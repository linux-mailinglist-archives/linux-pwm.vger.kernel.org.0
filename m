Return-Path: <linux-pwm+bounces-7151-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4882B32FAB
	for <lists+linux-pwm@lfdr.de>; Sun, 24 Aug 2025 13:58:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A430189EFF0
	for <lists+linux-pwm@lfdr.de>; Sun, 24 Aug 2025 11:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C16328851C;
	Sun, 24 Aug 2025 11:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="IoeVFI0g"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE7019C556;
	Sun, 24 Aug 2025 11:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756036676; cv=none; b=R++GnKvLPiZZtKA7PIpDd8RohsCODeplYkYNdAujUqt9xa2mIGEF/mUO8YYTBR7gW849s1qP5OH/k1gSBPbGYpirlXkmgtWaEvNoBF/mECFuLJciVWMighuEpkUBwq2p8ysomMOSSaxJlGf4V+ebsp+1iof62RDIhXy3VZTSKpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756036676; c=relaxed/simple;
	bh=iDItYU14bs9Wkgtq5eO+wyJIVO4uvL+0QMi97/PWJWg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=lPJSu+RstcJZClzyzyXRhERABa2vxgm5GI7W+DSkzR1wd+yQbXIonAT9ix81BSZk+YHDxMVO7HhN7W0DQ8HKnWdMi+kAwHF3K1ZeGnE77jQoWMxoxb8j8NgxAA4efHhAStJFt1ll8JLYURV7NbgfLaFYfJoUh4KIhwsjYK1EvOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=IoeVFI0g; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id F33C2C8F1CD;
	Sun, 24 Aug 2025 11:57:31 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id BFCA3605F1;
	Sun, 24 Aug 2025 11:57:45 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 842C81C22D9B2;
	Sun, 24 Aug 2025 13:57:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1756036664; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=iyQr/0sKbu7Sx3T/Nik+QnNduCUCDzuhTyvELh4u87U=;
	b=IoeVFI0gadnQPs2I5GfxxdEu5l8Xhy8QKQaxWkKygFtyE+AGMdt/FXkHPjpanTDPsx1S03
	+pQoPMQZ9zgjtF6aU3UE5EVKdhEWnoHUqLrKQNvda0Ex/7KMuDW2Am3vDBct8Drg6hPUAv
	+C9u0noioD804987yw1r1CuERfG8oNp1uRdnaudQlHL2pkdjlcczB6RX5KHpmV+c2FuW2B
	jJUqBv0IQdvdyKOOeS7S3FBM9vAEvT3T+AzwI3ddJeUNreeGujcDS9PQg2zjeicwvD/SYN
	+2cSHGIV7kxf7eciBMcCc9PcY5kH+Hk0RTGmc7aipVglsfQ2S5BYDKBQLP+E4Q==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Subject: [PATCH v14 00/10] Add support for MAX7360
