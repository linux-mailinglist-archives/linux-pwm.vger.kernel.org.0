Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 996052C7A60
	for <lists+linux-pwm@lfdr.de>; Sun, 29 Nov 2020 18:51:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728226AbgK2RvO (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 29 Nov 2020 12:51:14 -0500
Received: from mout.gmx.net ([212.227.17.20]:42665 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726470AbgK2RvO (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sun, 29 Nov 2020 12:51:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1606672133;
        bh=q5EfoxNx3GvtONQ7tlxc5ju4+UKEtK3w/Aju5T/lU34=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=Gts6FsyCRBclIgLeMbu+ykktP0TVR2B5D9ViHP8xcHK/0SV367mIvdY9ji1ZkI9k7
         rUmxbpLN17ZnIGzFMpCO6WWWwl+EMyuTicJ13EmKPrS/w8ZSJDCe7ceHDjWJp5t1N3
         Dp28OQe31+RnsjaNTGYA2Jm7G/Gfvnpwq8i/zpew=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([37.201.214.162]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M26vB-1klLYq2i1h-002VfI; Sun, 29
 Nov 2020 18:48:53 +0100
Date:   Sun, 29 Nov 2020 18:48:43 +0100
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Mark Brown <broonie@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>, linux-rtc@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Daniel Palmer <daniel@0x0f.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Andreas Kemnade <andreas@kemnade.info>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-pwm@vger.kernel.org, Stephan Gerhold <stephan@gerhold.net>,
        allen <allen.chen@ite.com.tw>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Josua Mayer <josua.mayer@jm0.eu>,
        Shawn Guo <shawnguo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH v4 4/7] pwm: ntxec: Add driver for PWM function in
 Netronix EC
Message-ID: <20201129174843.GF456020@latitude>
References: <20201122222739.1455132-1-j.neuschaefer@gmx.net>
 <20201122222739.1455132-5-j.neuschaefer@gmx.net>
 <20201124082019.vpkr3xnp55arjpnp@pengutronix.de>
 <20201126231931.GE456020@latitude>
 <20201127071105.k2rb4iykeqevbao5@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="o0ZfoUVt4BxPQnbU"
Content-Disposition: inline
In-Reply-To: <20201127071105.k2rb4iykeqevbao5@pengutronix.de>
X-Provags-ID: V03:K1:yZA5pcBjayKfsaxQ10SfBrM5TtDKdp9YyH3brKYnvC8zSTMCWqx
 h0UaKAduTVL83Gr5kOuKiX4XYYsAUiszORA1/rugd6Na78VA4FYZ4JTiuhVU7BbuVEsSIpJ
 100aI3LX+F30cUiLSNnMzKeZVS5eS+M+e0Rb0ykW2sIKcX/Q1g0V8GhnvF1oDTpO+uWjqh5
 fkeIuG8MVZVukVfY2XOyg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:M+Qcdze4yRY=:6JxxKN0ysRb87ucwiWXXLY
 swxGPxXnUJUAs391j0nHMvRjcgdmD0w4+fAauujDWIe1JD9Dd4gc7BhllY+AA1sLumM1IG8EJ
 RALnpXvJbh2/4ZZ5z9XvGRm4liw1xddf8y2F3svKn3KVefZW86dY/mzPEYyj4J6IFveUK/y3O
 quY64o3L2y2iTiAY/I8fgmeOEWJ8juNkB//SAZ16DnMF/yyeHO561iMHh8hO5vfr2tGNCy6jK
 nnI1lyiPdgrp3cIIfvqKGLmBaZJ40U26SVUy2vTCQ+oxg8AzDsl75RiQcJL/xgsIrqEVh/Plo
 2+mtlMn/cOaLSV/4ka1QyojdmemXYrVv5oRsNVOzv57/9+johssutH5ll1Dp7XslH+v74mnVR
 gI79cahkevbD9e8QjJW6wAq7YHiv+mKwr2YD/34yj9bLFYqwyGyWETYoMlARMPsiluHIzSjMv
 T1kP/C2Jvhk5Wn9hojRMVD2f0t5P6sPh1ZI+Q+EMCcF5PLxxa/nbtKXLy6cNj+LpFg2wJR7ns
 zIWseKjMWUFnpc7TG+LjKW/V/hJ/oTNmALWsclbC6I1C2CS8//HlPMMKrugBtSGHfqiFVHz0T
 JsicR7Rkg4R1LChi998PSbZhIo1r/yTMSm1pberGgl03vGMQdi6XqGXaqEPS+SnOMdVZQGp0M
 /w+0EfPFgeyzmxBlA5ZkDvaR6IwlLI6C5KEmUFeEBeh/0JFLSpKkEiMSscyCh+3at95VRpnuR
 yUEFJWrWl/j2DDQyh18HIFjeAq4sQVq73iUUjfLCAoJiYQAwfdjFGgtv5Mr9hu5sK+lErpjXj
 RzIRZbJcbgWM+v512HhnJ03AgF0gZtdqbVuKFa0a5AX8OZsv9997wVVqUtYEnCIkmcXG+j725
 S//VM3O+OWENLmLgmdBg==
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--o0ZfoUVt4BxPQnbU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 27, 2020 at 08:11:05AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> Hello Jonathan,
>=20
> On Fri, Nov 27, 2020 at 12:19:31AM +0100, Jonathan Neusch=C3=A4fer wrote:
> > On Tue, Nov 24, 2020 at 09:20:19AM +0100, Uwe Kleine-K=C3=B6nig wrote:
[...]
> > > state->duty_cycle and state->period are u64, so you're losing
> > > information here. Consider state->duty_cycle =3D 0x100000001 and
> > > state->period =3D 0x200000001.
> >=20
> > Oh, good point, I didn't notice the truncation.
> >=20
> > The reason I picked unsigned int was to avoid a 64-bit division;
> > I suppose I can do something like this:
> >=20
> >     period =3D (u32)period / TIME_BASE_NS;
> >     duty =3D (u32)duty / TIME_BASE_NS;
>=20
> You can do that after you checked period > MAX_PERIOD_NS below, yes.
> Something like:
>=20
> 	if (state->polarity !=3D PWM_POLARITY_NORMAL)
> 		return -EINVAL;
>=20
> 	if (state->period > MAX_PERIOD_NS) {
> 		period =3D MAX_PERIOD_NS;
> 	else
> 		period =3D state->period;
>=20
> 	if (state->duty_cycle > period)
> 		duty_cycle =3D period;
> 	else
> 		duty_cycle =3D state->duty_cycle;
>=20
> should work with even keeping the local variables as unsigned int.

With the min_t() macro, this becomes nice and short:

	 period =3D min_t(u64, state->period, MAX_PERIOD_NS);
	 duty   =3D min_t(u64, state->duty_cycle, period);

	 period /=3D TIME_BASE_NS;
	 duty   /=3D TIME_BASE_NS;


> > > I think I already asked, but I don't remember the reply: What happens=
 to
> > > the output between these writes? A comment here about this would be
> > > suitable.
> >=20
> > I will add something like the following:
> >=20
> > /*
> >  * Changes to the period and duty cycle take effect as soon as the
> >  * corresponding low byte is written, so the hardware may be configured
> >  * to an inconsistent state after the period is written and before the
> >  * duty cycle is fully written. If, in such a case, the old duty cycle
> >  * is longer than the new period, the EC will output 100% for a moment.
> >  */
>=20
> Is the value pair taken over by hardware atomically? That is, is it
> really "will" in your last line, or only "might". (E.g. when changing
> from duty_cycle, period =3D 1000, 2000 to 500, 800 and a new cycle begins
> after reducing period, the new duty_cycle is probably written before the
> counter reaches 500. Do we get a 100% cycle here?)

I am not sure when exactly a new period or duty cycle value is applied,
and I don't have the test equipment to measure it. I'll change the text
to "may output 100%".

> Other than that the info is fine. Make sure to point this out in the
> Limitations paragraph at the top of the driver please, too.

Okay.


> > > /*
> > >  * The current state cannot be read out, so there is no .get_state
> > >  * callback.
> > >  */
> > >=20
> > > Hmm, at least you could provice a .get_state() callback that reports =
the
> > > setting that was actually implemented for in the last call to .apply(=
)?
> >=20
> > Yes... I see two options:
> >=20
> > 1. Caching the state in the driver's private struct. I'm not completely
> >    convinced of the value, given that the information is mostly
> >    available in the PWM core already (except for the adjustments that
> >    the driver makes).
> >=20
> > 2. Writing the adjusted state back into pwm_dev->state (via pwm_set_*).
> >    This seems a bit dirty.
>=20
> 2. isn't a good option. Maybe regmap caches this stuff anyhow for 1. (or
> can be made doing that)?

With regmap caching, I'd be concerned that a read operation may slip
through and reach the device, producing a bogus result. Not sure if
write-only/write-through caching can be configured in regmap.


Thanks,
Jonathan

--o0ZfoUVt4BxPQnbU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAl/D3vAACgkQCDBEmo7z
X9t1kA//Rr2iUNp6uHCpqNEZM8RTiPQXN3QbeqMwR17sfoIUcaVl5lT0gD949Ea8
VbzZAp+3xPIlkGjs6JvjpDm9VVEM1jIV78+SVdvbAf7jW6g4WoM+xsSpCz1oD3QK
MU2M6v/hkW51EaTB05SKxYWVNkHrEYcxjLv2pjuBE/WP7MATjX1CzksJ8y3QSrYc
4j4os/8/ulznBElr1epcNr+IpMEotlV6JT7W+CQzW1Zj2ASOJjUjy9uUGBcOUUfH
v7Sfe/SFS0Dniy6GDaBQj0r13rRGyevR+TQBRUcrrIogEn8rc51KDMZW1FvAp1Sw
+a/ZURqwce2YP03FuFxMoJhePJRfqxXIQ82/BG51sE6MwnVwNls4dDIZGlHMzfPD
crmjBo0Tk3G2WMQIiPtJoRbKNLqQ3J+RoU4+P0ch0eQcvrOqzn54wJpVAPE1/aHl
lWFa5bzXUTdSxVoHzBu5iNcUnlVp4J8USdo59u/l0Sj7ZLnXRtrJQL58Xkf0yh9m
VtyK02UJ7m9YfwtCo6j8yqk1/uJ1PlqyABrYgMOMtUDcUXKBLgnjB+vu+x/NLtEu
Mwd8vA6dJYL6rATyv4l90Aagh97wjnTy9WjdgydXv/5kyEPzbGmihsGcX07/tcCc
qiLeT9MG0S0a2/TKef6MfDMOEBszXiQ9jbCkHIBTQW3nCBGYGRE=
=eiSy
-----END PGP SIGNATURE-----

--o0ZfoUVt4BxPQnbU--
