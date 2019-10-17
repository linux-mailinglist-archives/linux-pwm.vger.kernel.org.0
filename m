Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DDCADB079
	for <lists+linux-pwm@lfdr.de>; Thu, 17 Oct 2019 16:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404558AbfJQOwK (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 17 Oct 2019 10:52:10 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:39536 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733056AbfJQOwJ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 17 Oct 2019 10:52:09 -0400
Received: by mail-io1-f65.google.com with SMTP id a1so3346359ioc.6;
        Thu, 17 Oct 2019 07:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=W5rIB1/t8sIUdGpNtAI739ICdxaYf3wjiycVoir8Jro=;
        b=RTMTA8GOIBI91VVgXfZfHh7lhT0JPGsV5B5ZaFwe6PIW1IqhixNjzqYULFch2h6lSL
         xyVvuGGtkETW+AuDqp5hbaRKRKJTJCqT1BS+YP6KqPODYanBwLY2eo+8PEbWYOEVMdyt
         UO4fHXSkBCNySrjvQePmVO3hQIXAb6DxUCYT7r961ARqY1B4Bjh/U7iBshjus7KwKJRT
         BxbkV3jRcCChMm7JENRXPEKSJ9yGnKPbF6EmOkI8hXVjZKAYXJznhQA+2n5jk29OpDdA
         UtD3wss/1d1+pPpDDsyqIAGI0Wjt8qrI1lFbS4PKMDJRXtp3f9Rf1+U/82Raog+VWrbM
         bAgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=W5rIB1/t8sIUdGpNtAI739ICdxaYf3wjiycVoir8Jro=;
        b=IjJFIiUf+dDp1oPBC5OukGhTUu+HAr7sTJkddsRIVzD1uCDUSmD3DCwkZ9EyrZiPM8
         u5Ofeg7I6btizZ9IyFuUc0YiCyXq6HKJevgg5j1ok7mR2O/i4bicjwMuM5u7ujt3D68L
         tyK9IsZEgAcjL3AzIM0+dx7rsvZMpxjsASTGD1x1fqKebwNvfhkR5ZRSyflscHRU8ltL
         GyUCYeSKHlnwOTrYEBPfIcszf4frjnN+QUbDCQO3fWccmmkdrE1huP7f/9bqqswE9Hi7
         Uk19+ahQ04AxahRmSU3yWTivdV66QaLjYzVu8GBo/niKmtHAUOnkem78ZmWA/yrPXstf
         Wryw==
X-Gm-Message-State: APjAAAXfQ/A7Lilk5sEP8cpDGWayG4PEdgdpP96JSQXBarYapMk4Jzw6
        z5JgOQ/g5XwncoHUErNZEiJGIi06yTgHpGQgLKE=
X-Google-Smtp-Source: APXvYqxTq7E9uML16r9kKJF8ASS9oY+BwfWyajRYBmilJaGQnynoqeYFs9pN5c6kQd3pP+DgCnyhbUeReC9/dEiHSG0=
X-Received: by 2002:a5d:9952:: with SMTP id v18mr3218550ios.58.1571323928466;
 Thu, 17 Oct 2019 07:52:08 -0700 (PDT)
MIME-Version: 1.0
References: <20191017081059.31761-1-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20191017081059.31761-1-u.kleine-koenig@pengutronix.de>
From:   Adam Ford <aford173@gmail.com>
Date:   Thu, 17 Oct 2019 09:51:57 -0500
Message-ID: <CAHCN7x+HpUyu93RNi_HbK7jc5jsbW5HKdNtxg8oLv25m-ak-rA@mail.gmail.com>
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

Looking at the pwm core file in linunx/master, it looks like we're
checking to see if all items are the same.  If they are, we return 0.
This make sense because we're not changing anything.

If anything is different, we're using the cached value because we're
not checking if/what has changed.  If we want to change the polarity
or the duty cycle, this appears to me like it would not change because
it just uses the cached value.  Somehow it seems to me like we should
just blindly update the state to what we want and let the lower-level
functions cache what they need to prevent the recalculation, but if
we're changing duty cycle or polarity, I am not seeing how that will
be updated.

Both of those appear to be broken depending on which board is having an iss=
ue.

adam



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
> +       }
> +
>         if (pb->notify_after)
>                 pb->notify_after(pb->dev, brightness);
>
> --
> 2.23.0
>
