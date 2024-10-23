Return-Path: <linux-pwm+bounces-3787-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D9E9AD61F
	for <lists+linux-pwm@lfdr.de>; Wed, 23 Oct 2024 23:02:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D76321C21A22
	for <lists+linux-pwm@lfdr.de>; Wed, 23 Oct 2024 21:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C7520110D;
	Wed, 23 Oct 2024 20:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="J3+2LKLA"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1744200C9F
	for <linux-pwm@vger.kernel.org>; Wed, 23 Oct 2024 20:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729717190; cv=none; b=goDj8lyXxYmcLdeQCAdMr5ERcWoxGdl7oyFzNuDAWBY8uh7R1YHCxpNF172Rvij5aG9EKXugCbAUZ7KTX92mMbHfLWP5ZyxQ/zd2L0E+GnJv5/Hcd0uCxRz7WJSlT/E22jhj6b9aVv1N3QtMN0YN/8hEhOm+JziU/gvdEQhyuWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729717190; c=relaxed/simple;
	bh=phtGbJKO/KlBEvCVg99uCLCLcEMBa9++5HvqvueHsOE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RgFoJSFvICocN8UpOiBaMUxXeA1fNYdcGJAH/8EsmpzqtOxncIahPSE2HOJmYhjUx0jU31n5LvvDE7ChM5srxJuN7/ofvxjwX68701uZGTUr+Y9E2+2O03EATu3AtByFASbXjBgABombn7+PYorJ7pCX293S2JaltDzlLD9Xyrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=J3+2LKLA; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5e5b5715607so131391eaf.1
        for <linux-pwm@vger.kernel.org>; Wed, 23 Oct 2024 13:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729717188; x=1730321988; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2otSV1rHjKqUFOfq5ASaT/zo6s+UQZpxLSJYnG+uWx4=;
        b=J3+2LKLA9/pmQK6Aj0HUtQ4bzYE2skcNCOQJcucvIh5db7Mj9epuqquRo7OC3GRUvB
         TC8LVUyBlsXSLQJahMq/CtNSxzGS7w60ZDnYD1QOjP6pcFW/DCZwyxBHOpz0b5rtvpDR
         GULmVN/9T+gLP3TLSjjE6tyfrHgK1t2ExTwa3wcif3NJdrEJ1U/MeqEE3y04gjqPD7t+
         ka4g0tK/ebr6bCAbveHEAQNZBs1xclJlWkySoP7F9HqfxfwP8sbHu9n453WwfdzFvp0H
         6Omeh4AINor6ivyiBue7DVHnZ7eMHyjRlqeWRmTz/YAj8vJnPskmHvXe7Dg1pywPZ5Wp
         VHKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729717188; x=1730321988;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2otSV1rHjKqUFOfq5ASaT/zo6s+UQZpxLSJYnG+uWx4=;
        b=YgChsQij1Bgm/zLVXZNBLexYhjQT7vJjI/bxSOQurQMb0blyrrzrzuddqt60Mn+UWP
         eUWmLKcCfWm2TW/Tsx16yQARZ4my33llbFjUS6eqpUJqs2OSUl0hjl2MSaNbn0W0o2CB
         CjTOQqnZcap9g9e6phOkJO5vMteeJX9QS5xKHUrRhk1i/GrS4/iXLnOdyWkRXCQtGGTJ
         faAddkc8ygLcdMuFkRoG3h3gIPyIQVKYKXri4rGrx4Isv6fNcnqvdbKoC+nbH5+9OJ2z
         jcuPjVn9K7420wFQ/Bnsb2tbKkmIEffti5K+xnp80mdSzoUl89uyf/1lwdJQsYpV6pIM
         Tldw==
X-Forwarded-Encrypted: i=1; AJvYcCW86Xiu1rfJLbzno/ypTT42qdwkhU2RTTt6+/1q4dLagjR3BeTM6NmrFVf2XExC7ZaMjLNkNPP4+Xw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/vKRVjw7L1kMuig0qvwF9AvYyMjUo7KZvV9f69qQYaG5je4jT
	5d2qL+nMv1Sxi2etwbXNoc93CBdOkYu3GqeivtHEsntuUjG0kLgbg6s4rrLUUYo=
X-Google-Smtp-Source: AGHT+IGn/a4EyLP7/cnnLnEcDl15fgyVWsXOwJaSEtbGGCNRiWWTMbO61peIYd2WVZIRKRwFTzW5RQ==
X-Received: by 2002:a05:6820:2293:b0:5d6:ab0:b9a6 with SMTP id 006d021491bc7-5ebee27a8a1mr2399382eaf.4.1729717188136;
        Wed, 23 Oct 2024 13:59:48 -0700 (PDT)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5ec02c2c157sm52730eaf.44.2024.10.23.13.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 13:59:46 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 23 Oct 2024 15:59:18 -0500
