Return-Path: <linux-pwm+bounces-4092-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36B039CF5F3
	for <lists+linux-pwm@lfdr.de>; Fri, 15 Nov 2024 21:25:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2791CB35253
	for <lists+linux-pwm@lfdr.de>; Fri, 15 Nov 2024 20:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A93A1F9422;
	Fri, 15 Nov 2024 20:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Xajit6dE"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA871F77B3
	for <linux-pwm@vger.kernel.org>; Fri, 15 Nov 2024 20:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731701949; cv=none; b=esooaMXA7cNzzVg2w6yxgHydaiC/9rHJLcplybxniq0zQO2k+MutnFvjlVPNz2TLbTgaMF+qildkWG9nQ08S4MRgSOcPuYTaf1RJGVNutJe3Csoyd9el3iYeirdu6k3Wlf+/N5Z53Mp5Rtb+c/69tgAJ7++brO5SKutjdhOpMA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731701949; c=relaxed/simple;
	bh=K1HoU/1E/QUQRe3UVXF/+K4ECGHjub1lJwvbHWp9jQc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QBMNhs1RQ2f7L49kJEQAr9Ax4WT0heVOSO8Fzy8ENg1yWbdpd+QjlCzutbnArUArYK7MZM8y/jmcD1oBBhbLaRw869VuEGfaPF4ulRRAkGqt9hJ0j0RLGrd5alxtNH2PP2nPSrxeQmZrnsDj5onQTa1EXLdvqUH8uoWmO/OP3VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Xajit6dE; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-28854674160so485898fac.2
        for <linux-pwm@vger.kernel.org>; Fri, 15 Nov 2024 12:19:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1731701946; x=1732306746; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L3Uuz3QqVS6gHnYak4A3GWg09WNjnuXwNWm39DAev2Y=;
        b=Xajit6dE9krQf9FCU3AeSVxnpFHLJDo37RsZjPC0dqDcA9aSeW2N+WOuYhWNWsaLs0
         s8j0kv5Ilp49IzZTNFCJ8j76rZYUv8yfFyaASbrx5sfzNDMEhnwDQjrI6FT9TBBxpwRA
         mB7hVrE8TeYHq+sgJGtBJCKjJpolZSy/twX43wxPybtEYR3Ag/9Hst1dz1MEczdbM1Rc
         niIPo/RRXcpPqVUgrmcMngPr9rnrZuQaUUEBJo5VT2zj28+5EPvOCbBQF2zaBrYbE05k
         O6M/VogMX2EmDi8lb/EuBHMCQ4JhBXX74dvXSJNHoYDoiAgQ/9OdYIip3tYcxR3VkfMg
         8qIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731701946; x=1732306746;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L3Uuz3QqVS6gHnYak4A3GWg09WNjnuXwNWm39DAev2Y=;
        b=jqxNrq9HcKklrvXEpg8WzFvxtphDF5CSaUG1gbovZ4e32kv9X3ljFPnKRpx3fIO2d9
         FukM30Gr+0jtjn2Wuj/eqHC7nNMFbXok5+IrcFctqRMH7n/JL0t3X4ZJEJXOShfDr2SO
         dsubb00SY4UiZ4bAv+ho29fCI6BkZwe1lYAd4uIwbcWTE363vI6IKH9M/Q9WyU/lEmeF
         QN3TPvPL2oHUVnH88Y7heKYxXk6CjCj71KrHK+9reur82/QIAhsPeQ5zGrH4x/sFuHk4
         p+2LXyDFyqAnC3vsnyVg8gT3GnHMgzUfJPC5U9Foa5mDyd5HzBOxVyW25I6GT4E9PbAR
         2rmA==
X-Forwarded-Encrypted: i=1; AJvYcCVt53PtewI/bV3kZB0qMTwEzZIfvqmOnX9CqrZhSCvgNtX1X0ZgSKwEnEiAHsswNKOQtyVpNvDYRPc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhinUbwREQinbcJi7RhY5hLi77n8yJhQwsIE3y6LHWrSLNKg3W
	JI4JxRlzVbC99kLsma+FkWIkMWJzWYgA1b3ZMCj6fGV34MEPgM6MSLjOCq8zOCs=
