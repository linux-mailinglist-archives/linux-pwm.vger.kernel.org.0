Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B207C2481
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Sep 2019 17:40:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732065AbfI3PkC (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 30 Sep 2019 11:40:02 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:13970 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731127AbfI3Pj6 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 30 Sep 2019 11:39:58 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8UFVdeR013287;
        Mon, 30 Sep 2019 17:39:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=qLUAFJoZ4hJYwU9KqQE8rr3UJjLpfuf6fQEfBaTxXxs=;
 b=VzJb97KDI6wb8uChM6pzudyWFUxR+ZEOVFkOeGw0YELYgw9uZ3LkjGy7QWXRNEU3BSkM
 Gl9lxUcqTS+5QfGTN5J4sRU76egD9L/o/chK3gBRFc78NZ/KMrCjbtKISNnwvYVAj+E3
 j0pvYVGpUSH9nQdg8MB63h8P6i3Tc0sQ9RHmRKvPU7wRIWh+5i4NCpe4MC0HcskkKD/9
 7biOcsmycLt5SRm8D1BKPK8j9s8ymFQYx52LkCF72PMv57eSdB5NJxHXcq58eOjrQ8ZE
 x18W0A1mXU++2MJbVY8D+2CxEWKpMe6Gt07NVF22isF2FpL3LnPiaBLFQ9NwDER82R3L nA== 
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
        by mx08-00178001.pphosted.com with ESMTP id 2v9vna47sp-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 30 Sep 2019 17:39:45 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 6352A4D;
        Mon, 30 Sep 2019 15:39:42 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas21.st.com [10.75.90.44])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id BEEB42A45FB;
        Mon, 30 Sep 2019 17:39:41 +0200 (CEST)
Received: from SAFEX1HUBCAS22.st.com (10.75.90.92) by SAFEX1HUBCAS21.st.com
 (10.75.90.44) with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 30 Sep
 2019 17:39:41 +0200
Received: from localhost (10.48.0.192) by Webmail-ga.st.com (10.75.90.48) with
 Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 30 Sep 2019 17:39:41 +0200
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
To:     <thierry.reding@gmail.com>, <robh+dt@kernel.org>
CC:     <alexandre.torgue@st.com>, <mark.rutland@arm.com>,
        <mcoquelin.stm32@gmail.com>, <fabrice.gasnier@st.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        <benjamin.gaignard@st.com>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH 2/2] pwm: stm32: add power management support
Date:   Mon, 30 Sep 2019 17:39:11 +0200
Message-ID: <1569857951-20007-3-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1569857951-20007-1-git-send-email-fabrice.gasnier@st.com>
References: <1569857951-20007-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.48.0.192]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-09-30_09:2019-09-30,2019-09-30 signatures=0
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
 drivers/pwm/pwm-stm32.c | 82 +++++++++++++++++++++++++++++++++++++------------
 1 file changed, 62 insertions(+), 20 deletions(-)

diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
index 740e2de..9bcd73a 100644
--- a/drivers/pwm/pwm-stm32.c
+++ b/drivers/pwm/pwm-stm32.c
@@ -12,6 +12,7 @@
 #include <linux/mfd/stm32-timers.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/pinctrl/consumer.h>
 #include <linux/platform_device.h>
 #include <linux/pwm.h>
 
@@ -19,6 +20,12 @@
 #define CCMR_CHANNEL_MASK  0xFF
 #define MAX_BREAKINPUT 2
 
