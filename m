Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4C0230DFC8
	for <lists+linux-pwm@lfdr.de>; Wed,  3 Feb 2021 17:34:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232418AbhBCQeO (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 3 Feb 2021 11:34:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230180AbhBCQeC (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 3 Feb 2021 11:34:02 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC4F8C061573;
        Wed,  3 Feb 2021 08:33:21 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id 7so25151868wrz.0;
        Wed, 03 Feb 2021 08:33:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LwYk9IXStRn7SgUS76qHSJjRJWVhTr/k7WOX+m0XO/w=;
        b=SGkrJiRz0EXbG18IdOW96od8R9qUqlm+EbdrudIW+hhxa3+h5Dp6C/bXdl+0Ctno4k
         cMK0B8PXbT4TziWpFCeQ/P2g8rHYglYb/6fZ6tGZbfXLDvUTmDU9e2No+SZOXvFLNIWV
         8u1f4DXym0ddMiXYQ/HPT3fWZi+QaoqL42jWTFKZgVav9a/4W644Clsn/Ss2h8INIZVJ
         mxR4z6H8AjhUSgqGNItQQfHDGPLuRXHSnQPgcBHfPc5vVPuJp6y20hS6F4wFiZQrZxnp
         EDx4nyvtiuedyyJCIsRavGHzw4v6nvEf+owm4qSO4FCoHQmL5F6+h2im4klJds/98OKa
         4ISA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LwYk9IXStRn7SgUS76qHSJjRJWVhTr/k7WOX+m0XO/w=;
        b=E4xg8dgMWcPB7bH3KYF8iq9x+7HdSjufvAstvzrgQ3z0segTjjTrH94wFizyXNlgoh
         g/XNSzJGT9E/jcvq4EHkO6sgfNkwoFC+2j2O9FAB6EDy+ipZl7RqUZoSNftYl872G6BO
         uSwvcvqTljMkT8fNBMUnDTjlv7pdrq7yhdYtUGHP4srZT392/EiQv4hv4vHfiQezYvag
         WUu3blsM4eLeCOrtVuMbFIBvNIhe2LOAcpFqQWqcQYbiQKMeVQwb0rlAqAHRKMehYY82
         8cVxoX+A62TUQXweIT+X3yRdLcEUXP+89lzwyUG0gFGdXsb9BJXv8RE1/ruNqo42Bxo0
         mbMg==
X-Gm-Message-State: AOAM532beXSIBe3981uLVN+OCUgr1AgY9WHsN1IcSd6PZlstFaurRpbO
        GAb3yueZmzQfr727YMB44Uo=
X-Google-Smtp-Source: ABdhPJxO4gMeXrlYm6a9K277Pj1yr4Bzb6rdNQsXLKYXSLYB7eI3tKUXsq3Z1TwO3brUy3ilCdrZDg==
X-Received: by 2002:a5d:58c2:: with SMTP id o2mr4446825wrf.31.1612370000447;
        Wed, 03 Feb 2021 08:33:20 -0800 (PST)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id r124sm3344257wmr.16.2021.02.03.08.33.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 08:33:18 -0800 (PST)
Date:   Wed, 3 Feb 2021 17:33:16 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Ban Tao <fengzheng923@gmail.com>, mripard@kernel.org,
        wens@csie.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH v2] pwm: sunxi: Add Allwinner SoC PWM controller driver
Message-ID: <YBrQTM5iADZgA2v1@ulmo>
References: <20210203125317.1975-1-fengzheng923@gmail.com>
 <20210203151200.fdzzq23teoypbxad@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="AGCAPFBM7w9A+AcG"
Content-Disposition: inline
In-Reply-To: <20210203151200.fdzzq23teoypbxad@pengutronix.de>
User-Agent: Mutt/2.0.5 (da5e3282) (2021-01-21)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--AGCAPFBM7w9A+AcG
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 03, 2021 at 04:12:00PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> On Wed, Feb 03, 2021 at 08:53:17PM +0800, Ban Tao wrote:
[...]
> > +#define PWM_GET_CLK_OFFSET(chan)	(0x20 + ((chan >> 1) * 0x4))
> > +#define PWM_CLK_APB_SCR			BIT(7)
> > +#define PWM_DIV_M			0
> > +#define PWM_DIV_M_WIDTH			0x4
> > +
> > +#define PWM_CLK_REG			0x40
> > +#define PWM_CLK_GATING			BIT(0)
> > +
> > +#define PWM_ENABLE_REG			0x80
> > +#define PWM_EN				BIT(0)
> > +
> > +#define PWM_CTL_REG(chan)		(0x100 + 0x20 * chan)
> > +#define PWM_ACT_STA			BIT(8)
> > +#define PWM_PRESCAL_K			0
> > +#define PWM_PRESCAL_K_WIDTH		0x8
> > +
> > +#define PWM_PERIOD_REG(chan)		(0x104 + 0x20 * chan)
> > +#define PWM_ENTIRE_CYCLE		16
> > +#define PWM_ENTIRE_CYCLE_WIDTH		0x10
> > +#define PWM_ACT_CYCLE			0
> > +#define PWM_ACT_CYCLE_WIDTH		0x10
>=20
> Please use a driver specific prefix for these defines.

These are nice and to the point, so I think it'd be fine to leave these
as-is. Unless of course if they conflict with something from the PWM
core, which I don't think any of these do.

> > +struct sun50i_pwm_data {
> > +	unsigned int npwm;
> > +};
> > +
> > +struct sun50i_pwm_chip {
> > +	struct pwm_chip chip;
> > +	struct clk *clk;
> > +	struct reset_control *rst_clk;
> > +	void __iomem *base;
> > +	const struct sun50i_pwm_data *data;
> > +};
> > +
> > +static inline struct sun50i_pwm_chip *sun50i_pwm_from_chip(struct pwm_=
chip *chip)
> > +{
> > +	return container_of(chip, struct sun50i_pwm_chip, chip);
> > +}

I wanted to reply to Uwe's comment on v1 but you sent this before I got
around to it, so I'll mention it here. I recognize the usefulness of
having a common prefix for function names, though admittedly it's not
totally necessary in these drivers because these are all local symbols.
But it does makes things a bit consistent and helps when looking at
backtraces and such, so that's all good.

That said, I consider these casting helpers a bit of a special case
because they usually won't show up in backtraces, or anywhere else for
that matter. Traditionally these have been named to_*(), so it'd be
entirely consistent to keep doing that.

But I don't have any strong objections to this variant either, so pick
whichever you want. Although, please, nobody take that as a hint that
any existing helpers should be converted.

[...]
> > +static int sun50i_pwm_probe(struct platform_device *pdev)
> > +{
> > +	struct sun50i_pwm_chip *pwm;
>=20
> "pwm" isn't a good name, in PWM code this name is usually used for
> struct pwm_device pointers (and sometimes the global pwm id). I usually
> use "ddata" for driver data (and would have called "sun50i_pwm_chip"
> "sun50i_pwm_ddata" instead). Another common name is "priv".

This driver already declares sun50i_pwm_data for per-SoC data, so having
a struct sun50i_pwm_ddata would just be confusing. sun50i_pwm_chip is
consistent with what other drivers name this, so I think that's fine.

Agreed on "pwm" being a bad choice here, though.

Thierry

--AGCAPFBM7w9A+AcG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmAa0EkACgkQ3SOs138+
s6EjvhAAgI1CKlBx/Bl0vTUGrzdegos3MfgicgCq4dYzmsaFqrGrhWFOxBtdYiZG
RO8mFFROyI93fbezPVPjcw60zrETEQj6mu8MIo48a56OowcIEOl2UE1ySfN0QibZ
p2MiDmOSSGc1ij4ux8lh7KB0hMdwVMtzRaJms1WzWkP7ieGCoaNua5cXUjXRagu5
8+/xnuKTq1f4dDshr0BV5w+TFTW1aruA2VsXnsIt2vEcPXzN9Wcj5F5407EQGVC9
XGhFT9OGdz2sfI6gg5HrXnzAG4bGiYzO5Hon6y0Ql/CiYyg5ce6nKYXSiBoKbbJQ
2lrD63+4PlFROyS7yjJsTGRHBZ3nefxq6WAVTls2jtunrTM8L1OSGXZ+W+s+ENWe
31crGvxyXLygAYOI2BQ5p/IVlYBhlbK4AP1zEhKaOtq6WuCZnzYpwMpyqXlRjvHe
E+y3CPfaJe2IRG5S9W5QoldNWyDazUi0n5B7jfWlwOr5eqZnheNvRABoeZNttjUf
lWKIn73nJxT4sii1JMjQ4j2xX7PZASPQAmDab3i+oVNorD69dJVe6x/8+VJNC1hQ
8BVcyq8gxI9moyaaFysMn5tdj/7vAcZNyCVvMVR6GsNvtdbKVo35rbJSRHNaBRbs
aucaodxJryNKtd6+Z5tYPT/SljThWBSnb+AaLYGeaqy7H60g2y0=
=lGYg
-----END PGP SIGNATURE-----

--AGCAPFBM7w9A+AcG--
