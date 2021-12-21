Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD6F247BCBE
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Dec 2021 10:18:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236282AbhLUJSl (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 21 Dec 2021 04:18:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236296AbhLUJSk (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 21 Dec 2021 04:18:40 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15DDFC061574
        for <linux-pwm@vger.kernel.org>; Tue, 21 Dec 2021 01:18:40 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mzbI3-0005aS-W8; Tue, 21 Dec 2021 10:18:36 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1mzbI2-005nAb-En; Tue, 21 Dec 2021 10:18:33 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mzbI1-0007ot-5G; Tue, 21 Dec 2021 10:18:33 +0100
Date:   Tue, 21 Dec 2021 10:18:30 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     hammer hsieh <hammerh0314@gmail.com>
Cc:     thierry.reding@gmail.com, lee.jones@linaro.org, robh+dt@kernel.org,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, wells.lu@sunplus.com,
        Hammer Hsieh <hammer.hsieh@sunplus.com>
Subject: Re: [PATCH v1 2/2] pwm:sunplus-pwm:Add Sunplus SoC PWM Driver
Message-ID: <20211221091830.7jsklhvt7c3bhmjp@pengutronix.de>
References: <1639741568-5846-1-git-send-email-hammer.hsieh@sunplus.com>
 <1639741568-5846-3-git-send-email-hammer.hsieh@sunplus.com>
 <20211217152839.vjzgvpha2shcitdj@pengutronix.de>
 <CAOX-t559nNt2YRqB030kRaBUtD9jUpPqG+6YN4+knDWdRMHcfw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cgprsrk5kixc7umm"
Content-Disposition: inline
In-Reply-To: <CAOX-t559nNt2YRqB030kRaBUtD9jUpPqG+6YN4+knDWdRMHcfw@mail.gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--cgprsrk5kixc7umm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Tue, Dec 21, 2021 at 02:28:24PM +0800, hammer hsieh wrote:
> Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> =E6=96=BC 2021=E5=
=B9=B412=E6=9C=8817=E6=97=A5 =E9=80=B1=E4=BA=94
> =E4=B8=8B=E5=8D=8811:28=E5=AF=AB=E9=81=93=EF=BC=9A
>=20
> > On Fri, Dec 17, 2021 at 07:46:08PM +0800, Hammer Hsieh wrote:
> > > Add Sunplus SoC PWM Driver
> > >
> > > Signed-off-by: Hammer Hsieh <hammer.hsieh@sunplus.com>
> > > ---
> > >  MAINTAINERS               |   1 +
> > >  drivers/pwm/Kconfig       |  11 +++
> > >  drivers/pwm/Makefile      |   1 +
> > >  drivers/pwm/pwm-sunplus.c | 192
> > ++++++++++++++++++++++++++++++++++++++++++++++
> > >  4 files changed, 205 insertions(+)
> > >  create mode 100644 drivers/pwm/pwm-sunplus.c
> > >
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index 721ed79..1c9e3c5 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -18246,6 +18246,7 @@ SUNPLUS PWM DRIVER
> > >  M:   Hammer Hsieh <hammer.hsieh@sunplus.com>
> > >  S:   Maintained
> > >  F:   Documentation/devicetree/bindings/pwm/pwm-sunplus.yaml
> > > +F:   drivers/pwm/pwm-sunplus.c
> > >
> > >  SUPERH
> > >  M:   Yoshinori Sato <ysato@users.sourceforge.jp>
> > > diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> > > index 21e3b05..9df5d5f 100644
> > > --- a/drivers/pwm/Kconfig
> > > +++ b/drivers/pwm/Kconfig
> > > @@ -526,6 +526,17 @@ config PWM_SPRD
> > >         To compile this driver as a module, choose M here: the module
> > >         will be called pwm-sprd.
> > >
> > > +config PWM_SUNPLUS
> > > +     tristate "Sunplus PWM support"
> > > +     depends on ARCH_SUNPLUS || COMPILE_TEST
> > > +     depends on HAS_IOMEM && OF
> > > +     help
> > > +       Generic PWM framework driver for the PWM controller on
> > > +       Sunplus SoCs.
> > > +
> > > +       To compile this driver as a module, choose M here: the module
> > > +       will be called pwm-sunplus.
> > > +
> > >  config PWM_STI
> > >       tristate "STiH4xx PWM support"
> > >       depends on ARCH_STI || COMPILE_TEST
> > > diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> > > index 708840b..be58616 100644
> > > --- a/drivers/pwm/Makefile
> > > +++ b/drivers/pwm/Makefile
> > > @@ -53,6 +53,7 @@ obj-$(CONFIG_PWM_STM32)             +=3D pwm-stm32.o
> > >  obj-$(CONFIG_PWM_STM32_LP)   +=3D pwm-stm32-lp.o
> > >  obj-$(CONFIG_PWM_STMPE)              +=3D pwm-stmpe.o
> > >  obj-$(CONFIG_PWM_SUN4I)              +=3D pwm-sun4i.o
> > > +obj-$(CONFIG_PWM_SUNPLUS)    +=3D pwm-sunplus.o
> > >  obj-$(CONFIG_PWM_TEGRA)              +=3D pwm-tegra.o
> > >  obj-$(CONFIG_PWM_TIECAP)     +=3D pwm-tiecap.o
> > >  obj-$(CONFIG_PWM_TIEHRPWM)   +=3D pwm-tiehrpwm.o
> > > diff --git a/drivers/pwm/pwm-sunplus.c b/drivers/pwm/pwm-sunplus.c
> > > new file mode 100644
> > > index 0000000..0ae59fc
> > > --- /dev/null
> > > +++ b/drivers/pwm/pwm-sunplus.c
> > > @@ -0,0 +1,192 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * PWM device driver for SUNPLUS SoCs
> > > + *
> > > + * Author: Hammer Hsieh <hammer.hsieh@sunplus.com>
> > > + */
> >
> > Please add a section here about your hardware limitations. Please stick
> > to the format used in e.g. pwm-sifive.c. That is a block starting with
> >
> >  * Limitations:
> >
> > and then a list of issues. One such item is: Only supports normal
> > polarity.
>
> ok, will add it.

Can you please fix your mailer to properly quote and mark your text
accordingly? (I fixed it up, so the above looks right, in your mail
however it doesn't.)

> > > +#include <linux/clk.h>
> > > +#include <linux/io.h>
> > > +#include <linux/kernel.h>
> > > +#include <linux/module.h>
> > > +#include <linux/platform_device.h>
> > > +#include <linux/pwm.h>
> > > +
> > > +#define PWM_SUP_CONTROL0     0x000
> > > +#define PWM_SUP_CONTROL1     0x004
> > > +#define PWM_SUP_FREQ_BASE    0x008
> > > +#define PWM_SUP_DUTY_BASE    0x018
> > > +#define PWM_SUP_FREQ(ch)     (PWM_SUP_FREQ_BASE + 4 * (ch))
> > > +#define PWM_SUP_DUTY(ch)     (PWM_SUP_DUTY_BASE + 4 * (ch))
> > > +#define PWM_SUP_FREQ_MAX     GENMASK(15, 0)
> > > +#define PWM_SUP_DUTY_MAX     GENMASK(7, 0)
> > > +
> > > +#define PWM_SUP_NUM          4
> > > +#define PWM_BYPASS_BIT_SHIFT 8
> > > +#define PWM_DD_SEL_BIT_SHIFT 8
> > > +#define PWM_SUP_FREQ_SCALER  256
> > > +
> > > +struct sunplus_pwm {
> > > +     struct pwm_chip chip;
> > > +     void __iomem *base;
> > > +     struct clk *clk;
> > > +};
> > > +
> > > +static inline struct sunplus_pwm *to_sunplus_pwm(struct pwm_chip *ch=
ip)
> > > +{
> > > +     return container_of(chip, struct sunplus_pwm, chip);
> > > +}
> > > +
> > > +static void sunplus_reg_init(void __iomem *base)
> > > +{
> > > +     u32 i, value;
> > > +
> > > +     /* turn off all pwm channel output */
> > > +     value =3D readl(base + PWM_SUP_CONTROL0);
> > > +     value &=3D ~GENMASK((PWM_SUP_NUM - 1), 0);
> > > +     writel(value, base + PWM_SUP_CONTROL0);
> > > +
> > > +     /* init all pwm channel clock source */
> > > +     value =3D readl(base + PWM_SUP_CONTROL1);
> > > +     value |=3D GENMASK((PWM_SUP_NUM - 1), 0);
> > > +     writel(value, base + PWM_SUP_CONTROL1);
> > > +
> > > +     /* init all freq and duty setting */
> > > +     for (i =3D 0; i < PWM_SUP_NUM; i++) {
> > > +             writel(0, base + PWM_SUP_FREQ(i));
> > > +             writel(0, base + PWM_SUP_DUTY(i));
> > > +     }
> >
> > Please keep the PWM in their boot-up state. That is, if the bootloader
> > enabled a display with a bootsplash, don't disable the backlight when
> > the PWM driver loads.
>
> ok, will remove the init register code.
>=20
>=20
> > > +}
> > > +
> > > +static int sunplus_pwm_apply(struct pwm_chip *chip, struct pwm_device
> > *pwm,
> > > +                          const struct pwm_state *state)
> > > +{
> > > +     struct sunplus_pwm *priv =3D to_sunplus_pwm(chip);
> > > +     u32 period_ns, duty_ns, value;
> > > +     u32 dd_freq, duty;
> > > +     u64 tmp;
> > > +
> >
> >         if (state->polarity !=3D PWM_POLARITY_NORMAL)
> >                 return -EINVAL;
> >
> > > +     if (!state->enabled) {
> > > +             value =3D readl(priv->base + PWM_SUP_CONTROL0);
> > > +             value &=3D ~BIT(pwm->hwpwm);
> > > +             writel(value, priv->base + PWM_SUP_CONTROL0);
> > > +             return 0;
> > > +     }
> > > +
> > > +     period_ns =3D state->period;
> >
> > state->period is an u64, so you might loose precision here.
> >
> > > +     duty_ns =3D state->duty_cycle;
> >
> > ditto
> >
> > > +
> > > +     /* cal pwm freq and check value under range */
> > > +     tmp =3D clk_get_rate(priv->clk) * (u64)period_ns;
> >
> > This might overflow?
> >
> > > +     tmp =3D DIV_ROUND_CLOSEST_ULL(tmp, NSEC_PER_SEC);
> > > +     tmp =3D DIV_ROUND_CLOSEST_ULL(tmp, PWM_SUP_FREQ_SCALER);
> >
> > In general you should pick the highest period that isn't bigger than the
> > requested period. I didn't check in detail, but using round-closest is a
> > strong hint that you get that wrong.
> >
> > > +     dd_freq =3D (u32)tmp;
> > > +
> > > +     if (dd_freq =3D=3D 0)
> > > +             return -EINVAL;
> > > +
> > > +     if (dd_freq > PWM_SUP_FREQ_MAX)
> > > +             dd_freq =3D PWM_SUP_FREQ_MAX;
> > > +
> > > +     writel(dd_freq, priv->base + PWM_SUP_FREQ(pwm->hwpwm));
> > > +
> > > +     /* cal and set pwm duty */
> > > +     value =3D readl(priv->base + PWM_SUP_CONTROL0);
> > > +     value |=3D BIT(pwm->hwpwm);
> > > +     if (duty_ns =3D=3D period_ns) {
> > > +             value |=3D BIT(pwm->hwpwm + PWM_BYPASS_BIT_SHIFT);
> > > +             duty =3D PWM_SUP_DUTY_MAX;
> > > +     } else {
> > > +             value &=3D ~BIT(pwm->hwpwm + PWM_BYPASS_BIT_SHIFT);
> > > +             tmp =3D (u64)duty_ns * PWM_SUP_FREQ_SCALER + (period_ns=
 >>
> > 1);
> > > +             tmp =3D DIV_ROUND_CLOSEST_ULL(tmp, (u64)period_ns);
> > > +             duty =3D (u32)tmp;
> > > +             duty |=3D (pwm->hwpwm << PWM_DD_SEL_BIT_SHIFT);
> >
> > This is also more inexact than necessary. In general don't use period_ns
> > in the calculation of duty register settings. As with period you're
> > supposed to pick the biggest possible dutycycle not bigger than the
> > requested value.
> >
> > Consider a PWM that with register P =3D P and register D =3D D implemen=
ts a
> > PWM output with period =3D 1000 * P ns and duty_cycle =3D 1000 * D ns
> >
> > For a request of period =3D 39900 and duty_cycle =3D 12100, you have to=
 pick
> > P =3D 39 and D =3D 12. However P * duty_ns / period_ns =3D 11.82 ...
> >
> >
> static int sunplus_pwm_apply(struct pwm_chip *chip, struct pwm_device *pw=
m,
>     const struct pwm_state *state)
> {
>   struct sunplus_pwm *priv =3D to_sunplus_pwm(chip);
>   u32 dd_freq, duty, value, value1;
>   u64 period_ns, duty_ns, tmp;
>   u64 period_ns_max;
>=20
>   if (state->polarity !=3D pwm->state.polarity)
>     return -EINVAL;
>=20
>   if (!state->enabled) {
>   /* disable pwm channel output */
>   value =3D readl(priv->base + PWM_SUP_CONTROL0);
>   value &=3D ~BIT(pwm->hwpwm);
>   writel(value, priv->base + PWM_SUP_CONTROL0);
>   /* disable pwm channel clk source */
>   value =3D readl(priv->base + PWM_SUP_CONTROL1);
>   value &=3D ~BIT(pwm->hwpwm);
>   writel(value, priv->base + PWM_SUP_CONTROL1);
>   return 0;
>   }
>=20
>   tmp =3D PWM_SUP_FREQ_SCALER * NSEC_PER_SEC;
>   tmp =3D DIV64_U64_ROUND_CLOSEST(tmp, clk_get_rate(priv->clk));
>   period_ns_max =3D PWM_SUP_FREQ_MAX * tmp;
>=20
>   if (state->period > period_ns_max)
>   return -EINVAL;
>=20
>   period_ns =3D state->period;
>   duty_ns =3D state->duty_cycle;
>=20
>  /* cal pwm freq and check value under range */
>   tmp =3D DIV64_U64_ROUND_CLOSEST(clk_get_rate(priv->clk),
> PWM_SUP_FREQ_SCALER);
>   tmp =3D tmp * period_ns >> 10;
>   tmp =3D DIV64_U64_ROUND_CLOSEST(tmp, NSEC_PER_SEC >> 10);
>   dd_freq =3D (u32)tmp;
>=20
>   if (dd_freq =3D=3D 0)
>   return -EINVAL;
>=20
>   if (dd_freq > PWM_SUP_FREQ_MAX)
>     dd_freq =3D PWM_SUP_FREQ_MAX;
>=20
>   writel(dd_freq, priv->base + PWM_SUP_FREQ(pwm->hwpwm));
>=20
>   /* cal and set pwm duty */
>   value =3D readl(priv->base + PWM_SUP_CONTROL0);
>   value |=3D BIT(pwm->hwpwm);
>   value1 =3D readl(priv->base + PWM_SUP_CONTROL1);
>   value1 |=3D BIT(pwm->hwpwm);
>   if (duty_ns =3D=3D period_ns) {
>     value |=3D BIT(pwm->hwpwm + PWM_BYPASS_BIT_SHIFT);
>     duty =3D PWM_SUP_DUTY_MAX;
>   } else {
>   value &=3D ~BIT(pwm->hwpwm + PWM_BYPASS_BIT_SHIFT);
>   tmp =3D (duty_ns >> 10) * PWM_SUP_FREQ_SCALER;
>   tmp =3D DIV64_U64_ROUND_CLOSEST(tmp, (period_ns >> 10));
>   duty =3D (u32)tmp;
>   duty |=3D (pwm->hwpwm << PWM_DD_SEL_BIT_SHIFT);
>   }
>   writel(value, priv->base + PWM_SUP_CONTROL0);
>   writel(value1, priv->base + PWM_SUP_CONTROL1);
>   writel(duty, priv->base + PWM_SUP_DUTY(pwm->hwpwm));
>=20
>   return 0;
> }

This is badly indented, I'm delaying review until the next patch.

> while turn on PWM_DEBUG.
> I still get warning message like
> sunplus-pwm 9c007a00.pwm: .apply is not idempotent (ena=3D1 pol=3D0
> 9998240/19996480)->(ena=3D1 pol=3D0 9996976/19993952)

After you applied a setting the debug code calls .get_state and applies
its result. The problem is that applying
duty_cycle =3D 9998240 + period =3D 19996480 yields duty_cycle =3D 9996976 +
period =3D 19993952 though there should be an exact match.

There is still a ROUND_CLOSEST in your .apply callback ... that probably
cannot implement "pick the biggest possible period not bigger than the
rquested period".

> echo 20000000 > period
> echo 10000000 > duty_cycle
> echo 1 > enable
> I'm not sure it's a issue or not?
> get_state calculate reg value to state->period and state->duty_cycle.
> apply calculate state->period and state->duty_cycle to reg value.
> Can't match always.

Yes, it's not a 1:1 relation. If however applying

	period =3D $pa
	duty_cycle =3D $da

yields a state with

	period =3D $pr
	duty_cycle =3D $dr

then applying $dr / $pr should give an exact match.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig         =
   |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--cgprsrk5kixc7umm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmHBm+MACgkQwfwUeK3K
7Al0gwgAiYLRdVgJIUicMMLkQfSVW/K4VPdQCHUQMzZs3soUk2Zv2kMbqwodzqrd
3LwWbFRmvJTUQGvxLBUijkxtQDRpTyrCF39lu/Wx35bENtr3Aqe+UtHuFm4JBfLR
UwVe6/ijHMVgd3XMve+2QAFX4qUqrFIPKmcFC8wujlEp45+nz2jGTkJMdGVyqVgR
ySlcxzV7Wn1Atlbb+4fqqQGLYKhKHyrQAWbNXWLnOBRPHbWIrXnS3siLI6LSqp6+
duMYVhBNxHO/DeSPaJvqiJcpquNGvhbFaCsE8xduaDS/W4imotK/n74H2tfIfW5X
dSN/xjC70NAixcWu36+vzC13NCtiHg==
=1lLl
-----END PGP SIGNATURE-----

--cgprsrk5kixc7umm--
