Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F5F63BBD63
	for <lists+linux-pwm@lfdr.de>; Mon,  5 Jul 2021 15:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbhGENSJ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 5 Jul 2021 09:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbhGENSI (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 5 Jul 2021 09:18:08 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5742C061574
        for <linux-pwm@vger.kernel.org>; Mon,  5 Jul 2021 06:15:31 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m0ORe-0006JG-4u; Mon, 05 Jul 2021 15:15:30 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m0ORd-0003Rs-Mp; Mon, 05 Jul 2021 15:15:29 +0200
Date:   Mon, 5 Jul 2021 15:15:29 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 2/2] pwm: imx27: Don't check the return code of
 pwmchip_remove()
Message-ID: <20210705131529.ple6yymh2ojz6scj@pengutronix.de>
References: <20210324152058.69022-1-u.kleine-koenig@pengutronix.de>
 <20210324152058.69022-3-u.kleine-koenig@pengutronix.de>
 <YHBB1HrlQ/DMiey7@orome.fritz.box>
 <20210525195905.abybdmfu5zjl7sc3@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qt2prcfsnhsnv7ds"
Content-Disposition: inline
In-Reply-To: <20210525195905.abybdmfu5zjl7sc3@pengutronix.de>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--qt2prcfsnhsnv7ds
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Thierry,

On Tue, May 25, 2021 at 09:59:05PM +0200, Uwe Kleine-K=F6nig wrote:
> On Fri, Apr 09, 2021 at 02:00:20PM +0200, Thierry Reding wrote:
> > On Wed, Mar 24, 2021 at 04:20:58PM +0100, Uwe Kleine-K=F6nig wrote:
> > > pwmchip_remove() always returns 0. Don't use the value to make it
> > > possible to eventually change the function to return void. This is a
> > > good thing as pwmchip_remove() is usually called from a remove functi=
on
> > > (mostly for platform devices) and their return value is ignored by the
> > > device core anyhow.
> > >=20
> > > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > > ---
> > >  drivers/pwm/pwm-imx27.c | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> >=20
> > It's true that there's not much we can do upon failure, so failing
> > doesn't make much sense and therefore returning an error doesn't make
> > sense. So how about we WARN on the -EBUSY case instead of returning an
> > error? That should have an even higher impact than an error that's being
> > silently ignored.
>=20
> After patch 1 in this series (or the reworked version from
> https://lore.kernel.org/r/20210423165902.2439564-1-u.kleine-koenig@pengut=
ronix.de)
> pwmchip_remove() really always returns 0, so adding a WARN in the imx27
> (or any other) driver doesn't make much sense.
>=20
> It might make sense to add such a WARN in pwmchip_remove(), is it that
> what you intended to suggest?

You never replied to this question. Given that today pwmchip_remove()
indeed always returns 0, your concern here should not stop application
of the change to the pwm-imx27 driver.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--qt2prcfsnhsnv7ds
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmDjBe4ACgkQwfwUeK3K
7AmMcwf/bz7my2qlpqhToGoANJ9hA2TkK6N9DIRGob031fBH+QPLQDuERtuIkuDh
1OSOo5V4oMjWQGhDSExR3/Y4JQBb5aPje5MVpe6d0SIOND2aQohv8QZ0vB/F6nXw
3VcHXT12j8KkcEIvrdwq+acYDQ29Hdf3Y//r3iH/zSMoSHqj4guWCfzzc6e4pkI4
rhJmzAgKrQ3waUooVMWQNc585gay+4ifPHuNw8BzL7AoTDgfcQayC0xYsV602ZRZ
qtiq6VpC1tyBPjIfuyRRuGe4Zp4OtET+riEU7lH5EAI/rPu3ICN9+9a8uPFIXmta
Yp2n4c6YltmqO62UW/ODcU5v+Gu6iw==
=PrWh
-----END PGP SIGNATURE-----

--qt2prcfsnhsnv7ds--
