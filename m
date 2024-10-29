Return-Path: <linux-pwm+bounces-3951-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1516B9B41A8
	for <lists+linux-pwm@lfdr.de>; Tue, 29 Oct 2024 05:57:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD8332836CC
	for <lists+linux-pwm@lfdr.de>; Tue, 29 Oct 2024 04:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41C9B1DE4C0;
	Tue, 29 Oct 2024 04:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T4UZ7SQK"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70C72FB2;
	Tue, 29 Oct 2024 04:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730177836; cv=none; b=D1r4c2lFaFA2lRIdDJtchxFUbd45IEexOgfc2Iedk0JznDABfLsb8BhTvkE+887pc8JwpmiBvV54fbbLC0h8ZerApLOsIoXWzAJdcXI8GFucVIWWgyZDJgwhL04r8zUmwXUlX54A5RWQ9yrDOlVQJ1dYSjrGi1AyUmp6nA7h1VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730177836; c=relaxed/simple;
	bh=w3dNvlar+8hrakFCL0PJdSpSMr2MisQMbNqP8I8bRaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l2TIq5hkfHvi6AHbuBrFhGnw3wqPBf8NE25my7L256vTsPfCOLpjKuuHSyepWoHNx85LHvlQ0NXxY1OQxAn4aWHMx6l/0KQ2S5dC3si4x5H/Z6Wdg4QIscj3siCqPC8MpVaq8HdARwrJJeY5PjYKfwJtGfq8INv1A2aERny54Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T4UZ7SQK; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7b1507c42faso460393885a.0;
        Mon, 28 Oct 2024 21:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730177833; x=1730782633; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=miRKsVITHzAukzsj+/ygTCg9k/xHlCLYaDB0d4rUOqE=;
        b=T4UZ7SQKh0lWAFPCrQ8snW57OQb0dhWhHbGjZqXTjfJPIe9Pjx7Ij516zaN0DHnZQ4
         Hc+J7VMZA/+kxxM+dzxwEa07JszQoh9CLJ78FArgaDVnOeCGDWfzxbJDtABpRFcyM+e4
         9Ri/Du20XwqaXbujI90ToFGwkVOFHSjNM+aigBZh4D9hwDpjioAqG/cdFDytqcMVEB/c
         bO2pQzRxj0MtKvxVfH94C2Etrh3/dJkzaYN7bXHHhJkRsuWKeP1gixXdT03OI7psnbrS
         1iSBWCFtqReCAXnUfdKbOcjhO6UDvDezFtAg17r2pbVoroRGQBT+yq8YerjBA/FlRpk/
         3+gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730177833; x=1730782633;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=miRKsVITHzAukzsj+/ygTCg9k/xHlCLYaDB0d4rUOqE=;
        b=mRioeFOb3ajJ/LIl+9LIQ0JFfJyLrovHJYWprXAkKG+GgsFkz71C5H4SgJQGLvmrpq
         X8nC7/JgiUFrP7neuzCQ+Jv0kFaBW8c4/ZMS0IqBd96wvB+Vrrz3xWGw9s1L/4RXvIEe
         Aj/wk32hK8dpUkS7B11r9nZ0yqLF4AzCeKQUPp2bQBna3YlpvDsUFIzNAZBq/V2Isa8t
         xmOf5kQNuKa6IwGJrnkuTcPUunujxcj0nLgZVjCU5bQ33N41FgazR2Cqk1wcsV41uepB
         8orS+KXk098RbIjh7A2OKzF4dB1vI/8vxe19QT06FyyLagcig+NC6m8vi8KAScqAaD9Y
         nS3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUhpC3RjTxcq9IlZS6rsPpPTq/Zv5UFATvC/6eRZJ2cmObAD21a/tNGnaa2IfbnLTl3yVHe5L4nIA/j@vger.kernel.org, AJvYcCUuuL+JpBN7u+do+Z8w3zw609PnLvjOrROwt2czxa76gI5mqogesE6n2nizk3mnGDRuY9lZhpS5SZ9+552g@vger.kernel.org, AJvYcCW3DsM/QKQHg6SpjxClrDO38nITvZwmx16ph3NKJ6pD2jnngFpf6e1VCKyc5j7jIeDtdGAiRspFK0XVPAwv0OQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ9XKJK4a1Cpp7RcD1PVVRUjOYiM+i/JmU5URYzdqHZVZzKAO4
	B1VrA5eLImiQD599XH2RW3PCPd2qncAMPGTnz3QM6QM0Y4QyLdIb
