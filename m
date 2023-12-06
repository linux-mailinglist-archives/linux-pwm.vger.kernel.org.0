Return-Path: <linux-pwm+bounces-421-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 61BAB807625
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 18:11:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03944B20CBB
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 17:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99FCA3EA7D;
	Wed,  6 Dec 2023 17:11:36 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 672A6C9
	for <linux-pwm@vger.kernel.org>; Wed,  6 Dec 2023 09:11:33 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 96166143D;
	Wed,  6 Dec 2023 09:12:18 -0800 (PST)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6CD263F762;
	Wed,  6 Dec 2023 09:11:31 -0800 (PST)
Date: Wed, 6 Dec 2023 17:11:28 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@pengutronix.de>
Cc: Thierry Reding <thierry.reding@gmail.com>, kernel@pengutronix.de,
 Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, linux-pwm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v4 097/115] pwm: sun4i: Make use of devm_pwmchip_alloc()
 function
Message-ID: <20231206171128.3e2391ea@donnerap.manchester.arm.com>
In-Reply-To: <c79e120b120df9eedddaaf70364d28e15df23d91.1701860672.git.u.kleine-koenig@pengutronix.de>
References: <cover.1701860672.git.u.kleine-koenig@pengutronix.de>
	<c79e120b120df9eedddaaf70364d28e15df23d91.1701860672.git.u.kleine-koenig@pengutronix.de>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed,  6 Dec 2023 12:44:51 +0100
Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> wrote:

Hi,

> This prepares the pwm-sun4i driver to further changes of the pwm core
> outlined in the commit introducing devm_pwmchip_alloc(). There is no
> intended semantical change and the driver should behave as before.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

That looks alright to me, it's really only wrapping the access to
struct sun4i_pwm_chip using the newly provided functions.

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Cheers,
Andre

> ---
>  drivers/pwm/pwm-sun4i.c | 34 +++++++++++++++++++---------------
>  1 file changed, 19 insertions(+), 15 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
> index 44edf1ce5739..36a8dc65b19c 100644
> --- a/drivers/pwm/pwm-sun4i.c
> +++ b/drivers/pwm/pwm-sun4i.c
> @@ -81,7 +81,6 @@ struct sun4i_pwm_data {
>  };
> =20
>  struct sun4i_pwm_chip {
> -	struct pwm_chip chip;
>  	struct clk *bus_clk;
>  	struct clk *clk;
>  	struct reset_control *rst;
> @@ -92,7 +91,7 @@ struct sun4i_pwm_chip {
> =20
>  static inline struct sun4i_pwm_chip *to_sun4i_pwm_chip(struct pwm_chip *=
chip)
>  {
> -	return container_of(chip, struct sun4i_pwm_chip, chip);
> +	return pwmchip_get_drvdata(chip);
>  }
> =20
>  static inline u32 sun4i_pwm_readl(struct sun4i_pwm_chip *chip,
> @@ -384,17 +383,22 @@ MODULE_DEVICE_TABLE(of, sun4i_pwm_dt_ids);
> =20
>  static int sun4i_pwm_probe(struct platform_device *pdev)
>  {
> +	struct pwm_chip *chip;
>  	struct sun4i_pwm_chip *sun4ichip;
> +	const struct sun4i_pwm_data *data;
>  	int ret;
> =20
> -	sun4ichip =3D devm_kzalloc(&pdev->dev, sizeof(*sun4ichip), GFP_KERNEL);
> -	if (!sun4ichip)
> -		return -ENOMEM;
> -
> -	sun4ichip->data =3D of_device_get_match_data(&pdev->dev);
> -	if (!sun4ichip->data)
> +	data =3D of_device_get_match_data(&pdev->dev);
> +	if (!data)
>  		return -ENODEV;
> =20
> +	chip =3D devm_pwmchip_alloc(&pdev->dev, data->npwm, sizeof(*sun4ichip));
> +	if (IS_ERR(chip))
> +		return PTR_ERR(chip);
> +	sun4ichip =3D to_sun4i_pwm_chip(chip);
> +
> +	sun4ichip->data =3D data;
> +
>  	sun4ichip->base =3D devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(sun4ichip->base))
>  		return PTR_ERR(sun4ichip->base);
> @@ -451,19 +455,18 @@ static int sun4i_pwm_probe(struct platform_device *=
pdev)
>  		goto err_bus;
>  	}
> =20
> -	sun4ichip->chip.dev =3D &pdev->dev;
> -	sun4ichip->chip.ops =3D &sun4i_pwm_ops;
> -	sun4ichip->chip.npwm =3D sun4ichip->data->npwm;
> +	chip->ops =3D &sun4i_pwm_ops;
> +	chip->npwm =3D sun4ichip->data->npwm;
> =20
>  	spin_lock_init(&sun4ichip->ctrl_lock);
> =20
> -	ret =3D pwmchip_add(&sun4ichip->chip);
> +	ret =3D pwmchip_add(chip);
>  	if (ret < 0) {
>  		dev_err(&pdev->dev, "failed to add PWM chip: %d\n", ret);
>  		goto err_pwm_add;
>  	}
> =20
> -	platform_set_drvdata(pdev, sun4ichip);
> +	platform_set_drvdata(pdev, chip);
> =20
>  	return 0;
> =20
> @@ -477,9 +480,10 @@ static int sun4i_pwm_probe(struct platform_device *p=
dev)
> =20
>  static void sun4i_pwm_remove(struct platform_device *pdev)
>  {
> -	struct sun4i_pwm_chip *sun4ichip =3D platform_get_drvdata(pdev);
> +	struct pwm_chip *chip =3D platform_get_drvdata(pdev);
> +	struct sun4i_pwm_chip *sun4ichip =3D to_sun4i_pwm_chip(chip);
> =20
> -	pwmchip_remove(&sun4ichip->chip);
> +	pwmchip_remove(chip);
> =20
>  	clk_disable_unprepare(sun4ichip->bus_clk);
>  	reset_control_assert(sun4ichip->rst);


