Return-Path: <linux-pwm+bounces-4615-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA060A0C318
	for <lists+linux-pwm@lfdr.de>; Mon, 13 Jan 2025 22:02:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC4AC188913D
	for <lists+linux-pwm@lfdr.de>; Mon, 13 Jan 2025 21:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5B121FA8C3;
	Mon, 13 Jan 2025 21:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="FTab2Gif"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B551F942D
	for <linux-pwm@vger.kernel.org>; Mon, 13 Jan 2025 21:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736802071; cv=none; b=e7U/bRM/0iklzhSUhiU+PpN7R+XplGWfkjzKvjtKaAOglhAnQhM6M5GnE8jC5+jXESKh/0NcT80qVjal9cfEhgqSXPU+FWmT+J7wkaWc3/uCvVhgUV8mQY024H8LMPUaEmjqySAxsxd1UPuQaHmzUvw+lJ6Gf3lK8TynBH0vmlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736802071; c=relaxed/simple;
	bh=jRlTs2hPxFTMWzXud2pwyf/gDJQZpce7x7Xes5PCDq0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p5zf6pkf+1GizoX8kwAbVsZT9ZRcNWBQANF/xnhOm/2dcyF9teX2hv6ZucOAhLAtsZe70KtqTqHlm5BE9/IDjgteb5lmghcyT3UVQDWD9Wcpa+g77jMUv1xFZwM2eKvpC4VagLAEI6yvlpeLe9QUedtofoYxl+ovvp0yhzGb0r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=FTab2Gif; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-71e1d7130a5so2189330a34.0
        for <linux-pwm@vger.kernel.org>; Mon, 13 Jan 2025 13:01:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1736802067; x=1737406867; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m4qOy1E2SWXTRLQzjAjoUUpkXvVJq7HeawRi11wv1CQ=;
        b=FTab2GifrSjdz1W7bjvBYjUilGHiDoz4r6Q9cZxQUjZT6/S4jKM/5e64KBeK6s6BiR
         JGeJ2PmIrk/0HUD3u6T5LKtUvO5/uuSCWJwHmP9gIzfNN/oum6nl+C1wf2mVnS+JdP3s
         T9esDyBsdsPFpYjWYkW4W9NrubDlJbbyKHOgxhF8sLo7bu4IN/tgVl/jh+Ns0XE+VlAC
         R6uw0cWjFPvco6Q0TJPA8UX97BVESQ9tU3lRqyO7C92sEP7uuIv7H231xIbO9jXwKjT5
         1NH994K0aig/V0rXPYPTPJMgGTnUCbpsLUVAfBokesH7Vhf6yb8jd2tj2xZTw4H0rbU5
         IzZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736802067; x=1737406867;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m4qOy1E2SWXTRLQzjAjoUUpkXvVJq7HeawRi11wv1CQ=;
        b=ggtRP2ZxBdajv1bMsPEHDPOPYa81XngoMA+MXN+E0zckPTaMaCqsQRvMLuF4zkyDJQ
         MFHzCuOHNX176f5D5WsDbCUH+p/9GYya469s1cph18Y47VsxWfmHLoDWKy+e614n/L4J
         mDF62Kl27Pv8qD96mI6BVWl0z1KxfbxmSlCKB3LMCkwzcsDsNl63fXtl6xVnrbxkK6qK
         jOaMnBDPs4Rqp96YILaX7WS0X3Z8GjEXXYuTTRI4XuS8eu+Q7Ob/aHrDxLpcQWB5lfvb
         Fhau9VwMbi0/lKBFTfUtsahlGqwxJltFvKP/lUwRxR33Xj8VzccKp/yGcKXFLuRPcciv
         Zcfg==
X-Forwarded-Encrypted: i=1; AJvYcCWgLQfKjU5RXuErRvoTLqRSGA67v6xb4y3sGC8qdkp71mn7B10apfPb66oVbhsgtZ4ebF0/wM8Ob5g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIGU3cb8Qom+/zXFtvR0uYDlQL6C/6AjncXkfgXUWR5K6za9dz
	qHFxbMUIbSmd2SIf9J1tQ93GhALTqlnTCMKPwtt6bA4JKhNjkO4etD9WxfgWR8s=