X-Google-Smtp-Source: AGHT+IGW1ooBeldcdGoeMJo+T427girUR5zVV1hzqHzNK8xt/vLyirJwTY09tBGqdQSIjGkKrufbxQ==
X-Received: by 2002:a05:6214:2f88:b0:6cb:c661:49ce with SMTP id 6a1803df08f44-6d2f62d4b03mr13390146d6.23.1730177832557;
        Mon, 28 Oct 2024 21:57:12 -0700 (PDT)
Received: from yoga (ool-1826d901.dyn.optonline.net. [24.38.217.1])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d17972f622sm39003676d6.9.2024.10.28.21.57.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 21:57:11 -0700 (PDT)
Date: Tue, 29 Oct 2024 00:57:08 -0400
From: Alex Lanzano <lanzano.alex@gmail.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Mehdi Djait <mehdi.djait@bootlin.com>, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, 
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, dri-devel@lists.freedesktop.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH] drm/tiny: Fix some error handling paths in
 sharp_memory_probe()
Message-ID: <7b4y5djihc4ov7o2h6t27qakvvunkmf4ieozf3earesseny4qd@wdcpk35zt3zg>
References: <b218165cf9af60907e0912266134f1ef1d3617b9.1729924305.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b218165cf9af60907e0912266134f1ef1d3617b9.1729924305.git.christophe.jaillet@wanadoo.fr>

