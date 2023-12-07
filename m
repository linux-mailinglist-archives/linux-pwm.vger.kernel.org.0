Return-Path: <linux-pwm+bounces-439-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDA9C808E2C
	for <lists+linux-pwm@lfdr.de>; Thu,  7 Dec 2023 18:05:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67DF81F2109F
	for <lists+linux-pwm@lfdr.de>; Thu,  7 Dec 2023 17:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F28A481C2;
	Thu,  7 Dec 2023 17:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ObpWpnH8"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E062D481C0;
	Thu,  7 Dec 2023 17:05:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3479C433C7;
	Thu,  7 Dec 2023 17:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701968715;
	bh=h9KGISYyOVGefe6SYKaxV+4376SmODof03fEQ1b9yf8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ObpWpnH8PPrbTJaoI12FrYVVQXYwD74oa0wbAhDG8gdHDp4J26njEEKUmWVo/Bz5d
	 Mn5DjY/agVAEMjTk42o6q1nujhIRdhD9xLFfH0iEfcFJVLhRthd0dpwrXlUA+2sotv
	 dcyWDr3FPSRcxp3lMHjGV5N9ojJrfbhIsTahP2TzkFHaSG4fH3xvXqdqgr6M1mW2sx
	 lizCbEca7Oei3p6p4ERtxr4cJWoo9c7FxgQBzMFmiJxSibOPOlD9d0Q//lIvXoXDVY
	 BUW8BuJBfH1B19mziVTqSTI+CSkudX7NxVTA64gxUoDuzBTTjeahcD9Y9VbBq4d5G5
	 3e1Gjh9cYQcyw==
Date: Thu, 7 Dec 2023 17:05:09 +0000
From: Lee Jones <lee@kernel.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Thierry Reding <thierry.reding@gmail.com>, kernel@pengutronix.de,
	Pavel Machek <pavel@ucw.cz>,
	Conor Dooley <conor.dooley@microchip.com>,
	Anjelique Melendez <quic_amelende@quicinc.com>,
	Rob Herring <robh@kernel.org>,
	Bjorn Andersson <quic_bjorande@quicinc.com>,
	Kees Cook <keescook@chromium.org>, Luca Weiss <luca@z3ntu.xyz>,
	linux-leds@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v4 108/115] leds: qcom-lpg: Make use of
 devm_pwmchip_alloc() function
Message-ID: <20231207170509.GC111411@google.com>
References: <cover.1701860672.git.u.kleine-koenig@pengutronix.de>
 <60605623e9e41d6f4b25e9c0eaf09d99bbc825f2.1701860672.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <60605623e9e41d6f4b25e9c0eaf09d99bbc825f2.1701860672.git.u.kleine-koenig@pengutronix.de>

On Wed, 06 Dec 2023, Uwe Kleine-König wrote:

> This prepares the pwm sub-driver to further changes of the pwm core
> outlined in the commit introducing devm_pwmchip_alloc(). There is no
> intended semantical change and the driver should behave as before.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/leds/rgb/leds-qcom-lpg.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)

Acked-by: Lee Jones <lee@kernel.org>

> diff --git a/drivers/leds/rgb/leds-qcom-lpg.c b/drivers/leds/rgb/leds-qcom-lpg.c
> index 156b73d1f4a2..0a7acf59a420 100644
> --- a/drivers/leds/rgb/leds-qcom-lpg.c
> +++ b/drivers/leds/rgb/leds-qcom-lpg.c
> @@ -77,7 +77,7 @@ struct lpg {
>  
>  	struct mutex lock;
>  
> -	struct pwm_chip pwm;
> +	struct pwm_chip *pwm;
>  
>  	const struct lpg_data *data;
>  
> @@ -978,7 +978,7 @@ static int lpg_pattern_mc_clear(struct led_classdev *cdev)
>  
>  static inline struct lpg *lpg_pwm_from_chip(struct pwm_chip *chip)
>  {
> -	return container_of(chip, struct lpg, pwm);
> +	return pwmchip_get_drvdata(chip);
>  }
>  
>  static int lpg_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
> @@ -1093,13 +1093,17 @@ static const struct pwm_ops lpg_pwm_ops = {
>  
>  static int lpg_add_pwm(struct lpg *lpg)
>  {
> +	struct pwm_chip *chip;
>  	int ret;
>  
> -	lpg->pwm.dev = lpg->dev;
> -	lpg->pwm.npwm = lpg->num_channels;
> -	lpg->pwm.ops = &lpg_pwm_ops;
> +	lpg->pwm = chip = devm_pwmchip_alloc(lpg->dev, lpg->num_channels, 0);
> +	if (IS_ERR(chip))
> +		return PTR_ERR(chip);
>  
> -	ret = devm_pwmchip_add(lpg->dev, &lpg->pwm);
> +	chip->ops = &lpg_pwm_ops;
> +	pwmchip_set_drvdata(chip, lpg);
> +
> +	ret = devm_pwmchip_add(lpg->dev, chip);
>  	if (ret)
>  		dev_err_probe(lpg->dev, ret, "failed to add PWM chip\n");
>  
> -- 
> 2.42.0
> 

-- 
Lee Jones [李琼斯]

