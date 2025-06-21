Return-Path: <linux-pwm+bounces-6465-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8D20AE2AA9
	for <lists+linux-pwm@lfdr.de>; Sat, 21 Jun 2025 19:21:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CAD2189C213
	for <lists+linux-pwm@lfdr.de>; Sat, 21 Jun 2025 17:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1C44254B1B;
	Sat, 21 Jun 2025 17:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="vdIY08H5";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="q63Ujdk5"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E78E25393E;
	Sat, 21 Jun 2025 17:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750526490; cv=none; b=Ayq9lgruP4B4uTdDLCV5MuL/6/ZxTkw7XGffJPus1ay0RRm6nlXZyFyUuaQ439RTlqOl7FDPv5mGOSNFu4ON++ZYNYtvrhtTxC+h9n9qlYjfaer/SE3yrIBQzHIFAthxmwHcOykSXflMnpuQklOaLWjv6v38FTVFSt1Xma3d7GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750526490; c=relaxed/simple;
	bh=zxpohLn9mX8clveX9Pzii6+8IN6bFrPBcNR+2mZDB4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YDfE1RSCHRyW0xr4ZHcK5SD37pK26shpy/ht0lcAKmealT/zVkvCTjmZ2xFOZZEVVGOjmYoNl6Jx7ClzDOSJgOxAdzPC+qgQuNup3Yw+czGwIHmRidH2BqorDS08DNXl8pNi6SeyNV4l4rMCpp51i14IIlrsHvu6vGCv9VvvW1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=vdIY08H5; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=q63Ujdk5; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4bPh2v0KwHz9t7b;
	Sat, 21 Jun 2025 19:21:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1750526487;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8QwqPmZJK568Hu3+OFRpzAmjwFuzscBcD2Y5N4HhP2s=;
	b=vdIY08H5Pm1y9rfc6exDnt5G5WA2MXqVZ+tOQzxG8mi/Jo/JwAw20CFovqqVlLr6g9qB7i
	twnjW/9Oe+GhJ+AHIdxhsFmNM6VgkuxDbSHQ1cM0ta1c7wIjvJhtRB7JG26889jMtfBcEr
	c+yOzNdvQtYuJQBu4gUeEBx3x4pnJotYT3WO/NA/ZtSIMhTQOhrO8dSoLxnCaszKDzbD18
	hMzmJseiedKSh13fXz8o97E3pIwkPhW0Z3pSzrnaL7havvL1mB2M3tXjgeUjdDzxG63H4Y
	WChTMJOTYddzAxw68Cfbi8jdoM1xgQS19c9QQG1r1pHD5NDKYd3PDSaeerDf3g==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1750526484;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8QwqPmZJK568Hu3+OFRpzAmjwFuzscBcD2Y5N4HhP2s=;
	b=q63Ujdk5KBWerMLEsr99zJSsvMgktPgd187n/MXva/cd0/XNL7QfHXMPKFvhe6QlwSXvbw
	gmLqYdIEngBpKItaiPjsP2ZJz4KKX0p0Fv2qCuGBj/9X0pezP9iPDBgJLx7Tyu9mbDpU2m
	PALHW7PLt19EtOYPrGHeQie34XoIsWVsGHduVyGAcxCPeILmAV5+pA16f5BQ7waQpVK3sd
	ucCpe3sS9EBpNYwhOUlyFqirFX3MvhZDzP5Oe6ztRXEEwfoCZ1h7t0PdQBxBVdQgENfQvo
	0EsChWVSpCWQY635e6ydp2P5gnLjk8PkzE+BgUsSe9bsbLbmFZQz0HMety33gw==
To: linux-pwm@vger.kernel.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH v4 3/3] pwm: argon-fan-hat: Add Argon40 Fan HAT support
Date: Sat, 21 Jun 2025 19:19:56 +0200
Message-ID: <20250621172056.160855-3-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250621172056.160855-1-marek.vasut+renesas@mailbox.org>
References: <20250621172056.160855-1-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: cmec9hsx618397acss9i7zkrawu4zqfr
X-MBO-RS-ID: 3179eb33102f8616f75
X-Rspamd-Queue-Id: 4bPh2v0KwHz9t7b

Add trivial PWM driver for Argon40 Fan HAT, which is a RaspberryPi
blower fan hat which can be controlled over I2C. Model this device
as a PWM, so the pwm-fan can be attached to it and handle thermal
zones and RPM management in a generic manner.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: "Uwe Kleine-König" <ukleinek@kernel.org>
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org
Cc: linux-pwm@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org
---
V2: - Switch to waveform ops
    - Add shutdown hook to force the fan to maximum RPM on shutdown
      instead of stopping it, to be on the safe side
V3: - Find the 30 kHz fixed period PWM, use that
    - Add comments
    - Consolidate argon_fan_hat_write()
V4: - Add if (wf->duty_length_ns > ARGON40_FAN_HAT_PERIOD_NS) overflow check
    - Use i2c_smbus_write_byte_data()
    - Rename struct pwm_chip *pc to struct pwm_chip *chip
    - Remove tab alignment from argon_fan_hat_pwm_ops {}
    - Define ARGON40_FAN_HAT_REG_DUTY_CYCLE macro
---
 drivers/pwm/Kconfig             |   9 +++
 drivers/pwm/Makefile            |   1 +
 drivers/pwm/pwm-argon-fan-hat.c | 120 ++++++++++++++++++++++++++++++++
 3 files changed, 130 insertions(+)
 create mode 100644 drivers/pwm/pwm-argon-fan-hat.c

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 6e113f8b4baf..3ef1757502eb 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -66,6 +66,15 @@ config PWM_APPLE
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-apple.
 
