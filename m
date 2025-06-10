Return-Path: <linux-pwm+bounces-6286-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D260AD45AB
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Jun 2025 00:09:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B217189B2EF
	for <lists+linux-pwm@lfdr.de>; Tue, 10 Jun 2025 22:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9323F286D55;
	Tue, 10 Jun 2025 22:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="KoqevNlO";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="c6hz/Sss"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B3D244693;
	Tue, 10 Jun 2025 22:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749593334; cv=none; b=g1DMsLm1QXhqH4Vn7oX/IcCl5HfgzPLhbzuy9Czh7VdSgjl0JIEbzUOWF2CqU/tnw/RWyzWmjY9tmDt5b76Pb9RPzPX2bhgVWSDPSyqr9bvhvX9M4W+vincZVeFr8kFSmPTMN6dxZdu/avHCp4DM46ssut5V3ptUBiT1uNuE9Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749593334; c=relaxed/simple;
	bh=8eVlCHoaiF/DhJcSD2elLNPiXPvcBRtisOKN2XR/bfA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MwyYTpQ3PEW2sDXidNtQasb3kuL6kMaNbm4AjP2T0QwEFFebzvdO9QVVbip73mg9Q0Pl/LYLbVaiCXe+e81WE5jtFulTYZGoVw9O+f184SJSLk3FsacLtK039fggrGE6m2TbbR0J3OO+naYqxMaN/Mp5AMb1qA+IlEgWiLrKhPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=KoqevNlO; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=c6hz/Sss; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4bH2xZ6bRhz9sn1;
	Wed, 11 Jun 2025 00:08:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1749593330;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2D1s7jkP0Q+KaM74g8c6VRgHuKnPUmYNAE+BEyvEMfc=;
	b=KoqevNlONOHOeZdbNZ7Li2oYjLH53RsEIWBL4ZEkdkCDKU49/Zhpkt/bYL/i5Br021DE0U
	A2vtSsLOj3singaRcq6o1418G+ofwYfipfqUJZZbAdQ01awS35+wjUfiwD5fLBnZYgs4bJ
	4a3tLUeiczSMmlvqrIPVudgUgGGPAhphn34cqUkX6SNa61VtwfxZRTniCmgsJaPRHKWEhx
	tk28CZ6D5P6QgbBQVc19TnKsGIKQrITTZSfVDejFN7rGTs3Ydw5E8Spfp68WPzzsW/lrV2
	4KxWRiAw+H2vnlOT0E45cj1q8akdHiJ+2LHaLKLp3dd+3mr5Tf3Em6R36BQSuw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1749593329;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2D1s7jkP0Q+KaM74g8c6VRgHuKnPUmYNAE+BEyvEMfc=;
	b=c6hz/SsseDaUTUHA7IgUSXJBWFQXi7hVLerZT4A2O5B78sQJXISXbnBDOHX9hptoq3pLC+
	yKuTJnmytF/kmY5Lcklj0ImRvwXJpcF9gZ+QrpnRAmoJSBOl8HDBKc3mOP9Pn2b9lqkkkf
	KWPbSTJ+hDYuTRhGKqDnL0jgN6yMM+YebwFER8tJJAaWq730NAPCJLATY0D3tpTn63PyYx
	AfFg5qTJVAeCSaGbhqmAnRHLx8AQ4H1dgHXkRhENY7yl0kJPeK6pSgNmAPCEkK2z1D4N4s
	5qCivcXqN/SNcBRlFdRuSVE2We1l62qlxKPjcViZoCdHrQCZpaxrIi9FVyfKtA==
To: linux-pwm@vger.kernel.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH 3/3] pwm: argon-fan-hat: Add Argon40 Fan HAT support
Date: Wed, 11 Jun 2025 00:07:27 +0200
Message-ID: <20250610220814.167318-3-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250610220814.167318-1-marek.vasut+renesas@mailbox.org>
References: <20250610220814.167318-1-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: ca14d921f7c2e9aa8e2
X-MBO-RS-META: oj67q5689d5bc4y67watt6anfw59699s
X-Rspamd-Queue-Id: 4bH2xZ6bRhz9sn1

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
 drivers/pwm/Kconfig             |  9 +++++
 drivers/pwm/Makefile            |  1 +
 drivers/pwm/pwm-argon-fan-hat.c | 64 +++++++++++++++++++++++++++++++++
 3 files changed, 74 insertions(+)
 create mode 100644 drivers/pwm/pwm-argon-fan-hat.c

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index d9bcd1e8413e..02f1a52ea29e 100644
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
index 000000000000..3d04abdbd349
--- /dev/null
+++ b/drivers/pwm/pwm-argon-fan-hat.c
@@ -0,0 +1,64 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2025 Marek Vasut
+ */
+
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/pwm.h>
+
+static int argon_fan_hat_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+				   const struct pwm_state *state)
+{
+	struct i2c_client *i2c = pwmchip_get_drvdata(chip);
+	u8 tx[2] = { 0x80, state->enabled ? pwm_get_relative_duty_cycle(state, 100) : 0 };
+	struct i2c_msg msg = {
+		.addr = i2c->addr,
+		.len = 2,
+		.buf = tx,
+	};
+
+	if (state->polarity != PWM_POLARITY_NORMAL)
+		return -EINVAL;
+
+	return (i2c_transfer(i2c->adapter, &msg, 1) == 1) ? 0 : -EINVAL;
+}
+
+static const struct pwm_ops argon_fan_hat_pwm_ops = {
+	.apply = argon_fan_hat_pwm_apply,
+};
+
+static int argon_fan_hat_i2c_probe(struct i2c_client *i2c)
+{
+	struct pwm_chip *pc = devm_pwmchip_alloc(&i2c->dev, 1, 0);
+
+	if (IS_ERR(pc))
+		return PTR_ERR(pc);
+
+	pc->ops = &argon_fan_hat_pwm_ops;
+	pwmchip_set_drvdata(pc, i2c);
+
+	return devm_pwmchip_add(&i2c->dev, pc);
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


