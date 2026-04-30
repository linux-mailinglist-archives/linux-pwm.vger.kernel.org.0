Return-Path: <linux-pwm+bounces-8750-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KCZlONEt82m8yAEAu9opvQ
	(envelope-from <linux-pwm+bounces-8750-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 30 Apr 2026 12:24:17 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EAFF4A0C45
	for <lists+linux-pwm@lfdr.de>; Thu, 30 Apr 2026 12:24:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 02B00302A60E
	for <lists+linux-pwm@lfdr.de>; Thu, 30 Apr 2026 10:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29C463FFADC;
	Thu, 30 Apr 2026 10:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DmCFLvnh"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66343FE341;
	Thu, 30 Apr 2026 10:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777544208; cv=none; b=K+Msw9tZzslJU7Pti4f5qVSddgLepzMraFjbGGlKDAJ6B+16ARg5IVd2IqtiNGeHtQPjISaln28MbH3pTbyC3BrsaexCVXefCYHYDEDNqMkebLtzuQZkP4Bx0LLgOSBGYMpAm5tZw84izOmtxF40rOKFsyrBwKYtD5f7IGFhuaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777544208; c=relaxed/simple;
	bh=7bmDdN7+hplPoMG6uJ2fTGYSiHa5Imclf/zTQ8Upbmo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MbR08rSJijJR0HsttopgpZEj8aH4rtINCBxu4V5UO79CjKl8++4qKS5DWqS6TD7aVbLblXO2pVyypND4carUzmn4SStObJNVaaUAIjtFae6UXV6Zns5VSCwBH4Z7szHd/EamLDOfPdK/wcvwMu0+u/lrY3mzsSS+4iufIjssYWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DmCFLvnh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A4620C2BCF6;
	Thu, 30 Apr 2026 10:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777544207;
	bh=7bmDdN7+hplPoMG6uJ2fTGYSiHa5Imclf/zTQ8Upbmo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=DmCFLvnhy1t8POFprrEXm0Qrd4af/MAfP/ZAA/rZyVWug0YC3iPGMBEnuNkMyg0ZW
	 itaFDJDIZChlUWNjx+zS+JwgbhBpFJ0SPKj6TjJleIV65r4IYidd9Bm5+F57x7Mz5E
	 wDuW40g+kVawroFmHCddYilTcypneEXdLS/otBoahdXbUMJy7W59qPEXMOjW3vc/kx
	 4GfwW7oQYVkBz+VcUgMzHUq4TPn90kHAPXUfelvXiA590RmWk4m3gEKEIOcVeQ1Vjr
	 i1VH6O12O1bQXdqo8WwH/f4LrdBpmrDGdQd8+hElVrY6WbMMyq3DesfdcaxMQ/Bc3D
	 VMa7mFS6EHBng==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99DA8CCFA13;
	Thu, 30 Apr 2026 10:16:47 +0000 (UTC)
From: Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org>
Date: Thu, 30 Apr 2026 13:16:45 +0300
Subject: [PATCH v9 3/6] iio: adc: ad4691: add triggered buffer support
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260430-ad4692-multichannel-sar-adc-driver-v9-3-33e439e4fb87@analog.com>
References: <20260430-ad4692-multichannel-sar-adc-driver-v9-0-33e439e4fb87@analog.com>
In-Reply-To: <20260430-ad4692-multichannel-sar-adc-driver-v9-0-33e439e4fb87@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-doc@vger.kernel.org, 
 Radu Sabau <radu.sabau@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777544205; l=22901;
 i=radu.sabau@analog.com; s=20260220; h=from:subject:message-id;
 bh=jhB+VQPBsH2JWQYf3W57gFrOemsRyhHWVuqAfKr13d4=;
 b=nBM7BuaCnewRH7LOYEWV3oO3s1H7SKnqMcI8y/UJ2DjlS1UH1zbk+XZUb21WcTKK0k0bc0vxg
 G946UMTBHtKB1iuyrUZzsSg3KC1fFCdCHlpuouKE0MlBiIiqa6Q4w0o
X-Developer-Key: i=radu.sabau@analog.com; a=ed25519;
 pk=lDPQHgn9jTdt0vo58Na9lLxLaE2mb330if71Cn+EvFU=
X-Endpoint-Received: by B4 Relay for radu.sabau@analog.com/20260220 with
 auth_id=642
X-Original-From: Radu Sabau <radu.sabau@analog.com>
Reply-To: radu.sabau@analog.com
X-Rspamd-Queue-Id: 2EAFF4A0C45
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8750-lists,linux-pwm=lfdr.de,radu.sabau.analog.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[metafoo.de,analog.com,kernel.org,baylibre.com,gmail.com,pengutronix.de,lwn.net,linuxfoundation.org];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,linux-pwm@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	HAS_REPLYTO(0.00)[radu.sabau@analog.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,analog.com:email,analog.com:replyto,analog.com:mid]

From: Radu Sabau <radu.sabau@analog.com>

Add buffered capture support using the IIO triggered buffer framework.

CNV Burst Mode: the GP pin identified by interrupt-names in the device
tree is configured as DATA_READY output. The IRQ handler stops
conversions and fires the IIO trigger; the trigger handler executes a
pre-built SPI message that reads all active channels from the AVG_IN
accumulator registers and then resets accumulator state and restarts
conversions for the next cycle.

Manual Mode: CNV is tied to SPI CS so each transfer simultaneously
reads the previous result and starts the next conversion (pipelined
N+1 scheme). At preenable time a pre-built, optimised SPI message of
N+1 transfers is constructed (N channel reads plus one NOOP to drain
the pipeline). The trigger handler executes the message in a single
spi_sync() call and collects the results. An external trigger (e.g.
iio-trig-hrtimer) is required to drive the trigger at the desired
sample rate.

Both modes share the same trigger handler and push a complete scan —
one u16 slot per channel at its scan_index position, followed by a
timestamp — to the IIO buffer via iio_push_to_buffers_with_ts().

The CNV Burst Mode sampling frequency (PWM period) is exposed as a
buffer-level attribute via IIO_DEVICE_ATTR.

Signed-off-by: Radu Sabau <radu.sabau@analog.com>
---
 drivers/iio/adc/Kconfig  |   2 +
 drivers/iio/adc/ad4691.c | 523 +++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 511 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 3685a03aa8dc..d498f16c0816 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -142,6 +142,8 @@ config AD4170_4
 config AD4691
 	tristate "Analog Devices AD4691 Family ADC Driver"
 	depends on SPI
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
 	select REGMAP
 	help
 	  Say yes here to build support for Analog Devices AD4691 Family MuxSAR
diff --git a/drivers/iio/adc/ad4691.c b/drivers/iio/adc/ad4691.c
index 05826b762c7f..c1e3406fef18 100644
--- a/drivers/iio/adc/ad4691.c
+++ b/drivers/iio/adc/ad4691.c
@@ -5,16 +5,20 @@
  */
 #include <linux/array_size.h>
 #include <linux/bitfield.h>
-#include <linux/bitops.h>
+#include <linux/bitmap.h>
 #include <linux/cleanup.h>
 #include <linux/delay.h>
 #include <linux/dev_printk.h>
 #include <linux/device/devres.h>
+#include <linux/dmaengine.h>
 #include <linux/err.h>
+#include <linux/interrupt.h>
 #include <linux/limits.h>
 #include <linux/math.h>
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
+#include <linux/property.h>
+#include <linux/pwm.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 #include <linux/reset.h>
@@ -22,7 +26,12 @@
 #include <linux/units.h>
 #include <linux/unaligned.h>
 
+#include <linux/iio/buffer.h>
 #include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/iio/trigger.h>
+#include <linux/iio/triggered_buffer.h>
+#include <linux/iio/trigger_consumer.h>
 
 #define AD4691_VREF_uV_MIN			2400000
 #define AD4691_VREF_uV_MAX			5250000
@@ -31,6 +40,9 @@
 #define AD4691_VREF_3P3_uV_MAX			3750000
 #define AD4691_VREF_4P096_uV_MAX		4500000
 
+#define AD4691_CNV_DUTY_CYCLE_NS		380
+#define AD4691_CNV_HIGH_TIME_NS			430
+
 #define AD4691_SPI_CONFIG_A_REG			0x000
 #define AD4691_SW_RESET				(BIT(7) | BIT(0))
 
@@ -38,6 +50,7 @@
 #define AD4691_CLAMP_STATUS1_REG		0x01A
 #define AD4691_CLAMP_STATUS2_REG		0x01B
 #define AD4691_DEVICE_SETUP			0x020
+#define AD4691_MANUAL_MODE			BIT(2)
 #define AD4691_LDO_EN				BIT(4)
 #define AD4691_REF_CTRL				0x021
 #define AD4691_REF_CTRL_MASK			GENMASK(4, 2)
@@ -45,13 +58,18 @@
 #define AD4691_OSC_FREQ_REG			0x023
 #define AD4691_OSC_FREQ_MASK			GENMASK(3, 0)
 #define AD4691_STD_SEQ_CONFIG			0x025
+#define AD4691_SEQ_ALL_CHANNELS_OFF		0x00
 #define AD4691_SPARE_CONTROL			0x02A
 
+#define AD4691_NOOP				0x00
+#define AD4691_ADC_CHAN(ch)			((0x10 + (ch)) << 3)
+
 #define AD4691_OSC_EN_REG			0x180
 #define AD4691_STATE_RESET_REG			0x181
 #define AD4691_STATE_RESET_ALL			0x01
 #define AD4691_ADC_SETUP			0x182
 #define AD4691_ADC_MODE_MASK			GENMASK(1, 0)
+#define AD4691_CNV_BURST_MODE			0x01
 #define AD4691_AUTONOMOUS_MODE			0x02
 /*
  * ACC_MASK_REG covers both mask bytes via ADDR_DESCENDING SPI: writing a
@@ -61,6 +79,8 @@
 #define AD4691_ACC_DEPTH_IN(n)			(0x186 + (n))
 #define AD4691_GPIO_MODE1_REG			0x196
 #define AD4691_GPIO_MODE2_REG			0x197
+#define AD4691_GP_MODE_MASK			GENMASK(3, 0)
+#define AD4691_GP_MODE_DATA_READY		0x06
 #define AD4691_GPIO_READ			0x1A0
 #define AD4691_ACC_STATUS_FULL1_REG		0x1B0
 #define AD4691_ACC_STATUS_FULL2_REG		0x1B1
@@ -99,8 +119,8 @@ struct ad4691_chip_info {
 	{								\
 		.type = IIO_VOLTAGE,					\
 		.indexed = 1,						\
-		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW)		\
-				    | BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |		\
+				      BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
 		.info_mask_separate_available =				\
 				      BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
 		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SCALE),	\
@@ -110,6 +130,7 @@ struct ad4691_chip_info {
 			.sign = 'u',					\
 			.realbits = 16,					\
 			.storagebits = 16,				\
+			.endianness = IIO_BE,				\
 		},							\
 	}
 
@@ -130,6 +151,7 @@ static const struct iio_chan_spec ad4691_channels[] = {
 	AD4691_CHANNEL(13),
 	AD4691_CHANNEL(14),
 	AD4691_CHANNEL(15),
+	IIO_CHAN_SOFT_TIMESTAMP(16),
 };
 
 static const struct iio_chan_spec ad4693_channels[] = {
@@ -141,6 +163,17 @@ static const struct iio_chan_spec ad4693_channels[] = {
 	AD4691_CHANNEL(5),
 	AD4691_CHANNEL(6),
 	AD4691_CHANNEL(7),
+	IIO_CHAN_SOFT_TIMESTAMP(8),
+};
+
+static const struct ad4691_channel_info ad4691_sw_info = {
+	.channels = ad4691_channels,
+	.num_channels = ARRAY_SIZE(ad4691_channels),
+};
+
+static const struct ad4691_channel_info ad4693_sw_info = {
+	.channels = ad4693_channels,
+	.num_channels = ARRAY_SIZE(ad4693_channels),
 };
 
 /*
@@ -167,15 +200,7 @@ static const int ad4691_osc_freqs_Hz[] = {
 	[0xF] = 1250,
 };
 
-static const struct ad4691_channel_info ad4691_sw_info = {
-	.channels = ad4691_channels,
-	.num_channels = ARRAY_SIZE(ad4691_channels),
-};
-
-static const struct ad4691_channel_info ad4693_sw_info = {
-	.channels = ad4693_channels,
-	.num_channels = ARRAY_SIZE(ad4693_channels),
-};
+static const char * const ad4691_gp_names[] = { "gp0", "gp1", "gp2", "gp3" };
 
 static const struct ad4691_chip_info ad4691_chip_info = {
 	.name = "ad4691",
@@ -204,7 +229,14 @@ static const struct ad4691_chip_info ad4694_chip_info = {
 struct ad4691_state {
 	const struct ad4691_chip_info *info;
 	struct regmap *regmap;
+	struct spi_device *spi;
+
+	struct pwm_device *conv_trigger;
+	int irq;
 	int vref_uV;
+	u32 cnv_period_ns;
+
+	bool manual_mode;
 	bool refbuf_en;
 	bool ldo_en;
 	/*
@@ -212,8 +244,45 @@ struct ad4691_state {
 	 * atomicity of consecutive SPI operations.
 	 */
 	struct mutex lock;
+	/*
+	 * Per-buffer-enable lifetime resources:
+	 * Manual Mode - a pre-built SPI message that clocks out N+1
+	 *		 transfers in one go.
+	 * CNV Burst Mode - a pre-built SPI message that clocks out 2*N
+	 *		    transfers in one go.
+	 */
+	struct spi_message scan_msg;
+	/* max 16 + 1 NOOP (manual) or 2*16 + 2 (CNV burst). */
+	struct spi_transfer scan_xfers[34];
+	/*
+	 * CNV burst: 16 AVG_IN addresses + state-reset address + state-reset
+	 * value = 18.  Manual: 16 channel cmds + 1 NOOP = 17.
+	 */
+	__be16 scan_tx[18] __aligned(IIO_DMA_MINALIGN);
+	/*
+	 * Scan buffer: one BE16 slot per active channel, plus timestamp.
+	 * DMA-aligned because scan_xfers point rx_buf directly into vals[].
+	 */
+	IIO_DECLARE_DMA_BUFFER_WITH_TS(__be16, vals, 16);
 };
 
