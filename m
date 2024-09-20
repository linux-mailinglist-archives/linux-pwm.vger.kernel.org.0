Return-Path: <linux-pwm+bounces-3311-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7550297D92A
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Sep 2024 19:34:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0247E1F214CD
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Sep 2024 17:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0035E184556;
	Fri, 20 Sep 2024 17:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="lcZ5ZSx3"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A515185928
	for <linux-pwm@vger.kernel.org>; Fri, 20 Sep 2024 17:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726853616; cv=none; b=NlBZGbBr9SgSPltHDG/VLEOSvoB/VrqVzPyq6XLvm5Gu1No0qv1LxkXuzvPzEMsMJ8iks2wMRgWXSlf8qXfj+4Tiqn0wn7OKkg3Gjl077qaEuC4uAtU+SaxIzMZIJQFbzkwLTZvgAT/4xfKTES9rRDqC+77AQO6ypMOOzyis72o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726853616; c=relaxed/simple;
	bh=rGbKHqnx/NA9Sx5Ie+fz9ZIrDMgsKImoOwwJ/a9nWEA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ciVGqIKbf+gXd+jj4iKAbQtHUYX0q1dBr55GrNfkbFEd0Rv6dc6DIPgmHelPB4Cb5SoF2+1ovioqOpV5nNQS0zTFMh0dT+/WpJzV+ToV1ki80vD1CqstHT41zAWSGwLkKI9/cQE7LyWCMbbHtLUu0dzsutVj8M0+MAdBAxSMmes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=lcZ5ZSx3; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-378c16a4d3eso2351874f8f.1
        for <linux-pwm@vger.kernel.org>; Fri, 20 Sep 2024 10:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1726853612; x=1727458412; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q92/JWErx+OZicU+GXTVjk0ikMmmaNiLFbmb1mbQCF8=;
        b=lcZ5ZSx3X+NOYytTj1CsSi6NYOjIYpjwDxz8T7GmhLpmt9LF4HxEEBp2RTNsBV+SeQ
         wV6LAwgm43QbLlALPQtTLlNGEVv0LAhqAUwF8I9W5pWYlQkIy2OXnZMdQ8wuZjq+3UAI
         ZGvUXKuvF+qStbXRdaMG+sbUQh4lbqKBxHQnNXA8ajuZk9GdL+hsO1nmEhGFA37mcLDi
         oTvZgHg3EVg+HXrU1FADN0Fqplxrai2QWeL8vUkqZuJ3j/4DLZl4YDlfW1XDGrVbiOPo
         zy0CrEP/HLPCeXN8yHlXiXku3cvfq6CfPbMvLW7NIOES0XmBw6HWfh3YfwSSUPN+SRb2
         oehw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726853612; x=1727458412;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q92/JWErx+OZicU+GXTVjk0ikMmmaNiLFbmb1mbQCF8=;
        b=tGxxjljP7MNqjpOZNKzYSxUBARXhFcdp1TuAGK6852rE4JcDZclnQ6uoBHiQ+Xc6Hx
         MQaLKrKgpLlOFwKCICIu+QixTY4ibaq2lcYUueUU18d3d0KhnwcK01e+S5VSwRqCaoZN
         KYkr30FLSdxqYOwxympCkGAPv0jAUquS9hy+u94rWt9o/3SG4t39zx5TNiEICPMU1iNO
         U0cciH3jjcLbxiBqmotH5rj1Nxkawgnx469728NFm8Q2XGxRLatsPwTqdVSOyAqyiqma
         S5JvP3F/7ikyYPneBFnrA+XAbzuLOUDA8truSNzgTAKF/JQqFIuMvMPmP0ZpdvL2P3nn
         6Nrw==
X-Gm-Message-State: AOJu0YyJEatDM8Hy0X4Ig5Lr0QmoZcmwZpasyFxKlrC/6y0ye2AyNN7z
	0PzHhI1R5eydrBfecCo/mv9skXY4lZGU8tmkfYwlcW9Mhi7z6sd6/BAY9NIdt1o=
X-Google-Smtp-Source: AGHT+IHiFZeHsSAWFx9ZmboLVADpTy9yI48Qwebf1x7tovVKQWe7xonWk4njrIIeah5oZxGPUzQOeg==
X-Received: by 2002:a5d:6a04:0:b0:374:c847:831 with SMTP id ffacd0b85a97d-37a4238ce3fmr2862998f8f.55.1726853611434;
        Fri, 20 Sep 2024 10:33:31 -0700 (PDT)
