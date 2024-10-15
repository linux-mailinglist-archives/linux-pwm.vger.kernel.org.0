Return-Path: <linux-pwm+bounces-3653-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A224E99EE73
	for <lists+linux-pwm@lfdr.de>; Tue, 15 Oct 2024 15:58:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EFD21F26672
	for <lists+linux-pwm@lfdr.de>; Tue, 15 Oct 2024 13:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B8791DD0CF;
	Tue, 15 Oct 2024 13:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="lVVDQXgc"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94BD1C07DE
	for <linux-pwm@vger.kernel.org>; Tue, 15 Oct 2024 13:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729000605; cv=none; b=cY+foFs2QfO+9bgrg6rADEZEv57c/R/EzDewFy/ZUhoOChdv8Nrexani/Rdmjrd7iSN1ISdBIYhQfXUmkZHbNBdYWf9VJbwKK0ydpyvtS4PKXY6730q2W80asm2/JlPJjAw7fJgbybCSBYmDcUC+0NcEuy4cW8eOzsP8e0oh2Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729000605; c=relaxed/simple;
	bh=knvF5aKMvqbmI6xU45rnHDO+4jl4aWSRuRnTBvrdC14=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fXt/j8J8yIUwJHPmQnpv+rDdnFemYjjmzILqUh5PpeCN4kBcEIN0QZNbuba6ovhlrhRtuovcGB8xeTLOBBeO1PkRxnbWWDCwhM2UyEr/OipDC4C8zlsAvwv8AuRll7udG5CZGTBAfVrErVZMpJps4BYFXRSfEEd3pQRVyGVZLtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=lVVDQXgc; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4305724c12eso41315585e9.1
        for <linux-pwm@vger.kernel.org>; Tue, 15 Oct 2024 06:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729000599; x=1729605399; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DHsNSKa4NzWLb/5F9UDh7Kih8Y7W7IvCdbO7qkDG4QU=;
        b=lVVDQXgcN+SijH9DtfXcrCGU3IyLuN0ZaClc/gAP1U9W8nRqEg7EGNizbrCZaO5s3+
         xg8mXAy35AXUFSbnCGuOIUo/eRrMBCQxaUMMnlbjwWIEDCg+0bbFe/vP+6yAFe6qvoIu
         BTZQI5/m1buhEqJHw1ZMAs/XZzVKEaPc3lTfZWd1rSDyVPWw6UogeG1lOn3OJeSdfYjq
         51aBsaRmT3VpLltDS3EMgAWw0bNaW8BQbYKeVNZwn/RG85ZjbQr0AzADR1F+5bmHf92x
         NP6empElRFTrAxqMdgiMfZFKJnKvpmrd4tdQ6F/OpvOeDlbA+k+1ePVOl170JngWPnJi
         Jyhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729000599; x=1729605399;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DHsNSKa4NzWLb/5F9UDh7Kih8Y7W7IvCdbO7qkDG4QU=;
        b=qq2faBiV7vKsDKcMO+qJVLgRyPevEq7eIBhmiQH3cDSWkZcZzEq0dIlB3QizaWbaa3
         8uhQxGUsLOI9A0JalcD7bJW0wzdgBNelDRaeM3ctMEDgGX+Uz5oajkuR5H1YfkHcpigo
         G2KQaNqj4n511G69G4Q90cU2ZPxzd3+bdhyBS6DlDYRB9CNebWoECiaUcRh/TYpxoRTb
         800U4dSaxogtVfwNL14NKOm+mhKQtefhCGkMhWJTv6Y3RMKJp6rNb3Oue1rlmv/LBsvk
         CWTk7bLH6vsGw6kRAzRzSDF5TgSmXAhB6ypBDQ9APQgJxC35hbhDj8qdNwgkCLRErp/z
         Vm0g==
X-Gm-Message-State: AOJu0Yx7e7h9bXMTGeIKITL/LLZJJkmNuKEFAsDR4DoSfMtCXzx12TLb
	yO5c7qqwRKZcBgwlZAkpDmjKqP7wcU3cN9RDNxiq02SqnZb5ChKnQ7GMvVpq8E8=
X-Google-Smtp-Source: AGHT+IEtOCxl98BOx97qmInh3XU9AWy/piuphXBOEDTC50/Q49BYrM5/J5YaRnvQ9PDEroX0GG7IUA==
X-Received: by 2002:a05:600c:468a:b0:431:47d4:19c7 with SMTP id 5b1f17b1804b1-43147d41ba6mr9248425e9.3.1729000598507;
        Tue, 15 Oct 2024 06:56:38 -0700 (PDT)
