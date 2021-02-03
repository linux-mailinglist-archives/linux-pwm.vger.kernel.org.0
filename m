Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFEF130E484
	for <lists+linux-pwm@lfdr.de>; Wed,  3 Feb 2021 22:01:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232394AbhBCVAN (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 3 Feb 2021 16:00:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231963AbhBCU75 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 3 Feb 2021 15:59:57 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D51CC061786
        for <linux-pwm@vger.kernel.org>; Wed,  3 Feb 2021 12:59:17 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1l7PF4-0004aP-6a; Wed, 03 Feb 2021 21:59:14 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1l7PF3-0001Si-9a; Wed, 03 Feb 2021 21:59:13 +0100
Date:   Wed, 3 Feb 2021 21:59:13 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Ban Tao <fengzheng923@gmail.com>
Cc:     linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        mripard@kernel.org, wens@csie.org, kernel@pengutronix.de
Subject: Re: [PATCH v2] pwm: sunxi: Add Allwinner SoC PWM controller driver
Message-ID: <20210203205913.dvmppahnkmcj2dac@pengutronix.de>
References: <20210203125317.1975-1-fengzheng923@gmail.com>
 <20210203151200.fdzzq23teoypbxad@pengutronix.de>
 <YBrQTM5iADZgA2v1@ulmo>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cnkbjtn2mnqxloiw"
Content-Disposition: inline
In-Reply-To: <YBrQTM5iADZgA2v1@ulmo>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--cnkbjtn2mnqxloiw
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Thierry, hello Ban,

On Wed, Feb 03, 2021 at 05:33:16PM +0100, Thierry Reding wrote:
> On Wed, Feb 03, 2021 at 04:12:00PM +0100, Uwe Kleine-K=F6nig wrote:
> > On Wed, Feb 03, 2021 at 08:53:17PM +0800, Ban Tao wrote:
> [...]
> > > +#define PWM_GET_CLK_OFFSET(chan)	(0x20 + ((chan >> 1) * 0x4))
> > > +#define PWM_CLK_APB_SCR			BIT(7)
> > > +#define PWM_DIV_M			0
> > > +#define PWM_DIV_M_WIDTH			0x4
> > > +
> > > +#define PWM_CLK_REG			0x40
> > > +#define PWM_CLK_GATING			BIT(0)
> > > +
> > > +#define PWM_ENABLE_REG			0x80
> > > +#define PWM_EN				BIT(0)
> > > +
> > > +#define PWM_CTL_REG(chan)		(0x100 + 0x20 * chan)
> > > +#define PWM_ACT_STA			BIT(8)
> > > +#define PWM_PRESCAL_K			0
> > > +#define PWM_PRESCAL_K_WIDTH		0x8
> > > +
> > > +#define PWM_PERIOD_REG(chan)		(0x104 + 0x20 * chan)
> > > +#define PWM_ENTIRE_CYCLE		16
> > > +#define PWM_ENTIRE_CYCLE_WIDTH		0x10
> > > +#define PWM_ACT_CYCLE			0
> > > +#define PWM_ACT_CYCLE_WIDTH		0x10
> >=20
> > Please use a driver specific prefix for these defines.
>=20
> These are nice and to the point, so I think it'd be fine to leave these
> as-is. Unless of course if they conflict with something from the PWM
> core, which I don't think any of these do.

In my eyes PWM_CLK_REG, PWM_CLK_GATING, PWM_ENABLE_REG and PWM_EN are
not so nice. pwm-sun4i.c has already PWM_EN, pwm-mtk-disp.c has
DISP_PWM_EN, pwm-zx.c has ZX_PWM_EN, pwm-berlin.c has BERLIN_PWM_EN.
Luckily most of them already use a prefix. So it doesn't conflict with
the core, but might with other drivers. And also if you only care about
conflicts with the core, using a prefix is the future-proof strategy.
For tools like ctags and cscope a unique name is great, too.

Also comparing

	tmp |=3D BIT_CH(PWM_EN, pwm->hwpwm);

with (say)

	tmp |=3D BIT_CH(SUN5I_PWM_PWM_EN, pwm->hwpwm);

I prefer the latter as it is obvious that this is a driver specific
constant.

Having said that, I'm also a fan of having the register name in the bit
field define to simplify spotting errors like 4b75f8000361 ("serial:
imx: Fix DCD reading").

So looking at:

+       /* disable pwm controller */
+       tmp =3D sun50i_pwm_readl(sun50i_pwm, PWM_ENABLE_REG);
+       tmp &=3D ~BIT_CH(PWM_EN, pwm->hwpwm);
+       sun50i_pwm_writel(sun50i_pwm, tmp, PWM_ENABLE_REG);

my preferred version would be instead:

+       /* disable pwm controller */
+       enable =3D sun50i_pwm_readl(sun50i_pwm, SUN50I_REG_PWM_ENABLE);
+       enable &=3D ~SUN50I_REG_PWM_ENABLE_EN(pwm->hwpwm);
+       sun50i_pwm_writel(sun50i_pwm, enable, SUN50I_REG_PWM_ENABLE);

where variable name, register name and bitfield name are obviously
matching.

> > > +struct sun50i_pwm_data {
> > > +	unsigned int npwm;
> > > +};
> > > +
> > > +struct sun50i_pwm_chip {
> > > +	struct pwm_chip chip;
> > > +	struct clk *clk;
> > > +	struct reset_control *rst_clk;
> > > +	void __iomem *base;
> > > +	const struct sun50i_pwm_data *data;
> > > +};
> > > +
> > > +static inline struct sun50i_pwm_chip *sun50i_pwm_from_chip(struct pw=
m_chip *chip)
> > > +{
> > > +	return container_of(chip, struct sun50i_pwm_chip, chip);
> > > +}
>=20
> I wanted to reply to Uwe's comment on v1 but you sent this before I got
> around to it, so I'll mention it here. I recognize the usefulness of
> having a common prefix for function names, though admittedly it's not
> totally necessary in these drivers because these are all local symbols.
> But it does makes things a bit consistent and helps when looking at
> backtraces and such, so that's all good.
>=20
> That said, I consider these casting helpers a bit of a special case
> because they usually won't show up in backtraces, or anywhere else for
> that matter. Traditionally these have been named to_*(), so it'd be
> entirely consistent to keep doing that.
>=20
> But I don't have any strong objections to this variant either, so pick
> whichever you want. Although, please, nobody take that as a hint that
> any existing helpers should be converted.

@Thierry: I don't understand your motivation to write this. For me
consistence is a quite important aspect. Obviously for you it's less so
and the code presented here over-fulfils your standards. So everything
is fine as is, isn't it?

I think using a rule like "A common prefix for driver specific functions"
consistently is easier than allowing some exceptions. There is no gain
in not using the prefix, so IMHO keep the rules simple without
exceptions.

> [...]
> > > +static int sun50i_pwm_probe(struct platform_device *pdev)
> > > +{
> > > +	struct sun50i_pwm_chip *pwm;
> >=20
> > "pwm" isn't a good name, in PWM code this name is usually used for
> > struct pwm_device pointers (and sometimes the global pwm id). I usually
> > use "ddata" for driver data (and would have called "sun50i_pwm_chip"
> > "sun50i_pwm_ddata" instead). Another common name is "priv".
>=20
> This driver already declares sun50i_pwm_data for per-SoC data, so having
> a struct sun50i_pwm_ddata would just be confusing.

Agreed. So maybe pick a better name for sun50i_pwm_data; my suggestion
would be sun50i_pwm_soc_info.

> sun50i_pwm_chip is consistent with what other drivers name this, so I
> think that's fine.

Either the name is good, then this alone justifies to use it. If however
the name is bad, it IMHO doesn't matter if others use the same bad
naming scheme and you better don't use it. So please don't let us
consider it a good name *only* because it's used in several other
places.

@Ban: You see Thierry and I don't agree in every aspect. So please take
the feedback you get from us as cause for thought and then try to come
up with a v3 with choices you can justify.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--cnkbjtn2mnqxloiw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmAbDp4ACgkQwfwUeK3K
7AnekAf7BqfAWUcGh30G1jKekk2BUgMaHdj/otMHwLUZ5Y9f+9PsQgpg0E+wl8J1
LrdWA6wAp8ejVmho8Cpoxm+BvnIxM6msm51pyTxNdttL0z+oob1lEYi/FiCoKHX8
LU6wu4v2PlEdwPAPH3c3uDuy2DzvBQCrJ3riRff6IQI6gjMSnIicqwmz3m7mYfXd
IJ8HAir3MgvwIJvE0AbXBEEspWEjgFzfS2Cm86AaGC5ib/J66WDK2NOwgCekK3zY
yfd42xqid45JXIClzEdVT/hwlgeGfbqIxgk+3wGWqP02YBnTs7XGq8B0e56aBzkv
ID5f9QCVk+l7LUoht9IJ65sSwpcPuw==
=n0pZ
-----END PGP SIGNATURE-----

--cnkbjtn2mnqxloiw--
