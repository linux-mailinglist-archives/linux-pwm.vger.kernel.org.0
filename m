Return-Path: <linux-pwm+bounces-3789-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 497EB9AD62C
	for <lists+linux-pwm@lfdr.de>; Wed, 23 Oct 2024 23:02:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E08EB23AB8
	for <lists+linux-pwm@lfdr.de>; Wed, 23 Oct 2024 21:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7254F204F72;
	Wed, 23 Oct 2024 20:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="n6i647jU"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29697202623
	for <linux-pwm@vger.kernel.org>; Wed, 23 Oct 2024 20:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729717196; cv=none; b=kfEOrd9Bcij/OnwOVBy7S6jdtsXgXAoifztQUDscOBuQiMmbEEA/b762PeyqCNR5XLEzT9jXWEWo7qDNh+MoznI2SCIrFvkTteKDpJXzkwrWv71/Xu/CSbliaNTrLBanyCwu4jrbk2pD53FRN7XjQtwTahhChiIvyWmcxuF8FKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729717196; c=relaxed/simple;
	bh=pfaM/qCZp/7RrJRQByE9+Fl0yQHeVPFno4H9YJjhgqY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y1eH5niu+qFpYebijUzCMLIqC59d1yVsx0PFAa6IT7C6Qvfl140cRoJv/j9rIStHtInztEy6pTZK/O4yuJJRe/ERHaPFSU6yRdpEsaLeVQ3vWxRUPvzpu4p07PkJMaBKn1OWMtoPDp/J0XRFkn9YSeoY/rIm/qdumYgtNsSyPRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=n6i647jU; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5e5b5715607so131440eaf.1
        for <linux-pwm@vger.kernel.org>; Wed, 23 Oct 2024 13:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729717193; x=1730321993; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zawaNnQ/tIDSblfd6yVLzHckf/0fbTuRKMQ9RIWxWz0=;
        b=n6i647jU+UcpqtF1SBDbk359Q5VtrPImqx89BCPxS8h6RvDg6LftxATbQk4ull42BP
         +n7jvBvn9/sIpsqanPOUYklZUBOVUTQR83v8p4geY06Tt7jrPNtXFFdr6K4ZCitb0cRH
         3ejNWNcVSCjy7EPlM0uCGhdUnr869RaTwY0hNo2cN5h6ve8C4QC9M5cv1Jc1JPE1NGVx
         4U9xZVX4BHtyR8VuhLajyRJo77T0cxFBYoTjsarxuNjKZ9TCBi/P2XRSgEllFX708zpo
         y7Lq7jWXLGZulmcRBXqxmQcfhs9Bx7I2WOKLviAT92PIHsRbJi2aJEFDsQ0KsJK8AIGE
         ibgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729717193; x=1730321993;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zawaNnQ/tIDSblfd6yVLzHckf/0fbTuRKMQ9RIWxWz0=;
        b=k+uBpCZH9j2BWm3NN7pE+hDIJzQKh4po9uwgZ872POwewBcF72iiELHiYCF7OtsE51
         R+pjy5e+oHVhgKF8GeyhAUItVrZILBIrfT54ZWcWLRTIhwIyVbtPxjU+yIn0iahZxCq4
         s9EsWkYwY9szyw9KhMvnDVw6I1fPqzZz4hqWmQ/bOzXOmOve4RTD7TyrjQ/xJA6M93Dm
         zDRGSpgmfkZ/V6bA3Tf1txYcZsTincz2Z4Xtl1yfezyN+ECI4pRKTuzq/rcUvFfYpxe9
         yYodlHrigodG4FoC+2zoQjE1+1xU7rChYX1zDRJ+s6nSJuea8I5+oRO5R6JlXkFyvPmE
         hn/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWNmk8To2RmGMiM8n2GqLEkkUaleYsjmRs7RV1/XMOsGP+c1mDT8pxVhKYgNE4I14B6jZgriZ8ztgs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbsLWZsIeeDQQek+SjoLmuqW2AdY0+y0HpA5VYQ9nNzpG7woxp
	r1hya8A6z7aAomXNJXKsBrupFUobrQtpFBBgZDiNAg6MGpHQ2eHQ69AHS9vf4Ds=
X-Google-Smtp-Source: AGHT+IFWW95edUGhfU3qExtoaLye6C6MtgstZi0ufDn2VZvcRopsiuFPCUaukguXyRmg4R+u8FRDLg==
X-Received: by 2002:a4a:bd98:0:b0:5eb:d48d:f172 with SMTP id 006d021491bc7-5ebd86b8577mr4431800eaf.3.1729717193232;
        Wed, 23 Oct 2024 13:59:53 -0700 (PDT)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5ec02c2c157sm52730eaf.44.2024.10.23.13.59.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 13:59:51 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 23 Oct 2024 15:59:20 -0500
