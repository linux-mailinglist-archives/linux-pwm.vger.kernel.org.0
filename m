Return-Path: <linux-pwm+bounces-9008-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wD6oEuVWDGodfwUAu9opvQ
	(envelope-from <linux-pwm+bounces-9008-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 19 May 2026 14:26:13 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C085E57EA3E
	for <lists+linux-pwm@lfdr.de>; Tue, 19 May 2026 14:26:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 33AAC3037D76
	for <lists+linux-pwm@lfdr.de>; Tue, 19 May 2026 12:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 820E04DB560;
	Tue, 19 May 2026 12:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hdVBnKpZ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F644D8D90;
	Tue, 19 May 2026 12:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779193242; cv=none; b=KLh7OjiKoghLOgTcmSyOqkbIthju2Q5qN0UCcGUpYIfoXrvFXQSIsyXwbxNa0Z0M+LqugdUUYeJxS6H2PzxEE/w1FTvqdEd2ZFiA6jpMzvCymTacM8oiX84YJNPr1hsqaUx9qzv9N1J4IYi/CnBq4SyUeNZ9c6V+qgheFIauQsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779193242; c=relaxed/simple;
	bh=wNkEWNjnFvNKYFEz+fcepREO9mdGbvKVXEuxR5OrLKM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AupgpvmOHda9ykM/7n7suUJNT2gdmHLYLeiMP1XIONDpT9YVmVzeDeN9Ib5X9fkcqeBslS7UpuQUIFvOHU97+jQF93OQuEHvG1+eWArVCPYYQYTMKUwkM5Vb4vzcST2hu48VK7xYTVHh9SUFHuuRrv/l/Sxvj7fJOAdkCDNgI5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hdVBnKpZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E07CAC2BCF6;
	Tue, 19 May 2026 12:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779193242;
	bh=wNkEWNjnFvNKYFEz+fcepREO9mdGbvKVXEuxR5OrLKM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=hdVBnKpZrFr7LebzZywBRXnoVWz04FKbWZrhjoDlr847DqKs3pDu/UNBrxPwZgkYV
	 nzKq1NlwXx1QiHJGVuIgxb5+idhAfryAp8uBOd6qN+3P0o+ceH9A2Dvol590Zjn0da
	 L0EtNc5UsMjE4JGtQxkpyeHN00jgGho7kJvsIV4Oihs6PUDIn98szzoeSi6WopKApD
	 ZBZ2FIuPZeKQhqgyCUe1UWrJUoaY63WJJrfIZTDc2CSbwFesaw8RhyRbkz8nvjL0lF
	 WQnaR+qiTOnZBrIKi8SvH5qFQfM6m/hLeo/Y/xx+m+dJZt8uYDniQPHBLEr+xqfC7h
	 Tjiz4SH17hZQQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4446CD5BAA;
	Tue, 19 May 2026 12:20:41 +0000 (UTC)
From: Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org>
Date: Tue, 19 May 2026 15:20:23 +0300
Subject: [PATCH v12 2/6] iio: adc: ad4691: add initial driver for AD4691
 family
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260519-ad4692-multichannel-sar-adc-driver-v12-2-5b335162aa51@analog.com>
References: <20260519-ad4692-multichannel-sar-adc-driver-v12-0-5b335162aa51@analog.com>
In-Reply-To: <20260519-ad4692-multichannel-sar-adc-driver-v12-0-5b335162aa51@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779193239; l=27214;
 i=radu.sabau@analog.com; s=20260220; h=from:subject:message-id;
 bh=gDkEQLWoER1TtqBGVDJYpgGZR+Zm5FdCv+DCMwQ6FZo=;
 b=QPAHuKZB3zvMzF5uRcy3ZRIrNI6BSitiFupBvvUICApXGPQPRLm7DLujBxPB9nM5v58/7MAr2
 7yUfGd0ACISB+HbeDd8I1d3I4ssEQcRy+UYQlmP2OqSvtLZhwWDEJlz
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9008-lists,linux-pwm=lfdr.de,radu.sabau.analog.com];
	FREEMAIL_TO(0.00)[metafoo.de,analog.com,kernel.org,baylibre.com,gmail.com,pengutronix.de,lwn.net,linuxfoundation.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	HAS_REPLYTO(0.00)[radu.sabau@analog.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,linux-pwm@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[baylibre.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,analog.com:url,analog.com:replyto,analog.com:mid,analog.com:email]
X-Rspamd-Queue-Id: C085E57EA3E
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
REFBUF_EN is set accordingly). Hardware reset is performed by asserting
the reset-gpios GPIO line for at least 300 µs then deasserting it;
a software reset via SPI_CONFIG_A is used as fallback when no reset
GPIO is provided.

Accumulator channel masking for single-shot reads uses ACC_MASK_REG via
an ADDR_DESCENDING SPI write, which covers both mask bytes in a single
16-bit transfer.

IIO_CHAN_INFO_SAMP_FREQ is exposed as info_mask_separate. The oscillator
is shared hardware — writing any channel's sampling_frequency attribute
sets it for all others — but per-channel attributes are used throughout
the series to avoid an ABI change when per-channel oversampling ratios
are introduced in a later commit, at which point the effective output
rate (osc_freq / osr[N]) becomes genuinely per-channel.

Reviewed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Radu Sabau <radu.sabau@analog.com>
---
 MAINTAINERS              |   1 +
 drivers/iio/adc/Kconfig  |  12 +
 drivers/iio/adc/Makefile |   1 +
 drivers/iio/adc/ad4691.c | 796 +++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 810 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7d31c38921e8..020c1ffae31b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1488,6 +1488,7 @@ L:	linux-iio@vger.kernel.org
 S:	Supported
 W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/adc/adi,ad4691.yaml
+F:	drivers/iio/adc/ad4691.c
 
 ANALOG DEVICES INC AD4695 DRIVER
 M:	Michael Hennerich <michael.hennerich@analog.com>
diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index a9dedbb8eb46..c9aca0d08e41 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -144,6 +144,18 @@ config AD4170_4
 	  To compile this driver as a module, choose M here: the module will be
 	  called ad4170-4.
 
+config AD4691
+	tristate "Analog Devices AD4691 Family ADC Driver"
+	depends on SPI
+	depends on REGULATOR || COMPILE_TEST
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
index 097357d146ba..707dd708912f 100644
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
index 000000000000..2d58df862142
--- /dev/null
+++ b/drivers/iio/adc/ad4691.c
@@ -0,0 +1,796 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2024-2026 Analog Devices, Inc.
+ * Author: Radu Sabau <radu.sabau@analog.com>
+ */
+#include <linux/array_size.h>
+#include <linux/bitfield.h>
+#include <linux/bitmap.h>
+#include <linux/cleanup.h>
+#include <linux/delay.h>
+#include <linux/dev_printk.h>
+#include <linux/device/devres.h>
+#include <linux/err.h>
+#include <linux/limits.h>
+#include <linux/math.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+#include <linux/reset.h>
+#include <linux/spi/spi.h>
+#include <linux/types.h>
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
+#define AD4691_CNV_DUTY_CYCLE_NS		380
+#define AD4691_CNV_HIGH_TIME_NS			430
+
+#define AD4691_SPI_CONFIG_A_REG			0x000
+#define AD4691_SW_RESET				(BIT(7) | BIT(0))
+
+#define AD4691_STATUS_REG			0x014
+#define AD4691_CLAMP_STATUS1_REG		0x01A
+#define AD4691_CLAMP_STATUS2_REG		0x01B
+#define AD4691_DEVICE_SETUP			0x020
+#define AD4691_MANUAL_MODE			BIT(2)
+#define AD4691_LDO_EN				BIT(4)
+#define AD4691_REF_CTRL				0x021
+#define AD4691_REF_CTRL_MASK			GENMASK(4, 2)
+#define AD4691_REFBUF_EN			BIT(0)
+#define AD4691_OSC_FREQ_REG			0x023
+#define AD4691_OSC_FREQ_MASK			GENMASK(3, 0)
+#define AD4691_STD_SEQ_CONFIG			0x025
+#define AD4691_SEQ_ALL_CHANNELS_OFF		0x00
+#define AD4691_SPARE_CONTROL			0x02A
+
+#define AD4691_MAX_CHANNELS			16
+
+#define AD4691_NOOP				0x00
+#define AD4691_ADC_CHAN(ch)			((0x10 + (ch)) << 3)
+
+#define AD4691_OSC_EN_REG			0x180
+#define AD4691_STATE_RESET_REG			0x181
+#define AD4691_STATE_RESET_ALL			BIT(0)
+#define AD4691_ADC_SETUP			0x182
+#define AD4691_ADC_MODE_MASK			GENMASK(1, 0)
+#define AD4691_CNV_BURST_MODE			0x01
+#define AD4691_AUTONOMOUS_MODE			0x02
+/*
+ * ACC_MASK_REG covers both mask bytes via ADDR_DESCENDING SPI: writing a
+ * 16-bit BE value to 0x185 auto-decrements to 0x184 for the second byte.
+ */
+#define AD4691_ACC_MASK_REG			0x185
+#define AD4691_ACC_DEPTH_IN(n)			(0x186 + (n))
+#define AD4691_GPIO_MODE1_REG			0x196
+#define AD4691_GPIO_MODE2_REG			0x197
+#define AD4691_GP_MODE_MASK			GENMASK(3, 0)
+#define AD4691_GP_MODE_DATA_READY		0x06
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
+
+static const char * const ad4691_supplies[] = { "avdd", "vio" };
+
+enum ad4691_ref_ctrl {
+	AD4691_VREF_2P5,
+	AD4691_VREF_3P0,
+	AD4691_VREF_3P3,
+	AD4691_VREF_4P096,
+	AD4691_VREF_5P0
+};
+
+struct ad4691_channel_info {
+	const struct iio_chan_spec *channels __counted_by_ptr(num_channels);
+	unsigned int num_channels;
+};
+
+struct ad4691_chip_info {
+	const char *name;
+	unsigned int max_rate;
+	const struct ad4691_channel_info *sw_info;
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
+		.scan_type = {						\
+			.realbits = 16,					\
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
+static const struct ad4691_channel_info ad4691_sw_info = {
+	.channels = ad4691_channels,
+	.num_channels = ARRAY_SIZE(ad4691_channels),
+};
+
+static const struct ad4691_channel_info ad4693_sw_info = {
+	.channels = ad4693_channels,
+	.num_channels = ARRAY_SIZE(ad4693_channels),
+};
+
+/*
+ * Internal oscillator frequency table. Index is the OSC_FREQ_REG[3:0] value.
+ * Index 0 (1 MHz) is only valid for AD4692/AD4694; AD4691/AD4693 support
+ * up to 500 kHz and use index 1 as their highest valid rate.
+ */
+static const int ad4691_osc_freqs_Hz[] = {
+	[0x0] = 1000000,
+	[0x1] = 500000,
+	[0x2] = 400000,
+	[0x3] = 250000,
+	[0x4] = 200000,
+	[0x5] = 167000,
+	[0x6] = 133000,
+	[0x7] = 125000,
+	[0x8] = 100000,
+	[0x9] = 50000,
+	[0xA] = 25000,
+	[0xB] = 12500,
+	[0xC] = 10000,
+	[0xD] = 5000,
+	[0xE] = 2500,
+	[0xF] = 1250,
+};
+
+static const struct ad4691_chip_info ad4691_chip_info = {
+	.name = "ad4691",
+	.max_rate = 500 * HZ_PER_KHZ,
+	.sw_info = &ad4691_sw_info,
+};
+
+static const struct ad4691_chip_info ad4692_chip_info = {
+	.name = "ad4692",
+	.max_rate = 1 * HZ_PER_MHZ,
+	.sw_info = &ad4691_sw_info,
+};
+
+static const struct ad4691_chip_info ad4693_chip_info = {
+	.name = "ad4693",
+	.max_rate = 500 * HZ_PER_KHZ,
+	.sw_info = &ad4693_sw_info,
+};
+
+static const struct ad4691_chip_info ad4694_chip_info = {
+	.name = "ad4694",
+	.max_rate = 1 * HZ_PER_MHZ,
+	.sw_info = &ad4693_sw_info,
+};
+
+struct ad4691_state {
+	const struct ad4691_chip_info *info;
+	struct regmap *regmap;
+	struct spi_device *spi;
+
+	int vref_uV;
+
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
+	case AD4691_SPARE_CONTROL ... AD4691_ACC_MASK_REG - 1:
+	case AD4691_ACC_MASK_REG + 1 ... AD4691_ACC_SAT_OVR_REG(15):
+		ret = spi_write_then_read(spi, tx, sizeof(tx), rx, 1);
+		if (ret)
+			return ret;
+		*val = rx[0];
+		return 0;
+	case AD4691_ACC_MASK_REG:
+	case AD4691_STD_SEQ_CONFIG:
+	case AD4691_AVG_IN(0) ... AD4691_AVG_IN(15):
+		ret = spi_write_then_read(spi, tx, sizeof(tx), rx, 2);
+		if (ret)
+			return ret;
+		*val = get_unaligned_be16(rx);
+		return 0;
+	case AD4691_AVG_STS_IN(0) ... AD4691_AVG_STS_IN(15):
+	case AD4691_ACC_IN(0) ... AD4691_ACC_IN(15):
+		ret = spi_write_then_read(spi, tx, sizeof(tx), rx, 3);
+		if (ret)
+			return ret;
+		*val = get_unaligned_be24(rx);
+		return 0;
+	case AD4691_ACC_STS_DATA(0) ... AD4691_ACC_STS_DATA(15):
+		ret = spi_write_then_read(spi, tx, sizeof(tx), rx, 4);
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
+		if (val > U8_MAX)
+			return -EINVAL;
+		tx[2] = val;
+		return spi_write_then_read(spi, tx, 3, NULL, 0);
+	case AD4691_ACC_MASK_REG:
+	case AD4691_STD_SEQ_CONFIG:
+		if (val > U16_MAX)
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
+		return true;
+	default:
+		break;
+	}
+
+	/*
+	 * Multi-byte registers have non-unit strides; only accept base
+	 * addresses to prevent debugfs from triggering reads that cross
+	 * register boundaries.
+	 */
+	if (reg >= AD4691_AVG_IN(0) && reg <= AD4691_AVG_IN(15))
+		return (reg - AD4691_AVG_IN(0)) % 2 == 0;
+	if (reg >= AD4691_AVG_STS_IN(0) && reg <= AD4691_AVG_STS_IN(15))
+		return (reg - AD4691_AVG_STS_IN(0)) % 3 == 0;
+	if (reg >= AD4691_ACC_IN(0) && reg <= AD4691_ACC_IN(15))
+		return (reg - AD4691_ACC_IN(0)) % 3 == 0;
+	if (reg >= AD4691_ACC_STS_DATA(0) && reg <= AD4691_ACC_STS_DATA(15))
+		return (reg - AD4691_ACC_STS_DATA(0)) % 4 == 0;
+
+	return false;
+}
+
+static bool ad4691_readable_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case 0 ... AD4691_OSC_FREQ_REG:
+	case AD4691_SPARE_CONTROL ... AD4691_ACC_SAT_OVR_REG(15):
+	case AD4691_STD_SEQ_CONFIG:
+		return true;
+	default:
+		break;
+	}
+
+	/* Multi-byte registers: only accept base addresses (see volatile_reg). */
+	if (reg >= AD4691_AVG_IN(0) && reg <= AD4691_AVG_IN(15))
+		return (reg - AD4691_AVG_IN(0)) % 2 == 0;
+	if (reg >= AD4691_AVG_STS_IN(0) && reg <= AD4691_AVG_STS_IN(15))
+		return (reg - AD4691_AVG_STS_IN(0)) % 3 == 0;
+	if (reg >= AD4691_ACC_IN(0) && reg <= AD4691_ACC_IN(15))
+		return (reg - AD4691_ACC_IN(0)) % 3 == 0;
+	if (reg >= AD4691_ACC_STS_DATA(0) && reg <= AD4691_ACC_STS_DATA(15))
+		return (reg - AD4691_ACC_STS_DATA(0)) % 4 == 0;
+
+	return false;
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
+/*
+ * Index 0 in ad4691_osc_freqs_Hz is 1 MHz — valid only for AD4692/AD4694
+ * (max_rate == 1 MHz). AD4691/AD4693 cap at 500 kHz so their valid range
+ * starts at index 1.
+ */
+static unsigned int ad4691_samp_freq_start(const struct ad4691_chip_info *info)
+{
+	return (info->max_rate == 1 * HZ_PER_MHZ) ? 0 : 1;
+}
+
+static int ad4691_get_sampling_freq(struct ad4691_state *st, int *val)
+{
+	unsigned int reg_val;
+	int ret;
+
+	guard(mutex)(&st->lock);
+
+	ret = regmap_read(st->regmap, AD4691_OSC_FREQ_REG, &reg_val);
+	if (ret)
+		return ret;
+
+	*val = ad4691_osc_freqs_Hz[FIELD_GET(AD4691_OSC_FREQ_MASK, reg_val)];
+	return IIO_VAL_INT;
+}
+
+static int ad4691_set_sampling_freq(struct ad4691_state *st, int freq)
+{
+	unsigned int start = ad4691_samp_freq_start(st->info);
+
+	guard(mutex)(&st->lock);
+
+	for (unsigned int i = start; i < ARRAY_SIZE(ad4691_osc_freqs_Hz); i++) {
+		if (ad4691_osc_freqs_Hz[i] != freq)
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
+	unsigned int start = ad4691_samp_freq_start(st->info);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*vals = &ad4691_osc_freqs_Hz[start];
+		*type = IIO_VAL_INT;
+		*length = ARRAY_SIZE(ad4691_osc_freqs_Hz) - start;
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
+	unsigned int reg_val, osc_idx, period_us;
+	int ret;
+
+	guard(mutex)(&st->lock);
+
+	/* Use AUTONOMOUS mode for single-shot reads. */
+	ret = regmap_write(st->regmap, AD4691_STATE_RESET_REG, AD4691_STATE_RESET_ALL);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(st->regmap, AD4691_STD_SEQ_CONFIG,
+			   BIT(chan->channel));
+	if (ret)
+		return ret;
+
+	ret = regmap_write(st->regmap, AD4691_ACC_MASK_REG,
+			   ~BIT(chan->channel) & GENMASK(15, 0));
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
+	osc_idx = FIELD_GET(AD4691_OSC_FREQ_MASK, reg_val);
+	/* Wait 2 oscillator periods for the conversion to complete. */
+	period_us = DIV_ROUND_UP(2UL * USEC_PER_SEC, ad4691_osc_freqs_Hz[osc_idx]);
+	fsleep(period_us);
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
+	struct ad4691_state *st = iio_priv(indio_dev);
+
+	IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
+	if (IIO_DEV_ACQUIRE_FAILED(claim))
+		return -EBUSY;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		return ad4691_set_sampling_freq(st, val);
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
+	.read_raw = ad4691_read_raw,
+	.write_raw = ad4691_write_raw,
+	.read_avail = ad4691_read_avail,
+	.debugfs_reg_access = ad4691_reg_access,
+};
+
+static int ad4691_regulator_setup(struct ad4691_state *st)
+{
+	struct device *dev = regmap_get_device(st->regmap);
+	int ret;
+
+	ret = devm_regulator_bulk_get_enable(dev, ARRAY_SIZE(ad4691_supplies),
+					     ad4691_supplies);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to get and enable supplies\n");
+
+	/*
+	 * vdd-supply and ldo-in-supply are mutually exclusive:
+	 *   vdd-supply present  → external 1.8V VDD; disable internal LDO.
+	 *   vdd-supply absent   → enable internal LDO fed from ldo-in-supply.
+	 * Having both simultaneously is strongly inadvisable per the datasheet.
+	 */
+	if (device_property_present(dev, "vdd-supply")) {
+		ret = devm_regulator_get_enable(dev, "vdd");
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "Failed to get and enable VDD\n");
+	} else if (device_property_present(dev, "ldo-in-supply")) {
+		ret = devm_regulator_get_enable(dev, "ldo-in");
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "Failed to get and enable LDO-IN\n");
+		st->ldo_en = true;
+	} else {
+		return dev_err_probe(dev, -EINVAL,
+				     "missing one of vdd-supply, ldo-in-supply\n");
+	}
+
+	if (device_property_present(dev, "ref-supply")) {
+		st->vref_uV = devm_regulator_get_enable_read_voltage(dev, "ref");
+		if (st->vref_uV < 0)
+			return dev_err_probe(dev, st->vref_uV,
+					     "Failed to get REF supply voltage\n");
+	} else if (device_property_present(dev, "refin-supply")) {
+		st->vref_uV = devm_regulator_get_enable_read_voltage(dev, "refin");
+		if (st->vref_uV < 0)
+			return dev_err_probe(dev, st->vref_uV,
+					     "Failed to get REFIN supply voltage\n");
+		st->refbuf_en = true;
+	} else {
+		return dev_err_probe(dev, -EINVAL,
+				     "missing one of ref-supply, refin-supply\n");
+	}
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
+	int ret;
+
+	rst = devm_reset_control_get_optional_exclusive(dev, NULL);
+	if (IS_ERR(rst))
+		return dev_err_probe(dev, PTR_ERR(rst), "Failed to get reset\n");
+
+	if (rst) {
+		/*
+		 * Assert the reset line to guarantee a clean reset pulse on
+		 * every probe, including driver reloads where the line may
+		 * already be deasserted (reset_control_put() does not
+		 * re-assert on release). tRESETL (minimum pulse width) = 10 ns
+		 * (Table 5); kernel function-call overhead alone exceeds this,
+		 * so no explicit delay is needed between assert and deassert.
+		 */
+		reset_control_assert(rst);
+		ret = reset_control_deassert(rst);
+		if (ret)
+			return ret;
+		/*
+		 * Wait tHWR = 300 µs (Table 5) for the device to complete its
+		 * internal reset sequence before accepting SPI commands.
+		 */
+		fsleep(300);
+		return 0;
+	}
+
+	/* No hardware reset available, fall back to software reset. */
+	ret = regmap_write(st->regmap, AD4691_SPI_CONFIG_A_REG, AD4691_SW_RESET);
+	if (ret)
+		return ret;
+	/*
+	 * Wait tSWR = 300 µs (Table 5) for the device to complete its
+	 * internal reset sequence before accepting SPI commands.
+	 */
+	fsleep(300);
+	return 0;
+}
+
+static int ad4691_config(struct ad4691_state *st)
+{
+	struct device *dev = regmap_get_device(st->regmap);
+	enum ad4691_ref_ctrl ref_val;
+	unsigned int val;
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
+	val = FIELD_PREP(AD4691_REF_CTRL_MASK, ref_val);
+	if (st->refbuf_en)
+		val |= AD4691_REFBUF_EN;
+
+	ret = regmap_write(st->regmap, AD4691_REF_CTRL, val);
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
+	ret = regmap_write(st->regmap, AD4691_OSC_FREQ_REG,
+			   ad4691_samp_freq_start(st->info));
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
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	st = iio_priv(indio_dev);
+	st->spi = spi;
+	st->info = spi_get_device_match_data(spi);
+	if (!st->info)
+		return -ENODEV;
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
+	indio_dev->channels = st->info->sw_info->channels;
+	indio_dev->num_channels = st->info->sw_info->num_channels;
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
+	{ .name = "ad4691", .driver_data = (kernel_ulong_t)&ad4691_chip_info },
+	{ .name = "ad4692", .driver_data = (kernel_ulong_t)&ad4692_chip_info },
+	{ .name = "ad4693", .driver_data = (kernel_ulong_t)&ad4693_chip_info },
+	{ .name = "ad4694", .driver_data = (kernel_ulong_t)&ad4694_chip_info },
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



