Return-Path: <linux-pwm+bounces-203-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2F627F8D42
	for <lists+linux-pwm@lfdr.de>; Sat, 25 Nov 2023 19:48:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFF961C20A48
	for <lists+linux-pwm@lfdr.de>; Sat, 25 Nov 2023 18:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E121EB57;
	Sat, 25 Nov 2023 18:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HiI9/E92"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4643DEA
	for <linux-pwm@vger.kernel.org>; Sat, 25 Nov 2023 10:48:39 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-40b2fa4ec5eso21296925e9.2
        for <linux-pwm@vger.kernel.org>; Sat, 25 Nov 2023 10:48:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700938118; x=1701542918; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5SzMDeq8cuJF4iGMiJU+VHUL3rvnTgoje2vjhJHYf3M=;
        b=HiI9/E9244wfga/pGMDeSlYaEaB+3pfGU+yIoCVyfMAykmx0j1fKzx80DFMKUeI/tI
         G3KdN0M+lZdlDgaWyB62ZRoiwVgUPZkryz05FI75aARAj62p9rdxOs8GEoBhUuWAz4QU
         DF0QZizjbT71owtUur8FskTKRVlDW10Zd7+txtVCmjhi+oekIqIv6OugzTZR9BTtzQYb
         720WULiHSXK/Y4uN7c2YW47EUMGi3EJH1DaSudraluy5id3UyPZnbUitsx3PZpR0MX/B
         9fTcQk0uKTiQPCgTdYvuUCVfAltzli2oQZKn6jEfsLbHW0GBibDA7A/BbeOjUE2U1DRP
         /dDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700938118; x=1701542918;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5SzMDeq8cuJF4iGMiJU+VHUL3rvnTgoje2vjhJHYf3M=;
        b=NuDFXrCSqVHejDkEY0w2inb/N1JxCpmxhSSDamcyinyhWymvGUDx9fWU2agsx2TReo
         C4a7k9N5nBgKFwHAu4DR8kTRm4R8Z5Jr4sDEC/fDbnfgVoGp9W/kTCLrgSLKqMFs8/Mq
         qJvAV6+dvd1ruqPe/zytXnk1oDpiWZx9ijLdFNgFmC0nKqgLA3ctn6Fa9HGSNBXL6wMJ
         k9kdRDHhT2s8Anw38cCbUJ5FesfDs4qw4BqZKrTHsN6LMzeHP1riq/dcrhDtRqAFZ3ej
         fTwy/J5EJoVbq5i17pP0KSf4wldgNqnRs3e1JndQCii0LbJbpxgLoItSRkbC2sPHvH8F
         d1GQ==
X-Gm-Message-State: AOJu0YyqNZyoDy44SDG4Ew71hIY+cdEymCpzkxW+cy/3oChZb2ygX970
	M7zg13YmZ/xA0iHpy7HnoKs=
X-Google-Smtp-Source: AGHT+IFeInfOx+70yaIqwk3UdjHO8KiZz0Ggp4tdjGhbYyZu1TqbbJipbhA1dexuK9jYndmtYvWdiA==
X-Received: by 2002:a05:600c:b85:b0:40a:45ff:fd69 with SMTP id fl5-20020a05600c0b8500b0040a45fffd69mr5382276wmb.19.1700938117285;
        Sat, 25 Nov 2023 10:48:37 -0800 (PST)
Received: from jernej-laptop.localnet ([188.159.248.16])
        by smtp.gmail.com with ESMTPSA id n8-20020a05600c3b8800b0040b398f0585sm6003890wms.9.2023.11.25.10.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Nov 2023 10:48:36 -0800 (PST)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
 Samuel Holland <samuel@sholland.org>,
 Uwe =?ISO-8859-1?Q?Kleine=2DK=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, kernel@pengutronix.de
Subject: Re: [PATCH v3 030/108] pwm: sun4i: Make use of pwmchip_parent() macro
Date: Sat, 25 Nov 2023 19:48:35 +0100
Message-ID: <2706375.mvXUDI8C0e@jernej-laptop>
In-Reply-To: <20231121134901.208535-31-u.kleine-koenig@pengutronix.de>
References:
 <20231121134901.208535-1-u.kleine-koenig@pengutronix.de>
 <20231121134901.208535-31-u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Dne torek, 21. november 2023 ob 14:49:32 CET je Uwe Kleine-K=F6nig napisal(=
a):
> struct pwm_chip::dev is about to change. To not have to touch this
> driver in the same commit as struct pwm_chip::dev, use the macro
> provided for exactly this purpose.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
>  drivers/pwm/pwm-sun4i.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
> index 1a439025540d..44edf1ce5739 100644
> --- a/drivers/pwm/pwm-sun4i.c
> +++ b/drivers/pwm/pwm-sun4i.c
> @@ -245,7 +245,7 @@ static int sun4i_pwm_apply(struct pwm_chip *chip, str=
uct pwm_device *pwm,
>  	if (!cstate.enabled) {
>  		ret =3D clk_prepare_enable(sun4i_pwm->clk);
>  		if (ret) {
> -			dev_err(chip->dev, "failed to enable PWM clock\n");
> +			dev_err(pwmchip_parent(chip), "failed to enable PWM clock\n");
>  			return ret;
>  		}
>  	}
> @@ -253,7 +253,7 @@ static int sun4i_pwm_apply(struct pwm_chip *chip, str=
uct pwm_device *pwm,
>  	ret =3D sun4i_pwm_calculate(sun4i_pwm, state, &duty, &period, &prescale=
r,
>  				  &bypass);
>  	if (ret) {
> -		dev_err(chip->dev, "period exceeds the maximum value\n");
> +		dev_err(pwmchip_parent(chip), "period exceeds the maximum value\n");
>  		if (!cstate.enabled)
>  			clk_disable_unprepare(sun4i_pwm->clk);
>  		return ret;
>=20





