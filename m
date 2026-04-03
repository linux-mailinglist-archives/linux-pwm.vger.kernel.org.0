Return-Path: <linux-pwm+bounces-8467-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0AsQGXeez2kTyAYAu9opvQ
	(envelope-from <linux-pwm+bounces-8467-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 03 Apr 2026 13:03:19 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1664B3937C3
	for <lists+linux-pwm@lfdr.de>; Fri, 03 Apr 2026 13:03:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9E6023022576
	for <lists+linux-pwm@lfdr.de>; Fri,  3 Apr 2026 11:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 667163AF670;
	Fri,  3 Apr 2026 11:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bx5xPCO7"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390F93AE1BE;
	Fri,  3 Apr 2026 11:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775214188; cv=none; b=Z1yZRjc/veyU1jsfEbASnUaCboy7Q76auHQZy9QDYfjzYMonx13wNGOqEbg2mt9JcaTtwI8YvKRCybyFgNviLzPW0iOduG0vezh1hl/RUHm1+0Kq44+uLFkBDfjm0ksztiH5kScLkLsNNYeKB2MIT+V955VfXS6VYuL0h9dnLo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775214188; c=relaxed/simple;
	bh=zRDhEJXVnPTmjHSAeDumv5b+OWQShn5aj7Q+CK7wHfs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RoSowOpnEumDPeAr/vFdfGAR1ZQQz2FhXMAinCEJ3i+P3RYQov5kyQnxbALpSnAY2dlU29rZQZLyV0t3jx8xBNy0NF9cwl9AeiEjPhVWcBFLgxCdq5rFxZKbbItofAzg0kxkIo3uLLmPBJUhYWVNSFTRB1ecUfmKTABMltMt2Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bx5xPCO7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D2BBBC2BCB9;
	Fri,  3 Apr 2026 11:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775214187;
	bh=zRDhEJXVnPTmjHSAeDumv5b+OWQShn5aj7Q+CK7wHfs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Bx5xPCO7vPS+swiQi9Gcg5COm7AFds4EWjMWPQvnrUgo68hxaExcRJOVR64uoHjNa
	 IX6jwMsgylHdhtUCGhmDFZEz5+bOvxTG2gs+e/b1TXWS6X4Pp4FazLzvfEj+qjrlAI
	 eJ1obufMTkZcxipdtUPehU7NOQNXukWn7syfrDEQNVfrs2phvTEP+Zllr3sOQ3q36X
	 aeJLkSqtduVJ+OPuePyJfsQDpGooQJMRd0qsswGJaPy3Js2+1Pia7vi+McRzX3j+77
	 ryPi68XRhYjUgSwp/WHwEHxEKzNkW5LZhq8fzDCvW2xlGicjzvAVWZFV+DFK1k5gU3
	 PwMXHh8rhiBNQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CADDBE7E370;
	Fri,  3 Apr 2026 11:03:07 +0000 (UTC)
From: Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org>
Date: Fri, 03 Apr 2026 14:03:04 +0300
Subject: [PATCH v6 3/4] iio: adc: ad4691: add triggered buffer support
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260403-ad4692-multichannel-sar-adc-driver-v6-3-fa2a01a57c4e@analog.com>
References: <20260403-ad4692-multichannel-sar-adc-driver-v6-0-fa2a01a57c4e@analog.com>
In-Reply-To: <20260403-ad4692-multichannel-sar-adc-driver-v6-0-fa2a01a57c4e@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775214183; l=25109;
 i=radu.sabau@analog.com; s=20260220; h=from:subject:message-id;
 bh=C3zDIxo0viTjieA5qLuZiPKH/bBIFvW3G2tmeA2RCl4=;
 b=Z+otqqMYN6nBrMlM4Fjt7rouDEta0KpXaSX6KIx9Rcr3P44tOYs1tOLsGlVk0pMU+K8M0eAGs
 nSqoSkU4JUHAYXIZejCfdT1xx8aLMhglGMjYEL3fp+dSktSmawuUrd8
X-Developer-Key: i=radu.sabau@analog.com; a=ed25519;
 pk=lDPQHgn9jTdt0vo58Na9lLxLaE2mb330if71Cn+EvFU=
X-Endpoint-Received: by B4 Relay for radu.sabau@analog.com/20260220 with
 auth_id=642
X-Original-From: Radu Sabau <radu.sabau@analog.com>
Reply-To: radu.sabau@analog.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8467-lists,linux-pwm=lfdr.de,radu.sabau.analog.com];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	HAS_REPLYTO(0.00)[radu.sabau@analog.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1664B3937C3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
 drivers/iio/adc/ad4691.c | 592 ++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 592 insertions(+), 2 deletions(-)

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
index 43bd408c3d11..f2a7273e43b9 100644
--- a/drivers/iio/adc/ad4691.c
+++ b/drivers/iio/adc/ad4691.c
@@ -5,15 +5,19 @@
  */
 #include <linux/array_size.h>
 #include <linux/bitfield.h>
+#include <linux/bitmap.h>
 #include <linux/bitops.h>
 #include <linux/cleanup.h>
 #include <linux/delay.h>
 #include <linux/dev_printk.h>
 #include <linux/device/devres.h>
 #include <linux/err.h>
+#include <linux/interrupt.h>
 #include <linux/math.h>
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
+#include <linux/property.h>
+#include <linux/pwm.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 #include <linux/reset.h>
@@ -21,7 +25,12 @@
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
@@ -30,6 +39,8 @@
 #define AD4691_VREF_3P3_uV_MAX			3750000
 #define AD4691_VREF_4P096_uV_MAX		4500000
 
+#define AD4691_CNV_DUTY_CYCLE_NS		380
+
 #define AD4691_SPI_CONFIG_A_REG			0x000
 #define AD4691_SW_RESET				(BIT(7) | BIT(0))
 
@@ -37,6 +48,7 @@
 #define AD4691_CLAMP_STATUS1_REG		0x01A
 #define AD4691_CLAMP_STATUS2_REG		0x01B
 #define AD4691_DEVICE_SETUP			0x020
+#define AD4691_MANUAL_MODE			BIT(2)
 #define AD4691_LDO_EN				BIT(4)
 #define AD4691_REF_CTRL				0x021
 #define AD4691_REF_CTRL_MASK			GENMASK(4, 2)
@@ -44,13 +56,18 @@
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
@@ -60,6 +77,8 @@
 #define AD4691_ACC_DEPTH_IN(n)			(0x186 + (n))
 #define AD4691_GPIO_MODE1_REG			0x196
 #define AD4691_GPIO_MODE2_REG			0x197
+#define AD4691_GP_MODE_MASK			GENMASK(3, 0)
+#define AD4691_GP_MODE_DATA_READY		0x06
 #define AD4691_GPIO_READ			0x1A0
 #define AD4691_ACC_STATUS_FULL1_REG		0x1B0
 #define AD4691_ACC_STATUS_FULL2_REG		0x1B1
@@ -95,9 +114,11 @@ struct ad4691_chip_info {
 		.type = IIO_VOLTAGE,					\
 		.indexed = 1,						\
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW)		\
-				    | BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
+				    | BIT(IIO_CHAN_INFO_SAMP_FREQ)	\
+				    | BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),	\
 		.info_mask_separate_available =				\
