Return-Path: <linux-pwm+bounces-8861-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uMWpMoTDAWqWjgEAu9opvQ
	(envelope-from <linux-pwm+bounces-8861-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 11 May 2026 13:54:44 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D99B50D21C
	for <lists+linux-pwm@lfdr.de>; Mon, 11 May 2026 13:54:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9CB8B30237EF
	for <lists+linux-pwm@lfdr.de>; Mon, 11 May 2026 11:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2066137B01A;
	Mon, 11 May 2026 11:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RGD9fDj8"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39A9378D63;
	Mon, 11 May 2026 11:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778500457; cv=none; b=Nio8dc2+XFjiw4nC8cyisyrnix4wJhP+gseAH/gR1JSozhs2+wUGk3RJ1ikdnQzNEoREUafQFNYZvyNnwzNbycovTBpiw73NFCZdY3XMgnBiym83gPM3Q/jikS2MaE1DmKgSGtJvsns9hZfkzDcStPjvZ0apP2SVSJZX7G/dVXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778500457; c=relaxed/simple;
	bh=+ZY1TGq52XfpLedGDwFxPgghBq2u1gWpdEIwvgdZ0ho=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tVEIs2GeeQfGsqNDbN+x45UYOL1uxtP6Lhe/f3PQ5+fA13nLRryeKOww+wbdL3kdYYNe0thb9pAmW9ZKLJdZMUdLgGo7aMtJx3oIv7lL7v2kOj+a2EXxYkV2Zhd5PEIEE/BczIreOVApVtNfkE1YcI7gDHlGvWrWW/dd9P6FA0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RGD9fDj8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A844EC2BCFD;
	Mon, 11 May 2026 11:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778500456;
	bh=+ZY1TGq52XfpLedGDwFxPgghBq2u1gWpdEIwvgdZ0ho=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=RGD9fDj8k6sP89NuiHipJvneD38ugn6uHi4OkIIH5UfEnA3K49o8F6Bn8JOnZBY+A
	 QgJTpiGoe6eiIh32i1la9uGYne0ggSWwX4wiEoHGC3Z7JnNj46dXsdhyFX1lxSbcNM
	 AETdvZhEYt7137+9vuWPgVk+Fy8hAfaXJpmVQVVidBKbDeX03MxN9YOVptqogKszPd
	 xm9I2D3faOpOQyHPYNyXzEURNd1niCZ0vkxqZuRJmMX3LHxqUTD6QThZsDoajJVp3H
	 x07AZwUs0DjwHfE/+ZP3ux9zfhLUtMDrQGwR25PyGa20MCHHYrYWMsnW57vy4THmX2
	 LHPYclzXXR6Mw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EC02CD37B9;
	Mon, 11 May 2026 11:54:16 +0000 (UTC)
From: Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org>
Date: Mon, 11 May 2026 14:54:17 +0300
Subject: [PATCH v10 5/6] iio: adc: ad4691: add oversampling support
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260511-ad4692-multichannel-sar-adc-driver-v10-5-e1fbb1744e38@analog.com>
References: <20260511-ad4692-multichannel-sar-adc-driver-v10-0-e1fbb1744e38@analog.com>
In-Reply-To: <20260511-ad4692-multichannel-sar-adc-driver-v10-0-e1fbb1744e38@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778500454; l=17822;
 i=radu.sabau@analog.com; s=20260220; h=from:subject:message-id;
 bh=KQ2OzN9C4QtKkxFoUI0hsb2vPFiAq44wz10x0Fvt/EI=;
 b=viCoogBxjIY6pLmKnf7hc1gFlgWYBMnRjaCcYZTAghBowmgjd9Gsxy+aAH9qKQevzpVRnlGIU
 uA7P4i3VnUNDOErd4g2HOBSSw72rOJ90mZQBoscz7lYT8d5OiZz1rxI
X-Developer-Key: i=radu.sabau@analog.com; a=ed25519;
 pk=lDPQHgn9jTdt0vo58Na9lLxLaE2mb330if71Cn+EvFU=
X-Endpoint-Received: by B4 Relay for radu.sabau@analog.com/20260220 with
 auth_id=642
X-Original-From: Radu Sabau <radu.sabau@analog.com>
Reply-To: radu.sabau@analog.com
X-Rspamd-Queue-Id: 8D99B50D21C
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
	TAGGED_FROM(0.00)[bounces-8861-lists,linux-pwm=lfdr.de,radu.sabau.analog.com];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,analog.com:email,analog.com:mid,analog.com:replyto]
