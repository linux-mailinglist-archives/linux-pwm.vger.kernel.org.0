Return-Path: <linux-pwm+bounces-3560-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D078699651A
	for <lists+linux-pwm@lfdr.de>; Wed,  9 Oct 2024 11:22:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10D77B25013
	for <lists+linux-pwm@lfdr.de>; Wed,  9 Oct 2024 09:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BAA1191F84;
	Wed,  9 Oct 2024 09:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="PxCxKnGs"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723AA191478
	for <linux-pwm@vger.kernel.org>; Wed,  9 Oct 2024 09:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728465595; cv=none; b=a0nE89wjWkJkgwpgVXMVmTTuBSSCqevKwojc2An17cvUwZLIe2xheRY0MWsLqt/fVGqfrJqbDG3+LBxLPuUNB2sfBSlSF9FvTkrLMANrbXokrBcaF6XvLb1N42WZi85i+m6wKLCA2PpwiJQSjlQzdpTgJWlNi8i8iX1uWUg5g+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728465595; c=relaxed/simple;
	bh=uuGWxYey7yHQCI4vU9zbNCU9qHQf1LbNNRlr2LUqzxo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kJDqg06s9Z+8BSlpA7JV+FqsqueLjKxCfAJsBD8GqNWm98jUNM/Ql6kHwxCrAdj/E1dWINYIiaBuOnUd6LtVMn5XP4Gz1XPwoex+Iqbn4xxMwurb2TzbF+T9Bmno5zLMqsoEW8JNeOZdwXTAVryulNk3yKyOlPU6CgCVl6jMCUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=PxCxKnGs; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42cacabd2e0so62290265e9.3
        for <linux-pwm@vger.kernel.org>; Wed, 09 Oct 2024 02:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728465590; x=1729070390; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ioyVQRlmSykkPScNPBSOZR4crBNY+9Ixx2TFHYTli/k=;
        b=PxCxKnGsGsyNr767qsbwxOovJN1orJUeIv4FY/kmUGQXkWMfLWR0m/kNddTsB+WFta
         SJHMTrKqOXmEELYSk/tFneYw2tZwHLXVensxxJENrgI1O4Lory99DYm+icV27ofZTuzw
         XosrPezouJrBdKJig2YWO7UIEp84qn5Y1Rc9hufNTImfFqZb0L6UUzOOy5CKXd5WGtY8
         3S0lNh36FjFieTfg+u3q1jAMRAt50Y5R9P4fWuS419sXHnNqR30uBjGAFyT1j21fOS04
         DuKzbwEZeickLw66HVHI8N3c5OfC56YqhPHKxS1nK8PIUqR2CvX6wxhCkZCfvjLs0Zud
         L2RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728465590; x=1729070390;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ioyVQRlmSykkPScNPBSOZR4crBNY+9Ixx2TFHYTli/k=;
        b=jHzgQfx+I7ol9Mv7CI9PZ/T0tjWt1NKNPv7bDZKywDa2rg6kYrPqf135fOZUjaplRf
         FgBUHluj+qNtE2FQY34e8ynM5BgdgICsOAojTFaSKtW9r4qoPWdPkKz934fCN+n29tEa
         9IhAlQPj83AbJN5zH44Z7hgKNpHHvEHjhUDQFgfNdpcq3Bgw6G6LSvQNZjJiW8s5+vZP
         11EBKswZmvJWxCZsFU3cLqLE670VcWkp5lAX9hx37Exs2+9vAdo+EZTOrjbALPm1d+BL
         KxLqXgZCId0b1Q69y0aoDJssmpa/TBFSrOTb0lqrxSsEJeUazSoCe4xDVPXBFSrs5VES
         vdUQ==
X-Gm-Message-State: AOJu0Yzt4RM74a57WfxBi18axwE4e5snNtgnLsW6Zo20tMdsHM6WG2a0
	qZAoWeC5jjvNQIH+zIUPD0N6g7GF6Saa3JH/kzqCpEy42MCWPf2manVlXrboMOE=
X-Google-Smtp-Source: AGHT+IFzDIk1E+M5DMdcof+CZ5T2iitzbZ1ELPmRkmV0B9ZeNrzjpuKdiAku59JhRvy8QaHla4A/Dw==
X-Received: by 2002:a05:600c:45d1:b0:42c:bfd6:9d4d with SMTP id 5b1f17b1804b1-430ccef5ff5mr13596205e9.2.1728465589561;
        Wed, 09 Oct 2024 02:19:49 -0700 (PDT)
