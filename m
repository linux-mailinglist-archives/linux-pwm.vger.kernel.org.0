Return-Path: <linux-pwm+bounces-6102-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 141A5AC25AC
	for <lists+linux-pwm@lfdr.de>; Fri, 23 May 2025 16:56:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E527A54485F
	for <lists+linux-pwm@lfdr.de>; Fri, 23 May 2025 14:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEF34296731;
	Fri, 23 May 2025 14:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SvRXVI29"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF512940B;
	Fri, 23 May 2025 14:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748011988; cv=none; b=W7nSzqA8PyoGQfkVcCpnoMAK3eW5q3kP8NM2hr+YjwJ0rSpRetoW12CLWPiWkWuubUucd457OVbYH5lP71NYApvpZeuMpJokL2dNlQzJ1SXgD1kNZcCNbyugMGSCkTr4lKab+EJc4KkbkEW7WI3wBCS7pEakT4op78jQFZakMLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748011988; c=relaxed/simple;
	bh=AhpQg2GHgpa0wOs+6NOjWierHFBG4ZF/u0irecDG34U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ni31JEA6MD+Dyym1k9Dhw/iAJmX4jb7s5GlKuaWyDAK5d6Qgl+fnd2f7dpxmZ+NGZATxwOC+AI9i+V8zVUBfyrZ8c3E6aio4iUSTAqTXlg2TjN7hgVW8V76Z4tWOFFkhRQDLh3JG2Qyeyb2JuBoWwH092xu21A6bIGup/ar14vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SvRXVI29; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86C78C4CEE9;
	Fri, 23 May 2025 14:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748011988;
	bh=AhpQg2GHgpa0wOs+6NOjWierHFBG4ZF/u0irecDG34U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SvRXVI29aJp9OFsRkdhATx9eRTXrRxcanQ4Yxg2mdECjFkjSY7csR8mfPTG9d06Bg
	 amT/PHMG4kyhmPeboPHezSAZWfq0+vhFB1VS+M8CPJj0WT3OOTJ0jGxyzHfPOdIT0p
	 fmGqSCjlfYULuN5DtlbjHAWh5DE2ZB3zlPT53s+AKA7mUZ/3aIQ9fz2wStiibcxDX1
	 RMr3qR1xWy44xGTejlGWG00RFDzwWKJm1etCxce0Ed6yLM1278DPBOfK90W51Pda4P
	 n2Pvfk5LB9UtLL0TvhbPdihdVPxa7K0F6d1cvH+05vaXek+oGwTVdu0d4kYDBHu57n
	 6dvrPj6Tqh20A==
Date: Fri, 23 May 2025 15:53:02 +0100
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
Subject: Re: [PATCH v4 04/20] mfd: adp5585: make use of MFD_CELL_NAME()
Message-ID: <20250523145302.GG1378991@google.com>
References: <20250521-dev-adp5589-fw-v4-0-f2c988d7a7a0@analog.com>
 <20250521-dev-adp5589-fw-v4-4-f2c988d7a7a0@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250521-dev-adp5589-fw-v4-4-f2c988d7a7a0@analog.com>

On Wed, 21 May 2025, Nuno Sá via B4 Relay wrote:

> From: Nuno Sá <nuno.sa@analog.com>
> 
> Use the helper macro. No functional change intended...

"Whilst we're at it, now seems like a good time to update the Copyright."

Or similar.

> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> ---
>  drivers/mfd/adp5585.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mfd/adp5585.c b/drivers/mfd/adp5585.c
> index f3b74f7d6040413d066eb6dbaecfa3d5e6ee06bd..179dc284833ae8f39eefc6787dd2c7158dfd3ad7 100644
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
> @@ -24,8 +25,8 @@ enum {
>  };
>  
>  static const struct mfd_cell adp5585_devs[ADP5585_DEV_MAX] = {
> -	{ .name = "adp5585-gpio", },
> -	{ .name = "adp5585-pwm", },
> +	MFD_CELL_NAME("adp5585-gpio"),
> +	MFD_CELL_NAME("adp5585-pwm"),
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