X-Rspamd-Action: no action

From: Radu Sabau <radu.sabau@analog.com>

Add per-channel oversampling ratio (OSR) support for CNV burst mode.
The accumulator depth register (ACC_DEPTH_IN) is programmed with the
selected OSR at buffer enable time and before each single-shot read.

Supported OSR values: 1, 2, 4, 8, 16, 32.

Introduce AD4691_MANUAL_CHANNEL() for manual mode channels, which do
not expose the oversampling ratio attribute since OSR is not applicable
in that mode. A separate manual_channels array is added to
struct ad4691_channel_info and selected at probe time;

in_voltageN_sampling_frequency represents the effective output rate for
channel N, defined as osc_freq / osr[N]. The chip has one internal
oscillator shared by all channels; each channel independently
accumulates osr[N] oscillator cycles before producing a result.

Writing sampling_frequency computes needed_osc = freq * osr[N] and
snaps down to the largest oscillator table entry that satisfies both
osc <= needed_osc and osc % osr[N] == 0, guaranteeing an exact integer
read-back. The result is stored in target_osc_freq_Hz and written to
OSC_FREQ_REG at buffer enable and single-shot time, so sampling_frequency
and oversampling_ratio can be set in any order.

in_voltageN_sampling_frequency_available is computed dynamically from
the channel's current OSR, listing only oscillator table entries that
divide evenly by osr[N], expressed as effective rates. The list becomes
sparser as OSR increases, capping at max_rate / osr[N].

Writing oversampling_ratio stores the new OSR for that channel;
target_osc_freq_Hz is left unchanged. The effective rate read back via
in_voltageN_sampling_frequency becomes target_osc_freq_Hz / new_osr
automatically. The two attributes are orthogonal: sampling_frequency
controls the oscillator, oversampling_ratio controls the averaging depth.

OSR defaults to 1 (no accumulation) for all channels.

Signed-off-by: Radu Sabau <radu.sabau@analog.com>
---
 drivers/iio/adc/ad4691.c | 268 +++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 234 insertions(+), 34 deletions(-)

diff --git a/drivers/iio/adc/ad4691.c b/drivers/iio/adc/ad4691.c
index 011a3cd46da0..842c4012801c 100644
--- a/drivers/iio/adc/ad4691.c
+++ b/drivers/iio/adc/ad4691.c
@@ -25,6 +25,7 @@
 #include <linux/reset.h>
 #include <linux/string.h>
 #include <linux/spi/spi.h>
+#include <linux/types.h>
 #include <linux/spi/offload/consumer.h>
 #include <linux/spi/offload/provider.h>
 #include <linux/units.h>
@@ -117,6 +118,7 @@ enum ad4691_ref_ctrl {
 
 struct ad4691_channel_info {
 	const struct iio_chan_spec *channels __counted_by_ptr(num_channels);
+	const struct iio_chan_spec *manual_channels __counted_by_ptr(num_channels);
 	unsigned int num_channels;
 };
 
@@ -127,12 +129,39 @@ struct ad4691_chip_info {
 	const struct ad4691_channel_info *offload_info;
 };
 
+/* CNV burst mode channel — exposes oversampling ratio. */
 #define AD4691_CHANNEL(ch)						\
 	{								\
 		.type = IIO_VOLTAGE,					\
 		.indexed = 1,						\
-		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW)		\
-				    | BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |		\
+				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO) | \
+				      BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
+		.info_mask_separate_available =				\
+				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO) | \
+				      BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SCALE),	\
+		.channel = ch,						\
+		.scan_index = ch,					\
+		.scan_type = {						\
+			.sign = 'u',					\
+			.realbits = 16,					\
+			.storagebits = 16,				\
+			.endianness = IIO_BE,				\
+		},							\
+	}
+
+/*
+ * Manual mode channel — no oversampling ratio attribute. OSR is not
+ * supported in manual mode; ACC_DEPTH_IN is not configured during manual
+ * buffer enable.
+ */
+#define AD4691_MANUAL_CHANNEL(ch)					\
+	{								\
+		.type = IIO_VOLTAGE,					\
+		.indexed = 1,						\
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |		\
+				      BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
 		.info_mask_separate_available =				\
 				      BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
 		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SCALE),	\
@@ -177,25 +206,65 @@ static const struct iio_chan_spec ad4693_channels[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(8),
 };
 
