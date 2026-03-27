Return-Path: <linux-pwm+bounces-8387-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OIkQBnlnxmnnJgUAu9opvQ
	(envelope-from <linux-pwm+bounces-8387-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 27 Mar 2026 12:18:17 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BFEB63433C1
	for <lists+linux-pwm@lfdr.de>; Fri, 27 Mar 2026 12:18:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 265C730B8CD7
	for <lists+linux-pwm@lfdr.de>; Fri, 27 Mar 2026 11:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7B203E9F97;
	Fri, 27 Mar 2026 11:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tn8g09xa"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827463E6DE0;
	Fri, 27 Mar 2026 11:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774609688; cv=none; b=mYlURsab7bZryiqE15VAYFubjrpwUmQT7auMP3KsE7mEnuBUECp/7bzyKcD24qhX4DYH1QUlpCHIXKGnEHGddHXTPf4ZBjG5YTaxVh8bQA11XjkVdz/TnRWk4pLcE1ro8AJFxOSRqkqKoXVOxRZ1pxcInRQicuWzsSsuMNpU43c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774609688; c=relaxed/simple;
	bh=onsYAPTWUhtWT9aVV6zfjYf4cH1H/ovJJymieQUfvbE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S6AJUmcVnc+RzPxAKeah0tgzJvOq1XA4iOYovddEDC82pvzQ0ch7tVZJQfvHMmuDjkdrZLpAq8GveCk/Y7n+PlGddfdahFTwDSj2qpHiZomHYMnOjgT4cVhUzEpeyJJ5s67sEo6+xC7X1XFmebD1cO5ANyaXYHPGBu5rzXvf+Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tn8g09xa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 61602C2BCB2;
	Fri, 27 Mar 2026 11:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774609687;
	bh=onsYAPTWUhtWT9aVV6zfjYf4cH1H/ovJJymieQUfvbE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Tn8g09xaS/utieMNxlCPrV1s8zY2SKHUqOkkKAwam3JDvHv55eN5YWHXWnXaoiCzx
	 bvBKthjUzkbRK5xoIJq7cpOfCUtybYt8Yz9iNhW7EzBRdiwXi0Jk/Io7D4rCeija5x
	 W78uDZpWuLqb7RGxj/5cQ+Aa/JVJ9MqB5/K9JrJwlTg2KXTi+78BGAGrGc9fxyo3DZ
	 hpxvSX7fyx5Izs01TnmBtvo4hZntvb1pqObFpegrEmoVr3SDiagYnWi78/HoT6GrMj
	 QBfS+qUN6rB0Mdjncx8OGqLRVD30IwHhc7gLLczYw4NhTiY1hwBFUEvnyOC0J5fdpH
	 z68y+E4P90khQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4877D10ED659;
	Fri, 27 Mar 2026 11:08:07 +0000 (UTC)
From: Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org>
Date: Fri, 27 Mar 2026 13:07:58 +0200
Subject: [PATCH v5 2/4] iio: adc: ad4691: add initial driver for AD4691
 family
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260327-ad4692-multichannel-sar-adc-driver-v5-2-11f789de47b8@analog.com>
References: <20260327-ad4692-multichannel-sar-adc-driver-v5-0-11f789de47b8@analog.com>
In-Reply-To: <20260327-ad4692-multichannel-sar-adc-driver-v5-0-11f789de47b8@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774609685; l=23140;
 i=radu.sabau@analog.com; s=20260220; h=from:subject:message-id;
 bh=LsrVKbEDtdL9NLrz15mTBDx1r2cqJT7Gw+jONe3xcpo=;
 b=hjQwmqyEO/S6w6iJZtNIFCH41KIAsdFsEKWbXaC2VOR20WXXQdrQW/8izQEhE7Z0YGq/ousyL
 ZTA8/4hZqI9AAVFovFbceOVOqDg7xr55i2JidGAAAUyXyOHtg/KChjN
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
	TAGGED_FROM(0.00)[bounces-8387-lists,linux-pwm=lfdr.de,radu.sabau.analog.com];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,analog.com:email,analog.com:mid,analog.com:replyto,analog.com:url]
