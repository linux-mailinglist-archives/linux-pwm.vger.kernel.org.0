Return-Path: <linux-pwm+bounces-6075-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DAB6AC0B1B
	for <lists+linux-pwm@lfdr.de>; Thu, 22 May 2025 14:06:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E0D93B0120
	for <lists+linux-pwm@lfdr.de>; Thu, 22 May 2025 12:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0010328A700;
	Thu, 22 May 2025 12:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="RulxBa0V"
X-Original-To: linux-pwm@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F00433DB;
	Thu, 22 May 2025 12:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747915608; cv=none; b=DPIkNYJGsyN43Eh/XLp0zYjj76nhFgWgFdztTX/DpVbrer9pVEzNSEzNr2VHDjsO2cfGypHHSCuFbdFnGUmSgJ6WUW6dZ3UWjy5qXq0K6qtGMj6jZKKGqlNxOf5tsX54mU+IzsJqnGH0EcvQAwWjzg+mgZLwOs+o115m0Mnxqkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747915608; c=relaxed/simple;
	bh=sarlfpjmwco1wBVRTTBDateodZuUqAOn115Z368wacc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Vk+N3klDSzCUR4eA8brmEmE72mm6WEBTOnRho8dJzUmsFHyf5D1c/UIuA7J4k9U2m4S6VfyksfC8shQnn66mJDyoslVNdQ/kDVnP8vW3ySNOYX1/aMfHX6uH8FTEIS8UX9OZeuW0I+q007hhL0nVS56/YZ1vWOwKGCYxy3jtIxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=RulxBa0V; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id F37851FD48;
	Thu, 22 May 2025 12:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1747915603;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xa4FngajQSj/KFbgvgvpRtuRSkbY6yfLKj4dHrHeIRM=;
	b=RulxBa0Vyjqc+owdBmdIBHviKcMau7F2yIpvEe6hhlPszwIbm9rs2atFMOyI/Z1w6knrTT
	QnLHZ8NvzZhkPqmFHAJof6vnsbyrTnMTsqdSW0mDhf8X9Ol9oG2Mh97j2i+/nOrwexPyfa
	9fiLgK4mbkutselTmId4z6TE9F9X2CHh5a0Qo7GRS/ddTgc2AULQyCKY+CzNHk46MueVPy
	VkVcAPLTdyTS+EyMoABElqhUgVq5x/iT8uhXKWsvpF4SaUeLLMm1d/iEpIX02D9EWfbefi
	qrd6TfagA74EXjlUsFTNSHgshVBPncGkUkzlstP42PqxkDLF95k1PvKiZoEGCA==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Subject: [PATCH v9 00/11] Add support for MAX7360
Date: Thu, 22 May 2025 14:06:15 +0200
Message-Id: <20250522-mdb-max7360-support-v9-0-74fc03517e41@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADcTL2gC/33QTW7DIBAF4KtErEsFM/x21XtUXTCAG6Q6juzUS
 hX57sWRKqey3eVD8M0bbmzIfckDezncWJ/HMpTuVIN/OrB4DKePzEuqmYEAJUF63ibibbhaNII
 PX+dz1184AAYXs9IUkNWX5z435XpX395rPpbh0vXf9yGjnE//90bJBXfZobTazddeqesun+X0H
 LuWzeIIDwrgtgJVQRtcAohoclor+KtoIeWOglXxWnpSIZKgjS5qUUCqbUXNGwXU0SQib8xa0Yu
 C0m0ruioNgaDQeJuCWCtmUZTY+V1TFRtAo3bWZPRrxT4osNPFVkVlYYRLItimWStuUfReF1cVo
 qycaQxFsn+VaZp+AGU3+qeiAgAA
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
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1747915601; l=6039;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=sarlfpjmwco1wBVRTTBDateodZuUqAOn115Z368wacc=;
 b=qHEGL0EaoRkPoiIasJEM9p1K3SVTVHGOE6/CuwcQq2BqVIDWYmzjyY/UlcZXEy9RiY/uc6jb3
 a4i5t1gZsHLDZQcq9bV0Hb5Yb6ViNKvkepfeAdKcqsRNxPJeJzVPrIV
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdehleduucdltddurdegfedvrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhufffkfggtgfgvfevofesthejredtredtjeenucfhrhhomhepofgrthhhihgvuhcuffhusghoihhsqdeurhhirghnugcuoehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpefhkeffueegvdekiefhfeejueeukeekgeegjeeghefgvdekveevvdekieetkeelveenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpddugedqrhgtvddrqdhlihhnkhenucfkphepvdgrtddumegtsgdugeemheehieemjegrtddtmeeffhgtfhemfhgstdgumeduvdeivdemvdgvjeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgdugeemheehieemjegrtddtmeeffhgtfhemfhgstdgumeduvdeivdemvdgvjeeipdhhvghloheplgduvdejrddtrddurddungdpmhgrihhlfhhrohhmpehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvhedprhgtphhtthhopegurghkrheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhin
 hhushdrfigrlhhlvghijheslhhinhgrrhhordhorhhgpdhrtghpthhtohepsghrohhonhhivgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghnughrihihrdhshhgvvhgthhgvnhhkoheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmpdhrtghpthhtohepthhhohhmrghsrdhpvghtrgiiiihonhhisegsohhothhlihhnrdgtohhmpdhrtghpthhtohepsghrghhlsegsghguvghvrdhplhdprhgtphhtthhopegumhhithhrhidrthhorhhokhhhohhvsehgmhgrihhlrdgtohhm
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

Mathieu Dubois-Briand (9):
      dt-bindings: mfd: gpio: Add MAX7360
      pinctrl: Add MAX7360 pinctrl driver
      regmap: irq: Add support for chips without separate IRQ status
      gpio: regmap: Allow to allocate regmap-irq device
      gpio: regmap: Allow to provide init_valid_mask callback
      gpio: max7360: Add MAX7360 gpio support
      input: keyboard: Add support for MAX7360 keypad
      input: misc: Add support for MAX7360 rotary
      MAINTAINERS: Add entry on MAX7360 driver

 .../bindings/gpio/maxim,max7360-gpio.yaml          |  83 ++++++
 .../devicetree/bindings/mfd/maxim,max7360.yaml     | 191 +++++++++++++
 MAINTAINERS                                        |  13 +
 drivers/base/regmap/regmap-irq.c                   |  99 ++++---
 drivers/gpio/Kconfig                               |  12 +
 drivers/gpio/Makefile                              |   1 +
 drivers/gpio/gpio-max7360.c                        | 257 +++++++++++++++++
 drivers/gpio/gpio-regmap.c                         |  22 +-
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
 drivers/pwm/pwm-max7360.c                          | 180 ++++++++++++
 include/linux/gpio/regmap.h                        |  18 ++
 include/linux/mfd/max7360.h                        | 109 ++++++++
 include/linux/regmap.h                             |   3 +
 26 files changed, 1903 insertions(+), 33 deletions(-)
---
base-commit: 92a09c47464d040866cf2b4cd052bc60555185fb
change-id: 20241219-mdb-max7360-support-223a8ce45ba3

Best regards,
-- 
Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>


