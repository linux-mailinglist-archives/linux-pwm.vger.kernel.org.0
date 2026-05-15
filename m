Return-Path: <linux-pwm+bounces-8888-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wGKLAZYhB2rnrgIAu9opvQ
	(envelope-from <linux-pwm+bounces-8888-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 15 May 2026 15:37:26 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DC32C5508DF
	for <lists+linux-pwm@lfdr.de>; Fri, 15 May 2026 15:37:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6F139302D93F
	for <lists+linux-pwm@lfdr.de>; Fri, 15 May 2026 13:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C4D3CE4BA;
	Fri, 15 May 2026 13:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mtHFL+I5"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02183B0AD6;
	Fri, 15 May 2026 13:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778851894; cv=none; b=JNd6kwyJJgTvjEZoyvDTkaJqQedHxL3hYDG3XTHAi3oGuKAiAr9c8Ph3ivES2RrORJlfHXdadXbn1ZXVmuAE9kIjlTa8oPkHqO/kBTUMu8O4Fr8/scJmf76SDbuCxR4cjnR53PaHbebqJRtkqgSBPSx9KKx+DRcEcEE84mNdHVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778851894; c=relaxed/simple;
	bh=MszLh/KpWtrmTI44XuntwvPVfxpvszRbpvllklN5uFQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rp5FYrMHIti7QZIRnplTcDzMMYHUNkId6sY0dA3GrcCqPdk9l0t46a5dpYGmioH6Mj/t41BRvxKxkJTNR/0JcyDb/12HRyiS4HOINf6w+833Rm9B6TITG+9pX386XxLyYEDt8TpUvqVj6lrxsgfWyLJnaOvvrr4lPEYhJEW9chs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mtHFL+I5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 82535C4AF16;
	Fri, 15 May 2026 13:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778851894;
	bh=MszLh/KpWtrmTI44XuntwvPVfxpvszRbpvllklN5uFQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=mtHFL+I52jUItbAkn7r8Fq5acO2Of16YHBzJPw86QtzEJxGhcYAiUu7UamQ/76lRV
	 9099EZn5xANew6pFC1rSJ+mPGQgLUx8pM3PgO5YY1cHzBo1I71Ai3jnTWrwPLITsEH
	 E2IPn3GpxTEgGIRQhkyfCfiQIhnSunScF8QLlV5tD8KNNBIJZjNigd56no1meG9+9q
	 lDUA3Fv3vFefiLkbh/fyOjhJxuljfpoo19nxa2pYDvNrB03l1QKMjr+zFludJip7zq
	 y4+KqBNtM7q59PnDwuzMqpxTKIZCX7XoOg/bEc7LFUkazCa4OUdm3JOzJqz8zSwpeF
	 T9j4AvyZOaQwA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A7FDCD4F48;
	Fri, 15 May 2026 13:31:34 +0000 (UTC)
From: Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org>
Date: Fri, 15 May 2026 16:31:32 +0300
Subject: [PATCH v11 3/6] iio: adc: ad4691: add triggered buffer support
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260515-ad4692-multichannel-sar-adc-driver-v11-3-eab27d852ac2@analog.com>
References: <20260515-ad4692-multichannel-sar-adc-driver-v11-0-eab27d852ac2@analog.com>
In-Reply-To: <20260515-ad4692-multichannel-sar-adc-driver-v11-0-eab27d852ac2@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778851890; l=26073;
 i=radu.sabau@analog.com; s=20260220; h=from:subject:message-id;
 bh=1lYzihS5ad/1urESHAJNiHQfBpXxwQnMbbhGiJxLlYc=;
 b=whvpb0z+A55eykFnBpQn4me2obJEKjZsL57W2DRCgkLyBu4GS3uIeTHOJryHr67pY4Oz5HDKw
 Y825TqR/UbcAWtM8SvL1Cq+w3wt66VLPybYpMzB4mNC4ihYTKVvoYdA
X-Developer-Key: i=radu.sabau@analog.com; a=ed25519;
 pk=lDPQHgn9jTdt0vo58Na9lLxLaE2mb330if71Cn+EvFU=
X-Endpoint-Received: by B4 Relay for radu.sabau@analog.com/20260220 with
 auth_id=642
X-Original-From: Radu Sabau <radu.sabau@analog.com>
Reply-To: radu.sabau@analog.com
X-Rspamd-Queue-Id: DC32C5508DF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8888-lists,linux-pwm=lfdr.de,radu.sabau.analog.com];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	HAS_REPLYTO(0.00)[radu.sabau@analog.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,analog.com:email,analog.com:mid,analog.com:replyto]
X-Rspamd-Action: no action

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
one big-endian 16-bit (__be16) slot per active channel, densely packed
in scan_index order, followed by a timestamp.

