Return-Path: <linux-pwm+bounces-9203-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MKWiN1BnGWrZwAgAu9opvQ
	(envelope-from <linux-pwm+bounces-9203-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 29 May 2026 12:15:44 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B34B6009A2
	for <lists+linux-pwm@lfdr.de>; Fri, 29 May 2026 12:15:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B66CD30344E0
	for <lists+linux-pwm@lfdr.de>; Fri, 29 May 2026 10:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 531353C585B;
	Fri, 29 May 2026 10:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NiFPKF9T"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6353BD635;
	Fri, 29 May 2026 10:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780049704; cv=none; b=K29ZinkrJweMxztPsWn38GgjKv0T12fbbQiA5KB0PqEFZr0UIViBagITKYuto05WVrBFX2t4+F73RYwYCPDM8PmB8HK0irCuZoi7aCeyrPpmuvqJTCx5Mk6nmrIezUdIJkY+uW6wV9GyxtYmmcLB6SK02eWUubKRkGolQ9rnTqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780049704; c=relaxed/simple;
	bh=XLYf8W0SXs0I4U76tSZHOZ2I5HAgyzTuqu4vbSS80U8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IGvA3bCFT80wq27xou92Y6yDVXyIaTpnjQW4k+Ho8JeyyVxLidedrla/v1+//0PGhZBoJZdxhRplLdr9IazM3Y1CR1DY96PbTjbMcRdUzmN3DObBhJH+sGSf6mGIsIsJJqcBoGdcRwgLuqO1WWP59jNoX6RQfPyxlusmYhuijNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NiFPKF9T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EEBD9C2BCF5;
	Fri, 29 May 2026 10:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1780049704;
	bh=XLYf8W0SXs0I4U76tSZHOZ2I5HAgyzTuqu4vbSS80U8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=NiFPKF9TXciuW2PAOwvsO/thx05heCoBEO3k9CAuw4dQaa2ccyqhDzyNoVDApYJSp
	 DUqeanEczSgFvMV6WXVzKLCFm6xkM/ZPF3FDcw8C4ucRM66goSFVpG/XlqKMQzyfSp
	 Xc55PlbgA0+QedjVJFoe6FWXRI4K4KtXTOOu5+10A6lsBkCOphMypxMymdFlOmLiBU
	 WOrPb53dORYdrlq48J9kqpKNA+pkgGmVmMN6L4KNDqYwYdHAjqYuLvyhxZ7ZyIJbz9
	 nQ1chIwun22ZaMh1Pzzh4Z/n5suGoBdtzl6PWjylF6n/idijpRbBMfIrWF2FTRClGq
	 5+D+k4J1BDSOQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3C79CD6E4C;
	Fri, 29 May 2026 10:15:03 +0000 (UTC)
From: Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org>
Date: Fri, 29 May 2026 13:15:03 +0300
Subject: [PATCH v14 4/6] iio: adc: ad4691: add SPI offload support
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260529-ad4692-multichannel-sar-adc-driver-v14-4-e93c2747dc1f@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780049701; l=23174;
 i=radu.sabau@analog.com; s=20260220; h=from:subject:message-id;
 bh=f0N/SMgTKfRnA5eqvxv1p6ghXhNtcbu4RMWt7iCW7A0=;
 b=Dlodp6iEvZvFyRTSj1EZKkZP7+m8butEWDaM4hKtbXAEdrL5NfBrTQPkrA44uYN0o9bpYsbM3
 kt/5PCudOnBA3aZFsY0OWE9mAO485NUbC1tUwNffKh53R87aTvyYH34
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
	TAGGED_FROM(0.00)[bounces-9203-lists,linux-pwm=lfdr.de,radu.sabau.analog.com];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[analog.com:replyto,analog.com:mid,analog.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 7B34B6009A2
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
The SPI Engine assembles received bits into native 16-bit words before
DMA, so offload samples land in CPU-native byte order (IIO_CPU).
Dedicated channel arrays (AD4691_OFFLOAD_CHANNEL) reflect this: they
omit IIO_BE and carry no soft timestamp (DMA delivers data directly to
userspace). The software triggered-buffer path retains its IIO_BE
channels because bits_per_word=8 causes SPI to deliver bytes MSB-first
into memory, making the on-disk layout big-endian. Both paths use
storagebits=16 as transfers are 16 bits wide in both cases.

IIO_BUFFER_DMAENGINE is selected because the offload path uses
devm_iio_dmaengine_buffer_setup_with_handle() to allocate and
attach the DMA RX buffer to the IIO device.

Signed-off-by: Radu Sabau <radu.sabau@analog.com>
---
 drivers/iio/adc/Kconfig  |   2 +
 drivers/iio/adc/ad4691.c | 444 ++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 443 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 1d7afde108c0..4d12eeb08020 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -149,8 +149,10 @@ config AD4691
 	depends on SPI
 	depends on REGULATOR || COMPILE_TEST
 	select IIO_BUFFER
+	select IIO_BUFFER_DMAENGINE
 	select IIO_TRIGGERED_BUFFER
 	select REGMAP
+	select SPI_OFFLOAD
 	help
 	  Say yes here to build support for Analog Devices AD4691 Family MuxSAR
 	  SPI analog to digital converters (ADC).
diff --git a/drivers/iio/adc/ad4691.c b/drivers/iio/adc/ad4691.c
index 175c80129786..b1d1b42f724e 100644
--- a/drivers/iio/adc/ad4691.c
+++ b/drivers/iio/adc/ad4691.c
@@ -10,6 +10,7 @@
 #include <linux/delay.h>
 #include <linux/dev_printk.h>
 #include <linux/device/devres.h>
+#include <linux/dmaengine.h>
 #include <linux/err.h>
 #include <linux/interrupt.h>
 #include <linux/kstrtox.h>
@@ -24,11 +25,15 @@
 #include <linux/reset.h>
 #include <linux/string.h>
 #include <linux/spi/spi.h>
+#include <linux/spi/offload/consumer.h>
+#include <linux/spi/offload/provider.h>
 #include <linux/types.h>
 #include <linux/units.h>
 #include <linux/unaligned.h>
 
 #include <linux/iio/buffer.h>
+#include <linux/iio/buffer-dma.h>
+#include <linux/iio/buffer-dmaengine.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 #include <linux/iio/trigger.h>
@@ -44,6 +49,11 @@
 
 #define AD4691_CNV_DUTY_CYCLE_NS		380
 #define AD4691_CNV_HIGH_TIME_NS			430
+/*
+ * Conservative default for the manual offload periodic trigger. Low enough
+ * to work safely out of the box across all OSR and channel count combinations.
+ */
+#define AD4691_OFFLOAD_INITIAL_TRIGGER_HZ	(100 * HZ_PER_KHZ)
 
 #define AD4691_SPI_CONFIG_A_REG			0x000
 #define AD4691_SW_RESET				(BIT(7) | BIT(0))
@@ -119,6 +129,7 @@ struct ad4691_chip_info {
 	const char *name;
 	unsigned int max_rate;
 	const struct ad4691_channel_info *sw_info;
+	const struct ad4691_channel_info *offload_info;
 };
 
 #define AD4691_CHANNEL(ch)						\
@@ -140,6 +151,30 @@ struct ad4691_chip_info {
 		},							\
 	}
 
+/*
+ * Offload path (bits_per_word=16): the SPI Engine assembles received
+ * bits into native 16-bit words before DMA, so samples are in
+ * CPU-native byte order (IIO_CPU). storagebits=16 matches the 16-bit
+ * DMA word size.
+ */
+#define AD4691_OFFLOAD_CHANNEL(ch)					\
+	{								\
+		.type = IIO_VOLTAGE,					\
+		.indexed = 1,						\
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SCALE)	\
+				    | BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
+		.info_mask_shared_by_all_available =			\
+				      BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
+		.channel = ch,						\
+		.scan_index = ch,					\
+		.scan_type = {						\
+			.format = 'u',					\
+			.realbits = 16,					\
+			.storagebits = 16,				\
+		},							\
+	}
+
 static const struct iio_chan_spec ad4691_channels[] = {
 	AD4691_CHANNEL(0),
 	AD4691_CHANNEL(1),
@@ -172,6 +207,40 @@ static const struct iio_chan_spec ad4693_channels[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(8),
 };
 
+/*
+ * Offload channel arrays: no IIO_CHAN_SOFT_TIMESTAMP because DMA delivers
+ * data directly to userspace without a software timestamp.
+ */
+static const struct iio_chan_spec ad4691_offload_channels[] = {
+	AD4691_OFFLOAD_CHANNEL(0),
+	AD4691_OFFLOAD_CHANNEL(1),
+	AD4691_OFFLOAD_CHANNEL(2),
+	AD4691_OFFLOAD_CHANNEL(3),
+	AD4691_OFFLOAD_CHANNEL(4),
+	AD4691_OFFLOAD_CHANNEL(5),
+	AD4691_OFFLOAD_CHANNEL(6),
+	AD4691_OFFLOAD_CHANNEL(7),
+	AD4691_OFFLOAD_CHANNEL(8),
+	AD4691_OFFLOAD_CHANNEL(9),
+	AD4691_OFFLOAD_CHANNEL(10),
+	AD4691_OFFLOAD_CHANNEL(11),
+	AD4691_OFFLOAD_CHANNEL(12),
+	AD4691_OFFLOAD_CHANNEL(13),
+	AD4691_OFFLOAD_CHANNEL(14),
+	AD4691_OFFLOAD_CHANNEL(15),
+};
+
+static const struct iio_chan_spec ad4693_offload_channels[] = {
+	AD4691_OFFLOAD_CHANNEL(0),
+	AD4691_OFFLOAD_CHANNEL(1),
+	AD4691_OFFLOAD_CHANNEL(2),
+	AD4691_OFFLOAD_CHANNEL(3),
+	AD4691_OFFLOAD_CHANNEL(4),
+	AD4691_OFFLOAD_CHANNEL(5),
+	AD4691_OFFLOAD_CHANNEL(6),
+	AD4691_OFFLOAD_CHANNEL(7),
+};
+
 static const struct ad4691_channel_info ad4691_sw_info = {
 	.channels = ad4691_channels,
 	.num_channels = ARRAY_SIZE(ad4691_channels),
@@ -182,6 +251,16 @@ static const struct ad4691_channel_info ad4693_sw_info = {
 	.num_channels = ARRAY_SIZE(ad4693_channels),
 };
 
+static const struct ad4691_channel_info ad4691_offload_info = {
+	.channels = ad4691_offload_channels,
+	.num_channels = ARRAY_SIZE(ad4691_offload_channels),
+};
+
+static const struct ad4691_channel_info ad4693_offload_info = {
+	.channels = ad4693_offload_channels,
+	.num_channels = ARRAY_SIZE(ad4693_offload_channels),
+};
+
 /*
  * Internal oscillator frequency table. Index is the OSC_FREQ_REG[3:0] value.
  * Index 0 (1 MHz) is only valid for AD4692/AD4694; AD4691/AD4693 support
@@ -212,24 +291,28 @@ static const struct ad4691_chip_info ad4691_chip_info = {
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
 };
 
 struct ad4691_state {
@@ -251,6 +334,10 @@ struct ad4691_state {
 	 * atomicity of consecutive SPI operations.
 	 */
 	struct mutex lock;
+	/* NULL when no SPI offload hardware is present. */
+	struct spi_offload *offload;
+	struct spi_offload_trigger *offload_trigger;
+	u64 trigger_hz;
 	/*
 	 * Per-buffer-enable lifetime resources:
 	 * Manual Mode - a pre-built SPI message that clocks out N+1
@@ -265,8 +352,11 @@ struct ad4691_state {
 	struct spi_transfer scan_xfers[34];
 	/*
 	 * CNV burst: 16 AVG_IN addresses = 16.  Manual: 16 channel cmds +
-	 * 1 NOOP = 17.  Stored as native u16; put_unaligned_be16() fills each
-	 * slot so the SPI controller (bits_per_word=8) sends bytes MSB-first.
+	 * 1 NOOP = 17.  Stored as native u16.  The non-offload path fills slots
+	 * with put_unaligned_be16() (bits_per_word=8, bytes go out in memory
+	 * order).  The offload path assigns native values directly
+	 * (bits_per_word=bpw, SPI reads each slot as a native 16-bit word and
+	 * shifts it out MSB-first).
 	 */
 	u16 scan_tx[17] __aligned(IIO_DMA_MINALIGN);
 	/*
@@ -301,6 +391,45 @@ static int ad4691_gpio_setup(struct ad4691_state *st, unsigned int gp_num)
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
+	return type == SPI_OFFLOAD_TRIGGER_DATA_READY && nargs == 1 && args[0] <= 3;
+}
+
+static int ad4691_offload_trigger_request(struct spi_offload_trigger *trigger,
+					  enum spi_offload_trigger_type type,
+					  u64 *args, u32 nargs)
+{
+	struct ad4691_state *st = spi_offload_trigger_get_priv(trigger);
+
+	if (nargs != 1 || args[0] > 3)
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
@@ -876,6 +1005,218 @@ static const struct iio_buffer_setup_ops ad4691_cnv_burst_buffer_setup_ops = {
 	.postdisable = ad4691_cnv_burst_buffer_postdisable,
 };
 
+static int ad4691_manual_offload_buffer_postenable(struct iio_dev *indio_dev)
+{
+	struct ad4691_state *st = iio_priv(indio_dev);
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
+	memset(st->scan_tx, 0, sizeof(st->scan_tx));
+
+	/*
+	 * N+1 transfers for N channels. Each CS-low period triggers
+	 * a conversion AND returns the previous result (pipelined).
+	 *   TX: [AD4691_ADC_CHAN(n), 0x00]
+	 *   RX: [data_hi, data_lo]     (storagebits=16, shift=0)
+	 * Transfer 0 RX is garbage; transfers 1..N carry real data.
+	 * scan_tx is reused for TX commands (mutually exclusive with the
+	 * non-offload triggered-buffer path).
+	 *
+	 * bits_per_word=bpw: the SPI controller reads tx_buf as a native
+	 * 16-bit word and shifts it out MSB-first.  Store the exact 16-bit
+	 * value we want on the wire as a plain native u16 — no endianness
+	 * macro — so the wire bytes are correct on both LE and BE hosts.
+	 * The channel-select command is a single byte; shift it to the MSB
+	 * position so SPI sends it first, with a zero pad in the LSB.
+	 */
+	k = 0;
+	iio_for_each_active_channel(indio_dev, bit) {
+		st->scan_tx[k] = AD4691_ADC_CHAN(bit) << 8;
+		st->scan_xfers[k].tx_buf = &st->scan_tx[k];
+		st->scan_xfers[k].len = sizeof(*st->scan_tx);
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
+	/* Final NOOP transfer retrieves the last channel's result. */
+	st->scan_xfers[k].tx_buf = &st->scan_tx[k]; /* scan_tx[k] == 0 == NOOP */
+	st->scan_xfers[k].len = sizeof(*st->scan_tx);
+	st->scan_xfers[k].bits_per_word = bpw;
+	st->scan_xfers[k].offload_flags = SPI_OFFLOAD_XFER_RX_STREAM;
+	k++;
+
+	spi_message_init_with_transfers(&st->scan_msg, st->scan_xfers, k);
+	st->scan_msg.offload = st->offload;
+
+	ret = spi_optimize_message(spi, &st->scan_msg);
+	if (ret)
+		goto err_exit_conversion;
+
+	config.periodic.frequency_hz = st->trigger_hz;
+	ret = spi_offload_trigger_enable(st->offload, st->offload_trigger, &config);
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
+
+	spi_offload_trigger_disable(st->offload, st->offload_trigger);
+	spi_unoptimize_message(&st->scan_msg);
+
+	return ad4691_exit_conversion_mode(st);
+}
+
+static const struct iio_buffer_setup_ops ad4691_manual_offload_buffer_setup_ops = {
+	.postenable = ad4691_manual_offload_buffer_postenable,
+	.predisable = ad4691_manual_offload_buffer_predisable,
+};
+
+static int ad4691_cnv_burst_offload_buffer_postenable(struct iio_dev *indio_dev)
+{
+	struct ad4691_state *st = iio_priv(indio_dev);
+	struct device *dev = regmap_get_device(st->regmap);
+	struct spi_device *spi = to_spi_device(dev);
+	struct spi_offload_trigger_config config = {
+		.type = SPI_OFFLOAD_TRIGGER_DATA_READY,
+	};
+	unsigned int bpw = indio_dev->channels[0].scan_type.realbits;
+	unsigned int acc_mask, std_seq_config;
+	unsigned int bit, k;
+	int ret;
+
+	std_seq_config = bitmap_read(indio_dev->active_scan_mask, 0,
+				     iio_get_masklength(indio_dev)) & GENMASK(15, 0);
+	ret = regmap_write(st->regmap, AD4691_STD_SEQ_CONFIG, std_seq_config);
+	if (ret)
+		return ret;
+
+	acc_mask = ~std_seq_config & GENMASK(15, 0);
+	ret = regmap_write(st->regmap, AD4691_ACC_MASK_REG, acc_mask);
+	if (ret)
+		return ret;
+
+	ret = ad4691_enter_conversion_mode(st);
+	if (ret)
+		return ret;
+
+	memset(st->scan_xfers, 0, sizeof(st->scan_xfers));
+	memset(st->scan_tx, 0, sizeof(st->scan_tx));
+
+	/*
+	 * Each AVG_IN register read uses two transfers:
+	 *   TX: [reg_hi | 0x80, reg_lo]  (address phase, CS stays asserted)
+	 *   RX: [data_hi, data_lo]       (bpw-wide data phase, storagebits=16)
+	 * Both TX and RX use bits_per_word=bpw: the SPI controller reads tx_buf
+	 * as a native 16-bit word and shifts it out MSB-first.  Store the exact
+	 * 16-bit wire value as a plain native u16 — no endianness macro — so the
+	 * wire bytes are correct on both LE and BE hosts.  The read-address
+	 * (0x8000 | reg) is already the 16-bit value we want on the wire.
+	 * scan_tx is reused for TX addresses (mutually exclusive with the
+	 * non-offload triggered-buffer path).
+	 */
+	k = 0;
+	iio_for_each_active_channel(indio_dev, bit) {
+		st->scan_tx[k] = 0x8000 | AD4691_AVG_IN(bit);
+
+		/* TX: address phase, CS stays asserted into data phase */
+		st->scan_xfers[2 * k].tx_buf = &st->scan_tx[k];
+		st->scan_xfers[2 * k].len = sizeof(*st->scan_tx);
+		st->scan_xfers[2 * k].bits_per_word = bpw;
+
+		/* RX: data phase, CS toggles after to delimit the next register op */
+		st->scan_xfers[2 * k + 1].len = sizeof(*st->scan_tx);
+		st->scan_xfers[2 * k + 1].bits_per_word = bpw;
+		st->scan_xfers[2 * k + 1].offload_flags = SPI_OFFLOAD_XFER_RX_STREAM;
+		st->scan_xfers[2 * k + 1].cs_change = 1;
+		k++;
+	}
+
+	/*
+	 * State reset: single 4-byte write [addr_hi, addr_lo, STATE_RESET_ALL,
+	 * OSC_EN=1]. ADDR_DESCENDING writes byte[3]=1 to OSC_EN_REG (0x180) as
+	 * a deliberate side-write, keeping the oscillator enabled.
+	 * scan_tx_reset is shared with the non-offload path (len=4 here vs
+	 * len=3 there) since the two paths are mutually exclusive at probe.
+	 */
+	put_unaligned_be16(AD4691_STATE_RESET_REG, st->scan_tx_reset);
+	st->scan_tx_reset[2] = AD4691_STATE_RESET_ALL;
+	st->scan_tx_reset[3] = 1;
+	st->scan_xfers[2 * k].tx_buf = st->scan_tx_reset;
+	st->scan_xfers[2 * k].len = sizeof(st->scan_tx_reset);
+	/*
+	 * 4-byte u8 buffer assembled with put_unaligned_be16(); leave
+	 * bits_per_word at the default (8) so bytes go out in memory order.
+	 */
+
+	spi_message_init_with_transfers(&st->scan_msg, st->scan_xfers, 2 * k + 1);
+	st->scan_msg.offload = st->offload;
+
+	ret = spi_optimize_message(spi, &st->scan_msg);
+	if (ret)
+		goto err_exit_conversion;
+
+	ret = spi_offload_trigger_enable(st->offload, st->offload_trigger, &config);
+	if (ret)
+		goto err_unoptimize;
+
+	ret = ad4691_sampling_enable(st, true);
+	if (ret)
+		goto err_disable_trigger;
+
+	return 0;
+
+err_disable_trigger:
+	spi_offload_trigger_disable(st->offload, st->offload_trigger);
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
+
+	ad4691_sampling_enable(st, false);
+	spi_offload_trigger_disable(st->offload, st->offload_trigger);
+	spi_unoptimize_message(&st->scan_msg);
+
+	return ad4691_exit_conversion_mode(st);
+}
+
+static const struct iio_buffer_setup_ops ad4691_cnv_burst_offload_buffer_setup_ops = {
+	.postenable = ad4691_cnv_burst_offload_buffer_postenable,
+	.predisable = ad4691_cnv_burst_offload_buffer_predisable,
+};
+
 static ssize_t sampling_frequency_show(struct device *dev,
 				       struct device_attribute *attr,
 				       char *buf)
@@ -883,6 +1224,9 @@ static ssize_t sampling_frequency_show(struct device *dev,
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct ad4691_state *st = iio_priv(indio_dev);
 
+	if (st->manual_mode && st->offload)
+		return sysfs_emit(buf, "%llu\n", READ_ONCE(st->trigger_hz));
+
 	return sysfs_emit(buf, "%lu\n", NSEC_PER_SEC / st->cnv_period_ns);
 }
 
@@ -903,6 +1247,20 @@ static ssize_t sampling_frequency_store(struct device *dev,
 	if (IIO_DEV_ACQUIRE_FAILED(claim))
 		return -EBUSY;
 
+	if (st->manual_mode && st->offload) {
+		struct spi_offload_trigger_config config = {
+			.type = SPI_OFFLOAD_TRIGGER_PERIODIC,
+			.periodic = { .frequency_hz = freq },
+		};
+
+		ret = spi_offload_trigger_validate(st->offload_trigger, &config);
+		if (ret)
+			return ret;
+
+		WRITE_ONCE(st->trigger_hz, config.periodic.frequency_hz);
+		return len;
+	}
+
 	ret = ad4691_set_pwm_freq(st, freq);
 	if (ret)
 		return ret;
@@ -1268,9 +1626,77 @@ static int ad4691_setup_triggered_buffer(struct iio_dev *indio_dev,
 						   ad4691_buffer_attrs);
 }
 
+static int ad4691_setup_offload(struct iio_dev *indio_dev,
+				struct ad4691_state *st,
+				struct spi_offload *spi_offload)
+{
+	struct device *dev = regmap_get_device(st->regmap);
+	struct dma_chan *rx_dma;
+	int ret;
+
+	st->offload = spi_offload;
+
+	indio_dev->channels = st->info->offload_info->channels;
+	indio_dev->num_channels = st->info->offload_info->num_channels;
+	/*
+	 * Offload path uses DMA directly; no IIO trigger is involved, so
+	 * external triggers are not restricted (no validate_trigger).
+	 */
+	indio_dev->info = &ad4691_manual_info;
+
+	if (st->manual_mode) {
+		st->offload_trigger =
+			devm_spi_offload_trigger_get(dev, st->offload,
+						     SPI_OFFLOAD_TRIGGER_PERIODIC);
+		if (IS_ERR(st->offload_trigger))
+			return dev_err_probe(dev, PTR_ERR(st->offload_trigger),
+					     "Failed to get periodic offload trigger\n");
+
+		st->trigger_hz = AD4691_OFFLOAD_INITIAL_TRIGGER_HZ;
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
+		st->offload_trigger =
+			devm_spi_offload_trigger_get(dev, st->offload,
+						     SPI_OFFLOAD_TRIGGER_DATA_READY);
+		if (IS_ERR(st->offload_trigger))
+			return dev_err_probe(dev, PTR_ERR(st->offload_trigger),
+					     "Failed to get DATA_READY offload trigger\n");
+	}
+
+	rx_dma = devm_spi_offload_rx_stream_request_dma_chan(dev, st->offload);
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
@@ -1306,10 +1732,20 @@ static int ad4691_probe(struct spi_device *spi)
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
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
-	ret = ad4691_setup_triggered_buffer(indio_dev, st);
+	if (spi_offload)
+		ret = ad4691_setup_offload(indio_dev, st, spi_offload);
+	else
+		ret = ad4691_setup_triggered_buffer(indio_dev, st);
 	if (ret)
 		return ret;
 
@@ -1347,3 +1783,5 @@ module_spi_driver(ad4691_driver);
 MODULE_AUTHOR("Radu Sabau <radu.sabau@analog.com>");
 MODULE_DESCRIPTION("Analog Devices AD4691 Family ADC Driver");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("IIO_DMA_BUFFER");
+MODULE_IMPORT_NS("IIO_DMAENGINE_BUFFER");

-- 
2.43.0



