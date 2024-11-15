Return-Path: <linux-pwm+bounces-4096-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D3029CF612
	for <lists+linux-pwm@lfdr.de>; Fri, 15 Nov 2024 21:30:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4033AB33E9C
	for <lists+linux-pwm@lfdr.de>; Fri, 15 Nov 2024 20:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09C3A1FAF19;
	Fri, 15 Nov 2024 20:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="y2PppCwh"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C011FAC46
	for <linux-pwm@vger.kernel.org>; Fri, 15 Nov 2024 20:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731701955; cv=none; b=cXLAVxZ8kH6xh5d3XlTq22W0ytDwvE8p+SL79Ykcga9cBHOeZMkzhhfMi14jLwYfx4nXUuqin7dkxj7gcZY+2asJtKVs3ssJ9RsAxNj4VnwUH2FYDcJvTV5P/TT6WEn8qnxjaQEN8La48wa9YHLRYQOWb6Q7kyt4O5gCKXmu3KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731701955; c=relaxed/simple;
	bh=lAGm0BfqgiNcIcjLhq96l0xwQMzn10PfebZ1OkujxZY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=afxJNKmErv/1NofgQzEwe1/WazYzqAa84vvTcMyWyZHsp16QGhgE3Ux6NxLNogQnWpM+d+TMXNQEv7h0WN0fXRP9qE4AJzwu4ddpU/5ni1wOUtr8ghJ6v2NgAyk4E193bSUDi4hIvTI0HTRg9nysH+gCwobgATtEzTJ0Oko48/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=y2PppCwh; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5edf76cd843so1104470eaf.1
        for <linux-pwm@vger.kernel.org>; Fri, 15 Nov 2024 12:19:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1731701952; x=1732306752; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+8s25RYMi+zlyRDlUm0JExPlZPMjT1HBFf4tYIofzew=;
        b=y2PppCwhMF68/W9cV0d37bUh48J1V2i/bz+69x752BvQIPWXO7JJG80uPa3M/bWNAA
         cCEGFqOKBD3JmgBIUJ+AR3xsr846QjbJr71EYnmJeoudd1QtTHfss0eo05knaorC4bZD
         jeyvpaWI7tbQR5HdvAqEt1qwgGUhZUcOG8K3cXrXHXYwarq7KqFMMyoDKx4OV5SbK5ss
         pU5w7oncMjw2d8R9d/YFM+f57WgiZbyyPbVaaEZQgn+lJSXSmq0kI7Kh2Kn9VOAFag4G
         U9Vdmlw9OvyHLMh2TOfRNFZ+ZsjMI5jUVlC7A2rA+C1RAP4Hl3DCh/ghCENB5A6xmWIA
         T6qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731701952; x=1732306752;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+8s25RYMi+zlyRDlUm0JExPlZPMjT1HBFf4tYIofzew=;
        b=bkKInCR0JJFMgy+I7QTyRFhnqqQD8BOXwWPn3p0myYct1RTRGCD5vg+ut4/eBVP08j
         H6F4zfFYXEYTxU5cKzzEE6eupwm2junjVIKzKGdG6rehdqPl8YDDW/1g/s9llDQlz2YQ
         UcAzTArPXxfg9biT/nKJ3c3JSiLn/D6Kcm83721ERy5cuqNz4i+kk/O4FZOdEItlTLvm
         gWxY926jL5AQjEodLr52XgXW87Nv4p6HD3n887S1KhLBBeVLQnGbaI4DDRYK+n3l+3pU
         j26TYTG2ZiiYXCIobqO/TE0TxMreN2rS4ZY+eO6FdUAqSUWak4OZuMyW4dDIkmXkR+lM
         mhfg==
X-Forwarded-Encrypted: i=1; AJvYcCXJ7OCSF9ik3DAGlMGwcs9K1I8NGAImr0suvolDzisnSdnYq3NKOOLj5jZlqNra8NsPmi31nMkfgaM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7U1QA0bv5k9xiy8sP6Dj2jenIQiz7N4hMEvwe2jG7RNEpZmGH
	OAaoDZ/cXLC83Ls1124VDKs38+mx+bBv51PjkGlGvzoFx1mxWxPSjL2dFqn9ENo=
X-Google-Smtp-Source: AGHT+IF+lv4w+8HYxFzmk7lngOHQjR5NRVDb+KEp2Ni5zx2ZGPOp/A07V9v7MCv0sDwNk76D0Q1dow==
X-Received: by 2002:a05:6820:2d0c:b0:5ed:feae:d5bd with SMTP id 006d021491bc7-5eeab410f02mr4409964eaf.3.1731701952105;
        Fri, 15 Nov 2024 12:19:12 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71a780ea62esm748978a34.5.2024.11.15.12.19.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 12:19:10 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 15 Nov 2024 14:18:54 -0600
