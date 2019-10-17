Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9147DAEEA
	for <lists+linux-pwm@lfdr.de>; Thu, 17 Oct 2019 15:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437315AbfJQN74 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 17 Oct 2019 09:59:56 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:35307 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437275AbfJQN74 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 17 Oct 2019 09:59:56 -0400
Received: by mail-il1-f194.google.com with SMTP id j9so2134573ilr.2;
        Thu, 17 Oct 2019 06:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QFNNmg9wRzJREtA5JfZT3aTANg+99p30/ASMbM2gTbk=;
        b=EOcziOiT26brwCbh2/387S62d+bKBylBjKUf76UxmYjGCpSO8rmDDBw8ExidKYnRed
         52jAMlNG9fvXdoSOR4CkoriYL/umXPiDwQ0VamZwZsGSOTK5877Ci7z8+qhVvf2nRHl1
         eoGHMSndeCxYMpaa3wkLM2tSaJZXCaJcP0PYjFL+iilP5SD0tQ9/EhObK+qIiCVE78MV
         7l76k/MvqwZHB6y9eiJVi1cyqNacl6PWRV5VqryqNIDaIYiLZJ/vdSBoMohEJV5KyHYx
         IUZ5cB/dBZV/bUmDWpW+dXjvMu6p5Smfd5DdtbqqFVXmH+jQpmcLbP+jbs92r+y8PY7T
         kadQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QFNNmg9wRzJREtA5JfZT3aTANg+99p30/ASMbM2gTbk=;
        b=Cq8ZDIP4g+iitOIQGu6qlHIolGhim3NtrfGiB/6jAi9nIF8jPcTTxkcQ4Yy0iQmsCP
         lAB9eAjfu8KK1ZJ5f0wsFA3HdTTgbeFdREcr68nk3aGYusluWFqcx8xPzrpIK/S2QyKp
         IdR9kVj5EGVU1qWcpN8ml/QaPsIILnD+b1zT2ybi6+F72vFBjxP446mN8AikH85zC4gI
         Y56wtYcTY3rgK4eRLOe48V3iafAb2CU/BFLdKCRXH9ZT14/um9bgAoBJ7FdfpB3iDcp5
         cfVNxzZhWh2AzoJW8ILffmM8MfkfhqLfyDeGeYHOEGfRb2sVteFr1YPbAHZvi4h763VV
         Uv1g==
X-Gm-Message-State: APjAAAU8B+DfrFaa0bW6wF80q7CGvZDQ2QgMXwKTD/p8ojIgrt6z+GIa
        ysmjTUp4ei1+yHg6XWH3dmSvC13W38pn6f2et8k=
X-Google-Smtp-Source: APXvYqw+BtxpGQtTsloek31AbUPnMKu/Kn8Vc4hziPEgSfPimRNfZnFAvRT0zQCLEhijvkflTduF+aWioXGeM06vXa8=
X-Received: by 2002:a92:6a04:: with SMTP id f4mr3920482ilc.205.1571320794610;
 Thu, 17 Oct 2019 06:59:54 -0700 (PDT)
MIME-Version: 1.0
References: <20191017081059.31761-1-u.kleine-koenig@pengutronix.de>
 <c89925bd-857d-874f-b74f-c5700d4c9fbd@ysoft.com> <20191017101116.3d5okxmto5coecad@pengutronix.de>
 <20191017111131.GB3122066@ulmo> <CAHCN7xJmUiMRfYqgB+mkPVtoL20=RwXJHvzzJum4YcgUEHizsg@mail.gmail.com>
In-Reply-To: <CAHCN7xJmUiMRfYqgB+mkPVtoL20=RwXJHvzzJum4YcgUEHizsg@mail.gmail.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Thu, 17 Oct 2019 08:59:42 -0500
Message-ID: <CAHCN7xJc_WxE-cuJgCcX3_5JWOoXfYreGpPUvhmPiUBWdCnFXg@mail.gmail.com>
Subject: Re: [PATCH] backlight: pwm_bl: configure pwm only once per backlight toggle
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        =?UTF-8?B?TWljaGFsIFZva8OhxI0=?= <michal.vokac@ysoft.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, linux-pwm@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-fbdev@vger.kernel.org, Sascha Hauer <kernel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, Oct 17, 2019 at 8:30 AM Adam Ford <aford173@gmail.com> wrote:
>
> On Thu, Oct 17, 2019 at 6:11 AM Thierry Reding <thierry.reding@gmail.com>=
 wrote:
