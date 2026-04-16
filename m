Return-Path: <linux-pwm+bounces-8603-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qHRXLBOr4Gm8kgAAu9opvQ
	(envelope-from <linux-pwm+bounces-8603-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 16 Apr 2026 11:25:39 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A7B940C4E1
	for <lists+linux-pwm@lfdr.de>; Thu, 16 Apr 2026 11:25:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DAC4D31C8E2C
	for <lists+linux-pwm@lfdr.de>; Thu, 16 Apr 2026 09:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9629439B96D;
	Thu, 16 Apr 2026 09:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E/hCkSUc"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562EB39A060;
	Thu, 16 Apr 2026 09:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776331132; cv=none; b=SGQ5I6zDn8K6BFPL9zronSQyk3xkE7nVihsbBiQqVyoaXYeN5kg9bb9FjCrigRekcJxXUCToihiSRCai4dhruklbeQhs9o+f9Sg/BLxbkNd64cHZB+QM1oEHXGCHzHgmlqa++8eRP81EI6lJbcWqqHWwb0loRRIGS9uUTh2MqY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776331132; c=relaxed/simple;
	bh=sUrmCGR6kAwOnbNerHAAk6Lmb38jismBdLFefY3pL4M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tRWjzH7M6RZe3AXEvqqtR1a/nS4up8Fg9N/DM2oERZzd17oBKzz3fwG6IYKpC/myPs2xa7ws/9Ym5E5JfPRlcdV8dPFjF2nScZXhNAx8QnvanX0PWfzMoxC468uN9z7ks61HEGAnyW9S8VdYC/UtRIaVsk3bCD2+hBAh8RiuzZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E/hCkSUc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 19BC0C2BCFD;
	Thu, 16 Apr 2026 09:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776331132;
	bh=sUrmCGR6kAwOnbNerHAAk6Lmb38jismBdLFefY3pL4M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=E/hCkSUcDNlGq5CEH3la/FcldXH4s9i+U3DxO0wo/+dB+/JdWV5GHwQ2fQxl6DFZ0
	 z/H/X+NRE2cbcljY83245ZV9wMfNlV6jGgLX/uIUXqqAS8ey5jLgIFiTOcGiC60mtG
	 xuVqMOqZTIXIaEyaFpneW1Xe5OA9diIRL8gori/u5DFtPjQbqHR4oBmjt7O90PAP2+
	 9jbtkMEOPJAG8geLNT6CCpTwVqgpioLNWZxM8ppNp8R+LRvXwSjmP21Ghwu9gzdbCM
	 yQeA85RmmKDYEGMQY8qXWNsz0mrUInnMcZTb8svsG4tYJn8Z/BApemCwSY0SR9b3uq
	 97L3p/icmUZPw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D680F8A14C;
	Thu, 16 Apr 2026 09:18:52 +0000 (UTC)
From: Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org>
Date: Thu, 16 Apr 2026 12:18:49 +0300
Subject: [PATCH v8 4/6] iio: adc: ad4691: add SPI offload support
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260416-ad4692-multichannel-sar-adc-driver-v8-4-c415bd048fa3@analog.com>
References: <20260416-ad4692-multichannel-sar-adc-driver-v8-0-c415bd048fa3@analog.com>
In-Reply-To: <20260416-ad4692-multichannel-sar-adc-driver-v8-0-c415bd048fa3@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776331127; l=20767;
 i=radu.sabau@analog.com; s=20260220; h=from:subject:message-id;
 bh=rotBpvUW1u48O+6snVu0w6RUCPzPo6JlDRixt5kk2yI=;
 b=Rg11bY5mhGhlFQkAyvCJLkqDIlQd2jyceLtvPuLVhOswR+Dhww67n3LtBEioUjWUEtF7+NrTH
 A1xa1h0yPDjChYUE34K0S+5kI7u3BGjh2iwYVvgBeolt8Yzum5M2aps
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
	TAGGED_FROM(0.00)[bounces-8603-lists,linux-pwm=lfdr.de,radu.sabau.analog.com];
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
X-Rspamd-Queue-Id: 1A7B940C4E1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Radu Sabau <radu.sabau@analog.com>

Add SPI offload support to enable DMA-based, CPU-independent data
acquisition using the SPI Engine offload framework.

When an SPI offload is available (devm_spi_offload_get() succeeds),
the driver registers a DMA engine IIO buffer and uses dedicated buffer
setup operations. If no offload is available the existing software
triggered buffer path is used unchanged.

Both CNV Burst Mode and Manual Mode support offload, but use different
trigger mechanisms:

CNV Burst Mode: the SPI Engine is triggered by the ADC's DATA_READY
signal on the GP pin specified by the trigger-source consumer reference
in the device tree (one cell = GP pin number 0-3). For this mode the
driver acts as both an SPI offload consumer (DMA RX stream, message
optimization) and a trigger source provider: it registers the
GP/DATA_READY output via devm_spi_offload_trigger_register() so the
offload framework can match the '#trigger-source-cells' phandle and
automatically fire the SPI Engine DMA transfer at end-of-conversion.

Manual Mode: the SPI Engine is triggered by a periodic trigger at
the configured sampling frequency. The pre-built SPI message uses
the pipelined CNV-on-CS protocol: N+1 16-bit transfers are issued
for N active channels (the first result is discarded as garbage from
the pipeline flush) and the remaining N results are captured by DMA.

All offload transfers use 16-bit frames (bits_per_word=16, len=2).
The channel scan_type (storagebits=16, shift=0, IIO_BE) is shared
between the software triggered-buffer and offload paths; no separate
scan_type or channel array is needed for the offload case. The
ad4691_manual_channels[] array introduced in the triggered-buffer
commit is reused here: it hides the IIO_CHAN_INFO_OVERSAMPLING_RATIO
attribute, which is not applicable in Manual Mode.

Kconfig gains a dependency on IIO_BUFFER_DMAENGINE.

Signed-off-by: Radu Sabau <radu.sabau@analog.com>
---
 drivers/iio/adc/Kconfig  |   2 +
 drivers/iio/adc/ad4691.c | 402 +++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 393 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index d498f16c0816..fdc6565933c5 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -143,8 +143,10 @@ config AD4691
 	tristate "Analog Devices AD4691 Family ADC Driver"
 	depends on SPI
 	select IIO_BUFFER
+	select IIO_BUFFER_DMAENGINE
 	select IIO_TRIGGERED_BUFFER
 	select REGMAP
+	select SPI_OFFLOAD
 	help
 	  Say yes here to build support for Analog Devices AD4691 Family MuxSAR
 	  SPI analog to digital converters (ADC).
diff --git a/drivers/iio/adc/ad4691.c b/drivers/iio/adc/ad4691.c
index 98c079e8ded3..fbd44f595cbe 100644
--- a/drivers/iio/adc/ad4691.c
+++ b/drivers/iio/adc/ad4691.c
@@ -23,10 +23,14 @@
 #include <linux/regulator/consumer.h>
 #include <linux/reset.h>
 #include <linux/spi/spi.h>
+#include <linux/spi/offload/consumer.h>
+#include <linux/spi/offload/provider.h>
 #include <linux/units.h>
 #include <linux/unaligned.h>
 
 #include <linux/iio/buffer.h>
+#include <linux/iio/buffer-dma.h>
+#include <linux/iio/buffer-dmaengine.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 #include <linux/iio/trigger.h>
@@ -42,6 +46,11 @@
 
 #define AD4691_CNV_DUTY_CYCLE_NS		380
 #define AD4691_CNV_HIGH_TIME_NS			430
+/*
+ * Conservative default for the manual offload periodic trigger. Low enough
+ * to work safely out of the box across all OSR and channel count combinations.
+ */
+#define AD4691_OFFLOAD_INITIAL_TRIGGER_HZ	(100 * HZ_PER_KHZ)
 
 #define AD4691_SPI_CONFIG_A_REG			0x000
 #define AD4691_SW_RESET				(BIT(7) | BIT(0))
@@ -113,6 +122,7 @@ struct ad4691_chip_info {
 	const char *name;
 	unsigned int max_rate;
 	const struct ad4691_channel_info *sw_info;
+	const struct ad4691_channel_info *offload_info;
 };
 
 #define AD4691_CHANNEL(ch)						\
@@ -176,6 +186,18 @@ static const struct ad4691_channel_info ad4693_sw_info = {
 	.num_channels = ARRAY_SIZE(ad4693_channels),
 };
 
+static const struct ad4691_channel_info ad4691_offload_info = {
+	.channels = ad4691_channels,
+	/* Exclude the soft timestamp entry; num_channels caps access. */
+	.num_channels = ARRAY_SIZE(ad4691_channels) - 1,
+};
+
+static const struct ad4691_channel_info ad4693_offload_info = {
+	.channels = ad4693_channels,
+	/* Exclude the soft timestamp entry; num_channels caps access. */
+	.num_channels = ARRAY_SIZE(ad4693_channels) - 1,
+};
+
 /*
  * Internal oscillator frequency table. Index is the OSC_FREQ_REG[3:0] value.
  * Index 0 (1 MHz) is only valid for AD4692/AD4694; AD4691/AD4693 support
@@ -206,24 +228,36 @@ static const struct ad4691_chip_info ad4691_chip_info = {
 	.name = "ad4691",
 	.max_rate = 500 * HZ_PER_KHZ,
 	.sw_info = &ad4691_sw_info,
+	.offload_info = &ad4691_offload_info,
 };
 
 static const struct ad4691_chip_info ad4692_chip_info = {
 	.name = "ad4692",
 	.max_rate = 1 * HZ_PER_MHZ,
 	.sw_info = &ad4691_sw_info,
+	.offload_info = &ad4691_offload_info,
 };
 
 static const struct ad4691_chip_info ad4693_chip_info = {
 	.name = "ad4693",
 	.max_rate = 500 * HZ_PER_KHZ,
 	.sw_info = &ad4693_sw_info,
+	.offload_info = &ad4693_offload_info,
 };
 
 static const struct ad4691_chip_info ad4694_chip_info = {
 	.name = "ad4694",
 	.max_rate = 1 * HZ_PER_MHZ,
 	.sw_info = &ad4693_sw_info,
+	.offload_info = &ad4693_offload_info,
+};
+
+struct ad4691_offload_state {
+	struct spi_offload *offload;
+	struct spi_offload_trigger *trigger;
+	u64 trigger_hz;
+	u8 tx_cmd[17][2];
+	u8 tx_reset[4];
 };
 
 struct ad4691_state {
@@ -252,7 +286,10 @@ struct ad4691_state {
 	 *		    transfers in one go.
 	 */
 	struct spi_message scan_msg;
-	/* max 16 + 1 NOOP (manual) or 2*16 + 2 (CNV burst). */
+	/*
+	 * Non-offload: max 16 + 1 NOOP (manual) or 2*16 + 2 (CNV burst).
+	 * Offload reuses this array — both paths are mutually exclusive.
+	 */
 	struct spi_transfer scan_xfers[34];
 	/*
 	 * CNV burst: 16 AVG_IN addresses + state-reset address + state-reset
@@ -264,6 +301,8 @@ struct ad4691_state {
 	 * DMA-aligned because scan_xfers point rx_buf directly into vals[].
 	 */
 	IIO_DECLARE_DMA_BUFFER_WITH_TS(__be16, vals, 16);
+	/* NULL when no SPI offload hardware is present */
+	struct ad4691_offload_state *offload;
 };
 
 /*
@@ -283,6 +322,46 @@ static int ad4691_gpio_setup(struct ad4691_state *st, unsigned int gp_num)
 				  AD4691_GP_MODE_DATA_READY << shift);
 }
 
+static const struct spi_offload_config ad4691_offload_config = {
+	.capability_flags = SPI_OFFLOAD_CAP_TRIGGER |
+			    SPI_OFFLOAD_CAP_RX_STREAM_DMA,
+};
+
+static bool ad4691_offload_trigger_match(struct spi_offload_trigger *trigger,
+					 enum spi_offload_trigger_type type,
+					 u64 *args, u32 nargs)
+{
+	return type == SPI_OFFLOAD_TRIGGER_DATA_READY &&
+	       nargs == 1 && args[0] <= 3;
+}
+
+static int ad4691_offload_trigger_request(struct spi_offload_trigger *trigger,
+					  enum spi_offload_trigger_type type,
+					  u64 *args, u32 nargs)
+{
+	struct ad4691_state *st = spi_offload_trigger_get_priv(trigger);
+
+	if (nargs != 1)
+		return -EINVAL;
+
+	return ad4691_gpio_setup(st, args[0]);
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
+	.match    = ad4691_offload_trigger_match,
+	.request  = ad4691_offload_trigger_request,
+	.validate = ad4691_offload_trigger_validate,
+};
+
 static int ad4691_reg_read(void *context, unsigned int reg, unsigned int *val)
 {
 	struct spi_device *spi = context;
@@ -712,6 +791,7 @@ static const struct iio_buffer_setup_ops ad4691_manual_buffer_setup_ops = {
 static int ad4691_cnv_burst_buffer_preenable(struct iio_dev *indio_dev)
 {
 	struct ad4691_state *st = iio_priv(indio_dev);
+	unsigned int acc_mask;
 	unsigned int k, i;
 	int ret;
 
@@ -758,9 +838,9 @@ static int ad4691_cnv_burst_buffer_preenable(struct iio_dev *indio_dev)
 	if (ret)
 		goto err_unoptimize;
 
-	ret = regmap_write(st->regmap, AD4691_ACC_MASK_REG,
-			   ~bitmap_read(indio_dev->active_scan_mask, 0,
-				iio_get_masklength(indio_dev)) & GENMASK(15, 0));
+	acc_mask = ~bitmap_read(indio_dev->active_scan_mask, 0,
+				iio_get_masklength(indio_dev)) & GENMASK(15, 0);
+	ret = regmap_write(st->regmap, AD4691_ACC_MASK_REG, acc_mask);
 	if (ret)
 		goto err_unoptimize;
 
@@ -803,6 +883,209 @@ static const struct iio_buffer_setup_ops ad4691_cnv_burst_buffer_setup_ops = {
 	.postdisable = &ad4691_cnv_burst_buffer_postdisable,
 };
 
+static int ad4691_manual_offload_buffer_postenable(struct iio_dev *indio_dev)
+{
+	struct ad4691_state *st = iio_priv(indio_dev);
+	struct ad4691_offload_state *offload = st->offload;
+	struct device *dev = regmap_get_device(st->regmap);
+	struct spi_device *spi = to_spi_device(dev);
+	struct spi_offload_trigger_config config = {
+		.type = SPI_OFFLOAD_TRIGGER_PERIODIC,
+	};
+	unsigned int bpw = indio_dev->channels[0].scan_type.realbits;
+	unsigned int bit, k;
+	int ret;
+
+	ret = ad4691_enter_conversion_mode(st);
+	if (ret)
+		return ret;
+
+	memset(st->scan_xfers, 0, sizeof(st->scan_xfers));
+
+	/*
+	 * N+1 transfers for N channels. Each CS-low period triggers
+	 * a conversion AND returns the previous result (pipelined).
+	 *   TX: [AD4691_ADC_CHAN(n), 0x00]
+	 *   RX: [data_hi, data_lo]     (storagebits=16, shift=0)
+	 * Transfer 0 RX is garbage; transfers 1..N carry real data.
+	 */
+	k = 0;
+	iio_for_each_active_channel(indio_dev, bit) {
+		offload->tx_cmd[k][0] = AD4691_ADC_CHAN(bit);
+		st->scan_xfers[k].tx_buf = offload->tx_cmd[k];
+		st->scan_xfers[k].len = sizeof(offload->tx_cmd[k]);
+		st->scan_xfers[k].bits_per_word = bpw;
+		st->scan_xfers[k].cs_change = 1;
+		st->scan_xfers[k].cs_change_delay.value = AD4691_CNV_HIGH_TIME_NS;
+		st->scan_xfers[k].cs_change_delay.unit = SPI_DELAY_UNIT_NSECS;
+		/* First transfer RX is garbage — skip it. */
+		if (k > 0)
+			st->scan_xfers[k].offload_flags = SPI_OFFLOAD_XFER_RX_STREAM;
+		k++;
+	}
+
+	/* Final NOOP to flush pipeline and capture last channel. */
+	offload->tx_cmd[k][0] = AD4691_NOOP;
+	st->scan_xfers[k].tx_buf = offload->tx_cmd[k];
+	st->scan_xfers[k].len = sizeof(offload->tx_cmd[k]);
+	st->scan_xfers[k].bits_per_word = bpw;
+	st->scan_xfers[k].offload_flags = SPI_OFFLOAD_XFER_RX_STREAM;
+	k++;
+
+	spi_message_init_with_transfers(&st->scan_msg, st->scan_xfers, k);
+	st->scan_msg.offload = offload->offload;
+
+	ret = spi_optimize_message(spi, &st->scan_msg);
+	if (ret)
+		goto err_exit_conversion;
+
+	config.periodic.frequency_hz = offload->trigger_hz;
+	ret = spi_offload_trigger_enable(offload->offload, offload->trigger, &config);
+	if (ret)
+		goto err_unoptimize;
+
+	return 0;
+
+err_unoptimize:
+	spi_unoptimize_message(&st->scan_msg);
+err_exit_conversion:
+	ad4691_exit_conversion_mode(st);
+	return ret;
+}
+
+static int ad4691_manual_offload_buffer_predisable(struct iio_dev *indio_dev)
+{
+	struct ad4691_state *st = iio_priv(indio_dev);
+	struct ad4691_offload_state *offload = st->offload;
+
+	spi_offload_trigger_disable(offload->offload, offload->trigger);
+	spi_unoptimize_message(&st->scan_msg);
+
+	return ad4691_exit_conversion_mode(st);
+}
+
+static const struct iio_buffer_setup_ops ad4691_manual_offload_buffer_setup_ops = {
+	.postenable = &ad4691_manual_offload_buffer_postenable,
+	.predisable = &ad4691_manual_offload_buffer_predisable,
+};
+
+static int ad4691_cnv_burst_offload_buffer_postenable(struct iio_dev *indio_dev)
+{
+	struct ad4691_state *st = iio_priv(indio_dev);
+	struct ad4691_offload_state *offload = st->offload;
+	struct device *dev = regmap_get_device(st->regmap);
+	struct spi_device *spi = to_spi_device(dev);
+	struct spi_offload_trigger_config config = {
+		.type = SPI_OFFLOAD_TRIGGER_DATA_READY,
+	};
+	unsigned int bpw = indio_dev->channels[0].scan_type.realbits;
+	unsigned int acc_mask;
+	unsigned int bit, k;
+	int ret;
+
+	ret = regmap_write(st->regmap, AD4691_STD_SEQ_CONFIG,
+			   bitmap_read(indio_dev->active_scan_mask, 0,
+				       iio_get_masklength(indio_dev)));
+	if (ret)
+		return ret;
+
+	acc_mask = ~bitmap_read(indio_dev->active_scan_mask, 0,
+				iio_get_masklength(indio_dev)) & GENMASK(15, 0);
+	ret = regmap_write(st->regmap, AD4691_ACC_MASK_REG, acc_mask);
+	if (ret)
+		return ret;
+
+	ret = ad4691_enter_conversion_mode(st);
+	if (ret)
+		return ret;
+
+	memset(st->scan_xfers, 0, sizeof(st->scan_xfers));
+
+	/*
+	 * Each AVG_IN register read uses two 16-bit transfers:
+	 *   TX: [reg_hi | 0x80, reg_lo]  (address, CS stays asserted)
+	 *   RX: [data_hi, data_lo]       (data, storagebits=16, shift=0)
+	 * The state reset is also split into two 16-bit transfers
+	 * (address then value) to keep bits_per_word uniform throughout.
+	 */
+	k = 0;
+	iio_for_each_active_channel(indio_dev, bit) {
+		put_unaligned_be16(0x8000 | AD4691_AVG_IN(bit), offload->tx_cmd[k]);
+
+		/* TX: address phase, CS stays asserted into data phase */
+		st->scan_xfers[2 * k].tx_buf = offload->tx_cmd[k];
+		st->scan_xfers[2 * k].len = sizeof(offload->tx_cmd[k]);
+		st->scan_xfers[2 * k].bits_per_word = bpw;
+
+		/* RX: data phase, CS toggles after to delimit the next register op */
+		st->scan_xfers[2 * k + 1].len = sizeof(offload->tx_cmd[k]);
+		st->scan_xfers[2 * k + 1].bits_per_word = bpw;
+		st->scan_xfers[2 * k + 1].offload_flags = SPI_OFFLOAD_XFER_RX_STREAM;
+		st->scan_xfers[2 * k + 1].cs_change = 1;
+		k++;
+	}
+
+	/* State reset to re-arm DATA_READY for the next scan. */
+	put_unaligned_be16(AD4691_STATE_RESET_REG, offload->tx_reset);
+	offload->tx_reset[2] = AD4691_STATE_RESET_ALL;
+
+	st->scan_xfers[2 * k].tx_buf = offload->tx_reset;
+	st->scan_xfers[2 * k].len = sizeof(offload->tx_cmd[k]);
+	st->scan_xfers[2 * k].bits_per_word = bpw;
+
+	st->scan_xfers[2 * k + 1].tx_buf = &offload->tx_reset[2];
+	st->scan_xfers[2 * k + 1].len = sizeof(offload->tx_cmd[k]);
+	st->scan_xfers[2 * k + 1].bits_per_word = bpw;
+	st->scan_xfers[2 * k + 1].cs_change = 1;
+
+	spi_message_init_with_transfers(&st->scan_msg, st->scan_xfers, 2 * k + 2);
+	st->scan_msg.offload = offload->offload;
+
+	ret = spi_optimize_message(spi, &st->scan_msg);
+	if (ret)
+		goto err_exit_conversion;
+
+	ret = ad4691_sampling_enable(st, true);
+	if (ret)
+		goto err_unoptimize;
+
+	ret = spi_offload_trigger_enable(offload->offload, offload->trigger, &config);
+	if (ret)
+		goto err_sampling_disable;
+
+	return 0;
+
+err_sampling_disable:
+	ad4691_sampling_enable(st, false);
+err_unoptimize:
+	spi_unoptimize_message(&st->scan_msg);
+err_exit_conversion:
+	ad4691_exit_conversion_mode(st);
+	return ret;
+}
+
+static int ad4691_cnv_burst_offload_buffer_predisable(struct iio_dev *indio_dev)
+{
+	struct ad4691_state *st = iio_priv(indio_dev);
+	struct ad4691_offload_state *offload = st->offload;
+	int ret;
+
+	spi_offload_trigger_disable(offload->offload, offload->trigger);
+
+	ret = ad4691_sampling_enable(st, false);
+	if (ret)
+		return ret;
+
+	spi_unoptimize_message(&st->scan_msg);
+
+	return ad4691_exit_conversion_mode(st);
+}
+
+static const struct iio_buffer_setup_ops ad4691_cnv_burst_offload_buffer_setup_ops = {
+	.postenable = &ad4691_cnv_burst_offload_buffer_postenable,
+	.predisable = &ad4691_cnv_burst_offload_buffer_predisable,
+};
+
 static ssize_t sampling_frequency_show(struct device *dev,
 				       struct device_attribute *attr,
 				       char *buf)
