Return-Path: <linux-pwm+bounces-8187-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sKMGN7d2qWl77wAAu9opvQ
	(envelope-from <linux-pwm+bounces-8187-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 05 Mar 2026 13:27:35 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 50B67211A0B
	for <lists+linux-pwm@lfdr.de>; Thu, 05 Mar 2026 13:27:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6DBFA3070EC4
	for <lists+linux-pwm@lfdr.de>; Thu,  5 Mar 2026 12:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7B0639D6F1;
	Thu,  5 Mar 2026 12:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eK8LIZp1"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959AF37416A;
	Thu,  5 Mar 2026 12:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772713415; cv=none; b=P1uZMHCO15XsDkvrpHMySXL6iPdy/R1CJ1vTJIwN24lNA+peRleRh5QgOQBk+G40qONVy4AUaRq2oeTQb1pUQa2zkMLYL/BWJ0Ml8xCftW/vSZMH5yw6hl7M4glG5ME/iQjsOOxf6xMULDcvaz8ZblQNbj6DYZo+ZBs+GANUxOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772713415; c=relaxed/simple;
	bh=kE0lYUjfo/svatyXGTuKOdjX1JqgCHw31DUrJcjnvOc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G9gDjtkqssz6ue3Dl4ItV49yCqepVPFAhWnxS3wSa7e5qYiYu/Aa6O3dwwJQMSVWylH8bIudcPSg3RXieoe/E13eJhaYJ5t9CDFWvSsetrJmULxZMm+3AytbFcocOd9GKBzbneYeLdzW2Owuog8K2oSbEOYqABptrN/zpYz+qy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eK8LIZp1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 55AFEC2BCB4;
	Thu,  5 Mar 2026 12:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772713415;
	bh=kE0lYUjfo/svatyXGTuKOdjX1JqgCHw31DUrJcjnvOc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=eK8LIZp16YLNnkCGon9yUEU7Q0PhE+34aacGVV2rt89o8SoqrP23TFuRCed9lAH7w
	 x9qFxpEEgBKYvqCSj29/Lu/CawbSpWPdyvRuP2Pf/L4CsUlO9NXu1NR14BfdwMLRW6
	 3QeJaXa9baTevnTQZH+goL5rwemPVbGAQn9DctoyE4UeYhfuHauAEqHWwgXIVVdSNa
	 XfiuzWzP4GZc4DD6iTTc1Fsi9BcGoKo/xhNY9zvEOw0uNGTuZ4U3dZV9LRp1SCoNg5
	 1COVZvlqeqHDv4eI7JdlqVU7OpijRVVJxfGwXtpOvdaZYV1S9qsd4ks9w9Rb52/C9S
	 3WuTI5GN1RppA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4978BF30955;
	Thu,  5 Mar 2026 12:23:35 +0000 (UTC)
From: Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org>
Date: Thu, 05 Mar 2026 14:23:28 +0200
Subject: [PATCH 2/4] iio: adc: ad4691: add initial driver for AD4691 family
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260305-ad4692-multichannel-sar-adc-driver-v1-2-336229a8dcc7@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772713413; l=37439;
 i=radu.sabau@analog.com; s=20260220; h=from:subject:message-id;
 bh=TCWKolk7iMtcppe+0vro0WVACPHBWNzsay83Ne7LSFM=;
 b=60+4pm7LNhsC1r8PuSu8OanhZBih6oZbQYsJe4ozbI62o0aCPsF7eclVjM/8r7iKJJ2PyeMhB
 EfTnfhbM9yRB16e5FZtXteaxpSXTv4xJzOs1o6UioTH+8ZZGH/iKFnI
X-Developer-Key: i=radu.sabau@analog.com; a=ed25519;
 pk=lDPQHgn9jTdt0vo58Na9lLxLaE2mb330if71Cn+EvFU=
X-Endpoint-Received: by B4 Relay for radu.sabau@analog.com/20260220 with
 auth_id=642
X-Original-From: Radu Sabau <radu.sabau@analog.com>
Reply-To: radu.sabau@analog.com
X-Rspamd-Queue-Id: 50B67211A0B
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
	TAGGED_FROM(0.00)[bounces-8187-lists,linux-pwm=lfdr.de,radu.sabau.analog.com];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,analog.com:replyto,analog.com:email,analog.com:url,analog.com:mid]
X-Rspamd-Action: no action

From: Radu Sabau <radu.sabau@analog.com>

Add support for the Analog Devices AD4691 family of high-speed,
low-power multichannel SAR ADCs: AD4691 (16-ch, 500 kSPS),
AD4692 (16-ch, 1 MSPS), AD4693 (8-ch, 500 kSPS) and
AD4694 (8-ch, 1 MSPS).

The driver implements a custom regmap layer over raw SPI to handle the
device's mixed 1/2/3/4-byte register widths and uses the standard IIO
read_raw/write_raw interface for single-channel reads.

Five operating modes are supported:
  - CNV Clock Mode:   external PWM drives CNV; sampling rate set via
                      PWM period
  - CNV Burst Mode:   PWM triggers burst cycles; internal oscillator
                      drives conversions within each burst
  - Autonomous Mode:  internal oscillator drives conversions;
                      started/stopped via register write
  - SPI Burst Mode:   like Autonomous but optimised for SPI burst reads
  - Manual Mode:      CNV tied to SPI CS; pipelined protocol;

Signed-off-by: Radu Sabau <radu.sabau@analog.com>
---
 MAINTAINERS              |    1 +
 drivers/iio/adc/Kconfig  |   11 +
 drivers/iio/adc/Makefile |    1 +
 drivers/iio/adc/ad4691.c | 1196 ++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 1209 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9994d107d88d..5325f7d3b7f4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1490,6 +1490,7 @@ L:	linux-iio@vger.kernel.org
 S:	Supported
 W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/adc/adi,ad4691.yaml
+F:	drivers/iio/adc/ad4691.c
 F:	include/dt-bindings/iio/adc/adi,ad4691.h
 
 ANALOG DEVICES INC AD4695 DRIVER
diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 60038ae8dfc4..3685a03aa8dc 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -139,6 +139,17 @@ config AD4170_4
 	  To compile this driver as a module, choose M here: the module will be
 	  called ad4170-4.
 
+config AD4691
+	tristate "Analog Devices AD4691 Family ADC Driver"
+	depends on SPI
+	select REGMAP
+	help
+	  Say yes here to build support for Analog Devices AD4691 Family MuxSAR
+	  SPI analog to digital converters (ADC).
+
+	  To compile this driver as a module, choose M here: the module will be
+	  called ad4691.
+
 config AD4695
 	tristate "Analog Device AD4695 ADC Driver"
 	depends on SPI
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index c76550415ff1..4ac1ea09d773 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -16,6 +16,7 @@ obj-$(CONFIG_AD4080) += ad4080.o
 obj-$(CONFIG_AD4130) += ad4130.o
 obj-$(CONFIG_AD4134) += ad4134.o
 obj-$(CONFIG_AD4170_4) += ad4170-4.o
