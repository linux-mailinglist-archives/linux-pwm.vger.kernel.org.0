Return-Path: <linux-pwm+bounces-1809-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F5AA88680E
	for <lists+linux-pwm@lfdr.de>; Fri, 22 Mar 2024 09:16:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0B521F2533C
	for <lists+linux-pwm@lfdr.de>; Fri, 22 Mar 2024 08:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4A32168CD;
	Fri, 22 Mar 2024 08:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pdWUkciI"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4856168A9;
	Fri, 22 Mar 2024 08:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711095391; cv=none; b=ggl9IjFT1nQd6R9Yk+HsV1NWgI+2cMaGK7mtZu90sQSn+gPBeKNyjNnvISe7Cw/RYdu8mPbzkHN0p/72wAZgcQ2/JEaqtxAmvJG8wqEfdyEbi/oAKRpuRirtaL4gxi8Gh0eO1S9m5mRVRzlCsNGijbCs20hBm9QPCDwJTrqHrR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711095391; c=relaxed/simple;
	bh=78e84KjAWSryCmLw73e2JyPKfWstRQ6SUGWADdV5MAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GoKArnpvglwaIm4fPVQ7/CTXVGnA2L5Grra/yPM3gTl/duwNmziBapFDR+myi6jXFZReI5wzmuLI0T9HM9O5wfnyab4JO+N1QmUsQv2YuJKZEID7R743pCMh4AUD2MbRF6eW1lwltjE8MvczULylaJ5Uid2LIb9ZpocECu48854=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pdWUkciI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D9CCC433F1;
	Fri, 22 Mar 2024 08:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711095390;
	bh=78e84KjAWSryCmLw73e2JyPKfWstRQ6SUGWADdV5MAo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pdWUkciI1p6OLe7Mp+iUUUkevTieQn7eyS3YHgIIgT29n/AUCtVaV+k3ToslsobLD
	 lArtEjjMUZxjohcYrlq9gO56WY3BqCAjKewuAlOdOcZOX03agHSPh2BogaSFjvipuC
	 +whc6ZZT8m2UIH0EXapTRZPPKyo1/LnDjofMwLPneA5XidcN3nV0FhbFu3vEZ06Ed3
	 6zrwBFzERX/CGcGElK8A0aVPjvGignBrRL46+7bh/T0SnLmXDshmUXNTbyLaT+VR+U
	 i7dmG5Y44ciYvgfW1R3EZQXguHUN5VgNbV/YyogWtkQ5G3Nd3Z1mTjq5HAjrQQz5DW
	 rEwtYnZcPA7xA==
Date: Fri, 22 Mar 2024 08:16:25 +0000
From: Lee Jones <lee@kernel.org>
To: andy@kernel.org, daniel.thompson@linaro.org, jingoohan1@gmail.com,
	deller@gmx.de, robin@protonic.nl, javierm@redhat.com,
	Thomas Zimmermann <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-input@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v4 00/10] backlight: Replace struct fb_info in interfaces
Message-ID: <20240322081625.GM13211@google.com>
References: <20240305162425.23845-1-tzimmermann@suse.de>
 <171103756721.89062.17090257592751026195.b4-ty@kernel.org>
 <20240321161358.GB13211@google.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240321161358.GB13211@google.com>

On Thu, 21 Mar 2024, Lee Jones wrote:

> On Thu, 21 Mar 2024, Lee Jones wrote:
> 
> > On Tue, 05 Mar 2024 17:22:33 +0100, Thomas Zimmermann wrote:
> > > Backlight drivers implement struct backlight_ops.check_fb, which
> > > uses struct fb_info in its interface. Replace the callback with one
> > > that does not use fb_info.
> > > 
> > > In DRM, we have several drivers that implement backlight support. By
> > > including <linux/backlight.h> these drivers depend on <linux/fb.h>.
> > > At the same time, fbdev is deprecated for new drivers and likely to
> > > be replaced on many systems.
> > > 
> > > [...]
> > 
> > Applied, thanks!
> > 
> > [01/10] backlight: Match backlight device against struct fb_info.bl_dev
> >         commit: f1ecddf747f0d734682152b37c927aa958a51497
> > [02/10] auxdisplay/ht16k33: Remove struct backlight_ops.check_fb
> >         commit: dddfda7d5f12a7b48aeca6c3840167529c8cd34a
> > [03/10] hid/hid-picolcd: Fix initialization order
> >         commit: a951a15002da620871d8f3d8218c043cdc4c2471
> > [04/10] hid/hid-picolcd: Remove struct backlight_ops.check_fb
> >         commit: b3c52552f8d8a816bda2bda984411c73f4dd0b87
> > [05/10] backlight/aat2870-backlight: Remove struct backlight.check_fb
> >         commit: 0e03c96046405281fb072c05a7810d2661a2f334
> > [06/10] backlight/pwm-backlight: Remove struct backlight_ops.check_fb
> >         commit: 78534967e7cb3c2fbfcb2d37820b51a80c570f90
> > [07/10] fbdev/sh_mobile_lcdc_fb: Remove struct backlight_ops.check_fb
> >         commit: b853c08cd6598b3b3ff91cb2bba336bfef9c0ac4
> > [08/10] fbdev/ssd1307fb: Init backlight before registering framebuffer
> >         commit: d5ae81e965953da27cf46db6281d6a6a28eaaccb
> > [09/10] fbdev/ssd1307fb: Remove struct backlight_ops.check_fb
> >         commit: ec5925ef4a2dfd7ee060f4fd2a2e8036f8a94e8e
> > [10/10] backlight: Add controls_device callback to struct backlight_ops
> >         commit: 2e427743de015c1ac047036ef495c3f004105439
> 
> Okay, let's try this again.
> 
> Send off for more build testing based on v6.8.
> 
> Will report back once complete.

So far, so good.

Will rebase these and sent out an immutable branch PR once v6.9-rc1 is out.

Note to self: ib-backlight-auxdisplay-hid-fb-6.9

-- 
Lee Jones [李琼斯]

