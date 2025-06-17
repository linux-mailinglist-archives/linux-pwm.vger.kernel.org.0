Return-Path: <linux-pwm+bounces-6399-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41214ADC617
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Jun 2025 11:21:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D05E1899372
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Jun 2025 09:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD73B293474;
	Tue, 17 Jun 2025 09:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="gihDhi5a";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="XHACR0wt"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2DC28FFFB;
	Tue, 17 Jun 2025 09:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750152061; cv=none; b=o2geUWp0gtBKUuLZhli6hD4evXswl0gYTqFVFxqaOZAgfOC7a9AWu+KxRHevvD1ZyTV6T40ItMrHrbZOqr8UjdV+2iOzpDUGyHHH/wb/nHLNHsg5+dtJglgAne7OUF8Eemj2KOoOBdOFTzGjHsRIcRl8Ndzd5tx182qeEitiQMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750152061; c=relaxed/simple;
	bh=RZ49EYiuEBe//gJA7l+urmw3mBTIE5qPYjYIiRC5WbA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RA86KDYRspwZB4PYjhMD8IWgeNCyhy/njtwcgnOYvHvDh8F7nAXpX3IPcbXbmZW1AQeP7K7SOdqUlNapCT+D8fnJCBrCq13y3T+6vBewhN6iyk1a8JWQKHpmiGd+sOl0CGwLGD/M6fvL9AxETzvj40QjGYmS6iIfGZ7MUDDtxY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=gihDhi5a; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=XHACR0wt; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4bM1ZK67PQz9sTb;
	Tue, 17 Jun 2025 11:20:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1750152057;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mw92VLyJgn+5px9AirmOrbYFjpqlQH9nBGpVDrOJeto=;
	b=gihDhi5aV0VF6TF04zkAnbAQeKWrmWA47PbYTpBxn+5DwLq2XLPPzn1TjbZvCexyeeVk2Q
	/Ihems18df8qThjehW0BrCzqAnvvsNT1jHeVilLA4GdXXrFMtWBBehCsgWShzUrX+zzUaB
	zQ140IVCmRHQROqCxcHsU7mQlqYQXXmDqE6XhpCVb2D6BEdKlVNWPJ1UKMYMGfls4P64kR
	I81qsUY3arjwFWCYN7UveV77ZpqUQg/51bdlFGpfiLET/GI2f2ZlWqomBhhb0OU/S98XpG
	pcYRXkFAKa4zdLlLVKinPF13l8Ozi4VVj2cOndEo8IxWxcSSx+bKdh+945pTAw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1750152055;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mw92VLyJgn+5px9AirmOrbYFjpqlQH9nBGpVDrOJeto=;
	b=XHACR0wtXy9oeAn661cIP5sRixppWVsDP8wI8nGNaCBpSuDIctacxhtuxV840m4jaVm+bm
	PzTEEuQmGt79Unas/ZEELr6hP8IPMdQwA7E7lHuuZR+42tVLwVcI/xBuNAV5u9fHwMOzT+
	R1yHhF7wvHdvQR6z0KqKbhu3fixMosquDuFsaDsBWa+9sZsxYmLYIKIWIlkwdBDN2i1ZMz
	kG8eQIlRwooUz5CAGeyS6fCUKRo9/iUx1ac+oaYENk4pqpTGivnCQk3Cf27V/xVapBU0ni
	X58Ew84Jl9QGOqwYLIDox1NxfoWAmIso7A2PBcNbCRwUEn0e56VeEMnHhCvUKw==
To: linux-pwm@vger.kernel.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH v3 3/3] pwm: argon-fan-hat: Add Argon40 Fan HAT support
Date: Tue, 17 Jun 2025 11:19:36 +0200
Message-ID: <20250617092037.37229-3-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250617092037.37229-1-marek.vasut+renesas@mailbox.org>
References: <20250617092037.37229-1-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: ocg4oe9th5skxwo8ws16wbo9ngga9xo8
X-MBO-RS-ID: 241d3e7cbe834ea492d
X-Rspamd-Queue-Id: 4bM1ZK67PQz9sTb

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
---
 drivers/pwm/Kconfig             |   9 +++
 drivers/pwm/Makefile            |   1 +
 drivers/pwm/pwm-argon-fan-hat.c | 122 ++++++++++++++++++++++++++++++++
 3 files changed, 132 insertions(+)
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
index 000000000000..58b94ad4d9bc
--- /dev/null
+++ b/drivers/pwm/pwm-argon-fan-hat.c
@@ -0,0 +1,122 @@
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
+	wf->period_length_ns = ARGON40_FAN_HAT_PERIOD_NS;
+	wf->duty_length_ns = DIV64_U64_ROUND_UP(wf->period_length_ns * *wfhw, 100);
+	wf->duty_offset_ns = 0;
+
+	return 0;
+}
+
+static int argon_fan_hat_write(struct i2c_client *i2c, const u8 wfhw)
+{
+	u8 tx[2] = { 0x80, wfhw };
+	struct i2c_msg msg = {
+		.addr = i2c->addr,
+		.len = 2,
+		.buf = tx,
+	};
+
+	return (i2c_transfer(i2c->adapter, &msg, 1) == 1) ? 0 : -EINVAL;
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
+	.sizeof_wfhw		= sizeof(u8),
+	.round_waveform_fromhw	= argon_fan_hat_round_waveform_fromhw,
+	.round_waveform_tohw	= argon_fan_hat_round_waveform_tohw,
+	.write_waveform		= argon_fan_hat_write_waveform,
+	/*
+	 * The controller does not provide any way to read info back,
+	 * reading from the controller stops the fan, therefore there
+	 * is no .read_waveform here.
+	 */
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


