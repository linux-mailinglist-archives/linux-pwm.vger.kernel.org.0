Return-Path: <linux-pwm+bounces-7326-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1E95B59A8E
	for <lists+linux-pwm@lfdr.de>; Tue, 16 Sep 2025 16:42:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10E8617441E
	for <lists+linux-pwm@lfdr.de>; Tue, 16 Sep 2025 14:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CA8031D75D;
	Tue, 16 Sep 2025 14:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qfJbw1SS"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2B22C15AA;
	Tue, 16 Sep 2025 14:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758033296; cv=none; b=TkyuWRiXFeCMKG3+L/An3oipx5GZubALENQVJCMP3ButdZ+IoRO2XAyPCPrcleL5G+/z85r+zv5VbukKhJkcVjxFGA1K8lw4mkeX4ju2q3K1cCRZSA7kNL0I6ebFDU8WfGnKfedq+kBVvCTKIrFX/GzFM3eO4BAE6vVxGgi8QiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758033296; c=relaxed/simple;
	bh=E7bATN9G95lxsMIscr5CR3AgS3iZbRXC94zT1FqKkco=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=cdSqpyZ/ke+Hle6g+LnsNQblAo+gsSR/wGgX3MmLXOByEALgHeR9gOyvnoXMtIlMKIbYq0J+dLrenuYrqHf8eG/TyVXjr2dSUZE7ZTTcxqEP+o1QBQglf4fZAgvyFxYROMS4l97gl8BMR0rCAadVVgreUDNKW5Cz20vrpbM8Jkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qfJbw1SS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBF7DC4CEFB;
	Tue, 16 Sep 2025 14:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758033295;
	bh=E7bATN9G95lxsMIscr5CR3AgS3iZbRXC94zT1FqKkco=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=qfJbw1SSMhRTOFhtklfkqYwNyMsVkgO6RLUbzmCqhU/+Grz6ndApZd9GoR0LsfXJT
	 HNLudIegbN10afHnwlUEjXXlvIvL7E8BBpiG2S29qzKn5d6ApfJHGX0KNQcu7nCWy0
	 fMpgPProKpcrkkcntG999fMxCHMd2ad4nWhMLB4GQCcTo+62WR+euBuO/R1BcRM8+o
	 3UbLylFWMO8XzXVbBwdYXhHFlMjU5DAiKFKEp20rC2IA51//+ANJrYC5ji7lKQadHZ
	 ZUUL06RU1ZH5Z+o0Hfp0lMRiC9F4sIxPFr1Y5tQldI4Clb2kGgBlJCwQGUICjLIlKY
	 dBrL7T1T8764g==
From: Lee Jones <lee@kernel.org>
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
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-input@vger.kernel.org, 
 linux-pwm@vger.kernel.org, andriy.shevchenko@intel.com, 
 =?utf-8?q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
In-Reply-To: <20250824-mdb-max7360-support-v14-0-435cfda2b1ea@bootlin.com>
References: <20250824-mdb-max7360-support-v14-0-435cfda2b1ea@bootlin.com>
Subject: Re: [PATCH v14 00/10] Add support for MAX7360
Message-Id: <175803329065.3832522.18087850599111439891.b4-ty@kernel.org>
Date: Tue, 16 Sep 2025 15:34:50 +0100
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-c81fc

On Sun, 24 Aug 2025 13:57:19 +0200, Mathieu Dubois-Briand wrote:
> This series implements a set of drivers allowing to support the Maxim
> Integrated MAX7360 device.
> 
> The MAX7360 is an I2C key-switch and led controller, with following
> functionalities:
> - Keypad controller for a key matrix of up to 8 rows and 8 columns.
> - Rotary encoder support, for a single rotary encoder.
> - Up to 8 PWM outputs.
> - Up to 8 GPIOs with support for interrupts and 6 GPOs.
> 
> [...]

Applied, thanks!

[01/10] dt-bindings: mfd: gpio: Add MAX7360
        commit: aee814458fb98819876442f0261fad0bb9842224
[02/10] mfd: Add max7360 support
        commit: a22ddeef55c4df847d9ac862b6192da774948fe1
[03/10] pinctrl: Add MAX7360 pinctrl driver
        commit: b4b993c0e39436ffb3a9b21cabf62b5df085b2e1
[04/10] pwm: max7360: Add MAX7360 PWM support
        commit: d93a75d94b79ba3e664f7236ee05790e8b1d0e4b
[05/10] gpio: regmap: Allow to allocate regmap-irq device
        commit: 553b75d4bfe9264f631d459fe9996744e0672b0e
[06/10] gpio: regmap: Allow to provide init_valid_mask callback
        commit: 0627b71fa5508ab605b6e9fd74baed40805cfdda
[07/10] gpio: max7360: Add MAX7360 gpio support
        commit: b1a7433d857edb14b993161af9ed1ee98d4c9cee
[08/10] input: keyboard: Add support for MAX7360 keypad
        commit: fa6a23f1c59c67de9160b4acc5a8651ad2106fa8
[09/10] input: misc: Add support for MAX7360 rotary
        commit: 229c15e9a69cb3d6a303a9e20b10fb991b66895d
[10/10] MAINTAINERS: Add entry on MAX7360 driver
        commit: 32d4cedd24ed346edbe063323ed495d685e033df

--
Lee Jones [李琼斯]