> >
> > On Thu, Oct 17, 2019 at 12:11:16PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> > > On Thu, Oct 17, 2019 at 11:48:08AM +0200, Michal Vok=C3=A1=C4=8D wrot=
e:
> > > > On 17. 10. 19 10:10, Uwe Kleine-K=C3=B6nig wrote:
> > > > > A previous change in the pwm core (namely 01ccf903edd6 ("pwm: Let
> > > > > pwm_get_state() return the last implemented state")) changed the
> > > > > semantic of pwm_get_state() and disclosed an (as it seems) common
> > > > > problem in lowlevel PWM drivers. By not relying on the period and=
 duty
> > > > > cycle being retrievable from a disabled PWM this type of problem =
is
> > > > > worked around.
> > > > >
> > > > > Apart from this issue only calling the pwm_get_state/pwm_apply_st=
ate
> > > > > combo once is also more effective.
> > > > >
> > > > > Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix=
.de>
> > > > > ---
> > > > > Hello,
> > > > >
> > > > > There are now two reports about 01ccf903edd6 breaking a backlight=
. As
> > > > > far as I understand the problem this is a combination of the back=
end pwm
> > > > > driver yielding surprising results and the pwm-bl driver doing th=
ings
> > > > > more complicated than necessary.
> > > > >
> > > > > So I guess this patch works around these problems. Still it would=
 be
> > > > > interesting to find out the details in the imx driver that trigge=
rs the
> > > > > problem. So Adam, can you please instrument the pwm-imx27 driver =
to
> > > > > print *state at the beginning of pwm_imx27_apply() and the end of
> > > > > pwm_imx27_get_state() and provide the results?
> > > > >
> > > > > Note I only compile tested this change.
> > > >
> > > > Hi Uwe,
> > > > I was just about to respond to the "pwm_bl on i.MX6Q broken on 5.4-=
RC1+"
> > > > thread that I have a similar problem when you submitted this patch.
> > > >
> > > > So here are my few cents:
> > > >
> > > > My setup is as follows:
> > > >  - imx6dl-yapp4-draco with i.MX6Solo
> > > >  - backlight is controlled with inverted PWM signal
> > > >  - max brightness level =3D 32, default brightness level set to 32 =
in DT.
> > > >
> > > > 1. Almost correct backlight behavior before 01ccf903edd6 ("pwm: Let
> > > >    pwm_get_state() return the last implemented state):
> > > >
> > > >  - System boots to userspace and backlight is enabled all the time =
from
> > > >    power up.
> > > >
> > > >    $ dmesg | grep state
> > > >    [    1.763381] get state end: -1811360608, enabled: 0
> > >
> > > What is -1811360608? When I wrote "print *state" above, I thought abo=
ut
> > > something like:
> > >
> > >       pr_info("%s: period: %u, duty: %u, polarity: %d, enabled: %d",
> > >               __func__, state->period, state->duty_cycle, state->pola=
rity, state->enabled);
> > >
> > > A quick look into drivers/pwm/pwm-imx27.c shows that this is another
> > > driver that yields duty_cycle =3D 0 when the hardware is off.
> >
> > It seems to me like the best recourse to fix this for now would be to
> > patch up the drivers that return 0 when the hardware is off by caching
> > the currently configured duty cycle.
> >
> > How about the patch below?
> >
> > Thierry
> >
> > --- >8 ---
> > From 15a52a7f1b910804fabd74a5882befd3f9d6bb37 Mon Sep 17 00:00:00 2001
> > From: Thierry Reding <thierry.reding@gmail.com>
> > Date: Thu, 17 Oct 2019 12:56:00 +0200
> > Subject: [PATCH] pwm: imx27: Cache duty cycle register value
> >
> > The hardware register containing the duty cycle value cannot be accesse=
d
> > when the PWM is disabled. This causes the ->get_state() callback to rea=
d
> > back a duty cycle value of 0, which can confuse consumer drivers.
> >
> > Signed-off-by: Thierry Reding <thierry.reding@gmail.com>

Your patch doesn't appear to being the PWM on by default, but I appear
to be able to do stuff without the screen going blank, so I think
we're making some progress. I unrolled the pwm_bl changes, but kept
yours but I am not seeing any ability to change the brightness.
Level 1-7 all appear to me to be the same.

> > ---
> >  drivers/pwm/pwm-imx27.c | 31 ++++++++++++++++++++++++-------
> >  1 file changed, 24 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/pwm/pwm-imx27.c b/drivers/pwm/pwm-imx27.c
> > index ae11d8577f18..4113d5cd4c62 100644
> > --- a/drivers/pwm/pwm-imx27.c
> > +++ b/drivers/pwm/pwm-imx27.c
> > @@ -85,6 +85,13 @@ struct pwm_imx27_chip {
> >         struct clk      *clk_per;
> >         void __iomem    *mmio_base;
> >         struct pwm_chip chip;
> > +
> > +       /*
> > +        * The driver cannot read the current duty cycle from the hardw=
are if
> > +        * the hardware is disabled. Cache the last programmed duty cyc=
le
> > +        * value to return in that case.
> > +        */
> > +       unsigned int duty_cycle;
> >  };
> >
> >  #define to_pwm_imx27_chip(chip)        container_of(chip, struct pwm_i=
mx27_chip, chip)
> > @@ -155,14 +162,17 @@ static void pwm_imx27_get_state(struct pwm_chip *=
chip,
> >         tmp =3D NSEC_PER_SEC * (u64)(period + 2);
> >         state->period =3D DIV_ROUND_CLOSEST_ULL(tmp, pwm_clk);
> >
> > -       /* PWMSAR can be read only if PWM is enabled */
> > -       if (state->enabled) {
> > +       /*
> > +        * PWMSAR can be read only if PWM is enabled. If the PWM is dis=
abled,
> > +        * use the cached value.
> > +        */
> > +       if (state->enabled)
> >                 val =3D readl(imx->mmio_base + MX3_PWMSAR);
> > -               tmp =3D NSEC_PER_SEC * (u64)(val);
> > -               state->duty_cycle =3D DIV_ROUND_CLOSEST_ULL(tmp, pwm_cl=
k);
> > -       } else {
> > -               state->duty_cycle =3D 0;
> > -       }
> > +       else
> > +               val =3D imx->duty_cycle;
> > +
> > +       tmp =3D NSEC_PER_SEC * (u64)(val);
> > +       state->duty_cycle =3D DIV_ROUND_CLOSEST_ULL(tmp, pwm_clk);
>
> Is this right?  It seems like the tmp  and state->duty_cycle
> caltulations should be kept inside "if (state->enabled)" because if we
> set val to the duty_cycle in the else, I would think it is going to
> calculate this again.
>
> I think the 'else' should be 'state->duty_cycle =3D imx->duty_cycle'
> because we shouldn't need to recalculate this again.
>
> Am I missing something?

I figured out what I was missing.

>
> adam
> >
> >         if (!state->enabled)
> >                 pwm_imx27_clk_disable_unprepare(chip);
> > @@ -261,6 +271,13 @@ static int pwm_imx27_apply(struct pwm_chip *chip, =
struct pwm_device *pwm,
> >                 writel(duty_cycles, imx->mmio_base + MX3_PWMSAR);
> >                 writel(period_cycles, imx->mmio_base + MX3_PWMPR);
> >
> > +               /*
> > +                * Store the duty cycle for future reference in cases w=
here
> > +                * the MX3_PWMSAR register can't be read (i.e. when the=
 PWM
> > +                * is disabled).
> > +                */
> > +               imx->duty_cycle =3D duty_cycles;
> > +
> >                 cr =3D MX3_PWMCR_PRESCALER_SET(prescale) |
> >                      MX3_PWMCR_STOPEN | MX3_PWMCR_DOZEN | MX3_PWMCR_WAI=
TEN |
> >                      FIELD_PREP(MX3_PWMCR_CLKSRC, MX3_PWMCR_CLKSRC_IPG_=
HIGH) |
> > --
> > 2.23.0
> >
