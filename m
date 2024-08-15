Return-Path: <linux-pwm+bounces-3020-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80FD5952E13
	for <lists+linux-pwm@lfdr.de>; Thu, 15 Aug 2024 14:13:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3A66B23D37
	for <lists+linux-pwm@lfdr.de>; Thu, 15 Aug 2024 12:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E0D19EEA4;
	Thu, 15 Aug 2024 12:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="KlgFPHD7"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C0A17C9B6
	for <linux-pwm@vger.kernel.org>; Thu, 15 Aug 2024 12:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723723936; cv=none; b=TruEOBTCuWrlBqsWH7/daZvoAKD2umaOBuRRCe26eS6p7nshinCWAI+hlkde5W58A/QtpzE/Vq/Mn9StI/1IWQbn+mF09jW56Lbp1lYaQYMdE6kp91MN5gsCkMBdrigZX78O0lM1/wglzVuuG66mFQ4BpEwsI/jRYFL4Vr60K44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723723936; c=relaxed/simple;
	bh=Xa18CiY1WUs7s+G2+TH89jQYkhJjsmYHoYi+3712ovI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dYdw0ZSMaVTd+k8jqHiV4d47h4nckfilAmgkCK5LTOHSpKRbiZcvgSlIMapxuM2SEDOjkq9evZ8WEWVP2YXLNdCtpbTa6woYYUPZoY2nU0AbQ+Qf3DC/sObY00eOUJ4Rg+KHNKtxZrMv5SDG/0Y8plk27RGsE/ajfyvAWy1qCxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=KlgFPHD7; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-428163f7635so5894435e9.2
        for <linux-pwm@vger.kernel.org>; Thu, 15 Aug 2024 05:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1723723931; x=1724328731; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NFA32zQInRzfe5yf5AB0IBnuMx8Nixl7dIHw/E3hc08=;
        b=KlgFPHD7cs6/os2ZBA2wlnDk5KJ4aH8fiQB2gBxDNeJiFBM4nJwteYYbQuXpNryp1z
         gpzVAoOjfT5t0AyP6rALVetKnCYY3MqSBaiWXrU86zz/ZJyc7v0v444322rRG9qR73ZO
         92njbgTR4hBFvhUUKDsr3WGEbjl+j1Qi0vKv7C+bmalcXj18bS4IubrdDw3Cpb0H9kPs
         IeByW/r6F95PSlON1feeUVpN0amDXTkR3TZ5sXDQYqzmc+wpc/O+NdMzjEQvuIM8y5h4
         reeJ45RvP4Ju2TLG7BXfvi6nJSJHACb7dSggmXJM1RzpN1XXLmtUxhWD+BgS1DecPHKu
         QCWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723723931; x=1724328731;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NFA32zQInRzfe5yf5AB0IBnuMx8Nixl7dIHw/E3hc08=;
        b=mk9dENkXTKfJIOVdAw8PYm0Lvp6Na9XffwUlvgBshiRc+uFgbnOsRXwaHCMYgclyBJ
         FhFXHLww06tu3Fvl9CWX3cdSicMzflAAzg0F6HDE4aiCscuApFlNixxB+d9QDUQeqaiI
         3jNQQm2/n5GfQIVXP98EhZgxY+F53mSjpb6I2GA+2Lj/c88/XEC1P6B/NGjdS6vx+1oe
         zaVJfowmm5729uxBLPXyCbQBRJPItxXi3q/DAX8QefjL0xbWB9xYPF7SJGe/+n2UXwv8
         0LX5ZIvrwQ95Q20ttS6VR2kxHttXQFZCRE2yBHuhiXoTla8ldqP06F15Tvh4BttaMAY9
         w/DA==
X-Gm-Message-State: AOJu0Yxs9KE9bHxL7930EiFWLlC/MEc9x8ksWEaie07vl6uz2ZMsbn0A
	tqMG4HyfyMF/oM32FlIzJ9WADkfg1NcBsASs+ma05YZE3d0SKKYGniuR4Ok83Yk=
X-Google-Smtp-Source: AGHT+IF2q3Oty0cmk0APfAZsZllQRS35rMaowkUqqgk3gmq/RGgkzPytR7aQCKDoA+MrTOelM3VcbA==
X-Received: by 2002:a05:600c:138e:b0:427:d8fd:42a9 with SMTP id 5b1f17b1804b1-429dd247c0bmr39792025e9.22.1723723930430;
        Thu, 15 Aug 2024 05:12:10 -0700 (PDT)
