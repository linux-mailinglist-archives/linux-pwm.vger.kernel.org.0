Return-Path: <linux-pwm+bounces-3015-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77517952DF0
	for <lists+linux-pwm@lfdr.de>; Thu, 15 Aug 2024 14:12:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0925F1F24B36
	for <lists+linux-pwm@lfdr.de>; Thu, 15 Aug 2024 12:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E67C917C984;
	Thu, 15 Aug 2024 12:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="RegdssjB"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9001714DD
	for <linux-pwm@vger.kernel.org>; Thu, 15 Aug 2024 12:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723723930; cv=none; b=NTPc/kEarcB7Bs0lzNBze8dgpUrOR0fPlBjozTQdxoSvauQF/1vfuIgLdKhLFVKo8V6Vnb5lKUBN3T/r8MA2Nmb/uFy9tJ+ePqd74WG1MRsiHVVC0HkdbNXNLTRJiJ8djBI8Nn7wXhmW8ep2tiFPhQgfb2gB7ez99YWViO/Eu4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723723930; c=relaxed/simple;
	bh=Us88Shtkd7A1R1s6R1VBRQRr7IdSygdzcSsx6VJC0MM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=iq6S1WZ1FNFgaAOP4g8C87y+yjYjZR1wh3xKM7nQ57elxsox+BG8Tdre/ysxT4fcsJtGTM//cYewT0Rn44Xq0RmFX0WHz24cdObiIusfOoLFb46CNvBexLaTBtFJ9UnQpu73Xnmq7A+DH7P8zazZiZV8hi2pw6SxoTxwpIKQpsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=RegdssjB; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4281c164408so5193235e9.1
        for <linux-pwm@vger.kernel.org>; Thu, 15 Aug 2024 05:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1723723924; x=1724328724; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B6b2zbLM/Tp1Zgk0fNHIy17cVxQgx0rBqolcnQ+5/cI=;
        b=RegdssjB8oOke8IZynsMt96IpUxg1eVKmYKKTKE7BDIHnBWEduEoLm9qhFDMZdeQYW
         X2lfh30R6XOpbbnKC03wdLle766LDokCxvjn3QEbhql+3gPcLY6g/TLg1ursQxVhuVjf
         kd7jTX1w4Y3LTJizaPCJYLvSV2bEhtrQEQE5TBM21o7CuphKr4vmrEP3SvYRB2vHaaZM
         bbhSYeO/Z3V6wrV9hmqwl66Hkc5Yfom3vQnRaC9arhCCgMf4MagQ77IqPB86rN1O1pO/
         R0gGVupbYqOF4ZRIEq4tLUPM/R3JkS8G6LJUX0NfNSN+9rigoc2FVCFo6k2NDuroHWSm
         O0mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723723924; x=1724328724;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B6b2zbLM/Tp1Zgk0fNHIy17cVxQgx0rBqolcnQ+5/cI=;
        b=B7M990K0tIOwmY7DtH4jVpsT2mSmouI32wG1OlmNTCy7/4sD4PFXKqG6p+JypJy34G
         nrhF8ftqz4F0Cqm8FKCLQ5QbKTZKW/ujo7WIpjHFbJg3xiHkalGp9rmK6lTjgaPv5UbX
         Gc10TXuXomjgO87fVP3/KMYC1aYhXXH6X2tKLpQLjHRZ9pz28bAxf/bHS0n+vPRNh42o
         9RjjBu/xrDAjXvljGMzxOKoAZT5KbSXpwBOvJtrlHGmK04RFw7rdskw653CHN7uWt3Kq
         pcLJ1UjDYR14RQjy9P2At+Ilk3OqRdyKXCupnJ4ybMXB4znI7fy5k0PyzafJFOBfLHo5
         zUSA==
X-Gm-Message-State: AOJu0Ywv3ulKN7SXCabMbLa/QvrNvHkWlCVEuxpo7iimwDeTWT5S1Zfj
	92RdgvldZnp3rVJJYym7dOvysIg5mwPQNQXjUwRO0NGITW9uXL7mXnj4qMV3g8I=
X-Google-Smtp-Source: AGHT+IGGbmDLyMbLzqjs4KjegU7nHsA9v7FA6+8m2rxRuRBMQ01O93ZYfORFa2jKMn4eELFwot9xXg==
X-Received: by 2002:a5d:5c88:0:b0:371:8277:6649 with SMTP id ffacd0b85a97d-37182776782mr2063758f8f.2.1723723923878;
        Thu, 15 Aug 2024 05:12:03 -0700 (PDT)
