Return-Path: <linux-pwm+bounces-3485-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C2899911D0
	for <lists+linux-pwm@lfdr.de>; Fri,  4 Oct 2024 23:51:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EAD60B222E7
	for <lists+linux-pwm@lfdr.de>; Fri,  4 Oct 2024 21:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E221D9691;
	Fri,  4 Oct 2024 21:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ghUk4CZI"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C591D958C
	for <linux-pwm@vger.kernel.org>; Fri,  4 Oct 2024 21:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728078544; cv=none; b=b6qPKt19WqbjQP7If65lDLG+gEI/W+3NED4VhTu0U9rgQJvo1NfRZ+01lTgip5+BHE3S4R7jN3TPI+pv3OqEvDQxO+3C65VczWHBfGkOAsiYGeQP/90xy0JU0hs5dZSnNqNBmvtxKN3hflPJ4BNjUQs1va3IjfuDdrSWCV9v5QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728078544; c=relaxed/simple;
	bh=uxF55S0JXT7v+zGPwPebUz4jkIJV6ru9p3/cgQuby9M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ChAWXVmax0LEWi5mUrDi/9WyOSAUlOCZxp1QNCWG90xskDAw9vbZOsgXdZF1WQw2Xwu5+Lh1n7rTfNqjjBWdzl4AgAHG/x3tBPMy/PZHdd4XgEhrI5KMT1h9PlNRSPuSyNfpytdTTy6d0SWL32P8kBGCtXcrMNN7w4DOsHNR1Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ghUk4CZI; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42cde6b5094so25950255e9.3
        for <linux-pwm@vger.kernel.org>; Fri, 04 Oct 2024 14:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728078538; x=1728683338; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mVqaa9cyNAYsLFWXMQVgjjISK5eJ+wBNXbIRMd5YpCM=;
        b=ghUk4CZIA/PsaC801MciY+2j8bVjQ4CMyPChLPTr39C0lsDz2bjuAF6tksn/O2DDa5
         YvKwcO283754i/i/vp9pJV9aEmAFNDzSb6/6JIxEVfgsxzqjs/5wffC+SXINz0Z5Nicn
         VAKbd93DI+wgahM3RpWNztYeKUwaWEtFQ5GuHoH0fX7+MJdm9UPBjcaolPAqF8BSyQgh
         DemFWqF1JN1TyWu92wCfZd/JYmCguimkN+oB4VmFE1bufmqNNjPlk/3FE5wcQDhog0HB
         6C084tUrnQl6Dv7GYXkSkr5wSnhxDh9aYcFO5YjmiFmV8RqQ7F2osMNP8uKVMvay4Ion
         +Wug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728078538; x=1728683338;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mVqaa9cyNAYsLFWXMQVgjjISK5eJ+wBNXbIRMd5YpCM=;
        b=dbYNLsWUC24q5bgr3XaKiECBCyWEpWvdRoENZbgGEL7mm9fNtvwo5JBwUrenSTkBYk
         GDgzj63NejtTTCe1StqMbh7a+gfWqsgi9V0VythKrMtTzoKKCX/H/KZ71oKlTcOP1/z+
         mCfbNhNFALr3rYjLNT5ajdSvtA16zG94JyxXMfuP9WTx6lXPb75knc7RJWFjHrOQ0tIt
         A6SngWh8mo5cqRXAqJmhxlrTXImNcKR29q24/mKFx2XNEw07KgAsJ6uVSG0Aep/ZX4oo
         HTqqAuRv6Ie16iakLgFDwJNscQ+H6jEYI+nLhL+yoqi8Vv4cl0KvbYC0kDQQsdDOF67U
         1gEQ==
X-Gm-Message-State: AOJu0Ywx5WwgpUi/PObfK+4BWGeMfhRtx+/wH8RfQm4n1COoFMtGDESu
	ji29tLt3Sd+9hOMMuIrJ99ZR2bnFrWnRWyKueelEjPdCNgrzyxFuveHOUEwu7y0=
X-Google-Smtp-Source: AGHT+IHzy95ua6wMPvOrQQuyINtSdcPyglzjZmAPTZnxAcdpWc4EN+FjTQ81OTpMStoluOKAutcBLA==
X-Received: by 2002:a05:600c:468f:b0:42c:af06:718 with SMTP id 5b1f17b1804b1-42f85aea086mr31212845e9.28.1728078537985;
        Fri, 04 Oct 2024 14:48:57 -0700 (PDT)
