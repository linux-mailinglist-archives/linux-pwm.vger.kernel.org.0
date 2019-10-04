Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A771CBAEE
	for <lists+linux-pwm@lfdr.de>; Fri,  4 Oct 2019 14:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387764AbfJDMyf (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 4 Oct 2019 08:54:35 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:58222 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387769AbfJDMy1 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 4 Oct 2019 08:54:27 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x94CpoxJ005820;
        Fri, 4 Oct 2019 14:54:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=V4v+lFYFEXdiVbvoBk7RFLUjPo+9SumQd8cGnXWqUig=;
 b=n46SoD5OaCtB0jdEACL7bSdbzu3jsBBqziQagzYHPtuhePEOqX5S9qnm33QRU5Mr/PSh
 YOsuRb38HIoDY/F/rgg4tupzfVYvDaWzaXhD3GAicU47fNchcDESni+DQf9iWY64CUOD
 kaFRvzFuvvISlqnDVemx4aDyfdb9XYv85Iqt82q3qAYjua28+iUfABacQwxFCZWB+6+/
 lXaqLqWfWq99OGljZnoTS6tXR0rQ7X2ItcMT+GFTzOHFA8KCZispgpFJ52jlfmTavkx6
 U6+KbYHxBNV6iVVEFYdVF7nGJ4AnvQPulCyLzlwDC5gz8CBIxjgpN5ique6diVrKDld8 8Q== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2v9xdhapkk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Oct 2019 14:54:13 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3E51A10002A;
        Fri,  4 Oct 2019 14:54:13 +0200 (CEST)
Received: from Webmail-eu.st.com (Safex1hubcas21.st.com [10.75.90.44])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 3054A2BFDEF;
        Fri,  4 Oct 2019 14:54:13 +0200 (CEST)
Received: from SAFEX1HUBCAS22.st.com (10.75.90.92) by SAFEX1HUBCAS21.st.com
 (10.75.90.44) with Microsoft SMTP Server (TLS) id 14.3.439.0; Fri, 4 Oct 2019
 14:54:13 +0200
Received: from localhost (10.48.0.192) by Webmail-ga.st.com (10.75.90.48) with
 Microsoft SMTP Server (TLS) id 14.3.439.0; Fri, 4 Oct 2019 14:54:12 +0200
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
To:     <thierry.reding@gmail.com>, <robh+dt@kernel.org>,
        <u.kleine-koenig@pengutronix.de>
CC:     <alexandre.torgue@st.com>, <mark.rutland@arm.com>,
        <mcoquelin.stm32@gmail.com>, <fabrice.gasnier@st.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        <benjamin.gaignard@st.com>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH v2 3/3] pwm: stm32: add power management support
Date:   Fri, 4 Oct 2019 14:53:53 +0200
Message-ID: <1570193633-6600-4-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1570193633-6600-1-git-send-email-fabrice.gasnier@st.com>
References: <1570193633-6600-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.48.0.192]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-04_06:2019-10-03,2019-10-04 signatures=0
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Add suspend/resume PM sleep ops. When going to low power, enforce the PWM
channel isn't active. Let the PWM consumers disable it during their own
suspend sequence, see [1]. So, perform a check here, and handle the
pinctrl states. Also restore the break inputs upon resume, as registers
content may be lost when going to low power mode.

[1] https://lkml.org/lkml/2019/2/5/770

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
Changes in v2:
Follow Uwe suggestions/remarks:
- Add a precursor patch to ease reviewing
- Use registers read instead of pwm_get_state
- Add a comment to mention registers content may be lost in low power mode
---
 drivers/pwm/pwm-stm32.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
index cf8658c..546b661 100644
--- a/drivers/pwm/pwm-stm32.c
+++ b/drivers/pwm/pwm-stm32.c
@@ -12,6 +12,7 @@
 #include <linux/mfd/stm32-timers.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/pinctrl/consumer.h>
 #include <linux/platform_device.h>
 #include <linux/pwm.h>
 
@@ -655,6 +656,42 @@ static int stm32_pwm_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static int __maybe_unused stm32_pwm_suspend(struct device *dev)
+{
+	struct stm32_pwm *priv = dev_get_drvdata(dev);
+	unsigned int ch;
+	u32 ccer, mask;
+
+	/* Look for active channels */
+	ccer = active_channels(priv);
+
+	for (ch = 0; ch < priv->chip.npwm; ch++) {
+		mask = TIM_CCER_CC1E << (ch * 4);
+		if (ccer & mask) {
+			dev_err(dev, "The consumer didn't stop us (%s)\n",
+				priv->chip.pwms[ch].label);
+			return -EBUSY;
+		}
+	}
+
+	return pinctrl_pm_select_sleep_state(dev);
+}
+
+static int __maybe_unused stm32_pwm_resume(struct device *dev)
+{
+	struct stm32_pwm *priv = dev_get_drvdata(dev);
+	int ret;
+
+	ret = pinctrl_pm_select_default_state(dev);
+	if (ret)
+		return ret;
+
+	/* restore breakinput registers that may have been lost in low power */
+	return stm32_pwm_apply_breakinputs(priv);
+}
+
+static SIMPLE_DEV_PM_OPS(stm32_pwm_pm_ops, stm32_pwm_suspend, stm32_pwm_resume);
+
 static const struct of_device_id stm32_pwm_of_match[] = {
 	{ .compatible = "st,stm32-pwm",	},
 	{ /* end node */ },
@@ -667,6 +704,7 @@ static struct platform_driver stm32_pwm_driver = {
 	.driver	= {
 		.name = "stm32-pwm",
 		.of_match_table = stm32_pwm_of_match,
+		.pm = &stm32_pwm_pm_ops,
 	},
 };
 module_platform_driver(stm32_pwm_driver);
-- 
2.7.4

