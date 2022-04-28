Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34043513102
	for <lists+linux-pwm@lfdr.de>; Thu, 28 Apr 2022 12:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238851AbiD1KNN (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 28 Apr 2022 06:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233395AbiD1KMv (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 28 Apr 2022 06:12:51 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E986433A7
        for <linux-pwm@vger.kernel.org>; Thu, 28 Apr 2022 03:04:33 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id d5so6046998wrb.6
        for <linux-pwm@vger.kernel.org>; Thu, 28 Apr 2022 03:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r6GO++wJs6Ylv9J8Z571XUGz+vgSn7D9Np0jLXX2xNs=;
        b=dUPpc3hxGpUKssLZI7KYsSpVqrjwO0E6wN2tR5Zr6ZunX/wFFH+gNKa3VTEoImdTt6
         LaB2Qum5mhNVTiPuz+L/2zVgRbu/wnlKTSw6xLer0sP0FvbDNiQAMwA4NlTN/UtqnnOt
         p5NrSqGWOzuezI0SbLzjGDq0oLRpcytFVzmlk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r6GO++wJs6Ylv9J8Z571XUGz+vgSn7D9Np0jLXX2xNs=;
        b=IiMx1/Zxiorg1upW5iJTcD1mpxCHvaunWKwPqPz2JLF8INnWLadU/3mSPo20Mq6Qjt
         /aFkIN5dp7Lqs3Jk/Z4M+JbpWJm3jLn+IIEP/NrIq/JNWeTtIweGRfgyL3QXi9UiGYXv
         zDFk+da1IgiXKES/zWOv/X9psiWbU+efE7VlJngIQ73AD2CfQKxTAxJrGMcRfVQa2Spi
         WNQJ+FJQNN0DqaFnDU869ZWgD6P6Qe0sx11qZhQZTJVlAEKdrb5EWdZnNLS+2hmsUFxj
         fIYp+gy4N3UUALzVBzt9Vej2dmdY9pph6EYtO19XDmuBc4GgDT1zqtoXuvESGjilqL0K
         tX8w==
X-Gm-Message-State: AOAM532tVoMSRIeEXPyKEQ6l4hBLAlG00RaFYZj82c9L2kgvE/3nvwEG
        OvbVE5wRWhuZb/Et2ow7kF3kdw==
X-Google-Smtp-Source: ABdhPJxWC0lEzljS1JjjJ6x5Vn6FXFI1H/zmeIMZMEaw5iXw91svT6CfHg5YHdajuHQ4BS2W7XwiwQ==
X-Received: by 2002:a05:6000:1d94:b0:206:e3c:a118 with SMTP id bk20-20020a0560001d9400b002060e3ca118mr25798153wrb.452.1651140272153;
        Thu, 28 Apr 2022 03:04:32 -0700 (PDT)
Received: from fabiobaltieri-linux.lan ([37.228.205.1])
        by smtp.gmail.com with ESMTPSA id v5-20020a5d6785000000b0020a792848eesm15080449wru.82.2022.04.28.03.04.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 03:04:31 -0700 (PDT)
From:   Fabio Baltieri <fabiobaltieri@chromium.org>
To:     Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        chrome-platform@lists.linux.dev, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Fabio Baltieri <fabiobaltieri@chromium.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>
Subject: [PATCH v6 2/4] pwm: pwm-cros-ec: add channel type support
Date:   Thu, 28 Apr 2022 10:04:19 +0000
Message-Id: <20220428100421.247471-3-fabiobaltieri@chromium.org>
X-Mailer: git-send-email 2.36.0.rc2.479.g8af0fa9b8e-goog
In-Reply-To: <20220428100421.247471-1-fabiobaltieri@chromium.org>
References: <20220428100421.247471-1-fabiobaltieri@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Add support for EC_PWM_TYPE_DISPLAY_LIGHT and EC_PWM_TYPE_KB_LIGHT pwm
types to the PWM cros_ec_pwm driver. This allows specifying one of these
PWM channel by functionality, and let the EC firmware pick the correct
channel, thus abstracting the hardware implementation from the kernel
driver.

To use it, define the node with the "google,cros-ec-pwm-type"
compatible.

Signed-off-by: Fabio Baltieri <fabiobaltieri@chromium.org>
Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
 drivers/pwm/pwm-cros-ec.c | 82 ++++++++++++++++++++++++++++++++-------
 1 file changed, 67 insertions(+), 15 deletions(-)

diff --git a/drivers/pwm/pwm-cros-ec.c b/drivers/pwm/pwm-cros-ec.c
index 5e29d9c682c3..7f10f56c3eb6 100644
--- a/drivers/pwm/pwm-cros-ec.c
+++ b/drivers/pwm/pwm-cros-ec.c
@@ -12,17 +12,21 @@
 #include <linux/pwm.h>
 #include <linux/slab.h>
 
+#include <dt-bindings/mfd/cros_ec.h>
+
 /**
  * struct cros_ec_pwm_device - Driver data for EC PWM
  *
  * @dev: Device node
  * @ec: Pointer to EC device
  * @chip: PWM controller chip
+ * @use_pwm_type: Use PWM types instead of generic channels
  */
 struct cros_ec_pwm_device {
 	struct device *dev;
 	struct cros_ec_device *ec;
 	struct pwm_chip chip;
+	bool use_pwm_type;
 };
 
 /**
@@ -58,14 +62,31 @@ static void cros_ec_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
 	kfree(channel);
 }
 
-static int cros_ec_pwm_set_duty(struct cros_ec_device *ec, u8 index, u16 duty)
+static int cros_ec_dt_type_to_pwm_type(u8 dt_index, u8 *pwm_type)
 {
+	switch (dt_index) {
+	case CROS_EC_PWM_DT_KB_LIGHT:
+		*pwm_type = EC_PWM_TYPE_KB_LIGHT;
+		return 0;
+	case CROS_EC_PWM_DT_DISPLAY_LIGHT:
+		*pwm_type = EC_PWM_TYPE_DISPLAY_LIGHT;
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int cros_ec_pwm_set_duty(struct cros_ec_pwm_device *ec_pwm, u8 index,
+				u16 duty)
+{
+	struct cros_ec_device *ec = ec_pwm->ec;
 	struct {
 		struct cros_ec_command msg;
 		struct ec_params_pwm_set_duty params;
 	} __packed buf;
 	struct ec_params_pwm_set_duty *params = &buf.params;
 	struct cros_ec_command *msg = &buf.msg;
+	int ret;
 
 	memset(&buf, 0, sizeof(buf));
 
@@ -75,14 +96,25 @@ static int cros_ec_pwm_set_duty(struct cros_ec_device *ec, u8 index, u16 duty)
 	msg->outsize = sizeof(*params);
 
 	params->duty = duty;
-	params->pwm_type = EC_PWM_TYPE_GENERIC;
-	params->index = index;
+
+	if (ec_pwm->use_pwm_type) {
+		ret = cros_ec_dt_type_to_pwm_type(index, &params->pwm_type);
+		if (ret) {
+			dev_err(ec->dev, "Invalid PWM type index: %d\n", index);
+			return ret;
+		}
+		params->index = 0;
+	} else {
+		params->pwm_type = EC_PWM_TYPE_GENERIC;
+		params->index = index;
+	}
 
 	return cros_ec_cmd_xfer_status(ec, msg);
 }
 
-static int cros_ec_pwm_get_duty(struct cros_ec_device *ec, u8 index)
+static int cros_ec_pwm_get_duty(struct cros_ec_pwm_device *ec_pwm, u8 index)
 {
+	struct cros_ec_device *ec = ec_pwm->ec;
 	struct {
 		struct cros_ec_command msg;
 		union {
@@ -102,8 +134,17 @@ static int cros_ec_pwm_get_duty(struct cros_ec_device *ec, u8 index)
 	msg->insize = sizeof(*resp);
 	msg->outsize = sizeof(*params);
 
-	params->pwm_type = EC_PWM_TYPE_GENERIC;
-	params->index = index;
+	if (ec_pwm->use_pwm_type) {
+		ret = cros_ec_dt_type_to_pwm_type(index, &params->pwm_type);
+		if (ret) {
+			dev_err(ec->dev, "Invalid PWM type index: %d\n", index);
+			return ret;
+		}
+		params->index = 0;
+	} else {
+		params->pwm_type = EC_PWM_TYPE_GENERIC;
+		params->index = index;
+	}
 
 	ret = cros_ec_cmd_xfer_status(ec, msg);
 	if (ret < 0)
@@ -133,7 +174,7 @@ static int cros_ec_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	 */
 	duty_cycle = state->enabled ? state->duty_cycle : 0;
 
-	ret = cros_ec_pwm_set_duty(ec_pwm->ec, pwm->hwpwm, duty_cycle);
+	ret = cros_ec_pwm_set_duty(ec_pwm, pwm->hwpwm, duty_cycle);
 	if (ret < 0)
 		return ret;
 
@@ -149,7 +190,7 @@ static void cros_ec_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 	struct cros_ec_pwm *channel = pwm_get_chip_data(pwm);
 	int ret;
 
-	ret = cros_ec_pwm_get_duty(ec_pwm->ec, pwm->hwpwm);
+	ret = cros_ec_pwm_get_duty(ec_pwm, pwm->hwpwm);
 	if (ret < 0) {
 		dev_err(chip->dev, "error getting initial duty: %d\n", ret);
 		return;
@@ -204,13 +245,13 @@ static const struct pwm_ops cros_ec_pwm_ops = {
  * of PWMs it supports directly, so we have to read the pwm duty cycle for
  * subsequent channels until we get an error.
  */
-static int cros_ec_num_pwms(struct cros_ec_device *ec)
+static int cros_ec_num_pwms(struct cros_ec_pwm_device *ec_pwm)
 {
 	int i, ret;
 
 	/* The index field is only 8 bits */
 	for (i = 0; i <= U8_MAX; i++) {
-		ret = cros_ec_pwm_get_duty(ec, i);
+		ret = cros_ec_pwm_get_duty(ec_pwm, i);
 		/*
 		 * We look for SUCCESS, INVALID_COMMAND, or INVALID_PARAM
 		 * responses; everything else is treated as an error.
@@ -236,6 +277,7 @@ static int cros_ec_pwm_probe(struct platform_device *pdev)
 {
 	struct cros_ec_device *ec = dev_get_drvdata(pdev->dev.parent);
 	struct device *dev = &pdev->dev;
+	struct device_node *np = pdev->dev.of_node;
 	struct cros_ec_pwm_device *ec_pwm;
 	struct pwm_chip *chip;
 	int ret;
@@ -251,17 +293,26 @@ static int cros_ec_pwm_probe(struct platform_device *pdev)
 	chip = &ec_pwm->chip;
 	ec_pwm->ec = ec;
 
+	if (of_device_is_compatible(np, "google,cros-ec-pwm-type"))
+		ec_pwm->use_pwm_type = true;
+
 	/* PWM chip */
 	chip->dev = dev;
 	chip->ops = &cros_ec_pwm_ops;
 	chip->of_xlate = cros_ec_pwm_xlate;
 	chip->of_pwm_n_cells = 1;
-	ret = cros_ec_num_pwms(ec);
-	if (ret < 0) {
-		dev_err(dev, "Couldn't find PWMs: %d\n", ret);
-		return ret;
+
+	if (ec_pwm->use_pwm_type) {
+		chip->npwm = CROS_EC_PWM_DT_COUNT;
+	} else {
+		ret = cros_ec_num_pwms(ec_pwm);
+		if (ret < 0) {
+			dev_err(dev, "Couldn't find PWMs: %d\n", ret);
+			return ret;
+		}
+		chip->npwm = ret;
 	}
-	chip->npwm = ret;
+
 	dev_dbg(dev, "Probed %u PWMs\n", chip->npwm);
 
 	ret = pwmchip_add(chip);
@@ -288,6 +339,7 @@ static int cros_ec_pwm_remove(struct platform_device *dev)
 #ifdef CONFIG_OF
 static const struct of_device_id cros_ec_pwm_of_match[] = {
 	{ .compatible = "google,cros-ec-pwm" },
+	{ .compatible = "google,cros-ec-pwm-type" },
 	{},
 };
 MODULE_DEVICE_TABLE(of, cros_ec_pwm_of_match);
-- 
2.36.0.rc2.479.g8af0fa9b8e-goog

