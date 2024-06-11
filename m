Return-Path: <linux-pwm+bounces-2431-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A35179042FA
	for <lists+linux-pwm@lfdr.de>; Tue, 11 Jun 2024 19:59:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D0EC28A087
	for <lists+linux-pwm@lfdr.de>; Tue, 11 Jun 2024 17:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CCB16EB58;
	Tue, 11 Jun 2024 17:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="MGUJ9Lse";
	dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="gUDBqNT9"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mailrelay4-1.pub.mailoutpod3-cph3.one.com (mailrelay4-1.pub.mailoutpod3-cph3.one.com [46.30.211.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9C55C8EF
	for <linux-pwm@vger.kernel.org>; Tue, 11 Jun 2024 17:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.30.211.243
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718128617; cv=none; b=mwM5DkOfk2AWoA3WWTkM2rkI5XEuzewLVAn4NmhWH6Knv+5MFztVCbUzqG77HlC2SEkwGPtezDvo7kaF+nyB54t1XdC/C18y1SnfLyINzSt91QkAXU5PGy1enlUDkKxpATomifdTfsjpWGuEMTQ2pY60H828JZYtLk/yPGgyOQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718128617; c=relaxed/simple;
	bh=m4UNf0dPubO+Nhq/aKH7BVJeY8wPAsx8wTcxb5/fl8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kdqQr9GTfZL4cZHSPiJU2P8z+mRP+CPeP2lC8Ql+QpnuJvmwKhMRjcb8fNAJZSVOXjQ+VcI1RdvtIUyVTpu64fGa5xoiaedDloB6RlzsvyWMH9821wZnIvyArFCG5mzFKJBhe/cXuRqnYV+7vVdh++S75Zrb6nubDDeRSzfA72c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org; spf=none smtp.mailfrom=ravnborg.org; dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b=MGUJ9Lse; dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b=gUDBqNT9; arc=none smtp.client-ip=46.30.211.243
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ravnborg.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ravnborg.org; s=rsa1;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
	 from:date:from;
	bh=g9WKV73/vX/yRKi/hglFtmBSXNmDuF7jx1LSMWu23v8=;
	b=MGUJ9LseT3f5lZBW0OKxinuyoP4Ccabuc75xhvpP21vgQEyTqiVTs4Fg1RT9IdF8tTLhJBJKs53DG
	 aD3n4oKlEvWVRlRYDi10iHhL7J1lFyvbR4vIoTIomca43ATnqv+Z/NCR92hPtsikZKhlO8ItWGgxg1
	 4YuvdjlA2N/E6Zg3k2emqVqcNu4RNvyBYvCI3W1WOKotRcB1YpG2MWaZ4xvwTtOVOGaN8E/WwfzlwA
	 gOZOSciUXJNWLRHPt6oxwzcjCfkZShwRyr4YoMkmmM+sC+Yp0OfmoH7PYdlMPo9+qPG06FIdr81BjM
	 FdbLkkUDCMyp0E5urejZivADmsWGsSQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
	d=ravnborg.org; s=ed1;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
	 from:date:from;
	bh=g9WKV73/vX/yRKi/hglFtmBSXNmDuF7jx1LSMWu23v8=;
	b=gUDBqNT9P/28PpP+1HZVetLC/b5nS0VWr4onj3XTH81Z/oW76YeBdXPCjeM+olZqxVc/T6ZDdKKNy
	 aYJ+AdoAg==
X-HalOne-ID: d271771c-281b-11ef-802b-591fce59e039
Received: from ravnborg.org (2-105-16-150-cable.dk.customer.tdc.net [2.105.16.150])
	by mailrelay4.pub.mailoutpod3-cph3.one.com (Halon) with ESMTPSA
	id d271771c-281b-11ef-802b-591fce59e039;
	Tue, 11 Jun 2024 17:55:45 +0000 (UTC)
Date: Tue, 11 Jun 2024 19:55:44 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: lee@kernel.org, daniel.thompson@linaro.org, jingoohan1@gmail.com,
	deller@gmx.de, linus.walleij@linaro.org, f.suligoi@asem.it,
	ukleinek@kernel.org, dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH 01/17] backlight: Add BL_CORE_ constants for power states
Message-ID: <20240611175544.GC545417@ravnborg.org>
References: <20240611125321.6927-1-tzimmermann@suse.de>
 <20240611125321.6927-2-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240611125321.6927-2-tzimmermann@suse.de>

Hi Thomas.

On Tue, Jun 11, 2024 at 02:41:56PM +0200, Thomas Zimmermann wrote:
> Duplicate FB_BLANK_ constants as BL_CORE_ constants in the backlight
> header file. Allows backlight drivers to avoid including the fbdev
> header file and removes a compile-time dependency between the two
> subsystems.
Good to remove this dependency.
> 
> The new BL_CORE constants have the same values as their FB_BLANK_
> counterparts. Hence UAPI and internal semantics do not change. The
> backlight drivers can be converted one by one.
This seems like the right approach.

> 
> Backlight code or drivers do not use FB_BLANK_VSYNC_SUSPEND and
> FB_BLANK_HSYNC_SUSPEND, so no new constants for these are being
> added.
> 
> The semantics of FB_BLANK_NORMAL appear inconsistent. In fbdev,
> NORMAL means display off with sync enabled. In backlight code,
> this translates to turn the backlight off, but some drivers
> interpret it as backlight on. So we keep the current code as is,
> but mark BL_CORE_NORMAL as deprecated. Drivers should be fixed
> and the constant removed. This affects ams369fg06 and a few DRM
> panel drivers.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>  Documentation/ABI/stable/sysfs-class-backlight |  7 ++++---
>  include/linux/backlight.h                      | 16 ++++++++++------
>  2 files changed, 14 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/ABI/stable/sysfs-class-backlight b/Documentation/ABI/stable/sysfs-class-backlight
> index 023fb52645f8b..6102d6bebdf9a 100644
> --- a/Documentation/ABI/stable/sysfs-class-backlight
> +++ b/Documentation/ABI/stable/sysfs-class-backlight
> @@ -3,10 +3,11 @@ Date:		April 2005
>  KernelVersion:	2.6.12
>  Contact:	Richard Purdie <rpurdie@rpsys.net>
>  Description:
> -		Control BACKLIGHT power, values are FB_BLANK_* from fb.h
> +		Control BACKLIGHT power, values are compatible with
> +		FB_BLANK_* from fb.h
>  
> -		 - FB_BLANK_UNBLANK (0)   : power on.
> -		 - FB_BLANK_POWERDOWN (4) : power off
> +		 - 0 (FB_BLANK_UNBLANK)   : power on.
> +		 - 4 (FB_BLANK_POWERDOWN) : power off
>  Users:		HAL
>  
>  What:		/sys/class/backlight/<backlight>/brightness
> diff --git a/include/linux/backlight.h b/include/linux/backlight.h
> index 19a1c0e22629d..e0cfd89ffadd2 100644
> --- a/include/linux/backlight.h
> +++ b/include/linux/backlight.h
> @@ -210,14 +210,18 @@ struct backlight_properties {
>  	 * When the power property is updated update_status() is called.
>  	 *
>  	 * The possible values are: (0: full on, 1 to 3: power saving
> -	 * modes; 4: full off), see FB_BLANK_XXX.
> +	 * modes; 4: full off), see BL_CORE_XXX constants.
>  	 *
>  	 * When the backlight device is enabled @power is set
> -	 * to FB_BLANK_UNBLANK. When the backlight device is disabled
> -	 * @power is set to FB_BLANK_POWERDOWN.
> +	 * to BL_CORE_UNBLANK. When the backlight device is disabled
> +	 * @power is set to BL_CORE_POWERDOWN.
>  	 */
>  	int power;
>  
> +#define BL_CORE_UNBLANK		(0)
> +#define BL_CORE_NORMAL		(1) // deprecated; don't use in new code
> +#define BL_CORE_POWERDOWN	(4)

When introducing backlight specific constants then it would be good to
get away from the ackward fbdev naming and use something that is more
obvious.

Something like:

#define BACKLIGHT_POWER_ON	0
#define BACKLIGHT_POWER_OFF	4
#define BACKLIGHT_POWER_NORMAL	1	// deprecated; don't use in new code

This will make the code more obvious to read / understand - at least
IMO.

The proposal did not use the BL_CORE_ naming, lets keep this for
suspend/resume stuff.

On top of this - many users of the power states could benefit using the
backlight_enable()/backlight_disable() helpers, but that's another story.

	Sam