@@ -810,6 +1093,9 @@ static ssize_t sampling_frequency_show(struct device *dev,
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct ad4691_state *st = iio_priv(indio_dev);
 
+	if (st->manual_mode && st->offload)
+		return sysfs_emit(buf, "%llu\n", st->offload->trigger_hz);
+
 	return sysfs_emit(buf, "%lu\n", NSEC_PER_SEC / st->cnv_period_ns);
 }
 
@@ -825,12 +1111,25 @@ static ssize_t sampling_frequency_store(struct device *dev,
 	if (ret)
 		return ret;
 
-	ret = iio_device_claim_direct(indio_dev);
-	if (ret)
-		return ret;
+	IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
+	if (IIO_DEV_ACQUIRE_FAILED(claim))
+		return -EBUSY;
+
+	if (st->manual_mode && st->offload) {
+		struct spi_offload_trigger_config config = {
+			.type = SPI_OFFLOAD_TRIGGER_PERIODIC,
+			.periodic = { .frequency_hz = freq },
+		};
+
+		ret = spi_offload_trigger_validate(st->offload->trigger, &config);
+		if (ret)
+			return ret;
+
+		st->offload->trigger_hz = config.periodic.frequency_hz;
+		return len;
+	}
 
 	ret = ad4691_set_pwm_freq(st, freq);
-	iio_device_release_direct(indio_dev);
 	if (ret)
 		return ret;
 
@@ -1139,9 +1438,75 @@ static int ad4691_setup_triggered_buffer(struct iio_dev *indio_dev,
 						   ad4691_buffer_attrs);
 }
 
