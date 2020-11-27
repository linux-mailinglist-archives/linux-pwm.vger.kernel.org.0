Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 851A02C6395
	for <lists+linux-pwm@lfdr.de>; Fri, 27 Nov 2020 12:09:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbgK0LI4 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 27 Nov 2020 06:08:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725980AbgK0LI4 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 27 Nov 2020 06:08:56 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0E8FC0613D1;
        Fri, 27 Nov 2020 03:08:55 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id g14so5122424wrm.13;
        Fri, 27 Nov 2020 03:08:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QjRDfMPweD6TnATMeNMos4uBwL7p9ymlFrh/9upwgRc=;
        b=HJoqcXgK6WHPbgEvMPUriavUvdQsRXSEs6pQE+5wZK1NK0PvXVxBU24674ewWWIJdv
         NOr72GHy8amT/EgimKq7J6jB4RgJToNX5D5FXXsQhgB2Ce88Frcvp6Ntrac7xZ82MDr/
         /5KZXkfvLXs+lD3tObHeVlP1K2V5UIAh8NuYV2EfwlRskGHzlkWnkYUEGzl21JYUpp2K
         F+ba8CFbmCAddEy8y3gUWWVa183J62HMasXKqjGRM8iIqstOKR8skfg7J/imWEk3nTxP
         fb088a+4sYREY0P8hJgALibB/2t8ng/IFMrv8Es1yj5i/xQCiKM0KF3gwJIMa9iUUD7b
         whgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QjRDfMPweD6TnATMeNMos4uBwL7p9ymlFrh/9upwgRc=;
        b=AqFI/Cj1BnvSLon/DfpyvqCP7ecWSMX/WKiFAgD4jXUK2Jo2iD20zxhz4osixvdxtC
         Wf1R7Bd7lF/1zcMHUszOgr6U2ajyv7ghqv//ektGJ5uym+OMvDwW6Ug487WCZDKT1mmY
         ZPJ2jS3VWOcU9LtFF4TlXCOSu3mjH0S3YBhxkNdGTbQJY/kLsPQ8sB96+H3Ek1TnCxzk
         roogxuRJ/7EC3m25JzjRqjzO3fTCc2xSKESbTcNfl6PhstnXi1waL8Nv4u+nlWY4aYRW
         UecrsOpFdO7LE4jCqPd+EaOjDICHkuh8I1bq2QZ6p6EK5jACEIYG37XBhM6dj0/O3M3W
         MoYw==
X-Gm-Message-State: AOAM533IeISB1qxAULiuPoBaj3AMeerHD7IpxeZlVRkBLg3uWyA/d59D
        gYjfmRif8ysFTRLCWGaaLbY=
X-Google-Smtp-Source: ABdhPJwIsRftLeMWAAsh9hQ6v1m8ElZiRMQU1jEK2vOFez0QVkJpFWmbP4CjnJFPgs48nBtC8ZtLzw==
X-Received: by 2002:adf:ed04:: with SMTP id a4mr9644479wro.172.1606475334437;
        Fri, 27 Nov 2020 03:08:54 -0800 (PST)
Received: from localhost ([217.111.27.204])
        by smtp.gmail.com with ESMTPSA id w15sm14073923wrp.52.2020.11.27.03.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 03:08:53 -0800 (PST)
Date:   Fri, 27 Nov 2020 12:08:51 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Mark Brown <broonie@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
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
Message-ID: <X8DeQ7IWjSV5Jtic@ulmo>
References: <20201122222739.1455132-1-j.neuschaefer@gmx.net>
 <20201122222739.1455132-5-j.neuschaefer@gmx.net>
 <20201124082019.vpkr3xnp55arjpnp@pengutronix.de>
 <20201126231931.GE456020@latitude>
 <20201127071105.k2rb4iykeqevbao5@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ixVrwD0k1fxTKBEk"
