Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A225E50BCC0
	for <lists+linux-pwm@lfdr.de>; Fri, 22 Apr 2022 18:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357655AbiDVQWG (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 22 Apr 2022 12:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243277AbiDVQWE (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 22 Apr 2022 12:22:04 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD5E85D5E0;
        Fri, 22 Apr 2022 09:19:07 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id x33so15157949lfu.1;
        Fri, 22 Apr 2022 09:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hd/YOrU1/XseKs5Z4uFXqpPft8fFu9wFFJjwMjBfrJE=;
        b=FfmC5TioF/bXG5xe57397BoZD3UNPLSC0+hoT5LKbDKbHR3hNmO+mtPyjfB8cFuudp
         1g33eQmLFWIAboTQA2mqAqbtBU0JWNS0NrAQC1Afm1XE2pmrLnUTrjsiRiW1otUVWxpQ
         QpQrxZiCHzhQomd8bAAexJz4QoN3RhojwjP1RiUNu8Ati6Xgju76XyimvLc6gIjjsHGN
         T01mogPLm2xDa3DAvOBoSEyLlQ9lfaeEoGFeBYqciqndIVngXdLAtS8fJXnYSKdTlQRJ
         MgENDIXXyFv0xL6ipv/qZI+F2Yq0bNHiN2u4SOSk1UvxmeHHb8t9LnhSpOEUHNkUSRyy
         e08g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hd/YOrU1/XseKs5Z4uFXqpPft8fFu9wFFJjwMjBfrJE=;
        b=ckeAjI/kh9g/rVTM12YNQN9CCWCvb+1J+p/gRlTrWjPwtSITSivD29ho8CHQc6n2fn
         +JX2FBsijb96S72oL8YjZAMRsQjINSS2D6T034KCVvtxD3IYYZYLOSE1Qc1vb4qJEpHa
         Rn9gsWohi0LYZmhAU5lz00w84fNVlzuqoqB6zij3x31sKxmcwm0CEP+K+VSnikfqpCD9
         vzTXUVdbbLiHe1CtWzpa1bhcQCMlpII5P0cDyWtNgOqEjNlYwnqXWebV+gOEnjuVzl9I
         8ZrMe6O0UCGLUYX9z6CfZyzMJWtYFES2M5SR7qTNT12jdyxoSWG831fMT8L0EGltt/ws
         oKfg==
X-Gm-Message-State: AOAM5330Qpqmuv0Vi/6ulUy7FerLJ94EkZRJRwjpUSnXuvNpfQ9K//vZ
        1w3SSyfYcfkPPN80aopdHy0=
X-Google-Smtp-Source: ABdhPJyAjop1xFvNuUQw2yN1ZQK32j9OuHX1+HGRoJxMoLjVw6T0+9Ehh1NQLftSepELWZ/+Z6Bemw==
X-Received: by 2002:a19:ac4d:0:b0:46b:ae5b:83dd with SMTP id r13-20020a19ac4d000000b0046bae5b83ddmr3518320lfc.557.1650644346089;
        Fri, 22 Apr 2022 09:19:06 -0700 (PDT)
Received: from orome ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id n16-20020a2ebd10000000b0024da2f52f5esm263786ljq.70.2022.04.22.09.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 09:19:05 -0700 (PDT)
Date:   Fri, 22 Apr 2022 18:19:03 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH] pwm: tegra: Optimize period calculation
Message-ID: <YmLVd+krwW82N/ER@orome>
References: <20220303175012.358613-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="O7cWjSVfhXJa/R6h"
Content-Disposition: inline
In-Reply-To: <20220303175012.358613-1-u.kleine-koenig@pengutronix.de>
User-Agent: Mutt/2.2.1 (c8109e14) (2022-02-19)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--O7cWjSVfhXJa/R6h
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 03, 2022 at 06:50:12PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> Dividing by the result of a division looses precision because the result =
is
> rounded twice. E.g. with clk_rate =3D 48000000 and period =3D 32760033 the
> following numbers result:
>=20
> 	rate =3D pc->clk_rate >> PWM_DUTY_WIDTH =3D 187500
> 	hz =3D DIV_ROUND_CLOSEST_ULL(100ULL * NSEC_PER_SEC, period_ns) =3D 3052
> 	rate =3D DIV_ROUND_CLOSEST_ULL(100ULL * rate, hz) =3D 6144
>=20
> The exact result would be 6142.5061875 and (apart from rounding) this is
> found by using a single division. As a side effect is also a tad
> cheaper to calculate.
>=20
> Also using clk_rate >> PWM_DUTY_WIDTH looses precision. Consider for
> example clk_rate =3D 47999999 and period =3D 106667:
>=20
> 	mul_u64_u64_div_u64(pc->clk_rate >> PWM_DUTY_WIDTH, period_ns,
> 			    NSEC_PER_SEC) =3D 19
>=20
> 	mul_u64_u64_div_u64(pc->clk_rate, period_ns,
> 			    NSEC_PER_SEC << PWM_DUTY_WIDTH) =3D 20
>=20
> (The exact result is 20.000062083332033.)
>=20
> With this optimizations also switch from round-closest to round-down. Giv=
en
> that the calculations were non-optimal for quite some time now which
> nobody reported as a problem, this is the opportunity to align the driver=
's
> behavior to the requirements of new drivers. (Note however that the
> duty_cycle calculation isn't aligned yet.)
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/pwm/pwm-tegra.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
> index e5a9ffef4a71..7fc03a9ec154 100644
> --- a/drivers/pwm/pwm-tegra.c
> +++ b/drivers/pwm/pwm-tegra.c
> @@ -99,7 +99,7 @@ static int tegra_pwm_config(struct pwm_chip *chip, stru=
ct pwm_device *pwm,
>  			    int duty_ns, int period_ns)
>  {
>  	struct tegra_pwm_chip *pc =3D to_tegra_pwm_chip(chip);
> -	unsigned long long c =3D duty_ns, hz;
> +	unsigned long long c =3D duty_ns;
>  	unsigned long rate, required_clk_rate;
>  	u32 val =3D 0;
>  	int err;
> @@ -156,11 +156,9 @@ static int tegra_pwm_config(struct pwm_chip *chip, s=
truct pwm_device *pwm,
>  		pc->clk_rate =3D clk_get_rate(pc->clk);
>  	}
> =20
> -	rate =3D pc->clk_rate >> PWM_DUTY_WIDTH;
> -
>  	/* Consider precision in PWM_SCALE_WIDTH rate calculation */
> -	hz =3D DIV_ROUND_CLOSEST_ULL(100ULL * NSEC_PER_SEC, period_ns);
> -	rate =3D DIV_ROUND_CLOSEST_ULL(100ULL * rate, hz);
> +	rate =3D mul_u64_u64_div_u64(pc->clk_rate, period_ns,
> +				   (u64)NSEC_PER_SEC << PWM_DUTY_WIDTH);
> =20
>  	/*
>  	 * Since the actual PWM divider is the register's frequency divider
> @@ -169,6 +167,8 @@ static int tegra_pwm_config(struct pwm_chip *chip, st=
ruct pwm_device *pwm,
>  	 */
>  	if (rate > 0)
>  		rate--;
> +	else
> +		return -EINVAL;

Can you elaborate on why this is needed? Previously rate =3D=3D 0 was a
valid case and this could still happen with the above calculations.

Thierry

--O7cWjSVfhXJa/R6h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmJi1XcACgkQ3SOs138+
s6EoYhAAg0R7EqfpM7eyn3WkKPkUvAwQJgAVv0ZY4X6Zeh8dvBNV2E/PJnzyvXmO
mBqyaAHXD0llFNPWfjrwTkAQTH80RHA3MY0z65MyVnetzl/gumhJP+/aP/Kyk4yS
TAGP+jBaj/ZAQ7vp0V2CHU6bEgw+HkQyLjF5JD0eJ2KiaEOHjuY7S0gQgb/x9ExD
4asud0nz5JmRUpBgc+ePPKgw2IFdIpL8NffuC+CAy2VppJJ4EloZP3rodEsB34aH
Dt0sTwIXn+uGS9FWivkrFBPWQUa3l648p1Xx3/jW4L0vbxecGFOw7nUORHOlLjb9
Gv1IOuDoneKv+Tb6QKgncJNWDZk59eNYeAIXgcVqpPju8DwBlNRuVuDsw66c1R7K
goRKpDrkBhsnG9oFSBn2Ez9DlGFXJdFuE8XC462mLwRRyVhFVrG4YxX1X5eICfhH
ckmRgGmFtjYQ0KbMARgKCpT8fcgndXf5+RA6o/0DynVcNfyP6wPbnfrcjxjxs03A
4RePzFxv1Z48el7W44EfatSqPioXdMWkZaX28NDBdnuObfvl5lw1DAUbXCK2p5FY
U8mp6sHz7oZ63Nko96AqZW+6zn5eNhw/DIIfQhiwRl7chQeL4Xq1CAwk6A0JiSZs
tqzZVmnyPbJzbGOhbFBABFVS227WDcZUw9i5i+BCMrLKR1bFgYU=
=oKhv
-----END PGP SIGNATURE-----

--O7cWjSVfhXJa/R6h--
