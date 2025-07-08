Return-Path: <linux-pwm+bounces-6771-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B06AFD05D
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Jul 2025 18:14:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 881231884CA0
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Jul 2025 16:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B58C2E1C7E;
	Tue,  8 Jul 2025 16:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ok7LX6ua"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF4722FDE8;
	Tue,  8 Jul 2025 16:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751991188; cv=none; b=M4MdJK6aDGr3orqd4hD6dGEuSI5FZDWwZbo11IfcYDj7MM202TK7ERDfCTII0/CpwdKtOPsjJc0g6V/N4n31rRq42E98BErXVhzek1Nqmx70y2qDr1kIuqAK9Unp+A8KfUjqj2F+68i/b9Aews2FgCdPtJyXMo4W1GfkyYvio4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751991188; c=relaxed/simple;
	bh=C82IB3MMoaz8h7zQFIOrUvLR5loJhELSBCxxCjOYf1c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p5puW1lfPEHyv2lUWg/Z/AMXQ9hTDPZDmf08hYf0EpVIyi3NC3htYGPOShIJkJrNinJ3QwnFj6Y4LvGyRBI+eAx+qARJbfLLHw26J/OdecZbRKqQZtdlDp+ArTDyR2fMiERle+uPOwq1bHOTEvqZMyN4K4pzClkT+m/Z4PlLFvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ok7LX6ua; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 31C76C4CEF6;
	Tue,  8 Jul 2025 16:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751991188;
	bh=C82IB3MMoaz8h7zQFIOrUvLR5loJhELSBCxxCjOYf1c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Ok7LX6uaMQgM1RF+IHiTHXfMgK0/GHl5RRJU49cmh/7gDUpb9nZ3mUgYW9VnZKyVX
	 CG8hrn4ixDxDO2wsMQFoCdyFY4e/A/uGDOj7Ajw2yVWqgnysqH20wXqqaWDHnImSaq
	 YKAURYwsCPAdllNc2PoJ/obHiIo1AbC91muu/tennQPeCJ0lc2iyNuNm9h+91mBdkI
	 trOvJKNoSFaYQQBhyjkNYUF7BSrgJsI7GbFneoLfw+ioBS/I0VGXmA0CpNOz2o2dxn
	 jywYHTfXWPT/COg/40IQ+2ahfzV597Qulptw/fy1D/aq+X9TFupwo1dfUn9Otc8+l3
	 83RO/+yH/b3QQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 227B1C83F09;
	Tue,  8 Jul 2025 16:13:08 +0000 (UTC)
From: Dimitri Fedrau via B4 Relay <devnull+dimitri.fedrau.liebherr.com@kernel.org>
Date: Tue, 08 Jul 2025 18:13:03 +0200
Subject: [PATCH v4 1/2] pwm: mc33xs2410: add hwmon support
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250708-mc33xs2410-hwmon-v4-1-95b9e3ea5f5c@liebherr.com>
References: <20250708-mc33xs2410-hwmon-v4-0-95b9e3ea5f5c@liebherr.com>
In-Reply-To: <20250708-mc33xs2410-hwmon-v4-0-95b9e3ea5f5c@liebherr.com>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-hwmon@vger.kernel.org, Dimitri Fedrau <dimitri.fedrau@liebherr.com>, 
 Dimitri Fedrau <dima.fedrau@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751991187; l=4821;
 i=dimitri.fedrau@liebherr.com; s=20241202; h=from:subject:message-id;
 bh=qUeIPQxAnEuF2jKIbHlawUN2Esf14Kuip2Av+HM28AE=;
 b=MAE1xJLv80KoXUG0E3hmAt8xy2tNB7u4QUT1fh5ElufY3ZbJ0ksAiVxSxMnxNeiaTKkYgKODy
 6GgbmAJynfyBH86NEJWcYU+lsv2tsDsytyjasY6LoUh1xXuC9H3GX3q
X-Developer-Key: i=dimitri.fedrau@liebherr.com; a=ed25519;
 pk=rT653x09JSQvotxIqQl4/XiI4AOiBZrdOGvxDUbb5m8=
X-Endpoint-Received: by B4 Relay for dimitri.fedrau@liebherr.com/20241202
 with auth_id=290
X-Original-From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
Reply-To: dimitri.fedrau@liebherr.com

From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>

Support for hwmon is provided by a separate driver residing in hwmon
subsystem which is implemented as auxiliary device. Add handling of this
device.

Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
---
 drivers/pwm/Kconfig          |  1 +
 drivers/pwm/pwm-mc33xs2410.c | 64 ++++++++++++++++++++++++++++++++++++++++++--
 include/linux/mc33xs2410.h   | 14 ++++++++++
 3 files changed, 77 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 6e113f8b4baf293284f017bc22fbc162633bb2fc..5b20230c5ccd99137efcd968efe603b8c8e2253f 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -427,6 +427,7 @@ config PWM_MC33XS2410
 	tristate "MC33XS2410 PWM support"
 	depends on OF
 	depends on SPI
+	select AUXILIARY_BUS
 	help
 	  NXP MC33XS2410 high-side switch driver. The MC33XS2410 is a four
 	  channel high-side switch. The device is operational from 3.0 V
