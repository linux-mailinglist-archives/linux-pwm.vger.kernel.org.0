Return-Path: <linux-pwm+bounces-3791-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB1AC9AD634
	for <lists+linux-pwm@lfdr.de>; Wed, 23 Oct 2024 23:03:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDE621C20C6F
	for <lists+linux-pwm@lfdr.de>; Wed, 23 Oct 2024 21:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D97D205AAC;
	Wed, 23 Oct 2024 21:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="bAMCips6"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2D6205E32
	for <linux-pwm@vger.kernel.org>; Wed, 23 Oct 2024 21:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729717203; cv=none; b=nbBhik1+Oi5mCFb/QP4wtoOan3FbofLSmbmgvc0vZu5+X8thBLmAnAZm+Z9cvPJwgtTQg34U8/odPMUBKwrGabC4uz7LtiEzus9X0gLZ9PwXuf2UM/N0Z3a4IjtEzmTlsA/aq6sd4MHWcYqh0d0bA9EswN+di9FQFzVJKI2WRas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729717203; c=relaxed/simple;
	bh=yNmOcChsKq4/9GgjRbr9ryWwkcaHw6cRDMeIchBwwRM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eJYFP1HvAterYF2hWHWzPtGB5Kkb9yww3/e6xHrqJ56zsZjdfLa50ZvwJpbWiDuWfo6gmzP4/+kPQ/vcFJ8ep2/7SMQBmE3lLVUY8VKDfm4I4J9ni5z1aroCyI90mOBW3Jj3LOsmMVqrXdm7AXkGZeYuPIydKCH6uUaAdZGHbkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=bAMCips6; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5e5b5715607so131485eaf.1
        for <linux-pwm@vger.kernel.org>; Wed, 23 Oct 2024 14:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729717199; x=1730321999; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NpqewWkBeL5YA+0h8Tu2l8PEEwW8v5sVkJknMJkiYMA=;
        b=bAMCips633jgJEawwY/nQ8bXGmPfvVDC4w3VlpXYU0EkEACP7j/BlkJ740wQamWwEB
         NGPIHyNYB53JuHAE2FPtG+xpI3j3k7HQIV2d+Jqsuqj7FoxEj5hdNvAR6idVLmfpuA+1
         iBP3M9nRzw5qG0yf23cnpL+StfQCYnL+RU1eLDvV+1wMEz2rg8xRo++s9lSWBHfVBQwV
         fRsTM1o+GagHK5ulNtyv4COKrPupm7m6qGstsYmIf7X54GOiXzvBtSIPFlxsiTgypv9A
         3VegU4r1SwwRDJmjJyKLHJwBXe2h6IUL70ftMMIK6HrnKuLVSxsvZIGoETJvYgapQ/jx
         4tOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729717199; x=1730321999;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NpqewWkBeL5YA+0h8Tu2l8PEEwW8v5sVkJknMJkiYMA=;
        b=lptpsZHZ+CDwjoKFDjM4E9yb9elRvjfxWv7FXH05DUTNj9wAKPA4MmlYVOSq9QtzpU
         OIH394Mef0uzn0hwPd6ViQH2QMWGkhJYnHBHauweERuNfk7Pbog97TSrGuKH5zzf9ghY
         rE85YzB2iALlugAnZ3fMCK21VTQctWLHo9AAHWCUTf0DPbFRn9J6RiMFOZvWj9unT8Hl
         y36B2nRbR1PXO67GQcNOotOJk6kwmBvBKbSTI/CJ42nHcru8u8i8+8hGG0cyh2ls+c0q
         kKpOeido7N7UlQ9E6YAE8dG4wftP9a2OGlBp/72MBGUtMP6RWcCO88XZ265L+CeQDR12
         dD4Q==
X-Forwarded-Encrypted: i=1; AJvYcCW8wewAYuJPZdbcbHVE5xXh9cD51JA2gFVIuWre26XTHeFeiqM2SidPIDTkzGHtBKYI3IN/KFOv+wg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgS1wTKq5BwuixoRz2t6l4atTsA+0aZpq0YDjUW2xRfd0zUH2D
	EL9V7b6da5qN4smlVEdd/Ap5rhcynIgfSxOnnS9Z3TGlYBKeic1us5JWo5WpxLQ=
X-Google-Smtp-Source: AGHT+IEq8xTH1knR1qZber5eXHa4hS9/pMfWY5RtrwXk/Ht06SeRlMq6G/tOoUSvZ9OAaxDSBg1lsw==
X-Received: by 2002:a05:6820:160d:b0:5eb:6b3e:ce7f with SMTP id 006d021491bc7-5ebedeb15f8mr2185894eaf.0.1729717199564;
        Wed, 23 Oct 2024 13:59:59 -0700 (PDT)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5ec02c2c157sm52730eaf.44.2024.10.23.13.59.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 13:59:58 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 23 Oct 2024 15:59:22 -0500
