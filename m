Return-Path: <linux-pwm+bounces-4621-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9856CA0C33A
	for <lists+linux-pwm@lfdr.de>; Mon, 13 Jan 2025 22:04:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4B2F168B50
	for <lists+linux-pwm@lfdr.de>; Mon, 13 Jan 2025 21:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CFE31FC7CE;
	Mon, 13 Jan 2025 21:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="aewhOC9m"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559181D5ADC
	for <linux-pwm@vger.kernel.org>; Mon, 13 Jan 2025 21:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736802077; cv=none; b=eKz3AZpdcMlC1RB21YSOGgPcZ+wdAJRXG58abn5ESaVOE2l1py2Wun3v9vqLk4V3fVA9yhD/g6ODE8PS1gNXS3wZHj/hMX5X4InNgatH/I83wAbBPS9ZxSwLYyQHgh5DPK4p7HlmOeFLzvZnet/xMqyJkm1TBjLyynTSidTKuDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736802077; c=relaxed/simple;
	bh=VjnhHll/OJ7MvQ7X87mHVdGjGGFGKfjfrLs/98CvvVM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=udn0Pum+MdLMr3LJQdGa1MqjBTYQeOtpb1T4ftCP4Tn90gDXi0+p4VzrjCEakM74xF+OX5rstB8D84sPt2g1GhsHufsene4P2HwkrBl3JHjM++AyZZXNaFJ7wIfJa9SnwxJieaGU/g6ePodl0dg3A53DhuCCTANb7Y5t5beWxNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=aewhOC9m; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-71ded02b779so2536371a34.2
        for <linux-pwm@vger.kernel.org>; Mon, 13 Jan 2025 13:01:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1736802071; x=1737406871; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ut553xAl4qrxbnk0QZzc/W+Fhixkn3BLwHaZPLvysyc=;
        b=aewhOC9mUbd+MeowPQ492fvWzQ+ZGVv0SLpbeMlZnqOWKWjJQkuSHe1TFslhiV8zb6
         /MnCbbZpSf0vo6d7GHbYaROq0emcgX7luXMc49JwvFZOj18ch7Iflykr16ZsPAtswXdc
         F6r3jMff85ywVjFGmNZ5BstpEIxlFtYb8PVJ3AS5zlMkfNYiyvLZe2tE6fedfu8i7vzB
         mHCVcnI3N+NjpU1tFmyqDONLiFhMEJp3Pd8TsAH9AXj6fYZOTMCM9n2cEmLMuzBQ2VpF
         EKboghZBtVPokmlNKcOPYys3/I8PoqzO+Vji504JehWTyZs7/aB4BdQ+fMuXg924z+60
         SRNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736802071; x=1737406871;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ut553xAl4qrxbnk0QZzc/W+Fhixkn3BLwHaZPLvysyc=;
        b=AiHQikrOxaUPaKv2f1CYBuXlsghZ/d0a7/67pul7Q6wDCw4mV6KdGVdcp8ivnlGYqd
         fDF4/tSvhgSW0eL+AGIbX721ItO0P3DqzZ8m2DypcsBx/Te4oigdBuTERApVa8MERrqs
         TX6TF+WSsmbroBJMsfwi+lonPI7qBYj60TIxhyIm2kOcCikxyxkU2QLd9haQAXbTW6Za
         XsFNkhmONNhIlR99sFNhAHpxqDl4RCWbsKRb5jBFt72xat0H0WAM0Z2vpkYUHh9c/tQL
         /n+p3w8JACJZV34I2rE0COGWXwsVwS0OXUHwQr6LvkIDd+Ky9sR4aWB27rVjz7q97hQD
         m5JQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGl7yh5hKq63qHC5JyJWBPRNPjc3qUpLQ1c1j1YbWFw4hLP97Wf9kuzYvpgL76Vh/D1LhKkDkIG/M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2BYqkABbm9zHmEt6vlVM65p9qC2mOCSoxENoUrun/3qH0yizn
	EtLY3KrE8Yhb8bvhhH7PU+z54kUbZ1g0BAqEJbWIHgBZcB3USLMd02JyxapmGnU=