Subject: [PATCH RFC v4 13/15] iio: adc: ad7944: add support for SPI offload
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241023-dlech-mainline-spi-engine-offload-2-v4-13-f8125b99f5a1@baylibre.com>
References: <20241023-dlech-mainline-spi-engine-offload-2-v4-0-f8125b99f5a1@baylibre.com>
In-Reply-To: <20241023-dlech-mainline-spi-engine-offload-2-v4-0-f8125b99f5a1@baylibre.com>
To: Mark Brown <broonie@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, David Jander <david@protonic.nl>, 
 Martin Sperl <kernel@martin.sperl.org>, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, linux-pwm@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.1

This adds support for SPI offload to the ad7944 driver. This allows
reading data at the max sample rate of 2.5 MSPS.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---

v4 changes:
* Adapted to changes in other patches.
* Add new separate channel spec for when using SPI offload.
* Fixed some nitpicks.

v3 changes:
* Finished TODOs.
* Adapted to changes in other patches.

v2 changes:

In the previous version, there was a new separate driver for the PWM
trigger and DMA hardware buffer. This was deemed too complex so they
are moved into the ad7944 driver.

It has also been reworked to accommodate for the changes described in
the other patches.
---
 drivers/iio/adc/Kconfig  |   1 +
 drivers/iio/adc/ad7944.c | 233 ++++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 222 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 179d83aafd8a..92dfb495a8ce 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -346,6 +346,7 @@ config AD7923
 config AD7944
 	tristate "Analog Devices AD7944 and similar ADCs driver"
 	depends on SPI
+	select SPI_OFFLOAD
 	select IIO_BUFFER
 	select IIO_TRIGGERED_BUFFER
 	help
diff --git a/drivers/iio/adc/ad7944.c b/drivers/iio/adc/ad7944.c
index 6d1202bd55a0..52005bd3174c 100644
--- a/drivers/iio/adc/ad7944.c
+++ b/drivers/iio/adc/ad7944.c
@@ -16,11 +16,14 @@
 #include <linux/module.h>
 #include <linux/property.h>
 #include <linux/regulator/consumer.h>
+#include <linux/spi/spi-offload.h>
 #include <linux/spi/spi.h>
 #include <linux/string_helpers.h>
+#include <linux/units.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
+#include <linux/iio/buffer-dmaengine.h>
 #include <linux/iio/trigger_consumer.h>
 #include <linux/iio/triggered_buffer.h>
 
@@ -54,6 +57,11 @@ struct ad7944_adc {
 	enum ad7944_spi_mode spi_mode;
 	struct spi_transfer xfers[3];
 	struct spi_message msg;
+	struct spi_transfer offload_xfers[2];
+	struct spi_message offload_msg;
+	struct spi_offload *offload;
+	struct spi_offload_trigger *offload_trigger;
+	unsigned long offload_trigger_hz;
 	void *chain_mode_buf;
 	/* Chip-specific timing specifications. */
 	const struct ad7944_timing_spec *timing_spec;
@@ -81,6 +89,8 @@ struct ad7944_adc {
 
 /* quite time before CNV rising edge */
 #define AD7944_T_QUIET_NS	20
+/* minimum CNV high time to trigger conversion */
+#define AD7944_T_CNVH_NS	10
 
 static const struct ad7944_timing_spec ad7944_timing_spec = {
 	.conv_ns = 420,
@@ -96,6 +106,7 @@ struct ad7944_chip_info {
 	const char *name;
 	const struct ad7944_timing_spec *timing_spec;
 	const struct iio_chan_spec channels[2];
+	const struct iio_chan_spec offload_channels[1];
 };
 
 /* get number of bytes for SPI xfer */
@@ -129,6 +140,24 @@ static const struct ad7944_chip_info _name##_chip_info = {		\
 		},							\
 		IIO_CHAN_SOFT_TIMESTAMP(1),				\
 	},								\
+	/* basically the same minus soft timestamp plus sampling freq */\
+	.offload_channels = {						\
+		{							\
+			.type = IIO_VOLTAGE,				\
+			.indexed = 1,					\
+			.differential = _diff,				\
+			.channel = 0,					\
+			.channel2 = _diff ? 1 : 0,			\
+			.scan_index = 0,				\
+			.scan_type.sign = _diff ? 's' : 'u',		\
+			.scan_type.realbits = _bits,			\
+			.scan_type.storagebits = 32,			\
+			.scan_type.endianness = IIO_CPU,		\
+			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW)	\
+					| BIT(IIO_CHAN_INFO_SCALE)	\
+					| BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
+		},							\
+	},								\
 }
 
 /* pseudo-differential with ground sense */
