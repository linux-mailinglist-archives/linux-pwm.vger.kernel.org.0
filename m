Return-Path: <linux-pwm+bounces-4090-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C97639CF5D1
	for <lists+linux-pwm@lfdr.de>; Fri, 15 Nov 2024 21:22:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EB501F22BDC
	for <lists+linux-pwm@lfdr.de>; Fri, 15 Nov 2024 20:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64CEB1F470B;
	Fri, 15 Nov 2024 20:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="hVHA84Dw"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51EB51EF95B
	for <linux-pwm@vger.kernel.org>; Fri, 15 Nov 2024 20:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731701946; cv=none; b=D74eTQTGKcN7WZlQur/lX09jHQgyObKlLV9yn8yB8f5UrB7zr3CiOcGYXjq7jk5K7nVQoFtkExVQP5rZ2yxhX/rQ5pNSp1HicOYwTItuyk1LNHIfGaTMmDvCpefWZiQkhIlybFT0eYs0qpwVzrFaBM9IIBFy3eg4JsNj0k61CPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731701946; c=relaxed/simple;
	bh=liN7b/KYzKtzeNSL+5oMImxJ6lcQk3gX9Kb2jv+h/ro=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lQBSc1uXKIFuYVlbfSOoA0L/4Sty+VTwlV5k2rsIImexN+iHkv1zlGkdOSZzBRqIYiihD3NuP8TkOAJWcXo4ts1WNeovvKrGkdMIEQX9UnBwkW3zIAwODiKVzVerEzH3EUCCvhcXCI96JiPpRVh58qxqX6LHynNJ1oYIT9w9w3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=hVHA84Dw; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-71a5ab612ceso862693a34.0
        for <linux-pwm@vger.kernel.org>; Fri, 15 Nov 2024 12:19:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1731701942; x=1732306742; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0V8K9STxeMmBsbxzTyK1zNzGuxIPVz8nmTjFT2BLRT4=;
        b=hVHA84DwKhpRjhy76VpaVoC8S++0uxCpadJArbTlAPX6/fh99tkkusWCsN/ZEYEZTp
         uO5Cb9HUcb02/nvSK/Ej4vIptodo1oUCBwdqEwIxDkmVHaEAnOI+Ccc+i8TyNkv7Vzdn
         YSXqyaQxtDb2up4x1syImbvUO1g6Jrigz2CmXS7kpSPrvIDmqXlXM+1e276cYqO2l3bM
         YlUlVyQ8UPkyjGEIprGgUBaOLA5VzCFHnm5mWn/izdOIE8dnf8FrBi47/hbqiEg3IODO
         PfIVWJrkwYbo0eOa6cWTJWDJeApf8L3lNSvCs1VFqxB0nsQbJsoPSixrnnIvCN0um5N1
         ZHCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731701942; x=1732306742;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0V8K9STxeMmBsbxzTyK1zNzGuxIPVz8nmTjFT2BLRT4=;
        b=q1jTI4ioT9PNjOB0622Y8BSjfb6zFR7fqCvLAIIwRQvoJzlMnY8GCPTrb7PLEA/9tC
         +u/MxbsI5cb5nM085katTkMOw+N0fVGeEUMwyW7NzO0TfFOeXT4tDvzIag21Pm2B839J
         M5iGm7sdFi7KTJf10dZk7qLPcu5rr8uCSEzL+Zd1wwpWHANx7AGxx58yfaWlkTDTXJB1
         nQttBm333wgI2Wsc/baH4kvrY1rO7NFoWbd/bZzMeWRKls2kzw3yz1Dqkfcgp+X3XLd8
         RUVV5dtoZh4nMnRG18wv9xWmqUPCaFSykdQ/xTvGP4nFzHSF7xM2Dha0ed4Kch8s0WDO
         MSCw==
