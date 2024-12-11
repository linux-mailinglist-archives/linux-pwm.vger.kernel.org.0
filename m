Return-Path: <linux-pwm+bounces-4327-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25A169ED7D2
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Dec 2024 21:58:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46F371889264
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Dec 2024 20:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF2E823A186;
	Wed, 11 Dec 2024 20:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Iw6RASGQ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC700239BA3
	for <linux-pwm@vger.kernel.org>; Wed, 11 Dec 2024 20:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733950526; cv=none; b=AQoPYFruUXdzVUilOqjRtJApdFPIkF4HAf8zp6uaSrLLzn/M26fV3xPOV2gyIXnu6mG/Nyc+Ci2bQ5a2YvFZ/oQEShCKwp0/Je5ohoBGuKWUp/Io13Y32KukXYeagj0o4my2B52HSqn/k6qnuleRiMAiLV5O6Qj1T77sRjBDdvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733950526; c=relaxed/simple;
	bh=onlfQFAhqm4q5VaPDuBTOll2HwT9uU8B4edUXhLPjF8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rCENayy8HBEydJe519xaTcijRqJoPwp/VcqbsDzOsBTMKQtYp52U8yrMYBO6zdAB+2M70Uw9FN9XRPyFrb5WqYu+usBs/CSRqiUWeBmD89jSceK7Sk+nMQ0tCmI4J+iiBuybnpx4ioxWW9zTrTYHgGzjEuWzlEKh+J9ApHtbfQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Iw6RASGQ; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5f2c34ae517so1359482eaf.1
        for <linux-pwm@vger.kernel.org>; Wed, 11 Dec 2024 12:55:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1733950523; x=1734555323; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D69OZhusuMhcaJTAF0Ez/mdxh3V91WiBTrdnxc++b0c=;
        b=Iw6RASGQv2EZuSS6p1kfXMQ8UwjmJKHw1vvk2iTNc8KSBE68ek4tRO1G3LuWO9SqCP
         0900uZha9T4IgeJTXjyVxtAMlYas1LwveG/HNQ4Rt5GzXmxIxsMEe9rxhTrK5n/6JPuV
         gLeZUuyyX1ssaKtTMV1oa2cm60pPtL5qxQL+4mk/1NBzJ5ZEYheJndSXybR9/JrpP8Ns
         4yl8FPsi+n5yYnUhNXa+7azTyjR4TEHp22DSSTJ8oqvtPawb5LqSN5RePpn2SMpNEQ4Z
         +ENEuNy7BlwStLUp/m6dus9vbVTiOUkpPveG109FJBfa1VvQb6FAeHUw9BvRiNmEcNJ7
         H9AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733950523; x=1734555323;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D69OZhusuMhcaJTAF0Ez/mdxh3V91WiBTrdnxc++b0c=;
        b=QcYna/1tfJw2nN7CtI4JUZYeDiVkalvNk4E41j4AFFO5eROrXxopIqgDH4VWiZd38Y
         FaIla0DF0ROr7qWJU5qgRJEf+6viqic+F/ie01NfYXA0i/EIRQqMBLdkrTqqEa06Jep7
         BpTa+iZMT+aivZInI+tzwl8nFuhuPSk9Yf2Vhrs7cNQ4hsnAQgEIbtZT1jCbDe2Ejs+z
         MUVbGKxGl/zr1W+BT9OUA6sYE/JoIZm1wu9iT6I+JN788MgIeR0mlEQXQ0bmljCE1Isd
         03B95qoHuUsWwLZCYJIMexxhbLvnXWBk+Yp/hy2ch9g854e8YGyB6eH1r0HkMfdWlS4H
         uQJw==
X-Forwarded-Encrypted: i=1; AJvYcCXahI3H/fB447DhOUKvqeCxZqVy9lyK8de+qSIAcbnU1DVLyluvcgpFjnxMoe2HlMcx9SkroJD4dqc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw971HvUAvQXPdfZaRH3QablSN1HIp9jJU4wOmmXyzEmT4jWDGn
	LQBMoAP9dyx0RBnz3wTEkSZF3j03s1BYiQG+o7W/aAaPrX3BVUFEznv7Vrc0wzTCf1LgHLYlAd+
	H
