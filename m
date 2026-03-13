Return-Path: <linux-pwm+bounces-8248-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QFtnAvfhs2ktcQAAu9opvQ
	(envelope-from <linux-pwm+bounces-8248-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Mar 2026 11:07:51 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 03564281171
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Mar 2026 11:07:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BFE573018E1B
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Mar 2026 10:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D84C438C2DF;
	Fri, 13 Mar 2026 10:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NS+LYcC5"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E842322DB7;
	Fri, 13 Mar 2026 10:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773396461; cv=none; b=QKgzB7SBlwq0xl8upbkNmA8x0UKtYhBCtqrVs2GhyyPZj5gnGIPLq3B7z2BBU5pqvCZdlKme77+NiYNuxJagnLUMdCwp750bslBkt8mAjC/XAfduokLJv3m3zEfVpXhYngPNTivsdgnCxXeTe60gqrfZNVT83Dpe0CvQGpzXgMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773396461; c=relaxed/simple;
	bh=uSxulfCN1GxJSq31fFQ2U7tG6VpF1bHyqGSUNMOt78I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SoeU6LtLSjSyspz6lcR8ggW0IlRFORXt66SrZvMWMWHHfzEm/ZSiSC6oHceH5Vgngb8/sgy1yoRHNWbds4DeVGGlt/+OETjXdQDdd+mW6WmLXNE8gCQQ8Ls31r7AuRslstjPXc5+aBryEf6gOcoNoXOUuVwBU1i0SFLamFb8n6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NS+LYcC5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3F986C2BCAF;
	Fri, 13 Mar 2026 10:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773396461;
	bh=uSxulfCN1GxJSq31fFQ2U7tG6VpF1bHyqGSUNMOt78I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=NS+LYcC5rJWjh7ZXLnA9vG0EPsof5Oh74xIX3BdbBRTOV85u3r/5z5cu52AlMZgdd
	 Mk9azubyhFOhoDGmvTCDraRrACHT3b9Vc2hzgu3zbEhgPg6Qdr4oRTq5WdNnxLvSIs
	 nhC06gFYF8D6YVMOi4hWmvTWxNTnbh7sKw2hMJZ12cNFdF2Fyij8e4RLuEIQ9kHRHO
	 HdMVbhCBtPvVJx8easRn/YpSmwDV0b2hKkS/HF+ikuy8GYKyUPV9MiApRZ0sK3o0O6
	 ORuHoEZcrE0MtaAECg7/4YX0TNUJXHhb06DXzCVboAIKjtWbjpO5qJ0bvIP6Id2n4J
	 M5geK6LCCV0QQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31771105F787;
	Fri, 13 Mar 2026 10:07:41 +0000 (UTC)
From: Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org>
Date: Fri, 13 Mar 2026 12:07:26 +0200
Subject: [PATCH v3 2/4] iio: adc: ad4691: add initial driver for AD4691
 family
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260313-ad4692-multichannel-sar-adc-driver-v3-2-b4d14d81a181@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773396456; l=26116;
 i=radu.sabau@analog.com; s=20260220; h=from:subject:message-id;
 bh=mLXhyMYeH8L+LlUIGaWUpATo+C6wroteetWFKFM6C7A=;
 b=SEONhyN3a6OpEoPPQWGqeoFUIocdEO0jv3OAdrsq6DwP7LddjsZueNtxz4NM+266Rotpb09Ev
 apOzh0QtH9YBz94AZLEwaVOQkkDuC600H2tcLZFtzc0MqkL/54DcC4I
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8248-lists,linux-pwm=lfdr.de,radu.sabau.analog.com];
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
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	HAS_REPLYTO(0.00)[radu.sabau@analog.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,analog.com:email,analog.com:mid,analog.com:replyto,analog.com:url]
X-Rspamd-Queue-Id: 03564281171
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Radu Sabau <radu.sabau@analog.com>

Add support for the Analog Devices AD4691 family of high-speed,
low-power multichannel SAR ADCs: AD4691 (16-ch, 500 kSPS),
AD4692 (16-ch, 1 MSPS), AD4693 (8-ch, 500 kSPS) and
AD4694 (8-ch, 1 MSPS).