+struct stm32_breakinput {
+	u32 index;
+	u32 level;
+	u32 filter;
+};
+
 struct stm32_pwm {
 	struct pwm_chip chip;
 	struct mutex lock; /* protect pwm config/enable */
@@ -26,15 +33,11 @@ struct stm32_pwm {
 	struct regmap *regmap;
 	u32 max_arr;
 	bool have_complementary_output;
+	struct stm32_breakinput breakinput[MAX_BREAKINPUT];
+	unsigned int nbreakinput;
 	u32 capture[4] ____cacheline_aligned; /* DMA'able buffer */
 };
 
-struct stm32_breakinput {
-	u32 index;
-	u32 level;
-	u32 filter;
-};
-
 static inline struct stm32_pwm *to_stm32_pwm_dev(struct pwm_chip *chip)
 {
 	return container_of(chip, struct stm32_pwm, chip);
@@ -512,15 +515,27 @@ static int stm32_pwm_set_breakinput(struct stm32_pwm *priv,
 	return (bdtr & bke) ? 0 : -EINVAL;
 }
 
-static int stm32_pwm_apply_breakinputs(struct stm32_pwm *priv,
+static int stm32_pwm_apply_breakinputs(struct stm32_pwm *priv)
+{
+	int i, ret = 0;
+
+	for (i = 0; i < priv->nbreakinput && !ret; i++) {
+		ret = stm32_pwm_set_breakinput(priv,
+					       priv->breakinput[i].index,
+					       priv->breakinput[i].level,
+					       priv->breakinput[i].filter);
+	}
+
+	return ret;
+}
+
+static int stm32_pwm_probe_breakinputs(struct stm32_pwm *priv,
 				       struct device_node *np)
 {
-	struct stm32_breakinput breakinput[MAX_BREAKINPUT];
-	int nb, ret, i, array_size;
+	int nb, ret, array_size;
 
 	nb = of_property_count_elems_of_size(np, "st,breakinput",
 					     sizeof(struct stm32_breakinput));
-
 	/*
 	 * Because "st,breakinput" parameter is optional do not make probe
 	 * failed if it doesn't exist.
@@ -531,20 +546,14 @@ static int stm32_pwm_apply_breakinputs(struct stm32_pwm *priv,
 	if (nb > MAX_BREAKINPUT)
 		return -EINVAL;
 
+	priv->nbreakinput = nb;
 	array_size = nb * sizeof(struct stm32_breakinput) / sizeof(u32);
 	ret = of_property_read_u32_array(np, "st,breakinput",
-					 (u32 *)breakinput, array_size);
+					 (u32 *)priv->breakinput, array_size);
 	if (ret)
 		return ret;
 
-	for (i = 0; i < nb && !ret; i++) {
-		ret = stm32_pwm_set_breakinput(priv,
-					       breakinput[i].index,
-					       breakinput[i].level,
-					       breakinput[i].filter);
-	}
-
-	return ret;
+	return stm32_pwm_apply_breakinputs(priv);
 }
 
 static void stm32_pwm_detect_complementary(struct stm32_pwm *priv)
@@ -614,7 +623,7 @@ static int stm32_pwm_probe(struct platform_device *pdev)
 	if (!priv->regmap || !priv->clk)
 		return -EINVAL;
 
-	ret = stm32_pwm_apply_breakinputs(priv, np);
+	ret = stm32_pwm_probe_breakinputs(priv, np);
 	if (ret)
 		return ret;
 
@@ -647,6 +656,38 @@ static int stm32_pwm_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static int __maybe_unused stm32_pwm_suspend(struct device *dev)
+{
+	struct stm32_pwm *priv = dev_get_drvdata(dev);
+	struct pwm_state state;
+	unsigned int i;
+
+	for (i = 0; i < priv->chip.npwm; i++) {
+		pwm_get_state(&priv->chip.pwms[i], &state);
+		if (state.enabled) {
+			dev_err(dev, "The consumer didn't stop us (%s)\n",
+				priv->chip.pwms[i].label);
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
+	return stm32_pwm_apply_breakinputs(priv);
+}
+
+static SIMPLE_DEV_PM_OPS(stm32_pwm_pm_ops, stm32_pwm_suspend, stm32_pwm_resume);
+
 static const struct of_device_id stm32_pwm_of_match[] = {
 	{ .compatible = "st,stm32-pwm",	},
 	{ /* end node */ },
@@ -659,6 +700,7 @@ static struct platform_driver stm32_pwm_driver = {
 	.driver	= {
 		.name = "stm32-pwm",
 		.of_match_table = stm32_pwm_of_match,
+		.pm = &stm32_pwm_pm_ops,
 	},
 };
 module_platform_driver(stm32_pwm_driver);
-- 
2.7.4

