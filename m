Return-Path: <linux-pwm+bounces-4401-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8DF39F7F52
	for <lists+linux-pwm@lfdr.de>; Thu, 19 Dec 2024 17:22:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65AE3188951E
	for <lists+linux-pwm@lfdr.de>; Thu, 19 Dec 2024 16:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 443C722653B;
	Thu, 19 Dec 2024 16:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="MMCyBE66"
X-Original-To: linux-pwm@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68DBB13A41F;
	Thu, 19 Dec 2024 16:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734625318; cv=none; b=rxouHpsBcDIlf8J5vx0X18IAMZGPs6V/+Sq1VJuq+L8e529l4rYDPpuhX2DJZMBrSuc6ZtlXi9HHlYBi6gOmwz3+ufk7EGbxPRWiqufHeH0luY3d/UxvmjdYDWXDI0LC4Ix48khZ9OOritlUZ4cU+Rs+CBjTQxuLWuCm0QZVlwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734625318; c=relaxed/simple;
	bh=PFXrEneY7LN8GFDGKSq5kZxvxcHXVcq18nHJg+DB9tI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=bd4T83NWbQqcMa/Slv9Bzy6loK6vAm+t0chrceZjdBM4spXlKXDkVV1kiscbk2HsoL3hE/Q/7F/JegmwYk6InfpABqpqg0KwRoHVyLHVLz9Msys5LrJc1foLPqb0qLU7h8J+ZJJdsxMLZ/pgESjHzsZfvSfCWT7oBKbAtssBku4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=MMCyBE66; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9043B6000E;
	Thu, 19 Dec 2024 16:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1734625308;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hbjmlsWctXuimzc17WoC2gtIxpQQnqQvTMXKjQlvx78=;
	b=MMCyBE66dl8OOAynP5TBOqRXp4j+DXnjQx3CLPQg53ok0zTOdRGV8YCyQReLC+pTMUneAZ
	bsDqCThpL7sRq4Yrjqr5T5htk3k446IFoZlSqIeD/Zd4PdLVec8icxZ//Zn0mQxJqtLTk9
	xx4LOq93MciLBxG86ZGd9ZgxZ/aZTJxhe9k1F3AyY2nMoR31K3Jk18fEDBhIXdoq7F7q+7
	OSP6kQ5FWdgy/Bez/DijukjSURSQ/NGD7JGLsu7DOS/HyIqSfVuJyXZt9ri3LL31MrLV6f
	+Z2dB3Zg/m4MYH5EMTXbZrURVJYwbFahofDtihs8Bj9CMlXTl03DzRCTPv5F7w==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Subject: [PATCH 0/8] Add support for MAX7360 multifunction device
Date: Thu, 19 Dec 2024 17:21:17 +0100
Message-Id: <20241219-mdb-max7360-support-v1-0-8e8317584121@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAP1HZGcC/x3MTQ5AMBBA4avIrE2iU/9XEYtiMAs0LdJE3F1j+
 S3ee8CzE/bQJg84vsXLsUeoNIFxNfvCKFM0UEa5ItXgNg24mVDpMkN/WXu4E4m0qUfOi8FoiKV
 1PEv4r13/vh/XvQqVZQAAAA==
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Kamel Bouhara <kamel.bouhara@bootlin.com>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-input@vger.kernel.org, 
 linux-pwm@vger.kernel.org, 
 =?utf-8?q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734625307; l=2640;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=PFXrEneY7LN8GFDGKSq5kZxvxcHXVcq18nHJg+DB9tI=;
 b=mR5GwIP+qdMUt74C2iN1BlP7fnLCKi+OIUgQE8SKeVW54Twxfq/i74AAWfOcgRQX/j5etT8Eb
 gk6VrCGzBn3C6YVZnND7FJYL3igLmADbcJTfm32Xr28ugj5X2etb5AX
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-GND-Sasl: mathieu.dubois-briand@bootlin.com

This series implements a set of drivers allowing to support the Maxim
Integrated MAX7360 device.

The MAX7360 is an I2C key-switch and led controller, with following
functionalities:
- Keypad controller for a key matrix of up to 8 rows and 8 columns.
- Rotary encoder support, for a single rotary encoder.
- Up to 8 PWM outputs.
- Up to 8 GPIOs with support for interrupts and 6 GPOs.

Chipset pins are shared between all functionalities, so all cannot be
used at the same time.

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
Kamel Bouhara (2):
      mfd: Add max7360 support
      pwm: max7360: Add MAX7360 PWM support

Mathieu Dubois-Briand (6):
      dt-bindings: Add MAX7360 MFD device
      dt-bindings: Add MAX7360 subdevices
      gpio: max7360: Add MAX7360 gpio support
      input: keyboard: Add support for MAX7360 keypad
      input: misc: Add support for MAX7360 rotary
      MAINTAINERS: Add entry on MAX7360 driver

 .../devicetree/bindings/gpio/max7360-gpio.yaml     |  96 +++++
 .../devicetree/bindings/input/max7360-keypad.yaml  |  67 +++
 .../devicetree/bindings/input/max7360-rotary.yaml  |  52 +++
 Documentation/devicetree/bindings/mfd/max7360.yaml |  56 +++
 .../devicetree/bindings/pwm/max7360-pwm.yaml       |  35 ++
 MAINTAINERS                                        |  12 +
 drivers/gpio/Kconfig                               |  11 +
 drivers/gpio/Makefile                              |   1 +
 drivers/gpio/gpio-max7360.c                        | 453 +++++++++++++++++++++
 drivers/input/keyboard/Kconfig                     |  12 +
 drivers/input/keyboard/Makefile                    |   1 +
 drivers/input/keyboard/max7360-keypad.c            | 297 ++++++++++++++
 drivers/input/misc/Kconfig                         |  11 +
 drivers/input/misc/Makefile                        |   1 +
 drivers/input/misc/max7360-rotary.c                | 194 +++++++++
 drivers/mfd/Kconfig                                |  12 +
 drivers/mfd/Makefile                               |   1 +
 drivers/mfd/max7360.c                              | 302 ++++++++++++++
 drivers/pwm/Kconfig                                |  11 +
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/pwm-max7360.c                          | 173 ++++++++
 include/linux/mfd/max7360.h                        | 103 +++++
 22 files changed, 1902 insertions(+)
---
base-commit: 78d4f34e2115b517bcbfe7ec0d018bbbb6f9b0b8
change-id: 20241219-mdb-max7360-support-223a8ce45ba3

Best regards,
-- 
Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>


