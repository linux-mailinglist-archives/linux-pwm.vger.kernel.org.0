Return-Path: <linux-pwm+bounces-6572-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D7BFAED192
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Jun 2025 00:08:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A142416F4C2
	for <lists+linux-pwm@lfdr.de>; Sun, 29 Jun 2025 22:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4BFF23E352;
	Sun, 29 Jun 2025 22:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Lt0xrerH";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="v84DgpGT"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087391DD0EF;
	Sun, 29 Jun 2025 22:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751234901; cv=none; b=iwph6CFXzQM66dUTSFMGtkydNmvDCLhPJF5K/yLcvJsiBaFUWYn9lVpVAXQUw8L490XEYRn9onst1JLGjfzsbpeVcMNqgMGd0jT+XWIzxt6Mf/MiPL6dwS/w770GAA9ouajXDcUpW0pCfujjx/+Iegi4IVhcNlHMjssD/q9ovvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751234901; c=relaxed/simple;
	bh=0JOjYfKAzVruBnBuqHn8SeK7Bb8gtnPA6TWVf7BcE1g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fjJN2kYJYZoDAJpe7SZRLWOXZD6+RQ0csqw/GoVF4579nP6l3nxK9JJpqHU/Qai76JHi+KswgalVRigHPu8N7p6/06xXR2qvLeCOY2XaqmJbVNvgiIlFd5+P43yWISSr5nDDLpQhlqnLCXRrQ1iqUx7ZENwKAgGjSpDUM3ttD2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=Lt0xrerH; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=v84DgpGT; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4bVk2908RVz9srf;
	Mon, 30 Jun 2025 00:08:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1751234897;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VCezvZH57woMKE+MUjaf7KpEpF9KPuEYDFUd6+xgS9w=;
	b=Lt0xrerHclL4BIg25429gxmCXMktK7vKmcBn1FwDNiyZIn4bjsdVdIDlmfEyd6Zji9MFwE
	ii2rL2LHODYhTwVYGMh8ED1V4+ZF+Sr0N4yTzE69fQG8Rgxq8pVZri0v29ImSt9VOWsG6J
	4BrUlOR3NCA03FJR76q+3l9BodxzfdNit8HUuqZ29YpnWom1/goNUHKnkh1vy0JgR+Bkgc
	pv+eWwIaYl0jJmb3v92/UFJ3Sot591VVpB3GK5P5WUMLgDJBaWS4VoHm17vurSx6CZywoO
	b/5/ZleP7ye1/0dzfvP8Ij+E3UXc3vH35Sqw23ApXEbR4hZWvSScB3+Bw1ey7Q==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1751234894;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VCezvZH57woMKE+MUjaf7KpEpF9KPuEYDFUd6+xgS9w=;
	b=v84DgpGT6mD0585yJI7xOUGUzKi6pFVtp6U5Fxvd/lYlMqoNF5ZcnIW1SWWY8ABMPeKsl9
	4EVlYtnBW2V+X9mO9GCN0bw0chnD+Sv0qms78sSDuMO+MBpnTua/ijMVI3OLV2RFXTsK2X
	s+Z+OTy6UYDCmjeXy1tsvZSBZz3yqJZNZEK9nsxMW1cU7oYsmPCyZQkVMDb0u/KoS488g5
	a5d3tMnZicZHCsDQr449PS2BUJxCN9s3PfbWSW9SJGRwVzIG7q0JsFVFmsEbQhDSMegyzZ
	YlrgFkVL0CMl7gSekgxobbbUetVN+7RnHnKQfwbusKhesNG/DPPZwavfuYkIag==
To: linux-pwm@vger.kernel.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH v5 3/3] pwm: argon-fan-hat: Add Argon40 Fan HAT support
Date: Mon, 30 Jun 2025 00:07:20 +0200
Message-ID: <20250629220757.936212-3-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250629220757.936212-1-marek.vasut+renesas@mailbox.org>
References: <20250629220757.936212-1-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: hi3dcoo6fxyc143nwzuqrb569d6kbf3b
X-MBO-RS-ID: 5194294e4403238fda2

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
V5: - Undo "Add shutdown hook" from V2
---
 drivers/pwm/Kconfig             |   9 +++
 drivers/pwm/Makefile            |   1 +
 drivers/pwm/pwm-argon-fan-hat.c | 109 ++++++++++++++++++++++++++++++++
 3 files changed, 119 insertions(+)
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
index 000000000000..2c59bd142d40
--- /dev/null
+++ b/drivers/pwm/pwm-argon-fan-hat.c
@@ -0,0 +1,109 @@
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
+static int argon_fan_hat_write_waveform(struct pwm_chip *chip,
+					struct pwm_device *pwm,
+					const void *_wfhw)
+{
+	struct i2c_client *i2c = pwmchip_get_drvdata(chip);
+	const u8 *wfhw = _wfhw;
+
+	return i2c_smbus_write_byte_data(i2c, ARGON40_FAN_HAT_REG_DUTY_CYCLE, *wfhw);
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
+};
+
+module_i2c_driver(argon_fan_hat_driver);
+
+MODULE_AUTHOR("Marek Vasut <marek.vasut+renesas@mailbox.org>");
+MODULE_DESCRIPTION("Argon40 Fan HAT");
+MODULE_LICENSE("GPL");
-- 
2.47.2


