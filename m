Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6FD27D5CF0
	for <lists+linux-pwm@lfdr.de>; Tue, 24 Oct 2023 23:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344249AbjJXVMN (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 24 Oct 2023 17:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344160AbjJXVMM (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 24 Oct 2023 17:12:12 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4CC610CE
        for <linux-pwm@vger.kernel.org>; Tue, 24 Oct 2023 14:12:10 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qvOgx-0005EP-SP; Tue, 24 Oct 2023 23:11:59 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qvOgw-00421X-Cl; Tue, 24 Oct 2023 23:11:58 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qvOgw-005XxO-3K; Tue, 24 Oct 2023 23:11:58 +0200
Date:   Tue, 24 Oct 2023 23:11:57 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-pwm@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] pwm: samsung: Fix a bit test
Message-ID: <20231024211157.xv3vzqlmxmxwgvle@pengutronix.de>
References: <917e3890-7895-4b1c-bcee-4eecb3b7fe09@moroto.mountain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nkibwm3sl7ikb3rs"
Content-Disposition: inline
In-Reply-To: <917e3890-7895-4b1c-bcee-4eecb3b7fe09@moroto.mountain>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--nkibwm3sl7ikb3rs
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Dan,

On Tue, Oct 17, 2023 at 05:04:08PM +0300, Dan Carpenter wrote:
> This code has two problems.  First, it passes the wrong bit parameter to
> test_bit().  Second, it mixes using PWMF_REQUESTED in test_bit() and in
> open coded bit tests.
>=20
> The test_bit() function takes a bit number.  In other words,
> "if (test_bit(0, &flags))" is the equivalent of "if (flags & (1 << 0))".
> Passing (1 << 0) to test_bit() is like writing BIT(BIT(0)).  It's a
> double shift bug.
>=20
> In pwm_samsung_resume() these issues mean that the flag is never set and
> the function is essentially a no-op.
>=20
> Fixes: 4c9548d24c0d ("pwm: samsung: Put per-channel data into driver data=
")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
> From static analysis and not tested.
>=20
>  drivers/pwm/pwm-samsung.c | 2 +-
>  include/linux/pwm.h       | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-samsung.c b/drivers/pwm/pwm-samsung.c
> index 10fe2c13cd80..acf4a0d8d990 100644
> --- a/drivers/pwm/pwm-samsung.c
> +++ b/drivers/pwm/pwm-samsung.c
> @@ -630,7 +630,7 @@ static int pwm_samsung_resume(struct device *dev)
>  		struct pwm_device *pwm =3D &chip->pwms[i];
>  		struct samsung_pwm_channel *chan =3D &our_chip->channel[i];
> =20
> -		if (!(pwm->flags & PWMF_REQUESTED))
> +		if (!test_bit(PWMF_REQUESTED, &pwm->flags))
>  			continue;
> =20
>  		if (our_chip->variant.output_mask & BIT(i))
> diff --git a/include/linux/pwm.h b/include/linux/pwm.h
> index e3b437587b32..3eee5bf367fb 100644
> --- a/include/linux/pwm.h
> +++ b/include/linux/pwm.h
> @@ -41,8 +41,8 @@ struct pwm_args {
>  };
> =20
>  enum {
> -	PWMF_REQUESTED =3D 1 << 0,
> -	PWMF_EXPORTED =3D 1 << 1,
> +	PWMF_REQUESTED =3D 0,
> +	PWMF_EXPORTED  =3D 1,

I'd want s/  / / here. Or even not assign explicit values at all?

>  };
> =20
>  /*

I'd say these are two separate issues, with the one in pwm-samsung being
bad and the one in <linux/pwm.h> "only" ugly.

I wonder how I could get the samsung part wrong. All current usages of
PMWF_REQUESTED (and also PWMF_EXPORTED) use test_bit (et al). Grepping
through history pwm-pca9685.c got this wrong in a similar way for some
time, but otherwise it was always used correctly.

The definition of the flags in <linux/pwm.h> is ugly since=20
f051c466cf69 ("pwm: Allow chips to support multiple PWMs") from 2011!

@Dan: Would you split the patch in two please?

Thanks for catching that!

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--nkibwm3sl7ikb3rs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmU4Mx0ACgkQj4D7WH0S
/k7KQwf/eaAyfpovq4WF+Ttz94ctJhg4PD7Nk9TRKnE72mEh/giRc3ZaQ6RY3ybw
1ymd1StO/XRx6QtH16VFBW7x3FHcxMedBndun4K33rruSUaaQ9lw+Br8FPNuHFmg
akDIcusQDG+PUR2K2ERAAELHU0cmFHxG78jbUZ+Y/+lQg7JEiRLW4lFvMSzTsJMs
I4i3EzBZXRpcFPk80HoA9PhECYqP+OleLpUmuc53hRb8txwJpSJrWjohaXP45ps0
gEcS7ItZJQOjDvc5bHEy6/DOwdhtbZU/nuOqqGLqs4PIuM2WARmQKrtVCl4IMrJ1
5sd5d5F3TWurS/8+vXSjNWQj+fMOAQ==
=qrEt
-----END PGP SIGNATURE-----

--nkibwm3sl7ikb3rs--
