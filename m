Return-Path: <linux-pwm+bounces-1708-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB9278719B1
	for <lists+linux-pwm@lfdr.de>; Tue,  5 Mar 2024 10:36:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCF2F1C20B38
	for <lists+linux-pwm@lfdr.de>; Tue,  5 Mar 2024 09:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DABE52F6B;
	Tue,  5 Mar 2024 09:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ctFC1+e5"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A024CB58;
	Tue,  5 Mar 2024 09:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709631398; cv=none; b=KXL0L1+jXYD18Mx1VgafL2cKZVSAgmaT1wfiWc4vsGAgvjAFbtl013u9usNS+HJkKlkT3U7dDTNlQllrnvDxe6/BrseQjSTyCv6M2wCxq8zztxJgS8xDBPqyMZDnC1AKIXhcmtBhj2kKtvFpnw9btdW7B6f1ub9DiZL0QTVatuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709631398; c=relaxed/simple;
	bh=JKisc/w7E/vIUGFzAVoD8hmtzh/whmZyLQbF+nWTv28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cs1xn6nm5OC635YIF2wPzHdJbwXBkshLcJati2hLoghYpX6a8N7Y//WPiwOmxImy+51MOS1fnZtGKwSkpJH6S0jWXefmH5tK+ty3QRSyq+PnOefx8lXveffUQc7wx0WMcosNydTc6tsotUuv5sWA8AFsWXR8E3LcGdQtl8NPzAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ctFC1+e5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D3AEC433C7;
	Tue,  5 Mar 2024 09:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709631398;
	bh=JKisc/w7E/vIUGFzAVoD8hmtzh/whmZyLQbF+nWTv28=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ctFC1+e57EJzmEJCTPoP2Sfaf0angHBcyEZKKw6ystDKWE8QEPHEc6bL6Vpqn+mnq
	 gARAdiIOzUgtiofzooCA+CRmgNzaiK32ztiiS80MTdzjFLwwIPi+MnPmF4CnvtNxnX
	 0MkEbSAi1hR/rrnVBWf59vrHyeZWqOlJ/+nCjFQxY+a47IJnT62SgmG9gXCNkVZXVr
	 duU/HPc3UXrnASo35ixGQ6JRzS/nDUrQr6o/xi/fYlHDXL7SnJQ5E3aB+98Ssr3hH1
	 y5uY8jVnpxHQ6MhuwM0n/wKTYOzAvsgixfSdh7WtOWY/wgO2wE+CiDNeiXLM1GhmZn
	 uXkUsv6b0c3gA==
Date: Tue, 5 Mar 2024 09:36:32 +0000
From: Lee Jones <lee@kernel.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: andy@kernel.org, daniel.thompson@linaro.org, jingoohan1@gmail.com,
	deller@gmx.de, robin@protonic.nl, javierm@redhat.com,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-input@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v3 00/10] backlight: Replace struct fb_info in interfaces
Message-ID: <20240305093632.GC5206@google.com>
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

Which Acks are you missing for us to merge this?

-- 
Lee Jones [李琼斯]