X-Gm-Gg: ASbGncudg25DgN+FOurkU/8qF2v85SAKpK2wbB9BQaSW3fuBKLyRBPORGsWT3i27Rf4
	oDUt5900rgpTZabXHwLKdcAFmV+SQDt9/ruK6rDwX+7vHCdCXnkTwdJcmHssfgW5h9cpLFnt/6o
	XtJEqH3g1OCaZhY5UoEnEAopuEnQaQaI/ME2Ny47bb32EshshBytBiJfcjx5WrajTKV8SMAWsPj
	Sn7tSqu9lwEx1sE2DoMcl/O9HlmSAKffO29UQKt7QmNCj3B1v0Bp/hM/2giejf8urkYk/3r0bnQ
	cv5hdS8EUw==
X-Google-Smtp-Source: AGHT+IGBIXY454f7GZ1lQjq3iUNIGvZBHebh7zOEqrscTMiEe9LHXa1hO0yDT4ODlKNIium4yriowg==
X-Received: by 2002:a05:6820:992:b0:5ee:e029:f797 with SMTP id 006d021491bc7-5f2efbaae2emr625858eaf.6.1733950523079;
        Wed, 11 Dec 2024 12:55:23 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71def651fb2sm1888288a34.27.2024.12.11.12.55.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 12:55:21 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 11 Dec 2024 14:54:51 -0600
Subject: [PATCH v6 14/17] iio: adc: ad4695: Add support for SPI offload
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241211-dlech-mainline-spi-engine-offload-2-v6-14-88ee574d5d03@baylibre.com>
References: <20241211-dlech-mainline-spi-engine-offload-2-v6-0-88ee574d5d03@baylibre.com>
In-Reply-To: <20241211-dlech-mainline-spi-engine-offload-2-v6-0-88ee574d5d03@baylibre.com>
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
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2

Add support for SPI offload to the ad4695 driver. SPI offload allows
sampling data at the max sample rate (500kSPS or 1MSPS).

This is developed and tested against the ADI example FPGA design for
this family of ADCs [1].

[1]: http://analogdevicesinc.github.io/hdl/projects/ad469x_fmc/index.html

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---

v6 changes:
* Fixed use of c++ style comments
* Moved static const struct definition out of probe function
* Changes bits_per_word to always be 19 for future oversampling
  compatibility (Trevor is working on implementing oversampling support
  on top of this patch, so we have high confidence this is the correct
  thing to do)
* Fixed wrong xfer->len

v5 changes:
* Register SCLK speed handling has been split out into a separate series.
* Add sampling_frequency_available attribute.
* Limit max allowed sampling frequency based on chip info.
* Expand explanations of offload enable/disable ordering requirements.
* Finish TODO to use macros for phandle arg values.
* Don't use dev_info() when falling back to non-offload operation.
* Update to accommodate changes in other patches in this series.

