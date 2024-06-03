Return-Path: <linux-pwm+bounces-2330-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EE628D8AF3
	for <lists+linux-pwm@lfdr.de>; Mon,  3 Jun 2024 22:35:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0E551F20C16
	for <lists+linux-pwm@lfdr.de>; Mon,  3 Jun 2024 20:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2BED13B791;
	Mon,  3 Jun 2024 20:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KvGH2rg+"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3426513B798;
	Mon,  3 Jun 2024 20:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717446907; cv=none; b=mb5j0tMhwL9NhiGGzFfI2UrUymquzUhDOYBK+b7sH8Kv9zFR/8M8337bJeHCDX33yQ8V7vJBRd45CeDb2IGfWQCOGrDtvCR0BePms6k0ApcPcSnBojjYvWBmcWe691BTsS5y4QvzPfQoXMfyjGlGlnaJ/PQCsQw5jGwPfSOi1c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717446907; c=relaxed/simple;
	bh=KwWNQGw+2/5TNKQgZ7WcKZJkgf/QIcP8hEPwsf63tFk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Er15KXf7ig7TVttFdRtsd0jrsK+4rHvbAVxB3AVw+t5s5f2P5eDtMSSBESWrGPAgHT6d4wqj5l7N1sEOx1+DKvOovmtVyTPMHdOODVJHVOrGcWYgALSgDj4uVIR0iKoJ77QAUQ13ATVnssBuigerxNDnl4Bel+BvDNOvJqhSIK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KvGH2rg+; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-57a2406f951so5125372a12.1;
        Mon, 03 Jun 2024 13:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717446904; x=1718051704; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7xuy1n57KIpCTHjyrkT+Tg9AxFkzW/GLX4KPPVhYwkc=;
        b=KvGH2rg+OZkIEZ80yBo9LmwPgBBDbyUuaEZPpmdTLpCTgv5mmaC9ekNUjUapbVOYT2
         PihC6jm5lb6qrR1Rh7JrzDyk+QpGuePGZnDzCn4b7RZMzkXvzdPSamwquMMuPBibUOEK
         rpK69mVUgbFysbFG6BUQ5RaH1XHLHDQaG234rdk3VLjlMvwycjF70Afll8ZMDL2afd7o
         l+Osx+TSq+XY5/GZdGlH0sFdFl03GLayZ2+wWPNzCgzY5j09N/q5Qu2YXcqxO8HS3XPz
         2uL7lGp/F8WUnxc/pmC28sX1A36fBE7KQVIf7d0zV5cYOEzVtGBZfm2Y7AXhVNpazJbc
         Z5zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717446904; x=1718051704;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7xuy1n57KIpCTHjyrkT+Tg9AxFkzW/GLX4KPPVhYwkc=;
        b=stHl5QMMI2bfdkcHDCvvgUJo+acrfjPYQxNEmgcp7eIbR2T8IBRn9B5oCgRnCRuAiR
         3Mmmdm2NhWUzVrREaU8irRITjALj0z0u8TKpc/l7LjBWNVSheVQsfOptxB9HojAF/utx
         zvZp7+j1pkZHWRjk3nUcdfItca4lr3O0etFjkKAgu99szYFmwyDOD5peoyrZYU5V7obi
         DHrkF1nulyO/FLOsqEwH8ZqqAMtJSHBppq74Vb89V/gPFPHDOBVabTr0+QdGgq1Ev0Fc
         rZLVRINpiWjhXo5zXhWi0l5+gib1Q+D9ZlTSbXQKegIARLfV1YLxkJTSB/bfr4gE0XhV
         rhHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKrkOaj6Ivtmb8zm+rTCY/50+d+SRNzHv9SJUt6GXtYtLzWDgx0QUFfdWY+CrXMqlFJsuYG1oFMpmT2l8hwytGNQP/RelFDoxzetQwifakfPbmajbK1SgJyhgD8ofLminfHjE5ugeophtYhtleZvK8q1sQ8lxZ5hrcKghlcNqGS0Q=
X-Gm-Message-State: AOJu0YwYpEPXYT3z5Qw43ZyhnpavntlAjQOwI6oij4fMA1G4hdIdM5qZ
	q9UBF63rpyntF4aIrEC4U6Kmk3JbtjEtbB1AojztEAu2kd2V4Uk83U4LoSgyjHNV/1OVzlulBr+
	HThKI0OORTSEUk3jxuLxh6YwfO5w=
