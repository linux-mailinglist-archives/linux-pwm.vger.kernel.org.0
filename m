Return-Path: <linux-pwm+bounces-3646-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AFAE99EE48
	for <lists+linux-pwm@lfdr.de>; Tue, 15 Oct 2024 15:56:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27298281578
	for <lists+linux-pwm@lfdr.de>; Tue, 15 Oct 2024 13:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52D971AF0BD;
	Tue, 15 Oct 2024 13:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Atfazspp"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D85170A3A
	for <linux-pwm@vger.kernel.org>; Tue, 15 Oct 2024 13:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729000598; cv=none; b=J8uwrWkXAyix0V7Ixu/lBiJpSmhSVJirNlX5ro1Lft92AFuWfc1Ayl/qUkLyrD4ahTaJiIXGNsgBtI49wv7HgsCRp4ZW/Egq2FdH7AVpGtcEpaFvhn0jAkXb/yBFKc2GYqtN94GMYLrtYs8mZmUzZFkOp91TD21RdGXm7cseg3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729000598; c=relaxed/simple;
	bh=mAvJUecqLZb8mQ7JA+zGw3XaC23jD7z91aCXiUApXpg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Mmu+qqQ2z1tXHsU4Aq4iZn6hjlMwD6TjUmsmjTRyy/ZnmEWn/0AHHgsIPxZFlkTbC2nggtRybsMI/EFDQOd4VFu9Vuy+Gn69ExYf1/euOn41GRRKZjArphAoZqHa4pfDWzWZr+wD0S8q/4AZsar+VLzqTJ7DyeXE8K6zS++V1x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Atfazspp; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-430f6bc9ca6so42851255e9.2
        for <linux-pwm@vger.kernel.org>; Tue, 15 Oct 2024 06:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729000593; x=1729605393; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AbMeYD74pGk8oJktHViz+H/uCI+iSWvCml2RdzFQNPc=;
        b=AtfazsppkQsom4ceXEJYPkPA8x1odwQI+tmwHZw9OBAIjkiiqE2yfcYELVfG68kzaa
         h8EIoZgKwz9W/EQkUXqRMA5C3l0cbS7ZD7eSczrZU795q2pu1/YeB6eoc6FAu6wweFqT
         6wVCU1XX5ZGdWVG2jLH16fDEIfkAEu5mCb06YVBmMaYMcfbur/2rygOGyB3ZxMwV+eeU
         vb24oT1hUt8WUgpL/fMlcm8K0ztZzkJFiRYd8+tk3HTaMheag1VcDZNQY+BscJ3uX0El
         0yJtm1N+aFx63Nd9C6evSWKm+b0KvzQ1Xml/O1ielgM3bY7OriM1xQTi//36k2xNPUv6
         L4TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729000593; x=1729605393;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AbMeYD74pGk8oJktHViz+H/uCI+iSWvCml2RdzFQNPc=;
        b=KeOQ6EKesdYI4x6RJIhxzf4ji7UkcI2vQ6saoyCG1TtNuwyng5/8Svi+yDlpX3t3GB
         JluM4TH7naTNrRQmhBvL2NqXtW+4tlE7NXFfih2kVFIhy1f1P1IyH3LWWEnq9c7qiSGz
         K2lmVCftwLKQlI9EffgTUD0QxiWbBEUNMxmCrkhEUXvEW9qJJfPajPxnhnHBdtdeTmed
         mP+XV2pmfWfH6Benc0wQYb3IIdNKVBPiLNPRPmTF4C3tS2jnejGZzLYBLHnkPPugR0/A
         s+ZNXwje/D+kNZMdDD2zn+eLdD8d4r8iK+WZyvyt9sRnQDqetqq+l7Gw4ZqXfGetQnoY
         F2YA==
X-Gm-Message-State: AOJu0YxN54Tb5NNKIOqUx5BBU8jFo9+PdFihIh185LQUj8skau1rDF0N
	mGm/HeXAb78qabbJj9xLEvPda3b+mkV8hwfv4rztmjoTPlUFFO35xxJIgLUebCE=
