Return-Path: <linux-pwm+bounces-3553-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DBD99964F3
	for <lists+linux-pwm@lfdr.de>; Wed,  9 Oct 2024 11:21:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE2FEB271BE
	for <lists+linux-pwm@lfdr.de>; Wed,  9 Oct 2024 09:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C641118E03C;
	Wed,  9 Oct 2024 09:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="g/NX4I02"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F40817
	for <linux-pwm@vger.kernel.org>; Wed,  9 Oct 2024 09:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728465587; cv=none; b=htFOz76k/ZykmBBWt56mSlLs6b0wkrsFWFvNZ7BKoH5NlwPrhFQTPqgO02B78YPqqSoYHL4KvXm6M5qs5N0CK6RW4U7p5Vq08ukgSQ6kRW91bvdZ2fy9w5v+dJ3/rMLcUf5hNwfrGiLlbee5G9R9b8lWLH/+JR5ahP25SJiie+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728465587; c=relaxed/simple;
	bh=n9NcSx6B6mq5gEWt7lUtBdnyNqrVS/k0PL3jsKufD5g=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=fcR2nKXUMU/r/H68h2pS4ZKjmEv2eLtPnwcmWP/lvF6igfltgbOUD2Fa0aOByV+6MqjIcR2sp1OdivNEt8tGAc2Ckcp4nwyUKsH4YESPBDjuR0QntsAOCa9Z3CiwXoXNTNkNHKweo2N/9oPz+hmigITwyHO0nlMedcHOfOePzCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=g/NX4I02; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42f56ad2afaso88160765e9.1
        for <linux-pwm@vger.kernel.org>; Wed, 09 Oct 2024 02:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728465583; x=1729070383; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jBR7OYZriJhDfvISw9B9LqPMX41wXLMjEmHGfAiqmLI=;
        b=g/NX4I02L2fPyqNGD/tN6mEzDnMMeD7pE5MlfoNWYJz4qYQobZ8wFJ8QuqHEx8QvB4
         wyS1BE6KpcFuaajpDKiOGp6m5Eqw02xDjQJOs1KwEittqGLyJ/g+RrEA8C4/65zP6h4j
         bi2Ca/rDpWy3n9Zq5LvDo+yYcZN2xiKtxRsekW/rUeKWo+o9o2hMLyYOlvrIHo4mwviT
         IoFpPkEV+/akfHEetrKBKA/v6ZfrBbXzNHcZQ/P0WAgDnKStgHpOZDoyYF3SdsdAu5jc
         ZSOhXI8FrgZK/7iZTO51S6O2t6XuElwSVU+++Y/V9/lGpBa3tnl0X+pym7NX3uTkIi1g
         u7yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728465583; x=1729070383;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jBR7OYZriJhDfvISw9B9LqPMX41wXLMjEmHGfAiqmLI=;
        b=FSUeEGfWblxNwM4UCfmr4RYNb/Q//r6ysrt2AfgQgM7sfZAygXC1Z7x2YEz36VFHuj
         l09Q0bAklDIi5gFNhQRRudISSFe/mzXHjfihP81x+wd5bkDEZd7mEX6oCVkyLuPF26gK
         2pG/E09CUjGuE5rX/JytsWfY3HRsODtGb1o9YyzLdYMkz+/jCDA/l5h5Dc8LCEQmQJW0
         6Qh4F1hV55vqMD9t1Vadw65cnbdUw8ubjwMAtFIsd9kKzelvtgwK4wicvu81i8/E2tl5
         cmdA383eXV/ZFil88PWekuon2hOU/VTXhxZE/ddR/zroC7GTcMRYHiRyv/00PCpu2/DD
         uAoA==
X-Gm-Message-State: AOJu0YyYm2EnxUR8c1KPxl+NxSqikuUFXiJtbkQXCNBpDXKBNEDBUyrj
	hqNE3QGpl+Da5hbLmaBHX/tZI50iaclHJXUGkehSfuAxwNwNET3PAzD1GBLCv/I=
X-Google-Smtp-Source: AGHT+IFjXWWvtj0jzmE/w31GHgXvDjDbLGpThHIRDRdfMpzR6HxFmqq2psvrZUA+k9uwR4WGYITAMQ==
X-Received: by 2002:a05:600c:19ca:b0:42c:bbd5:727b with SMTP id 5b1f17b1804b1-430d70b3d31mr17564835e9.25.1728465582224;
        Wed, 09 Oct 2024 02:19:42 -0700 (PDT)
Received: from [127.0.1.1] (frhb82016ds.ikexpress.com. [185.246.87.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-430d59b1207sm13892765e9.31.2024.10.09.02.19.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 02:19:41 -0700 (PDT)
From: Guillaume Stols <gstols@baylibre.com>
Subject: [PATCH v4 0/8] Add iio backend compatibility for ad7606
Date: Wed, 09 Oct 2024 09:19:31 +0000
Message-Id: <20241009-ad7606_add_iio_backend_support-v4-0-6971a8c0f1d5@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKNKBmcC/4XO3UrEMBCG4VtZcmxk8tMk3SPvQ6RMkqkbdNuad
 IvL0ns3dkFBhB5+c/DMe2OFcqLCjocby7SkksahDv1wYOGEwyvxFOtmEqQGKxuO0RowHcbYpTR
 2HsMbDbErl2ka88yDBqGgQdNKzSoyZerT5/bg+eW+M31c6p/5fmQeC/Ewns9pPh5a48nYgAg9a
 AlRC+mCN7YH6320aHrdEihk39YplXnM1619ERu2ZTqxm7kIDjwQKhLCC0T95PH6nnymx5qy6Yv
 8FVsJu6KsIpB11kkkG+EfUf2IAkDviqqKytnGgpCBnPwjruv6BQwvFpq/AQAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728465581; l=5077;
 i=gstols@baylibre.com; s=20240417; h=from:subject:message-id;
 bh=n9NcSx6B6mq5gEWt7lUtBdnyNqrVS/k0PL3jsKufD5g=;
 b=8So2hJjBpW+YQoPjEqfgcs8pso2hqjXTv7ye0zuY1s3sg325sPLFleO65eS1Sts/VcXsxp6Ht
 kxlSt+kMRklAr4uGyI7N+uBvarxBJ1NCGA8QJahVt7UdOiV28+XXM6L
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
 drivers/iio/adc/ad7606.c                           | 575 +++++++++++++++------
 drivers/iio/adc/ad7606.h                           |  51 +-
 drivers/iio/adc/ad7606_par.c                       | 123 ++++-
 drivers/iio/adc/ad7606_spi.c                       |  96 ++--
 9 files changed, 839 insertions(+), 227 deletions(-)
---
base-commit: 96be67caa0f0420d4128cb67f07bbd7a6f49e03a
change-id: 20240725-ad7606_add_iio_backend_support-c401305a6924

Best regards,
--
Guillaume Stols <gstols@baylibre.com>


