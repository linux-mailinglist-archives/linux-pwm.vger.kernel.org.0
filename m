Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA91C40E9E7
	for <lists+linux-pwm@lfdr.de>; Thu, 16 Sep 2021 20:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241558AbhIPScB (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 16 Sep 2021 14:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345343AbhIPSbf (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 16 Sep 2021 14:31:35 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69C1EC0A2368
        for <linux-pwm@vger.kernel.org>; Thu, 16 Sep 2021 09:47:53 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mQuY8-0007kn-MO; Thu, 16 Sep 2021 18:47:48 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mQuY6-0004hO-Ic; Thu, 16 Sep 2021 18:47:46 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mQuY6-0001PV-HJ; Thu, 16 Sep 2021 18:47:46 +0200
Date:   Thu, 16 Sep 2021 18:47:46 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-pwm@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Duc Nguyen <duc.nguyen.ub@renesas.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] pwm: renesas-tpu: don't allow no duty if duty_ns is
 given
Message-ID: <20210916164746.rujqwpnrm4i6lf7z@pengutronix.de>
References: <20210915065542.1897-1-wsa+renesas@sang-engineering.com>
 <20210915065542.1897-3-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rc23usyhskkfrhzk"
Content-Disposition: inline
In-Reply-To: <20210915065542.1897-3-wsa+renesas@sang-engineering.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--rc23usyhskkfrhzk
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 15, 2021 at 08:55:41AM +0200, Wolfram Sang wrote:
> From: Duc Nguyen <duc.nguyen.ub@renesas.com>
>=20
> We have special code if duty_ns is 0. But if non-zero is given, then the
> calculation should not result in zero duty.

Why not? Assuming a PWM that supports multiples of say 100 ns for
duty_cycle, rounding a request for 550 ns down to 500 ns isn't worse
than rounding down a request for 50 ns to 0 ns is it?
=20
> Signed-off-by: Duc Nguyen <duc.nguyen.ub@renesas.com>
> [wsa: split and reworded commit message]
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  drivers/pwm/pwm-renesas-tpu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/pwm/pwm-renesas-tpu.c b/drivers/pwm/pwm-renesas-tpu.c
> index 754440194650..bb51156e4bda 100644
> --- a/drivers/pwm/pwm-renesas-tpu.c
> +++ b/drivers/pwm/pwm-renesas-tpu.c
> @@ -275,7 +275,7 @@ static int tpu_pwm_config(struct pwm_chip *chip, stru=
ct pwm_device *_pwm,
>  	if (duty_ns) {
>  		duty =3D clk_rate / prescalers[prescaler]
>  		     / (NSEC_PER_SEC / duty_ns);

Unrelated to the change under discussion here: Dividing by the result of
a division is bad.=20

Consider:
	clk_rate =3D 1333333333
	prescalers[prescaler] =3D 43
	duty_ns =3D 500000001

The exact result is 15503875.996124031, with the above formula you get
31007751 which is off by nearly a factor of two.

These numbers are probably not relevant, but they show the problem.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--rc23usyhskkfrhzk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmFDdS4ACgkQwfwUeK3K
7AnUQAgAmjJkLhnY8ifBEORHpJuO7fpbsjyT8WptyK9dTJgqg0jPJEwCgl/eCi2Y
ZNLZ986jXRsiQerhDIofYYaSQhoCDG8YN29BCp3Gbl/TSe37Isg5kwSX9RYC2c7n
Hiy3vGPwmNzYshtE8HjLKHWCNZqUy85sUmDN6auecy9SIWG5YLvEDlF5Wnku28x6
qG4OpOuIM3aSRh6NbpDwqQGvgHXoZl7AdeCJjUD9C+oehyNAZ9WOh7E8FSkO7ofq
/JGg1vHJLFiMeh1WVKIuJFkIA/mGsQKzYHnk/h8dvbD0eIFfHYYFSSCGfb3OSSPd
2pVWCqEQ9MSIYgX13cINC7O8z12RlA==
=7YDn
-----END PGP SIGNATURE-----

--rc23usyhskkfrhzk--