v4 changes: new patch in v4
---
 drivers/iio/adc/Kconfig  |   1 +
 drivers/iio/adc/ad4695.c | 445 +++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 429 insertions(+), 17 deletions(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 995b9cacbaa964d26424346120c139858f93cdcd..ec60b64c46e187e2be18ab1f8ca9e6f4f03299f9 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -52,6 +52,7 @@ config AD4695
 	tristate "Analog Device AD4695 ADC Driver"
 	depends on SPI
 	select IIO_BUFFER
+	select IIO_BUFFER_DMAENGINE
 	select IIO_TRIGGERED_BUFFER
 	select REGMAP
 	help
diff --git a/drivers/iio/adc/ad4695.c b/drivers/iio/adc/ad4695.c
index 13cf01d35301be40369571e7dd2aeac1a8148d15..c8cd73d19e869f11999608f61df5724d329b4427 100644
--- a/drivers/iio/adc/ad4695.c
+++ b/drivers/iio/adc/ad4695.c
@@ -19,14 +19,19 @@
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/gpio/consumer.h>
+#include <linux/iio/buffer-dmaengine.h>
 #include <linux/iio/buffer.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/triggered_buffer.h>
 #include <linux/iio/trigger_consumer.h>
 #include <linux/minmax.h>
+#include <linux/mutex.h>
 #include <linux/property.h>
+#include <linux/pwm.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
+#include <linux/spi/offload/consumer.h>
+#include <linux/spi/offload/provider.h>
 #include <linux/spi/spi.h>
 #include <linux/units.h>
 
@@ -66,6 +71,8 @@
 #define AD4695_REG_STD_SEQ_CONFIG			0x0024
 #define AD4695_REG_GPIO_CTRL				0x0026
 #define AD4695_REG_GP_MODE				0x0027
+#define   AD4695_REG_GP_MODE_BUSY_GP_SEL		  BIT(5)
+#define   AD4695_REG_GP_MODE_BUSY_GP_EN			  BIT(1)
 #define AD4695_REG_TEMP_CTRL				0x0029
 #define   AD4695_REG_TEMP_CTRL_TEMP_EN			  BIT(0)
 #define AD4695_REG_CONFIG_IN(n)				(0x0030 | (n))
@@ -124,13 +131,22 @@ struct ad4695_channel_config {
 
 struct ad4695_state {
 	struct spi_device *spi;
+	struct spi_offload *offload;
+	struct spi_offload_trigger *offload_trigger;
 	struct regmap *regmap;
 	struct regmap *regmap16;
 	struct gpio_desc *reset_gpio;
+	/* currently PWM CNV only supported with SPI offload use */
+	struct pwm_device *cnv_pwm;
+	/* protects against concurrent use of cnv_pwm */
+	struct mutex cnv_pwm_lock;
+	/* offload also requires separate gpio to manually control CNV */
+	struct gpio_desc *cnv_gpio;
 	/* voltages channels plus temperature and timestamp */
 	struct iio_chan_spec iio_chan[AD4695_MAX_CHANNELS + 2];
 	struct ad4695_channel_config channels_cfg[AD4695_MAX_CHANNELS];
 	const struct ad4695_chip_info *chip_info;
+	int sample_freq_range[3];
 	/* Reference voltage. */
 	unsigned int vref_mv;
 	/* Common mode input pin voltage. */
@@ -355,6 +371,13 @@ static const struct ad4695_chip_info ad4698_chip_info = {
 	.num_voltage_inputs = 8,
 };
 
+static void ad4695_cnv_manual_trigger(struct ad4695_state *st)
+{
+	gpiod_set_value_cansleep(st->cnv_gpio, 1);
+	ndelay(10);
+	gpiod_set_value_cansleep(st->cnv_gpio, 0);
+}
+
 /**
  * ad4695_set_single_cycle_mode - Set the device in single cycle mode
  * @st: The AD4695 state
@@ -460,6 +483,17 @@ static int ad4695_exit_conversion_mode(struct ad4695_state *st)
 	 */
 	st->cnv_cmd2 = AD4695_CMD_EXIT_CNV_MODE << 3;
 
+	if (st->cnv_gpio) {
+		ad4695_cnv_manual_trigger(st);
+
+		/*
+		 * In this case, CNV is not connected to CS, so we don't need
+		 * the extra CS toggle to trigger the conversion and toggling
+		 * CS would have no effect.
+		 */
+		return spi_sync_transfer(st->spi, &xfers[1], 1);
+	}
+
 	return spi_sync_transfer(st->spi, xfers, ARRAY_SIZE(xfers));
 }
 
@@ -687,6 +721,160 @@ static irqreturn_t ad4695_trigger_handler(int irq, void *p)
 	return IRQ_HANDLED;
 }
 
+static int ad4695_offload_buffer_postenable(struct iio_dev *indio_dev)
+{
+	struct ad4695_state *st = iio_priv(indio_dev);
+	struct spi_offload_trigger_config config = {
+		.type = SPI_OFFLOAD_TRIGGER_DATA_READY,
+	};
+	struct spi_transfer *xfer = &st->buf_read_xfer[0];
+	struct pwm_state state;
+	u8 temp_chan_bit = st->chip_info->num_voltage_inputs;
+	u8 num_slots = 0;
+	u8 temp_en = 0;
+	unsigned int bit;
+	int ret;
+
+	iio_for_each_active_channel(indio_dev, bit) {
+		if (bit == temp_chan_bit) {
+			temp_en = 1;
+			continue;
+		}
+
+		ret = regmap_write(st->regmap, AD4695_REG_AS_SLOT(num_slots),
+				   FIELD_PREP(AD4695_REG_AS_SLOT_INX, bit));
+		if (ret)
+			return ret;
+
+		num_slots++;
+	}
+
+	/*
+	 * For non-offload, we could discard data to work around this
+	 * restriction, but with offload, that is not possible.
+	 */
+	if (num_slots < 2) {
+		dev_err(&st->spi->dev,
+			"At least two voltage channels must be enabled.\n");
+		return -EINVAL;
+	}
+
+	ret = regmap_update_bits(st->regmap, AD4695_REG_TEMP_CTRL,
+				 AD4695_REG_TEMP_CTRL_TEMP_EN,
+				 FIELD_PREP(AD4695_REG_TEMP_CTRL_TEMP_EN,
+					    temp_en));
+	if (ret)
+		return ret;
+
+	/* Each BUSY event means just one sample for one channel is ready. */
+	memset(xfer, 0, sizeof(*xfer));
+	xfer->offload_flags = SPI_OFFLOAD_XFER_RX_STREAM;
+	/* Using 19 bits per word to allow for possible oversampling */
+	xfer->bits_per_word = 19;
+	xfer->len = 4;
+
+	spi_message_init_with_transfers(&st->buf_read_msg, xfer, 1);
+	st->buf_read_msg.offload = st->offload;
+
+	ret = spi_optimize_message(st->spi, &st->buf_read_msg);
+	if (ret)
+		return ret;
+
+	/*
+	 * NB: technically, this is part the SPI offload trigger enable, but it
+	 * doesn't work to call it from the offload trigger enable callback
+	 * because it requires accessing the SPI bus. Calling it from the
+	 * trigger enable callback could cause a deadlock.
+	 */
+	ret = regmap_set_bits(st->regmap, AD4695_REG_GP_MODE,
+			      AD4695_REG_GP_MODE_BUSY_GP_EN);
+	if (ret)
+		goto err_unoptimize_message;
+
+	ret = spi_offload_trigger_enable(st->offload, st->offload_trigger,
+					 &config);
+	if (ret)
+		goto err_disable_busy_output;
+
+	ret = ad4695_enter_advanced_sequencer_mode(st, num_slots);
+	if (ret)
+		goto err_offload_trigger_disable;
+
+	guard(mutex)(&st->cnv_pwm_lock);
+	pwm_get_state(st->cnv_pwm, &state);
+	/*
+	 * PWM subsystem generally rounds down, so requesting 2x minimum high
+	 * time ensures that we meet the minimum high time in any case.
+	 */
+	state.duty_cycle = AD4695_T_CNVH_NS * 2;
+	ret = pwm_apply_might_sleep(st->cnv_pwm, &state);
+	if (ret)
+		goto err_offload_exit_conversion_mode;
+
+	return 0;
+
+err_offload_exit_conversion_mode:
+	/*
+	 * We have to unwind in a different order to avoid triggering offload.
+	 * ad4695_exit_conversion_mode() triggers a conversion, so it has to be
+	 * done after spi_offload_trigger_disable().
+	 */
+	spi_offload_trigger_disable(st->offload, st->offload_trigger);
+	ad4695_exit_conversion_mode(st);
+	goto err_disable_busy_output;
+
+err_offload_trigger_disable:
+	spi_offload_trigger_disable(st->offload, st->offload_trigger);
+
+err_disable_busy_output:
+	regmap_clear_bits(st->regmap, AD4695_REG_GP_MODE,
+			  AD4695_REG_GP_MODE_BUSY_GP_EN);
+
+err_unoptimize_message:
+	spi_unoptimize_message(&st->buf_read_msg);
+
+	return ret;
+}
+
+static int ad4695_offload_buffer_predisable(struct iio_dev *indio_dev)
+{
+	struct ad4695_state *st = iio_priv(indio_dev);
+	struct pwm_state state;
+	int ret;
+
+	scoped_guard(mutex, &st->cnv_pwm_lock) {
+		pwm_get_state(st->cnv_pwm, &state);
+		state.duty_cycle = 0;
+		ret = pwm_apply_might_sleep(st->cnv_pwm, &state);
+		if (ret)
+			return ret;
+	}
+
+	spi_offload_trigger_disable(st->offload, st->offload_trigger);
+
+	/*
+	 * ad4695_exit_conversion_mode() triggers a conversion, so it has to be
+	 * done after spi_offload_trigger_disable().
+	 */
+	ret = ad4695_exit_conversion_mode(st);
+	if (ret)
+		return ret;
+
+	ret = regmap_clear_bits(st->regmap, AD4695_REG_GP_MODE,
+				AD4695_REG_GP_MODE_BUSY_GP_EN);
+	if (ret)
+		return ret;
+
+	spi_unoptimize_message(&st->buf_read_msg);
+
+	return 0;
+}
+
+static const struct iio_buffer_setup_ops ad4695_offload_buffer_setup_ops = {
+	.postenable = ad4695_offload_buffer_postenable,
+	.predisable = ad4695_offload_buffer_predisable,
+};
+
 /**
  * ad4695_read_one_sample - Read a single sample using single-cycle mode
  * @st: The AD4695 state
@@ -718,6 +906,13 @@ static int ad4695_read_one_sample(struct ad4695_state *st, unsigned int address)
 	if (ret)
 		return ret;
 
+	/*
+	 * If CNV is connected to CS, the previous function will have triggered
+	 * the conversion, otherwise, we do it manually.
+	 */
+	if (st->cnv_gpio)
+		ad4695_cnv_manual_trigger(st);
+
 	/*
 	 * Setting the first channel to the temperature channel isn't supported
 	 * in single-cycle mode, so we have to do an extra conversion to read
@@ -729,6 +924,13 @@ static int ad4695_read_one_sample(struct ad4695_state *st, unsigned int address)
 		ret = spi_sync_transfer(st->spi, xfers, ARRAY_SIZE(xfers));
 		if (ret)
 			return ret;
+
+		/*
+		 * If CNV is connected to CS, the previous function will have
+		 * triggered the conversion, otherwise, we do it manually.
+		 */
+		if (st->cnv_gpio)
+			ad4695_cnv_manual_trigger(st);
 	}
 
 	/* Then read the result and exit conversion mode. */
