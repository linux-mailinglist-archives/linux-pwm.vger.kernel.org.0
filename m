Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B57A1F3E7D
	for <lists+linux-pwm@lfdr.de>; Tue,  9 Jun 2020 16:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728905AbgFIOmF (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 9 Jun 2020 10:42:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:38856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728601AbgFIOmE (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 9 Jun 2020 10:42:04 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1442D2072F;
        Tue,  9 Jun 2020 14:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591713723;
        bh=DBeZHLEQGulEBu3IQlBvivbxuD7CpCjdJ39fxG4UDBw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Khl7WXZjz0yf6NrpGSUGwKvt+9K9Oxrk2SI7klUKYjRZn787104XzLQeBOo1pQ6XD
         8P3ZXbXVKjAzZIirxNhWJodow3QE8tArvfWVwI7OmyATVf1vglnnzFlbQgsUhrX9os
         sLU/nPY7O2QDkwwpcjPSl5w/ov2O5k6TSsc7WPf0=
Date:   Tue, 9 Jun 2020 15:42:01 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Michael Walle <michael@walle.cc>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        david.m.ertman@intel.com, shiraz.saleem@intel.com,
        Rob Herring <robh+dt@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-hwmon@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v4 02/11] mfd: Add support for Kontron sl28cpld
 management controller
Message-ID: <20200609144201.GK4583@sirena.org.uk>
References: <c5632bfab3956265e90fc2fb6c0b3cae@walle.cc>
 <20200606114645.GB2055@sirena.org.uk>
 <dc052a5c77171014ecc465b1da8b7ef8@walle.cc>
 <20200608082827.GB3567@dell>
 <CAHp75VdiH=J-ovCdh1RFJDW_bJM8=pbXRaHmB691GLb-5oBmYQ@mail.gmail.com>
 <7d7feb374cbf5a587dc1ce65fc3ad672@walle.cc>
 <20200608185651.GD4106@dell>
 <32231f26f7028d62aeda8fdb3364faf1@walle.cc>
 <20200609064735.GH4106@dell>
 <32287ac0488f7cbd5a7d1259c284e554@walle.cc>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0FM4RQAc0jwHekq5"
Content-Disposition: inline
In-Reply-To: <32287ac0488f7cbd5a7d1259c284e554@walle.cc>
X-Cookie: Be careful!  Is it classified?
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--0FM4RQAc0jwHekq5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 09, 2020 at 04:38:31PM +0200, Michael Walle wrote:

>   mfd-device@10 {
>     compatible =3D "simple-regmap", "simple-mfd";
>     reg =3D <10>;
>     regmap,reg-bits =3D <8>;
>     regmap,val-bits =3D <8>;
>     sub-device@0 {
>       compatible =3D "vendor,sub-device0";
>       reg =3D <0>;
>     };

A DT binding like this is not a good idea, encoding the details of the
register map into the DT binding makes it an ABI which is begging for
trouble.  I'd also suggest that any device using a generic driver like
this should have a specific compatible string for the device so we can
go back and add quirks later if we need them.

>     ...
> };
>=20
> Or if you just want the regmap:
>=20
> &soc {
>   regmap: regmap@fff0000 {
>     compatible =3D "simple-regmap";
>     reg =3D <0xfff0000>;
>     regmap,reg-bits =3D <16>;
>     regmap,val-bits =3D <32>;
>   };
>=20
>   enet-which-needs-syscon-too@1000000 {
>     vendor,ctrl-regmap =3D <&regmap>;
>   };
> };
>=20
> Similar to the current syscon (which is MMIO only..).
>=20
> -michael
>=20
> >=20
> > I can't think of any reasons why not, off the top of my head.
> >=20
> > Does Regmap only deal with shared accesses from multiple devices
> > accessing a single register map, or can it also handle multiple
> > devices communicating over a single I2C channel?
> >=20
> > One for Mark perhaps.
> >=20
> > > > The issues I wish to resolve using 'simple-mfd' are when sub-devices
> > > > register maps overlap and intertwine.
> >=20
> > [...]
> >=20
> > > > > > > What do these bits configure?
> > > > >
> > > > > - hardware strappings which have to be there before the board pow=
ers
> > > > > up,
> > > > >   like clocking mode for different SerDes settings
> > > > > - "keep-in-reset" bits for onboard peripherals if you want to save
> > > > > power
> > > > > - disable watchdog bits (there is a watchdog which is active right
> > > > > from
> > > > >   the start and supervises the bootloader start and switches to
> > > > > failsafe
> > > > >   mode if it wasn't successfully started)
> > > > > - special boot modes, like eMMC, etc.
> > > > >
> > > > > Think of it as a 16bit configuration word.
> > > >
> > > > And you wish for users to be able to view these at run-time?
> > >=20
> > > And esp. change them.
> > >=20
> > > > Can they adapt any of them on-the-fly or will the be RO?
> > >=20
> > > They are R/W but only will only affect the board behavior after a
> > > reset.
> >=20
> > I see.  Makes sense.  This is board controller territory.  Perhaps
> > suitable for inclusion into drivers/soc or drivers/platform.

--0FM4RQAc0jwHekq5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7fn7gACgkQJNaLcl1U
h9AhrQf/dpQW8gsPG9Ua7FU/Ae75V1zwG5NKx2ioZcYzal7CqZg3Q0+ciOedLwFs
WELrgzSE7WB9V18aaNAg8CpMIKlBhqU+2I4JxSAZQWfuaFQgrP550jA5iij1L69d
RIxP1xrQClXSvmJa33MBpD95uFdGEPWxMOiSB72lLy4E7jr65KwJ55P6tcOlXo7L
Ma/qDeZ0tjrcZOtH5h3dPsJhEojskfrxWJq6CJ1UjXifZxvy+O/khY6E7TTetw3+
0b8ttqNSXE4Yk9Z7TKhYlonnqWphaX3XdoDvTlbgxmBldVUrr63UJCTbiCm5pKJ1
HYxxN5ha9XcJcvRtIDLWzkq7wpRCQg==
=rwO1
-----END PGP SIGNATURE-----

--0FM4RQAc0jwHekq5--
