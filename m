Return-Path: <linux-pwm+bounces-8890-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UHUjJqohB2rnrgIAu9opvQ
	(envelope-from <linux-pwm+bounces-8890-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 15 May 2026 15:37:46 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 329C955090B
	for <lists+linux-pwm@lfdr.de>; Fri, 15 May 2026 15:37:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 29E983033F48
	for <lists+linux-pwm@lfdr.de>; Fri, 15 May 2026 13:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4367B3E5A15;
	Fri, 15 May 2026 13:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BYb9nmG3"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149BF3D0914;
	Fri, 15 May 2026 13:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778851895; cv=none; b=fP2CJIR8V1hI0UFFMkiKIbWlfx0Ex3/apkeLovTwhKOyrq4pjYAQOMUxp+KgY8uQr//opsI+KfoLw+p3cxhirUwinBCufVPoO1Qfzx7yLjSnWdM9QtG2Gjr2PwX0Qh6+5+W79Yu6hlGJZsYDG9bhV0HwAudLtvl+RdB47OcYBKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778851895; c=relaxed/simple;
	bh=25xxCBDkXsBqlKEgnyyYilnyPbl9eh+okf2lHsvhN1I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nm2zZKh7piXEQ1+wYx2YC8tVmjKi2HALgRsuyW7uFJof6eZVgCJkvfcPVLJF0wug3laJMZMrITCd+W2JyCyYgMhOkLcoiYtM6EnrQtxVzNShSCzAm0CoHbboGip+WU7rXGzTpYhQJDPymeAXnpNApHteVcS6LWoS4NSmRFJqZTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BYb9nmG3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A1586C4AF19;
	Fri, 15 May 2026 13:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778851894;
	bh=25xxCBDkXsBqlKEgnyyYilnyPbl9eh+okf2lHsvhN1I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=BYb9nmG3E6ikKt0/lEyeqp3oX9YhMqX4ypFagdBg5AcZzVVPLd0s+Xt1hqL8lKqlb
	 jMju830NxJro3P/lCv96GBMcghso/SoGbzuKROP2eUOGT4he1NpRLcPUvKw6Fn3MUf
	 LTVDzI2+jfM0lxltgiQHEwKYxBKSXoUjv4p5/eBYrc+Yv/YFFO5jWb9kifKx+5Mgvp
	 HCo35aAUMQxk00NfxEM5a+Q8VD/bDPYTqaDcNcMJk9Z+pd1qv6lOl0qlM1zdWxHcES
	 ap0tgYqHB7Wz1q7OYefzj7/3Ovb7+auv9R0AdCcB484rqMA989NQQWfC+he8dZpei9
	 DB6izvsc7KWow==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93589CD4F25;
	Fri, 15 May 2026 13:31:34 +0000 (UTC)
From: Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org>
Date: Fri, 15 May 2026 16:31:34 +0300
Subject: [PATCH v11 5/6] iio: adc: ad4691: add oversampling support
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260515-ad4692-multichannel-sar-adc-driver-v11-5-eab27d852ac2@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778851890; l=22613;
 i=radu.sabau@analog.com; s=20260220; h=from:subject:message-id;
 bh=avJ4bPyyW4IhXoqFLHwZqeTqHyn+PXp02BTefGjK+o0=;
 b=CjwrgBaoFatTcWN2ILU0zj997oNMlcPoNDoSR9mjCue34UnttAidBgGdT+xh/g1xL3RXZeh6m
 vGsXZD/zVJAAAk3hLNM2PFIL1JqsyTKDykG9lD4pK3lsSGzozYeI5X7
X-Developer-Key: i=radu.sabau@analog.com; a=ed25519;
 pk=lDPQHgn9jTdt0vo58Na9lLxLaE2mb330if71Cn+EvFU=
X-Endpoint-Received: by B4 Relay for radu.sabau@analog.com/20260220 with
 auth_id=642
X-Original-From: Radu Sabau <radu.sabau@analog.com>
Reply-To: radu.sabau@analog.com
X-Rspamd-Queue-Id: 329C955090B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8890-lists,linux-pwm=lfdr.de,radu.sabau.analog.com];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	HAS_REPLYTO(0.00)[radu.sabau@analog.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,analog.com:email,analog.com:mid,analog.com:replyto]
X-Rspamd-Action: no action

