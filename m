Return-Path: <linux-pwm+bounces-3481-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B54D79911B9
	for <lists+linux-pwm@lfdr.de>; Fri,  4 Oct 2024 23:50:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 014EFB23855
	for <lists+linux-pwm@lfdr.de>; Fri,  4 Oct 2024 21:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9925F1B4F18;
	Fri,  4 Oct 2024 21:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="TgKMp65B"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255811D8DF8
	for <linux-pwm@vger.kernel.org>; Fri,  4 Oct 2024 21:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728078539; cv=none; b=pleTXLlvFqzw3EDi2+OLP6Qj4omdOVQcg27ob18Y3+HScIMt5BdxZBvR4P4RK5id7KMYSRwgOal1raBTvHxOTj9Q09vIDSTAcE+2omqhznTMUd8oo4ago+4tUpUl+GT4Y7ybQs3jTTaxHLdFoThOw4uhQCzqlSITzn6uBbZ/n04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728078539; c=relaxed/simple;
	bh=MPX+gxSXSRVkD6yBFhZnDYs0/lqv0mAf/wM0wEpSIqo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f29lK3aSn9HBViuytebeem2YKTUQXq2I/AvjtJ4VLBxDl08ytBtTxhEfSTOmV2JobU4CCUqtnGamqy5iUs+E7yHNC5bVnkZvQMWTQGdEwkgzngGgCd1BGNsLD+xKR1fmbWU25Bzr2Erl2jeZ68vCwqSX2AkfQDQKBtAQ7H/bCf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=TgKMp65B; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42e748f78d6so23402755e9.0
        for <linux-pwm@vger.kernel.org>; Fri, 04 Oct 2024 14:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728078534; x=1728683334; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=96IaB7ZOrC1D6CinpPMwTazn0uYiER61veLcA10WMPk=;
        b=TgKMp65BWBgaiZe4MOI9jjIHWh19LGaq7O7dK2viVnZrlW1phP6qeXdVQBXowvooyU
         +uPOPsWmUU+LwYLUkS4ovV/6nQL8XwWxpkcS/tI158KdrTLz5q0xh7xo2gDix7nGTXVl
         VjbWXb/kBb3VNtrz126ki2QVKhghamfl5n0XwTM2ph9zo0PZr/RW2TnH8yxLr5wI6uof
         vVCVVBhtKlYXxH3aXzkTqCoRj9/7jJ65PM/inZnZlkG8uH7SJUVgM1kuGZx1cTKhGpf7
         mUlGQKW9NF/QxQLG/qz0sQWvqpqX/vipqjlw8Yj3DqbXyv/5I5sdHQyhX7YQpcPAJunI
         bgvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728078534; x=1728683334;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=96IaB7ZOrC1D6CinpPMwTazn0uYiER61veLcA10WMPk=;
        b=OFI6CiEZOpuyQwhZKtchLQ2qwz88W75DSs+toFhNU3Qbszfn3GQWrNSR2nGueGtkaL
         3SVjzf9ZrkZqXGpTYVhf7d9HbQ/teyOTQvZN6Vr2FndD1YDdz9kmyu0T0/nnJKq56Jrh
         4W2ck/b7u9h/56PxDMw4lzAZFAak9LuM2kPPN9JCLhv9mkmtuUC7ZAmSZuTS++NaF1e2
         B9+2pQW/zGlBVKRNP8WMNEgm0on3qjtiVDbBXEcs7XENUCyGTAhPI1eA+O8LeW/VrIlx
         67U3cTIGHJWQoQoqX8Wexs4j8SVeT3pFtBWUkTkbJKHUvR8M5PDXVF6IXp45CLkmT7v4
         F05g==
X-Gm-Message-State: AOJu0YzdX5kPosB8k8rdH/Ww8Bet74hYQYThTwBdWnC7ob3lrG+/xLuk
	AReBV4+2gy3CdAkASLwSxHSCs/JriTX1KdvcPVT7eLgekI8WBydaTOYAVrxW/mc=
X-Google-Smtp-Source: AGHT+IHFFnL/fyuYp/t9j06RFOtG2IGJ5n8dGdwUIEZ3jSTxTbhe/WFN270jW/R88z4lbqNHbwhd3w==
X-Received: by 2002:a05:600c:4514:b0:42f:7e87:3438 with SMTP id 5b1f17b1804b1-42f859b1931mr31524045e9.0.1728078534077;
        Fri, 04 Oct 2024 14:48:54 -0700 (PDT)
