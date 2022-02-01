Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71E074A5811
	for <lists+linux-pwm@lfdr.de>; Tue,  1 Feb 2022 08:47:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235139AbiBAHrc (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 1 Feb 2022 02:47:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbiBAHrb (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 1 Feb 2022 02:47:31 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71233C061714
        for <linux-pwm@vger.kernel.org>; Mon, 31 Jan 2022 23:47:31 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id p15so51263379ejc.7
        for <linux-pwm@vger.kernel.org>; Mon, 31 Jan 2022 23:47:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EDf6sL5+Vz0irPliCNnK4ySRuZoKiPmYO/vVuUM+pEc=;
        b=OEnp9oDCaQkznrYvqTExAOSLvAj7IxPqiXJ20fHHPOcePDqAY/LcaWn6Ief4tVRrZy
         LeVkYKIBXnzi8tf4n61i6xawhrB2TlZOWzPca3VGhOeGvOoZB3+bPmV+se6cBDGqYH7W
         artY59hVBd3KPIURhmaTxzUMK3Mp9yGTKeejEte2u3InhjwSxIG4MGCwEkJBeFuPv/iM
         K3nvi+WzWjAIM/SLAqsMeZy65q43/nY274vAs4RVy6/nMVJrCL5AsmTGrZG63BGvYbn7
         g0gNkezaN6ZDxHcqUOokuKpqrdvUly6tFe+isb0jZAvg6f6EoFFMKP6t8sP/0/N263hV
         RAGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EDf6sL5+Vz0irPliCNnK4ySRuZoKiPmYO/vVuUM+pEc=;
        b=HDENYQLIeT5FzFUBefGOy+vFNVsKq+ZY1JDKzuNGT/ERSbdxu/xdHlHxBpFJsfpOur
         vHCnXD0IhfW9zMyxp0C/kj6oVPqAnYxIzbIKr9ufC8/TzK/6g+wmME7XNkGEmK4ami8D
         JGsNKkSTHZnkqQH0st47lchoCJKb8mUpEOcipexdZk5WquZHahSawxPoc/GoLO0xg/rZ
         Yhry7AmakN6a6GqNUtMWjf7scfw2dEfm9T3tsnsDwxVpYZFAEQFlGC1dNkxLQhZqqgk2
         CMAd3VJn1rJgmF4XK7lguYRnQIY/RaIzMkNvl3UV1Iwl0m6bFyty58UP4GVyU9jiZfXA
         cINQ==
X-Gm-Message-State: AOAM530DQ/atCr40mpMTTFszNOqK+xOmyfepGKyYewOFQ9vGt+fLeq+Q
        5436arju+3+mBpipHBFP8qIJiKpIWh8j2A==
X-Google-Smtp-Source: ABdhPJxQKgHlQsV/Q97g8h/nuA8jnnq0kGFxGfLlc0Kww/kW10dFv51rmfpKaBMFwsXFkvet1bC6oA==
X-Received: by 2002:a17:907:2da5:: with SMTP id gt37mr20312848ejc.529.1643701649895;
        Mon, 31 Jan 2022 23:47:29 -0800 (PST)
Received: from orome ([193.209.96.43])
        by smtp.gmail.com with ESMTPSA id w26sm18938411edq.81.2022.01.31.23.47.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 23:47:29 -0800 (PST)
Date:   Tue, 1 Feb 2022 08:47:26 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Vladimir Zapolskiy <vz@mleia.com>, linux-pwm@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH 1/3] pwm: lpc18xx-sct: Initialize driver data and
 hardware before pwmchip_add()
Message-ID: <YfjljnMC1AfJCNvA@orome>
References: <20211110084950.1053426-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yu5w6erUqlSkQk6k"
Content-Disposition: inline
In-Reply-To: <20211110084950.1053426-1-u.kleine-koenig@pengutronix.de>
User-Agent: Mutt/2.1.5 (31b18ae9) (2021-12-30)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--yu5w6erUqlSkQk6k
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 10, 2021 at 09:49:48AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> When a driver calls pwmchip_add() it has to be prepared to immediately
> get its callbacks called. So move allocation of driver data and hardware
> initialization before the call to pwmchip_add().
>=20
> This fixes a potential NULL pointer exception and a race condition on
> register writes.
>=20
> Fixes: 841e6f90bb78 ("pwm: NXP LPC18xx PWM/SCT driver")
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/pwm/pwm-lpc18xx-sct.c | 20 +++++++++-----------
>  1 file changed, 9 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-lpc18xx-sct.c b/drivers/pwm/pwm-lpc18xx-sct.c
> index 8e461f3baa05..8cc8ae16553c 100644
> --- a/drivers/pwm/pwm-lpc18xx-sct.c
> +++ b/drivers/pwm/pwm-lpc18xx-sct.c
> @@ -395,12 +395,6 @@ static int lpc18xx_pwm_probe(struct platform_device =
*pdev)
>  	lpc18xx_pwm_writel(lpc18xx_pwm, LPC18XX_PWM_LIMIT,
>  			   BIT(lpc18xx_pwm->period_event));
> =20
> -	ret =3D pwmchip_add(&lpc18xx_pwm->chip);
> -	if (ret < 0) {
> -		dev_err(&pdev->dev, "pwmchip_add failed: %d\n", ret);
> -		goto disable_pwmclk;
> -	}
> -
>  	for (i =3D 0; i < lpc18xx_pwm->chip.npwm; i++) {
>  		struct lpc18xx_pwm_data *data;
> =20
> @@ -410,14 +404,12 @@ static int lpc18xx_pwm_probe(struct platform_device=
 *pdev)
>  				    GFP_KERNEL);
>  		if (!data) {
>  			ret =3D -ENOMEM;
> -			goto remove_pwmchip;
> +			goto disable_pwmclk;
>  		}
> =20
>  		pwm_set_chip_data(pwm, data);
>  	}
> =20
> -	platform_set_drvdata(pdev, lpc18xx_pwm);
> -
>  	val =3D lpc18xx_pwm_readl(lpc18xx_pwm, LPC18XX_PWM_CTRL);
>  	val &=3D ~LPC18XX_PWM_BIDIR;
>  	val &=3D ~LPC18XX_PWM_CTRL_HALT;
> @@ -425,10 +417,16 @@ static int lpc18xx_pwm_probe(struct platform_device=
 *pdev)