The driver implements a custom regmap layer over raw SPI to handle the
device's mixed 1/2/3/4-byte register widths and uses the standard IIO
read_raw/write_raw interface for single-channel reads.

Two buffered operating modes are supported, auto-detected from the
device tree:

    - CNV Clock Mode:  an external PWM drives the CNV pin; the sampling
                       rate is controlled via the PWM period. Requires a
                       reference clock and a DATA_READY interrupt.

    - Manual Mode:     CNV is tied to SPI CS; each SPI transfer triggers
                       a conversion and returns the previous result
                       (pipelined). No external clock or interrupt needed.

In both modes the chip idles in Autonomous Mode so that single-shot
read_raw can use the internal oscillator without disturbing the
hardware configuration.

Signed-off-by: Radu Sabau <radu.sabau@analog.com>
---
 MAINTAINERS              |   1 +
 drivers/iio/adc/Kconfig  |  11 +
 drivers/iio/adc/Makefile |   1 +
 drivers/iio/adc/ad4691.c | 772 +++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 785 insertions(+)

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
index 000000000000..31eafa12bef8
--- /dev/null
+++ b/drivers/iio/adc/ad4691.c
@@ -0,0 +1,772 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2024-2026 Analog Devices, Inc.
+ * Author: Radu Sabau <radu.sabau@analog.com>
+ */
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
+#include <linux/cleanup.h>
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/reset.h>
+#include <linux/interrupt.h>
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
+#define AD4691_VREF_uV_MIN			2400000
+#define AD4691_VREF_uV_MAX			5250000
+
+/*
+ * Default sampling frequency for MANUAL_MODE.
+ * Each sample needs (num_channels + 1) SPI transfers of 24 bits.
+ * The factor 36 = 24 * 3/2 folds in a 50% scheduling margin:
+ *   freq = spi_hz / (24 * 3/2 * (num_channels + 1))
+ *        = spi_hz / (36 * (num_channels + 1))
+ */
+#define AD4691_MANUAL_MODE_STD_FREQ(x, y)	((y) / (36 * ((x) + 1)))
+#define AD4691_BITS_PER_XFER			24
+#define AD4691_CNV_DUTY_CYCLE_NS		380
+#define AD4691_MAX_CONV_PERIOD_US		800
+
+#define AD4691_SEQ_ALL_CHANNELS_OFF		0x00
+#define AD4691_STATE_RESET_ALL			0x01
+
+#define AD4691_REF_CTRL_MASK			GENMASK(4, 2)
+
+#define AD4691_DEVICE_MANUAL			0x14
+#define AD4691_DEVICE_REGISTER			0x10
+#define AD4691_AUTONOMOUS_MODE_VAL		0x02
+
+#define AD4691_NOOP				0x00
+#define AD4691_ADC_CHAN(ch)			((0x10 + (ch)) << 3)
+
+#define AD4691_STATUS_REG			0x014
+#define AD4691_CLAMP_STATUS1_REG		0x01A
+#define AD4691_CLAMP_STATUS2_REG		0x01B
+#define AD4691_DEVICE_SETUP			0x020
+#define AD4691_REF_CTRL				0x021
+#define AD4691_OSC_FREQ_REG			0x023
+#define AD4691_STD_SEQ_CONFIG			0x025
+#define AD4691_SPARE_CONTROL			0x02A
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
+enum ad4691_adc_mode {
+	AD4691_CNV_CLOCK_MODE,
+	AD4691_MANUAL_MODE,
+};
+
+enum ad4691_gpio_mode {
+	AD4691_ADC_BUSY   = 4,
+	AD4691_DATA_READY = 6,
+};
+
+enum ad4691_ref_ctrl {
+	AD4691_VREF_2P5   = 0,
+	AD4691_VREF_3P0   = 1,
+	AD4691_VREF_3P3   = 2,
+	AD4691_VREF_4P096 = 3,
+	AD4691_VREF_5P0   = 4,
+};
+
+struct ad4691_chip_info {
+	const struct iio_chan_spec *channels;
+	const struct iio_chan_spec *manual_channels;
+	const char *name;
+	unsigned int num_channels;
+	unsigned int max_rate;
+};
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
+static const struct ad4691_chip_info ad4691_ad4691 = {
+	.channels = ad4691_channels,
+	.manual_channels = ad4691_manual_channels,
+	.name = "ad4691",
+	.num_channels = ARRAY_SIZE(ad4691_channels),
+	.max_rate = 500 * HZ_PER_KHZ,
+};
+
+static const struct ad4691_chip_info ad4691_ad4692 = {
+	.channels = ad4691_channels,
+	.manual_channels = ad4691_manual_channels,
+	.name = "ad4692",
+	.num_channels = ARRAY_SIZE(ad4691_channels),
+	.max_rate = 1 * HZ_PER_MHZ,
+};
+
+static const struct ad4691_chip_info ad4691_ad4693 = {
+	.channels = ad4693_channels,
+	.manual_channels = ad4693_manual_channels,
+	.name = "ad4693",
+	.num_channels = ARRAY_SIZE(ad4693_channels),
+	.max_rate = 500 * HZ_PER_KHZ,
+};
+
+static const struct ad4691_chip_info ad4691_ad4694 = {
+	.channels = ad4693_channels,
+	.manual_channels = ad4693_manual_channels,
+	.name = "ad4694",
+	.num_channels = ARRAY_SIZE(ad4693_channels),
+	.max_rate = 1 * HZ_PER_MHZ,
+};
+
+struct ad4691_state {
+	const struct ad4691_chip_info	*chip;
+	struct regmap			*regmap;
+
+	unsigned long			ref_clk_rate;
+	struct pwm_device		*conv_trigger;
+
+	enum ad4691_adc_mode		adc_mode;
+
+	int				vref_uV;
+	u64				cnv_period;
+	ktime_t				sampling_period;
+	/*
+	 * Synchronize access to members of the driver state, and ensure
+	 * atomicity of consecutive SPI operations.
+	 */
+	struct mutex			lock;
+};
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
+static int ad4691_regulator_get(struct ad4691_state *st)
+{
+	struct device *dev = regmap_get_device(st->regmap);
+	int ret;
+
+	ret = devm_regulator_get_enable(dev, "vio");
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to get and enable VIO\n");
+
+	st->vref_uV = devm_regulator_get_enable_read_voltage(dev, "vref");
+	if (st->vref_uV == -ENODEV)
+		st->vref_uV = devm_regulator_get_enable_read_voltage(dev, "vrefin");
+	if (st->vref_uV < 0)
+		return dev_err_probe(dev, st->vref_uV,
+				     "Failed to get reference supply\n");
+
+	if (st->vref_uV < AD4691_VREF_uV_MIN || st->vref_uV > AD4691_VREF_uV_MAX)
+		return dev_err_probe(dev, -EINVAL, "vref(%d) must be under [%u %u]\n",
+				     st->vref_uV, AD4691_VREF_uV_MIN, AD4691_VREF_uV_MAX);
+
+	return 0;
+}
+
+static int ad4691_reg_read(void *context, unsigned int reg, unsigned int *val)
+{
+	struct ad4691_state *st = context;
+	struct spi_device *spi = to_spi_device(regmap_get_device(st->regmap));
+	u8 tx[2], rx[4];
+	int ret;
+
+	put_unaligned_be16(0x8000 | reg, tx);
+
+	switch (reg) {
+	case 0 ... AD4691_OSC_FREQ_REG:
+	case AD4691_SPARE_CONTROL ... AD4691_ACC_SAT_OVR_REG(15):
+		ret = spi_write_then_read(spi, tx, 2, rx, 1);
+		if (ret)
+			return ret;
+		*val = rx[0];
+		return 0;
+	case AD4691_STD_SEQ_CONFIG:
+	case AD4691_AVG_IN(0) ... AD4691_AVG_IN(15):
+		ret = spi_write_then_read(spi, tx, 2, rx, 2);
+		if (ret)
+			return ret;
+		*val = get_unaligned_be16(rx);
+		return 0;
+	case AD4691_AVG_STS_IN(0) ... AD4691_AVG_STS_IN(15):
+	case AD4691_ACC_IN(0) ... AD4691_ACC_IN(15):
+		ret = spi_write_then_read(spi, tx, 2, rx, 3);
+		if (ret)
+			return ret;
+		*val = get_unaligned_be24(rx);
+		return 0;
+	case AD4691_ACC_STS_DATA(0) ... AD4691_ACC_STS_DATA(15):
+		ret = spi_write_then_read(spi, tx, 2, rx, 4);
+		if (ret)
+			return ret;
+		*val = get_unaligned_be32(rx);
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ad4691_reg_write(void *context, unsigned int reg, unsigned int val)
+{
+	struct ad4691_state *st = context;
+	struct spi_device *spi = to_spi_device(regmap_get_device(st->regmap));
+	u8 tx[4];
+
+	put_unaligned_be16(reg, tx);
+
+	switch (reg) {
+	case 0 ... AD4691_OSC_FREQ_REG:
+	case AD4691_SPARE_CONTROL ... AD4691_GPIO_MODE2_REG:
+		if (val > 0xFF)
+			return -EINVAL;
+		tx[2] = val;
+		return spi_write_then_read(spi, tx, 3, NULL, 0);
+	case AD4691_STD_SEQ_CONFIG:
+		if (val > 0xFFFF)
+			return -EINVAL;
+		put_unaligned_be16(val, &tx[2]);
+		return spi_write_then_read(spi, tx, 4, NULL, 0);
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
+	.cache_type = REGCACHE_MAPLE,
+};
+
+static int ad4691_get_sampling_freq(struct ad4691_state *st)
+{
+	if (st->adc_mode == AD4691_MANUAL_MODE)
+		return DIV_ROUND_CLOSEST(NSEC_PER_SEC,
+					 ktime_to_ns(st->sampling_period));
+
+	return DIV_ROUND_CLOSEST(NSEC_PER_SEC,
+				 pwm_get_period(st->conv_trigger));
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
+static int ad4691_pwm_get(struct ad4691_state *st)
+{
+	struct device *dev = regmap_get_device(st->regmap);
+	struct clk *ref_clk;
+	int ret;
+
+	ref_clk = devm_clk_get_enabled(dev, NULL);
+	if (IS_ERR(ref_clk))
+		return dev_err_probe(dev, PTR_ERR(ref_clk),
+				     "Failed to get ref clock\n");
+
+	st->ref_clk_rate = clk_get_rate(ref_clk);
+
+	st->conv_trigger = devm_pwm_get(dev, "cnv");
+	if (IS_ERR(st->conv_trigger))
+		return dev_err_probe(dev, PTR_ERR(st->conv_trigger),
+				     "Failed to get cnv pwm\n");
+
+	ret = devm_add_action_or_reset(dev, ad4691_disable_pwm,
+				       st->conv_trigger);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Failed to register PWM disable action\n");
+
+	return __ad4691_set_sampling_freq(st, st->chip->max_rate);
+}
+
+static int ad4691_set_sampling_freq(struct iio_dev *indio_dev, unsigned int freq)
+{
+	struct ad4691_state *st = iio_priv(indio_dev);
+
+	IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
+
+	if (IIO_DEV_ACQUIRE_FAILED(claim))
+		return -EBUSY;
+
+	guard(mutex)(&st->lock);
+
+	if (st->adc_mode == AD4691_MANUAL_MODE) {
+		if (!freq || freq > st->chip->max_rate)
+			return -ERANGE;
+
+		st->sampling_period = ns_to_ktime(DIV_ROUND_CLOSEST(NSEC_PER_SEC,
+									 freq));
+		return 0;
+	}
+
+	if (!st->conv_trigger)
+		return -ENODEV;
+
+	if (!freq || freq > st->chip->max_rate)
+		return -ERANGE;
+
+	return __ad4691_set_sampling_freq(st, freq);
+}
+
+static int ad4691_single_shot_read(struct iio_dev *indio_dev,
+				   struct iio_chan_spec const *chan, int *val)
+{
+	struct ad4691_state *st = iio_priv(indio_dev);
+	u16 mask = ~BIT(chan->channel);
+	u32 acc_mask[2] = { mask & 0xFF, mask >> 8 };
+	unsigned int reg_val;
+	int ret;
+
+	/*
+	 * Always use AUTONOMOUS mode for single-shot reads, regardless
+	 * of the buffer mode (CNV_CLOCK or MANUAL). The chip is kept
+	 * in AUTONOMOUS mode during idle; enter_conversion_mode() and
+	 * exit_conversion_mode() handle the switch for buffer operation.
+	 */
+	ret = regmap_write(st->regmap, AD4691_STATE_RESET_REG,
+			   AD4691_STATE_RESET_ALL);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(st->regmap, AD4691_STD_SEQ_CONFIG,
+			   BIT(chan->channel));
+	if (ret)
+		return ret;
+
+	ret = regmap_bulk_write(st->regmap, AD4691_ACC_MASK1_REG, acc_mask, 2);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(st->regmap, AD4691_OSC_EN_REG, 1);
+	if (ret)
+		return ret;
+
+	/*
+	 * Wait for conversion to complete using a timed delay.
+	 * A single read needs 2 internal oscillator periods.
+	 * OSC_FREQ_REG is never modified by the driver, so the
+	 * oscillator runs at reset-default speed. Use chip->max_rate
+	 * as a conservative proxy: it is always <= the OSC frequency,
+	 * so the computed delay is >= the actual conversion time.
+	 */
+	unsigned long conv_us = DIV_ROUND_UP(2 * USEC_PER_SEC,
+					     st->chip->max_rate);
+	fsleep(conv_us);
+
+	ret = regmap_write(st->regmap, AD4691_OSC_EN_REG, 0);
+	if (ret)
+		return ret;
+
+	ret = regmap_read(st->regmap, AD4691_AVG_IN(chan->channel), &reg_val);
+	if (ret)
+		return ret;
+
+	*val = reg_val;
+	regmap_write(st->regmap, AD4691_STATE_RESET_REG, AD4691_STATE_RESET_ALL);
+
+	return IIO_VAL_INT;
+}
+
+static int ad4691_read_raw(struct iio_dev *indio_dev,
+			   struct iio_chan_spec const *chan, int *val,
+			   int *val2, long info)
+{
+	struct ad4691_state *st = iio_priv(indio_dev);
+
+	switch (info) {
+	case IIO_CHAN_INFO_RAW: {
+		IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
+
+		if (IIO_DEV_ACQUIRE_FAILED(claim))
+			return -EBUSY;
+
+		return ad4691_single_shot_read(indio_dev, chan, val);
+	}
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*val = ad4691_get_sampling_freq(st);
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		*val = st->vref_uV / 1000;
+		*val2 = chan->scan_type.realbits;
+		return IIO_VAL_FRACTIONAL_LOG2;
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
+
+	guard(mutex)(&st->lock);
+
+	if (readval)
+		return regmap_read(st->regmap, reg, readval);
+
+	return regmap_write(st->regmap, reg, writeval);
+}
+
+static const struct iio_info ad4691_info = {
+	.read_raw = &ad4691_read_raw,
+	.write_raw = &ad4691_write_raw,
+	.debugfs_reg_access = &ad4691_reg_access,
+};
+
+static int ad4691_reset(struct ad4691_state *st)
+{
+	struct device *dev = regmap_get_device(st->regmap);
+	struct reset_control *rst;
+
+	rst = devm_reset_control_get_optional_exclusive(dev, NULL);
+	if (IS_ERR(rst))
+		return dev_err_probe(dev, PTR_ERR(rst),
+				     "Failed to get reset\n");
+
+	if (!rst)
+		return 0;
+
+	reset_control_assert(rst);
+	/* Reset delay required. See datasheet Table 5. */
+	fsleep(300);
+	reset_control_deassert(rst);
+
+	return 0;
+}
+
+static int ad4691_config(struct ad4691_state *st)
+{
+	struct device *dev = regmap_get_device(st->regmap);
+	enum ad4691_ref_ctrl ref_val;
+	unsigned int reg_val;
+	int ret;
+
+	/*
+	 * Determine buffer conversion mode from DT: if a PWM is provided it
+	 * drives the CNV pin (CNV_CLOCK_MODE); otherwise CNV is tied to CS
+	 * and each SPI transfer triggers a conversion (MANUAL_MODE).
+	 * Both modes idle in AUTONOMOUS mode so that read_raw can use the
+	 * internal oscillator without disturbing the hardware configuration.
+	 */
+	if (device_property_present(dev, "pwms")) {
+		st->adc_mode = AD4691_CNV_CLOCK_MODE;
+		ret = ad4691_pwm_get(st);
+		if (ret)
+			return ret;
+	} else {
+		st->adc_mode = AD4691_MANUAL_MODE;
+		st->sampling_period = ns_to_ktime(DIV_ROUND_CLOSEST_ULL(NSEC_PER_SEC,
+			AD4691_MANUAL_MODE_STD_FREQ(st->chip->num_channels,
+				to_spi_device(dev)->max_speed_hz)));
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
+	switch (st->vref_uV) {
+	case AD4691_VREF_uV_MIN ... 2750000:
+		ref_val = AD4691_VREF_2P5;
+		break;
+	case 2750001 ... 3250000:
+		ref_val = AD4691_VREF_3P0;
+		break;
+	case 3250001 ... 3750000:
+		ref_val = AD4691_VREF_3P3;
+		break;
+	case 3750001 ... 4500000:
+		ref_val = AD4691_VREF_4P096;
+		break;
+	case 4500001 ... AD4691_VREF_uV_MAX:
+		ref_val = AD4691_VREF_5P0;
+		break;
+	default:
+		return dev_err_probe(dev, -EINVAL,
+				     "Unsupported vref voltage: %d uV\n",
+				     st->vref_uV);
+	}
+
+	ret = regmap_write(st->regmap, AD4691_REF_CTRL,
+			   FIELD_PREP(AD4691_REF_CTRL_MASK, ref_val));
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to write REF_CTRL\n");
+
+	/* Both CNV_CLOCK and MANUAL devices start in AUTONOMOUS mode. */
+	ret = regmap_write(st->regmap, AD4691_ADC_SETUP, AD4691_AUTONOMOUS_MODE_VAL);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to write ADC_SETUP\n");
+
+	return regmap_write(st->regmap, AD4691_GPIO_MODE1_REG, AD4691_ADC_BUSY);
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
+	ret = devm_mutex_init(dev, &st->lock);
+	if (ret)
+		return ret;
+
+	st->regmap = devm_regmap_init(dev, NULL, st, &ad4691_regmap_config);
+	if (IS_ERR(st->regmap))
+		return dev_err_probe(dev, PTR_ERR(st->regmap),
+				     "Failed to initialize regmap\n");
+
+	st->chip = spi_get_device_match_data(spi);
+
+	ret = ad4691_regulator_get(st);
+	if (ret)
+		return ret;
+
+	ret = ad4691_reset(st);
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
+	indio_dev->channels = (st->adc_mode == AD4691_MANUAL_MODE) ?
+		st->chip->manual_channels : st->chip->channels;
+	indio_dev->num_channels = st->chip->num_channels;
+
+	return devm_iio_device_register(dev, indio_dev);
+}
+
+static const struct of_device_id ad4691_of_match[] = {
+	{ .compatible = "adi,ad4691", .data = &ad4691_ad4691 },
+	{ .compatible = "adi,ad4692", .data = &ad4691_ad4692 },
+	{ .compatible = "adi,ad4693", .data = &ad4691_ad4693 },
+	{ .compatible = "adi,ad4694", .data = &ad4691_ad4694 },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ad4691_of_match);
+
+static const struct spi_device_id ad4691_id[] = {
+	{ "ad4691", (kernel_ulong_t)&ad4691_ad4691 },
+	{ "ad4692", (kernel_ulong_t)&ad4691_ad4692 },
+	{ "ad4693", (kernel_ulong_t)&ad4691_ad4693 },
+	{ "ad4694", (kernel_ulong_t)&ad4691_ad4694 },
+	{ }
+};
+MODULE_DEVICE_TABLE(spi, ad4691_id);
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