Subject: [PATCH v5 15/16] iio: adc: ad4695: Add support for SPI offload
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241115-dlech-mainline-spi-engine-offload-2-v5-15-bea815bd5ea5@baylibre.com>
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

Add support for SPI offload to the ad4695 driver. SPI offload allows
sampling data at the max sample rate (500kSPS or 1MSPS).

This is developed and tested against the ADI example FPGA design for
this family of ADCs [1].

[1]: http://analogdevicesinc.github.io/hdl/projects/ad469x_fmc/index.html

Signed-off-by: David Lechner <dlechner@baylibre.com>
---

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
 drivers/iio/adc/ad4695.c | 438 +++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 422 insertions(+), 17 deletions(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 995b9cacbaa9..ec60b64c46e1 100644
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
index 10f61290e2c1..02880d1ef31b 100644
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
@@ -124,13 +130,22 @@ struct ad4695_channel_config {
 
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
@@ -355,6 +370,13 @@ static const struct ad4695_chip_info ad4698_chip_info = {
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
@@ -460,6 +482,17 @@ static int ad4695_exit_conversion_mode(struct ad4695_state *st)
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
 
@@ -687,6 +720,159 @@ static irqreturn_t ad4695_trigger_handler(int irq, void *p)
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
+	xfer->bits_per_word = 16;
+	xfer->len = 2;
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
@@ -718,6 +904,13 @@ static int ad4695_read_one_sample(struct ad4695_state *st, unsigned int address)
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
@@ -729,6 +922,13 @@ static int ad4695_read_one_sample(struct ad4695_state *st, unsigned int address)
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
@@ -842,11 +1042,34 @@ static int ad4695_read_raw(struct iio_dev *indio_dev,
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
@@ -900,6 +1123,17 @@ static int ad4695_write_raw(struct iio_dev *indio_dev,
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
@@ -923,6 +1157,7 @@ static int ad4695_read_avail(struct iio_dev *indio_dev,
 		 */
 		S16_MIN / 4, 0, 0, MICRO / 4, S16_MAX / 4, S16_MAX % 4 * MICRO / 4
 	};
+	struct ad4695_state *st = iio_priv(indio_dev);
 
 	switch (mask) {
 	case IIO_CHAN_INFO_CALIBSCALE:
@@ -943,6 +1178,10 @@ static int ad4695_read_avail(struct iio_dev *indio_dev,
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
@@ -978,6 +1217,7 @@ static int ad4695_debugfs_reg_access(struct iio_dev *indio_dev,
 
 static const struct iio_info ad4695_info = {
 	.read_raw = &ad4695_read_raw,
+	.write_raw_get_fmt = &ad4695_write_raw_get_fmt,
 	.write_raw = &ad4695_write_raw,
 	.read_avail = &ad4695_read_avail,
 	.debugfs_reg_access = &ad4695_debugfs_reg_access,
@@ -1091,26 +1331,156 @@ static int ad4695_parse_channel_cfg(struct ad4695_state *st)
 	return 0;
 }
 
+static bool ad4695_offload_trigger_match(struct spi_offload_trigger *trigger,
+					 enum spi_offload_trigger_type type,
+					 u64 *args, u32 nargs)
+{
+	if (type != SPI_OFFLOAD_TRIGGER_DATA_READY)
+		return false;
+
+	// args[0] is the trigger event.
+	// args[1] is the GPIO pin number.
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
+		chan->info_mask_separate_available |= BIT(IIO_CHAN_INFO_SAMP_FREQ);
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
@@ -1122,6 +1492,10 @@ static int ad4695_probe(struct spi_device *spi)
 	if (!st->chip_info)
 		return -EINVAL;
 
+	st->sample_freq_range[0] = 1; /* min */
+	st->sample_freq_range[1] = 1; /* step */
+	st->sample_freq_range[2] = st->chip_info->max_sample_rate; /* max */
+
 	st->regmap = devm_regmap_init(dev, &ad4695_regmap_bus, st,
 				      &ad4695_regmap_config);
 	if (IS_ERR(st->regmap))
@@ -1134,6 +1508,11 @@ static int ad4695_probe(struct spi_device *spi)
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
@@ -1260,12 +1639,36 @@ static int ad4695_probe(struct spi_device *spi)
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = st->iio_chan;
 
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
@@ -1302,3 +1705,4 @@ MODULE_AUTHOR("Ramona Gradinariu <ramona.gradinariu@analog.com>");
 MODULE_AUTHOR("David Lechner <dlechner@baylibre.com>");
 MODULE_DESCRIPTION("Analog Devices AD4695 ADC driver");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(IIO_DMAENGINE_BUFFER);

-- 
2.43.0


