Return-Path: <linux-pwm+bounces-2248-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C06518D01DA
	for <lists+linux-pwm@lfdr.de>; Mon, 27 May 2024 15:40:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AE501F27B3D
	for <lists+linux-pwm@lfdr.de>; Mon, 27 May 2024 13:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 809D215EFD2;
	Mon, 27 May 2024 13:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BxigHGnu"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7DBF15EFD4;
	Mon, 27 May 2024 13:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716817050; cv=none; b=Y8qRn38dckl7PheFxdB1XvbWaw7ihwOpd3vvCpcqvRCXvL7tnuhpvRMiCR2ixaU8NAtssOE17FOHYb2OOyUwIG+A4kc/BkOh2Qx49QuDuLaCv/7ggKo3gSLNmswZJFYWTPaLsj0Px41X6El4gL1/RgJ/4lId9lsGL8Nub6QHPaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716817050; c=relaxed/simple;
	bh=o/GJKaIJ9lYTnxwGxykVsJt4sN0dAnKoOra7dqwTt4I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B44PXd8g1dB2LbKcOyNKNw9XFpt/198ChVyxREJH867ZMUOuILSWGZ+aaDg1AwdpPhINU/tOvpVbarqef2iv3A/6Ntc6BKo7nGeYtb9ZTWXQvbajJGA0mR9Rwq3CJtu+gb9j/+uoZQF7ABdx6whZpUPlUSaEc5dTjFNFeLWEYw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BxigHGnu; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-57822392a0dso8432068a12.0;
        Mon, 27 May 2024 06:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716817047; x=1717421847; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zhl9jNgY4cx1h8lYgOg4MyjfEdUbVWKXbFvOwfCvYuQ=;
        b=BxigHGnu+jNq6wOB8Vyf1tY8i6qBWu2+9u1i7lDgPL2Jv3wV3zX63E/AHUxOWspoZ/
         xNhg2O6orHmSBXbq49jb7vYwbHkrKO2WnvnQpdjaDBk9ZGuFptVMAywGN8PlLhFTzlrb
         u2xjVAgH4FrXYkCTznRcWBvFjzJiqe7T9PlMzLVVrIwax3qF8ZgngvyfCXb8Y583r5c7
         vguIJisnk2Vmh+sbaYCDY5VMd049g7vvOx5i88cGblfXMMxQMcbZH9xOR434xpDcLyZR
         v4pWxAzJ46cBSn1VVU0K1COQiIon1emwTJ0WVl3DWkMTwLfr9hUZbjCDpC6zp+HZSEhm
         MHqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716817047; x=1717421847;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zhl9jNgY4cx1h8lYgOg4MyjfEdUbVWKXbFvOwfCvYuQ=;
        b=sy7NocTNpN1x6bWRUYs7xWf9SN13FNHhh5b9vfypi2AMpfkwfyf9GNpuviXMgOaS87
         b+MpdZbh3oKvJTYfw2mDsqt1E4NYfaOGccHMykLuaF+uz4RmA8NzvYrYdGaZg1kfFkEO
         TCh4Di3xH5vqZ7uB+K+pxdNc5uh4IBUG1S7q1wcXdf2kWGhU3j/hvezajcY2TC2lyNSZ
         MQL3DI2WHEFglxfAMBoXSq10dUYjM47Cl+c2OXBzm5y4hr4E88YNHjvYM9BvwWyFjOqP
         7PqW0gdlWLSq3zK0oPTrAmLuLhwLhBzgNXz0gHuhoJHZ9VTl5hr3snClTUYE1v3D7yA0
         CuOg==
X-Forwarded-Encrypted: i=1; AJvYcCWcqYggwj+qC2BBVrKfgbnXzFrAZYXOL6CT1RUqbPzYmafoP4FDxR4Puxpmf5EyCLT5QCIwB0Zk2/zXuIUqZnQHAo9jRZxfnoA+1e8rnDWK/le3ilxd92gLg1R07xicwq5jOOR65QdgWQylR/GtIgh3NFYMIP1vAkIdGymxilqN6Oc=
X-Gm-Message-State: AOJu0YzUbIXqDZ8NUSvzQO1d5sUp58CnhfoVKPRskiJHFuTnVty9Xq6E
	JN6iWsXqnAaJVYexHmL8oFpr5YZLdCK9epo6hak5zlYppsrk8iyYTEwkwErcRzIZRTu7vi/QDOv
	nvt6vJw+2OW8YE6/ucIbhnkF3vMQ=
X-Google-Smtp-Source: AGHT+IGNl2z4R/oM1svkC/xv2oug1/YAJPGB8K/gQHSeNCj3kD+oViSn7sJ1ii+BZAgOyqOaKsDgiNo1c7T46mX0HQg=
X-Received: by 2002:a17:906:a219:b0:a59:c52b:993c with SMTP id
 a640c23a62f3a-a62651163ddmr498564866b.77.1716817046720; Mon, 27 May 2024
 06:37:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240527112857.90554-1-wahrenst@gmx.net> <20240527112857.90554-3-wahrenst@gmx.net>
