Return-Path: <linux-pwm+bounces-165-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 078DC7F5B9A
	for <lists+linux-pwm@lfdr.de>; Thu, 23 Nov 2023 10:46:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6DFC281833
	for <lists+linux-pwm@lfdr.de>; Thu, 23 Nov 2023 09:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C19E121111;
	Thu, 23 Nov 2023 09:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="UsoyD3Z4"
X-Original-To: linux-pwm@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25E351716
	for <linux-pwm@vger.kernel.org>; Thu, 23 Nov 2023 01:46:48 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 554EB25A;
	Thu, 23 Nov 2023 10:46:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1700732773;
	bh=S0dnQIMNd5hdhiIJzmXIsW3xuGRNCsYSxY8qFC7m3KM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UsoyD3Z4wli11kOeNSOV9M2tKW3q7Gujo6dX2NQ8Z47XNp2grb06n7qVs3br9E1u/
	 4g8BsIWQBIvgqt4MPeEsme3EOWZrvD5jmK30dMWULFH6crofw5EDmC9FPFuxkQP2yS
	 7cLYx1drSF4wJnds/xU9b5zU4bfI0cAxSFMzT7wk=
Date: Thu, 23 Nov 2023 11:46:52 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Thierry Reding <thierry.reding@gmail.com>,
	Douglas Anderson <dianders@chromium.org>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	dri-devel@lists.freedesktop.org, kernel@pengutronix.de,
	linux-pwm@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH v3 101/108] drm/bridge: ti-sn65dsi86: Make use of
 devm_pwmchip_alloc() function
Message-ID: <20231123094652.GH15697@pendragon.ideasonboard.com>
References: <20231121134901.208535-1-u.kleine-koenig@pengutronix.de>
 <20231121134901.208535-102-u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231121134901.208535-102-u.kleine-koenig@pengutronix.de>

Hi Uwe,

(CC'ing Bartosz)

Thank you for the patch.

On Tue, Nov 21, 2023 at 02:50:43PM +0100, Uwe Kleine-König wrote:
> This prepares the pwm driver of the ti-sn65dsi86 to further changes of
> the pwm core outlined in the commit introducing devm_pwmchip_alloc().
> There is no intended semantical change and the driver should behave as
> before.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/gpu/drm/bridge/ti-sn65dsi86.c | 25 ++++++++++++++++---------
>  1 file changed, 16 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> index c45c07840f64..cd40530ffd71 100644
> --- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> +++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> @@ -197,7 +197,7 @@ struct ti_sn65dsi86 {
>  	DECLARE_BITMAP(gchip_output, SN_NUM_GPIOS);
>  #endif
>  #if defined(CONFIG_PWM)
> -	struct pwm_chip			pchip;
> +	struct pwm_chip			*pchip;

Dynamic allocation with devm_*() isn't the right solution for lifetime
issues related to cdev. See my talk at LPC 2022
(https://www.youtube.com/watch?v=kW8LHWlJPTU, slides at
https://lpc.events/event/16/contributions/1227/attachments/1103/2115/20220914-lpc-devm_kzalloc.pdf),
and Bartosz's talk at LPC 2023
(https://lpc.events/event/17/contributions/1627/attachments/1258/2725/Linux%20Plumbers%20Conference%202023.pdf).

>  	bool				pwm_enabled;
>  	atomic_t			pwm_pin_busy;
>  #endif
> @@ -1372,7 +1372,8 @@ static void ti_sn_pwm_pin_release(struct ti_sn65dsi86 *pdata)
>  
>  static struct ti_sn65dsi86 *pwm_chip_to_ti_sn_bridge(struct pwm_chip *chip)
>  {
> -	return container_of(chip, struct ti_sn65dsi86, pchip);
> +	struct ti_sn65dsi86 **pdata = pwmchip_priv(chip);
> +	return *pdata;
>  }
>  
>  static int ti_sn_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
> @@ -1585,22 +1586,28 @@ static const struct pwm_ops ti_sn_pwm_ops = {
>  static int ti_sn_pwm_probe(struct auxiliary_device *adev,
>  			   const struct auxiliary_device_id *id)
>  {
> +	struct pwm_chip *chip;
>  	struct ti_sn65dsi86 *pdata = dev_get_drvdata(adev->dev.parent);
>  
> -	pdata->pchip.dev = pdata->dev;
> -	pdata->pchip.ops = &ti_sn_pwm_ops;
> -	pdata->pchip.npwm = 1;
> -	pdata->pchip.of_xlate = of_pwm_single_xlate;
> -	pdata->pchip.of_pwm_n_cells = 1;
> +	/* XXX: should this better use adev->dev instead of pdata->dev? */
> +	pdata->pchip = chip = devm_pwmchip_alloc(pdata->dev, 1, sizeof(&pdata));
> +	if (IS_ERR(chip))
> +		return PTR_ERR(chip);
>  
> -	return pwmchip_add(&pdata->pchip);
> +	*(struct ti_sn65dsi86 **)pwmchip_priv(chip) = pdata;
> +
> +	chip->ops = &ti_sn_pwm_ops;
> +	chip->of_xlate = of_pwm_single_xlate;
> +	chip->of_pwm_n_cells = 1;
> +
> +	return pwmchip_add(chip);
>  }
>  
>  static void ti_sn_pwm_remove(struct auxiliary_device *adev)
>  {
>  	struct ti_sn65dsi86 *pdata = dev_get_drvdata(adev->dev.parent);
>  
> -	pwmchip_remove(&pdata->pchip);
> +	pwmchip_remove(pdata->pchip);
>  
>  	if (pdata->pwm_enabled)
>  		pm_runtime_put_sync(pdata->dev);

-- 
Regards,

Laurent Pinchart