+/*
+ * Configure the given GP pin (0-3) as DATA_READY output.
+ * GP0/GP1 → GPIO_MODE1_REG, GP2/GP3 → GPIO_MODE2_REG.
+ * Even pins occupy bits [3:0], odd pins bits [7:4].
+ */
+static int ad4691_gpio_setup(struct ad4691_state *st, unsigned int gp_num)
+{
+	unsigned int bit_off = gp_num % 2;
+	unsigned int reg_off = gp_num / 2;
+	unsigned int shift = 4 * bit_off;
+
+	return regmap_update_bits(st->regmap,
+				  AD4691_GPIO_MODE1_REG + reg_off,
+				  AD4691_GP_MODE_MASK << shift,
+				  AD4691_GP_MODE_DATA_READY << shift);
+}
+
 static int ad4691_reg_read(void *context, unsigned int reg, unsigned int *val)
 {
 	struct spi_device *spi = context;
@@ -507,6 +576,333 @@ static int ad4691_reg_access(struct iio_dev *indio_dev, unsigned int reg,
 	return regmap_write(st->regmap, reg, writeval);
 }
 
+static int ad4691_set_pwm_freq(struct ad4691_state *st, int freq)
+{
+	if (!freq)
+		return -EINVAL;
+
+	st->cnv_period_ns = DIV_ROUND_UP(NSEC_PER_SEC, freq);
+	return 0;
+}
+
+static int ad4691_sampling_enable(struct ad4691_state *st, bool enable)
+{
+	struct pwm_state conv_state = {
+		.period     = st->cnv_period_ns,
+		.duty_cycle = AD4691_CNV_DUTY_CYCLE_NS,
+		.polarity   = PWM_POLARITY_NORMAL,
+		.enabled    = enable,
+	};
+
+	return pwm_apply_might_sleep(st->conv_trigger, &conv_state);
+}
+
+/*
+ * ad4691_enter_conversion_mode - Switch the chip to its buffer conversion mode.
+ *
+ * Configures the ADC hardware registers for the mode selected at probe
+ * (CNV_BURST or MANUAL). Called from buffer preenable before starting
+ * sampling. The chip is in AUTONOMOUS mode during idle (for read_raw).
+ */
+static int ad4691_enter_conversion_mode(struct ad4691_state *st)
+{
+	int ret;
+
+	if (st->manual_mode)
+		return regmap_update_bits(st->regmap, AD4691_DEVICE_SETUP,
+					  AD4691_MANUAL_MODE, AD4691_MANUAL_MODE);
+
+	ret = regmap_update_bits(st->regmap, AD4691_ADC_SETUP,
+				 AD4691_ADC_MODE_MASK, AD4691_CNV_BURST_MODE);
+	if (ret)
+		return ret;
+
+	return regmap_write(st->regmap, AD4691_STATE_RESET_REG,
+			    AD4691_STATE_RESET_ALL);
+}
+
+/*
+ * ad4691_exit_conversion_mode - Return the chip to AUTONOMOUS mode.
+ *
+ * Called from buffer postdisable to restore the chip to the
+ * idle state used by read_raw. Clears the sequencer and resets state.
+ */
+static int ad4691_exit_conversion_mode(struct ad4691_state *st)
+{
+	if (st->manual_mode)
+		return regmap_update_bits(st->regmap, AD4691_DEVICE_SETUP,
+					  AD4691_MANUAL_MODE, 0);
+
+	return regmap_update_bits(st->regmap, AD4691_ADC_SETUP,
+				  AD4691_ADC_MODE_MASK, AD4691_AUTONOMOUS_MODE);
+}
+
+static int ad4691_manual_buffer_preenable(struct iio_dev *indio_dev)
+{
+	struct ad4691_state *st = iio_priv(indio_dev);
+	unsigned int prev_i, k, i;
+	bool first;
+	int ret;
+
+	memset(st->scan_xfers, 0, sizeof(st->scan_xfers));
+	memset(st->scan_tx, 0, sizeof(st->scan_tx));
+
+	spi_message_init(&st->scan_msg);
+
+	first = true;
+	prev_i = 0;
+	k = 0;
+	iio_for_each_active_channel(indio_dev, i) {
+		st->scan_tx[k] = cpu_to_be16(AD4691_ADC_CHAN(i));
+		st->scan_xfers[k].tx_buf = &st->scan_tx[k];
+		/*
+		 * The pipeline means xfer[0] receives the residual from the
+		 * previous sequence, not a valid sample for channel i. Point
+		 * it at vals[i] anyway; xfer[1] (or the NOOP when only one
+		 * channel is active) will overwrite that slot with the real
+		 * result, so no separate dummy buffer is needed.
+		 */
+		if (first) {
+			st->scan_xfers[k].rx_buf = &st->vals[i];
+			first = false;
+		} else {
+			st->scan_xfers[k].rx_buf = &st->vals[prev_i];
+		}
+		st->scan_xfers[k].len = sizeof(__be16);
+		st->scan_xfers[k].cs_change = 1;
+		spi_message_add_tail(&st->scan_xfers[k], &st->scan_msg);
+		prev_i = i;
+		k++;
+	}
+
+	/* Final NOOP transfer retrieves the last channel's result. */
+	st->scan_xfers[k].tx_buf = &st->scan_tx[k]; /* scan_tx[k] == 0 == NOOP */
+	st->scan_xfers[k].rx_buf = &st->vals[prev_i];
+	st->scan_xfers[k].len = sizeof(__be16);
+	spi_message_add_tail(&st->scan_xfers[k], &st->scan_msg);
+
+	ret = spi_optimize_message(st->spi, &st->scan_msg);
+	if (ret)
+		return ret;
+
+	ret = ad4691_enter_conversion_mode(st);
+	if (ret) {
+		spi_unoptimize_message(&st->scan_msg);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int ad4691_manual_buffer_postdisable(struct iio_dev *indio_dev)
+{
+	struct ad4691_state *st = iio_priv(indio_dev);
+	int ret;
+
+	ret = ad4691_exit_conversion_mode(st);
+	spi_unoptimize_message(&st->scan_msg);
+	return ret;
+}
+
+static const struct iio_buffer_setup_ops ad4691_manual_buffer_setup_ops = {
+	.preenable = &ad4691_manual_buffer_preenable,
+	.postdisable = &ad4691_manual_buffer_postdisable,
+};
+
+static int ad4691_cnv_burst_buffer_preenable(struct iio_dev *indio_dev)
+{
+	struct ad4691_state *st = iio_priv(indio_dev);
+	unsigned int k, i;
+	int ret;
+
+	memset(st->scan_xfers, 0, sizeof(st->scan_xfers));
+	memset(st->scan_tx, 0, sizeof(st->scan_tx));
+
+	spi_message_init(&st->scan_msg);
+
+	/*
+	 * Each AVG_IN read needs two transfers: a 2-byte address write phase
+	 * followed by a 2-byte data read phase. CS toggles between channels
+	 * (cs_change=1 on the read phase of all but the last channel).
+	 */
+	k = 0;
+	iio_for_each_active_channel(indio_dev, i) {
+		st->scan_tx[k] = cpu_to_be16(0x8000 | AD4691_AVG_IN(i));
+		st->scan_xfers[2 * k].tx_buf = &st->scan_tx[k];
+		st->scan_xfers[2 * k].len = sizeof(__be16);
+		spi_message_add_tail(&st->scan_xfers[2 * k], &st->scan_msg);
+		st->scan_xfers[2 * k + 1].rx_buf = &st->vals[i];
+		st->scan_xfers[2 * k + 1].len = sizeof(__be16);
+		st->scan_xfers[2 * k + 1].cs_change = 1;
+		spi_message_add_tail(&st->scan_xfers[2 * k + 1], &st->scan_msg);
+		k++;
+	}
+
+	st->scan_tx[k] = cpu_to_be16(AD4691_STATE_RESET_REG);
+	st->scan_xfers[2 * k].tx_buf = &st->scan_tx[k];
+	st->scan_xfers[2 * k].len = sizeof(__be16);
+	spi_message_add_tail(&st->scan_xfers[2 * k], &st->scan_msg);
+	st->scan_tx[k + 1] = cpu_to_be16(AD4691_STATE_RESET_ALL << 8);
+	st->scan_xfers[2 * k + 1].tx_buf = &st->scan_tx[k + 1];
+	st->scan_xfers[2 * k + 1].len = sizeof(__be16);
+	st->scan_xfers[2 * k + 1].cs_change = 1;
+	spi_message_add_tail(&st->scan_xfers[2 * k + 1], &st->scan_msg);
+
+	ret = spi_optimize_message(st->spi, &st->scan_msg);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(st->regmap, AD4691_STD_SEQ_CONFIG,
+			   bitmap_read(indio_dev->active_scan_mask, 0,
+				       iio_get_masklength(indio_dev)));
+	if (ret)
+		goto err_unoptimize;
+
+	ret = regmap_write(st->regmap, AD4691_ACC_MASK_REG,
+			   ~bitmap_read(indio_dev->active_scan_mask, 0,
+				iio_get_masklength(indio_dev)) & GENMASK(15, 0));
+	if (ret)
+		goto err_unoptimize;
+
+	ret = ad4691_enter_conversion_mode(st);
+	if (ret)
+		goto err_unoptimize;
+
+	ret = ad4691_sampling_enable(st, true);
+	if (ret)
+		goto err_exit_conv;
+
+	enable_irq(st->irq);
+	return 0;
+
+err_exit_conv:
+	ad4691_exit_conversion_mode(st);
+err_unoptimize:
+	spi_unoptimize_message(&st->scan_msg);
+	return ret;
+}
+
+static int ad4691_cnv_burst_buffer_postdisable(struct iio_dev *indio_dev)
+{
+	struct ad4691_state *st = iio_priv(indio_dev);
+	int ret;
+
+	disable_irq(st->irq);
+
+	ret = ad4691_sampling_enable(st, false);
+	if (ret)
+		return ret;
+
+	ret = ad4691_exit_conversion_mode(st);
+	spi_unoptimize_message(&st->scan_msg);
+	return ret;
+}
+
+static const struct iio_buffer_setup_ops ad4691_cnv_burst_buffer_setup_ops = {
+	.preenable = &ad4691_cnv_burst_buffer_preenable,
+	.postdisable = &ad4691_cnv_burst_buffer_postdisable,
+};
+
+static ssize_t sampling_frequency_show(struct device *dev,
+				       struct device_attribute *attr,
+				       char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct ad4691_state *st = iio_priv(indio_dev);
+
+	return sysfs_emit(buf, "%lu\n", NSEC_PER_SEC / st->cnv_period_ns);
+}
+
+static ssize_t sampling_frequency_store(struct device *dev,
+					struct device_attribute *attr,
+					const char *buf, size_t len)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct ad4691_state *st = iio_priv(indio_dev);
+	int freq, ret;
+
+	ret = kstrtoint(buf, 10, &freq);
+	if (ret)
+		return ret;
+
+	IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
+	if (IIO_DEV_ACQUIRE_FAILED(claim))
+		return -EBUSY;
+
+
+	ret = ad4691_set_pwm_freq(st, freq);
+	if (ret)
+		return ret;
+
+	return len;
+}
+
+static IIO_DEVICE_ATTR_RW(sampling_frequency, 0);
+
+static const struct iio_dev_attr *ad4691_buffer_attrs[] = {
+	&iio_dev_attr_sampling_frequency,
+	NULL
+};
+
+static irqreturn_t ad4691_irq(int irq, void *private)
+{
+	struct iio_dev *indio_dev = private;
+	struct ad4691_state *st = iio_priv(indio_dev);
+
+	iio_trigger_poll(indio_dev->trig);
+	/*
+	 * Keep the DATA_READY IRQ disabled until the trigger handler has
+	 * finished reading the scan, to prevent a new assertion mid-transfer.
+	 * The PWM continues running uninterrupted; the IRQ is re-enabled in
+	 * ad4691_trigger_handler once spi_sync completes.
+	 *
+	 * IRQF_ONESHOT already masks the hardware line during this threaded
+	 * handler, so disable_irq_nosync here ensures the IRQ stays disabled
+	 * even after IRQF_ONESHOT unmasks on return.
+	 */
+	disable_irq_nosync(st->irq);
+
+	return IRQ_HANDLED;
+}
+
+static const struct iio_trigger_ops ad4691_trigger_ops = {
+	.validate_device = iio_trigger_validate_own_device,
+};
+
+static int ad4691_read_scan(struct iio_dev *indio_dev, s64 timestamp)
+{
+	struct ad4691_state *st = iio_priv(indio_dev);
+	int ret;
+
+	guard(mutex)(&st->lock);
+
+	ret = spi_sync(st->spi, &st->scan_msg);
+	if (ret)
+		return ret;
+
+	/*
+	 * rx_buf pointers in scan_xfers point directly into scan.vals, so no
+	 * copy is needed. The scan_msg already includes a STATE_RESET at the
+	 * end (appended in preenable), so no explicit reset is needed here.
+	 */
+	iio_push_to_buffers_with_ts(indio_dev, st->vals, sizeof(st->vals),
+				    timestamp);
+	return 0;
+}
+
+static irqreturn_t ad4691_trigger_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct ad4691_state *st = iio_priv(indio_dev);
+
+	ad4691_read_scan(indio_dev, pf->timestamp);
+	if (!st->manual_mode)
+		enable_irq(st->irq);
+	iio_trigger_notify_done(indio_dev->trig);
+	return IRQ_HANDLED;
+}
+
 static const struct iio_info ad4691_info = {
 	.read_raw = &ad4691_read_raw,
 	.write_raw = &ad4691_write_raw,
@@ -514,6 +910,18 @@ static const struct iio_info ad4691_info = {
 	.debugfs_reg_access = &ad4691_reg_access,
 };
 
+static int ad4691_pwm_setup(struct ad4691_state *st)
+{
+	struct device *dev = regmap_get_device(st->regmap);
+
+	st->conv_trigger = devm_pwm_get(dev, "cnv");
+	if (IS_ERR(st->conv_trigger))
+		return dev_err_probe(dev, PTR_ERR(st->conv_trigger),
+				     "Failed to get cnv pwm\n");
+
+	return ad4691_set_pwm_freq(st, st->info->max_rate);
+}
+
 static int ad4691_regulator_setup(struct ad4691_state *st)
 {
 	struct device *dev = regmap_get_device(st->regmap);
@@ -593,6 +1001,22 @@ static int ad4691_config(struct ad4691_state *st)
 	unsigned int val;
 	int ret;
 
+	/*
+	 * Determine buffer conversion mode from DT: if a PWM is provided it
+	 * drives the CNV pin (CNV_BURST_MODE); otherwise CNV is tied to CS
+	 * and each SPI transfer triggers a conversion (MANUAL_MODE).
+	 * Both modes idle in AUTONOMOUS mode so that read_raw can use the
+	 * internal oscillator without disturbing the hardware configuration.
+	 */
+	if (device_property_present(dev, "pwms")) {
+		st->manual_mode = false;
+		ret = ad4691_pwm_setup(st);
+		if (ret)
+			return ret;
+	} else {
+		st->manual_mode = true;
+	}
+
 	switch (st->vref_uV) {
 	case AD4691_VREF_uV_MIN ... AD4691_VREF_2P5_uV_MAX:
 		ref_val = AD4691_VREF_2P5;
@@ -646,6 +1070,75 @@ static int ad4691_config(struct ad4691_state *st)
 	return 0;
 }
 
+static int ad4691_setup_triggered_buffer(struct iio_dev *indio_dev,
+					 struct ad4691_state *st)
+{
+	struct device *dev = regmap_get_device(st->regmap);
+	struct iio_trigger *trig;
+	unsigned int i;
+	int irq, ret;
+
+	trig = devm_iio_trigger_alloc(dev, "%s-dev%d", indio_dev->name,
+				      iio_device_id(indio_dev));
+	if (!trig)
+		return -ENOMEM;
+
+	trig->ops = &ad4691_trigger_ops;
+	iio_trigger_set_drvdata(trig, st);
+
+	ret = devm_iio_trigger_register(dev, trig);
+	if (ret)
+		return dev_err_probe(dev, ret, "IIO trigger register failed\n");
+
+	indio_dev->trig = iio_trigger_get(trig);
+
+	if (st->manual_mode)
+		return devm_iio_triggered_buffer_setup(dev, indio_dev,
+						       &iio_pollfunc_store_time,
+						       &ad4691_trigger_handler,
+						       &ad4691_manual_buffer_setup_ops);
+
+	/*
+	 * The GP pin named in interrupt-names asserts at end-of-conversion.
+	 * The IRQ handler stops conversions and fires the IIO trigger so
+	 * the trigger handler can read and push the sample to the buffer.
+	 * The IRQ is kept disabled until the buffer is enabled.
+	 */
+	irq = -ENXIO;
+	for (i = 0; i < ARRAY_SIZE(ad4691_gp_names); i++) {
+		irq = fwnode_irq_get_byname(dev_fwnode(dev),
+					    ad4691_gp_names[i]);
+		if (irq > 0)
+			break;
+	}
+	if (irq < 0)
+		return dev_err_probe(dev, irq, "failed to get GP interrupt\n");
+
+	st->irq = irq;
+
+	ret = ad4691_gpio_setup(st, i);
+	if (ret)
+		return ret;
+
+	/*
+	 * IRQ is kept disabled until the buffer is enabled to prevent
+	 * spurious DATA_READY events before the SPI message is set up.
+	 */
+	ret = devm_request_threaded_irq(dev, irq, NULL,
+					&ad4691_irq,
+					IRQF_ONESHOT | IRQF_NO_AUTOEN,
+					indio_dev->name, indio_dev);
+	if (ret)
+		return ret;
+
+	return devm_iio_triggered_buffer_setup_ext(dev, indio_dev,
+						   &iio_pollfunc_store_time,
+						   &ad4691_trigger_handler,
+						   IIO_BUFFER_DIRECTION_IN,
+						   &ad4691_cnv_burst_buffer_setup_ops,
+						   ad4691_buffer_attrs);
+}
+
 static int ad4691_probe(struct spi_device *spi)
 {
 	struct device *dev = &spi->dev;
@@ -658,6 +1151,7 @@ static int ad4691_probe(struct spi_device *spi)
 		return -ENOMEM;
 
 	st = iio_priv(indio_dev);
+	st->spi = spi;
 	st->info = spi_get_device_match_data(spi);
 
 	ret = devm_mutex_init(dev, &st->lock);
@@ -685,8 +1179,9 @@ static int ad4691_probe(struct spi_device *spi)
 	indio_dev->info = &ad4691_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
-	indio_dev->channels = st->info->sw_info->channels;
-	indio_dev->num_channels = st->info->sw_info->num_channels;
+	ret = ad4691_setup_triggered_buffer(indio_dev, st);
+	if (ret)
+		return ret;
 
 	return devm_iio_device_register(dev, indio_dev);
 }

-- 
2.43.0