@@ -842,11 +1044,34 @@ static int ad4695_read_raw(struct iio_dev *indio_dev,
 		default:
 			return -EINVAL;
 		}
+	case IIO_CHAN_INFO_SAMP_FREQ: {
+		struct pwm_state state;
+
+		ret = pwm_get_state_hw(st->cnv_pwm, &state);
+		if (ret)
+			return ret;
+
+		*val = DIV_ROUND_UP_ULL(NSEC_PER_SEC, state.period);
+
+		return IIO_VAL_INT;
+	}
 	default:
 		return -EINVAL;
 	}
 }
 
+static int ad4695_write_raw_get_fmt(struct iio_dev *indio_dev,
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
 static int ad4695_write_raw(struct iio_dev *indio_dev,
 			    struct iio_chan_spec const *chan,
 			    int val, int val2, long mask)
@@ -900,6 +1125,17 @@ static int ad4695_write_raw(struct iio_dev *indio_dev,
 			default:
 				return -EINVAL;
 			}
+		case IIO_CHAN_INFO_SAMP_FREQ: {
+			struct pwm_state state;
+
+			if (val <= 0 || val > st->chip_info->max_sample_rate)
+				return -EINVAL;
+
+			guard(mutex)(&st->cnv_pwm_lock);
+			pwm_get_state(st->cnv_pwm, &state);
+			state.period = DIV_ROUND_UP_ULL(NSEC_PER_SEC, val);
+			return pwm_apply_might_sleep(st->cnv_pwm, &state);
+		}
 		default:
 			return -EINVAL;
 		}
