Return-Path: <linux-pwm+bounces-5599-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 075E5A94E64
	for <lists+linux-pwm@lfdr.de>; Mon, 21 Apr 2025 11:03:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F361317142C
	for <lists+linux-pwm@lfdr.de>; Mon, 21 Apr 2025 09:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A2FE20FAA8;
	Mon, 21 Apr 2025 09:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="kjGbTkvO"
X-Original-To: linux-pwm@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3AB1D7984;
	Mon, 21 Apr 2025 09:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745226214; cv=none; b=dFdCXw8drrrDrZHDD3tLkfwq16UZVmJYvqV//NBivOBe62cdqU6kgWnXRXp8v/GKz4K+cVpL1H3G4FliRwClG3jwr37rAFPvEC+sTaoT4zCaP6NZ5+xnCklpjbNxCS3e7zXwIjQuERMxvuM/ev6o/HBKLIUK22vgZvUfU21sfpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745226214; c=relaxed/simple;
	bh=sPeoqzzUgFTEvHPCa7H3p5g1By1IUdg+KjN37r8+SP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rfD6D2PY0YP28pTTk4pbcEuR1OKg66sffuAO2R5eJSZ1oqbiDMooL53ygGxRMMTqudEg3D6x7XH8MNBeKRs+MUh+naylYt7O5N2W98TmmmeK162wvwDeC6d46VjzxkP5f2aCmB3IwS3ZvrCfrNyzplC23z/6UF8+SjDEbPfAjyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=kjGbTkvO; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 5FE5656D;
	Mon, 21 Apr 2025 11:01:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1745226083;
	bh=sPeoqzzUgFTEvHPCa7H3p5g1By1IUdg+KjN37r8+SP0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kjGbTkvOotVrqrg7pRAeoDcSFs2DNriDtgQiXOgtDz309ZqUJZYUCuVifbIE68FSR
	 rmxBptW4rHq1PlLcRSSiHWRh6QehTMxfYGg13xQ0E+8GONeR8RydIAhp4tvsEUdk8x
	 UJAp1ivUC1lA9EKtbc8dVA5USJQ6KGzGfY5R0Zz8=
Date: Mon, 21 Apr 2025 12:03:28 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: nuno.sa@analog.com
Cc: linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-input@vger.kernel.org,
	Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Liu Ying <victor.liu@nxp.com>
Subject: Re: [PATCH v2 04/17] mfd: adp5585: make use of MFD_CELL_NAME()
Message-ID: <20250421090328.GC29968@pendragon.ideasonboard.com>
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

On Tue, Apr 15, 2025 at 03:49:20PM +0100, Nuno Sá via B4 Relay wrote:
> From: Nuno Sá <nuno.sa@analog.com>
> 
> Use the helper macro. No functional change intended...
> 
> Signed-off-by: Nuno Sá <nuno.sa@analog.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

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
> +	MFD_CELL_NAME("adp5585-gpio"),
> +	MFD_CELL_NAME("adp5585-pwm"),
> +
>  };
>  
>  static const struct regmap_range adp5585_volatile_ranges[] = {

-- 
Regards,

Laurent Pinchart

