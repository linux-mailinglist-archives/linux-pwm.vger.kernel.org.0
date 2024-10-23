Return-Path: <linux-pwm+bounces-3776-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D689AD5E8
	for <lists+linux-pwm@lfdr.de>; Wed, 23 Oct 2024 22:59:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8A161C22081
	for <lists+linux-pwm@lfdr.de>; Wed, 23 Oct 2024 20:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A62341E8826;
	Wed, 23 Oct 2024 20:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="oANJdccm"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32CDD13AA2B
	for <linux-pwm@vger.kernel.org>; Wed, 23 Oct 2024 20:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729717160; cv=none; b=A/Y26s+88YxOwaw+IB+ZPuJPlnHd+mwUVj+ZNJYaZ2WPRPOtM7UKf6f1+GmgIlYmD4rJZunk+BzHhSneFeDsL2zhaorchzNi/bDeaeLcp2ubFi7GCZLvY7ooCjWOrfFmJKabN13s62hPp05tuo9JAs7TU1zoZPAsd/LuiK9y7Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729717160; c=relaxed/simple;
	bh=gUkuBY9bo71JJTJB5re/xUdAobzayyfJ8VRpLHGMDaU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=aVmkFhGJg9yz18a8hjUumv7A34aeW/Nod8Qo0IlbyL19D3SimTY/v+Pz+jF3hdEpawUU00S52NRKDZDgAv80A2mv/S8NWjP6PH258p08yjh3uZNCXOM2Gm78D6yC0xvGZCS2v0kONjujP6cPK31D4rzbrPR7cw4/FZNVO92l5ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=oANJdccm; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5e5b5715607so131156eaf.1
        for <linux-pwm@vger.kernel.org>; Wed, 23 Oct 2024 13:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729717156; x=1730321956; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2Sq3YErNwXlYIDZenVr/C+NE9FZlP0tU7NSaS67Os0c=;
        b=oANJdccmolGUM+wDY3oJPnn4o6irj/s3KlNDOVy61nKYd0WLqDprl5VGGO6TjNXtwx
         c3vFQZ21T3x7ck5m6JUkDX4s1YZ3ipNplBqXmPuUuVQDKSG93fUV5xNdv0p2AmxpdCbv
         roFadTTb6sCkICIElniOXMqYgVutQPVUTVnEwnMBNa8ixF3w5/rbvPmbyTZ7vsjdWlq9
         2db88OGI6d+28nThhMs4QR+VR+4ENvl8ZvcJ6w5kup5FVj4eBygonQA0cAE7/DBaxp32
         kmGx3/ac+Q2RRjhyy6yWJLft+yGIeYIJP2DXhkWmllxA2kgkH8u4/Vua3QcTYOy3lsgd
         KRTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729717156; x=1730321956;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2Sq3YErNwXlYIDZenVr/C+NE9FZlP0tU7NSaS67Os0c=;
        b=VtvlwVleAYWNjkcENZE+rO5G5OxV+9UqU+8K+SHpssqnKlIALJ3djcblduqIw6QSO0
         7FC09KGpjf8DLZ9m2Y7yE+5ly+jCqFZGlDzSTJGzAdWXsZYZ+rejj/Oh7VWxVE+ZAlwd
         aK9kTgaqde3ukcVBgIvon2BI7oEps30pb9/onkwIA74Qw/IJEUEoSqYH2BnQVZMbuTuE
         Hm+khBSFXCbHS6jy7XRNdjXXzEVvDAI5YKduxlFhqtNDnYAXPbHqgLJgqAr/ad+QyPLo
         jnp22xwFQUTDSdltgJcUQkiveyGkkdoZHpE/OCXRWeUnpjJMrrS6Vw3c6Y2rIrX15uTV
         NZrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKlXTW3HfeLpJMhVU1gJQ3FpcVD0gwFIR4awzGIEicCGaqZbsPXex6TXfbt2nXm+J3nWFlBu54ehc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvCq8bp2R2ZOqF5NLo0iaBURdErzFU0VlUinU4XMPJ/OhfnyZ1
	X6u3g7k8nRi8qzpsl/bvIOwEu5I3cdM+z1McjTbZl/GS8/1WEHP9/N7GpE58Bok=
