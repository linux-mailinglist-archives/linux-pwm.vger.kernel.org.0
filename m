Return-Path: <linux-pwm+bounces-1712-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C38871C4A
	for <lists+linux-pwm@lfdr.de>; Tue,  5 Mar 2024 11:54:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02E561C22D5E
	for <lists+linux-pwm@lfdr.de>; Tue,  5 Mar 2024 10:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E171764CC0;
	Tue,  5 Mar 2024 10:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ib32rDTh"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76A6633F1;
	Tue,  5 Mar 2024 10:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709635505; cv=none; b=ZNldbGOabh9l2l2YdhSmyVHdSqNvM27Pbck6WNpd2SnkO05a5fZXgvSM22iHMtH9UeuD0w6IwP7lHQlOGXP7IIoZ0sRQlR2byN0T1cHdAFB0TcAn+Y3Jmjo2AnYLGavtFnDUGedXT+kkK+uc80PDWIMtN6KrbqPDlj11MTAGfqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709635505; c=relaxed/simple;
	bh=8VjRaJlSO52iUgJuSPtyZYPQMgxH2rtz0BnF9RAJWh4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sYw8VEfswU3RP9VbjkkPB5hp+xczzvnVV/ng8gqrlc61Vzgk8LyiUujzObgqd4KUWhiY4AA7YloWPWO9yfTLzuB9rk9Vk26vbqGsiNQ30qx2GqrAHdMlKSHAPEMOvjnjhzkSZR39v68/1xQyJ0SqldyVlw40unRCCzz8gPf+s0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ib32rDTh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC4A1C433C7;
	Tue,  5 Mar 2024 10:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709635505;
	bh=8VjRaJlSO52iUgJuSPtyZYPQMgxH2rtz0BnF9RAJWh4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ib32rDTh4IJYYPZKnoiSk9MLqhEOKNsNr1vEYi4ugZ0s5BDM8Mht4heLcu0Udkxag
	 8v0nX4T7ukk8LMFRAhRQ8uqDx/xOQMPUzeSu60R3VdRhJXj4O1nzOR8eaFlbL96JFu
	 soCK+s47ucZI/XIqYtx+PY1I8b9MWsw3ywh3jfQzPQwrVWfkAyOWd7ozPyvoqOQ9yM
	 AbwvJ/0dBjchXuN1RaH6qMHcgF372gCrI9vBrJ8IhsR0g//jDRywFazfy74BqdAVD5
	 303nVglW7uUTyNujcbgQtlD1sEJ/4m7n7RG5j2qbbcbwFNhdVwxcL9msRwmNIq3Nlr
	 Hlyk7IKCnXt0w==
Date: Tue, 5 Mar 2024 10:44:59 +0000
From: Lee Jones <lee@kernel.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: andy@kernel.org, daniel.thompson@linaro.org, jingoohan1@gmail.com,
	deller@gmx.de, robin@protonic.nl, javierm@redhat.com,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-input@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v3 00/10] backlight: Replace struct fb_info in interfaces
Message-ID: <20240305104459.GA86322@google.com>
References: <20240304163220.19144-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240304163220.19144-1-tzimmermann@suse.de>

On Mon, 04 Mar 2024, Thomas Zimmermann wrote:

> Backlight drivers implement struct backlight_ops.check_fb, which
> uses struct fb_info in its interface. Replace the callback with one
> that does not use fb_info.
> 
> In DRM, we have several drivers that implement backlight support. By
> including <linux/backlight.h> these drivers depend on <linux/fb.h>.
> At the same time, fbdev is deprecated for new drivers and likely to
> be replaced on many systems.
> 
> This patchset is part of a larger effort to implement the backlight
> code without depending on fbdev.
> 
> Patch 1 makes the backlight core match backlight and framebuffer
> devices via struct fb_info.bl_dev. Patches 2 to 9 then go through
> drivers and remove unnecessary implementations of check_fb. Finally,
> patch 10 replaces the check_fb hook with controls_device, which
> uses the framebuffer's Linux device instead of the framebuffer.
> 
> v3:
> 	* hide CONFIG_FB_BACKLIGHT behind fb_bl_device() (Lee)
> 	* if-else cleanups (Andy)
> 	* fix commit message of patch 2 (Andy)
> v2:
> 	* fix hid-picolcd for CONFIG_FB_BACKLIGHT=n
> 	* fixes to commit messages
> 
> Thomas Zimmermann (10):
>   backlight: Match backlight device against struct fb_info.bl_dev
>   auxdisplay/ht16k33: Remove struct backlight_ops.check_fb
>   hid/hid-picolcd: Fix initialization order
>   hid/hid-picolcd: Remove struct backlight_ops.check_fb
>   backlight/aat2870-backlight: Remove struct backlight.check_fb
>   backlight/pwm-backlight: Remove struct backlight_ops.check_fb
>   fbdev/sh_mobile_lcdc_fb: Remove struct backlight_ops.check_fb
>   fbdev/ssd1307fb: Init backlight before registering framebuffer
>   fbdev/ssd1307fb: Remove struct backlight_ops.check_fb
>   backlight: Add controls_device callback to struct backlight_ops
> 
>  drivers/auxdisplay/ht16k33.c             |  8 ------
>  drivers/hid/hid-picolcd_backlight.c      |  7 ------
>  drivers/hid/hid-picolcd_core.c           | 14 +++++------
>  drivers/hid/hid-picolcd_fb.c             |  6 +++++
>  drivers/video/backlight/aat2870_bl.c     |  7 ------
>  drivers/video/backlight/backlight.c      |  8 ++++--
>  drivers/video/backlight/bd6107.c         | 12 ++++-----
>  drivers/video/backlight/gpio_backlight.c | 12 ++++-----
>  drivers/video/backlight/lv5207lp.c       | 12 ++++-----
>  drivers/video/backlight/pwm_bl.c         | 12 ---------
>  drivers/video/fbdev/core/fb_backlight.c  |  5 ++++
>  drivers/video/fbdev/sh_mobile_lcdcfb.c   |  7 ------
>  drivers/video/fbdev/ssd1307fb.c          | 31 +++++++++---------------
>  include/linux/backlight.h                | 16 ++++++------
>  include/linux/fb.h                       |  9 +++++++
>  include/linux/pwm_backlight.h            |  1 -
>  16 files changed, 70 insertions(+), 97 deletions(-)

All applied.  Submitted for build testing.

Will follow-up with a PR once that's passed.

-- 
Lee Jones [李琼斯]