+obj-$(CONFIG_AD4691) += ad4691.o
 obj-$(CONFIG_AD4695) += ad4695.o
 obj-$(CONFIG_AD4851) += ad4851.o
 obj-$(CONFIG_AD7091R) += ad7091r-base.o
diff --git a/drivers/iio/adc/ad4691.c b/drivers/iio/adc/ad4691.c
new file mode 100644
index 000000000000..dee8bc312d44
--- /dev/null
+++ b/drivers/iio/adc/ad4691.c
@@ -0,0 +1,1196 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2024-2026 Analog Devices, Inc.
+ * Author: Radu Sabau <radu.sabau@analog.com>
+ */
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/gpio/consumer.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/math.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/property.h>
+#include <linux/pwm.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+#include <linux/spi/spi.h>
+#include <linux/util_macros.h>
+#include <linux/units.h>
+#include <linux/unaligned.h>
+
+#include <linux/iio/iio.h>
+
+#include <dt-bindings/iio/adc/adi,ad4691.h>
+
+#define AD4691_NUM_REGULATORS			1
+#define AD4691_MAX_ADC_MODE			4
+
+#define AD4691_VREF_MIN				2400000
+#define AD4691_VREF_MAX				5250000
+
+/*
+ * Default sampling frequency for MANUAL_MODE.
+ * Each sample needs (num_channels + 1) SPI transfers of 24 bits.
+ * The factor 36 = 24 * 3/2 folds in a 50% scheduling margin:
+ *   freq = spi_hz / (24 * 3/2 * (num_channels + 1))
+ *        = spi_hz / (36 * (num_channels + 1))
+ */
+#define AD4691_MANUAL_MODE_STD_FREQ(x, y)	((y) / (36 * ((x) + 1)))
+#define AD4691_CNV_DUTY_CYCLE_NS		380
+#define AD4691_MAX_CONV_PERIOD_US		800
+
+#define AD4691_SEQ_ALL_CHANNELS_OFF		0x00
+#define AD4691_STATE_RESET_ALL			0x01
+
+#define AD4691_REF_CTRL_MASK			GENMASK(4, 2)
+
+#define AD4691_DEVICE_MANUAL			0x14
+
+#define AD4691_NOOP				0x00
+#define AD4691_ADC_CHAN(ch)			((0x10 + (ch)) << 3)
+
+#define AD4691_PRODUCT_ID_LSB_REG		0x04
+
+#define AD4691_STATUS_REG			0x14
+#define AD4691_CLAMP_STATUS1_REG		0x1A
+#define AD4691_CLAMP_STATUS2_REG		0x1B
+#define AD4691_DEVICE_SETUP			0x20
+#define AD4691_REF_CTRL				0x21
+#define AD4691_OSC_FREQ_REG			0x23
+#define AD4691_STD_SEQ_CONFIG			0x25
+#define AD4691_SPARE_CONTROL			0x2A
+
+#define AD4691_OSC_EN_REG			0x180
+#define AD4691_STATE_RESET_REG			0x181
+#define AD4691_ADC_SETUP			0x182
+#define AD4691_ACC_MASK1_REG			0x184
+#define AD4691_ACC_MASK2_REG			0x185
+#define AD4691_ACC_COUNT_LIMIT(n)		(0x186 + (n))
+#define AD4691_ACC_COUNT_VAL			0x3F
+#define AD4691_GPIO_MODE1_REG			0x196
+#define AD4691_GPIO_MODE2_REG			0x197
+#define AD4691_GPIO_READ			0x1A0
+#define AD4691_ACC_STATUS_FULL1_REG		0x1B0
+#define AD4691_ACC_STATUS_FULL2_REG		0x1B1
+#define AD4691_ACC_STATUS_OVERRUN1_REG		0x1B2
+#define AD4691_ACC_STATUS_OVERRUN2_REG		0x1B3
+#define AD4691_ACC_STATUS_SAT1_REG		0x1B4
+#define AD4691_ACC_STATUS_SAT2_REG		0x1BE
+#define AD4691_ACC_SAT_OVR_REG(n)		(0x1C0 + (n))
+#define AD4691_AVG_IN(n)			(0x201 + (2 * (n)))
+#define AD4691_AVG_STS_IN(n)			(0x222 + (3 * (n)))
+#define AD4691_ACC_IN(n)			(0x252 + (3 * (n)))
+#define AD4691_ACC_STS_DATA(n)			(0x283 + (4 * (n)))
+
+#define AD4691_CHANNEL(chan, index, real_bits, storage_bits, _shift)	\
+	{								\
+		.type = IIO_VOLTAGE,					\
+		.indexed = 1,						\
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ)	\
+					   | BIT(IIO_CHAN_INFO_SCALE),	\
+		.channel = chan,					\
+		.scan_index = index,					\
+		.scan_type = {						\
+			.sign = 'u',					\
+			.realbits = real_bits,				\
+			.storagebits = storage_bits,			\
+			.shift = _shift,				\
+		},							\
+	}
+
+enum ad4691_ids {
+	AD4691_ID_AD4691,
+	AD4691_ID_AD4692,
+	AD4691_ID_AD4693,
+	AD4691_ID_AD4694,
+};
+
+enum ad4691_adc_mode {
+	AD4691_CNV_CLOCK_MODE,
+	AD4691_CNV_BURST_MODE,
+	AD4691_AUTONOMOUS_MODE,
+	AD4691_SPI_BURST_MODE,
+	AD4691_MANUAL_MODE,
+};
+
+enum ad4691_gpio_mode {
+	AD4691_HIGH_Z,
+	AD4691_DIGITAL_OUTPUT_LOW,
+	AD4691_DIGITAL_OUTPUT_HIGH,
+	AD4691_DIGITAL_INPUT,
+	AD4691_ADC_BUSY,
+	AD4691_SEQ_DONE,
+	AD4691_DATA_READY,
+	AD4691_ACC_OVR_ERROR,
+	AD4691_ACC_SAT_ERROR,
+};
+
+enum ad4691_int_osc_freq {
+	AD4691_OSC_1MHZ = 0,
+	AD4691_OSC_500KHZ,
+	AD4691_OSC_400KHZ,
+	AD4691_OSC_250KHZ,
+	AD4691_OSC_200KHZ,
+	AD4691_OSC_167KHZ,
+	AD4691_OSC_133KHZ,
+	AD4691_OSC_125KHZ,
+	AD4691_OSC_100KHZ,
+	AD4691_OSC_50KHZ,
+	AD4691_OSC_25KHZ,
+	AD4691_OSC_12P5KHZ,
+	AD4691_OSC_10KHZ,
+	AD4691_OSC_5KHZ,
+	AD4691_OSC_2P5KHZ,
+	AD4691_OSC_1P25KHZ,
+};
+
+enum ad4691_ref_ctrl {
+	AD4691_VREF_2P5 = 0,
+	AD4691_VREF_3P0,
+	AD4691_VREF_3P3,
+	AD4691_VREF_4P096,
+	AD4691_VREF_5P0,
+};
+
+static int ad4691_int_osc_val[] = {
+	[AD4691_OSC_1MHZ] = 1000000,
+	[AD4691_OSC_500KHZ] = 500000,
+	[AD4691_OSC_400KHZ] = 400000,
+	[AD4691_OSC_250KHZ] = 250000,
+	[AD4691_OSC_200KHZ] = 200000,
+	[AD4691_OSC_167KHZ] = 167000,
+	[AD4691_OSC_133KHZ] = 133000,
+	[AD4691_OSC_125KHZ] = 125000,
+	[AD4691_OSC_100KHZ] = 100000,
+	[AD4691_OSC_50KHZ] = 50000,
+	[AD4691_OSC_25KHZ] = 25000,
+	[AD4691_OSC_12P5KHZ] = 12500,
+	[AD4691_OSC_10KHZ] = 10000,
+	[AD4691_OSC_5KHZ] = 5000,
+	[AD4691_OSC_2P5KHZ] = 2500,
+	[AD4691_OSC_1P25KHZ] = 1250,
+};
+
+struct ad4691_chip_info {
+	const struct iio_chan_spec *channels;
+	const char *name;
+	u8 product_id;
+	int num_channels;
+	int max_rate;
+};
+
+static const struct iio_chan_spec ad4691_channels[] = {
+	AD4691_CHANNEL(0, 0, 16, 32, 0),
+	AD4691_CHANNEL(1, 1, 16, 32, 0),
+	AD4691_CHANNEL(2, 2, 16, 32, 0),
+	AD4691_CHANNEL(3, 3, 16, 32, 0),
+	AD4691_CHANNEL(4, 4, 16, 32, 0),
+	AD4691_CHANNEL(5, 5, 16, 32, 0),
+	AD4691_CHANNEL(6, 6, 16, 32, 0),
+	AD4691_CHANNEL(7, 7, 16, 32, 0),
+	AD4691_CHANNEL(8, 8, 16, 32, 0),
+	AD4691_CHANNEL(9, 9, 16, 32, 0),
+	AD4691_CHANNEL(10, 10, 16, 32, 0),
+	AD4691_CHANNEL(11, 11, 16, 32, 0),
+	AD4691_CHANNEL(12, 12, 16, 32, 0),
+	AD4691_CHANNEL(13, 13, 16, 32, 0),
+	AD4691_CHANNEL(14, 14, 16, 32, 0),
+	AD4691_CHANNEL(15, 15, 16, 32, 0)
+};
+
+static const struct iio_chan_spec ad4693_channels[] = {
+	AD4691_CHANNEL(0, 0, 16, 32, 0),
+	AD4691_CHANNEL(1, 1, 16, 32, 0),
+	AD4691_CHANNEL(2, 2, 16, 32, 0),
+	AD4691_CHANNEL(3, 3, 16, 32, 0),
+	AD4691_CHANNEL(4, 4, 16, 32, 0),
+	AD4691_CHANNEL(5, 5, 16, 32, 0),
+	AD4691_CHANNEL(6, 6, 16, 32, 0),
+	AD4691_CHANNEL(7, 7, 16, 32, 0)
+};
+
+static const struct iio_chan_spec ad4691_manual_channels[] = {
+	AD4691_CHANNEL(0, 0, 16, 24, 8),
+	AD4691_CHANNEL(1, 1, 16, 24, 8),
+	AD4691_CHANNEL(2, 2, 16, 24, 8),
+	AD4691_CHANNEL(3, 3, 16, 24, 8),
+	AD4691_CHANNEL(4, 4, 16, 24, 8),
+	AD4691_CHANNEL(5, 5, 16, 24, 8),
+	AD4691_CHANNEL(6, 6, 16, 24, 8),
+	AD4691_CHANNEL(7, 7, 16, 24, 8),
+	AD4691_CHANNEL(8, 8, 16, 24, 8),
+	AD4691_CHANNEL(9, 9, 16, 24, 8),
+	AD4691_CHANNEL(10, 10, 16, 24, 8),
+	AD4691_CHANNEL(11, 11, 16, 24, 8),
+	AD4691_CHANNEL(12, 12, 16, 24, 8),
+	AD4691_CHANNEL(13, 13, 16, 24, 8),
+	AD4691_CHANNEL(14, 14, 16, 24, 8),
+	AD4691_CHANNEL(15, 15, 16, 24, 8)
+};
+
+static const struct iio_chan_spec ad4693_manual_channels[] = {
+	AD4691_CHANNEL(0, 0, 16, 24, 8),
+	AD4691_CHANNEL(1, 1, 16, 24, 8),
+	AD4691_CHANNEL(2, 2, 16, 24, 8),
+	AD4691_CHANNEL(3, 3, 16, 24, 8),
+	AD4691_CHANNEL(4, 4, 16, 24, 8),
+	AD4691_CHANNEL(5, 5, 16, 24, 8),
+	AD4691_CHANNEL(6, 6, 16, 24, 8),
+	AD4691_CHANNEL(7, 7, 16, 24, 8)
+};
+
+static const struct ad4691_chip_info ad4691_chips[] = {
+	[AD4691_ID_AD4691] = {
+		.channels = ad4691_channels,
+		.name = "ad4691",
+		.product_id = 0x11,
+		.num_channels = ARRAY_SIZE(ad4691_channels),
+		.max_rate = 500000,
+	},
+	[AD4691_ID_AD4692] = {
+		.channels = ad4691_channels,
+		.name = "ad4692",
+		.product_id = 0x12,
+		.num_channels = ARRAY_SIZE(ad4691_channels),
+		.max_rate = 1000000,
+	},
+	[AD4691_ID_AD4693] = {
+		.channels = ad4693_channels,
+		.name = "ad4693",
+		.product_id = 0x13,
+		.num_channels = ARRAY_SIZE(ad4693_channels),
+		.max_rate = 500000,
+	},
+	[AD4691_ID_AD4694] = {
+		.channels = ad4693_channels,
+		.name = "ad4694",
+		.product_id = 0x14,
+		.num_channels = ARRAY_SIZE(ad4693_channels),
+		.max_rate = 1000000,
+	},
+};
+
+struct ad4691_state {
+	const struct ad4691_chip_info	*chip;
+	struct spi_device		*spi;
+	struct regmap			*regmap;
+
+	unsigned long			ref_clk_rate;
+	struct pwm_device		*conv_trigger;
+
+	struct regulator_bulk_data	regulators[AD4691_NUM_REGULATORS];
+
+	enum ad4691_adc_mode		adc_mode;
+
+	int				vref;
+	u64				cnv_period;
+	/*
+	 * Synchronize access to members of the driver state, and ensure
+	 * atomicity of consecutive SPI operations.
+	 */
+	struct mutex			lock;
+
+	ktime_t				sampling_period;
+
+	/* DMA (thus cache coherency maintenance) may require the
+	 * transfer buffers to live in their own cache lines.
+	 * Make the buffer large enough for one 24 bit sample and one 64 bit
+	 * aligned 64 bit timestamp.
+	 */
+	unsigned char rx_data[ALIGN(3, sizeof(s64)) + sizeof(s64)]	__aligned(IIO_DMA_MINALIGN);
+	unsigned char tx_data[ALIGN(3, sizeof(s64)) + sizeof(s64)]	__aligned(IIO_DMA_MINALIGN);
+};
+
+static void ad4691_disable_regulators(void *data)
+{
+	struct ad4691_state *st = data;
+
+	regulator_bulk_disable(AD4691_NUM_REGULATORS, st->regulators);
+}
+
+static void ad4691_disable_regulator(void *data)
+{
+	struct regulator *reg = data;
+
+	regulator_disable(reg);
+}
+
+static void ad4691_disable_pwm(void *data)
+{
+	struct pwm_device *pwm = data;
+	struct pwm_state state;
+
+	pwm_get_state(pwm, &state);
+	state.enabled = false;
+	pwm_apply_might_sleep(pwm, &state);
+}
+
+static int ad4691_regulators_get(struct ad4691_state *st)
+{
+	struct device *dev = &st->spi->dev;
+	struct regulator *ref;
+	int ret;
+
+	st->regulators[0].supply = "vio";
+
+	ret = devm_regulator_bulk_get(dev, AD4691_NUM_REGULATORS,
+				      st->regulators);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to get VIO regulator\n");
+
+	ret = regulator_bulk_enable(AD4691_NUM_REGULATORS, st->regulators);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to enable regulators\n");
+
+	ret = devm_add_action_or_reset(dev, ad4691_disable_regulators, st);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Failed to register regulator disable action\n");
+
+	ref = devm_regulator_get_optional(dev, "vref");
+	if (IS_ERR(ref)) {
+		if (PTR_ERR(ref) != -ENODEV)
+			return dev_err_probe(dev, PTR_ERR(ref),
+					     "Failed to get vref regulator");
+
+		/* Internal REFIN must be used if optional REF isn't used. */
+		ref = devm_regulator_get(dev, "vrefin");
+		if (IS_ERR(ref))
+			return dev_err_probe(dev, PTR_ERR(ref),
+					     "Failed to get vrefin regulator");
+	}
+
+	ret = regulator_enable(ref);
+	if (ret) {
+		dev_err_probe(dev, ret, "Failed to enable specified ref supply\n");
+		return ret;
+	}
+
+	ret = devm_add_action_or_reset(dev, ad4691_disable_regulator, ref);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Failed to register ref disable action\n");
+
+	st->vref = regulator_get_voltage(ref);
+	if (st->vref < AD4691_VREF_MIN || st->vref > AD4691_VREF_MAX)
+		return dev_err_probe(dev, -EINVAL, "vref(%d) must be under [%u %u]\n",
+				     st->vref, AD4691_VREF_MIN, AD4691_VREF_MAX);
+
+	return 0;
+}
+
+static int ad4691_reg_read(void *context, unsigned int reg, unsigned int *val)
+{
+	struct ad4691_state *st = context;
+	unsigned char buf[6];
+	int ret;
+
+	buf[0] = (reg >> 8) | 0x80;
+	buf[1] = reg & 0xFF;
+
+	switch (reg) {
+	case 0 ... AD4691_OSC_FREQ_REG:
+	case AD4691_SPARE_CONTROL ... AD4691_ACC_SAT_OVR_REG(15):
+		ret = spi_write_then_read(st->spi, &buf[0], 2, &buf[2], 1);
+		if (!ret)
+			*val = buf[2];
+		break;
+	case AD4691_STD_SEQ_CONFIG:
+	case AD4691_AVG_IN(0) ... AD4691_AVG_IN(15):
+		ret = spi_write_then_read(st->spi, &buf[0], 2, &buf[2], 2);
+		if (!ret)
+			*val = get_unaligned_be16(&buf[2]);
+		break;
+	case AD4691_AVG_STS_IN(0) ... AD4691_AVG_STS_IN(15):
+		ret = spi_write_then_read(st->spi, &buf[0], 2, &buf[2], 3);
+		if (!ret)
+			*val = get_unaligned_be24(&buf[2]);
+		break;
+	case AD4691_ACC_IN(0) ... AD4691_ACC_IN(15):
+		ret = spi_write_then_read(st->spi, &buf[0], 2, &buf[2], 3);
+		if (!ret)
+			*val = get_unaligned_be24(&buf[2]);
+		break;
+	case AD4691_ACC_STS_DATA(0) ... AD4691_ACC_STS_DATA(15):
+		ret = spi_write_then_read(st->spi, &buf[0], 2, &buf[2], 4);
+		if (!ret)
+			*val = get_unaligned_be32(&buf[2]);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return ret;
+}
+
+static int ad4691_reg_write(void *context, unsigned int reg, unsigned int val)
+{
+	struct ad4691_state *st = context;
+	unsigned char buf[4];
+
+	buf[0] = (reg >> 8);
+	buf[1] = reg & 0xFF;
+
+	switch (reg) {
+	case 0 ... AD4691_OSC_FREQ_REG:
+	case AD4691_SPARE_CONTROL ... AD4691_GPIO_MODE2_REG:
+		if (val > 0xFF)
+			return -EINVAL;
+		buf[2] = val;
+
+		return spi_write(st->spi, buf, 3);
+	case AD4691_STD_SEQ_CONFIG:
+		if (val > 0xFFFF)
+			return -EINVAL;
+		put_unaligned_be16(val, &buf[2]);
+
+		return spi_write(st->spi, buf, 4);
+	default:
+		return -EINVAL;
+	}
+}
+
+static bool ad4691_volatile_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case AD4691_STATUS_REG:
+	case AD4691_CLAMP_STATUS1_REG:
+	case AD4691_CLAMP_STATUS2_REG:
+	case AD4691_GPIO_READ:
+	case AD4691_ACC_STATUS_FULL1_REG ... AD4691_ACC_STATUS_SAT2_REG:
+	case AD4691_ACC_SAT_OVR_REG(0) ... AD4691_ACC_SAT_OVR_REG(15):
+	case AD4691_AVG_IN(0) ... AD4691_AVG_IN(15):
+	case AD4691_AVG_STS_IN(0) ... AD4691_AVG_STS_IN(15):
+	case AD4691_ACC_IN(0) ... AD4691_ACC_IN(15):
+	case AD4691_ACC_STS_DATA(0) ... AD4691_ACC_STS_DATA(15):
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool ad4691_readable_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case 0 ... AD4691_OSC_FREQ_REG:
+	case AD4691_SPARE_CONTROL ... AD4691_ACC_SAT_OVR_REG(15):
+	case AD4691_STD_SEQ_CONFIG:
+	case AD4691_AVG_IN(0) ... AD4691_AVG_IN(15):
+	case AD4691_AVG_STS_IN(0) ... AD4691_AVG_STS_IN(15):
+	case AD4691_ACC_IN(0) ... AD4691_ACC_IN(15):
+	case AD4691_ACC_STS_DATA(0) ... AD4691_ACC_STS_DATA(15):
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool ad4691_writeable_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case 0 ... AD4691_OSC_FREQ_REG:
+	case AD4691_STD_SEQ_CONFIG:
+	case AD4691_SPARE_CONTROL ... AD4691_GPIO_MODE2_REG:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static const struct regmap_config ad4691_regmap_config = {
+	.reg_bits = 16,
+	.val_bits = 32,
+	.reg_read = ad4691_reg_read,
+	.reg_write = ad4691_reg_write,
+	.volatile_reg = ad4691_volatile_reg,
+	.readable_reg = ad4691_readable_reg,
+	.writeable_reg = ad4691_writeable_reg,
+	.max_register = AD4691_ACC_STS_DATA(15),
+	.cache_type = REGCACHE_RBTREE,
+};
+
+static int ad4691_transfer(struct ad4691_state *st, int command,
+			   unsigned int *val)
+{
+	struct spi_transfer xfer = {
+		.tx_buf = st->tx_data,
+		.rx_buf = st->rx_data,
+		.len = 3,
+	};
+	int ret;
+
+	memcpy(st->tx_data, &command, 3);
+
+	ret = spi_sync_transfer(st->spi, &xfer, 1);
+	if (ret)
+		return ret;
+
+	*val = get_unaligned_be24(st->rx_data);
+
+	return 0;
+}
+
+static int ad4691_get_sampling_freq(struct ad4691_state *st)
+{
+	unsigned int val;
+	int ret;
+
+	switch (st->adc_mode) {
+	case AD4691_MANUAL_MODE:
+		return DIV_ROUND_CLOSEST_ULL(NSEC_PER_SEC,
+					     ktime_to_ns(st->sampling_period));
+	case AD4691_CNV_CLOCK_MODE:
+		return DIV_ROUND_CLOSEST_ULL(NSEC_PER_SEC,
+					     pwm_get_period(st->conv_trigger));
+	case AD4691_CNV_BURST_MODE:
+	case AD4691_AUTONOMOUS_MODE:
+	case AD4691_SPI_BURST_MODE:
+		ret = regmap_read(st->regmap, AD4691_OSC_FREQ_REG, &val);
+		if (ret)
+			return ret;
+
+		return ad4691_int_osc_val[val];
+	default:
+		return -EINVAL;
+	}
+}
+
+static int __ad4691_set_sampling_freq(struct ad4691_state *st, int freq)
+{
+	unsigned long long target, ref_clk_period_ns;
+	struct pwm_state cnv_state;
+
+	pwm_init_state(st->conv_trigger, &cnv_state);
+
+	freq = clamp(freq, 1, st->chip->max_rate);
+	target = DIV_ROUND_CLOSEST_ULL(st->ref_clk_rate, freq);
+	ref_clk_period_ns = DIV_ROUND_CLOSEST_ULL(NANO, st->ref_clk_rate);
+	st->cnv_period = ref_clk_period_ns * target;
+	cnv_state.period = ref_clk_period_ns * target;
+	cnv_state.duty_cycle = AD4691_CNV_DUTY_CYCLE_NS;
+	cnv_state.enabled = false;
+
+	return pwm_apply_might_sleep(st->conv_trigger, &cnv_state);
+}
+
+/*
+ * ad4691_cnv_burst_period_ns - Compute the CNV_BURST_MODE PWM period.
+ * @st: Driver state.
+ * @n_active: Number of active channels.
+ *
+ * The period must cover the full conversion time tOSC*(n_active+1) plus
+ * the SPI transfer time for reading the accumulator results and issuing
+ * STATE_RESET, with a 50% margin on the SPI portion to absorb jitter.
+ *
+ * Return: Period in nanoseconds.
+ */
+static u64 ad4691_cnv_burst_period_ns(struct ad4691_state *st,
+				      int n_active)
+{
+	unsigned int osc_idx = AD4691_OSC_1MHZ;
+	u64 osc_freq, conv_time_ns, spi_bits, spi_time_ns;
+
+	regmap_read(st->regmap, AD4691_OSC_FREQ_REG, &osc_idx);
+	if (osc_idx >= ARRAY_SIZE(ad4691_int_osc_val))
+		osc_idx = AD4691_OSC_1MHZ;
+
+	osc_freq = ad4691_int_osc_val[osc_idx];
+	conv_time_ns = div64_u64((u64)(n_active + 1) * NSEC_PER_SEC, osc_freq);
+
+	spi_bits = (u64)n_active * 32 + 24;
+	spi_time_ns = div64_u64(spi_bits * NSEC_PER_SEC, st->spi->max_speed_hz);
+
+	/* 50% margin on SPI time absorbs OS scheduling jitter. */
+	return conv_time_ns + spi_time_ns * 3 / 2;
+}
+
+static int ad4691_pwm_get(struct spi_device *spi, struct ad4691_state *st)
+{
+	struct clk *ref_clk;
+	int ret;
+
+	ref_clk = devm_clk_get_enabled(&spi->dev, "ref_clk");
+	if (IS_ERR(ref_clk))
+		return dev_err_probe(&spi->dev, PTR_ERR(ref_clk),
+				     "Failed to get ref_clk\n");
+
+	st->ref_clk_rate = clk_get_rate(ref_clk);
+
+	st->conv_trigger = devm_pwm_get(&spi->dev, "cnv");
+	if (IS_ERR(st->conv_trigger)) {
+		return dev_err_probe(&spi->dev, PTR_ERR(st->conv_trigger),
+				     "Failed to get cnv pwm\n");
+	}
+
+	ret = devm_add_action_or_reset(&spi->dev, ad4691_disable_pwm,
+				       st->conv_trigger);
+	if (ret)
+		return dev_err_probe(&spi->dev, ret,
+				     "Failed to register PWM disable action\n");
+
+	switch (st->adc_mode) {
+	case AD4691_CNV_CLOCK_MODE:
+		return __ad4691_set_sampling_freq(st, st->chip->max_rate);
+	case AD4691_CNV_BURST_MODE: {
+		/*
+		 * In CNV Burst Mode, the internal oscillator drives per-channel
+		 * conversions. The PWM triggers each burst cycle; its period
+		 * must cover the full conversion time tOSC*(n+1) plus SPI
+		 * transfer time. Use worst-case channel count here; the period
+		 * is refined at buffer enable time when the active count is known.
+		 */
+		u64 period_ns = ad4691_cnv_burst_period_ns(st, st->chip->num_channels);
+		int pwm_freq = (int)max(1ULL, div64_u64(NSEC_PER_SEC, period_ns));
+
+		return __ad4691_set_sampling_freq(st, pwm_freq);
+	}
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static int ad4691_set_sampling_freq(struct iio_dev *indio_dev, unsigned int freq)
+{
+	struct ad4691_state *st = iio_priv(indio_dev);
+	int ret, i;
+
+	if (!iio_device_claim_direct(indio_dev))
+		return -EBUSY;
+
+	mutex_lock(&st->lock);
+	switch (st->adc_mode) {
+	case AD4691_MANUAL_MODE:
+		if (!freq || freq > st->chip->max_rate) {
+			ret = -EINVAL;
+			goto exit;
+		}
+
+		st->sampling_period = ns_to_ktime(DIV_ROUND_CLOSEST_ULL
+			(NSEC_PER_SEC, freq));
+		ret = 0;
+		goto exit;
+	case AD4691_CNV_CLOCK_MODE:
+		if (!st->conv_trigger) {
+			ret = -ENODEV;
+			goto exit;
+		}
+
+		if (!freq || freq > st->chip->max_rate) {
+			ret = -EINVAL;
+			goto exit;
+		}
+
+		ret = __ad4691_set_sampling_freq(st, freq);
+		break;
+	case AD4691_CNV_BURST_MODE: {
+		u64 period_ns;
+		int pwm_freq;
+
+		i = find_closest_descending(freq, ad4691_int_osc_val, 16);
+		ret = regmap_write(st->regmap, AD4691_OSC_FREQ_REG, i);
+		if (ret)
+			goto exit;
+
+		/*
+		 * Compute the worst-case PWM period using the maximum channel
+		 * count. The exact period is refined at buffer enable time when
+		 * the active channel count is known.
+		 */
+		period_ns = ad4691_cnv_burst_period_ns(st, st->chip->num_channels);
+		pwm_freq = (int)max(1ULL, div64_u64(NSEC_PER_SEC, period_ns));
+		ret = __ad4691_set_sampling_freq(st, pwm_freq);
+
+		break;
+	}
+	case AD4691_AUTONOMOUS_MODE:
+	case AD4691_SPI_BURST_MODE:
+		i = find_closest_descending(freq, ad4691_int_osc_val, 16);
+		ret = regmap_write(st->regmap, AD4691_OSC_FREQ_REG, i);
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+exit:
+	mutex_unlock(&st->lock);
+	iio_device_release_direct(indio_dev);
+	return ret;
+}
+
+static int ad4691_sampling_enable(struct ad4691_state *st, bool enable)
+{
+	struct pwm_state conv_state = { };
+
+	switch (st->adc_mode) {
+	case AD4691_CNV_CLOCK_MODE:
+	case AD4691_CNV_BURST_MODE:
+		conv_state.period = st->cnv_period;
+		conv_state.duty_cycle = AD4691_CNV_DUTY_CYCLE_NS;
+		conv_state.polarity = PWM_POLARITY_NORMAL;
+		conv_state.enabled = enable;
+
+		return pwm_apply_might_sleep(st->conv_trigger, &conv_state);
+	case AD4691_AUTONOMOUS_MODE:
+		return regmap_write(st->regmap, AD4691_OSC_EN_REG, enable);
+	case AD4691_SPI_BURST_MODE:
+		if (enable)
+			return regmap_write(st->regmap, AD4691_OSC_EN_REG, enable);
+
+		/*
+		 * SPI Burst Mode is self-terminating: the oscillator stops
+		 * automatically after the configured number of conversions.
+		 * No explicit disable write is needed.
+		 */
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
+/*
+ * Return the time in microseconds for a single-channel conversion driven by
+ * the internal oscillator. A single read requires (n_active + 1) = 2 oscillator
+ * periods (n_active = 1).
+ */
+static unsigned long ad4691_osc_single_conv_us(struct ad4691_state *st)
+{
+	unsigned int osc_idx = AD4691_OSC_1MHZ;
+
+	regmap_read(st->regmap, AD4691_OSC_FREQ_REG, &osc_idx);
+	if (osc_idx >= ARRAY_SIZE(ad4691_int_osc_val))
+		osc_idx = AD4691_OSC_1MHZ;
+
+	return DIV_ROUND_UP(2UL * USEC_PER_SEC, ad4691_int_osc_val[osc_idx]);
+}
+
+static int ad4691_read_raw(struct iio_dev *indio_dev,
+			   struct iio_chan_spec const *chan, int *val,
+			   int *val2, long info)
+{
+	struct ad4691_state *st = iio_priv(indio_dev);
+	unsigned int reg_val;
+	int ret;
+
+	switch (info) {
+	case IIO_CHAN_INFO_RAW:
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
+
+		switch (st->adc_mode) {
+		case AD4691_CNV_CLOCK_MODE:
+		case AD4691_CNV_BURST_MODE:
+		case AD4691_AUTONOMOUS_MODE:
+		case AD4691_SPI_BURST_MODE:
+			ret = regmap_write(st->regmap, AD4691_STATE_RESET_REG,
+					   AD4691_STATE_RESET_ALL);
+			if (ret)
+				goto done;
+
+			ret = regmap_write(st->regmap, AD4691_STD_SEQ_CONFIG, BIT(chan->channel));
+			if (ret)
+				goto done;
+
+			if (chan->channel < 8) {
+				ret = regmap_write(st->regmap, AD4691_ACC_MASK1_REG,
+						   ~BIT(chan->channel) & 0xFF);
+				if (ret)
+					goto done;
+				ret = regmap_write(st->regmap, AD4691_ACC_MASK2_REG,
+						   0xFF);
+			} else {
+				ret = regmap_write(st->regmap, AD4691_ACC_MASK1_REG,
+						   0xFF);
+				if (ret)
+					goto done;
+				ret = regmap_write(st->regmap, AD4691_ACC_MASK2_REG,
+						   ~BIT(chan->channel - 8) & 0xFF);
+			}
+
+			if (ret)
+				goto done;
+
+			ret = ad4691_sampling_enable(st, true);
+			if (ret)
+				goto done;
+
+			/*
+			 * Wait for conversion to complete using a timed delay.
+			 * CNV_CLOCK_MODE conversion time is bounded by
+			 * AD4691_MAX_CONV_PERIOD_US. All other modes are driven by
+			 * the internal oscillator; two oscillator periods cover a
+			 * single-channel read (n_active + 1 = 2).
+			 */
+			if (st->adc_mode == AD4691_CNV_CLOCK_MODE) {
+				usleep_range(AD4691_MAX_CONV_PERIOD_US,
+					     AD4691_MAX_CONV_PERIOD_US + 100);
+			} else {
+				unsigned long conv_us = ad4691_osc_single_conv_us(st);
+
+				usleep_range(conv_us, conv_us + conv_us / 4 + 1);
+			}
+
+			ret = ad4691_sampling_enable(st, false);
+			if (ret)
+				goto done;
+
+			ret = regmap_read(st->regmap,
+					  AD4691_AVG_IN(chan->channel),
+					  &reg_val);
+
+			*val = reg_val;
+			regmap_write(st->regmap, AD4691_STATE_RESET_REG,
+					AD4691_STATE_RESET_ALL);
+
+			break;
+		case AD4691_MANUAL_MODE:
+			ret = ad4691_transfer(st, AD4691_ADC_CHAN(chan->channel), val);
+			if (ret)
+				goto done;
+
+			ret = ad4691_transfer(st, AD4691_NOOP, val);
+			if (ret)
+				goto done;
+
+			/* Extract ADC data from the 24-bit SPI frame */
+			*val = *val >> 8;
+			break;
+		default:
+			ret = -EINVAL;
+			goto done;
+		}
+
+done:
+		iio_device_release_direct(indio_dev);
+
+		if (ret)
+			return ret;
+
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*val = ad4691_get_sampling_freq(st);
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		*val = st->vref / 1000;
+		*val2 = chan->scan_type.realbits;
+		return IIO_VAL_FRACTIONAL_LOG2;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ad4691_read_avail(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     const int **vals, int *type, int *length,
+			     long info)
+{
+	struct ad4691_state *st = iio_priv(indio_dev);
+
+	switch (info) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		switch (st->adc_mode) {
+		case AD4691_CNV_CLOCK_MODE:
+		case AD4691_MANUAL_MODE:
+			return -EOPNOTSUPP;
+		case AD4691_CNV_BURST_MODE:
+		case AD4691_AUTONOMOUS_MODE:
+		case AD4691_SPI_BURST_MODE:
+			*vals = ad4691_int_osc_val;
+			*length = ARRAY_SIZE(ad4691_int_osc_val);
+			*type = IIO_VAL_INT;
+
+			return IIO_AVAIL_LIST;
+		default:
+			return -EINVAL;
+		}
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ad4691_write_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan,
+			    int val, int val2, long mask)
+{
+	switch (mask) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		return ad4691_set_sampling_freq(indio_dev, val);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ad4691_reg_access(struct iio_dev *indio_dev, unsigned int reg,
+			     unsigned int writeval, unsigned int *readval)
+{
+	struct ad4691_state *st = iio_priv(indio_dev);
+	int ret;
+
+	if (st->adc_mode == AD4691_MANUAL_MODE)
+		return -EOPNOTSUPP;
+
+	mutex_lock(&st->lock);
+	if (readval) {
+		ret = regmap_read(st->regmap, reg, readval);
+		goto mutex_unlock;
+	}
+
+	ret = regmap_write(st->regmap, reg, writeval);
+
+mutex_unlock:
+	mutex_unlock(&st->lock);
+	return ret;
+}
+
+static const struct iio_info ad4691_info = {
+	.read_raw = &ad4691_read_raw,
+	.read_avail = &ad4691_read_avail,
+	.write_raw = &ad4691_write_raw,
+	.debugfs_reg_access = &ad4691_reg_access,
+};
+
+static const struct spi_device_id ad4691_id[] = {
+	{ "ad4692", (kernel_ulong_t)&ad4691_chips[AD4691_ID_AD4692] },
+	{ "ad4691", (kernel_ulong_t)&ad4691_chips[AD4691_ID_AD4691] },
+	{ "ad4694", (kernel_ulong_t)&ad4691_chips[AD4691_ID_AD4694] },
+	{ "ad4693", (kernel_ulong_t)&ad4691_chips[AD4691_ID_AD4693] },
+	{}
+};
+MODULE_DEVICE_TABLE(spi, ad4691_id);
+
+static int ad4691_gpio_setup(struct ad4691_state *st)
+{
+	struct device *dev = &st->spi->dev;
+	struct gpio_desc *reset;
+
+	reset = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(reset))
+		return dev_err_probe(dev, PTR_ERR(reset),
+				     "Failed to get reset GPIO\n");
+
+	/* Reset delay required. See datasheet Table 5. */
+	fsleep(300);
+	gpiod_set_value(reset, 0);
+
+	return 0;
+}
+
+static int ad4691_config(struct ad4691_state *st)
+{
+	struct device *dev = &st->spi->dev;
+	unsigned int reg_val;
+	u32 mode;
+	int ret;
+
+	ret = regmap_read(st->regmap, AD4691_PRODUCT_ID_LSB_REG, &reg_val);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to read product ID\n");
+
+	if (reg_val != st->chip->product_id)
+		return dev_err_probe(dev, -ENODEV,
+				     "Product ID mismatch: expected 0x%02x, got 0x%02x\n",
+				     st->chip->product_id, reg_val);
+
+	ret = device_property_read_u32(dev, "adi,spi-mode", &mode);
+	if (ret)
+		return dev_err_probe(dev, -EINVAL, "Could not find SPI mode\n");
+
+	if (mode > AD4691_MAX_ADC_MODE)
+		return dev_err_probe(dev, -EINVAL, "Invalid SPI mode(%u)\n", mode);
+
+	st->adc_mode = mode;
+
+	/*
+	 * CNV_CLOCK_MODE and CNV_BURST_MODE require a PWM for conversion timing.
+	 * MANUAL_MODE doesn't need PWM - CS is tied to CNV, so each SPI
+	 * transfer automatically triggers a conversion.
+	 */
+	if (st->adc_mode == AD4691_CNV_CLOCK_MODE ||
+	    st->adc_mode == AD4691_CNV_BURST_MODE) {
+		if (device_property_present(dev, "pwms")) {
+			ret = ad4691_pwm_get(st->spi, st);
+			if (ret)
+				return ret;
+		} else {
+			return dev_err_probe(dev, -ENODEV,
+					     "CNV modes require 'pwms' property\n");
+		}
+	}
+
+	/* Perform a state reset on the channels at start-up. */
+	ret = regmap_write(st->regmap, AD4691_STATE_RESET_REG,
+			   AD4691_STATE_RESET_ALL);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to write state reset\n");
+
+	/* Clear STATUS register by reading from the STATUS register. */
+	ret = regmap_read(st->regmap, AD4691_STATUS_REG, &reg_val);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to read status register\n");
+
+	switch (st->vref) {
+	case AD4691_VREF_MIN ... 2750000:
+		ret = regmap_write(st->regmap, AD4691_REF_CTRL,
+				       FIELD_PREP(AD4691_REF_CTRL_MASK,
+						  AD4691_VREF_2P5));
+		break;
+	case 2750001 ... 3250000:
+		ret = regmap_write(st->regmap, AD4691_REF_CTRL,
+				       FIELD_PREP(AD4691_REF_CTRL_MASK,
+						  AD4691_VREF_3P0));
+		break;
+	case 3250001 ... 3750000:
+		ret = regmap_write(st->regmap, AD4691_REF_CTRL,
+				       FIELD_PREP(AD4691_REF_CTRL_MASK,
+						  AD4691_VREF_3P3));
+		break;
+	case 3750001 ... 4500000:
+		ret = regmap_write(st->regmap, AD4691_REF_CTRL,
+				       FIELD_PREP(AD4691_REF_CTRL_MASK,
+						  AD4691_VREF_4P096));
+		break;
+	case 4500001 ... AD4691_VREF_MAX:
+		ret = regmap_write(st->regmap, AD4691_REF_CTRL,
+				       FIELD_PREP(AD4691_REF_CTRL_MASK,
+						  AD4691_VREF_5P0));
+		break;
+	default:
+		return dev_err_probe(dev, -EINVAL,
+				     "Unsupported vref voltage: %d uV\n",
+				     st->vref);
+	}
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to write REF_CTRL\n");
+
+	switch (st->adc_mode) {
+	case AD4691_CNV_CLOCK_MODE:
+	case AD4691_CNV_BURST_MODE:
+	case AD4691_AUTONOMOUS_MODE:
+	case AD4691_SPI_BURST_MODE:
+		/*
+		 * The adi,spi-mode DT property values 0-3 map directly to the
+		 * ADC_SETUP register encoding for these four modes.
+		 */
+		ret = regmap_write(st->regmap, AD4691_ADC_SETUP, mode);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "Failed to write ADC_SETUP\n");
+
+		if (st->adc_mode == AD4691_AUTONOMOUS_MODE)
+			/* Configure GP0 as ADC_BUSY for trigger */
+			return regmap_write(st->regmap, AD4691_GPIO_MODE1_REG,
+					    AD4691_ADC_BUSY);
+		else
+			/* Configure GP0 as DATA_READY for trigger */
+			return regmap_write(st->regmap, AD4691_GPIO_MODE1_REG,
+					    AD4691_DATA_READY);
+	case AD4691_MANUAL_MODE:
+		/* GP0 as ADC_BUSY; conversion completion is polled via CS in MANUAL_MODE. */
+		ret = regmap_write(st->regmap, AD4691_GPIO_MODE1_REG,
+				   AD4691_ADC_BUSY);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "Failed to write GPIO_MODE1\n");
+
+		return regmap_write(st->regmap, AD4691_DEVICE_SETUP,
+				    AD4691_DEVICE_MANUAL);
+	default:
+		return -EINVAL;
+	}
+}
+
+static void ad4691_setup_channels(struct iio_dev *indio_dev,
+				  struct ad4691_state *st)
+{
+	if (st->adc_mode == AD4691_MANUAL_MODE) {
+		if (st->chip->num_channels == 8)
+			indio_dev->channels = ad4693_manual_channels;
+		else
+			indio_dev->channels = ad4691_manual_channels;
+	} else {
+		indio_dev->channels = st->chip->channels;
+	}
+
+	indio_dev->num_channels = st->chip->num_channels;
+}
+
+static int ad4691_probe(struct spi_device *spi)
+{
+	struct device *dev = &spi->dev;
+	struct iio_dev *indio_dev;
+	struct ad4691_state *st;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	st = iio_priv(indio_dev);
+	mutex_init(&st->lock);
+
+	st->spi = spi;
+	spi_set_drvdata(spi, indio_dev);
+
+	st->regmap = devm_regmap_init(dev, NULL, st, &ad4691_regmap_config);
+	if (IS_ERR(st->regmap))
+		return dev_err_probe(dev, PTR_ERR(st->regmap),
+				     "Failed to initialize regmap\n");
+
+	st->chip = spi_get_device_match_data(spi);
+	if (!st->chip) {
+		st->chip = (void *)spi_get_device_id(spi)->driver_data;
+		if (!st->chip)
+			return dev_err_probe(dev, -ENODEV,
+					     "Could not find chip info data\n");
+	}
+
+	ret = ad4691_regulators_get(st);
+	if (ret)
+		return ret;
+
+	ret = ad4691_gpio_setup(st);
+	if (ret)
+		return ret;
+
+	ret = ad4691_config(st);
+	if (ret)
+		return ret;
+
+	indio_dev->name = st->chip->name;
+	indio_dev->info = &ad4691_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	ad4691_setup_channels(indio_dev, st);
+
+	return devm_iio_device_register(dev, indio_dev);
+}
+
+static const struct of_device_id ad4691_of_match[] = {
+	{ .compatible = "adi,ad4692", .data = &ad4691_chips[AD4691_ID_AD4692] },
+	{ .compatible = "adi,ad4691", .data = &ad4691_chips[AD4691_ID_AD4691] },
+	{ .compatible = "adi,ad4694", .data = &ad4691_chips[AD4691_ID_AD4694] },
+	{ .compatible = "adi,ad4693", .data = &ad4691_chips[AD4691_ID_AD4693] },
+	{},
+};
+MODULE_DEVICE_TABLE(of, ad4691_of_match);
+
+static struct spi_driver ad4691_driver = {
+	.driver = {
+		.name = "ad4691",
+		.of_match_table = ad4691_of_match,
+	},
+	.probe = ad4691_probe,
+	.id_table = ad4691_id,
+};
+module_spi_driver(ad4691_driver);
+
+MODULE_AUTHOR("Radu Sabau <radu.sabau@analog.com>");
+MODULE_DESCRIPTION("Analog Devices AD4691 Family ADC Driver");
+MODULE_LICENSE("GPL");

-- 
2.43.0



