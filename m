Return-Path: <linux-pwm+bounces-6325-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 926F4AD757F
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Jun 2025 17:17:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 972C918833F0
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Jun 2025 15:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD4A298981;
	Thu, 12 Jun 2025 15:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u/K97eeA"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2CE1BC2A;
	Thu, 12 Jun 2025 15:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749741459; cv=none; b=GRtDGSG2wIsEqRf+vEwUvC3FabKXavBbN9gOMeAXjBVGZfzGZuQKQjN7m4gIvYDzHD7koUqz0UfGB7R2wy0i+3JR5YBirLiri0NsDUnKOlrd2UhcoTYoJiMYK2WqGN4GMdHUSoVm49W4ECFIC6Uj5R68kQLXukR/h5lMeiZ3NBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749741459; c=relaxed/simple;
	bh=5+sVOo5OIuYq9z0EhuNAy8+Z6b6B1HeQZN2IK5yXV3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uNMZEPF3DdTmWImug10lys49DYVbBKI/CDWpxNHM6UJeqPNe0R2HZ4vW76m1Aeo/1kG2mgnkHnEbN7dHfkcUozmbigxmxgbUAi9FcgSs9weQ1TN5BcjSjupSdg0UgvNO3Zbt6wdr/E7cvbnUGjbI8zjcSz/MjFvfpeqvsno/4No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u/K97eeA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D7C7C4CEEA;
	Thu, 12 Jun 2025 15:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749741458;
	bh=5+sVOo5OIuYq9z0EhuNAy8+Z6b6B1HeQZN2IK5yXV3o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u/K97eeAtQdjdv+LuiEgBYtDEoZzrrCwyVXUeCQJwsJM7Riwij7SoLj7jvr3g7ZSP
	 +ZfulIh2URZBEsSH7SROdYsdGUIaECtUpMCoLbauHGyjfrv688RHsIFX75aF32OkeB
	 TCFjLR43mXsOxrVFQXjVm2a+xbMch1/X/Rpy02WCaQGRwgJG9TwLkOHUQFZqWlgm6l
	 ZOmq9st9hSkgOodUzPBHiwB8zoSrO/ZFAA+v7aFG1LeSSLS6ijdt/xp41x0uSAPBs5
	 HPi7H1pvSPgOkQkWhoeR+qU9LNfb2Gr6lhoyJM0PMEnoRSzGdOxNiOYDkv0AenlXFl
	 b7l3dzIZJ8OPg==
Date: Thu, 12 Jun 2025 16:17:32 +0100
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
Subject: Re: [PATCH v4 18/20] mfd: adp5585: support getting vdd regulator
Message-ID: <20250612151732.GM381401@google.com>
References: <20250521-dev-adp5589-fw-v4-0-f2c988d7a7a0@analog.com>
 <20250521-dev-adp5589-fw-v4-18-f2c988d7a7a0@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250521-dev-adp5589-fw-v4-18-f2c988d7a7a0@analog.com>

On Wed, 21 May 2025, Nuno Sá via B4 Relay wrote:

> From: Nuno Sá <nuno.sa@analog.com>
> 
> Make sure we get and enable the VDD supply (if available).
> 
> Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> ---
>  drivers/mfd/adp5585.c | 5 +++++
>  1 file changed, 5 insertions(+)

Reviewed-by: Lee Jones <lee@kernel.org>

> diff --git a/drivers/mfd/adp5585.c b/drivers/mfd/adp5585.c
> index 122e2c95385f8d5cbd7839db78dda77ad7ba4ae4..e8b9a0ef4ee654ac1abc4042152fe0933f1d9f0d 100644
> --- a/drivers/mfd/adp5585.c
> +++ b/drivers/mfd/adp5585.c
> @@ -17,6 +17,7 @@
>  #include <linux/mod_devicetable.h>
>  #include <linux/module.h>
>  #include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
>  #include <linux/types.h>
>  
>  enum {
> @@ -713,6 +714,10 @@ static int adp5585_i2c_probe(struct i2c_client *i2c)
>  	if (ret)
>  		return ret;
>  
> +	ret = devm_regulator_get_enable(&i2c->dev, "vdd");
> +	if (ret)
> +		return ret;
> +
>  	adp5585->regmap = devm_regmap_init_i2c(i2c, &regmap_config);
>  	if (IS_ERR(adp5585->regmap))
>  		return dev_err_probe(&i2c->dev, PTR_ERR(adp5585->regmap),
> 
> -- 
> 2.49.0
> 
> 

-- 
Lee Jones [李琼斯]

