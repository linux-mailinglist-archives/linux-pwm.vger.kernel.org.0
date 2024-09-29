Return-Path: <linux-pwm+bounces-3399-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A78989729
	for <lists+linux-pwm@lfdr.de>; Sun, 29 Sep 2024 21:48:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EDE4281E0A
	for <lists+linux-pwm@lfdr.de>; Sun, 29 Sep 2024 19:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E21E757EB;
	Sun, 29 Sep 2024 19:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hMcqinDr"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7163C46434;
	Sun, 29 Sep 2024 19:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727639298; cv=none; b=NDO5bgOEis0b/TBSrX8o3NSOwKBwMFJS8y7G/pOZ1iwpxLMJdYFKnJnb6ct0H5EoAqZ8huwUaIAA6P8bxhniAQZY+17TxOHWdhwlQOCvTCGCn1kkIRGPiJZ5aMQDta5npxDctiFwOBIpfGkTw8biP1TEvZ7hXE1AuuriEfmt02w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727639298; c=relaxed/simple;
	bh=n4Gy5P+xTKV6CevjkFfFjH/AY+oUiDjB5BqTBlcvez8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sQ2WBEU0+rRC/1iscNUFxNNAQMDch1q9+K19nks37EwWqxAZrKnZquaCMExpGV7Eysv90Ix3OcwyWYqcR4YD4CGTllndEyiuygVD0DdcmLYnAw+sScgxMQVM7kaR1e3fw0OYETkdGbisiXrNJ7qgmsdbiyvUUgjuRKxjJaou9cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hMcqinDr; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7a99de9beb2so233139785a.3;
        Sun, 29 Sep 2024 12:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727639296; x=1728244096; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=C/yNLMI4Dfa1JOu9ZZ5KMcnVN9OakoAYGWQtbvgWXzk=;
        b=hMcqinDr5/o8p6Moo/fz+PssS3pgUkdabH3YxVyGK4kfiUc5jaacT7WigOaziiGMhd
         AzTbQhmCE2hJx9/ZaVn3Wi2t4x2QxTpQn1tglEG37udvhR291kDVhE5PSZ5WgUpTIww2
         ZvZisctmrD/Dv56Mkn/GL+PMPNoLL7OlMrXlXeQ1W8HgwLWGykErJKm7awLWww2ZuNEM
         9T8+5jvo96o50Ko8+9oyDnxqLXVZ6vSSozdWfLmaedtARXDOMwyBW7UBbsxGmtNfjFzc
         YLtR8J+wGJJ+yJDYQHDNPL6W+/M78DgJkLQJvJdViKIZf0WmjKRtI26MXrzNhPNqxgRf
         WfRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727639296; x=1728244096;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C/yNLMI4Dfa1JOu9ZZ5KMcnVN9OakoAYGWQtbvgWXzk=;
        b=Eca8u7cp23OX60Bf/OQKgXgT+94ySvO7rhf74KBfaLg63AFog/3d1vm4O8XuBNDuGv
         WpKbZNH8fKNMcZuRB0l5Cn0ZLuFi48dmBUa6e899r2qOY3OhvfDdD8OSoWcRwrDrpcn/
         DnaRHONfhLZbgGIxkrWpHZUE070+hndE52pwDm7WLyI2Yeu3uyh1qbxtbAxQuU3hXhZd
         XIbJmft9ls15CluSZQEhEb8P/drkeS7rSB06TWXzaDUgikL+RDYYbZlEDZCp7NjpEhyF
         ZZ4u90xeXx1MmKJRXkd1g534XxRk+3ybNaaLSFPpGF/q+NPm8/GxYF8TiNrpT3q6Ka+5
         aafA==
X-Forwarded-Encrypted: i=1; AJvYcCUQHOmsELJeW4wnajgVDHF7Y7VU1Cq7L0bTU9cTgTEuy1nwTyyg4IK9w2sOrUrwCMHMEZk16//aybDF@vger.kernel.org, AJvYcCWrOGZ0xdgA3YB9LD3gFybEkmHKNWgQt6qvojd6n/da6vHm7RkKRED4BsfhEUNeFAwRXbzc8aeVtrF0@vger.kernel.org, AJvYcCXei0GwX4xr5hsN40AcunN4f7HC9zevUVJUuTWdgnHJdgTy+TW3wygn8cKKLi1FZ9jUj+IKhHk0JOCuE8WX@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4NLECLypBUZkSqugMW1G92ryJxMtZvyy+Dzi8dLBFq1kaD7cG
	EqG1bX9t6/FBVM4LWgnZBsbwbHvZA3RNff/csZ9Qvgx/d67cbQr+
X-Google-Smtp-Source: AGHT+IFeeeUii0kxH//xLKWlv0LXOHbVcGPm/7q0EHdBCNjq4YERwamx3b7Evz0ZK+RetrYdcveDXA==
X-Received: by 2002:a05:620a:370b:b0:7ac:bb36:5c5d with SMTP id af79cd13be357-7ae378529admr1444074285a.31.1727639296140;
        Sun, 29 Sep 2024 12:48:16 -0700 (PDT)
