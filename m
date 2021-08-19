Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 599083F1A5F
	for <lists+linux-pwm@lfdr.de>; Thu, 19 Aug 2021 15:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240106AbhHSN3M (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 19 Aug 2021 09:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240102AbhHSN3M (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 19 Aug 2021 09:29:12 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF99EC061575
        for <linux-pwm@vger.kernel.org>; Thu, 19 Aug 2021 06:28:35 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id f5so9084460wrm.13
        for <linux-pwm@vger.kernel.org>; Thu, 19 Aug 2021 06:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3sAOG6+KCDqPz1V1vilx/hMSA+4bNbqm3jb2fzSKed4=;
        b=D3b+Xjps5II89Ldxbi/LYwnAfJ+/Qtn1RrkGEAVF8WgTdKvryrKJ5IF26xWkE9UO8p
         HIz6D7W5ws0ZzNqcWVxBCGVr5G2dqODJXXYUMSXPSK3SYNWvR1un1PKchKVXQq5aD+ZU
         xqWibB8YGVr9B03mB/nGXNHPEun/bkF8fUQR1kzubU8L1ydy2VrR+bHAxRf121lIFzYu
         JHVoxMzdCoQ1wboc94P5QUbuFDIyaFOmlZtI/HKSDZAkM7PZ+l+9NLhiEtLJiNgfPe2g
         ndFlUZk3wkTWIxro78Bv+yEjOI3TVa3Dj1fp8bBBREs+m6pG+xXMlpbm+RlKtaS8Wc6b
         5JqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3sAOG6+KCDqPz1V1vilx/hMSA+4bNbqm3jb2fzSKed4=;
        b=V4+xKbo2T/QqvNwWQro6c1ooK7l2u/S/CcyOrs4KqopyCra1JtlKNz5B4aNLBD77u7
         QWeYSFFBKQVE1HXBmrMkEdSwN6MZ5JcEL7aFX3gXswfWA/D5k1V5O1du0si85MhzGlu3
         fOs+bV1h/sz8G6qKjKLlpDSOok1PdBGWvicvTqaIyFr5dpqjLBzg9Jk+8nnLedYWzwIe
         biMA7wYWzz/aQF5o3d2tGMkpDXGXUY5T0Bn5BWoyxAY9DcpaR24yGgyN8+FGVaEw3/4n
         NODGoBOoUAgNA6qNpTKKLwFAnEVFhQqYYU37BJIS0/zztLx38F2TLnlYFirQ/KZdfMm/
         h2jg==
X-Gm-Message-State: AOAM5331mlLdZBdYWfSTdhy5LjFFu7rZIM5cyW7gWPZvKAN7KOAX6JDv
        aNg+8Z8ecTyw34MmaFou/cg=
X-Google-Smtp-Source: ABdhPJxpUjisqaBTEoceaRnANYKDukTm5eAAwHschXxuh6k5EtPaCnRSxb9cJZ6OF1p+KknFVET4dQ==
X-Received: by 2002:adf:e746:: with SMTP id c6mr3821514wrn.276.1629379713936;
        Thu, 19 Aug 2021 06:28:33 -0700 (PDT)
Received: from localhost ([217.111.27.204])
        by smtp.gmail.com with ESMTPSA id z8sm2891174wrt.77.2021.08.19.06.28.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 06:28:32 -0700 (PDT)
Date:   Thu, 19 Aug 2021 15:28:31 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-pwm@vger.kernel.org,
        kernel@pengutronix.de, Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 3/3] pwm: Restore initial state if a legacy callback fails
Message-ID: <YR5cf+UIpc3lLotK@orome.fritz.box>
References: <20210701072927.328254-1-u.kleine-koenig@pengutronix.de>
 <20210701072927.328254-4-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="NFDDAHIHqC+jbcN4"
Content-Disposition: inline
In-Reply-To: <20210701072927.328254-4-u.kleine-koenig@pengutronix.de>
User-Agent: Mutt/2.1.1 (e2a89abc) (2021-07-12)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--NFDDAHIHqC+jbcN4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 01, 2021 at 09:29:27AM +0200, Uwe Kleine-K=C3=B6nig wrote:
> It is not entirely accurate to go back to the initial state after e.g.
> .enable() failed, as .config() still modified the hardware, but this same
> inconsistency exists for drivers that implement .apply().
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/pwm/core.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> index 20afe6d0bc5e..6e30ef9b9b79 100644
> --- a/drivers/pwm/core.c
> +++ b/drivers/pwm/core.c
> @@ -539,10 +539,8 @@ static int pwm_apply_legacy(struct pwm_chip *chip, s=
truct pwm_device *pwm,
>  			    const struct pwm_state *state)
>  {
>  	int err;
> +	struct pwm_state initial_state =3D pwm->state;
> =20
> -	/*
> -	 * FIXME: restore the initial state in case of error.
> -	 */
>  	if (state->polarity !=3D pwm->state.polarity) {
>  		if (!chip->ops->set_polarity)
>  			return -EINVAL;
> @@ -563,7 +561,7 @@ static int pwm_apply_legacy(struct pwm_chip *chip, st=
ruct pwm_device *pwm,
> =20
>  		err =3D chip->ops->set_polarity(chip, pwm, state->polarity);
>  		if (err)
> -			return err;
> +			goto rollback;
> =20
>  		pwm->state.polarity =3D state->polarity;
>  	}
> @@ -586,7 +584,7 @@ static int pwm_apply_legacy(struct pwm_chip *chip, st=
ruct pwm_device *pwm,
>  				state->duty_cycle,
>  				state->period);
>  	if (err)
> -		return err;
> +		goto rollback;
> =20
>  	pwm->state.period =3D state->period;
>  	pwm->state.duty_cycle =3D state->duty_cycle;
> @@ -594,10 +592,14 @@ static int pwm_apply_legacy(struct pwm_chip *chip, =
struct pwm_device *pwm,
>  	if (!pwm->state.enabled) {
>  		err =3D chip->ops->enable(chip, pwm);
>  		if (err)
> -			return err;
> +			goto rollback;
>  	}
> =20
>  	return 0;
> +
> +rollback:
> +	pwm->state =3D initial_state;
> +	return err;
>  }

Can't we achieve the same thing by just removing all the updates to
pwm->state in pwm_apply_legacy()? Patch 1 in the series now does
pwm->state =3D *state for both the atomic and the legacy cases, so if
we don't update pwm->state explicitly in pwm_apply_legacy(), then
there should be no need to rollback, right?

What we currently do is a bit redundant anyway. pwm->state =3D *state
should be a no-op after pwm_apply_legacy().

Thierry

--NFDDAHIHqC+jbcN4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmEeXH8ACgkQ3SOs138+
s6FPmRAAgqOx7g7+ZhjfU3x+Db//1VG4Clorc7PZIxvmv5VGBe0bIxC8b/VTgHGV
ctTfaV3f8DOrc9JBy44hagh48ySzD/RuOPgvrQMDkKDwWlCIKAzXKTSXhjAURF69
ZnFZnIDewWxCRp9u7kLAg7GSlzOumqrC8diS7vzXvCLiwrA6LGVGl7Xj/0f3ywaE
yeOXj9t8xudqwdrt9aRhw+jdh05ovG7+unFtAoEHCdAAL+ox6TH/QM4VF1jvnoPs
CNb734OaCBSDqFBCO+bG8EY+Jfg5uuGB5BdOWgEclM7s3meNcLK0Qvl0Ria0UBrF
CzroCCctljZ075zfgJT0477eoUzlPt8GLoIaKiu/6F5fk9IAiKax0nRZb9Qsb4Ys
9MVcvwSjpzLzinUddAT2gIFAhI6/TadLX2c7qejRDgWFb7v8qIYpHhs1EjRmmOk6
2o1BORsO9N0KrEYUbSOUbbCJDdpRFV1FTr+LlkkwdyfBj4yebLgqdLlUgz7W+mX9
qk1qqihz7tlSth9iFMoXvlw35N+Syewi4NkBG2b5oDxMtf1N1uoWGVjQ42DnKn9P
HelZsUH7qhwTavDJeQb5qz7FF6K4vCnz2Z9/jly7RYNLQi5hFcvEYYXseoYox3vV
ujqx5g81nFOCyJbr5zDu921PjYAzSzCesJ7OZEkTcvH6BZsx8sQ=
=p9L9
-----END PGP SIGNATURE-----

--NFDDAHIHqC+jbcN4--
