Return-Path: <linux-pwm+bounces-1195-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4E9E849010
	for <lists+linux-pwm@lfdr.de>; Sun,  4 Feb 2024 20:21:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C14BA1C22083
	for <lists+linux-pwm@lfdr.de>; Sun,  4 Feb 2024 19:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E788250EA;
	Sun,  4 Feb 2024 19:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gadgetoid.com header.i=@gadgetoid.com header.b="doY3/JH/"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8938D24B23
	for <linux-pwm@vger.kernel.org>; Sun,  4 Feb 2024 19:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707074487; cv=none; b=X5S3bsYFidIULjZnuGoG1fHXby6m7b2NVeyuyik0UXXjVWUfdfC7DzGjn4Slsrve5J8FGx73eRzpr/XwUhfo8gH4odgMwjwG9fmydoLzA8a2GH2udyTvL1uRA881mzXsbVA4qFmtiE8B4A/dvg9QkVEgBzGTaxOM6ee4a8Xe1A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707074487; c=relaxed/simple;
	bh=+2qQZPvzRM1Ccx5r01txcVMOu3HC/uAEKJdeEjLsMc8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DRlPefb554VVBNVt/vQSnsdHtZGmmskxmsDESWrZ/qKclqOkjwhaZKerS7dj3NHVmA6hwFqr/iFGpzSYZQYVJNvCB6JTDdQVfneN7SJwQy0learoJd0omg1C9BCQRvnke758VMJ3TAvP6aCtBP5tBHuJjJMJS9H44WvyK7JWVJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gadgetoid.com; spf=pass smtp.mailfrom=gadgetoid.com; dkim=pass (2048-bit key) header.d=gadgetoid.com header.i=@gadgetoid.com header.b=doY3/JH/; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gadgetoid.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gadgetoid.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6e0f43074edso2178016a34.1
        for <linux-pwm@vger.kernel.org>; Sun, 04 Feb 2024 11:21:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gadgetoid.com; s=google; t=1707074484; x=1707679284; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=60/XrcYt04qCiCxE5F6uQ90YiYyMDDuz2RU+MkOhiCs=;
        b=doY3/JH/VGFNSDKGTNfFcNEZh3cJJ6s63wiBE933toOgBGzXn8lFi5GQk6lYLjzK/9
         MkY8EacNtkiVVvQCJJeDkYzJ/hCKUS7qaX6wBU5qwxcvUlvSgCleLp5dgUKgDIl0wNqv
         7i1zSY+tp0iDXIr6OYjecUmASdxxpifpA6OOmXavBGpADD/qMhbz/xLaEjptR23mMmOn
         NQl1fErK9+Begcd3FJY16CF4UekDxlR4IcXMMRJFG5rRT1KoQ+C22aksjyqbYxRDLFHm
         qGFaf6ML8uNnMIvILGGol6UBBmz/jg1KiONCxpUU7ryPTa8nQRLZqi3RK5t4rMfvR2uy
         EGtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707074484; x=1707679284;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=60/XrcYt04qCiCxE5F6uQ90YiYyMDDuz2RU+MkOhiCs=;
        b=SzW1RvCCsxVcSkZ0rlUMgE3jM9EZXOkHVuYrp6WrACLCYlRpmiJRL/IHPKhKbkIOge
         T2zWyg2bHLynP3LQ7EtYKtuIVeCIX74iPaMuXFqNFYUeV9eHry0UkYo76kJ5I23ArDSz
         oPo7KmjtfnX2Dc4VO5nmOUQHxzAEGXx8l+V9NSeUXIJ6dufqxmXPWmHsgkgKNkcSxk+W
         QXhzMAiONzRaVUK8uY9H3p4MMENGuy8hzY7MdVxGnp8Ek8eNM3S2TxsgEYpeZLMXqdB2
         yh+oWuKELrItov/rkanNiNuV4j/nuddYQAo8F4sE86exF/qoMD8KTw8BFnVmr83CaBnc
         Z6hw==
X-Gm-Message-State: AOJu0YzRbMWxl94k6I0j+rkovdBylanA/g36dL05uPIUzdDQVSxgB2fy
	6Ymt2jR4AcosjcKf98IktoCDh0HVd43U2vCOw3QY28ZRGg6S8pizXi+yA1n28b2ZwkQpb0JItUS
	BJVg54ZVQ6vOiOAN7JzZl8JWYexHAD3Xlk+Fxrg==
X-Google-Smtp-Source: AGHT+IG3Z18gYOA2RjAesz6ekRd1LlfvoBIJH/qHhBB5ERUf3SeHSwhd6yPwjdb6xlORyUSXjQpvxZGKoTMcLcOe6QE=
X-Received: by 2002:a05:6870:10d6:b0:218:d5a6:e14 with SMTP id
 22-20020a05687010d600b00218d5a60e14mr4466262oar.46.1707074484492; Sun, 04 Feb
 2024 11:21:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240128163630.104725-1-wahrenst@gmx.net> <CA+kSVo88y7n9dyo57fgjybC9=1b_dgTPA3u-_kUH9X_79HF4tA@mail.gmail.com>
 <384a6c41-f29c-4adc-96a2-f72a44d1c718@gmx.net>