X-Google-Smtp-Source: AGHT+IGilfQALzlUaRjQKAeJdDuhDXJ/hfaTiTpgfDtaWkXIRakHM2UbjucZmhQBeuZED8qGnKiPZA==
X-Received: by 2002:a05:6870:1d1a:b0:288:559d:5b5c with SMTP id 586e51a60fabf-2962e01d26emr3417404fac.34.1731701946232;
        Fri, 15 Nov 2024 12:19:06 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71a780ea62esm748978a34.5.2024.11.15.12.19.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 12:19:05 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 15 Nov 2024 14:18:51 -0600
Subject: [PATCH v5 12/16] iio: adc: ad7944: add support for SPI offload
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241115-dlech-mainline-spi-engine-offload-2-v5-12-bea815bd5ea5@baylibre.com>
References: <20241115-dlech-mainline-spi-engine-offload-2-v5-0-bea815bd5ea5@baylibre.com>
In-Reply-To: <20241115-dlech-mainline-spi-engine-offload-2-v5-0-bea815bd5ea5@baylibre.com>
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
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.1

This adds support for SPI offload to the ad7944 driver. This allows
reading data at the max sample rate of 2.5 MSPS.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---

v5 changes:
* Remove dev_info() message.
* Implement sampling_frequency_available attribute.
* Limit max sample rate to chip-specific value.

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
 drivers/iio/adc/ad7944.c | 281 ++++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 266 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index a3e8ac569ce4..995b9cacbaa9 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -360,6 +360,7 @@ config AD7923
 config AD7944
 	tristate "Analog Devices AD7944 and similar ADCs driver"
 	depends on SPI
+	select SPI_OFFLOAD
 	select IIO_BUFFER
 	select IIO_TRIGGERED_BUFFER
 	help
diff --git a/drivers/iio/adc/ad7944.c b/drivers/iio/adc/ad7944.c
index 6d1202bd55a0..f5237db06b1e 100644
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
 