X-Gm-Gg: ASbGncsUTu4KyRi66nR/sjUSOIRZFeO6kAIdULN5wHIJV3ZTFUFLgLZaliWZoc+Rj+m
	Ys7OMe7tL1vHboU0IB+HIslpGP46IDaNkk/PbBySpG1uadZHboH442whS/dEPPTryAxhMECYu1L
	TnnzqG43YW4u+TRsyhYZwu+Rx/mHzR/t4YkqUe6lRv5LA2GcYIipxbp9XPeaXjeHpFflamBuGli
	PeogN7srThiCnqho9Vv11QNYt2zLm2ML/BF4acDYWIBinV/svirdlIH3/jFImKsyR3fz1P2Tcb/
	kqmdWFz6ZFIT
X-Google-Smtp-Source: AGHT+IHrB6vSbspWOk3Rx9IKrNZYhVIur8SbVj/M6Ygov49+hczQXsqAhEvexS5+SvuMDkJrDQpqaQ==
X-Received: by 2002:a05:6830:6509:b0:718:a52:e1cc with SMTP id 46e09a7af769-721e2ecc7e6mr15932371a34.25.1736802071421;
        Mon, 13 Jan 2025 13:01:11 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7231855effasm3927744a34.33.2025.01.13.13.01.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 13:01:11 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 13 Jan 2025 15:00:22 -0600
Subject: [PATCH v7 17/17] iio: dac: ad5791: Add offload support
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250113-dlech-mainline-spi-engine-offload-2-v7-17-e0860c81caae@baylibre.com>
References: <20250113-dlech-mainline-spi-engine-offload-2-v7-0-e0860c81caae@baylibre.com>
In-Reply-To: <20250113-dlech-mainline-spi-engine-offload-2-v7-0-e0860c81caae@baylibre.com>
To: Mark Brown <broonie@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Cc: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, David Jander <david@protonic.nl>, 
 Martin Sperl <kernel@martin.sperl.org>, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, linux-pwm@vger.kernel.org, 
 Axel Haslam <ahaslam@baylibre.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2

From: Axel Haslam <ahaslam@baylibre.com>

Add SPI offload support to stream TX buffers using DMA.
This allows loading samples to the DAC with a rate of 1 MSPS.

Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Nuno Sa <nuno.sa@analog.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---

v7 changes:
* Removed extra space character.
* Added write_raw_get_fmt callback to avoid having to check val2.
* Don't allow sampling frequency of 0 Hz.

v6 changes: new patch in v6
---
 drivers/iio/dac/Kconfig  |   3 +
 drivers/iio/dac/ad5791.c | 163 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 166 insertions(+)

diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
index 5690a37267d86ea3ec805adfa32e13c052864061..4811ea973125a0dea1f8a9cdee1e0c045bc21981 100644
--- a/drivers/iio/dac/Kconfig
+++ b/drivers/iio/dac/Kconfig
@@ -296,6 +296,9 @@ config AD5770R
 config AD5791
 	tristate "Analog Devices AD5760/AD5780/AD5781/AD5790/AD5791 DAC SPI driver"
 	depends on SPI
+	select SPI_OFFLOAD
+	select IIO_BUFFER
+	select IIO_BUFFER_DMAENGINE
 	help
 	  Say yes here to build support for Analog Devices AD5760, AD5780,
 	  AD5781, AD5790, AD5791 High Resolution Voltage Output Digital to
diff --git a/drivers/iio/dac/ad5791.c b/drivers/iio/dac/ad5791.c
index 24462cb020e19e8e2c6faa13109ac047cf423c37..aacbd22af13c63a44ddd855330dd935dc77f3731 100644
--- a/drivers/iio/dac/ad5791.c
+++ b/drivers/iio/dac/ad5791.c
@@ -15,9 +15,12 @@
 #include <linux/module.h>
 #include <linux/regulator/consumer.h>
 #include <linux/slab.h>
+#include <linux/spi/offload/consumer.h>
 #include <linux/spi/spi.h>
 #include <linux/sysfs.h>
+#include <linux/units.h>
 
+#include <linux/iio/buffer-dmaengine.h>
 #include <linux/iio/dac/ad5791.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
@@ -64,11 +67,13 @@
  * struct ad5791_chip_info - chip specific information
  * @name:		name of the dac chip
  * @channel:		channel specification
+ * @channel_offload:	channel specification for offload
  * @get_lin_comp:	function pointer to the device specific function
  */
 struct ad5791_chip_info {
 	const char *name;
 	const struct iio_chan_spec channel;
+	const struct iio_chan_spec channel_offload;
 	int (*get_lin_comp)(unsigned int span);
 };
 