Subject: [PATCH RFC v4 11/15] iio: buffer-dmaengine: add
 devm_iio_dmaengine_buffer_setup_ext2()
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241023-dlech-mainline-spi-engine-offload-2-v4-11-f8125b99f5a1@baylibre.com>
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

Add a new devm_iio_dmaengine_buffer_setup_ext2() function to handle
cases where the DMA channel is managed by the caller rather than being
requested and released by the iio_dmaengine module.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---

v4 changes:
* This replaces "iio: buffer-dmaengine: generalize requesting DMA channel"
---
 drivers/iio/buffer/industrialio-buffer-dmaengine.c | 107 +++++++++++++++------
 include/linux/iio/buffer-dmaengine.h               |   5 +
 2 files changed, 81 insertions(+), 31 deletions(-)

diff --git a/drivers/iio/buffer/industrialio-buffer-dmaengine.c b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
index 054af21dfa65..602cb2e147a6 100644
--- a/drivers/iio/buffer/industrialio-buffer-dmaengine.c
+++ b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
@@ -33,6 +33,7 @@ struct dmaengine_buffer {
 	struct iio_dma_buffer_queue queue;
 
 	struct dma_chan *chan;
+	bool owns_chan;
 	struct list_head active;
 
 	size_t align;
@@ -216,28 +217,23 @@ static const struct iio_dev_attr *iio_dmaengine_buffer_attrs[] = {
  * Once done using the buffer iio_dmaengine_buffer_free() should be used to
  * release it.
  */
-static struct iio_buffer *iio_dmaengine_buffer_alloc(struct device *dev,
-	const char *channel)
+static struct iio_buffer *iio_dmaengine_buffer_alloc(struct dma_chan *chan,
+						     bool owns_chan)
 {
 	struct dmaengine_buffer *dmaengine_buffer;
 	unsigned int width, src_width, dest_width;
 	struct dma_slave_caps caps;
-	struct dma_chan *chan;
 	int ret;
 
 	dmaengine_buffer = kzalloc(sizeof(*dmaengine_buffer), GFP_KERNEL);
-	if (!dmaengine_buffer)
-		return ERR_PTR(-ENOMEM);
-
-	chan = dma_request_chan(dev, channel);
-	if (IS_ERR(chan)) {
-		ret = PTR_ERR(chan);
-		goto err_free;
+	if (!dmaengine_buffer) {
+		ret = -ENOMEM;
+		goto err_release;
 	}
 
 	ret = dma_get_slave_caps(chan, &caps);
 	if (ret < 0)
-		goto err_release;
+		goto err_free;
 
 	/* Needs to be aligned to the maximum of the minimums */
 	if (caps.src_addr_widths)
@@ -252,6 +248,7 @@ static struct iio_buffer *iio_dmaengine_buffer_alloc(struct device *dev,
 
 	INIT_LIST_HEAD(&dmaengine_buffer->active);
 	dmaengine_buffer->chan = chan;
+	dmaengine_buffer->owns_chan = owns_chan;
 	dmaengine_buffer->align = width;
 	dmaengine_buffer->max_size = dma_get_max_seg_size(chan->device->dev);
 
@@ -263,10 +260,12 @@ static struct iio_buffer *iio_dmaengine_buffer_alloc(struct device *dev,
 
 	return &dmaengine_buffer->queue.buffer;
 
-err_release:
-	dma_release_channel(chan);
 err_free:
 	kfree(dmaengine_buffer);
+err_release:
+	if (owns_chan)
+		dma_release_channel(chan);
+
 	return ERR_PTR(ret);
 }
 
@@ -282,12 +281,38 @@ void iio_dmaengine_buffer_free(struct iio_buffer *buffer)
 		iio_buffer_to_dmaengine_buffer(buffer);
 
 	iio_dma_buffer_exit(&dmaengine_buffer->queue);
-	dma_release_channel(dmaengine_buffer->chan);
-
 	iio_buffer_put(buffer);
+
+	if (dmaengine_buffer->owns_chan)
+		dma_release_channel(dmaengine_buffer->chan);
 }
 EXPORT_SYMBOL_NS_GPL(iio_dmaengine_buffer_free, IIO_DMAENGINE_BUFFER);
 
+static struct iio_buffer
+*__iio_dmaengine_buffer_setup_ext(struct iio_dev *indio_dev,
+				  struct dma_chan *chan, bool owns_chan,
+				  enum iio_buffer_direction dir)
+{
+	struct iio_buffer *buffer;
+	int ret;
+
+	buffer = iio_dmaengine_buffer_alloc(chan, owns_chan);
+	if (IS_ERR(buffer))
+		return ERR_CAST(buffer);
+
+	indio_dev->modes |= INDIO_BUFFER_HARDWARE;
+
+	buffer->direction = dir;
+
+	ret = iio_device_attach_buffer(indio_dev, buffer);
+	if (ret) {
+		iio_dmaengine_buffer_free(buffer);
+		return ERR_PTR(ret);
+	}
+
+	return buffer;
+}
+
 /**
  * iio_dmaengine_buffer_setup_ext() - Setup a DMA buffer for an IIO device
  * @dev: DMA channel consumer device
@@ -308,24 +333,13 @@ struct iio_buffer *iio_dmaengine_buffer_setup_ext(struct device *dev,
 						  const char *channel,
 						  enum iio_buffer_direction dir)
 {
-	struct iio_buffer *buffer;
-	int ret;
-
-	buffer = iio_dmaengine_buffer_alloc(dev, channel);
-	if (IS_ERR(buffer))
-		return ERR_CAST(buffer);
-
-	indio_dev->modes |= INDIO_BUFFER_HARDWARE;
-
-	buffer->direction = dir;
+	struct dma_chan *chan;
 
-	ret = iio_device_attach_buffer(indio_dev, buffer);
-	if (ret) {
-		iio_dmaengine_buffer_free(buffer);
-		return ERR_PTR(ret);
-	}
+	chan = dma_request_chan(dev, channel);
+	if (IS_ERR(chan))
+		return ERR_CAST(chan);
 
-	return buffer;
+	return __iio_dmaengine_buffer_setup_ext(indio_dev, chan, true, dir);
 }
 EXPORT_SYMBOL_NS_GPL(iio_dmaengine_buffer_setup_ext, IIO_DMAENGINE_BUFFER);
 
@@ -362,6 +376,37 @@ int devm_iio_dmaengine_buffer_setup_ext(struct device *dev,
 }
 EXPORT_SYMBOL_NS_GPL(devm_iio_dmaengine_buffer_setup_ext, IIO_DMAENGINE_BUFFER);
 
+/**
+ * devm_iio_dmaengine_buffer_setup_ext2() - Setup a DMA buffer for an IIO device
+ * @dev: Device for devm ownership
+ * @indio_dev: IIO device to which to attach this buffer.
+ * @chan: DMA channel
+ * @dir: Direction of buffer (in or out)
+ *
+ * This allocates a new IIO buffer with devm_iio_dmaengine_buffer_alloc()
+ * and attaches it to an IIO device with iio_device_attach_buffer().
+ * It also appends the INDIO_BUFFER_HARDWARE mode to the supported modes of the
+ * IIO device.
+ *
+ * This is the same as devm_iio_dmaengine_buffer_setup_ext() except that the
+ * caller manages requesting and releasing the DMA channel.
+ */
+int devm_iio_dmaengine_buffer_setup_ext2(struct device *dev,
+					 struct iio_dev *indio_dev,
+					 struct dma_chan *chan,
+					 enum iio_buffer_direction dir)
+{
+	struct iio_buffer *buffer;
+
+	buffer = __iio_dmaengine_buffer_setup_ext(indio_dev, chan, false, dir);
+	if (IS_ERR(buffer))
+		return PTR_ERR(buffer);
+
+	return devm_add_action_or_reset(dev, __devm_iio_dmaengine_buffer_free,
+					buffer);
+}
+EXPORT_SYMBOL_NS_GPL(devm_iio_dmaengine_buffer_setup_ext2, IIO_DMAENGINE_BUFFER);
+
 MODULE_AUTHOR("Lars-Peter Clausen <lars@metafoo.de>");
 MODULE_DESCRIPTION("DMA buffer for the IIO framework");
 MODULE_LICENSE("GPL");
diff --git a/include/linux/iio/buffer-dmaengine.h b/include/linux/iio/buffer-dmaengine.h
index 81d9a19aeb91..7bdb979b59f2 100644
--- a/include/linux/iio/buffer-dmaengine.h
+++ b/include/linux/iio/buffer-dmaengine.h
@@ -11,6 +11,7 @@
 
 struct iio_dev;
 struct device;
+struct dma_chan;
 
 void iio_dmaengine_buffer_free(struct iio_buffer *buffer);
 struct iio_buffer *iio_dmaengine_buffer_setup_ext(struct device *dev,
@@ -26,6 +27,10 @@ int devm_iio_dmaengine_buffer_setup_ext(struct device *dev,
 					struct iio_dev *indio_dev,
 					const char *channel,
 					enum iio_buffer_direction dir);
+int devm_iio_dmaengine_buffer_setup_ext2(struct device *dev,
+					 struct iio_dev *indio_dev,
+					 struct dma_chan *chan,
+					 enum iio_buffer_direction dir);
 
 #define devm_iio_dmaengine_buffer_setup(dev, indio_dev, channel)	\
 	devm_iio_dmaengine_buffer_setup_ext(dev, indio_dev, channel,	\

-- 
2.43.0


