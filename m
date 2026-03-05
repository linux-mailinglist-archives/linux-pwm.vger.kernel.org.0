Return-Path: <linux-pwm+bounces-8188-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gES7NLx2qWl77wAAu9opvQ
	(envelope-from <linux-pwm+bounces-8188-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 05 Mar 2026 13:27:40 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 92629211A27
	for <lists+linux-pwm@lfdr.de>; Thu, 05 Mar 2026 13:27:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6787A3077F15
	for <lists+linux-pwm@lfdr.de>; Thu,  5 Mar 2026 12:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 088F939E18B;
	Thu,  5 Mar 2026 12:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iEeUuqDu"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A5E39D6FD;
	Thu,  5 Mar 2026 12:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772713415; cv=none; b=pixJDcT5syPQ/9mGrGQNmpejREt1gu0VCI+PHCzED4XB3E2iSnh2k8gUP3vyQVxNnV/s+LOolln/DYbCzTmpm5rkurfIOT1CzFoJSdSGucJMcdrvJm6LBpXh1TJHvQR46CTx2Wbobsow/aRvf7K1HXRv6nhSR1roHHq4ivVa6gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772713415; c=relaxed/simple;
	bh=XMyV1p3aB7Qf2mFuPa6CrsdsH84IZNGoq026sEdAMXQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZsShrtsFjoQ6gIsxO5gY7PvckgJVElCCf+YO7/qE3mt6MZ3oArKZHSqJA7STIG6XTRoC/UrZHJC2IV9p2jfwG7DepF4VJQ5JfOKg7SDhBTVLD1Y3InWn5QeUwD+0T5zGXO4rQDavFRSa21Di0facjNysbt+GTkTTmh1iZfEEuj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iEeUuqDu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 84F52C4AF13;
	Thu,  5 Mar 2026 12:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772713415;
	bh=XMyV1p3aB7Qf2mFuPa6CrsdsH84IZNGoq026sEdAMXQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=iEeUuqDu3h+0eFXGuOOjtON1SiuUuCz7s0bkPtt4Ja1A2R86Kt3i5i8XePNjiLtFK
	 kMnS0j+zdQhomHrZLlt1Wwz0xq96cojgFAL44dHXrEeqj/pwKLE61NKdLEpjbKGtHv
	 dbJB+zkSzfP0x2N9aTFlGeOD/ompMSKG3kg+hbdUZ27Y7oq4MR4LYLNo7OryPVb4w6
	 xHKQj/dRmui2mKVAwBS6dGmqFQDRpsal0+GzdJthwslWiDgOBiyhAIU3/DiSQ5C6fq
	 knKH3iFn7iytCraEUt3tidpVoH0Kxscenpp9esr5hdwEO+mMvspFKbpbF1M7bbWKzd
	 +00fJxZfBBq5g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 760DEF3092C;
	Thu,  5 Mar 2026 12:23:35 +0000 (UTC)
From: Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org>
Date: Thu, 05 Mar 2026 14:23:30 +0200
Subject: [PATCH 4/4] iio: adc: ad4691: add SPI offload support
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260305-ad4692-multichannel-sar-adc-driver-v1-4-336229a8dcc7@analog.com>
References: <20260305-ad4692-multichannel-sar-adc-driver-v1-0-336229a8dcc7@analog.com>
In-Reply-To: <20260305-ad4692-multichannel-sar-adc-driver-v1-0-336229a8dcc7@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, 
 linux-gpio@vger.kernel.org, Radu Sabau <radu.sabau@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772713413; l=25027;
 i=radu.sabau@analog.com; s=20260220; h=from:subject:message-id;
 bh=fsJYfVJAeFuv2N8CEoY4pRwap+ES24z5DGo+5a2M3YI=;
 b=8v8JFRQz/pAwK4RQsJ0ld0jvDSjFQt97MafVAPQJ0NKgxq2MJg3oZ1bNMiELvBITgMHsbfbXO
 cXH/3RhjvUHCKdsDscmVXTPZ+UQjwEApA0n8J2JNowRPlz2MfCNg3wU
X-Developer-Key: i=radu.sabau@analog.com; a=ed25519;
 pk=lDPQHgn9jTdt0vo58Na9lLxLaE2mb330if71Cn+EvFU=
X-Endpoint-Received: by B4 Relay for radu.sabau@analog.com/20260220 with
 auth_id=642
X-Original-From: Radu Sabau <radu.sabau@analog.com>
Reply-To: radu.sabau@analog.com
X-Rspamd-Queue-Id: 92629211A27
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-8188-lists,linux-pwm=lfdr.de,radu.sabau.analog.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[metafoo.de,analog.com,kernel.org,baylibre.com,gmail.com];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,analog.com:replyto,analog.com:email,analog.com:mid]
X-Rspamd-Action: no action

