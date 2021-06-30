Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8C843B7D98
	for <lists+linux-pwm@lfdr.de>; Wed, 30 Jun 2021 08:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232409AbhF3Gv1 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 30 Jun 2021 02:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbhF3Gv1 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 30 Jun 2021 02:51:27 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12A6FC061766
        for <linux-pwm@vger.kernel.org>; Tue, 29 Jun 2021 23:48:59 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lyU1o-0002lb-4q; Wed, 30 Jun 2021 08:48:56 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lyU1n-0005a2-6J; Wed, 30 Jun 2021 08:48:55 +0200
Date:   Wed, 30 Jun 2021 08:48:26 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-renesas-soc@vger.kernel.org, linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, kernel@pengutronix.de
Subject: Re: [PATCH v2] pwm: Ensure for legacy drivers that pwm->state stays
 consistent
Message-ID: <20210630064826.4u2p37tlbriiwtsn@pengutronix.de>
References: <20210411160451.1207799-1-u.kleine-koenig@pengutronix.de>
 <20210501160943.108821-1-u.kleine-koenig@pengutronix.de>
 <alpine.DEB.2.22.394.2106292138100.1194476@ramsan.of.borg>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sqqmagc2umouqkn6"
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2106292138100.1194476@ramsan.of.borg>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--sqqmagc2umouqkn6
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Geert,

On Tue, Jun 29, 2021 at 09:44:38PM +0200, Geert Uytterhoeven wrote:
> On Sat, 1 May 2021, Uwe Kleine-K=F6nig wrote:
> > Without this change it can happen that if changing the polarity succeed=
ed
> > but changing duty_cycle and period failed pwm->state contains a mixture
> > between the old and the requested state.
> >=20
> > So remember the initial state before starting to modify the configurati=
on
> > and restore it when one of the required callback fails.
> >=20
> > Compared to the previous implementation .disable() (if necessary) is ca=
lled
> > earlier to prevent a glitch.
> >=20
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
>=20
> Thanks for your patch, which is now commit d7bff84fe7ed8c3b ("pwm:
> Ensure for legacy drivers that pwm->state stays consistent") in
> pwm/for-next.
>=20
> This commit broke the backlight on the Atmark Techno Armadillo 800 EVA
> board (arch/arm/boot/dts/r8a7740-armadillo800eva.dts), which now shows a
> black screen.  Reverting the commit fixes the problem.
>=20
> Do you have an idea what is wrong, and how to fix it?

I starred at the patch for some time now and couldn't find a problem.
Looking at drivers/pwm/pwm-renesas-tpu.c I don't see something obvious.
(The .set_polarity callback is faulty as I doesn't commit the request to
hardware, but that shouldn't matter here.)

I guess the first request the backlight driver emits is

	.period =3D 33333,
	.duty_cycle =3D 33333,
	.enabled =3D true,
	.polarity =3D PWM_POLARITY_INVERSED,

which should result into the following driver calls (with and without
the breaking commit):

	tpu_pwm_set_polarity(chip, pwm, PWM_POLARITY_INVERSED);
	tpu_pwm_config(chip, pwm, 33333, 33333);
	tpu_pwm_enable(chip, pwm);

Can you confirm that?

Feel free to contact me via irc if you have questions/insights.

Thanks for your time to report the issue,
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--sqqmagc2umouqkn6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmDcE7IACgkQwfwUeK3K
7AlXtAgAlRAVBpdSnCH6cXBh+rivgSIt2WT5Ph2lkm7I5RstIvLkge+mijxgsQiV
27RIpzxTlUdEOpiogDPmonA1Z94FbY0++Utwf5iYEiRntnXvx+NaN8H7nVFkPrcQ
nbP+l8E30qnsRjvvlnOiw42vxAp28inldTecTY6SiW0wnt4cb2PzgUDJNYfxdpZO
hjnJNu5D35WaH1RpRKAZUbbj04udfcXiiXOU7sUkQFBQ+Tl9/dTmvkQhPY8y/ZYf
76UZykd49Vw7nTZvRl54hGM+j7yUxrL4xb6rhlRllltaL1PKWwCEwC4A9OydDD1T
i7lXmfUhUPg98U8poZBgR0E+2n80DA==
=/JDG
-----END PGP SIGNATURE-----

--sqqmagc2umouqkn6--
