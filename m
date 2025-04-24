Return-Path: <linux-pwm+bounces-5693-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E0DAA9B31B
	for <lists+linux-pwm@lfdr.de>; Thu, 24 Apr 2025 17:55:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01F6F3AD3A1
	for <lists+linux-pwm@lfdr.de>; Thu, 24 Apr 2025 15:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CF9D27E1B1;
	Thu, 24 Apr 2025 15:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RbSsQzM5"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B773C1F;
	Thu, 24 Apr 2025 15:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745510110; cv=none; b=e9LuON1P7rg5Sc+c+/TWLMcXiWaXNsAWFl0i1afRtag20T/H5bf6kSBKzS+NIfgLWzdfOHbG1heAB1bvLS6WpqWUNiF2TINBm7z0OrYtaF3tov69ouoO7w04CXJKWHQcqbdyhZHku+Q/B4ehNPvr917a+tC9xpdjuP5Vs0SGEZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745510110; c=relaxed/simple;
	bh=bf5fafHL23z4dmtDZEoT0dtNCnCATtZ9AAeo/g41SX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TZDis+wX/84VGjMC4s92g0VlZTOkUI9Ll6Nay7Hgt1g+PUtV5TitgJSj7Q6L1RrEKLQo9UwO1S1Oxtp/jFGF98JIO+tW9kk83bUJJhcTW8z2HfwJevd5IcWmCw86R3K86ei1sH9Eh2PiCRr5OJ+KfVMyQiaPaFVFljq4zJAC8vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RbSsQzM5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04CC6C4CEE3;
	Thu, 24 Apr 2025 15:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745510109;
	bh=bf5fafHL23z4dmtDZEoT0dtNCnCATtZ9AAeo/g41SX4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RbSsQzM5rO1m/lqSd9HOQqgkENltAeijq5VGMnbr57dy3ddMScIl/J+EseQ2/zp3/
	 VQwyvTZT88NLJP+rBoMr/rc8y2NbED3EpV87vnNg75QFY1IvVBdB5QX981gctdqvQZ
	 yCoITa5xEjqV5vIwEcPQQJQq2KAXl+CuVCST0vqCQNVgbqioKw9N+hv9CiNQ2htdEm
	 Ikkl3f4VLWzz6E6JmrMUdDT4X6uXKCmtui3iG9xr5KJ7gg5CbCy0Sh/g6nXG18dVWY
	 FCXAo4JyP+llOuuf1CU+wNly+mc5Gl7V9M9uigfFwGDJKK+hfVp555VfgRm5UI78IK
	 juDlp4oHA5JDA==
Date: Thu, 24 Apr 2025 16:55:04 +0100
From: Lee Jones <lee@kernel.org>
To: nuno.sa@analog.com
Cc: linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-input@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Liu Ying <victor.liu@nxp.com>
Subject: Re: [PATCH v2 04/17] mfd: adp5585: make use of MFD_CELL_NAME()
Message-ID: <20250424155504.GJ8734@google.com>
References: <20250415-dev-adp5589-fw-v2-0-3a799c3ed812@analog.com>
 <20250415-dev-adp5589-fw-v2-4-3a799c3ed812@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250415-dev-adp5589-fw-v2-4-3a799c3ed812@analog.com>

On Tue, 15 Apr 2025, Nuno Sá via B4 Relay wrote:

> From: Nuno Sá <nuno.sa@analog.com>
> 
> Use the helper macro. No functional change intended...
> 
> Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> ---
>  drivers/mfd/adp5585.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mfd/adp5585.c b/drivers/mfd/adp5585.c
> index f17b5f2474cac6a403556694066f438288264a49..fafe3ad93ea196e1eb8e79fecba58f36f12167eb 100644
> --- a/drivers/mfd/adp5585.c
> +++ b/drivers/mfd/adp5585.c
> @@ -4,6 +4,7 @@
>   *
>   * Copyright 2022 NXP
>   * Copyright 2024 Ideas on Board Oy
> + * Copyright 2025 Analog Devices Inc.
>   */
>  
>  #include <linux/array_size.h>
> @@ -18,8 +19,10 @@
>  #include <linux/types.h>
>  
>  static const struct mfd_cell adp5585_devs[] = {
> -	{ .name = "adp5585-gpio", },
> -	{ .name = "adp5585-pwm", },
> +	MFD_CELL_NAME("adp5585-keys"),

This looks like a functional change to me?

> +	MFD_CELL_NAME("adp5585-gpio"),
> +	MFD_CELL_NAME("adp5585-pwm"),
> +

Superfluous blank line.

>  };
>  
>  static const struct regmap_range adp5585_volatile_ranges[] = {
> 
> -- 
> 2.49.0
> 
> 

-- 
Lee Jones [李琼斯]