Subject: [PATCH RFC v4 15/15] iio: adc: ad4695: Add support for SPI offload
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241023-dlech-mainline-spi-engine-offload-2-v4-15-f8125b99f5a1@baylibre.com>
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

Add support for SPI offload to the ad4695 driver. SPI offload allows
sampling data at the max sample rate (500kSPS or 1MSPS).

This is developed and tested against the ADI example FPGA design for
this family of ADCs [1].

[1]: http://analogdevicesinc.github.io/hdl/projects/ad469x_fmc/index.html

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/Kconfig  |   1 +
 drivers/iio/adc/ad4695.c | 470 +++++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 440 insertions(+), 31 deletions(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 92dfb495a8ce..f76a3f62a9ad 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -53,6 +53,7 @@ config AD4695
 	depends on SPI
 	select REGMAP_SPI
 	select IIO_BUFFER
+	select IIO_BUFFER_DMAENGINE
 	select IIO_TRIGGERED_BUFFER
 	help
 	  Say yes here to build support for Analog Devices AD4695 and similar
diff --git a/drivers/iio/adc/ad4695.c b/drivers/iio/adc/ad4695.c
index 595ec4158e73..c150851d1fb1 100644
--- a/drivers/iio/adc/ad4695.c
+++ b/drivers/iio/adc/ad4695.c
@@ -19,14 +19,18 @@
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
+#include <linux/spi/spi-offload.h>
 #include <linux/spi/spi.h>
 #include <linux/units.h>
 
@@ -66,6 +70,8 @@
 #define AD4695_REG_STD_SEQ_CONFIG			0x0024
 #define AD4695_REG_GPIO_CTRL				0x0026
 #define AD4695_REG_GP_MODE				0x0027
+#define   AD4695_REG_GP_MODE_BUSY_GP_SEL		  BIT(5)
+#define   AD4695_REG_GP_MODE_BUSY_GP_EN			  BIT(1)
 #define AD4695_REG_TEMP_CTRL				0x0029
 #define   AD4695_REG_TEMP_CTRL_TEMP_EN			  BIT(0)
 #define AD4695_REG_CONFIG_IN(n)				(0x0030 | (n))
@@ -87,6 +93,7 @@
 
 /* timing specs */
 #define AD4695_T_CONVERT_NS		415
+#define AD4695_T_CNVH_NS		10
 #define AD4695_T_WAKEUP_HW_MS		3
 #define AD4695_T_WAKEUP_SW_MS		3
 #define AD4695_T_REFBUF_MS		100
@@ -121,9 +128,18 @@ struct ad4695_channel_config {
 
 struct ad4695_state {
 	struct spi_device *spi;
+	struct spi_offload *offload;
+	struct spi_offload_trigger *offload_trigger;
+	u32 spi_max_speed_hz;
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
@@ -571,6 +587,167 @@ static irqreturn_t ad4695_trigger_handler(int irq, void *p)
 	return IRQ_HANDLED;
 }
 
+static void ad4695_cnv_manual_trigger(struct ad4695_state *st)
+{
+	gpiod_set_value_cansleep(st->cnv_gpio, 1);
+	ndelay(10);
+	gpiod_set_value_cansleep(st->cnv_gpio, 0);
+}
+
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
+	xfer->bits_per_word = 16;
+	xfer->len = 2;
+
+	spi_message_init_with_transfers(&st->buf_read_msg, xfer, 1);
+	st->buf_read_msg.offload = st->offload;
+
+	st->spi->max_speed_hz = st->spi_max_speed_hz;
+	ret = spi_optimize_message(st->spi, &st->buf_read_msg);
+	st->spi->max_speed_hz = AD4695_REG_ACCESS_SCLK_HZ;
+	if (ret)
+		return ret;
+
+	/*
+	 * NB: technically, this is part the SPI offload trigger enable, but it
+	 * doesn't work to call it from the offload trigger enable callback
+	 * due to issues with ordering with respect to entering/exiting
+	 * conversion mode.
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
+	/* have to unwind in a different order to avoid triggering offload */
+	spi_offload_trigger_disable(st->offload, st->offload_trigger);
+	ad4695_cnv_manual_trigger(st);
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
+	 * We have to trigger on more conversion to ensure that the exit
+	 * conversion mode command works.
+	 */
+	ad4695_cnv_manual_trigger(st);
+
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
@@ -583,13 +760,20 @@ static irqreturn_t ad4695_trigger_handler(int irq, void *p)
  */
 static int ad4695_read_one_sample(struct ad4695_state *st, unsigned int address)
 {
-	struct spi_transfer xfer[2] = { };
-	int ret, i = 0;
+	struct spi_transfer xfer = { };
+	int ret;
 
 	ret = ad4695_set_single_cycle_mode(st, address);
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
 	 * in single-cycle mode, so we have to do an extra xfer to read the
@@ -598,23 +782,29 @@ static int ad4695_read_one_sample(struct ad4695_state *st, unsigned int address)
 	if (address == AD4695_CMD_TEMP_CHAN) {
 		/* We aren't reading, so we can make this a short xfer. */
 		st->cnv_cmd2 = AD4695_CMD_TEMP_CHAN << 3;
-		xfer[0].tx_buf = &st->cnv_cmd2;
-		xfer[0].len = 1;
-		xfer[0].cs_change = 1;
-		xfer[0].cs_change_delay.value = AD4695_T_CONVERT_NS;
-		xfer[0].cs_change_delay.unit = SPI_DELAY_UNIT_NSECS;
+		xfer.tx_buf = &st->cnv_cmd2;
+		xfer.len = 1;
+
+		ret = spi_sync_transfer(st->spi, &xfer, 1);
+		if (ret)
+			return ret;
 
-		i = 1;
+		/*
+		 * If CNV is connected to CS, the previous function will have
+		 * triggered the conversion, otherwise, we do it manually.
+		 */
+		if (st->cnv_gpio)
+			ad4695_cnv_manual_trigger(st);
 	}
 
 	/* Then read the result and exit conversion mode. */
 	st->cnv_cmd = AD4695_CMD_EXIT_CNV_MODE << 11;
-	xfer[i].bits_per_word = 16;
-	xfer[i].tx_buf = &st->cnv_cmd;
-	xfer[i].rx_buf = &st->raw_data;
-	xfer[i].len = 2;
+	xfer.bits_per_word = 16;
+	xfer.tx_buf = &st->cnv_cmd;
+	xfer.rx_buf = &st->raw_data;
+	xfer.len = 2;
 
-	return spi_sync_transfer(st->spi, xfer, i + 1);
+	return spi_sync_transfer(st->spi, &xfer, 1);
 }
 
 static int ad4695_read_raw(struct iio_dev *indio_dev,
@@ -721,11 +911,34 @@ static int ad4695_read_raw(struct iio_dev *indio_dev,
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
@@ -779,6 +992,17 @@ static int ad4695_write_raw(struct iio_dev *indio_dev,
 			default:
 				return -EINVAL;
 			}
+		case IIO_CHAN_INFO_SAMP_FREQ: {
+			struct pwm_state state;
+
+			if (val <= 0)
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
@@ -857,6 +1081,7 @@ static int ad4695_debugfs_reg_access(struct iio_dev *indio_dev,
 
 static const struct iio_info ad4695_info = {
 	.read_raw = &ad4695_read_raw,
+	.write_raw_get_fmt = &ad4695_write_raw_get_fmt,
 	.write_raw = &ad4695_write_raw,
 	.read_avail = &ad4695_read_avail,
 	.debugfs_reg_access = &ad4695_debugfs_reg_access,
@@ -970,26 +1195,173 @@ static int ad4695_parse_channel_cfg(struct ad4695_state *st)
 	return 0;
 }
 
+static bool ad4695_offload_trigger_match(void *priv,
+					 enum spi_offload_trigger_type type,
+					 u64 *args, u32 nargs)
+{
+	if (type != SPI_OFFLOAD_TRIGGER_DATA_READY)
+		return false;
+
+	// TODO: create macros for args[0] and args[1]
+	// args[0] is the trigger signal, 0 == BUSY
+	// args[1] is the GPIO pin number, 0 == GP0, 3 == GP3
+	if (nargs != 2 || args[0] != 0)
+		return false;
+
+	return true;
+}
+
+static int ad4695_offload_trigger_request(void *priv,
+					  enum spi_offload_trigger_type type,
+					  u64 *args, u32 nargs)
+{
+	struct ad4695_state *st = priv;
+
+	/* Should already be validated by match, but just in case. */
+	if (nargs != 2)
+		return -EINVAL;
+
+	/* DT tells us if BUSY signal uses GP0 or GP3 */
+	if (args[1] == 3)
+		return regmap_set_bits(st->regmap, AD4695_REG_GP_MODE,
+				       AD4695_REG_GP_MODE_BUSY_GP_SEL);
+
+	return regmap_clear_bits(st->regmap, AD4695_REG_GPIO_CTRL,
+				 AD4695_REG_GP_MODE_BUSY_GP_SEL);
+}
+
+static int ad4695_offload_trigger_validate(void *priv, struct spi_offload_trigger_config *config)
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
+static void ad4695_restore_spi_max_speed_hz(void *data)
+{
+	struct ad4695_state *st = data;
+
+	st->spi->max_speed_hz = st->spi_max_speed_hz;
+}
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
+		.name = "data-ready",
+		.id = 0,
+		.parent = dev,
+		.fwnode = dev_fwnode(dev),
+		.ops = &ad4695_offload_trigger_ops,
+	};
+	struct spi_offload_trigger *trigger;
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
+	trigger = devm_spi_offload_trigger_alloc(dev, &trigger_info);
+	if (IS_ERR(trigger))
+		return dev_err_probe(dev, PTR_ERR(trigger),
+				     "failed to allocate offload trigger\n");
+
+	ret = devm_spi_offload_trigger_register(dev, trigger, st);
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
+	/* Currently, only self-provided trigger is supported. */
+	if (st->offload_trigger != trigger)
+		return dev_err_probe(dev, -EINVAL, "offload trigger mismatch\n");
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
+	/*
+	 * REVISIT: ideally, we would ask the RX DMA stream what the
+	 * buffer layout is. Right now, the only supported offload is
+	 * the ADI ad469x HDL project which always uses 32-bit word
+	 * size for data values, regardless of the SPI bits per word.
+	 */
+
+	for (i = 0; i < indio_dev->num_channels; i++) {
+		struct iio_chan_spec *chan = &st->iio_chan[i];
+
+		/* update storagebits to match offload capabilities */
+		chan->scan_type.storagebits = 32;
+		/* add sample frequency for PWM CNV trigger */
+		chan->info_mask_separate |= BIT(IIO_CHAN_INFO_SAMP_FREQ);
+	}
+
+	return devm_iio_dmaengine_buffer_setup_ext2(dev, indio_dev, rx_dma,
+						    IIO_BUFFER_DIRECTION_IN);
+}
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
@@ -1002,8 +1374,13 @@ static int ad4695_probe(struct spi_device *spi)
 		return -EINVAL;
 
 	/* Registers cannot be read at the max allowable speed */
+	st->spi_max_speed_hz = spi->max_speed_hz;
 	spi->max_speed_hz = AD4695_REG_ACCESS_SCLK_HZ;
 
+	ret = devm_add_action_or_reset(dev, ad4695_restore_spi_max_speed_hz, st);
+	if (ret)
+		return ret;
+
 	st->regmap = devm_regmap_init_spi(spi, &ad4695_regmap_config);
 	if (IS_ERR(st->regmap))
 		return dev_err_probe(dev, PTR_ERR(st->regmap),
@@ -1014,6 +1391,11 @@ static int ad4695_probe(struct spi_device *spi)
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
@@ -1139,14 +1521,39 @@ static int ad4695_probe(struct spi_device *spi)
 	indio_dev->info = &ad4695_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = st->iio_chan;
-	indio_dev->num_channels = st->chip_info->num_voltage_inputs + 2;
 
-	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
-					      iio_pollfunc_store_time,
-					      ad4695_trigger_handler,
-					      &ad4695_buffer_setup_ops);
-	if (ret)
-		return ret;
+	static const struct spi_offload_config ad4695_offload_config = {
+		.capability_flags = SPI_OFFLOAD_CAP_TRIGGER
+				  | SPI_OFFLOAD_CAP_RX_STREAM_DMA,
+	};
+
+	st->offload = devm_spi_offload_get(dev, spi, &ad4695_offload_config);
+	ret = PTR_ERR_OR_ZERO(st->offload);
+	if (ret && ret != -ENODEV)
+		return dev_err_probe(dev, ret, "failed to get SPI offload\n");
+
+	if (ret == -ENODEV) {
+		/* If no SPI offload, fall back to low speed usage. */
+		dev_info(dev, "SPI offload not available\n");
+
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
@@ -1183,3 +1590,4 @@ MODULE_AUTHOR("Ramona Gradinariu <ramona.gradinariu@analog.com>");
 MODULE_AUTHOR("David Lechner <dlechner@baylibre.com>");
 MODULE_DESCRIPTION("Analog Devices AD4695 ADC driver");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(IIO_DMAENGINE_BUFFER);

-- 
2.43.0


