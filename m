Return-Path: <linux-pwm+bounces-6861-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC425B0E1A4
	for <lists+linux-pwm@lfdr.de>; Tue, 22 Jul 2025 18:24:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFC7E1888E9F
	for <lists+linux-pwm@lfdr.de>; Tue, 22 Jul 2025 16:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAFF227AC44;
	Tue, 22 Jul 2025 16:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="SVZmiIAQ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6479927A46F;
	Tue, 22 Jul 2025 16:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753201447; cv=none; b=KGYzS+wZo1KUwKhPhTSwU5UrZuhvyJnDxMHohnORo5jYHCfhMEqBWv3++0Tg5OSgkrUVFnjg6Jogc9Rdm7BjaIUD/tDT2D95fylG+g9WSx7L8mT8g1md7Hacuz51Gy89Xst3TKkVkaK/Pu/43B1wmLaUsfb3+lRAqg2eM6VZTWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753201447; c=relaxed/simple;
	bh=6+QKmtXatEDMJmwweO5PBDyYQYZx7SbN1S02PCNHlT8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=pWZadNxrK7dMSo5R5UfttdaP3pSVbw1Av298nl7mN9Y/Saw/VSr8p8HXkw8bVqfwe0f4ecgKHMVyTcDFYOdJ7AB9Eeu8hViKfNnBksb4w5IJOxr1UltLS128Wjrd+55MKgBGSdoLMq+OUFt62mm4pxKXrggVv9KV+TWWNSw/ZvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=SVZmiIAQ; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id BA0E243EB5;
	Tue, 22 Jul 2025 16:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1753201442;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3S6rrfxuXZPbHMowkoW0rGpZN3lOeigWd6+vovDesCg=;
	b=SVZmiIAQGutd9g5fnU18ktE4SZ84M8G3Sjfx/h5nRFScxMMdu6szuPH/unKjsyrF79I2ch
	AymMPcQ2FvbR2C1vRHPEdfPxEX+sVVySuDzlswOgOY4f9nGQv6/JOjeyJ72X8YBjXHuu3t
	Rl7ErC48YG9SAaSnlDNRFcFUsuj67Gtkt52zfG0A9Z/6OJsS0n6Og2e0UdMQ4p8W4XUbC3
	zT+C2BS875uXI7ony1S2Ng7cap2UZ3VOlbiOZWtLNa7S96lRKKawrD34ixs4zgPQQVcxpr
	d3HrjQa/G6gbPjCasK8h4WUT/HcqxE3TFsg/IJ/cOLR9l2uZr9sl7A3ep2QTqA==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Subject: [PATCH v12 00/10] Add support for MAX7360
Date: Tue, 22 Jul 2025 18:23:44 +0200
Message-Id: <20250722-mdb-max7360-support-v12-0-3747721a8d02@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABC7f2gC/33SyWrDQAwA0F8JPtdFy6w99T9KD7PIjaGJg52al
 JB/7zhQnGK7R4mZN5JG12qQvpWhetldq17Gdmi7YwmQnnZV2ofjh9RtLomKgBQS+vqQY30IF8s
 G6uHrdOr6c03EwSVROgauys1TL017ubNv7yXet8O567/vr4w4Zf/3RqyhduIYrXbTsdfYdefP9
 vicukM1iSM9KMTrChWFbXCZKLGRvFT4V9GAuKFwUbxGH1VIEeJKLWpWCNW6oqaOAutkcozemKW
 iZ4XRrSu6KE0kiKHxNgdYKmZWFGxM1xTFBtKsnTXCfqnYB4U2arFFUQIGXIZgm2apuFnRW7W4o
 sQoypnGxBTtUvEPCtG64qeOVJOANVpRK3+E8MAwbKwdFCcJRy8GgnZuxcHZsYgbzrS/qcEsQsF
 mlf46t9vtB0G4gAF5AwAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753201440; l=6816;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=6+QKmtXatEDMJmwweO5PBDyYQYZx7SbN1S02PCNHlT8=;
 b=bU2Bj3F6T+mJcs/O+7v2rxetsdZMFNziPU2gd+nlmkTTwg14bjU8X4T0vgphVvIJhNYwU9ZAH
 f9WWqf3jrIEBnGhTonlaxLZXh9iwDnIqwg7lOD2dudIZYC1egpCyCkF
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejheefiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffufffkgggtgffvvefosehtjeertdertdejnecuhfhrohhmpeforghthhhivghuucffuhgsohhishdquehrihgrnhguuceomhgrthhhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhephfekffeugedvkeeihfefjeeuueekkeeggeejgeehgfdvkeevvedvkeeiteekleevnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpudegqdhrtgdvrddqlhhinhhknecukfhppedvrgdtudemtggsudegmeehheeimeejrgdttdemfehftghfmehfsgdtugemuddviedvmedvvgejieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudegmeehheeimeejrgdttdemfehftghfmehfsgdtugemuddviedvmedvvgejiedphhgvlhhopegluddvjedrtddruddrudgnpdhmrghilhhfrhhomhepmhgrthhhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvdeipdhrtghpthhtoheplhhinhhushdrfigrlhhlvghijheslhhinhgrrhhordhorhhgpdhrtghpthhtohepmhifrghll
 hgvsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrnhgurhhihidrshhhvghvtghhvghnkhhosehinhhtvghlrdgtohhmpdhrtghpthhtoheprhgrfhgrvghlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhiikhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegsrghrthhoshiirdhgohhlrghsiigvfihskhhisehlihhnrghrohdrohhrghdprhgtphhtthhopehlihhnuhigqdhpfihmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghonhhorhdoughtsehkvghrnhgvlhdrohhrgh
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

Lee Jones suggested the whole series goes through MFD subsystem, once
all patches got the needed Acks.

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
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
 drivers/pwm/pwm-max7360.c                          | 206 ++++++++++++++
 include/linux/gpio/regmap.h                        |  18 ++
 include/linux/mfd/max7360.h                        | 109 ++++++++
 24 files changed, 1866 insertions(+), 2 deletions(-)
---
base-commit: 347e9f5043c89695b01e66b3ed111755afcf1911
change-id: 20241219-mdb-max7360-support-223a8ce45ba3

Best regards,
-- 
Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>