Received: from [127.0.1.1] (frhb82016ds.ikexpress.com. [185.246.87.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4313f56f241sm18848295e9.22.2024.10.15.06.56.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 06:56:38 -0700 (PDT)
From: Guillaume Stols <gstols@baylibre.com>
Date: Tue, 15 Oct 2024 13:56:20 +0000
Subject: [PATCH v5 7/8] iio: adc: ad7606: Add iio-backend support
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241015-ad7606_add_iio_backend_support-v5-7-654faf1ae08c@baylibre.com>
References: <20241015-ad7606_add_iio_backend_support-v5-0-654faf1ae08c@baylibre.com>
In-Reply-To: <20241015-ad7606_add_iio_backend_support-v5-0-654faf1ae08c@baylibre.com>
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
 aardelean@baylibre.com, dlechner@baylibre.com, jstephan@baylibre.com, 
 nuno.sa@analog.com, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Guillaume Stols <gstols@baylibre.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729000592; l=16895;
 i=gstols@baylibre.com; s=20240417; h=from:subject:message-id;
 bh=knvF5aKMvqbmI6xU45rnHDO+4jl4aWSRuRnTBvrdC14=;
 b=IOsLO5n2Bydup55KdpPSTpzhpAjfsK8lS+gFZsD4gucoIgzxOmdRrDPTv4Alx/RGsRfxL/Jc8
 +hBPimg+o80BqA8eW4I/nvNLMFDAZiuOClkEM4S65ILzEJj6txUOqsQ
X-Developer-Key: i=gstols@baylibre.com; a=ed25519;
 pk=XvMm5WHuV67sGYOJZqIYzXndbaJOlNd8Q6li6vnb4Cs=

- Basic support for iio backend.
- Supports IIO_CHAN_INFO_SAMP_FREQ R/W.
- Only hardware mode is available, and that IIO_CHAN_INFO_RAW is not
  supported if iio-backend mode is selected.

Signed-off-by: Guillaume Stols <gstols@baylibre.com>
---
 drivers/iio/adc/Kconfig      |   2 +
 drivers/iio/adc/ad7606.c     | 154 ++++++++++++++++++++++++++++++++++---------
 drivers/iio/adc/ad7606.h     |  15 +++++
 drivers/iio/adc/ad7606_par.c |  92 +++++++++++++++++++++++++-
 4 files changed, 231 insertions(+), 32 deletions(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 91873f60322d..a57b5f0bc070 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -224,9 +224,11 @@ config AD7606_IFACE_PARALLEL
 	tristate "Analog Devices AD7606 ADC driver with parallel interface support"
 	depends on HAS_IOPORT
 	select AD7606
+	select IIO_BACKEND
 	help
 	  Say yes here to build parallel interface support for Analog Devices:
 	  ad7605-4, ad7606, ad7606-6, ad7606-4 analog to digital converters (ADC).
+	  It also support iio_backended devices for AD7606B.
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called ad7606_par.
diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
index 34d377e9ac79..7871552ce5ac 100644
--- a/drivers/iio/adc/ad7606.c
+++ b/drivers/iio/adc/ad7606.c
@@ -21,6 +21,7 @@
 #include <linux/units.h>
 #include <linux/util_macros.h>
 
+#include <linux/iio/backend.h>
 #include <linux/iio/buffer.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
@@ -191,6 +192,7 @@ EXPORT_SYMBOL_NS_GPL(ad7606_4_info, IIO_AD7606);
 
 const struct ad7606_chip_info ad7606b_info = {
 	.channels = ad7606_channels_16bit,
+	.max_samplerate = 800 * KILO,
 	.name = "ad7606b",
 	.num_adc_channels = 8,
 	.num_channels = 9,
@@ -490,6 +492,17 @@ static int ad7606_pwm_set_low(struct ad7606_state *st)
 	return ret;
 }
 
+static int ad7606_pwm_set_swing(struct ad7606_state *st)
+{
+	struct pwm_state cnvst_pwm_state;
+
+	pwm_get_state(st->cnvst_pwm, &cnvst_pwm_state);
+	cnvst_pwm_state.enabled = true;
+	cnvst_pwm_state.duty_cycle = cnvst_pwm_state.period / 2;
+
+	return pwm_apply_might_sleep(st->cnvst_pwm, &cnvst_pwm_state);
+}
+
 static bool ad7606_pwm_is_swinging(struct ad7606_state *st)
 {
 	struct pwm_state cnvst_pwm_state;
@@ -576,11 +589,22 @@ static int ad7606_scan_direct(struct iio_dev *indio_dev, unsigned int ch,
 		if (ret < 0)
 			return ret;
 	}
-	ret = wait_for_completion_timeout(&st->completion,
-					  msecs_to_jiffies(1000));
-	if (!ret) {
-		ret = -ETIMEDOUT;
-		goto error_ret;
+
+	/*
+	 * If no backend, wait for the interruption on busy pin, otherwise just add
+	 * a delay to leave time for the data to be available. For now, the latter
+	 * will not happen because IIO_CHAN_INFO_RAW is not supported for the backend.
+	 * TODO: Add support for reading a single value when the backend is used.
+	 */
+	if (!st->back) {
+		ret = wait_for_completion_timeout(&st->completion,
+						  msecs_to_jiffies(1000));
+		if (!ret) {
+			ret = -ETIMEDOUT;
+			goto error_ret;
+		}
+	} else {
+		fsleep(1);
 	}
 
 	ret = ad7606_read_samples(st);
@@ -620,6 +644,7 @@ static int ad7606_read_raw(struct iio_dev *indio_dev,
 	int ret, ch = 0;
 	struct ad7606_state *st = iio_priv(indio_dev);
 	struct ad7606_chan_scale *cs;
+	struct pwm_state cnvst_pwm_state;
 
 	switch (m) {
 	case IIO_CHAN_INFO_RAW:
@@ -640,6 +665,14 @@ static int ad7606_read_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
 		*val = st->oversampling;
 		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		/*
+		 * TODO: return the real frequency intead of the requested one once
+		 * pwm_get_state_hw comes upstream.
+		 */
+		pwm_get_state(st->cnvst_pwm, &cnvst_pwm_state);
+		*val = DIV_ROUND_CLOSEST_ULL(NSEC_PER_SEC, cnvst_pwm_state.period);
+		return IIO_VAL_INT;
 	}
 	return -EINVAL;
 }
@@ -732,6 +765,10 @@ static int ad7606_write_raw(struct iio_dev *indio_dev,
 			return ret;
 
 		return 0;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		if (val < 0 && val2 != 0)
+			return -EINVAL;
+		return ad7606_set_sampling_freq(st, val);
 	default:
 		return -EINVAL;
 	}
@@ -914,14 +951,50 @@ static int ad7606_read_avail(struct iio_dev *indio_dev,
 	return -EINVAL;
 }
 
+static int ad7606_backend_buffer_postenable(struct iio_dev *indio_dev)
+{
+	struct ad7606_state *st = iio_priv(indio_dev);
+
+	return ad7606_pwm_set_swing(st);
+}
+
+static int ad7606_backend_buffer_predisable(struct iio_dev *indio_dev)
+{
+	struct ad7606_state *st = iio_priv(indio_dev);
+
+	return ad7606_pwm_set_low(st);
+}
+
+static int ad7606_update_scan_mode(struct iio_dev *indio_dev,
+				   const unsigned long *scan_mask)
+{
+	struct ad7606_state *st = iio_priv(indio_dev);
+
+	/*
+	 * The update scan mode is only for iio backend compatible drivers.
+	 * If the specific update_scan_mode is not defined in the bus ops,
+	 * just do nothing and return 0.
+	 */
+	if (!st->bops->update_scan_mode)
+		return 0;
+
+	return st->bops->update_scan_mode(indio_dev, scan_mask);
+}
+
 static const struct iio_buffer_setup_ops ad7606_buffer_ops = {
 	.postenable = &ad7606_buffer_postenable,
 	.predisable = &ad7606_buffer_predisable,
 };
 
+static const struct iio_buffer_setup_ops ad7606_backend_buffer_ops = {
+	.postenable = &ad7606_backend_buffer_postenable,
+	.predisable = &ad7606_backend_buffer_predisable,
+};
+
 static const struct iio_info ad7606_info_no_os_or_range = {
 	.read_raw = &ad7606_read_raw,
 	.validate_trigger = &ad7606_validate_trigger,
+	.update_scan_mode = &ad7606_update_scan_mode,
 };
 
 static const struct iio_info ad7606_info_os_and_range = {
@@ -929,6 +1002,7 @@ static const struct iio_info ad7606_info_os_and_range = {
 	.write_raw = &ad7606_write_raw,
 	.attrs = &ad7606_attribute_group_os_and_range,
 	.validate_trigger = &ad7606_validate_trigger,
+	.update_scan_mode = &ad7606_update_scan_mode,
 };
 
 static const struct iio_info ad7606_info_sw_mode = {
@@ -937,6 +1011,7 @@ static const struct iio_info ad7606_info_sw_mode = {
 	.read_avail = &ad7606_read_avail,
 	.debugfs_reg_access = &ad7606_reg_access,
 	.validate_trigger = &ad7606_validate_trigger,
+	.update_scan_mode = &ad7606_update_scan_mode,
 };
 
 static const struct iio_info ad7606_info_os = {
@@ -944,6 +1019,7 @@ static const struct iio_info ad7606_info_os = {
 	.write_raw = &ad7606_write_raw,
 	.attrs = &ad7606_attribute_group_os,
 	.validate_trigger = &ad7606_validate_trigger,
+	.update_scan_mode = &ad7606_update_scan_mode,
 };
 
 static const struct iio_info ad7606_info_range = {
@@ -951,6 +1027,7 @@ static const struct iio_info ad7606_info_range = {
 	.write_raw = &ad7606_write_raw,
 	.attrs = &ad7606_attribute_group_range,
 	.validate_trigger = &ad7606_validate_trigger,
+	.update_scan_mode = &ad7606_update_scan_mode,
 };
 
 static const struct iio_trigger_ops ad7606_trigger_ops = {
@@ -1070,8 +1147,6 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
 	indio_dev->channels = st->chip_info->channels;
 	indio_dev->num_channels = st->chip_info->num_channels;
 
-	init_completion(&st->completion);
-
 	ret = ad7606_reset(st);
 	if (ret)
 		dev_warn(st->dev, "failed to RESET: no RESET GPIO specified\n");
@@ -1118,34 +1193,51 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
 		if (ret)
 			return ret;
 	}
-	st->trig = devm_iio_trigger_alloc(dev, "%s-dev%d",
-					  indio_dev->name,
-					  iio_device_id(indio_dev));
-	if (!st->trig)
-		return -ENOMEM;
 
-	st->trig->ops = &ad7606_trigger_ops;
-	iio_trigger_set_drvdata(st->trig, indio_dev);
-	ret = devm_iio_trigger_register(dev, st->trig);
-	if (ret)
-		return ret;
+	if (st->bops->iio_backend_config) {
+		/*
+		 * If there is a backend, the PWM should not overpass the maximum sampling
+		 * frequency the chip supports.
+		 */
+		ret = ad7606_set_sampling_freq(st,
+					       chip_info->max_samplerate ? : 2 * KILO);
+		if (ret)
+			return ret;
+
+		ret = st->bops->iio_backend_config(dev, indio_dev);
+		if (ret)
+			return ret;
 
-	indio_dev->trig = iio_trigger_get(st->trig);
+		indio_dev->setup_ops = &ad7606_backend_buffer_ops;
+	} else {
+		init_completion(&st->completion);
+		st->trig = devm_iio_trigger_alloc(dev, "%s-dev%d",
+						  indio_dev->name,
+						  iio_device_id(indio_dev));
+		if (!st->trig)
+			return -ENOMEM;
+
+		st->trig->ops = &ad7606_trigger_ops;
+		iio_trigger_set_drvdata(st->trig, indio_dev);
+		ret = devm_iio_trigger_register(dev, st->trig);
+		if (ret)
+			return ret;
 
-	ret = devm_request_threaded_irq(dev, irq,
-					NULL,
-					&ad7606_interrupt,
-					IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
-					chip_info->name, indio_dev);
-	if (ret)
-		return ret;
+		indio_dev->trig = iio_trigger_get(st->trig);
 
-	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
-					      &iio_pollfunc_store_time,
-					      &ad7606_trigger_handler,
-					      &ad7606_buffer_ops);
-	if (ret)
-		return ret;
+		ret = devm_request_threaded_irq(dev, irq, NULL, &ad7606_interrupt,
+						IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
+						chip_info->name, indio_dev);
+		if (ret)
+			return ret;
+
+		ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
+						      &iio_pollfunc_store_time,
+						      &ad7606_trigger_handler,
+						      &ad7606_buffer_ops);
+		if (ret)
+			return ret;
+	}
 
 	return devm_iio_device_register(dev, indio_dev);
 }
diff --git a/drivers/iio/adc/ad7606.h b/drivers/iio/adc/ad7606.h
index b26a11b2eba1..2c629a15cc33 100644
--- a/drivers/iio/adc/ad7606.h
+++ b/drivers/iio/adc/ad7606.h
@@ -61,6 +61,12 @@
 
 #define AD7616_CHANNEL(num)	AD7606_SW_CHANNEL(num, 16)
 
+#define AD7606_BI_CHANNEL(num)				\
+	AD760X_CHANNEL(num, 0,				\
+		BIT(IIO_CHAN_INFO_SCALE),		\
+		BIT(IIO_CHAN_INFO_SAMP_FREQ) |		\
+		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO), 16)
+
 struct ad7606_state;
 
 typedef int (*ad7606_scale_setup_cb_t)(struct ad7606_state *st,
@@ -69,6 +75,7 @@ typedef int (*ad7606_scale_setup_cb_t)(struct ad7606_state *st,
 /**
  * struct ad7606_chip_info - chip specific information
  * @channels:		channel specification
+ * @max_samplerate:	maximum supported samplerate
  * @name		device name
  * @num_channels:	number of channels
  * @num_adc_channels	the number of channels the ADC actually inputs.
@@ -82,6 +89,7 @@ typedef int (*ad7606_scale_setup_cb_t)(struct ad7606_state *st,
  */
 struct ad7606_chip_info {
 	const struct iio_chan_spec	*channels;
+	unsigned int			max_samplerate;
 	const char			*name;
 	unsigned int			num_adc_channels;
 	unsigned int			num_channels;
@@ -152,6 +160,7 @@ struct ad7606_state {
 	bool				sw_mode_en;
 	const unsigned int		*oversampling_avail;
 	unsigned int			num_os_ratios;
+	struct iio_backend		*back;
 	int (*write_scale)(struct iio_dev *indio_dev, int ch, int val);
 	int (*write_os)(struct iio_dev *indio_dev, int val);
 
@@ -180,16 +189,21 @@ struct ad7606_state {
 
 /**
  * struct ad7606_bus_ops - driver bus operations
+ * @iio_backend_config	function pointer for configuring the iio_backend for
+ *			the compatibles that use it
  * @read_block		function pointer for reading blocks of data
  * @sw_mode_config:	pointer to a function which configured the device
  *			for software mode
  * @reg_read	function pointer for reading spi register
  * @reg_write	function pointer for writing spi register
  * @write_mask	function pointer for write spi register with mask
+ * @update_scan_mode	function pointer for handling the calls to iio_info's update_scan
+ *			mode when enabling/disabling channels.
  * @rd_wr_cmd	pointer to the function which calculates the spi address
  */
 struct ad7606_bus_ops {
 	/* more methods added in future? */
+	int (*iio_backend_config)(struct device *dev, struct iio_dev *indio_dev);
 	int (*read_block)(struct device *dev, int num, void *data);
 	int (*sw_mode_config)(struct iio_dev *indio_dev);
 	int (*reg_read)(struct ad7606_state *st, unsigned int addr);
@@ -200,6 +214,7 @@ struct ad7606_bus_ops {
 				 unsigned int addr,
 				 unsigned long mask,
 				 unsigned int val);
+	int (*update_scan_mode)(struct iio_dev *indio_dev, const unsigned long *scan_mask);
 	u16 (*rd_wr_cmd)(int addr, char isWriteOp);
 };
 
diff --git a/drivers/iio/adc/ad7606_par.c b/drivers/iio/adc/ad7606_par.c
index b87be2f1ca04..6946ff00e4cb 100644
--- a/drivers/iio/adc/ad7606_par.c
+++ b/drivers/iio/adc/ad7606_par.c
@@ -2,7 +2,8 @@
 /*
  * AD7606 Parallel Interface ADC driver
  *
- * Copyright 2011 Analog Devices Inc.
+ * Copyright 2011 - 2024 Analog Devices Inc.
+ * Copyright 2024 BayLibre SAS.
  */
 
 #include <linux/err.h>
@@ -14,9 +15,82 @@
 #include <linux/property.h>
 #include <linux/types.h>
 
+#include <linux/iio/backend.h>
 #include <linux/iio/iio.h>
+
 #include "ad7606.h"
 
+static const struct iio_chan_spec ad7606b_bi_channels[] = {
+	AD7606_BI_CHANNEL(0),
+	AD7606_BI_CHANNEL(1),
+	AD7606_BI_CHANNEL(2),
+	AD7606_BI_CHANNEL(3),
+	AD7606_BI_CHANNEL(4),
+	AD7606_BI_CHANNEL(5),
+	AD7606_BI_CHANNEL(6),
+	AD7606_BI_CHANNEL(7),
+};
+
+static int ad7606_bi_update_scan_mode(struct iio_dev *indio_dev, const unsigned long *scan_mask)
+{
+	struct ad7606_state *st = iio_priv(indio_dev);
+	unsigned int c, ret;
+
+	for (c = 0; c < indio_dev->num_channels; c++) {
+		if (test_bit(c, scan_mask))
+			ret = iio_backend_chan_enable(st->back, c);
+		else
+			ret = iio_backend_chan_disable(st->back, c);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int ad7606_bi_setup_iio_backend(struct device *dev, struct iio_dev *indio_dev)
+{
+	struct ad7606_state *st = iio_priv(indio_dev);
+	unsigned int ret, c;
+	struct iio_backend_data_fmt data = {
+		.sign_extend = true,
+		.enable = true,
+	};
+
+	st->back = devm_iio_backend_get(dev, NULL);
+	if (IS_ERR(st->back))
+		return PTR_ERR(st->back);
+
+	/* If the device is iio_backend powered the PWM is mandatory */
+	if (!st->cnvst_pwm)
+		return dev_err_probe(st->dev, -EINVAL,
+				     "A PWM is mandatory when using backend.\n");
+
+	ret = devm_iio_backend_request_buffer(dev, st->back, indio_dev);
+	if (ret)
+		return ret;
+
+	ret = devm_iio_backend_enable(dev, st->back);
+	if (ret)
+		return ret;
+
+	for (c = 0; c < indio_dev->num_channels; c++) {
+		ret = iio_backend_data_format_set(st->back, c, &data);
+		if (ret)
+			return ret;
+	}
+
+	indio_dev->channels = ad7606b_bi_channels;
+	indio_dev->num_channels = 8;
+
+	return 0;
+}
+
+static const struct ad7606_bus_ops ad7606_bi_bops = {
+	.iio_backend_config = ad7606_bi_setup_iio_backend,
+	.update_scan_mode = ad7606_bi_update_scan_mode,
+};
+
 static int ad7606_par16_read_block(struct device *dev,
 				   int count, void *buf)
 {
@@ -96,9 +170,22 @@ static int ad7606_par_probe(struct platform_device *pdev)
 	void __iomem *addr;
 	resource_size_t remap_size;
 	int irq;
+	struct iio_backend *back;
 
+	/*
+	 * If a firmware node is available (ACPI or DT), platform_device_id is null
+	 * and we must use get_match_data.
+	 */
 	if (dev_fwnode(&pdev->dev)) {
 		chip_info = device_get_match_data(&pdev->dev);
+		if (device_property_present(&pdev->dev, "io-backends"))
+			/*
+			 * If a backend is available ,call the core probe with backend
+			 * bops, otherwise use the former bops.
+			 */
+			return ad7606_probe(&pdev->dev, 0, NULL,
+					    chip_info,
+					    &ad7606_bi_bops);
 	} else {
 		id = platform_get_device_id(pdev);
 		chip_info = (const struct ad7606_chip_info *)id->driver_data;
@@ -124,6 +211,7 @@ static const struct platform_device_id ad7606_driver_ids[] = {
 	{ .name	= "ad7606-4", .driver_data = (kernel_ulong_t)&ad7606_4_info, },
 	{ .name	= "ad7606-6", .driver_data = (kernel_ulong_t)&ad7606_6_info, },
 	{ .name	= "ad7606-8", .driver_data = (kernel_ulong_t)&ad7606_8_info, },
+	{ .name	= "ad7606b", .driver_data = (kernel_ulong_t)&ad7606b_info, },
 	{ }
 };
 MODULE_DEVICE_TABLE(platform, ad7606_driver_ids);
@@ -133,6 +221,7 @@ static const struct of_device_id ad7606_of_match[] = {
 	{ .compatible = "adi,ad7606-4", .data = &ad7606_4_info },
 	{ .compatible = "adi,ad7606-6", .data = &ad7606_6_info },
 	{ .compatible = "adi,ad7606-8", .data = &ad7606_8_info },
+	{ .compatible = "adi,ad7606b", .data = &ad7606b_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, ad7606_of_match);
@@ -152,3 +241,4 @@ MODULE_AUTHOR("Michael Hennerich <michael.hennerich@analog.com>");
 MODULE_DESCRIPTION("Analog Devices AD7606 ADC");
 MODULE_LICENSE("GPL v2");
 MODULE_IMPORT_NS(IIO_AD7606);
+MODULE_IMPORT_NS(IIO_BACKEND);

-- 
2.34.1


