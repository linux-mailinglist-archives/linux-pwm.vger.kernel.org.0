Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2671F3489E5
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Mar 2021 08:12:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbhCYHMX (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 25 Mar 2021 03:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbhCYHLz (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 25 Mar 2021 03:11:55 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 095F4C06174A
        for <linux-pwm@vger.kernel.org>; Thu, 25 Mar 2021 00:11:55 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lPK9n-00083p-Vc; Thu, 25 Mar 2021 08:11:51 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lPK9m-0001RC-MB; Thu, 25 Mar 2021 08:11:50 +0100
Date:   Thu, 25 Mar 2021 08:11:50 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Ray Jui <ray.jui@broadcom.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, Ray Jui <rjui@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, kernel@pengutronix.de,
        Scott Branden <sbranden@broadcom.com>,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH] pwm: bcm-iproc: Free resources only after
 pwmchip_remove()
Message-ID: <20210325071150.627lorrnfxpqqalr@pengutronix.de>
References: <20210324200134.75513-1-u.kleine-koenig@pengutronix.de>
 <aea0642b-5646-e368-7f8b-358a7c72659c@broadcom.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="b3aw6snem5egs5zb"
Content-Disposition: inline
In-Reply-To: <aea0642b-5646-e368-7f8b-358a7c72659c@broadcom.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--b3aw6snem5egs5zb
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Wed, Mar 24, 2021 at 02:15:23PM -0700, Ray Jui wrote:
> On 3/24/2021 1:01 PM, Uwe Kleine-K=F6nig wrote:
> > Before pwmchip_remove() returns the PWM is expected to be functional. So
> > remove the pwmchip before disabling the clock.
> >=20
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > ---
> >  drivers/pwm/pwm-bcm-iproc.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/pwm/pwm-bcm-iproc.c b/drivers/pwm/pwm-bcm-iproc.c
> > index 529a66ab692d..edd2ce1760ab 100644
> > --- a/drivers/pwm/pwm-bcm-iproc.c
> > +++ b/drivers/pwm/pwm-bcm-iproc.c
> > @@ -253,9 +253,11 @@ static int iproc_pwmc_remove(struct platform_devic=
e *pdev)
> >  {
> >  	struct iproc_pwmc *ip =3D platform_get_drvdata(pdev);
> > =20
> > +	pwmchip_remove(&ip->chip);
> > +
> >  	clk_disable_unprepare(ip->clk);
> > =20
> > -	return pwmchip_remove(&ip->chip);
> > +	return 0;
>=20
> This is a good fix! Given that there appears to be a race condition
> where the clock can be disabled before the PWM device unregisters from
> the framework, I assume we might be seeing hangs in corner cases without
> this fix, i.e., PWM device accessed with clock disabled. Then does it
> make sense to add a fixes tag so this fix is also picked up by LTS?

The hangs are usually short, so I'm unsure if it's worth the backport.
Also before commit b2c200e3f2fd ("pwm: Add consumer device link")---which
is in v5.3-rc1---you cannot ignore the return value of pwmchip_remove().

(And before that change if pwmchip_remove() returned an error the
situation was grave compared to that clock skew. So on the other hand we
could drop the return value check there, too, without making the
situation considerably worse.)

Anyhow, the offending commit is (little surprisingly)

	daa5abc41c80 (pwm: Add support for Broadcom iProc PWM controller)

which appeared in 4.7-rc1. I let Thierry decide if he want to add this
fixes line.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--b3aw6snem5egs5zb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmBcN7MACgkQwfwUeK3K
7AmwWgf9FtKk561BtFoRyXkgTLQz/GxdOoN+qOIf26V0aguSa/iuNXKk0Pem3kKp
bLyl5uHGSQ1UHCcyph3lGvzI92jxDpZBZ+ErFhjSaND/x4dgw0Y7QjN4qM5IGtfa
J71VleGBnQBJiV179jyt9axOUqZsegy3q1xSen2x36DfTigl/nI6+eNF2KT1sfOI
/d2f9ryig7WfbKUb/axgWXkxluHdVERkWo0x1AGXTJTbgghlIilK3iDkor8wkVb+
KXUM4vuxQKKKaUWf/aU7YNJsifXBsqnFM67oianHSnEeEHlx8inlEbScwWaO3RqA
NY+cbAosjI3v5Al8cGe25g85LPogLg==
=T57Z
-----END PGP SIGNATURE-----

--b3aw6snem5egs5zb--