The CNV Burst Mode sampling frequency (PWM period) is exposed as a
buffer-level attribute via IIO_DEVICE_ATTR.

Signed-off-by: Radu Sabau <radu.sabau@analog.com>
---
 drivers/iio/adc/Kconfig  |   2 +
 drivers/iio/adc/ad4691.c | 592 +++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 580 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 5e601a87e5f3..484363458658 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -143,6 +143,8 @@ config AD4691
 	tristate "Analog Devices AD4691 Family ADC Driver"
 	depends on SPI
 	depends on REGULATOR || COMPILE_TEST
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
 	select REGMAP
 	help
 	  Say yes here to build support for Analog Devices AD4691 Family MuxSAR
diff --git a/drivers/iio/adc/ad4691.c b/drivers/iio/adc/ad4691.c
index ba77e1bfef16..bf27d5f33a49 100644
--- a/drivers/iio/adc/ad4691.c
+++ b/drivers/iio/adc/ad4691.c
@@ -5,24 +5,35 @@
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
+#include <linux/kstrtox.h>
 #include <linux/limits.h>
 #include <linux/math.h>
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
+#include <linux/property.h>
+#include <linux/pwm.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 #include <linux/reset.h>
+#include <linux/string.h>
 #include <linux/spi/spi.h>
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
@@ -31,6 +42,9 @@
 #define AD4691_VREF_3P3_uV_MAX			3750000
 #define AD4691_VREF_4P096_uV_MAX		4500000
 
+#define AD4691_CNV_DUTY_CYCLE_NS		380
+#define AD4691_CNV_HIGH_TIME_NS			430
+
 #define AD4691_SPI_CONFIG_A_REG			0x000
 #define AD4691_SW_RESET				(BIT(7) | BIT(0))
 
@@ -38,6 +52,7 @@
 #define AD4691_CLAMP_STATUS1_REG		0x01A
 #define AD4691_CLAMP_STATUS2_REG		0x01B
 #define AD4691_DEVICE_SETUP			0x020
+#define AD4691_MANUAL_MODE			BIT(2)
 #define AD4691_LDO_EN				BIT(4)
 #define AD4691_REF_CTRL				0x021
 #define AD4691_REF_CTRL_MASK			GENMASK(4, 2)
@@ -45,13 +60,18 @@
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
@@ -61,6 +81,8 @@
 #define AD4691_ACC_DEPTH_IN(n)			(0x186 + (n))
 #define AD4691_GPIO_MODE1_REG			0x196
 #define AD4691_GPIO_MODE2_REG			0x197
+#define AD4691_GP_MODE_MASK			GENMASK(3, 0)
+#define AD4691_GP_MODE_DATA_READY		0x06
 #define AD4691_GPIO_READ			0x1A0
 #define AD4691_ACC_STATUS_FULL1_REG		0x1B0
 #define AD4691_ACC_STATUS_FULL2_REG		0x1B1
@@ -110,6 +132,7 @@ struct ad4691_chip_info {
 			.sign = 'u',					\
 			.realbits = 16,					\
 			.storagebits = 16,				\
+			.endianness = IIO_BE,				\
 		},							\
 	}
 