Received: from [127.0.1.1] (frhb82016ds.ikexpress.com. [185.246.87.17])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37189897926sm1365082f8f.87.2024.08.15.05.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 05:12:10 -0700 (PDT)
From: Guillaume Stols <gstols@baylibre.com>
Date: Thu, 15 Aug 2024 12:12:02 +0000
Subject: [PATCH 8/8] iio:adc:ad7606: Add iio-backend support
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240815-ad7606_add_iio_backend_support-v1-8-cea3e11b1aa4@baylibre.com>
References: <20240815-ad7606_add_iio_backend_support-v1-0-cea3e11b1aa4@baylibre.com>
In-Reply-To: <20240815-ad7606_add_iio_backend_support-v1-0-cea3e11b1aa4@baylibre.com>
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
 Guillaume Stols <gstols@baylibre.com>, 
 20240705211452.1157967-2-u.kleine-koenig@baylibre.com, 
 20240712171821.1470833-2-u.kleine-koenig@baylibre.com, 
 cover.1721040875.git.u.kleine-koenig@baylibre.com, aardelean@baylibre.com
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723723923; l=15684;
 i=gstols@baylibre.com; s=20240417; h=from:subject:message-id;
 bh=Xa18CiY1WUs7s+G2+TH89jQYkhJjsmYHoYi+3712ovI=;
 b=46nOiiSOXC3/K9nBMdvsND8Zy8yMu9lqq6Ja91ejfGSnWokBMrCCsawpC+cPC8dALfvEHLB+i
 ET3fpMadIu9C9a+UZpcqVVB9+Ok3xG+d3z7Nwd5GmbPtKipY+3Zw+zk
X-Developer-Key: i=gstols@baylibre.com; a=ed25519;
 pk=XvMm5WHuV67sGYOJZqIYzXndbaJOlNd8Q6li6vnb4Cs=

- Basic support for iio backend.
- Supports IIO_CHAN_INFO_SAMP_FREQ R/W.
- Only hardware mode is available, and that IIO_CHAN_INFO_RAW is not
  supported if iio-backend mode is selected.

A small correction was added to the driver's file name in the Kconfig
file's description.

Signed-off-by: Guillaume Stols <gstols@baylibre.com>
---
 drivers/iio/adc/Kconfig      |   3 +-
 drivers/iio/adc/ad7606.c     | 103 +++++++++++++++++++++++++++++++++++--------
 drivers/iio/adc/ad7606.h     |  16 +++++++
 drivers/iio/adc/ad7606_par.c |  98 +++++++++++++++++++++++++++++++++++++++-
 4 files changed, 200 insertions(+), 20 deletions(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 88e8ce2e78b3..01248b6df868 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -227,9 +227,10 @@ config AD7606_IFACE_PARALLEL
 	help
 	  Say yes here to build parallel interface support for Analog Devices:
 	  ad7605-4, ad7606, ad7606-6, ad7606-4 analog to digital converters (ADC).
+	  It also support iio_backended devices for AD7606B.
 
 	  To compile this driver as a module, choose M here: the
-	  module will be called ad7606_parallel.
+	  module will be called ad7606_par.
 
 config AD7606_IFACE_SPI
 	tristate "Analog Devices AD7606 ADC driver with spi interface support"
diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
index 99d5ca5c2348..a753d5caa9f8 100644
--- a/drivers/iio/adc/ad7606.c
+++ b/drivers/iio/adc/ad7606.c
@@ -21,6 +21,7 @@
 #include <linux/util_macros.h>
 #include <linux/units.h>
 
+#include <linux/iio/backend.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/buffer.h>
 #include <linux/iio/sysfs.h>
@@ -148,7 +149,15 @@ static int ad7606_set_sampling_freq(struct ad7606_state *st, unsigned long freq)
 
 static int ad7606_read_samples(struct ad7606_state *st)
 {
-	unsigned int num = st->chip_info->num_channels - 1;
+	unsigned int num = st->chip_info->num_channels;
+
+	/*
+	 * Timestamp channel does not contain sample, and no timestamp channel if
+	 * backend is used.
+	 */
+	if (!st->back)
+		num--;
+
 	u16 *data = st->data;
 	int ret;
 
@@ -220,11 +229,15 @@ static int ad7606_scan_direct(struct iio_dev *indio_dev, unsigned int ch)
 		if (!ret)
 			return ret;
 	}
-	ret = wait_for_completion_timeout(&st->completion,
-					  msecs_to_jiffies(1000));
-	if (!ret) {
-		ret = -ETIMEDOUT;
-		goto error_ret;
+
+	/* backend manages interruptions by itself.*/
+	if (!st->back) {
+		ret = wait_for_completion_timeout(&st->completion,
+						  msecs_to_jiffies(1000));
+		if (!ret) {
+			ret = -ETIMEDOUT;
+			goto error_ret;
+		}
 	}
 
 	ret = ad7606_read_samples(st);
@@ -271,6 +284,12 @@ static int ad7606_read_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
 		*val = st->oversampling;
 		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		pwm_get_state_hw(st->cnvst_pwm, &cnvst_pwm_state);
+		/* If the PWM is swinging, return the real frequency, otherwise 0 */
+		*val = ad7606_pwm_is_swinging(st) ?
+			DIV_ROUND_CLOSEST_ULL(NSEC_PER_SEC, cnvst_pwm_state.period) : 0;
+		return IIO_VAL_INT;
 	}
 	return -EINVAL;
 }
