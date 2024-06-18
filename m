Return-Path: <linux-pwm+bounces-2498-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 116F990CAD2
	for <lists+linux-pwm@lfdr.de>; Tue, 18 Jun 2024 14:01:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 964DE1F232E7
	for <lists+linux-pwm@lfdr.de>; Tue, 18 Jun 2024 12:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6655139CF6;
	Tue, 18 Jun 2024 11:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gadgetoid.com header.i=@gadgetoid.com header.b="FC7KvVcf"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEAEA13C822
	for <linux-pwm@vger.kernel.org>; Tue, 18 Jun 2024 11:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718711505; cv=none; b=ccevLPWdAietp6OEQRj6b1Yfz40CchkpyLhoKXbo72eX86uBgcb7phMqgCHrA1rN+lTcLMKpsXMe9NM28WkCEVAX4br+e8ogeQT5fJSmSgMDWoyA8zyp7H3YIR9071ulAwbbVml6gtHWydMgiMqeacbgWeGbQjcGGVqTdQFEks8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718711505; c=relaxed/simple;
	bh=B8bttVEZCmjROUmARUQ0zA/rHjbyRSmSPlkOwA1ECaU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cmM+5EDuwme13DFc0qqP8jtf4zVy1243uq+aAo/wjqdb5/xSeFm9fJ1DEixiorrbDDBsg/rymS0sm1/cIAvUixX0jVUwcil8B7OL4ojsLEGpB+uQNDtEoMh9efsfPIdSKzz2jQ2ADDeyxKqjLBam2QUsctZXPC1dl6J8rv11/4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gadgetoid.com; spf=pass smtp.mailfrom=gadgetoid.com; dkim=pass (2048-bit key) header.d=gadgetoid.com header.i=@gadgetoid.com header.b=FC7KvVcf; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gadgetoid.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gadgetoid.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5ba18126a3bso2298813eaf.1
        for <linux-pwm@vger.kernel.org>; Tue, 18 Jun 2024 04:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gadgetoid.com; s=google; t=1718711503; x=1719316303; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XcLeW1lELKT4R/ng9TOeJAlv3h1yazasKJ0GF1QBAMI=;
        b=FC7KvVcfjXOYPq3+6VAlL5WXAGyYH2u+KeHeSNzjzEym86qP/7Srvu6SZpBcROa5B0
         off4qyeexKgDgYV+vN9jfA+bIf0QKOMPFMnVFN+3c79CXFzOvUx5sn21Z/4dJi6/jcAO
         0CZnfD2i1oxj33fW9Z8WVKNGXTbHxHXLYLzjzYAQW92yPGVd8SSiUaEIt9yWilTwZ7cZ
         bi34hPGSSfL/yfikIudobOveXiczCz/ivs/buUHqZ1++K441oCzX2c2CPhfKOtTfH3hK
         0rQXDK84ERGqQ0lpM1oEKFAIldOXbSp2Z+uKIHN+xv4iZ1G9ROxDDFjmVeOYaui6bk18
         SN2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718711503; x=1719316303;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XcLeW1lELKT4R/ng9TOeJAlv3h1yazasKJ0GF1QBAMI=;
        b=BmfWBxoCLoUcKnpJ7TEn71bI/xtUczVJALnKJDL3OByOqzkvELrU1i/7gmnCU40lPF
         uLsoMyi+ArIaDoBfhlzLOuZqoI1xiP+GpiEJ2JLjK8yirMTOYiIV+V38APXcXH5oVdR4
         mkXg58VBIbh/w0WErppMMjrQD8N/VQspWn47/BxmX13OEsBLxbp5iD2gyMC3fk6RKmkm
         4fjWU7ZrdDbpSmYbdJeDclUbhioWPnAWTX7G3H8bMDfZFQ/Y3ROI3tj7xHExvWLfzAe4
         E0/NR3m4TDtZLl335OXzgKxezTD2ABvhDAXR43xeVGIPmhd3PN/E+6qZxMBf34pm0uvd
         2r0A==
