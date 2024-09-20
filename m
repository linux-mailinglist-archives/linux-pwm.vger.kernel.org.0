Return-Path: <linux-pwm+bounces-3315-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94FAC97D941
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Sep 2024 19:35:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8D861C21EEF
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Sep 2024 17:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD2FC187547;
	Fri, 20 Sep 2024 17:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="zXGyZFmH"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBBF718628F
	for <linux-pwm@vger.kernel.org>; Fri, 20 Sep 2024 17:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726853620; cv=none; b=b7TtBR2G/AGoY6WFzTzIlJTaG8V3S6Th+gdDCKaEKo/l4rywviGhGx6S3Rup3HZgeNahxqW+BdsZYXcVm1gD9XIeZm5DT+CqYvYI0yKZjFCHeJyGWz9i8Rf8vBmuy5pNPoddB4yYJaHY9UKB1+W0Q5F1ulaHCMMRYF/6jGU+a6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726853620; c=relaxed/simple;
	bh=oq1q/NzJfEdQoqtBhTXNe9ONaDj41XLOLIawsgCIdd8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZXGm6lAHEc5Zr3uCPNYK2n58oryOILTtxhprOGRYXR3mapxRMTRWKcJR0Q8JIk9C8Xjctm50LHIofufQlz9QM7pZM4LvDnrjOWqJSkIRVQrZ/LMN2lavSrx6F93HqkxGpLtghXlyCahapgSfruiy8ZZUs4J3erVou0ReX/h+FsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=zXGyZFmH; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42ca4e0299eso18662535e9.2
        for <linux-pwm@vger.kernel.org>; Fri, 20 Sep 2024 10:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1726853615; x=1727458415; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kLZnexWwOCOJyKY1ie+tZ2lwaSXrVIbed+TIq2zB4TM=;
        b=zXGyZFmH/WA4EWNYOF9RUK+vSuzrzWxUxXz64rcKsW5DTx6RqNkGCbOylxe1Tb4VzH
         AkZD/RpLhvjd2SKLyPNHe0C9TtyK0ENve2yoUlbK7SuMnrvNnKYQkhEQ07tHb1n9FN5C
         if5aTyo+b9Bez8TXkMhTCklB+T30h6ofvD4PxUxYN7mw5s8MuxIkDsu1EYkVL7R5zTPw
         cGv+Lsrtu0dC3v6C7yXJspuHTC7c0MnO2wift6RL2Jc7IRzD4qEzjFBG9N4pNxoIO4hl
         HfCVm1EtlC5Od9syi7wGPO4vohGansga/Xm4MWX+agPEN5Xgk3b3ZhXCDPUgeaVFRYEE
         LrFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726853615; x=1727458415;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kLZnexWwOCOJyKY1ie+tZ2lwaSXrVIbed+TIq2zB4TM=;
        b=riw3PW2R7gvIpy8yopkEnKbyiWUiDgM1ix3ToQLSJv2GqcyMnYol3fHZvEbzN5kEE1
         AXW5svCe14syK6DddkiXyWSQ2celfTXP2d+QF8mfffPyzvspFvv70027tvPnok+79Pek
         OM7/7hJwJbmqnjULRB+S9BJ+ctcMv40lZyNZVPT8DfQGCp910Q5TTyCsQTf94LGe3Fau
         ZU+Ydub1JCQZyAYDZo3EAXktWBciUC70Nu2XTSDFPnjhrOVOZKCUhBsd7x4CYVIrGrEG
         1OBXj2buMFr8sGKjgMhsynzbouUf/wLgoV7VOookQ6pzYo5UYEf249j/Pj0iBrIpDYGj
         OaqA==
X-Gm-Message-State: AOJu0YwmfAK76uUHjejUwrugtsmJk90LJpIPT9c/7+G8DK9UQLdKRjqC
	vg8U22sT9JrjV4zk9LHzRBEGEsR07Rt8Dx3MYufHD8faS1dYRnhMs8omg8RpppY=
X-Google-Smtp-Source: AGHT+IHRqwfSRwCNWamNToJaGpWUDBjEwXhaz+zI66pN8+3VxydOa3lG6s44mAyPEDyvsz00F8g0Kw==
X-Received: by 2002:adf:e58c:0:b0:374:c6a7:5bd2 with SMTP id ffacd0b85a97d-37a4313fef7mr1927548f8f.21.1726853614507;
        Fri, 20 Sep 2024 10:33:34 -0700 (PDT)
Received: from [127.0.1.1] (frhb82016ds.ikexpress.com. [185.246.87.17])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e780e029sm18111177f8f.116.2024.09.20.10.33.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 10:33:34 -0700 (PDT)
From: Guillaume Stols <gstols@baylibre.com>
Date: Fri, 20 Sep 2024 17:33:29 +0000
Subject: [PATCH v2 09/10] iio: adc: ad7606: Add iio-backend support
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240920-ad7606_add_iio_backend_support-v2-9-0e78782ae7d0@baylibre.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1726853604; l=14580;
 i=gstols@baylibre.com; s=20240417; h=from:subject:message-id;
 bh=oq1q/NzJfEdQoqtBhTXNe9ONaDj41XLOLIawsgCIdd8=;
 b=SGthrUVrmseDOaiOn9+/Q4L+Cz/5RKwNTT++JdFZ1uwHM+3zEcSAir2M+jpv5pCEmcYXQ2qc4
 sxx3ji7LU2yAmPJ0lxaxlR/An7GUnxrSmx4ZL0gnXoyueFJzXU/SCur