Received: from [127.0.1.1] (frhb82016ds.ikexpress.com. [185.246.87.17])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e780e029sm18111177f8f.116.2024.09.20.10.33.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 10:33:31 -0700 (PDT)
From: Guillaume Stols <gstols@baylibre.com>
Date: Fri, 20 Sep 2024 17:33:26 +0000
Subject: [PATCH v2 06/10] iio: adc: ad7606: Add PWM support for conversion
 trigger
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240920-ad7606_add_iio_backend_support-v2-6-0e78782ae7d0@baylibre.com>
References: <20240920-ad7606_add_iio_backend_support-v2-0-0e78782ae7d0@baylibre.com>
In-Reply-To: <20240920-ad7606_add_iio_backend_support-v2-0-0e78782ae7d0@baylibre.com>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Michal Marek <mmarek@suse.com>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michael Hennerich <michael.hennerich@analog.com>, 
 linux-fbdev@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org, 
 aardelean@baylibre.com, dlechner@baylibre.com, 
 Guillaume Stols <gstols@baylibre.com>, jstephan@baylibre.com
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1726853604; l=9213;
 i=gstols@baylibre.com; s=20240417; h=from:subject:message-id;
 bh=rGbKHqnx/NA9Sx5Ie+fz9ZIrDMgsKImoOwwJ/a9nWEA=;
 b=bDWDXc/YIQSmgXwpX8pQ6d5eIK4VDK4epDWqaauFUN31lfe/Gg4bl648rgftOEsmybgyKbF+j
 doPHbau3CQ+BDipDW/NAh0aNBm85/QAh45dfVAvCpjFVxGpnFSctq+u
X-Developer-Key: i=gstols@baylibre.com; a=ed25519;
 pk=XvMm5WHuV67sGYOJZqIYzXndbaJOlNd8Q6li6vnb4Cs=

Until now, the conversion were triggered by setting high the GPIO
connected to the convst pin. This commit gives the possibility to
connect the convst pin to a PWM.
Connecting a PWM allows to have a better control on the samplerate,
but it must be handled with care, as it is completely decorrelated of
the driver's busy pin handling.
Hence it is not recommended to be used "as is" but must be exploited
in conjonction with IIO backend, and for now only a sampling frequency
of 2 kHz is available.

Signed-off-by: Guillaume Stols <gstols@baylibre.com>
---
 drivers/iio/adc/ad7606.c | 170 ++++++++++++++++++++++++++++++++++++++++-------
 drivers/iio/adc/ad7606.h |   2 +
 2 files changed, 148 insertions(+), 24 deletions(-)

diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
index 9b457472d49c..b98057138295 100644
--- a/drivers/iio/adc/ad7606.c
+++ b/drivers/iio/adc/ad7606.c
@@ -13,11 +13,13 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/property.h>
+#include <linux/pwm.h>
 #include <linux/regulator/consumer.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/sysfs.h>
 #include <linux/util_macros.h>
+#include <linux/units.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/buffer.h>
@@ -83,6 +85,80 @@ static int ad7606_reg_access(struct iio_dev *indio_dev,
 	}
 }
 
