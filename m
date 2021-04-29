Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D03B036F19C
	for <lists+linux-pwm@lfdr.de>; Thu, 29 Apr 2021 23:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236795AbhD2VNP (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 29 Apr 2021 17:13:15 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:58834 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234795AbhD2VNM (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 29 Apr 2021 17:13:12 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 151021C0BA1; Thu, 29 Apr 2021 23:12:24 +0200 (CEST)
Date:   Thu, 29 Apr 2021 23:12:23 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Dan Murphy <dmurphy@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>,
        Lee Jones <lee.jones@linaro.org>,
        Martin Botka <martin.botka1@gmail.com>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH v6 2/4] leds: Add driver for Qualcomm LPG
Message-ID: <20210429211223.GA5480@amd>
References: <20201021201224.3430546-1-bjorn.andersson@linaro.org>
 <20201021201224.3430546-3-bjorn.andersson@linaro.org>
 <20201029181357.GE26053@duo.ucw.cz>
 <YIn50NW+Pimqfsih@builder.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="wRRV7LY7NUeQGEoC"
Content-Disposition: inline
In-Reply-To: <YIn50NW+Pimqfsih@builder.lan>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > +static int lpg_add_pwm(struct lpg *lpg)
> > > +{
> > > +	int ret;
> > > +
> > > +	lpg->pwm.base =3D -1;
> > > +	lpg->pwm.dev =3D lpg->dev;
> > > +	lpg->pwm.npwm =3D lpg->num_channels;
> > > +	lpg->pwm.ops =3D &lpg_pwm_ops;
> > > +
> > > +	ret =3D pwmchip_add(&lpg->pwm);
> > > +	if (ret)
> > > +		dev_err(lpg->dev, "failed to add PWM chip: ret %d\n", ret);
> > > +
> > > +	return ret;
> > > +}
> >=20
> > Do we need to do this? I'd rather have LED driver, than LED+PWM
> > driver...
> >=20
>=20
> Yes, I believe we need to do this.
>=20
> Because each piece of hardware has N channels, which can be wired to
> LEDs, grouped with other channels and wired to multicolor LEDs or be
> used as PWM signals. And this configuration is board specific.
>=20
> One such example is the laptop in front of me, which has 3 channels
> wired to an RGB LED and 1 channel wired as a backlight control signal
> (i.e. using pwm-backlight).  Another example is a devboard where the
> 4 channels are wired to 4 LEDs.

Ok, so this is actually important. In this case you should have PWM
layer, exporting PWMs, and then rgb-LED driver that takes three of
those PWMs and turns them into LED, no?

And ... surprise ... that is likely to help other people, as LEDs
connected to PWMs are quite common.

Hmm.?

If you can't do this for some reason, you should probably explain in
the changelog, because this is going to be FAQ.

Best regards,
								Pavel
--=20
http://www.livejournal.com/~pavelmachek

--wRRV7LY7NUeQGEoC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmCLITcACgkQMOfwapXb+vK+BACeMLv8lEYnpH1WKHwqzQQfYMGc
5O4AoKuyGX4vAejCvrj2ZaEI2S6+fTMH
=al0Q
-----END PGP SIGNATURE-----

--wRRV7LY7NUeQGEoC--
