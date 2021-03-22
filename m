Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44D41343EB9
	for <lists+linux-pwm@lfdr.de>; Mon, 22 Mar 2021 12:01:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbhCVLBP (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 22 Mar 2021 07:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230346AbhCVLAx (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 22 Mar 2021 07:00:53 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F08D3C061574
        for <linux-pwm@vger.kernel.org>; Mon, 22 Mar 2021 04:00:52 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id u5-20020a7bcb050000b029010e9316b9d5so8989209wmj.2
        for <linux-pwm@vger.kernel.org>; Mon, 22 Mar 2021 04:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SEw5p1nbzjlYEkIY+XyJ7H48SeOjgwoLkq2EHBwoHjA=;
        b=jwdJKFyXgmAWda4w+L3MU1PSf48YvVHr650WC2RVH2nXW5XBFOXEZ7aXUqQw7T+428
         KUPdNeX9tU0fvBgmsYSLznuhQ46JCectseu3+yuCPCdbZ/sSw2hFJhesofWNMvmJ+zFh
         DkYpJZ1ZPXhhO8rRb48l2DoB/sHgxi1UZlL7wnp4kw+ahXFL5TMy6uS4YHVskNwfTTTh
         vFJBouBiEwHWaSEs+MvWYrm6ABr1EdZyew0crDoG06QUal+QVRE2KRqV9z8gB82b6L1x
         L7SXbGkQy5BVJSc2nUwIIkgW7vQsoG0omPVAyDnB8/6MfCkQN+GiQBICzrF2u81sV3At
         bH7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SEw5p1nbzjlYEkIY+XyJ7H48SeOjgwoLkq2EHBwoHjA=;
        b=AwH2KinhINAVSoLf6xeRMBxhyISBIG2fI096uczVq7oi89oNxG7ooHgwRrMHJB5X6g
         8hFj8cVpmwYx2JacZ6vc+JQY4XVGpnqYul7U4En0egMJzufr3t4CVcThpjhF8BfEpmjp
         LYE3rYd3EN+4+UBsyKI05XokTVNDFGbC9l4KcaEGERcH25biLMKyE+ohHAJD3CxPqlZk
         JRy32B9a2ZK0+B3FGv71cjzW0l3+iWkqA2oK51w4G+RrwVHEc/rg6Oz7nPr8UgQaNlxV
         bhbuNvNL8t3HQHhn3brs/c+7crbkDhXVwjptejI1A9Zfg7RSpAL8vBPXExjIPu1Pjajv
         fBKg==
X-Gm-Message-State: AOAM530NhKqOk/ozp8aD9IxCiHoO2C0YuOQQCp69SEpK22bofdLHIE6b
        bng/slQTRwxVd6Kag7kY7C0=
X-Google-Smtp-Source: ABdhPJy5XXM7xRTCAhoCH3EPlK3bkknA1pYD8aICLWNOQrdV2JGloyxB4ro+Qha9dcRevGhx5HsM/A==
X-Received: by 2002:a1c:a306:: with SMTP id m6mr14813078wme.13.1616410846161;
        Mon, 22 Mar 2021 04:00:46 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id r4sm1259298wrs.15.2021.03.22.04.00.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 04:00:43 -0700 (PDT)
Date:   Mon, 22 Mar 2021 12:01:01 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-pwm@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH] pwm: Prevent a glitch in compat code
Message-ID: <YFh47dFLmWqZHvz7@orome.fritz.box>
References: <20210308093600.25455-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="XRZYalU+i5SPUxA2"
Content-Disposition: inline
In-Reply-To: <20210308093600.25455-1-u.kleine-koenig@pengutronix.de>
User-Agent: Mutt/2.0.6 (98f8cb83) (2021-03-06)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--XRZYalU+i5SPUxA2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 08, 2021 at 10:36:00AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> When a PWM is to be disabled, configuring the duty cycle and
> period before actually disabling the hardware might result in either a
> glitch or a delay. So check for disabling first and return early in this
> case.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/pwm/core.c | 20 +++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> index 4058d3c86a45..4604ca3e0e62 100644
> --- a/drivers/pwm/core.c
> +++ b/drivers/pwm/core.c
> @@ -597,6 +597,12 @@ int pwm_apply_state(struct pwm_device *pwm, const st=
ruct pwm_state *state)
>  			pwm->state.polarity =3D state->polarity;
>  		}
> =20
> +		if (!state->enabled && pwm->state.enabled) {
> +			chip->ops->disable(chip, pwm);
> +			pwm->state.enabled =3D false;
> +			return 0;

I don't think we can return early here because otherwise if consumers
happen to modify the period along with the enabled state, the changes
to the period will get lost.

Can we just omit the "return 0;" here?

> +		}
> +
>  		if (state->period !=3D pwm->state.period ||
>  		    state->duty_cycle !=3D pwm->state.duty_cycle) {
>  			int duty_cycle, period;
> @@ -620,16 +626,12 @@ int pwm_apply_state(struct pwm_device *pwm, const s=
truct pwm_state *state)
>  			pwm->state.period =3D state->period;
>  		}
> =20
> -		if (state->enabled !=3D pwm->state.enabled) {
> -			if (state->enabled) {
> -				err =3D chip->ops->enable(chip, pwm);
> -				if (err)
> -					return err;
> -			} else {
> -				chip->ops->disable(chip, pwm);
> -			}
> +		if (!pwm->state.enabled) {

If we don't return early above, we'll have to change this here as well
to ensure we don't gratuituously enable the PWM. Instead this would
basically become the inverse of what we do for disable above, which is
also nicely symmetrical (i.e. disable, then change period/duty to avoid
a glitch and change period/duty then enable to avoid the glitch).

Thierry

--XRZYalU+i5SPUxA2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmBYeO0ACgkQ3SOs138+
s6EEdhAApF3OtdhzQGf9NFJC4R5BaT+8EMQxAlyGEEZ9Ly/g8RIBNVLIkPZ+Be3R
xN9ZzwwLv8pj7g5FP8AMuPalwgKZwf+mssf+rztHS9s3lK0r5YiIoDDPTz1LywKK
KlEIzijZJQy4Kh3IZJW21/CRWjAnfj+nnBTJbh9tyTbdo1cI4vfWdBNk8vOY7M2R
UszbhsXijSjKUqbkYhoxReykafbpc2m8xztSn2OYH6P3dgS4hDiOy7DKlJGURR5A
W2GRAKy8aPd3sThHftyYPVMkN1a7Sqmu+VpLWvxJzq4RPSAue+6yqXUVVQ2UCt/j
ag1ysLqOZXAIJnYxTth3pNC/yB2hM5jV6U/xeExMSGngKrjb1MBxpezd18lhGFlF
7iRyXXu2thSHX9mms1KNGoFZY/yuKYOXlOPLfZErE0QLd2BH5TSkP9VLcj5W2Pyb
LUz75+OxWzvMSz8yUUIjaPqKAnmaDNaDJrvkc2PL3mxsc8AszHrfmBqIkuy+gFDT
DvjLQqGxhg4E+Li6jNuSQ/6GaREfx2ZytG0i17TKHaJP7s3lkMJPofaUKEQRzdiF
9HIvp/eN2vABWrW0Nvbyok/zsXJmmsB1WAPsg+fF5wJieQPDW9J12bGMRQ4neQ9S
7RXVUDf74eqIEw1TOOXNWbEyiCqT7+OCJ5fiv2NyCu6tYuV2ZIo=
=36Ou
-----END PGP SIGNATURE-----

--XRZYalU+i5SPUxA2--