From: Radu Sabau <radu.sabau@analog.com>

Add SPI offload support to the AD4691 family driver to enable
DMA-based RX stream acquisition. When an SPI offload is available,
the driver switches to a pre-built SPI message with 32-bit transfers
(4-byte frames aligned to DMA width) and registers a periodic
offload trigger for autonomous, CPU-independent sampling.

The offload path implements its own buffer setup ops
(ad4691_offload_buffer_postenable/predisable) that enable the
offload trigger and wire the DMAengine buffer, while the existing
software triggered buffer path is retained as a fallback for
non-offload configurations.

Offload channel specs use a 32-bit storage/repeat with a 16-bit
shift to extract ADC data from the MSBytes of each DMA word,
matching the wire format in Manual Mode where SDO outputs ADC data
directly without a command echo.

Kconfig gains a dependency on IIO_BUFFER_DMAENGINE.

Signed-off-by: Radu Sabau <radu.sabau@analog.com>
---
 drivers/iio/adc/Kconfig  |   1 +
 drivers/iio/adc/ad4691.c | 541 ++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 531 insertions(+), 11 deletions(-)

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
index ab48f336e46c..7ec0a2555a4b 100644
--- a/drivers/iio/adc/ad4691.c
+++ b/drivers/iio/adc/ad4691.c
@@ -8,6 +8,7 @@
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/device.h>
+#include <linux/dmaengine.h>
 #include <linux/err.h>
 #include <linux/gpio/consumer.h>
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
@@ -49,6 +54,7 @@
  */
 #define AD4691_MANUAL_MODE_STD_FREQ(x, y)	((y) / (36 * ((x) + 1)))
 #define AD4691_BITS_PER_XFER			24
+#define AD4691_OFFLOAD_BITS_PER_WORD		32
 #define AD4691_CNV_DUTY_CYCLE_NS		380
 #define AD4691_MAX_CONV_PERIOD_US		800
 
@@ -253,6 +259,43 @@ static const struct iio_chan_spec ad4693_manual_channels[] = {
 	AD4691_CHANNEL(7, 7, 16, 24, 8)
 };
 
