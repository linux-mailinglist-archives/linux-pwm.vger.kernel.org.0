Return-Path: <linux-pwm+bounces-6872-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 158AFB0F95C
	for <lists+linux-pwm@lfdr.de>; Wed, 23 Jul 2025 19:39:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 751923B238E
	for <lists+linux-pwm@lfdr.de>; Wed, 23 Jul 2025 17:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0482D220F23;
	Wed, 23 Jul 2025 17:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lnSyv37g"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6AD121D5AA;
	Wed, 23 Jul 2025 17:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753292106; cv=none; b=fI85n2Gv/rmIdiKutbtSUVUyrxclXQSmc3Vw9d7Wqve4R9DZFfkfaKPOGj2BhjWXbmhhp0EtHjGpYpzP7cnGQcP6uelep9eoX5j9OhdgMMIH8rjiYmHTYnkHXVYiaHVkWvJMRLfSuq6yk61g9d6TZW3J+OEdRaKUf6NljeSa3wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753292106; c=relaxed/simple;
	bh=SSXg8ECWTIfwP0u4L4pppiz7mam/bpcy0GKszAlTwNg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tz2vAWAwMJpRmxcGWCqharcAx5yIf8T2jcgxsXN/zfTz5HXDzXdxODoCInSmGapQ3KMHwXJOmx70hRpbnFHTpYhP2kON81XZuuyKGDG/LaPx8gQsKCkrHni3tZV6phfdGpZvOI0bnBxuk7pN13w+mrKULNGNpZ5P/53UxWVkhck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lnSyv37g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A0146C4CEF4;
	Wed, 23 Jul 2025 17:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753292106;
	bh=SSXg8ECWTIfwP0u4L4pppiz7mam/bpcy0GKszAlTwNg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=lnSyv37gO5xEHqB8K/CQpzv8VsCYVOl5A46fWuaQ3DShpB3S9EK1/g5sx1s0AST5L
	 2DWJbjiG7Mnkgn9YAWwB+twyx3bC6umrddPQEk3hKNo8lPTZRJb5FTcmMW5sDsICxs
	 w1IWe1LB1i6wEL1t9NFcsZd8iUYuATN/jb0/M49Ru7Wh0YB9cbWnC6fBmv2lygU39N
	 uUMEYjIV22THLf2tfnwYaCv3JbM9zjittx6WHhngM+Ru1iqsfXaGCpuzI2xUqCE7Dm
	 Y3iK67ZS06YkkRFr1q/POiUoi4RI9yZ4kV0ywEzSd0oEKor2VeamUIMSnFz54s7ekX
	 32lxvXm6ID9PA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F335C83F17;
	Wed, 23 Jul 2025 17:35:06 +0000 (UTC)
From: Dimitri Fedrau via B4 Relay <devnull+dimitri.fedrau.liebherr.com@kernel.org>
Date: Wed, 23 Jul 2025 19:34:56 +0200
Subject: [PATCH v5 1/2] pwm: mc33xs2410: add hwmon support
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250723-mc33xs2410-hwmon-v5-1-f62aab71cd59@liebherr.com>
References: <20250723-mc33xs2410-hwmon-v5-0-f62aab71cd59@liebherr.com>
In-Reply-To: <20250723-mc33xs2410-hwmon-v5-0-f62aab71cd59@liebherr.com>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org, 
 Dimitri Fedrau <dimitri.fedrau@liebherr.com>, 
 Dimitri Fedrau <dima.fedrau@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753292105; l=4016;
 i=dimitri.fedrau@liebherr.com; s=20241202; h=from:subject:message-id;
 bh=7Ba6D8Nsq70XyxD+K636D3Vr+HrfmANRkuQUcbHIPpM=;
 b=Yaf9Q27JI8cGgE4AVwyyY7jDYQB6CmIz1eC+D5TC5XcPI8bV5vjVbWPl3DdTS++lMvSe3KSU0
 Z0zxTv8nh8xDtV1acg6fIdb3PgS+A/SCS+myjLGVawzrc5yxYuySto4
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
 drivers/pwm/pwm-mc33xs2410.c | 20 ++++++++++++++++++--
 include/linux/mc33xs2410.h   | 16 ++++++++++++++++
 3 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 3ef1757502ebd92b30584cd10611311a0fbfc03b..64f1c86340fdc7d0ef41bf14be5f6f0623a2bd31 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -436,6 +436,7 @@ config PWM_MC33XS2410
 	tristate "MC33XS2410 PWM support"
 	depends on OF
 	depends on SPI
