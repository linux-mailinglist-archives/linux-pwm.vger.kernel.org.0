Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D5642A3E3A
	for <lists+linux-pwm@lfdr.de>; Tue,  3 Nov 2020 09:00:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725968AbgKCIAp (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 3 Nov 2020 03:00:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbgKCIAp (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 3 Nov 2020 03:00:45 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DB71C0613D1
        for <linux-pwm@vger.kernel.org>; Tue,  3 Nov 2020 00:00:45 -0800 (PST)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kZrFC-0002oS-Hz; Tue, 03 Nov 2020 09:00:42 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1kZrFB-0003Pm-DD; Tue, 03 Nov 2020 09:00:41 +0100
Date:   Tue, 3 Nov 2020 09:00:39 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] pwm: ab8500: Add error message if pwmchip_add() fails
Message-ID: <20201103080039.fuoupa3p5tz3jrws@pengutronix.de>
References: <20200812075214.499-1-u.kleine-koenig@pengutronix.de>
 <20200812081139.GC4354@dell>
 <20201022192253.5c2c2jmxtsji2fnh@pengutronix.de>
 <20201026093300.GB3926206@dell>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="d6c7uspu6p5yvcu6"
Content-Disposition: inline
In-Reply-To: <20201026093300.GB3926206@dell>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--d6c7uspu6p5yvcu6
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2020 at 09:33:00AM +0000, Lee Jones wrote:
> On Thu, 22 Oct 2020, Uwe Kleine-K=F6nig wrote:
>=20
> > On Wed, Aug 12, 2020 at 09:11:39AM +0100, Lee Jones wrote:
> > > On Wed, 12 Aug 2020, Uwe Kleine-K=F6nig wrote:
> > >=20
> > > > pwmchip_add() doesn't emit an error message, so add one in the driv=
er.
> > >=20
> > > Maybe placing one there would be a good idea.
> > >=20
> > > It would certainly cut down on a lot of superfluous strings.
> >=20
> > Hmm, I'm not convinced. Do you want to work on that? If not I suggest to
> > still apply the patch as currently it is justified.
>=20
> I haven't looked at implementing it.  Does it look difficult/

Probably it isn't, needs just some endurance to actually do it. (And I
won't invest that in the near future, also because I'm not convinced
that the result is beneficial.)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--d6c7uspu6p5yvcu6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl+hDiQACgkQwfwUeK3K
7AkMpwf+Juv+TJ34eqNAgxyyARDbhS1gQKEuwz47uDvzpRVozm9HO+PMmsKlMrMW
mr/xjAC07ulEX0wDRJGoKZh1g3k06qRcKiES1XziaVX2yogFYICCcfisnCjDoVAd
A7yxRATR3e+GcRXeuXbl4PL7OJcZmfHG2hJBhPNDglgzl6+0zcKtWgNdgtgFaDel
TTCzuQn63wXZrhte0wMVh0FoDMcA16HCGyqLVPS0+Zu1jV96NaviY/j1EMHK08l3
nAv/0rU3ShOH4nEXw+7TFnK9OW71EC7+PqZhzMoFWjAU442mdTm5r0RELm7LyGie
cR0GsLqv6htmzUsTezTRVtkL4oJSXA==
=9I/z
-----END PGP SIGNATURE-----

--d6c7uspu6p5yvcu6--