Date: Sun, 24 Aug 2025 13:57:19 +0200
Message-Id: <20250824-mdb-max7360-support-v14-0-435cfda2b1ea@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAB/+qmgC/33SyW7bMBAG4FcJdK6CWbjmlPcIcuAybATUliE5R
 orA714qQSGhonrkgPw4Q/6f3SzTIHP39PDZTXIb5mE81wWqHw9degvnn9IPuRY6AlJI6PtTjv0
 pfFg20M/vl8s4XXsiDi6J0jFwV09eJinDxxf78lrXb8N8HaffX7fccKn+37thD70Tx2i1W7Y9x
 3G8/hrOj2k8dYt4o41C3FaoKmyDy0SJjeS9wn8VDYgHClfFa/RRhRQhNnpRq0Ko2opaJgqsk8k
 xemP2il4VRtdWdFVKJIiheJsD7BWzKgoOXtdUxQbSrJ01wn6v2I1CB73YqigBAy5DsKXsFbcq+
 qgXV5UYRTlTTEzR7hW/UYjail8mUiUBa7SiGn+EsGEYDmIH1UnC0YuBoJ1rOLg6FvHAWfKbCmY
 RCjar1HBo4xyNhd8JVtYS1hgDNZxNhN1hP0uGxfqSQiyF3T/pu9/vfwCEa/N8CQQAAA==
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Kamel Bouhara <kamel.bouhara@bootlin.com>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Michael Walle <mwalle@kernel.org>, Mark Brown <broonie@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-input@vger.kernel.org, 
 linux-pwm@vger.kernel.org, andriy.shevchenko@intel.com, 
 =?utf-8?q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756036647; l=7257;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=iDItYU14bs9Wkgtq5eO+wyJIVO4uvL+0QMi97/PWJWg=;
 b=G85FJ7dKSjDsNbp4a9ZDcsiHexGUDZhzywd7TrLH42h43/mpn8DGf8L0C/S8VsGwsuEb3GxQh
 uyPQ0+N9Ec4AxJTGGpQR13xrEzj69TqHYSAFUx6Ns6n5Mh6Oid0p3yK
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-Last-TLS-Session-Version: TLSv1.3

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

Lee Jones suggested the whole series goes through MFD subsystem, once
all patches got the needed Acks.

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
Changes in v14:
- Rebased on v6.17-rc2.
- PWM: fixed max7360_pwm_round_waveform_tohw() return value on disabling.
- Link to v13: https://lore.kernel.org/r/20250811-mdb-max7360-support-v13-0-e79fcabff386@bootlin.com

Changes in v13:
- Rebased on v6.17-rc1.
- PWM: fixed max7360_pwm_round_waveform_tohw() return value on rounding.
- Link to v12: https://lore.kernel.org/r/20250722-mdb-max7360-support-v12-0-3747721a8d02@bootlin.com

Changes in v12:
- Rebased on v6.16-rc6.
- PWM: fixed rounding rules.
- PWM: added a link to the datasheet and fixed case in two error
  messages.
- Link to v11: https://lore.kernel.org/r/20250711-mdb-max7360-support-v11-0-cf1dee2a7d4c@bootlin.com

Changes in v11:
- Rebased on v6.16-rc5.
- Small fixes in keypad and rotary encoder input drivers: typos and off
  by one errors.
- Various fixes in PWM driver and PWM Kconfig.
- Link to v10: https://lore.kernel.org/r/20250530-mdb-max7360-support-v10-0-ce3b9e60a588@bootlin.com

Changes in v10:
- Rebased on v6.15
- Do not use devm_ functions to allocate regmap-irq in gpio-remap.c
- Link to v9: https://lore.kernel.org/r/20250522-mdb-max7360-support-v9-0-74fc03517e41@bootlin.com

Changes in v9:
- Fix build issue with bad usage of array_size() on intermediate commit.
- MFD: Fix error strings. Also fix #define style in the header file.
- Pinctrl: Fix missing include.
- PWM: Fix register writes in max7360_pwm_waveform() and
  max7360_pwm_round_waveform_tohw().
- GPIO: Fix GPIO valid mask initialization.
- Link to v8: https://lore.kernel.org/r/20250509-mdb-max7360-support-v8-0-bbe486f6bcb7@bootlin.com

Changes in v8:
- Small changes in drivers.
- Rebased on v6.15-rc5
- Link to v7: https://lore.kernel.org/r/20250428-mdb-max7360-support-v7-0-4e0608d0a7ff@bootlin.com

Changes in v7:
- Add rotary encoder absolute axis support in device tree bindings and
  driver.
- Lot of small changes in keypad, rotary encoder and GPIO drivers.
- Rebased on v6.15-rc4
- Link to v6: https://lore.kernel.org/r/20250409-mdb-max7360-support-v6-0-7a2535876e39@bootlin.com

Changes in v6:
- Rebased on v6.15-rc1.
- Use device_set_of_node_from_dev() instead of creating PWM and Pinctrl
  on parent device.