+	select AUXILIARY_BUS
 	help
 	  NXP MC33XS2410 high-side switch driver. The MC33XS2410 is a four
 	  channel high-side switch. The device is operational from 3.0 V
diff --git a/drivers/pwm/pwm-mc33xs2410.c b/drivers/pwm/pwm-mc33xs2410.c
index a1ac3445ccdb4709d92e0075d424a8abc1416eee..6d99e3ff7239891d87711d98aa463ac158af70e1 100644
--- a/drivers/pwm/pwm-mc33xs2410.c
+++ b/drivers/pwm/pwm-mc33xs2410.c
@@ -17,11 +17,14 @@
  *   behavior of the output pin that is neither the old nor the new state,
  *   rather something in between.
  */
+#define DEFAULT_SYMBOL_NAMESPACE		"PWM_MC33XS2410"
 
+#include <linux/auxiliary_bus.h>
 #include <linux/bitfield.h>
 #include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/math64.h>
+#include <linux/mc33xs2410.h>
 #include <linux/minmax.h>
 #include <linux/module.h>
 #include <linux/of.h>
@@ -120,12 +123,19 @@ static int mc33xs2410_read_reg(struct spi_device *spi, u8 reg, u16 *val, u8 flag
 	return mc33xs2410_read_regs(spi, &reg, flag, val, 1);
 }
 
-static int mc33xs2410_read_reg_ctrl(struct spi_device *spi, u8 reg, u16 *val)
+int mc33xs2410_read_reg_ctrl(struct spi_device *spi, u8 reg, u16 *val)
 {
 	return mc33xs2410_read_reg(spi, reg, val, MC33XS2410_FRAME_IN_DATA_RD);
 }
+EXPORT_SYMBOL_GPL(mc33xs2410_read_reg_ctrl);
 
-static int mc33xs2410_modify_reg(struct spi_device *spi, u8 reg, u8 mask, u8 val)
+int mc33xs2410_read_reg_diag(struct spi_device *spi, u8 reg, u16 *val)
+{
+	return mc33xs2410_read_reg(spi, reg, val, 0);
+}
+EXPORT_SYMBOL_GPL(mc33xs2410_read_reg_diag);
+
+int mc33xs2410_modify_reg(struct spi_device *spi, u8 reg, u8 mask, u8 val)
 {
 	u16 tmp;
 	int ret;
@@ -139,6 +149,7 @@ static int mc33xs2410_modify_reg(struct spi_device *spi, u8 reg, u8 mask, u8 val
 
 	return mc33xs2410_write_reg(spi, reg, tmp);
 }
+EXPORT_SYMBOL_GPL(mc33xs2410_modify_reg);
 
 static u8 mc33xs2410_pwm_get_freq(u64 period)
 {
@@ -314,6 +325,7 @@ static int mc33xs2410_reset(struct device *dev)
 static int mc33xs2410_probe(struct spi_device *spi)
 {
 	struct device *dev = &spi->dev;
+	struct auxiliary_device *adev;
 	struct pwm_chip *chip;
 	int ret;
 
@@ -361,6 +373,10 @@ static int mc33xs2410_probe(struct spi_device *spi)
 	if (ret < 0)
 		return dev_err_probe(dev, ret, "Failed to add pwm chip\n");
 
+	adev = devm_auxiliary_device_create(dev, "hwmon", NULL);
+	if (!adev)
+		return dev_err_probe(dev, -ENODEV, "Failed to register hwmon device\n");
+
 	return 0;
 }
 
diff --git a/include/linux/mc33xs2410.h b/include/linux/mc33xs2410.h
new file mode 100644
index 0000000000000000000000000000000000000000..31c0edf10dd7370a0c3e603947256577d4d40854
--- /dev/null
+++ b/include/linux/mc33xs2410.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2024 Liebherr-Electronics and Drives GmbH
+ */
+#ifndef _MC33XS2410_H
+#define _MC33XS2410_H
+
+#include <linux/spi/spi.h>
+
+MODULE_IMPORT_NS("PWM_MC33XS2410");
+
+int mc33xs2410_read_reg_ctrl(struct spi_device *spi, u8 reg, u16 *val);
+int mc33xs2410_read_reg_diag(struct spi_device *spi, u8 reg, u16 *val);
+int mc33xs2410_modify_reg(struct spi_device *spi, u8 reg, u8 mask, u8 val);
+
+#endif /* _MC33XS2410_H */

-- 
2.39.5



