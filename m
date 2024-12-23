Return-Path: <linux-pwm+bounces-4459-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B075A9FB320
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Dec 2024 17:44:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A1007A02C2
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Dec 2024 16:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC84A1B6CF4;
	Mon, 23 Dec 2024 16:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="LDUoUpm6"
X-Original-To: linux-pwm@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F24C1B372C;
	Mon, 23 Dec 2024 16:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734972229; cv=none; b=arMBGd1/5jeqL5AnX6GzYUSWhC6IrkOMJnSVasKDvKilHWlIpEUBHbgG44V8dGwXFvr6bQGIjNOf7C9uF0XnbCakhBiQTxa27IDIBocFOkonHSZ7guD8QcHNdMytYfnaT3WbehttVrZTE/3lcaMDuMcOVgcp7cATBL6sfcmY5p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734972229; c=relaxed/simple;
	bh=sGHYrWSXQCOZrKRERLVqHyXhWbAf/MToHiS9M9BLz1U=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=O/magJ2Lmc0gv7pjCc6aJyFhfqNN/UhUVcRVMX1jGIjT9fwwYE4DXBJNgexdroAbDafPz/TMwvitaxiUnT2W8TdQhJq8bpqhs0FYqWT0pypwd9Vtrfz0/gCsLYg4h0TlEpXv48QfnELloUX4j1t4I2lSK1jDsa99S//MoFsjAlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=LDUoUpm6; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A61BA60004;
	Mon, 23 Dec 2024 16:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1734972219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lV6j1N4A98p5xHYyM/cNFuubRs5O3MnjBd6VXqgq/w4=;
	b=LDUoUpm6j7VFnazq8qp+cT+9V4qJjAd9VJatuv/Y5TMHPKOh5Mk4MmbhJkiH/fRAFdirEl
	+q3FG/igjGeZuTB9oe/aw8t4fbSsGHEZ0+HcLjlmhDeQoYvsSnTCCQnS+3mSxigY+pnuN9
	ArtL4uizjJP3IkwNFNpfff8xMxrTOATyrVHh3uJg8f+hYWS/GU9mFAbxPMLCBRNiGvgro3
	bzVFRz20+zUu/80Fk9GYzmsA7LLWzrN7flUY5Be11k5aaJLmi82povyEM+Lp2vnErWPt+7
	nLhTfroTK2SJoqTRiWo0R+iR1DPT+RhNzLKKIupw+lL+/uh87zVwoA/HJ+oJ+Q==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Subject: [PATCH v2 0/7] Add support for MAX7360
Date: Mon, 23 Dec 2024 17:42:32 +0100
Message-Id: <20241223-mdb-max7360-support-v2-0-37a8d22c36ed@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPiSaWcC/32NQQ6CMBBFr0Jm7RjaglRX3sOwaGGUSYSSFhsM6
 d0tHMDl+/n//Q0CeaYAt2IDT5EDuymDPBXQDWZ6EXKfGWQpKyHFFcfe4mjWRl1KDJ95dn5BKZX
 RHVW1NQrycvb05PWwPtrMA4fF+e9xEsWe/vdFgSVq0ko0td5rd+vc8ubp3LkR2pTSD1Zm0ia4A
 AAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734972218; l=2746;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=sGHYrWSXQCOZrKRERLVqHyXhWbAf/MToHiS9M9BLz1U=;
 b=zZaVe7MbuSOer/TV4oLjg391rLokfsycZms/LrecPAl/d2aGhnxULSN3TGAvg3c5dll2D3r5U
 CrTOYvtmN6DDXSCwPkR3mmJKvSWJYamf6ZM1melxa5wFyR12kY7AVYT
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
Changes in v2:
- Removing device tree subnodes for keypad, rotary encoder and pwm
  functionalities.
- Fixed dt-bindings syntax and naming.
- Fixed missing handling of requested period in PWM driver.
- Cleanup of the code
- Link to v1: https://lore.kernel.org/r/20241219-mdb-max7360-support-v1-0-8e8317584121@bootlin.com

---
Kamel Bouhara (2):
      mfd: Add max7360 support
      pwm: max7360: Add MAX7360 PWM support

Mathieu Dubois-Briand (5):
      dt-bindings: mfd: gpio: Add MAX7360
      gpio: max7360: Add MAX7360 gpio support
      input: keyboard: Add support for MAX7360 keypad
      input: misc: Add support for MAX7360 rotary
      MAINTAINERS: Add entry on MAX7360 driver

 .../bindings/gpio/maxim,max7360-gpio.yaml          |  80 ++++
 .../devicetree/bindings/mfd/maxim,max7360.yaml     | 107 +++++
 MAINTAINERS                                        |  12 +
 drivers/gpio/Kconfig                               |  11 +
 drivers/gpio/Makefile                              |   1 +
 drivers/gpio/gpio-max7360.c                        | 455 +++++++++++++++++++++
 drivers/input/keyboard/Kconfig                     |  12 +
 drivers/input/keyboard/Makefile                    |   1 +
 drivers/input/keyboard/max7360-keypad.c            | 289 +++++++++++++
 drivers/input/misc/Kconfig                         |  11 +
 drivers/input/misc/Makefile                        |   1 +
 drivers/input/misc/max7360-rotary.c                | 185 +++++++++
 drivers/mfd/Kconfig                                |  12 +
 drivers/mfd/Makefile                               |   1 +
 drivers/mfd/max7360.c                              | 296 ++++++++++++++
 drivers/pwm/Kconfig                                |  11 +
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/pwm-max7360.c                          | 219 ++++++++++
 include/linux/mfd/max7360.h                        | 109 +++++
 19 files changed, 1814 insertions(+)
---
base-commit: 78d4f34e2115b517bcbfe7ec0d018bbbb6f9b0b8
change-id: 20241219-mdb-max7360-support-223a8ce45ba3

Best regards,
-- 
Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>


