Return-Path: <linux-pwm+bounces-1808-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81C04885D26
	for <lists+linux-pwm@lfdr.de>; Thu, 21 Mar 2024 17:14:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F8502832E6
	for <lists+linux-pwm@lfdr.de>; Thu, 21 Mar 2024 16:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A50A12C534;
	Thu, 21 Mar 2024 16:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="orvLW/Z5"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C69E12C52E;
	Thu, 21 Mar 2024 16:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711037644; cv=none; b=b3r8apnZvsqtvLOpfhSuXAeCboFzczKVxbuSJLFYZO+ds1XNzFJdswDjTA55nemngS6gQ8tGmMqmLSv9rrnIVRjtUjPphrHraUih9slRm0qt10ABpC1pwJCiHXzqiwnSFx8rUFrmp4gEzSxj2gYGzIu5WIMN6kdJ1lsY1lXdMDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711037644; c=relaxed/simple;
	bh=qMsQ50acyokaCuiaWDcok6esKfsQI6FWYHbKO155u2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o6BIEiWw6+ocsbOgPSOPxpHak+BLFq0Mex+qTawBlEPUgeWx5w8KV5s/k8ivbv9tLfpNRYKANDCAkxLZD729jNLIh1HXJnLCcI6DCWGB3XmoKOAkwhjACMzag8W/hKn1JSuKWJChUBjkprki/2pQhy3sssBOvygh8joltNNtH2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=orvLW/Z5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7840BC433F1;
	Thu, 21 Mar 2024 16:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711037643;
	bh=qMsQ50acyokaCuiaWDcok6esKfsQI6FWYHbKO155u2U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=orvLW/Z5D/H4hLwxMkQXtw4LkIcKymFLQ19BApf/xaJ2fGINLTNfXrFzE90yAyYb4
	 Lm801x4CJ9ZSssnx71CHR01WMhuHEeMjnawKZoN9fFajCNzoQT58p2sEc5AOEQGjzW
	 D+8iUcIg4Fid6/4N4QuzSKFMLef9ibWbZzFQv+3/RrlCdE7FXlfQeR8Xp+zPmPFXtH
	 iwLEkTDFEYu9iIpx4X0ILy4iQPvq2BFd4tyo8pNOJbgOwKeIGd+8k0TzkrNFX58gId
	 otyoYJKtQsr12r+SQIxGk7Ydp8U4Xblg3tWVI243uF40NXPzLoi5ZD7EfM5uBrRAM7
	 VMHGu4dc2TwRw==
Date: Thu, 21 Mar 2024 16:13:58 +0000
From: Lee Jones <lee@kernel.org>
To: andy@kernel.org, daniel.thompson@linaro.org, jingoohan1@gmail.com,
	deller@gmx.de, robin@protonic.nl, javierm@redhat.com,
	Thomas Zimmermann <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-input@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v4 00/10] backlight: Replace struct fb_info in interfaces
Message-ID: <20240321161358.GB13211@google.com>
References: <20240305162425.23845-1-tzimmermann@suse.de>
 <171103756721.89062.17090257592751026195.b4-ty@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <171103756721.89062.17090257592751026195.b4-ty@kernel.org>

On Thu, 21 Mar 2024, Lee Jones wrote:

> On Tue, 05 Mar 2024 17:22:33 +0100, Thomas Zimmermann wrote:
> > Backlight drivers implement struct backlight_ops.check_fb, which
> > uses struct fb_info in its interface. Replace the callback with one
> > that does not use fb_info.
> > 
> > In DRM, we have several drivers that implement backlight support. By
> > including <linux/backlight.h> these drivers depend on <linux/fb.h>.
> > At the same time, fbdev is deprecated for new drivers and likely to
> > be replaced on many systems.
> > 
> > [...]
> 
> Applied, thanks!
> 
> [01/10] backlight: Match backlight device against struct fb_info.bl_dev
>         commit: f1ecddf747f0d734682152b37c927aa958a51497
> [02/10] auxdisplay/ht16k33: Remove struct backlight_ops.check_fb
>         commit: dddfda7d5f12a7b48aeca6c3840167529c8cd34a
> [03/10] hid/hid-picolcd: Fix initialization order
>         commit: a951a15002da620871d8f3d8218c043cdc4c2471
> [04/10] hid/hid-picolcd: Remove struct backlight_ops.check_fb
>         commit: b3c52552f8d8a816bda2bda984411c73f4dd0b87
> [05/10] backlight/aat2870-backlight: Remove struct backlight.check_fb
>         commit: 0e03c96046405281fb072c05a7810d2661a2f334
> [06/10] backlight/pwm-backlight: Remove struct backlight_ops.check_fb
>         commit: 78534967e7cb3c2fbfcb2d37820b51a80c570f90
> [07/10] fbdev/sh_mobile_lcdc_fb: Remove struct backlight_ops.check_fb
>         commit: b853c08cd6598b3b3ff91cb2bba336bfef9c0ac4
> [08/10] fbdev/ssd1307fb: Init backlight before registering framebuffer
>         commit: d5ae81e965953da27cf46db6281d6a6a28eaaccb
> [09/10] fbdev/ssd1307fb: Remove struct backlight_ops.check_fb
>         commit: ec5925ef4a2dfd7ee060f4fd2a2e8036f8a94e8e
> [10/10] backlight: Add controls_device callback to struct backlight_ops
>         commit: 2e427743de015c1ac047036ef495c3f004105439

Okay, let's try this again.

Send off for more build testing based on v6.8.

Will report back once complete.

-- 
Lee Jones [李琼斯]

