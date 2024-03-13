Return-Path: <linux-pwm+bounces-1752-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5253587A3DD
	for <lists+linux-pwm@lfdr.de>; Wed, 13 Mar 2024 09:03:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D85A283102
	for <lists+linux-pwm@lfdr.de>; Wed, 13 Mar 2024 08:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3850A171BF;
	Wed, 13 Mar 2024 08:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mGvEuauO"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CFC21AADF;
	Wed, 13 Mar 2024 08:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710317008; cv=none; b=CeG3ByI5qwdcGinPzINlmsBAyseE2c4b9mEq2+q5cTwXvu3rkNmxQdjeCwCw7QDbkjQbfCPdP3N+xsezmouiqY4PrzVvX5xMTJYeYjZ6dAoPOV97O+y/fyI/MgIi91lBTcqfACNh/pX5MU3cIdZmvzu3AJAaj6ZmHTitLNY+KIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710317008; c=relaxed/simple;
	bh=l0tGitGHLV1/9HpYMoRsuk1aHCzZMdgkRs83nroWmVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jg3JdHxOlyBDE+nDBKZetp/KjWfXG3n+g7CPcwVLlugdgDAkj9zvzpRp/aMEDdS5tYA49IAHBjlCZwE0v9iEANWDzuQ91JefCliR7rnUi964JrZetY6KFrF5vAEkFZKKhtWlmptzgRjTMnpieIs+CcMDn4+RZvgKo2RLO9z/7tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mGvEuauO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BA46C433F1;
	Wed, 13 Mar 2024 08:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710317007;
	bh=l0tGitGHLV1/9HpYMoRsuk1aHCzZMdgkRs83nroWmVg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mGvEuauOZjLA4AeWdQaZ+xmqo10WtmE5pwVpnPX0E/aJ2es93C2b/33NpdvX41Aqh
	 gmn2AcTYEcTBCbwGAS08SmV7apHF6Ia/fwgWiu2ZC7kQt/+za5mMddJl3353b9zc7/
	 ydJv/hB/0SJFpCfzLw44FqdT7MsMYvOcsdw4BBtzsylthkA1KFP6BHfRVXVNxmOjA7
	 sIhOceZC222dV5+vlAqoITB63IXiljpNJ7skvwjHL7HV1lbKha+Pgv0tKqyY8m6n3w
	 vQy8PYF3SfKvrWI/LT8SB6rnBwC09gx7SP8hLJQ0EJgMMr3FzSkTtTwsBIEIQFX3qn
	 tjoEKqVFkKZUw==
Date: Wed, 13 Mar 2024 08:03:21 +0000
From: Lee Jones <lee@kernel.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Thomas Zimmermann <tzimmermann@suse.de>, andy@kernel.org,
	daniel.thompson@linaro.org, jingoohan1@gmail.com, deller@gmx.de,
	robin@protonic.nl, javierm@redhat.com,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-input@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v4 00/10] backlight: Replace struct fb_info in interfaces
Message-ID: <20240313080321.GE1522089@google.com>
References: <20240305162425.23845-1-tzimmermann@suse.de>
 <heasef3pdfyj7xyngnvbg527pc5uyy2v6hatz4wr6q3sfkhw3h@f4lnresjcnmb>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <heasef3pdfyj7xyngnvbg527pc5uyy2v6hatz4wr6q3sfkhw3h@f4lnresjcnmb>

On Wed, 13 Mar 2024, Uwe Kleine-König wrote:

> Hello Thomas,
> 
> On Tue, Mar 05, 2024 at 05:22:33PM +0100, Thomas Zimmermann wrote:
> > Backlight drivers implement struct backlight_ops.check_fb, which
> > uses struct fb_info in its interface. Replace the callback with one
> > that does not use fb_info.
> > 
> > In DRM, we have several drivers that implement backlight support. By
> > including <linux/backlight.h> these drivers depend on <linux/fb.h>.
> > At the same time, fbdev is deprecated for new drivers and likely to
> > be replaced on many systems.
> > 
> > This patchset is part of a larger effort to implement the backlight
> > code without depending on fbdev.
> > 
> > Patch 1 makes the backlight core match backlight and framebuffer
> > devices via struct fb_info.bl_dev. Patches 2 to 9 then go through
> > drivers and remove unnecessary implementations of check_fb. Finally,
> > patch 10 replaces the check_fb hook with controls_device, which
> > uses the framebuffer's Linux device instead of the framebuffer.
> 
> I assume the merge plan for this series is via drm-misc in one go?

Backlight in one go.  This will be the second attempt at applying it.

-- 
Lee Jones [李琼斯]

