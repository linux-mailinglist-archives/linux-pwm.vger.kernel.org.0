Return-Path: <linux-pwm+bounces-1055-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47ECE83C278
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 13:27:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2E8CB21F58
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 12:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 810B2482EE;
	Thu, 25 Jan 2024 12:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E1tLv29k"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE13482DC
	for <linux-pwm@vger.kernel.org>; Thu, 25 Jan 2024 12:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706185609; cv=none; b=YpVJxEJ0cke9I+B/I6uWeingI6mxC1nf7x9MgHX7lAByfoW8RrisLp4C9zJVHzCA5HRkc91rN6DW3zh8yIIekNbfHgUkBh2FOSA6lP8TyLC28YOQK7TAdu2Xj3H1kj8X3derJe3b/AC10MVXPUTy1Kdecz6P1BBEkx6RqWaefy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706185609; c=relaxed/simple;
	bh=f2s70FoxfWKlvYI8rEQuBCtCm0pNVV+xAm5hARhYJ5M=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=pJfL7ha02rVr1qNBX+gABatoFETajQW6FyuIq/qaeykNH5qC09jYlHTAl9Ad6GGakjfog3nlKFAreEy3xeraC5b9/ue7WyCTqe2Wi0+QbE8FskPSHXSLviFtLyTTxtpUbBlgzCQFcQxEyPjVbhjQLYLS3yaIK7GMJ7UvVwm4vJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E1tLv29k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AF7BC433C7;
	Thu, 25 Jan 2024 12:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706185609;
	bh=f2s70FoxfWKlvYI8rEQuBCtCm0pNVV+xAm5hARhYJ5M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=E1tLv29ko87lvgMaCaJ3t8/pCxbwX4nfkj3TYDcgrjNyVoXcU2mppIq5KmclTM056
	 we9MPOtAZTGgc55uW2cwBb1EIRlTGwR+gVbJIHPFZb4Wgi73XDXvEO2UVkkEq/rD5G
	 yt5sE8IGlLRtYA9zXr+EXnZ9C4bbY7SR7GVzaGwiquvxx5N8CxAQ7D4VfpIQf5FNHg
	 QstyaZCynp2DhJlb7Rioafdcwn8EdDkcNp9+cy6csi3Te4ok5PLbfHCt9/DLGRLiG0
	 3pFKJpG0anzxcrsJPbHJOJPgdzLRtSvP6hg1PbQsmWHsagOz04WnhaNzsr2k8JFQsg
	 VW6/4OJoRkkbw==
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 25 Jan 2024 13:26:45 +0100
From: Michael Walle <mwalle@kernel.org>
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH v5 087/111] pwm: sl28cpld: Make use of
 devm_pwmchip_alloc() function
In-Reply-To: <eba4f163b407831e27d1de769fe3a8ef29ad1f0d.1706182805.git.u.kleine-koenig@pengutronix.de>
References: <cover.1706182805.git.u.kleine-koenig@pengutronix.de>
 <eba4f163b407831e27d1de769fe3a8ef29ad1f0d.1706182805.git.u.kleine-koenig@pengutronix.de>
Message-ID: <8c92b4fa9e568f875763c65cdebc925e@kernel.org>
X-Sender: mwalle@kernel.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit

> This prepares the pwm-sl28cpld driver to further changes of the pwm 
> core
> outlined in the commit introducing devm_pwmchip_alloc(). There is no
> intended semantical change and the driver should behave as before.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Reviewed-by: Michael Walle <mwalle@kernel.org>

With a small nit below.

> ---
>  drivers/pwm/pwm-sl28cpld.c | 13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-sl28cpld.c b/drivers/pwm/pwm-sl28cpld.c
> index 88b01ff9e460..934378d6a002 100644
> --- a/drivers/pwm/pwm-sl28cpld.c
> +++ b/drivers/pwm/pwm-sl28cpld.c
> @@ -81,14 +81,13 @@
>  	regmap_write((priv)->regmap, (priv)->offset + (reg), (val))
> 
>  struct sl28cpld_pwm {
> -	struct pwm_chip chip;
>  	struct regmap *regmap;
>  	u32 offset;
>  };
> 
>  static inline struct sl28cpld_pwm *sl28cpld_pwm_from_chip(struct 
> pwm_chip *chip)
>  {
> -	return container_of(chip, struct sl28cpld_pwm, chip);
> +	return pwmchip_get_drvdata(chip);

This function now seems superfluous. Better use
pwmchip_get_drvdata(chip) directly.

If you don't respin or this is too much work, I can
send a patch once this is applied.

-michael

>  }
> 
>  static int sl28cpld_pwm_get_state(struct pwm_chip *chip,
> @@ -213,9 +212,10 @@ static int sl28cpld_pwm_probe(struct 
> platform_device *pdev)
>  		return -ENODEV;
>  	}
> 
> -	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> -	if (!priv)
> -		return -ENOMEM;
> +	chip = devm_pwmchip_alloc(&pdev->dev, 1, sizeof(*priv));
> +	if (IS_ERR(chip))
> +		return PTR_ERR(chip);
> +	priv = sl28cpld_pwm_from_chip(chip);
> 
>  	priv->regmap = dev_get_regmap(pdev->dev.parent, NULL);
>  	if (!priv->regmap) {
> @@ -231,10 +231,7 @@ static int sl28cpld_pwm_probe(struct 
> platform_device *pdev)
>  	}
> 
>  	/* Initialize the pwm_chip structure */
> -	chip = &priv->chip;
> -	chip->dev = &pdev->dev;
>  	chip->ops = &sl28cpld_pwm_ops;
> -	chip->npwm = 1;
> 
>  	ret = devm_pwmchip_add(&pdev->dev, chip);
>  	if (ret) {