@@ -81,6 +86,11 @@ struct ad5791_chip_info {
  * @gpio_clear:		clear gpio
  * @gpio_ldac:		load dac gpio
  * @chip_info:		chip model specific constants
+ * @offload_msg:	spi message used for offload
+ * @offload_xfer:	spi transfer used for offload
+ * @offload:		offload device
+ * @offload_trigger:	offload trigger
+ * @offload_trigger_hz:	offload sample rate
  * @vref_mv:		actual reference voltage used
  * @vref_neg_mv:	voltage of the negative supply
  * @ctrl:		control register cache
@@ -96,6 +106,11 @@ struct ad5791_state {
 	struct gpio_desc		*gpio_clear;
 	struct gpio_desc		*gpio_ldac;
 	const struct ad5791_chip_info	*chip_info;
+	struct spi_message		offload_msg;
+	struct spi_transfer		offload_xfer;
+	struct spi_offload		*offload;
+	struct spi_offload_trigger	*offload_trigger;
+	unsigned int			offload_trigger_hz;
 	unsigned short			vref_mv;
 	unsigned int			vref_neg_mv;
 	unsigned			ctrl;
@@ -232,6 +247,25 @@ static int ad5780_get_lin_comp(unsigned int span)
 		return AD5780_LINCOMP_10_20;
 }
 
+static int ad5791_set_sample_freq(struct ad5791_state *st, int val)
+{
+	struct spi_offload_trigger_config config = {
+		.type = SPI_OFFLOAD_TRIGGER_PERIODIC,
+		.periodic = {
+			.frequency_hz = val,
+		},
+	};
+	int ret;
+
+	ret = spi_offload_trigger_validate(st->offload_trigger, &config);
+	if (ret)
+		return ret;
+
+	st->offload_trigger_hz = config.periodic.frequency_hz;
+
+	return 0;
+}
+
 static int ad5791_read_raw(struct iio_dev *indio_dev,
 			   struct iio_chan_spec const *chan,
 			   int *val,
@@ -259,6 +293,9 @@ static int ad5791_read_raw(struct iio_dev *indio_dev,
 		do_div(val64, st->vref_mv);
 		*val = -val64;
 		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*val = st->offload_trigger_hz;
+		return IIO_VAL_INT;
 	default:
 		return -EINVAL;
 	}
@@ -299,6 +336,24 @@ static const struct ad5791_chip_info _name##_chip_info = {		\
 			},						\
 			.ext_info = ad5791_ext_info,			\
 	},								\
+	.channel_offload = {						\
+			.type = IIO_VOLTAGE,				\
+			.output = 1,					\
+			.indexed = 1,					\
+			.address = AD5791_ADDR_DAC0,			\
+			.channel = 0,					\
+			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),	\
+			.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |	\
+				BIT(IIO_CHAN_INFO_OFFSET),		\
+			.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),\
+			.scan_type = {					\
+				.sign = 'u',				\
+				.realbits = (bits),			\
+				.storagebits = 32,			\
+				.shift = (_shift),			\
+			},						\
+			.ext_info = ad5791_ext_info,			\
+	},								\
 }
 
 AD5791_DEFINE_CHIP_INFO(ad5760, 16, 4, ad5780_get_lin_comp);
@@ -322,14 +377,106 @@ static int ad5791_write_raw(struct iio_dev *indio_dev,
 
 		return ad5791_spi_write(st, chan->address, val);
 
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		if (val < 1)
+			return -EINVAL;
+		return ad5791_set_sample_freq(st, val);
 	default:
 		return -EINVAL;
 	}
 }
 