Content-Disposition: inline
In-Reply-To: <20201127071105.k2rb4iykeqevbao5@pengutronix.de>
User-Agent: Mutt/2.0.2 (d9268908) (2020-11-20)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--ixVrwD0k1fxTKBEk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 27, 2020 at 08:11:05AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> Hello Jonathan,
>=20
> On Fri, Nov 27, 2020 at 12:19:31AM +0100, Jonathan Neusch=C3=A4fer wrote:
> > On Tue, Nov 24, 2020 at 09:20:19AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> > > On Sun, Nov 22, 2020 at 11:27:36PM +0100, Jonathan Neusch=C3=A4fer wr=
ote:
> > [...]
> > > > +/*
> > > > + * The time base used in the EC is 8MHz, or 125ns. Period and duty=
 cycle are
> > > > + * measured in this unit.
> > > > + */
> > > > +#define TIME_BASE_NS 125
> > > > +
> > > > +/*
> > > > + * The maximum input value (in nanoseconds) is determined by the t=
ime base and
> > > > + * the range of the hardware registers that hold the converted val=
ue.
> > > > + * It fits into 32 bits, so we can do our calculations in 32 bits =
as well.
> > > > + */
> > > > +#define MAX_PERIOD_NS (TIME_BASE_NS * 0xffff)
> > > > +
> > > > +static int ntxec_pwm_apply(struct pwm_chip *chip, struct pwm_devic=
e *pwm_dev,
> > > > +			   const struct pwm_state *state)
> > > > +{
> > > > +	struct ntxec_pwm *priv =3D pwmchip_to_priv(pwm_dev->chip);
> > > > +	unsigned int duty =3D state->duty_cycle;
> > > > +	unsigned int period =3D state->period;
> > >=20
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
>=20
> > > > +	int res =3D 0;
> > > > +
> > > > +	if (state->polarity !=3D PWM_POLARITY_NORMAL)
> > > > +		return -EINVAL;
> > > > +
> > > > +	if (period > MAX_PERIOD_NS) {
> > > > +		period =3D MAX_PERIOD_NS;
> > > > +
> > > > +		if (duty > period)
> > > > +			duty =3D period;
> > > > +	}
> > > > +
> > > > +	period /=3D TIME_BASE_NS;
> > > > +	duty /=3D TIME_BASE_NS;
> > > > +
> > > > +	res =3D regmap_write(priv->ec->regmap, NTXEC_REG_PERIOD_HIGH, ntx=
ec_reg8(period >> 8));
> > > > +	if (res)
> > > > +		return res;
> > >=20
> > > I wonder if you can add some logic to the regmap in the mfd driver su=
ch
> > > that ntxec_reg8 isn't necessary for all users.
> >=20
> > I think that would involve:
> >=20
> > 1. adding custom register access functions to the regmap, which decide
> >    based on the register number whether a register needs 8-bit or 16-bit
> >    access. So far I have avoided information about registers into the
> >    main driver, when the registers are only used in the sub-drivers.
> >=20
> > or
> >=20
> > 2. switching the regmap configuration to little endian, which would be
> >    advantageous for 8-bit registers, inconsequential for 16-bit
> >    registers that consist of independent high and low halves, and wrong
> >    for the 16-bit registers 0x41, which reads the battery voltage ADC
> >    value. It is also different from how the vendor kernel treats 16-bit
> >    registers.
> >=20
> > Perhaps there is another option that I haven't considered yet.
>=20
> I don't know enough about regmap to teach you something here. But maybe
> Mark has an idea. (I promoted him from Cc: to To:, maybe he will
> notice.)
>=20
> > > > +	res =3D regmap_write(priv->ec->regmap, NTXEC_REG_PERIOD_LOW, ntxe=
c_reg8(period));
> > > > +	if (res)
> > > > +		return res;
> > > > +
> > > > +	res =3D regmap_write(priv->ec->regmap, NTXEC_REG_DUTY_HIGH, ntxec=
_reg8(duty >> 8));
> > > > +	if (res)
> > > > +		return res;
> > > > +
> > > > +	res =3D regmap_write(priv->ec->regmap, NTXEC_REG_DUTY_LOW, ntxec_=
reg8(duty));
> > > > +	if (res)
> > > > +		return res;
> > >=20
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
>=20
> Other than that the info is fine. Make sure to point this out in the
> Limitations paragraph at the top of the driver please, too.

Perhaps also use something like regmap_bulk_write() to make sure the
time between these writes is a short as possible.

>=20
> > > > +	.apply =3D ntxec_pwm_apply,
> > >=20
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
>=20
> > > @Thierry: Do you have concerns here? Actually it would be more effect=
ive
> > > to have a callback (like .apply()) that modfies its pwm_state
> > > accordingly. (Some drivers did that in the past, but I changed that to
> > > get an uniform behaviour in 71523d1812aca61e32e742e87ec064e3d8c615e1.)
> > > The downside is that people have to understand that concept to proper=
ly
> > > use it. I'm torn about the right approach.
> >=20
> > General guidance for such cases when the state can't be read back from
> > the hardware would be appreciated.
>=20
> Yes, improving the documentation would be great here. Thierry, can you
> please comment on
> https://lore.kernel.org/r/20191209213233.29574-2-u.kleine-koenig@pengutro=
nix.de
> which I'm waiting on before describing our understanding in more detail.

Hm... that link gives me a "Not Found" message. Anyway, I think perhaps
the best compromise would be for the core to provide an implementation
of ->get_state() that drivers can use if they can't read out hardware
state. This generic implementation would then just copy over the
internal state and we have to trust that that's really what was applied.

One drawback of that is that we don't factor in things like rounding
errors and other limitations. So a better alternative may be to require
drivers to store a cached version of the state and return that in their
->get_state() implementation.

Or perhaps a hybrid of the above would work where the core provides the
helper that copies cached state and a cached state structure for storage
and then the drivers that can't properly read back hardware state just
need to update the cached state during ->apply().

I slightly prefer variant 2 because it's not clear to me how often we'll
need this and we can always easily convert to variant 3 if this becomes
a more common thing to do.

Thierry

--ixVrwD0k1fxTKBEk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl/A3kAACgkQ3SOs138+
s6GBWw//VcnE+RL+r62Ul8O2R/ofhl7bCE0o/fWAFyHR9POLPzDU6AJYRERRkwuF
9ha2hrrhDvUoD9pxl2ixtrm+qsap7ViFfT/DjrWiKWLyEVL24RhVB/uHqYQT5Ksy
LeXpy9EzMFka4hN8oTlNMela+OJ21N8iSgjTg79b9zuEGDqYhxEHFCnwxTGYmoLD
yYlMYK/HtsICRkkQjqRW0tStoidhUZNEkcnnnUE4x+iHNXdzXAIUw3+h2N8XpUkC
kxqmxU3BGv4TxvXLuzVJj3u9F2kcIUby2YUuD9PK3vIEzWtuEeyurc3yYM4eirvA
f+0K8udhbdpEO/vZ2Y3kSIhJIIFovYIzqHCRLOOpS1HVjsQe8XE9ekT3o2wWUXTp
+IRFeq5xTSxRidN0ONolyn1kaUFB6hgm2baCeO0D19pDsalpnpkaY3lrIsHFpnoN
4Nr+INw5r2Cna8nVVQNJH13ZZoXFlfjmDHvi7ut5sSrB+VDgEcfbPoegYKwJSeqd
geKWyl2Le9ZA4RwiuXLi4my4bNdItBPe2a8ELBlBaS9C8LaIBAusYIxQ96RFJROL
hD5AT4Y4shsk6XeIaAlKTpSFUKWU06SVVCALG/wp8akwvlNk4ifB/XbpXQ0VhKxc
dMDYHK8ki9lFEpvzPukWEfSxbvrMfFXFtGSRwPNdZ6M5yHTcOdc=
=z/KG
-----END PGP SIGNATURE-----

--ixVrwD0k1fxTKBEk--