@@ -923,6 +1159,7 @@ static int ad4695_read_avail(struct iio_dev *indio_dev,
 		 */
 		S16_MIN / 4, 0, 0, MICRO / 4, S16_MAX / 4, S16_MAX % 4 * MICRO / 4
 	};
+	struct ad4695_state *st = iio_priv(indio_dev);
 
 	switch (mask) {
 	case IIO_CHAN_INFO_CALIBSCALE:
@@ -943,6 +1180,10 @@ static int ad4695_read_avail(struct iio_dev *indio_dev,
 		default:
 			return -EINVAL;
 		}
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*vals = st->sample_freq_range;
+		*type = IIO_VAL_INT;
+		return IIO_AVAIL_RANGE;
 	default:
 		return -EINVAL;
 	}
@@ -978,6 +1219,7 @@ static int ad4695_debugfs_reg_access(struct iio_dev *indio_dev,
 
 static const struct iio_info ad4695_info = {
 	.read_raw = &ad4695_read_raw,
+	.write_raw_get_fmt = &ad4695_write_raw_get_fmt,
 	.write_raw = &ad4695_write_raw,
 	.read_avail = &ad4695_read_avail,
 	.debugfs_reg_access = &ad4695_debugfs_reg_access,
@@ -1091,26 +1333,166 @@ static int ad4695_parse_channel_cfg(struct ad4695_state *st)
 	return 0;
 }
 
+static bool ad4695_offload_trigger_match(struct spi_offload_trigger *trigger,
+					 enum spi_offload_trigger_type type,
+					 u64 *args, u32 nargs)
+{
+	if (type != SPI_OFFLOAD_TRIGGER_DATA_READY)
+		return false;
+
+	/*
+	 * Requires 2 args:
+	 * args[0] is the trigger event.
+	 * args[1] is the GPIO pin number.
+	 */
+	if (nargs != 2 || args[0] != AD4695_TRIGGER_EVENT_BUSY)
+		return false;
+
+	return true;
+}
+
+static int ad4695_offload_trigger_request(struct spi_offload_trigger *trigger,
+					  enum spi_offload_trigger_type type,
+					  u64 *args, u32 nargs)
+{
+	struct ad4695_state *st = spi_offload_trigger_get_priv(trigger);
+
+	/* Should already be validated by match, but just in case. */
+	if (nargs != 2)
+		return -EINVAL;
+
+	/* DT tells us if BUSY event uses GP0 or GP3. */
+	if (args[1] == AD4695_TRIGGER_PIN_GP3)
+		return regmap_set_bits(st->regmap, AD4695_REG_GP_MODE,
+				       AD4695_REG_GP_MODE_BUSY_GP_SEL);
+
+	return regmap_clear_bits(st->regmap, AD4695_REG_GPIO_CTRL,
+				 AD4695_REG_GP_MODE_BUSY_GP_SEL);
+}
+
+static int
+ad4695_offload_trigger_validate(struct spi_offload_trigger *trigger,
+				struct spi_offload_trigger_config *config)
+{
+	if (config->type != SPI_OFFLOAD_TRIGGER_DATA_READY)
+		return -EINVAL;
+
+	return 0;
+}
+
+/*
+ * NB: There are no enable/disable callbacks here due to requiring a SPI
+ * message to enable or disable the BUSY output on the ADC.
+ */
+static const struct spi_offload_trigger_ops ad4695_offload_trigger_ops = {
+	.match = ad4695_offload_trigger_match,
+	.request = ad4695_offload_trigger_request,
+	.validate = ad4695_offload_trigger_validate,
+};
+
+static void ad4695_pwm_disable(void *pwm)
+{
+	pwm_disable(pwm);
+}
+
+static int ad4695_probe_spi_offload(struct iio_dev *indio_dev,
+				    struct ad4695_state *st)
+{
+	struct device *dev = &st->spi->dev;
+	struct spi_offload_trigger_info trigger_info = {
+		.fwnode = dev_fwnode(dev),
+		.ops = &ad4695_offload_trigger_ops,
+		.priv = st,
+	};
+	struct pwm_state pwm_state;
+	struct dma_chan *rx_dma;
+	int ret, i;
+
+	indio_dev->num_channels = st->chip_info->num_voltage_inputs + 1;
+	indio_dev->setup_ops = &ad4695_offload_buffer_setup_ops;
+
+	if (!st->cnv_gpio)
+		return dev_err_probe(dev, -ENODEV,
+				     "CNV GPIO is required for SPI offload\n");
+
+	ret = devm_spi_offload_trigger_register(dev, &trigger_info);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "failed to register offload trigger\n");
+
+	st->offload_trigger = devm_spi_offload_trigger_get(dev, st->offload,
+		SPI_OFFLOAD_TRIGGER_DATA_READY);
+	if (IS_ERR(st->offload_trigger))
+		return dev_err_probe(dev, PTR_ERR(st->offload_trigger),
+				     "failed to get offload trigger\n");
+
+	ret = devm_mutex_init(dev, &st->cnv_pwm_lock);
+	if (ret)
+		return ret;
+
+	st->cnv_pwm = devm_pwm_get(dev, NULL);
+	if (IS_ERR(st->cnv_pwm))
+		return dev_err_probe(dev, PTR_ERR(st->cnv_pwm),
+				     "failed to get CNV PWM\n");
+
+	pwm_init_state(st->cnv_pwm, &pwm_state);
+
+	/* If firmware didn't provide default rate, use 10kHz (arbitrary). */
+	if (pwm_state.period == 0)
+		pwm_state.period = 100 * MILLI;
+
+	pwm_state.enabled = true;
+
+	ret = pwm_apply_might_sleep(st->cnv_pwm, &pwm_state);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to apply CNV PWM\n");
+
+	ret = devm_add_action_or_reset(dev, ad4695_pwm_disable, st->cnv_pwm);
+	if (ret)
+		return ret;
+
+	rx_dma = devm_spi_offload_rx_stream_request_dma_chan(dev, st->offload);
+	if (IS_ERR(rx_dma))
+		return dev_err_probe(dev, PTR_ERR(rx_dma),
+				     "failed to get offload RX DMA\n");
+
+	for (i = 0; i < indio_dev->num_channels; i++) {
+		struct iio_chan_spec *chan = &st->iio_chan[i];
+
+		/*
+		 * NB: When using offload support, all channels need to have the
+		 * same bits_per_word because they all use the same SPI message
+		 * for reading one sample. In order to prevent breaking
+		 * userspace in the future when oversampling support is added,
+		 * all channels are set read 19 bits with a shift of 3 to mask
+		 * out the extra bits even though we currently only support 16
+		 * bit samples (oversampling ratio == 1).
+		 */
+		chan->scan_type.shift = 3;
+		chan->scan_type.storagebits = 32;
+		/* add sample frequency for PWM CNV trigger */
+		chan->info_mask_separate |= BIT(IIO_CHAN_INFO_SAMP_FREQ);
+		chan->info_mask_separate_available |= BIT(IIO_CHAN_INFO_SAMP_FREQ);
+	}
+
+	return devm_iio_dmaengine_buffer_setup_with_handle(dev, indio_dev,
+		rx_dma, IIO_BUFFER_DIRECTION_IN);
+}
+
+static const struct spi_offload_config ad4695_spi_offload_config = {
+	.capability_flags = SPI_OFFLOAD_CAP_TRIGGER |
+			    SPI_OFFLOAD_CAP_RX_STREAM_DMA,
+};
+
 static int ad4695_probe(struct spi_device *spi)
 {
 	struct device *dev = &spi->dev;
 	struct ad4695_state *st;
 	struct iio_dev *indio_dev;
-	struct gpio_desc *cnv_gpio;
 	bool use_internal_ldo_supply;
 	bool use_internal_ref_buffer;
 	int ret;
 
-	cnv_gpio = devm_gpiod_get_optional(dev, "cnv", GPIOD_OUT_LOW);
-	if (IS_ERR(cnv_gpio))
-		return dev_err_probe(dev, PTR_ERR(cnv_gpio),
-				     "Failed to get CNV GPIO\n");
-
-	/* Driver currently requires CNV pin to be connected to SPI CS */
-	if (cnv_gpio)
-		return dev_err_probe(dev, -ENODEV,
-				     "CNV GPIO is not supported\n");
-
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
 	if (!indio_dev)
 		return -ENOMEM;
@@ -1122,6 +1504,10 @@ static int ad4695_probe(struct spi_device *spi)
 	if (!st->chip_info)
 		return -EINVAL;
 
+	st->sample_freq_range[0] = 1; /* min */
+	st->sample_freq_range[1] = 1; /* step */
+	st->sample_freq_range[2] = st->chip_info->max_sample_rate; /* max */
+
 	st->regmap = devm_regmap_init(dev, &ad4695_regmap_bus, st,
 				      &ad4695_regmap_config);
 	if (IS_ERR(st->regmap))
@@ -1134,6 +1520,11 @@ static int ad4695_probe(struct spi_device *spi)
 		return dev_err_probe(dev, PTR_ERR(st->regmap16),
 				     "Failed to initialize regmap16\n");
 
+	st->cnv_gpio = devm_gpiod_get_optional(dev, "cnv", GPIOD_OUT_LOW);
+	if (IS_ERR(st->cnv_gpio))
+		return dev_err_probe(dev, PTR_ERR(st->cnv_gpio),
+				     "Failed to get CNV GPIO\n");
+
 	ret = devm_regulator_bulk_get_enable(dev,
 					     ARRAY_SIZE(ad4695_power_supplies),
 					     ad4695_power_supplies);
@@ -1261,12 +1652,31 @@ static int ad4695_probe(struct spi_device *spi)
 	indio_dev->channels = st->iio_chan;
 	indio_dev->num_channels = st->chip_info->num_voltage_inputs + 2;
 
-	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
-					      iio_pollfunc_store_time,
-					      ad4695_trigger_handler,
-					      &ad4695_buffer_setup_ops);
-	if (ret)
-		return ret;
+	st->offload = devm_spi_offload_get(dev, spi, &ad4695_spi_offload_config);
+	ret = PTR_ERR_OR_ZERO(st->offload);
+	if (ret && ret != -ENODEV)
+		return dev_err_probe(dev, ret, "failed to get SPI offload\n");
+
+	/* If no SPI offload, fall back to low speed usage. */
+	if (ret == -ENODEV) {
+		/* Driver currently requires CNV pin to be connected to SPI CS */
+		if (st->cnv_gpio)
+			return dev_err_probe(dev, -EINVAL,
+					     "CNV GPIO is not supported\n");
+
+		indio_dev->num_channels = st->chip_info->num_voltage_inputs + 2;
+
+		ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
+						      iio_pollfunc_store_time,
+						      ad4695_trigger_handler,
+						      &ad4695_buffer_setup_ops);
+		if (ret)
+			return ret;
+	} else {
+		ret = ad4695_probe_spi_offload(indio_dev, st);
+		if (ret)
+			return ret;
+	}
 
 	return devm_iio_device_register(dev, indio_dev);
 }
@@ -1303,3 +1713,4 @@ MODULE_AUTHOR("Ramona Gradinariu <ramona.gradinariu@analog.com>");
 MODULE_AUTHOR("David Lechner <dlechner@baylibre.com>");
 MODULE_DESCRIPTION("Analog Devices AD4695 ADC driver");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("IIO_DMAENGINE_BUFFER");

-- 
2.43.0