@@ -360,6 +379,8 @@ static int ad7606_write_raw(struct iio_dev *indio_dev,
 			return ret;
 
 		return 0;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		return ad7606_set_sampling_freq(st, val);
 	default:
 		return -EINVAL;
 	}
@@ -482,7 +503,6 @@ static int ad7606_buffer_postenable(struct iio_dev *indio_dev)
 	struct ad7606_state *st = iio_priv(indio_dev);
 
 	gpiod_set_value(st->gpio_convst, 1);
-	ad7606_pwm_set_swing(st);
 
 	return 0;
 }
@@ -492,19 +512,53 @@ static int ad7606_buffer_predisable(struct iio_dev *indio_dev)
 	struct ad7606_state *st = iio_priv(indio_dev);
 
 	gpiod_set_value(st->gpio_convst, 0);
-	ad7606_pwm_set_low(st);
 
 	return 0;
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
+	/* The update scan mode is only for iio backend compatible drivers.
+	 * If the specific update_scan_mode is not defined in the bus ops,
+	 * just do nothing and return 0.
+	 */
+	if (st->bops->update_scan_mode)
+		return st->bops->update_scan_mode(indio_dev, scan_mask);
+	else
+		return 0;
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
@@ -512,6 +566,7 @@ static const struct iio_info ad7606_info_os_and_range = {
 	.write_raw = &ad7606_write_raw,
 	.attrs = &ad7606_attribute_group_os_and_range,
 	.validate_trigger = &ad7606_validate_trigger,
+	.update_scan_mode = &ad7606_update_scan_mode,
 };
 
 static const struct iio_info ad7606_info_os_range_and_debug = {
@@ -520,6 +575,7 @@ static const struct iio_info ad7606_info_os_range_and_debug = {
 	.debugfs_reg_access = &ad7606_reg_access,
 	.attrs = &ad7606_attribute_group_os_and_range,
 	.validate_trigger = &ad7606_validate_trigger,
+	.update_scan_mode = &ad7606_update_scan_mode,
 };
 
 static const struct iio_info ad7606_info_os = {
@@ -527,6 +583,7 @@ static const struct iio_info ad7606_info_os = {
 	.write_raw = &ad7606_write_raw,
 	.attrs = &ad7606_attribute_group_os,
 	.validate_trigger = &ad7606_validate_trigger,
+	.update_scan_mode = &ad7606_update_scan_mode,
 };
 
 static const struct iio_info ad7606_info_range = {
@@ -534,6 +591,7 @@ static const struct iio_info ad7606_info_range = {
 	.write_raw = &ad7606_write_raw,
 	.attrs = &ad7606_attribute_group_range,
 	.validate_trigger = &ad7606_validate_trigger,
+	.update_scan_mode = &ad7606_update_scan_mode,
 };
 
 static const struct iio_trigger_ops ad7606_trigger_ops = {
@@ -602,8 +660,6 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
 	indio_dev->channels = st->chip_info->channels;
 	indio_dev->num_channels = st->chip_info->num_channels;
 
-	init_completion(&st->completion);
-
 	ret = ad7606_reset(st);
 	if (ret)
 		dev_warn(st->dev, "failed to RESET: no RESET GPIO specified\n");
@@ -635,7 +691,7 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
 			return ret;
 	}
 
-	/* If convst pin is not defined, setup PWM*/
+	/* If convst pin is not defined, setup PWM */
 	if (!st->gpio_convst) {
 		st->cnvst_pwm = devm_pwm_get(dev, NULL);
 		if (IS_ERR(st->cnvst_pwm))
@@ -671,14 +727,25 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
 		if (ret)
 			return ret;
 	}
-	ret = devm_request_threaded_irq(dev, irq,
-					NULL,
-					&ad7606_interrupt,
-					IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
-					chip_info->name, indio_dev);
-	if (ret)
-		return ret;
 
+	if (st->bops->iio_backend_config) {
+		st->bops->iio_backend_config(dev, indio_dev);
+		indio_dev->setup_ops = &ad7606_pwm_buffer_ops;
+	} else {
+		/* Reserve the PWM use only for backend (force gpio_convst definition)*/
+		if (!st->gpio_convst)
+			return dev_err_probe(dev, -EINVAL,
+					     "Convst pin must be defined when not in backend mode");
+
+		init_completion(&st->completion);
+		ret = devm_request_threaded_irq(dev, irq,
+						NULL,
+						&ad7606_interrupt,
+						IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
+						chip_info->name, indio_dev);
+		if (ret)
+			return ret;
+	}
 	return devm_iio_device_register(dev, indio_dev);
 }
 EXPORT_SYMBOL_NS_GPL(ad7606_probe, IIO_AD7606);
diff --git a/drivers/iio/adc/ad7606.h b/drivers/iio/adc/ad7606.h
index aab8fefb84be..9a098cd77812 100644
--- a/drivers/iio/adc/ad7606.h
+++ b/drivers/iio/adc/ad7606.h
@@ -34,6 +34,12 @@
 		BIT(IIO_CHAN_INFO_SCALE),		\
 		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO))
 
