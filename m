Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04425656B83
	for <lists+linux-pwm@lfdr.de>; Tue, 27 Dec 2022 15:05:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiL0OFN (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 27 Dec 2022 09:05:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbiL0OFM (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 27 Dec 2022 09:05:12 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2073.outbound.protection.outlook.com [40.107.243.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F1415F7F
        for <linux-pwm@vger.kernel.org>; Tue, 27 Dec 2022 06:05:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KAXzzQGPaoY6mTmlfCXhKioHS+laPBdJQuXZR7y/wxYYJtYx5Wwwcu2JGt3fi1OQ7JTGEVEDmAeRK9zTVrB5rT3UU3jxNmBquyX6OdkgBjwEN9K75eTRCEKYpBt3zQopHNoSig48a22rqiTmdxRADKdcmSM/yPJzs+v//mW9UZsBpAoON5WsY7cHy2sx4vzriGC/K8xwJAM05TBL5cKzF6ULpPVWYbaUHCaRQ1y9KoeoIxUWG3ZVcb3QpbiiXO+3Hlctb1oKZgFXH7BaNUgtCuvrhBYYiQjI67Auydme6oEin899gB8gAz6mA1p7pPLwIgF0sC4KXpdD7Fzr62rZcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YHSGii6MWhiUAI31FuFbR9G6fiiDObp/NaFwxFYKCa8=;
 b=PaoLFPGZquEBdSkez0qhYEtaGGxk5+gRvqfd9wyCpC642oDx5ZnJ63pzdRQilXi/83kdFD9XQv+NRV3W3JEn0g+3TgpCULVTIGPCkHeVO5YkN8T27SdRz7Ux8eMLP0TviXkut9TfPOTTuKOrtUn7yFG9VIQeHxFoK18NtdI4nYzumYz9rBF8qN8hEiYmN6layLNVApbk/q09QG+TYNVh7Us8RYeUL3BAP8sQG0GFCnPKg+PUhJ/aUBY9s5PnpMSQBH6wXDLC9Pe7MrLtdOLygCwfkVnGXW1muaJ8ok5ED16I67DriRA94qNwbh03IoWAXskAjebPdeIr5P/1LREWYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YHSGii6MWhiUAI31FuFbR9G6fiiDObp/NaFwxFYKCa8=;
 b=XdYyzSDhopxfyOyxAmyZswoHXzdGi1weOgPCmxlIgH1FzAmwo1Vfqp5+UUPTcY6m8ppkxtzU39kR9xLPwx4o7D150tSQEwcCm2JnQia4DZ5Kn+I7VvQkzrL5BCCbThnSJCJgqnYPhJRYFWpsJOQ7rclL/OkWo2zqS0scjW9aaXA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=labundy.com;
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21) by DM5PR08MB3354.namprd08.prod.outlook.com
 (2603:10b6:4:67::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.16; Tue, 27 Dec
 2022 14:05:03 +0000
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::ea42:ebaf:dd18:6a4c]) by SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::ea42:ebaf:dd18:6a4c%6]) with mapi id 15.20.5944.016; Tue, 27 Dec 2022
 14:05:02 +0000
Date:   Tue, 27 Dec 2022 08:05:01 -0600
From:   Jeff LaBundy <jeff@labundy.com>
To:     thierry.reding@gmail.com
Cc:     u.kleine-koenig@pengutronix.de, linux-pwm@vger.kernel.org,
        jeff@labundy.com
Subject: [PATCH v2] pwm: iqs620a: Replace one remaining instance of
 regmap_update_bits()
Message-ID: <Y6r7jSs3dFw0KZOP@nixie71>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: DM6PR08CA0017.namprd08.prod.outlook.com
 (2603:10b6:5:80::30) To SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN4PR0801MB3774:EE_|DM5PR08MB3354:EE_