X-Forwarded-Encrypted: i=1; AJvYcCV2QpG7AQu97Ud73ryR5QycQc1knbknV+7RAYTpJ4L0P5ndUGymwAOJas1v4lj4aJZ3+uQhh7hB1fA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJVjzQqZauZ0Zzw0h34h+OXT+AyYeVrvMqg0wQaVD1nWC6dYGE
	TpS81fdLRBo1PpegautuhNMXgmsUrCl/Nsdm8bu77wiMYekZgoiJCmE2rXviG4o=
X-Google-Smtp-Source: AGHT+IE09WFChQ+/hR2mVDvjYMehhUE2fePG8D9Jb1Cbzj66rlCOErUZI2AFvqUCBNYs2zx0h1rLDQ==
X-Received: by 2002:a05:6830:6c0f:b0:71a:7603:d2d2 with SMTP id 46e09a7af769-71a7797c309mr4591306a34.18.1731701942374;
        Fri, 15 Nov 2024 12:19:02 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71a780ea62esm748978a34.5.2024.11.15.12.19.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 12:19:01 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 15 Nov 2024 14:18:48 -0600
Subject: [PATCH v5 09/16] iio: buffer-dmaengine: document
 iio_dmaengine_buffer_setup_ext
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241115-dlech-mainline-spi-engine-offload-2-v5-9-bea815bd5ea5@baylibre.com>
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

The iio_dmaengine_buffer_setup_ext() function is public and should be
documented. Also, while touching this, fix the description of @dev in
related functions. @dev does not strictly have to be the parent of the
IIO device. It is only passed to dma_request_chan() so strictly
speaking, it can be any device that is a valid DMA channel consumer.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---

v5 changes: none

v4 changes:
* This patch is new in v4.

Jonathan, I think this patch stands on its own if you want to take it
earlier than the rest of this series.
---
 drivers/iio/buffer/industrialio-buffer-dmaengine.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/buffer/industrialio-buffer-dmaengine.c b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
index 19af1caf14cd..054af21dfa65 100644
--- a/drivers/iio/buffer/industrialio-buffer-dmaengine.c
+++ b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
@@ -206,7 +206,7 @@ static const struct iio_dev_attr *iio_dmaengine_buffer_attrs[] = {
 
 /**
  * iio_dmaengine_buffer_alloc() - Allocate new buffer which uses DMAengine
- * @dev: Parent device for the buffer
+ * @dev: DMA channel consumer device
  * @channel: DMA channel name, typically "rx".
  *
  * This allocates a new IIO buffer which internally uses the DMAengine framework
@@ -288,6 +288,21 @@ void iio_dmaengine_buffer_free(struct iio_buffer *buffer)
 }
 EXPORT_SYMBOL_NS_GPL(iio_dmaengine_buffer_free, IIO_DMAENGINE_BUFFER);
 
+/**
+ * iio_dmaengine_buffer_setup_ext() - Setup a DMA buffer for an IIO device
+ * @dev: DMA channel consumer device
+ * @indio_dev: IIO device to which to attach this buffer.
+ * @channel: DMA channel name, typically "rx".
+ * @dir: Direction of buffer (in or out)
+ *
+ * This allocates a new IIO buffer with devm_iio_dmaengine_buffer_alloc()
+ * and attaches it to an IIO device with iio_device_attach_buffer().
+ * It also appends the INDIO_BUFFER_HARDWARE mode to the supported modes of the
+ * IIO device.
+ *
+ * Once done using the buffer iio_dmaengine_buffer_free() should be used to
+ * release it.
+ */
 struct iio_buffer *iio_dmaengine_buffer_setup_ext(struct device *dev,
 						  struct iio_dev *indio_dev,
 						  const char *channel,
@@ -321,7 +336,7 @@ static void __devm_iio_dmaengine_buffer_free(void *buffer)
 
 /**
  * devm_iio_dmaengine_buffer_setup_ext() - Setup a DMA buffer for an IIO device
- * @dev: Parent device for the buffer
+ * @dev: Device for devm ownership and DMA channel consumer device
  * @indio_dev: IIO device to which to attach this buffer.
  * @channel: DMA channel name, typically "rx".
  * @dir: Direction of buffer (in or out)

-- 
2.43.0


