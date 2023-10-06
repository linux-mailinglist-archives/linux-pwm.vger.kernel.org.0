Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D4E57BB45A
	for <lists+linux-pwm@lfdr.de>; Fri,  6 Oct 2023 11:38:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbjJFJiT (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 6 Oct 2023 05:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjJFJiS (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 6 Oct 2023 05:38:18 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 447B9BE
        for <linux-pwm@vger.kernel.org>; Fri,  6 Oct 2023 02:38:16 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-5384975e34cso3465265a12.0
        for <linux-pwm@vger.kernel.org>; Fri, 06 Oct 2023 02:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696585095; x=1697189895; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7gQz0u/r+9N6pT+JFwHHHRZPQwGpe8TGKPgcQ0jjH1g=;
        b=h8ZeaZbL5xhuaWkcVBRaH2ZcoXnp2xg+IquL9R0Ck7Wxb6A0Bsyt7j7y5qedMg3Pvx
         6XQuLbC248uLS+Lg4okyNPTtQ92HGNJ+HlyFUrY3eSlYv4+82R2lavnzbn5q3Kl6jUAz
         QVHjnBIKzVf/mXqpW2Nh0xzjfyHvz33Q1r+7NYfc4zXQsnLP5J6iFVJaWT2A5NhTMd9a
         H5/dPWy7fZPOydmE3Y9fgZ/TVqNniewpN9QtdvID17ImiX/YdHDUNwWzReQ1wvT7bM5Y
         bI/DY2deyZ0upkVTkHh/IeQyJtuccP/ECBduN2E9ApAU6mFuYFj4sxP3hJugmfr7WGrR
         WpWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696585095; x=1697189895;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7gQz0u/r+9N6pT+JFwHHHRZPQwGpe8TGKPgcQ0jjH1g=;
        b=EVtD1tdYg/i8RlwJBvxqFewnYcKf0knBA0U1WON5ypC2kHYthTZUJzE29M+89iE2Tv
         2lsMwMDIaAA7RM8u1JCzqo596RSSLpGj9LKgKmmdZeEmcpBjVGt/xPBmcQPDnBuX0PJd
         kdyjp4zXNMGED5vZ3L71cdTXh9Tm9sVrNYllxBeZavmP3htmfxSSCxvW1toHsUCt0KFX
         855CKl6QaYkjjuFDeBWE6dKjEpaOshYXCZBRRrlmDYo3QsEVQsDNwh6htdpfKl7KJf1k
         X2K/Bv5bWe/VikDAtfqCDi2Fkmmbf6/gG7xY6xadieDKRAH1qfgIqkA2DxttLrk94POH
         6KJw==
X-Gm-Message-State: AOJu0Yzzl22LWlDzJrTts3wf8wNDmwDDLCcucj0osG2TT6p6X5L6dG4H
        RMSEaRfGwN467PQmHPEUySQ=
X-Google-Smtp-Source: AGHT+IHM+lCchGAQcVbtJ6Kkcrdq+4mFOPpNz3uMEmxg85BrtI5dehm6QLeGmNH/n+LPAhL04c84hQ==
X-Received: by 2002:a17:906:10cc:b0:9ae:4e81:4580 with SMTP id v12-20020a17090610cc00b009ae4e814580mr7090259ejv.66.1696585094522;
        Fri, 06 Oct 2023 02:38:14 -0700 (PDT)
Received: from orome.fritz.box (p200300e41f3f4900f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f3f:4900:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id cd16-20020a170906b35000b00991faf3810esm2609508ejb.146.2023.10.06.02.38.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 02:38:13 -0700 (PDT)
Date:   Fri, 6 Oct 2023 11:38:12 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v1 070/101] pwm: Ensure a struct pwm have the same
 lifetime as its pwm_chip
Message-ID: <ZR_VhNLrXVUc2Fxr@orome.fritz.box>
References: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
 <20230808171931.944154-71-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="41lDrh64BLQjkugi"
Content-Disposition: inline
In-Reply-To: <20230808171931.944154-71-u.kleine-koenig@pengutronix.de>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--41lDrh64BLQjkugi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 08, 2023 at 07:19:00PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> It's required to not free the memory underlying a requested PWM
> while a consumer still has a reference to it. While currently a pwm_chip
> doesn't life long enough in all cases, linking the struct pwm to the
> pwm_chip results in the right lifetime as soon as the pwmchip is living
> long enough. This happens with the following commits.
>=20
> Note this is a breaking change for all pwm drivers that don't use
> pwmchip_alloc().
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/pwm/core.c  | 24 +++++++++---------------
>  include/linux/pwm.h |  2 +-
>  2 files changed, 10 insertions(+), 16 deletions(-)
>=20
> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> index cfcddf62ab01..3b8d41fdda1b 100644
> --- a/drivers/pwm/core.c
> +++ b/drivers/pwm/core.c
> @@ -198,7 +198,7 @@ static bool pwm_ops_check(const struct pwm_chip *chip)
> =20
>  void *pwmchip_priv(struct pwm_chip *chip)
>  {
> -	return &chip[1];
> +	return &chip->pwms[chip->npwm];

I already disliked &chip[1] and this isn't making things any better. I
fully realize that this is going to give us the right address, but it
just looks wrong. Can we not do something like:

	return (void *)chip + sizeof(*chip);

instead? That would make it more explict that we're trying to get at the
extra data that was allocated. It also makes things a bit more robust
and doesn't explode when somebody decides to add fields after "pwms".

>  }
>  EXPORT_SYMBOL_GPL(pwmchip_priv);
> =20
> @@ -208,7 +208,7 @@ struct pwm_chip *devm_pwmchip_alloc(struct device *pa=
rent, unsigned int npwm, si
>  	size_t alloc_size;
>  	unsigned int i;
> =20
> -	alloc_size =3D sizeof(*chip) + sizeof_priv;
> +	alloc_size =3D sizeof(*chip) + npwm * sizeof(struct pwm_device) + sizeo=
f_priv;
> =20
>  	chip =3D devm_kzalloc(parent, alloc_size, GFP_KERNEL);
>  	if (!chip)
> @@ -217,6 +217,13 @@ struct pwm_chip *devm_pwmchip_alloc(struct device *p=
arent, unsigned int npwm, si
>  	chip->dev =3D parent;
>  	chip->npwm =3D npwm;
> =20
> +	for (i =3D 0; i < chip->npwm; i++) {
> +		struct pwm_device *pwm =3D &chip->pwms[i];
> +
> +		pwm->chip =3D chip;
> +		pwm->hwpwm =3D i;
> +	}
> +
>  	return chip;
>  }
>  EXPORT_SYMBOL_GPL(devm_pwmchip_alloc);
> @@ -243,26 +250,15 @@ int __pwmchip_add(struct pwm_chip *chip, struct mod=
ule *owner)
> =20
>  	chip->owner =3D owner;
> =20
> -	chip->pwms =3D kcalloc(chip->npwm, sizeof(*pwm), GFP_KERNEL);

I think the structure of this patch series is a bit weird. Basically
you're not actually improving things until the very end, at which point
all questions get resolved.

What this patch does isn't actually changing anything about the object
lifetimes. chip->pwms still goes away at the same time (effectively)
because the chip's memory allocation will be released shortly after
pwmchip_remove() is called.

It isn't until the very end of the series that you actually fix up the
lifetime problem. So I read through the entire series trying to make
sense of all this and commenting where things aren't going to work as
expected, only to realize it isn't all going to fall in place until the
very end.

So I think you should either make this clearer in the commit message or
make sure that things like pwmchip_alloc() do the right things from the
start.

Thierry

> -	if (!chip->pwms)
> -		return -ENOMEM;
> -
>  	mutex_lock(&pwm_lock);
> =20
>  	ret =3D idr_alloc(&pwmchip_idr, chip, 0, 0, GFP_KERNEL);
>  	if (ret < 0) {
>  		mutex_unlock(&pwm_lock);
> -		kfree(chip->pwms);
>  		return ret;
>  	}
> =20
>  	chip->id =3D ret;
> -	for (i =3D 0; i < chip->npwm; i++) {
> -		struct pwm_device *pwm =3D &chip->pwms[i];
> -
> -		pwm->chip =3D chip;
> -		pwm->hwpwm =3D i;
> -	}
> =20
>  	mutex_unlock(&pwm_lock);
> =20
> @@ -293,8 +289,6 @@ void pwmchip_remove(struct pwm_chip *chip)
>  	idr_remove(&pwmchip_idr, chip->id);
> =20
>  	mutex_unlock(&pwm_lock);
> -
> -	kfree(chip->pwms);
>  }
>  EXPORT_SYMBOL_GPL(pwmchip_remove);
> =20
> diff --git a/include/linux/pwm.h b/include/linux/pwm.h
> index 3c0da17e193c..fbcba204de44 100644
> --- a/include/linux/pwm.h
> +++ b/include/linux/pwm.h
> @@ -301,7 +301,7 @@ struct pwm_chip {
>  	unsigned int of_pwm_n_cells;
> =20
>  	/* only used internally by the PWM framework */
> -	struct pwm_device *pwms;
> +	struct pwm_device pwms[];
>  };
> =20
>  #if IS_ENABLED(CONFIG_PWM)
> --=20
> 2.40.1
>=20

--41lDrh64BLQjkugi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmUf1YEACgkQ3SOs138+
s6FnNRAAuoSJ+eXufDPgRHxrV9i/WRPtLczbB3QCYezRZBvtHQKAvaUa+duyhwcZ
y/L78bkXviRCBmaPHuRTfy99G7j36D+9JgsUbt0o8rf5eVNVelBmXDasXF+Kc3Jt
6GAonyi6tk19ezhagMN/xTYs5fw8aMGc58wt0cvDdPMLrhSX2R9VA4KAN6AEY5GO
94pDHRrtM9jRWxDrIK/ubnwGS7C8cLK2oxA7bkYL/gw5gl6xcgCHUHo7aQDxnmtJ
0F5oBLftGVwdo+YEOydpjmfLSktWNAOIypnast1wndEt7jLlgQC7fK8ATY1uvZCB
R4U1xQ0C+8wpFhfr/cpaBuAyPfHNHJMea43MVk0BkroDAPScXvQHnRNrgbqBuXGi
3hd4MtC5k1+xl8v3crJjjL4KYR5fY6U3ld1rrB0ILjgc3h3cgOQY8axyfDPj35Il
C8cvQ1Obt8IAtqLyGiJ4xsiXXtXhqkkwpARBttau3zpCL+/8yb78AUyLHd4W+aiz
UJxaXcF9jjtNUvJ9MKjNEZzVKnEbVyUGvHPQyWB+UBZtgL4kBztH2LhC9/Gzr7F/
Gu97l3vaMSyjo/8O0Zq0VOsjV7i+U6K10x9z3WUkCRAd5U3qzWU0Sug8GI2aIbGa
Wfec8WfOlKUMEeO6OSoy8gren0C83f3CJijl+blRFvg1F54AkPQ=
=5bcu
-----END PGP SIGNATURE-----

--41lDrh64BLQjkugi--