X-Google-Smtp-Source: AGHT+IFnMCPXiLFaoUymAEwxqVwbIQmmOBwrfONlvEq/fqSIvjjlH0Zwe7ri6z5v7v7UlXqJRK2Psw==
X-Received: by 2002:a05:600c:510f:b0:42c:bf70:a303 with SMTP id 5b1f17b1804b1-43125619eb7mr101725465e9.29.1729000592871;
        Tue, 15 Oct 2024 06:56:32 -0700 (PDT)
Received: from [127.0.1.1] (frhb82016ds.ikexpress.com. [185.246.87.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4313f56f241sm18848295e9.22.2024.10.15.06.56.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 06:56:32 -0700 (PDT)
From: Guillaume Stols <gstols@baylibre.com>
Subject: [PATCH v5 0/8] Add iio backend compatibility for ad7606
Date: Tue, 15 Oct 2024 13:56:13 +0000
Message-Id: <20241015-ad7606_add_iio_backend_support-v5-0-654faf1ae08c@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAH10DmcC/4XOTU7DMBCG4atEXhM0dsY/6Yp7IBSN7Qm1oElx0
 oiq6t0xqQQIVcrym8Uz70VMnBNPYlddROYlTWkcytAPlQh7Gl65TrFsoUAhWKVritaA6SjGLqW
 x8xTeeIjddDoexzzXAUE2oMm0CkVBjpn79Lk+eH657cwfp/Jnvh2Fp4nrMB4Oad5VaLRBpKBa3
 ZgoQVrndSA0DiN4h9Zo3/aE4tvap2ke83ltX+SKrZlObmYusoY6MDUspZdE+OTp/J585seSsuq
 L+hVbBZuiKiKwddYpYhvhjtj8iBIAN8WmiI2z2oJUgZ26I+Jfsd0UsYimtZJcgF5G/U+8Xq9fy
 TCILxECAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729000592; l=5611;
 i=gstols@baylibre.com; s=20240417; h=from:subject:message-id;
 bh=mAvJUecqLZb8mQ7JA+zGw3XaC23jD7z91aCXiUApXpg=;
 b=eA4Nr5B5pKK3BOlqDyvr9iNlZJuWxGBi6BvNGQV27CiYwLbHaMOK2PUFIvM7T0/ULrUhykVbL
 iYSaMY9Vq82DLnsAcvEJMAXmH7JFgTknN/hGvuMRm/PY6qGm1BVSHfZ
X-Developer-Key: i=gstols@baylibre.com; a=ed25519;
 pk=XvMm5WHuV67sGYOJZqIYzXndbaJOlNd8Q6li6vnb4Cs=

This series aims to add iio backend support for AD7606X ADCs.

In a nutshell, iio backend is a paradigm to shift the logic establishing
the connexion between iio buffers and backend buffers into the backend's
driver.  This provides a more stable programming interface to the driver
developers, and give more flexibility in the way the hardware communicates.

The support will be first added on AD7606B, and on next patches AD7606C16
and AD7606C18 will be added.  The series have been tested on a Zedboard,
using the latest HDL available, i.e
https://github.com/analogdevicesinc/hdl/commit/7d0a4cee1b5fa403f175af513d7eb804c3bd75d0
and an AD7606B FMCZ EKV.  This HDL handles both the conversion trigger
(through a PWM), and the end of conversion interruption, and is compatible
with axi-adc, which is "iio-backendable".

More information about this HDL design can be found at:
https://wiki.analog.com/resources/eval/user-guides/ad7606x-fmc/hdl

The support is thus separated in two parts:

- PWM support was first added.  My first intention was to make it available
  for any version of the driver, but the time required to handle the
  interruption is not neglectable, and I saw drifts that would eventually
  cause an overlapping SPI read with a new conversion trigger, whith
  catastrphic consequences. To mitigate this, CRC check must be
  implemented, but indeed increasing the samplerate causes more sample to
  be lost.  Therefore, I decided to only allow PWM for iio-backend
  powered device as a first intention, leaving open the possibility to
  add the general compatibility afterwards.

- IIO backend support was added: Once the PWM support was ready, the driver
  can be extended to iio-backend. The iio-backend powered version of the
  driver is a platform driver, and an exemple devicetree node is available
  in the bindings.

The following features will be added in subsequent patch series:
 - software mode for iio backend
 - 18 bits mode (AD7606C18)
 - single read (IIO_CHAN_READ_RAW)

Signed-off-by: Guillaume Stols <gstols@baylibre.com>
---
Changes in v5:
- Removal of an useless instruction move.
- Removal of extra checks on the PWM setters functions.
- Renaming of buffer postenable/predisable functions.
- Usage of device_property_present to check if there is a backend
  property instead of trying to load the backend.
- Improvement of error handling on PWM GPIO emulation, displaying an
  error in the kernel log in case the duty cycle set fails.
- Link to v4: https://lore.kernel.org/r/20241009-ad7606_add_iio_backend_support-v4-0-6971a8c0f1d5@baylibre.com

Changes in v4:
- Removal of accepted patches.
- Correction on fsleep (missing semicolon and incorrect spelling !).
- Correction on buffer initialization that should not be conditionned by
  the presence or not of a PWM, but by the presence of a backend.
- Addition of blank lines between blocks.
- Modification of some declaration to switch variables to static.
- Link to v3: https://lore.kernel.org/r/20241004-ad7606_add_iio_backend_support-v3-0-38757012ce82@baylibre.com

Changes in v3:
- Rebase on top of the series adding ad7606C16 and AD7606C18 support.
- Addition of pwm-names actual values and improvement in the
  description.
- Introduction of .num_adc_channels field in ad7606_chip_info that
  defines the number of hardware inputs.
- Introduction of ad7606_bus_info which couples hardware and wiring
  informations.
- Addition of a delay in the scan_direct function for the backend.
- Link to v2: https://lore.kernel.org/r/20240920-ad7606_add_iio_backend_support-v2-0-0e78782ae7d0@baylibre.com

Changes in v2:
- Logical change in dt-bindings, using a flag for the interface instead of
  infering it from the value of the "reg" property.
- Removal of get_platform_match_data addition, instead the logic is
  directly used in the file.
- Removal of use and export of pwm_get_state_hw, returning the configured
  frequency instead of the running one.
- Correction on various typos, whitespaces, bad order of includes.
- Separation of SPI conditions and PWM disabling for no backend in other
  commits.
- Link to v1: https://lore.kernel.org/r/20240815-ad7606_add_iio_backend_support-v1-0-cea3e11b1aa4@baylibre.com

---
Guillaume Stols (8):
      dt-bindings: iio: adc: ad7606: Remove spi-cpha from required
      dt-bindings: iio: adc: ad7606: Add iio backend bindings
      Documentation: iio: Document ad7606 driver
      iio: adc: ad7606: Add PWM support for conversion trigger
      iio: adc: ad7606: Add compatibility to fw_nodes
      iio: adc: ad7606: Introduce num_adc_channels
      iio: adc: ad7606: Add iio-backend support
      iio: adc: ad7606: Disable PWM usage for non backend version

 .../devicetree/bindings/iio/adc/adi,ad7606.yaml    |  72 ++-
 Documentation/iio/ad7606.rst                       | 145 ++++++
 Documentation/iio/index.rst                        |   1 +
 MAINTAINERS                                        |   1 +
 drivers/iio/adc/Kconfig                            |   2 +
 drivers/iio/adc/ad7606.c                           | 576 +++++++++++++++------
 drivers/iio/adc/ad7606.h                           |  51 +-
 drivers/iio/adc/ad7606_par.c                       | 122 ++++-
 drivers/iio/adc/ad7606_spi.c                       |  96 ++--
 9 files changed, 838 insertions(+), 228 deletions(-)
---
base-commit: 465644ac29536d10178b5ca4684d0b84765b9fa4
change-id: 20240725-ad7606_add_iio_backend_support-c401305a6924

Best regards,
--
Guillaume Stols <gstols@baylibre.com>


