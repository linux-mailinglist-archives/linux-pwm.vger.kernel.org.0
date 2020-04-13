Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C586E1A6174
	for <lists+linux-pwm@lfdr.de>; Mon, 13 Apr 2020 04:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727399AbgDMCQE (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 12 Apr 2020 22:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:38410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727081AbgDMCQE (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 12 Apr 2020 22:16:04 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2085.outbound.protection.outlook.com [40.107.94.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31676C0A3BE0
        for <linux-pwm@vger.kernel.org>; Sun, 12 Apr 2020 19:16:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=faGKFSvTWspRMXM9IBm2XktiXAnB98Bh9Ud0c9eu55I0sbze2cNIeSSmOzzqIhfqRDDq8BVciAm1UjRnLPQhDw7mwGsmuAct5LRz1Oo1E/Un+vzyx19p1tqwt138zwq7snWpbPHfn/i7yV9QYJ+zWpXepEwBi+Qun8Qzly1f4KpvGKBcCqfGVb3QACiGcrRz309EHwrSjt/xmEhzJN0OL0YIEje06iDNv0GqwqyQX1BvtWTBmsQfUWRSWDAnBrYusG1MLgtGn4Cpc490LvtTEg7puBXpvNDYTXmFr6SGiq6Y3k6bVAPIU0z2enL+w3qOp/iSFtR/VbjoX1g8sRkncQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xkp0E2hsKZQr1Kniz9mWY9fXngNf3knnOVggH6PS73I=;
 b=luwlfxA3if0ZH+/PtwcsGFHrH/WH+ltXUA2x5K4m9JaAHj5XlGfwfLYFh4+vckcwdwtEvqIYOn3PSXx/GBNIXM9IXdu+pHBudQAcgM8RpTZ5blKC2aJcJy3r7+YTuNCOswtCsAo8PUgNgaWcVSF6mdkddYZvJSQb8B3Cf3wIdC9axSusgAR4moh3fElQ53PxSrOaq3S8euwdKbfcG5jIUkPDy1YCasfeBrUPvnoJ7ylsE/PnnRZAseS423IBGcFzKMcBldX299isqGWLZeaGIYwmSnQlcqZO3sRL+/+VuQY/rmCecWf/8F97ZL6WSLnfIUwLFYJ+fj2IOO1uk1HA0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xkp0E2hsKZQr1Kniz9mWY9fXngNf3knnOVggH6PS73I=;
 b=dkTsiLE1zsyhFQzgnB/u+c1KXK76LJ0kSkJAaPNOenvwbCSHs4ZuilxIbQ/KRubOIGz95mDlRz68rhgnM32cM36IM66nDhU5ZmfH3+x1E/vJnaztFf68smtb/eSDA2Bm5R0bhEn3bAeBb3AKUNtlPVJ1BpzDKPR36KliqdlROXg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jeff@labundy.com; 
Received: from SN6PR08MB5517.namprd08.prod.outlook.com (2603:10b6:805:fb::32)
 by SN6PR08MB4253.namprd08.prod.outlook.com (2603:10b6:805:34::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.20; Mon, 13 Apr
 2020 02:16:01 +0000
Received: from SN6PR08MB5517.namprd08.prod.outlook.com
 ([fe80::d1f2:9197:cd6:4823]) by SN6PR08MB5517.namprd08.prod.outlook.com
 ([fe80::d1f2:9197:cd6:4823%7]) with mapi id 15.20.2900.015; Mon, 13 Apr 2020
 02:16:01 +0000
From:   Jeff LaBundy <jeff@labundy.com>
To:     thierry.reding@gmail.com
Cc:     u.kleine-koenig@pengutronix.de, linux-pwm@vger.kernel.org,
        Jeff LaBundy <jeff@labundy.com>
Subject: [RESEND v5] pwm: Add support for Azoteq IQS620A PWM generator
Date:   Sun, 12 Apr 2020 21:15:16 -0500
Message-Id: <1586744116-14157-1-git-send-email-jeff@labundy.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN2PR01CA0057.prod.exchangelabs.com (2603:10b6:800::25) To
 SN6PR08MB5517.namprd08.prod.outlook.com (2603:10b6:805:fb::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (136.49.227.119) by SN2PR01CA0057.prod.exchangelabs.com (2603:10b6:800::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2900.15 via Frontend Transport; Mon, 13 Apr 2020 02:16:01 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [136.49.227.119]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0aab9432-f5fc-490c-3c8e-08d7df509cb5
X-MS-TrafficTypeDiagnostic: SN6PR08MB4253:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR08MB4253CC4B01FF7767A5AA3F89D3DD0@SN6PR08MB4253.namprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1284;
X-Forefront-PRVS: 037291602B
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR08MB5517.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(376002)(136003)(396003)(39830400003)(346002)(366004)(107886003)(956004)(36756003)(2616005)(52116002)(26005)(316002)(16526019)(2906002)(186003)(6512007)(4326008)(6506007)(6916009)(30864003)(66476007)(6666004)(66574012)(81156014)(8936002)(8676002)(66556008)(6486002)(508600001)(86362001)(5660300002)(66946007);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: labundy.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: elQbmX313T/grsfjlpieZMVUYNxAeAmj+4v2EGOzlO+7m80i3Mi840s90YkJc635M9uzJQboKLcs9fZEBtQI5z/pW4rXMJJrEg4L0zEqlLMQw6c4bkrYq90UbrgFveoBPwMUYJXwmoLQVyrojcckfRkkAcG9ZRKTQPR2JUsKHR5D3z3YhW0EVsc3Ol7HKlwmCl6EdYnz6DIWpocNSQgwmUDslOsxNf+I/iXln1hJl386TOuSb/2xxTwp/ze+FbdxN36CdyKvRVgyfeC6OFKVn0bOA2fAHCespDtz43CYMvJfTkoZTtiZpHJIOocCaRkAm9xFp5wWYum63OsDRviDYoXQbrt/38wEdh02ampWUDBkB9dCBWakAIsBfWkJniUca/rcpcCf/CvXOFypbL3GI32qQesFcTahIBea8semmUD9e4MqU+thvvS+qVAEbOIS
X-MS-Exchange-AntiSpam-MessageData: S1t4ED9K2Vx7yRiHBghaLQj6vIUby2vfK2r43rSwwGGoPMNkr+h6tmX5kXaDUIdVCNllbn9lnkdFJlZJoTdjVQOl+OKWukWESfSrvI/CXey2qvPlHadX7ntsDrlSg9cIpOSj54JfxKx+DNWEPEVYkA==
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0aab9432-f5fc-490c-3c8e-08d7df509cb5
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2020 02:16:01.7834
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9HaTYQePZ30kmGQjDcppCng6613waWqArk0H8TxYJogpUYTJf379VBwVtTBeQtS1Stsflcjwt5/P5K2iCQ64rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR08MB4253
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This patch adds support for the Azoteq IQS620A, capable of generating
a 1-kHz PWM output with duty cycle between ~0.4% and 100% (inclusive).

Signed-off-by: Jeff LaBundy <jeff@labundy.com>
Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
Note: This patch was originally part of a series that was intended to be taken
      through mfd in its entirety. However, attempts to elicit an Ack for this
      patch went unanswered, so it was dropped in order to unblock the series.

      The remainder of the series (including pwm bindings) landed in 5.7-rc1,
      so this patch is being sent on its own so that it may be taken through
      pwm during the next merge window.

Changes in v5:
  - Replaced iqs62x->map with iqs62x->regmap throughout
  - Updated iqs620_pwm_probe to read the values of IQS620_PWR_SETTINGS_PWM_OUT
    and IQS620_PWM_DUTY_CYCLE so that iqs620_pwm_get_state reflects the actual
    state of the device following any changes made by a bootloader
  - Dropped #defines for platform_driver name and alias in favor of the actual
    string names

Changes in v4:
  - Updated iqs620_pwm_apply and iqs620_pwm_get_state to hold the lock around
    only the minimum necessary code
  - Removed the completion protecting against early use of chip->pwms[0] from
    inside iqs620_pwm_notifier in favor of cached register values
  - Updated iqs620_pwm_get_state to use the cached register values instead of
    reading IQS620_PWR_SETTINGS_PWM_OUT and IQS620_PWM_DUTY_CYCLE (both equal
    to zero by default)
  - Added a comment in iqs620_pwm_notifier to note that the parent MFD driver
    prints an error message in the event of a device reset

Changes in v3:
  - Updated the commit message to say "~0.4%" instead of "0.4%"
  - Clarified the effect of duty cycle and state changes in the 'Limitations'
    section and added a restriction regarding 0% duty cycle
  - Added a comment in iqs620_pwm_apply to explain how duty cycle is derived
  - Updated iqs620_pwm_apply to disable the output first and enable it last to
    prevent temporarily driving a stale duty cycle
  - Rounded the calculation for duty cycle up and down in iqs620_pwm_get_state
    and iqs620_pwm_apply, respectively
  - Added a comment in iqs620_pwm_get_state to explain what it reports follow-
    ing requests to set duty cycle to 0%
  - Added a lock to prevent back-to-back access of IQS620_PWR_SETTINGS_PWM_OUT
    and IQS620_PWM_DUTY_CYCLE from being interrupted
  - Updated iqs620_pwm_notifier to reference pwm->state directly as opposed to
    calling pwm_get_state
  - Moved notifier unregistration back to a device-managed action
  - Added a completion to prevent iqs620_pwm_notifier from referencing the
    pwm_chip structure until it has been initialized by pwmchip_add

Changes in v2:
  - Merged 'Copyright' and 'Author' lines into one in introductory comments
  - Added 'Limitations' section to introductory comments
  - Replaced 'error' with 'ret' throughout
  - Added const qualifier to state argument of iqs620_pwm_apply and removed all
    modifications to the variable's contents
  - Updated iqs620_pwm_apply to return -ENOTSUPP or -EINVAL if the requested
    polarity is inverted or the requested period is below 1 ms, respectively
  - Updated iqs620_pwm_apply to disable the PWM output if duty cycle is zero
  - Added iqs620_pwm_get_state
  - Eliminated tabbed alignment of pwm_ops and platform_driver struct members
  - Moved notifier unregistration to already present iqs620_pwm_remove, which
    eliminated the need for a device-managed action and ready flag
  - Added a comment in iqs620_pwm_probe to explain the order of operations
  - Changed Kconfig "depends on" logic to MFD_IQS62X || COMPILE_TEST

 drivers/pwm/Kconfig       |  10 ++
 drivers/pwm/Makefile      |   1 +
 drivers/pwm/pwm-iqs620a.c | 270 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 281 insertions(+)
 create mode 100644 drivers/pwm/pwm-iqs620a.c

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index eebbc91..c13d146 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -232,6 +232,16 @@ config PWM_IMX_TPM
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-imx-tpm.

+config PWM_IQS620A
+	tristate "Azoteq IQS620A PWM support"
+	depends on MFD_IQS62X || COMPILE_TEST
+	help
+	  Generic PWM framework driver for the Azoteq IQS620A multi-function
+	  sensor.
+
+	  To compile this driver as a module, choose M here: the module will
+	  be called pwm-iqs620a.
+
 config PWM_JZ4740
 	tristate "Ingenic JZ47xx PWM support"
 	depends on MACH_INGENIC
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index 9a47507..a59c710 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -20,6 +20,7 @@ obj-$(CONFIG_PWM_IMG)		+= pwm-img.o
 obj-$(CONFIG_PWM_IMX1)		+= pwm-imx1.o
 obj-$(CONFIG_PWM_IMX27)		+= pwm-imx27.o
 obj-$(CONFIG_PWM_IMX_TPM)	+= pwm-imx-tpm.o
+obj-$(CONFIG_PWM_IQS620A)	+= pwm-iqs620a.o
 obj-$(CONFIG_PWM_JZ4740)	+= pwm-jz4740.o
 obj-$(CONFIG_PWM_LP3943)	+= pwm-lp3943.o
 obj-$(CONFIG_PWM_LPC18XX_SCT)	+= pwm-lpc18xx-sct.o
diff --git a/drivers/pwm/pwm-iqs620a.c b/drivers/pwm/pwm-iqs620a.c
new file mode 100644
index 0000000..674f0e2
--- /dev/null
+++ b/drivers/pwm/pwm-iqs620a.c
@@ -0,0 +1,270 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Azoteq IQS620A PWM Generator
+ *
+ * Copyright (C) 2019 Jeff LaBundy <jeff@labundy.com>
+ *
+ * Limitations:
+ * - The period is fixed to 1 ms and is generated continuously despite changes
+ *   to the duty cycle or enable/disable state.
+ * - Changes to the duty cycle or enable/disable state take effect immediately
+ *   and may result in a glitch during the period in which the change is made.
+ * - The device cannot generate a 0% duty cycle. For duty cycles below 1 / 256
+ *   ms, the output is disabled and relies upon an external pull-down resistor
+ *   to hold the GPIO3/LTX pin low.
+ */
+
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/mfd/iqs62x.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/notifier.h>
+#include <linux/platform_device.h>
+#include <linux/pwm.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+
+#define IQS620_PWR_SETTINGS			0xD2
+#define IQS620_PWR_SETTINGS_PWM_OUT		BIT(7)
+
+#define IQS620_PWM_DUTY_CYCLE			0xD8
+
+#define IQS620_PWM_PERIOD_NS			1000000
+
+struct iqs620_pwm_private {
+	struct iqs62x_core *iqs62x;
+	struct pwm_chip chip;
+	struct notifier_block notifier;
+	struct mutex lock;
+	bool out_en;
+	u8 duty_val;
+};
+
+static int iqs620_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			    const struct pwm_state *state)
+{
+	struct iqs620_pwm_private *iqs620_pwm;
+	struct iqs62x_core *iqs62x;
+	int duty_scale, ret;
+
+	if (state->polarity != PWM_POLARITY_NORMAL)
+		return -ENOTSUPP;
+
+	if (state->period < IQS620_PWM_PERIOD_NS)
+		return -EINVAL;
+
+	iqs620_pwm = container_of(chip, struct iqs620_pwm_private, chip);
+	iqs62x = iqs620_pwm->iqs62x;
+
+	/*
+	 * The duty cycle generated by the device is calculated as follows:
+	 *
+	 * duty_cycle = (IQS620_PWM_DUTY_CYCLE + 1) / 256 * 1 ms
+	 *
+	 * ...where IQS620_PWM_DUTY_CYCLE is a register value between 0 and 255
+	 * (inclusive). Therefore the lowest duty cycle the device can generate
+	 * while the output is enabled is 1 / 256 ms.
+	 *
+	 * For lower duty cycles (e.g. 0), the PWM output is simply disabled to
+	 * allow an external pull-down resistor to hold the GPIO3/LTX pin low.
+	 */
+	duty_scale = state->duty_cycle * 256 / IQS620_PWM_PERIOD_NS;
+
+	mutex_lock(&iqs620_pwm->lock);
+
+	if (!state->enabled || !duty_scale) {
+		ret = regmap_update_bits(iqs62x->regmap, IQS620_PWR_SETTINGS,
+					 IQS620_PWR_SETTINGS_PWM_OUT, 0);
+		if (ret)
+			goto err_mutex;
+	}
+
+	if (duty_scale) {
+		u8 duty_val = min(duty_scale - 1, 0xFF);
+
+		ret = regmap_write(iqs62x->regmap, IQS620_PWM_DUTY_CYCLE,
+				   duty_val);
+		if (ret)
+			goto err_mutex;
+
+		iqs620_pwm->duty_val = duty_val;
+	}
+
+	if (state->enabled && duty_scale) {
+		ret = regmap_update_bits(iqs62x->regmap, IQS620_PWR_SETTINGS,
+					 IQS620_PWR_SETTINGS_PWM_OUT, 0xFF);
+		if (ret)
+			goto err_mutex;
+	}
+
+	iqs620_pwm->out_en = state->enabled;
+
+err_mutex:
+	mutex_unlock(&iqs620_pwm->lock);
+
+	return ret;
+}
+
+static void iqs620_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
+				 struct pwm_state *state)
+{
+	struct iqs620_pwm_private *iqs620_pwm;
+
+	iqs620_pwm = container_of(chip, struct iqs620_pwm_private, chip);
+
+	mutex_lock(&iqs620_pwm->lock);
+
+	/*
+	 * Since the device cannot generate a 0% duty cycle, requests to do so
+	 * cause subsequent calls to iqs620_pwm_get_state to report the output
+	 * as disabled with duty cycle equal to that which was in use prior to
+	 * the request. This is not ideal, but is the best compromise based on
+	 * the capabilities of the device.
+	 */
+	state->enabled = iqs620_pwm->out_en;
+	state->duty_cycle = DIV_ROUND_UP((iqs620_pwm->duty_val + 1) *
+					 IQS620_PWM_PERIOD_NS, 256);
+
+	mutex_unlock(&iqs620_pwm->lock);
+
+	state->period = IQS620_PWM_PERIOD_NS;
+}
+
+static int iqs620_pwm_notifier(struct notifier_block *notifier,
+			       unsigned long event_flags, void *context)
+{
+	struct iqs620_pwm_private *iqs620_pwm;
+	struct iqs62x_core *iqs62x;
+	int ret;
+
+	if (!(event_flags & BIT(IQS62X_EVENT_SYS_RESET)))
+		return NOTIFY_DONE;
+
+	iqs620_pwm = container_of(notifier, struct iqs620_pwm_private,
+				  notifier);
+	iqs62x = iqs620_pwm->iqs62x;
+
+	mutex_lock(&iqs620_pwm->lock);
+
+	/*
+	 * The parent MFD driver already prints an error message in the event
+	 * of a device reset, so nothing else is printed here unless there is
+	 * an additional failure.
+	 */
+	ret = regmap_write(iqs62x->regmap, IQS620_PWM_DUTY_CYCLE,
+			   iqs620_pwm->duty_val);
+	if (ret)
+		goto err_mutex;
+
+	ret = regmap_update_bits(iqs62x->regmap, IQS620_PWR_SETTINGS,
+				 IQS620_PWR_SETTINGS_PWM_OUT,
+				 iqs620_pwm->out_en ? 0xFF : 0);
+
+err_mutex:
+	mutex_unlock(&iqs620_pwm->lock);
+
+	if (ret) {
+		dev_err(iqs620_pwm->chip.dev,
+			"Failed to re-initialize device: %d\n", ret);
+		return NOTIFY_BAD;
+	}
+
+	return NOTIFY_OK;
+}
+
+static const struct pwm_ops iqs620_pwm_ops = {
+	.apply = iqs620_pwm_apply,
+	.get_state = iqs620_pwm_get_state,
+	.owner = THIS_MODULE,
+};
+
+static void iqs620_pwm_notifier_unregister(void *context)
+{
+	struct iqs620_pwm_private *iqs620_pwm = context;
+	int ret;
+
+	ret = blocking_notifier_chain_unregister(&iqs620_pwm->iqs62x->nh,
+						 &iqs620_pwm->notifier);
+	if (ret)
+		dev_err(iqs620_pwm->chip.dev,
+			"Failed to unregister notifier: %d\n", ret);
+}
+
+static int iqs620_pwm_probe(struct platform_device *pdev)
+{
+	struct iqs62x_core *iqs62x = dev_get_drvdata(pdev->dev.parent);
+	struct iqs620_pwm_private *iqs620_pwm;
+	unsigned int val;
+	int ret;
+
+	iqs620_pwm = devm_kzalloc(&pdev->dev, sizeof(*iqs620_pwm), GFP_KERNEL);
+	if (!iqs620_pwm)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, iqs620_pwm);
+	iqs620_pwm->iqs62x = iqs62x;
+
+	ret = regmap_read(iqs62x->regmap, IQS620_PWR_SETTINGS, &val);
+	if (ret)
+		return ret;
+	iqs620_pwm->out_en = val & IQS620_PWR_SETTINGS_PWM_OUT;
+
+	ret = regmap_read(iqs62x->regmap, IQS620_PWM_DUTY_CYCLE, &val);
+	if (ret)
+		return ret;
+	iqs620_pwm->duty_val = val;
+
+	iqs620_pwm->chip.dev = &pdev->dev;
+	iqs620_pwm->chip.ops = &iqs620_pwm_ops;
+	iqs620_pwm->chip.base = -1;
+	iqs620_pwm->chip.npwm = 1;
+
+	mutex_init(&iqs620_pwm->lock);
+
+	iqs620_pwm->notifier.notifier_call = iqs620_pwm_notifier;
+	ret = blocking_notifier_chain_register(&iqs620_pwm->iqs62x->nh,
+					       &iqs620_pwm->notifier);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to register notifier: %d\n", ret);
+		return ret;
+	}
+
+	ret = devm_add_action_or_reset(&pdev->dev,
+				       iqs620_pwm_notifier_unregister,
+				       iqs620_pwm);
+	if (ret)
+		return ret;
+
+	ret = pwmchip_add(&iqs620_pwm->chip);
+	if (ret)
+		dev_err(&pdev->dev, "Failed to add device: %d\n", ret);
+
+	return ret;
+}
+
+static int iqs620_pwm_remove(struct platform_device *pdev)
+{
+	struct iqs620_pwm_private *iqs620_pwm = platform_get_drvdata(pdev);
+	int ret;
+
+	ret = pwmchip_remove(&iqs620_pwm->chip);
+	if (ret)
+		dev_err(&pdev->dev, "Failed to remove device: %d\n", ret);
+
+	return ret;
+}
+
+static struct platform_driver iqs620_pwm_platform_driver = {
+	.driver = {
+		.name = "iqs620a-pwm",
+	},
+	.probe = iqs620_pwm_probe,
+	.remove = iqs620_pwm_remove,
+};
+module_platform_driver(iqs620_pwm_platform_driver);
+
+MODULE_AUTHOR("Jeff LaBundy <jeff@labundy.com>");
+MODULE_DESCRIPTION("Azoteq IQS620A PWM Generator");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:iqs620a-pwm");
--
2.7.4

