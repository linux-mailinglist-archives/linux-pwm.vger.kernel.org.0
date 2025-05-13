Return-Path: <linux-pwm+bounces-5949-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C03E1AB575C
	for <lists+linux-pwm@lfdr.de>; Tue, 13 May 2025 16:39:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AE3419E4FF4
	for <lists+linux-pwm@lfdr.de>; Tue, 13 May 2025 14:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEF05299928;
	Tue, 13 May 2025 14:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="enNVU0qa"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB3828E56C;
	Tue, 13 May 2025 14:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747147188; cv=none; b=DN7pxqcd55/VmxKxGB+LlsInF/ZGMTsRP7G+MJSzPxRkLTstxtjZMpju0IqBLLqRsIpNck6N4dncULMdgRTNm92x4G1HNsSxaE5DSnyGODaPJDWQ7fsKf+quYKd27MNkqmcQ5SP3TpZIEAnazMW0FUcWPfNESqqF35tBt+y5QK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747147188; c=relaxed/simple;
	bh=HeSqpSWsc68+TjFPv1rKHS8+MgeUwgSQdJR++Dv0ce8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CVsZfw1OSJRySk+vn9BgFHo2CYBxW5//tGtr8ojcCm9+fNJ+c7XDw5cuutrCWTP308aHp8wp0B7I1fYdKprTZ8ohe9oSYgCBP/ODPrLY6NBS8rXMpOBAZ5UpP6p1bPAI+tFamXQrGa+VNRNedYISRAwXhknPwUcZICD2TtHiVBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=enNVU0qa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51ED1C4CEE9;
	Tue, 13 May 2025 14:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747147188;
	bh=HeSqpSWsc68+TjFPv1rKHS8+MgeUwgSQdJR++Dv0ce8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=enNVU0qaSJG/zC6MdBMXA3DiINnOEJUraEv92iUVvNVVdFDW+5UNEBBdZFNcB0YX/
	 OO8ZiE/8SKo9txgIn4SjsngXoS+7gHvbKyUeIMQGjJf6Oy8g9K0pUQo2aag0cwDDyq
	 GfvYPLLaFoymCXBY44umm5Myli5k0PF/alJDWCKP9v0Y++wJ1oT6Ip9hRjTIE0VowO
	 KBUTqSpKpFvDJPu0aaYV+YJWIJRa3gxaJ3IFaRs5tubF4a/DFhTvN9DbUimGxVup7S
	 YyNk8bYyzMvqiUMJwECn/AKClnYcuKvCtdimhIsVjMbEoLwsdSzPIbPuCc+v+/+H//
	 Q7LYBNwDV1edQ==
Date: Tue, 13 May 2025 15:39:42 +0100
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
Subject: Re: [PATCH v3 05/22] mfd: adp5585: make use of MFD_CELL_NAME()
Message-ID: <20250513143942.GN2936510@google.com>
References: <20250512-dev-adp5589-fw-v3-0-092b14b79a88@analog.com>
 <20250512-dev-adp5589-fw-v3-5-092b14b79a88@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250512-dev-adp5589-fw-v3-5-092b14b79a88@analog.com>

On Mon, 12 May 2025, Nuno Sá via B4 Relay wrote:

> From: Nuno Sá <nuno.sa@analog.com>
> 
> Use the helper macro. No functional change intended...
> 
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> ---
>  drivers/mfd/adp5585.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mfd/adp5585.c b/drivers/mfd/adp5585.c
> index d693b1ead05128e02f671ca465f9c72cab3b3395..19d4a0ab1bb4c261e82559630624059529765fbd 100644
> --- a/drivers/mfd/adp5585.c
> +++ b/drivers/mfd/adp5585.c
> @@ -4,6 +4,7 @@
>   *
>   * Copyright 2022 NXP
>   * Copyright 2024 Ideas on Board Oy
> + * Copyright 2025 Analog Devices Inc.

If you're going to sneak in irrelevant changes, at least mention it in
passing in the change log.

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

