Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E0BA3F1A75
	for <lists+linux-pwm@lfdr.de>; Thu, 19 Aug 2021 15:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240035AbhHSNhG (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 19 Aug 2021 09:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240010AbhHSNhG (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 19 Aug 2021 09:37:06 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 117A2C061575
        for <linux-pwm@vger.kernel.org>; Thu, 19 Aug 2021 06:36:30 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id c129-20020a1c35870000b02902e6b6135279so4092286wma.0
        for <linux-pwm@vger.kernel.org>; Thu, 19 Aug 2021 06:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dm/L8U1aG5H1oQiUun8vCPahjYzgBeQ9/12UDiYhpmc=;
        b=outrQLGfLeDnln0w55atm8TK9GxZw7zKW4oMBc0r2wl2OYYndYIIuPCoTifmUFZCUS
         5q2lqJ30OLy/aKaL1t0dePzR/9T2suTfS+C5TDLYvbWs/ozwngIAf4vEDgi4VyUj6hOu
         qHLXj29D6+PjPecoGsfQI1HYGVpNh7vJ6sY32dRI7/pc5MzJFhaInZ+MpYP70sP4BMY8
         ND6PGEQavOVM4v+rjy3sOZKWw8NBH5LbZ1b1FeaxPttCUr1PmGN9pfshNbflqSNJvVmd
         lWx7Q5kdgSTk/AP867XLyO6YPxmjtaVV0LIa7OM9jFAlWrYRI+BxYej3FP+cvrquhYnw
         EXAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dm/L8U1aG5H1oQiUun8vCPahjYzgBeQ9/12UDiYhpmc=;
        b=AYlIfYjPJEzD1UeyOgM6ucQZsvDq5rLdaE6EX4Hb4q2OWaXtCNrLzY5xfgPbjDzNaL
         rFl50j7aIp3TLXUjib4DdSjEJ9yBVKan0TBhka6xDIEm2GkYTsXN0IJ/Piu073S5v9WB
         kLpDTlftsIsW0x32ES+OzxlMdoMAHxp9mkeoT8Sb4l8w109H8iw7R2TgMw1F1xjotXA2
         sDu60fCAMn9EvXW/C68W3hUr2a3ZkrDV4Dygdnp9+CrfsEQbNHmBnOpMp2MhPhnA2+Pq
         8CZxPF1eChBU8ixpv4XyH48e5alh/f9/QGtBtji9Grn8vE1nVipRWRfwPzAmJoZ68dNW
         q5Lw==
X-Gm-Message-State: AOAM530B3wUdK1cqaPJLyYzqR72To7ubCieFZRIchN+J/4VHcqEnvbO7
        N07xJ6J4uh1OGOFwPLYFjqc=
X-Google-Smtp-Source: ABdhPJykEnGh1qbT5dCE+Ofb4ghkeaat8ZEKFmzgdu37bzmpzSs7J5C9AOGo0eX8TsA8fyJKI7LlXA==
X-Received: by 2002:a05:600c:210a:: with SMTP id u10mr13918722wml.162.1629380188675;
        Thu, 19 Aug 2021 06:36:28 -0700 (PDT)
Received: from localhost ([217.111.27.204])
        by smtp.gmail.com with ESMTPSA id g12sm3015786wru.85.2021.08.19.06.36.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 06:36:27 -0700 (PDT)
Date:   Thu, 19 Aug 2021 15:36:26 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-pwm@vger.kernel.org,
        kernel@pengutronix.de, Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 2/3] pwm: Prevent a glitch for legacy drivers
Message-ID: <YR5eWvpEaLxgdWxD@orome.fritz.box>
References: <20210701072927.328254-1-u.kleine-koenig@pengutronix.de>
 <20210701072927.328254-3-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="PdUDrqr5Uu9FKJ1x"
Content-Disposition: inline
In-Reply-To: <20210701072927.328254-3-u.kleine-koenig@pengutronix.de>
User-Agent: Mutt/2.1.1 (e2a89abc) (2021-07-12)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--PdUDrqr5Uu9FKJ1x
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 01, 2021 at 09:29:26AM +0200, Uwe Kleine-K=C3=B6nig wrote:
> If a running PWM is reconfigured to disabled calling the ->config()
> callback before disabling the hardware might result in a glitch where
> the (maybe) new period and duty_cycle are visible on the output before
> disabling the hardware.
>=20
> So handle disabling before calling ->config(). Also exit early in this ca=
se
> which is possible because period and duty_cycle don't matter for disabled=
 PWMs.
> In return however ->config has to be called even if state->period =3D=3D
> pwm->state.period && state->duty_cycle !=3D pwm->state.duty_cycle because=
 setting
> these might have been skipped in the previous call.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/pwm/core.c | 41 ++++++++++++++++++++++++-----------------
>  1 file changed, 24 insertions(+), 17 deletions(-)
>=20
> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> index 3c72f8963073..20afe6d0bc5e 100644
> --- a/drivers/pwm/core.c
> +++ b/drivers/pwm/core.c
> @@ -568,26 +568,33 @@ static int pwm_apply_legacy(struct pwm_chip *chip, =
struct pwm_device *pwm,
>  		pwm->state.polarity =3D state->polarity;
>  	}
> =20
> -	if (state->period !=3D pwm->state.period ||
> -	    state->duty_cycle !=3D pwm->state.duty_cycle) {
> -		err =3D chip->ops->config(pwm->chip, pwm,
> -					state->duty_cycle,
> -					state->period);
> -		if (err)
> -			return err;
> +	if (!state->enabled) {
> +		if (pwm->state.enabled)
> +			chip->ops->disable(chip, pwm);
> =20
> -		pwm->state.period =3D state->period;
> -		pwm->state.duty_cycle =3D state->duty_cycle;
> +		return 0;
>  	}
> =20
> -	if (state->enabled !=3D pwm->state.enabled) {
> -		if (!pwm->state.enabled) {
> -			err =3D chip->ops->enable(chip, pwm);
> -			if (err)
> -				return err;
> -		} else {
> -			chip->ops->disable(chip, pwm);
> -		}
> +	/*
> +	 * We cannot skip calling ->config even if state->period =3D=3D
> +	 * pwm->state.period && state->duty_cycle =3D=3D pwm->state.duty_cycle
> +	 * because we might have exited early in the last call to
> +	 * pwm_apply_state because of !state->enabled and so the two values in
> +	 * pwm->state might not be configured in hardware.
> +	 */
> +	err =3D chip->ops->config(pwm->chip, pwm,
> +				state->duty_cycle,
> +				state->period);
> +	if (err)
> +		return err;
> +
> +	pwm->state.period =3D state->period;
> +	pwm->state.duty_cycle =3D state->duty_cycle;
> +
> +	if (!pwm->state.enabled) {
> +		err =3D chip->ops->enable(chip, pwm);
> +		if (err)
> +			return err;
>  	}

I thought we might have discussed this, but I can't find any record of
it. How is this better than always configuring, whether the PWM is
disabled or not?

=46rom an atomic point of view, the hardware state is expected to match
the PWM state that was passed to ->apply() after it returns. That means
that calling ->get_state() after ->apply() should return the same state
that was passed to ->apply(). With the above that's no longer true. It
doesn't actually matter, because legacy drivers don't support
->get_state(), but conceptually it's not mimicking the atomic API as
well as it could.

Thierry

--PdUDrqr5Uu9FKJ1x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmEeXloACgkQ3SOs138+
s6ECHw/+Mafef2PXGGfS1Yem3Y2el88VXb6A3YV1NBhO1S3yThJ1GNeoHZagPGl7
/McoVQL9f7UnDk4i4KSWduHHYB3VdsBP5XluJiJlMIu7MyD2LGUTDaVXmuwhmXQR
1AWj35Xc9jbdoeCtUxndv3/7GgkXl146gGEzkpnCCM75kqBOFe8b16csnmZC0W/P
CvWhQ3qzj7cwvrNQskpH+yZkgDhrNiCnoBU3JrGkKaorbfM2hzwGyiFQRoGfqPDb
BmnRDYpYih+SQiGBfGH5a1FYbNeuMgMHvwZ4zBF2dDt9YkV6hG4spkAoHIyszxhM
C/bKfxwqeWkKuN/stfupQ4w9endtmXgzBvD5/st6pkBmNQUZ1oNQhx2nevJUthS7
5RNpmdJCVmTutnCTDYBZV4MMwXuVpgxXOasY8KGggvgZbTl7w1pWlddA47ReQAoX
unjhO7fWD0a0MwNSZ8MNzlJHhaBF1hAebSXeUSKLfOYRpbrtYx235t/JxDSHFDYR
2iqwZyF7xRynfM75jlg0V3kwZCS9uCiZA7Lzvh3xJqtzTeHkA1k5FWv1lvzS3s3w
gs0TQZhJH/dnPFp5X6DyNAD9BRk52ntQ4b1z8FjXBJYcjKw8vSB3XwFsb1yoikKG
d8wTee/fT9Uh2m/pbUz+SFWjP90FDx5WppQRQT/aKgGut9Pzmw8=
=ETOt
-----END PGP SIGNATURE-----

--PdUDrqr5Uu9FKJ1x--
