Return-Path: <linux-pwm+bounces-5895-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5420CAB35E1
	for <lists+linux-pwm@lfdr.de>; Mon, 12 May 2025 13:26:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7146F7A93BC
	for <lists+linux-pwm@lfdr.de>; Mon, 12 May 2025 11:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF9C428D857;
	Mon, 12 May 2025 11:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S3OSac1P"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920ED25C802;
	Mon, 12 May 2025 11:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747049171; cv=none; b=k/oUNEUMIq2eF9p9qh+vAnc4OdtTnSampSxviLMfk6cgNsAlY5wy3FWiUlnTIX/xWX6esuSYRBuGIaJUy+G8iutxpDlmqCVq/wb1AclXeo49LymBhWEh3CQKqY4L7M/+fxkL/nHETVO9woetFF73tJAdUOryn8sN+CY760Mn47c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747049171; c=relaxed/simple;
	bh=0bANmR03SRjRmDVHY+CDLs/PzBOw4ovvu4Q4PJhMhVM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=X/q/FTh4sPG+c3JsMR+i9TLfQ3Mou0J1FVEbkaShkq25SUjED04rnRxii3zM/h/2Yq/g/c4sPhXK/9MtEoF6KBxSZ5XQu76d4uK3ESXDiSTy1p9LL3BFi6ifd88S//zb5hLf08hMsF55hZU0ySVePupvuQ/Vt8hkP0cm6zZxhQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S3OSac1P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E80D8C4CEEE;
	Mon, 12 May 2025 11:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747049170;
	bh=0bANmR03SRjRmDVHY+CDLs/PzBOw4ovvu4Q4PJhMhVM=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=S3OSac1Penj0r0wTbr2LXDGYypR7yPeIoSXxUjrHaG3q9EqNM8MCJ6sKeVtlona1N
	 5oSzzvtQI04Xjv4E58K6YKKhMcjMynlwZlmJCovhO+CvljTR5cAwQ4iJLEq0CapZ/D
	 m9SmONV+t0tVtjg7l6iXi1iWBwNXOE8uZ9VfqK1aNcwt+l3XXmkMKJ9iirC5fq/3WH
	 iw+fZgNEDN+Ecc5+OL0buDh9KBLXC+HFIjRQduPKL3MNu88DiR9F/164QCCtw3MWX7
	 NvpqzgGx5qFBriYgf/ImQWJ64fdapqAoKcWzf6aDSswI//nC/Abjly5XqhdcamtWLf
	 N/A4WpDXMus3Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7A0AC3ABC3;
	Mon, 12 May 2025 11:26:10 +0000 (UTC)
From: Dimitri Fedrau via B4 Relay <devnull+dimitri.fedrau.liebherr.com@kernel.org>
Date: Mon, 12 May 2025 13:26:01 +0200
Subject: [PATCH] pwm: mc33xs2410: add support for temperature sensors
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250512-mc33xs2410-hwmon-v1-1-addba77c78f9@liebherr.com>
X-B4-Tracking: v=1; b=H4sIAMjaIWgC/x3MQQqAIBBA0avIrBMmTaKuEi3ExpyFFgoVhHdPW
 r7F/y8UykwFZvFCposLH6mh7wS4YNNOkrdmUKgMGhxldFo/RQ09ynDHI0lrvJ/Ik0M00LIzk+f
 nXy5rrR+eta+vYgAAAA==
X-Change-ID: 20250507-mc33xs2410-hwmon-a5ff9efec005
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-hwmon@vger.kernel.org, Dimitri Fedrau <dima.fedrau@gmail.com>, 
 Dimitri Fedrau <dimitri.fedrau@liebherr.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1747049170; l=7237;
 i=dimitri.fedrau@liebherr.com; s=20241202; h=from:subject:message-id;
 bh=WO+KJq5SeJ/zVZpna3KQEugGGpzJUOSQsd2wSDTN6nU=;
 b=oq98zzKrURO5ToJ22Y1C1vQz/akr+yJc8i8yqSV1I1JET7tw2k7Yn5x2FJd4wKwvXDL/7/d/R
 1yRnb7u0frMCnZyaiaKKk/APWs6k68Y2NXbfpjkFJfPpw+5t59MBvUX
X-Developer-Key: i=dimitri.fedrau@liebherr.com; a=ed25519;
 pk=rT653x09JSQvotxIqQl4/XiI4AOiBZrdOGvxDUbb5m8=
X-Endpoint-Received: by B4 Relay for dimitri.fedrau@liebherr.com/20241202
 with auth_id=290
X-Original-From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
Reply-To: dimitri.fedrau@liebherr.com

From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>

The MC33XS2410 provides temperature sensors for the central die temperature
and the four outputs. Additionally a common temperature warning threshold
can be configured for the outputs. Add hwmon support for the sensors.

Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
---
 drivers/pwm/Kconfig          |   1 +
 drivers/pwm/pwm-mc33xs2410.c | 176 ++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 176 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 6faa8b2ec0a4844f667a84335f30bde44d52378e..0deaf8447f4302e7cfd3b4cb35c7d46ef19e006c 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -425,6 +425,7 @@ config PWM_LPSS_PLATFORM
 
 config PWM_MC33XS2410
 	tristate "MC33XS2410 PWM support"
+	depends on HWMON || HWMON=n
 	depends on OF
 	depends on SPI
 	help
diff --git a/drivers/pwm/pwm-mc33xs2410.c b/drivers/pwm/pwm-mc33xs2410.c
index a1ac3445ccdb4709d92e0075d424a8abc1416eee..c3302b58b3acb60e5985c1c14746c380271eb6d6 100644
--- a/drivers/pwm/pwm-mc33xs2410.c
+++ b/drivers/pwm/pwm-mc33xs2410.c
@@ -21,6 +21,7 @@
 #include <linux/bitfield.h>
 #include <linux/delay.h>
 #include <linux/err.h>
+#include <linux/hwmon.h>
 #include <linux/math64.h>
 #include <linux/minmax.h>
 #include <linux/module.h>
@@ -29,6 +30,8 @@
 
 #include <linux/spi/spi.h>
 
+/* ctrl registers */
+
 #define MC33XS2410_GLB_CTRL			0x00
 #define MC33XS2410_GLB_CTRL_MODE		GENMASK(7, 6)
 #define MC33XS2410_GLB_CTRL_MODE_NORMAL		FIELD_PREP(MC33XS2410_GLB_CTRL_MODE, 1)
@@ -51,6 +54,21 @@
 
 #define MC33XS2410_WDT				0x14
 
+#define MC33XS2410_TEMP_WT			0x29
+#define MC33XS2410_TEMP_WT_MASK			GENMASK(7, 0)
+
+/* diag registers */
+
+/* chan in { 1 ... 4 } */
+#define MC33XS2410_OUT_STA(chan)		(0x02 + (chan) - 1)
+#define MC33XS2410_OUT_STA_OTW			BIT(8)
+
+#define MC33XS2410_TS_TEMP_DIE			0x26
+#define MC33XS2410_TS_TEMP_MASK			GENMASK(9, 0)
+
+/* chan in { 1 ... 4 } */
+#define MC33XS2410_TS_TEMP(chan)		(0x2f + (chan) - 1)
+
 #define MC33XS2410_PWM_MIN_PERIOD		488282
 /* step in { 0 ... 3 } */
 #define MC33XS2410_PWM_MAX_PERIOD(step)		(2000000000 >> (2 * (step)))
@@ -125,6 +143,11 @@ static int mc33xs2410_read_reg_ctrl(struct spi_device *spi, u8 reg, u16 *val)
 	return mc33xs2410_read_reg(spi, reg, val, MC33XS2410_FRAME_IN_DATA_RD);
 }
 