X-Developer-Key: i=gstols@baylibre.com; a=ed25519;
 pk=XvMm5WHuV67sGYOJZqIYzXndbaJOlNd8Q6li6vnb4Cs=

- Basic support for iio backend.
- Supports IIO_CHAN_INFO_SAMP_FREQ R/W.
- Only hardware mode is available, and that IIO_CHAN_INFO_RAW is not
  supported if iio-backend mode is selected.

Signed-off-by: Guillaume Stols <gstols@baylibre.com>
---
 drivers/iio/adc/Kconfig      |  2 +
 drivers/iio/adc/ad7606.c     | 94 +++++++++++++++++++++++++++++++++++++-------
 drivers/iio/adc/ad7606.h     | 15 +++++++
 drivers/iio/adc/ad7606_par.c | 91 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 187 insertions(+), 15 deletions(-)

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
index 7f2ff1674638..f710445bdc22 100644
--- a/drivers/iio/adc/ad7606.c
+++ b/drivers/iio/adc/ad7606.c
@@ -21,6 +21,7 @@
 #include <linux/util_macros.h>
 #include <linux/units.h>
 
+#include <linux/iio/backend.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/buffer.h>
 #include <linux/iio/sysfs.h>
@@ -271,7 +272,15 @@ static int ad7606_set_sampling_freq(struct ad7606_state *st, unsigned long freq)
 
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
 
 	return st->bops->read_block(st->dev, num, data);
@@ -319,11 +328,14 @@ static int ad7606_scan_direct(struct iio_dev *indio_dev, unsigned int ch)
 		if (!ret)
 			return ret;
 	}
