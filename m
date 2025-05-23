Return-Path: <linux-pwm+bounces-6109-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8159AAC26E3
	for <lists+linux-pwm@lfdr.de>; Fri, 23 May 2025 17:55:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98898A20972
	for <lists+linux-pwm@lfdr.de>; Fri, 23 May 2025 15:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5573F2957A2;
	Fri, 23 May 2025 15:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jh5zVPui"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10472294A1D;
	Fri, 23 May 2025 15:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748015743; cv=none; b=Gn72iqVH0JekAGa5g9tcT9XoSrLh1tL0ge8S9TcnK1XYRghRG2J8NTw8Byk2c0qIkyjlkxBhHmradRmv7+tYYnckI+6Gt/xFXdOUQwkmbXueUvDxAKWNaoVDoHV3cN9Lkrt5OOgVi0vbVTVsLNQ2PT132aR8L6YY8MS9tb9psVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748015743; c=relaxed/simple;
	bh=02S++/GnMLzXCwbjOabyD4L7obDi6EOlhMd/z4qvnZg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=IEh0nacU5VFA2PfcRvKQWknqw2AEX5B4rzrLApBZukpVXkDW017GbrY7XVmc0rKWg9AkmHjAJNzzwOCLub82ndGJz7pvw//5tR83YJ8uUpaL8SlVnf35yVq3OMtt+a5ti2CK+Z+VYgt06AAp0sCLDvgggho8OFbY3ZPhKkZoCuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jh5zVPui; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 551FFC4CEEF;
	Fri, 23 May 2025 15:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748015742;
	bh=02S++/GnMLzXCwbjOabyD4L7obDi6EOlhMd/z4qvnZg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=jh5zVPuiOna6z5tzNx9kqq7oe9bzgSsF1g6n/TK3adC8oGF7KBsuLoiiPt7otzI9R
	 pkODmT8kDsaWRQT9hkIdTab9+5tmzRAmVN+G97qz+ylrDWEx5MhhM4OwZuTdOgo+Rl
	 Vmrnyp/BXukO10ycqVZwYszs6dTuVxYSUr/3u2mxekfxdkhOEbo7YP/FNVsIiyL+/u
	 wsn6JKM1RtdK/4RCwRsFgSDOmfUJirKnJv1HuRPZMHg7tAlxqV3GDcw8DRi5VCh3Me
	 zoF1JoWEYv37tcJhYz2iS4bU3r9rYwwXApbXUrBQT+nZMicZ2OaOP2PE/Ucv6qwqCZ
	 QgfoV7LW4iD2Q==
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
In-Reply-To: <20250509-mdb-max7360-support-v8-0-bbe486f6bcb7@bootlin.com>
References: <20250509-mdb-max7360-support-v8-0-bbe486f6bcb7@bootlin.com>
Subject: Re: (subset) [PATCH v8 00/11] Add support for MAX7360
Message-Id: <174801573711.565639.2548650361543550224.b4-ty@kernel.org>
Date: Fri, 23 May 2025 16:55:37 +0100
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c25d1

On Fri, 09 May 2025 11:14:34 +0200, Mathieu Dubois-Briand wrote:
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