+static int mc33xs2410_read_reg_diag(struct spi_device *spi, u8 reg, u16 *val)
+{
+	return mc33xs2410_read_reg(spi, reg, val, 0);
+}
+
 static int mc33xs2410_modify_reg(struct spi_device *spi, u8 reg, u8 mask, u8 val)
 {
 	u16 tmp;
@@ -140,6 +163,157 @@ static int mc33xs2410_modify_reg(struct spi_device *spi, u8 reg, u8 mask, u8 val
 	return mc33xs2410_write_reg(spi, reg, tmp);
 }
 
+#if IS_ENABLED(CONFIG_HWMON)
+static const struct hwmon_channel_info * const mc33xs2410_hwmon_info[] = {
+	HWMON_CHANNEL_INFO(temp,
+			   HWMON_T_LABEL | HWMON_T_INPUT,
+			   HWMON_T_LABEL | HWMON_T_INPUT | HWMON_T_MAX |
+			   HWMON_T_ALARM,
+			   HWMON_T_LABEL | HWMON_T_INPUT | HWMON_T_MAX |
+			   HWMON_T_ALARM,
+			   HWMON_T_LABEL | HWMON_T_INPUT | HWMON_T_MAX |
+			   HWMON_T_ALARM,
+			   HWMON_T_LABEL | HWMON_T_INPUT | HWMON_T_MAX |
+			   HWMON_T_ALARM),
+	NULL,
+};
+
+static umode_t mc33xs2410_hwmon_is_visible(const void *data,
+					   enum hwmon_sensor_types type,
+					   u32 attr, int channel)
+{
+	switch (attr) {
+	case hwmon_temp_input:
+	case hwmon_temp_alarm:
+	case hwmon_temp_label:
+		return 0444;
+	case hwmon_temp_max:
+		return 0644;
+	default:
+		return 0;
+	}
+}
+
+static int mc33xs2410_hwmon_read_out_status(struct spi_device *spi,
+					    int channel, u16 *val)
+{
+	int ret;
+
+	ret = mc33xs2410_read_reg_diag(spi, MC33XS2410_OUT_STA(channel), val);
+	if (ret < 0)
+		return ret;
+
+	/* Bits latches high */
+	return mc33xs2410_read_reg_diag(spi, MC33XS2410_OUT_STA(channel), val);
+}
+
+static int mc33xs2410_hwmon_read(struct device *dev,
+				 enum hwmon_sensor_types type,
+				 u32 attr, int channel, long *val)
+{
+	struct spi_device *spi = dev_get_drvdata(dev);
+	u16 reg_val;
+	int ret;
+	u8 reg;
+
+	switch (attr) {
+	case hwmon_temp_input:
+		reg = (channel == 0) ? MC33XS2410_TS_TEMP_DIE :
+				       MC33XS2410_TS_TEMP(channel);
+		ret = mc33xs2410_read_reg_diag(spi, reg, &reg_val);
+		if (ret < 0)
+			return ret;
+
+		/* LSB is 0.25 degree celsius */
+		*val = FIELD_GET(MC33XS2410_TS_TEMP_MASK, reg_val) * 250 - 40000;
+		return 0;
+	case hwmon_temp_alarm:
+		ret = mc33xs2410_hwmon_read_out_status(spi, channel, &reg_val);
+		if (ret < 0)
+			return ret;
+
+		*val = FIELD_GET(MC33XS2410_OUT_STA_OTW, reg_val);
+		return 0;
+	case hwmon_temp_max:
+		ret = mc33xs2410_read_reg_ctrl(spi, MC33XS2410_TEMP_WT, &reg_val);
+		if (ret < 0)
+			return ret;
+
+		/* LSB is 1 degree celsius */
+		*val = FIELD_GET(MC33XS2410_TEMP_WT_MASK, reg_val) * 1000 - 40000;
+		return 0;
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static int mc33xs2410_hwmon_write(struct device *dev,
+				  enum hwmon_sensor_types type, u32 attr,
+				  int channel, long val)
+{
+	struct spi_device *spi = dev_get_drvdata(dev);
+
+	switch (attr) {
+	case hwmon_temp_max:
+		val = clamp_val(val, -40000, 215000);
+
+		/* LSB is 1 degree celsius */
+		val = (val / 1000) + 40;
+		return mc33xs2410_modify_reg(spi, MC33XS2410_TEMP_WT,
+					     MC33XS2410_TEMP_WT_MASK, val);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static const char *const mc33xs2410_temp_label[] = {
+	"Central die temperature",
+	"Channel 1 temperature",
+	"Channel 2 temperature",
+	"Channel 3 temperature",
+	"Channel 4 temperature",
+};
+
+static int mc33xs2410_read_string(struct device *dev,
+				  enum hwmon_sensor_types type,
+				  u32 attr, int channel, const char **str)
+{
+	*str = mc33xs2410_temp_label[channel];
+
+	return 0;
+}
+
+static const struct hwmon_ops mc33xs2410_hwmon_hwmon_ops = {
+	.is_visible = mc33xs2410_hwmon_is_visible,
+	.read = mc33xs2410_hwmon_read,
+	.read_string = mc33xs2410_read_string,
+	.write = mc33xs2410_hwmon_write,
+};
+
+static const struct hwmon_chip_info mc33xs2410_hwmon_chip_info = {
+	.ops = &mc33xs2410_hwmon_hwmon_ops,
+	.info = mc33xs2410_hwmon_info,
+};
+
+static int mc33xs2410_hwmon_probe(struct spi_device *spi)
+{
+	struct device *dev = &spi->dev;
+	struct device *hwmon;
+
+	hwmon = devm_hwmon_device_register_with_info(dev, NULL, spi,
+						     &mc33xs2410_hwmon_chip_info,
+						     NULL);
+
+	return PTR_ERR_OR_ZERO(hwmon);
+}
+
+#else
+static int mc33xs2410_hwmon_probe(struct spi_device *spi)
+{
+	return 0;
+}
+#endif
+
 static u8 mc33xs2410_pwm_get_freq(u64 period)
 {
 	u8 step, count;
@@ -361,7 +535,7 @@ static int mc33xs2410_probe(struct spi_device *spi)
 	if (ret < 0)
 		return dev_err_probe(dev, ret, "Failed to add pwm chip\n");
 
-	return 0;
+	return mc33xs2410_hwmon_probe(spi);
 }
 
 static const struct spi_device_id mc33xs2410_spi_id[] = {

---
base-commit: 7395eb13e3a85067de3e083d3781630ea303c0c4
change-id: 20250507-mc33xs2410-hwmon-a5ff9efec005

Best regards,
-- 
Dimitri Fedrau <dimitri.fedrau@liebherr.com>