@@ -54,6 +57,12 @@ struct ad7944_adc {
 	enum ad7944_spi_mode spi_mode;
 	struct spi_transfer xfers[3];
 	struct spi_message msg;
+	struct spi_transfer offload_xfers[2];
+	struct spi_message offload_msg;
+	struct spi_offload *offload;
+	struct spi_offload_trigger *offload_trigger;
+	unsigned long offload_trigger_hz;
+	int sample_freq_range[3];
 	void *chain_mode_buf;
 	/* Chip-specific timing specifications. */
 	const struct ad7944_timing_spec *timing_spec;
@@ -81,6 +90,8 @@ struct ad7944_adc {
 
 /* quite time before CNV rising edge */
 #define AD7944_T_QUIET_NS	20
+/* minimum CNV high time to trigger conversion */
+#define AD7944_T_CNVH_NS	10
 
 static const struct ad7944_timing_spec ad7944_timing_spec = {
 	.conv_ns = 420,
@@ -95,7 +106,9 @@ static const struct ad7944_timing_spec ad7986_timing_spec = {
 struct ad7944_chip_info {
 	const char *name;
 	const struct ad7944_timing_spec *timing_spec;
+	u32 max_sample_rate_hz;
 	const struct iio_chan_spec channels[2];
+	const struct iio_chan_spec offload_channels[1];
 };
 
 /* get number of bytes for SPI xfer */
@@ -105,13 +118,15 @@ struct ad7944_chip_info {
  * AD7944_DEFINE_CHIP_INFO - Define a chip info structure for a specific chip
  * @_name: The name of the chip
  * @_ts: The timing specification for the chip
+ * @_max: The maximum sample rate in Hz
  * @_bits: The number of bits in the conversion result
  * @_diff: Whether the chip is true differential or not
  */
-#define AD7944_DEFINE_CHIP_INFO(_name, _ts, _bits, _diff)		\
+#define AD7944_DEFINE_CHIP_INFO(_name, _ts, _max, _bits, _diff)		\
 static const struct ad7944_chip_info _name##_chip_info = {		\
 	.name = #_name,							\
 	.timing_spec = &_ts##_timing_spec,				\
+	.max_sample_rate_hz = _max,					\
 	.channels = {							\
 		{							\
 			.type = IIO_VOLTAGE,				\
@@ -129,13 +144,33 @@ static const struct ad7944_chip_info _name##_chip_info = {		\
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
+			.info_mask_separate_available =			\
+				BIT(IIO_CHAN_INFO_SAMP_FREQ),		\
+		},							\
+	},								\
 }
 
 /* pseudo-differential with ground sense */
-AD7944_DEFINE_CHIP_INFO(ad7944, ad7944, 14, 0);
-AD7944_DEFINE_CHIP_INFO(ad7985, ad7944, 16, 0);
+AD7944_DEFINE_CHIP_INFO(ad7944, ad7944, 2.5 * MEGA, 14, 0);
+AD7944_DEFINE_CHIP_INFO(ad7985, ad7944, 2.5 * MEGA, 16, 0);
 /* fully differential */
-AD7944_DEFINE_CHIP_INFO(ad7986, ad7986, 18, 1);
+AD7944_DEFINE_CHIP_INFO(ad7986, ad7986, 2 * MEGA, 18, 1);
 
 static int ad7944_3wire_cs_mode_init_msg(struct device *dev, struct ad7944_adc *adc,
 					 const struct iio_chan_spec *chan)
@@ -239,6 +274,48 @@ static int ad7944_chain_mode_init_msg(struct device *dev, struct ad7944_adc *adc
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
@@ -294,6 +371,23 @@ static int ad7944_single_conversion(struct ad7944_adc *adc,
 	return IIO_VAL_INT;
 }
 
+static int ad7944_read_avail(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     const int **vals, int *type, int *length,
+			     long mask)
+{
+	struct ad7944_adc *adc = iio_priv(indio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*vals = adc->sample_freq_range;
+		*type = IIO_VAL_INT;
+		return IIO_AVAIL_RANGE;
+	default:
+		return -EINVAL;
+	}
+}
+
 static int ad7944_read_raw(struct iio_dev *indio_dev,
 			   const struct iio_chan_spec *chan,
 			   int *val, int *val2, long info)
@@ -326,13 +420,104 @@ static int ad7944_read_raw(struct iio_dev *indio_dev,
 			return -EINVAL;
 		}
 
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*val = adc->offload_trigger_hz;
+		return IIO_VAL_INT;
+
 	default:
 		return -EINVAL;
 	}
 }
 
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
+		if (val < 1 || val > adc->sample_freq_range[2])
+			return -EINVAL;
+
+		return ad7944_set_sample_freq(adc, val);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ad7944_write_raw_get_fmt(struct iio_dev *indio_dev,
+				    const struct iio_chan_spec *chan,
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
 static const struct iio_info ad7944_iio_info = {
+	.read_avail = &ad7944_read_avail,
 	.read_raw = &ad7944_read_raw,
+	.write_raw = &ad7944_write_raw,
+	.write_raw_get_fmt = &ad7944_write_raw_get_fmt,
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
@@ -446,6 +631,11 @@ static const char * const ad7944_power_supplies[] = {
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
@@ -471,6 +661,10 @@ static int ad7944_probe(struct spi_device *spi)
 
 	adc->timing_spec = chip_info->timing_spec;
 
+	adc->sample_freq_range[0] = 1; /* min */
+	adc->sample_freq_range[1] = 1; /* step */
+	adc->sample_freq_range[2] = chip_info->max_sample_rate_hz; /* max */
+
 	ret = device_property_match_property_string(dev, "adi,spi-mode",
 						    ad7944_spi_modes,
 						    ARRAY_SIZE(ad7944_spi_modes));
@@ -590,20 +784,74 @@ static int ad7944_probe(struct spi_device *spi)
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
+	/* Fall back to low speed usage when no SPI offload available. */
+	if (ret == -ENODEV) {
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
@@ -638,3 +886,4 @@ module_spi_driver(ad7944_driver);
 MODULE_AUTHOR("David Lechner <dlechner@baylibre.com>");
 MODULE_DESCRIPTION("Analog Devices AD7944 PulSAR ADC family driver");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(IIO_DMAENGINE_BUFFER);

-- 
2.43.0


