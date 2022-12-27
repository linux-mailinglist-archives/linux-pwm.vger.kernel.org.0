Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9822F656749
	for <lists+linux-pwm@lfdr.de>; Tue, 27 Dec 2022 06:02:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbiL0FCx (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 27 Dec 2022 00:02:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiL0FCw (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 27 Dec 2022 00:02:52 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2045.outbound.protection.outlook.com [40.107.94.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9D345FE2
        for <linux-pwm@vger.kernel.org>; Mon, 26 Dec 2022 21:02:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dN3NfN6CHbYBOpKT1z9EXnjKLaC/hyqizl78QZBR6KRHmTUn1SOaHqSvu1Z2Eln1zO7lxo5lReMeQJBfmL4GvNrYG+OgCa4rrSsmBMDfZ8an2Wx/SFR4TUc7FLmJWu/W9OLB8W9jnfqJ24WcEQZ+Lv8vZZ4o9cSB4dOR6yu1VO9oRBEBwxRmsryTA8QQN47r6ZVU1GqX2K0RMRKuIxnpu5oc49SI7jxZcON65u2MkogXy1QOiqUMUstMuXmjvbBpVMHLecIOaiH/zjwBcGrTx4bQBSA3YRGJ4GeCMiYM/tSahZPcgxTBvD1kcoEouwQDn2Uzvgj8qARn0yWClmcERg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=92ehzQ1E/14SItnPOcebITi/dM4soEbWUCEJIqGyHnE=;
 b=K1VKsN9uixxGeZjj4OkP52UCKADFqlncRmsmP90DNwbl3b1ZUUccdTJgfC7ljTFHuAqlQW4AyXoZ/sgOG79O8KiwGlpmIlIGAvav9tSBnu0P1KWH/nK07s4j0orvq+i8YMQ93obfZXQa/U6U95GlYJet5zZFRJDQWi9g0pFPMwwaHnWBzXEHqr2RR0dY9mUYsiHziPTOJpa7NjRHnsT3h2uvKKl6Rc5iXBO3QT86pTwP4fEag1gVL/t3Y5tOsAbT2bHYf20a30zE5v0tPQCcwlNOzB2/Tc1avgMZlvLGIYawI4thAFgeiXPg5zX2eoytOqKDlmLLftrrou+ZHzzlwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=92ehzQ1E/14SItnPOcebITi/dM4soEbWUCEJIqGyHnE=;
 b=ablJmRerbbWcWOPWWKArx2gFU4WQe9Y6Q4iuO5era1FBMFhfFjXtdUQSWH1FwZ5l8NnP5FMJiE4mGt856eMbHcr0KxsWIDP3FsYtEeffS6mx1AD9B4UVzmU0lEbI5Y7uEDmgbuDcBSyWGNvS3xztarBOkz9VzzvQTzhryMQKuHw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=labundy.com;
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21) by CO1PR08MB7063.namprd08.prod.outlook.com
 (2603:10b6:303:da::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.16; Tue, 27 Dec
 2022 05:02:47 +0000
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::ea42:ebaf:dd18:6a4c]) by SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::ea42:ebaf:dd18:6a4c%6]) with mapi id 15.20.5944.016; Tue, 27 Dec 2022
 05:02:46 +0000
Date:   Mon, 26 Dec 2022 23:02:41 -0600
From:   Jeff LaBundy <jeff@labundy.com>
To:     thierry.reding@gmail.com
Cc:     u.kleine-koenig@pengutronix.de, linux-pwm@vger.kernel.org,
        jeff@labundy.com
Subject: [PATCH] pwm: iqs620a: Replace one remaining instance of
 regmap_update_bits()
