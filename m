Return-Path: <linux-pwm+bounces-8534-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id COI/MBvI12n6SwgAu9opvQ
	(envelope-from <linux-pwm+bounces-8534-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 09 Apr 2026 17:39:07 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D7D63CCD99
	for <lists+linux-pwm@lfdr.de>; Thu, 09 Apr 2026 17:39:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2C25B304D64C
	for <lists+linux-pwm@lfdr.de>; Thu,  9 Apr 2026 15:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B22EB3E1226;
	Thu,  9 Apr 2026 15:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HuaXksia"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0F73E0C7D;
	Thu,  9 Apr 2026 15:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775748509; cv=none; b=OSf/IBujbVCF4qcZZWIMFXqTCm+Z1jxmpaPeG6r42Pay4sv0uTBHkPB0+Zl+kIaeNO+ZmsAAtR7TZWaUMLZaIIVZx9mLNYfbnWW5/cvZ4mmBrwnV21biUq4vZMvBsTVvuTp+ojap7iY3BPuf8Cn7NEjDiKbyao+zXnpHSsMaxag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775748509; c=relaxed/simple;
	bh=KsblKUkQGH4qzMaiWWjhoWft+PHq8/XzwCcpm7GCJu0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PMNkAWTVMRGwzZoCUxZKKpIyo76KpkCIOzOP3GRsFdgXM1sBi54KV9Tzc1/DdjWMqdzJUhy1vTG4LtsfM/tzrdODdKazl1DucHtogpP6Et0r/HD8SRs/fL/RDj6NMet5TnFYCE2QkzG4aMpC9p0Cnut5BDsyFtzp8YAZBbmLegs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HuaXksia; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 510B6C2BCC9;
	Thu,  9 Apr 2026 15:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775748509;
	bh=KsblKUkQGH4qzMaiWWjhoWft+PHq8/XzwCcpm7GCJu0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=HuaXksiaEkeUTtpQlqyKpcpokZ6jE3zuvXFUZWReOTEA6SE/lq6/0lrBfHsfPmgkl
	 5qh09hJmpHANYGJmaIx8i/4mwX09BHYbziX37xi/ouC/Pibl5RgpeTVfx7cz9dHDYN
	 QTH69qGk9hsPhv2UUciNBalHFx45WOzhmTPNOmjtQ76wmHzm1/KJXfbeZiPgfsBw3F
	 dkZf3zJ7QFPQq6ePiQvPOqGztlLVOTkAbow+lTq2W9RdEX9zt+WR5ywtmzqF4PxqBS
	 325TrTMv1kv5Rxc6tZxYTcmDUj/ne4zB6Dk9JbD564JCfp8Xd0qs5cK8z2xbxcn401
	 PGwZKbyN6fR7A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4779AF31E28;
	Thu,  9 Apr 2026 15:28:29 +0000 (UTC)
From: Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org>
Date: Thu, 09 Apr 2026 18:28:26 +0300
Subject: [PATCH v7 5/6] iio: adc: ad4691: add oversampling support
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260409-ad4692-multichannel-sar-adc-driver-v7-5-be375d4df2c5@analog.com>
References: <20260409-ad4692-multichannel-sar-adc-driver-v7-0-be375d4df2c5@analog.com>
In-Reply-To: <20260409-ad4692-multichannel-sar-adc-driver-v7-0-be375d4df2c5@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775748505; l=9894;
 i=radu.sabau@analog.com; s=20260220; h=from:subject:message-id;
 bh=eB6uvSJZMwxlszpLMEXiVdwqo2+1DAbz0m1ETwwp1E8=;
 b=Q9j9fNUH+gyIVtPhmTXEJpOmAQAIZwPDs3DvcRhKK3vjvmaqorlbeSfKFkBOsWJcG4pAwxb5U
 ENfshks7CfnBUWaVta7dRxuHpc0ypqzrtQRNwA4SpgDL2BydQYuRE81
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
	TAGGED_FROM(0.00)[bounces-8534-lists,linux-pwm=lfdr.de,radu.sabau.analog.com];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,analog.com:email,analog.com:replyto,analog.com:mid]
X-Rspamd-Queue-Id: 4D7D63CCD99
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Radu Sabau <radu.sabau@analog.com>

Add per-channel oversampling ratio (OSR) support for CNV burst mode.
The accumulator depth register (ACC_DEPTH_IN) is programmed with the
selected OSR at buffer enable time and before each single-shot read.

Supported OSR values: 1, 2, 4, 8, 16, 32.

Introduce AD4691_MANUAL_CHANNEL() for manual mode channels, which do
not expose the oversampling ratio attribute since OSR is not applicable
in that mode. A separate manual_channels array is added to
struct ad4691_channel_info and selected at probe time; offload paths
reuse the same arrays with num_channels capping access before the soft
timestamp entry.

The reported sampling frequency accounts for the active OSR:
effective_freq = oscillator_freq / osr

OSR defaults to 1 (no accumulation) for all channels.

Signed-off-by: Radu Sabau <radu.sabau@analog.com>
---
 drivers/iio/adc/ad4691.c | 137 +++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 128 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/adc/ad4691.c b/drivers/iio/adc/ad4691.c
index 839ea7f44c78..ef96d736996e 100644
--- a/drivers/iio/adc/ad4691.c
+++ b/drivers/iio/adc/ad4691.c
@@ -116,6 +116,7 @@ enum ad4691_ref_ctrl {
 
 struct ad4691_channel_info {
 	const struct iio_chan_spec *channels;
+	const struct iio_chan_spec *manual_channels;
 	unsigned int num_channels;
 };
 
@@ -126,7 +127,34 @@ struct ad4691_chip_info {
 	const struct ad4691_channel_info *offload_info;
 };
 
+/* CNV burst mode channel — exposes oversampling ratio. */
 #define AD4691_CHANNEL(ch)						\
+	{								\
+		.type = IIO_VOLTAGE,					\
+		.indexed = 1,						\
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
 	{								\
 		.type = IIO_VOLTAGE,					\
 		.indexed = 1,						\
@@ -177,25 +205,65 @@ static const struct iio_chan_spec ad4693_channels[] = {
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
-	/* No soft timestamp; num_channels caps access to 16. */
+	/*
+	 * Offload paths share the SW channel arrays. num_channels caps access
+	 * before the soft timestamp entry, so no separate array is needed.
+	 */
+	.manual_channels = ad4691_manual_channels,
 	.num_channels = 16,
 };
 
 static const struct ad4691_channel_info ad4693_offload_info = {
 	.channels = ad4693_channels,
-	/* No soft timestamp; num_channels caps access to 8. */
+	.manual_channels = ad4693_manual_channels,
 	.num_channels = 8,
 };
 
@@ -270,6 +338,8 @@ struct ad4691_state {
 	int irq;
 	int vref_uV;
 	u32 cnv_period_ns;
+	/* Per-channel oversampling ratio; always 1 in manual mode. */
+	u8 osr[16];
 
 	bool manual_mode;
 	bool refbuf_en;
@@ -490,7 +560,8 @@ static const struct regmap_config ad4691_regmap_config = {
 	.cache_type = REGCACHE_MAPLE,
 };
 
-static int ad4691_get_sampling_freq(struct ad4691_state *st, int *val)
+static int ad4691_get_sampling_freq(struct ad4691_state *st, int *val,
+				    unsigned int osr)
 {
 	unsigned int reg_val;
 	int ret;
@@ -499,7 +570,7 @@ static int ad4691_get_sampling_freq(struct ad4691_state *st, int *val)
 	if (ret)
 		return ret;
 
-	*val = ad4691_osc_freqs_Hz[FIELD_GET(AD4691_OSC_FREQ_MASK, reg_val)];
+	*val = ad4691_osc_freqs_Hz[FIELD_GET(AD4691_OSC_FREQ_MASK, reg_val)] / osr;
 	return IIO_VAL_INT;
 }
 
@@ -536,6 +607,11 @@ static int ad4691_read_avail(struct iio_dev *indio_dev,
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
@@ -566,6 +642,11 @@ static int ad4691_single_shot_read(struct iio_dev *indio_dev,
 	if (ret)
 		return ret;
 
+	ret = regmap_write(st->regmap, AD4691_ACC_DEPTH_IN(chan->channel),
+			   st->osr[chan->channel]);
+	if (ret)
+		return ret;
+
 	ret = regmap_read(st->regmap, AD4691_OSC_FREQ_REG, &reg_val);
 	if (ret)
 		return ret;
@@ -575,8 +656,9 @@ static int ad4691_single_shot_read(struct iio_dev *indio_dev,
 		return ret;
 
 	osc_idx = FIELD_GET(AD4691_OSC_FREQ_MASK, reg_val);
-	/* Wait 2 oscillator periods for the conversion to complete. */
-	period_us = DIV_ROUND_UP(2UL * USEC_PER_SEC, ad4691_osc_freqs_Hz[osc_idx]);
+	/* Wait osr oscillator periods for all accumulator samples to complete. */
+	period_us = DIV_ROUND_UP((unsigned long)st->osr[chan->channel] * USEC_PER_SEC,
+				 ad4691_osc_freqs_Hz[osc_idx]);
 	fsleep(period_us);
 
 	ret = regmap_write(st->regmap, AD4691_OSC_EN_REG, 0);
@@ -611,7 +693,10 @@ static int ad4691_read_raw(struct iio_dev *indio_dev,
 		return ad4691_single_shot_read(indio_dev, chan, val);
 	}
 	case IIO_CHAN_INFO_SAMP_FREQ:
-		return ad4691_get_sampling_freq(st, val);
+		return ad4691_get_sampling_freq(st, val, st->osr[chan->channel]);
+	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+		*val = st->osr[chan->channel];
+		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
 		*val = st->vref_uV / (MICRO / MILLI);
 		*val2 = chan->scan_type.realbits;
@@ -625,9 +710,24 @@ static int ad4691_write_raw(struct iio_dev *indio_dev,
 			    struct iio_chan_spec const *chan,
 			    int val, int val2, long mask)
 {
+	struct ad4691_state *st = iio_priv(indio_dev);
+
 	switch (mask) {
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		return ad4691_set_sampling_freq(indio_dev, val);
+	case IIO_CHAN_INFO_OVERSAMPLING_RATIO: {
+		IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
+		if (IIO_DEV_ACQUIRE_FAILED(claim))
+			return -EBUSY;
+
+		for (unsigned int i = 0; i < ARRAY_SIZE(ad4691_oversampling_ratios); i++) {
+			if (ad4691_oversampling_ratios[i] != val)
+				continue;
+			st->osr[chan->channel] = val;
+			return 0;
+		}
+		return -EINVAL;
+	}
 	default:
 		return -EINVAL;
 	}
@@ -842,6 +942,12 @@ static int ad4691_cnv_burst_buffer_preenable(struct iio_dev *indio_dev)
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
@@ -998,6 +1104,12 @@ static int ad4691_cnv_burst_offload_buffer_postenable(struct iio_dev *indio_dev)
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
@@ -1519,6 +1631,7 @@ static int ad4691_probe(struct spi_device *spi)
 	st = iio_priv(indio_dev);
 	st->spi = spi;
 	st->info = spi_get_device_match_data(spi);
+	memset(st->osr, 1, sizeof(st->osr));
 
 	ret = devm_mutex_init(dev, &st->lock);
 	if (ret)
@@ -1553,11 +1666,17 @@ static int ad4691_probe(struct spi_device *spi)
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



