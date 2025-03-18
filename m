Return-Path: <linux-pwm+bounces-5219-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B71CCA6797A
	for <lists+linux-pwm@lfdr.de>; Tue, 18 Mar 2025 17:31:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 739A0189C5A3
	for <lists+linux-pwm@lfdr.de>; Tue, 18 Mar 2025 16:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B51F620E715;
	Tue, 18 Mar 2025 16:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="R+LAmh/v"
X-Original-To: linux-pwm@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1AEE20ADF4;
	Tue, 18 Mar 2025 16:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742315211; cv=none; b=BtnaF/WYqdMAmCXw69ZMCwS5WQH9iFhGsPXckEPGOC6rNMoArmtuALOktP59D4wpXL2vjH6Brmt+TuuoKqmEzFYSQuC9qWp+xkaAQ5QdBysd5XXOsEQ7Gdf1AwZdP22Jtl4llJ4cDJK9xUI7Ge359vn8A3HWSCUlAYpJ0TTbc/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742315211; c=relaxed/simple;
	bh=q/AieX/7kB6mSPgXM4t5kwiuJs/qADs3hg/ldWRzCgM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=jCfWrLqxdA3L+5mVlr18UFP1SobHBHSLOHW4BVnnH8jOoTOWRU4R+mgf4JMgPqdJy+5JsBx62gRgkptAP6XhwBNnahTbXLT3lr14jmIcAivc3HiYLGCBFC+TwJaH+TEnmqZbRcDoB54jKboLzhMSZrDOsAk97waLPzhC/tYRg/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=R+LAmh/v; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id EB393442B9;
	Tue, 18 Mar 2025 16:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1742315206;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=45zCDv9E6VLY+ONuZj3J5CDqCgWno6ibgDXhT+Cl9eI=;
	b=R+LAmh/v8E+5i3BY2GRajMbhJhhSDFW8V3zbcf7YZm06BGoTv89xo2y5CLBSXaHRI3v66f
	9NG6QBkDU1vwAdnJdHYzQDvKsRqrUzdN+jAFWKMpJbXReSon97vTFKfZihTpWHMFICeJNv
	lBD3JGIr6CdETssDrbcrRU8fa0fEXLmY3D8JlP1x9ntQCH80J4CGQX0dmM3+gK1Jswmz12
	jLJN/It6JHuMCliPfJ06kBizDlFTXly2+SqhqmUHJQAIbzMrBhpNB0vHthEtGvovgu+6eS
	M8J3UNjZijIERub2Lx4skS1PeKO1A/cgwHVrrAJ9F6GaHOu+bGspZaryYk/RJw==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Subject: [PATCH v5 00/11] Add support for MAX7360
Date: Tue, 18 Mar 2025 17:26:16 +0100
Message-Id: <20250318-mdb-max7360-support-v5-0-fb20baf97da0@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKme2WcC/33PzU7DMAwH8FeZciYotpM03Yn3mHbIFywSbaqkV
 ENT3510EgJE4fi37J/tG6uxpFjZ8XBjJS6ppjy2oB4OzF/s+BJ5Ci0zFCgBoedDcHyw14604PV
 tmnKZOSJZ46NUzhJrk1OJz+l6V0/nli+pzrm835cssFX/9xbggptoCDpltrYnl/P8msZHnwe2i
 Qt+U5D2FWwKddYERE86ht8KfSpKAPyhUFN6Bb2T1jvhdm6RXwqC3Ffk9pEl5XVwrtf6p7Ku6we
 bq97JigEAAA==
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
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742315204; l=4823;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=q/AieX/7kB6mSPgXM4t5kwiuJs/qADs3hg/ldWRzCgM=;
 b=4orGU7PiaImPJMi7UseFvHChJHUf8hlu/tVPn1XHwRMcQHEOWBXpdXY5NlVDFNBelAK8YhRex
 RGsB/RmOgcxCiOCly8mxM6JxTv5sIaYhp3YSk2mba1SdLETrNaogjEK
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugedvledvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhufffkfggtgfgvfevofesthejredtredtjeenucfhrhhomhepofgrthhhihgvuhcuffhusghoihhsqdeurhhirghnugcuoehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpefhkeffueegvdekiefhfeejueeukeekgeegjeeghefgvdekveevvdekieetkeelveenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpddugedqrhgtvddrqdhlihhnkhenucfkphepvdgrtddumegtsgdugeemheehieemjegrtddtmeeffhgtfhemfhgstdgumeduvdeivdemvdgvjeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgdugeemheehieemjegrtddtmeeffhgtfhemfhgstdgumeduvdeivdemvdgvjeeipdhhvghloheplgduvdejrddtrddurddungdpmhgrihhlfhhrohhmpehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvfedprhgtphhtthhopehlihhnuhigqdhinhhpuhhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepu
 ggrkhhrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehrrghfrggvlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgrthhhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrtghomhdprhgtphhtthhopehukhhlvghinhgvkheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrmhgvlhdrsghouhhhrghrrgessghoohhtlhhinhdrtghomhdprhgtphhtthhopehgrhgvghhkhheslhhinhhugihfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehmfigrlhhlvgeskhgvrhhnvghlrdhorhhg
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

 .../bindings/gpio/maxim,max7360-gpio.yaml          |  83 +++++++
 .../devicetree/bindings/mfd/maxim,max7360.yaml     | 170 +++++++++++++
 MAINTAINERS                                        |  13 +
 drivers/base/regmap/regmap-irq.c                   |  97 +++++---
 drivers/gpio/Kconfig                               |  12 +
 drivers/gpio/Makefile                              |   1 +
 drivers/gpio/gpio-max7360.c                        | 246 +++++++++++++++++++
 drivers/gpio/gpio-regmap.c                         |  26 +-
 drivers/input/keyboard/Kconfig                     |  12 +
 drivers/input/keyboard/Makefile                    |   1 +
 drivers/input/keyboard/max7360-keypad.c            | 264 +++++++++++++++++++++
 drivers/input/misc/Kconfig                         |  11 +
 drivers/input/misc/Makefile                        |   1 +
 drivers/input/misc/max7360-rotary.c                | 161 +++++++++++++
 drivers/mfd/Kconfig                                |  14 ++
 drivers/mfd/Makefile                               |   1 +
 drivers/mfd/max7360.c                              | 185 +++++++++++++++
 drivers/pinctrl/Kconfig                            |  11 +
 drivers/pinctrl/Makefile                           |   1 +
 drivers/pinctrl/pinctrl-max7360.c                  | 195 +++++++++++++++
 drivers/pwm/Kconfig                                |  11 +
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/pwm-max7360.c                          | 194 +++++++++++++++
 include/linux/gpio/regmap.h                        |  22 ++
 include/linux/mfd/max7360.h                        | 112 +++++++++
 include/linux/regmap.h                             |   3 +
 26 files changed, 1813 insertions(+), 35 deletions(-)
---
base-commit: a64dcfb451e254085a7daee5fe51bf22959d52d3
change-id: 20241219-mdb-max7360-support-223a8ce45ba3

Best regards,
-- 
Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>