+/*
+ * Manual mode offload channels.
+ *
+ * Transfer format: 4-byte SPI frame to match 32-bit DMA width.
+ * In Manual Mode there is no command echo - SDO outputs ADC data directly.
+ * 16-bit ADC data in 2 MSBytes, shift=16 for extraction.
+ */
+static const struct iio_chan_spec ad4691_manual_offload_channels[] = {
+	AD4691_CHANNEL(0, 0, 16, 32, 16),
+	AD4691_CHANNEL(1, 1, 16, 32, 16),
+	AD4691_CHANNEL(2, 2, 16, 32, 16),
+	AD4691_CHANNEL(3, 3, 16, 32, 16),
+	AD4691_CHANNEL(4, 4, 16, 32, 16),
+	AD4691_CHANNEL(5, 5, 16, 32, 16),
+	AD4691_CHANNEL(6, 6, 16, 32, 16),
+	AD4691_CHANNEL(7, 7, 16, 32, 16),
+	AD4691_CHANNEL(8, 8, 16, 32, 16),
+	AD4691_CHANNEL(9, 9, 16, 32, 16),
+	AD4691_CHANNEL(10, 10, 16, 32, 16),
+	AD4691_CHANNEL(11, 11, 16, 32, 16),
+	AD4691_CHANNEL(12, 12, 16, 32, 16),
+	AD4691_CHANNEL(13, 13, 16, 32, 16),
+	AD4691_CHANNEL(14, 14, 16, 32, 16),
+	AD4691_CHANNEL(15, 15, 16, 32, 16)
+};
+
+static const struct iio_chan_spec ad4693_manual_offload_channels[] = {
+	AD4691_CHANNEL(0, 0, 16, 32, 16),
+	AD4691_CHANNEL(1, 1, 16, 32, 16),
+	AD4691_CHANNEL(2, 2, 16, 32, 16),
+	AD4691_CHANNEL(3, 3, 16, 32, 16),
+	AD4691_CHANNEL(4, 4, 16, 32, 16),
+	AD4691_CHANNEL(5, 5, 16, 32, 16),
+	AD4691_CHANNEL(6, 6, 16, 32, 16),
+	AD4691_CHANNEL(7, 7, 16, 32, 16)
+};
+
 static const struct ad4691_chip_info ad4691_chips[] = {
 	[AD4691_ID_AD4691] = {
 		.channels = ad4691_channels,
@@ -310,6 +353,17 @@ struct ad4691_state {
 	struct hrtimer			sampling_timer;
 	ktime_t				sampling_period;
 
+	struct spi_offload		*offload;
+	struct spi_offload_trigger	*offload_trigger;
+	struct spi_offload_trigger	*offload_trigger_periodic;
+	u64				offload_trigger_hz;
+	struct spi_message		offload_msg;
+	/* Max 16 channels * 2 transfers (cmd + data) + 1 state reset + 1 conv start */
+	struct spi_transfer		offload_xfer[34];
+	/* TX commands for manual and accumulator modes */
+	u32				offload_tx_cmd[17];
+	u32				offload_tx_reset;
+	u32				offload_tx_conv_stop;
 	/* DMA (thus cache coherency maintenance) may require the
 	 * transfer buffers to live in their own cache lines.
 	 * Make the buffer large enough for one 24 bit sample and one 64 bit
@@ -324,6 +378,65 @@ struct ad4691_state {
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
 static void ad4691_disable_regulators(void *data)
 {
 	struct ad4691_state *st = data;
@@ -560,6 +673,9 @@ static int ad4691_get_sampling_freq(struct ad4691_state *st)
 
 	switch (st->adc_mode) {
 	case AD4691_MANUAL_MODE:
+		/* Offload uses periodic trigger, non-offload uses hrtimer */
+		if (st->offload)
+			return st->offload_trigger_hz;
 		return DIV_ROUND_CLOSEST_ULL(NSEC_PER_SEC,
 					     ktime_to_ns(st->sampling_period));
 	case AD4691_CNV_CLOCK_MODE:
@@ -600,6 +716,7 @@ static int __ad4691_set_sampling_freq(struct ad4691_state *st, int freq)
  * ad4691_cnv_burst_period_ns - Compute the CNV_BURST_MODE PWM period.
  * @st: Driver state.
  * @n_active: Number of active channels.
+ * @is_offload: True for the SPI offload path, false for the triggered buffer path.
  *
  * The period must cover the full conversion time tOSC*(n_active+1) plus
  * the SPI transfer time for reading the accumulator results and issuing
@@ -608,7 +725,7 @@ static int __ad4691_set_sampling_freq(struct ad4691_state *st, int freq)
  * Return: Period in nanoseconds.
  */
 static u64 ad4691_cnv_burst_period_ns(struct ad4691_state *st,
-				      int n_active)
+				      int n_active, bool is_offload)
 {
 	unsigned int osc_idx = AD4691_OSC_1MHZ;
 	u64 osc_freq, conv_time_ns, spi_bits, spi_time_ns;
@@ -620,7 +737,20 @@ static u64 ad4691_cnv_burst_period_ns(struct ad4691_state *st,
 	osc_freq = ad4691_int_osc_val[osc_idx];
 	conv_time_ns = div64_u64((u64)(n_active + 1) * NSEC_PER_SEC, osc_freq);
 
-	spi_bits = (u64)n_active * 32 + 24;
+	if (is_offload) {
+		/*
+		 * Offload SPI sequence per trigger: n_active AVG_IN reads
+		 * (4 B each) + STATE_RESET (4 B).
+		 */
+		spi_bits = (u64)(n_active + 1) * 32;
+	} else {
+		/*
+		 * Non-offload sequence per trigger: n_active AVG_IN reads
+		 * (4 B: 2 cmd + 2 data each) + STATE_RESET (3 B).
+		 */
+		spi_bits = (u64)n_active * 32 + 24;
+	}
+
 	spi_time_ns = div64_u64(spi_bits * NSEC_PER_SEC, st->spi->max_speed_hz);
 
 	/* 50% margin on SPI time absorbs OS scheduling jitter. */
@@ -662,7 +792,9 @@ static int ad4691_pwm_get(struct spi_device *spi, struct ad4691_state *st)
 		 * transfer time. Use worst-case channel count here; the period
 		 * is refined at buffer enable time when the active count is known.
 		 */
-		u64 period_ns = ad4691_cnv_burst_period_ns(st, st->chip->num_channels);
+		u64 period_ns = ad4691_cnv_burst_period_ns(st,
+							    st->chip->num_channels,
+							    false);
 		int pwm_freq = (int)max(1ULL, div64_u64(NSEC_PER_SEC, period_ns));
 
 		return __ad4691_set_sampling_freq(st, pwm_freq);
@@ -683,6 +815,26 @@ static int ad4691_set_sampling_freq(struct iio_dev *indio_dev, unsigned int freq
 	mutex_lock(&st->lock);
 	switch (st->adc_mode) {
 	case AD4691_MANUAL_MODE:
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
+				goto exit;
+
+			st->offload_trigger_hz = config.periodic.frequency_hz;
+			ret = 0;
+			goto exit;
+		}
+
+		/* Non-offload: update hrtimer sampling period */
 		if (!freq || freq > st->chip->max_rate) {
 			ret = -EINVAL;
 			goto exit;
@@ -719,7 +871,9 @@ static int ad4691_set_sampling_freq(struct iio_dev *indio_dev, unsigned int freq
 		 * count. The exact period is refined at buffer enable time when
 		 * the active channel count is known.
 		 */
-		period_ns = ad4691_cnv_burst_period_ns(st, st->chip->num_channels);
+		period_ns = ad4691_cnv_burst_period_ns(st,
+							st->chip->num_channels,
+							false);
 		pwm_freq = (int)max(1ULL, div64_u64(NSEC_PER_SEC, period_ns));
 		ret = __ad4691_set_sampling_freq(st, pwm_freq);
 
@@ -839,6 +993,13 @@ static int ad4691_read_raw(struct iio_dev *indio_dev,
 
 			/*
 			 * Wait for conversion to complete using a timed delay.
+			 * An interrupt-driven approach is not used for single-shot
+			 * reads: the DATA_READY IRQ is registered only in the
+			 * triggered buffer path, and offload configurations route
+			 * DATA_READY to the SPI engine, not to a CPU interrupt.
+			 * Using usleep_range keeps the driver simple and correct
+			 * across all configurations.
+			 *
 			 * CNV_CLOCK_MODE conversion time is bounded by
 			 * AD4691_MAX_CONV_PERIOD_US. All other modes are driven by
 			 * the internal oscillator; two oscillator periods cover a
@@ -1072,6 +1233,294 @@ static const struct iio_buffer_setup_ops ad4691_buffer_setup_ops = {
 	.postdisable = &ad4691_buffer_postdisable,
 };
 
+static int ad4691_offload_buffer_postenable(struct iio_dev *indio_dev)
+{
+	struct ad4691_state *st = iio_priv(indio_dev);
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
+	/*
+	 * MANUAL_MODE uses a periodic (PWM) trigger and reads directly from the ADC.
+	 * All other modes use the DATA_READY trigger and read from accumulators.
+	 */
+	if (st->adc_mode == AD4691_MANUAL_MODE) {
+		config.type = SPI_OFFLOAD_TRIGGER_PERIODIC;
+		config.periodic.frequency_hz = st->offload_trigger_hz;
+		trigger = st->offload_trigger_periodic;
+		if (!trigger)
+			return -EINVAL;
+	} else {
+		if (st->adc_mode != AD4691_AUTONOMOUS_MODE)
+			ret = regmap_write(st->regmap, AD4691_GPIO_MODE1_REG,
+					   AD4691_DATA_READY);
+		else
+			ret = regmap_write(st->regmap, AD4691_GPIO_MODE1_REG,
+					   AD4691_ADC_BUSY);
+		if (ret)
+			return ret;
+
+		ret = regmap_write(st->regmap, AD4691_STATE_RESET_REG,
+					   AD4691_STATE_RESET_ALL);
+		if (ret)
+			return ret;
+
+		/* Configure accumulator masks - 0 = enabled, 1 = masked */
+		ret = regmap_write(st->regmap, AD4691_ACC_MASK1_REG,
+				       ~(*indio_dev->active_scan_mask) & 0xFF);
+		if (ret)
+			return ret;
+
+		ret = regmap_write(st->regmap, AD4691_ACC_MASK2_REG,
+				       ~(*indio_dev->active_scan_mask >> 8) & 0xFF);
+		if (ret)
+			return ret;
+
+		/* Configure sequencer with active channels */
+		ret = regmap_write(st->regmap, AD4691_STD_SEQ_CONFIG,
+				       *indio_dev->active_scan_mask);
+		if (ret)
+			return ret;
+
+		/* Configure accumulator count limit for each active channel */
+		iio_for_each_active_channel(indio_dev, bit) {
+			ret = regmap_write(st->regmap, AD4691_ACC_COUNT_LIMIT(bit),
+					       AD4691_ACC_COUNT_VAL);
+			if (ret)
+				return ret;
+		}
+
+		config.type = SPI_OFFLOAD_TRIGGER_DATA_READY;
+		trigger = st->offload_trigger;
+	}
+
+	switch (st->adc_mode) {
+	case AD4691_CNV_CLOCK_MODE:
+	case AD4691_CNV_BURST_MODE:
+	case AD4691_AUTONOMOUS_MODE:
+	case AD4691_SPI_BURST_MODE:
+		/*
+		 * AUTONOMOUS mode: must stop conversion before reading.
+		 * Sequence: CONV_STOP -> read accumulators -> STATE_RESET -> CONV_START
+		 */
+		if (st->adc_mode == AD4691_AUTONOMOUS_MODE) {
+			/*
+			 * With bits_per_word=32, SPI engine reads native u32
+			 * and transmits MSB first. No byte-swap needed.
+			 */
+			st->offload_tx_conv_stop = (AD4691_OSC_EN_REG >> 8) << 24 |
+				(AD4691_OSC_EN_REG & 0xFF) << 16 |
+				0x00 << 8;  /* CONV_START = 0 to stop */
+			xfer[num_xfers].tx_buf = &st->offload_tx_conv_stop;
+			xfer[num_xfers].len = 4;
+			xfer[num_xfers].bits_per_word = 32;
+			xfer[num_xfers].speed_hz = st->spi->max_speed_hz;
+			xfer[num_xfers].cs_change = 1;
+			num_xfers++;
+		}
+
+		/*
+		 * Single transfer per channel: 2-byte cmd + 2-byte data = 4 bytes
+		 * (one 32-bit SPI Engine DMA word).
+		 *
+		 * AVG_IN registers are used instead of ACC_IN. See the
+		 * AD4691_OFFLOAD_CHANNEL macro for a detailed explanation.
+		 *
+		 * RX word layout (big-endian): [cmd_hi, cmd_lo, d_hi, d_lo]
+		 */
+		for (i = 0; i < n_active; i++) {
+			unsigned int reg;
+			int ch = active_chans[i];
+
+			reg = AD4691_AVG_IN(ch);
+			st->offload_tx_cmd[ch] =
+				((reg >> 8) | 0x80) << 24 |
+				(reg & 0xFF) << 16;
+			xfer[num_xfers].tx_buf = &st->offload_tx_cmd[ch];
+			xfer[num_xfers].len = 4;
+			xfer[num_xfers].bits_per_word = 32;
+			xfer[num_xfers].speed_hz = st->spi->max_speed_hz;
+			xfer[num_xfers].offload_flags = SPI_OFFLOAD_XFER_RX_STREAM;
+			xfer[num_xfers].cs_change = 1;
+			num_xfers++;
+		}
+
+		/*
+		 * State reset: clear accumulator so DATA_READY can fire again.
+		 *
+		 * With bits_per_word=32, SPI engine reads native u32
+		 * and transmits MSB first. No byte-swap needed.
+		 *
+		 * The device uses address-descending mode when streaming, so
+		 * the 4th byte is written to the OSC_EN register. In AUTONOMOUS
+		 * and SPI_BURST modes we want OSC_EN re-asserted, therefore set
+		 * the 4th byte to 0x01 for those modes.
+		 */
+		if (st->adc_mode == AD4691_AUTONOMOUS_MODE ||
+		    st->adc_mode == AD4691_SPI_BURST_MODE) {
+			st->offload_tx_reset = ((AD4691_STATE_RESET_REG >> 8) << 24) |
+				       ((AD4691_STATE_RESET_REG & 0xFF) << 16) |
+				       (0x01 << 8) | 0x01;
+		} else {
+			st->offload_tx_reset = ((AD4691_STATE_RESET_REG >> 8) << 24) |
+				       ((AD4691_STATE_RESET_REG & 0xFF) << 16) |
+				       (0x01 << 8);
+		}
+
+		xfer[num_xfers].tx_buf = &st->offload_tx_reset;
+		xfer[num_xfers].len = 4;
+		xfer[num_xfers].bits_per_word = 32;
+		xfer[num_xfers].speed_hz = st->spi->max_speed_hz;
+		xfer[num_xfers].cs_change = 0;
+		num_xfers++;
+
+		break;
+
+	case AD4691_MANUAL_MODE:
+		/*
+		 * Manual mode with CNV tied to CS: Each CS toggle triggers a
+		 * conversion AND reads the previous conversion result (pipeline).
+		 */
+		for (i = 0; i < n_active; i++) {
+			st->offload_tx_cmd[num_xfers] = AD4691_ADC_CHAN(active_chans[i]) << 24;
+			xfer[num_xfers].tx_buf = &st->offload_tx_cmd[num_xfers];
+			xfer[num_xfers].len = 4;
+			xfer[num_xfers].bits_per_word = 32;
+			xfer[num_xfers].speed_hz = st->spi->max_speed_hz;
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
+		st->offload_tx_cmd[num_xfers] = AD4691_NOOP << 24;
+		xfer[num_xfers].tx_buf = &st->offload_tx_cmd[num_xfers];
+		xfer[num_xfers].len = 4;
+		xfer[num_xfers].bits_per_word = 32;
+		xfer[num_xfers].speed_hz = st->spi->max_speed_hz;
+		xfer[num_xfers].cs_change = 0;
+		xfer[num_xfers].offload_flags = SPI_OFFLOAD_XFER_RX_STREAM;
+		num_xfers++;
+		break;
+
+	default:
+		return -EINVAL;
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
+					  st->spi->max_speed_hz * 2);
+
+		trigger_period_ns = div64_u64(NSEC_PER_SEC, st->offload_trigger_hz);
+
+		if (trigger_period_ns < min_period_ns)
+			return -EINVAL;
+	}
+
+	spi_message_init_with_transfers(&st->offload_msg, xfer, num_xfers);
+	st->offload_msg.offload = st->offload;
+
+	ret = spi_optimize_message(st->spi, &st->offload_msg);
+	if (ret)
+		return ret;
+
+	/*
+	 * Start conversions before enabling the trigger for all non-MANUAL modes.
+	 * If the trigger is enabled first, the SPI engine blocks waiting for
+	 * DATA_READY, and any subsequent SPI write times out.
+	 *
+	 * MANUAL_MODE: CNV is tied to CS; conversion starts with each transfer.
+	 * CNV_BURST_MODE: cnv_period updated above; PWM starts conversions.
+	 * AUTONOMOUS_MODE: OSC_EN=1 written here; DATA_READY fires when
+	 * accumulation completes and triggers the SPI engine offload sequence.
+	 */
+	if (st->adc_mode != AD4691_MANUAL_MODE) {
+		if (st->adc_mode == AD4691_CNV_BURST_MODE)
+			st->cnv_period =
+				ad4691_cnv_burst_period_ns(st, n_active, true);
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
+	ad4691_sampling_enable(st, false);
+err_unoptimize_message:
+	spi_unoptimize_message(&st->offload_msg);
+	return ret;
+}
+
+static int ad4691_offload_buffer_predisable(struct iio_dev *indio_dev)
+{
+	struct ad4691_state *st = iio_priv(indio_dev);
+	struct spi_offload_trigger *trigger;
+	int ret = 0, tmp;
+
+	trigger = (st->adc_mode == AD4691_MANUAL_MODE) ?
+		  st->offload_trigger_periodic : st->offload_trigger;
+
+	spi_offload_trigger_disable(st->offload, trigger);
+	spi_unoptimize_message(&st->offload_msg);
+
+	/* Stop conversions and reset sequencer state (not needed for MANUAL_MODE) */
+	if (st->adc_mode != AD4691_MANUAL_MODE) {
+		tmp = ad4691_sampling_enable(st, false);
+		if (!ret)
+			ret = tmp;
+
+		tmp = regmap_write(st->regmap, AD4691_STD_SEQ_CONFIG,
+				   AD4691_SEQ_ALL_CHANNELS_OFF);
+		if (!ret)
+			ret = tmp;
+
+		tmp = regmap_write(st->regmap, AD4691_STATE_RESET_REG,
+				   AD4691_STATE_RESET_ALL);
+		if (!ret)
+			ret = tmp;
+	}
+
+	return ret;
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
@@ -1353,10 +1802,17 @@ static void ad4691_setup_channels(struct iio_dev *indio_dev,
 				  struct ad4691_state *st)
 {
 	if (st->adc_mode == AD4691_MANUAL_MODE) {
-		if (st->chip->num_channels == 8)
-			indio_dev->channels = ad4693_manual_channels;
-		else
-			indio_dev->channels = ad4691_manual_channels;
+		if (st->offload) {
+			if (st->chip->num_channels == 8)
+				indio_dev->channels = ad4693_manual_offload_channels;
+			else
+				indio_dev->channels = ad4691_manual_offload_channels;
+		} else {
+			if (st->chip->num_channels == 8)
+				indio_dev->channels = ad4693_manual_channels;
+			else
+				indio_dev->channels = ad4691_manual_channels;
+		}
 	} else {
 		indio_dev->channels = st->chip->channels;
 	}
@@ -1364,6 +1820,54 @@ static void ad4691_setup_channels(struct iio_dev *indio_dev,
 	indio_dev->num_channels = st->chip->num_channels;
 }
 
+static int ad4691_setup_offload(struct iio_dev *indio_dev,
+				struct ad4691_state *st)
+{
+	struct device *dev = &st->spi->dev;
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
+								      st->spi->max_speed_hz);
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
@@ -1455,6 +1959,14 @@ static int ad4691_probe(struct spi_device *spi)
 		return dev_err_probe(dev, PTR_ERR(st->regmap),
 				     "Failed to initialize regmap\n");
 
+	st->offload = devm_spi_offload_get(dev, spi, &ad4691_offload_config);
+	if (IS_ERR(st->offload)) {
+		if (PTR_ERR(st->offload) != -ENODEV)
+			return dev_err_probe(dev, PTR_ERR(st->offload),
+					     "failed to get SPI offload\n");
+		st->offload = NULL;
+	}
+
 	st->chip = spi_get_device_match_data(spi);
 	if (!st->chip) {
 		st->chip = (void *)spi_get_device_id(spi)->driver_data;
@@ -1481,9 +1993,15 @@ static int ad4691_probe(struct spi_device *spi)
 
 	ad4691_setup_channels(indio_dev, st);
 
-	ret = ad4691_setup_triggered_buffer(indio_dev, st);
-	if (ret)
-		return ret;
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
@@ -1510,3 +2028,4 @@ module_spi_driver(ad4691_driver);
 MODULE_AUTHOR("Radu Sabau <radu.sabau@analog.com>");
 MODULE_DESCRIPTION("Analog Devices AD4691 Family ADC Driver");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("IIO_DMA_BUFFER");

-- 
2.43.0



