Return-Path: <linux-pwm+bounces-8297-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sCeqLawpvWkG7QIAu9opvQ
	(envelope-from <linux-pwm+bounces-8297-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Mar 2026 12:04:12 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 911AB2D93E8
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Mar 2026 12:04:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B04E6300F12A
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Mar 2026 11:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38AD939B95A;
	Fri, 20 Mar 2026 11:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uO1t5oGH"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8257396D1E;
	Fri, 20 Mar 2026 11:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774004639; cv=none; b=MXxjsc8D2YpcslVdHGDl2cj7qN6AAdSfL8u2sbWMHG9xbl73bge/UYIHeWxE+uH+kX8WKdyKCHxuUPq8FjRw0H+BghDgkJMprD77QsxgATHxWebI8GoG9ZpD9XRxbGJBFZq4uPvrmqZdKlahN4NNHbFJbiURZH+Wx2HBVtRZOmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774004639; c=relaxed/simple;
	bh=d0/ZPw94aFPTAExgWJwi5bY5yasqhO+dLDXzto1Lo0I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UNWTHGioKJgZ2cF6aClFdRrwIHBFq1fzJgI7zs5uJj05iJlccZW8jp+Kix73zFkdUbK/98yZFOwCq9ZK4LQIUSKq3z9uCwPDDb31Kuir8xXnvmQglnOwiCNkbds16Sg71Nh3Dq9Bhvk2xTm2IuvU/+GSJ+BQ2XykxBvI4fo54a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uO1t5oGH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A686EC2BCC9;
	Fri, 20 Mar 2026 11:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774004639;
	bh=d0/ZPw94aFPTAExgWJwi5bY5yasqhO+dLDXzto1Lo0I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=uO1t5oGHTLwEEpWQTiqm5IgBe2Wm6sxyN09lfz/SccPgTzXAM+teVqBI2Zum64m6l
	 z/+/o8PgslLWDCVP2+ju5YgiWRFblvtnpU+UeiDNzTj5oJdpAgbAPBNdu1MjFzmh9Y
	 kCpzRSRnHHEo4rwCFfwe8GgyTbziMDhYjIkhbgk4Ql/vr1IHm92KQ541gcYX5dlcio
	 /Pv/qno0BlHX7FszpzY3/29FoBNokDZfMDjA7z+Ine+cF3f0Ingc6fH7DXJzhFEMug
	 GXAF/3gK0r2fSX67LDmMN/RbO1SSbnZlWtjAIbgJkJn+K6GKWyIM2G/Fh4Rilflh3Z
	 UBIxFUowS3DqA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CA5C108B8F3;
	Fri, 20 Mar 2026 11:03:59 +0000 (UTC)
From: Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org>
Date: Fri, 20 Mar 2026 13:03:58 +0200
Subject: [PATCH v4 4/4] iio: adc: ad4691: add SPI offload support
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260320-ad4692-multichannel-sar-adc-driver-v4-4-052c1050507a@analog.com>
References: <20260320-ad4692-multichannel-sar-adc-driver-v4-0-052c1050507a@analog.com>
In-Reply-To: <20260320-ad4692-multichannel-sar-adc-driver-v4-0-052c1050507a@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774004636; l=23384;
 i=radu.sabau@analog.com; s=20260220; h=from:subject:message-id;
 bh=CcNob1GhOWpVfV4i05s0F2XBUXGCckdQbVMCSNH+1Go=;
 b=SU5pnU+A0aTeL95IAt11cS9Hto61a/gS2bAyFQPWD9pTz9yx/9zTQKalqarf/6KK2pfIE3613
 eqtsffDXqGaC/EHonsjqb0Y7nnTyMxvAfNW06j5iD8S9LbvtQkBh6YV
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8297-lists,linux-pwm=lfdr.de,radu.sabau.analog.com];
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
	NEURAL_HAM(-0.00)[-0.996];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	HAS_REPLYTO(0.00)[radu.sabau@analog.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 911AB2D93E8
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
the pipelined CNV-on-CS protocol: N+1 4-byte transfers are issued
for N active channels (the first result is discarded as garbage from
the pipeline flush) and the remaining N results are captured by DMA.

All offload transfers use 32-bit frames (bits_per_word=32, len=4) for
DMA word alignment. This patch promotes the channel scan_type from
storagebits=16 (triggered-buffer path) to storagebits=32 to match the
DMA word size; the triggered-buffer paths are updated to the same layout
for consistency. CNV Burst Mode channel data arrives in the lower 16
bits of the 32-bit word (shift=0); Manual Mode data arrives in the upper
16 bits (shift=16), matching the 4-byte SPI transfer layout
[data_hi, data_lo, 0, 0]. A separate ad4691_manual_channels[] array
encodes the shift=16 scan type for manual mode.

Kconfig gains a dependency on IIO_BUFFER_DMAENGINE.

Signed-off-by: Radu Sabau <radu.sabau@analog.com>
---
 drivers/iio/adc/Kconfig  |   1 +
 drivers/iio/adc/ad4691.c | 470 +++++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 435 insertions(+), 36 deletions(-)

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
index db776de32846..5e0fe993c17d 100644
--- a/drivers/iio/adc/ad4691.c
+++ b/drivers/iio/adc/ad4691.c
@@ -8,6 +8,7 @@
 #include <linux/cleanup.h>
 #include <linux/delay.h>
 #include <linux/device.h>
+#include <linux/dmaengine.h>
 #include <linux/err.h>
 #include <linux/interrupt.h>
 #include <linux/math.h>
@@ -19,10 +20,14 @@
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
@@ -37,6 +42,7 @@
 #define AD4691_VREF_4P096_uV_MAX		4500000
 
 #define AD4691_CNV_DUTY_CYCLE_NS		380
+#define AD4691_CNV_HIGH_TIME_NS			430
 
 #define AD4691_SPI_CONFIG_A_REG			0x000
 #define AD4691_SW_RESET				(BIT(7) | BIT(0))
@@ -89,6 +95,12 @@
 #define AD4691_ACC_IN(n)			(0x252 + (3 * (n)))
 #define AD4691_ACC_STS_DATA(n)			(0x283 + (4 * (n)))
 
+/* SPI offload 32-bit word field masks (transmitted MSB first) */
+#define AD4691_OFFLOAD_BITS_PER_WORD		32
+#define AD4691_MSG_ADDR_HI			GENMASK(31, 24)
+#define AD4691_MSG_ADDR_LO			GENMASK(23, 16)
+#define AD4691_MSG_DATA				GENMASK(15, 8)
+
 enum ad4691_ref_ctrl {
 	AD4691_VREF_2P5   = 0,
 	AD4691_VREF_3P0   = 1,
@@ -99,12 +111,22 @@ enum ad4691_ref_ctrl {
 
 struct ad4691_chip_info {
 	const struct iio_chan_spec *channels;
+	const struct iio_chan_spec *manual_channels;
 	const char *name;
 	unsigned int num_channels;
 	unsigned int max_rate;
 };
 
-#define AD4691_CHANNEL(ch)						\
+/*
+ * 16-bit ADC data is stored in 32-bit slots to match the SPI offload DMA
+ * word size (32 bits per transfer). The shift reflects the data position
+ * within the 32-bit word:
+ *   CNV_BURST: RX = [dummy, dummy, data_hi, data_lo] -> shift = 0
+ *   MANUAL:    RX = [data_hi, data_lo, dummy, dummy] -> shift = 16
+ * The triggered-buffer paths store data in the same position for consistency.
+ * Do not "fix" storagebits to 16.
+ */
+#define AD4691_CHANNEL(ch, _shift)					\
 	{								\
 		.type = IIO_VOLTAGE,					\
 		.indexed = 1,						\
@@ -118,40 +140,72 @@ struct ad4691_chip_info {
 		.scan_type = {						\
 			.sign = 'u',					\
 			.realbits = 16,					\
-			.storagebits = 16,				\
-			.shift = 0,					\
+			.storagebits = 32,				\
+			.shift = _shift,				\
 		},							\
 	}
 
 static const struct iio_chan_spec ad4691_channels[] = {
-	AD4691_CHANNEL(0),
-	AD4691_CHANNEL(1),
-	AD4691_CHANNEL(2),
-	AD4691_CHANNEL(3),
-	AD4691_CHANNEL(4),
-	AD4691_CHANNEL(5),
-	AD4691_CHANNEL(6),
-	AD4691_CHANNEL(7),
-	AD4691_CHANNEL(8),
-	AD4691_CHANNEL(9),
-	AD4691_CHANNEL(10),
-	AD4691_CHANNEL(11),
-	AD4691_CHANNEL(12),
-	AD4691_CHANNEL(13),
-	AD4691_CHANNEL(14),
-	AD4691_CHANNEL(15),
+	AD4691_CHANNEL(0, 0),
+	AD4691_CHANNEL(1, 0),
+	AD4691_CHANNEL(2, 0),
+	AD4691_CHANNEL(3, 0),
+	AD4691_CHANNEL(4, 0),
+	AD4691_CHANNEL(5, 0),
+	AD4691_CHANNEL(6, 0),
+	AD4691_CHANNEL(7, 0),
+	AD4691_CHANNEL(8, 0),
+	AD4691_CHANNEL(9, 0),
+	AD4691_CHANNEL(10, 0),
+	AD4691_CHANNEL(11, 0),
+	AD4691_CHANNEL(12, 0),
+	AD4691_CHANNEL(13, 0),
+	AD4691_CHANNEL(14, 0),
+	AD4691_CHANNEL(15, 0),
+	IIO_CHAN_SOFT_TIMESTAMP(16),
+};
+
+static const struct iio_chan_spec ad4691_manual_channels[] = {
+	AD4691_CHANNEL(0, 16),
+	AD4691_CHANNEL(1, 16),
+	AD4691_CHANNEL(2, 16),
+	AD4691_CHANNEL(3, 16),
+	AD4691_CHANNEL(4, 16),
+	AD4691_CHANNEL(5, 16),
+	AD4691_CHANNEL(6, 16),
+	AD4691_CHANNEL(7, 16),
+	AD4691_CHANNEL(8, 16),
+	AD4691_CHANNEL(9, 16),
+	AD4691_CHANNEL(10, 16),
+	AD4691_CHANNEL(11, 16),
+	AD4691_CHANNEL(12, 16),
+	AD4691_CHANNEL(13, 16),
+	AD4691_CHANNEL(14, 16),
+	AD4691_CHANNEL(15, 16),
 	IIO_CHAN_SOFT_TIMESTAMP(16),
 };
 
 static const struct iio_chan_spec ad4693_channels[] = {
-	AD4691_CHANNEL(0),
-	AD4691_CHANNEL(1),
-	AD4691_CHANNEL(2),
-	AD4691_CHANNEL(3),
-	AD4691_CHANNEL(4),
-	AD4691_CHANNEL(5),
-	AD4691_CHANNEL(6),
-	AD4691_CHANNEL(7),
+	AD4691_CHANNEL(0, 0),
+	AD4691_CHANNEL(1, 0),
+	AD4691_CHANNEL(2, 0),
+	AD4691_CHANNEL(3, 0),
+	AD4691_CHANNEL(4, 0),
+	AD4691_CHANNEL(5, 0),
+	AD4691_CHANNEL(6, 0),
+	AD4691_CHANNEL(7, 0),
+	IIO_CHAN_SOFT_TIMESTAMP(16),
+};
+
+static const struct iio_chan_spec ad4693_manual_channels[] = {
+	AD4691_CHANNEL(0, 16),
+	AD4691_CHANNEL(1, 16),
+	AD4691_CHANNEL(2, 16),
+	AD4691_CHANNEL(3, 16),
+	AD4691_CHANNEL(4, 16),
+	AD4691_CHANNEL(5, 16),
+	AD4691_CHANNEL(6, 16),
+	AD4691_CHANNEL(7, 16),
 	IIO_CHAN_SOFT_TIMESTAMP(16),
 };
 
@@ -181,6 +235,7 @@ static const unsigned int ad4691_osc_freqs[] = {
 
 static const struct ad4691_chip_info ad4691_chip_info = {
 	.channels = ad4691_channels,
+	.manual_channels = ad4691_manual_channels,
 	.name = "ad4691",
 	.num_channels = ARRAY_SIZE(ad4691_channels),
 	.max_rate = 500 * HZ_PER_KHZ,
@@ -188,6 +243,7 @@ static const struct ad4691_chip_info ad4691_chip_info = {
 
 static const struct ad4691_chip_info ad4692_chip_info = {
 	.channels = ad4691_channels,
+	.manual_channels = ad4691_manual_channels,
 	.name = "ad4692",
 	.num_channels = ARRAY_SIZE(ad4691_channels),
 	.max_rate = 1 * HZ_PER_MHZ,
@@ -195,6 +251,7 @@ static const struct ad4691_chip_info ad4692_chip_info = {
 
 static const struct ad4691_chip_info ad4693_chip_info = {
 	.channels = ad4693_channels,
+	.manual_channels = ad4693_manual_channels,
 	.name = "ad4693",
 	.num_channels = ARRAY_SIZE(ad4693_channels),
 	.max_rate = 500 * HZ_PER_KHZ,
@@ -202,6 +259,7 @@ static const struct ad4691_chip_info ad4693_chip_info = {
 
 static const struct ad4691_chip_info ad4694_chip_info = {
 	.channels = ad4693_channels,
+	.manual_channels = ad4693_manual_channels,
 	.name = "ad4694",
 	.num_channels = ARRAY_SIZE(ad4693_channels),
 	.max_rate = 1 * HZ_PER_MHZ,
@@ -227,9 +285,9 @@ struct ad4691_state {
 	 */
 	struct mutex			lock;
 	/*
-	 * Per-buffer-enabl ree lifetimesources:
-	 * Manual Mode - a pre-built SPI message that clocks out N+1
-	 *		 transfers in one go.
+	 * Per-buffer-enable lifetime resources (triggered-buffer paths):
+	 * Manual Mode    - a pre-built SPI message that clocks out N+1
+	 *		    transfers in one go.
 	 * CNV Burst Mode - a pre-built SPI message that clocks out 2*N
 	 *		    transfers in one go.
 	 */
@@ -238,9 +296,19 @@ struct ad4691_state {
 	struct spi_transfer		*scan_xfers;
 	__be16				*scan_tx;
 	__be16				*scan_rx;
-	/* Scan buffer: one slot per channel (u16) plus timestamp */
+	/* SPI offload DMA path resources */
+	struct spi_offload		*offload;
+	/* SPI offload trigger - periodic (MANUAL) or DATA_READY (CNV_BURST) */
+	struct spi_offload_trigger	*offload_trigger;
+	u64				offload_trigger_hz;
+	struct spi_message		offload_msg;
+	/* Max 16 channel xfers + 1 state-reset or NOOP */
+	struct spi_transfer		offload_xfer[17];
+	u32				offload_tx_cmd[17];
+	u32				offload_tx_reset;
+	/* Scan buffer: one slot per channel (u32) plus timestamp */
 	struct {
-		u16 vals[16];
+		u32 vals[16];
 		s64 ts __aligned(8);
 	} scan __aligned(IIO_DMA_MINALIGN);
 };
@@ -260,6 +328,46 @@ static int ad4691_gpio_setup(struct ad4691_state *st, unsigned int gp_num)
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
+	return ad4691_gpio_setup(st, (unsigned int)args[0]);
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
 static void ad4691_disable_pwm(void *data)
 {
 	struct pwm_state state = { .enabled = false };
@@ -817,6 +925,206 @@ static const struct iio_buffer_setup_ops ad4691_cnv_burst_buffer_setup_ops = {
 	.postdisable = &ad4691_cnv_burst_buffer_postdisable,
 };
 
+static int ad4691_manual_offload_buffer_postenable(struct iio_dev *indio_dev)
+{
+	struct ad4691_state *st = iio_priv(indio_dev);
+	struct device *dev = regmap_get_device(st->regmap);
+	struct spi_device *spi = to_spi_device(dev);
+	struct spi_offload_trigger_config config = {
+		.type = SPI_OFFLOAD_TRIGGER_PERIODIC,
+	};
+	unsigned int bit, k;
+	int ret;
+
+	ret = ad4691_enter_conversion_mode(st);
+	if (ret)
+		return ret;
+
+	memset(st->offload_xfer, 0, sizeof(st->offload_xfer));
+
+	/*
+	 * N+1 transfers for N channels. Each CS-low period triggers
+	 * a conversion AND returns the previous result (pipelined).
+	 *   TX: [AD4691_ADC_CHAN(n), 0x00, 0x00, 0x00]
+	 *   RX: [data_hi, data_lo, 0x00, 0x00]   (shift=16)
+	 * Transfer 0 RX is garbage; transfers 1..N carry real data.
+	 */
+	k = 0;
+	iio_for_each_active_channel(indio_dev, bit) {
+		st->offload_tx_cmd[k] =
+			cpu_to_be32(FIELD_PREP(AD4691_MSG_ADDR_HI,
+					       AD4691_ADC_CHAN(bit)));
+		st->offload_xfer[k].tx_buf = &st->offload_tx_cmd[k];
+		st->offload_xfer[k].len = sizeof(u32);
+		st->offload_xfer[k].bits_per_word = AD4691_OFFLOAD_BITS_PER_WORD;
+		st->offload_xfer[k].cs_change = 1;
+		st->offload_xfer[k].cs_change_delay.value = AD4691_CNV_HIGH_TIME_NS;
+		st->offload_xfer[k].cs_change_delay.unit = SPI_DELAY_UNIT_NSECS;
+		/* First transfer RX is garbage — skip it. */
+		if (k > 0)
+			st->offload_xfer[k].offload_flags = SPI_OFFLOAD_XFER_RX_STREAM;
+		k++;
+	}
+
+	/* Final NOOP to flush pipeline and capture last channel. */
+	st->offload_tx_cmd[k] =
+		cpu_to_be32(FIELD_PREP(AD4691_MSG_ADDR_HI, AD4691_NOOP));
+	st->offload_xfer[k].tx_buf = &st->offload_tx_cmd[k];
+	st->offload_xfer[k].len = sizeof(u32);
+	st->offload_xfer[k].bits_per_word = AD4691_OFFLOAD_BITS_PER_WORD;
+	st->offload_xfer[k].offload_flags = SPI_OFFLOAD_XFER_RX_STREAM;
+	k++;
+
+	spi_message_init_with_transfers(&st->offload_msg, st->offload_xfer, k);
+	st->offload_msg.offload = st->offload;
+
+	ret = spi_optimize_message(spi, &st->offload_msg);
+	if (ret)
+		goto err_exit_conversion;
+
+	config.periodic.frequency_hz = st->offload_trigger_hz;
+	ret = spi_offload_trigger_enable(st->offload, st->offload_trigger, &config);
+	if (ret)
+		goto err_unoptimize;
+
+	return 0;
+
+err_unoptimize:
+	spi_unoptimize_message(&st->offload_msg);
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
+	spi_unoptimize_message(&st->offload_msg);
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
+	struct device *dev = regmap_get_device(st->regmap);
+	struct spi_device *spi = to_spi_device(dev);
+	struct spi_offload_trigger_config config = {
+		.type = SPI_OFFLOAD_TRIGGER_DATA_READY,
+	};
+	unsigned int n_active = hweight_long(*indio_dev->active_scan_mask);
+	unsigned int bit, k;
+	int ret;
+
+	ret = regmap_write(st->regmap, AD4691_ACC_MASK_REG,
+			   (u16)~(*indio_dev->active_scan_mask));
+	if (ret)
+		return ret;
+
+	ret = regmap_write(st->regmap, AD4691_STD_SEQ_CONFIG,
+			   *indio_dev->active_scan_mask);
+	if (ret)
+		return ret;
+
+	iio_for_each_active_channel(indio_dev, bit) {
+		ret = regmap_write(st->regmap, AD4691_ACC_COUNT_LIMIT(bit),
+				   AD4691_ACC_COUNT_VAL);
+		if (ret)
+			return ret;
+	}
+
+	ret = ad4691_enter_conversion_mode(st);
+	if (ret)
+		return ret;
+
+	memset(st->offload_xfer, 0, sizeof(st->offload_xfer));
+
+	/*
+	 * N transfers to read N AVG_IN registers plus one state-reset
+	 * transfer (no RX) to re-arm DATA_READY.
+	 *   TX: [reg_hi | 0x80, reg_lo, 0x00, 0x00]
+	 *   RX: [0x00, 0x00, data_hi, data_lo]   (shift=0)
+	 */
+	k = 0;
+	iio_for_each_active_channel(indio_dev, bit) {
+		unsigned int reg = AD4691_AVG_IN(bit);
+
+		st->offload_tx_cmd[k] =
+			cpu_to_be32(((reg >> 8 | 0x80) << 24) |
+				    ((reg & 0xFF) << 16));
+		st->offload_xfer[k].tx_buf = &st->offload_tx_cmd[k];
+		st->offload_xfer[k].len = sizeof(u32);
+		st->offload_xfer[k].bits_per_word = AD4691_OFFLOAD_BITS_PER_WORD;
+		st->offload_xfer[k].offload_flags = SPI_OFFLOAD_XFER_RX_STREAM;
+		if (k < n_active - 1)
+			st->offload_xfer[k].cs_change = 1;
+		k++;
+	}
+
+	/* State reset to re-arm DATA_READY for the next scan. */
+	st->offload_tx_reset =
+		cpu_to_be32(((AD4691_STATE_RESET_REG >> 8) << 24) |
+			    ((AD4691_STATE_RESET_REG & 0xFF) << 16) |
+			    (AD4691_STATE_RESET_ALL << 8));
+	st->offload_xfer[k].tx_buf = &st->offload_tx_reset;
+	st->offload_xfer[k].len = sizeof(u32);
+	st->offload_xfer[k].bits_per_word = AD4691_OFFLOAD_BITS_PER_WORD;
+	k++;
+
+	spi_message_init_with_transfers(&st->offload_msg, st->offload_xfer, k);
+	st->offload_msg.offload = st->offload;
+
+	ret = spi_optimize_message(spi, &st->offload_msg);
+	if (ret)
+		goto err_exit_conversion;
+
+	ret = ad4691_sampling_enable(st, true);
+	if (ret)
+		goto err_unoptimize;
+
+	ret = spi_offload_trigger_enable(st->offload, st->offload_trigger, &config);
+	if (ret)
+		goto err_sampling_disable;
+
+	return 0;
+
+err_sampling_disable:
+	ad4691_sampling_enable(st, false);
+err_unoptimize:
+	spi_unoptimize_message(&st->offload_msg);
+err_exit_conversion:
+	ad4691_exit_conversion_mode(st);
+	return ret;
+}
+
+static int ad4691_cnv_burst_offload_buffer_predisable(struct iio_dev *indio_dev)
+{
+	struct ad4691_state *st = iio_priv(indio_dev);
+	int ret;
+
+	spi_offload_trigger_disable(st->offload, st->offload_trigger);
+
+	ret = ad4691_sampling_enable(st, false);
+	if (ret)
+		return ret;
+
+	spi_unoptimize_message(&st->offload_msg);
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
@@ -824,6 +1132,9 @@ static ssize_t sampling_frequency_show(struct device *dev,
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct ad4691_state *st = iio_priv(indio_dev);
 
+	if (st->manual_mode && st->offload)
+		return sysfs_emit(buf, "%llu\n", st->offload_trigger_hz);
+
 	if (st->manual_mode)
 		return -ENODEV;
 
@@ -838,7 +1149,7 @@ static ssize_t sampling_frequency_store(struct device *dev,
 	struct ad4691_state *st = iio_priv(indio_dev);
 	int freq, ret;
 
-	if (st->manual_mode)
+	if (st->manual_mode && !st->offload)
 		return -ENODEV;
 
 	ret = kstrtoint(buf, 10, &freq);
@@ -847,6 +1158,20 @@ static ssize_t sampling_frequency_store(struct device *dev,
 
 	guard(mutex)(&st->lock);
 
+	if (st->manual_mode) {
+		struct spi_offload_trigger_config config = {
+			.type = SPI_OFFLOAD_TRIGGER_PERIODIC,
+			.periodic = { .frequency_hz = freq },
+		};
+
+		ret = spi_offload_trigger_validate(st->offload_trigger, &config);
+		if (ret)
+			return ret;
+
+		st->offload_trigger_hz = config.periodic.frequency_hz;
+		return len;
+	}
+
 	ret = ad4691_set_pwm_freq(st, freq);
 	if (ret)
 		return ret;
@@ -900,7 +1225,7 @@ static irqreturn_t ad4691_trigger_handler(int irq, void *p)
 
 	if (st->manual_mode) {
 		iio_for_each_active_channel(indio_dev, i) {
-			st->scan.vals[i] = be16_to_cpu(st->scan_rx[k + 1]);
+			st->scan.vals[i] = (u32)be16_to_cpu(st->scan_rx[k + 1]) << 16;
 			k++;
 		}
 	} else {
@@ -1088,6 +1413,15 @@ static int ad4691_config(struct ad4691_state *st, u32 max_speed_hz)
 	if (st->manual_mode)
 		return 0;
 
+	/*
+	 * In the offload CNV Burst path the GP pin is supplied by the trigger
+	 * consumer via #trigger-source-cells; gpio_setup is called from
+	 * ad4691_offload_trigger_request() instead. For the non-offload path
+	 * derive the pin from the first interrupt-names entry (e.g. "gp0").
+	 */
+	if (device_property_present(dev, "#trigger-source-cells"))
+		return 0;
+
 	ret = device_property_read_string_array(dev, "interrupt-names",
 						&irq_name, 1);
 	if (ret < 0)
@@ -1158,6 +1492,56 @@ static int ad4691_setup_triggered_buffer(struct iio_dev *indio_dev,
 					       &ad4691_manual_buffer_setup_ops);
 }
 
+static int ad4691_setup_offload(struct iio_dev *indio_dev,
+				struct ad4691_state *st)
+{
+	struct device *dev = regmap_get_device(st->regmap);
+	struct dma_chan *rx_dma;
+	int ret;
+
+	if (st->manual_mode) {
+		st->offload_trigger =
+			devm_spi_offload_trigger_get(dev, st->offload,
+						     SPI_OFFLOAD_TRIGGER_PERIODIC);
+		if (IS_ERR(st->offload_trigger))
+			return dev_err_probe(dev, PTR_ERR(st->offload_trigger),
+					     "Failed to get periodic offload trigger\n");
+
+		st->offload_trigger_hz = st->info->max_rate;
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
+	return devm_iio_dmaengine_buffer_setup_with_handle(dev, indio_dev, rx_dma,
+							   IIO_BUFFER_DIRECTION_IN);
+}
+
 static int ad4691_probe(struct spi_device *spi)
 {
 	struct device *dev = &spi->dev;
@@ -1193,14 +1577,27 @@ static int ad4691_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
+	st->offload = devm_spi_offload_get(dev, spi, &ad4691_offload_config);
+	ret = PTR_ERR_OR_ZERO(st->offload);
+	if (ret == -ENODEV)
+		st->offload = NULL;
+	else if (ret)
+		return dev_err_probe(dev, ret, "Failed to get SPI offload\n");
+
 	indio_dev->name = st->info->name;
 	indio_dev->info = &ad4691_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
-	indio_dev->channels = st->info->channels;
+	if (st->manual_mode)
+		indio_dev->channels = st->info->manual_channels;
+	else
+		indio_dev->channels = st->info->channels;
 	indio_dev->num_channels = st->info->num_channels;
 
-	ret = ad4691_setup_triggered_buffer(indio_dev, st);
+	if (st->offload)
+		ret = ad4691_setup_offload(indio_dev, st);
+	else
+		ret = ad4691_setup_triggered_buffer(indio_dev, st);
 	if (ret)
 		return ret;
 
@@ -1238,3 +1635,4 @@ module_spi_driver(ad4691_driver);
 MODULE_AUTHOR("Radu Sabau <radu.sabau@analog.com>");
 MODULE_DESCRIPTION("Analog Devices AD4691 Family ADC Driver");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("IIO_DMA_BUFFER");

-- 
2.43.0