X-Gm-Gg: ASbGncvSg7cr7GjjX/A0RInskLV37JOaCP91bYiD1asLUqbw9jzCb0CN/x5A57FByat
	6CJummB6bXPGlV0Tn5JplYKUOMNosfCaFhF1QWTS8OjsDb5YFHgbZyVrcWTAB/UMhdyxCIvOtxV
	MiArtIUHN8iIY2e3f0jGRR4G7ZmH/FX4DF3niniiioQR6HKpCe2Zn017AZX+PcFccEr27V4YrzU
	Kyvk1fwNVU63ZL1pVpRFAR0xPQhpxxsTo0HZ+qlLweJW4CfQgVnSCBWaen2Ql09k0/WiwlsUV5N
	J9qpvZLlWAxE
X-Google-Smtp-Source: AGHT+IEhD0Vp5JdEuew98KxE05jR40/4fw1aRh9ZIYPvM+djmKr8mac14kyQAxtYZsi3oBGb27A3Bw==
X-Received: by 2002:a05:6830:3495:b0:71d:5236:9295 with SMTP id 46e09a7af769-721e2eff802mr13309103a34.24.1736802066783;
        Mon, 13 Jan 2025 13:01:06 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7231855effasm3927744a34.33.2025.01.13.13.01.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 13:01:06 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 13 Jan 2025 15:00:17 -0600
Subject: [PATCH v7 12/17] doc: iio: ad7944: describe offload support
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250113-dlech-mainline-spi-engine-offload-2-v7-12-e0860c81caae@baylibre.com>
References: <20250113-dlech-mainline-spi-engine-offload-2-v7-0-e0860c81caae@baylibre.com>
In-Reply-To: <20250113-dlech-mainline-spi-engine-offload-2-v7-0-e0860c81caae@baylibre.com>
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
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2

Add a section to the ad7944 documentation describing how to use the
driver with SPI offloading.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---

v7 changes: none

v6 changes: none

v5 changes: new patch in v5
---
 Documentation/iio/ad7944.rst | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/Documentation/iio/ad7944.rst b/Documentation/iio/ad7944.rst
index 0d26e56aba8862a8d2ff541012bb4681d05c7bb5..e6dbe4d7f58cffd9f700f931ad2641d336526129 100644
--- a/Documentation/iio/ad7944.rst
+++ b/Documentation/iio/ad7944.rst
@@ -46,6 +46,8 @@ CS mode, 3-wire, without busy indicator
 To select this mode in the device tree, set the ``adi,spi-mode`` property to
 ``"single"`` and omit the ``cnv-gpios`` property.
 
+This is the only wiring configuration supported when using `SPI offload support`_.
+
 CS mode, 4-wire, without busy indicator
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
@@ -106,7 +108,6 @@ Unimplemented features
 ----------------------
 
 - ``BUSY`` indication
-- ``TURBO`` mode
 
 
 Device attributes
@@ -147,6 +148,27 @@ AD7986 is a fully-differential ADC and has the following attributes:
 In "chain" mode, additional chips will appear as additional voltage input
 channels, e.g. ``in_voltage2-voltage3_raw``.
 
+SPI offload support
+===================
+
+To be able to achieve the maximum sample rate, the driver can be used with the
+`AXI SPI Engine`_ to provide SPI offload support.
+
+.. _AXI SPI Engine: http://analogdevicesinc.github.io/hdl/projects/pulsar_adc/index.html
+
+When SPI offload is being used, some attributes will be different.
+
+* ``trigger`` directory is removed.
+* ``in_voltage0_sampling_frequency`` attribute is added for setting the sample
+  rate.
+* ``in_voltage0_sampling_frequency_available`` attribute is added for querying
+  the max sample rate.
+* ``timestamp`` channel is removed.
+* Buffer data format may be different compared to when offload is not used,
+  e.g. the ``in_voltage0_type`` attribute.
+
+If the ``turbo-gpios`` property is present in the device tree, the driver will
+turn on TURBO during buffered reads and turn it off otherwise.
 
 Device buffers
 ==============

-- 
2.43.0