Received: from [127.0.1.1] (frhb82016ds.ikexpress.com. [185.246.87.17])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37189897926sm1365082f8f.87.2024.08.15.05.12.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 05:12:03 -0700 (PDT)
From: Guillaume Stols <gstols@baylibre.com>
Subject: [PATCH 0/8] Add iio backend compatibility for ad7606
Date: Thu, 15 Aug 2024 12:11:54 +0000
Message-Id: <20240815-ad7606_add_iio_backend_support-v1-0-cea3e11b1aa4@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIvwvWYC/5WNO27DMBAFryKwDgkufyuryj0CQ6DItULI+oSUj
 ASG7x7FKlME6d68YubOCuVEhTXVnWW6pZLmaQd4qVh491NPPMWdmZLKSFSW+4hOutbH2KY0t50
 PA02xLduyzHnlwUjQ0np3UobtkiXTJX0+A2/ngzN9bHtnPU42Uin+2WmqoyKtAjBWCQCLJ4dc8
 U0MV0oT8WGmKfWvnf+6pi6TCPP4k/ktAQUItQIBBmWt9T8lYb5RFoAKpJE1WtGnVfwl6Hwhvu8
 xrU2FwUdwOuhT6JxRFG2NURN1Gr11GomkQiMv7Px4fAOT39QdhwEAAA==
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
 Guillaume Stols <gstols@baylibre.com>, 
 20240705211452.1157967-2-u.kleine-koenig@baylibre.com, 
 20240712171821.1470833-2-u.kleine-koenig@baylibre.com, 
 cover.1721040875.git.u.kleine-koenig@baylibre.com, aardelean@baylibre.com
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723723923; l=4428;
 i=gstols@baylibre.com; s=20240417; h=from:subject:message-id;
 bh=Us88Shtkd7A1R1s6R1VBRQRr7IdSygdzcSsx6VJC0MM=;
 b=Ynl+ACj13W8GI6QAHhXWja2h5+tS9oSA3WFsW85NRdCIu5pJENDwU3D3nnu8T5VLi3Q4nh8Ti
 yaFta/5OGDYD7bj42YdETbF1veWmNalgx681cWt3SAgz1K8FbH/BfIo
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
Guillaume Stols (8):
      dt-bindings: iio: adc: ad7606: Make corrections on spi conditions
      dt-bindings: iio: adc: ad7606: Add iio backend bindings
      Documentation: iio: Document ad7606 driver
      pwm: Export pwm_get_state_hw
      platform: add platform_get_device_match_data() helper
      iio: adc: ad7606: Add PWM support for conversion trigger
      iio: adc: ad7606: Switch to xxx_get_device_match_data
      iio:adc:ad7606: Add iio-backend support

 .../devicetree/bindings/iio/adc/adi,ad7606.yaml    |  90 ++++-
 Documentation/iio/ad7606.rst                       | 142 ++++++++
 drivers/base/platform.c                            |  12 +
 drivers/iio/adc/Kconfig                            |   3 +-
 drivers/iio/adc/ad7606.c                           | 363 +++++++++++++--------
 drivers/iio/adc/ad7606.h                           | 151 ++++++++-
 drivers/iio/adc/ad7606_par.c                       | 120 ++++++-
 drivers/iio/adc/ad7606_spi.c                       |  31 +-
 drivers/pwm/core.c                                 |   3 +-
 include/linux/platform_device.h                    |   1 +
 include/linux/pwm.h                                |   1 +
 11 files changed, 733 insertions(+), 184 deletions(-)
---
base-commit: 7cad163c39cb642ed587d3eeb37a5637ee02740f
change-id: 20240725-ad7606_add_iio_backend_support-c401305a6924
prerequisite-message-id: 20240705211452.1157967-2-u.kleine-koenig@baylibre.com
prerequisite-patch-id: 0e21153cd012f41ba9db52357fd08219af53e26c
prerequisite-message-id: 20240712171821.1470833-2-u.kleine-koenig@baylibre.com
prerequisite-patch-id: b22c91bbc4e3412f8e7e1f796ed18570ae021c96
prerequisite-message-id: cover.1721040875.git.u.kleine-koenig@baylibre.com
prerequisite-patch-id: bfc36d041b9e5d417c6b18268dd91171d627d04e
prerequisite-patch-id: adec4b066442de64275ebc3bd310ebaea99a0e8d
prerequisite-patch-id: b536b9607ae40bd58f3e56c4ccd304b7880b5b90
prerequisite-patch-id: fe43e064fe174b830d5a11f83e3cd7252089820e
prerequisite-patch-id: a1cd565094d86ff473724db1fd6dbb61aca996dd
prerequisite-patch-id: d7b5d697839f0a6cea0aa37810df4d02a7762ead
prerequisite-patch-id: e86302e513cfdf80831da4d79a7a950eecf7c557
prerequisite-patch-id: 05b25465694c5640e42e67d2059e84f34e259670

Best regards,
-- 
Guillaume Stols <gstols@baylibre.com>


