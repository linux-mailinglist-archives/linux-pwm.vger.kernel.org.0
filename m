Return-Path: <linux-pwm+bounces-1520-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14BCD856287
	for <lists+linux-pwm@lfdr.de>; Thu, 15 Feb 2024 13:06:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3550281A9E
	for <lists+linux-pwm@lfdr.de>; Thu, 15 Feb 2024 12:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 307D312BEA1;
	Thu, 15 Feb 2024 12:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J3bMSFGD"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B6112AAE5
	for <linux-pwm@vger.kernel.org>; Thu, 15 Feb 2024 12:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707998795; cv=none; b=nFUDQpzOXciuh6/dpW12oMu8uuYxr44nbqOPukRx/sHeLI/XxT1ZJEFo+sZaTGyioR18HHew/VdxoyKys9tf+lWUHExIuAAJU1SyVJPE2uU6RAilel3zVk8BBD91bWrcXd0KlsvIoXOrxVk7fYo25qyvaGz4RSloaHKPaJsaizg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707998795; c=relaxed/simple;
	bh=w9U1H09U+2f4ftaRuPUfEvrB/jRLSmaCK86+AH3G8uE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R78PkAjoPTj7y8htaxf0abk8Ltd9bSynY041BFJN01mRhh/MYVkNxqPstSpRPT/Mix3YwzQvIWGQ6oabXSK+d7ePWI/nOWRcCrFWfmpXr20XVgdKB9rr0AhQMFs5vWl6cZK32VmmyN5gXgh+jbOTAJVyESrVchV3Cr3KlQA35Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=J3bMSFGD; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-411d715c401so6130185e9.1
        for <linux-pwm@vger.kernel.org>; Thu, 15 Feb 2024 04:06:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707998791; x=1708603591; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VMgDoMHIzFuqODakLtjtNeclHHbG8KPNcm8YqaMnNoA=;
        b=J3bMSFGD5OBNJr+AA72dX4JgkgCFxiiD8jUwEklru6Pr74joyi4BKKoa+zEZOYddeF
         wckQY+Gzlw7+3qtzUc9fTI+skaM8ImPVPfyGtkRIjsvUr7yZqur9fZtrfNKlYu3/7oB3
         1RoXLLipAQeNwr5nbkOnErbf7WSGmUZseAOxlyMuInOjwL76+n8SBsZIYKeUaFn2HGrE
         2Wbf9XJej97Uw8skwR+QCsgAOJmD/RleUVbV/tEiI9noh2vZQ8Ct0PKhrk7OC/yQcf0o
         TYgFYJnm3FpjLJonXuogsK8WljO15+6ud15aMC6laAeFyxM3J8idGMhjM8d6bOhyXmM/
         433Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707998791; x=1708603591;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VMgDoMHIzFuqODakLtjtNeclHHbG8KPNcm8YqaMnNoA=;
        b=PnAUvYAGdd2J3F7eWPUEoM2+6aVNHCRMvGMjnY3Cb3/BNUMsFduP5dLoeI6pYfI77P
         JHjuNovhSU521LrZj2dGk8jtouPV49mdSDQC1H0N60/55C5y1Q9qq9OVEte/F719NLBa
         fZrNHoxl2UYJMVgG2krPq+g8h0ibShZZ2r3ooy+5Mrq0SnMqDiKf1GHbKOgxDwx0MYa8
         K8DOme4bv1jYQ5S8L7GzkiVvD9TvB6g7Rady1qTUQjrNqAPHSWV+g/gMrD0m0PiBhW1f
         xep/NrtdfpRGg9e1UnDhBN2AHmj2bv1PUMbpPE16BkYfFZ1fHKTEPlUiuovSDp9VHEgG
         FXRw==
X-Forwarded-Encrypted: i=1; AJvYcCULAQN6GlC/OF4eqk1hX3RzLCjhj/zeK3EUJ3I8ZjZYfY+vxh49hVb8lyC/Qjn/9oV8O7Yo1wJLgUU8mxv2u3d1cvKN3mOyyRpm
X-Gm-Message-State: AOJu0YxN2QxdEigfj+KNpsdhxrf2GEJUM7LNSChETqKFO+u2roF4Qzq/
	YRR89dsdIVnWt/L4slGpFIeqJ7bDPGuuW8QhrhigK6IHTu23ri+adrFGzh/gbQo=
X-Google-Smtp-Source: AGHT+IFXsJnSJU/aoEXOC+yNwsZ//mKJH3nNdWKrq+duj3XBkzFcLIjieh7WMKZqSCQMPoyrY6E43A==
X-Received: by 2002:adf:f50d:0:b0:33b:4649:a1e0 with SMTP id q13-20020adff50d000000b0033b4649a1e0mr1195842wro.15.1707998791423;
        Thu, 15 Feb 2024 04:06:31 -0800 (PST)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id x13-20020a5d54cd000000b0033cf5094fcesm1620967wrv.36.2024.02.15.04.06.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 04:06:31 -0800 (PST)
Date: Thu, 15 Feb 2024 12:06:29 +0000
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: lee@kernel.org, jingoohan1@gmail.com, deller@gmx.de, javierm@redhat.com,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-input@vger.kernel.org, linux-pwm@vger.kernel.org,
	Bruno =?iso-8859-1?Q?Pr=E9mont?= <bonbons@linux-vserver.org>
Subject: Re: [PATCH 04/10] hid/hid-picolcd: Remove struct
 backlight_ops.check_fb
Message-ID: <20240215120629.GH9758@aspen.lan>
References: <20240212162645.5661-1-tzimmermann@suse.de>
 <20240212162645.5661-5-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240212162645.5661-5-tzimmermann@suse.de>

On Mon, Feb 12, 2024 at 05:16:37PM +0100, Thomas Zimmermann wrote:
> The driver sets struct fb_info.bl_dev to the correct backlight
> device.

This looks like it was copied from a different patch since you
added code to do this as part of the patch!

> Thus rely on the backlight core code to match backlight
> and framebuffer devices, and remove the extra check_fb function
> from struct backlight_ops.
> <snip>
> diff --git a/drivers/hid/hid-picolcd_fb.c b/drivers/hid/hid-picolcd_fb.c
> index d7dddd99d325e..4500f6e03d32f 100644
> --- a/drivers/hid/hid-picolcd_fb.c
> +++ b/drivers/hid/hid-picolcd_fb.c
> @@ -493,6 +493,10 @@ int picolcd_init_framebuffer(struct picolcd_data *data)
>  	info->fix = picolcdfb_fix;
>  	info->fix.smem_len   = PICOLCDFB_SIZE*8;
>
> +#ifdef CONFIG_HID_PICOLCD_BACKLIGHT
> +	info->bl_dev = data->backlight;
> +#endif
> +
>  	fbdata = info->par;
>  	spin_lock_init(&fbdata->lock);
>  	fbdata->picolcd = data;


Daniel.

