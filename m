Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98EEC35B099
	for <lists+linux-pwm@lfdr.de>; Sat, 10 Apr 2021 23:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234874AbhDJV0a (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 10 Apr 2021 17:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232659AbhDJV0a (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 10 Apr 2021 17:26:30 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02B94C06138A
        for <linux-pwm@vger.kernel.org>; Sat, 10 Apr 2021 14:26:14 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lVL7N-0004UK-7n; Sat, 10 Apr 2021 23:26:13 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lVL7M-00086X-L8; Sat, 10 Apr 2021 23:26:12 +0200
Date:   Sat, 10 Apr 2021 23:26:12 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        kernel@pengutronix.de
Subject: Re: [PATCH 1/3] pwm: lpss: Don't modify HW state in .remove callback
Message-ID: <20210410212612.xdnbdbfckszcvqqb@pengutronix.de>
References: <20210407080155.55004-1-u.kleine-koenig@pengutronix.de>
 <YHBU5MqK+vjTGwio@orome.fritz.box>
 <20210410134601.ccqhuor3gd6pm2fw@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cqffeyv2kanhbxhc"
Content-Disposition: inline
In-Reply-To: <20210410134601.ccqhuor3gd6pm2fw@pengutronix.de>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--cqffeyv2kanhbxhc
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 10, 2021 at 03:46:01PM +0200, Uwe Kleine-K=F6nig wrote:
> On Fri, Apr 09, 2021 at 03:21:40PM +0200, Thierry Reding wrote:
> > On Wed, Apr 07, 2021 at 10:01:53AM +0200, Uwe Kleine-K=F6nig wrote:
> > > A consumer is expected to disable a PWM before calling pwm_put(). And=
 if
> > > they didn't there is hopefully a good reason (or the consumer needs
> > > fixing). Also if disabling an enabled PWM was the right thing to do,
> > > this should better be done in the framework instead of in each low le=
vel
> > > driver.
> > >=20
> > > So drop the hardware modification from the .remove() callback.
> > >=20
> > > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > > ---
> > >  drivers/pwm/pwm-lpss.c | 6 ------
> > >  1 file changed, 6 deletions(-)
> >=20
> > Applied, thanks.
>=20
> Great, but you didn't push yet. Is this still going through your own CI,
> or did you forget to push?

Oh, I thought you took the devm_pwmchip_add patch. I withdraw my
question.

Best regards
Uwe


--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--cqffeyv2kanhbxhc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmByF/EACgkQwfwUeK3K
7Antjgf9HNn7q5xY9oLyFmq1r8hVQKx7wwKu6ECwflmx6WAwxnU3nG3ySbkRSHRr
2NWs0fMjQRioLKadj0QsPEP2FDgFJDH9POAhpWhJUj8KIbKKgkUCBOytLQLCz3E1
ULNGyaPVdchsLv1+eLmKPVqiT7fK34dZGNwcvuIqZ18/uB4GrScxSzDfdZ4dYcFR
Fwt1pdzLhP2JoV2Qy7V9zB6XeEE5JBuiMEMXTmri/LbMxAFvz3YV8tCcO/0iqXaq
dpAV4/7XC8iMKhLpuVC/xuX96l3ZkZjHVFP5QJAbvXkEfzsxRKnEXpwAHe6wJQyg
GLoWbRAFdMWc//WwtCgeHQEjlYd8WA==
=IeQp
-----END PGP SIGNATURE-----

--cqffeyv2kanhbxhc--