diff --git a/drivers/pwm/pwm-mc33xs2410.c b/drivers/pwm/pwm-mc33xs2410.c
index a1ac3445ccdb4709d92e0075d424a8abc1416eee..e70ed90bfdac77f5c777f0ba66d670331a515d12 100644
--- a/drivers/pwm/pwm-mc33xs2410.c
+++ b/drivers/pwm/pwm-mc33xs2410.c
@@ -18,10 +18,12 @@
  *   rather something in between.
  */
 
+#include <linux/auxiliary_bus.h>
 #include <linux/bitfield.h>
 #include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/math64.h>
+#include <linux/mc33xs2410.h>
 #include <linux/minmax.h>
 #include <linux/module.h>
 #include <linux/of.h>
@@ -120,12 +122,19 @@ static int mc33xs2410_read_reg(struct spi_device *spi, u8 reg, u16 *val, u8 flag
 	return mc33xs2410_read_regs(spi, &reg, flag, val, 1);
 }
 
-static int mc33xs2410_read_reg_ctrl(struct spi_device *spi, u8 reg, u16 *val)
+int mc33xs2410_read_reg_ctrl(struct spi_device *spi, u8 reg, u16 *val)
 {
 	return mc33xs2410_read_reg(spi, reg, val, MC33XS2410_FRAME_IN_DATA_RD);
 }
+EXPORT_SYMBOL_NS_GPL(mc33xs2410_read_reg_ctrl, "PWM_MC33XS2410");
 
-static int mc33xs2410_modify_reg(struct spi_device *spi, u8 reg, u8 mask, u8 val)
+int mc33xs2410_read_reg_diag(struct spi_device *spi, u8 reg, u16 *val)
+{
+	return mc33xs2410_read_reg(spi, reg, val, 0);
+}
+EXPORT_SYMBOL_NS_GPL(mc33xs2410_read_reg_diag, "PWM_MC33XS2410");
+
+int mc33xs2410_modify_reg(struct spi_device *spi, u8 reg, u8 mask, u8 val)
 {
 	u16 tmp;
 	int ret;
@@ -139,6 +148,7 @@ static int mc33xs2410_modify_reg(struct spi_device *spi, u8 reg, u8 mask, u8 val
 
 	return mc33xs2410_write_reg(spi, reg, tmp);
 }
+EXPORT_SYMBOL_NS_GPL(mc33xs2410_modify_reg, "PWM_MC33XS2410");
 
 static u8 mc33xs2410_pwm_get_freq(u64 period)
 {
@@ -297,6 +307,52 @@ static const struct pwm_ops mc33xs2410_pwm_ops = {
 	.get_state = mc33xs2410_pwm_get_state,
 };
 
+static void mc33xs2410_adev_release(struct device *dev)
+{
+	struct auxiliary_device *adev = to_auxiliary_dev(dev);
+
+	kfree(adev);
+}
+
+static void mc33xs2410_unregister_adev(void *_adev)
+{
+	struct auxiliary_device *adev = _adev;
+
+	auxiliary_device_delete(adev);
+	auxiliary_device_uninit(adev);
+}
+
+static int mc33xs2410_hwmon_register(struct device *dev)
+{
+	struct auxiliary_device *adev;
+	int ret;
+
+	adev = kzalloc(sizeof(*adev), GFP_KERNEL);
+	if (!adev)
+		return -ENOMEM;
+
+	adev->name = "hwmon";
+	adev->dev.parent = dev;
+	adev->dev.release = mc33xs2410_adev_release;
+	adev->id = 0;
+
+	ret = auxiliary_device_init(adev);
+	if (ret)
+		return ret;
+
+	ret = auxiliary_device_add(adev);
+	if (ret) {
+		auxiliary_device_uninit(adev);
+		return ret;
+	}
+
+	ret = devm_add_action_or_reset(dev, mc33xs2410_unregister_adev, adev);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
 static int mc33xs2410_reset(struct device *dev)
 {
 	struct gpio_desc *reset_gpio;
@@ -361,6 +417,10 @@ static int mc33xs2410_probe(struct spi_device *spi)
 	if (ret < 0)
 		return dev_err_probe(dev, ret, "Failed to add pwm chip\n");
 
+	ret = mc33xs2410_hwmon_register(dev);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Failed to register hwmon device\n");
+
 	return 0;
 }
 
diff --git a/include/linux/mc33xs2410.h b/include/linux/mc33xs2410.h
new file mode 100644
index 0000000000000000000000000000000000000000..15a0b0b595fe00a369cee45f2d30b2d912b612bb
--- /dev/null
+++ b/include/linux/mc33xs2410.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2024 Liebherr-Electronics and Drives GmbH
+ */
+#ifndef _MC33XS2410_H
+#define _MC33XS2410_H
+
+#include <linux/spi/spi.h>
+
+int mc33xs2410_read_reg_ctrl(struct spi_device *spi, u8 reg, u16 *val);
+int mc33xs2410_read_reg_diag(struct spi_device *spi, u8 reg, u16 *val);
+int mc33xs2410_modify_reg(struct spi_device *spi, u8 reg, u8 mask, u8 val);
+
+#endif /* _MC33XS2410_H */

-- 
2.39.5



