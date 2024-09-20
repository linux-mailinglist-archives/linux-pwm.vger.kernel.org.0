Return-Path: <linux-pwm+bounces-3316-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B66C497D942
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Sep 2024 19:35:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C63F5B2354A
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Sep 2024 17:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE184187553;
	Fri, 20 Sep 2024 17:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="BIOrXG+r"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3083B186606
	for <linux-pwm@vger.kernel.org>; Fri, 20 Sep 2024 17:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726853620; cv=none; b=kETItHbEL4j2oynm0k2cadq4ERlppJvLO19VE8AS/hmjSXrQunYZ89PyJYEWW/qfa7kux5j8CHsPy0kSFIOWKJ7JSUGjJSTgAGKKT4EtNavgEjThUumxCzg4KwmcLY/YPGhuiUYC5kPLzJoTJcrZoFtO+MzLzI+oNXrcDOFT7ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726853620; c=relaxed/simple;
	bh=jH5AF1NUj11MGOXs+0oMMIR7SvlyPmokhbLME9mMNMs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cxOKU909FjAWbgV0EPHJgVxFvPo0M0Ic2maK45uMQ84ea0PyhE2v8k6/rrARbx2DyoGD6TpdTVYzTKNJnpExAkazpd9vEBual1ZBWsfSarEZmMs04EyV+Yz8LYL+Qw256iLDuNmtc4G3rzMRDf78aF2pa/osJpL5Bg/QEiBvPd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=BIOrXG+r; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-374bb08d011so1238520f8f.3
        for <linux-pwm@vger.kernel.org>; Fri, 20 Sep 2024 10:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1726853616; x=1727458416; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nqbTxoEOJj+E0EusJXu3vOo7bySZpM0E+tGgQhd2Qeo=;
        b=BIOrXG+rj43PTDtF5s+7ZqEf+/6qZ3HmQoUZeQ0jFuq8PEtSzC8VI/ulrwfSYHDKUf
         14iFj3+RFhTNas1qHu03RpWNtGKRF9KX0aGtcDWAsfqFTezhWVriczctcCVIGCRces2J
         aGvDo5I+z/D8MBaKNeLgBB8g+2fQJbuqvOF99ary92LlyX0bKAYb/TcjJL2xUwJAh+Om
         PYNW5drVNKSSoF1riQqLDYbaByoWbVPX3hVYM5v+3HFOG8Ctcfh2p9qlhlL7CKP/Ifm0
         U6Ie8AvlJbn62W+q3AjlIswmyaPcaBTHNHf/g4HlJNHUxEsZMXk9TJ1ZBcAkb4M/dKSG
         Erhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726853616; x=1727458416;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nqbTxoEOJj+E0EusJXu3vOo7bySZpM0E+tGgQhd2Qeo=;
        b=CQ/NPfa7zg+Pv/4/uQOoarPi2xnTF2vfZ3AjTJfDeNs9MqtuDoY0QLUwuwAra8Pche
         WfJYhZA4aP5DqmXmJi4h35Zj9qVaqofes87EHlaBCZoO47jkdQsQ+ZdGFiNNO7WDbrcH
         OrqRSYsWd+X7vF0hW8gczsEd1C4tTjMzzJmL12f+qDIZqPyqYru8AIZuSqZ8F7wtgAtr
         bnIS/Vt0+CbK9zj0WvRwKprRYKkI3uYntXdj4mUE3Xy+mZsCpXI43yBZQZgPB74p2VAz
         if2j9BxD5tIHFhoAX/Ew3Ad8odEPoRwOGFYkpMMK8LAjDYHP5SvL2g+0+1N9Jnd3cIXf
         oPqQ==
X-Gm-Message-State: AOJu0YwG5+wTclskyR857IzkD8gt6Ak2Y3SxHlUtg2kMnv4ogpj+BKRz
	q4+KzmjDJ/EUi1tSH1vYdPb6tyxTrkNHv+x1yS5kVVtlEpZZ4su12SyommWb+FM=
X-Google-Smtp-Source: AGHT+IFiSJQD4Z15/Xdx8nq9M3r3mKqhBJoDnK88r8s3gsfWDbUgSbXnNSZwYOc4QDNcmGmgZR2b6g==
X-Received: by 2002:a05:6000:88e:b0:374:c17a:55b5 with SMTP id ffacd0b85a97d-37a4226bb7bmr1929359f8f.14.1726853616033;
        Fri, 20 Sep 2024 10:33:36 -0700 (PDT)
Received: from [127.0.1.1] (frhb82016ds.ikexpress.com. [185.246.87.17])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e780e029sm18111177f8f.116.2024.09.20.10.33.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 10:33:34 -0700 (PDT)
From: Guillaume Stols <gstols@baylibre.com>
Date: Fri, 20 Sep 2024 17:33:30 +0000
Subject: [PATCH v2 10/10] iio: adc: ad7606: Disable PWM usage for non
 backend version
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240920-ad7606_add_iio_backend_support-v2-10-0e78782ae7d0@baylibre.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1726853604; l=1655;
 i=gstols@baylibre.com; s=20240417; h=from:subject:message-id;
 bh=jH5AF1NUj11MGOXs+0oMMIR7SvlyPmokhbLME9mMNMs=;
 b=kSnZJIrPGfSq6YzbLJZ9p9mO7w2NOsG/iZXur554ypRAWkxnTvW2tYn3jiMYak1kdPyCLhejb
 hUajOoIJbZlAmnbA5Lm007KmnnbAvokXAsLS7hGMF50KRMfdAOuPIXg
X-Developer-Key: i=gstols@baylibre.com; a=ed25519;
 pk=XvMm5WHuV67sGYOJZqIYzXndbaJOlNd8Q6li6vnb4Cs=

Since the pwm was introduced before backend, there was an example use
whit triggered buffers. However, using it may be dangerous, because if
the PWM goes too fast, a new conversion can be triggered before the
transmission is over, whit the associated mess in the buffers.
Until a solution is found to mitigate this risk, for instante CRC
support, the PWM will be disabled.

Signed-off-by: Guillaume Stols <gstols@baylibre.com>
---
 drivers/iio/adc/ad7606.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
index f710445bdc22..0c12ca237ee9 100644
--- a/drivers/iio/adc/ad7606.c
+++ b/drivers/iio/adc/ad7606.c
@@ -599,7 +599,6 @@ static int ad7606_buffer_postenable(struct iio_dev *indio_dev)
 	struct ad7606_state *st = iio_priv(indio_dev);
 
 	gpiod_set_value(st->gpio_convst, 1);
-	ad7606_pwm_set_swing(st);
 
 	return 0;
 }
@@ -609,7 +608,6 @@ static int ad7606_buffer_predisable(struct iio_dev *indio_dev)
 	struct ad7606_state *st = iio_priv(indio_dev);
 
 	gpiod_set_value(st->gpio_convst, 0);
-	ad7606_pwm_set_low(st);
 
 	return 0;
 }
@@ -838,6 +836,12 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
 		indio_dev->setup_ops = &ad7606_pwm_buffer_ops;
 	} else {
 		init_completion(&st->completion);
+
+		/* Reserve the PWM use only for backend (force gpio_convst definition) */
+		if (!st->gpio_convst)
+			return dev_err_probe(dev, -EINVAL,
+					     "No backend, connect convst to a GPIO");
+
 		ret = devm_request_threaded_irq(dev, irq,
 						NULL,
 						&ad7606_interrupt,

-- 
2.34.1