X-MS-Office365-Filtering-Correlation-Id: a2c60da6-938c-46b6-f5da-08dae8135960
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /v4676XCkr808IdJUh51hhafKKK+XdXqAfTOMWVCqCcpjwXBPLvOdVmH+CSh3qGhqghdj2s4L5GQKVVmkMQkJjtCoqK9EATZY+m4hVPVNL9PE6kR2ZxGsALnmh8DEPTw2Q+ytgMk4h4W1EHB7u8B4Xn0QOTB+yAgAGS8WdnLdq+GPmR6QvkqNYLqpkkNLxp5wVKB+9VcYdQIRtYNaRqnw+PRG6cIqjrVAC6Q6Y7H5zRZpkeOiGyRSmLrmvNBQdPN4UsEHHi/HLUwFjC3UDp+AGlMtO5oJeSg4KvcEv8NVAns9H5ax2JPzEyvPMOOunIo/Pyi3AX9dsK5XqWlijn1PNLxKTJGq63FQeoqzWMA/7PvgDiPZJPA1/vKHCWxa3cg/Sk4dPTgxG0NXSd7apaptym7ls0UsVqTlNh1hVsRuRj9KglObPs6brFoRP/642WkFujGNXFLGN8c0uuPqbMCZsAAC+jBUusFZhsky2pNU7kgdqmPXdKbu5ie9CDLdVgS50J0qiJHEp/qJY9CfufGCXFqJGmlPp6ENmYPpqDi6839tF4E1TCWSZExESbnTZzg54AuU2ZFIelQn4i/W/Lt9QB/SWUYaalq66aPBdzG4tyz8l3Wp5Cx8TgUe/lwCq7EoPRjoKKEBjIfydH5+gWlLg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0801MB3774.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(346002)(376002)(366004)(136003)(39830400003)(396003)(451199015)(38100700002)(41300700001)(8676002)(33716001)(4326008)(8936002)(83380400001)(5660300002)(66476007)(66556008)(66946007)(6512007)(186003)(26005)(478600001)(6486002)(6506007)(9686003)(6916009)(2906002)(316002)(107886003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YPEcQQjyl/LuPxGWsKBjjcIbKo8I0AyjxFLpu+V9G+sTx441C+P1VJoWPSOq?=
 =?us-ascii?Q?jui/4yWeSexptaFSwBx1AO5NrLOLDClKiZtXUV+dYe27xtz4/I2lKEBuuFP6?=
 =?us-ascii?Q?LQT/LLOJfsogaAPvFmU9VuVKeKvKKObO5cNwcmrpH2s/vFASUcGiVIok9tnE?=
 =?us-ascii?Q?V8HPJDFi+DSpU2d2RQKREmcOIy/c6BBrpIiy2+AQ03Jz8MVLIIqmvDrfEKqb?=
 =?us-ascii?Q?na5cMqLi95TpZrgmye+NqJynXmf7neqf6d3KBj9Sde9Hi+GGD8c+0JfqQYaE?=
 =?us-ascii?Q?P+b0qKOyU6KbTYVRSa2v+bzcCDCwXELqztJq7M4+bfUrtlSKZP+k/8+oHmp9?=
 =?us-ascii?Q?yTvSXq1YEsj2vDmv3iaYaziox8PoRef33fQUtIqmhZ7hkm1CqLkQGtoQdZqd?=
 =?us-ascii?Q?jFhOJSEl2FPDaOUN5cIOTEg+FsRx6u+ofOMVkOFOVbNiUmYluXf7n0fvSZPl?=
 =?us-ascii?Q?VaHom8THplN7/IFIUz5ewMfVeL/IKYm5hPBiEQoYtbiOc/A96omngtIDgY9O?=
 =?us-ascii?Q?zq+EEkTyqQKEPsCXh31XucnR0HRdINB8Et8U3wyRVum3ppf8exnFTWWx7dxv?=
 =?us-ascii?Q?A5L/PQTgI6l9nJcT+hB8VNnHa7qKp9d4tAQA3IdSrUVlMOLf1TeX2IghMJfZ?=
 =?us-ascii?Q?1cqWBsG4hWD4X/fPhiuPt7B1KjcpRjQGX/iCToDGO21HHBCymO4yFr8kH9ue?=
 =?us-ascii?Q?c3m2kCgZwHZDRmfqtD+Rml3+ss/WGFww/P/RZEna+apGoAYe/rFaRJfmH9nB?=
 =?us-ascii?Q?4+FuUXGtPPSEYYP7M/trH9j84Q1u9XkpgTCODk8AoSTlO8Qj66nuU6pShTRS?=
 =?us-ascii?Q?CSl6dObI3fBJveFQtl4zdT4cWuIzBe/TdyyHATtYDQvKLFb4VnLDikFN6Rj6?=
 =?us-ascii?Q?WRVT27AiIgeD8jcGhxVu2GaTyjC4TwAMhkrr8vLAOozx5wU0Dy4SHVxuEzX6?=
 =?us-ascii?Q?bkwGDZ/WiAuxNAoCpHZD8OsSFz6GU8DtuSfxWQB9DkKFcVtx+8bSEst7hN4U?=
 =?us-ascii?Q?rwNLrhCI3qAEXyNKx+Glzc7UVuA0nYb3pjXa7FgpaLqvjglm49Ne+77qfo3h?=
 =?us-ascii?Q?Vcb88BPUE+4LOnLNvs+4sckv0siQUmmdBDTTUYHM+wCBgJmKn/C2dGjoT4jf?=
 =?us-ascii?Q?9YdeGcCgLRs0HtUxO5WFQdO4vrKCOw8i422eSWW1M2XU6TnVJfpiHp/kiJvi?=
 =?us-ascii?Q?VX63rJYfG4jseir35/XJMft6hnuhN3qK9CnK1QG0NeZ5zysYBozYSzJmnZBK?=
 =?us-ascii?Q?X71Q7uLoXuMduWBzOjbkNaPsu97h90E8Do/48auRMxjuUI4mKuyiAVNLUmDu?=
 =?us-ascii?Q?bCKc1PrjpJD92HWGp/kxo0ocugLReQd8Gwobu+73LYtNRLU5Is7srNPh2eeu?=
 =?us-ascii?Q?hgei/dILUsH8YCNbkPTT1kEj8MAla+FCjf0bEXN3rYeYgF86wbWcKgKGteda?=
 =?us-ascii?Q?gVCZO0eTDxGzDFcVnlyWihyhdaCaBSwXidwMzRQaZNTNkNrKkd55Ex1mhuXD?=
 =?us-ascii?Q?jPzHKCmrhWkB/5URHkgW8FRQWVle9dO4y3fVK765O/M4gTp0HrGqNpngWC4/?=
 =?us-ascii?Q?z3Ac+UHTKfql8+Q+qvy/aDE2Jqq3BJ5GBRYGVjSf?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2c60da6-938c-46b6-f5da-08dae8135960
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0801MB3774.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Dec 2022 14:05:02.8833
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AYLE489uJi4GRTafEzQWVUUuteB27if3rvkuxUtg+/aFcQs5OG6OFihDL36pbOKFicUiG5E7oRndrSLrJb6/Fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR08MB3354
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The call to regmap_update_bits() which was responsible for clearing
the PWM output enable register bit was recently dropped in favor of
a call to regmap_clear_bits(), thereby simplifying the code.

Similarly, the call to regmap_update_bits() which sets the same bit
can be simplified with a call to regmap_set_bits().

Signed-off-by: Jeff LaBundy <jeff@labundy.com>
---
Changes in v2:
 - Dropped Fixes tag

 drivers/pwm/pwm-iqs620a.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-iqs620a.c b/drivers/pwm/pwm-iqs620a.c
index 4987ca940b64..8362b4870c66 100644
--- a/drivers/pwm/pwm-iqs620a.c
+++ b/drivers/pwm/pwm-iqs620a.c
@@ -55,8 +55,8 @@ static int iqs620_pwm_init(struct iqs620_pwm_private *iqs620_pwm,
 	if (ret)
 		return ret;
 
-	return regmap_update_bits(iqs62x->regmap, IQS620_PWR_SETTINGS,
-				  IQS620_PWR_SETTINGS_PWM_OUT, 0xff);
+	return regmap_set_bits(iqs62x->regmap, IQS620_PWR_SETTINGS,
+			       IQS620_PWR_SETTINGS_PWM_OUT);
 }
 
 static int iqs620_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
-- 
2.34.1