+config PWM_ARGON_FAN_HAT
+	tristate "Argon40 Fan HAT support"
+	depends on I2C && OF
+	help
+	  Generic PWM framework driver for Argon40 Fan HAT.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called pwm-argon-fan-hat.
+
 config PWM_ATMEL
 	tristate "Atmel PWM support"
 	depends on ARCH_AT91 || COMPILE_TEST
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index 96160f4257fc..ff4f47e5fb7a 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -3,6 +3,7 @@ obj-$(CONFIG_PWM)		+= core.o
 obj-$(CONFIG_PWM_AB8500)	+= pwm-ab8500.o
 obj-$(CONFIG_PWM_ADP5585)	+= pwm-adp5585.o
 obj-$(CONFIG_PWM_APPLE)		+= pwm-apple.o
+obj-$(CONFIG_PWM_ARGON_FAN_HAT)	+= pwm-argon-fan-hat.o
 obj-$(CONFIG_PWM_ATMEL)		+= pwm-atmel.o
 obj-$(CONFIG_PWM_ATMEL_HLCDC_PWM)	+= pwm-atmel-hlcdc.o
 obj-$(CONFIG_PWM_ATMEL_TCB)	+= pwm-atmel-tcb.o
diff --git a/drivers/pwm/pwm-argon-fan-hat.c b/drivers/pwm/pwm-argon-fan-hat.c
new file mode 100644
index 000000000000..1bf07c769497
--- /dev/null
+++ b/drivers/pwm/pwm-argon-fan-hat.c
@@ -0,0 +1,120 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2025 Marek Vasut
+ *
+ * Limitations:
+ * - no support for offset/polarity
+ * - fixed 30 kHz period
+ *
+ * Argon Fan HAT https://argon40.com/products/argon-fan-hat
+ */
+
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/pwm.h>
+
+#define ARGON40_FAN_HAT_PERIOD_NS	33333	/* ~30 kHz */
+
+#define ARGON40_FAN_HAT_REG_DUTY_CYCLE	0x80
+
+static int argon_fan_hat_round_waveform_tohw(struct pwm_chip *chip,
+					     struct pwm_device *pwm,
+					     const struct pwm_waveform *wf,
+					     void *_wfhw)
+{
+	u8 *wfhw = _wfhw;
+
+	if (wf->duty_length_ns > ARGON40_FAN_HAT_PERIOD_NS)
+		*wfhw = 100;
+	else
+		*wfhw = mul_u64_u64_div_u64(wf->duty_length_ns, 100, ARGON40_FAN_HAT_PERIOD_NS);
+
+	return 0;
+}
+
+static int argon_fan_hat_round_waveform_fromhw(struct pwm_chip *chip,
+					       struct pwm_device *pwm,
+					       const void *_wfhw,
+					       struct pwm_waveform *wf)
+{
+	const u8 *wfhw = _wfhw;
+
+	wf->period_length_ns = ARGON40_FAN_HAT_PERIOD_NS;
+	wf->duty_length_ns = DIV64_U64_ROUND_UP(wf->period_length_ns * *wfhw, 100);
+	wf->duty_offset_ns = 0;
+
+	return 0;
+}
+
+static int argon_fan_hat_write(struct i2c_client *i2c, const u8 wfhw)
+{
+	return i2c_smbus_write_byte_data(i2c, ARGON40_FAN_HAT_REG_DUTY_CYCLE, wfhw);
+}
+
+static int argon_fan_hat_write_waveform(struct pwm_chip *chip,
+					struct pwm_device *pwm,
+					const void *_wfhw)
+{
+	struct i2c_client *i2c = pwmchip_get_drvdata(chip);
+	const u8 *wfhw = _wfhw;
+
+	return argon_fan_hat_write(i2c, *wfhw);
+}
+
+static const struct pwm_ops argon_fan_hat_pwm_ops = {
+	.sizeof_wfhw = sizeof(u8),
+	.round_waveform_fromhw = argon_fan_hat_round_waveform_fromhw,
+	.round_waveform_tohw = argon_fan_hat_round_waveform_tohw,
+	.write_waveform = argon_fan_hat_write_waveform,
+	/*
+	 * The controller does not provide any way to read info back,
+	 * reading from the controller stops the fan, therefore there
+	 * is no .read_waveform here.
+	 */
+};
+
+static int argon_fan_hat_i2c_probe(struct i2c_client *i2c)
+{
+	struct pwm_chip *chip = devm_pwmchip_alloc(&i2c->dev, 1, 0);
+	int ret;
+
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+
+	chip->ops = &argon_fan_hat_pwm_ops;
+	pwmchip_set_drvdata(chip, i2c);
+
+	ret = devm_pwmchip_add(&i2c->dev, chip);
+	if (ret)
+		return dev_err_probe(&i2c->dev, ret, "Could not add PWM chip\n");
+
+	return 0;
+}
+
+static void argon_fan_hat_i2c_shutdown(struct i2c_client *i2c)
+{
+	argon_fan_hat_write(i2c, 100);
+}
+
+static const struct of_device_id argon_fan_hat_dt_ids[] = {
+	{ .compatible = "argon40,fan-hat" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, argon_fan_hat_dt_ids);
+
+static struct i2c_driver argon_fan_hat_driver = {
+	.driver = {
+		.name = "argon-fan-hat",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
+		.of_match_table = argon_fan_hat_dt_ids,
+	},
+	.probe = argon_fan_hat_i2c_probe,
+	.shutdown = argon_fan_hat_i2c_shutdown,
+};
+
+module_i2c_driver(argon_fan_hat_driver);
+
+MODULE_AUTHOR("Marek Vasut <marek.vasut+renesas@mailbox.org>");
+MODULE_DESCRIPTION("Argon40 Fan HAT");
+MODULE_LICENSE("GPL");
-- 
2.47.2


