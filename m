Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36677DAD73
	for <lists+linux-pwm@lfdr.de>; Thu, 17 Oct 2019 14:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728353AbfJQMxP (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 17 Oct 2019 08:53:15 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:38608 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727400AbfJQMxP (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 17 Oct 2019 08:53:15 -0400
Received: by mail-io1-f65.google.com with SMTP id u8so2830515iom.5;
        Thu, 17 Oct 2019 05:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=iD0TSDo0VJnLTbxUIdw+lbShlZzAkEVAgX8nV9jMFNk=;
        b=LLDNj+GfbYVBaJGnVyfvbFGbiPCqxDDTw3O+VWIN2Oqmd5dySBSl83J5lH6g8i5DKO
         f9f5OburrzL/pxtYENydeYOkkdRFHoxaf+r9xTWn2PssmJOKwSuLbXAkAzlAmc8XTcPo
         92e6cYfh2EJ28SN5557X6IKhGIn5XAD/1+rZaM/M7L0rz3R2zv3M9w1QGFnyuuVcUBiy
         n+JC3lhYnd6UsdIJrwrGkpGTPYXCcZMw8fZmiQyIXRxOGII0rnNT0FpQmNewHgOKwJoO
         vHyIssby+9pNdrYg2LE4wbs38VA66JKm3tJW2l1pS/8/qWptD5rpO/qDOgpeAaOqOjPB
         qC4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=iD0TSDo0VJnLTbxUIdw+lbShlZzAkEVAgX8nV9jMFNk=;
        b=m2UatUyEIy7zJiX7mJWQg8L99I4MGezBe0AM+0HFFFs+iCZmX/VD0m0OE2ef0I496u
         lPW8+aWwRy72ou+VLTSmbrLm4Jn1dF3P1LAkdcHh+iGZ6wU4jeMoDFWl+QE/I6nBpvo0
         72ef/mpQFnYGyc+tvYa2qx1N0ldZakBDNa1q1mmB8hJhRSzcYLOAfso7QxO68/VyCx/j
         KjWv5RYNUu+nuPV/f4WxdLyz04YjsNX0G/EhiNYjGCJS9ANe/JjPYDg2UQjZ9CoN9LJD
         8+1FSmOxx3ofnfSKORo3HZv5vYavtM5dHzz5mditza7GgdQYe2G3W3BZtrIf4yE6HOvJ
         yvhw==
X-Gm-Message-State: APjAAAXedqAblQlsiUya/fMnHDASuBaI7/PvCYIAxtLXWMTqJImE98F4
        SC7xRbihgTfaeueGIi3YL7zO6CouZuBedGkFuO6jkBor
X-Google-Smtp-Source: APXvYqyQQSnBGHr42YDTYT5E4fdrGnYai4qHMDD2FaHfCah1M4pZMR64OCOEHxcKxa+aYMfsY+fkqncuLWGLpLGRC6o=
X-Received: by 2002:a6b:ab03:: with SMTP id u3mr2646271ioe.158.1571316794346;
 Thu, 17 Oct 2019 05:53:14 -0700 (PDT)
MIME-Version: 1.0
References: <20191017081059.31761-1-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20191017081059.31761-1-u.kleine-koenig@pengutronix.de>
From:   Adam Ford <aford173@gmail.com>
Date:   Thu, 17 Oct 2019 07:53:02 -0500
Message-ID: <CAHCN7x+myMedaPjsH-bV1_Maq58AuS_8y4dZG0M7hyLdAhzZWQ@mail.gmail.com>
Subject: Re: [PATCH] backlight: pwm_bl: configure pwm only once per backlight toggle
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-fbdev@vger.kernel.org, Sascha Hauer <kernel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, Oct 17, 2019 at 3:11 AM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> A previous change in the pwm core (namely 01ccf903edd6 ("pwm: Let
> pwm_get_state() return the last implemented state")) changed the
> semantic of pwm_get_state() and disclosed an (as it seems) common
> problem in lowlevel PWM drivers. By not relying on the period and duty
> cycle being retrievable from a disabled PWM this type of problem is
> worked around.
>
> Apart from this issue only calling the pwm_get_state/pwm_apply_state
> combo once is also more effective.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
> Hello,
>
> There are now two reports about 01ccf903edd6 breaking a backlight. As
> far as I understand the problem this is a combination of the backend pwm
> driver yielding surprising results and the pwm-bl driver doing things
> more complicated than necessary.
>
> So I guess this patch works around these problems. Still it would be
> interesting to find out the details in the imx driver that triggers the
> problem. So Adam, can you please instrument the pwm-imx27 driver to
> print *state at the beginning of pwm_imx27_apply() and the end of
> pwm_imx27_get_state() and provide the results?
>
> Note I only compile tested this change.
>
> Best regards
> Uwe
>
>  drivers/video/backlight/pwm_bl.c | 34 +++++++++++---------------------
>  1 file changed, 12 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/p=
wm_bl.c
> index 746eebc411df..ddebd62b3978 100644
> --- a/drivers/video/backlight/pwm_bl.c
> +++ b/drivers/video/backlight/pwm_bl.c
> @@ -42,10 +42,8 @@ struct pwm_bl_data {
>
>  static void pwm_backlight_power_on(struct pwm_bl_data *pb)
>  {
> -       struct pwm_state state;
>         int err;
>
> -       pwm_get_state(pb->pwm, &state);
>         if (pb->enabled)
>                 return;
>
> @@ -53,9 +51,6 @@ static void pwm_backlight_power_on(struct pwm_bl_data *=
pb)
>         if (err < 0)
>                 dev_err(pb->dev, "failed to enable power supply\n");
>
> -       state.enabled =3D true;
> -       pwm_apply_state(pb->pwm, &state);
> -
>         if (pb->post_pwm_on_delay)
>                 msleep(pb->post_pwm_on_delay);
>
> @@ -67,40 +62,27 @@ static void pwm_backlight_power_on(struct pwm_bl_data=
 *pb)
>
>  static void pwm_backlight_power_off(struct pwm_bl_data *pb)
>  {
> -       struct pwm_state state;
> -
> -       pwm_get_state(pb->pwm, &state);
> -       if (!pb->enabled)
> -               return;
> -
>         if (pb->enable_gpio)
>                 gpiod_set_value_cansleep(pb->enable_gpio, 0);
>
>         if (pb->pwm_off_delay)
>                 msleep(pb->pwm_off_delay);
>
> -       state.enabled =3D false;
> -       state.duty_cycle =3D 0;
> -       pwm_apply_state(pb->pwm, &state);
> -
>         regulator_disable(pb->power_supply);
>         pb->enabled =3D false;
>  }
>
> -static int compute_duty_cycle(struct pwm_bl_data *pb, int brightness)
> +static int compute_duty_cycle(struct pwm_bl_data *pb, int brightness, st=
ruct pwm_state *state)
>  {
>         unsigned int lth =3D pb->lth_brightness;
> -       struct pwm_state state;
>         u64 duty_cycle;
>
> -       pwm_get_state(pb->pwm, &state);
> -
>         if (pb->levels)
>                 duty_cycle =3D pb->levels[brightness];
>         else
>                 duty_cycle =3D brightness;
>
> -       duty_cycle *=3D state.period - lth;
> +       duty_cycle *=3D state->period - lth;
>         do_div(duty_cycle, pb->scale);
>
>         return duty_cycle + lth;
> @@ -122,12 +104,20 @@ static int pwm_backlight_update_status(struct backl=
ight_device *bl)
>
>         if (brightness > 0) {
>                 pwm_get_state(pb->pwm, &state);
> -               state.duty_cycle =3D compute_duty_cycle(pb, brightness);
> +               state.duty_cycle =3D compute_duty_cycle(pb, brightness, &=
state);
> +               state.enabled =3D true;
>                 pwm_apply_state(pb->pwm, &state);
> +
>                 pwm_backlight_power_on(pb);
> -       } else
> +       } else {
>                 pwm_backlight_power_off(pb);
>
> +               pwm_get_state(pb->pwm, &state);
> +               state.enabled =3D false;
> +               state.duty_cycle =3D 0;
> +               pwm_apply_state(pb->pwm, &state);

Both cases where (brightness > 0) and 'else' contain the
pwm_apply_state() call with the same parameters.  Can this be moved
outside of the if statements?
> +       }
> +
>         if (pb->notify_after)
>                 pb->notify_after(pb->dev, brightness);
>
> --
> 2.23.0
>
