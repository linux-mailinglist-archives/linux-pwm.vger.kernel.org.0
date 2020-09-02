Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E14125A623
	for <lists+linux-pwm@lfdr.de>; Wed,  2 Sep 2020 09:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbgIBHIs (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 2 Sep 2020 03:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbgIBHIr (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 2 Sep 2020 03:08:47 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94371C061244
        for <linux-pwm@vger.kernel.org>; Wed,  2 Sep 2020 00:08:47 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kDMsu-00039W-RC; Wed, 02 Sep 2020 09:08:44 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1kDMsu-0007Ke-Gl; Wed, 02 Sep 2020 09:08:44 +0200
Date:   Wed, 2 Sep 2020 09:08:44 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     David Jander <david@protonic.nl>
Cc:     Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        Clemens Gruber <clemens.gruber@pqgruber.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, linux-pwm@vger.kernel.org,
        Oleksij Rempel <o.rempel@pengutronix.de>
Subject: Re: [PATCH v2 1/3] drivers: pwm: pwm-pcs9685.c: Make comments more
 consistent
Message-ID: <20200902070844.bqb6ic7fju4j6wwm@pengutronix.de>
References: <20200828121415.1292388-1-david@protonic.nl>
 <20200828121415.1292388-2-david@protonic.nl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ccgshvxya4lqwvw5"
Content-Disposition: inline
In-Reply-To: <20200828121415.1292388-2-david@protonic.nl>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--ccgshvxya4lqwvw5
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 28, 2020 at 02:14:13PM +0200, David Jander wrote:
> Make all explanatory comments start with an uppercase char.
>=20
> Signed-off-by: David Jander <david@protonic.nl>
> ---
>  drivers/pwm/pwm-pca9685.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
> index 76cd22bd6614..0f1a3e07e501 100644
> --- a/drivers/pwm/pwm-pca9685.c
> +++ b/drivers/pwm/pwm-pca9685.c
> @@ -91,7 +91,7 @@ static bool pca9685_pwm_test_and_set_inuse(struct pca96=
85 *pca, int pwm_idx)
>  	mutex_lock(&pca->lock);
>  	if (pwm_idx >=3D PCA9685_MAXCHAN) {
>  		/*
> -		 * "all LEDs" channel:
> +		 * "All LEDs" channel:

I'd not replace this one, assuming "all LEDs" is a term from the
datasheet.

>  		 * pretend already in use if any of the PWMs are requested
>  		 */
>  		if (!bitmap_empty(pca->pwms_inuse, PCA9685_MAXCHAN)) {
> @@ -100,7 +100,7 @@ static bool pca9685_pwm_test_and_set_inuse(struct pca=
9685 *pca, int pwm_idx)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ccgshvxya4lqwvw5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl9PRPkACgkQwfwUeK3K
7AknuAf9Ebjxs6D5tU11F5J9TE6Cg11kC0cUZBATjKJuBWuXF4y8ZEfyLnns5uJu
9YNwhIxXpk5+VCJ4L4hZO8DLw+ECrOGyWOogTp77rSghI80hf/UJGmU83P6XazJr
oPPATdXyKxbPSMWji00vx+h0ruC/6wy1kVIdyb9Cpb9Z4+fDmF7ZFbX9cRn3Ds2a
SDqBkfPrhOx8xVUY/3p8i3pfRRK5wYceCi358wgybLI1waL8fJyHMmSYtDXOUaQV
VwrZPbmn9vSjIrBTzDfxFLYBCCUinwgtyKnbln6YApaPa4tiiOf7Ty1Ci8bBpORc
L9CkGwoGQHymlKODFj1Sai5T1QAlgQ==
=/54Q
-----END PGP SIGNATURE-----

--ccgshvxya4lqwvw5--
