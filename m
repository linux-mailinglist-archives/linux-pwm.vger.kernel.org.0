Return-Path: <linux-pwm+bounces-9205-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OGoFIWVnGWpMwQgAu9opvQ
	(envelope-from <linux-pwm+bounces-9205-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 29 May 2026 12:16:05 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 00ECE600A05
	for <lists+linux-pwm@lfdr.de>; Fri, 29 May 2026 12:16:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D6F8C303CC7E
	for <lists+linux-pwm@lfdr.de>; Fri, 29 May 2026 10:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69C7F3C8184;
	Fri, 29 May 2026 10:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CWXZXd4M"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3197F3C0604;
	Fri, 29 May 2026 10:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780049704; cv=none; b=ryKriQ7MAwaYRe1GglynAH5PWaHiMolqMEO9uxwlH/Q9DiF0GNNsycIG+jKpQLbGvD8T7hEIvQGNc+HNeUVlEp8JFT4Gl8YA3qSJWlWfTG0R9w2YCVEllhZqAgk3SA0v39HB7bOQZ1vMxkdSy/5aI0nuNwZhIDLw51wjDRNw4YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780049704; c=relaxed/simple;
	bh=uHX2Lyt2071S9+m5tCp2CvoLOSa8GAvy802srwdbzIs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l2L+lnY21NJBmljr3df6HjkCNQIPD3XbGGSiYGss/gAKWdtu3gtroCidPmzAmqdWItLZZKFRwChuvbDpzVXaKrY39z1slaUGwEjI2ImNelKAOv4GtJl3UGA7fZ6m3y9UuBSmswmMWVLCcPn0CnTh9AQZJxB2SXHBgPylnP2ApsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CWXZXd4M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0B93EC2BD05;
	Fri, 29 May 2026 10:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1780049704;
	bh=uHX2Lyt2071S9+m5tCp2CvoLOSa8GAvy802srwdbzIs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=CWXZXd4MpgIw8q/r+BKS5q1Y7GkCWukVL+9KlGrEGwbsyp5Z5mg4MtaVTFasf86en
	 dmpviilQ10E7mn1grPxJ1OT47QY7i9MIJ8YnxxZUrmAxJ3PD3zL+WieJboawaZjEy6
	 Ye5LxhyRlqvtfSdXoxenudz5k11JlTbgL3hOk2EknDFnmFhRZxwRWHdLb92uPtJbg5
	 sz19aKe6vYkqvWg1/IKlm9fkYpfQv6dH3+dvXI2a/J4nFq5TYs5RKz/VJk9GUXVggj
	 nz34wTDY6i4M23aoL6smRAsFOA9rp4efnPi+XSXr8505y6+gaUr9ABYPJDPIJ9QR06
	 8POPVICa+5Vzw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03F9BCD6E43;
	Fri, 29 May 2026 10:15:04 +0000 (UTC)
From: Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org>
Date: Fri, 29 May 2026 13:15:04 +0300
Subject: [PATCH v14 5/6] iio: adc: ad4691: add oversampling support
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260529-ad4692-multichannel-sar-adc-driver-v14-5-e93c2747dc1f@analog.com>
References: <20260529-ad4692-multichannel-sar-adc-driver-v14-0-e93c2747dc1f@analog.com>
In-Reply-To: <20260529-ad4692-multichannel-sar-adc-driver-v14-0-e93c2747dc1f@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780049701; l=20831;
 i=radu.sabau@analog.com; s=20260220; h=from:subject:message-id;
 bh=wIg14vUVcGGm92k22NkKLUwa1qXduJNO09x/JfQTJm8=;
 b=p8c8Y6L4foua+VFWBJ9G5KcdVTGr2XyffTCsQkgidJJ4RBbj8kKZQloiK4eBrEPEDLY9WeebD
 aADqPYxzyOIC2M+bGBjLwxdbT/OI0tQ1aJ78k4dQSC4ZY3tp/Cc8vW0
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9205-lists,linux-pwm=lfdr.de,radu.sabau.analog.com];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	HAS_REPLYTO(0.00)[radu.sabau@analog.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[analog.com:replyto,analog.com:mid,analog.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 00ECE600A05
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Radu Sabau <radu.sabau@analog.com>

Add oversampling ratio (OSR) support for CNV burst mode. The accumulator
depth register (ACC_DEPTH_IN(0)) is programmed with the selected OSR at
buffer enable time and before each single-shot read.

Supported OSR values: 1, 2, 4, 8, 16, 32.

Introduce AD4691_MANUAL_CHANNEL() for manual mode channels, which do
not expose the oversampling_ratio attribute since OSR is not applicable
in that mode. A separate manual_channels array is added to
struct ad4691_channel_info and selected at probe time.

The OSR is shared across all channels (in_voltage_sampling_frequency
and in_voltage_oversampling_ratio are info_mask_shared_by_all) because
the chip has one internal oscillator and a single accumulator depth
register (ACC_DEPTH_IN(0)) for all channels.

in_voltage_sampling_frequency represents the effective output rate,
defined as osc_freq / osr. Writing it computes needed_osc = freq * osr
and snaps down to the largest oscillator table entry that satisfies both
osc <= needed_osc and osc % osr == 0, guaranteeing an exact integer
read-back. The result is stored in target_osc_freq_Hz and written to
OSC_FREQ_REG at buffer enable and single-shot time, so sampling_frequency
and oversampling_ratio can be set in any order.

in_voltage_sampling_frequency_available is precomputed at probe for
each OSR value, listing only oscillator table entries that divide
evenly by that OSR, expressed as effective rates (osc_freq / osr).
The list becomes sparser as OSR increases, capping at max_rate / osr.
read_avail picks the precomputed list for the current OSR, making the
returned pointer stable and race-free.

Writing oversampling_ratio stores the new shared OSR and snaps
target_osc_freq_Hz to the largest oscillator table entry that is both
<= old_effective_rate * new_osr and evenly divisible by new_osr. This
preserves an integer read-back of in_voltage_sampling_frequency after
the OSR change while keeping the oscillator as close as possible to the
previous effective rate.

OSR defaults to 1 (no accumulation).

Signed-off-by: Radu Sabau <radu.sabau@analog.com>
---
 drivers/iio/adc/ad4691.c | 357 +++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 327 insertions(+), 30 deletions(-)

diff --git a/drivers/iio/adc/ad4691.c b/drivers/iio/adc/ad4691.c
index b1d1b42f724e..043143ae9560 100644
--- a/drivers/iio/adc/ad4691.c
+++ b/drivers/iio/adc/ad4691.c
@@ -122,6 +122,7 @@ enum ad4691_ref_ctrl {
 
 struct ad4691_channel_info {
 	const struct iio_chan_spec *channels __counted_by_ptr(num_channels);
+	const struct iio_chan_spec *manual_channels __counted_by_ptr(num_channels);
 	unsigned int num_channels;
 };
 
@@ -132,7 +133,34 @@ struct ad4691_chip_info {
 	const struct ad4691_channel_info *offload_info;
 };
 
+/* CNV burst mode channel — exposes oversampling ratio. */
 #define AD4691_CHANNEL(ch)						\
+	{								\
+		.type = IIO_VOLTAGE,					\
+		.indexed = 1,						\
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SCALE)	\
+				    | BIT(IIO_CHAN_INFO_SAMP_FREQ)	\
+				    | BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO), \
+		.info_mask_shared_by_all_available =			\
+				      BIT(IIO_CHAN_INFO_SAMP_FREQ)	\
+				    | BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO), \
+		.channel = ch,						\
+		.scan_index = ch,					\
+		.scan_type = {						\
+			.format = 'u',					\
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
 	{								\
 		.type = IIO_VOLTAGE,					\
 		.indexed = 1,						\
@@ -156,8 +184,33 @@ struct ad4691_chip_info {
  * bits into native 16-bit words before DMA, so samples are in
  * CPU-native byte order (IIO_CPU). storagebits=16 matches the 16-bit
  * DMA word size.
+ *
+ * CNV burst offload configures ACC_DEPTH_IN per channel, so the
+ * oversampling_ratio attribute is exposed. Manual offload does not;
+ * use AD4691_OFFLOAD_MANUAL_CHANNEL for that path.
  */
 #define AD4691_OFFLOAD_CHANNEL(ch)					\
+	{								\
+		.type = IIO_VOLTAGE,					\
+		.indexed = 1,						\
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SCALE)	\
+				    | BIT(IIO_CHAN_INFO_SAMP_FREQ)	\
+				    | BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO), \
+		.info_mask_shared_by_all_available =			\
+				      BIT(IIO_CHAN_INFO_SAMP_FREQ)	\
+				    | BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO), \
+		.channel = ch,						\
+		.scan_index = ch,					\
+		.scan_type = {						\
+			.format = 'u',					\
+			.realbits = 16,					\
+			.storagebits = 16,				\
+		},							\
+	}
+
+/* Manual offload — same IIO_CPU layout but no oversampling_ratio attribute. */
+#define AD4691_OFFLOAD_MANUAL_CHANNEL(ch)				\
 	{								\
 		.type = IIO_VOLTAGE,					\
 		.indexed = 1,						\
@@ -241,23 +294,91 @@ static const struct iio_chan_spec ad4693_offload_channels[] = {
 	AD4691_OFFLOAD_CHANNEL(7),
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
+static const struct iio_chan_spec ad4691_offload_manual_channels[] = {
+	AD4691_OFFLOAD_MANUAL_CHANNEL(0),
+	AD4691_OFFLOAD_MANUAL_CHANNEL(1),
+	AD4691_OFFLOAD_MANUAL_CHANNEL(2),
+	AD4691_OFFLOAD_MANUAL_CHANNEL(3),
+	AD4691_OFFLOAD_MANUAL_CHANNEL(4),
+	AD4691_OFFLOAD_MANUAL_CHANNEL(5),
+	AD4691_OFFLOAD_MANUAL_CHANNEL(6),
+	AD4691_OFFLOAD_MANUAL_CHANNEL(7),
+	AD4691_OFFLOAD_MANUAL_CHANNEL(8),
+	AD4691_OFFLOAD_MANUAL_CHANNEL(9),
+	AD4691_OFFLOAD_MANUAL_CHANNEL(10),
+	AD4691_OFFLOAD_MANUAL_CHANNEL(11),
+	AD4691_OFFLOAD_MANUAL_CHANNEL(12),
+	AD4691_OFFLOAD_MANUAL_CHANNEL(13),
+	AD4691_OFFLOAD_MANUAL_CHANNEL(14),
+	AD4691_OFFLOAD_MANUAL_CHANNEL(15),
+};
+
+static const struct iio_chan_spec ad4693_offload_manual_channels[] = {
+	AD4691_OFFLOAD_MANUAL_CHANNEL(0),
+	AD4691_OFFLOAD_MANUAL_CHANNEL(1),
+	AD4691_OFFLOAD_MANUAL_CHANNEL(2),
+	AD4691_OFFLOAD_MANUAL_CHANNEL(3),
+	AD4691_OFFLOAD_MANUAL_CHANNEL(4),
+	AD4691_OFFLOAD_MANUAL_CHANNEL(5),
+	AD4691_OFFLOAD_MANUAL_CHANNEL(6),
+	AD4691_OFFLOAD_MANUAL_CHANNEL(7),
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
 	.channels = ad4691_offload_channels,
+	.manual_channels = ad4691_offload_manual_channels,
 	.num_channels = ARRAY_SIZE(ad4691_offload_channels),
 };
 
 static const struct ad4691_channel_info ad4693_offload_info = {
 	.channels = ad4693_offload_channels,
+	.manual_channels = ad4693_offload_manual_channels,
 	.num_channels = ARRAY_SIZE(ad4693_offload_channels),
 };
 
@@ -324,6 +445,25 @@ struct ad4691_state {
 	int irq;
 	int vref_uV;
 	u32 cnv_period_ns;
+	/*
+	 * Snapped oscillator frequency (Hz) shared by all channels. Set when
+	 * sampling_frequency or oversampling_ratio is written; written to
+	 * OSC_FREQ_REG at buffer enable and single-shot time so both attributes
+	 * can be set in any order. Reading in_voltage_sampling_frequency
+	 * returns target_osc_freq_Hz / osr — the effective rate given the
+	 * shared oversampling ratio.
+	 */
+	u32 target_osc_freq_Hz;
+	/* Shared oversampling ratio across all channels; always 1 in manual mode. */
+	unsigned int osr;
+	/*
+	 * Precomputed effective-rate lists, one row per entry in
+	 * ad4691_oversampling_ratios[]. Populated at probe; read_avail picks
+	 * the row for the current shared OSR. The tables are stable after
+	 * probe so returning a pointer into them from read_avail is race-free.
+	 */
+	int samp_freq_avail[ARRAY_SIZE(ad4691_oversampling_ratios)][ARRAY_SIZE(ad4691_osc_freqs_Hz)];
+	int samp_freq_avail_len[ARRAY_SIZE(ad4691_oversampling_ratios)];
 
 	bool manual_mode;
 	bool irq_enabled;
@@ -580,35 +720,95 @@ static unsigned int ad4691_samp_freq_start(const struct ad4691_chip_info *info)
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
 
-	guard(mutex)(&st->lock);
+	for (unsigned int i = start; i < ARRAY_SIZE(ad4691_osc_freqs_Hz); i++) {
+		if ((unsigned int)ad4691_osc_freqs_Hz[i] > needed_osc)
+			continue;
+		if (ad4691_osc_freqs_Hz[i] % osr)
+			continue;
+		return ad4691_osc_freqs_Hz[i];
+	}
+	return 0;
+}
 
-	ret = regmap_read(st->regmap, AD4691_OSC_FREQ_REG, &reg_val);
-	if (ret)
-		return ret;
+/* Write target_osc_freq_Hz to OSC_FREQ_REG. Called at use time. */
+static int ad4691_write_osc_freq(struct ad4691_state *st)
+{
+	for (unsigned int i = 0; i < ARRAY_SIZE(ad4691_osc_freqs_Hz); i++) {
+		if (ad4691_osc_freqs_Hz[i] == st->target_osc_freq_Hz)
+			return regmap_write(st->regmap, AD4691_OSC_FREQ_REG, i);
+	}
+	return -EINVAL;
+}
 
-	*val = ad4691_osc_freqs_Hz[FIELD_GET(AD4691_OSC_FREQ_MASK, reg_val)];
-	return IIO_VAL_INT;
+/* Return the index of osr in ad4691_oversampling_ratios[], defaulting to 0. */
+static unsigned int ad4691_osr_index(unsigned int osr)
+{
+	for (unsigned int i = 0; i < ARRAY_SIZE(ad4691_oversampling_ratios) - 1; i++) {
+		if ((unsigned int)ad4691_oversampling_ratios[i] == osr)
+			return i;
+	}
+	return ARRAY_SIZE(ad4691_oversampling_ratios) - 1;
+}
+
+/*
+ * Precompute samp_freq_avail[][]: for each OSR value, list the oscillator
+ * table entries that divide evenly by that OSR, expressed as effective rates
+ * (osc_freq / osr). Called once at probe after st->info is set.
+ */
+static void ad4691_precompute_samp_freq_avail(struct ad4691_state *st)
+{
+	unsigned int start = ad4691_samp_freq_start(st->info);
+
+	for (unsigned int i = 0; i < ARRAY_SIZE(ad4691_oversampling_ratios); i++) {
+		unsigned int osr = ad4691_oversampling_ratios[i];
+		int n = 0;
+
+		for (unsigned int j = start; j < ARRAY_SIZE(ad4691_osc_freqs_Hz); j++) {
+			if (ad4691_osc_freqs_Hz[j] % osr)
+				continue;
+			st->samp_freq_avail[i][n++] = ad4691_osc_freqs_Hz[j] / osr;
+		}
+		st->samp_freq_avail_len[i] = n;
+	}
 }
 
 static int ad4691_set_sampling_freq(struct ad4691_state *st, int freq)
 {
-	unsigned int start = ad4691_samp_freq_start(st->info);
+	unsigned int osr, found;
 
+	/*
+	 * Read osr under st->lock: osr and target_osc_freq_Hz are modified
+	 * together under the lock; reading after acquiring it ensures we see
+	 * a consistent snapshot with no concurrent write racing us.
+	 */
 	guard(mutex)(&st->lock);
+	osr = st->osr;
 
-	for (unsigned int i = start; i < ARRAY_SIZE(ad4691_osc_freqs_Hz); i++) {
-		if (ad4691_osc_freqs_Hz[i] != freq)
-			continue;
-		return regmap_update_bits(st->regmap, AD4691_OSC_FREQ_REG,
-					  AD4691_OSC_FREQ_MASK, i);
-	}
+	if (freq <= 0 || (unsigned int)freq > st->info->max_rate / osr)
+		return -EINVAL;
 
-	return -EINVAL;
+	found = ad4691_find_osc_freq(st, (unsigned int)freq * osr, osr);
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
@@ -617,13 +817,27 @@ static int ad4691_read_avail(struct iio_dev *indio_dev,
 			     int *length, long mask)
 {
 	struct ad4691_state *st = iio_priv(indio_dev);
-	unsigned int start = ad4691_samp_freq_start(st->info);
 
 	switch (mask) {
-	case IIO_CHAN_INFO_SAMP_FREQ:
-		*vals = &ad4691_osc_freqs_Hz[start];
+	case IIO_CHAN_INFO_SAMP_FREQ: {
+		unsigned int osr_idx;
+
+		/*
+		 * The precomputed tables are stable after probe; only the
+		 * current OSR needs to be read under the lock to pick the
+		 * right row atomically.
+		 */
+		guard(mutex)(&st->lock);
+		osr_idx = ad4691_osr_index(st->osr);
+		*vals = st->samp_freq_avail[osr_idx];
 		*type = IIO_VAL_INT;
-		*length = ARRAY_SIZE(ad4691_osc_freqs_Hz) - start;
+		*length = st->samp_freq_avail_len[osr_idx];
+		return IIO_AVAIL_LIST;
+	}
+	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+		*vals = ad4691_oversampling_ratios;
+		*type = IIO_VAL_INT;
+		*length = ARRAY_SIZE(ad4691_oversampling_ratios);
 		return IIO_AVAIL_LIST;
 	default:
 		return -EINVAL;
@@ -634,7 +848,7 @@ static int ad4691_single_shot_read(struct iio_dev *indio_dev,
 				   struct iio_chan_spec const *chan, int *val)
 {
 	struct ad4691_state *st = iio_priv(indio_dev);
-	unsigned int reg_val, osc_idx, period_us;
+	unsigned int reg_val, period_us;
 	int ret;
 
 	guard(mutex)(&st->lock);
@@ -654,7 +868,11 @@ static int ad4691_single_shot_read(struct iio_dev *indio_dev,
 	if (ret)
 		return ret;
 
-	ret = regmap_read(st->regmap, AD4691_OSC_FREQ_REG, &reg_val);
+	ret = regmap_write(st->regmap, AD4691_ACC_DEPTH_IN(0), st->osr);
+	if (ret)
+		return ret;
+
+	ret = ad4691_write_osc_freq(st);
 	if (ret)
 		return ret;
 
@@ -662,9 +880,12 @@ static int ad4691_single_shot_read(struct iio_dev *indio_dev,
 	if (ret)
 		return ret;
 
-	osc_idx = FIELD_GET(AD4691_OSC_FREQ_MASK, reg_val);
-	/* Wait 2 oscillator periods for the conversion to complete. */
-	period_us = DIV_ROUND_UP(2UL * USEC_PER_SEC, ad4691_osc_freqs_Hz[osc_idx]);
+	/*
+	 * Wait osr + 1 oscillator periods: osr for accumulation, +1 for the
+	 * pipeline margin (one extra period ensures the final result is ready).
+	 */
+	period_us = DIV_ROUND_UP((st->osr + 1) * USEC_PER_SEC,
+				 st->target_osc_freq_Hz);
 	fsleep(period_us);
 
 	ret = regmap_write(st->regmap, AD4691_OSC_EN_REG, 0);
@@ -698,8 +919,22 @@ static int ad4691_read_raw(struct iio_dev *indio_dev,
 
 		return ad4691_single_shot_read(indio_dev, chan, val);
 	}
-	case IIO_CHAN_INFO_SAMP_FREQ:
-		return ad4691_get_sampling_freq(st, val);
+	case IIO_CHAN_INFO_SAMP_FREQ: {
+		/*
+		 * Read target_osc_freq_Hz and osr under st->lock to get a
+		 * consistent snapshot: write_raw for SAMP_FREQ or OSR modifies
+		 * both fields under the lock, so a concurrent read without the
+		 * lock could observe a new oscillator frequency with the old OSR.
+		 */
+		guard(mutex)(&st->lock);
+		*val = st->target_osc_freq_Hz / st->osr;
+		return IIO_VAL_INT;
+	}
+	case IIO_CHAN_INFO_OVERSAMPLING_RATIO: {
+		guard(mutex)(&st->lock);
+		*val = st->osr;
+		return IIO_VAL_INT;
+	}
 	case IIO_CHAN_INFO_SCALE:
 		*val = st->vref_uV / (MICRO / MILLI);
 		*val2 = chan->scan_type.realbits;
@@ -722,6 +957,33 @@ static int ad4691_write_raw(struct iio_dev *indio_dev,
 	switch (mask) {
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		return ad4691_set_sampling_freq(st, val);
+	case IIO_CHAN_INFO_OVERSAMPLING_RATIO: {
+		unsigned int old_effective, found, osr_idx;
+
+		osr_idx = ad4691_osr_index(val);
+		if (ad4691_oversampling_ratios[osr_idx] != val)
+			return -EINVAL;
+
+		/*
+		 * Hold st->lock while computing the new oscillator frequency
+		 * and updating both target_osc_freq_Hz and osr atomically:
+		 * read_raw for SAMP_FREQ reads both fields under the lock and
+		 * must see a consistent pair (new osc ↔ new osr).
+		 *
+		 * Snap target_osc_freq_Hz to the largest table entry that is
+		 * both <= old_effective * new_osr and evenly divisible by
+		 * new_osr, preserving an integer read-back of
+		 * in_voltage_sampling_frequency after the OSR change.
+		 */
+		guard(mutex)(&st->lock);
+		old_effective = st->target_osc_freq_Hz / st->osr;
+		found = ad4691_find_osc_freq(st, old_effective * (unsigned int)val, val);
+		if (!found)
+			return -EINVAL;
+		st->target_osc_freq_Hz = found;
+		st->osr = val;
+		return 0;
+	}
 	default:
 		return -EINVAL;
 	}
@@ -776,6 +1038,10 @@ static int ad4691_enter_conversion_mode(struct ad4691_state *st)
 		return regmap_update_bits(st->regmap, AD4691_DEVICE_SETUP,
 					  AD4691_MANUAL_MODE, AD4691_MANUAL_MODE);
 
+	ret = ad4691_write_osc_freq(st);
+	if (ret)
+		return ret;
+
 	ret = regmap_update_bits(st->regmap, AD4691_ADC_SETUP,
 				 AD4691_ADC_MODE_MASK, AD4691_CNV_BURST_MODE);
 	if (ret)
@@ -943,6 +1209,10 @@ static int ad4691_cnv_burst_buffer_preenable(struct iio_dev *indio_dev)
 	if (ret)
 		goto err_unoptimize;
 
+	ret = regmap_write(st->regmap, AD4691_ACC_DEPTH_IN(0), st->osr);
+	if (ret)
+		goto err_unoptimize;
+
 	ret = ad4691_enter_conversion_mode(st);
 	if (ret)
 		goto err_unoptimize;
@@ -1122,6 +1392,10 @@ static int ad4691_cnv_burst_offload_buffer_postenable(struct iio_dev *indio_dev)
 	if (ret)
 		return ret;
 
+	ret = regmap_write(st->regmap, AD4691_ACC_DEPTH_IN(0), st->osr);
+	if (ret)
+		return ret;
+
 	ret = ad4691_enter_conversion_mode(st);
 	if (ret)
 		return ret;
@@ -1538,11 +1812,15 @@ static int ad4691_config(struct ad4691_state *st)
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to write OSC_FREQ\n");
 
+	st->target_osc_freq_Hz = ad4691_osc_freqs_Hz[ad4691_samp_freq_start(st->info)];
+
 	ret = regmap_update_bits(st->regmap, AD4691_ADC_SETUP,
 				 AD4691_ADC_MODE_MASK, AD4691_AUTONOMOUS_MODE);
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to write ADC_SETUP\n");
 
+	ad4691_precompute_samp_freq_avail(st);
+
 	return 0;
 }
 
@@ -1554,7 +1832,14 @@ static int ad4691_setup_triggered_buffer(struct iio_dev *indio_dev,
 	unsigned int i;
 	int irq, ret;
 
-	indio_dev->channels = st->info->sw_info->channels;
+	/*
+	 * Manual mode exposes channels without the oversampling_ratio attribute
+	 * because ACC_DEPTH_IN is not configured in manual mode.
+	 */
+	if (st->manual_mode)
+		indio_dev->channels = st->info->sw_info->manual_channels;
+	else
+		indio_dev->channels = st->info->sw_info->channels;
 	indio_dev->num_channels = st->info->sw_info->num_channels;
 	indio_dev->info = st->manual_mode ? &ad4691_manual_info : &ad4691_cnv_burst_info;
 
@@ -1636,7 +1921,18 @@ static int ad4691_setup_offload(struct iio_dev *indio_dev,
 
 	st->offload = spi_offload;
 
-	indio_dev->channels = st->info->offload_info->channels;
+	/*
+	 * CNV burst offload exposes oversampling_ratio (ACC_DEPTH_IN is
+	 * configured per channel at buffer enable). Manual offload does not
+	 * configure ACC_DEPTH_IN, so it uses a separate channel array
+	 * without the oversampling_ratio attribute. Both paths use IIO_CPU
+	 * (no .endianness annotation) because bits_per_word=16 causes the
+	 * SPI Engine to produce native 16-bit DMA words.
+	 */
+	if (st->manual_mode)
+		indio_dev->channels = st->info->offload_info->manual_channels;
+	else
+		indio_dev->channels = st->info->offload_info->channels;
 	indio_dev->num_channels = st->info->offload_info->num_channels;
 	/*
 	 * Offload path uses DMA directly; no IIO trigger is involved, so
@@ -1710,6 +2006,7 @@ static int ad4691_probe(struct spi_device *spi)
 	st->info = spi_get_device_match_data(spi);
 	if (!st->info)
 		return -ENODEV;
+	st->osr = 1;
 
 	ret = devm_mutex_init(dev, &st->lock);
 	if (ret)

-- 
2.43.0