Received: from VM-Arch (ool-1826d901.dyn.optonline.net. [24.38.217.1])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ae3783d613sm347893685a.121.2024.09.29.12.48.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Sep 2024 12:48:15 -0700 (PDT)
Date: Sun, 29 Sep 2024 15:48:11 -0400
From: Alex Lanzano <lanzano.alex@gmail.com>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Mehdi Djait <mehdi.djait@bootlin.com>, christophe.jaillet@wanadoo.fr, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v6 2/2] drm/tiny: Add driver for Sharp Memory LCD
Message-ID: <znyfkop6lm5a734hsuko56xcmeeessqrkhbjhf5iwbtllmli2k@kcwbo7fh6yah>
References: <20240905124432.834831-1-lanzano.alex@gmail.com>
 <20240905124432.834831-3-lanzano.alex@gmail.com>
 <q2njnpzpkd3xrrv6icr5wq6uztja3wfmy2x2ldreqemzbwkedv@ixywmn7qy34q>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <q2njnpzpkd3xrrv6icr5wq6uztja3wfmy2x2ldreqemzbwkedv@ixywmn7qy34q>

Hi thanks for the review! I'll address these in v8. Looks like you
missed my v7 of this patch

On Wed, Sep 25, 2024 at 11:07:00PM GMT, Uwe Kleine-König wrote:
> Hello,
> 
> On Thu, Sep 05, 2024 at 08:44:00AM -0400, Alex Lanzano wrote:
> > +static void sharp_memory_crtc_enable(struct drm_crtc *crtc,
> > +				     struct drm_atomic_state *state)
> > +{
> > +	struct pwm_state pwm_state;
> > +	struct sharp_memory_device *smd = drm_to_sharp_memory_device(crtc->dev);
> > +
> > +	sharp_memory_clear_display(smd);
> > +
> > +	if (smd->enable_gpio)
> > +		gpiod_set_value(smd->enable_gpio, 1);
> > +
> > +	switch (smd->vcom_mode) {
> > +	case SHARP_MEMORY_SOFTWARE_VCOM:
> > +		smd->sw_vcom_signal = kthread_run(sharp_memory_sw_vcom_signal_thread,
> > +						  smd, "sw_vcom_signal");
> > +		break;
> > +
> > +	case SHARP_MEMORY_EXTERNAL_VCOM:
> > +		break;
> > +
> > +	case SHARP_MEMORY_PWM_VCOM:
> > +		pwm_get_state(smd->pwm_vcom_signal, &pwm_state);
> 
> I'd prefer using pwm_init_state() here instead of pwm_get_state(), The
> former only depends on machine description (probably device tree), the
> latter depends on what happend before to the PWM. While it probably
> doesn't make a difference in practise, the former is more deterministic.
> 

Will fix in v8.

> > +		pwm_state.period =    1000000000;
> > +		pwm_state.duty_cycle = 100000000;
> 
> Unusual indention.
> 

Will fix

> The device tree (and also ACPI) defines a default period for a PWM. If
> you used pwm_init_state() -- as suggested above -- you could just use
> pwm_set_relative_duty_cycle(smd->pwm_vcom_signal, 1, 10); here.
> 

Will fix

> > +		pwm_state.enabled = true;
> > +		pwm_apply_might_sleep(smd->pwm_vcom_signal, &pwm_state);
> > +		break;
> > +	}
> > +}
> > +
> > +static void sharp_memory_crtc_disable(struct drm_crtc *crtc,
> > +				      struct drm_atomic_state *state)
> > +{
> > +	struct sharp_memory_device *smd = drm_to_sharp_memory_device(crtc->dev);
> > +
> > +	sharp_memory_clear_display(smd);
> > +
> > +	if (smd->enable_gpio)
> > +		gpiod_set_value(smd->enable_gpio, 0);
> > +
> > +	switch (smd->vcom_mode) {
> > +	case SHARP_MEMORY_SOFTWARE_VCOM:
> > +		kthread_stop(smd->sw_vcom_signal);
> > +		break;
> > +
> > +	case SHARP_MEMORY_EXTERNAL_VCOM:
> > +		break;
> > +
> > +	case SHARP_MEMORY_PWM_VCOM:
> > +		pwm_disable(smd->pwm_vcom_signal);
> 
> What is the objective here? Do you want to save energy and don't care
> about the output? Or do you want the PWM to emit the inactive level?
> Note that for the second case, pwm_disable() is wrong, as depending on
> the underlying hardware the PWM might continue to toggle or emit a
> constant active level.
> 

I want the PWM to stop emitting to save energy.

> > +		break;
> > +	}
> > +}
> > +
> > [...]
> > +
> > +static int sharp_memory_init_pwm_vcom_signal(struct sharp_memory_device *smd)
> > +{
> > +	struct pwm_state state;
> > +	struct device *dev = &smd->spi->dev;
> > +
> > +	smd->pwm_vcom_signal = devm_pwm_get(dev, NULL);
> > +	if (IS_ERR(smd->pwm_vcom_signal))
> > +		return dev_err_probe(dev, -EINVAL, "Could not get pwm device\n");
> > +
> > +	pwm_init_state(smd->pwm_vcom_signal, &state);
> > +	state.enabled = false;
> > +	pwm_apply_might_sleep(smd->pwm_vcom_signal, &state);
> 
> Same question as above. If you care about the output level, use
> 
> 	{
> 		.period = ...,
> 		.duty_cycle = 0,
> 		.enabled = true,
> 	}
> 

See answer above!

> > +
> > +	return 0;
> > +}
> 
> Best regards
> Uwe