Message-ID: <Y6p8cSYK+QKaKe7B@nixie71>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: SA9P221CA0024.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:806:25::29) To SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN4PR0801MB3774:EE_|CO1PR08MB7063:EE_
X-MS-Office365-Filtering-Correlation-Id: 70a481eb-f91d-4a92-77b8-08dae7c79821
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jfo8VHSFXGfosqgHw31ic+XSfMMiOSYUZOD/t1JnM4DNL6A64MI4YazQPu9kqtvdwlheGcMpr13DxeLMr/r1ljD5sP54s2ZVr81Kjb010zqcmdWHSPNicrWVblHW++fp6qzwPIltklEG5Gd4TVtXQnlAndu6F33B+OEn1Fl/Q6VHeyhZ1T7iSzJjbbp7++omyzc79bY5Jj0qYixoafAJDr3JrBVuh2SkgGcik1stCthgeE14jx949vGgXJCCJ/INNPF4A1V+mqaQZGQ+p/NrUdYVU3dbXbzPnahzGtldnG22qcAAUnChuQpM3id3XufhCN65VasLWRBbck0zhqXm8q5g97zI6Tu7mlqdrNicUzlP24wqawnAAky5q2QXnncRX7bSe3ptcHAKwoaZEA2u+wn5c0i7e2YrAricFHMpT7kQ1w6AQ8FafiPbmsSQ8BD/Tp6qUcuFagmexXR5qkB3UvnRMdiFqT/zU8fcXnSKCvJv9iP0EDuWoD4eRi30E9rM/cRb2A8SdQwstqpUF/pCXfVCatMCCNWj61PH/TU8TDnoLfiszWrOBJ9oxVwr05mgAI2NMQB47tCz8T9778c6wcR9F2NSQ5JSRQ+/aP4PefwYrZEIYNeAyrXQ5yt2zArAcZaixFsI7rVMEorsOJCOc/qZown7eZKzQnjw8RSsyZNONVvbzjxnXbmdWmd3kYB8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0801MB3774.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(39830400003)(346002)(366004)(136003)(396003)(376002)(451199015)(83380400001)(86362001)(38100700002)(8936002)(2906002)(41300700001)(5660300002)(33716001)(6666004)(478600001)(6506007)(186003)(26005)(6486002)(9686003)(107886003)(4326008)(6512007)(8676002)(316002)(6916009)(66946007)(66556008)(66476007)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+5DEQMltdVcsKALuy12ky4usTvEw6KzJhZzrAPKpjglKkelDiwrAimv5imnM?=
 =?us-ascii?Q?vDn7mUN21bndicGBhvABmLGoC9fYlt5fJT4Go455gu69E1bk2U9aCw98uJM6?=
 =?us-ascii?Q?CGrJF8x3v7t/DQvmFLbE/jx6pJNY0G1g5QjCMoGkE7ry8SUMqJY16nkwZn4T?=
 =?us-ascii?Q?oqg95cCA5DplnGXxQdF3zk7Q/uYZEV1FiIpN3Z46O9eJ5FxhmiSk5V+DR5rp?=
 =?us-ascii?Q?G4Vte/Ribkz1QEwtOHGDh4a8qUXa5I6j3DgGKk6Wgp2WNHUga5WrvqKrZa6P?=
 =?us-ascii?Q?6CLavj+32wJckHcmWpyCF2CTzVcjqK+K0PEWM3NvQJ/LxwJ+12HRb6XaZIrl?=
 =?us-ascii?Q?V7ddXXGkqToDbNwD5A7ys/D2zMo1Fyc8EKqGtOLv6JQJp4SipJAXWpXiy9ur?=
 =?us-ascii?Q?k1EFzKOfcYU4GxzSRYmkSebNrDgYpNf1idSjaS+2Xfk96Bb/bLawCTij0REE?=
 =?us-ascii?Q?PZdyyEq5FHzQEzAoigjLqFl/RUUdKAQso34sXu7ydJuJkAtFoGep8o+QvFOs?=
 =?us-ascii?Q?vJqNe53N27zDASRmv9AXkXbf+kQCBQrHUmR7v2sRLsU0DfJ94ljX1kInguQP?=
 =?us-ascii?Q?pbi0lqBohlgi8HBN4WXSl1bFumF1DL5IKXvnZGXqXXMjajLmlSO5vuxtUYrX?=
 =?us-ascii?Q?ma28brvjhLyoWoSRVmgURCb6ffF3XlTMbKBY9RX+gmY4Bv3JWKBcdnEtLFcw?=
 =?us-ascii?Q?Q2bMk/1yh8Fd8edzhYYMnUmfEtcFgJ7YV9eRyCvsodG4i84nId7FN/d9afjd?=
 =?us-ascii?Q?I9zirDef9Pi5CbsZbpw3g3/t3QTOu+1qhvSqM1mZMrRwJ3C7wmQVawwiYDkJ?=
 =?us-ascii?Q?g2RRMxXwaxAeczvFcgaRHgFn0U4uB7OY7YWENJbw83PU7xdxmA73Z6Hr84zP?=
 =?us-ascii?Q?zBCrctzV0dj4l1CLgMoa/LNIU5LRJkZr69diwypshFLz7d3Y0Gg5QuNAnNVH?=
 =?us-ascii?Q?8joSldPsZrFwhk7MvMab/pJbNRsrQR6T6/uL+NEB8DZ1Flgfdbrel94qhaL2?=
 =?us-ascii?Q?pTaLQUnOjWJHHhWRHVZroSdhKV9Gi3Q0i13RV1gGZPX6F+uhSN+eCDuQVCq8?=
 =?us-ascii?Q?IEOg8iQeWIMQXux8fpSqObylQzA4nJpg7RH0Ulm1I/Rhu6WUt1OQ+YwhzRMe?=
 =?us-ascii?Q?v21dstdG9WeFbRs9aBK2I8YZvb5Vzfq9vnWf/4KeIiJdCEBdqbVJazJ7T6Lf?=
 =?us-ascii?Q?SgQbYQ5CQG3wlbECSeEXNaY1ZJsYFoEnckDNzDuRcS78+hVBSVFhbky3nf3U?=
 =?us-ascii?Q?Ji8155lh+d/QjvtypRwNiqzAfo+MORULiSgm24lv+3eeXHpm2Ka15vcSJg5f?=
 =?us-ascii?Q?GP0mdfAcuT7cIqK6f6lCfDWdpt/LPjnpNkdMewxrgvrnjDYiZGUky/oNvpte?=
 =?us-ascii?Q?IKIabfgDdkmR9Qx2+gZYP9XV9qsR7wBtLpBMQQueut314t9OQQAlbhIx1RJz?=
 =?us-ascii?Q?YFvAFnWOkNhwf8tYuyE/YV5tK/rPF/SJllUbfpFL59zBHfKfVK8FWrWpT6Bd?=
 =?us-ascii?Q?BVPcICYkdy2kI2kJWju0YcAuqs6Y4rpqgmm6wHr4P7UWKPJ7VTrXF69wQ55e?=
 =?us-ascii?Q?hFDYVDVcFsNgo8t+hTWsW/e+QVubeEOE8nItxVUd?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70a481eb-f91d-4a92-77b8-08dae7c79821
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0801MB3774.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Dec 2022 05:02:46.6465
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J94QXAVHmBiUw66v9Ov5z1LivFLGNVskNqSPhcqVhybFqux31VpkSZc2g+yD2ZNjsaw8bWV8XMvbncniqyCEgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR08MB7063
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

Fixes: 2c85895bf3d2 ("pwm: iqs620a: Use regmap_clear_bits and regmap_set_bits where applicable")
Signed-off-by: Jeff LaBundy <jeff@labundy.com>
---
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

