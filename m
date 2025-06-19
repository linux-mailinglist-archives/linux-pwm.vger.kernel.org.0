Return-Path: <linux-pwm+bounces-6447-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5CACAE0BF3
	for <lists+linux-pwm@lfdr.de>; Thu, 19 Jun 2025 19:32:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A44D3AEAA9
	for <lists+linux-pwm@lfdr.de>; Thu, 19 Jun 2025 17:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A39288C2C;
	Thu, 19 Jun 2025 17:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h7OkaGbg"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E97623ABA6;
	Thu, 19 Jun 2025 17:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750354365; cv=none; b=DU5ov+AeSQP+rQCtptlNF3fUzlWC31wyLf4nzIDJrqVTYE8+rvu3TLm92hV4Y4ZofOH+jgUito1rFcTL+L213kvI02Le4VUQ2BU7K/c8pnJX/C6TuPte4SClHdwpmyWXiF4Lx9oRIsxtzjXn9jMpOn6zMH9xJq8zaQVCblNQ/iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750354365; c=relaxed/simple;
	bh=SbHt/cy98hAoU1ACnUTGCtxFlOFYcLwWiM9zH1/i6HI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=qtdzNp2ntZ2IkKAYNPxiHHlguOR5jOtr5LiaePYRuSlwA/NQ+H9oXPCzHgvDNhoV03mmKQ0v2BgVvU/Cydkx1/eGHXz2aCW2eReSWBMjuOBj+ZVDgnBgjElPfUZ5DFffqWKTKdf72ZzKxLqrmpFaMtE3MBFFzgxAnvCpvtTuAg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h7OkaGbg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1ACC9C4CEF0;
	Thu, 19 Jun 2025 17:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750354365;
	bh=SbHt/cy98hAoU1ACnUTGCtxFlOFYcLwWiM9zH1/i6HI=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=h7OkaGbgvrxRwye9k3n7OxwKKIvvtmGJpsA1CnGXSDYxEm/8NlwYLzbsSB8quPF3P
	 AEJ3CyajTgBJq2HNOTKZo5UseDtrh0DrO3tz3BDAyx6C9R50SXmCaoDUj52OApLRdA
	 GXaRjsx97cFHta6KtBSaVUJ1hE2y4F3dBKWbkNVwgYOXlTAmLif5G7BNErAiAV6M0Z
	 J5NtBhVUKZ7f31yFEkirfC/3DmLWe+OguBsfT/Ez/MvAoS3wadvD3uEgTPjL9HJU5a
	 bwthnAzzsXvMa+9MDIJOk/Jbkjr40NvduPQw2NFCuqq+RDueQ8hoMFvZY04RW5Fb3S
	 k9qW7rLQJQHpg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07D14C7115B;
	Thu, 19 Jun 2025 17:32:45 +0000 (UTC)
From: Dimitri Fedrau via B4 Relay <devnull+dimitri.fedrau.liebherr.com@kernel.org>
Date: Thu, 19 Jun 2025 19:32:42 +0200
Subject: [PATCH v3] pwm: mc33xs2410: add support for temperature sensors
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250619-mc33xs2410-hwmon-v3-1-301731e49f8f@liebherr.com>
X-B4-Tracking: v=1; b=H4sIALlJVGgC/23NTQ7CIBCG4auYWYvhR0LrynsYFxQGIbHFgMGap
 neXNi6Munwn+Z6ZIGMKmOGwmSBhCTnEoYbYbsB4PVyQBFsbOOWSSqpIb4QYM98zSvyjjwPR0rk
 WHRpKJdTZLaEL40qezrV9yPeYnuuHwpbrG2P8FyuMMKKt7bRSRjWuPV4Ddh5T2pnYw+IV/mnIP
 wavRmM51r1CQe2XMc/zC8Ihew73AAAA
X-Change-ID: 20250507-mc33xs2410-hwmon-a5ff9efec005
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-hwmon@vger.kernel.org, Dimitri Fedrau <dima.fedrau@gmail.com>, 
 Dimitri Fedrau <dimitri.fedrau@liebherr.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750354364; l=7025;
 i=dimitri.fedrau@liebherr.com; s=20241202; h=from:subject:message-id;
 bh=chFN37L9O7y4mdyrp4nItchTv0oIed/TseetXA611Fo=;
 b=kfd6CKMxOJQJScg0EBtmYX8toVsXmo1D9G4NW7PcEXs4LmORqKgSmLWX0Z3y1xq9y83T+EFsN
 qScsBTvNEhzAiioEv358vVFbMo9p8EmLvKHYCPdMYht4Vss44Ey1lyc
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

Acked-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
---
Changes in v3:
- Add changes suggested by Uwe Kleine-König.
  Remove "#if IS_ENABLED(CONFIG_HWMON)" and add
  "if (IS_REACHABLE(CONFIG_HWMON))" in mc33xs2410_hwmon_probe.
- Link to v2: https://lore.kernel.org/r/20250515-mc33xs2410-hwmon-v2-1-8d2e78f7e30d@liebherr.com

Changes in v2:
- Remove helper mc33xs2410_hwmon_read_out_status and report the last
  latched status.
- Link to v1: https://lore.kernel.org/r/20250512-mc33xs2410-hwmon-v1-1-addba77c78f9@liebherr.com
---
 drivers/pwm/pwm-mc33xs2410.c | 164 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 164 insertions(+)

diff --git a/drivers/pwm/pwm-mc33xs2410.c b/drivers/pwm/pwm-mc33xs2410.c
index a1ac3445ccdb4709d92e0075d424a8abc1416eee..6a0a1e50d9584dbca751748143669ee1ebefb7e3 100644
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
@@ -140,6 +163,143 @@ static int mc33xs2410_modify_reg(struct spi_device *spi, u8 reg, u8 mask, u8 val
 	return mc33xs2410_write_reg(spi, reg, tmp);
 }
 
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
+		ret = mc33xs2410_read_reg_diag(spi, MC33XS2410_OUT_STA(channel),
+					       &reg_val);
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
+
+	if (IS_REACHABLE(CONFIG_HWMON)) {
+		struct device *hwmon;
+
+		hwmon = devm_hwmon_device_register_with_info(dev, NULL, spi,
+							     &mc33xs2410_hwmon_chip_info,
+							     NULL);
+		return PTR_ERR_OR_ZERO(hwmon);
+	}
+
+	dev_dbg(dev, "Not registering hwmon sensors\n");
+
+	return 0;
+}
+
 static u8 mc33xs2410_pwm_get_freq(u64 period)
 {
 	u8 step, count;
@@ -361,6 +521,10 @@ static int mc33xs2410_probe(struct spi_device *spi)
 	if (ret < 0)
 		return dev_err_probe(dev, ret, "Failed to add pwm chip\n");
 
+	ret = mc33xs2410_hwmon_probe(spi);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Failed to register hwmon sensors\n");
+
 	return 0;
 }
 

---
base-commit: 446d36aa71b56e8a926e6ff066d83b12130fda59
change-id: 20250507-mc33xs2410-hwmon-a5ff9efec005

Best regards,
-- 
Dimitri Fedrau <dimitri.fedrau@liebherr.com>



