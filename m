Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59962DB3AF
	for <lists+linux-pwm@lfdr.de>; Thu, 17 Oct 2019 19:45:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394504AbfJQRpK (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 17 Oct 2019 13:45:10 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:33015 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394349AbfJQRpK (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 17 Oct 2019 13:45:10 -0400
Received: by mail-io1-f66.google.com with SMTP id z19so4119261ior.0;
        Thu, 17 Oct 2019 10:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=75E2laK4g7GeJgVF1eEMBE1cAO5dAIifqA0G0cS/+3g=;
        b=gLt0XWF8vtqlr6xsJ9xfa6dhCoCWHSMQI+0uwaYojgB4U9NSfcGxSlzqZALo0HQxVa
         I3UNAivhdC+ZrCow5k5CICAEPBoPzwpPfaK73pBXYUcj7S0lgmXMabEO3thlCrm6iQn2
         YgSGSQvr9V7apSYapKML/BeK9pCtW4IzPSAyN7rnZ162WaUZlgnmNcJO3gLvLmPoiKye
         4aV7uPt2XpTvCiECt81xr9iJQHDWTzV4+ylSIOKlhpx+RMb/TbfFEr+FSREj0x3qC/7M
         aQSBJbxMi+QJDUXYylx6XwCaEsETdZusb9ZQ0iFME8W/nGZ3+7UNKNftFYN+11d/Md3t
         eYyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=75E2laK4g7GeJgVF1eEMBE1cAO5dAIifqA0G0cS/+3g=;
        b=g8NQoW6fl+IMB4Y7WLu+j4Za+8TXQFbA3sx8QMGnc+dC+IaDOA7ZvYKLmKrBkVVLaR
         4Bm3kNDMlmbksGd6dsl8t4+T/A2LsJsOyHr6axN4SpkJXzxytJNBAl5N6Jus9rRrVODa
         YMusigpZHOVRSLbQeUoWvmJJnqtBHU0N2jNvm5Vhy6SiZp5iBmhPZuIXarQMAT5Lj+WE
         8/cQqDMsjb3Hnbp8lO9UGQXjAV9m26eroun6hmhiW2TE9w2S8mwGxXB23XJY0z8mRPGf
         bcgSeZQF8ADxt4xuu40BbLLdDlc5u9U79xBHKt95Q8cQWDU5sAhQIcs5+/2q9zKluI1a
         XJBA==
X-Gm-Message-State: APjAAAV0bCrwWUU9n2LupcagwgIci0wKxFHy4vEiB+MScyWKLUddjWYk
        2ovfRn59T2Qt+YCq62QEEXbloCkAequhVk7J0t9EBcHV
X-Google-Smtp-Source: APXvYqzF/m98gIatPmFuynS4cps484GmffbW+LyAsFi6Hr7RgTF9maK2Ty8pEes7xI9gi+nCIxPNet2Pzt2QTTsZkQU=
X-Received: by 2002:a02:92c9:: with SMTP id c9mr4639809jah.0.1571334308595;
 Thu, 17 Oct 2019 10:45:08 -0700 (PDT)
MIME-Version: 1.0
References: <20191017081059.31761-1-u.kleine-koenig@pengutronix.de>
 <c89925bd-857d-874f-b74f-c5700d4c9fbd@ysoft.com> <20191017101116.3d5okxmto5coecad@pengutronix.de>
 <20191017111131.GB3122066@ulmo> <20191017120917.fcb7x4fq4tbl2iat@pengutronix.de>
 <20191017125932.GB3768303@ulmo> <aa73b430-527c-8066-ad9c-edab62a05fc9@ysoft.com>
 <20191017151437.GA85210@ulmo> <CAHCN7xJduG9yxAhuW6D1_kpd5=p7LhO_YCWjVxcCoW5bmSEJGQ@mail.gmail.com>
 <20191017171326.GA531411@ulmo>
In-Reply-To: <20191017171326.GA531411@ulmo>
From:   Adam Ford <aford173@gmail.com>
Date:   Thu, 17 Oct 2019 12:44:57 -0500
Message-ID: <CAHCN7xJWco5gTdjmJZRbNqi1aO+ytor5XMJWQX8a38tfGbz+xg@mail.gmail.com>
Subject: Re: [PATCH] backlight: pwm_bl: configure pwm only once per backlight toggle
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     =?UTF-8?B?TWljaGFsIFZva8OhxI0=?= <michal.vokac@ysoft.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Lee Jones <lee.jones@linaro.org>, linux-fbdev@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Jingoo Han <jingoohan1@gmail.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, Oct 17, 2019 at 12:13 PM Thierry Reding
<thierry.reding@gmail.com> wrote:
>
> On Thu, Oct 17, 2019 at 12:07:21PM -0500, Adam Ford wrote:
> > On Thu, Oct 17, 2019 at 10:14 AM Thierry Reding
> > <thierry.reding@gmail.com> wrote:
> > >
> > > On Thu, Oct 17, 2019 at 03:58:25PM +0200, Michal Vok=C3=A1=C4=8D wrot=
e:
> > > > On 17. 10. 19 14:59, Thierry Reding wrote:
> > > > > On Thu, Oct 17, 2019 at 02:09:17PM +0200, Uwe Kleine-K=C3=B6nig w=
rote:
> > > > > > On Thu, Oct 17, 2019 at 01:11:31PM +0200, Thierry Reding wrote:
> > > > > > > On Thu, Oct 17, 2019 at 12:11:16PM +0200, Uwe Kleine-K=C3=B6n=
ig wrote:
> > > > > > > > On Thu, Oct 17, 2019 at 11:48:08AM +0200, Michal Vok=C3=A1=
=C4=8D wrote:
> > > > > > > > > On 17. 10. 19 10:10, Uwe Kleine-K=C3=B6nig wrote:
> > > > > > > > > > A previous change in the pwm core (namely 01ccf903edd6 =
("pwm: Let
> > > > > > > > > > pwm_get_state() return the last implemented state")) ch=
anged the
> > > > > > > > > > semantic of pwm_get_state() and disclosed an (as it see=
ms) common
> > > > > > > > > > problem in lowlevel PWM drivers. By not relying on the =
period and duty
> > > > > > > > > > cycle being retrievable from a disabled PWM this type o=
f problem is
> > > > > > > > > > worked around.
> > > > > > > > > >
> > > > > > > > > > Apart from this issue only calling the pwm_get_state/pw=
m_apply_state
> > > > > > > > > > combo once is also more effective.
> > > > > > > > > >
> > > > > > > > > > Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@p=
engutronix.de>
> > > > > > > > > > ---
> > > > > > > > > > Hello,
> > > > > > > > > >
> > > > > > > > > > There are now two reports about 01ccf903edd6 breaking a=
 backlight. As
> > > > > > > > > > far as I understand the problem this is a combination o=
f the backend pwm
> > > > > > > > > > driver yielding surprising results and the pwm-bl drive=
r doing things
> > > > > > > > > > more complicated than necessary.
> > > > > > > > > >
> > > > > > > > > > So I guess this patch works around these problems. Stil=
l it would be
> > > > > > > > > > interesting to find out the details in the imx driver t=
hat triggers the
> > > > > > > > > > problem. So Adam, can you please instrument the pwm-imx=
27 driver to
> > > > > > > > > > print *state at the beginning of pwm_imx27_apply() and =
the end of
> > > > > > > > > > pwm_imx27_get_state() and provide the results?
> > > > > > > > > >
> > > > > > > > > > Note I only compile tested this change.
> > > > > > > > >
> > > > > > > > > Hi Uwe,
> > > > > > > > > I was just about to respond to the "pwm_bl on i.MX6Q brok=
en on 5.4-RC1+"
> > > > > > > > > thread that I have a similar problem when you submitted t=
his patch.
> > > > > > > > >
> > > > > > > > > So here are my few cents:
> > > > > > > > >
> > > > > > > > > My setup is as follows:
> > > > > > > > >   - imx6dl-yapp4-draco with i.MX6Solo
> > > > > > > > >   - backlight is controlled with inverted PWM signal
> > > > > > > > >   - max brightness level =3D 32, default brightness level=
 set to 32 in DT.
> > > > > > > > >
> > > > > > > > > 1. Almost correct backlight behavior before 01ccf903edd6 =
("pwm: Let
> > > > > > > > >     pwm_get_state() return the last implemented state):
> > > > > > > > >
> > > > > > > > >   - System boots to userspace and backlight is enabled al=
l the time from
> > > > > > > > >     power up.
> > > > > > > > >
> > > > > > > > >     $ dmesg | grep state
> > > > > > > > >     [    1.763381] get state end: -1811360608, enabled: 0
> > > > > > > >
> > > > > > > > What is -1811360608? When I wrote "print *state" above, I t=
hought about
> > > > > > > > something like:
> > > > > > > >
> > > > > > > >       pr_info("%s: period: %u, duty: %u, polarity: %d, enab=
led: %d",
> > > > > > > >               __func__, state->period, state->duty_cycle, s=
tate->polarity, state->enabled);
> > > > > > > >
> > > > > > > > A quick look into drivers/pwm/pwm-imx27.c shows that this i=
s another
> > > > > > > > driver that yields duty_cycle =3D 0 when the hardware is of=
f.
> > > > > > >
> > > > > > > It seems to me like the best recourse to fix this for now wou=
ld be to
> > > > > > > patch up the drivers that return 0 when the hardware is off b=
y caching
> > > > > > > the currently configured duty cycle.
> > > > > > >
> > > > > > > How about the patch below?
> > > > > > >
> > > > > > > Thierry
> > > > > > >
> > > > > > > --- >8 ---
> > > > > > >  From 15a52a7f1b910804fabd74a5882befd3f9d6bb37 Mon Sep 17 00:=
00:00 2001
> > > > > > > From: Thierry Reding <thierry.reding@gmail.com>
> > > > > > > Date: Thu, 17 Oct 2019 12:56:00 +0200
> > > > > > > Subject: [PATCH] pwm: imx27: Cache duty cycle register value
> > > > > > >
> > > > > > > The hardware register containing the duty cycle value cannot =
be accessed
> > > > > > > when the PWM is disabled. This causes the ->get_state() callb=
ack to read
> > > > > > > back a duty cycle value of 0, which can confuse consumer driv=
ers.
> > > > > > >
> > > > > > > Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
> > > > > > > ---
> > > > > > >   drivers/pwm/pwm-imx27.c | 31 ++++++++++++++++++++++++------=
-
> > > > > > >   1 file changed, 24 insertions(+), 7 deletions(-)
> > > > > > >
> > > > > > > diff --git a/drivers/pwm/pwm-imx27.c b/drivers/pwm/pwm-imx27.=
c
> > > > > > > index ae11d8577f18..4113d5cd4c62 100644
> > > > > > > --- a/drivers/pwm/pwm-imx27.c
> > > > > > > +++ b/drivers/pwm/pwm-imx27.c
> > > > > > > @@ -85,6 +85,13 @@ struct pwm_imx27_chip {
> > > > > > >         struct clk      *clk_per;
> > > > > > >         void __iomem    *mmio_base;
> > > > > > >         struct pwm_chip chip;
> > > > > > > +
> > > > > > > +       /*
> > > > > > > +        * The driver cannot read the current duty cycle from=
 the hardware if
> > > > > > > +        * the hardware is disabled. Cache the last programme=
d duty cycle
> > > > > > > +        * value to return in that case.
> > > > > > > +        */
> > > > > > > +       unsigned int duty_cycle;
> > > > > > >   };
> > > > > > >   #define to_pwm_imx27_chip(chip)       container_of(chip, st=
ruct pwm_imx27_chip, chip)
> > > > > > > @@ -155,14 +162,17 @@ static void pwm_imx27_get_state(struct =
pwm_chip *chip,
> > > > > > >         tmp =3D NSEC_PER_SEC * (u64)(period + 2);
> > > > > > >         state->period =3D DIV_ROUND_CLOSEST_ULL(tmp, pwm_clk)=
;
> > > > > > > -       /* PWMSAR can be read only if PWM is enabled */
> > > > > > > -       if (state->enabled) {
> > > > > > > +       /*
> > > > > > > +        * PWMSAR can be read only if PWM is enabled. If the =
PWM is disabled,
> > > > > > > +        * use the cached value.
> > > > > > > +        */
> > > > > > > +       if (state->enabled)
> > > > > > >                 val =3D readl(imx->mmio_base + MX3_PWMSAR);
> > > > > > > -               tmp =3D NSEC_PER_SEC * (u64)(val);
> > > > > > > -               state->duty_cycle =3D DIV_ROUND_CLOSEST_ULL(t=
mp, pwm_clk);
> > > > > > > -       } else {
> > > > > > > -               state->duty_cycle =3D 0;
> > > > > > > -       }
> > > > > > > +       else
> > > > > > > +               val =3D imx->duty_cycle;
> > > > > > > +
> > > > > > > +       tmp =3D NSEC_PER_SEC * (u64)(val);
> > > > > > > +       state->duty_cycle =3D DIV_ROUND_CLOSEST_ULL(tmp, pwm_=
clk);
> > > > > > >         if (!state->enabled)
> > > > > > >                 pwm_imx27_clk_disable_unprepare(chip);
> > > > > > > @@ -261,6 +271,13 @@ static int pwm_imx27_apply(struct pwm_ch=
ip *chip, struct pwm_device *pwm,
> > > > > > >                 writel(duty_cycles, imx->mmio_base + MX3_PWMS=
AR);
> > > > > > >                 writel(period_cycles, imx->mmio_base + MX3_PW=
MPR);
> > > > > > > +               /*
> > > > > > > +                * Store the duty cycle for future reference =
in cases where
> > > > > > > +                * the MX3_PWMSAR register can't be read (i.e=
. when the PWM
> > > > > > > +                * is disabled).
> > > > > > > +                */
> > > > > > > +               imx->duty_cycle =3D duty_cycles;
> > > > > > > +
> > > > > >
> > > > > > I wonder if it would be more sensible to do this in the pwm cor=
e
> > > > > > instead. Currently there are two drivers known with this proble=
m. I
> > > > > > wouldn't be surprised if there were more.
> > > > >
> > > > > I've inspected all the drivers and didn't spot any beyond cros-ec=
 and
> > > > > i.MX that have this problem. There's also no good way to do this =
in the
> > > > > core, because the core doesn't know whether or not the driver is =
capable
> > > > > of returning the correct duty cycle on hardare readout. So the co=
re
> > > > > would have to rely on state->duty_cycle that is passed in, but th=
en the
> > > > > offending commit becomes useless because the whole point was to r=
eturn
> > > > > the state as written to hardware (rather than the software state =
which
> > > > > was being returned before that patch).
> > > > >
> > > > > > If we want to move clients to not rely on .period and .duty_cyc=
le for a
> > > > > > disabled PWM (do we?) a single change in the core is also benef=
icial
> > > > > > compared to fixing several lowlevel drivers.
> > > > >
> > > > > These are really two orthogonal problems. We don't currently cons=
ider
> > > > > enabled =3D 0 to be equivalent to duty_cycle =3D 0 at an API leve=
l. I'm not
> > > > > prepared to do that at this point in the release cycle either.
> > > > >
> > > > > What this here has shown is that we have at least two drivers tha=
t don't
> > > > > behave the way they are supposed to according to the API and they=
 break
> > > > > consumers. If they break for pwm-backlight, it's possible that th=
ey will
> > > > > break for other consumers as well. So the right thing to do is fi=
x the
> > > > > two drivers that are broken.
> > > > >
> > > > > After -rc1 we no longer experiment. Instead we clean up the messe=
s we've
> > > > > made. We can revisit the other points once mainline is fixed.
> > > >
> > > > Hi Thierry,
> > > > I just tried your patch with v5.4-rc3 with this result:
> > > >
> > > > root@hydraco:~# dmesg | grep pwm_
> > > > [    1.772089] pwm_imx27_get_state: period: 992970, duty: 0, polari=
ty: 0, enabled: 0
> > > > [    4.938759] pwm_imx27_apply: period: 500000, duty: 0, polarity: =
1, enabled: 0
> > > > [    4.947431] pwm_imx27_get_state: period: 992970, duty: 0, polari=
ty: 0, enabled: 0
> > >
> > > Okay... this is interesting. If I understand correctly, that first li=
ne
> > > here is where the initial hardware readout happens. The second one is
> > > the first time when the backlight is configured, so it sets period an=
d
> > > polarity. But then for some reason when we read out after that to rea=
d
> > > what state was written... we see that actually nothing was written at
> > > all.
> > >
> > > And we can see why in pwm_imx27_apply(): If the PWM is not enabled, w=
e
> > > don't actually program any of the registers, so it's not a surprise t=
hat
> > > things fall apart.
> > >
> > > > [    4.956484] pwm_imx27_apply: period: 992970, duty: 992970, polar=
ity: 0, enabled: 0
> > > > [    4.965473] pwm_imx27_get_state: period: 992970, duty: 0, polari=
ty: 0, enabled: 0
> > > > [    4.974410] pwm_imx27_apply: period: 992970, duty: 0, polarity: =
0, enabled: 1
> > > > [    4.988617] pwm_imx27_get_state: period: 992970, duty: 0, polari=
ty: 0, enabled: 1
> > > >
> > > > Backlight is on with full brightness at this stage.
> > > >
> > > > root@hydraco:/sys/class/backlight/backlight# cat brightness
> > > > 32
> > > >
> > > > root@hydraco:/sys/class/backlight/backlight# echo 32 > brightness
> > > > [  153.386391] pwm_imx27_apply: period: 992970, duty: 992970, polar=
ity: 0, enabled: 1
> > > > [  153.398311] pwm_imx27_get_state: period: 992970, duty: 992970, p=
olarity: 0, enabled: 1
> > > >
> > > > Backlight goes down.
> > > >
> > > > root@hydraco:/sys/class/backlight/backlight# echo 1 > brightness
> > > > [  168.506261] pwm_imx27_apply: period: 992970, duty: 15576, polari=
ty: 0, enabled: 1
> > > > [  168.518064] pwm_imx27_get_state: period: 992970, duty: 15576, po=
larity: 0, enabled: 1
> > > >
> > > > Backlight goes up to almost full brightness.
> > > >
> > > > root@hydraco:/sys/class/backlight/backlight# echo 0 > brightness
> > > > [  177.496265] pwm_imx27_apply: period: 992970, duty: 0, polarity: =
0, enabled: 0
> > > > [  177.507602] pwm_imx27_get_state: period: 496485, duty: 7788, pol=
arity: 0, enabled: 0
> > > >
> > > > Backlight goes up to full brightness.
> > > >
> > > > So your patch does not solve my issue.
> > > >
> > > > The main problem I see is incorrect polarity setting. In my DT
> > > > the pwm-backlight consumer requests PWM_POLARITY_INVERTED and
> > > > period 500000ns. Though after reset the PWM HW registers are
> > > > configured to normal polarity. This initial setting is read out
> > > > and used by the consumer instead of the DT configuration.
> > >
> > > So the problem with the i.MX driver is that it doesn't actually write
> > > the full state to the hardware and therefore the patch that caused th=
ese
> > > things to break reads back an incomplete state. So we've basically go=
t
> > > two options: 1) make sure the hardware state is fully written or 2) m=
ake
> > > sure that we return the cached state.
> > >
> > > I think 2) doesn't really make sense because it is conflicts with the
> > > purpose of the ->get_state() callback. The only time where we should =
be
> > > returning cached data is if the hardware registers don't contain the
> > > information (as in the case of the cros-ec driver) or if we can't acc=
ess
> > > it for other reasons (such as in the case of i.MX's duty cycle).
> > >
> > > Does the attached patch help with your issue? The idea is to always
> > > write the full state to the hardware, even if period and duty cycle a=
re
> > > unused when the PWM is disabled. That's really the kind of contract t=
hat
> > > we have added with the offending patch in the core.
> > >
> > > It looks like all other drivers handle this more or less correctly, s=
o
> > > if we only need to fix up cros-ec and i.MX this seems like a realisti=
c
> > > way to fix things up. If other drivers are problematic in this regard=
,
> > > we should probably revert and then fix the drivers before we can appl=
y
> > > that patch again.
> >
> > This patch combined with your previous patch appears to have worked.
> > If you end up sending a patch series to fix this, go ahead and add
> >
> > Tested-by: Adam Ford <aford173@gmail.com> #imx6q-logicpd
>
> Excellent! Thanks for testing this. I'll wait until tomorrow to see if
> there's some feedback from Enric for the cros-ec change. I'll send out
> the total of three patches again in the hopes that those are really
> the only two cases that are broken.

When you do, can you mark it with the Fixes note?  I am hoping the
maintainers can hopefully incorporate this into 5.4 since it fixes a
regression.

adam
>
> Thierry
>
> > > --- >8 ---
> > > From 7040f0038e04a1caa6dda5b6f675a9fdee0271f4 Mon Sep 17 00:00:00 200=
1
> > > From: Thierry Reding <thierry.reding@gmail.com>
> > > Date: Thu, 17 Oct 2019 17:11:41 +0200
> > > Subject: [PATCH] pwm: imx27: Unconditionally write state to hardware
> > >
> > > The i.MX driver currently uses a shortcut and doesn't write all of th=
e
> > > state through to the hardware when the PWM is disabled. This causes a=
n
> > > inconsistent state to be read back by consumers with the result of th=
em
> > > malfunctioning.
> > >
> > > Fix this by always writing the full state through to the hardware
> > > registers so that the correct state can always be read back.
> > >
> > > Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
> > > ---
> > >  drivers/pwm/pwm-imx27.c | 120 ++++++++++++++++++++------------------=
--
> > >  1 file changed, 59 insertions(+), 61 deletions(-)
> > >
> > > diff --git a/drivers/pwm/pwm-imx27.c b/drivers/pwm/pwm-imx27.c
> > > index 4113d5cd4c62..59d8b1289808 100644
> > > --- a/drivers/pwm/pwm-imx27.c
> > > +++ b/drivers/pwm/pwm-imx27.c
> > > @@ -230,70 +230,68 @@ static int pwm_imx27_apply(struct pwm_chip *chi=
p, struct pwm_device *pwm,
> > >
> > >         pwm_get_state(pwm, &cstate);
> > >
> > > -       if (state->enabled) {
> > > -               c =3D clk_get_rate(imx->clk_per);
> > > -               c *=3D state->period;
> > > -
> > > -               do_div(c, 1000000000);
> > > -               period_cycles =3D c;
> > > -
> > > -               prescale =3D period_cycles / 0x10000 + 1;
> > > -
> > > -               period_cycles /=3D prescale;
> > > -               c =3D (unsigned long long)period_cycles * state->duty=
_cycle;
> > > -               do_div(c, state->period);
> > > -               duty_cycles =3D c;
> > > -
> > > -               /*
> > > -                * according to imx pwm RM, the real period value sho=
uld be
> > > -                * PERIOD value in PWMPR plus 2.
> > > -                */
> > > -               if (period_cycles > 2)
> > > -                       period_cycles -=3D 2;
> > > -               else
> > > -                       period_cycles =3D 0;
> > > -
> > > -               /*
> > > -                * Wait for a free FIFO slot if the PWM is already en=
abled, and
> > > -                * flush the FIFO if the PWM was disabled and is abou=
t to be
> > > -                * enabled.
> > > -                */
> > > -               if (cstate.enabled) {
> > > -                       pwm_imx27_wait_fifo_slot(chip, pwm);
> > > -               } else {
> > > -                       ret =3D pwm_imx27_clk_prepare_enable(chip);
> > > -                       if (ret)
> > > -                               return ret;
> > > -
> > > -                       pwm_imx27_sw_reset(chip);
> > > -               }
> > > -
> > > -               writel(duty_cycles, imx->mmio_base + MX3_PWMSAR);
> > > -               writel(period_cycles, imx->mmio_base + MX3_PWMPR);
> > > -
> > > -               /*
> > > -                * Store the duty cycle for future reference in cases=
 where
> > > -                * the MX3_PWMSAR register can't be read (i.e. when t=
he PWM
> > > -                * is disabled).
> > > -                */
> > > -               imx->duty_cycle =3D duty_cycles;
> > > -
> > > -               cr =3D MX3_PWMCR_PRESCALER_SET(prescale) |
> > > -                    MX3_PWMCR_STOPEN | MX3_PWMCR_DOZEN | MX3_PWMCR_W=
AITEN |
> > > -                    FIELD_PREP(MX3_PWMCR_CLKSRC, MX3_PWMCR_CLKSRC_IP=
G_HIGH) |
> > > -                    MX3_PWMCR_DBGEN | MX3_PWMCR_EN;
> > > -
> > > -               if (state->polarity =3D=3D PWM_POLARITY_INVERSED)
> > > -                       cr |=3D FIELD_PREP(MX3_PWMCR_POUTC,
> > > -                                       MX3_PWMCR_POUTC_INVERTED);
> > > -
> > > -               writel(cr, imx->mmio_base + MX3_PWMCR);
> > > -       } else if (cstate.enabled) {
> > > -               writel(0, imx->mmio_base + MX3_PWMCR);
> > > +       c =3D clk_get_rate(imx->clk_per);
> > > +       c *=3D state->period;
> > >
> > > -               pwm_imx27_clk_disable_unprepare(chip);
> > > +       do_div(c, 1000000000);
> > > +       period_cycles =3D c;
> > > +
> > > +       prescale =3D period_cycles / 0x10000 + 1;
> > > +
> > > +       period_cycles /=3D prescale;
> > > +       c =3D (unsigned long long)period_cycles * state->duty_cycle;
> > > +       do_div(c, state->period);
> > > +       duty_cycles =3D c;
> > > +
> > > +       /*
> > > +        * according to imx pwm RM, the real period value should be P=
ERIOD
> > > +        * value in PWMPR plus 2.
> > > +        */
> > > +       if (period_cycles > 2)
> > > +               period_cycles -=3D 2;
> > > +       else
> > > +               period_cycles =3D 0;
> > > +
> > > +       /*
> > > +        * Wait for a free FIFO slot if the PWM is already enabled, a=
nd flush
> > > +        * the FIFO if the PWM was disabled and is about to be enable=
d.
> > > +        */
> > > +       if (cstate.enabled) {
> > > +               pwm_imx27_wait_fifo_slot(chip, pwm);
> > > +       } else {
> > > +               ret =3D pwm_imx27_clk_prepare_enable(chip);
> > > +               if (ret)
> > > +                       return ret;
> > > +
> > > +               pwm_imx27_sw_reset(chip);
> > >         }
> > >
> > > +       writel(duty_cycles, imx->mmio_base + MX3_PWMSAR);
> > > +       writel(period_cycles, imx->mmio_base + MX3_PWMPR);
> > > +
> > > +       /*
> > > +        * Store the duty cycle for future reference in cases where t=
he
> > > +        * MX3_PWMSAR register can't be read (i.e. when the PWM is di=
sabled).
> > > +        */
> > > +       imx->duty_cycle =3D duty_cycles;
> > > +
> > > +       cr =3D MX3_PWMCR_PRESCALER_SET(prescale) |
> > > +            MX3_PWMCR_STOPEN | MX3_PWMCR_DOZEN | MX3_PWMCR_WAITEN |
> > > +            FIELD_PREP(MX3_PWMCR_CLKSRC, MX3_PWMCR_CLKSRC_IPG_HIGH) =
|
> > > +            MX3_PWMCR_DBGEN;
> > > +
> > > +       if (state->polarity =3D=3D PWM_POLARITY_INVERSED)
> > > +               cr |=3D FIELD_PREP(MX3_PWMCR_POUTC,
> > > +                               MX3_PWMCR_POUTC_INVERTED);
> > > +
> > > +       if (state->enabled)
> > > +               cr |=3D MX3_PWMCR_EN;
> > > +
> > > +       writel(cr, imx->mmio_base + MX3_PWMCR);
> > > +
> > > +       if (!state->enabled && cstate.enabled)
> > > +               pwm_imx27_clk_disable_unprepare(chip);
> > > +
> > >         return 0;
> > >  }
> > >
> > > --
> > > 2.23.0
> > >
