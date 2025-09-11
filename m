Return-Path: <linux-pwm+bounces-7293-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81D84B52B7B
	for <lists+linux-pwm@lfdr.de>; Thu, 11 Sep 2025 10:21:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9FF31B26D5B
	for <lists+linux-pwm@lfdr.de>; Thu, 11 Sep 2025 08:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA8B92DECBA;
	Thu, 11 Sep 2025 08:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bxkIKVq1"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832332DCF72;
	Thu, 11 Sep 2025 08:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757578912; cv=none; b=sYOdTMFZsiBQsDx+7e2AJbKEXACrx9PdorYKNzSC8F+NzFmANgH38kco7aEYHpxFlQ5NpDuvoW+GKVHWWIBDkf7r0cAqodAJlwctnj09AJ+cOirmjgHBTll0xJO0yydP1ZN1wKHGLIO3yIa61HhFzS3mvDQQd2VhTvTNsQzR7IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757578912; c=relaxed/simple;
	bh=HjGv5e8J09LIWOPPU09kKH6Zwo3LDbgwb9s+ej/NZaw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u+B8cPyd3mGsiCl+m6b3vRgWhQEXn1sDsQ1aDgkVXcn1Hpc/8oRe7w+mpks5zRV6lTRGWaIXTc1r/CQx9xfNVlxSYICxTdm5JlrESUja1+idIkM9IXNEK0NvW+A9B/h5jyp9VL7aRwUPj0B7PvMXNiFm4ZPSLEtewKYbM4zulqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bxkIKVq1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EF07C4CEF1;
	Thu, 11 Sep 2025 08:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757578912;
	bh=HjGv5e8J09LIWOPPU09kKH6Zwo3LDbgwb9s+ej/NZaw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bxkIKVq1HzbqhrWH8kOhXRJrgPCiixe9B1xVhexbh4XIJPUyiyiDnRg/dR6QCoiZF
	 QeuBlZXkE3EuDdls9lv8rb7m5dZZpMoOjvzvSuA+rTrCc4rGZwfAGIoN0yKLFz1073
	 mulxlTEeusgLYSQ+KsgCGAgBtz6Owp0OQg+JC/Ruq5YoOS/kSDNFEzQexLW5GQwlr4
	 6zJ8bo2PDqTdlndzDQze1kRRdQJppnWxWa1i4UWPnGkr9pd96IhHiImK1moL192xRw
	 zCXf6Q+41544pZR1yPiIQ+f5o6BfdcoiIWmBZ9XnKs21Yuqyc8vG5K4Li62rRBTCF5
	 FJg9GPAPYovqw==
Date: Thu, 11 Sep 2025 09:21:47 +0100
From: Lee Jones <lee@kernel.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: Flavio Suligoi <f.suligoi@asem.it>,
	Daniel Thompson <danielt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-pwm@vger.kernel.org
Subject: Re: [PATCH 0/2] backlight: mp3309c: Drop pwm_apply_args()
Message-ID: <20250911082147.GE9224@google.com>
References: <cover.1751361465.git.u.kleine-koenig@baylibre.com>
 <175680932706.2261091.9987211835426797993.b4-ty@kernel.org>
 <zkqqw2jxtx7mhwbck5jr5kgdg5ze5bk65aqarpdzl2ieh2hdj5@fnm5lybd227v>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <zkqqw2jxtx7mhwbck5jr5kgdg5ze5bk65aqarpdzl2ieh2hdj5@fnm5lybd227v>

On Tue, 09 Sep 2025, Uwe Kleine-König wrote:

> Hello Lee,
> 
> On Tue, Sep 02, 2025 at 11:35:27AM +0100, Lee Jones wrote:
> > On Tue, 01 Jul 2025 11:22:35 +0200, Uwe Kleine-König wrote:
> > > the first patch of this series is what I really care about: There are
> > > hardly any drivers left that use pwm_apply_args(). When all of them are
> > > converted to not use it any more, I intend to drop that function.
> > > 
> > > The 2nd patch is just a change that I noticed while editing the driver
> > > that is IMHO nice. If you don't agree and only apply the first patch, I
> > > won't argue. It's an alternative approach to what Daniel Thompson did in
> > > commit 7ee6478d5aa9 ("backlight: mp3309c: Fully initialize
> > > backlight_properties during probe").
> > > 
> > > [...]
> > 
> > Applied, thanks!
> > 
> > [1/2] backlight: mp3309c: Drop pwm_apply_args()
> >       commit: d22caa15de3a11b503157aec079cad4bf305ff47
> > [2/2] backlight: mp3309c: Initialize backlight properties without memset
> >       commit: 71ca0594c11b4030c6dece9ba9b080d652a82473
> 
> I would expect to see these commits in your repo at
> https://git.kernel.org/pub/scm/linux/kernel/git/lee/backlight.git, but
> the exact commits don't exist there and if the patches are included
> under a different commit-id it's not obvious to me in which branch. Did
> you forget to push?

Yes.  Now pushed.  Sorry for the delay.

-- 
Lee Jones [李琼斯]

