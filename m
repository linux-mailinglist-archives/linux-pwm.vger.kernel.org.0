Return-Path: <linux-pwm+bounces-5947-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AEE21AB5710
	for <lists+linux-pwm@lfdr.de>; Tue, 13 May 2025 16:26:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 157ED3A71FC
	for <lists+linux-pwm@lfdr.de>; Tue, 13 May 2025 14:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C31612BE0E0;
	Tue, 13 May 2025 14:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VkL0LTcf"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA0F212FBD;
	Tue, 13 May 2025 14:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747146384; cv=none; b=K0N9nFFujddd9hRZieOm5ukF3H+Ps9BOap3wvQeaJHCuxNU7BLSatp8gVuelJrDYqL6n3RmVoNiYmnmVHRRGuCuyYNdX963NflM277OC7qzM0UYxg9APc7sLJacMxsX9be355Rq6c3qKBbwSL/Ch4HVoa/TpOuR4c52kYgWVf90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747146384; c=relaxed/simple;
	bh=qAEY+cryUh2C7geBy3Ndeqhgf/WqCkZEWt0NqYuKdxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rhojDXBx2mDflcsivUO0qEB1QOH/q3hq10uHiaWXMJeHhSN9iIEJ2uxrhJypD8ntWNbpX/PgAswTTGUZ8O6ch6BhJuGX4r7KpOkQXeeAXCsGXL8x1nY3NIBvr/nzIxfqF1qDI/JPNga64H+hgxRbymP3w7wn951JwQRa/p4dchk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VkL0LTcf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F3B0C4CEE4;
	Tue, 13 May 2025 14:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747146384;
	bh=qAEY+cryUh2C7geBy3Ndeqhgf/WqCkZEWt0NqYuKdxE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VkL0LTcfXIDCsM9vZCfeyPKMxbTtOmaFexCyQjUdbrr5pHLPXNDUHsvLT1dCl9Z7x
	 l8YxW8Riy/27mNZH1DFQR267a8gM3t91oWC3pwi8KWhnbgKDXDp/DHUx/1IgJqK675
	 AqUX8Pwf6f7TFrrvLLvbJP5dRLZuMoiq+ym3a7qgQ/wXuBY0oHuCjqUuU+aVf3K5dQ
	 lh6apLy6PEcrZElQScB8MRek587P702Coo2t/prxO6AewG9hn3zSH9t5Se1fJBFudU
	 DKVqXG1LD5TbtIbMWmPlawbpBnb00It9CSMjwlolKZ3pfp/VQ4rr6oMYTkAgib3KDm
	 MCba6lVlOxcEw==
Date: Tue, 13 May 2025 15:26:18 +0100
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
Subject: Re: [PATCH v3 03/22] mfd: adp5585: enable oscilator during probe
Message-ID: <20250513142618.GL2936510@google.com>
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

On Mon, 12 May 2025, Nuno Sá via B4 Relay wrote:

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
> +	ret = regmap_set_bits(adp5585->regmap, ADP5585_GENERAL_CFG,
> +			      ADP5585_OSC_EN);

Nit: Consider unwrapping to 100-chars to avoid these simple line breaks.

Other than that, looks okay.

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
> 
> -- 
> 2.49.0
> 
> 

-- 
Lee Jones [李琼斯]