Received: from [127.0.1.1] (frhb82016ds.ikexpress.com. [185.246.87.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f86b4ab63sm24680375e9.40.2024.10.04.14.48.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 14:48:52 -0700 (PDT)
From: Guillaume Stols <gstols@baylibre.com>
Date: Fri, 04 Oct 2024 21:48:40 +0000
Subject: [PATCH v3 06/10] iio: adc: ad7606: Add PWM support for conversion
 trigger
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241004-ad7606_add_iio_backend_support-v3-6-38757012ce82@baylibre.com>
References: <20241004-ad7606_add_iio_backend_support-v3-0-38757012ce82@baylibre.com>
In-Reply-To: <20241004-ad7606_add_iio_backend_support-v3-0-38757012ce82@baylibre.com>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michael Hennerich <michael.hennerich@analog.com>, 
 linux-fbdev@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org, 
 aardelean@baylibre.com, dlechner@baylibre.com, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Guillaume Stols <gstols@baylibre.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728078523; l=9431;
 i=gstols@baylibre.com; s=20240417; h=from:subject:message-id;
 bh=MPX+gxSXSRVkD6yBFhZnDYs0/lqv0mAf/wM0wEpSIqo=;
 b=4lyU/0RkOrYql/6qWrpQY+utIuSAhkyIj/LBny7Fc0wc5mR+tU/W2e0ZmJmp+wg5rwM4YAdJL
 p/E9i2QG639Dn0R+45EH3vyCDdrYXUcS7wt5hVV19v9/JF0e7rKqumL
X-Developer-Key: i=gstols@baylibre.com; a=ed25519;
 pk=XvMm5WHuV67sGYOJZqIYzXndbaJOlNd8Q6li6vnb4Cs=

Until now, the conversion were triggered by setting high the GPIO
connected to the convst pin. This commit gives the possibility to
connect the convst pin to a PWM.
Connecting a PWM allows to have a better control on the samplerate,
but it must be handled with care, as it is completely decorrelated of
the driver's busy pin handling.
Hence it is not recommended to be used "as is" but must be exploited
in conjunction with IIO backend, and for now only a mock functionality
is enabled, i.e PWM never swings, but is used as a GPIO, i.e duty_cycle
== period equals high state, duty_cycle == 0 equals low state.

This mock functionality will be disabled after the IIO backend usecase
is introduced.

Signed-off-by: Guillaume Stols <gstols@baylibre.com>
---
 drivers/iio/adc/ad7606.c | 164 ++++++++++++++++++++++++++++++++++++++++-------
 drivers/iio/adc/ad7606.h |   2 +
 2 files changed, 144 insertions(+), 22 deletions(-)

diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
index d1aec53e0bcf..224ffaf3dbff 100644
--- a/drivers/iio/adc/ad7606.c
+++ b/drivers/iio/adc/ad7606.c
@@ -13,10 +13,12 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/property.h>
+#include <linux/pwm.h>
 #include <linux/regulator/consumer.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/sysfs.h>
+#include <linux/units.h>
 #include <linux/util_macros.h>
 
 #include <linux/iio/buffer.h>
@@ -299,6 +301,82 @@ static int ad7606_reg_access(struct iio_dev *indio_dev,
 	}
 }
 
+static int ad7606_pwm_set_high(struct ad7606_state *st)
+{
+	struct pwm_state cnvst_pwm_state;
+	int ret;
+
+	if (!st->cnvst_pwm)
+		return -EINVAL;
+
+	pwm_get_state(st->cnvst_pwm, &cnvst_pwm_state);
+	cnvst_pwm_state.enabled = true;
+	cnvst_pwm_state.duty_cycle = cnvst_pwm_state.period;
+
+	ret = pwm_apply_might_sleep(st->cnvst_pwm, &cnvst_pwm_state);
+	/* sleep 2 µS to let finish the current pulse */
+	fleep(2)
+
+	return ret;
+}
+
+static int ad7606_pwm_set_low(struct ad7606_state *st)
+{
+	struct pwm_state cnvst_pwm_state;
+	int ret;
+
+	if (!st->cnvst_pwm)
+		return -EINVAL;
+
+	pwm_get_state(st->cnvst_pwm, &cnvst_pwm_state);
+	cnvst_pwm_state.enabled = true;
+	cnvst_pwm_state.duty_cycle = 0;
+
+	ret = pwm_apply_might_sleep(st->cnvst_pwm, &cnvst_pwm_state);
+	/* sleep 2 µS to let finish the current pulse */
+	fleep(2)
+
+	return ret;
+}
+
+static bool ad7606_pwm_is_swinging(struct ad7606_state *st)
+{
+	struct pwm_state cnvst_pwm_state;
+
+	if (!st->cnvst_pwm)
+		return false;
+
+	pwm_get_state(st->cnvst_pwm, &cnvst_pwm_state);
+
+	return cnvst_pwm_state.duty_cycle != cnvst_pwm_state.period &&
+	       cnvst_pwm_state.duty_cycle != 0;
+}
+
+static int ad7606_set_sampling_freq(struct ad7606_state *st, unsigned long freq)
+{
+	struct pwm_state cnvst_pwm_state;
+	bool is_swinging = ad7606_pwm_is_swinging(st);
+	bool is_high;
+
+	if (freq == 0)
+		return -EINVAL;
+
+	/* Retrieve the previous state. */
+	pwm_get_state(st->cnvst_pwm, &cnvst_pwm_state);
+	is_high = cnvst_pwm_state.duty_cycle == cnvst_pwm_state.period;
+
+	cnvst_pwm_state.period = DIV_ROUND_UP_ULL(NSEC_PER_SEC, freq);
+	cnvst_pwm_state.polarity = PWM_POLARITY_NORMAL;
+	if (is_high)
+		cnvst_pwm_state.duty_cycle = cnvst_pwm_state.period;
+	else if (is_swinging)
+		cnvst_pwm_state.duty_cycle = cnvst_pwm_state.period / 2;
+	else
+		cnvst_pwm_state.duty_cycle = 0;
+
+	return pwm_apply_might_sleep(st->cnvst_pwm, &cnvst_pwm_state);
+}
+
 static int ad7606_read_samples(struct ad7606_state *st)
 {
 	unsigned int num = st->chip_info->num_channels - 1;
@@ -325,6 +403,7 @@ static irqreturn_t ad7606_trigger_handler(int irq, void *p)
 	iio_trigger_notify_done(indio_dev->trig);
 	/* The rising edge of the CONVST signal starts a new conversion. */
 	gpiod_set_value(st->gpio_convst, 1);
+	ad7606_pwm_set_high(st);
 
 	return IRQ_HANDLED;
 }
@@ -337,7 +416,13 @@ static int ad7606_scan_direct(struct iio_dev *indio_dev, unsigned int ch,
 	const struct iio_chan_spec *chan;
 	int ret;
 
-	gpiod_set_value(st->gpio_convst, 1);
+	if (st->gpio_convst) {
+		gpiod_set_value(st->gpio_convst, 1);
+	} else {
+		ret = ad7606_pwm_set_high(st);
+		if (ret < 0)
+			return ret;
+	}
 	ret = wait_for_completion_timeout(&st->completion,
 					  msecs_to_jiffies(1000));
 	if (!ret) {
@@ -364,6 +449,11 @@ static int ad7606_scan_direct(struct iio_dev *indio_dev, unsigned int ch,
 	}
 
 error_ret:
+	if (!st->gpio_convst) {
+		ret = ad7606_pwm_set_low(st);
+		if (ret < 0)
+			return ret;
+	}
 	gpiod_set_value(st->gpio_convst, 0);
 
 	return ret;
@@ -663,8 +753,9 @@ static int ad7606_request_gpios(struct ad7606_state *st)
 {
 	struct device *dev = st->dev;
 
-	st->gpio_convst = devm_gpiod_get(dev, "adi,conversion-start",
-					 GPIOD_OUT_LOW);
+	st->gpio_convst = devm_gpiod_get_optional(dev, "adi,conversion-start",
+						  GPIOD_OUT_LOW);
+
 	if (IS_ERR(st->gpio_convst))
 		return PTR_ERR(st->gpio_convst);
 
@@ -709,6 +800,7 @@ static irqreturn_t ad7606_interrupt(int irq, void *dev_id)
 
 	if (iio_buffer_enabled(indio_dev)) {
 		gpiod_set_value(st->gpio_convst, 0);
+		ad7606_pwm_set_low(st);
 		iio_trigger_poll_nested(st->trig);
 	} else {
 		complete(&st->completion);
@@ -733,6 +825,7 @@ static int ad7606_buffer_postenable(struct iio_dev *indio_dev)
 	struct ad7606_state *st = iio_priv(indio_dev);
 
 	gpiod_set_value(st->gpio_convst, 1);
+	ad7606_pwm_set_high(st);
 
 	return 0;
 }
@@ -742,6 +835,7 @@ static int ad7606_buffer_predisable(struct iio_dev *indio_dev)
 	struct ad7606_state *st = iio_priv(indio_dev);
 
 	gpiod_set_value(st->gpio_convst, 0);
+	ad7606_pwm_set_low(st);
 
 	return 0;
 }
@@ -875,6 +969,11 @@ static int ad7606_chan_scales_setup(struct iio_dev *indio_dev)
 	return 0;
 }
 
+static void ad7606_pwm_disable(void *data)
+{
+	pwm_disable(data);
+}
+
 int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
 		 const char *name, unsigned int id,
 		 const struct ad7606_bus_ops *bops)
@@ -951,20 +1050,48 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
 	if (ret)
 		return ret;
 
-	st->trig = devm_iio_trigger_alloc(dev, "%s-dev%d",
-					  indio_dev->name,
-					  iio_device_id(indio_dev));
-	if (!st->trig)
-		return -ENOMEM;
-
-	st->trig->ops = &ad7606_trigger_ops;
-	iio_trigger_set_drvdata(st->trig, indio_dev);
-	ret = devm_iio_trigger_register(dev, st->trig);
-	if (ret)
-		return ret;
+	/* If convst pin is not defined, setup PWM. */
+	if (!st->gpio_convst) {
+		st->cnvst_pwm = devm_pwm_get(dev, NULL);
+		if (IS_ERR(st->cnvst_pwm))
+			return PTR_ERR(st->cnvst_pwm);
+		/* The PWM is initialized at 1MHz to have a fast enough GPIO emulation. */
+		ret = ad7606_set_sampling_freq(st, 1 * MEGA);
+		if (ret)
+			return ret;
 
-	indio_dev->trig = iio_trigger_get(st->trig);
+		ret = ad7606_pwm_set_low(st);
+		if (ret)
+			return ret;
 
+		/*
+		 * PWM is not disabled when sampling stops, but instead its duty cycle is set
+		 * to 0% to be sure we have a "low" state. After we unload the driver, let's
+		 * disable the PWM.
+		 */
+		ret = devm_add_action_or_reset(dev, ad7606_pwm_disable,
+					       st->cnvst_pwm);
+		if (ret)
+			return ret;
+	} else {
+		st->trig = devm_iio_trigger_alloc(dev, "%s-dev%d",
+						  indio_dev->name,
+						  iio_device_id(indio_dev));
+		if (!st->trig)
+			return -ENOMEM;
+		st->trig->ops = &ad7606_trigger_ops;
+		iio_trigger_set_drvdata(st->trig, indio_dev);
+		ret = devm_iio_trigger_register(dev, st->trig);
+		if (ret)
+			return ret;
+		indio_dev->trig = iio_trigger_get(st->trig);
+		ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
+						      &iio_pollfunc_store_time,
+						      &ad7606_trigger_handler,
+						      &ad7606_buffer_ops);
+		if (ret)
+			return ret;
+	}
 	ret = devm_request_threaded_irq(dev, irq,
 					NULL,
 					&ad7606_interrupt,
@@ -973,13 +1100,6 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
 	if (ret)
 		return ret;
 
-	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
-					      &iio_pollfunc_store_time,
-					      &ad7606_trigger_handler,
-					      &ad7606_buffer_ops);
-	if (ret)
-		return ret;
-
 	return devm_iio_device_register(dev, indio_dev);
 }
 EXPORT_SYMBOL_NS_GPL(ad7606_probe, IIO_AD7606);
diff --git a/drivers/iio/adc/ad7606.h b/drivers/iio/adc/ad7606.h
index fc05a4afa3b8..760cf5e2ecb6 100644
--- a/drivers/iio/adc/ad7606.h
+++ b/drivers/iio/adc/ad7606.h
@@ -115,6 +115,7 @@ struct ad7606_chan_scale {
  * @bops		bus operations (SPI or parallel)
  * @chan_scales		scale configuration for channels
  * @oversampling	oversampling selection
+ * @cnvst_pwm		pointer to the PWM device connected to the cnvst pin
  * @base_address	address from where to read data in parallel operation
  * @sw_mode_en		software mode enabled
  * @oversampling_avail	pointer to the array which stores the available
@@ -142,6 +143,7 @@ struct ad7606_state {
 	const struct ad7606_bus_ops	*bops;
 	struct ad7606_chan_scale	chan_scales[AD760X_MAX_CHANNELS];
 	unsigned int			oversampling;
+	struct pwm_device		*cnvst_pwm;
 	void __iomem			*base_address;
 	bool				sw_mode_en;
 	const unsigned int		*oversampling_avail;

-- 
2.34.1


