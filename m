Return-Path: <linux-pwm+bounces-463-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B069D80A7F2
	for <lists+linux-pwm@lfdr.de>; Fri,  8 Dec 2023 16:53:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 651B51F20FFA
	for <lists+linux-pwm@lfdr.de>; Fri,  8 Dec 2023 15:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE4E432C9F;
	Fri,  8 Dec 2023 15:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IK6jT85y"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A7F11996
	for <linux-pwm@vger.kernel.org>; Fri,  8 Dec 2023 07:53:01 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-548ce39b101so3169913a12.2
        for <linux-pwm@vger.kernel.org>; Fri, 08 Dec 2023 07:53:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702050779; x=1702655579; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zK8omqPLoVqiOsm4awtdyTo/Ew6UFIDOki73tZQJSz8=;
        b=IK6jT85yErrilV6pKnmweyofVnnIKIVgobgo+8FS+fe7rX/Yj2rnYTN0BWMH3a+lwj
         HpfwmTSO+RO9LAirfKFR3VEZkadAMo3eEcGfnleMqHK4kBZfLSA/EaUfTVEGvuvoVeFa
         uBECLZcfiyOpnCIVj9SNrLHq6T8UhBalgz7m4G4iWFTV0kQSUWxAkVhwq7ICLu/auOy1
         MVmJsOUYb+GD53n/xCnHbmue9eFzw6wbsDRKYiNsBNSKFwxBSsLMdoOLi9eOv3MoVS94
         0dSwQn2xfWUcUdffz7RjVyq5YFJVRqA2OryWKBUzavNjq/lco8ccxB4E119ICj3qDTOe
         YiDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702050779; x=1702655579;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zK8omqPLoVqiOsm4awtdyTo/Ew6UFIDOki73tZQJSz8=;
        b=NFvnNhJ0D2IJJHjABSh8P5tgtjzlD6mojXha/rCHz1iOIw4BS7VB6EocJ1y2v90BWQ
         U69fveAlETpL/tN15wOxOjJbCgnLQABU9TZxy5Q0lLC7m3dsnLMb1MSaushQ6I73Hcc9
         c1Hcjfa/ZMSc8VC3t6/xXw4vJIXs6uApGvoBvUwx4g3y4oJTGohZPvTB0C6foXfWYOJh
         wj6xOeZvEY2dSNMWpvaH6dXDbDXwmApqVuCTMzQog0kn09iM8xIYr7CX25xWEeIGdD/v
         saO/O8D/qthMcO6lofKjA36jq70s4SG5zT7X3LESDvN/zLhTcf8pHwdIpd1ZluFwG2my
         KDng==
X-Gm-Message-State: AOJu0Yxrq9oO1fYBxpL4QuS26NPRUD5oK5txfb1SdUHcBRp2l396tQPD
	5JHSczrxJ4g4y5uqUZoPUIY=
X-Google-Smtp-Source: AGHT+IHpMrVO3d6Ofvo2ML3ArtLwJwriv8zExcKT1eKTy3Od/ySm4fjfkpJKt9IuN5T1oFol/XLNvw==
X-Received: by 2002:a50:a419:0:b0:54c:4837:7d28 with SMTP id u25-20020a50a419000000b0054c48377d28mr156936edb.103.1702050779370;
        Fri, 08 Dec 2023 07:52:59 -0800 (PST)
