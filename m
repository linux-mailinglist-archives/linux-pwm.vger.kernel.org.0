Return-Path: <linux-pwm+bounces-8250-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WJjgLuvis2ktcQAAu9opvQ
	(envelope-from <linux-pwm+bounces-8250-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Mar 2026 11:11:55 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E32281372
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Mar 2026 11:11:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B56CE3213377
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Mar 2026 10:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C27138C43E;
	Fri, 13 Mar 2026 10:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X6CqDMLK"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7EFB38C2DD;
	Fri, 13 Mar 2026 10:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773396461; cv=none; b=rVwMj1YKldQwoSWEf8LQWgiph8C158waF3JM8EAT8OyovwO6y0l6LeTyJpg+hz+y18s86te+4PEyaiEPubVDR2WC2ACwJ0HA3dq3Ii8lirGIg6b3g9UtuoMzDZYGAgjIGXoaihzXJEUCn1wcc3nlTjCJeQHuk2K53bJ2Ii1J+aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773396461; c=relaxed/simple;
	bh=v7b8ZXpKDc7K5AugG1SE9y4CQXBAFVE7AhEpWLetjL0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ockwbxc4epQwYC74l36aGPcop8u5KSAkgqzG7HNUzEV6LaYiVeOqJHKwuGMUdbIkW+n5Qlozfg5BosXMykk7DklMqFM12twv0pZy5DPnlmR/tTh58yQDv2T8TfdtD6vdnUeO9q25yVA5ihwvQUWJcMZ63py8tCBcPdkaoArFzMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X6CqDMLK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5CF76C2BCB7;
	Fri, 13 Mar 2026 10:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773396461;
	bh=v7b8ZXpKDc7K5AugG1SE9y4CQXBAFVE7AhEpWLetjL0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=X6CqDMLKSSprkrTpYjC+D9+HZStyxm/OqO1RGK9wT6yQMYUWl34CYX8HhJX2cYyKM
	 w84/PLb43oQial5bPnCW+W7IAxkYDPhxb1nDOV7xFsgISTRERpRvINlTbt6QzNT6JN
	 pNR7IT066m9Lmj18O6AbThnnvTOviYCbKblNoLhdzeoXQ0V8YRWHjclmqUCYDn1fh2
	 mymMkWh+47GL9jr2ZjZdA+37SRLcO4JqGmcnEs3UqE0Ln3Ff2JBnv+OP/Jj+eNJtfX
	 VeRqf6EV4wvbxNNbXI362eeCacj26yo7O5fz4dOZB4FNsO4Yu7dFhped09HKMzpTZD
	 Gfo2VWmN9032g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FF6F105F78C;
	Fri, 13 Mar 2026 10:07:41 +0000 (UTC)
From: Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org>
Date: Fri, 13 Mar 2026 12:07:28 +0200
Subject: [PATCH v3 4/4] iio: adc: ad4691: add SPI offload support
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260313-ad4692-multichannel-sar-adc-driver-v3-4-b4d14d81a181@analog.com>
References: <20260313-ad4692-multichannel-sar-adc-driver-v3-0-b4d14d81a181@analog.com>
In-Reply-To: <20260313-ad4692-multichannel-sar-adc-driver-v3-0-b4d14d81a181@analog.com>
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
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, 
 linux-gpio@vger.kernel.org, Radu Sabau <radu.sabau@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773396456; l=19079;
 i=radu.sabau@analog.com; s=20260220; h=from:subject:message-id;
 bh=fVZdvfwdWHO55zzdEIdhP+gdQE03wvLMTOICAIgXurg=;
 b=kTtP9/lLwLM7XWvKsH/GYwgs5Zxw5s8PUxByiYk/9b7p/aALlQZVG4B/qFRrAj4jKM4M79upi
 NI0XJOkL/3TDysgLdHmkuqNB/+5+PT2wyZwPNzbdq6abHDKX5dCd5w4
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8250-lists,linux-pwm=lfdr.de,radu.sabau.analog.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[metafoo.de,analog.com,kernel.org,baylibre.com,gmail.com,pengutronix.de];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,linux-pwm@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	HAS_REPLYTO(0.00)[radu.sabau@analog.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,analog.com:email,analog.com:replyto,analog.com:mid]
X-Rspamd-Queue-Id: 40E32281372
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Radu Sabau <radu.sabau@analog.com>

Add SPI offload support to enable DMA-based, CPU-independent data
acquisition using the SPI Engine offload framework.

When an SPI offload is available (devm_spi_offload_get() succeeds),
the driver registers a DMA engine IIO buffer and uses dedicated buffer
setup operations. If no offload is available the existing software
triggered buffer path is used unchanged.

Both CNV Clock Mode and Manual Mode support offload, but use different
trigger mechanisms:

CNV Clock Mode: the SPI Engine is triggered by the ADC's DATA_READY
signal on GP0. For this mode the driver acts as both an SPI offload
consumer (DMA RX stream, message optimization) and a trigger source
provider: it registers the GP0/DATA_READY output via
devm_spi_offload_trigger_register() so the offload framework can
match the '#trigger-source-cells' phandle from the device tree and
automatically fire the SPI Engine DMA transfer at end-of-conversion.
The pre-built SPI message reads all active channels from the AVG_IN
accumulator registers (2-byte address + 2-byte data per channel,
one 4-byte transfer each) followed by a state reset word to re-arm
the accumulator for the next cycle.

Manual Mode: the SPI Engine is triggered by a periodic trigger at
the configured sampling frequency. The pre-built SPI message uses
the pipelined CNV-on-CS protocol: N+1 4-byte transfers are issued
for N active channels (the first result is discarded as garbage from
the pipeline flush) and the remaining N results are captured by DMA.

All offload transfers use 32-bit frames (bits_per_word=32, len=4) for
DMA word alignment. In Manual Mode the 4-byte DMA word layout is
[dummy(8), data_hi(8), data_lo(8), extra(8)]; the channel scan type
storagebits=32, shift=8, realbits=16 correctly extracts the 16-bit
ADC result from the middle two bytes.

Kconfig gains a dependency on IIO_BUFFER_DMAENGINE.

Signed-off-by: Radu Sabau <radu.sabau@analog.com>
---
 drivers/iio/adc/Kconfig  |   1 +
 drivers/iio/adc/ad4691.c | 397 ++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 391 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index d498f16c0816..93f090e9a562 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -144,6 +144,7 @@ config AD4691
 	depends on SPI
 	select IIO_BUFFER
 	select IIO_TRIGGERED_BUFFER
+	select IIO_BUFFER_DMAENGINE
 	select REGMAP
 	help
 	  Say yes here to build support for Analog Devices AD4691 Family MuxSAR
diff --git a/drivers/iio/adc/ad4691.c b/drivers/iio/adc/ad4691.c
index de2208395b21..ad9eaa94727e 100644
--- a/drivers/iio/adc/ad4691.c
+++ b/drivers/iio/adc/ad4691.c
@@ -9,6 +9,7 @@
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/device.h>
+#include <linux/dmaengine.h>
 #include <linux/err.h>
 #include <linux/reset.h>
 #include <linux/hrtimer.h>
@@ -21,11 +22,15 @@
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 #include <linux/spi/spi.h>
+#include <linux/spi/offload/consumer.h>
+#include <linux/spi/offload/provider.h>
 #include <linux/util_macros.h>
 #include <linux/units.h>
 #include <linux/unaligned.h>
 
 #include <linux/iio/buffer.h>
+#include <linux/iio/buffer-dma.h>
+#include <linux/iio/buffer-dmaengine.h>
 #include <linux/iio/iio.h>
 
 #include <linux/iio/trigger.h>
@@ -46,6 +51,7 @@
  */
 #define AD4691_MANUAL_MODE_STD_FREQ(x, y)	((y) / (36 * ((x) + 1)))
 #define AD4691_BITS_PER_XFER			24
+#define AD4691_OFFLOAD_BITS_PER_WORD		32
 #define AD4691_CNV_DUTY_CYCLE_NS		380
 #define AD4691_MAX_CONV_PERIOD_US		800
 
@@ -92,6 +98,11 @@
 #define AD4691_ACC_IN(n)			(0x252 + (3 * (n)))
 #define AD4691_ACC_STS_DATA(n)			(0x283 + (4 * (n)))
 
+/* SPI offload 32-bit message byte-field masks (MSB = first transmitted) */
+#define AD4691_MSG_ADDR_HI			GENMASK(31, 24)
+#define AD4691_MSG_ADDR_LO			GENMASK(23, 16)
+#define AD4691_MSG_DATA				GENMASK(15, 8)
+
 enum ad4691_adc_mode {
 	AD4691_CNV_CLOCK_MODE,
 	AD4691_MANUAL_MODE,
@@ -250,6 +261,16 @@ struct ad4691_state {
 	/* hrtimer for MANUAL_MODE triggered buffer (non-offload) */
 	struct hrtimer			sampling_timer;
 
+	struct spi_offload		*offload;
+	struct spi_offload_trigger	*offload_trigger;
+	struct spi_offload_trigger	*offload_trigger_periodic;
+	u64				offload_trigger_hz;
+	struct spi_message		offload_msg;
+	/* Max 16 channel transfers + 1 state reset or NOOP */
+	struct spi_transfer		offload_xfer[17];
+	/* TX commands for manual and accumulator modes */
+	u32				offload_tx_cmd[17];
+	u32				offload_tx_reset;
 	/*
 	 * DMA (thus cache coherency maintenance) may require the
 	 * transfer buffers to live in their own cache lines.
@@ -263,6 +284,65 @@ struct ad4691_state {
 	} scan __aligned(IIO_DMA_MINALIGN);
 };
 
+static const struct spi_offload_config ad4691_offload_config = {
+	.capability_flags = SPI_OFFLOAD_CAP_TRIGGER |
+			    SPI_OFFLOAD_CAP_RX_STREAM_DMA,
+};
+
+static bool ad4691_offload_trigger_match(struct spi_offload_trigger *trigger,
+					 enum spi_offload_trigger_type type,
+					 u64 *args, u32 nargs)
+{
+	if (type != SPI_OFFLOAD_TRIGGER_DATA_READY)
+		return false;
+
+	/*
+	 * Requires 2 args:
+	 * args[0] is the trigger event (BUSY or DATA_READY).
+	 * args[1] is the GPIO pin number (only GP0 supported).
+	 */
+	if (nargs != 2)
+		return false;
+
+	if (args[0] != AD4691_TRIGGER_EVENT_BUSY &&
+	    args[0] != AD4691_TRIGGER_EVENT_DATA_READY)
+		return false;
+
+	if (args[1] != AD4691_TRIGGER_PIN_GP0)
+		return false;
+
+	return true;
+}
+
+static int ad4691_offload_trigger_request(struct spi_offload_trigger *trigger,
+					  enum spi_offload_trigger_type type,
+					  u64 *args, u32 nargs)
+{
+	/*
+	 * GP0 is configured as DATA_READY or BUSY in ad4691_config()
+	 * based on the ADC mode. No additional configuration needed here.
+	 */
+	if (nargs != 2)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int ad4691_offload_trigger_validate(struct spi_offload_trigger *trigger,
+					   struct spi_offload_trigger_config *config)
+{
+	if (config->type != SPI_OFFLOAD_TRIGGER_DATA_READY)
+		return -EINVAL;
+
+	return 0;
+}
+
+static const struct spi_offload_trigger_ops ad4691_offload_trigger_ops = {
+	.match = ad4691_offload_trigger_match,
+	.request = ad4691_offload_trigger_request,
+	.validate = ad4691_offload_trigger_validate,
+};
+
 static void ad4691_disable_pwm(void *data)
 {
 	struct pwm_device *pwm = data;
@@ -446,9 +526,13 @@ static int ad4691_transfer(struct ad4691_state *st, int command,
 
 static int ad4691_get_sampling_freq(struct ad4691_state *st)
 {
-	if (st->adc_mode == AD4691_MANUAL_MODE)
+	if (st->adc_mode == AD4691_MANUAL_MODE) {
+		/* Offload uses periodic trigger, non-offload uses hrtimer */
+		if (st->offload)
+			return st->offload_trigger_hz;
 		return DIV_ROUND_CLOSEST(NSEC_PER_SEC,
 					 ktime_to_ns(st->sampling_period));
+	}
 
 	return DIV_ROUND_CLOSEST(NSEC_PER_SEC,
 				 pwm_get_period(st->conv_trigger));
@@ -502,6 +586,7 @@ static int ad4691_pwm_get(struct ad4691_state *st)
 static int ad4691_set_sampling_freq(struct iio_dev *indio_dev, unsigned int freq)
 {
 	struct ad4691_state *st = iio_priv(indio_dev);
+	int ret;
 
 	IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
 
@@ -511,11 +596,29 @@ static int ad4691_set_sampling_freq(struct iio_dev *indio_dev, unsigned int freq
 	guard(mutex)(&st->lock);
 
 	if (st->adc_mode == AD4691_MANUAL_MODE) {
+		/* For offload mode, validate and store frequency for periodic trigger */
+		if (st->offload) {
+			struct spi_offload_trigger_config config = {
+				.type = SPI_OFFLOAD_TRIGGER_PERIODIC,
+				.periodic = {
+					.frequency_hz = freq,
+				},
+			};
+
+			ret = spi_offload_trigger_validate(st->offload_trigger_periodic,
+							   &config);
+			if (ret)
+				return ret;
+
+			st->offload_trigger_hz = config.periodic.frequency_hz;
+			return 0;
+		}
+
+		/* Non-offload: update hrtimer sampling period */
 		if (!freq || freq > st->chip->max_rate)
 			return -ERANGE;
 
-		st->sampling_period = ns_to_ktime(DIV_ROUND_CLOSEST(NSEC_PER_SEC,
-									 freq));
+		st->sampling_period = ns_to_ktime(DIV_ROUND_CLOSEST(NSEC_PER_SEC, freq));
 		return 0;
 	}
 
@@ -787,6 +890,223 @@ static const struct iio_buffer_setup_ops ad4691_buffer_setup_ops = {
 	.postdisable = &ad4691_buffer_postdisable,
 };
 
+static int ad4691_offload_buffer_postenable(struct iio_dev *indio_dev)
+{
+	struct ad4691_state *st = iio_priv(indio_dev);
+	struct spi_device *spi = to_spi_device(regmap_get_device(st->regmap));
+	struct spi_offload_trigger_config config = { };
+	struct spi_offload_trigger *trigger;
+	struct spi_transfer *xfer = st->offload_xfer;
+	int ret, num_xfers = 0;
+	int active_chans[16];
+	unsigned int bit;
+	int n_active = 0;
+	int i;
+
+	memset(xfer, 0, sizeof(st->offload_xfer));
+
+	/* Collect active channels in scan order */
+	iio_for_each_active_channel(indio_dev, bit)
+		active_chans[n_active++] = bit;
+
+	ret = ad4691_enter_conversion_mode(st);
+	if (ret)
+		return ret;
+
+	/*
+	 * MANUAL_MODE uses a periodic (PWM) trigger and reads directly from
+	 * the ADC. CNV_CLOCK_MODE uses the DATA_READY trigger and reads from
+	 * accumulators.
+	 */
+	if (st->adc_mode == AD4691_MANUAL_MODE) {
+		config.type = SPI_OFFLOAD_TRIGGER_PERIODIC;
+		config.periodic.frequency_hz = st->offload_trigger_hz;
+		trigger = st->offload_trigger_periodic;
+		if (!trigger)
+			return -EINVAL;
+	} else {
+		u16 mask = ~(*indio_dev->active_scan_mask);
+		u32 acc_mask[2] = { mask & 0xFF, mask >> 8 };
+
+		ret = regmap_write(st->regmap, AD4691_STATE_RESET_REG,
+				   AD4691_STATE_RESET_ALL);
+		if (ret)
+			return ret;
+
+		/* Configure accumulator masks - 0 = enabled, 1 = masked */
+		ret = regmap_bulk_write(st->regmap, AD4691_ACC_MASK1_REG,
+					acc_mask, 2);
+		if (ret)
+			return ret;
+
+		/* Configure sequencer with active channels */
+		ret = regmap_write(st->regmap, AD4691_STD_SEQ_CONFIG,
+				   *indio_dev->active_scan_mask);
+		if (ret)
+			return ret;
+
+		iio_for_each_active_channel(indio_dev, bit) {
+			ret = regmap_write(st->regmap, AD4691_ACC_COUNT_LIMIT(bit),
+					   AD4691_ACC_COUNT_VAL);
+			if (ret)
+				return ret;
+		}
+
+		config.type = SPI_OFFLOAD_TRIGGER_DATA_READY;
+		trigger = st->offload_trigger;
+	}
+
+	if (st->adc_mode == AD4691_MANUAL_MODE) {
+		/*
+		 * Manual mode with CNV tied to CS: Each CS toggle triggers a
+		 * conversion AND reads the previous conversion result (pipeline).
+		 */
+		for (i = 0; i < n_active; i++) {
+			put_unaligned_be32(FIELD_PREP(AD4691_MSG_ADDR_HI,
+						      AD4691_ADC_CHAN(active_chans[i])),
+					   &st->offload_tx_cmd[num_xfers]);
+			xfer[num_xfers].tx_buf = &st->offload_tx_cmd[num_xfers];
+			xfer[num_xfers].len = 4;
+			xfer[num_xfers].bits_per_word = 32;
+			xfer[num_xfers].speed_hz = spi->max_speed_hz;
+			xfer[num_xfers].cs_change = 1;
+			xfer[num_xfers].cs_change_delay.value = 1000;
+			xfer[num_xfers].cs_change_delay.unit = SPI_DELAY_UNIT_NSECS;
+			/* First transfer RX is garbage - don't capture it */
+			if (num_xfers)
+				xfer[num_xfers].offload_flags = SPI_OFFLOAD_XFER_RX_STREAM;
+			num_xfers++;
+		}
+
+		/* Final NOOP to flush pipeline and get last channel's data */
+		put_unaligned_be32(FIELD_PREP(AD4691_MSG_ADDR_HI, AD4691_NOOP),
+				   &st->offload_tx_cmd[num_xfers]);
+		xfer[num_xfers].tx_buf = &st->offload_tx_cmd[num_xfers];
+		xfer[num_xfers].len = 4;
+		xfer[num_xfers].bits_per_word = 32;
+		xfer[num_xfers].speed_hz = spi->max_speed_hz;
+		xfer[num_xfers].cs_change = 0;
+		xfer[num_xfers].offload_flags = SPI_OFFLOAD_XFER_RX_STREAM;
+		num_xfers++;
+	} else {
+		/*
+		 * CNV_CLOCK_MODE: single transfer per channel (2-byte cmd +
+		 * 2-byte data = 4 bytes, one 32-bit SPI Engine DMA word).
+		 * AVG_IN registers are used; RX layout: [cmd_hi, cmd_lo, d_hi, d_lo]
+		 */
+		for (i = 0; i < n_active; i++) {
+			unsigned int reg;
+			int ch = active_chans[i];
+
+			reg = AD4691_AVG_IN(ch);
+			put_unaligned_be32(FIELD_PREP(AD4691_MSG_ADDR_HI, (reg >> 8) | 0x80) |
+					   FIELD_PREP(AD4691_MSG_ADDR_LO, reg & 0xFF),
+					   &st->offload_tx_cmd[ch]);
+			xfer[num_xfers].tx_buf = &st->offload_tx_cmd[ch];
+			xfer[num_xfers].len = 4;
+			xfer[num_xfers].bits_per_word = 32;
+			xfer[num_xfers].speed_hz = spi->max_speed_hz;
+			xfer[num_xfers].offload_flags = SPI_OFFLOAD_XFER_RX_STREAM;
+			xfer[num_xfers].cs_change = 1;
+			num_xfers++;
+		}
+
+		/* State reset: clear accumulator so DATA_READY can fire again. */
+		put_unaligned_be32(FIELD_PREP(AD4691_MSG_ADDR_HI, AD4691_STATE_RESET_REG >> 8) |
+				   FIELD_PREP(AD4691_MSG_ADDR_LO, AD4691_STATE_RESET_REG & 0xFF) |
+				   FIELD_PREP(AD4691_MSG_DATA, AD4691_STATE_RESET_ALL),
+				   &st->offload_tx_reset);
+		xfer[num_xfers].tx_buf = &st->offload_tx_reset;
+		xfer[num_xfers].len = 4;
+		xfer[num_xfers].bits_per_word = 32;
+		xfer[num_xfers].speed_hz = spi->max_speed_hz;
+		xfer[num_xfers].cs_change = 0;
+		num_xfers++;
+	}
+
+	if (num_xfers == 0)
+		return -EINVAL;
+
+	/*
+	 * For MANUAL_MODE, validate that the trigger frequency is low enough
+	 * for all SPI transfers to complete. Each transfer is 32 bits.
+	 * Add 50% margin for CS setup/hold and other overhead.
+	 */
+	if (st->adc_mode == AD4691_MANUAL_MODE) {
+		u64 min_period_ns;
+		u64 trigger_period_ns;
+
+		/* Time for all transfers in nanoseconds, with 50% overhead margin */
+		min_period_ns = div64_u64((u64)num_xfers * AD4691_OFFLOAD_BITS_PER_WORD *
+					  NSEC_PER_SEC * 3,
+					  spi->max_speed_hz * 2);
+
+		trigger_period_ns = DIV_ROUND_CLOSEST_ULL(NSEC_PER_SEC, st->offload_trigger_hz);
+
+		if (trigger_period_ns < min_period_ns)
+			return -EINVAL;
+	}
+
+	spi_message_init_with_transfers(&st->offload_msg, xfer, num_xfers);
+	st->offload_msg.offload = st->offload;
+
+	ret = spi_optimize_message(spi, &st->offload_msg);
+	if (ret)
+		return ret;
+
+	/*
+	 * For CNV_CLOCK_MODE, start conversions before enabling the trigger.
+	 * If the trigger is enabled first, the SPI engine blocks waiting for
+	 * DATA_READY, and any subsequent SPI write times out.
+	 *
+	 * MANUAL_MODE: CNV is tied to CS; conversion starts with each transfer.
+	 */
+	if (st->adc_mode == AD4691_CNV_CLOCK_MODE) {
+		ret = ad4691_sampling_enable(st, true);
+		if (ret)
+			goto err_unoptimize_message;
+	}
+
+	ret = spi_offload_trigger_enable(st->offload, trigger, &config);
+	if (ret)
+		goto err_sampling_disable;
+
+	return 0;
+
+err_sampling_disable:
+	if (st->adc_mode == AD4691_CNV_CLOCK_MODE)
+		ad4691_sampling_enable(st, false);
+err_unoptimize_message:
+	spi_unoptimize_message(&st->offload_msg);
+	return ret;
+}
+
+static int ad4691_offload_buffer_predisable(struct iio_dev *indio_dev)
+{
+	struct ad4691_state *st = iio_priv(indio_dev);
+	struct spi_offload_trigger *trigger;
+	int ret;
+
+	trigger = (st->adc_mode == AD4691_MANUAL_MODE) ?
+		  st->offload_trigger_periodic : st->offload_trigger;
+
+	spi_offload_trigger_disable(st->offload, trigger);
+	spi_unoptimize_message(&st->offload_msg);
+
+	if (st->adc_mode == AD4691_CNV_CLOCK_MODE) {
+		ret = ad4691_sampling_enable(st, false);
+		if (ret)
+			return ret;
+	}
+
+	return ad4691_exit_conversion_mode(st);
+}
+
+static const struct iio_buffer_setup_ops ad4691_offload_buffer_setup_ops = {
+	.postenable = &ad4691_offload_buffer_postenable,
+	.predisable = &ad4691_offload_buffer_predisable,
+};
+
 static irqreturn_t ad4691_irq(int irq, void *private)
 {
 	struct iio_dev *indio_dev = private;
@@ -980,6 +1300,55 @@ static int ad4691_config(struct ad4691_state *st)
 	return regmap_write(st->regmap, AD4691_GPIO_MODE1_REG, AD4691_ADC_BUSY);
 }
 
+static int ad4691_setup_offload(struct iio_dev *indio_dev,
+				struct ad4691_state *st)
+{
+	struct device *dev = regmap_get_device(st->regmap);
+	struct spi_device *spi = to_spi_device(dev);
+	struct dma_chan *rx_dma;
+	int ret;
+
+	if (st->adc_mode == AD4691_MANUAL_MODE) {
+		st->offload_trigger_periodic = devm_spi_offload_trigger_get(dev,
+				st->offload, SPI_OFFLOAD_TRIGGER_PERIODIC);
+		if (IS_ERR(st->offload_trigger_periodic))
+			return dev_err_probe(dev,
+				PTR_ERR(st->offload_trigger_periodic),
+				"failed to get periodic offload trigger\n");
+
+		st->offload_trigger_hz = AD4691_MANUAL_MODE_STD_FREQ(st->chip->num_channels,
+								      spi->max_speed_hz);
+	} else {
+		struct spi_offload_trigger_info trigger_info = {
+			.fwnode = dev_fwnode(dev),
+			.ops = &ad4691_offload_trigger_ops,
+			.priv = st,
+		};
+
+		ret = devm_spi_offload_trigger_register(dev, &trigger_info);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "failed to register offload trigger\n");
+
+		st->offload_trigger = devm_spi_offload_trigger_get(dev,
+				st->offload, SPI_OFFLOAD_TRIGGER_DATA_READY);
+		if (IS_ERR(st->offload_trigger))
+			return dev_err_probe(dev, PTR_ERR(st->offload_trigger),
+					     "failed to get offload trigger\n");
+	}
+
+	rx_dma = devm_spi_offload_rx_stream_request_dma_chan(dev, st->offload);
+	if (IS_ERR(rx_dma))
+		return dev_err_probe(dev, PTR_ERR(rx_dma),
+				     "failed to get offload RX DMA\n");
+
+	indio_dev->modes = INDIO_DIRECT_MODE | INDIO_BUFFER_HARDWARE;
+	indio_dev->setup_ops = &ad4691_offload_buffer_setup_ops;
+
+	return devm_iio_dmaengine_buffer_setup_with_handle(dev, indio_dev,
+			rx_dma, IIO_BUFFER_DIRECTION_IN);
+}
+
 static int ad4691_setup_triggered_buffer(struct iio_dev *indio_dev,
 					 struct ad4691_state *st)
 {
@@ -1060,6 +1429,14 @@ static int ad4691_probe(struct spi_device *spi)
 		return dev_err_probe(dev, PTR_ERR(st->regmap),
 				     "Failed to initialize regmap\n");
 
+	st->offload = devm_spi_offload_get(dev, spi, &ad4691_offload_config);
+	ret = PTR_ERR_OR_ZERO(st->offload);
+	if (ret == -ENODEV)
+		st->offload = NULL;
+	else if (ret)
+		return dev_err_probe(dev, ret,
+				     "failed to get SPI offload\n");
+
 	st->chip = spi_get_device_match_data(spi);
 
 	ret = ad4691_regulator_get(st);
@@ -1082,10 +1459,15 @@ static int ad4691_probe(struct spi_device *spi)
 		st->chip->manual_channels : st->chip->channels;
 	indio_dev->num_channels = st->chip->num_channels;
 
-	ret = ad4691_setup_triggered_buffer(indio_dev, st);
-	if (ret)
-		return ret;
-
+	if (st->offload) {
+		ret = ad4691_setup_offload(indio_dev, st);
+		if (ret)
+			return ret;
+	} else {
+		ret = ad4691_setup_triggered_buffer(indio_dev, st);
+		if (ret)
+			return ret;
+	}
 	return devm_iio_device_register(dev, indio_dev);
 }
 
@@ -1120,3 +1502,4 @@ module_spi_driver(ad4691_driver);
 MODULE_AUTHOR("Radu Sabau <radu.sabau@analog.com>");
 MODULE_DESCRIPTION("Analog Devices AD4691 Family ADC Driver");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("IIO_DMA_BUFFER");

-- 
2.43.0



