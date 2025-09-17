Return-Path: <linux-pwm+bounces-7330-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 289B2B7E6A9
	for <lists+linux-pwm@lfdr.de>; Wed, 17 Sep 2025 14:48:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26C7317FD66
	for <lists+linux-pwm@lfdr.de>; Wed, 17 Sep 2025 10:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B6B34AAF1;
	Wed, 17 Sep 2025 10:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iCHIiTS5"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4330264A72;
	Wed, 17 Sep 2025 10:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758104185; cv=none; b=A+JnwucrbnUjCTnj/1w6HXkYXF3RZ5GFrAHNmQNg9hIk2/5srzEobj9FlhKbD6J6CG0MRLNvtCK/FPeCRHx4Kap/9OBYLN9H7Gcw3SMkpfhdZDYTfBRS+0rkCqbVRMP8mqw812xaBH6Sc2scodgpkOY0TDD4ZOrpWkSwbp5R2TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758104185; c=relaxed/simple;
	bh=ambwCGac4A+Wl1cpfcxdw276sosjbIvttwf0nQ4WwSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cYYpFqGmww9w6f6x8+ergDQwjueFP8eYCqHBlJgd25Rv3G8HghBks5G8emLthbs0oMIYZdJxOZTz79ywjjWRnSQQuCBwug5FkhaocYjhHfrL0Fz9vNBbwVZpUoyEFiEU/r8BVJc9Y0hODdRkXai7knQ9fHkBAN6lnV8ggkDc1mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iCHIiTS5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7C43C4CEF0;
	Wed, 17 Sep 2025 10:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758104185;
	bh=ambwCGac4A+Wl1cpfcxdw276sosjbIvttwf0nQ4WwSQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iCHIiTS5S7WjpNatZpUtiukDA24Vv/tY/DJRflBgUWWJTErqrXNp3Nn3kErGKvP2n
	 mCS9pwMSp7FxkunDQ9SzVJr5lodt/TVG/2+GT6c2qe+nZR2TDuxXz2sP/IE0j1Evlr
	 PjuXwXHBs3aVNDuvfSqUAsYZ3rfCYm8Adx+twqZuh4pDlHm6tX0SsDnvV1ehM7i/EX
	 9SNV/B5cKpgWhiTfLbutW28xMCIEyOpZ1PWqcHNq3zAZ8IdSZj/RMomQyGrdIcl30/
	 77dja6K58Mko0nfezrwfNbcLs8foBuId5yMnSyWWfnwlyKKzga+9Ds3FEeWcN+stfM
	 Eckm0vLKBvZaQ==
Date: Wed, 17 Sep 2025 11:16:17 +0100
From: Lee Jones <lee@kernel.org>
To: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kamel Bouhara <kamel.bouhara@bootlin.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Michael Walle <mwalle@kernel.org>, Mark Brown <broonie@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-input@vger.kernel.org, linux-pwm@vger.kernel.org,
	andriy.shevchenko@intel.com,
	=?iso-8859-1?Q?Gr=E9gory?= Clement <gregory.clement@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [GIT PULL] Immutable branch between MFD, GPIO, Input, Pinctrl and
 PWM due for the v6.18 merge window 
Message-ID: <20250917101617.GI3893363@google.com>
References: <20250824-mdb-max7360-support-v14-0-435cfda2b1ea@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250824-mdb-max7360-support-v14-0-435cfda2b1ea@bootlin.com>

Enjoy!

The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585:

  Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd-gpio-input-pinctrl-pwm-v6.18

for you to fetch changes up to 32d4cedd24ed346edbe063323ed495d685e033df:

  MAINTAINERS: Add entry on MAX7360 driver (2025-09-16 15:24:48 +0100)

----------------------------------------------------------------
Immutable branch between MFD, GPIO, Input, Pinctrl and PWM due for the v6.18 merge window

----------------------------------------------------------------
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
 create mode 100644 Documentation/devicetree/bindings/gpio/maxim,max7360-gpio.yaml
 create mode 100644 Documentation/devicetree/bindings/mfd/maxim,max7360.yaml
 create mode 100644 drivers/gpio/gpio-max7360.c
 create mode 100644 drivers/input/keyboard/max7360-keypad.c
 create mode 100644 drivers/input/misc/max7360-rotary.c
 create mode 100644 drivers/mfd/max7360.c
 create mode 100644 drivers/pinctrl/pinctrl-max7360.c
 create mode 100644 drivers/pwm/pwm-max7360.c
 create mode 100644 include/linux/mfd/max7360.h

-- 
Lee Jones [李琼斯]

