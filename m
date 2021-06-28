Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B335B3B6798
	for <lists+linux-pwm@lfdr.de>; Mon, 28 Jun 2021 19:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232358AbhF1R0j (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 28 Jun 2021 13:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232335AbhF1R0j (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 28 Jun 2021 13:26:39 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CD05C061574
        for <linux-pwm@vger.kernel.org>; Mon, 28 Jun 2021 10:24:13 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lxuzT-0004L1-Qb; Mon, 28 Jun 2021 19:24:11 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lxuzT-0003BI-58; Mon, 28 Jun 2021 19:24:11 +0200
Date:   Mon, 28 Jun 2021 19:24:11 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        kernel@pengutronix.de
Subject: Re: [PATCH v2] pwm: Ensure for legacy drivers that pwm->state stays
 consistent
Message-ID: <20210628172411.6nfiiwc75x6mutcr@pengutronix.de>
References: <20210411160451.1207799-1-u.kleine-koenig@pengutronix.de>
 <20210501160943.108821-1-u.kleine-koenig@pengutronix.de>
 <YNm2ftmwN2Nsgy0I@orome.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dp2656ds32vci553"
Content-Disposition: inline
In-Reply-To: <YNm2ftmwN2Nsgy0I@orome.fritz.box>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--dp2656ds32vci553
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 28, 2021 at 01:46:06PM +0200, Thierry Reding wrote:
> On Sat, May 01, 2021 at 06:09:43PM +0200, Uwe Kleine-K=F6nig wrote:
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
> > ---
> > Hello,
> >=20
> > just a small optimisation: At the end of pwm_apply_legacy()
> > state->enabled is known to be true, so simplify
> >=20
> > 	if (state->enabled && !pwm->state.enabled) {
> >=20
> > to
> > 	if (!pwm->state.enabled) {
> >=20
> > Best regards
> > Uwe
> >=20
> >  drivers/pwm/core.c | 139 +++++++++++++++++++++++++--------------------
> >  1 file changed, 78 insertions(+), 61 deletions(-)
>=20
> Applied, thanks. I made a few tiny changes such as dropping the apply
> function pointer, which didn't seem very useful.

I just checked what you did and I can live with your changes. However I
think you should point out in the commit log what you actually changed.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--dp2656ds32vci553
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmDaBbcACgkQwfwUeK3K
7AkCXgf/W0N32IJbKxopU0U3mCgXjEpZ6T3ZdymJrkGIusZN5yqEmDQcIxd/NFz7
vawPM+PEgwnU0zwTE0zEBk9h+UZyltqsziVnVQ3Vb58RHMX9rG2yGDW7U5klGbey
7rhdetZh148AOuDtxH5QFuRBmsDPjWQIzVHAp7iuP+ofOa29KVU65EDyyxDV7PnO
oaqmHSwgAkPXDRp3O66THuHmBnF7EUZ74jXGMPg7js71BXqlJxg4E49EjYxjlPlM
YacbWPE0K4+UIipELeLXa+ROOkBEGIZvPWr/yKPpQuiBD/WiT6Q/jnxFsXTtdytc
5EBJmuKI9/YeTtxeDYJoq4hvzZzJ8Q==
=cCYv
-----END PGP SIGNATURE-----

--dp2656ds32vci553--
