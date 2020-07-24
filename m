Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 492D122D1CE
	for <lists+linux-pwm@lfdr.de>; Sat, 25 Jul 2020 00:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbgGXWbx (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 24 Jul 2020 18:31:53 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:49152 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726154AbgGXWbw (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 24 Jul 2020 18:31:52 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 02BE01C0BDD; Sat, 25 Jul 2020 00:31:51 +0200 (CEST)
Date:   Sat, 25 Jul 2020 00:31:50 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Martin Botka <martin.botka1@gmail.com>
Cc:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Dan Murphy <dmurphy@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH RFC 0/6] Add QCOM pwm-lpg and tri-led drivers
Message-ID: <20200724223150.GB21965@amd>
References: <20200724213659.273599-1-martin.botka1@gmail.com>
 <20200724220516.GA21965@amd>
 <CADQ2G_HbysJbiQKSRmA6HDRfjPYPiDjbZfeuUjM1mNV-BBBC-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="Fba/0zbH8Xs+Fj9o"
Content-Disposition: inline
In-Reply-To: <CADQ2G_HbysJbiQKSRmA6HDRfjPYPiDjbZfeuUjM1mNV-BBBC-A@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--Fba/0zbH8Xs+Fj9o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > Dalsi cech co hackuje LEDky?
>=20
> Nie. Slovak.

Vitej do klubu :-).

> > Bindings should go first, they may need to be converted to yml
> > (devicetree people will know).
>=20
> OK

I'm not 100% sure, please double check.

> > Can generic pwm driver be used here?
>=20
> I have not tried to do that. But considering it's custom chip from Qualco=
mm
> then it's unlikely.

Please double check. Actually, is the series for one chip or for two
of them? LED framework should is happy to talk to generic pwm driver...

> >This is for RGB modules, right? It will need to use multicolor
> >framework.
>=20
> This is for RGB LEDs in phones that are connected via pmic.

Ok. Check multicolor framework in -next.

> > Is this for phone, btw? If so, which one?
>=20
> Yes it is. And it's for many many phones actually. I have done this mainly
> for SONY phones (Xperia 10, 10 Plus, XA2, XA2 Plus, XA2 Ultra).
> All of them use these drivers for generating the PWM and controlling the
> LEDs.

Aha, ok. I assume they are still quite far away from being usable with
mainline kernels.

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--Fba/0zbH8Xs+Fj9o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl8bYVYACgkQMOfwapXb+vI6kQCglny7KnSJCYt6qxAmNeotmZkU
ldkAnRuNUWHDxkhbTehERpei7p58IriZ
=tbOD
-----END PGP SIGNATURE-----

--Fba/0zbH8Xs+Fj9o--
