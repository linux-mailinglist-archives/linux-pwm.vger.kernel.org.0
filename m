Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61C377BB46D
	for <lists+linux-pwm@lfdr.de>; Fri,  6 Oct 2023 11:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231193AbjJFJl7 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 6 Oct 2023 05:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231488AbjJFJl5 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 6 Oct 2023 05:41:57 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 843C5EB
        for <linux-pwm@vger.kernel.org>; Fri,  6 Oct 2023 02:41:55 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-99de884ad25so345409666b.3
        for <linux-pwm@vger.kernel.org>; Fri, 06 Oct 2023 02:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696585314; x=1697190114; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B6MqGWV+NL5b6qM/zusxlKYGhCL4e3zRc/MNprU60kI=;
        b=HE2INiHv13AEnFaQAlSFudqDZTcWHGmRqbqw7Z1cOUWvW+stvgYZHhO8wuwQ5rUtEc
         H+gq92FPXTrJI9D44xAZHIypQW3n1+5iXm2F3qTaCJt0bwa3yQgxHDvmaQ0/qmHpNUUT
         6poc4iMOnTHMPjbNB4UvXki0P5I7kGeCwMyg74wGnQ3pfBugsNQxgs51Lb1vkwZ0MFlQ
         2TluTyLz1l6IvTk+ks5KpSowl2EemP01FHRy+RL5+Y8g6rAmKeodPaFa+MoqSH9MTth7
         tXODfbJ8H+DwD6fvlTQcT8clODyIQbO9qQmOR3pG5xpZ7GIfQs05EjxR8k91rIKkvxgw
         EHeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696585314; x=1697190114;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B6MqGWV+NL5b6qM/zusxlKYGhCL4e3zRc/MNprU60kI=;
        b=e+107niAFyQSda23TC3TCbhsaSchE9gw26EfciEBVJonlVpBZNO3XJM0eobC1lImGb
         OaP2xYc9ttdPNrajq/7zdyxRsj9NxiznxBvVByRfZNGwjdTMTaqKE0VmQrS3eKfdZnVu
         /rWOl2ClsXaLu32lFFl4N72VvFE11/LUsojHXfOdplC7D39ThZhlYzQ6Hfq9yydDAVKs
         +o0RSEF9K0KDC4482qAbiqGR0UPJ6StB98sfCZvzxciQnjD2GChB/Ipz6zMuFuxjR1qK
         sjBpS7MmggcQF5i0TLbDOqkq6a3fAAki6arLksdmjI/yi+GZhEBmh/q52zgzFcIrc8yJ
         Ifsw==
X-Gm-Message-State: AOJu0YyUiCKJILav9Gbi1qFjMa+R7NQnWvdoET8a9fFk4MPzzbYPT/MV
        2bu4YNIxkhAmDo3BkhW1QzY=
X-Google-Smtp-Source: AGHT+IHCswxjQ9xGGqwBPh8mobBwzyarkWN90CkXuHBNaYqxHUwowAi/oZfAssKlJfxJVSbtES+r/g==
X-Received: by 2002:a17:906:2da:b0:9b7:1e26:e2ea with SMTP id 26-20020a17090602da00b009b71e26e2eamr6443253ejk.41.1696585313672;
        Fri, 06 Oct 2023 02:41:53 -0700 (PDT)
Received: from orome.fritz.box (p200300e41f3f4900f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f3f:4900:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id l12-20020a170906230c00b009920e9a3a73sm2584092eja.115.2023.10.06.02.41.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 02:41:53 -0700 (PDT)
Date:   Fri, 6 Oct 2023 11:41:51 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v1 071/101] pwm: ab8500: Store parent device in driver
 data
Message-ID: <ZR_WXxqhmRgtpA0n@orome.fritz.box>
References: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
 <20230808171931.944154-72-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="nqAmwNhBClxL0tpC"
Content-Disposition: inline
In-Reply-To: <20230808171931.944154-72-u.kleine-koenig@pengutronix.de>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--nqAmwNhBClxL0tpC
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 08, 2023 at 07:19:01PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> struct pwm_chip::dev is about to change. To not have to touch this
> driver in the same commit as struct pwm_chip::dev, store a pointer to
> the parent device in driver data.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/pwm/pwm-ab8500.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)

You're basically adding a parent device to all driver-private data
structures in this and the following patches, so why not keep in in
struct pwm_chip and simply rename chip->dev to chip->parent?

As Andy has commented, this would eventually allow the PWM core to
take care of certain things like runtime PM, or even only for stuff
like using the parent device name in info/debug/error messages.

Also, you could then just make this a single large patch that renames
dev to parent in one go rather than making this large set even larger
with this kind of trivial changes.

Thierry

