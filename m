Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F2152DAC18
	for <lists+linux-pwm@lfdr.de>; Tue, 15 Dec 2020 12:32:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728618AbgLOLag (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 15 Dec 2020 06:30:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728538AbgLOLaa (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 15 Dec 2020 06:30:30 -0500
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70D78C0617A6
        for <linux-pwm@vger.kernel.org>; Tue, 15 Dec 2020 03:29:50 -0800 (PST)
Received: by mail-ot1-x342.google.com with SMTP id b24so1487776otj.0
        for <linux-pwm@vger.kernel.org>; Tue, 15 Dec 2020 03:29:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=p604QLetTfZSa7CHQbIrq6YTwQr3ft4EeGEtc5nMlPs=;
        b=nkH9xVh1hpd6qVGD3Oo4r1E37TgdGpZ0xZbRMn9WMfD1BDLS+zVkYea4aJtFOj/aBL
         GTB2MF4LAbRC7rrZRTCvO+6FAjCvxlj86kRMK7gbBUPY+75bp5lhRyqsbz2uQYQyo+ZY
         nCfRR2zVFj0K4SWT20Vx8yG6ddoX566gngLkU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=p604QLetTfZSa7CHQbIrq6YTwQr3ft4EeGEtc5nMlPs=;
        b=ivFlNSQkpmsfTDa9tNRkrfqtOvt+vViSWC0hQ6osUCP7V1mjoqCpvfk4uFdcWVtIb0
         VBf9jnHTHDGWlEKX4zckrLS7PpxgBOyENTE3bNCwmVlVQgfpuAG1vuiyUFsEEAYzcamz
         TRorFB5LFQowyErHy6/er72Sb9fXrak4k14xQZCyH1uIqt+uq/iTY8MBe28e7fqRa9zU
         in4CwU9g2uyCI1d44wOXP2Hl6OEmyP2RX6jdQjmwkSwuu+FNFjsQ1VMxhQ/eCuOSf/7T
         jqLW4VyEZ6LyLvATVINxeB5q2T/oPjGNOsfSKC3GZRqSc8eHLK+ap9eV+C2CesKSEGi/
         b3fA==
X-Gm-Message-State: AOAM5331I5lXDZi3zQpM41AMo28ekVZZvqkXB3R6IqYcl1G6F5oX0Cwb
        oCHLX3j9k90AT77Xjp41hoMUMpeRLYjof7Pr2S/j+w==
X-Google-Smtp-Source: ABdhPJzuuLJTZacsizJLBVq1WbUbWmbOx1nBRiHlV2dGDRGMqiZ2VHnA7ldTMNplrbw3D/mgjp8UPf4MfQNOK7oxdec=
X-Received: by 2002:a9d:7a4b:: with SMTP id z11mr22766759otm.305.1608031789756;
 Tue, 15 Dec 2020 03:29:49 -0800 (PST)
MIME-Version: 1.0
References: <20201215092031.152243-1-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20201215092031.152243-1-u.kleine-koenig@pengutronix.de>
From:   Paul Barker <pbarker@konsulko.com>
Date:   Tue, 15 Dec 2020 11:29:39 +0000
Message-ID: <CAM9ZRVt1wRUuGSniDvS2PME=O-Y3YtVHgTh27qn5Dkj_kUc3AQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] hwmon: pwm-fan: Ensure that calculation doesn't
 discard big period values
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, linux-hwmon@vger.kernel.org,
        linux-pwm@vger.kernel.org, kernel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, 15 Dec 2020 at 09:23, Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> With MAX_PWM being defined to 255 the code
>
>         unsigned long period;
>         ...
>         period =3D ctx->pwm->args.period;
>         state.duty_cycle =3D DIV_ROUND_UP(pwm * (period - 1), MAX_PWM);

Reviewing this I noticed that in pwm_fan_resume() we use
DIV_ROUND_UP_ULL for what looks like essentially the same calculation.
Could we just switch this line to DIV_ROUND_UP_ULL instead?

>
> calculates a too small value for duty_cycle if the configured period is
> big (either by discarding the 64 bit value ctx->pwm->args.period or by
> overflowing the multiplication). As this results in a too slow fan and
> so maybe an overheating machine better be safe than sorry and error out
> in .probe.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/hwmon/pwm-fan.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c
> index 1f63807c0399..ec171f2b684a 100644
> --- a/drivers/hwmon/pwm-fan.c
> +++ b/drivers/hwmon/pwm-fan.c
> @@ -324,8 +324,18 @@ static int pwm_fan_probe(struct platform_device *pde=
v)
>
>         ctx->pwm_value =3D MAX_PWM;
>
> -       /* Set duty cycle to maximum allowed and enable PWM output */
>         pwm_init_state(ctx->pwm, &state);
> +       /*
> +        * __set_pwm assumes that MAX_PWM * (period - 1) fits into an uns=
igned
> +        * long. Check this here to prevent the fan running at a too low
> +        * frequency.
> +        */
> +       if (state.period > ULONG_MAX / MAX_PWM + 1) {
> +               dev_err(dev, "Configured period too big\n");
> +               return -EINVAL;
> +       }
> +
> +       /* Set duty cycle to maximum allowed and enable PWM output */
>         state.duty_cycle =3D ctx->pwm->args.period - 1;
>         state.enabled =3D true;
>
>
> base-commit: 2c85ebc57b3e1817b6ce1a6b703928e113a90442
> --
> 2.29.2
>


--=20
Paul Barker
Konsulko Group