In-Reply-To: <384a6c41-f29c-4adc-96a2-f72a44d1c718@gmx.net>
From: Phil Howard <phil@gadgetoid.com>
Date: Sun, 4 Feb 2024 19:21:13 +0000
Message-ID: <CA+kSVo9V_CFdP0tahZ78zbfHPaKMSb8sh_3jc2dQZv0NkXnjvQ@mail.gmail.com>
Subject: Re: [PATCH V3 0/2] pwm: Add GPIO PWM driver
To: Stefan Wahren <wahrenst@gmx.net>
Cc: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	andy.shevchenko@gmail.com, Angelo Compagnucci <angelo.compagnucci@gmail.com>, 
	Linus Walleij <linus.walleij@linaro.org>, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 2 Feb 2024 at 20:13, Stefan Wahren <wahrenst@gmx.net> wrote:
>
> Hi Phil,
>
> Am 02.02.24 um 14:19 schrieb Phil Howard:
> > On Sun, 28 Jan 2024 at 16:37, Stefan Wahren <wahrenst@gmx.net> wrote:
> >> Add a software PWM which toggles a GPIO from a high-resolution timer.
> >>
> >> Recent discussions in the Raspberry Pi community revealt that a lot
> >> of users still use MMIO userspace tools for GPIO access. One argument
> >> for this approach is the lack of a GPIO PWM kernel driver. So this
> >> series tries to fill this gap.
> > *Thank you* for picking this up. I've been stuck down by covid but am aiming
> > to build and test this on a Pi 5 (with a gpio chip over PCIe) to see if it runs-
> > though I am fully expecting a PIO solution (using the Pi 5s RP1) to handle
> > PWM in this case, and hope to rely upon this gpio-pwm module for previous
> > iterations.
> i hope you are doing well.
>
> There will be small functional changes in V4. Since this series based on
> Linux 6.8 and there is no RPi 5 mainline support, you will need to apply
> it on top of rpi-6.8.y.

I've got as far as applying the patches and building myself a 6.8.y kernel,
just dragging the ol' brain kicking and screaming into dts world again.

>
> Should i wait for your test results (no pressure) before sending V4?

Don't wait on my account- (no really, it's chaos here)- send away!

> >
> >> This continues the work of Vincent Whitchurch [1], which is easier
> >> to read and more consequent by rejecting sleeping GPIOs than Nicola's
> >> approach [2].
> >>
> >> The work has been tested on a Raspberry Pi 3 B+ and a cheap logic
> >> analyzer.
> >>
> >> V3:
> >>   - rebase on top of v6.8-pwm-next
> >>   - cherry-pick improvements from Nicola's series
> >>   - try to address Uwe's, Linus' and Andy's comments
> >>   - try to avoid GPIO glitches during probe
> >>   - fix pwm_gpio_remove()
> >>   - some code clean up's and comments
> >>
> >> V2:
> >>   - Rename gpio to gpios in binding
> >>   - Calculate next expiry from expected current expiry rather than "now"
> >>   - Only change configuration after current period ends
> >>   - Implement get_state()
> >>   - Add error message for probe failures
> >>   - Stop PWM before unregister
> >>
> >> [1] - https://lore.kernel.org/all/20200915135445.al75xmjxudj2rgcp@axis.com/T/
> >> [2] - https://lore.kernel.org/all/20201205214353.xapax46tt5snzd2v@einstein.dilieto.eu/
> >>
> >> Nicola Di Lieto (1):
> >>    dt-bindings: pwm: Add pwm-gpio
> >>
> >> Vincent Whitchurch (1):
> >>    pwm: Add GPIO PWM driver
> >>
> >>   .../devicetree/bindings/pwm/pwm-gpio.yaml     |  42 ++++
> >>   drivers/pwm/Kconfig                           |  11 +
> >>   drivers/pwm/Makefile                          |   1 +
> >>   drivers/pwm/pwm-gpio.c                        | 221 ++++++++++++++++++
> >>   4 files changed, 275 insertions(+)
> >>   create mode 100644 Documentation/devicetree/bindings/pwm/pwm-gpio.yaml
> >>   create mode 100644 drivers/pwm/pwm-gpio.c
> >>
> >> --
> >> 2.34.1
> >>
>


-- 
Philip Howard
Technology & Lifestyle Writer
gadgetoid.com

Gadgetoid gadg-et-oid [gaj-it-oid]

                                     -adjective

1. having the characteristics or form of a gadget; resembling a
mechanical contrivance or device.