From: Radu Sabau <radu.sabau@analog.com>

Add per-channel oversampling ratio (OSR) support for CNV burst mode.
The accumulator depth register (ACC_DEPTH_IN) is programmed with the
selected OSR at buffer enable time and before each single-shot read.

Supported OSR values: 1, 2, 4, 8, 16, 32.

Introduce AD4691_MANUAL_CHANNEL() for manual mode channels, which do
not expose the oversampling_ratio attribute since OSR is not applicable
in that mode. A separate manual_channels array is added to
struct ad4691_channel_info and selected at probe time.

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

Writing oversampling_ratio stores the new OSR for that channel and snaps
target_osc_freq_Hz to the largest oscillator table entry that is both
<= old_effective_rate * new_osr and evenly divisible by new_osr. This
preserves an integer read-back of in_voltageN_sampling_frequency after
the OSR change while keeping the oscillator as close as possible to the
previous effective rate.

OSR defaults to 1 (no accumulation) for all channels.

Signed-off-by: Radu Sabau <radu.sabau@analog.com>
---
 drivers/iio/adc/ad4691.c | 381 ++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 343 insertions(+), 38 deletions(-)

diff --git a/drivers/iio/adc/ad4691.c b/drivers/iio/adc/ad4691.c
index 25f7a6939b0f..39244e0e4a2d 100644
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
@@ -151,8 +180,33 @@ struct ad4691_chip_info {
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
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW)		\
+				    | BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO) \
+				    | BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
+		.info_mask_separate_available =				\
+				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO) \
+				    | BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SCALE),	\
+		.channel = ch,						\
+		.scan_index = ch,					\
+		.scan_type = {						\
+			.sign = 'u',					\
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
@@ -236,23 +290,91 @@ static const struct iio_chan_spec ad4693_offload_channels[] = {
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
 
@@ -325,6 +447,19 @@ struct ad4691_state {
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
@@ -398,8 +533,7 @@ static bool ad4691_offload_trigger_match(struct spi_offload_trigger *trigger,
 					 enum spi_offload_trigger_type type,
 					 u64 *args, u32 nargs)
 {
-	return type == SPI_OFFLOAD_TRIGGER_DATA_READY &&
-	       nargs == 1 && args[0] <= 3;
+	return type == SPI_OFFLOAD_TRIGGER_DATA_READY && nargs == 1 && args[0] <= 3;
 }
 
 static int ad4691_offload_trigger_request(struct spi_offload_trigger *trigger,
@@ -578,6 +712,16 @@ static const struct regmap_config ad4691_regmap_config = {
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
@@ -588,41 +732,65 @@ static unsigned int ad4691_samp_freq_start(const struct ad4691_chip_info *info)
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
 
-	/*
-	 * AD4691_OSC_FREQ_REG is non-volatile and written during
-	 * ad4691_config(), so regmap returns the cached value here without
-	 * touching the SPI bus. No lock is needed.
-	 */
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
+	unsigned int osr, found;
 
 	IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
 	if (IIO_DEV_ACQUIRE_FAILED(claim))
 		return -EBUSY;
 
-	for (unsigned int i = start; i < ARRAY_SIZE(ad4691_osc_freqs_Hz); i++) {
-		if (ad4691_osc_freqs_Hz[i] != freq)
-			continue;
-		return regmap_update_bits(st->regmap, AD4691_OSC_FREQ_REG,
-					  AD4691_OSC_FREQ_MASK, i);
-	}
+	/*
+	 * Read osr under st->lock: osr[chan] and target_osc_freq_Hz are
+	 * modified together under the lock; reading after acquiring it ensures
+	 * we see a consistent snapshot with no concurrent write racing us.
+	 */
+	guard(mutex)(&st->lock);
+	osr = st->osr[chan->channel];
 
-	return -EINVAL;
+	if (freq <= 0 || (unsigned int)freq > st->info->max_rate / osr)
+		return -EINVAL;
+
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
@@ -634,10 +802,46 @@ static int ad4691_read_avail(struct iio_dev *indio_dev,
 	unsigned int start = ad4691_samp_freq_start(st->info);
 
 	switch (mask) {
-	case IIO_CHAN_INFO_SAMP_FREQ:
-		*vals = &ad4691_osc_freqs_Hz[start];
+	case IIO_CHAN_INFO_SAMP_FREQ: {
+		unsigned int osr;
+		int n = 0;
+
+		/*
+		 * Hold the lock while reading osr[chan] and populating the
+		 * scratch buffer: a concurrent oversampling_ratio write modifies
+		 * both target_osc_freq_Hz and osr[] under the lock, so we must
+		 * read osr atomically with respect to that write. The scratch
+		 * buffer is per-channel, so concurrent reads on different
+		 * channels do not race; concurrent reads on the same channel
+		 * would compute identical values, but holding the lock avoids
+		 * the formal data race.
+		 */
+		scoped_guard(mutex, &st->lock) {
+			osr = st->osr[chan->channel];
+
+			/*
+			 * Only oscillator frequencies evenly divisible by the
+			 * channel's OSR yield an integer effective rate; expose
+			 * those as effective rates (osc / osr) so the user works
+			 * entirely in output-sample space.
+			 */
+			for (unsigned int i = start;
+			     i < ARRAY_SIZE(ad4691_osc_freqs_Hz); i++) {
+				if (ad4691_osc_freqs_Hz[i] % osr)
+					continue;
+				st->samp_freq_avail[chan->channel][n++] =
+					ad4691_osc_freqs_Hz[i] / osr;
+			}
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
@@ -648,7 +852,7 @@ static int ad4691_single_shot_read(struct iio_dev *indio_dev,
 				   struct iio_chan_spec const *chan, int *val)
 {
 	struct ad4691_state *st = iio_priv(indio_dev);
-	unsigned int reg_val, osc_idx, period_us;
+	unsigned int reg_val, period_us;
 	int ret;
 
 	guard(mutex)(&st->lock);
@@ -669,7 +873,12 @@ static int ad4691_single_shot_read(struct iio_dev *indio_dev,
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
 
@@ -677,9 +886,12 @@ static int ad4691_single_shot_read(struct iio_dev *indio_dev,
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
@@ -713,8 +925,21 @@ static int ad4691_read_raw(struct iio_dev *indio_dev,
 
 		return ad4691_single_shot_read(indio_dev, chan, val);
 	}
-	case IIO_CHAN_INFO_SAMP_FREQ:
-		return ad4691_get_sampling_freq(st, val);
+	case IIO_CHAN_INFO_SAMP_FREQ: {
+		/*
+		 * Read target_osc_freq_Hz and osr[chan] under st->lock to get a
+		 * consistent snapshot: write_raw for SAMP_FREQ or OSR modifies
+		 * both fields under the lock, so a concurrent read without the
+		 * lock could observe a new oscillator frequency with the old OSR.
+		 */
+		guard(mutex)(&st->lock);
+		return ad4691_get_sampling_freq(st, st->osr[chan->channel], val);
+	}
+	case IIO_CHAN_INFO_OVERSAMPLING_RATIO: {
+		guard(mutex)(&st->lock);
+		*val = st->osr[chan->channel];
+		return IIO_VAL_INT;
+	}
 	case IIO_CHAN_INFO_SCALE:
 		*val = st->vref_uV / (MICRO / MILLI);
 		*val2 = chan->scan_type.realbits;
@@ -728,9 +953,48 @@ static int ad4691_write_raw(struct iio_dev *indio_dev,
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
+		unsigned int old_effective, found;
+		bool valid = false;
+
+		for (unsigned int i = 0; i < ARRAY_SIZE(ad4691_oversampling_ratios); i++) {
+			if (ad4691_oversampling_ratios[i] == val) {
+				valid = true;
+				break;
+			}
+		}
+		if (!valid)
+			return -EINVAL;
+
+		IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
+		if (IIO_DEV_ACQUIRE_FAILED(claim))
+			return -EBUSY;
+
+		/*
+		 * Hold st->lock while computing the new oscillator frequency
+		 * and updating both target_osc_freq_Hz and osr[chan] atomically:
+		 * read_raw for SAMP_FREQ reads both fields under the lock and
+		 * must see a consistent pair (new osc ↔ new osr).
+		 *
+		 * Snap target_osc_freq_Hz to the largest table entry that is
+		 * both <= old_effective * new_osr and evenly divisible by
+		 * new_osr, preserving an integer read-back of
+		 * in_voltageN_sampling_frequency after the OSR change.
+		 */
+		guard(mutex)(&st->lock);
+		old_effective = st->target_osc_freq_Hz / st->osr[chan->channel];
+		found = ad4691_find_osc_freq(st, old_effective * (unsigned int)val, val);
+		if (!found)
+			return -EINVAL;
+		st->target_osc_freq_Hz = found;
+		st->osr[chan->channel] = val;
+		return 0;
+	}
 	default:
 		return -EINVAL;
 	}
@@ -785,6 +1049,10 @@ static int ad4691_enter_conversion_mode(struct ad4691_state *st)
 		return regmap_update_bits(st->regmap, AD4691_DEVICE_SETUP,
 					  AD4691_MANUAL_MODE, AD4691_MANUAL_MODE);
 
+	ret = ad4691_write_osc_freq(st);
+	if (ret)
+		return ret;
+
 	ret = regmap_update_bits(st->regmap, AD4691_ADC_SETUP,
 				 AD4691_ADC_MODE_MASK, AD4691_CNV_BURST_MODE);
 	if (ret)
@@ -948,6 +1216,14 @@ static int ad4691_cnv_burst_buffer_preenable(struct iio_dev *indio_dev)
 	if (ret)
 		goto err_unoptimize;
 
+	iio_for_each_active_channel(indio_dev, i) {
+		if (i >= indio_dev->num_channels - 1)
+			break; /* skip soft timestamp */
+		ret = regmap_write(st->regmap, AD4691_ACC_DEPTH_IN(i), st->osr[i]);
+		if (ret)
+			goto err_unoptimize;
+	}
+
 	ret = ad4691_enter_conversion_mode(st);
 	if (ret)
 		goto err_unoptimize;
@@ -1126,6 +1402,14 @@ static int ad4691_cnv_burst_offload_buffer_postenable(struct iio_dev *indio_dev)
 	if (ret)
 		return ret;
 
+	iio_for_each_active_channel(indio_dev, bit) {
+		if (bit >= indio_dev->num_channels)
+			break; /* defensive guard; offload channels have no soft timestamp */
+		ret = regmap_write(st->regmap, AD4691_ACC_DEPTH_IN(bit), st->osr[bit]);
+		if (ret)
+			return ret;
+	}
+
 	ret = ad4691_enter_conversion_mode(st);
 	if (ret)
 		return ret;
@@ -1524,6 +1808,8 @@ static int ad4691_config(struct ad4691_state *st)
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to write OSC_FREQ\n");
 
+	st->target_osc_freq_Hz = ad4691_osc_freqs_Hz[ad4691_samp_freq_start(st->info)];
+
 	ret = regmap_update_bits(st->regmap, AD4691_ADC_SETUP,
 				 AD4691_ADC_MODE_MASK, AD4691_AUTONOMOUS_MODE);
 	if (ret)
@@ -1540,7 +1826,14 @@ static int ad4691_setup_triggered_buffer(struct iio_dev *indio_dev,
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
 
@@ -1621,7 +1914,18 @@ static int ad4691_setup_offload(struct iio_dev *indio_dev,
 	offload->offload = spi_offload;
 	st->offload = offload;
 
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
@@ -1695,6 +1999,7 @@ static int ad4691_probe(struct spi_device *spi)
 	st->info = spi_get_device_match_data(spi);
 	if (!st->info)
 		return -ENODEV;
+	memset(st->osr, 1, sizeof(st->osr));
 
 	ret = devm_mutex_init(dev, &st->lock);
 	if (ret)

-- 
2.43.0



