Return-Path: <linux-pwm+bounces-1299-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7B50853199
	for <lists+linux-pwm@lfdr.de>; Tue, 13 Feb 2024 14:18:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB0AE1C22858
	for <lists+linux-pwm@lfdr.de>; Tue, 13 Feb 2024 13:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C1F555764;
	Tue, 13 Feb 2024 13:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonic.nl header.i=@protonic.nl header.b="SYASL+WP"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp28.bhosted.nl (smtp28.bhosted.nl [94.124.121.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078D45576A
	for <linux-pwm@vger.kernel.org>; Tue, 13 Feb 2024 13:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.124.121.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707830317; cv=none; b=f6WTB07VCimC/BZvJW3i4rRDNWigdirW6eQV+5mem0y3reivR97+X52AOc/1uiLicJQxh4oGWM6y+g9zaj1IksgwBGXEIwcRiMXnraR6TnY99YaH8rDkEdfvr5fa7ASNzUjlyalnJbBsN+c97SabdtkqCerbPzm2a8DhuoX60+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707830317; c=relaxed/simple;
	bh=g/CFTesJKrk4NlM0Wg2NNjSEoTPolXNO4mHWIBPE2DI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mAQnoqBTH2GSU4XgfttwFpRiIiqpO++j2QMBsIyBBbapqctGeAhhAWheVCdLyoWPldyy/ZQdY/6qjJOVi6iNJK6fdgMawnkJroS/P8+FBoLWAJQqAEziydJFFZzCH4zluCRiQl1wviah7zHAcOQ9sY7rezvvTggRY7Ls+BI12BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=protonic.nl; spf=pass smtp.mailfrom=protonic.nl; dkim=pass (2048-bit key) header.d=protonic.nl header.i=@protonic.nl header.b=SYASL+WP; arc=none smtp.client-ip=94.124.121.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=protonic.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonic.nl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=protonic.nl; s=202111;
	h=content-transfer-encoding:content-type:mime-version:references:in-reply-to:
	 message-id:subject:cc:to:from:date:from;
	bh=3SqP4dG1tq+TGDU5Zf/cjAiZPv2I7xysnRYtNRsJZg8=;
	b=SYASL+WPVjjWM85nIJ3YyBPVcxZkjRdNZbuZQmNeduW+QOqL+VHR7nSWt4euxWt92KyJwIZdZwWTq
	 eaeLYlwX22GWEYsdFAwVYuNXeDYH+ri2KQnfboya8D4QggmEqaz+nXX+bJH3LPIiL+AB8dk3DZ+CXg
	 QIVBtfApRikahNSjJ1+zSyk8OCHO11bL2jYbeqnEycYtKL/Iulq2kWdjazmHjRi2FSYxh62/zNCl/P
	 /ZnBHGu2tpcVF23ifZPzfuc/nCBG/zsuUM6kiJX5n/1hIlIidHY57q8q/WqXkUK6HD3x4qA0DjqEHk
	 dXd0zgDF37DvKGPmmYbQY78i+WHGjPw==
X-MSG-ID: 38c347f3-ca72-11ee-ba6d-0050568164d1
Date: Tue, 13 Feb 2024 14:17:21 +0100
From: Robin van der Gracht <robin@protonic.nl>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: lee@kernel.org, daniel.thompson@linaro.org, jingoohan1@gmail.com,
 deller@gmx.de, javierm@redhat.com, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, linux-input@vger.kernel.org,
 linux-pwm@vger.kernel.org
Subject: Re: [PATCH 02/10] auxdisplay/ht16k33: Remove struct
 backlight_ops.check_fb
Message-ID: <20240213141721.29eb6ce0@ERD993>
In-Reply-To: <20240212162645.5661-3-tzimmermann@suse.de>
References: <20240212162645.5661-1-tzimmermann@suse.de>
	<20240212162645.5661-3-tzimmermann@suse.de>
Organization: Protonic Holland
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 12 Feb 2024 17:16:35 +0100
Thomas Zimmermann <tzimmermann@suse.de> wrote:

> The driver sets struct fb_info.bl_dev to the correct backlight
> device. Thus rely on the backlight core code to match backlight
> and framebuffer devices, and remove the extra check_fb function
> from struct backlight_ops.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Robin van der Gracht <robin@protonic.nl>
> ---
>  drivers/auxdisplay/ht16k33.c | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/drivers/auxdisplay/ht16k33.c b/drivers/auxdisplay/ht16k33.c
> index a90430b7d07ba..0a858db32486b 100644
> --- a/drivers/auxdisplay/ht16k33.c
> +++ b/drivers/auxdisplay/ht16k33.c
> @@ -325,16 +325,8 @@ static int ht16k33_bl_update_status(struct backlight_device *bl)
>  	return ht16k33_brightness_set(priv, brightness);
>  }
>  
> -static int ht16k33_bl_check_fb(struct backlight_device *bl, struct fb_info *fi)
> -{
> -	struct ht16k33_priv *priv = bl_get_data(bl);
> -
> -	return (fi == NULL) || (fi->par == priv);
> -}
> -
>  static const struct backlight_ops ht16k33_bl_ops = {
>  	.update_status	= ht16k33_bl_update_status,
> -	.check_fb	= ht16k33_bl_check_fb,
>  };

When combined with the previous patch:
[01/10] backlight: Match backlight device against struct fb_info.bl_dev

(I wasn't in the CC)

Acked-By: Robin van der Gracht <robin@protonic.nl>



