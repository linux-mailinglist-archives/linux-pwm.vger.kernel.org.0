Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2DF520D947
	for <lists+linux-pwm@lfdr.de>; Mon, 29 Jun 2020 22:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732756AbgF2TqE (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 29 Jun 2020 15:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388077AbgF2Tpy (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 29 Jun 2020 15:45:54 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97507C061755
        for <linux-pwm@vger.kernel.org>; Mon, 29 Jun 2020 12:45:54 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1jpziy-00084a-Re; Mon, 29 Jun 2020 21:45:52 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1jpziy-0005Sc-2g; Mon, 29 Jun 2020 21:45:52 +0200
Date:   Mon, 29 Jun 2020 21:45:51 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     thierry.reding@gmail.com, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Yendapally Reddy Dhananjaya Reddy 
        <yendapally.reddy@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH 1/4] pwm: bcm-iproc: Remove impossible comparison when
 validating duty cycle
Message-ID: <20200629194551.nlsgjlc6g35taks6@pengutronix.de>
References: <20200629124752.1018358-1-lee.jones@linaro.org>
 <20200629124752.1018358-2-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nfpd2ci3eiscija7"
Content-Disposition: inline
In-Reply-To: <20200629124752.1018358-2-lee.jones@linaro.org>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--nfpd2ci3eiscija7
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 29, 2020 at 01:47:49PM +0100, Lee Jones wrote:
> 'duty' here is an unsigned int, thus checking for <0 will always
> evaluate to false.
>=20
> Fixes the following W=3D1 warning:
>=20
>  drivers/pwm/pwm-bcm-iproc.c:147:12: warning: comparison of unsigned expr=
ession < 0 is always false [-Wtype-limits]
>=20
> Cc: Ray Jui <rjui@broadcom.com>
> Cc: Scott Branden <sbranden@broadcom.com>
> Cc: Yendapally Reddy Dhananjaya Reddy <yendapally.reddy@broadcom.com>
> Cc: bcm-kernel-feedback-list@broadcom.com
> Cc: linux-pwm@vger.kernel.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/pwm/pwm-bcm-iproc.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-bcm-iproc.c b/drivers/pwm/pwm-bcm-iproc.c
> index 1f829edd8ee70..46f0a45e9049c 100644
> --- a/drivers/pwm/pwm-bcm-iproc.c
> +++ b/drivers/pwm/pwm-bcm-iproc.c
> @@ -143,8 +143,7 @@ static int iproc_pwmc_apply(struct pwm_chip *chip, st=
ruct pwm_device *pwm,
>  		value =3D rate * state->duty_cycle;
>  		duty =3D div64_u64(value, div);
> =20
> -		if (period < IPROC_PWM_PERIOD_MIN ||
> -		    duty < IPROC_PWM_DUTY_CYCLE_MIN)
> +		if (period < IPROC_PWM_PERIOD_MIN)
>  			return -EINVAL;
> =20
>  		if (period <=3D IPROC_PWM_PERIOD_MAX &&

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--nfpd2ci3eiscija7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl76ROwACgkQwfwUeK3K
7Ambxwf/R6wYgRkhf9eNfmHQhlvmhydLzULYpt4yxZAlGdgVBIv5d0queLbzMC/A
+Rg9YS0L+QlaHXscl/HMURmyNE/ogz70JD/K+RD9gtRABEX1qC6VCXudZ372QVkZ
CnsUQXpva36Q680MkvM7Df3pJmj82YvCRDkpyOfXdb66d28bKKZXfqnACTzESIzp
7eAIMtkdY1sOUA9pFIGrujjVrtpvXjUy7X+eq0lxspMoRxeMb9fqm40kVCbPCdEO
gILougjq73SO3L2Q14oh/3XydBgc87caM1yhihbz3OamZd6m/BEp0pUvHTeNHpdJ
GIXb0dYXi44CkLHakoWrXsYEAoelcA==
=0gnH
-----END PGP SIGNATURE-----

--nfpd2ci3eiscija7--