+static const struct iio_chan_spec ad4691_manual_channels[] = {
+	AD4691_MANUAL_CHANNEL(0),
+	AD4691_MANUAL_CHANNEL(1),
+	AD4691_MANUAL_CHANNEL(2),
+	AD4691_MANUAL_CHANNEL(3),
+	AD4691_MANUAL_CHANNEL(4),
+	AD4691_MANUAL_CHANNEL(5),
+	AD4691_MANUAL_CHANNEL(6),
+	AD4691_MANUAL_CHANNEL(7),
+	AD4691_MANUAL_CHANNEL(8),
+	AD4691_MANUAL_CHANNEL(9),
+	AD4691_MANUAL_CHANNEL(10),
+	AD4691_MANUAL_CHANNEL(11),
+	AD4691_MANUAL_CHANNEL(12),
+	AD4691_MANUAL_CHANNEL(13),
+	AD4691_MANUAL_CHANNEL(14),
+	AD4691_MANUAL_CHANNEL(15),
+	IIO_CHAN_SOFT_TIMESTAMP(16),
+};
+
+static const struct iio_chan_spec ad4693_manual_channels[] = {
+	AD4691_MANUAL_CHANNEL(0),
+	AD4691_MANUAL_CHANNEL(1),
+	AD4691_MANUAL_CHANNEL(2),
+	AD4691_MANUAL_CHANNEL(3),
+	AD4691_MANUAL_CHANNEL(4),
+	AD4691_MANUAL_CHANNEL(5),
+	AD4691_MANUAL_CHANNEL(6),
+	AD4691_MANUAL_CHANNEL(7),
+	IIO_CHAN_SOFT_TIMESTAMP(8),
+};
+
+static const int ad4691_oversampling_ratios[] = { 1, 2, 4, 8, 16, 32 };
+
 static const struct ad4691_channel_info ad4691_sw_info = {
 	.channels = ad4691_channels,
+	.manual_channels = ad4691_manual_channels,
 	.num_channels = ARRAY_SIZE(ad4691_channels),
 };
 
 static const struct ad4691_channel_info ad4693_sw_info = {
 	.channels = ad4693_channels,
+	.manual_channels = ad4693_manual_channels,
 	.num_channels = ARRAY_SIZE(ad4693_channels),
 };
 
 static const struct ad4691_channel_info ad4691_offload_info = {
 	.channels = ad4691_channels,
-	/* Exclude the soft timestamp entry; num_channels caps access. */
+	/*
+	 * Offload paths share the SW channel arrays. num_channels caps access
+	 * before the soft timestamp entry, so no separate array is needed.
+	 */
+	.manual_channels = ad4691_manual_channels,
 	.num_channels = ARRAY_SIZE(ad4691_channels) - 1,
 };
 
 static const struct ad4691_channel_info ad4693_offload_info = {
 	.channels = ad4693_channels,
-	/* Exclude the soft timestamp entry; num_channels caps access. */
+	.manual_channels = ad4693_manual_channels,
 	.num_channels = ARRAY_SIZE(ad4693_channels) - 1,
 };
 