@@ -239,6 +268,48 @@ static int ad7944_chain_mode_init_msg(struct device *dev, struct ad7944_adc *adc
 	return devm_spi_optimize_message(dev, adc->spi, &adc->msg);
 }
 
+/*
+ * Unlike ad7944_3wire_cs_mode_init_msg(), this creates a message that reads
+ * during the conversion phase instead of the acquisition phase when reading
+ * a sample from the ADC. This is needed to be able to read at the maximum
+ * sample rate. It requires the SPI controller to have offload support and a
+ * high enough SCLK rate to read the sample during the conversion phase.
+ */
+static int ad7944_3wire_cs_mode_init_offload_msg(struct device *dev,
+						 struct ad7944_adc *adc,
+						 const struct iio_chan_spec *chan)
+{
+	struct spi_transfer *xfers = adc->offload_xfers;
+	int ret;
+
+	/*
+	 * CS is tied to CNV and we need a low to high transition to start the
+	 * conversion, so place CNV low for t_QUIET to prepare for this.
+	 */
+	xfers[0].delay.value = AD7944_T_QUIET_NS;
+	xfers[0].delay.unit = SPI_DELAY_UNIT_NSECS;
+	/* CNV has to be high for a minimum time to trigger conversion. */
+	xfers[0].cs_change = 1;
+	xfers[0].cs_change_delay.value = AD7944_T_CNVH_NS;
+	xfers[0].cs_change_delay.unit = SPI_DELAY_UNIT_NSECS;
+
+	/* Then we can read the previous sample during the conversion phase */
+	xfers[1].offload_flags = SPI_OFFLOAD_XFER_RX_STREAM;
+	xfers[1].len = AD7944_SPI_BYTES(chan->scan_type);
+	xfers[1].bits_per_word = chan->scan_type.realbits;
+
+	spi_message_init_with_transfers(&adc->offload_msg, xfers,
+					ARRAY_SIZE(adc->offload_xfers));
+
+	adc->offload_msg.offload = adc->offload;
+
+	ret = devm_spi_optimize_message(dev, adc->spi, &adc->offload_msg);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to prepare offload msg\n");
+
+	return 0;
+}
+
 /**
  * ad7944_convert_and_acquire - Perform a single conversion and acquisition
  * @adc: The ADC device structure
@@ -326,6 +397,46 @@ static int ad7944_read_raw(struct iio_dev *indio_dev,
 			return -EINVAL;
 		}
 
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*val = adc->offload_trigger_hz;
+		return IIO_VAL_INT;
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ad7944_set_sample_freq(struct ad7944_adc *adc, int val)
+{
+	struct spi_offload_trigger_config config = {
+		.type = SPI_OFFLOAD_TRIGGER_PERIODIC,
+		.periodic = {
+			.frequency_hz = val,
+		},
+	};
+	int ret;
+
+	ret = spi_offload_trigger_validate(adc->offload_trigger, &config);
+	if (ret)
+		return ret;
+
+	adc->offload_trigger_hz = config.periodic.frequency_hz;
+
+	return 0;
+}
+
+static int ad7944_write_raw(struct iio_dev *indio_dev,
+			    const struct iio_chan_spec *chan,
+			    int val, int val2, long info)
+{
+	struct ad7944_adc *adc = iio_priv(indio_dev);
+
+	switch (info) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		if (val < 0 || val2 < 0)
+			return -EINVAL;
+
+		return ad7944_set_sample_freq(adc, val);
 	default:
 		return -EINVAL;
 	}
@@ -333,6 +444,43 @@ static int ad7944_read_raw(struct iio_dev *indio_dev,
 
 static const struct iio_info ad7944_iio_info = {
 	.read_raw = &ad7944_read_raw,
+	.write_raw = &ad7944_write_raw,
+};
+
+static int ad7944_offload_buffer_postenable(struct iio_dev *indio_dev)
+{
+	struct ad7944_adc *adc = iio_priv(indio_dev);
+	struct spi_offload_trigger_config config = {
+		.type = SPI_OFFLOAD_TRIGGER_PERIODIC,
+		.periodic = {
+			.frequency_hz = adc->offload_trigger_hz,
+		},
+	};
+	int ret;
+
+	gpiod_set_value_cansleep(adc->turbo, 1);
+
+	ret = spi_offload_trigger_enable(adc->offload, adc->offload_trigger,
+					 &config);
+	if (ret)
+		gpiod_set_value_cansleep(adc->turbo, 0);
+
+	return ret;
+}
+
+static int ad7944_offload_buffer_predisable(struct iio_dev *indio_dev)
+{
+	struct ad7944_adc *adc = iio_priv(indio_dev);
+
+	spi_offload_trigger_disable(adc->offload, adc->offload_trigger);
+	gpiod_set_value_cansleep(adc->turbo, 0);
+
+	return 0;
+}
+
+static const struct iio_buffer_setup_ops ad7944_offload_buffer_setup_ops = {
+	.postenable = &ad7944_offload_buffer_postenable,
+	.predisable = &ad7944_offload_buffer_predisable,
 };
 
 static irqreturn_t ad7944_trigger_handler(int irq, void *p)
@@ -446,6 +594,11 @@ static const char * const ad7944_power_supplies[] = {
 	"avdd",	"dvdd",	"bvdd", "vio"
 };
 
+static const struct spi_offload_config ad7944_offload_config = {
+	.capability_flags = SPI_OFFLOAD_CAP_TRIGGER |
+			    SPI_OFFLOAD_CAP_RX_STREAM_DMA,
+};
+
 static int ad7944_probe(struct spi_device *spi)
 {
 	const struct ad7944_chip_info *chip_info;
@@ -590,20 +743,75 @@ static int ad7944_probe(struct spi_device *spi)
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &ad7944_iio_info;
 
-	if (adc->spi_mode == AD7944_SPI_MODE_CHAIN) {
-		indio_dev->available_scan_masks = chain_scan_masks;
-		indio_dev->channels = chain_chan;
-		indio_dev->num_channels = n_chain_dev + 1;
+	adc->offload = devm_spi_offload_get(dev, spi, &ad7944_offload_config);
+	ret = PTR_ERR_OR_ZERO(adc->offload);
+	if (ret && ret != -ENODEV)
+		return dev_err_probe(dev, ret, "failed to get offload\n");
+
+	if (ret == -ENODEV) {
+		dev_info(dev, "SPI offload not available\n");
+
+		if (adc->spi_mode == AD7944_SPI_MODE_CHAIN) {
+			indio_dev->available_scan_masks = chain_scan_masks;
+			indio_dev->channels = chain_chan;
+			indio_dev->num_channels = n_chain_dev + 1;
+		} else {
+			indio_dev->channels = chip_info->channels;
+			indio_dev->num_channels = ARRAY_SIZE(chip_info->channels);
+		}
+
+		ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
+						      iio_pollfunc_store_time,
+						      ad7944_trigger_handler,
+						      NULL);
+		if (ret)
+			return ret;
 	} else {
-		indio_dev->channels = chip_info->channels;
-		indio_dev->num_channels = ARRAY_SIZE(chip_info->channels);
-	}
+		struct dma_chan *rx_dma;
 
-	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
-					      iio_pollfunc_store_time,
-					      ad7944_trigger_handler, NULL);
-	if (ret)
-		return ret;
+		if (adc->spi_mode != AD7944_SPI_MODE_SINGLE)
+			return dev_err_probe(dev, -EINVAL,
+				"offload only supported in single mode\n");
+
+		indio_dev->setup_ops = &ad7944_offload_buffer_setup_ops;
+		indio_dev->channels = chip_info->offload_channels;
+		indio_dev->num_channels = ARRAY_SIZE(chip_info->offload_channels);
+
+		adc->offload_trigger = devm_spi_offload_trigger_get(dev,
+			adc->offload, SPI_OFFLOAD_TRIGGER_PERIODIC);
+		if (IS_ERR(adc->offload_trigger))
+			return dev_err_probe(dev, PTR_ERR(adc->offload_trigger),
+					     "failed to get offload trigger\n");
+
+		ret = ad7944_set_sample_freq(adc, 2 * MEGA);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "failed to init sample rate\n");
+
+		rx_dma = devm_spi_offload_rx_stream_request_dma_chan(dev,
+								     adc->offload);
+		if (IS_ERR(rx_dma))
+			return dev_err_probe(dev, PTR_ERR(rx_dma),
+					     "failed to get offload RX DMA\n");
+
+		/*
+		 * REVISIT: ideally, we would confirm that the offload RX DMA
+		 * buffer layout is the same as what is hard-coded in
+		 * offload_channels. Right now, the only supported offload
+		 * is the pulsar_adc project which always uses 32-bit word
+		 * size for data values, regardless of the SPI bits per word.
+		 */
+
+		ret = devm_iio_dmaengine_buffer_setup_ext2(
+			dev, indio_dev, rx_dma, IIO_BUFFER_DIRECTION_IN);
+		if (ret)
+			return ret;
+
+		ret = ad7944_3wire_cs_mode_init_offload_msg(dev, adc,
+			&chip_info->offload_channels[0]);
+		if (ret)
+			return ret;
+	}
 
 	return devm_iio_device_register(dev, indio_dev);
 }
@@ -638,3 +846,4 @@ module_spi_driver(ad7944_driver);
 MODULE_AUTHOR("David Lechner <dlechner@baylibre.com>");
 MODULE_DESCRIPTION("Analog Devices AD7944 PulSAR ADC family driver");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(IIO_DMAENGINE_BUFFER);

-- 
2.43.0