On Sat, Oct 26, 2024 at 08:32:36AM +0200, Christophe JAILLET wrote:
> If an error occurs after allocating resources based on which
> "sharp,vcom-mode" is used, then these resources must be released, as
> already done in the .remove() function.
> 
> Use 2 new devm_add_action_or_reset() for that and simplify code
> accordingly.
> 
> Fixes: b8f9f21716fe ("drm/tiny: Add driver for Sharp Memory LCD")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> Compile tested only
> ---
>  drivers/gpu/drm/tiny/sharp-memory.c | 66 ++++++++++++++---------------
>  1 file changed, 32 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/gpu/drm/tiny/sharp-memory.c b/drivers/gpu/drm/tiny/sharp-memory.c
> index 2d2315bd6aef..01d1ce2462e1 100644
> --- a/drivers/gpu/drm/tiny/sharp-memory.c
> +++ b/drivers/gpu/drm/tiny/sharp-memory.c
> @@ -48,12 +48,6 @@ enum sharp_memory_model {
>  	LS044Q7DH01,
>  };
>  
> -enum sharp_memory_vcom_mode {
> -	SHARP_MEMORY_SOFTWARE_VCOM,
> -	SHARP_MEMORY_EXTERNAL_VCOM,
> -	SHARP_MEMORY_PWM_VCOM
> -};
> -
>  struct sharp_memory_device {
>  	struct drm_device drm;
>  	struct spi_device *spi;
> @@ -67,10 +61,6 @@ struct sharp_memory_device {
>  
>  	struct gpio_desc *enable_gpio;
>  
> -	struct task_struct *sw_vcom_signal;
> -	struct pwm_device *pwm_vcom_signal;
> -
> -	enum sharp_memory_vcom_mode vcom_mode;
>  	u8 vcom;
>  
>  	u32 pitch;
> @@ -500,25 +490,41 @@ static int sharp_memory_pipe_init(struct drm_device *dev,
>  	return drm_connector_attach_encoder(connector, encoder);
>  }
>  
> +static void sharp_memory_stop_kthread(void *data)
> +{
> +	struct task_struct *task = data;
> +
> +	kthread_stop(task);
> +}
> +
> +static void sharp_memory_disable_pwm(void *data)
> +{
> +	struct pwm_device *pwm = data;
> +
> +	pwm_disable(pwm);
> +}
> +
>  static int sharp_memory_init_pwm_vcom_signal(struct sharp_memory_device *smd)
>  {
>  	int ret;
>  	struct device *dev = &smd->spi->dev;
> +	struct pwm_device *pwm_vcom_signal;
>  	struct pwm_state pwm_state;
>  
> -	smd->pwm_vcom_signal = devm_pwm_get(dev, NULL);
> -	if (IS_ERR(smd->pwm_vcom_signal))
> -		return dev_err_probe(dev, PTR_ERR(smd->pwm_vcom_signal),
> +	pwm_vcom_signal = devm_pwm_get(dev, NULL);
> +	if (IS_ERR(pwm_vcom_signal))
> +		return dev_err_probe(dev, PTR_ERR(pwm_vcom_signal),
>  				     "Could not get pwm device\n");
>  
> -	pwm_init_state(smd->pwm_vcom_signal, &pwm_state);
> +	pwm_init_state(pwm_vcom_signal, &pwm_state);
>  	pwm_set_relative_duty_cycle(&pwm_state, 1, 10);
>  	pwm_state.enabled = true;
> -	ret = pwm_apply_might_sleep(smd->pwm_vcom_signal, &pwm_state);
> +	ret = pwm_apply_might_sleep(pwm_vcom_signal, &pwm_state);
>  	if (ret)
>  		return dev_err_probe(dev, -EINVAL, "Could not apply pwm state\n");
>  
> -	return 0;
> +	return devm_add_action_or_reset(dev, sharp_memory_disable_pwm,
> +					pwm_vcom_signal);
>  }
>  
>  static int sharp_memory_probe(struct spi_device *spi)
> @@ -595,15 +601,20 @@ static int sharp_memory_probe(struct spi_device *spi)
>  				     "Unable to find sharp,vcom-mode node in device tree\n");
>  
>  	if (!strcmp("software", vcom_mode_str)) {
> -		smd->vcom_mode = SHARP_MEMORY_SOFTWARE_VCOM;
> -		smd->sw_vcom_signal = kthread_run(sharp_memory_sw_vcom_signal_thread,
> -						  smd, "sw_vcom_signal");
> +		struct task_struct *sw_vcom_signal;
> +
> +		sw_vcom_signal = kthread_run(sharp_memory_sw_vcom_signal_thread,
> +					     smd, "sw_vcom_signal");
> +
> +		ret = devm_add_action_or_reset(dev, sharp_memory_stop_kthread,
> +					       sw_vcom_signal);
> +		if (ret)
> +			return ret;
>  
>  	} else if (!strcmp("external", vcom_mode_str)) {
> -		smd->vcom_mode = SHARP_MEMORY_EXTERNAL_VCOM;
> +		/* empty */
>  
>  	} else if (!strcmp("pwm", vcom_mode_str)) {
> -		smd->vcom_mode = SHARP_MEMORY_PWM_VCOM;
>  		ret = sharp_memory_init_pwm_vcom_signal(smd);
>  		if (ret)
>  			return ret;
> @@ -640,19 +651,6 @@ static void sharp_memory_remove(struct spi_device *spi)
>  
>  	drm_dev_unplug(&smd->drm);
>  	drm_atomic_helper_shutdown(&smd->drm);
> -
> -	switch (smd->vcom_mode) {
> -	case SHARP_MEMORY_SOFTWARE_VCOM:
> -		kthread_stop(smd->sw_vcom_signal);
> -		break;
> -
> -	case SHARP_MEMORY_EXTERNAL_VCOM:
> -		break;
> -
> -	case SHARP_MEMORY_PWM_VCOM:
> -		pwm_disable(smd->pwm_vcom_signal);
> -		break;
> -	}
>  }
>  
>  static struct spi_driver sharp_memory_spi_driver = {
> -- 
> 2.47.0
> 
Tested-by: Alex Lanzano <lanzano.alex@gmail.com>
Reviewed-by: Alex Lanzano <lanzano.alex@gmail.com>

