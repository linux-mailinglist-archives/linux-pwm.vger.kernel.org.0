Return-Path: <linux-pwm+bounces-447-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF01809F63
	for <lists+linux-pwm@lfdr.de>; Fri,  8 Dec 2023 10:31:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E9FCB20C0C
	for <lists+linux-pwm@lfdr.de>; Fri,  8 Dec 2023 09:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A24612B94;
	Fri,  8 Dec 2023 09:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="nBV7RK1c"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A7AA1716
	for <linux-pwm@vger.kernel.org>; Fri,  8 Dec 2023 01:30:45 -0800 (PST)
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 720393F5F3
	for <linux-pwm@vger.kernel.org>; Fri,  8 Dec 2023 09:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1702027843;
	bh=uWzbSmFUcTYjr7UGey/qNk1zTeB36hCsnrM5hCDtBEM=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=nBV7RK1ccXfWTVXWvfwYfCaZxmbxl65E303YfFL+as21vVS/rOWZXDipvAYPgCU+F
	 aaezZaNiLVO4jFErdX+LMSWy3gcCztzhZH3bYdIfcgmjtHpTuAykCu2zk2XqGgBCoK
	 GE4sosyZDJklwLzETRX+eIG3D9CJyR8uG197sFcVBDemDJzJKXtMx5n6pJ+gHs6116
	 mL53jT6Muevm5DR5D2PYBXV8sGsBdUyWLfRSjIg5SU3gwbiZXmA26eV4gg5zxvu+qx
	 uSiMzdr9P1bqsRiztT16MaeoDawoCVMyyKT3b52S8BguvHmptlQGBXiJpGnvKi743u
	 4JyKVuO4mVcTA==
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-423f290bbfdso52804741cf.0
        for <linux-pwm@vger.kernel.org>; Fri, 08 Dec 2023 01:30:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702027842; x=1702632642;
        h=content-transfer-encoding:cc:to:subject:message-id:date
         :mime-version:references:in-reply-to:from:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uWzbSmFUcTYjr7UGey/qNk1zTeB36hCsnrM5hCDtBEM=;
        b=Tb1TrztgQf5BpRhbwTIT59XnP5+Mvpxyoh+Q9pokJBieZJdu2rpHrQJKUuS21PALx/
         fUFt358+l/VrQmy86pOVy3wEmrCOYU6/+Ytm3BzGNUC/99/H8A2AEndb7/N9oDU0+yma
         Jqd4HNnYpP6cXOt6kwI39qPgVK/3VoVvfmCfmZKIKZ+fE9923Hk98La89MMNTvDHiiUh
         RmTEwBraqv5nTV+gaIV9CDxpJd7CUsvoE35HA5mtdHVsAd/K27W/RNiQ+BcSmlJHqB8i
         UF42vXK+/TvbT92jr5pLtmYATEHXzr8oIAA0QISnELjRhxzm2J2K/aLl3lbschrh0AsA
         3iIw==
X-Gm-Message-State: AOJu0YzOssSVBCbToNulOoRBTt2Hp7FqwcOqzUqw/VZYHFUCz6XY2IdX
	xMHvVvs4q5PMINbXzuK20DbgegaduK8w6tfhfC7mk4XtEpNYkz8OMIMsaGLtY1XAXkhUNmFm3fu
	TQbQTHYI5D7dU0M9/1BwbEuotYERHLESiUHPfPZjz6Pvu0lc6V4DTMg==
X-Received: by 2002:a05:622a:1388:b0:423:843a:e311 with SMTP id o8-20020a05622a138800b00423843ae311mr796415qtk.23.1702027842547;
        Fri, 08 Dec 2023 01:30:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGVz5DptoQUK6psikD/zbi59O4PuftvbVHfHg/GwVr0qVjhm+KBWqH8BPPsCW9KZBAp6elc0NFCr84CZmMit00=
X-Received: by 2002:a05:622a:1388:b0:423:843a:e311 with SMTP id
 o8-20020a05622a138800b00423843ae311mr796405qtk.23.1702027842336; Fri, 08 Dec
 2023 01:30:42 -0800 (PST)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 8 Dec 2023 04:30:41 -0500
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <500a4f39531bd5fc61eb8ac0092e34d4b1ae2cc0.1701860672.git.u.kleine-koenig@pengutronix.de>
References: <cover.1701860672.git.u.kleine-koenig@pengutronix.de> <500a4f39531bd5fc61eb8ac0092e34d4b1ae2cc0.1701860672.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Fri, 8 Dec 2023 04:30:41 -0500
Message-ID: <CAJM55Z9sUTNKR5EGmPOio8Uh_1+wfs0-aiKcsngUKF24JcO-QA@mail.gmail.com>
Subject: Re: [PATCH v4 089/115] pwm: sifive: Make use of devm_pwmchip_alloc() function
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	Thierry Reding <thierry.reding@gmail.com>
Cc: kernel@pengutronix.de, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, linux-pwm@vger.kernel.org, 
	linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Uwe Kleine-K=C3=B6nig wrote:
> This prepares the pwm-sifive driver to further changes of the pwm core
> outlined in the commit introducing devm_pwmchip_alloc(). There is no
> intended semantical change and the driver should behave as before.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/pwm/pwm-sifive.c | 28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/pwm/pwm-sifive.c b/drivers/pwm/pwm-sifive.c
> index c1b412905d9e..cf3fcffe7b3a 100644
> --- a/drivers/pwm/pwm-sifive.c
> +++ b/drivers/pwm/pwm-sifive.c
> @@ -41,7 +41,7 @@
>  #define PWM_SIFIVE_DEFAULT_PERIOD	10000000
>
>  struct pwm_sifive_ddata {
> -	struct pwm_chip	chip;
> +	struct pwm_chip *chip;

In patch 43 you do ddata =3D (void *)chip + sizeof(*chip). Shouldn't we
be able to get
the chip pointer from ddata using chip =3D (void *)ddata - sizeof(*chip)?

>  	struct mutex lock; /* lock to protect user_count and approx_period */
>  	struct notifier_block notifier;
>  	struct clk *clk;
> @@ -54,7 +54,7 @@ struct pwm_sifive_ddata {
>  static inline
>  struct pwm_sifive_ddata *pwm_sifive_chip_to_ddata(struct pwm_chip *chip)
>  {
> -	return container_of(chip, struct pwm_sifive_ddata, chip);
> +	return pwmchip_get_drvdata(chip);
>  }
>
>  static int pwm_sifive_request(struct pwm_chip *chip, struct pwm_device *=
pwm)
> @@ -102,7 +102,7 @@ static void pwm_sifive_update_clock(struct pwm_sifive=
_ddata *ddata,
>  	/* As scale <=3D 15 the shift operation cannot overflow. */
>  	num =3D (unsigned long long)NSEC_PER_SEC << (PWM_SIFIVE_CMPWIDTH + scal=
e);
>  	ddata->real_period =3D div64_ul(num, rate);
> -	dev_dbg(pwmchip_parent(&ddata->chip),
> +	dev_dbg(pwmchip_parent(ddata->chip),
>  		"New real_period =3D %u ns\n", ddata->real_period);
>  }
>
> @@ -230,15 +230,14 @@ static int pwm_sifive_probe(struct platform_device =
*pdev)
>  	u32 val;
>  	unsigned int enabled_pwms =3D 0, enabled_clks =3D 1;
>
> -	ddata =3D devm_kzalloc(dev, sizeof(*ddata), GFP_KERNEL);
> -	if (!ddata)
> -		return -ENOMEM;
> +	chip =3D devm_pwmchip_alloc(dev, 4, sizeof(*ddata));
> +	if (IS_ERR(chip))
> +		return PTR_ERR(chip);
> +	ddata =3D pwm_sifive_chip_to_ddata(chip);
> +	ddata->chip =3D chip;
>
>  	mutex_init(&ddata->lock);
> -	chip =3D &ddata->chip;
> -	chip->dev =3D dev;
>  	chip->ops =3D &pwm_sifive_ops;
> -	chip->npwm =3D 4;
>
>  	ddata->regs =3D devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(ddata->regs))
> @@ -296,7 +295,7 @@ static int pwm_sifive_probe(struct platform_device *p=
dev)
>  		goto unregister_clk;
>  	}
>
> -	platform_set_drvdata(pdev, ddata);
> +	platform_set_drvdata(pdev, chip);
>  	dev_dbg(dev, "SiFive PWM chip registered %d PWMs\n", chip->npwm);
>
>  	return 0;
> @@ -314,15 +313,16 @@ static int pwm_sifive_probe(struct platform_device =
*pdev)
>
>  static void pwm_sifive_remove(struct platform_device *dev)
>  {
> -	struct pwm_sifive_ddata *ddata =3D platform_get_drvdata(dev);
> +	struct pwm_chip *chip =3D platform_get_drvdata(dev);
> +	struct pwm_sifive_ddata *ddata =3D pwm_sifive_chip_to_ddata(chip);
>  	struct pwm_device *pwm;
>  	int ch;
>
> -	pwmchip_remove(&ddata->chip);
> +	pwmchip_remove(chip);
>  	clk_notifier_unregister(ddata->clk, &ddata->notifier);
>
> -	for (ch =3D 0; ch < ddata->chip.npwm; ch++) {
> -		pwm =3D &ddata->chip.pwms[ch];
> +	for (ch =3D 0; ch < chip->npwm; ch++) {
> +		pwm =3D &chip->pwms[ch];
>  		if (pwm->state.enabled)
>  			clk_disable(ddata->clk);
>  	}
> --
> 2.42.0
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