@@ -268,6 +337,19 @@ struct ad4691_state {
 	int irq;
 	int vref_uV;
 	u32 cnv_period_ns;
+	/*
+	 * Snapped oscillator frequency (Hz) shared by all channels. Set when
+	 * sampling_frequency or oversampling_ratio is written; written to
+	 * OSC_FREQ_REG at buffer enable and single-shot time so both attributes
+	 * can be set in any order. Reading in_voltageN_sampling_frequency
+	 * returns target_osc_freq_Hz / osr[N] — the effective rate for that
+	 * channel given its oversampling ratio.
+	 */
+	u32 target_osc_freq_Hz;
+	/* Per-channel oversampling ratio; always 1 in manual mode. */
+	u8 osr[16];
+	/* Scratch buffer for read_avail SAMP_FREQ; content is OSR-dependent. */
+	int samp_freq_avail[16][ARRAY_SIZE(ad4691_osc_freqs_Hz)];
 
 	bool manual_mode;
 	bool refbuf_en;
@@ -341,8 +423,7 @@ static bool ad4691_offload_trigger_match(struct spi_offload_trigger *trigger,
 					 enum spi_offload_trigger_type type,
 					 u64 *args, u32 nargs)
 {
-	return type == SPI_OFFLOAD_TRIGGER_DATA_READY &&
-	       nargs == 1 && args[0] <= 3;
+	return type == SPI_OFFLOAD_TRIGGER_DATA_READY && nargs == 1 && args[0] <= 3;
 }
 
 static int ad4691_offload_trigger_request(struct spi_offload_trigger *trigger,
@@ -501,6 +582,16 @@ static const struct regmap_config ad4691_regmap_config = {
 	.cache_type = REGCACHE_MAPLE,
 };
 
+/* Write target_osc_freq_Hz to OSC_FREQ_REG. Called at use time. */
+static int ad4691_write_osc_freq(struct ad4691_state *st)
+{
+	for (unsigned int i = 0; i < ARRAY_SIZE(ad4691_osc_freqs_Hz); i++) {
+		if (ad4691_osc_freqs_Hz[i] == st->target_osc_freq_Hz)
+			return regmap_write(st->regmap, AD4691_OSC_FREQ_REG, i);
+	}
+	return -EINVAL;
+}
+
 /*
  * Index 0 in ad4691_osc_freqs_Hz is 1 MHz — valid only for AD4692/AD4694
  * (max_rate == 1 MHz). AD4691/AD4693 cap at 500 kHz so their valid range
@@ -511,36 +602,58 @@ static unsigned int ad4691_samp_freq_start(const struct ad4691_chip_info *info)
 	return (info->max_rate == 1 * HZ_PER_MHZ) ? 0 : 1;
 }
 
-static int ad4691_get_sampling_freq(struct ad4691_state *st, int *val)
+/*
+ * Find the largest oscillator table entry that is both <= needed_osc and
+ * evenly divisible by osr (guaranteeing an integer effective rate on
+ * read-back). Returns 0 if no such entry exists in the chip's valid range.
+ */
+static unsigned int ad4691_find_osc_freq(struct ad4691_state *st,
+					 unsigned int needed_osc,
+					 unsigned int osr)
 {
-	unsigned int reg_val;
-	int ret;
+	unsigned int start = ad4691_samp_freq_start(st->info);
 
-	ret = regmap_read(st->regmap, AD4691_OSC_FREQ_REG, &reg_val);
-	if (ret)
-		return ret;
+	for (unsigned int i = start; i < ARRAY_SIZE(ad4691_osc_freqs_Hz); i++) {
+		if ((unsigned int)ad4691_osc_freqs_Hz[i] > needed_osc)
+			continue;
+		if (ad4691_osc_freqs_Hz[i] % osr)
+			continue;
+		return ad4691_osc_freqs_Hz[i];
+	}
+	return 0;
+}
 
-	*val = ad4691_osc_freqs_Hz[FIELD_GET(AD4691_OSC_FREQ_MASK, reg_val)];
+static int ad4691_get_sampling_freq(struct ad4691_state *st, u8 osr, int *val)
+{
+	*val = st->target_osc_freq_Hz / osr;
 	return IIO_VAL_INT;
 }
 
-static int ad4691_set_sampling_freq(struct iio_dev *indio_dev, int freq)
+static int ad4691_set_sampling_freq(struct iio_dev *indio_dev,
+				    struct iio_chan_spec const *chan, int freq)
 {
 	struct ad4691_state *st = iio_priv(indio_dev);
-	unsigned int start = ad4691_samp_freq_start(st->info);
+	unsigned int osr = st->osr[chan->channel];
+	unsigned int found;
 
 	IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
 	if (IIO_DEV_ACQUIRE_FAILED(claim))
 		return -EBUSY;
 
-	for (unsigned int i = start; i < ARRAY_SIZE(ad4691_osc_freqs_Hz); i++) {
-		if (ad4691_osc_freqs_Hz[i] != freq)
-			continue;
-		return regmap_update_bits(st->regmap, AD4691_OSC_FREQ_REG,
-					  AD4691_OSC_FREQ_MASK, i);
-	}
+	if (freq <= 0 || freq > st->info->max_rate / osr)
+		return -EINVAL;
 
-	return -EINVAL;
+	found = ad4691_find_osc_freq(st, freq * osr, osr);
+	if (!found)
+		return -EINVAL;
+
+	/*
+	 * Store the snapped oscillator frequency; OSC_FREQ_REG is written at
+	 * buffer enable and single-shot time so that sampling_frequency and
+	 * oversampling_ratio can be set in any order.
+	 */
+	st->target_osc_freq_Hz = found;
+	return 0;
 }
 
 static int ad4691_read_avail(struct iio_dev *indio_dev,
@@ -552,10 +665,30 @@ static int ad4691_read_avail(struct iio_dev *indio_dev,
 	unsigned int start = ad4691_samp_freq_start(st->info);
 
 	switch (mask) {
-	case IIO_CHAN_INFO_SAMP_FREQ:
-		*vals = &ad4691_osc_freqs_Hz[start];
+	case IIO_CHAN_INFO_SAMP_FREQ: {
+		unsigned int osr = st->osr[chan->channel];
+		int n = 0;
+
+		/*
+		 * Only oscillator frequencies evenly divisible by the channel's
+		 * OSR yield an integer effective rate; expose those as effective
+		 * rates (osc / osr) so the user works entirely in output-sample
+		 * space.
+		 */
+		for (unsigned int i = start; i < ARRAY_SIZE(ad4691_osc_freqs_Hz); i++) {
+			if (ad4691_osc_freqs_Hz[i] % osr)
+				continue;
+			st->samp_freq_avail[chan->channel][n++] = ad4691_osc_freqs_Hz[i] / osr;
+		}
+		*vals = st->samp_freq_avail[chan->channel];
 		*type = IIO_VAL_INT;
-		*length = ARRAY_SIZE(ad4691_osc_freqs_Hz) - start;
+		*length = n;
+		return IIO_AVAIL_LIST;
+	}
+	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+		*vals = ad4691_oversampling_ratios;
+		*type = IIO_VAL_INT;
+		*length = ARRAY_SIZE(ad4691_oversampling_ratios);
 		return IIO_AVAIL_LIST;
 	default:
 		return -EINVAL;
@@ -566,7 +699,7 @@ static int ad4691_single_shot_read(struct iio_dev *indio_dev,
 				   struct iio_chan_spec const *chan, int *val)
 {
 	struct ad4691_state *st = iio_priv(indio_dev);
-	unsigned int reg_val, osc_idx, period_us;
+	unsigned int reg_val, period_us;
 	int ret;
 
 	guard(mutex)(&st->lock);
@@ -587,7 +720,12 @@ static int ad4691_single_shot_read(struct iio_dev *indio_dev,
 	if (ret)
 		return ret;
 
-	ret = regmap_read(st->regmap, AD4691_OSC_FREQ_REG, &reg_val);
+	ret = regmap_write(st->regmap, AD4691_ACC_DEPTH_IN(chan->channel),
+			   st->osr[chan->channel]);
+	if (ret)
+		return ret;
+
+	ret = ad4691_write_osc_freq(st);
 	if (ret)
 		return ret;
 
@@ -595,9 +733,12 @@ static int ad4691_single_shot_read(struct iio_dev *indio_dev,
 	if (ret)
 		return ret;
 
-	osc_idx = FIELD_GET(AD4691_OSC_FREQ_MASK, reg_val);
-	/* Wait 2 oscillator periods for the conversion to complete. */
-	period_us = DIV_ROUND_UP(2UL * USEC_PER_SEC, ad4691_osc_freqs_Hz[osc_idx]);
+	/*
+	 * Wait osr + 1 oscillator periods: osr for accumulation, +1 for the
+	 * pipeline margin (one extra period ensures the final result is ready).
+	 */
+	period_us = DIV_ROUND_UP((st->osr[chan->channel] + 1) * USEC_PER_SEC,
+				 st->target_osc_freq_Hz);
 	fsleep(period_us);
 
 	ret = regmap_write(st->regmap, AD4691_OSC_EN_REG, 0);
@@ -632,7 +773,10 @@ static int ad4691_read_raw(struct iio_dev *indio_dev,
 		return ad4691_single_shot_read(indio_dev, chan, val);
 	}
 	case IIO_CHAN_INFO_SAMP_FREQ:
-		return ad4691_get_sampling_freq(st, val);
+		return ad4691_get_sampling_freq(st, st->osr[chan->channel], val);
+	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+		*val = st->osr[chan->channel];
+		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
 		*val = st->vref_uV / (MICRO / MILLI);
 		*val2 = chan->scan_type.realbits;
@@ -646,9 +790,40 @@ static int ad4691_write_raw(struct iio_dev *indio_dev,
 			    struct iio_chan_spec const *chan,
 			    int val, int val2, long mask)
 {
+	struct ad4691_state *st = iio_priv(indio_dev);
+
 	switch (mask) {
 	case IIO_CHAN_INFO_SAMP_FREQ:
-		return ad4691_set_sampling_freq(indio_dev, val);
+		return ad4691_set_sampling_freq(indio_dev, chan, val);
+	case IIO_CHAN_INFO_OVERSAMPLING_RATIO: {
+		IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
+		if (IIO_DEV_ACQUIRE_FAILED(claim))
+			return -EBUSY;
+
+		for (unsigned int i = 0; i < ARRAY_SIZE(ad4691_oversampling_ratios); i++) {
+			unsigned int old_effective, found;
+
+			if (ad4691_oversampling_ratios[i] != val)
+				continue;
+			/*
+			 * Snap target_osc_freq_Hz to the largest table entry
+			 * that is both <= old_effective * new_osr and evenly
+			 * divisible by new_osr, preserving an integer read-back
+			 * of in_voltageN_sampling_frequency after the OSR change.
+			 */
+			old_effective = st->target_osc_freq_Hz /
+					st->osr[chan->channel];
+			found = ad4691_find_osc_freq(st,
+						     old_effective * (unsigned int)val,
+						     val);
+			if (!found)
+				return -EINVAL;
+			st->target_osc_freq_Hz = found;
+			st->osr[chan->channel] = val;
+			return 0;
+		}
+		return -EINVAL;
+	}
 	default:
 		return -EINVAL;
 	}
@@ -703,6 +878,10 @@ static int ad4691_enter_conversion_mode(struct ad4691_state *st)
 		return regmap_update_bits(st->regmap, AD4691_DEVICE_SETUP,
 					  AD4691_MANUAL_MODE, AD4691_MANUAL_MODE);
 
+	ret = ad4691_write_osc_freq(st);
+	if (ret)
+		return ret;
+
 	ret = regmap_update_bits(st->regmap, AD4691_ADC_SETUP,
 				 AD4691_ADC_MODE_MASK, AD4691_CNV_BURST_MODE);
 	if (ret)
@@ -866,6 +1045,12 @@ static int ad4691_cnv_burst_buffer_preenable(struct iio_dev *indio_dev)
 	if (ret)
 		goto err_unoptimize;
 
+	iio_for_each_active_channel(indio_dev, i) {
+		ret = regmap_write(st->regmap, AD4691_ACC_DEPTH_IN(i), st->osr[i]);
+		if (ret)
+			goto err_unoptimize;
+	}
+
 	ret = ad4691_enter_conversion_mode(st);
 	if (ret)
 		goto err_unoptimize;
@@ -1045,6 +1230,12 @@ static int ad4691_cnv_burst_offload_buffer_postenable(struct iio_dev *indio_dev)
 	if (ret)
 		return ret;
 
+	iio_for_each_active_channel(indio_dev, bit) {
+		ret = regmap_write(st->regmap, AD4691_ACC_DEPTH_IN(bit), st->osr[bit]);
+		if (ret)
+			return ret;
+	}
+
 	ret = ad4691_enter_conversion_mode(st);
 	if (ret)
 		return ret;
@@ -1422,6 +1613,8 @@ static int ad4691_config(struct ad4691_state *st)
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to write OSC_FREQ\n");
 
+	st->target_osc_freq_Hz = ad4691_osc_freqs_Hz[ad4691_samp_freq_start(st->info)];
+
 	ret = regmap_update_bits(st->regmap, AD4691_ADC_SETUP,
 				 AD4691_ADC_MODE_MASK, AD4691_AUTONOMOUS_MODE);
 	if (ret)
@@ -1581,6 +1774,7 @@ static int ad4691_probe(struct spi_device *spi)
 	st->info = spi_get_device_match_data(spi);
 	if (!st->info)
 		return -ENODEV;
+	memset(st->osr, 1, sizeof(st->osr));
 
 	ret = devm_mutex_init(dev, &st->lock);
 	if (ret)
@@ -1615,11 +1809,17 @@ static int ad4691_probe(struct spi_device *spi)
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	if (spi_offload) {
-		indio_dev->channels = st->info->offload_info->channels;
+		if (st->manual_mode)
+			indio_dev->channels = st->info->offload_info->manual_channels;
+		else
+			indio_dev->channels = st->info->offload_info->channels;
 		indio_dev->num_channels = st->info->offload_info->num_channels;
 		ret = ad4691_setup_offload(indio_dev, st, spi_offload);
 	} else {
-		indio_dev->channels = st->info->sw_info->channels;
+		if (st->manual_mode)
+			indio_dev->channels = st->info->sw_info->manual_channels;
+		else
+			indio_dev->channels = st->info->sw_info->channels;
 		indio_dev->num_channels = st->info->sw_info->num_channels;
 		ret = ad4691_setup_triggered_buffer(indio_dev, st);
 	}

-- 
2.43.0



