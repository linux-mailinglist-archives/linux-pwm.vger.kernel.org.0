Return-Path: <linux-pwm+bounces-6391-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF7CBADBE27
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Jun 2025 02:29:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9904918923F7
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Jun 2025 00:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D0821514F6;
	Tue, 17 Jun 2025 00:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="EQIauKK3";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="lVHZGDgH"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3AE1494DB;
	Tue, 17 Jun 2025 00:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750120162; cv=none; b=s/td0QvhkII8x4qnCHXp7zpuaDkv/JZjBIteQ6h+X9LtIOc3wMy0zu72oNzyS8bsirQHxJophUKZPEI0sNuM7W36A3PsoIymOwyi74y1tR6SXNQJf4Ipew9fNZyk/OV0r491mb++LxMgZhESKzq8bdiccusaGO+mo++4Qsi1t30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750120162; c=relaxed/simple;
	bh=C5md06ZL2tWFOaKDGxzb8Nun2AkGwKq2FRRlsrVsleI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cnDPl6pMYWgef8ZoG0KqdVTdVKNreq1+PT46OuO3LndDEOnSNqtV+GlzIVA+yQ4vopNMkguL1WLeNo8rc/LrU3KZYFsQaBNNCplbKqqFHbQuIVW0X1vskAW5/xqMnNFf6TBTDAfnGVJSCqIp8WSkJjKQFPjSzG6vG4DSEaHj/5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=EQIauKK3; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=lVHZGDgH; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4bLnmt13JDz9tR0;
	Tue, 17 Jun 2025 02:29:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1750120158;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZaOpor4mzIsWNtTmWEhHeTxzQ6iW07g71Hu+k4IMiyk=;
	b=EQIauKK3GzRp8uKwq9QxKiO3AQU0tvwylmfMLwt11HVCFZSDeAPRAq1/5GI/1cCfGAGT8W
	oSzkq8LYtJwPjIy4LUAYXQ4ZLoRMFT6ZlS0/XXTv8XSzGn4/yl/i0J1FDVNjEat8jXxYrG
	DkDZLnm2ztYe53TZ09z/dt7T5J3RLCwg4dr+58z3JSZrEsFXt+z9shtlFFCJ8Ay9y80jt2
	MSBl8XWf+PMaKWNbGkFntgkrMI5T4QIWGzjqZtytIw+EfQdMUyjJcAiXv+R2gXuZwkrTdX
	xMAZN5UCKTsZM8iXqrRUKoRbShVPIOgtq0XQgE9emEOH902WqDRHe/6gCtKs4Q==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1750120156;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZaOpor4mzIsWNtTmWEhHeTxzQ6iW07g71Hu+k4IMiyk=;
	b=lVHZGDgHeDXd6gELU64xaVOgbGxaGSfY1DWOOwWieDoouFow11qbx78MaQ0POUFsjB1eNA
	gaK4QMrAbc9iMgDTWKB18sYfaXnGz5t9tOqUHU9k8b9vaXibBMA5I/kl1bO9EOJvR9XOVP
	6InP5NcH2wq48E5713zi/hQPc2Rz3cEzZrnFrE+tFSLiVU2uwdmc0AQGJx0YIs3nVL6vJo
	HNjifcw7zxHGFwmBcI8IewiGIYtcdyDsDIPPyQjvJXn8yLxl8NksL/fRUHp5xLjtA0MKfb
	z6/QN1R4jlviNzbmRf6weiSnHBAjar4PH8zF+T3XZ6yCVqWQXBja2su7EXaFuw==
To: linux-pwm@vger.kernel.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH v2 3/3] pwm: argon-fan-hat: Add Argon40 Fan HAT support
Date: Tue, 17 Jun 2025 02:28:02 +0200
Message-ID: <20250617002852.606409-3-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250617002852.606409-1-marek.vasut+renesas@mailbox.org>
References: <20250617002852.606409-1-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: c3c5hjs6bmpfyq67an13xsecsadtjybw
X-MBO-RS-ID: 5cec56448e2d3af785c

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
---
 drivers/pwm/Kconfig             |   9 +++
 drivers/pwm/Makefile            |   1 +
 drivers/pwm/pwm-argon-fan-hat.c | 115 ++++++++++++++++++++++++++++++++
 3 files changed, 125 insertions(+)
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
index 000000000000..a26b58ee7f29
--- /dev/null
+++ b/drivers/pwm/pwm-argon-fan-hat.c
@@ -0,0 +1,115 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2025 Marek Vasut
+ *
+ * Limitations:
+ * - no support for offset/polarity
+ * - fixed duty cycle, period changes from 0Hz..120kHz
+ */
+
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/pwm.h>
+
+static int argon_fan_hat_round_waveform_tohw(struct pwm_chip *chip,
+					     struct pwm_device *pwm,
+					     const struct pwm_waveform *wf,
+					     void *_wfhw)
+{
+	u8 *wfhw = _wfhw;
+
+	*wfhw = DIV_ROUND_CLOSEST_ULL(wf->duty_length_ns * 100, wf->period_length_ns);
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
+	/* 1 step of this hardware is cca. 1200 Hz increase in frequency */
+	wf->period_length_ns = DIV64_U64_ROUND_UP(NSEC_PER_SEC, *wfhw * 1200);
+	wf->duty_length_ns = wf->period_length_ns / 10;
+	wf->duty_offset_ns = 0;
+
+	return 0;
+}
+
+static int argon_fan_hat_write_waveform(struct pwm_chip *chip,
+					struct pwm_device *pwm,
+					const void *_wfhw)
+{
+	struct i2c_client *i2c = pwmchip_get_drvdata(chip);
+	const u8 *wfhw = _wfhw;
+	u8 tx[2] = { 0x80, *wfhw };
+	struct i2c_msg msg = {
+		.addr = i2c->addr,
+		.len = 2,
+		.buf = tx,
+	};
+
+	return (i2c_transfer(i2c->adapter, &msg, 1) == 1) ? 0 : -EINVAL;
+}
+
+static const struct pwm_ops argon_fan_hat_pwm_ops = {
+	.sizeof_wfhw		= sizeof(u8),
+	.round_waveform_fromhw	= argon_fan_hat_round_waveform_fromhw,
+	.round_waveform_tohw	= argon_fan_hat_round_waveform_tohw,
+	.write_waveform		= argon_fan_hat_write_waveform,
+};
+
+static int argon_fan_hat_i2c_probe(struct i2c_client *i2c)
+{
+	struct pwm_chip *pc = devm_pwmchip_alloc(&i2c->dev, 1, 0);
+	int ret;
+
+	if (IS_ERR(pc))
+		return PTR_ERR(pc);
+
+	pc->ops = &argon_fan_hat_pwm_ops;
+	pwmchip_set_drvdata(pc, i2c);
+
+	ret = devm_pwmchip_add(&i2c->dev, pc);
+	if (ret)
+		return dev_err_probe(&i2c->dev, ret, "Could not add PWM chip\n");
+
+	return 0;
+}
+
+static void argon_fan_hat_i2c_shutdown(struct i2c_client *i2c)
+{
+	u8 tx[2] = { 0x80, 0x64 };
+	struct i2c_msg msg = {
+		.addr = i2c->addr,
+		.len = 2,
+		.buf = tx,
+	};
+
+	i2c_transfer(i2c->adapter, &msg, 1);
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


