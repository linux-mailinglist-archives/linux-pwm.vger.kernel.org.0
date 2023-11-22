Return-Path: <linux-pwm+bounces-141-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 395CA7F4535
	for <lists+linux-pwm@lfdr.de>; Wed, 22 Nov 2023 12:56:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A3441C2083C
	for <lists+linux-pwm@lfdr.de>; Wed, 22 Nov 2023 11:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C57F5467F;
	Wed, 22 Nov 2023 11:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gs4ZTWRA"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6C54B5AE;
	Wed, 22 Nov 2023 11:56:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02FADC433C8;
	Wed, 22 Nov 2023 11:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700654186;
	bh=7FpwYJTnM8Sy35jSkWBC0FWDgkpbT2czkdSgJPRxWPs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gs4ZTWRApFZS9ttCpySF1aqua3iT0HL2HNL5YjdrMkIgNUNDVUD/sQHo1d/YmIZ7Y
	 EoUypfwAIJdv0D529TfvuG83FvJ+vWI8xOcrJfvtRXzY/NRmz+ioXywL7fmIHQP19g
	 paeGSFD2pWrl01YMVq18ArJrAdX7H9BGa6NpJTzbW2bvNjdb65EZG82IOql4WSPjD5
	 Q7cXJiLM7wijfbgNjL0Jrr4xQqsipLe5zx0cJr8BRUmS31J6IiV0xySUpXV/y9LUFQ
	 PIBwCRwsax/7LA7RXhFrVMcIPpwDVXQX/SUyc8CtVwU1mx9PFsydAVrHsRhEpwK7vG
	 2TTyubatL4gQQ==
Date: Wed, 22 Nov 2023 11:56:21 +0000
From: Lee Jones <lee@kernel.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Pavel Machek <pavel@ucw.cz>, Thierry Reding <thierry.reding@gmail.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Anjelique Melendez <quic_amelende@quicinc.com>,
	Rob Herring <robh@kernel.org>, Kees Cook <keescook@chromium.org>,
	Luca Weiss <luca@z3ntu.xyz>,
	Bjorn Andersson <quic_bjorande@quicinc.com>,
	linux-leds@vger.kernel.org, kernel@pengutronix.de,
	linux-pwm@vger.kernel.org
Subject: Re: [PATCH v3 102/108] leds: qcom-lpg: Make use of
 devm_pwmchip_alloc() function
Message-ID: <20231122115621.GK173820@google.com>
References: <20231121134901.208535-1-u.kleine-koenig@pengutronix.de>
 <20231121134901.208535-103-u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231121134901.208535-103-u.kleine-koenig@pengutronix.de>

On Tue, 21 Nov 2023, Uwe Kleine-König wrote:

> This prepares the pwm sub-driver to further changes of the pwm core
> outlined in the commit introducing devm_pwmchip_alloc(). There is no
> intended semantical change and the driver should behave as before.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/leds/rgb/leds-qcom-lpg.c | 30 +++++++++++++++++++++---------
>  1 file changed, 21 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/leds/rgb/leds-qcom-lpg.c b/drivers/leds/rgb/leds-qcom-lpg.c
> index 68d82a682bf6..283227e02df6 100644
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
> @@ -977,9 +977,15 @@ static int lpg_pattern_mc_clear(struct led_classdev *cdev)
>  	return lpg_pattern_clear(led);
>  }
>  
> +static inline struct lpg *lpg_pwm_from_chip(struct pwm_chip *chip)
> +{
> +	struct lpg **lpg = pwmchip_priv(chip);
> +	return *lpg;
> +}

I don't have easy-vis into the other patches, but if this is a common
pattern, perhaps add a generic helper in <linux/pwm.h>?

>  static int lpg_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
>  {
> -	struct lpg *lpg = container_of(chip, struct lpg, pwm);
> +	struct lpg *lpg = lpg_pwm_from_chip(chip);
>  	struct lpg_channel *chan = &lpg->channels[pwm->hwpwm];
>  
>  	return chan->in_use ? -EBUSY : 0;
> @@ -995,7 +1001,7 @@ static int lpg_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
>  static int lpg_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>  			 const struct pwm_state *state)
>  {
> -	struct lpg *lpg = container_of(chip, struct lpg, pwm);
> +	struct lpg *lpg = lpg_pwm_from_chip(chip);
>  	struct lpg_channel *chan = &lpg->channels[pwm->hwpwm];
>  	int ret = 0;
>  
> @@ -1026,7 +1032,7 @@ static int lpg_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>  static int lpg_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
>  			     struct pwm_state *state)
>  {
> -	struct lpg *lpg = container_of(chip, struct lpg, pwm);
> +	struct lpg *lpg = lpg_pwm_from_chip(chip);
>  	struct lpg_channel *chan = &lpg->channels[pwm->hwpwm];
>  	unsigned int resolution;
>  	unsigned int pre_div;
> @@ -1089,13 +1095,19 @@ static const struct pwm_ops lpg_pwm_ops = {
>  
>  static int lpg_add_pwm(struct lpg *lpg)
>  {
> +	struct pwm_chip *chip;
>  	int ret;
>  
> -	lpg->pwm.dev = lpg->dev;
> -	lpg->pwm.npwm = lpg->num_channels;
> -	lpg->pwm.ops = &lpg_pwm_ops;
> +	lpg->pwm = chip = devm_pwmchip_alloc(lpg->dev, lpg->num_channels,
> +					     sizeof(&lpg));
> +	if (IS_ERR(chip))
> +		return PTR_ERR(chip);
>  
> -	ret = pwmchip_add(&lpg->pwm);
> +	*(struct lpg **)pwmchip_priv(chip) = lpg;

This is vile!

-- 
Lee Jones [李琼斯]