>  	val |=3D LPC18XX_PWM_PRE(0);
>  	lpc18xx_pwm_writel(lpc18xx_pwm, LPC18XX_PWM_CTRL, val);
> =20
> +	ret =3D pwmchip_add(&lpc18xx_pwm->chip);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "pwmchip_add failed: %d\n", ret);
> +		goto disable_pwmclk;
> +	}
> +
> +	platform_set_drvdata(pdev, lpc18xx_pwm);

Is there any particular reason why this needs to move? The driver only
call platform_get_drvdata() from the ->remove() implementation at this
point, so this should be fine, but it's possible that it would at some
future point try to access this data from some code path that may get
called as part of pwmchip_add(), so doing this prior to chip addition
may be a better option.

No need to resend, I can fix that up as I apply if there are no strong
reasons to keep this after pwmchip_add().

Thierry

--yu5w6erUqlSkQk6k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmH45Y4ACgkQ3SOs138+
s6Ho7xAApEQzrRa9eIdH9Aye1rJPJOCJDhJ9gMX6cREuBFDYUJUQRrhWoa2tK2aw
FGAAiDwhCBtZO2h3tE3bUg1ilc6/ZpgPF1pC9R4YsWePQI5k76i+RUU7uXWbY3k0
zqCb35XxU9IGoKpXkvoYy4RKT6nlhaFU+k93h57TtA2GcN5L7NL1gvhPg6up9NZh
6cMKwX6f/lrrXS6iZzdxr4YLGhMf4FTBB1zS1st2sTKCXdY4uNYcwgLd9xabG3Ld
OFmWkMqHTxXcaN1FSarA6mADj3wazCek8d6jfK5XpQ5Rej91+lH+f+go4gnjDF5Q
V2ATWnRMQbv1dlxq/iBqyA5k61TK4IDpgq3Rlkuc7QQfKmcovp+sco8wYDGtEee6
ZxylSDisrTCx9uw+Xyq/PCN68dsycrv/Nj4hleU9RY35u2pWoqSIIkiJNG3F4+m+
EztknbV2iEJblyrLsZa+SHR85o87iMBNweXGmOf7c6D3AoeaFM0nS6QAs8fZcSGn
vir1ZqB6vbVzUwFxd4qCR4N+1M5EmubB2x/KwzXMmmXLDYolMkkBfk21WloM8yLc
/rGuVtbKbBjYmjJv4o96gQ+yWNvax+x+rd6wOcejp6OxomUUddPLTfitfWYq26cA
4zfhB/AbICUZnsSJgdYdaCSWTEMNSjEXgQeTWq9vj2Y1n2c4HaM=
=crmy
-----END PGP SIGNATURE-----

--yu5w6erUqlSkQk6k--
