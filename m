Return-Path: <linux-pwm+bounces-3306-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C488997D909
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Sep 2024 19:33:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C1602826D6
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Sep 2024 17:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E981D17E010;
	Fri, 20 Sep 2024 17:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="uLa9Iq+y"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF4829CE6
	for <linux-pwm@vger.kernel.org>; Fri, 20 Sep 2024 17:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726853609; cv=none; b=nt9GhT5a7pX5dtVgippon15VKo4lXc75LDjvkYi40sLKbo4thLLLTPkchthn+QCD3Y00jP6g6G/dw6mrgnj4AyQC8gvaKly082mmMaKlzEMwqI0wveBfbaWB3+eTRHntNnn4HUsSQ9U4Jv8tR49APinfplNIecVliBH71S3ihow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726853609; c=relaxed/simple;
	bh=1IlR2iZrx1TWLUUVujKhfxFMAELLRAU+i32cLvFkSvg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=iZ7w//67Hlvul2S8lyP9KlG1M6SMfRNdQ6pwv4Z12Gc19DwvNmWJ6VT+IrMaHlbYWvQHPoanAsKQqzh+jod5fAUJKeK4BZPKxOrKUK0ToqOMijSYA1bikf+JIMpwd8uzt32ZbunQr71bpjJONSpKm4aM/PcNOr5oyNL0Ipx5YhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=uLa9Iq+y; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42cd74c0d16so20618385e9.1
        for <linux-pwm@vger.kernel.org>; Fri, 20 Sep 2024 10:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1726853606; x=1727458406; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6UUFhGcTyiJvlWI+WlBNBe2epzsWpe+JtKV2K/AcAmk=;
        b=uLa9Iq+y2zz500I+S7qTrtoi5u02SKxSkBsp4IJ8Nktj6I15/rQZwDpP+/0PIJeUgC
         z6XEjjWiDeAz0ySrQu0llV/+2K9eF/yIE+GmnCVX29J2G4cIh+CdyixQz43cohnnBgwO
         x2RQ+2D6SkZZv9MMi12n3Ue/hwcomRBgu2wwb2eCBzJ5jzf2aoFBAaAWHMvN/mJz0xkN
         /NWnCYDbFcMfvEfew5e8kQJQyFT1RT799iEb6UGAtN034cORmgCVG9Jk/LfjKDmB4/FF
         LeWCkSGSd+WU2U1IggZzUkhAiJc0ukKRvjiGz/+uaKGRndQAFEIsppBEQ0nFcW4sb8nQ
         /cYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726853606; x=1727458406;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6UUFhGcTyiJvlWI+WlBNBe2epzsWpe+JtKV2K/AcAmk=;
        b=X6owzTbjb/2P9bYyFhUUYKIf4N7P/ao+ZAzkBFkwUPaIYBhJ3UaEbOWH34nYZfzRDi
         z8k+XBPSIor1L0I7hhZiN/80jF/a+ix7/D0hm5RcQKT8bCL7EP9kL6aJECpdo+YS2oYd
         5Dp1rotj8AQoQtfivpnkKEzk7mx0I/lMYbtBrNNFueaqBoHM/CJxJdJerm0YvIsENfUe
         MyISn0xJEPSU+bY4jfqImYqdo/Kw2Bmsk8hMiy3dOPLYk6uE0AK675uobr8XIjwrUf25
         A+VWQvCJoOMyVURsn8FYLZY688v29zW02su8JWSK1iiK07uH7fzZMW5zbrMjE7sa48BD
         6DzQ==
X-Gm-Message-State: AOJu0Yx7V/zwG8Shu/iM+dZx/Q/DNzQdHsKHA1vM+Ve0hKz3WZzw/tnz
	MXq/Orj63rcXdWPH5IMrmZvcanKoAjjWRl1tvpkEtKNo1zGt2i5uQELDvlN0cho=
X-Google-Smtp-Source: AGHT+IGgCKLlGsFVnLPMMsSCnB8uD2rlgl4JGpdbipw0lqW+P0JA7xndJNxMakwiINiRxxfTey9q+w==
X-Received: by 2002:a05:600c:1553:b0:42c:b180:d452 with SMTP id 5b1f17b1804b1-42e7ac4b610mr28776055e9.19.1726853605527;
        Fri, 20 Sep 2024 10:33:25 -0700 (PDT)
Received: from [127.0.1.1] (frhb82016ds.ikexpress.com. [185.246.87.17])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e780e029sm18111177f8f.116.2024.09.20.10.33.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 10:33:25 -0700 (PDT)
From: Guillaume Stols <gstols@baylibre.com>
Subject: [PATCH v2 00/10] Add iio backend compatibility for ad7606
Date: Fri, 20 Sep 2024 17:33:20 +0000
Message-Id: <20240920-ad7606_add_iio_backend_support-v2-0-0e78782ae7d0@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOCx7WYC/4WOQW7CMBBFrxLNuka24yQuK+6BUDS2J2XUEgc7R
 CCUu2PCAbp8f/H+e0KmxJRhXz0h0cKZ41hAf1Xgzzj+kOBQGLTURna6ERi6VrY9htAzx96h/6U
 x9Pk2TTHNwhupatlg+60NFMmUaOD7dnA8fTjR9VZ+5s8IDjMJHy8XnveVdYS17SyqRinnCYPXg
 xu0NU5K532DmgoFeLvOnOeYHlv7ojbZlmnVv5mLElIUfU3lRiGag8PHH7tEu5ICp3VdXyRD0Nc
 bAQAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1726853604; l=4064;
 i=gstols@baylibre.com; s=20240417; h=from:subject:message-id;
 bh=1IlR2iZrx1TWLUUVujKhfxFMAELLRAU+i32cLvFkSvg=;
 b=BkWA5UZ8sbnmCANhIMAVsLd2+kn0lyBQ/wmDqoeiqChuNU9MI4wLyBlKGIVmoeIkIMZWlUAnz
 HBqJyUAgKfrBimDDhdOZCtUAJeQfvVoU3mTMM+xAWQRyPa8roudXHYd
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
Guillaume Stols (10):
      dt-bindings: iio: adc: ad7606: Set the correct polarity
      dt-bindings: iio: adc: ad7606: Make corrections on spi conditions
      dt-bindings: iio: adc: ad7606: Add iio backend bindings
      Documentation: iio: Document ad7606 driver
      iio: adc: ad7606: Sort includes in alphabetical order
      iio: adc: ad7606: Add PWM support for conversion trigger
      iio: adc: ad7606: Add compatibility to fw_nodes
      iio: adc: ad7606: Fix typo in the driver name
      iio: adc: ad7606: Add iio-backend support
      iio: adc: ad7606: Disable PWM usage for non backend version

 .../devicetree/bindings/iio/adc/adi,ad7606.yaml    |  97 ++++-
 Documentation/iio/ad7606.rst                       | 143 +++++++
 drivers/iio/adc/Kconfig                            |   4 +-
 drivers/iio/adc/ad7606.c                           | 474 +++++++++++++++------
 drivers/iio/adc/ad7606.h                           |  51 ++-
 drivers/iio/adc/ad7606_par.c                       | 126 +++++-
 drivers/iio/adc/ad7606_spi.c                       |  33 +-
 7 files changed, 749 insertions(+), 179 deletions(-)
---
base-commit: 8bea3878a1511bceadc2fbf284b00bcc5a2ef28d
change-id: 20240725-ad7606_add_iio_backend_support-c401305a6924

Best regards,
--
Guillaume Stols <gstols@baylibre.com>


