Return-Path: <linux-pwm+bounces-1618-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41CE2860FD9
	for <lists+linux-pwm@lfdr.de>; Fri, 23 Feb 2024 11:53:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D24CB1F21237
	for <lists+linux-pwm@lfdr.de>; Fri, 23 Feb 2024 10:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 062F0604AF;
	Fri, 23 Feb 2024 10:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="asVzxH/4"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBFE81428B;
	Fri, 23 Feb 2024 10:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708685630; cv=none; b=IBVNQzdx1NIaGAMpViC7G/1xRjmX9jAruCkamckCXs/021QT4mo3bPUpOQjb6/ls2mXTKEtHADqUSl859OBMJWbDHLQSS9+LOQ1Lkl6mkpl9I9IbD9SV0R464SaL5IdCShgJ8SYPA5GgugWaxvuOAWJ+4x2LiACjoxHMuyCjeXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708685630; c=relaxed/simple;
	bh=2HhxQDG0pdqR6ubl6Be6PMVKag9x1iu7wWGmuYxToWs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l1u6fNVgp491f0KKiYIxeN9d9Lk1G6v3x1pyz175M/xad+NilSdSA+KNrrB6nG+doeAN6T5kFMB4OKFKWP4BzvudEhpDDl4IxLDyoWVPawk6qinnim+wsekkJPiXhBeSY3GYXnesr6P3hcJgHenf6n57wIr8Y+Mz6qAK5FoNtwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=asVzxH/4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B544C433C7;
	Fri, 23 Feb 2024 10:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708685630;
	bh=2HhxQDG0pdqR6ubl6Be6PMVKag9x1iu7wWGmuYxToWs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=asVzxH/4vCF1ZFdPsyIBQrGcT3tEF9Opv5l0Jjz3DQ+pja6oLJAloDSFaJ5zEACDf
	 DJPVKnmj+4o4hmbDuTe0tbxR9wO6vD33QZKYp+dFr04v8kpxYLPn917xLU/QSUQ65i
	 9BIcQ3Kqfc5SC7xw1w5uLhdoUO+U7Arkvfl4nJvsBlVQRr3vKLldDcqjsj86CCo7rs
	 cqdcoqugHEYXnp3Zer4JW2whuEINRHdBZsaJd49bbV+voU0vUdqyoG4oTotKCf8hPv
	 r0FxZb2inolr8Qwj0nNVl0FWfXiWYqLbxeSbyAXPMsYR8K037/2qDlt1iG1YBBq6/2
	 iBNmDsWv0UrnQ==
Date: Fri, 23 Feb 2024 10:53:45 +0000
From: Lee Jones <lee@kernel.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: daniel.thompson@linaro.org, jingoohan1@gmail.com, deller@gmx.de,
	andy@kernel.org, robin@protonic.nl, javierm@redhat.com,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-input@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v2 01/10] backlight: Match backlight device against
 struct fb_info.bl_dev
Message-ID: <20240223105345.GS10170@google.com>
References: <20240221094324.27436-1-tzimmermann@suse.de>
 <20240221094324.27436-2-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240221094324.27436-2-tzimmermann@suse.de>

On Wed, 21 Feb 2024, Thomas Zimmermann wrote:

> Framebuffer drivers for devices with dedicated backlight are supposed
> to set struct fb_info.bl_dev to the backlight's respective device. Use
> the value to match backlight and framebuffer in the backlight core code.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
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

I don't want #ifery in C files.

Please find another way.

> +	else if (info->bl_dev && info->bl_dev != bd)
> +		goto out;
> +#endif
>  
>  	fb_blank = *(int *)evdata->data;
>  	if (fb_blank == FB_BLANK_UNBLANK && !bd->fb_bl_on[node]) {
> -- 
> 2.43.0
> 

-- 
Lee Jones [李琼斯]

