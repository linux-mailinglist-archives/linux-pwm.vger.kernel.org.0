Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A84222F71E2
	for <lists+linux-pwm@lfdr.de>; Fri, 15 Jan 2021 06:03:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727257AbhAOFBu (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 15 Jan 2021 00:01:50 -0500
Received: from mail-bn8nam12on2056.outbound.protection.outlook.com ([40.107.237.56]:40544
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727079AbhAOFBu (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 15 Jan 2021 00:01:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RhJb2+U5fD1dpyoE2oQSt67/pLXZ6qNCM7U77Tbr/uIHucFmscHs3I2dK5qq6YqyzPELpxesU9NNvoO/cG5tJhnSkXdLPy58jtwteDmGNkS5w1Q+0eMVyip8upct+PTCnRtWJZWnmXDl2/c3QXmBVbCgD4YhERQc/UuJufKXcZ1Sgx14IAv0dQno2JMKJ9pqY6isPCSXmurx79tdGzxyIritoqV0VgE3dxfNASmbxYYI/AmPiuzNnrF4+PcP7s95Hsr/K1S9KKD7DUlXDzm/CSFNvb4vFdAUBYJGjwUsCF+AW7z325zasKgu+oQ1SPOTPIiXoZZbhaR8yP+SHMi/YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K2SYmzkKvR68EMXGiPkIMk+vcp2PdhMWBCoPy6tM4C8=;
 b=kKFbLkQyFhOwgmeFALPKW8toIw/8pACv7e+cC4YIeiSbPAIBSVli0cTcnTWJ6extM5JEmeSOMwtUfsQ+nELYgvtpAM4O4e83MdS64ZxbMZdJL8MiiAcvWDKmAxjUWiMcKfeRMo3X9eS5RjNxZ/yWxX/35vDfNXeDn+O1trAKdb+TJJTNRRrOXOVdqCyXrCiYVq0h2WL65NJpMzHcbMlxSoCAt+Q/a55yhSFqA5RPbaZr42erVeX7w3cQFkVMjYghQ7CSj+fHDaA2z98J3WdFcgHCD37Rth5yOALnSjgrwEJowHqmRrrTZBZrmukiwWcJTbf4RvzsBy5fDbMGoAznPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K2SYmzkKvR68EMXGiPkIMk+vcp2PdhMWBCoPy6tM4C8=;
 b=GHjx7UER8JoDBSsHydRyySP0eQ6jpANa5Ge4krIAXr4pHK/TYkYGkeMYO6rrTQ4GUcSXoWjhzi4cd0JJH3SJAGWL4BPl4RKNkKzYwUAIG211ty5rfqGVoFo9IX03C2hZzJFQ15DzbWmP7+wtfiV51jAAjj/KQfRlU92h9paY72I=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=labundy.com;
Received: from SN6PR08MB5517.namprd08.prod.outlook.com (2603:10b6:805:fb::32)
 by SA2PR08MB6475.namprd08.prod.outlook.com (2603:10b6:806:f9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.9; Fri, 15 Jan
 2021 05:00:56 +0000
Received: from SN6PR08MB5517.namprd08.prod.outlook.com
 ([fe80::972:c257:aa68:9be0]) by SN6PR08MB5517.namprd08.prod.outlook.com
 ([fe80::972:c257:aa68:9be0%4]) with mapi id 15.20.3763.010; Fri, 15 Jan 2021
 05:00:56 +0000
From:   Jeff LaBundy <jeff@labundy.com>
To:     thierry.reding@gmail.com
Cc:     u.kleine-koenig@pengutronix.de, lee.jones@linaro.org,
        linux-pwm@vger.kernel.org, Jeff LaBundy <jeff@labundy.com>
Subject: [PATCH] pwm: iqs620a: Correct a stale state variable
Date:   Thu, 14 Jan 2021 23:00:34 -0600
Message-Id: <1610686834-6149-1-git-send-email-jeff@labundy.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-Originating-IP: [136.49.173.128]
X-ClientProxiedBy: SN4PR0501CA0011.namprd05.prod.outlook.com
 (2603:10b6:803:40::24) To SN6PR08MB5517.namprd08.prod.outlook.com
 (2603:10b6:805:fb::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (136.49.173.128) by SN4PR0501CA0011.namprd05.prod.outlook.com (2603:10b6:803:40::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3784.4 via Frontend Transport; Fri, 15 Jan 2021 05:00:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f7b2c4fb-409d-4983-d4d2-08d8b9128a6d
X-MS-TrafficTypeDiagnostic: SA2PR08MB6475:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA2PR08MB647580F213AA70CDBFA76DF4D3A70@SA2PR08MB6475.namprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: stpKk1CmprS2xG5BGjtJEkLHRGLaZ9G2vzi6f7xFDq6oLaHZyejpYRxjqj5ER8JzzifysVanhTxNEasGefEyfjKNCUWKkoIb8HoppM0pEWrCL2g3/jfdase64YVbN4n4A/fD1kDiTCIjCEZFScNUrURSlxTDwl12bBNN+3D99wBEEJm/JNcKqM/PcwXz/au9KoNihahqatD8nUcruz1AjgXGQ2eiyg4Rp465bEfVOfRcGra2LdObZwHmyfa+xosUSvzXbye83sG6wqZDA/chRNT8i7AfToYDXVBJEiB2dAw4fJrFwlFLqklH68xlAX8mDncu2IPJHalBc9V80z0AM3rp0UfZbKXPjXqSG2CvHT3ipW2S4/ZQFreLpiB0J18cFvrLQbNqitD5WqlThPouTfYs0m3o6cKg0enX+tY4FjcvCcXfa4+GlqG/GhrsBpcc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR08MB5517.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(396003)(39830400003)(136003)(376002)(8936002)(66476007)(6512007)(107886003)(478600001)(316002)(83380400001)(6916009)(8676002)(4326008)(6486002)(86362001)(36756003)(52116002)(5660300002)(6666004)(66556008)(186003)(6506007)(69590400011)(956004)(2616005)(16526019)(26005)(2906002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?ykquWGzRgoy6Ahdb36xQPToOMtF8cD2DIXpTKqMcTcqkZ4yGMLhEAmk497no?=
 =?us-ascii?Q?N8B4JeLO7GXHsNHlWD6hRK3Jn56Y3FkJuBHmC4fmldbRsSzo/ppnaXXi9WoI?=
 =?us-ascii?Q?apiuycKWDZcT6UxZlUi/mUMeHyu4uSCbTf4o9KUDGw5qlsQvwQRXuzzC3JXy?=
 =?us-ascii?Q?i35lf1H7rg7GlO8SGWvnorJSPcYPPmZ3yu5+GF0jC27ijxho8ShKJUZ5YnQO?=
 =?us-ascii?Q?4mMtppeHJ0/LeHdJrgPIbaDSnH5p4kgxuPZlZCRdfwgwwLERU/vX37lT/8ug?=
 =?us-ascii?Q?4QU0SYmbDnE52Ieb8Qg18XJ/Zpm7YySrzjQtipv0NJLD2ccTP1uOnuAeODTj?=
 =?us-ascii?Q?3qFane/VWtdr8SS8xMahvqGMeyhjurhYVUfOLDu3Yv1e6cWjsygNnAgXmXFP?=
 =?us-ascii?Q?F9/Bq/Iz7eEKb/aIW7lzIfpIZHKzG/0mOVnhIO1okRKHhADtK4QvUr/o1p06?=
 =?us-ascii?Q?T41a9HTtoqC1PL+u3X4uE8SNP1fHGxaykj+wVHyD1mnFc9dypQ3yusBqlraH?=
 =?us-ascii?Q?7W0mpGd0eUGDRheVhABtARM27mztp+cwBlS/KB+rqc2AOtfjjQyFJXNR4bI/?=
 =?us-ascii?Q?IeX6paoU8Z2+BAKWGQ2xcgjNUtUswsBWPvy3LfLSTy+k4r3xGqUNqkPbmjPR?=
 =?us-ascii?Q?qn37zdTj7qOP0GxDDrvpDxLaSSm3asn/tSzwocW/lqwCkYjPk2Qtew6XpSqx?=
 =?us-ascii?Q?zF+5eLf24UiK+RsSmNnTdy8BLsOVYnd/NEPdJo42MpqrkEgDUBhpUzt0+uc1?=
 =?us-ascii?Q?dANXJICkcKPoDPf250HYKq/L4zmccSx3cVsMx9IJIGylJ9qJ+sFTiTDdDWn5?=
 =?us-ascii?Q?yCGtE0kKrujMBocuOvO466rVmtzxzEUeA8w4dGD+5EfwC3MXdZn/YW1H6AW3?=
 =?us-ascii?Q?8WUNPM+aPC4gmqwgvQZcu2V4dYdW1ILhzvfmdAO3VSOZ0OdXcOqUdNRayl7E?=
 =?us-ascii?Q?/NV0UW5zZtM5P7872EmhGlvBp8L+5D+nuSDPgV53qoLIJcahdPlPE6s8+qtW?=
 =?us-ascii?Q?m/Hb?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7b2c4fb-409d-4983-d4d2-08d8b9128a6d
X-MS-Exchange-CrossTenant-AuthSource: SN6PR08MB5517.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2021 05:00:55.9651
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3CV1Lj9dUVLRcMniANC6RjgzTXOD7Cai7mVCb4nr/xW3U83TNwqfJfLkMl66PK+TLTOYqf+H2nYnSp2unjFqLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR08MB6475
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

If duty cycle is first set to a value that is sufficiently high to
enable the output (e.g. 10000 ns) but then lowered to a value that
is quantized to zero (e.g. 1000 ns), the output is disabled as the
device cannot drive a constant zero (as expected).

However if the device is later re-initialized due to watchdog bite,
the output is re-enabled at the next-to-last duty cycle (10000 ns).
This is because the iqs620_pwm->out_en flag unconditionally tracks
state->enabled instead of what was actually written to the device.

To solve this problem, force the iqs620_pwm->out_en flag to follow
the IQS620_PWR_SETTINGS_PWM_OUT field instead, as was the original
design intent.

Fixes: 6f0841a8197b ("pwm: Add support for Azoteq IQS620A PWM generator")
Signed-off-by: Jeff LaBundy <jeff@labundy.com>
---
 drivers/pwm/pwm-iqs620a.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-iqs620a.c b/drivers/pwm/pwm-iqs620a.c
index 5ede825..5eb8fa4 100644
--- a/drivers/pwm/pwm-iqs620a.c
+++ b/drivers/pwm/pwm-iqs620a.c
@@ -79,6 +79,8 @@ static int iqs620_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 					 IQS620_PWR_SETTINGS_PWM_OUT, 0);
 		if (ret)
 			goto err_mutex;
+
+		iqs620_pwm->out_en = false;
 	}
 
 	if (duty_scale) {
@@ -97,9 +99,9 @@ static int iqs620_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 					 IQS620_PWR_SETTINGS_PWM_OUT, 0xff);
 		if (ret)
 			goto err_mutex;
-	}
 
-	iqs620_pwm->out_en = state->enabled;
+		iqs620_pwm->out_en = true;
+	}
 
 err_mutex:
 	mutex_unlock(&iqs620_pwm->lock);
-- 
2.7.4