-	ret = wait_for_completion_timeout(&st->completion,
-					  msecs_to_jiffies(1000));
-	if (!ret) {
-		ret = -ETIMEDOUT;
-		goto error_ret;
+
+	if (!st->back) {
+		ret = wait_for_completion_timeout(&st->completion,
+						  msecs_to_jiffies(1000));
+		if (!ret) {
+			ret = -ETIMEDOUT;
+			goto error_ret;
+		}
 	}
 
 	ret = ad7606_read_samples(st);
@@ -349,6 +361,7 @@ static int ad7606_read_raw(struct iio_dev *indio_dev,
 {
 	int ret, ch = 0;
 	struct ad7606_state *st = iio_priv(indio_dev);
+	struct pwm_state cnvst_pwm_state;
 
 	switch (m) {
 	case IIO_CHAN_INFO_RAW:
@@ -369,6 +382,10 @@ static int ad7606_read_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
 		*val = st->oversampling;
 		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		pwm_get_state(st->cnvst_pwm, &cnvst_pwm_state);
+		*val = DIV_ROUND_CLOSEST_ULL(NSEC_PER_SEC, cnvst_pwm_state.period);
+		return IIO_VAL_INT;
 	}
 	return -EINVAL;
 }
@@ -458,6 +475,8 @@ static int ad7606_write_raw(struct iio_dev *indio_dev,
 			return ret;
 
 		return 0;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		return ad7606_set_sampling_freq(st, val);
 	default:
 		return -EINVAL;
 	}
@@ -595,14 +614,49 @@ static int ad7606_buffer_predisable(struct iio_dev *indio_dev)
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
@@ -610,6 +664,7 @@ static const struct iio_info ad7606_info_os_and_range = {
 	.write_raw = &ad7606_write_raw,
 	.attrs = &ad7606_attribute_group_os_and_range,
 	.validate_trigger = &ad7606_validate_trigger,
+	.update_scan_mode = &ad7606_update_scan_mode,
 };
 
 static const struct iio_info ad7606_info_os_range_and_debug = {
@@ -618,6 +673,7 @@ static const struct iio_info ad7606_info_os_range_and_debug = {
 	.debugfs_reg_access = &ad7606_reg_access,
 	.attrs = &ad7606_attribute_group_os_and_range,
 	.validate_trigger = &ad7606_validate_trigger,
+	.update_scan_mode = &ad7606_update_scan_mode,
 };
 
 static const struct iio_info ad7606_info_os = {
@@ -625,6 +681,7 @@ static const struct iio_info ad7606_info_os = {
 	.write_raw = &ad7606_write_raw,
 	.attrs = &ad7606_attribute_group_os,
 	.validate_trigger = &ad7606_validate_trigger,
+	.update_scan_mode = &ad7606_update_scan_mode,
 };
 
 static const struct iio_info ad7606_info_range = {
@@ -632,6 +689,7 @@ static const struct iio_info ad7606_info_range = {
 	.write_raw = &ad7606_write_raw,
 	.attrs = &ad7606_attribute_group_range,
 	.validate_trigger = &ad7606_validate_trigger,
+	.update_scan_mode = &ad7606_update_scan_mode,
 };
 
 static const struct iio_trigger_ops ad7606_trigger_ops = {
@@ -700,8 +758,6 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
 	indio_dev->channels = st->chip_info->channels;
 	indio_dev->num_channels = st->chip_info->num_channels;
 
-	init_completion(&st->completion);
-
 	ret = ad7606_reset(st);
 	if (ret)
 		dev_warn(st->dev, "failed to RESET: no RESET GPIO specified\n");
@@ -774,14 +830,22 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
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
+		ret = st->bops->iio_backend_config(dev, indio_dev);
+		if (ret)
+			return ret;
+		indio_dev->setup_ops = &ad7606_pwm_buffer_ops;
+	} else {
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
index 18c87fe9a41a..53cd8eb4898e 100644
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
@@ -59,6 +65,7 @@ enum ad7606_supported_device_ids {
  * @os_req_reset	some devices require a reset to update oversampling
  * @init_delay_ms	required delay in miliseconds for initialization
  *			after a restart
+ * @has_backend		defines if a backend is available for the given chip
  */
 struct ad7606_chip_info {
 	enum ad7606_supported_device_ids id;
@@ -69,6 +76,7 @@ struct ad7606_chip_info {
 	unsigned int			oversampling_num;
 	bool				os_req_reset;
 	unsigned long			init_delay_ms;
+	bool				has_backend;
 };
 
 /**
@@ -115,6 +123,7 @@ struct ad7606_state {
 	unsigned int			num_scales;
 	const unsigned int		*oversampling_avail;
 	unsigned int			num_os_ratios;
+	struct iio_backend		*back;
 	int (*write_scale)(struct iio_dev *indio_dev, int ch, int val);
 	int (*write_os)(struct iio_dev *indio_dev, int val);
 
@@ -139,16 +148,21 @@ struct ad7606_state {
 
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
@@ -159,6 +173,7 @@ struct ad7606_bus_ops {
 				 unsigned int addr,
 				 unsigned long mask,
 				 unsigned int val);
+	int (*update_scan_mode)(struct iio_dev *indio_dev, const unsigned long *scan_mask);
 	u16 (*rd_wr_cmd)(int addr, char isWriteOp);
 };
 
diff --git a/drivers/iio/adc/ad7606_par.c b/drivers/iio/adc/ad7606_par.c
index 7bac39033955..564284ede997 100644
--- a/drivers/iio/adc/ad7606_par.c
+++ b/drivers/iio/adc/ad7606_par.c
@@ -3,6 +3,8 @@
  * AD7606 Parallel Interface ADC driver
  *
  * Copyright 2011 Analog Devices Inc.
+ * Copyright 2024 Analog Devices Inc.
+ * Copyright 2024 BayLibre SAS.
  */
 
 #include <linux/err.h>
@@ -15,8 +17,80 @@
 #include <linux/types.h>
 
 #include <linux/iio/iio.h>
+#include <linux/iio/backend.h>
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
+		return -EINVAL;
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
@@ -96,9 +170,23 @@ static int ad7606_par_probe(struct platform_device *pdev)
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
+			 * If a backend is available in the device tree, call the core
+			 * probe with backend bops, otherwise use the former bops.
+			 */
+			return ad7606_probe(&pdev->dev, 0, NULL,
+					    chip_info,
+					    &ad7606_bi_bops);
 	} else {
 		id = platform_get_device_id(pdev);
 		chip_info = (const struct ad7606_chip_info *)id->driver_data;
@@ -125,6 +213,7 @@ static const struct platform_device_id ad7606_driver_ids[] = {
 	{ .name	= "ad7606-4", .driver_data = (kernel_ulong_t)&ad7606_4_info, },
 	{ .name	= "ad7606-6", .driver_data = (kernel_ulong_t)&ad7606_6_info, },
 	{ .name	= "ad7606-8", .driver_data = (kernel_ulong_t)&ad7606_8_info, },
+	{ .name	= "ad7606b", .driver_data = (kernel_ulong_t)&ad7606b_info, },
 	{ }
 };
 MODULE_DEVICE_TABLE(platform, ad7606_driver_ids);
@@ -134,6 +223,7 @@ static const struct of_device_id ad7606_of_match[] = {
 	{ .compatible = "adi,ad7606-4", .data = &ad7606_4_info },
 	{ .compatible = "adi,ad7606-6", .data = &ad7606_6_info },
 	{ .compatible = "adi,ad7606-8", .data = &ad7606_8_info },
+	{ .compatible = "adi,ad7606b", .data = &ad7606b_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, ad7606_of_match);
@@ -153,3 +243,4 @@ MODULE_AUTHOR("Michael Hennerich <michael.hennerich@analog.com>");
 MODULE_DESCRIPTION("Analog Devices AD7606 ADC");
 MODULE_LICENSE("GPL v2");
 MODULE_IMPORT_NS(IIO_AD7606);
+MODULE_IMPORT_NS(IIO_BACKEND);

-- 
2.34.1