>=20
> diff --git a/drivers/pwm/pwm-ab8500.c b/drivers/pwm/pwm-ab8500.c
> index f64f3fd251e7..663fdfe90bb6 100644
> --- a/drivers/pwm/pwm-ab8500.c
> +++ b/drivers/pwm/pwm-ab8500.c
> @@ -24,6 +24,7 @@
>  #define AB8500_PWM_CLKRATE 9600000
> =20
>  struct ab8500_pwm_chip {
> +	struct device *parent;
>  	unsigned int hwid;
>  };
> =20
> @@ -91,7 +92,7 @@ static int ab8500_pwm_apply(struct pwm_chip *chip, stru=
ct pwm_device *pwm,
>  	 * when disabled.
>  	 */
>  	if (!state->enabled || duty_steps =3D=3D 0) {
> -		ret =3D abx500_mask_and_set_register_interruptible(chip->dev,
> +		ret =3D abx500_mask_and_set_register_interruptible(ab8500->parent,
>  					AB8500_MISC, AB8500_PWM_OUT_CTRL7_REG,
>  					1 << ab8500->hwid, 0);
> =20
> @@ -111,18 +112,18 @@ static int ab8500_pwm_apply(struct pwm_chip *chip, =
struct pwm_device *pwm,
> =20
>  	reg =3D AB8500_PWM_OUT_CTRL1_REG + (ab8500->hwid * 2);
> =20
> -	ret =3D abx500_set_register_interruptible(chip->dev, AB8500_MISC,
> +	ret =3D abx500_set_register_interruptible(ab8500->parent, AB8500_MISC,
>  			reg, lower_val);
>  	if (ret < 0)
>  		return ret;
> =20
> -	ret =3D abx500_set_register_interruptible(chip->dev, AB8500_MISC,
> +	ret =3D abx500_set_register_interruptible(ab8500->parent, AB8500_MISC,
>  			(reg + 1), higher_val);
>  	if (ret < 0)
>  		return ret;
> =20
>  	/* enable */
> -	ret =3D abx500_mask_and_set_register_interruptible(chip->dev,
> +	ret =3D abx500_mask_and_set_register_interruptible(ab8500->parent,
>  				AB8500_MISC, AB8500_PWM_OUT_CTRL7_REG,
>  				1 << ab8500->hwid, 1 << ab8500->hwid);
> =20
> @@ -137,7 +138,7 @@ static int ab8500_pwm_get_state(struct pwm_chip *chip=
, struct pwm_device *pwm,
>  	struct ab8500_pwm_chip *ab8500 =3D ab8500_pwm_from_chip(chip);
>  	unsigned int div, duty_steps;
> =20
> -	ret =3D abx500_get_register_interruptible(chip->dev, AB8500_MISC,
> +	ret =3D abx500_get_register_interruptible(ab8500->parent, AB8500_MISC,
>  						AB8500_PWM_OUT_CTRL7_REG,
>  						&ctrl7);
>  	if (ret)
> @@ -150,13 +151,13 @@ static int ab8500_pwm_get_state(struct pwm_chip *ch=
ip, struct pwm_device *pwm,
>  		return 0;
>  	}
> =20
> -	ret =3D abx500_get_register_interruptible(chip->dev, AB8500_MISC,
> +	ret =3D abx500_get_register_interruptible(ab8500->parent, AB8500_MISC,
>  						AB8500_PWM_OUT_CTRL1_REG + (ab8500->hwid * 2),
>  						&lower_val);
>  	if (ret)
>  		return ret;
> =20
> -	ret =3D abx500_get_register_interruptible(chip->dev, AB8500_MISC,
> +	ret =3D abx500_get_register_interruptible(ab8500->parent, AB8500_MISC,
>  						AB8500_PWM_OUT_CTRL2_REG + (ab8500->hwid * 2),
>  						&higher_val);
>  	if (ret)
> @@ -196,6 +197,7 @@ static int ab8500_pwm_probe(struct platform_device *p=
dev)
>  	ab8500 =3D pwmchip_priv(chip);
> =20
>  	chip->ops =3D &ab8500_pwm_ops;
> +	ab8500->parent =3D &pdev->dev;
>  	ab8500->hwid =3D pdev->id - 1;
> =20
>  	err =3D devm_pwmchip_add(&pdev->dev, chip);
> --=20
> 2.40.1
>=20

--nqAmwNhBClxL0tpC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmUf1l8ACgkQ3SOs138+
s6Fizg/+NA1uWgNGCaNIYKtU85IXVQ8SavB1CXDcsnSB7hhKd9Fdz2HYaUCmYheU
aNA8YyGlbsOk05uI/Eka7HE75VH5yeulQAExCIiwZ8Z9YQvgYxoMz/OphT4RXuZD
xFrF6wYcEmIRMFqCw3JhuA70Wns7VSmDFfKrZleJNgHP/hRYT5PHuRCkOgyyFLL7
m7JbK550AhoFRmSVHLDCAiZwpmephcAFZc2ooEwFE10ndykiFKmW6qq6P7Z2LcpK
pajMNfeQInr7To3KFZTMG2uu6u03k3rw9z5psXN2lRAhs2y3UAI2R4KomqpgdaUs
H7x6vp6bRVbqNndV7jTeo8AVMTX2JiGnyK7UOrI8wFsx3wrSkF80RH/YC/rjHqGm
Q/bwwSCHROYsHUuivF5PG85eYBvpomn5o2gHv1Y/xdiL2fJLF7q/EaTUSm2jI9DV
bS838IZPuP0JVQxBWEiCey9faR6OPFe7Sv8+B2TYNmaEOv8bAu5SfHD/Bk47Fag/
fH6VZynTHSBXMYScW+wANummdTNSgOdwlLnAnnWsnaR/A5bTm8OMwAhsS2p7QqqF
7s+qJHq2BcCSb2GmGaodFnS0OySKGXyQDbJWzJAd3a68RJSlM5SlhGSAtXqLAxfM
RKy4ZlslDO7D6m/871UPYnCO3+ffLS5o6YUcwpLrnnWmltB+3uc=
=lt9m
-----END PGP SIGNATURE-----

--nqAmwNhBClxL0tpC--