+static int ad7606_pwm_set_high(struct ad7606_state *st)
+{
+	struct pwm_state cnvst_pwm_state;
+
+	if (!st->cnvst_pwm)
+		return -EINVAL;
+	pwm_get_state(st->cnvst_pwm, &cnvst_pwm_state);
+	cnvst_pwm_state.enabled = true;
+	cnvst_pwm_state.duty_cycle = cnvst_pwm_state.period;
+
+	return pwm_apply_might_sleep(st->cnvst_pwm, &cnvst_pwm_state);
+}
+
+static int ad7606_pwm_set_low(struct ad7606_state *st)
+{
+	struct pwm_state cnvst_pwm_state;
+
+	if (!st->cnvst_pwm)
+		return -EINVAL;
+	pwm_get_state(st->cnvst_pwm, &cnvst_pwm_state);
+	cnvst_pwm_state.enabled = true;
+	cnvst_pwm_state.duty_cycle = 0;
+
+	return pwm_apply_might_sleep(st->cnvst_pwm, &cnvst_pwm_state);
+}
+
+static int ad7606_pwm_set_swing(struct ad7606_state *st)
+{
+	struct pwm_state cnvst_pwm_state;
+
+	if (!st->cnvst_pwm)
+		return -EINVAL;
+
+	pwm_get_state(st->cnvst_pwm, &cnvst_pwm_state);
+	cnvst_pwm_state.enabled = true;
+	cnvst_pwm_state.duty_cycle = cnvst_pwm_state.period / 2;
+
+	return pwm_apply_might_sleep(st->cnvst_pwm, &cnvst_pwm_state);
+}
+
+static bool ad7606_pwm_is_swinging(struct ad7606_state *st)
+{
+	struct pwm_state cnvst_pwm_state;
+
+	if (!st->cnvst_pwm)
+		return false;
+	pwm_get_state(st->cnvst_pwm, &cnvst_pwm_state);
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
+
+	return pwm_apply_might_sleep(st->cnvst_pwm, &cnvst_pwm_state);
+}
+
 static int ad7606_read_samples(struct ad7606_state *st)
 {
 	unsigned int num = st->chip_info->num_channels - 1;
@@ -117,9 +193,22 @@ static irqreturn_t ad7606_trigger_handler(int irq, void *p)
 static int ad7606_scan_direct(struct iio_dev *indio_dev, unsigned int ch)
 {
 	struct ad7606_state *st = iio_priv(indio_dev);
+
+	struct pwm_state cnvst_pwm_state;
 	int ret;
+	bool pwm_swings = false;
 
-	gpiod_set_value(st->gpio_convst, 1);
+	if (st->gpio_convst) {
+		gpiod_set_value(st->gpio_convst, 1);
+	} else {
+		pwm_get_state(st->cnvst_pwm, &cnvst_pwm_state);
+		/* Keep the current PWM state to set it back. */
+		if (ad7606_pwm_is_swinging(st))
+			pwm_swings = true;
+		ret = ad7606_pwm_set_high(st);
+		if (!ret)
+			return ret;
+	}
 	ret = wait_for_completion_timeout(&st->completion,
 					  msecs_to_jiffies(1000));
 	if (!ret) {
@@ -130,7 +219,12 @@ static int ad7606_scan_direct(struct iio_dev *indio_dev, unsigned int ch)
 	ret = ad7606_read_samples(st);
 	if (ret == 0)
 		ret = st->data[ch];
-
+	if (!st->gpio_convst) {
+		if (!pwm_swings)
+			ret = ad7606_pwm_set_low(st);
+		else
+			ret = ad7606_pwm_set_swing(st);
+	}
 error_ret:
 	gpiod_set_value(st->gpio_convst, 0);
 
@@ -395,8 +489,9 @@ static int ad7606_request_gpios(struct ad7606_state *st)
 {
 	struct device *dev = st->dev;
 
-	st->gpio_convst = devm_gpiod_get(dev, "adi,conversion-start",
-					 GPIOD_OUT_LOW);
+	st->gpio_convst = devm_gpiod_get_optional(dev, "adi,conversion-start",
+						  GPIOD_OUT_LOW);
+
 	if (IS_ERR(st->gpio_convst))
 		return PTR_ERR(st->gpio_convst);
 
@@ -465,6 +560,7 @@ static int ad7606_buffer_postenable(struct iio_dev *indio_dev)
 	struct ad7606_state *st = iio_priv(indio_dev);
 
 	gpiod_set_value(st->gpio_convst, 1);
+	ad7606_pwm_set_swing(st);
 
 	return 0;
 }
@@ -474,6 +570,7 @@ static int ad7606_buffer_predisable(struct iio_dev *indio_dev)
 	struct ad7606_state *st = iio_priv(indio_dev);
 
 	gpiod_set_value(st->gpio_convst, 0);
+	ad7606_pwm_set_low(st);
 
 	return 0;
 }
@@ -521,6 +618,11 @@ static const struct iio_trigger_ops ad7606_trigger_ops = {
 	.validate_device = iio_trigger_validate_own_device,
 };
 
+static void ad7606_pwm_disable(void *data)
+{
+	pwm_disable(data);
+}
+
 int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
 		 const char *name, unsigned int id,
 		 const struct ad7606_bus_ops *bops)
@@ -611,20 +713,47 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
 			return ret;
 	}
 
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
-
-	indio_dev->trig = iio_trigger_get(st->trig);
+	/* If convst pin is not defined, setup PWM. */
+	if (!st->gpio_convst) {
+		st->cnvst_pwm = devm_pwm_get(dev, NULL);
+		if (IS_ERR(st->cnvst_pwm))
+			return PTR_ERR(st->cnvst_pwm);
+		/*
+		 * PWM is not disabled when sampling stops, but instead its duty cycle is set
+		 * to 0% to be sure we have a "low" state. After we unload the driver, let's
+		 * disable the PWM.
+		 */
+		ret = devm_add_action_or_reset(dev, ad7606_pwm_disable,
+					       st->cnvst_pwm);
+		if (ret)
+			return ret;
 
+		/*
+		 * Set the sampling rate to 2 kHz so to be sure that the interruption can be
+		 * handled between within a single pulse.
+		 */
+		ret = ad7606_set_sampling_freq(st, 2 * KILO);
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
@@ -633,13 +762,6 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
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
index 6649e84d25de..c13dda444526 100644
--- a/drivers/iio/adc/ad7606.h
+++ b/drivers/iio/adc/ad7606.h
@@ -65,6 +65,7 @@ struct ad7606_chip_info {
  * @bops		bus operations (SPI or parallel)
  * @range		voltage range selection, selects which scale to apply
  * @oversampling	oversampling selection
+ * @cnvst_pwm		pointer to the PWM device connected to the cnvst pin
  * @base_address	address from where to read data in parallel operation
  * @sw_mode_en		software mode enabled
  * @scale_avail		pointer to the array which stores the available scales
@@ -94,6 +95,7 @@ struct ad7606_state {
 	const struct ad7606_bus_ops	*bops;
 	unsigned int			range[16];
 	unsigned int			oversampling;
+	struct pwm_device		*cnvst_pwm;
 	void __iomem			*base_address;
 	bool				sw_mode_en;
 	const unsigned int		*scale_avail;

-- 
2.34.1


