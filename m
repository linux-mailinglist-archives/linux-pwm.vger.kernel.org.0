Return-Path: <linux-pwm+bounces-5956-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E7DAB588C
	for <lists+linux-pwm@lfdr.de>; Tue, 13 May 2025 17:27:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0043161A0D
	for <lists+linux-pwm@lfdr.de>; Tue, 13 May 2025 15:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21CF028E5EC;
	Tue, 13 May 2025 15:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="K07QE/8t"
X-Original-To: linux-pwm@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B603244669;
	Tue, 13 May 2025 15:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747149877; cv=none; b=R5LejQeik17wRqq52jGyQXzW3q0sP8SYBMGO4EsXDOPyBjiuyzKRPq/dcqIYhINC7Fruint0TwjdE8/0mGqLqghLpnAvKGpgHBLH5dPQJKaaEYGd0aA+H5MSSXx40EabjYThoWYmW2CiZAmH+M95SU7vqt4a8P2SSRdRBrYPVOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747149877; c=relaxed/simple;
	bh=aFq16nXJjpFPukEYgCucZUBi1M4RbuhTwFDtXPLmAvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Os8Ee77hx/jCk/XETV41praPfEt3pcfhAB4dP9Ry1LVpLHfsQHm91yzUHbP7mFGzxnYDV2X7rDgRg7s4pAq+UG3ZDOP26MZ+Ahyk5+9gbPhh5yzHWDqlzmrf5+w0W0FoeNhDxhtdxsMs2eeYbPBiozbHFFlNE+GO48a3ZznPBkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=K07QE/8t; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (unknown [146.0.27.149])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 08D564C9;
	Tue, 13 May 2025 17:24:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1747149856;
	bh=aFq16nXJjpFPukEYgCucZUBi1M4RbuhTwFDtXPLmAvA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K07QE/8tmNIoBoEFqG9vYAVbypmRPBShuXJXU4A48ybrUVkvCxoBhiUOPQ/LVepbo
	 EMKcBkL/WgDtx59Cck9kaNH5XBwKG12oBqH5oMm/uM8RzdsuCxGuVhOiVbumTNOfLz
	 q6oNYU5W+O4o9murCcjI4uI8zKT3knapia7YHKpg=
Date: Tue, 13 May 2025 17:24:23 +0200
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
Subject: Re: [PATCH v3 03/22] mfd: adp5585: enable oscilator during probe
Message-ID: <20250513152423.GB23592@pendragon.ideasonboard.com>
References: <20250512-dev-adp5589-fw-v3-0-092b14b79a88@analog.com>
 <20250512-dev-adp5589-fw-v3-3-092b14b79a88@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250512-dev-adp5589-fw-v3-3-092b14b79a88@analog.com>

Hi Nuno,

Thank you for the patch.

On Mon, May 12, 2025 at 01:38:55PM +0100, Nuno Sá via B4 Relay wrote:
> From: Nuno Sá <nuno.sa@analog.com>
> 
> Make sure to enable the oscillator in the top device. This will allow to
> not control this in the child PWM device as that would not work with
> future support for keyboard matrix where the oscillator needs to be
> always enabled (and so cannot be disabled by disabling PWM).
> 
> Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> ---
>  drivers/mfd/adp5585.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/mfd/adp5585.c b/drivers/mfd/adp5585.c
> index 02f9e8c1c6a1d8b9516c060e0024d69886e9fb7a..d693b1ead05128e02f671ca465f9c72cab3b3395 100644
> --- a/drivers/mfd/adp5585.c
> +++ b/drivers/mfd/adp5585.c
> @@ -143,6 +143,13 @@ static int adp5585_parse_fw(struct device *dev, struct adp5585_dev *adp5585,
>  	return rc;
>  }
>  
> +static void adp5585_osc_disable(void *data)
> +{
> +	const struct adp5585_dev *adp5585 = data;
> +
> +	regmap_write(adp5585->regmap, ADP5585_GENERAL_CFG, 0);
> +}
> +
>  static int adp5585_i2c_probe(struct i2c_client *i2c)
>  {
>  	const struct regmap_config *regmap_config;
> @@ -176,6 +183,15 @@ static int adp5585_i2c_probe(struct i2c_client *i2c)
>  	if (n_devs < 0)
>  		return n_devs;
>  

Could you add a comment here to explain what's going on ? Something
along the lines of

	/*
	 * Enable the internal oscillator, as it's shared between multiple
	 * functions.
	 *
	 * As a future improvement, power consumption could possibly be
	 * decreased in some use cases by enabling and disabling the oscillator
	 * dynamically based on the needs of the child drivers.
	 */

With that,

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> +	ret = regmap_set_bits(adp5585->regmap, ADP5585_GENERAL_CFG,
> +			      ADP5585_OSC_EN);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_add_action_or_reset(&i2c->dev, adp5585_osc_disable, adp5585);
> +	if (ret)
> +		return ret;
> +
>  	ret = devm_mfd_add_devices(&i2c->dev, PLATFORM_DEVID_AUTO,
>  				   devs, n_devs, NULL, 0, NULL);
>  	if (ret)

-- 
Regards,

Laurent Pinchart