+static int ad5791_write_raw_get_fmt(struct iio_dev *indio_dev,
+				    struct iio_chan_spec const *chan,
+				    long mask)
+{
+	switch (mask) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		return IIO_VAL_INT;
+	default:
+		return IIO_VAL_INT_PLUS_MICRO;
+	}
+}
+
+static int ad5791_buffer_preenable(struct iio_dev *indio_dev)
+{
+	struct ad5791_state *st = iio_priv(indio_dev);
+	struct spi_offload_trigger_config config = {
+		.type = SPI_OFFLOAD_TRIGGER_PERIODIC,
+		.periodic = {
+			.frequency_hz = st->offload_trigger_hz,
+		},
+	};
+
+	if (st->pwr_down)
+		return -EINVAL;
+
+	return spi_offload_trigger_enable(st->offload, st->offload_trigger,
+					 &config);
+}
+
+static int ad5791_buffer_postdisable(struct iio_dev *indio_dev)
+{
+	struct ad5791_state *st = iio_priv(indio_dev);
+
+	spi_offload_trigger_disable(st->offload, st->offload_trigger);
+
+	return 0;
+}
+
+static const struct iio_buffer_setup_ops ad5791_buffer_setup_ops = {
+	.preenable = &ad5791_buffer_preenable,
+	.postdisable = &ad5791_buffer_postdisable,
+};
+
+static int ad5791_offload_setup(struct iio_dev *indio_dev)
+{
+	struct ad5791_state *st = iio_priv(indio_dev);
+	struct spi_device *spi = st->spi;
+	struct dma_chan *tx_dma;
+	int ret;
+
+	st->offload_trigger = devm_spi_offload_trigger_get(&spi->dev,
+		st->offload, SPI_OFFLOAD_TRIGGER_PERIODIC);
+	if (IS_ERR(st->offload_trigger))
+		return dev_err_probe(&spi->dev, PTR_ERR(st->offload_trigger),
+				     "failed to get offload trigger\n");
+
+	ret = ad5791_set_sample_freq(st, 1 * MEGA);
+	if (ret)
+		return dev_err_probe(&spi->dev, ret,
+				     "failed to init sample rate\n");
+
+	tx_dma = devm_spi_offload_tx_stream_request_dma_chan(&spi->dev,
+							     st->offload);
+	if (IS_ERR(tx_dma))
+		return dev_err_probe(&spi->dev, PTR_ERR(tx_dma),
+				     "failed to get offload TX DMA\n");
+
+	ret = devm_iio_dmaengine_buffer_setup_with_handle(&spi->dev,
+		indio_dev, tx_dma, IIO_BUFFER_DIRECTION_OUT);
+	if (ret)
+		return ret;
+
+	st->offload_xfer.len = 4;
+	st->offload_xfer.bits_per_word = 24;
+	st->offload_xfer.offload_flags = SPI_OFFLOAD_XFER_TX_STREAM;
+
+	spi_message_init_with_transfers(&st->offload_msg, &st->offload_xfer, 1);
+	st->offload_msg.offload = st->offload;
+
+	return devm_spi_optimize_message(&spi->dev, st->spi, &st->offload_msg);
+}
+
 static const struct iio_info ad5791_info = {
 	.read_raw = &ad5791_read_raw,
 	.write_raw = &ad5791_write_raw,
+	.write_raw_get_fmt = &ad5791_write_raw_get_fmt,
+};
+
+static const struct spi_offload_config ad5791_offload_config = {
+	.capability_flags = SPI_OFFLOAD_CAP_TRIGGER |
+			    SPI_OFFLOAD_CAP_TX_STREAM_DMA,
 };
 
 static int ad5791_probe(struct spi_device *spi)
@@ -416,6 +563,21 @@ static int ad5791_probe(struct spi_device *spi)
 	indio_dev->channels = &st->chip_info->channel;
 	indio_dev->num_channels = 1;
 	indio_dev->name = st->chip_info->name;
+
+	st->offload = devm_spi_offload_get(&spi->dev, spi, &ad5791_offload_config);
+	ret = PTR_ERR_OR_ZERO(st->offload);
+	if (ret && ret != -ENODEV)
+		return dev_err_probe(&spi->dev, ret, "failed to get offload\n");
+
+	if (ret != -ENODEV) {
+		indio_dev->channels = &st->chip_info->channel_offload;
+		indio_dev->setup_ops = &ad5791_buffer_setup_ops;
+		ret = ad5791_offload_setup(indio_dev);
+		if (ret)
+			return dev_err_probe(&spi->dev, ret,
+					     "fail to setup offload\n");
+	}
+
 	return devm_iio_device_register(&spi->dev, indio_dev);
 }
 
@@ -452,3 +614,4 @@ module_spi_driver(ad5791_driver);
 MODULE_AUTHOR("Michael Hennerich <michael.hennerich@analog.com>");
 MODULE_DESCRIPTION("Analog Devices AD5760/AD5780/AD5781/AD5790/AD5791 DAC");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS("IIO_DMAENGINE_BUFFER");

-- 
2.43.0


