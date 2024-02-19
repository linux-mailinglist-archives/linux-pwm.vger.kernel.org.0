Return-Path: <linux-pwm+bounces-1549-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 25A3E85A6C5
	for <lists+linux-pwm@lfdr.de>; Mon, 19 Feb 2024 16:02:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1FA94B207B6
	for <lists+linux-pwm@lfdr.de>; Mon, 19 Feb 2024 15:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 908943770C;
	Mon, 19 Feb 2024 15:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="onEMj+ii"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64941376EC;
	Mon, 19 Feb 2024 15:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708354935; cv=none; b=VnNAFEhOw4f/M9nJiHm8hhiPIKrzRnx7Y3aZsAJfmdMgpK7WfNUkfy9x9tNFZA3MFCjbATqEax4S3uDYAfCfOVTCoIslDN9k0twKdrYDkpy7GpfYDWOMovAem3iz8e9HU65a/e0C4Dx4fNJNu0GnD3t+7CMgJXhkhTQ6fzoxiYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708354935; c=relaxed/simple;
	bh=rLJTGIJL4PehKGlrZU7auEkJi81q+N3ek1Fb//6b2lU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RBRD9thT9UqcFB7Y8qrfY0ITJnO1p6BH13TWmh1mrYraUuByOJ1LAUYQGO4Wi7EvQ5zwut/u/Ib7wjVxmT5OMfN6li0U/x2EJjv2Zq2D0C1lPKvLUczQSa0U0kE5cMmLKg/aF9w/qUQ7aVV9nbGzNXVEcZYk3Z18Lht8g/SFbqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=onEMj+ii; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0611C433F1;
	Mon, 19 Feb 2024 15:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708354934;
	bh=rLJTGIJL4PehKGlrZU7auEkJi81q+N3ek1Fb//6b2lU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=onEMj+iiSDkatOTkAQmMp147ZZR5yupKFlcfK1mqOwtUu6bAHjeXimLFyOsoIEnot
	 dW1x3BaY8y6lJxZ2RcKU7dNy8BvgIKE+iEMuXhwN3fgS7hq5iYwBXMeJJtCpfIw6uj
	 /53G5OInSS5NmMpmaoPhSVRQNCVYb16Wk3DCBYzmj05L9eCHoe58+a5ZYAU9eHabTL
	 zhemj43OVZjL7J/CB1blxdEGsTH05gZCbRF0vIkg8e5p00ss0wZkSqCiIa0qXOEs+F
	 OUVWliCKfqWJGoxb1DwmCLspBGTZLwfI5+DNxy8cBFUVqu4oBlOuD0DCxci2MuIy7v
	 WlDM2s9I8pLGw==
Date: Mon, 19 Feb 2024 15:02:09 +0000
From: Lee Jones <lee@kernel.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Daniel Thompson <daniel.thompson@linaro.org>, jingoohan1@gmail.com,
	deller@gmx.de, javierm@redhat.com, dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org, linux-input@vger.kernel.org,
	linux-pwm@vger.kernel.org
Subject: Re: [PATCH 00/10] backlight: Replace struct fb_info in interfaces
Message-ID: <20240219150209.GB10170@google.com>
References: <20240212162645.5661-1-tzimmermann@suse.de>
 <20240215121326.GL9758@aspen.lan>
 <288a480c-74e9-49dd-a58d-294792771ea6@suse.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <288a480c-74e9-49dd-a58d-294792771ea6@suse.de>

On Thu, 15 Feb 2024, Thomas Zimmermann wrote:

> Hi
> 
> Am 15.02.24 um 13:13 schrieb Daniel Thompson:
> > On Mon, Feb 12, 2024 at 05:16:33PM +0100, Thomas Zimmermann wrote:
> > > Backlight drivers implement struct backlight_ops.check_fb, which
> > > uses struct fb_info in its interface. Replace the callback with one
> > > the does not use fb_info.
> > > 
> > > In DRM, we have several drivers that implement backlight support. By
> > > including <linux/backlight.h> these drivers depend on <linux/fb.h>.
> > > At the same time, fbdev is deprecated for new drivers and likely to
> > > be replaced on many systems.
> > > 
> > > This patchset is part of a larger effort to implement the backlight
> > > code without depending on fbdev.
> > > 
> > > Patch 1 makes the backlight core match backlight and framebuffer
> > > devices via struct fb_info.bl_dev. Patches 2 to 9 then go through
> > > drivers and remove unnecessary implementations of check_fb. Finally,
> > > patch 10 replaces the check_fb hook with controls_device, which
> > > uses the framebuffer's Linux device instead of the framebuffer.
> > I won't reply individually but I also took a look at the patches for
> > the combo devices and it all looked good to me from a backlight
> > point of view.
> > 
> > However I don't want to drop Reviewed-by: on them since it risks those
> > bit being mistaken for an ack and merged ahead of the patch 1...
> 
> Thanks for reviewing. Unless someone objects, my intention is to merge
> everything via the drm-misc, so all patches should go in at once. I do have
> a lot more patches that untangle backlight and fbdev almost completely, but
> most of these changes are in the actual graphics drivers rather than the
> backlight core code. So hopefully everything can go through the DRM tree; or
> maybe the fbdev tree.

This is only acceptable if the maintainers of those trees can provide me
with a pull-request to a succinct (_only_ these patches) immutable
branch.  If this is not possible, then I should like to merge the set
through the Backlight tree and I can provide everyone else with said PR.

-- 
Lee Jones [李琼斯]

