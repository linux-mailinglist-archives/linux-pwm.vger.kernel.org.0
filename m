Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA0D3C896
	for <lists+linux-pwm@lfdr.de>; Tue, 11 Jun 2019 12:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405564AbfFKKSr (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 11 Jun 2019 06:18:47 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:33022 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405314AbfFKKSq (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 11 Jun 2019 06:18:46 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 2C6D68023E; Tue, 11 Jun 2019 12:18:33 +0200 (CEST)
Date:   Tue, 11 Jun 2019 12:18:43 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH 2/2] backlight: pwm_bl: Get number of brightness levels
 for CIE 1931 from the device tree
Message-ID: <20190611101843.GD7526@amd>
References: <20190610233739.29477-1-mka@chromium.org>
 <20190610233739.29477-2-mka@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="jL2BoiuKMElzg3CS"
Content-Disposition: inline
In-Reply-To: <20190610233739.29477-2-mka@chromium.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--jL2BoiuKMElzg3CS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2019-06-10 16:37:39, Matthias Kaehlcke wrote:
> Commit 88ba95bedb79 ("backlight: pwm_bl: Compute brightness of LED
> linearly to human eye") uses pwm_period / hweight32(pwm_period) as
> as heuristic to determine the number of brightness levels when the DT
> doesn't provide a brightness level table. This heuristic is broken
> and can result in excessively large brightness tables.
>=20
> Instead of using the heuristic try to retrieve the number of
> brightness levels from the device tree (property 'max-brightness'
> + 1). If the value is not specified use a default of 256 levels.
>=20
> Fixes: 88ba95bedb79 ("backlight: pwm_bl: Compute brightness of LED linear=
ly to human eye")

I don't think this one is suitable for stable. I'm pretty sure the
heuristics works well for many boards, and you just replaced it with
another heuristics ("256").

> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>

Acked-by: Pavel Machek <pavel@ucw.cz>

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--jL2BoiuKMElzg3CS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlz/gAMACgkQMOfwapXb+vIo3ACgh5KFLWPPu5aM3ZOFG5tXtj5k
Qc4AoJr268a0RVM8on0+DfnTeYriXWab
=vM3e
-----END PGP SIGNATURE-----

--jL2BoiuKMElzg3CS--