X-Rspamd-Queue-Id: BFEB63433C1
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

The chip idles in Autonomous Mode so that single-shot read_raw can use
the internal oscillator without disturbing the hardware configuration.

Three voltage supply domains are managed: avdd (required), vio, and a
reference supply on either the REF pin (ref-supply, external buffer)
or the REFIN pin (refin-supply, uses the on-chip reference buffer;
REFBUF_EN is set accordingly). Hardware reset is performed via
the reset controller framework; a software reset through SPI_CONFIG_A
is used as fallback when no hardware reset is available.

Accumulator channel masking for single-shot reads uses ACC_MASK_REG via
an ADDR_DESCENDING SPI write, which covers both mask bytes in a single
16-bit transfer.

Signed-off-by: Radu Sabau <radu.sabau@analog.com>
---
 MAINTAINERS              |   1 +
 drivers/iio/adc/Kconfig  |  11 +
 drivers/iio/adc/Makefile |   1 +
 drivers/iio/adc/ad4691.c | 690 +++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 703 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 438ca850fa1c..24e4502b8292 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1490,6 +1490,7 @@ L:	linux-iio@vger.kernel.org
 S:	Supported
 W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/adc/adi,ad4691.yaml
+F:	drivers/iio/adc/ad4691.c
 
 ANALOG DEVICES INC AD4695 DRIVER
 M:	Michael Hennerich <michael.hennerich@analog.com>
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
index 000000000000..f930efdb9d8c
--- /dev/null
+++ b/drivers/iio/adc/ad4691.c
@@ -0,0 +1,690 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2024-2026 Analog Devices, Inc.
+ * Author: Radu Sabau <radu.sabau@analog.com>
+ */
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
+#include <linux/cleanup.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/math.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+#include <linux/reset.h>
+#include <linux/spi/spi.h>
+#include <linux/units.h>
+#include <linux/unaligned.h>
+
+#include <linux/iio/iio.h>
+
+#define AD4691_VREF_uV_MIN			2400000
+#define AD4691_VREF_uV_MAX			5250000
+#define AD4691_VREF_2P5_uV_MAX			2750000
+#define AD4691_VREF_3P0_uV_MAX			3250000
+#define AD4691_VREF_3P3_uV_MAX			3750000
+#define AD4691_VREF_4P096_uV_MAX		4500000
+
+#define AD4691_SPI_CONFIG_A_REG			0x000
+#define AD4691_SW_RESET				(BIT(7) | BIT(0))
+
+#define AD4691_STATUS_REG			0x014
+#define AD4691_CLAMP_STATUS1_REG		0x01A
+#define AD4691_CLAMP_STATUS2_REG		0x01B
+#define AD4691_DEVICE_SETUP			0x020
+#define AD4691_LDO_EN				BIT(4)
+#define AD4691_REF_CTRL				0x021
+#define AD4691_REF_CTRL_MASK			GENMASK(4, 2)
+#define AD4691_REFBUF_EN			BIT(0)
+#define AD4691_OSC_FREQ_REG			0x023
+#define AD4691_OSC_FREQ_MASK			GENMASK(3, 0)
+#define AD4691_STD_SEQ_CONFIG			0x025
+#define AD4691_SPARE_CONTROL			0x02A
+
+#define AD4691_OSC_EN_REG			0x180
+#define AD4691_STATE_RESET_REG			0x181
+#define AD4691_STATE_RESET_ALL			0x01
+#define AD4691_ADC_SETUP			0x182
+#define AD4691_ADC_MODE_MASK			GENMASK(1, 0)
+#define AD4691_AUTONOMOUS_MODE			0x02
+/*
+ * ACC_MASK_REG covers both mask bytes via ADDR_DESCENDING SPI: writing a
+ * 16-bit BE value to 0x185 auto-decrements to 0x184 for the second byte.
+ */
+#define AD4691_ACC_MASK_REG			0x185
+#define AD4691_ACC_DEPTH_IN(n)			(0x186 + (n))
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
+	const char *name;
+	unsigned int num_channels;
+	unsigned int max_rate;
+};
+
+#define AD4691_CHANNEL(ch)						\
+	{								\
+		.type = IIO_VOLTAGE,					\
+		.indexed = 1,						\
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW)		\
+				    | BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
+		.info_mask_separate_available =				\
+				      BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
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
+static const struct iio_chan_spec ad4691_channels[] = {
+	AD4691_CHANNEL(0),
+	AD4691_CHANNEL(1),
+	AD4691_CHANNEL(2),
+	AD4691_CHANNEL(3),
+	AD4691_CHANNEL(4),
+	AD4691_CHANNEL(5),
+	AD4691_CHANNEL(6),
+	AD4691_CHANNEL(7),
+	AD4691_CHANNEL(8),
+	AD4691_CHANNEL(9),
+	AD4691_CHANNEL(10),
+	AD4691_CHANNEL(11),
+	AD4691_CHANNEL(12),
+	AD4691_CHANNEL(13),
+	AD4691_CHANNEL(14),
+	AD4691_CHANNEL(15),
+};
+
+static const struct iio_chan_spec ad4693_channels[] = {
+	AD4691_CHANNEL(0),
+	AD4691_CHANNEL(1),
+	AD4691_CHANNEL(2),
+	AD4691_CHANNEL(3),
+	AD4691_CHANNEL(4),
+	AD4691_CHANNEL(5),
+	AD4691_CHANNEL(6),
+	AD4691_CHANNEL(7),
+};
+
+/*
+ * Internal oscillator frequency table. Index is the OSC_FREQ_REG[3:0] value.
+ * Index 0 (1 MHz) is only valid for AD4692/AD4694; AD4691/AD4693 support
+ * up to 500 kHz and use index 1 as their highest valid rate.
+ */
+static const int ad4691_osc_freqs[] = {
+	1000000,	/* 0x0: 1 MHz */
+	500000,		/* 0x1: 500 kHz */
+	400000,		/* 0x2: 400 kHz */
+	250000,		/* 0x3: 250 kHz */
+	200000,		/* 0x4: 200 kHz */
+	167000,		/* 0x5: 167 kHz */
+	133000,		/* 0x6: 133 kHz */
+	125000,		/* 0x7: 125 kHz */
+	100000,		/* 0x8: 100 kHz */
+	50000,		/* 0x9: 50 kHz */
+	25000,		/* 0xA: 25 kHz */
+	12500,		/* 0xB: 12.5 kHz */
+	10000,		/* 0xC: 10 kHz */
+	5000,		/* 0xD: 5 kHz */
+	2500,		/* 0xE: 2.5 kHz */
+	1250,		/* 0xF: 1.25 kHz */
+};
+
+static const struct ad4691_chip_info ad4691_chip_info = {
+	.channels = ad4691_channels,
+	.name = "ad4691",
+	.num_channels = ARRAY_SIZE(ad4691_channels),
+	.max_rate = 500 * HZ_PER_KHZ,
+};
+
+static const struct ad4691_chip_info ad4692_chip_info = {
+	.channels = ad4691_channels,
+	.name = "ad4692",
+	.num_channels = ARRAY_SIZE(ad4691_channels),
+	.max_rate = 1 * HZ_PER_MHZ,
+};
+
+static const struct ad4691_chip_info ad4693_chip_info = {
+	.channels = ad4693_channels,
+	.name = "ad4693",
+	.num_channels = ARRAY_SIZE(ad4693_channels),
+	.max_rate = 500 * HZ_PER_KHZ,
+};
+
+static const struct ad4691_chip_info ad4694_chip_info = {
+	.channels = ad4693_channels,
+	.name = "ad4694",
+	.num_channels = ARRAY_SIZE(ad4693_channels),
+	.max_rate = 1 * HZ_PER_MHZ,
+};
+
+struct ad4691_state {
+	const struct ad4691_chip_info *info;
+	struct regmap *regmap;
+	int vref_uV;
+	bool refbuf_en;
+	bool ldo_en;
+	/*
+	 * Synchronize access to members of the driver state, and ensure
+	 * atomicity of consecutive SPI operations.
+	 */
+	struct mutex lock;
+};
+
+static int ad4691_reg_read(void *context, unsigned int reg, unsigned int *val)
+{
+	struct spi_device *spi = context;
+	u8 tx[2], rx[4];
+	int ret;
+
+	/* Set bit 15 to mark the operation as READ. */
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
+	struct spi_device *spi = context;
+	u8 tx[4];
+
+	put_unaligned_be16(reg, tx);
+
+	switch (reg) {
+	case 0 ... AD4691_OSC_FREQ_REG:
+	case AD4691_SPARE_CONTROL ... AD4691_ACC_MASK_REG - 1:
+	case AD4691_ACC_MASK_REG + 1 ... AD4691_GPIO_MODE2_REG:
+		if (val > 0xFF)
+			return -EINVAL;
+		tx[2] = val;
+		return spi_write_then_read(spi, tx, 3, NULL, 0);
+	case AD4691_ACC_MASK_REG:
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
+static int ad4691_get_sampling_freq(struct ad4691_state *st, int *val)
+{
+	unsigned int reg_val;
+	int ret;
+
+	ret = regmap_read(st->regmap, AD4691_OSC_FREQ_REG, &reg_val);
+	if (ret)
+		return ret;
+
+	*val = ad4691_osc_freqs[FIELD_GET(AD4691_OSC_FREQ_MASK, reg_val)];
+	return IIO_VAL_INT;
+}
+
+static int ad4691_set_sampling_freq(struct iio_dev *indio_dev, int freq)
+{
+	struct ad4691_state *st = iio_priv(indio_dev);
+	unsigned int start = (st->info->max_rate == 1 * HZ_PER_MHZ) ? 0 : 1;
+	unsigned int i;
+
+	IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
+	if (IIO_DEV_ACQUIRE_FAILED(claim))
+		return -EBUSY;
+
+	for (i = start; i < ARRAY_SIZE(ad4691_osc_freqs); i++) {
+		if (ad4691_osc_freqs[i] != freq)
+			continue;
+		return regmap_update_bits(st->regmap, AD4691_OSC_FREQ_REG,
+					  AD4691_OSC_FREQ_MASK, i);
+	}
+
+	return -EINVAL;
+}
+
+static int ad4691_read_avail(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     const int **vals, int *type,
+			     int *length, long mask)
+{
+	struct ad4691_state *st = iio_priv(indio_dev);
+	unsigned int start = (st->info->max_rate == 1 * HZ_PER_MHZ) ? 0 : 1;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*vals = &ad4691_osc_freqs[start];
+		*type = IIO_VAL_INT;
+		*length = ARRAY_SIZE(ad4691_osc_freqs) - start;
+		return IIO_AVAIL_LIST;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ad4691_single_shot_read(struct iio_dev *indio_dev,
+				   struct iio_chan_spec const *chan, int *val)
+{
+	struct ad4691_state *st = iio_priv(indio_dev);
+	unsigned int reg_val;
+	int ret;
+
+	guard(mutex)(&st->lock);
+
+	/*
+	 * Use AUTONOMOUS mode for single-shot reads.
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
+	ret = regmap_write(st->regmap, AD4691_ACC_MASK_REG,
+			   (u16)~BIT(chan->channel));
+	if (ret)
+		return ret;
+
+	ret = regmap_read(st->regmap, AD4691_OSC_FREQ_REG, &reg_val);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(st->regmap, AD4691_OSC_EN_REG, 1);
+	if (ret)
+		return ret;
+
+	/*
+	 * Wait for at least 2 internal oscillator periods for the
+	 * conversion to complete.
+	 */
+	fsleep(DIV_ROUND_UP(2 * USEC_PER_SEC, ad4691_osc_freqs[FIELD_GET(AD4691_OSC_FREQ_MASK, reg_val)]));
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
+
+	ret = regmap_write(st->regmap, AD4691_STATE_RESET_REG, AD4691_STATE_RESET_ALL);
+	if (ret)
+		return ret;
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
+		if (IIO_DEV_ACQUIRE_FAILED(claim))
+			return -EBUSY;
+
+		return ad4691_single_shot_read(indio_dev, chan, val);
+	}
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		return ad4691_get_sampling_freq(st, val);
+	case IIO_CHAN_INFO_SCALE:
+		*val = st->vref_uV / (MICRO / MILLI);
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
+	.read_avail = &ad4691_read_avail,
+	.debugfs_reg_access = &ad4691_reg_access,
+};
+
+static int ad4691_regulator_setup(struct ad4691_state *st)
+{
+	struct device *dev = regmap_get_device(st->regmap);
+	int ret;
+
+	ret = devm_regulator_get_enable(dev, "avdd");
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to get and enable AVDD\n");
+
+	ret = devm_regulator_get_enable(dev, "vio");
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to get and enable VIO\n");
+
+	ret = devm_regulator_get_enable(dev, "ldo-in");
+	if (ret == -ENODEV)
+		st->ldo_en = true;
+	else if (ret)
+		return dev_err_probe(dev, ret, "Failed to get and enable LDO-IN\n");
+
+	st->vref_uV = devm_regulator_get_enable_read_voltage(dev, "ref");
+	if (st->vref_uV == -ENODEV) {
+		st->vref_uV = devm_regulator_get_enable_read_voltage(dev, "refin");
+		st->refbuf_en = true;
+	}
+	if (st->vref_uV < 0)
+		return dev_err_probe(dev, st->vref_uV,
+				     "Failed to get reference supply\n");
+
+	if (st->vref_uV < AD4691_VREF_uV_MIN || st->vref_uV > AD4691_VREF_uV_MAX)
+		return dev_err_probe(dev, -EINVAL,
+				     "vref(%d) must be in the range [%u...%u]\n",
+				     st->vref_uV, AD4691_VREF_uV_MIN,
+				     AD4691_VREF_uV_MAX);
+
+	return 0;
+}
+
+static int ad4691_reset(struct ad4691_state *st)
+{
+	struct device *dev = regmap_get_device(st->regmap);
+	struct reset_control *rst;
+
+	rst = devm_reset_control_get_optional_exclusive(dev, NULL);
+	if (IS_ERR(rst))
+		return dev_err_probe(dev, PTR_ERR(rst), "Failed to get reset\n");
+
+	if (rst) {
+		/*
+		 * The GPIO is already asserted by reset_gpio_probe (GPIOD_OUT_HIGH).
+		 * Wait for the reset pulse width required by the chip. See datasheet Table 5.
+		 */
+		fsleep(300);
+		return reset_control_deassert(rst);
+	}
+
+	/* No hardware reset available, fall back to software reset. */
+	return regmap_write(st->regmap, AD4691_SPI_CONFIG_A_REG,
+			    AD4691_SW_RESET);
+}
+
+static int ad4691_config(struct ad4691_state *st)
+{
+	struct device *dev = regmap_get_device(st->regmap);
+	enum ad4691_ref_ctrl ref_val;
+	int ret;
+
+	switch (st->vref_uV) {
+	case AD4691_VREF_uV_MIN ... AD4691_VREF_2P5_uV_MAX:
+		ref_val = AD4691_VREF_2P5;
+		break;
+	case AD4691_VREF_2P5_uV_MAX + 1 ... AD4691_VREF_3P0_uV_MAX:
+		ref_val = AD4691_VREF_3P0;
+		break;
+	case AD4691_VREF_3P0_uV_MAX + 1 ... AD4691_VREF_3P3_uV_MAX:
+		ref_val = AD4691_VREF_3P3;
+		break;
+	case AD4691_VREF_3P3_uV_MAX + 1 ... AD4691_VREF_4P096_uV_MAX:
+		ref_val = AD4691_VREF_4P096;
+		break;
+	case AD4691_VREF_4P096_uV_MAX + 1 ... AD4691_VREF_uV_MAX:
+		ref_val = AD4691_VREF_5P0;
+		break;
+	default:
+		return dev_err_probe(dev, -EINVAL,
+				     "Unsupported vref voltage: %d uV\n",
+				     st->vref_uV);
+	}
+
+	ret = regmap_update_bits(st->regmap, AD4691_REF_CTRL,
+				 AD4691_REF_CTRL_MASK | AD4691_REFBUF_EN,
+				 FIELD_PREP(AD4691_REF_CTRL_MASK, ref_val) |
+				 (st->refbuf_en ? AD4691_REFBUF_EN : 0));
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to write REF_CTRL\n");
+
+	ret = regmap_assign_bits(st->regmap, AD4691_DEVICE_SETUP,
+				 AD4691_LDO_EN, st->ldo_en);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to write DEVICE_SETUP\n");
+
+	/*
+	 * Set the internal oscillator to the highest rate this chip supports.
+	 * Index 0 (1 MHz) exceeds the 500 kHz max of AD4691/AD4693, so those
+	 * chips start at index 1 (500 kHz).
+	 */
+	ret = regmap_update_bits(st->regmap, AD4691_OSC_FREQ_REG,
+				 AD4691_OSC_FREQ_MASK,
+				 (st->info->max_rate == 1 * HZ_PER_MHZ) ? 0 : 1);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to write OSC_FREQ\n");
+
+	ret = regmap_update_bits(st->regmap, AD4691_ADC_SETUP,
+				 AD4691_ADC_MODE_MASK, AD4691_AUTONOMOUS_MODE);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to write ADC_SETUP\n");
+
+	return 0;
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
+	st->info = spi_get_device_match_data(spi);
+
+	ret = devm_mutex_init(dev, &st->lock);
+	if (ret)
+		return ret;
+
+	st->regmap = devm_regmap_init(dev, NULL, spi, &ad4691_regmap_config);
+	if (IS_ERR(st->regmap))
+		return dev_err_probe(dev, PTR_ERR(st->regmap),
+				     "Failed to initialize regmap\n");
+
+	ret = ad4691_regulator_setup(st);
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
+	indio_dev->name = st->info->name;
+	indio_dev->info = &ad4691_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	indio_dev->channels = st->info->channels;
+	indio_dev->num_channels = st->info->num_channels;
+
+	return devm_iio_device_register(dev, indio_dev);
+}
+
+static const struct of_device_id ad4691_of_match[] = {
+	{ .compatible = "adi,ad4691", .data = &ad4691_chip_info },
+	{ .compatible = "adi,ad4692", .data = &ad4692_chip_info },
+	{ .compatible = "adi,ad4693", .data = &ad4693_chip_info },
+	{ .compatible = "adi,ad4694", .data = &ad4694_chip_info },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ad4691_of_match);
+
+static const struct spi_device_id ad4691_id[] = {
+	{ "ad4691", (kernel_ulong_t)&ad4691_chip_info },
+	{ "ad4692", (kernel_ulong_t)&ad4692_chip_info },
+	{ "ad4693", (kernel_ulong_t)&ad4693_chip_info },
+	{ "ad4694", (kernel_ulong_t)&ad4694_chip_info },
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