X-Google-Smtp-Source: AGHT+IH+lDMxvyFKRk7F24crRs9d1+aHL58p6J9vIYExDHMUBtOF6fP5eFn7MAR5PXhD2pmOTQ8bcx8Sf/xAnRtrwHA=
X-Received: by 2002:a17:906:d106:b0:a68:a333:d2a6 with SMTP id
 a640c23a62f3a-a68a333d5bcmr518193566b.65.1717446904290; Mon, 03 Jun 2024
 13:35:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240602-pwm-gpio-v6-0-e8f6ec9cc783@linaro.org> <20240602-pwm-gpio-v6-2-e8f6ec9cc783@linaro.org>
In-Reply-To: <20240602-pwm-gpio-v6-2-e8f6ec9cc783@linaro.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 3 Jun 2024 23:34:27 +0300
Message-ID: <CAHp75VfUcvz00T+12JKWPnJBK3msxgft-9fYQPU3ugtyqLBrTg@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] pwm: Add GPIO PWM driver
To: Linus Walleij <linus.walleij@linaro.org>
Cc: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philip Howard <phil@gadgetoid.com>, Sean Young <sean@mess.org>, 
	Chris Morgan <macromorgan@hotmail.com>, Stefan Wahren <wahrenst@gmx.net>, linux-gpio@vger.kernel.org, 
	linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
	Vincent Whitchurch <vincent.whitchurch@axis.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 2, 2024 at 11:33=E2=80=AFPM Linus Walleij <linus.walleij@linaro=
.org> wrote:
>
> From: Vincent Whitchurch <vincent.whitchurch@axis.com>
>
> Add a software PWM which toggles a GPIO from a high-resolution timer.
>
> This will naturally not be as accurate or as efficient as a hardware
> PWM, but it is useful in some cases.  I have for example used it for
> evaluating LED brightness handling (via leds-pwm) on a board where the
> LED was just hooked up to a GPIO, and for a simple verification of the
> timer frequency on another platform.
>
> Since high-resolution timers are used, sleeping GPIO chips are not
> supported and are rejected in the probe function.


Reviewed-by: Andy Shevchenko <andy@kernel.org>
See one question below.

...

> +static int pwm_gpio_probe(struct platform_device *pdev)
> +{
> +       struct device *dev =3D &pdev->dev;
> +       struct pwm_chip *chip;
> +       struct pwm_gpio *gpwm;
> +       int ret;
> +
> +       chip =3D devm_pwmchip_alloc(dev, 1, sizeof(*gpwm));
> +       if (IS_ERR(chip))
> +               return PTR_ERR(chip);
> +
> +       gpwm =3D pwmchip_get_drvdata(chip);
> +
> +       spin_lock_init(&gpwm->lock);
> +
> +       gpwm->gpio =3D devm_gpiod_get(dev, NULL, GPIOD_ASIS);
> +       if (IS_ERR(gpwm->gpio))
> +               return dev_err_probe(dev, PTR_ERR(gpwm->gpio),
> +                                    "%pfw: could not get gpio\n",
> +                                    dev_fwnode(dev));
> +
> +       if (gpiod_cansleep(gpwm->gpio))
> +               return dev_err_probe(dev, -EINVAL,
> +                                    "%pfw: sleeping GPIO not supported\n=
",
> +                                    dev_fwnode(dev));
> +
> +       chip->ops =3D &pwm_gpio_ops;
> +       chip->atomic =3D true;
> +
> +       hrtimer_init(&gpwm->gpio_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL=
);
> +       ret =3D devm_add_action_or_reset(dev, pwm_gpio_disable_hrtimer, g=
pwm);
> +       if (ret)
> +               return ret;
> +
> +       gpwm->gpio_timer.function =3D pwm_gpio_timer;
> +
> +       ret =3D pwmchip_add(chip);
> +       if (ret < 0)
> +               return dev_err_probe(dev, ret, "could not add pwmchip\n")=
;

> +       platform_set_drvdata(pdev, gpwm);

Do we still need this?

> +       return 0;
> +}

--=20
With Best Regards,
Andy Shevchenko