-				      BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
+				      BIT(IIO_CHAN_INFO_SAMP_FREQ)	\
+				    | BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),	\
 		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SCALE),	\
 		.channel = ch,						\
 		.scan_index = ch,					\
@@ -125,6 +146,7 @@ static const struct iio_chan_spec ad4691_channels[] = {
 	AD4691_CHANNEL(13),
 	AD4691_CHANNEL(14),
 	AD4691_CHANNEL(15),
+	IIO_CHAN_SOFT_TIMESTAMP(16),
 };
 
 static const struct iio_chan_spec ad4693_channels[] = {
@@ -136,6 +158,7 @@ static const struct iio_chan_spec ad4693_channels[] = {
 	AD4691_CHANNEL(5),
 	AD4691_CHANNEL(6),
 	AD4691_CHANNEL(7),
+	IIO_CHAN_SOFT_TIMESTAMP(8),
 };
 
 /*
@@ -162,6 +185,14 @@ static const int ad4691_osc_freqs_Hz[] = {
 	[0xF] = 1250,
 };
 
+static const char * const ad4691_gp_names[] = { "gp0", "gp1", "gp2", "gp3" };
+
+/*
+ * Valid ACC_DEPTH values where the effective divisor equals the count.
+ * From Table 13: ACC_DEPTH = 2^N yields right-shift = N, divisor = 2^N.
+ */
+static const int ad4691_oversampling_ratios[] = { 1, 2, 4, 8, 16, 32 };
+
 static const struct ad4691_chip_info ad4691_chip_info = {
 	.channels = ad4691_channels,
 	.name = "ad4691",
@@ -193,16 +224,55 @@ static const struct ad4691_chip_info ad4694_chip_info = {
 struct ad4691_state {
 	const struct ad4691_chip_info *info;
 	struct regmap *regmap;
+
+	struct pwm_device *conv_trigger;
+	int irq;
+
+	bool manual_mode;
+
 	int vref_uV;
+	u8 osr[16];
 	bool refbuf_en;
 	bool ldo_en;
+	u32 cnv_period_ns;
 	/*
 	 * Synchronize access to members of the driver state, and ensure
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
+	struct spi_transfer *scan_xfers;
+	__be16 *scan_tx;
+	__be16 *scan_rx;
+	/* Scan buffer: one slot per channel plus timestamp */
+	struct {
+		u16 vals[16];
+		aligned_s64 ts;
+	} scan __aligned(IIO_DMA_MINALIGN);
 };
 
+/*
+ * Configure the given GP pin (0-3) as DATA_READY output.
+ * GP0/GP1 → GPIO_MODE1_REG, GP2/GP3 → GPIO_MODE2_REG.
+ * Even pins occupy bits [3:0], odd pins bits [7:4].
+ */
+static int ad4691_gpio_setup(struct ad4691_state *st, unsigned int gp_num)
+{
+	unsigned int shift = 4 * (gp_num % 2);
+
+	return regmap_update_bits(st->regmap,
+				  AD4691_GPIO_MODE1_REG + gp_num / 2,
+				  AD4691_GP_MODE_MASK << shift,
+				  AD4691_GP_MODE_DATA_READY << shift);
+}
+
 static int ad4691_reg_read(void *context, unsigned int reg, unsigned int *val)
 {
 	struct spi_device *spi = context;
@@ -362,6 +432,24 @@ static int ad4691_set_sampling_freq(struct iio_dev *indio_dev, int freq)
 	return -EINVAL;
 }
 
+static int ad4691_set_oversampling_ratio(struct iio_dev *indio_dev,
+					 const struct iio_chan_spec *chan,
+					 int osr)
+{
+	struct ad4691_state *st = iio_priv(indio_dev);
+
+	if (osr < 1 || osr > 32 || !is_power_of_2(osr))
+		return -EINVAL;
+
+	IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
+	if (IIO_DEV_ACQUIRE_FAILED(claim))
+		return -EBUSY;
+
+	st->osr[chan->scan_index] = osr;
+	return regmap_write(st->regmap,
+			    AD4691_ACC_DEPTH_IN(chan->scan_index), osr);
+}
+
 static int ad4691_read_avail(struct iio_dev *indio_dev,
 			     struct iio_chan_spec const *chan,
 			     const int **vals, int *type,
@@ -376,6 +464,11 @@ static int ad4691_read_avail(struct iio_dev *indio_dev,
 		*type = IIO_VAL_INT;
 		*length = ARRAY_SIZE(ad4691_osc_freqs_Hz) - start;
 		return IIO_AVAIL_LIST;
+	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+		*vals = ad4691_oversampling_ratios;
+		*type = IIO_VAL_INT;
+		*length = ARRAY_SIZE(ad4691_oversampling_ratios);
+		return IIO_AVAIL_LIST;
 	default:
 		return -EINVAL;
 	}
@@ -406,6 +499,11 @@ static int ad4691_single_shot_read(struct iio_dev *indio_dev,
 	if (ret)
 		return ret;
 
+	ret = regmap_write(st->regmap, AD4691_ACC_DEPTH_IN(chan->scan_index),
+			   st->osr[chan->scan_index]);
+	if (ret)
+		return ret;
+
 	ret = regmap_read(st->regmap, AD4691_OSC_FREQ_REG, &reg_val);
 	if (ret)
 		return ret;
@@ -452,6 +550,9 @@ static int ad4691_read_raw(struct iio_dev *indio_dev,
 	}
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		return ad4691_get_sampling_freq(st, val);
+	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+		*val = st->osr[chan->scan_index];
+		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
 		*val = st->vref_uV / (MICRO / MILLI);
 		*val2 = chan->scan_type.realbits;
@@ -468,6 +569,8 @@ static int ad4691_write_raw(struct iio_dev *indio_dev,
 	switch (mask) {
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		return ad4691_set_sampling_freq(indio_dev, val);
+	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+		return ad4691_set_oversampling_ratio(indio_dev, chan, val);
 	default:
 		return -EINVAL;
 	}
@@ -486,6 +589,385 @@ static int ad4691_reg_access(struct iio_dev *indio_dev, unsigned int reg,
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
+static void ad4691_free_scan_bufs(struct ad4691_state *st)
+{
+	kfree(st->scan_xfers);
+	kfree(st->scan_tx);
+	kfree(st->scan_rx);
+}
+
+static int ad4691_manual_buffer_preenable(struct iio_dev *indio_dev)
+{
+	struct ad4691_state *st = iio_priv(indio_dev);
+	struct device *dev = regmap_get_device(st->regmap);
+	struct spi_device *spi = to_spi_device(dev);
+	unsigned int n_active = bitmap_weight(indio_dev->active_scan_mask,
+					      iio_get_masklength(indio_dev));
+	unsigned int n_xfers = n_active + 1;
+	unsigned int k, i;
+	int ret;
+
+	st->scan_xfers = kcalloc(n_xfers, sizeof(*st->scan_xfers), GFP_KERNEL);
+	if (!st->scan_xfers)
+		return -ENOMEM;
+
+	st->scan_tx = kcalloc(n_xfers, sizeof(*st->scan_tx), GFP_KERNEL);
+	if (!st->scan_tx) {
+		kfree(st->scan_xfers);
+		return -ENOMEM;
+	}
+
+	st->scan_rx = kcalloc(n_xfers, sizeof(*st->scan_rx), GFP_KERNEL);
+	if (!st->scan_rx) {
+		kfree(st->scan_tx);
+		kfree(st->scan_xfers);
+		return -ENOMEM;
+	}
+
+	spi_message_init(&st->scan_msg);
+
+	k = 0;
+	iio_for_each_active_channel(indio_dev, i) {
+		st->scan_tx[k] = cpu_to_be16(AD4691_ADC_CHAN(i));
+		st->scan_xfers[k].tx_buf = &st->scan_tx[k];
+		st->scan_xfers[k].rx_buf = &st->scan_rx[k];
+		st->scan_xfers[k].len = sizeof(__be16);
+		st->scan_xfers[k].cs_change = 1;
+		spi_message_add_tail(&st->scan_xfers[k], &st->scan_msg);
+		k++;
+	}
+
+	/* Final NOOP transfer to retrieve last channel's result. */
+	st->scan_tx[k] = cpu_to_be16(AD4691_NOOP);
+	st->scan_xfers[k].tx_buf = &st->scan_tx[k];
+	st->scan_xfers[k].rx_buf = &st->scan_rx[k];
+	st->scan_xfers[k].len = sizeof(__be16);
+	spi_message_add_tail(&st->scan_xfers[k], &st->scan_msg);
+
+	st->scan_msg.spi = spi;
+
+	ret = spi_optimize_message(spi, &st->scan_msg);
+	if (ret) {
+		ad4691_free_scan_bufs(st);
+		return ret;
+	}
+
+	ret = ad4691_enter_conversion_mode(st);
+	if (ret) {
+		spi_unoptimize_message(&st->scan_msg);
+		ad4691_free_scan_bufs(st);
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
+	ad4691_free_scan_bufs(st);
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
+	struct device *dev = regmap_get_device(st->regmap);
+	struct spi_device *spi = to_spi_device(dev);
+	unsigned int n_active = bitmap_weight(indio_dev->active_scan_mask,
+					      iio_get_masklength(indio_dev));
+	unsigned int bit, k, i;
+	int ret;
+
+	st->scan_xfers = kcalloc(2 * n_active, sizeof(*st->scan_xfers), GFP_KERNEL);
+	if (!st->scan_xfers)
+		return -ENOMEM;
+
+	st->scan_tx = kcalloc(n_active, sizeof(*st->scan_tx), GFP_KERNEL);
+	if (!st->scan_tx) {
+		kfree(st->scan_xfers);
+		return -ENOMEM;
+	}
+
+	st->scan_rx = kcalloc(n_active, sizeof(*st->scan_rx), GFP_KERNEL);
+	if (!st->scan_rx) {
+		kfree(st->scan_tx);
+		kfree(st->scan_xfers);
+		return -ENOMEM;
+	}
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
+		st->scan_xfers[2 * k + 1].rx_buf = &st->scan_rx[k];
+		st->scan_xfers[2 * k + 1].len = sizeof(__be16);
+		if (k < n_active - 1)
+			st->scan_xfers[2 * k + 1].cs_change = 1;
+		spi_message_add_tail(&st->scan_xfers[2 * k + 1], &st->scan_msg);
+		k++;
+	}
+
+	st->scan_msg.spi = spi;
+
+	ret = spi_optimize_message(spi, &st->scan_msg);
+	if (ret)
+		goto err_free_bufs;
+
+	ret = regmap_write(st->regmap, AD4691_STD_SEQ_CONFIG,
+			   bitmap_read(indio_dev->active_scan_mask, 0,
+				       iio_get_masklength(indio_dev)));
+	if (ret)
+		goto err;
+
+	ret = regmap_write(st->regmap, AD4691_ACC_MASK_REG,
+			   ~bitmap_read(indio_dev->active_scan_mask, 0,
+				iio_get_masklength(indio_dev)) & GENMASK(15, 0));
+	if (ret)
+		goto err;
+
+	iio_for_each_active_channel(indio_dev, bit) {
+		ret = regmap_write(st->regmap, AD4691_ACC_DEPTH_IN(bit),
+				   st->osr[bit]);
+		if (ret)
+			goto err;
+	}
+
+	ret = ad4691_enter_conversion_mode(st);
+	if (ret)
+		goto err;
+
+	ret = ad4691_sampling_enable(st, true);
+	if (ret)
+		goto err;
+
+	enable_irq(st->irq);
+	return 0;
+err:
+	spi_unoptimize_message(&st->scan_msg);
+err_free_bufs:
+	ad4691_free_scan_bufs(st);
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
+	ret = regmap_write(st->regmap, AD4691_STD_SEQ_CONFIG,
+			   AD4691_SEQ_ALL_CHANNELS_OFF);
+	if (ret)
+		return ret;
+
+	ret = ad4691_exit_conversion_mode(st);
+	spi_unoptimize_message(&st->scan_msg);
+	ad4691_free_scan_bufs(st);
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
+	return sysfs_emit(buf, "%u\n", (u32)(NSEC_PER_SEC / st->cnv_period_ns));
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
+	guard(mutex)(&st->lock);
+
+	if (iio_buffer_enabled(indio_dev))
+		return -EBUSY;
+
+	ret = ad4691_set_pwm_freq(st, freq);
+	if (ret)
+		return ret;
+
+	return len;
+}
+
+static IIO_DEVICE_ATTR(sampling_frequency, 0644,
+		       sampling_frequency_show,
+		       sampling_frequency_store, 0);
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
+	/*
+	 * GPx has asserted: stop conversions before reading so the
+	 * accumulator does not continue sampling while the trigger handler
+	 * processes the data. Then fire the IIO trigger to push the sample
+	 * to the buffer.
+	 */
+	ad4691_sampling_enable(st, false);
+	iio_trigger_poll(indio_dev->trig);
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
+	unsigned int i, k = 0;
+	int ret;
+
+	guard(mutex)(&st->lock);
+
+	ret = spi_sync(st->scan_msg.spi, &st->scan_msg);
+	if (ret)
+		return ret;
+
+	if (st->manual_mode) {
+		iio_for_each_active_channel(indio_dev, i) {
+			st->scan.vals[i] = be16_to_cpu(st->scan_rx[k + 1]);
+			k++;
+		}
+	} else {
+		iio_for_each_active_channel(indio_dev, i) {
+			st->scan.vals[i] = be16_to_cpu(st->scan_rx[k]);
+			k++;
+		}
+
+		ret = regmap_write(st->regmap, AD4691_STATE_RESET_REG,
+				   AD4691_STATE_RESET_ALL);
+		if (ret)
+			return ret;
+
+		ret = ad4691_sampling_enable(st, true);
+		if (ret)
+			return ret;
+	}
+
+	iio_push_to_buffers_with_ts(indio_dev, &st->scan, sizeof(st->scan),
+				    timestamp);
+	return 0;
+}
+
+static irqreturn_t ad4691_trigger_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+
+	ad4691_read_scan(indio_dev, pf->timestamp);
+	iio_trigger_notify_done(indio_dev->trig);
+	return IRQ_HANDLED;
+}
+
 static const struct iio_info ad4691_info = {
 	.read_raw = &ad4691_read_raw,
 	.write_raw = &ad4691_write_raw,
@@ -493,6 +975,18 @@ static const struct iio_info ad4691_info = {
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
@@ -558,6 +1052,22 @@ static int ad4691_config(struct ad4691_state *st)
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
@@ -613,6 +1123,78 @@ static int ad4691_config(struct ad4691_state *st)
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
+	trig = devm_iio_trigger_alloc(dev, "%s-dev%d",
+				      indio_dev->name,
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
+	if (!st->manual_mode) {
+		/*
+		 * The GP pin named in interrupt-names asserts at end-of-conversion.
+		 * The IRQ handler stops conversions and fires the IIO trigger so
+		 * the trigger handler can read and push the sample to the buffer.
+		 * The IRQ is kept disabled until the buffer is enabled.
+		 */
+		irq = -ENODEV;
+		for (i = 0; i < ARRAY_SIZE(ad4691_gp_names); i++) {
+			irq = fwnode_irq_get_byname(dev_fwnode(dev),
+						    ad4691_gp_names[i]);
+			if (irq > 0)
+				break;
+		}
+		if (irq <= 0)
+			return dev_err_probe(dev, irq < 0 ? irq : -ENODEV,
+					     "failed to get GP interrupt\n");
+
+		st->irq = irq;
+
+		ret = ad4691_gpio_setup(st, i);
+		if (ret)
+			return ret;
+
+		/*
+		 * IRQ is kept disabled until the buffer is enabled to prevent
+		 * spurious DATA_READY events before the SPI message is set up.
+		 */
+		ret = devm_request_threaded_irq(dev, irq, NULL,
+						&ad4691_irq,
+						IRQF_ONESHOT | IRQF_NO_AUTOEN,
+						indio_dev->name, indio_dev);
+		if (ret)
+			return ret;
+
+		return devm_iio_triggered_buffer_setup_ext(dev, indio_dev,
+							   &iio_pollfunc_store_time,
+							   &ad4691_trigger_handler,
+							   IIO_BUFFER_DIRECTION_IN,
+							   &ad4691_cnv_burst_buffer_setup_ops,
+							   ad4691_buffer_attrs);
+	}
+
+	return devm_iio_triggered_buffer_setup(dev, indio_dev,
+					       &iio_pollfunc_store_time,
+					       &ad4691_trigger_handler,
+					       &ad4691_manual_buffer_setup_ops);
+}
+
 static int ad4691_probe(struct spi_device *spi)
 {
 	struct device *dev = &spi->dev;
@@ -627,6 +1209,8 @@ static int ad4691_probe(struct spi_device *spi)
 	st = iio_priv(indio_dev);
 	st->info = spi_get_device_match_data(spi);
 
+	memset(st->osr, 1, sizeof(st->osr));
+
 	ret = devm_mutex_init(dev, &st->lock);
 	if (ret)
 		return ret;
@@ -655,6 +1239,10 @@ static int ad4691_probe(struct spi_device *spi)
 	indio_dev->channels = st->info->channels;
 	indio_dev->num_channels = st->info->num_channels;
 
+	ret = ad4691_setup_triggered_buffer(indio_dev, st);
+	if (ret)
+		return ret;
+
 	return devm_iio_device_register(dev, indio_dev);
 }
 

-- 
2.43.0



