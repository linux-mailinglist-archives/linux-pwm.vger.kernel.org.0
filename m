Return-Path: <linux-pwm+bounces-1824-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D61DE88E84B
	for <lists+linux-pwm@lfdr.de>; Wed, 27 Mar 2024 16:17:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03566B26C82
	for <lists+linux-pwm@lfdr.de>; Wed, 27 Mar 2024 15:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B07AB13048A;
	Wed, 27 Mar 2024 14:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G/+zYEUO"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8770112FF95;
	Wed, 27 Mar 2024 14:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711550858; cv=none; b=icXBIyEU5RMvjuDRMzOAov5ezQ7SG6STCLEycyngR2b7VpqHQQ7ab34p6lFuQDhvtSgcL0bNXLup3JobSZsDPHjwXaGgbLBQZcjKg3jdUVee34QoVSVt9IoaZxWvHQXd/tqLoQBT/GbVSOzur5qLLfHeRKCzNk+w4EYYsVI+hLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711550858; c=relaxed/simple;
	bh=wdtVqbVIEGdHY/OZHy307yQ0kmARv1BuTL6ACiPT0Xg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XqJFMmM/Att++AXI+lsszS1qkmN0SKKSo8N8RfaXI83Lo04BnXzHYnbPAj4SAp2TnvSZtuDIZYbbtg5jptD89FhxD2HVJ5vZHK9x/1ANlvG2PvWBSrUjTat4dHgENlPvA4jcsw03qJVctLcE525Q6aCYB708++6uZz6bjKsKHPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G/+zYEUO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 663D8C433C7;
	Wed, 27 Mar 2024 14:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711550858;
	bh=wdtVqbVIEGdHY/OZHy307yQ0kmARv1BuTL6ACiPT0Xg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G/+zYEUOOu8gk+98NtaOlB1nxHj3TNkGPCO9rFI0e9fYcdMyD2ICJJRABjGt8jw4Q
	 KZxFPG08PkglD9gtjsE8nrMn2z6D6kLiSsvq0whLk8wQ2eTc/cpZ+Lgx9J7LY2gl0W
	 kd4jb/2gQRSJTs2QI2I6sNikSHCyrfnIVjCBAfoQaUlAbsJTTCVQCKZQaAYnZ/7YLC
	 zW93e00Yj0G7Rt+RI3uEP1367e2fOXQeb4OCvVsnjs0C2Lq6ev+IZYHDpCcCIzo8FG
	 wxG2sObOMpGILCQ0akw9xyWcJRmUYxzTRXwIBF7AkYK/4cLTDklvv1sDKchntCQcN1
	 eUCEe8llwpsAA==
Date: Wed, 27 Mar 2024 14:47:33 +0000
From: Lee Jones <lee@kernel.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Daniel Thompson <daniel.thompson@linaro.org>,
	Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	kernel@pengutronix.de, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v2] backlight: lp8788: Drop support for platform data
Message-ID: <20240327144733.GV13211@google.com>
References: <20240314113529.923708-2-u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240314113529.923708-2-u.kleine-koenig@pengutronix.de>

On Thu, 14 Mar 2024, Uwe Kleine-König wrote:

> The backlight driver supports getting passed platform data. However this
> isn't used. This allows to remove quite some dead code from the driver
> because bl->pdata is always NULL, and so bl->mode is always
> LP8788_BL_REGISTER_ONLY.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
> Changes since (implicit) v1 archived at
> https://lkml.kernel.org/20240313124828.861731-2-u.kleine-koenig@pengutronix.de:
> 
>  - Also drop struct pwm_device *pwm member from struct lp8788_bl
> 
> I'm surprised that this didn't fail to compile ...
> 
> Best regards
> Uwe
> 
>  drivers/video/backlight/lp8788_bl.c | 151 ++--------------------------
>  include/linux/mfd/lp8788.h          |  36 -------
>  2 files changed, 8 insertions(+), 179 deletions(-)

Does not apply.

Please rebase onto v6.9-rc1 or for-backlight-next.

-- 
Lee Jones [李琼斯]