Received: from [127.0.1.1] (frhb82016ds.ikexpress.com. [185.246.87.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-430d59b1207sm13892765e9.31.2024.10.09.02.19.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 02:19:49 -0700 (PDT)
From: Guillaume Stols <gstols@baylibre.com>
Date: Wed, 09 Oct 2024 09:19:39 +0000
Subject: [PATCH v4 8/8] iio: adc: ad7606: Disable PWM usage for non backend
 version
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241009-ad7606_add_iio_backend_support-v4-8-6971a8c0f1d5@baylibre.com>
References: <20241009-ad7606_add_iio_backend_support-v4-0-6971a8c0f1d5@baylibre.com>
In-Reply-To: <20241009-ad7606_add_iio_backend_support-v4-0-6971a8c0f1d5@baylibre.com>
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
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Guillaume Stols <gstols@baylibre.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728465581; l=2292;
 i=gstols@baylibre.com; s=20240417; h=from:subject:message-id;
 bh=uuGWxYey7yHQCI4vU9zbNCU9qHQf1LbNNRlr2LUqzxo=;
 b=XVLRBxAuTkn7joKpnvjCLRf6ITZ/+5ljsYb4AA/VxTsiKxFajOG4ywCjBEqxuqc7N5Gj84iTV
 CILkNPzUc7wC3qLzFwcRQMmXbUilFKxPRUp+MLmez4at9Rdbv+KX5sW
X-Developer-Key: i=gstols@baylibre.com; a=ed25519;
 pk=XvMm5WHuV67sGYOJZqIYzXndbaJOlNd8Q6li6vnb4Cs=

Since the pwm was introduced before backend, there was a mock use, with
a GPIO emulation. Now that iio backend is introduced, the mock use can
be removed.

Signed-off-by: Guillaume Stols <gstols@baylibre.com>
---
 drivers/iio/adc/ad7606.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
index 1313b5cbb0aa..a117206e5256 100644
--- a/drivers/iio/adc/ad7606.c
+++ b/drivers/iio/adc/ad7606.c
@@ -473,8 +473,6 @@ static int ad7606_pwm_set_high(struct ad7606_state *st)
 	cnvst_pwm_state.duty_cycle = cnvst_pwm_state.period;
 
 	ret = pwm_apply_might_sleep(st->cnvst_pwm, &cnvst_pwm_state);
-	/* sleep 2 µS to let finish the current pulse */
-	fsleep(2);
 
 	return ret;
 }
@@ -492,8 +490,6 @@ static int ad7606_pwm_set_low(struct ad7606_state *st)
 	cnvst_pwm_state.duty_cycle = 0;
 
 	ret = pwm_apply_might_sleep(st->cnvst_pwm, &cnvst_pwm_state);
-	/* sleep 2 µS to let finish the current pulse */
-	fsleep(2);
 
 	return ret;
 }
@@ -576,7 +572,6 @@ static irqreturn_t ad7606_trigger_handler(int irq, void *p)
 	iio_trigger_notify_done(indio_dev->trig);
 	/* The rising edge of the CONVST signal starts a new conversion. */
 	gpiod_set_value(st->gpio_convst, 1);
-	ad7606_pwm_set_high(st);
 
 	return IRQ_HANDLED;
 }
@@ -899,7 +894,6 @@ static int ad7606_buffer_postenable(struct iio_dev *indio_dev)
 	struct ad7606_state *st = iio_priv(indio_dev);
 
 	gpiod_set_value(st->gpio_convst, 1);
-	ad7606_pwm_set_high(st);
 
 	return 0;
 }
@@ -909,7 +903,6 @@ static int ad7606_buffer_predisable(struct iio_dev *indio_dev)
 	struct ad7606_state *st = iio_priv(indio_dev);
 
 	gpiod_set_value(st->gpio_convst, 0);
-	ad7606_pwm_set_low(st);
 
 	return 0;
 }
@@ -1204,6 +1197,12 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
 
 		indio_dev->setup_ops = &ad7606_pwm_buffer_ops;
 	} else {
+
+		/* Reserve the PWM use only for backend (force gpio_convst definition) */
+		if (!st->gpio_convst)
+			return dev_err_probe(dev, -EINVAL,
+					     "No backend, connect convst to a GPIO");
+
 		init_completion(&st->completion);
 		st->trig = devm_iio_trigger_alloc(dev, "%s-dev%d",
 						  indio_dev->name,

-- 
2.34.1


