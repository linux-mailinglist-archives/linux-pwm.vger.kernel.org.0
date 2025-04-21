Return-Path: <linux-pwm+bounces-5616-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6661FA94F09
	for <lists+linux-pwm@lfdr.de>; Mon, 21 Apr 2025 11:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C2241710A6
	for <lists+linux-pwm@lfdr.de>; Mon, 21 Apr 2025 09:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A1D325D8EE;
	Mon, 21 Apr 2025 09:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="d6xPEvX0"
X-Original-To: linux-pwm@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6D519DF99;
	Mon, 21 Apr 2025 09:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745229025; cv=none; b=C3oSVnpC9zlkYb9QuOvO+Ey/51c4StnZTFZLFKo02uyz0me3UdA1FvYWrwXDpOn4kKGPBqMKmfiavo/aVRjWjClBVVvsSTxwI5GLXSDH0dIN7fOVy2k3oC74SKq1fvv1n8iQhFErWqxMKMdXutbj7HzKjY1H9OuI3j72qc+WFoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745229025; c=relaxed/simple;
	bh=GabJ2+Lj+nwvku0P6IaWgkhWGqB/NJEc6UGANn2MRuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qeIOB5N3LvuqmA3q7WyTtqPO3AY6bEbY84hok6v0IZ1OQDqOqnoC8ydfw7CBBcIINbIOOU0HJnPm1T9n9GzoY+r4AlPAAXmLNTdwqD/IOCXPSK8I9tReuVyUHJoqgnJ7fqJe4tgQe5SjF6bh4M/3i7vvvh2G7IJyGV4QYg1mDB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=d6xPEvX0; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 1693F6D5;
	Mon, 21 Apr 2025 11:48:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1745228895;
	bh=GabJ2+Lj+nwvku0P6IaWgkhWGqB/NJEc6UGANn2MRuc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d6xPEvX0EntT0/qol2bGehKgJT6Smehw7DtF7pz2bwEI9guIvsfGVn5j1wDWc7OFt
	 sE9ukgWXDxTxEiQjYQVdg0TcP9ED3ccgvhFu4YoPHrMADS42rmqvXRo2v2Pogvn2IY
	 yLra3r66KdfhCHlV+ISKBtPKk4ZlXUj5HqsqyxOo=
Date: Mon, 21 Apr 2025 12:50:19 +0300
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
Subject: Re: [PATCH v2 17/17] pwm: adp5585: make sure to include
 mod_devicetable.h
Message-ID: <20250421095019.GN29968@pendragon.ideasonboard.com>
References: <20250415-dev-adp5589-fw-v2-0-3a799c3ed812@analog.com>
 <20250415-dev-adp5589-fw-v2-17-3a799c3ed812@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250415-dev-adp5589-fw-v2-17-3a799c3ed812@analog.com>

Hi Nuno,

Thank you for the patch.

On Tue, Apr 15, 2025 at 03:49:33PM +0100, Nuno Sá via B4 Relay wrote:
> From: Nuno Sá <nuno.sa@analog.com>
> 
> Explicitly include mod_devicetable.h for struct platform_device_id.
> 
> Signed-off-by: Nuno Sá <nuno.sa@analog.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/pwm/pwm-adp5585.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pwm/pwm-adp5585.c b/drivers/pwm/pwm-adp5585.c
> index cc8ac8f9e5669b4ffca06d4117a29f030393f48f..85308257724a338da4d2416c8d01e48e08bd0856 100644
> --- a/drivers/pwm/pwm-adp5585.c
> +++ b/drivers/pwm/pwm-adp5585.c
> @@ -20,6 +20,7 @@
>  #include <linux/mfd/adp5585.h>
>  #include <linux/minmax.h>
>  #include <linux/module.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/platform_device.h>
>  #include <linux/pwm.h>
>  #include <linux/regmap.h>

-- 
Regards,

Laurent Pinchart