Received: from [127.0.1.1] (frhb82016ds.ikexpress.com. [185.246.87.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f86b4ab63sm24680375e9.40.2024.10.04.14.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 14:48:57 -0700 (PDT)
From: Guillaume Stols <gstols@baylibre.com>
Date: Fri, 04 Oct 2024 21:48:43 +0000
Subject: [PATCH v3 09/10] iio: adc: ad7606: Add iio-backend support
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241004-ad7606_add_iio_backend_support-v3-9-38757012ce82@baylibre.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728078523; l=16196;
 i=gstols@baylibre.com; s=20240417; h=from:subject:message-id;
 bh=uxF55S0JXT7v+zGPwPebUz4jkIJV6ru9p3/cgQuby9M=;
 b=9Jb1L2PvSmK20/z4ofwCBVgRHz3dj5Y702QYtI8tnAB2TfCK5kJgJqPhJrpIL4S95Z6Zkiob0
 EAgc62MbHKqAkfR7A3htvl4E8qUMdxc0bwPBJDxHdTDJg0bSBvML2eN
X-Developer-Key: i=gstols@baylibre.com; a=ed25519;
 pk=XvMm5WHuV67sGYOJZqIYzXndbaJOlNd8Q6li6vnb4Cs=

- Basic support for iio backend.
- Supports IIO_CHAN_INFO_SAMP_FREQ R/W.
- Only hardware mode is available, and that IIO_CHAN_INFO_RAW is not
  supported if iio-backend mode is selected.

Signed-off-by: Guillaume Stols <gstols@baylibre.com>
---
 drivers/iio/adc/Kconfig      |   2 +
 drivers/iio/adc/ad7606.c     | 124 +++++++++++++++++++++++++++++++++++++------
 drivers/iio/adc/ad7606.h     |  15 ++++++
 drivers/iio/adc/ad7606_par.c |  94 +++++++++++++++++++++++++++++++-
 4 files changed, 219 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 4ab1a3092d88..9b52d5b2c592 100644
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
index 3666a58f8a6f..d86eb7c3e4f7 100644
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
@@ -496,6 +498,20 @@ static int ad7606_pwm_set_low(struct ad7606_state *st)
 	return ret;
 }
 
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
 static bool ad7606_pwm_is_swinging(struct ad7606_state *st)
 {
 	struct pwm_state cnvst_pwm_state;
@@ -580,11 +596,22 @@ static int ad7606_scan_direct(struct iio_dev *indio_dev, unsigned int ch,
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
@@ -625,6 +652,7 @@ static int ad7606_read_raw(struct iio_dev *indio_dev,
 	int ret, ch = 0;
 	struct ad7606_state *st = iio_priv(indio_dev);
 	struct ad7606_chan_scale *cs;
+	struct pwm_state cnvst_pwm_state;
 
 	switch (m) {
 	case IIO_CHAN_INFO_RAW:
@@ -645,6 +673,14 @@ static int ad7606_read_raw(struct iio_dev *indio_dev,
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
@@ -737,6 +773,10 @@ static int ad7606_write_raw(struct iio_dev *indio_dev,
 			return ret;
 
 		return 0;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		if (val < 0 && val2 != 0)
+			return -EINVAL;
+		return ad7606_set_sampling_freq(st, val);
 	default:
 		return -EINVAL;
 	}
@@ -906,14 +946,50 @@ static int ad7606_read_avail(struct iio_dev *indio_dev,
 	return -EINVAL;
 }
 
+static int ad7606_pwm_buffer_postenable(struct iio_dev *indio_dev)
+{
+	struct ad7606_state *st = iio_priv(indio_dev);
+
+	return ad7606_pwm_set_swing(st);
+}
+
+static int ad7606_pwm_buffer_predisable(struct iio_dev *indio_dev)
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
 
+static const struct iio_buffer_setup_ops ad7606_pwm_buffer_ops = {
+	.postenable = &ad7606_pwm_buffer_postenable,
+	.predisable = &ad7606_pwm_buffer_predisable,
+};
+
 static const struct iio_info ad7606_info_no_os_or_range = {
 	.read_raw = &ad7606_read_raw,
 	.validate_trigger = &ad7606_validate_trigger,
+	.update_scan_mode = &ad7606_update_scan_mode,
 };
 
 static const struct iio_info ad7606_info_os_and_range = {
@@ -921,6 +997,7 @@ static const struct iio_info ad7606_info_os_and_range = {
 	.write_raw = &ad7606_write_raw,
 	.attrs = &ad7606_attribute_group_os_and_range,
 	.validate_trigger = &ad7606_validate_trigger,
+	.update_scan_mode = &ad7606_update_scan_mode,
 };
 
 static const struct iio_info ad7606_info_sw_mode = {
@@ -929,6 +1006,7 @@ static const struct iio_info ad7606_info_sw_mode = {
 	.read_avail = &ad7606_read_avail,
 	.debugfs_reg_access = &ad7606_reg_access,
 	.validate_trigger = &ad7606_validate_trigger,
+	.update_scan_mode = &ad7606_update_scan_mode,
 };
 
 static const struct iio_info ad7606_info_os = {
@@ -936,6 +1014,7 @@ static const struct iio_info ad7606_info_os = {
 	.write_raw = &ad7606_write_raw,
 	.attrs = &ad7606_attribute_group_os,
 	.validate_trigger = &ad7606_validate_trigger,
+	.update_scan_mode = &ad7606_update_scan_mode,
 };
 
 static const struct iio_info ad7606_info_range = {
@@ -943,6 +1022,7 @@ static const struct iio_info ad7606_info_range = {
 	.write_raw = &ad7606_write_raw,
 	.attrs = &ad7606_attribute_group_range,
 	.validate_trigger = &ad7606_validate_trigger,
+	.update_scan_mode = &ad7606_update_scan_mode,
 };
 
 static const struct iio_trigger_ops ad7606_trigger_ops = {
@@ -1062,8 +1142,6 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
 	indio_dev->channels = st->chip_info->channels;
 	indio_dev->num_channels = st->chip_info->num_channels;
 
-	init_completion(&st->completion);
-
 	ret = ad7606_reset(st);
 	if (ret)
 		dev_warn(st->dev, "failed to RESET: no RESET GPIO specified\n");
@@ -1108,7 +1186,24 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
 					       st->cnvst_pwm);
 		if (ret)
 			return ret;
+	}
+
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
+		indio_dev->setup_ops = &ad7606_pwm_buffer_ops;
 	} else {
+		init_completion(&st->completion);
 		st->trig = devm_iio_trigger_alloc(dev, "%s-dev%d",
 						  indio_dev->name,
 						  iio_device_id(indio_dev));
@@ -1126,15 +1221,14 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
 						      &ad7606_buffer_ops);
 		if (ret)
 			return ret;
+		ret = devm_request_threaded_irq(dev, irq,
+						NULL,
+						&ad7606_interrupt,
+						IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
+						chip_info->name, indio_dev);
+		if (ret)
+			return ret;
 	}
-	ret = devm_request_threaded_irq(dev, irq,
-					NULL,
-					&ad7606_interrupt,
-					IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
-					chip_info->name, indio_dev);
-	if (ret)
-		return ret;
-
 	return devm_iio_device_register(dev, indio_dev);
 }
 EXPORT_SYMBOL_NS_GPL(ad7606_probe, IIO_AD7606);
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
index b87be2f1ca04..6042f6799272 100644
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
@@ -14,9 +15,83 @@
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
+const struct ad7606_bus_ops ad7606_bi_bops = {
+	.iio_backend_config = ad7606_bi_setup_iio_backend,
+	.update_scan_mode = ad7606_bi_update_scan_mode,
+};
+EXPORT_SYMBOL_NS_GPL(ad7606_bi_bops, IIO_AD7606);
+
 static int ad7606_par16_read_block(struct device *dev,
 				   int count, void *buf)
 {
@@ -96,9 +171,23 @@ static int ad7606_par_probe(struct platform_device *pdev)
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
+		back = devm_iio_backend_get(&pdev->dev, NULL);
+		if (!IS_ERR(back))
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
@@ -124,6 +213,7 @@ static const struct platform_device_id ad7606_driver_ids[] = {
 	{ .name	= "ad7606-4", .driver_data = (kernel_ulong_t)&ad7606_4_info, },
 	{ .name	= "ad7606-6", .driver_data = (kernel_ulong_t)&ad7606_6_info, },
 	{ .name	= "ad7606-8", .driver_data = (kernel_ulong_t)&ad7606_8_info, },
+	{ .name	= "ad7606b", .driver_data = (kernel_ulong_t)&ad7606b_info, },
 	{ }
 };
 MODULE_DEVICE_TABLE(platform, ad7606_driver_ids);
@@ -133,6 +223,7 @@ static const struct of_device_id ad7606_of_match[] = {
 	{ .compatible = "adi,ad7606-4", .data = &ad7606_4_info },
 	{ .compatible = "adi,ad7606-6", .data = &ad7606_6_info },
 	{ .compatible = "adi,ad7606-8", .data = &ad7606_8_info },
+	{ .compatible = "adi,ad7606b", .data = &ad7606b_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, ad7606_of_match);
@@ -152,3 +243,4 @@ MODULE_AUTHOR("Michael Hennerich <michael.hennerich@analog.com>");
 MODULE_DESCRIPTION("Analog Devices AD7606 ADC");
 MODULE_LICENSE("GPL v2");
 MODULE_IMPORT_NS(IIO_AD7606);
+MODULE_IMPORT_NS(IIO_BACKEND);

-- 
2.34.1


