Return-Path: <linux-pwm+bounces-3476-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38ED7991196
	for <lists+linux-pwm@lfdr.de>; Fri,  4 Oct 2024 23:49:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30C131C21C73
	for <lists+linux-pwm@lfdr.de>; Fri,  4 Oct 2024 21:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03D331B4F12;
	Fri,  4 Oct 2024 21:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="WRCecLe6"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3BF14B967
	for <linux-pwm@vger.kernel.org>; Fri,  4 Oct 2024 21:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728078530; cv=none; b=k072E2KPovLHbw4KtjWAFR2tvBubDKmSvWVjZxpBCyiyDJv5J189gDf9HXd8CgJFU60e1VPMdvR6tpWhzf6VS8e0vgI4M2CcDCwqIv6+yc/Z3z0TtiODMpbhjn+RoKBkEDLLbNeT6Ks1KYVpVjuU1MmG5AsCQEtR7a7zuCwRYDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728078530; c=relaxed/simple;
	bh=baele4Nwv7MlPxYTi/fb1EW1xxMwhewdYdFuNsVeNAA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nC3QNKfC8OcQTs32qSehl91XAi6mrglCMBpHlr2tM4tI9AiOcMbtd9Wx0HKKf220K2cj4fz1gke53dUN698NXDjlOHLt4d237TRfbfKqVvIqnH+SKJZrIcQ5kAV9/3i2jzdU9MrREOPnnNoHdAMBQ4PCzMdaqEXfQUfV/nVbfCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=WRCecLe6; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-37cd0b5515fso1618140f8f.2
        for <linux-pwm@vger.kernel.org>; Fri, 04 Oct 2024 14:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728078527; x=1728683327; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0lZ3hRQxXjulLjy+7TWi5No6JHikVVEGfaXyEkMAv7U=;
        b=WRCecLe6GHkRhYD/+idd+EvK5wEem2aHJSF5x1AYZpX2/WTq63HZuNQmRpxRAB55VV
         +LeGoqzI1aQYpdUAtzXwMaJYPXIkDDPJtqw3jLyWMHUKZaWF8ojlDbzUYmIFiT1e0n8s
         s8fyuyYMCbg8FyStQqPeg4Gn7csmm+0iFp8lUQ4Lbzt+DskBHQ6Ool0dAnhEPMakvG8F
         LVvzzXvbCuD9D62bKH819SOulaHkewDJO2pL1YtwolyU8/laVQZpilPtUyjus5E/YB6r
         zgKe6j75Nhrx3MfQsSsWOZcMtQ8ShDvkcRn+CwEh5KwuBTG/jtW+vn4IatYbDuQGjBTv
         E0IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728078527; x=1728683327;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0lZ3hRQxXjulLjy+7TWi5No6JHikVVEGfaXyEkMAv7U=;
        b=q4LlY6Zygy8RsdfgR6laLmrm5kozcAfhcda5zc9ZXcEalWXvpt65kFBra7HasA9WrO
         raG5XW2PoWuvs4/o7udBLXOIgqsKejK42Sf9saS+46O4lCiZyVWGf7EZRKa3vdMF78TX
         nLSzRiq5P48SY3v8KYAuZm3JELCPOqPptuli0fb52cME+IPmtLDRLdtAMzUILDAHPyyT
         I+Y3PcM7nvWaVA262dwfCnsoEVx2PskyVHVR8p4GLSEsOP0BJovPJmivpVwSF8ELA2d3
         wKp5qhS+xGzDJt7slmItN7fn+2G4Q8uFiF/OSpcPUfQlVoSLLjjZ/0MkHYeSsDn6hjdo
         vFVg==
X-Gm-Message-State: AOJu0YwRmPlVAqUhjzS1wGsKORWK7C7Fhquu15/uExZdcOVkTlWsUUI8
	LfgL8nCP/noRkQyxr0ersqVbhGhzXBhfjWbU2RqzRVxWTFJXmDNrW5RrCYZ9aBo=
X-Google-Smtp-Source: AGHT+IELGyW7DdfB3eUCcfWXm/kjhvHs7NEWdyhLztJSHzSu/vdLp8yJMstLPjxTwbTRgw2c5zU1IA==
X-Received: by 2002:a5d:69ca:0:b0:37c:d02a:7e41 with SMTP id ffacd0b85a97d-37d0e738969mr2766006f8f.15.1728078527152;
        Fri, 04 Oct 2024 14:48:47 -0700 (PDT)
Received: from [127.0.1.1] (frhb82016ds.ikexpress.com. [185.246.87.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f86b4ab63sm24680375e9.40.2024.10.04.14.48.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 14:48:46 -0700 (PDT)
From: Guillaume Stols <gstols@baylibre.com>
Date: Fri, 04 Oct 2024 21:48:35 +0000
Subject: [PATCH v3 01/10] iio: adc: ad7606: Fix typo in the driver name
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241004-ad7606_add_iio_backend_support-v3-1-38757012ce82@baylibre.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728078523; l=848;
 i=gstols@baylibre.com; s=20240417; h=from:subject:message-id;
 bh=baele4Nwv7MlPxYTi/fb1EW1xxMwhewdYdFuNsVeNAA=;
 b=p4U6UtXueMN9Cj0qTH1RuJoNMSQR8LMBsgB/om9nerwUq1HUinLYayaLPzYTikXWMbGwjna8Q
 i20NpAvqKb8Cvr1bvRZNsOpA9FWeiFSQClrkQ3yFkwWweQag76uRoqm
X-Developer-Key: i=gstols@baylibre.com; a=ed25519;
 pk=XvMm5WHuV67sGYOJZqIYzXndbaJOlNd8Q6li6vnb4Cs=

The parallel driver's name is ad7606_par and not ad7606_parallel.

Fixes: 0046a46a8f93 ("staging/ad7606: Actually build the interface modules")
Signed-off-by: Guillaume Stols <gstols@baylibre.com>
---
 drivers/iio/adc/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 97ece1a4b7e3..4ab1a3092d88 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -229,7 +229,7 @@ config AD7606_IFACE_PARALLEL
 	  ad7605-4, ad7606, ad7606-6, ad7606-4 analog to digital converters (ADC).
 
 	  To compile this driver as a module, choose M here: the
-	  module will be called ad7606_parallel.
+	  module will be called ad7606_par.
 
 config AD7606_IFACE_SPI
 	tristate "Analog Devices AD7606 ADC driver with spi interface support"

-- 
2.34.1


