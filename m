Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3F196568AA
	for <lists+linux-pwm@lfdr.de>; Tue, 27 Dec 2022 10:04:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbiL0JEH (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 27 Dec 2022 04:04:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiL0JEH (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 27 Dec 2022 04:04:07 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7899364EF
        for <linux-pwm@vger.kernel.org>; Tue, 27 Dec 2022 01:04:05 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pA5rQ-0002nz-2t; Tue, 27 Dec 2022 10:03:00 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pA5rN-0022Dx-Lh; Tue, 27 Dec 2022 10:02:57 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pA5rM-008FyN-CP; Tue, 27 Dec 2022 10:02:56 +0100
Date:   Tue, 27 Dec 2022 10:02:53 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Jeff LaBundy <jeff@labundy.com>
Cc:     thierry.reding@gmail.com, linux-pwm@vger.kernel.org
Subject: Re: [PATCH] pwm: iqs620a: Replace one remaining instance of
 regmap_update_bits()
Message-ID: <20221227090253.nbck3kkwfpanrcgi@pengutronix.de>
References: <Y6p8cSYK+QKaKe7B@nixie71>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pvy2tcse2y62m3pf"
Content-Disposition: inline
In-Reply-To: <Y6p8cSYK+QKaKe7B@nixie71>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--pvy2tcse2y62m3pf
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Jeff,

On Mon, Dec 26, 2022 at 11:02:41PM -0600, Jeff LaBundy wrote:
> The call to regmap_update_bits() which was responsible for clearing
> the PWM output enable register bit was recently dropped in favor of
> a call to regmap_clear_bits(), thereby simplifying the code.
>=20
> Similarly, the call to regmap_update_bits() which sets the same bit
> can be simplified with a call to regmap_set_bits().
>=20
> Fixes: 2c85895bf3d2 ("pwm: iqs620a: Use regmap_clear_bits and regmap_set_=
bits where applicable")

I wouldn't call this a fix. This trailer triggers the stable guys to
backport the commit for stable. I wouldn't support that.

> Signed-off-by: Jeff LaBundy <jeff@labundy.com>
> ---
>  drivers/pwm/pwm-iqs620a.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-iqs620a.c b/drivers/pwm/pwm-iqs620a.c
> index 4987ca940b64..8362b4870c66 100644
> --- a/drivers/pwm/pwm-iqs620a.c
> +++ b/drivers/pwm/pwm-iqs620a.c
> @@ -55,8 +55,8 @@ static int iqs620_pwm_init(struct iqs620_pwm_private *i=
qs620_pwm,
>  	if (ret)
>  		return ret;
> =20
> -	return regmap_update_bits(iqs62x->regmap, IQS620_PWR_SETTINGS,
> -				  IQS620_PWR_SETTINGS_PWM_OUT, 0xff);

This is strange, because val has more bits set than mask
(IQS620_PWR_SETTINGS_PWM_OUT =3D=3D 0x80).

> +	return regmap_set_bits(iqs62x->regmap, IQS620_PWR_SETTINGS,
> +			       IQS620_PWR_SETTINGS_PWM_OUT);
>  }

The change looks fine however.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--pvy2tcse2y62m3pf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmOqtLoACgkQwfwUeK3K
7AmLeAf/VF0/ojyxipRCn0ijQ07eR+lslSrtWIh3RZQcws4Uj6qOiU7GZw04r8Gr
3pkwbYfJr65cEoPu5bwKCrcwep3Cc9XZzDRHDOokpVeKpwzSMKlRWgvlUX2MYLb4
V/b0kdO1rlheb2KDrb/T/m9KC3+R1FgkDbijUPQ4OQ7EadL9nkGPRJbTOkEZzV9F
4GsnZ83sxzMf5RS/B+IQ5Y5sUA7UVyT+4vZuoim0gFYC7zyxsQugc6e8A+Pqidbd
K/+ZMOBjO0bb4f8BIyhsbUk9Wf93FrOpwr8POZb59sKD8dki5dFMZshIs/bZ4MEx
03zg/5pdB0Q3GbLTdRK6/3qzFROStg==
=8R2q
-----END PGP SIGNATURE-----

--pvy2tcse2y62m3pf--
