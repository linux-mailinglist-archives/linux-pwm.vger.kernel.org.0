Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15AFA273499
	for <lists+linux-pwm@lfdr.de>; Mon, 21 Sep 2020 23:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbgIUVGP (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 21 Sep 2020 17:06:15 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:43748 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbgIUVGO (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 21 Sep 2020 17:06:14 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 8A4241C0B8C; Mon, 21 Sep 2020 23:06:11 +0200 (CEST)
Date:   Mon, 21 Sep 2020 23:06:10 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Jonathan Cameron <jic23@kernel.org>, Dan Murphy <dmurphy@ti.com>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-pm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: move Milo Kim to credits
Message-ID: <20200921210610.GA5338@amd>
References: <20200921210233.21449-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="W/nzBZO5zC0uMSeA"
Content-Disposition: inline
In-Reply-To: <20200921210233.21449-1-krzk@kernel.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--W/nzBZO5zC0uMSeA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Milo Kim's email in TI bounces with permanent error (550: Invalid
> recipient).  Last email from him on LKML was in 2017.  Move Milo Kim to
> credits and remove the separate driver entries for:
>=20
>  - TI LP855x backlight driver,
>  - TI LP8727 charger driver,
>  - TI LP8788 MFD (ADC, LEDs, charger and regulator) drivers.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

I believe normal way would be to mark the entries "orphaned", not to
drop them altogether. Plus, I believe someone from TI is likely to
step up.

Best regards,
								Pavel



> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5b9621ca2b31..031adeff29cc 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17471,29 +17471,6 @@ S:	Maintained
>  F:	sound/soc/codecs/isabelle*
>  F:	sound/soc/codecs/lm49453*
> =20
> -TI LP855x BACKLIGHT DRIVER
> -M:	Milo Kim <milo.kim@ti.com>
> -S:	Maintained
> -F:	Documentation/driver-api/backlight/lp855x-driver.rst
> -F:	drivers/video/backlight/lp855x_bl.c
> -F:	include/linux/platform_data/lp855x.h
> -
> -TI LP8727 CHARGER DRIVER
> -M:	Milo Kim <milo.kim@ti.com>
> -S:	Maintained
> -F:	drivers/power/supply/lp8727_charger.c
> -F:	include/linux/platform_data/lp8727.h
> -
> -TI LP8788 MFD DRIVER
> -M:	Milo Kim <milo.kim@ti.com>
> -S:	Maintained
> -F:	drivers/iio/adc/lp8788_adc.c
> -F:	drivers/leds/leds-lp8788.c
> -F:	drivers/mfd/lp8788*.c
> -F:	drivers/power/supply/lp8788-charger.c
> -F:	drivers/regulator/lp8788-*.c
> -F:	include/linux/mfd/lp8788*.h
> -
>  TI NETCP ETHERNET DRIVER
>  M:	Wingman Kwok <w-kwok2@ti.com>
>  M:	Murali Karicheri <m-karicheri2@ti.com>

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--W/nzBZO5zC0uMSeA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl9pFcIACgkQMOfwapXb+vLy/QCgpLhlHZK8W60IO1WeGXWGyjdL
DgUAnA9wxYGm4Wd3nk9+jCX3EnjhPK6A
=Cjsr
-----END PGP SIGNATURE-----

--W/nzBZO5zC0uMSeA--