+static int ad4691_setup_offload(struct iio_dev *indio_dev,
+				struct ad4691_state *st,
+				struct spi_offload *spi_offload)
+{
+	struct device *dev = regmap_get_device(st->regmap);
+	struct ad4691_offload_state *offload;
+	struct dma_chan *rx_dma;
+	int ret;
+
+	offload = devm_kzalloc(dev, sizeof(*offload), GFP_KERNEL);
+	if (!offload)
+		return -ENOMEM;
+
+	offload->offload = spi_offload;
+	st->offload = offload;
+
+	if (st->manual_mode) {
+		offload->trigger =
+			devm_spi_offload_trigger_get(dev, offload->offload,
+						     SPI_OFFLOAD_TRIGGER_PERIODIC);
+		if (IS_ERR(offload->trigger))
+			return dev_err_probe(dev, PTR_ERR(offload->trigger),
+					     "Failed to get periodic offload trigger\n");
+
+		offload->trigger_hz = AD4691_OFFLOAD_INITIAL_TRIGGER_HZ;
+	} else {
+		struct spi_offload_trigger_info trigger_info = {
+			.fwnode = dev_fwnode(dev),
+			.ops    = &ad4691_offload_trigger_ops,
+			.priv   = st,
+		};
+
+		ret = devm_spi_offload_trigger_register(dev, &trigger_info);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "Failed to register offload trigger\n");
+
+		offload->trigger =
+			devm_spi_offload_trigger_get(dev, offload->offload,
+						     SPI_OFFLOAD_TRIGGER_DATA_READY);
+		if (IS_ERR(offload->trigger))
+			return dev_err_probe(dev, PTR_ERR(offload->trigger),
+					     "Failed to get DATA_READY offload trigger\n");
+	}
+
+	rx_dma = devm_spi_offload_rx_stream_request_dma_chan(dev, offload->offload);
+	if (IS_ERR(rx_dma))
+		return dev_err_probe(dev, PTR_ERR(rx_dma),
+				     "Failed to get offload RX DMA channel\n");
+
+	if (st->manual_mode)
+		indio_dev->setup_ops = &ad4691_manual_offload_buffer_setup_ops;
+	else
+		indio_dev->setup_ops = &ad4691_cnv_burst_offload_buffer_setup_ops;
+
+	ret = devm_iio_dmaengine_buffer_setup_with_handle(dev, indio_dev, rx_dma,
+							  IIO_BUFFER_DIRECTION_IN);
+	if (ret)
+		return ret;
+
+	indio_dev->buffer->attrs = ad4691_buffer_attrs;
+
+	return 0;
+}
+
 static int ad4691_probe(struct spi_device *spi)
 {
 	struct device *dev = &spi->dev;
+	struct spi_offload *spi_offload;
 	struct iio_dev *indio_dev;
 	struct ad4691_state *st;
 	int ret;
@@ -1175,13 +1540,26 @@ static int ad4691_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
+	spi_offload = devm_spi_offload_get(dev, spi, &ad4691_offload_config);
+	ret = PTR_ERR_OR_ZERO(spi_offload);
+	if (ret == -ENODEV)
+		spi_offload = NULL;
+	else if (ret)
+		return dev_err_probe(dev, ret, "Failed to get SPI offload\n");
+
 	indio_dev->name = st->info->name;
 	indio_dev->info = &ad4691_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
-	indio_dev->channels = st->info->sw_info->channels;
-	indio_dev->num_channels = st->info->sw_info->num_channels;
-	ret = ad4691_setup_triggered_buffer(indio_dev, st);
+	if (spi_offload) {
+		indio_dev->channels = st->info->offload_info->channels;
+		indio_dev->num_channels = st->info->offload_info->num_channels;
+		ret = ad4691_setup_offload(indio_dev, st, spi_offload);
+	} else {
+		indio_dev->channels = st->info->sw_info->channels;
+		indio_dev->num_channels = st->info->sw_info->num_channels;
+		ret = ad4691_setup_triggered_buffer(indio_dev, st);
+	}
 	if (ret)
 		return ret;
 
@@ -1219,3 +1597,5 @@ module_spi_driver(ad4691_driver);
 MODULE_AUTHOR("Radu Sabau <radu.sabau@analog.com>");
 MODULE_DESCRIPTION("Analog Devices AD4691 Family ADC Driver");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("IIO_DMA_BUFFER");
+MODULE_IMPORT_NS("IIO_DMAENGINE_BUFFER");

-- 
2.43.0



