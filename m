Return-Path: <linux-pwm+bounces-6097-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6333DAC106D
	for <lists+linux-pwm@lfdr.de>; Thu, 22 May 2025 17:55:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCAEC7B24CF
	for <lists+linux-pwm@lfdr.de>; Thu, 22 May 2025 15:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B993129A302;
	Thu, 22 May 2025 15:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NNEYEF5l"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D394299AB1;
	Thu, 22 May 2025 15:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747929305; cv=none; b=TkrSuhkZgWE43hlbMkEEvAb9UXL6l0hE2HXOWj6uCSRcR9dpN/YGAtj/QJgHtmxMwz7qHVFaP1AjlaZYybHPIkSBRhXvmYJp6HScuCtswKHW+E6726rH9xAo2lUqx17r9zx8cSiValHrMtkz6N1rxuXZBmv8w0f7rEz385pid1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747929305; c=relaxed/simple;
	bh=w4FvX9d4kuB0EmgIeEKnSG+0zM1T1LUnOAhWnXqMSto=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=VxgBdwN3NJ43WRH/JcMfHSd8kTQhlOtBpN3RqhLHEJV2jrRXIQm6pvEgJTsMlAacCw7uo7XOwFNQD3275CQwbWHpgf/fqjTa215SKBmRu8gRW66UofXQewX+tm9LR6FUWSbDsH/5gZdeXwGZoEM2UftZ3G38GOQtnQlR1+cY72w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NNEYEF5l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD8DBC4CEE4;
	Thu, 22 May 2025 15:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747929305;
	bh=w4FvX9d4kuB0EmgIeEKnSG+0zM1T1LUnOAhWnXqMSto=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=NNEYEF5lIOfuU+qPv6qLE+wWLg2p1scuyfhRtSFfffI1SuesbhsknyMuQBIMJHt5P
	 /cwXDcTUmmgwlDrYW6/724DBpwdp8zuiI1/aEynn5OvG7buyq0fHjcij92XaNWs+rt
	 7Qdmbn/jT3Zx1xkasjC5HqxHGFcbu3zlYm5Iv9nXKIm4+OmQriV5pX6EcXfxkwDPDe
	 lXv4XOrqkiqX5snIBd4g3LoUn6e8VuD+nEaWoDhE9oXJCpMOgjDMRfj5dhiQdyugUO
	 fssD0ahHZ0TmVeuiBEZ8juoquutLnjFDVnRL06YafH0PzKbtTD79VKZmNup0o4+3VY
	 d10hPvHI6oVuQ==
From: Mark Brown <broonie@kernel.org>
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Kamel Bouhara <kamel.bouhara@bootlin.com>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Michael Walle <mwalle@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-input@vger.kernel.org, 
 linux-pwm@vger.kernel.org, andriy.shevchenko@intel.com, 
 =?utf-8?q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
In-Reply-To: <20250522-mdb-max7360-support-v9-0-74fc03517e41@bootlin.com>
References: <20250522-mdb-max7360-support-v9-0-74fc03517e41@bootlin.com>
Subject: Re: (subset) [PATCH v9 00/11] Add support for MAX7360
Message-Id: <174792930043.117740.5415129838999345044.b4-ty@kernel.org>
Date: Thu, 22 May 2025 16:55:00 +0100
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c25d1

On Thu, 22 May 2025 14:06:15 +0200, Mathieu Dubois-Briand wrote:
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

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[05/11] regmap: irq: Add support for chips without separate IRQ status
        commit: 1c12fbdf40e17df2efc24bf2009a0c3bfa75bfa7

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark


