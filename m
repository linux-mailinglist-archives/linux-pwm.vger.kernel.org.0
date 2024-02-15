Return-Path: <linux-pwm+bounces-1524-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D22E38562CE
	for <lists+linux-pwm@lfdr.de>; Thu, 15 Feb 2024 13:13:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C9AB1F21814
	for <lists+linux-pwm@lfdr.de>; Thu, 15 Feb 2024 12:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B1F012C53E;
	Thu, 15 Feb 2024 12:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nEUn0ccd"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADBCA12BF1A
	for <linux-pwm@vger.kernel.org>; Thu, 15 Feb 2024 12:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707999211; cv=none; b=qyJ4wtYsfsrcBjGFsGlm6ZRtxxXeYtmjQl9MdcQ34ibKr5/rslx34rP/l09N448gZGVWjGtapRiOHh0/CMoQKqyIkCmpr7IaGvHTRFD2hwYlaaukM3JGiCVT504ZKXtuDnv8rUDP+K3YEuC9p5wVey6PyO0UlE7FwPMbb7Seu2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707999211; c=relaxed/simple;
	bh=ztKOJXZUQlmom6xQKGWtUiTuW3B1WQBrh5Kjye/DMFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S0Ym2OPUzbPWrLRzcKp6EatF7D34Qs55thj9VAFaNM4PsDC3nB+118xwZYpkIYKI2+uEa978mw3NKWsQdf7Lks1jQJKRtLJUPIdt9JPoH3Uz04KMRFf/RK+GYdvHfliVlIqGGPcpFmgwbLQ0oAarJyDPvsgdrE1Z7tN7vJYj2Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nEUn0ccd; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-33aeb088324so411673f8f.2
        for <linux-pwm@vger.kernel.org>; Thu, 15 Feb 2024 04:13:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707999208; x=1708604008; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ztKOJXZUQlmom6xQKGWtUiTuW3B1WQBrh5Kjye/DMFE=;
        b=nEUn0ccdqhB9A168PeeBvFIyn4yTU0Jzgaw8sq9Ps9/yNU7HPY7I0vq1N0M7phHVif
         Ooc6mJvwnR0ORt+LROrJt8MJNHK/bffEQTptI3GQIyMxTYpnB1UpJEgmPDqET5/T3VrM
         REDgR+tB3oN4Ha9pTZrV/J7m8xY+N1riD7sUfIvSToVS/ysyAVVA1DAj6SWSMtn+bBLC
         LYBZm4RFZh00nz9HCsY7nf6aMUNLJzMvAvnT9+/7AaZ6KtR/iK7w3vFC5EXNpQS9KvLl
         YXdo189Iw10t1aR+PF+5XANpDVaJk0TXBYtslSguBDSWhCOfK9QiQ+vHHLQRRgzKxmkr
         CsVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707999208; x=1708604008;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ztKOJXZUQlmom6xQKGWtUiTuW3B1WQBrh5Kjye/DMFE=;
        b=Fi935L/GtgWIV354nq+YEwiNb45qlWOi16s3a0Itet3oNkv0Bu9f4uZb3sRKo56jes
         vBq7za5H6V+kscj4+3Y4pXiQooWJrlnfk+pW+W/IEQOAi3KNyVS0eXLxg95gH3IVv2IM
         ZJRgmGpwo/s9bOHUxTW1mzOyI67KLFI12GG9HRyC4x2PjtfsnNUZqzfD97QC9MYrhWC4
         Ew9/wiYzbdmh8SJy14VOZX79RUPJJ3gN8FFcG32T66B8/oAGviMpVQhqwY0mernGOHgG
         NfUlt7RN27WeTWDaNSKsQv01uX3B310UaLplbBiwGGAgyPcIvnU/ajCGTr3HFtTlzrhm
         irvw==
X-Forwarded-Encrypted: i=1; AJvYcCWFkqOQWQfOT22bktdm+Welm0dgvlBbxRlPs0ejnwoMVxFlqOC/pkh+hm8RImCNdFr/YtTm0UQhFXwTZvXIwBXCbXWq0VSFa2LL
X-Gm-Message-State: AOJu0Yy0JsUtJaAgY40Bacwqcs8qCzEXh6w6oxkGqsP+yquLpR9m5/64
	YyAZquEEgRvi/KM3cNHH3KsOFsmCqpsuBA1kKDOf5EF6VRCg4kuM9viPbjzed8s=
X-Google-Smtp-Source: AGHT+IG3P5/6JWNhRAZMxDeU3U+UujVMo6057seoNpz5jKX5VhBBtJ3zIzJ42dclINgr2k0ttUEtXg==
X-Received: by 2002:adf:f489:0:b0:33b:49db:c719 with SMTP id l9-20020adff489000000b0033b49dbc719mr1501651wro.39.1707999208004;
        Thu, 15 Feb 2024 04:13:28 -0800 (PST)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id z3-20020a5d6543000000b0033b583ba5e0sm1591192wrv.92.2024.02.15.04.13.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 04:13:27 -0800 (PST)
Date: Thu, 15 Feb 2024 12:13:26 +0000
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: lee@kernel.org, jingoohan1@gmail.com, deller@gmx.de, javierm@redhat.com,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-input@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH 00/10] backlight: Replace struct fb_info in interfaces
Message-ID: <20240215121326.GL9758@aspen.lan>
References: <20240212162645.5661-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240212162645.5661-1-tzimmermann@suse.de>

On Mon, Feb 12, 2024 at 05:16:33PM +0100, Thomas Zimmermann wrote:
> Backlight drivers implement struct backlight_ops.check_fb, which
> uses struct fb_info in its interface. Replace the callback with one
> the does not use fb_info.
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

I won't reply individually but I also took a look at the patches for
the combo devices and it all looked good to me from a backlight
point of view.

However I don't want to drop Reviewed-by: on them since it risks those
bit being mistaken for an ack and merged ahead of the patch 1...


Daniel.