In-Reply-To: <20240527112857.90554-3-wahrenst@gmx.net>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 27 May 2024 16:36:50 +0300
Message-ID: <CAHp75Vd46F7pYEvcXRn5ezCKWTAo_oMORht9vC2QedETgRAf2Q@mail.gmail.com>
Subject: Re: [PATCH V5 2/2] pwm: Add GPIO PWM driver
To: Stefan Wahren <wahrenst@gmx.net>
Cc: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philip Howard <phil@gadgetoid.com>, Sean Young <sean@mess.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Chris Morgan <macromorgan@hotmail.com>, 
	linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, Vincent Whitchurch <vincent.whitchurch@axis.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 27, 2024 at 2:29=E2=80=AFPM Stefan Wahren <wahrenst@gmx.net> wr=
ote:
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

...

> +#include <linux/cleanup.h>
> +#include <linux/container_of.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/hrtimer.h>

+ math.h

> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/platform_device.h>

+ property.h

> +#include <linux/pwm.h>
> +#include <linux/spinlock.h>
> +#include <linux/time.h>
> +#include <linux/types.h>

...

> +static enum hrtimer_restart pwm_gpio_timer(struct hrtimer *gpio_timer)
> +{
> +       struct pwm_gpio *gpwm =3D container_of(gpio_timer, struct pwm_gpi=
o,
> +                                            gpio_timer);
> +       unsigned long flags;
> +       u64 next_toggle;
> +       bool new_level;

> +       spin_lock_irqsave(&gpwm->lock, flags);

You added cleanup.h, why not scoped_guard() here?

> +       /* Apply new state at end of current period */
> +       if (!gpwm->level && gpwm->changing) {
> +               gpwm->changing =3D false;
> +               gpwm->state =3D gpwm->next_state;
> +               new_level =3D !!gpwm->state.duty_cycle;
> +       } else {
> +               new_level =3D !gpwm->level;
> +       }

> +       next_toggle =3D pwm_gpio_toggle(gpwm, new_level);
> +

Unneeded blank line.

> +       if (next_toggle)
> +               hrtimer_forward(gpio_timer, hrtimer_get_expires(gpio_time=
r),
> +                               ns_to_ktime(next_toggle));
> +
> +       spin_unlock_irqrestore(&gpwm->lock, flags);
> +
> +       return next_toggle ? HRTIMER_RESTART : HRTIMER_NORESTART;
> +}

...

> +       spin_lock_irqsave(&gpwm->lock, flags);

guard()

> +       if (!state->enabled) {
> +               pwm_gpio_round(&gpwm->state, state);
> +               gpwm->running =3D false;
> +               gpwm->changing =3D false;
> +
> +               gpiod_set_value(gpwm->gpio, invert);
> +       } else if (gpwm->running) {
> +               pwm_gpio_round(&gpwm->next_state, state);
> +               gpwm->changing =3D true;
> +       } else {
> +               unsigned long next_toggle;
> +
> +               pwm_gpio_round(&gpwm->state, state);
> +               gpwm->changing =3D false;
> +
> +               next_toggle =3D pwm_gpio_toggle(gpwm, !!state->duty_cycle=
);
> +               if (next_toggle)
> +                       hrtimer_start(&gpwm->gpio_timer, next_toggle,
> +                                     HRTIMER_MODE_REL);
> +       }
> +
> +       spin_unlock_irqrestore(&gpwm->lock, flags);
> +
> +       return 0;

...

> +static int pwm_gpio_get_state(struct pwm_chip *chip, struct pwm_device *=
pwm,
> +                              struct pwm_state *state)
> +{
> +       struct pwm_gpio *gpwm =3D pwmchip_get_drvdata(chip);
> +       unsigned long flags;
> +
> +       spin_lock_irqsave(&gpwm->lock, flags);

Ditto.

> +       if (gpwm->changing)
> +               *state =3D gpwm->next_state;
> +       else
> +               *state =3D gpwm->state;
> +
> +       spin_unlock_irqrestore(&gpwm->lock, flags);
> +
> +       return 0;
> +}

...

> +static int pwm_gpio_probe(struct platform_device *pdev)
> +{
> +       struct pwm_chip *chip;
> +       struct device *dev =3D &pdev->dev;
> +       struct pwm_gpio *gpwm;
> +       int ret;
> +
> +       chip =3D devm_pwmchip_alloc(&pdev->dev, 1, sizeof(*gpwm));

You have dev, use it.

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
> +       gpwm->gpio_timer.function =3D pwm_gpio_timer;
> +
> +       ret =3D pwmchip_add(chip);
> +       if (ret < 0)
> +               return dev_err_probe(dev, ret, "could not add pwmchip\n")=
;
> +
> +       platform_set_drvdata(pdev, gpwm);

> +       dev_info(dev, "pwm-gpio probed, hr timer resolution: %u ns\n", hr=
timer_resolution);

Is this important info? Can it be retrieved differently (via sysfs or
procfs or so)?

> +       return 0;
> +}
> +
> +static void pwm_gpio_remove(struct platform_device *pdev)
> +{
> +       struct pwm_gpio *gpwm =3D platform_get_drvdata(pdev);
> +
> +       hrtimer_cancel(&gpwm->gpio_timer);

This is a bit worrying. The probe sequence is to init timer followed
by adding PWM, here seems the broken order. Shouldn't you need to
wrapt hrtimer_init() into devm_add_action_or_reset()?

> +}

--=20
With Best Regards,
Andy Shevchenko

