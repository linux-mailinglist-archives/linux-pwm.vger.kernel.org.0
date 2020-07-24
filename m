Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9250122D19C
	for <lists+linux-pwm@lfdr.de>; Sat, 25 Jul 2020 00:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbgGXWFT (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 24 Jul 2020 18:05:19 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:47340 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726607AbgGXWFT (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 24 Jul 2020 18:05:19 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 112D11C0BE2; Sat, 25 Jul 2020 00:05:17 +0200 (CEST)
Date:   Sat, 25 Jul 2020 00:05:16 +0200
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
Message-ID: <20200724220516.GA21965@amd>
References: <20200724213659.273599-1-martin.botka1@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="wac7ysb48OaltWcw"
Content-Disposition: inline
In-Reply-To: <20200724213659.273599-1-martin.botka1@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--wac7ysb48OaltWcw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

Dalsi cech co hackuje LEDky?

> This series brings QCOM pwm-lpg and tri-led drivers from 4.14 that is req=
uired to support pmic-connected notification LED.
> This comes straight from downstream and I'm ready for your comments.

Yeah, so...

Bindings should go first, they may need to be converted to yml
(devicetree people will know).

Can generic pwm driver be used here?

This is for RGB modules, right? It will need to use multicolor
framework.

"Breathing" will need to be figured out. It should become a trigger.

Is this for phone, btw? If so, which one?

Best regards,
								Pavel

>  .../bindings/leds/leds-qti-tri-led.txt        |   72 +
>  .../devicetree/bindings/pwm/pwm-qti-lpg.txt   |  163 +++
>  drivers/leds/Kconfig                          |    9 +
>  drivers/leds/Makefile                         |    1 +
>  drivers/leds/leds-qti-tri-led.c               |  640 ++++++++
>  drivers/pwm/Kconfig                           |   10 +
>  drivers/pwm/Makefile                          |    1 +
>  drivers/pwm/core.c                            |   56 +-
>  drivers/pwm/pwm-qti-lpg.c                     | 1284 +++++++++++++++++
>  drivers/pwm/sysfs.c                           |   56 +-
>  include/linux/pwm.h                           |  144 +-
>  11 files changed, 2418 insertions(+), 18 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/leds/leds-qti-tri-l=
ed.txt
>  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-qti-lpg.txt
>  create mode 100644 drivers/leds/leds-qti-tri-led.c
>  create mode 100644 drivers/pwm/pwm-qti-lpg.c
>=20

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--wac7ysb48OaltWcw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl8bWxwACgkQMOfwapXb+vLWJQCdHtl9UD/9yDfZ1yGURJGOFa/h
BlsAmwV9txSx+kK7qN9Y9fI6OBfNv+A3
=cLGg
-----END PGP SIGNATURE-----

--wac7ysb48OaltWcw--
