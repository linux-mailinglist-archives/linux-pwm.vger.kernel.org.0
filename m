Return-Path: <linux-pwm+bounces-4595-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B58D5A0B730
	for <lists+linux-pwm@lfdr.de>; Mon, 13 Jan 2025 13:43:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEA32162088
	for <lists+linux-pwm@lfdr.de>; Mon, 13 Jan 2025 12:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FE1C22F168;
	Mon, 13 Jan 2025 12:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="IkBdRG5m"
X-Original-To: linux-pwm@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0F522AE41;
	Mon, 13 Jan 2025 12:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736772191; cv=none; b=MWlUJDEHCOOrDXxlpRrgmbyrTAk9GJQTKrFzslN/1l300DPnTHVnRTxQS0Uagkf+5YY7hi6R476HZW/PzNRpdM1rmCQdhTXsl6BxtKavDbNA2yuF+oZ6IY/FgROWKiv8yYZo/Oomy9iMObNmqrrpinAaC2TeNASkt1zvyaGsbjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736772191; c=relaxed/simple;
	bh=x5SgPW8bfo57jTlR9MQ3YN3nEDklpzcCf+voPz8Secs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=h4ufL4PcMU2wKCDS4HU0zX7BEMjCv9Z2G4PyttrCJsNLmUqUJ54wEqyjeibhtEwiyAaDwQkpynQyxfiKc/fwfpQjc5VFcVg9Lu+uOn7HrEd3pLz+3uBMfH0L3jOaJsSkUEhTOBdorttFJMGxVV3ZFmU7YvlmGCbX2GPnP4u48B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=IkBdRG5m; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id DDE1B24000B;
	Mon, 13 Jan 2025 12:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1736772186;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=iefv3ZxEy14mmBM/AkA5K3Ony2LyBSi5HCJzyxiTX0k=;
	b=IkBdRG5mS34VAGOKBOWiZelgrFOk/9dvWawzesRoTzJoJ5OdDb97AOM2y/C1yhvGWx2Yf9
	fklVLD82yNcujoOFAM1sC7IxK2w2Rv250bOiSLhAfHM0yZDqBoEYV+9jEiVQyLdNGVDXjx
	DDVjR13ccXiXwmK96kCvYO6NoNqpttLkmipHr1Vf36dK0I99gFbniNGMXhNCw7DTSknbKo
	FKVouXTMqo/ioiojkRwNNOCa86GVQK+BtkJ7hdVHzW2N6wc4fe4ITwjfZ5M4cW+g/kIsLR
	IFeqmzj/mpti94hwAFCo0cJ6zW2yhB3hXnskTuxSIYcW6K+tR2zmBXFbRedOFw==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Subject: [PATCH v3 0/7] Add support for MAX7360
Date: Mon, 13 Jan 2025 13:42:24 +0100
Message-Id: <20250113-mdb-max7360-support-v3-0-9519b4acb0b1@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADAKhWcC/33NzQ6CMAzA8VchOzvDWj4mJ9/DeBhblSXCyIYLh
 vDuDk6aGI//pv11YYG8pcCabGGeog3WDSnwkDHdqeFO3JrUDHIoBIgT703LezXXWOU8PMfR+Yk
 DoJKairJVyNLl6Olm5129XFN3NkzOv/YnUWzT/14UPOeSJIq6lNvauXVuetjhqF3PNjHChwL4W
 4GkYK2kAdBYkflW1nV9A6c/M7/+AAAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1736772185; l=3060;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=x5SgPW8bfo57jTlR9MQ3YN3nEDklpzcCf+voPz8Secs=;
 b=22OGeXHrSKqh8Z+epoYqJRRN3/gOubcatAXVDgcsvS1FDRqdH9Ka5NmHticPMK7BF8RVXi65R
 4WRJ/+VTCBNBrAPy/busS5AuPNE0ATaR+8g7Q7deHDRxtEJpxbtV6Mr
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
Changes in v3:
- Fix MFD device tree binding to add gpio child nodes.
- Fix various small issues in device tree bindings.
- Add missing line returns in error messages.
- Use dev_err_probe() when possible.
- Link to v2: https://lore.kernel.org/r/20241223-mdb-max7360-support-v2-0-37a8d22c36ed@bootlin.com

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

 .../bindings/gpio/maxim,max7360-gpio.yaml          |  90 ++++
 .../devicetree/bindings/mfd/maxim,max7360.yaml     | 140 +++++++
 MAINTAINERS                                        |  12 +
 drivers/gpio/Kconfig                               |  11 +
 drivers/gpio/Makefile                              |   1 +
 drivers/gpio/gpio-max7360.c                        | 454 +++++++++++++++++++++
 drivers/input/keyboard/Kconfig                     |  12 +
 drivers/input/keyboard/Makefile                    |   1 +
 drivers/input/keyboard/max7360-keypad.c            | 284 +++++++++++++
 drivers/input/misc/Kconfig                         |  11 +
 drivers/input/misc/Makefile                        |   1 +
 drivers/input/misc/max7360-rotary.c                | 183 +++++++++
 drivers/mfd/Kconfig                                |  12 +
 drivers/mfd/Makefile                               |   1 +
 drivers/mfd/max7360.c                              | 296 ++++++++++++++
 drivers/pwm/Kconfig                                |  11 +
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/pwm-max7360.c                          | 220 ++++++++++
 include/linux/mfd/max7360.h                        | 109 +++++
 19 files changed, 1850 insertions(+)
---
base-commit: 78d4f34e2115b517bcbfe7ec0d018bbbb6f9b0b8
change-id: 20241219-mdb-max7360-support-223a8ce45ba3

Best regards,
-- 
Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>


