Return-Path: <linux-pwm+bounces-5615-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF5DA94EFD
	for <lists+linux-pwm@lfdr.de>; Mon, 21 Apr 2025 11:48:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB2A016F397
	for <lists+linux-pwm@lfdr.de>; Mon, 21 Apr 2025 09:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1FA425D8E8;
	Mon, 21 Apr 2025 09:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="srBTKYVk"
X-Original-To: linux-pwm@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4664825A658;
	Mon, 21 Apr 2025 09:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745228885; cv=none; b=q+zL7p1EsSR7TpEh48JB9yxBqmtHCdqn5sCBqwoXBwZpN4FXReN8e4whCfwvHUBqgcjQLvTFEpmuMFZzhcFXcJbWsKBI7HSAD/CSmIrYr5SZ8leGUrvOKaYWjwRNsBN94814bzpiHGc9Gh3v2ajuyExXl7kSpkBNCkKizMRXzQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745228885; c=relaxed/simple;
	bh=TmEvICgAk3QJCQKIBH/rVZL2DHTBTGWmVVJ3N+XVzw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I2HneFqHkfso3hiSJycFaIBHkwOammntbqIkGX8f6E6UHimE5tjSfejjBpTs6ZoiYaJBfuUqLCnFmL/PB40kND/9NcmwzadeU6C87u3u8QqQSt30fTPfGj0HOH+Vc4OIanXpnfLVnGTgNucj8HNe6P26ioDYIttwzaUvWrrVYaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=srBTKYVk; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 662256D5;
	Mon, 21 Apr 2025 11:45:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1745228756;
	bh=TmEvICgAk3QJCQKIBH/rVZL2DHTBTGWmVVJ3N+XVzw4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=srBTKYVkKH4npOcNfRjNz36JEkEOsHL3LtZeVOxp5v3eDSxlcIcjkuqZkosFWZChS
	 TBMdeoMszAimSE/MgOmUbV3BuLao4eCoBO1emEOd+WInp1DOhGCbn6hbBOj3idntCD
	 /U7F/Lbn0JF2WyXbPU0LjQMdFYx0QQ1rF3CdXUzc=
Date: Mon, 21 Apr 2025 12:48:01 +0300
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
Subject: Re: [PATCH v2 14/17] mfd: adp5585: support getting vdd regulator
Message-ID: <20250421094801.GM29968@pendragon.ideasonboard.com>
References: <20250415-dev-adp5589-fw-v2-0-3a799c3ed812@analog.com>
 <20250415-dev-adp5589-fw-v2-14-3a799c3ed812@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250415-dev-adp5589-fw-v2-14-3a799c3ed812@analog.com>

Hi Nuno,

Thank you for the patch.

On Tue, Apr 15, 2025 at 03:49:30PM +0100, Nuno Sá via B4 Relay wrote:
> From: Nuno Sá <nuno.sa@analog.com>
> 
> Make sure we get and enable the VDD supply (if available).

Can the regulator be enabled only when needed ?

> Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> ---
>  drivers/mfd/adp5585.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/mfd/adp5585.c b/drivers/mfd/adp5585.c
> index c1d51d50dca6c9367d4a1b98a4f8bbec12dbf90b..667cc5bd0745f64eec60837ec3c00057af0cddeb 100644
> --- a/drivers/mfd/adp5585.c
> +++ b/drivers/mfd/adp5585.c
> @@ -18,6 +18,7 @@
>  #include <linux/mod_devicetable.h>
>  #include <linux/module.h>
>  #include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
>  #include <linux/types.h>
>  
>  static const struct mfd_cell adp5585_devs[] = {
> @@ -849,6 +850,10 @@ static int adp5585_i2c_probe(struct i2c_client *i2c)
>  	adp5585->dev = &i2c->dev;
>  	adp5585->irq = i2c->irq;
>  
> +	ret = devm_regulator_get_enable(&i2c->dev, "vdd");
> +	if (ret)
> +		return ret;
> +
>  	adp5585->regmap = devm_regmap_init_i2c(i2c, info->regmap_config);
>  	if (IS_ERR(adp5585->regmap))
>  		return dev_err_probe(&i2c->dev, PTR_ERR(adp5585->regmap),

-- 
Regards,

Laurent Pinchart