X-Google-Smtp-Source: AGHT+IF5vEkcFWBunbct3xDPJTcfOq2aHXuUYYMQqfOKidYToX+9CfBb1xysM7teRKdV7vOUrfBZ2A==
X-Received: by 2002:a05:6820:2293:b0:5d6:ab0:b9a6 with SMTP id 006d021491bc7-5ebee27a8a1mr2398714eaf.4.1729717156206;
        Wed, 23 Oct 2024 13:59:16 -0700 (PDT)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5ec02c2c157sm52730eaf.44.2024.10.23.13.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 13:59:14 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH RFC v4 00/15] spi: axi-spi-engine: add offload support
Date: Wed, 23 Oct 2024 15:59:07 -0500
Message-Id: <20241023-dlech-mainline-spi-engine-offload-2-v4-0-f8125b99f5a1@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJtjGWcC/5WNQQrCMBBFryJZOxLT1KgrQfAAbsVFkk7agTSRR
 IpSendjN4Ir3Xz+n4H3RpYxEWa2X4ws4UCZYihDLhfMdjq0CNSUzQQXktdrDo1H20GvKXgKCPl
 GgKF91+icj7oBAdpZrNSOm1obVki3hI4es+XCzqcju5ZjR/ke03M2D2J+/SUZBHDYKq50CSur+
 mD005NJuLKxnxVD9cEqIX7DVgWrpOAo68ZtduYLO03TC+a9ArM1AQAA
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

In this revision, I ended up changing quite a bit more that I was
expecting.

In the DT bindings, I ended up dropping the #spi-offload-cells and
spi-offload properties. A couple of reasons for this:

1. Several people commented that it is odd to have a separate provider/
   consumer binding for something that already has a parent/child
   relationship (both on this series and in another unrelated series
   with io-backends). For now, the only SPI offload provider is the AXI
   SPI Engine, which is a SPI controller.
2. In a discussion unrelated to this series, but related to the idea
   of SPI offloads [1], it became apparent that the proposed use for
   the cells to select triggers and tx/rx streams doesn't actually
   work for that case.
3. In offline review, it was suggested that assigning specific offloads
   to specific peripherals may be too restrictive, e.g. if there are
   controllers that have pools of identical offloads. This idea of
   pools of generic offloads has also come up in previous discussions
   on the mailing list.

[1]: https://lore.kernel.org/linux-iio/e5310b63-9dc4-43af-9fbe-0cc3b604ab8b@baylibre.com/

So the idea is that if we do end up needing to use DT to assign certain
resources (triggers, DMA channels, etc.) to specific peripherals, we
would make a mapping attribute in the controller node rather than using
phandle cells. But we don't need this yet, so it isn't present in The
current patches.

And if we ever end up with a SPI offload provider that is not a SPI
controller, we can bring back the #spi-offload-cells and
spi-offload properties.

Regarding the SPI core changes, there are more details on each
individual patch, but a lot has changed there due to adding a second
ADC consumer that is wired up differently. The AD7944 is as pictured
below, but the AD4695 that has been added has the ADC chip itself as
the SPI offload trigger source, which I found to not be compatible with
many of the assumptions we made in previous revisions. So there isn't
much that is still the same as in previous revisions.

---
Changes in v4:
- Dropped #spi-offload-cells and spi-offload properties from DT bindings.
- Made an attempt at a more generic trigger interface instead of using
  clk framework. This also includes a new driver for a generic PWM
  trigger.
- Addressed IIO review comments.
- Added new patches for iio/adc/ad4695 as 2nd user of SPI offload.
- Link to v3: https://lore.kernel.org/r/20240722-dlech-mainline-spi-engine-offload-2-v3-0-7420e45df69b@baylibre.com

Changes in v3:
- Reworked DT bindings to have things physically connected to the SPI
  controller be properties of the SPI controller and use more
  conventional provider/consumer properties.
- Added more SPI APIs for peripheral drivers to use to get auxillary
  offload resources, like triggers.
- Link to v2: https://lore.kernel.org/r/20240510-dlech-mainline-spi-engine-offload-2-v2-0-8707a870c435@baylibre.com

Individual patches have more details on these changes and earlier revisions too.
---

As a recap, here is the background and end goal of this series:

The AXI SPI Engine is a SPI controller that has the ability to record a
series of SPI transactions and then play them back using a hardware
trigger. This allows operations to be performed, repeating many times,
without any CPU intervention. This is needed for achieving high data
rates (millions of samples per second) from ADCs and DACs that are
connected via a SPI bus.

The offload hardware interface consists of a trigger input and a data
output for the RX data. These are connected to other hardware external
to the SPI controller.

To record one or more transactions, commands and TX data are written
to memories in the controller (RX buffer is not used since RX data gets
streamed to an external sink). This sequence of transactions can then be
played back when the trigger input is asserted.

This series includes core SPI support along with the first SPI
controller (AXI SPI Engine) and SPI peripheral (AD7944 ADC) that use
them. This enables capturing analog data at 2 million samples per
second.

The hardware setup looks like this:

+-------------------------------+   +------------------+
|                               |   |                  |
|  SOC/FPGA                     |   |  AD7944 ADC      |
|  +---------------------+      |   |                  |
|  | AXI SPI Engine      |      |   |                  |
|  |             SPI Bus ============ SPI Bus          |
|  |                     |      |   |                  |
|  |  +---------------+  |      |   |                  |
|  |  | Offload 0     |  |      |   +------------------+
|  |  |   RX DATA OUT > > > >   |
|  |  |    TRIGGER IN < < <  v  |
|  |  +---------------+  | ^ v  |
|  +---------------------+ ^ v  |
|  | AXI PWM             | ^ v  |
|  |                 CH0 > ^ v  |
|  +---------------------+   v  |
|  | AXI DMA             |   v  |
|  |                 CH0 < < <  |
|  +---------------------+      |
|                               |
+-------------------------------+

---
David Lechner (15):
      pwm: core: export pwm_get_state_hw()
      spi: add basic support for SPI offloading
      spi: offload: add support for hardware triggers
      spi: dt-bindings: add trigger-source.yaml
      spi: dt-bindings: add PWM SPI offload trigger
      spi: offload-trigger: add PWM trigger driver
      spi: add offload TX/RX streaming APIs
      spi: dt-bindings: axi-spi-engine: add SPI offload properties
      spi: axi-spi-engine: implement offload support
      iio: buffer-dmaengine: document iio_dmaengine_buffer_setup_ext
      iio: buffer-dmaengine: add devm_iio_dmaengine_buffer_setup_ext2()
      iio: adc: ad7944: don't use storagebits for sizing
      iio: adc: ad7944: add support for SPI offload
      dt-bindings: iio: adc: adi,ad4695: add SPI offload properties
      iio: adc: ad4695: Add support for SPI offload

 .../devicetree/bindings/iio/adc/adi,ad4695.yaml    |  13 +-
 .../bindings/spi/adi,axi-spi-engine.yaml           |  22 +
 .../devicetree/bindings/spi/trigger-pwm.yaml       |  39 ++
 .../devicetree/bindings/spi/trigger-source.yaml    |  28 ++
 drivers/iio/adc/Kconfig                            |   2 +
 drivers/iio/adc/ad4695.c                           | 470 +++++++++++++++++++--
 drivers/iio/adc/ad7944.c                           | 249 ++++++++++-
 drivers/iio/buffer/industrialio-buffer-dmaengine.c | 104 ++++-
 drivers/pwm/core.c                                 |  55 ++-
 drivers/spi/Kconfig                                |  16 +
 drivers/spi/Makefile                               |   4 +
 drivers/spi/spi-axi-spi-engine.c                   | 273 +++++++++++-
 drivers/spi/spi-offload-trigger-pwm.c              | 169 ++++++++
 drivers/spi/spi-offload.c                          | 446 +++++++++++++++++++
 drivers/spi/spi.c                                  |  10 +
 include/linux/iio/buffer-dmaengine.h               |   5 +
 include/linux/pwm.h                                |   1 +
 include/linux/spi/spi-offload.h                    | 166 ++++++++
 include/linux/spi/spi.h                            |  19 +
 19 files changed, 1995 insertions(+), 96 deletions(-)
---
base-commit: 6c4b0dd7d0df3a803766d4954dc064dc57aeda17
change-id: 20240510-dlech-mainline-spi-engine-offload-2-afce3790b5ab

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


