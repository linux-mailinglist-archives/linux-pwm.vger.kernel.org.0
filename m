Return-Path: <linux-pwm+bounces-4885-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D775CA35CF4
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Feb 2025 12:52:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED62518919D6
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Feb 2025 11:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A302263C82;
	Fri, 14 Feb 2025 11:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="QPic+FVV"
X-Original-To: linux-pwm@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E292221541;
	Fri, 14 Feb 2025 11:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739533820; cv=none; b=mfcCaJhuYpYRHrTkdvJVBrRwLP2jyoy4KMjU4mqfpr0zmBGwUNi/KAVoSlcH/lmwx7QJM1cxeK3226IDHTtWSYEb4MaDqAOWW8nIYlfXIO6LWtPx4ic5zajYxOjEy2OcagwzGr+C/de0yfdQZP31IPY0BG+wXj0wTNJt4x0V3wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739533820; c=relaxed/simple;
	bh=vF7KdmZH5zqFtRD2vuQTeuspsVDvQTjB8d+Y4ciyRFo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=s87GNOKBnKoUAzVXMkZNg9sRg+HOdjhd5BgNspaflusIer6jRJStfRl+hsEJkVEHKfS1dlNVVftH6Q10x9sL+0lGX0crsbViXvEbg2sKLN7M9WrSzEqKr0pbt4bAKh6Nuo2HkbsH49dBzisplq6WjqtYsN4Rsy4+n8rVWt0O5sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=QPic+FVV; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 023C2442A3;
	Fri, 14 Feb 2025 11:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1739533810;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=j07hPNU31IwHz1MTcTOgeAg+tNcqpIash75EC8z/CHk=;
	b=QPic+FVV5piEk8dkiz7t9Mazjk+U8XvU6JhSf2TRidfE2fB/1cCvEo2e+fJDefk9U6D0Ax
	lqUaEiG6Q3GF84hUjWMcYy+XoIm4ZXAcm73Edj3QpmpnGC+z1myy6GpMeaQPUNXC5KJswa
	GeLIlQyfwtmmtj2Epmziohrcp4wI7WKHftB2OC4+e3ISjDUgFvzNuP4aHdUtm2eQk5Byqj
	n4BRtbyhL6K0/FPFeAi1f+YmYqdt9tVwsb/+VOtFNeCbneR0MyiH3Pl06l2AcddF5Q3AkK
	GYO022oO+75kPRw67OXxKZcXCBgpgcQ96O14VzRLBtR+tDRKh8kMO04AeQcOmQ==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Subject: [PATCH v4 00/10] Add support for MAX7360
Date: Fri, 14 Feb 2025 12:49:50 +0100
Message-Id: <20250214-mdb-max7360-support-v4-0-8a35c6dbb966@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAN4tr2cC/33OTQ6CMBAF4KuYrq1pZygUV97DuGhLlSZCSYsEQ
 7i7hcTE+Ld8k3nfzESiDc5Gst9MJNjBRefbFLLthphatRdLXZUyAQYZB17SptK0UWOBOaPx1nU
 +9BQAlTQ2E1ohSc0u2LMbV/V4Srl2sffhvh4Z+DL97w2cMiqtRF4IuawdtPf91bU74xuyiAO8K
 IDfFUgKFkpWAAZzW30q+FQE4/yHgkkpBS91poxm+u2XeZ4fEDIF70QBAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739533806; l=3966;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=vF7KdmZH5zqFtRD2vuQTeuspsVDvQTjB8d+Y4ciyRFo=;
 b=nalo6LQVrcVi6TAQQteq3ondrkR6920KTYGAX58OdoLnGbnugFDBc/qFXP9dJrIUtCmdt+8Qh
 +1ecjLGGKGmDWHoEiGULZP77LuNhg4fP8RmK3ZTL7BItzrShPEHhoeF
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegleehjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffufffkgggtgffvvefosehtjeertdertdejnecuhfhrohhmpeforghthhhivghuucffuhgsohhishdquehrihgrnhguuceomhgrthhhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnheptdeujeelieelffeufedvgfffgfegvdehvddukeehledvkeettdelvdelfeffteevnecuffhomhgrihhnpedugedqrhgtvddrqdhlihhnkhdpkhgvrhhnvghlrdhorhhgnecukfhppedvrgdtudemtggsudegmeehheeimeejrgdttdemfehftghfmehfsgdtugemuddviedvmedvvgejieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudegmeehheeimeejrgdttdemfehftghfmehfsgdtugemuddviedvmedvvgejiedphhgvlhhopegluddvjedrtddruddrudgnpdhmrghilhhfrhhomhepmhgrthhhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvdefpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepm
 hgrthhhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrtghomhdprhgtphhtthhopehrrghfrggvlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhrvghgohhrhidrtghlvghmvghnthessghoohhtlhhinhdrtghomhdprhgtphhtthhopegurghkrheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhhohhmrghsrdhpvghtrgiiiihonhhisegsohhothhlihhnrdgtohhmpdhrtghpthhtohepsghrghhlsegsghguvghvrdhplhdprhgtphhtthhopehlihhnuhigqdhgphhiohesvhhgvghrrdhkvghrnhgvlhdrohhrgh
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
      gpio: regmap: Allow to provide request and free callbacks
      gpio: regmap: Allow to retrieve ngpio
      regmap: irq: Add support for chips without separate IRQ status
      gpio: max7360: Add MAX7360 gpio support
      input: keyboard: Add support for MAX7360 keypad
      input: misc: Add support for MAX7360 rotary
      MAINTAINERS: Add entry on MAX7360 driver

 .../bindings/gpio/maxim,max7360-gpio.yaml          |  91 +++++++
 .../devicetree/bindings/mfd/maxim,max7360.yaml     | 139 ++++++++++
 MAINTAINERS                                        |  12 +
 drivers/base/regmap/regmap-irq.c                   |  83 ++++--
 drivers/gpio/Kconfig                               |  11 +
 drivers/gpio/Makefile                              |   1 +
 drivers/gpio/gpio-max7360.c                        | 253 ++++++++++++++++++
 drivers/gpio/gpio-regmap.c                         |   8 +
 drivers/input/keyboard/Kconfig                     |  12 +
 drivers/input/keyboard/Makefile                    |   1 +
 drivers/input/keyboard/max7360-keypad.c            | 282 +++++++++++++++++++++
 drivers/input/misc/Kconfig                         |  11 +
 drivers/input/misc/Makefile                        |   1 +
 drivers/input/misc/max7360-rotary.c                | 182 +++++++++++++
 drivers/mfd/Kconfig                                |  14 +
 drivers/mfd/Makefile                               |   1 +
 drivers/mfd/max7360.c                              | 218 ++++++++++++++++
 drivers/pwm/Kconfig                                |  10 +
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/pwm-max7360.c                          | 213 ++++++++++++++++
 include/linux/gpio/regmap.h                        |  10 +
 include/linux/mfd/max7360.h                        | 112 ++++++++
 include/linux/regmap.h                             |   3 +
 23 files changed, 1649 insertions(+), 20 deletions(-)
---
base-commit: a64dcfb451e254085a7daee5fe51bf22959d52d3
change-id: 20241219-mdb-max7360-support-223a8ce45ba3

Best regards,
-- 
Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>


