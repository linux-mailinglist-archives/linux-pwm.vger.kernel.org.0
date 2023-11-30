Return-Path: <linux-pwm+bounces-270-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3CD07FF2E6
	for <lists+linux-pwm@lfdr.de>; Thu, 30 Nov 2023 15:50:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 903B9281CBF
	for <lists+linux-pwm@lfdr.de>; Thu, 30 Nov 2023 14:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43D194879F;
	Thu, 30 Nov 2023 14:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b+tX71sq"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267504879D
	for <linux-pwm@vger.kernel.org>; Thu, 30 Nov 2023 14:50:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDDCCC433C7;
	Thu, 30 Nov 2023 14:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701355832;
	bh=maT/ZkHw8r+oH1yc7sPgjKS5YB45zXIGjHJKrqgo5nw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b+tX71sq5NmkH1h8uT382wV1v6hyCw7TpzdKaRaWJCb8pEjgMjTeoT17AiJA4pRPA
	 44CbESjfNs0Kb0W+fFs2MqWV+9+rlOwyNyamfAzx6dtFJByq5vhpEK/ZzIm8L5FZ0V
	 dDiOlN0hgEmYwulRiIOmBQ4zl10N55FHdOFSd/l71me/TtVy0UOP7Qx5N43VeLH7I7
	 EgxRJxZo6oDExppXG3lm2NPoJb9S2+B48wWv4AAgABWMGGsgPDy7oJTOzZKkHOg5bX
	 R0Ua0/RqEPkOnjragyBm+2sf/TMYmgxuLRjDEYy0DszqYBaB6rUIKzHTrTfNYfJjEs
	 WGxWmU2+7JPEQ==
Date: Thu, 30 Nov 2023 14:50:27 +0000
From: Lee Jones <lee@kernel.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Thierry Reding <thierry.reding@gmail.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>, linux-pwm@vger.kernel.org,
	kernel@pengutronix.de
Subject: Re: [PATCH 1/3] pwm: Provide wrappers for storing and getting
 private data
Message-ID: <20231130145027.GA3259151@google.com>
References: <20231124215208.616551-1-u.kleine-koenig@pengutronix.de>
 <20231124215208.616551-2-u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231124215208.616551-2-u.kleine-koenig@pengutronix.de>

On Fri, 24 Nov 2023, Uwe Kleine-König wrote:

> Also call pwmchip_set_drvdata() in pwmchip_alloc() to have a sane
> default. Might replace pwmchip_priv()?!
> 
> After struct pwm_chip got its own struct device, this can make use of
> dev_get_drvdata() and dev_set_drvdata() on that device.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/pwm/core.c  |  2 ++
>  include/linux/pwm.h | 19 +++++++++++++++++++
>  2 files changed, 21 insertions(+)
> 
> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> index 17577a1c4efc..0cbce704cc0b 100644
> --- a/drivers/pwm/core.c
> +++ b/drivers/pwm/core.c
> @@ -216,6 +216,8 @@ struct pwm_chip *devm_pwmchip_alloc(struct device *parent, unsigned int npwm, si
>  	chip->dev = parent;
>  	chip->npwm = npwm;
>  
> +	pwmchip_set_drvdata(chip, pwmchip_priv(chip));
> +
>  	return chip;
>  }
>  EXPORT_SYMBOL_GPL(devm_pwmchip_alloc);
> diff --git a/include/linux/pwm.h b/include/linux/pwm.h
> index 3c62cf329ee0..7a32ac687717 100644
> --- a/include/linux/pwm.h
> +++ b/include/linux/pwm.h
> @@ -302,6 +302,7 @@ struct pwm_chip {
>  
>  	/* only used internally by the PWM framework */
>  	struct pwm_device *pwms;
> +	void *drvdata;

I appreciate that this may be temporary, but why not use the precedent
already set by struct device?

  void            *driver_data;

>  };
>  
>  static inline struct device *pwmchip_parent(struct pwm_chip *chip)
> @@ -309,6 +310,24 @@ static inline struct device *pwmchip_parent(struct pwm_chip *chip)
>  	return chip->dev;
>  }
>  
> +static inline void *pwmchip_get_drvdata(struct pwm_chip *chip)
> +{
> +	/*
> +	 * After pwm_chip got a dedicated struct device, this can be replaced by
> +	 * dev_get_drvdata(&chip->dev);
> +	 */
> +	return chip->drvdata;
> +}
> +
> +static inline void pwmchip_set_drvdata(struct pwm_chip *chip, void *data)
> +{
> +	/*
> +	 * After pwm_chip got a dedicated struct device, this can be replaced by
> +	 * dev_set_drvdata(&chip->dev, data);
> +	 */
> +	chip->drvdata = data;
> +}
> +
>  #if IS_ENABLED(CONFIG_PWM)
>  /* PWM user APIs */
>  int pwm_apply_state(struct pwm_device *pwm, const struct pwm_state *state);
> -- 
> 2.42.0
> 

-- 
Lee Jones [李琼斯]