Received: from orome.fritz.box (p200300e41f0fa600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f0f:a600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id l28-20020a50d6dc000000b0054ca3df2257sm934412edj.36.2023.12.08.07.52.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 07:52:58 -0800 (PST)
Date: Fri, 8 Dec 2023 16:52:57 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org, kernel@pengutronix.de
Subject: Re: [PATCH] pwm: meson: Simplify using dev_err_probe()
Message-ID: <ZXM72QYBbb32Q_aL@orome.fritz.box>
References: <20231206214817.1783227-2-u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="immTF9VRZDK7uFRg"
Content-Disposition: inline
In-Reply-To: <20231206214817.1783227-2-u.kleine-koenig@pengutronix.de>
User-Agent: Mutt/2.2.12 (2023-09-09)


--immTF9VRZDK7uFRg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 06, 2023 at 10:48:18PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> Using dev_err_probe() emitting an error message mentioning a return
> value and returning that value can be done in a single statement. Make
> use of that to simplify the probe part of the driver. This has the
> additional advantage to emit the symbolic name for the error instead of
> the integer error value.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
> Hello,
>=20
> while trying to understand Jerome's series[1] I noticed this patch
> opportunity.
>=20
> Best regards
> Uwe
>=20
> [1] https://lore.kernel.org/linux-pwm/20231129134004.3642121-1-jbrunet@ba=
ylibre.com
>=20
>  drivers/pwm/pwm-meson.c | 35 ++++++++++++++---------------------
>  1 file changed, 14 insertions(+), 21 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
> index 5bea53243ed2..2971bbf3b5e7 100644
> --- a/drivers/pwm/pwm-meson.c
> +++ b/drivers/pwm/pwm-meson.c
> @@ -468,10 +468,9 @@ static int meson_pwm_init_channels(struct meson_pwm =
*meson)
>  		channel->mux.hw.init =3D &init;
> =20
>  		err =3D devm_clk_hw_register(dev, &channel->mux.hw);
> -		if (err) {
> -			dev_err(dev, "failed to register %s: %d\n", name, err);
> -			return err;
> -		}
> +		if (err)
> +			return dev_err_probe(dev, err,
> +					     "failed to register %s\n", name);
> =20
>  		snprintf(name, sizeof(name), "%s#div%u", dev_name(dev), i);
> =20
> @@ -491,10 +490,9 @@ static int meson_pwm_init_channels(struct meson_pwm =
*meson)
>  		channel->div.lock =3D &meson->lock;
> =20
>  		err =3D devm_clk_hw_register(dev, &channel->div.hw);
> -		if (err) {
> -			dev_err(dev, "failed to register %s: %d\n", name, err);
> -			return err;
> -		}
> +		if (err)
> +			return dev_err_probe(dev, err,
> +					     "failed to register %s\n", name);
> =20
>  		snprintf(name, sizeof(name), "%s#gate%u", dev_name(dev), i);
> =20
> @@ -513,17 +511,13 @@ static int meson_pwm_init_channels(struct meson_pwm=
 *meson)
>  		channel->gate.lock =3D &meson->lock;
> =20
>  		err =3D devm_clk_hw_register(dev, &channel->gate.hw);
> -		if (err) {
> -			dev_err(dev, "failed to register %s: %d\n", name, err);
> -			return err;
> -		}
> +		if (err)
> +			return dev_err_probe(dev, err, "failed to register %s\n", name);
> =20
>  		channel->clk =3D devm_clk_hw_get_clk(dev, &channel->gate.hw, NULL);
> -		if (IS_ERR(channel->clk)) {
> -			err =3D PTR_ERR(channel->clk);
> -			dev_err(dev, "failed to register %s: %d\n", name, err);
> -			return err;
> -		}
> +		if (IS_ERR(channel->clk))
> +			return dev_err_probe(dev, PTR_ERR(channel->clk),
> +					     "failed to register %s\n", name);
>  	}
> =20
>  	return 0;
> @@ -554,10 +548,9 @@ static int meson_pwm_probe(struct platform_device *p=
dev)
>  		return err;
> =20
>  	err =3D devm_pwmchip_add(&pdev->dev, &meson->chip);
> -	if (err < 0) {
> -		dev_err(&pdev->dev, "failed to register PWM chip: %d\n", err);
> -		return err;
> -	}
> +	if (err < 0)
> +		return dev_err_probe(&pdev->dev, err,
> +				     "failed to register PWM chip\n");
> =20
>  	return 0;
>  }

This is a lot of churn for very little gain. None of these functions are
ever going to return -EPROBE_DEFER. And yes, I know that function's doc
says that it is "deemed acceptable to use" elsewhere. However, the
existing error messages are just fine, no need to churn just for the
sake of it.

Thierry

--immTF9VRZDK7uFRg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmVzO9kACgkQ3SOs138+
s6GRTw//SbehEz+5xIvNN1xg+VE3T4JUCI/u64M/sLYpNyYgX4u/WRwvrENS6Qn+
U21ZlVm7DvysGD18hbuvriT76y4hkvMwXHaGONCiMzuH+b8+fZLYoCAPUsX1oIfO
daWOooKW2BGoYXXk3vC/5apPh6y/Ea1lTtFli8lfmoMsIw3vI7tJoPF2iaLXActd
y4q9fujSNm2hL2HWHv0CkM/Sx9JJ2GwfXB6lqtguVDYTXDpECcUu/a7TqSUPK0hO
dIPYfXEQLQW3XWMMuL9LnHqsK+CnzBpMzvFtOwrA7a8Kocq/zWUmJGM5Afp5g9lD
FNInrmijDrZXgrr6CkygOYaxK3a/SzFNLI9RTlhMPGALf7VEUTi7PPL/WvvCRA9B
Qp19gBGkFhRf1d6exWFleBuXAgmXPb31+USb6hXooR0T4VvlhMKKzVBLjcS2vJQg
MqwQRLYYG4oDrKqCs7e3AFWBm0ZSjKz+kNhlqykUXIzB7Jsjeu5BTknn7xXMGqgT
fOeSsP1UF3C19jUpyLXgZnQc2frm2ZIorFSzWNC2kaqpq2r6QU7oxzE/M3fZjwNu
AMcELQlmkfb49YAi4cHqBn1e4YQGVokKu3XJ7oIhVu9fNcUOdeJkUN/OutBHxHO5
lm7KNpVG+L7U95f5VRrIk9nt2ul0sDUzTXvbWq1xmlZ//hODsL8=
=EgR/
-----END PGP SIGNATURE-----

--immTF9VRZDK7uFRg--