X-Forwarded-Encrypted: i=1; AJvYcCWCZcgdyozXpM1VDmUGCp2miovGso9IbLMWMvqRaWxRLv64r1OwW2ijGwixTJhKwF9h3w9usd1ZR28EqaRmXfx+oDJiF0uwOjFS
X-Gm-Message-State: AOJu0YxJ9uZQjtW+n+TpWqLYntySm+dWmB10/KnbLs44arzo9c0oWl/9
	5f4NiQp6P4H3533zS5Otm7Y/L/yLSuhpufRfCCapx6DISfYFZP3aUVYCJoFLdHUs8WAoMlo5kA1
	X5/i7As/qShfAEXFatyzWWOjryo4w+Gi8KbIRtQ==
X-Google-Smtp-Source: AGHT+IG82cYtgwVbWJFHYYgTPTF4O/qv5jWgxZ4zeXAS3T7GC0SpK6x9uAvryPfR9c1E6kN1uyjU0iL5otJdHQz1VqY=
X-Received: by 2002:a05:6871:8a0:b0:258:32c5:ebc4 with SMTP id
 586e51a60fabf-259730546d3mr1128770fac.26.1718711502904; Tue, 18 Jun 2024
 04:51:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240604-pwm-gpio-v7-0-6b67cf60db92@linaro.org>
In-Reply-To: <20240604-pwm-gpio-v7-0-6b67cf60db92@linaro.org>
From: Phil Howard <phil@gadgetoid.com>
Date: Tue, 18 Jun 2024 12:51:32 +0100
Message-ID: <CA+kSVo8pe-eb9d2qcyCuTfDLsqyz7KNnLW+ZqpPjr7pAq7BJtA@mail.gmail.com>
Subject: Re: [PATCH v7 0/2] pwm: Add GPIO PWM driver
To: Linus Walleij <linus.walleij@linaro.org>
Cc: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	andy.shevchenko@gmail.com, Sean Young <sean@mess.org>, 
	Chris Morgan <macromorgan@hotmail.com>, Stefan Wahren <wahrenst@gmx.net>, linux-gpio@vger.kernel.org, 
	linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
	Nicola Di Lieto <nicola.dilieto@gmail.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Dhruva Gole <d-gole@ti.com>, 
	Vincent Whitchurch <vincent.whitchurch@axis.com>, Andy Shevchenko <andy@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 4 Jun 2024 at 22:00, Linus Walleij <linus.walleij@linaro.org> wrote:
>
> Add a software PWM which toggles a GPIO from a high-resolution timer.
>
> Recent discussions in the Raspberry Pi community revealt that a lot
> of users still use MMIO userspace tools for GPIO access. One argument
> for this approach is the lack of a GPIO PWM kernel driver. So this
> series tries to fill this gap.
>
> This continues the work of Vincent Whitchurch [1], which is easier
> to read and more consequent by rejecting sleeping GPIOs than Nicola's
> approach [2]. It further takes over where Stefan Wahren left off.
>
> I have not looked into the interrupt storm problem mentioned in [3]
> but instead focused on some real-life tests:
>
> The IXP4xx NSLU2 has a speaker connected directly to a GPIO, and I
> wanted to use this patch to provide a proper beeper for the machine
> and not have to rely on custom hacks.
>
> I added a DTS patch like this:
>
> gpio_pwm: pwm {
>         #pwm-cells = <3>;
>         compatible = "pwm-gpio";
>         gpios = <&gpio0 4 GPIO_ACTIVE_HIGH>;
> };
>
> beeper {
>         compatible = "pwm-beeper";
>         pwms = <&gpio_pwm 0 1 0>;
>         beeper-hz = <1000>;
> };
>
> Then activated the necessary drivers with input evdev and they
> both probe fine. Then I use this test program:
> https://gist.github.com/licheegh/3dbdc8918325e8af8d4d13805cd0c350
> with a few different beep frequencies, such as "beep 400"
> for an OK sounding 400 Hz signal.
>
> Above ~10000 Hz the sound becomes bad and mostly sound like
> different kinds of noise. But this is not so bad for the NSLU2
> which is a 266 MHz ARM XScale machine, and we do not need any better
> on this machine so mission accomplished. Pushing the playback
> to higher and higher rates does not crash the machine, the
> sample program always terminates.
>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Changes in v7:
> - Drop platform_set_drvdata() as nothing use this anymore.
> - Add a small blurb documenting the pwm-cells in the binding.
> - Link to v6: https://lore.kernel.org/r/20240602-pwm-gpio-v6-0-e8f6ec9cc783@linaro.org
>
> v6:
> - Add a small blurb to drivers-on-gpio.rst
> - Add missing headers to driver
> - Use guarded spinlocks from <linux/cleanup.h>
> - Drop minor surplus whitespace
> - Use dev pointer everywhere in probe()
> - Drop dev_info() chatter at end of probe()
> - Use devm_add_action_or_reset() for a hook to disable the hrtimer and
>   get rid of the .remove() callback altogether.
>
> V5:
>  - add Reviewed-by's for dt-binding patch
>  - rebase on top of v6.10-rc1
>  - print hr resolution at driver probe
>  - fix grammar in Kconfig
>  - fix return type of pwm_gpio_toggle
>  - implement hrtimer resolution rounding as noted by Uwe
>  - use firmware node path instead of GPIO numbers as suggested by Andy
>  - adjust some header includes and style issues as noted by Andy
>
> V4:
>  - address DT bindings comments from Conor Dooley
>  - drop unnecessary MODULE_ALIAS() as suggested by Krzysztof Kozlowski
>  - add range checks to apply which consider the hrtimer resolution
>    (idea comes from Sean Young)
>  - mark driver as atomic as suggested by Sean Young
>
> V3:
>  - rebase on top of v6.8-pwm-next
>  - cherry-pick improvements from Nicola's series
>  - try to address Uwe's, Linus' and Andy's comments
>  - try to avoid GPIO glitches during probe
>  - fix pwm_gpio_remove()
>  - some code clean up's and comments
>
> V2:
>  - Rename gpio to gpios in binding
>  - Calculate next expiry from expected current expiry rather than "now"
>  - Only change configuration after current period ends
>  - Implement get_state()
>  - Add error message for probe failures
>  - Stop PWM before unregister
>
> [1] - https://lore.kernel.org/all/20200915135445.al75xmjxudj2rgcp@axis.com/T/
> [2] - https://lore.kernel.org/all/20201205214353.xapax46tt5snzd2v@einstein.dilieto.eu/
> [3] - https://lore.kernel.org/linux-pwm/CACRpkdary+kDrTJ=u4VbSTv7wXGLQj9_fy7mv0w-Zg+eDvGXVQ@mail.gmail.com/T/#m513f255daa9f30c325d11999cacd086411591bf9
>
> ---
> Nicola Di Lieto (1):
>       dt-bindings: pwm: Add pwm-gpio
>
> Vincent Whitchurch (1):
>       pwm: Add GPIO PWM driver
>
>  .../devicetree/bindings/pwm/pwm-gpio.yaml          |  46 ++++
>  Documentation/driver-api/gpio/drivers-on-gpio.rst  |   7 +-
>  drivers/pwm/Kconfig                                |  11 +
>  drivers/pwm/Makefile                               |   1 +
>  drivers/pwm/pwm-gpio.c                             | 241 +++++++++++++++++++++
>  5 files changed, 305 insertions(+), 1 deletion(-)
> ---
> base-commit: cc97b8f37b097a1598410154ca472964a1d9b255
> change-id: 20240530-pwm-gpio-e9133a1806ec
>
> Best regards,
> --
> Linus Walleij <linus.walleij@linaro.org>
>

Thank you for picking this up, it's reassuring to see it making progress.

I will give it a shot today.

- Phil