- Various small fixes in all drivers.
- Fix pins property pattern in pinctrl dt bindings.
- Link to v5: https://lore.kernel.org/r/20250318-mdb-max7360-support-v5-0-fb20baf97da0@bootlin.com

Changes in v5:
- Add pinctrl driver to replace the previous use of request()/free()
  callbacks for PORT pins.
- Dropping Reviewed-by tags on device-tree binding commit, because of
  modifications related to the previous point.
- Remove ngpios property from GPIO device tree bindings.
- Use GPIO valid_mask to mark unusable keypad columns GPOs, instead of
  changing ngpios.
- Drop patches adding support for request()/free() callbacks in GPIO
  regmap and gpio_regmap_get_ngpio().
- Allow gpio_regmap_register() to create the associated regmap IRQ.
- Various fixes in MFD, PWM, GPIO and KEYPAD drivers.
- Link to v4: https://lore.kernel.org/r/20250214-mdb-max7360-support-v4-0-8a35c6dbb966@bootlin.com

Changes in v4:
- Modified the GPIO driver to use gpio-regmap and regmap-irq.
- Add support for request()/free() callbacks in gpio-regmap.
- Add support for status_is_level in regmap-irq.
- Switched the PWM driver to waveform callbacks.
- Various small fixes in MFD, PWM, GPIO drivers and dt bindings.
- Rebased on v6.14-rc2.
- Link to v3: https://lore.kernel.org/r/20250113-mdb-max7360-support-v3-0-9519b4acb0b1@bootlin.com

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

Mathieu Dubois-Briand (8):
      dt-bindings: mfd: gpio: Add MAX7360
      pinctrl: Add MAX7360 pinctrl driver
      gpio: regmap: Allow to allocate regmap-irq device
      gpio: regmap: Allow to provide init_valid_mask callback
      gpio: max7360: Add MAX7360 gpio support
      input: keyboard: Add support for MAX7360 keypad
      input: misc: Add support for MAX7360 rotary
      MAINTAINERS: Add entry on MAX7360 driver

 .../bindings/gpio/maxim,max7360-gpio.yaml          |  83 ++++++
 .../devicetree/bindings/mfd/maxim,max7360.yaml     | 191 +++++++++++++
 MAINTAINERS                                        |  13 +
 drivers/gpio/Kconfig                               |  12 +
 drivers/gpio/Makefile                              |   1 +
 drivers/gpio/gpio-max7360.c                        | 257 +++++++++++++++++
 drivers/gpio/gpio-regmap.c                         |  30 +-
 drivers/input/keyboard/Kconfig                     |  12 +
 drivers/input/keyboard/Makefile                    |   1 +
 drivers/input/keyboard/max7360-keypad.c            | 308 +++++++++++++++++++++
 drivers/input/misc/Kconfig                         |  10 +
 drivers/input/misc/Makefile                        |   1 +
 drivers/input/misc/max7360-rotary.c                | 192 +++++++++++++
 drivers/mfd/Kconfig                                |  14 +
 drivers/mfd/Makefile                               |   1 +
 drivers/mfd/max7360.c                              | 171 ++++++++++++
 drivers/pinctrl/Kconfig                            |  11 +
 drivers/pinctrl/Makefile                           |   1 +
 drivers/pinctrl/pinctrl-max7360.c                  | 215 ++++++++++++++
 drivers/pwm/Kconfig                                |  10 +
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/pwm-max7360.c                          | 209 ++++++++++++++
 include/linux/gpio/regmap.h                        |  18 ++
 include/linux/mfd/max7360.h                        | 109 ++++++++
 24 files changed, 1869 insertions(+), 2 deletions(-)
---
base-commit: c17b750b3ad9f45f2b6f7e6f7f4679844244f0b9
change-id: 20241219-mdb-max7360-support-223a8ce45ba3

Best regards,
-- 
Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>


