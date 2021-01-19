Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F2D52FAFA1
	for <lists+linux-pwm@lfdr.de>; Tue, 19 Jan 2021 05:55:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730501AbhASEhc (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 18 Jan 2021 23:37:32 -0500
Received: from mail-bn8nam08on2049.outbound.protection.outlook.com ([40.107.100.49]:63936
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730712AbhASEbo (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 18 Jan 2021 23:31:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sqxx4FUY/VLY5D8U/r3B2+WubtC90t8mTXqkOSErF4TpelUdgdWBiHjaG66Uw6GTjb9ioAG1BE2/rSXE/Z/oCh08IHzWrmcuUfBPkRnlgHeItYcvQs2KS1gT0xeGt4VPrv2piUVDU1XeAAo012geUk0f8xnCGRGl/8xVRSFgf7ndwd0CwZKQLQYKyzYSEJHAg62q1Fww5AF9kbMzdQp23GnL5ReDSH2N36RKNyzckhBAXbeyptTfFdTb8sjCkVEx2W6QN/29kEMHZPLmdO2mfOxPiPjoxIN9dwLz6mi26EYLyFOP/PITxZK3FKKsGaMX1UobyRdc48I4BdSMwEjYzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MAC6M8tcblU3W4X55Z2CvAOOkSS2jfBNs1qlMJzWBa4=;
 b=KqUb4MRBysjObultcnssOw2Tm6VMlDRcdEoYqb7lfeiPI1qobpGQAMsmuyxEvsPGob/U7SqI/uYo99wu90BKCht5mC2KjOJeyO3nfvgk1u/7e0limWLid42A5573ytYpjkFwUm02eozkaUw3j0bKbTxqZJD94v6rZfIYFDbZLCt1+RMvUR0cT+hTzbJZL5rRxt0DRYDHMarW59HNNAhXlT4In9cpY6RStJ55ky49ExQK707HYGZDQzg2eNnnuUjYlQr6EUjTZfSmnrkicmbFmWwJYE7ZiZ2V3uO+BrK92Y0v4qK8813gDF+jYomyvomA8q/NbeAEOW+5pPUUt/F8UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MAC6M8tcblU3W4X55Z2CvAOOkSS2jfBNs1qlMJzWBa4=;
 b=F6LypMOIgNeIuBuYZc4SiGL/FEHjoJek38HDqkZxeAc882vTAkyMBqjUMv8FyzpSXQ1rBOwF6lSi3sg2sHptOtoeQ2dhRPQSMbKOyBGEZoLyCxnt3aoMq1q4yuygYxNNf+gbOruhCg5evm1gzeZutsUMhZ4rFIovMBvE/GM36ow=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=labundy.com;
Received: from SN6PR08MB5517.namprd08.prod.outlook.com (2603:10b6:805:fb::32)
 by SN4PR0801MB3822.namprd08.prod.outlook.com (2603:10b6:803:51::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.9; Tue, 19 Jan
 2021 04:30:49 +0000
Received: from SN6PR08MB5517.namprd08.prod.outlook.com
 ([fe80::972:c257:aa68:9be0]) by SN6PR08MB5517.namprd08.prod.outlook.com
 ([fe80::972:c257:aa68:9be0%4]) with mapi id 15.20.3763.014; Tue, 19 Jan 2021
 04:30:49 +0000
From:   Jeff LaBundy <jeff@labundy.com>
To:     thierry.reding@gmail.com
Cc:     u.kleine-koenig@pengutronix.de, lee.jones@linaro.org,
        linux-pwm@vger.kernel.org, Jeff LaBundy <jeff@labundy.com>
Subject: [PATCH v2] pwm: iqs620a: Correct a stale state variable
Date:   Mon, 18 Jan 2021 22:30:29 -0600
Message-Id: <1611030629-21746-1-git-send-email-jeff@labundy.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-Originating-IP: [136.49.173.128]
X-ClientProxiedBy: SN6PR05CA0022.namprd05.prod.outlook.com
 (2603:10b6:805:de::35) To SN6PR08MB5517.namprd08.prod.outlook.com
 (2603:10b6:805:fb::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (136.49.173.128) by SN6PR05CA0022.namprd05.prod.outlook.com (2603:10b6:805:de::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3784.5 via Frontend Transport; Tue, 19 Jan 2021 04:30:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6da45f60-73bd-4d49-8265-08d8bc32ff2d
X-MS-TrafficTypeDiagnostic: SN4PR0801MB3822:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN4PR0801MB3822EE1D921F8F42E0781A54D3A30@SN4PR0801MB3822.namprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jWDnTT5g4IfjfHcAxawBRZ81F3uUG8C5/RPr7vN5lOp32a3RTKS+AR94+QZafT3xKQIbkH1VH9IEFGlQsbuN+Yo1dpUxXZpG0tRz0PFdMDEGQ/+0aZF/ZQ6y7yKCXxGL4el0iJOLyP+5t+V1LWVi2qLLxRArFMHRK6d1UHbTkHHzHgoGrkUFXWLg3lcsstOsDsopuToYsM7gj0/Jnu/Qmi0AhljaYHt6z/2w4qxAXb4SIA55KlAwKwngn6pRvwpvkZI4ADnv8Yvl6Q1zrFhMx0SnpkJXxF220T1Q/OKcs/XvSghnLYnop689IY9ReSy3S2S43NrhRzi6pFIksT+0JlT1pWDkYXs6LMGQai4zRuPJSf/mSE2i8wPLaLY78nKxS3560xr/uyQf1h5Ap34/geYY73++BYKryIyuV/NVCpPvE00EJ0Nwcrwp0VKuJjBiYnpmnAKkE1KsEo5sqIpGv6zROfygmGbnnb+O767VMchgJdz7yjOogT1KIcBwhmfhUl3qujNZi2DmmlfpeBJDNw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR08MB5517.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(396003)(366004)(39830400003)(376002)(66556008)(66476007)(66946007)(107886003)(966005)(69590400011)(956004)(4326008)(6506007)(6916009)(6512007)(36756003)(2616005)(86362001)(52116002)(5660300002)(26005)(8676002)(316002)(186003)(478600001)(16526019)(6486002)(83380400001)(8936002)(6666004)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?zM7nkUWZf9Mt1jLIEXeiXsyXFPa6NdvPDM2B46VR6uG9y8kO8FZOIpsnbfXR?=
 =?us-ascii?Q?CITaaV8Ym1FUo4n082tfnx0+sAJuVZvjK9egXUiZgBmmrC4E6xdlC9ssxLIt?=
 =?us-ascii?Q?q4kvWD3Qo4ZvY+nrSkVuclysb5Rn/nKz5/I4GhvFoTDX/iHA2vRlnHQVwDzZ?=
 =?us-ascii?Q?OroGmAXNl9aM7yjp8g/BntDuQbWC9AKAKuWtm/MMTIZ3wCkklpOCuzxGbm+0?=
 =?us-ascii?Q?vOzVjsiM6We7q4aKUe39ZEqTK34ArVYiE+tgPT3cg6sJoexahySsDjaOYzyx?=
 =?us-ascii?Q?9wP+KdVNB7tGI+dA9oOedj7ayFu+mFHoz3SxNAumXlmgTjoplF9OOCLBQOtn?=
 =?us-ascii?Q?HVNEpcCzClPpj7DhDC+2djAd26gu6Xu9fCZFf3HCuBkWlFOuf5eGzkTjxOyb?=
 =?us-ascii?Q?cBANRylW/6a1t1N0YvXtbylsrnco9UlZYt0DFt6bldAlL7tk2oLsK5PO4nlX?=
 =?us-ascii?Q?DKW9nOYYJ/7eYQmo8njhseRxxJmNe2V12ImmaF4JjS8Q360Dka2m7nsbIh1m?=
 =?us-ascii?Q?UKa4o7YUOZfroXui96NkcVgvxuunpGO3jxfcWvQ76gh0FCCmE/tKbb4URBMY?=
 =?us-ascii?Q?Uro7GRs18zMOLEGFtY7e2+Itw0x7XGgV782/SU3DWAVlYZhCVEVcNOvA2QNs?=
 =?us-ascii?Q?9gX/wlureHcdCm4nUvo7X08V+1niLBvDolBavYdTbC05vBEnyWEBY1Aln7Gm?=
 =?us-ascii?Q?u7/rhn+k/5mVE6u7nW/sJy+QZghLllvw3Eo8EsBsTBbIFw6D/sFPyrSYMsD/?=
 =?us-ascii?Q?RnXii6cYuljeDWHS9N4huiLXaj6UvU0CWz5RsLK2v7ySkd+ZHF07OhD8K8f4?=
 =?us-ascii?Q?9XHYMUnsKHPpxW8iF1m2lQQHmUhVJEv2TDj7bHU/KfbDmVQNGETF5rqXFZdg?=
 =?us-ascii?Q?B9SXvvPx6H09PjvX5WvS8FVKoTbwGAueYBeQG0DAsRYnk2SrZm8OWuQ0VlJI?=
 =?us-ascii?Q?Cj7Zcj9peFeRjKgBppzbLnjB3c9EAsP2zH6cTM2HCiBva/RDM5h4aP9jnPLK?=
 =?us-ascii?Q?3v0e?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6da45f60-73bd-4d49-8265-08d8bc32ff2d
X-MS-Exchange-CrossTenant-AuthSource: SN6PR08MB5517.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2021 04:30:49.1708
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tMWo7PXWN2WVWtq7Ld6gQgr4xjaVsN440TExE3dn87R10NGQNithOgEuD0PWJPna5kX4ORZv+tUJJFaHvZjneQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0801MB3822
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

To solve this problem, use one state variable that encodes all 257
states of the output (duty_scale) with 0 representing tri-state, 1
representing the minimum available duty cycle and 256 representing
100% duty cycle.

Signed-off-by: Jeff LaBundy <jeff@labundy.com>
---
NOTE: This patch is intended to be applied after the following patch:

http://patchwork.ozlabs.org/patch/1426818/

Changes in v2:
  - Collapsed out_en and duty_val into a single state variable (duty_scale)
    that is decoded from the newly added iqs620_pwm_init() function

 drivers/pwm/pwm-iqs620a.c | 88 ++++++++++++++++++++---------------------------
 1 file changed, 37 insertions(+), 51 deletions(-)

diff --git a/drivers/pwm/pwm-iqs620a.c b/drivers/pwm/pwm-iqs620a.c
index 14b18fb..957b972 100644
--- a/drivers/pwm/pwm-iqs620a.c
+++ b/drivers/pwm/pwm-iqs620a.c
@@ -37,15 +37,32 @@ struct iqs620_pwm_private {
 	struct pwm_chip chip;
 	struct notifier_block notifier;
 	struct mutex lock;
-	bool out_en;
-	u8 duty_val;
+	unsigned int duty_scale;
 };

+static int iqs620_pwm_init(struct iqs620_pwm_private *iqs620_pwm,
+			   unsigned int duty_scale)
+{
+	struct iqs62x_core *iqs62x = iqs620_pwm->iqs62x;
+	int ret;
+
+	if (!duty_scale)
+		return regmap_update_bits(iqs62x->regmap, IQS620_PWR_SETTINGS,
+					  IQS620_PWR_SETTINGS_PWM_OUT, 0);
+
+	ret = regmap_write(iqs62x->regmap, IQS620_PWM_DUTY_CYCLE,
+			   duty_scale - 1);
+	if (ret)
+		return ret;
+
+	return regmap_update_bits(iqs62x->regmap, IQS620_PWR_SETTINGS,
+				  IQS620_PWR_SETTINGS_PWM_OUT, 0xff);
+}
+
 static int iqs620_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 			    const struct pwm_state *state)
 {
 	struct iqs620_pwm_private *iqs620_pwm;
-	struct iqs62x_core *iqs62x;
 	unsigned int duty_cycle;
 	unsigned int duty_scale;
 	int ret;
@@ -57,7 +74,6 @@ static int iqs620_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 		return -EINVAL;

 	iqs620_pwm = container_of(chip, struct iqs620_pwm_private, chip);
-	iqs62x = iqs620_pwm->iqs62x;

 	/*
 	 * The duty cycle generated by the device is calculated as follows:
@@ -74,36 +90,15 @@ static int iqs620_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	duty_cycle = min_t(u64, state->duty_cycle, IQS620_PWM_PERIOD_NS);
 	duty_scale = duty_cycle * 256 / IQS620_PWM_PERIOD_NS;

-	mutex_lock(&iqs620_pwm->lock);
-
-	if (!state->enabled || !duty_scale) {
-		ret = regmap_update_bits(iqs62x->regmap, IQS620_PWR_SETTINGS,
-					 IQS620_PWR_SETTINGS_PWM_OUT, 0);
-		if (ret)
-			goto err_mutex;
-	}
-
-	if (duty_scale) {
-		u8 duty_val = duty_scale - 1;
+	if (!state->enabled)
+		duty_scale = 0;

-		ret = regmap_write(iqs62x->regmap, IQS620_PWM_DUTY_CYCLE,
-				   duty_val);
-		if (ret)
-			goto err_mutex;
-
-		iqs620_pwm->duty_val = duty_val;
-	}
-
-	if (state->enabled && duty_scale) {
-		ret = regmap_update_bits(iqs62x->regmap, IQS620_PWR_SETTINGS,
-					 IQS620_PWR_SETTINGS_PWM_OUT, 0xff);
-		if (ret)
-			goto err_mutex;
-	}
+	mutex_lock(&iqs620_pwm->lock);

-	iqs620_pwm->out_en = state->enabled;
+	ret = iqs620_pwm_init(iqs620_pwm, duty_scale);
+	if (!ret)
+		iqs620_pwm->duty_scale = duty_scale;

-err_mutex:
 	mutex_unlock(&iqs620_pwm->lock);

 	return ret;
@@ -121,12 +116,11 @@ static void iqs620_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 	/*
 	 * Since the device cannot generate a 0% duty cycle, requests to do so
 	 * cause subsequent calls to iqs620_pwm_get_state to report the output
-	 * as disabled with duty cycle equal to that which was in use prior to
-	 * the request. This is not ideal, but is the best compromise based on
+	 * as disabled. This is not ideal, but is the best compromise based on
 	 * the capabilities of the device.
 	 */
-	state->enabled = iqs620_pwm->out_en;
-	state->duty_cycle = DIV_ROUND_UP((iqs620_pwm->duty_val + 1) *
+	state->enabled = iqs620_pwm->duty_scale > 0;
+	state->duty_cycle = DIV_ROUND_UP(iqs620_pwm->duty_scale *
 					 IQS620_PWM_PERIOD_NS, 256);

 	mutex_unlock(&iqs620_pwm->lock);
@@ -138,7 +132,6 @@ static int iqs620_pwm_notifier(struct notifier_block *notifier,
 			       unsigned long event_flags, void *context)
 {
 	struct iqs620_pwm_private *iqs620_pwm;
-	struct iqs62x_core *iqs62x;
 	int ret;

 	if (!(event_flags & BIT(IQS62X_EVENT_SYS_RESET)))
@@ -146,7 +139,6 @@ static int iqs620_pwm_notifier(struct notifier_block *notifier,

 	iqs620_pwm = container_of(notifier, struct iqs620_pwm_private,
 				  notifier);
-	iqs62x = iqs620_pwm->iqs62x;

 	mutex_lock(&iqs620_pwm->lock);

@@ -155,16 +147,8 @@ static int iqs620_pwm_notifier(struct notifier_block *notifier,
 	 * of a device reset, so nothing else is printed here unless there is
 	 * an additional failure.
 	 */
-	ret = regmap_write(iqs62x->regmap, IQS620_PWM_DUTY_CYCLE,
-			   iqs620_pwm->duty_val);
-	if (ret)
-		goto err_mutex;
+	ret = iqs620_pwm_init(iqs620_pwm, iqs620_pwm->duty_scale);

-	ret = regmap_update_bits(iqs62x->regmap, IQS620_PWR_SETTINGS,
-				 IQS620_PWR_SETTINGS_PWM_OUT,
-				 iqs620_pwm->out_en ? 0xff : 0);
-
-err_mutex:
 	mutex_unlock(&iqs620_pwm->lock);

 	if (ret) {
@@ -211,12 +195,14 @@ static int iqs620_pwm_probe(struct platform_device *pdev)
 	ret = regmap_read(iqs62x->regmap, IQS620_PWR_SETTINGS, &val);
 	if (ret)
 		return ret;
-	iqs620_pwm->out_en = val & IQS620_PWR_SETTINGS_PWM_OUT;

-	ret = regmap_read(iqs62x->regmap, IQS620_PWM_DUTY_CYCLE, &val);
-	if (ret)
-		return ret;
-	iqs620_pwm->duty_val = val;
+	if (val & IQS620_PWR_SETTINGS_PWM_OUT) {
+		ret = regmap_read(iqs62x->regmap, IQS620_PWM_DUTY_CYCLE, &val);
+		if (ret)
+			return ret;
+
+		iqs620_pwm->duty_scale = val + 1;
+	}

 	iqs620_pwm->chip.dev = &pdev->dev;
 	iqs620_pwm->chip.ops = &iqs620_pwm_ops;
--
2.7.4

