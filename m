Return-Path: <linux-pwm+bounces-7327-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 745EEB59A92
	for <lists+linux-pwm@lfdr.de>; Tue, 16 Sep 2025 16:42:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 521AB1699A2
	for <lists+linux-pwm@lfdr.de>; Tue, 16 Sep 2025 14:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF52D322DC4;
	Tue, 16 Sep 2025 14:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uHKjYWvh"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E8221E082;
	Tue, 16 Sep 2025 14:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758033362; cv=none; b=unxCLQJCThoi0jI+CS9CY3YUlrlOVoY7cidGSEdNO6sJr7xi6gpv4y+Q9Gles793HLEtaoc3PyVs+fsNMshtsliYGzls61mr1j/dDTmBEpwrDX1ECus6sBW/nMgW+GTpciOYAh+Jqp3o2uM6RKAENbrlxkY9tTfygRf4Qeq2H8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758033362; c=relaxed/simple;
	bh=2Yekq7m436nLZD3oVpFQrhiETKLLC4HMzG6xzqLqNgI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kBoaRf8aBltBQmza2QfKCLsjwiSiu0QRgyR6hw/wvl9E0y0M2bnTQ7zdJAEG1e9EQRb5j/JwmKt+wS9VGr/Iu9IRhLuAffazr1jt+aRS7xRUvYEDBunDNhdJ5Sd7vjlJIgB0mY9kZitxmg8pdENWOgTRUeM3SfOg81ydWtteaZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uHKjYWvh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0929CC4CEEB;
	Tue, 16 Sep 2025 14:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758033362;
	bh=2Yekq7m436nLZD3oVpFQrhiETKLLC4HMzG6xzqLqNgI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uHKjYWvhHnCRDxk+fwvFkSc+s/fvaSw1NjDnMsW6YlrBJem8RcJrqk5cnyT0seG4P
	 OVS0/468tfxYzlcR3xQ0hGnx0z9gbeMorv20v/RqvdRvZTxLLMATo1aE3/ZX7DKpQV
	 dD9fU8KeZ/qJ+Onbyk4QuhCR1ezBHOrndI4jxFqCNgvxYpOLpI2orf4JdoHk1gyt3g
	 fTdUlUtEftzx/GLqDGOEKSB/urDLuZh1KM1UK3LiG7WS/IOoiA3woUZ+3KRTtNe91u
	 DnLiuHPegVTn07DrVOWOB75vV/FS1ueL8r/AhsJLzUhK43EiLYYylEOnKhwu/9tTRr
	 ILl4QpCwbePqg==
Date: Tue, 16 Sep 2025 15:35:54 +0100
From: Lee Jones <lee@kernel.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kamel Bouhara <kamel.bouhara@bootlin.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Michael Walle <mwalle@kernel.org>, Mark Brown <broonie@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-input@vger.kernel.org,
	linux-pwm@vger.kernel.org, andriy.shevchenko@intel.com,
	=?iso-8859-1?Q?Gr=E9gory?= Clement <gregory.clement@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v14 00/10] Add support for MAX7360
Message-ID: <20250916143554.GE3585920@google.com>
References: <20250824-mdb-max7360-support-v14-0-435cfda2b1ea@bootlin.com>
 <175803329065.3832522.18087850599111439891.b4-ty@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <175803329065.3832522.18087850599111439891.b4-ty@kernel.org>

On Tue, 16 Sep 2025, Lee Jones wrote:

> On Sun, 24 Aug 2025 13:57:19 +0200, Mathieu Dubois-Briand wrote:
> > This series implements a set of drivers allowing to support the Maxim
> > Integrated MAX7360 device.
> > 
> > The MAX7360 is an I2C key-switch and led controller, with following
> > functionalities:
> > - Keypad controller for a key matrix of up to 8 rows and 8 columns.
> > - Rotary encoder support, for a single rotary encoder.
> > - Up to 8 PWM outputs.
> > - Up to 8 GPIOs with support for interrupts and 6 GPOs.
> > 
> > [...]
> 
> Applied, thanks!
> 
> [01/10] dt-bindings: mfd: gpio: Add MAX7360
>         commit: aee814458fb98819876442f0261fad0bb9842224
> [02/10] mfd: Add max7360 support
>         commit: a22ddeef55c4df847d9ac862b6192da774948fe1
> [03/10] pinctrl: Add MAX7360 pinctrl driver
>         commit: b4b993c0e39436ffb3a9b21cabf62b5df085b2e1
> [04/10] pwm: max7360: Add MAX7360 PWM support
>         commit: d93a75d94b79ba3e664f7236ee05790e8b1d0e4b
> [05/10] gpio: regmap: Allow to allocate regmap-irq device
>         commit: 553b75d4bfe9264f631d459fe9996744e0672b0e
> [06/10] gpio: regmap: Allow to provide init_valid_mask callback
>         commit: 0627b71fa5508ab605b6e9fd74baed40805cfdda
> [07/10] gpio: max7360: Add MAX7360 gpio support
>         commit: b1a7433d857edb14b993161af9ed1ee98d4c9cee
> [08/10] input: keyboard: Add support for MAX7360 keypad
>         commit: fa6a23f1c59c67de9160b4acc5a8651ad2106fa8
> [09/10] input: misc: Add support for MAX7360 rotary
>         commit: 229c15e9a69cb3d6a303a9e20b10fb991b66895d
> [10/10] MAINTAINERS: Add entry on MAX7360 driver
>         commit: 32d4cedd24ed346edbe063323ed495d685e033df

Send for build testing.  If all is well, I'll submit a PR shortly.

Note to self: ib-mfd-gpio-input-pinctrl-pwm-6.18

-- 
Lee Jones [李琼斯]

