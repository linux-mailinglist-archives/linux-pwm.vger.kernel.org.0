Return-Path: <linux-pwm+bounces-1556-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7654885B712
	for <lists+linux-pwm@lfdr.de>; Tue, 20 Feb 2024 10:18:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9CDD1C24251
	for <lists+linux-pwm@lfdr.de>; Tue, 20 Feb 2024 09:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1884660248;
	Tue, 20 Feb 2024 09:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="STMPGgqH"
X-Original-To: linux-pwm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82BAE5FEEA
	for <linux-pwm@vger.kernel.org>; Tue, 20 Feb 2024 09:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708420659; cv=none; b=ocEMpF77yymJu2wNI7EH7SbBIRzoY/RRjOyIWak+oTvnFb69JnZzIL/uqzI5r28ShzSxUxSQTcwU8Fz0TGO5FBahfWcHlJBhyP5fXTjtIYFpmqQU5UOFzTMeMRmlZZXLBNX8gg476qIMuLfaA/bZjiy/oW4PrmoVGR9Hx1c5C3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708420659; c=relaxed/simple;
	bh=nkf5Q/o2N6uxU/krrkxMdk5G+u0NWrK1OwF42W4+exU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Q3bx5DVPf1mR29IPKcM2mD1YD/Jt13D7Y5mmuwTifxxmSX/ANfRz5pgjFVl8CERrWOxJm+I/5PqJs9Mquz0/XTfzmfsjzIKqHhawNgB/lyCWoqxMtQ5NYXVuJMrPf9aOg0u71uVKFwwswGFepeCIB4JhR0ZN+IOLkWTqkC6t55A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=STMPGgqH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708420656;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QdkBCPYDeheTT+uzHIWpGEdO4JJdk+hRLV0yR8IOegg=;
	b=STMPGgqHuQw+Eqm56NZXLvzBV5wI9kjOYHHH7G3wV8dWHIzXtn/LwOBQ6jxHQNVVFelfag
	xMAzzox2kfEPI7BLwFYKUY12INIZujEy2c6v0V3GqQbEbm32t6KWMua8g/9q+SsLhfGTp5
	K4WebKlg9VBMgWnk3fLLnrqOsd8VJJ0=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-POv33-UtNjCtcrhpz0l5CA-1; Tue, 20 Feb 2024 04:17:34 -0500
X-MC-Unique: POv33-UtNjCtcrhpz0l5CA-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2d100e37cc1so32689111fa.3
        for <linux-pwm@vger.kernel.org>; Tue, 20 Feb 2024 01:17:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708420652; x=1709025452;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QdkBCPYDeheTT+uzHIWpGEdO4JJdk+hRLV0yR8IOegg=;
        b=aRS2O5ykWsF5m7qrCEbbKYzB3bo0suunCb8vltrCyHO4PJDj6PS5kHCnW5FF2QYa31
         8CR1U2ewU32J8b3uALqXLdyO2g0uCQSd+NxkjtYQJs+n13kJdgRbqW+4W20CDxOnqATk
         XRFIE/kwA/7GvksvFmjGuWirVCZcnTGw9KvLwLelS25Kl+v/GoDic1yK45wZSP5TvCP6
         4q6Fc2nUEBqWTSRq2ACVEIkgQFdN9g7ssSxy6ddjxYyZ/xOj4ZvZ64KInibMceglFIYI
         hztF+J2jKAjnxshB6NQmPS9RhoGRH7mtgiutxn3U6qv8XwvfuDelqaiW58w+i/wVDZWP
         +xHA==
X-Forwarded-Encrypted: i=1; AJvYcCWkUnLp6VyM7KsFc6/EJT+wLjlw6C70rFjRS5PxbgqKeYw5veySN2wOwh5HUJBLpeC1+QR2jgDaSZJ+0EsRjCp1G+U9EZzfllu2
X-Gm-Message-State: AOJu0YyME7rOMloBTnR96SSxcBGeqTIB4BBcv5OP2/O3OqxEe6J8Uydd
	iexF18zyLF00F5kB25TFyagXRjcmYeCegiBk+Yw4lpeNkT/myrYN0QZun3aS+jbXVTCcA2Qrr/y
	H4krC3G3fwRlmIe+iVnHjFQ2Vqu9DuA4W7om2AID4T+qKwX2vVohAnW6tYg==
X-Received: by 2002:ac2:5e62:0:b0:512:a93a:f5a5 with SMTP id a2-20020ac25e62000000b00512a93af5a5mr4159538lfr.19.1708420652691;
        Tue, 20 Feb 2024 01:17:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGAJvY45CWeh5zWa4RXaJeTqSuMBy6I0QeL2Im2jjuR1AxRWVjKK6LynUjbfe5DTheoNd69ag==
X-Received: by 2002:ac2:5e62:0:b0:512:a93a:f5a5 with SMTP id a2-20020ac25e62000000b00512a93af5a5mr4159530lfr.19.1708420652349;
        Tue, 20 Feb 2024 01:17:32 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id s6-20020a05600c45c600b00412696bd7d9sm4074941wmo.41.2024.02.20.01.17.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 01:17:32 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, lee@kernel.org,
 daniel.thompson@linaro.org, jingoohan1@gmail.com, deller@gmx.de
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-input@vger.kernel.org, linux-pwm@vger.kernel.org, Thomas Zimmermann
 <tzimmermann@suse.de>
Subject: Re: [PATCH 01/10] backlight: Match backlight device against struct
 fb_info.bl_dev
In-Reply-To: <20240212162645.5661-2-tzimmermann@suse.de>
References: <20240212162645.5661-1-tzimmermann@suse.de>
 <20240212162645.5661-2-tzimmermann@suse.de>
Date: Tue, 20 Feb 2024 10:17:31 +0100
Message-ID: <87bk8bjxzo.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Zimmermann <tzimmermann@suse.de> writes:

Hello Thomas,

> Framebuffer drivers for devices with dedicated backlight are supposed
> to set struct fb_info.bl_dev to the backlight's respective device. Use
> the value to match backlight and framebuffer in the backlight core code.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>  drivers/video/backlight/backlight.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/video/backlight/backlight.c b/drivers/video/backlight/backlight.c
> index 86e1cdc8e3697..48844a4f28ad3 100644
> --- a/drivers/video/backlight/backlight.c
> +++ b/drivers/video/backlight/backlight.c
> @@ -98,7 +98,8 @@ static int fb_notifier_callback(struct notifier_block *self,
>  {
>  	struct backlight_device *bd;
>  	struct fb_event *evdata = data;
> -	int node = evdata->info->node;
> +	struct fb_info *info = evdata->info;
> +	int node = info->node;
>  	int fb_blank = 0;
>  
>  	/* If we aren't interested in this event, skip it immediately ... */
> @@ -110,8 +111,12 @@ static int fb_notifier_callback(struct notifier_block *self,
>  
>  	if (!bd->ops)
>  		goto out;
> -	if (bd->ops->check_fb && !bd->ops->check_fb(bd, evdata->info))
> +	else if (bd->ops->check_fb && !bd->ops->check_fb(bd, info))
>  		goto out;
> +#if IS_ENABLED(CONFIG_FB_BACKLIGHT)
> +	else if (info->bl_dev && info->bl_dev != bd)

If the driver doesn't provide a struct backlight_ops .check_fb callback, I
think that having an info->bl_dev should be mandatory ? Or at least maybe
there should be a warning if info->bl_dev isn't set ?

The would be a driver bug, right ?

Regardless, the change makes sense to me.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


