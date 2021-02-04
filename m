Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EAD230F402
	for <lists+linux-pwm@lfdr.de>; Thu,  4 Feb 2021 14:41:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236327AbhBDNjr (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 4 Feb 2021 08:39:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236310AbhBDNj1 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 4 Feb 2021 08:39:27 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC3D2C061573;
        Thu,  4 Feb 2021 05:38:44 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id 7so3596240wrz.0;
        Thu, 04 Feb 2021 05:38:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sgLOuTi1xWKm9vErp4SFIwbBSD/J59ein/NspvF+fFY=;
        b=pQVZdolEQUYuGrRvyYBk6dGqYNNwSwgO3TMNF9knpc7a0TigLvJfES0oVXq/ZYBjDP
         DCZATPL3D6mVAaqB7zw60gFoCci6ELicQNNZj1q2FgUKE9vNp947YbHgkvn3mf/Wv/IF
         6jyiV+HfXmDFifJoDfPYirV9mjQphYzb9ndE8/pfyKpLOUIjcuqL6whQyp0LABjLV2RL
         Ar4nm2P3pbPvwLwRiHp7h3O6xr17HKFTlYk76iiUsq2CAu18tAQTl2wKle13C7mov2LW
         djYARexCAgO22c8mYw3YXlMZk4sOB4Dznte8X0tT+jHCu4t5xB2WbB5LvnC9n/jTxTKY
         unHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sgLOuTi1xWKm9vErp4SFIwbBSD/J59ein/NspvF+fFY=;
        b=qMmm3Xmw/KfcYS1aXwM3TmkNJ8XSa5pSaEVX/ry3JYnaEjzI8+W91OgHZDaqOqKBLz
         bVvIYIHSZbOA8SURNF68kutIgLPd8f5A1nNIFaOx+rOYEHALkyxvFr3o7i2zEvaq1zvP
         AJA3RBVME7Pih2FDl3PfcGrJo5bIXfGa/JcgHnSHubeF+0wEZ2ygUGD9+MwwihaKGGjV
         iyovGy1UNY9IMmEDtjw4UPnusn52meumvuK/mvcyOcsWDjHy/+i8hJ2yrId9tjGDnL3V
         bR0XALG+Ucr3Sj8+jkJhpLp3e6T0xM8qSqE6KN6hb34LYcOhlOWI15lsO9UcE2DqClCO
         sc3w==
X-Gm-Message-State: AOAM532aJxERk0hRqT3zCzoHO14WOTmJsZ6tIau3PnlN3EN9WePWcM/K
        lYJkAoqdtYKOEkBl5FdDLuk=
X-Google-Smtp-Source: ABdhPJyzfGcJ8xZnrKCnLOsXKK8brfRskg8tmkel6Zn9AFHsKtCaT38dHWX6HC+VUkDNhEbTR/DRNw==
X-Received: by 2002:a5d:4391:: with SMTP id i17mr9435327wrq.57.1612445923435;
        Thu, 04 Feb 2021 05:38:43 -0800 (PST)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id b13sm7952215wrt.31.2021.02.04.05.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 05:38:41 -0800 (PST)
Date:   Thu, 4 Feb 2021 14:38:40 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Ban Tao <fengzheng923@gmail.com>, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org, mripard@kernel.org, wens@csie.org,
        kernel@pengutronix.de
Subject: Re: [PATCH v2] pwm: sunxi: Add Allwinner SoC PWM controller driver
Message-ID: <YBv44P71Z0cD1BSG@ulmo>
References: <20210203125317.1975-1-fengzheng923@gmail.com>
 <20210203151200.fdzzq23teoypbxad@pengutronix.de>
 <YBrQTM5iADZgA2v1@ulmo>
 <20210203205913.dvmppahnkmcj2dac@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="TcXrT0sWFs9h8llg"
Content-Disposition: inline
In-Reply-To: <20210203205913.dvmppahnkmcj2dac@pengutronix.de>
User-Agent: Mutt/2.0.5 (da5e3282) (2021-01-21)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--TcXrT0sWFs9h8llg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 03, 2021 at 09:59:13PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> Hello Thierry, hello Ban,
>=20
> On Wed, Feb 03, 2021 at 05:33:16PM +0100, Thierry Reding wrote:
> > On Wed, Feb 03, 2021 at 04:12:00PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> > > On Wed, Feb 03, 2021 at 08:53:17PM +0800, Ban Tao wrote:
> > [...]
> > > > +#define PWM_GET_CLK_OFFSET(chan)	(0x20 + ((chan >> 1) * 0x4))
> > > > +#define PWM_CLK_APB_SCR			BIT(7)
> > > > +#define PWM_DIV_M			0
> > > > +#define PWM_DIV_M_WIDTH			0x4
> > > > +
> > > > +#define PWM_CLK_REG			0x40
> > > > +#define PWM_CLK_GATING			BIT(0)
> > > > +
> > > > +#define PWM_ENABLE_REG			0x80
> > > > +#define PWM_EN				BIT(0)
> > > > +
> > > > +#define PWM_CTL_REG(chan)		(0x100 + 0x20 * chan)
> > > > +#define PWM_ACT_STA			BIT(8)
> > > > +#define PWM_PRESCAL_K			0
> > > > +#define PWM_PRESCAL_K_WIDTH		0x8
> > > > +
> > > > +#define PWM_PERIOD_REG(chan)		(0x104 + 0x20 * chan)
> > > > +#define PWM_ENTIRE_CYCLE		16
> > > > +#define PWM_ENTIRE_CYCLE_WIDTH		0x10
> > > > +#define PWM_ACT_CYCLE			0
> > > > +#define PWM_ACT_CYCLE_WIDTH		0x10
> > >=20
> > > Please use a driver specific prefix for these defines.
> >=20
> > These are nice and to the point, so I think it'd be fine to leave these
> > as-is. Unless of course if they conflict with something from the PWM
> > core, which I don't think any of these do.
>=20
> In my eyes PWM_CLK_REG, PWM_CLK_GATING, PWM_ENABLE_REG and PWM_EN are
> not so nice. pwm-sun4i.c has already PWM_EN, pwm-mtk-disp.c has
> DISP_PWM_EN, pwm-zx.c has ZX_PWM_EN, pwm-berlin.c has BERLIN_PWM_EN.
> Luckily most of them already use a prefix. So it doesn't conflict with
> the core, but might with other drivers.

"Conflicts with another driver" is not something that makes sense. By
definition drivers should be specific to a given device, so you better
make sure there's no namespace sharing between them.

I'm fine if somebody wants to use a prefix, but I'm also fine if they
don't use a prefix, provided that there are no conflicts, which should
be immediately obvious because it typically causes build errors.

All I'm saying is that I don't think we need to require everyone to
adopt a prefix, especially if this hasn't been followed consistently,
because then we don't actually gain anything.

>                                         And also if you only care about
> conflicts with the core, using a prefix is the future-proof strategy.

It's not like these symbol names are carved in stone. If we ever
introduce a symbol in the PWM core that happens to conflicts with one or
more drivers, we can always fix the drivers at that point.

> For tools like ctags and cscope a unique name is great, too.
>=20
> Also comparing
>=20
> 	tmp |=3D BIT_CH(PWM_EN, pwm->hwpwm);
>=20
> with (say)
>=20
> 	tmp |=3D BIT_CH(SUN5I_PWM_PWM_EN, pwm->hwpwm);
>=20
> I prefer the latter as it is obvious that this is a driver specific
> constant.

I think the context makes it plenty clear that this is driver specific,
so the prefix is a bit redundant.

> Having said that, I'm also a fan of having the register name in the bit
> field define to simplify spotting errors like 4b75f8000361 ("serial:
> imx: Fix DCD reading").
>=20
> So looking at:
>=20
> +       /* disable pwm controller */
> +       tmp =3D sun50i_pwm_readl(sun50i_pwm, PWM_ENABLE_REG);
> +       tmp &=3D ~BIT_CH(PWM_EN, pwm->hwpwm);
> +       sun50i_pwm_writel(sun50i_pwm, tmp, PWM_ENABLE_REG);
>=20
> my preferred version would be instead:
>=20
> +       /* disable pwm controller */
> +       enable =3D sun50i_pwm_readl(sun50i_pwm, SUN50I_REG_PWM_ENABLE);
> +       enable &=3D ~SUN50I_REG_PWM_ENABLE_EN(pwm->hwpwm);
> +       sun50i_pwm_writel(sun50i_pwm, enable, SUN50I_REG_PWM_ENABLE);
>=20
> where variable name, register name and bitfield name are obviously
> matching.

I don't have any particular objection to the above, but I've also seen
this kind of naming result in ridiculously long (as in almost impossible
to read) lines, so I think we need to strike the right balance. Given
that there aren't any rigorous rules for this, I don't think it's worth
requiring everyone to adopt some style that's not consistently followed
anyway.

> > > > +struct sun50i_pwm_data {
> > > > +	unsigned int npwm;
> > > > +};
> > > > +
> > > > +struct sun50i_pwm_chip {
> > > > +	struct pwm_chip chip;
> > > > +	struct clk *clk;
> > > > +	struct reset_control *rst_clk;
> > > > +	void __iomem *base;
> > > > +	const struct sun50i_pwm_data *data;
> > > > +};
> > > > +
> > > > +static inline struct sun50i_pwm_chip *sun50i_pwm_from_chip(struct =
pwm_chip *chip)
> > > > +{
> > > > +	return container_of(chip, struct sun50i_pwm_chip, chip);
> > > > +}
> >=20
> > I wanted to reply to Uwe's comment on v1 but you sent this before I got
> > around to it, so I'll mention it here. I recognize the usefulness of
> > having a common prefix for function names, though admittedly it's not
> > totally necessary in these drivers because these are all local symbols.
> > But it does makes things a bit consistent and helps when looking at
> > backtraces and such, so that's all good.
> >=20
> > That said, I consider these casting helpers a bit of a special case
> > because they usually won't show up in backtraces, or anywhere else for
> > that matter. Traditionally these have been named to_*(), so it'd be
> > entirely consistent to keep doing that.
> >=20
> > But I don't have any strong objections to this variant either, so pick
> > whichever you want. Although, please, nobody take that as a hint that
> > any existing helpers should be converted.
>=20
> @Thierry: I don't understand your motivation to write this.

I'm writing this because I think your recommendation was the wrong thing
to do here. Ban was obviously doing what *all* other drivers are doing
for this casting helper, so why should this one be different?

>                                                             For me
> consistence is a quite important aspect. Obviously for you it's less so
> and the code presented here over-fulfils your standards. So everything
> is fine as is, isn't it?

Like I said, 100% of the PWM drivers use to_*() for these, so how is it
consistent if we now start to change that?

What I was trying to say is that I would've been fine with this if the
original patch had named this sun50i_pwm_from_chip(). It wouldn't have
been consistent, but I would probably not have objected. However, the
original patch was making this consistent and then you suggested to
change it so that it became inconsistent.

I want to avoid a situation where there's a quasi-standard rule, even if
it's not written down anywhere, and then out of nowhere we change the
rule, for no obvious reason.

> I think using a rule like "A common prefix for driver specific functions"
> consistently is easier than allowing some exceptions. There is no gain
> in not using the prefix, so IMHO keep the rules simple without
> exceptions.

That's a matter of perspective. The way I see it, the simple rule here
is that these casting helpers should be named to_*(). Like I said, that
is what every single one of the existing drivers in drivers/pwm does, so
using the driver prefix breaks the rule and make things inconsistent.

> > [...]
> > > > +static int sun50i_pwm_probe(struct platform_device *pdev)
> > > > +{
> > > > +	struct sun50i_pwm_chip *pwm;
> > >=20
> > > "pwm" isn't a good name, in PWM code this name is usually used for
> > > struct pwm_device pointers (and sometimes the global pwm id). I usual=
ly
> > > use "ddata" for driver data (and would have called "sun50i_pwm_chip"
> > > "sun50i_pwm_ddata" instead). Another common name is "priv".
> >=20
> > This driver already declares sun50i_pwm_data for per-SoC data, so having
> > a struct sun50i_pwm_ddata would just be confusing.
>=20
> Agreed. So maybe pick a better name for sun50i_pwm_data; my suggestion
> would be sun50i_pwm_soc_info.

Yeah, I think that'd make it much clearer what this is used for.

> > sun50i_pwm_chip is consistent with what other drivers name this, so I
> > think that's fine.
>=20
> Either the name is good, then this alone justifies to use it. If however
> the name is bad, it IMHO doesn't matter if others use the same bad
> naming scheme and you better don't use it. So please don't let us
> consider it a good name *only* because it's used in several other
> places.

I don't consider this naming scheme good just because it's consistent.
The reason why it is used fairly consistently is because I think the
name is good and I've recommended it to be used when people chose what
I thought were bad names.

Now there are other cases that don't follow this scheme and that's fine
too. I think it's okay to let people be creative every once in a while.
As long as everybody understands what the purpose is and as long as it
doesn't conflict with anything or confuses anyone, that's fine with me.

> @Ban: You see Thierry and I don't agree in every aspect. So please take
> the feedback you get from us as cause for thought and then try to come
> up with a v3 with choices you can justify.

That's a bit unfair. The purpose of review is to identify things that
need to be changed. If we go around giving people a bunch of options and
tell them to pick one of them and try again isn't terribly helpful.

So I think either we have to write down the rules to make sure everybody
is on the same page, or we let people look at existing code and pick up
the rules. In the latter case we may have to accept that people have
different preferences, and not everything may be 100% consistent. I
think that's totally fine. Achieving 100% consistency is wishful
thinking anyway. Even if you manage to achieve it in the PWM subsystem,
you then move to the next subsystem and things are likely to be done
differently there. We might as well just get used to having a bit of
inconsistency.

Thierry

--TcXrT0sWFs9h8llg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmAb+N0ACgkQ3SOs138+
s6Hc7Q//TcyTFGvuKDQkTJva20BC7/dgPcIi4WGCfgj0YRix8Ca79ZR0uWOo1Ung
O6Ls9I4OYHxS0CSuzUlOu7fC1gA1ZGdjD+nc+B3HcnXtLUWo42iYfWuKhMaplQvO
vSRejpkqqR0VbjzEw6p60ma5d6PACL4IzTql2bEB/eSRZuA0AWimYg85NZDe6kG8
vimQN2yPHP4Ndrqv7eUjNAUDYBGV1jFUx3JaHEVehOlYsWN3HQk7844LHGsKMqQk
Z4E82Rl85q9GD2sPyC+0xoA5s1I446Ufa7Lnhi50iIpmSjjfu8TA9cLyYG7YMtcG
ykWBW+t+4ghFodxLhO/E3l3rQVjRVYvsDu1ROp64YuQSzDLfAs7wOqkMzQPgZ3sP
CZtWMLya76bjwdvCf/kex9RbmPwCDdM2UduO1y7lSR4+NFBd4rnWj/l0vuMghIxT
U42Bym3nNQUKIIzGiNdJF9cBV1XCewKf9Ut8EmZMMTiWnXeERfe/ri3qMSpG7M1H
M0TCAcA2rcMDkgztvuZrQUeOlJYCM+oFszJQgMDYW3jqajBDcR5LgMHclA6XdZts
ppjRS0qHZotJNL6wc6YdHPUEBDP1K3kjPyRmLnPcnVTafZdmYj8c+6bVoPvVgXFf
FknUIJ4IkRXD1Aj4ZfTs19iSjCC+1bSqX3DIFPkgtKTKdsAlJ9I=
=rklk
-----END PGP SIGNATURE-----

--TcXrT0sWFs9h8llg--