+#define AD7606_BI_CHANNEL(num)				\
+	AD760X_CHANNEL(num, 0,				\
+		BIT(IIO_CHAN_INFO_SCALE),		\
+		BIT(IIO_CHAN_INFO_SAMP_FREQ) |		\
+		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO))
+
 #define AD7616_CHANNEL(num)	\
 	AD760X_CHANNEL(num, BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),\
 		0, BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO))
@@ -61,6 +67,7 @@ enum ad7606_supported_device_ids {
  * @os_req_reset	some devices require a reset to update oversampling
  * @init_delay_ms	required delay in miliseconds for initialization
  *			after a restart
+ * @has_backend		defines if a backend is available for the given chip
  */
 struct ad7606_chip_info {
 	enum ad7606_supported_device_ids id;
@@ -71,6 +78,7 @@ struct ad7606_chip_info {
 	unsigned int			oversampling_num;
 	bool				os_req_reset;
 	unsigned long			init_delay_ms;
+	bool				has_backend;
 };
 
 /**
@@ -116,6 +124,7 @@ struct ad7606_state {
 	unsigned int			num_scales;
 	const unsigned int		*oversampling_avail;
 	unsigned int			num_os_ratios;
+	struct iio_backend		*back;
 	int (*write_scale)(struct iio_dev *indio_dev, int ch, int val);
 	int (*write_os)(struct iio_dev *indio_dev, int val);
 
@@ -140,16 +149,21 @@ struct ad7606_state {
 
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
@@ -160,6 +174,7 @@ struct ad7606_bus_ops {
 				 unsigned int addr,
 				 unsigned long mask,
 				 unsigned int val);
+	int (*update_scan_mode)(struct iio_dev *indio_dev, const unsigned long *scan_mask);
 	u16 (*rd_wr_cmd)(int addr, char isWriteOp);
 };
 
@@ -264,6 +279,7 @@ static const struct ad7606_chip_info ad7606b_info = {
 	.num_channels = 9,
 	.oversampling_avail = ad7606_oversampling_avail,
 	.oversampling_num = ARRAY_SIZE(ad7606_oversampling_avail),
+	.has_backend = true,
 	.name = "ad7606B",
 	.id = ID_AD7606B,
 };
diff --git a/drivers/iio/adc/ad7606_par.c b/drivers/iio/adc/ad7606_par.c
index d83c0edc1e31..5c8a04556e25 100644
--- a/drivers/iio/adc/ad7606_par.c
+++ b/drivers/iio/adc/ad7606_par.c
@@ -3,6 +3,8 @@
  * AD7606 Parallel Interface ADC driver
  *
  * Copyright 2011 Analog Devices Inc.
+ * Copyright 2024 Analog Devices Inc.
+ * Copyright 2024 BayLibre SAS.
  */
 
 #include <linux/mod_devicetable.h>
@@ -11,10 +13,86 @@
 #include <linux/types.h>
 #include <linux/err.h>
 #include <linux/io.h>
+#include <linux/pwm.h>
+#include <linux/gpio.h>
+#include <linux/delay.h>
 
 #include <linux/iio/iio.h>
+#include <linux/iio/backend.h>
 #include "ad7606.h"
 
+#ifdef CONFIG_IIO_BACKEND
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
+		struct ad7606_state *st = iio_priv(indio_dev);
+		unsigned int ret, c;
+
+		st->back = devm_iio_backend_get(dev, NULL);
+		if (IS_ERR(st->back))
+			return PTR_ERR(st->back);
+
+		/* If the device is iio_backend powered the PWM is mandatory */
+		if (!st->cnvst_pwm)
+			return -EINVAL;
+
+		ret = devm_iio_backend_request_buffer(dev, st->back, indio_dev);
+		if (ret)
+			return ret;
+
+		ret = devm_iio_backend_enable(dev, st->back);
+		if (ret)
+			return ret;
+
+		struct iio_backend_data_fmt data = {
+			.sign_extend = true,
+			.enable = true,
+		};
+		for (c = 0; c < indio_dev->num_channels; c++) {
+			ret = iio_backend_data_format_set(st->back, c, &data);
+			if (ret)
+				return ret;
+		}
+
+		indio_dev->channels = ad7606b_bi_channels;
+		indio_dev->num_channels = 8;
+
+		return 0;
+}
+
+static const struct ad7606_bus_ops ad7606_bi_bops = {
+	.iio_backend_config = ad7606_bi_setup_iio_backend,
+	.update_scan_mode = ad7606_bi_update_scan_mode,
+};
+#endif
+
 static int ad7606_par16_read_block(struct device *dev,
 				   int count, void *buf)
 {
@@ -52,7 +130,20 @@ static int ad7606_par_probe(struct platform_device *pdev)
 	void __iomem *addr;
 	resource_size_t remap_size;
 	int irq;
-
+#ifdef CONFIG_IIO_BACKEND
+	struct iio_backend *back;
+
+	/*For now, only the AD7606B is backend compatible.*/
+	if (chip_info->has_backend) {
+		back = devm_iio_backend_get(&pdev->dev, NULL);
+		if (IS_ERR(back))
+			return PTR_ERR(back);
+
+		return ad7606_probe(&pdev->dev, 0, NULL,
+				    chip_info,
+				    &ad7606_bi_bops);
+	}
+#endif
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
 		return irq;
@@ -74,6 +165,7 @@ static const struct platform_device_id ad7606_driver_ids[] = {
 	{ .name	= "ad7606-4", .driver_data = (kernel_ulong_t)&ad7606_4_info, },
 	{ .name	= "ad7606-6", .driver_data = (kernel_ulong_t)&ad7606_6_info, },
 	{ .name	= "ad7606-8", .driver_data = (kernel_ulong_t)&ad7606_8_info, },
+	{ .name	= "ad7606b", .driver_data = (kernel_ulong_t)&ad7606b_info, },
 	{ }
 };
 MODULE_DEVICE_TABLE(platform, ad7606_driver_ids);
@@ -83,6 +175,7 @@ static const struct of_device_id ad7606_of_match[] = {
 	{ .compatible = "adi,ad7606-4", .data = &ad7606_4_info },
 	{ .compatible = "adi,ad7606-6", .data = &ad7606_6_info },
 	{ .compatible = "adi,ad7606-8", .data = &ad7606_8_info },
+	{ .compatible = "adi,ad7606b", .data = &ad7606b_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, ad7606_of_match);
@@ -102,3 +195,6 @@ MODULE_AUTHOR("Michael Hennerich <michael.hennerich@analog.com>");
 MODULE_DESCRIPTION("Analog Devices AD7606 ADC");
 MODULE_LICENSE("GPL v2");
 MODULE_IMPORT_NS(IIO_AD7606);
+#ifdef CONFIG_IIO_BACKEND
+MODULE_IMPORT_NS(IIO_BACKEND);
+#endif

-- 
2.34.1