@@ -130,6 +153,7 @@ static const struct iio_chan_spec ad4691_channels[] = {
 	AD4691_CHANNEL(13),
 	AD4691_CHANNEL(14),
 	AD4691_CHANNEL(15),
+	IIO_CHAN_SOFT_TIMESTAMP(16),
 };
 
 static const struct iio_chan_spec ad4693_channels[] = {
@@ -141,6 +165,17 @@ static const struct iio_chan_spec ad4693_channels[] = {
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
@@ -167,15 +202,7 @@ static const int ad4691_osc_freqs_Hz[] = {
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
@@ -204,7 +231,14 @@ static const struct ad4691_chip_info ad4694_chip_info = {
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
@@ -212,8 +246,56 @@ struct ad4691_state {
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
+	/*
+	 * max 16 + 1 NOOP (manual) or 2*16 + 1 state-reset (CNV burst).
+	 */
+	struct spi_transfer scan_xfers[34];
+	/*
+	 * CNV burst: 16 AVG_IN addresses = 16.  Manual: 16 channel cmds +
+	 * 1 NOOP = 17.  Stored as native u16; put_unaligned_be16() fills each
+	 * slot so the SPI controller (bits_per_word=8) sends bytes MSB-first.
+	 */
+	u16 scan_tx[17] __aligned(IIO_DMA_MINALIGN);
+	/*
+	 * CNV burst state-reset: 4-byte write [addr_hi, addr_lo,
+	 * STATE_RESET_ALL, OSC_EN=1]. CS is asserted throughout, so
+	 * ADDR_DESCENDING writes byte[3]=1 to OSC_EN_REG (0x180) as a
+	 * deliberate side-write, keeping the oscillator enabled. Shared
+	 * with the offload path (mutually exclusive at probe).
+	 */
+	u8 scan_tx_reset[4] __aligned(IIO_DMA_MINALIGN);
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
@@ -534,13 +616,405 @@ static int ad4691_reg_access(struct iio_dev *indio_dev, unsigned int reg,
 	return regmap_write(st->regmap, reg, writeval);
 }
 
-static const struct iio_info ad4691_info = {
+static int ad4691_set_pwm_freq(struct ad4691_state *st, unsigned int freq)
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
+	unsigned int k, i;
+	int ret;
+
+	memset(st->scan_xfers, 0, sizeof(st->scan_xfers));
+	memset(st->scan_tx, 0, sizeof(st->scan_tx));
+
+	spi_message_init(&st->scan_msg);
+
+	k = 0;
+	iio_for_each_active_channel(indio_dev, i) {
+		if (i >= indio_dev->num_channels - 1)
+			break; /* skip soft timestamp */
+		/*
+		 * Channel-select command occupies the first (high) byte of the
+		 * 16-bit DIN frame; the second byte is a don't-care zero pad.
+		 * put_unaligned_be16() writes [cmd, 0x00] in memory so the
+		 * SPI controller sends the command byte first on the wire.
+		 */
+		put_unaligned_be16((u16)(AD4691_ADC_CHAN(i) << 8), &st->scan_tx[k]);
+		st->scan_xfers[k].tx_buf = &st->scan_tx[k];
+		/*
+		 * The pipeline means xfer[0] receives the residual from the
+		 * previous sequence, not a valid sample. Discard it (rx_buf=NULL)
+		 * to avoid aliasing vals[0] across two concurrent DMA mappings.
+		 * xfer[1] (or the NOOP when only one channel is active) writes
+		 * the real ch[0] result to vals[0]. Subsequent transfers write
+		 * into vals[k-1] so each result lands at the next dense slot.
+		 */
+		st->scan_xfers[k].rx_buf = (k == 0) ? NULL : &st->vals[k - 1];
+		st->scan_xfers[k].len = sizeof(st->scan_tx[k]);
+		st->scan_xfers[k].cs_change = 1;
+		st->scan_xfers[k].cs_change_delay.value = AD4691_CNV_HIGH_TIME_NS;
+		st->scan_xfers[k].cs_change_delay.unit = SPI_DELAY_UNIT_NSECS;
+		spi_message_add_tail(&st->scan_xfers[k], &st->scan_msg);
+		k++;
+	}
+
+	/* Final NOOP transfer retrieves the last channel's result. */
+	st->scan_xfers[k].tx_buf = &st->scan_tx[k]; /* scan_tx[k] == 0 == NOOP */
+	st->scan_xfers[k].rx_buf = &st->vals[k - 1];
+	st->scan_xfers[k].len = sizeof(st->scan_tx[k]);
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
+	unsigned int acc_mask, std_seq_config;
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
+		if (i >= indio_dev->num_channels - 1)
+			break; /* skip soft timestamp */
+		put_unaligned_be16(0x8000 | AD4691_AVG_IN(i), &st->scan_tx[k]);
+		st->scan_xfers[2 * k].tx_buf = &st->scan_tx[k];
+		st->scan_xfers[2 * k].len = sizeof(st->scan_tx[k]);
+		spi_message_add_tail(&st->scan_xfers[2 * k], &st->scan_msg);
+		st->scan_xfers[2 * k + 1].rx_buf = &st->vals[k];
+		st->scan_xfers[2 * k + 1].len = sizeof(st->scan_tx[k]);
+		st->scan_xfers[2 * k + 1].cs_change = 1;
+		spi_message_add_tail(&st->scan_xfers[2 * k + 1], &st->scan_msg);
+		k++;
+	}
+
+	/*
+	 * Append a 4-byte state-reset transfer [addr_hi, addr_lo,
+	 * STATE_RESET_ALL, OSC_EN=1]. CS is asserted throughout, so
+	 * ADDR_DESCENDING writes byte[3]=1 to OSC_EN_REG (0x180) as a
+	 * deliberate side-write, keeping the oscillator enabled.
+	 * STATE_RESET_ALL starts the next burst; the hardware does not
+	 * accumulate new conversions until after a STATE_RESET pulse, so
+	 * no in-progress data is lost.  No cs_change here — CS must
+	 * deassert normally at end of message to frame the next command.
+	 */
+	put_unaligned_be16(AD4691_STATE_RESET_REG, st->scan_tx_reset);
+	st->scan_tx_reset[2] = AD4691_STATE_RESET_ALL;
+	st->scan_tx_reset[3] = 1;
+	st->scan_xfers[2 * k].tx_buf = st->scan_tx_reset;
+	st->scan_xfers[2 * k].len = sizeof(st->scan_tx_reset);
+	spi_message_add_tail(&st->scan_xfers[2 * k], &st->scan_msg);
+
+	ret = spi_optimize_message(st->spi, &st->scan_msg);
+	if (ret)
+		return ret;
+
+	std_seq_config = bitmap_read(indio_dev->active_scan_mask, 0,
+				     iio_get_masklength(indio_dev)) & GENMASK(15, 0);
+	ret = regmap_write(st->regmap, AD4691_STD_SEQ_CONFIG, std_seq_config);
+	if (ret)
+		goto err_unoptimize;
+
+	acc_mask = ~std_seq_config & GENMASK(15, 0);
+	ret = regmap_write(st->regmap, AD4691_ACC_MASK_REG, acc_mask);
+	if (ret)
+		goto err_unoptimize;
+
+	ret = ad4691_enter_conversion_mode(st);
+	if (ret)
+		goto err_unoptimize;
+
+	return 0;
+
+err_unoptimize:
+	spi_unoptimize_message(&st->scan_msg);
+	return ret;
+}
+
+static int ad4691_cnv_burst_buffer_postenable(struct iio_dev *indio_dev)
+{
+	struct ad4691_state *st = iio_priv(indio_dev);
+	int ret;
+
+	/*
+	 * Start the PWM and unmask the IRQ here in postenable, not in
+	 * preenable. The IIO core attaches the trigger poll function between
+	 * preenable and postenable; enabling sampling or unmasking the IRQ
+	 * before that point risks a DATA_READY assertion landing before the
+	 * poll function is registered. iio_trigger_poll() would drop the
+	 * event, disable_irq_nosync() would fire, and enable_irq() would
+	 * never be called, leaving the IRQ permanently masked.
+	 */
+	ret = ad4691_sampling_enable(st, true);
+	if (ret)
+		return ret;
+
+	enable_irq(st->irq);
+	return 0;
+}
+
+static int ad4691_cnv_burst_buffer_predisable(struct iio_dev *indio_dev)
+{
+	struct ad4691_state *st = iio_priv(indio_dev);
+
+	disable_irq(st->irq);
+	return ad4691_sampling_enable(st, false);
+}
+
+static int ad4691_cnv_burst_buffer_postdisable(struct iio_dev *indio_dev)
+{
+	struct ad4691_state *st = iio_priv(indio_dev);
+	int ret;
+
+	ret = ad4691_exit_conversion_mode(st);
+	spi_unoptimize_message(&st->scan_msg);
+	return ret;
+}
+
+static const struct iio_buffer_setup_ops ad4691_cnv_burst_buffer_setup_ops = {
+	.preenable = &ad4691_cnv_burst_buffer_preenable,
+	.postenable = &ad4691_cnv_burst_buffer_postenable,
+	.predisable = &ad4691_cnv_burst_buffer_predisable,
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
+	unsigned int freq;
+	int ret;
+
+	ret = kstrtouint(buf, 10, &freq);
+	if (ret)
+		return ret;
+
+	IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
+	if (IIO_DEV_ACQUIRE_FAILED(claim))
+		return -EBUSY;
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
+	/*
+	 * Disable the IRQ before calling iio_trigger_poll(). The IRQ is
+	 * re-enabled via the trigger .reenable callback, which the IIO core
+	 * calls inside iio_trigger_notify_done() once use_count reaches zero.
+	 * Re-enabling here (before notify_done) would race: a DATA_READY
+	 * between enable_irq() and notify_done() calls iio_trigger_poll()
+	 * while use_count > 0, dropping the event and permanently masking
+	 * the IRQ.
+	 *
+	 * IRQF_ONESHOT masks the hardware line for the duration of this
+	 * threaded handler; disable_irq_nosync() keeps the IRQ disabled even
+	 * after IRQF_ONESHOT unmasks on return.
+	 */
+	disable_irq_nosync(st->irq);
+	iio_trigger_poll(indio_dev->trig);
+
+	return IRQ_HANDLED;
+}
+
+static void ad4691_trigger_reenable(struct iio_trigger *trig)
+{
+	struct ad4691_state *st = iio_trigger_get_drvdata(trig);
+
+	enable_irq(st->irq);
+}
+
+static const struct iio_trigger_ops ad4691_trigger_ops = {
+	.reenable = ad4691_trigger_reenable,
+	.validate_device = iio_trigger_validate_own_device,
+};
+
+static int ad4691_read_scan(struct iio_dev *indio_dev, s64 ts)
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
+	iio_push_to_buffers_with_ts(indio_dev, st->vals, sizeof(st->vals), ts);
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
+/*
+ * CNV burst mode: only allow our own trigger (driven by DATA_READY IRQ).
+ * Manual mode: external triggers (e.g. iio-trig-hrtimer) must be allowed
+ * because manual mode has no DATA_READY IRQ to fire the internal trigger.
+ * iio_trigger_ops.validate_device = iio_trigger_validate_own_device is
+ * correct in both modes — it prevents other devices from hijacking our
+ * internal trigger; the distinction here is only for iio_info.validate_trigger.
+ */
+static const struct iio_info ad4691_cnv_burst_info = {
+	.read_raw = &ad4691_read_raw,
+	.write_raw = &ad4691_write_raw,
+	.read_avail = &ad4691_read_avail,
+	.debugfs_reg_access = &ad4691_reg_access,
+	.validate_trigger = iio_validate_own_trigger,
+};
+
+static const struct iio_info ad4691_manual_info = {
 	.read_raw = &ad4691_read_raw,
 	.write_raw = &ad4691_write_raw,
 	.read_avail = &ad4691_read_avail,
 	.debugfs_reg_access = &ad4691_reg_access,
 };
 
+static int ad4691_pwm_setup(struct ad4691_state *st)
+{
+	struct device *dev = regmap_get_device(st->regmap);
+
+	st->conv_trigger = devm_pwm_get(dev, "cnv");
+	if (IS_ERR(st->conv_trigger))
+		return dev_err_probe(dev, PTR_ERR(st->conv_trigger),
+				     "Failed to get CNV PWM\n");
+
+	return ad4691_set_pwm_freq(st, st->info->max_rate);
+}
+
 static int ad4691_regulator_setup(struct ad4691_state *st)
 {
 	struct device *dev = regmap_get_device(st->regmap);
@@ -623,6 +1097,22 @@ static int ad4691_config(struct ad4691_state *st)
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
@@ -676,6 +1166,79 @@ static int ad4691_config(struct ad4691_state *st)
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
+	indio_dev->channels = st->info->sw_info->channels;
+	indio_dev->num_channels = st->info->sw_info->num_channels;
+	indio_dev->info = st->manual_mode ? &ad4691_manual_info : &ad4691_cnv_burst_info;
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
+		if (irq > 0 || irq == -EPROBE_DEFER)
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
@@ -688,6 +1251,7 @@ static int ad4691_probe(struct spi_device *spi)
 		return -ENOMEM;
 
 	st = iio_priv(indio_dev);
+	st->spi = spi;
 	st->info = spi_get_device_match_data(spi);
 	if (!st->info)
 		return -ENODEV;
@@ -714,11 +1278,11 @@ static int ad4691_probe(struct spi_device *spi)
 		return ret;
 
 	indio_dev->name = st->info->name;
-	indio_dev->info = &ad4691_info;
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



