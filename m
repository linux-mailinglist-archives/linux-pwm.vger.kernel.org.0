Return-Path: <linux-pwm+bounces-5957-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB2A3AB5893
	for <lists+linux-pwm@lfdr.de>; Tue, 13 May 2025 17:28:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBD8616FAA8
	for <lists+linux-pwm@lfdr.de>; Tue, 13 May 2025 15:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2340928F501;
	Tue, 13 May 2025 15:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="ibKU4tDm"
X-Original-To: linux-pwm@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D6B1C84A0;
	Tue, 13 May 2025 15:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747150027; cv=none; b=n333z3hk4+fI7aBq4pYM4/h40diXnnR+9mrghJzjUCuG9gNaa7VZu8kKu930XrcBctSkWAifgpc1Q+PflCR9NeFNvFI5u5JKO2U1vVlXI9Hnx/OkpUaChZgGrBsCR51A+DIjtpBg0lLEf6AoLRR4O66NatM0we2rQr+2tYPeEm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747150027; c=relaxed/simple;
	bh=aIKIrSxJz0Eu7nA886+NzWplRUjWnJsQPf3t8KL2Isk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WfebHiokeu/GXrdP5vJSgGZ0lAM3t2hb0GRp4hzlKZZazH9HRHx8iRl9lGRalZ1K0a15NCuP80j2OLEbqGu1lUsTcuTkaNDgOTRWMrDjpqTgHHISjpAQSDvgZC4ICkY8os7IjSd+5xlhvvFrNTPP+sbyPL6Op+qWAy+kLMc4FlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=ibKU4tDm; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (unknown [146.0.27.149])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id AAFEE4C9;
	Tue, 13 May 2025 17:26:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1747150007;
	bh=aIKIrSxJz0Eu7nA886+NzWplRUjWnJsQPf3t8KL2Isk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ibKU4tDmLJXaFklBF0Ti5nSoFn5MsULt1HDLbKeTLJ0mxrbQ1dDLHyWOJ1Tp8YXCH
	 4m2wOak/PB8kgzsVQXq11qgC8NfdA/H7pT9+aET4XFB9CD5cVG7eW4K6ZAonvuQS6Q
	 VYe2dAEWHTgZ+kE3tnBUj1h6qqLm0WvetQ3LU/ao=
Date: Tue, 13 May 2025 17:26:55 +0200
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
Subject: Re: [PATCH v3 04/22] pwm: adp5585: don't control OSC_EN in the pwm
 driver
Message-ID: <20250513152655.GC23592@pendragon.ideasonboard.com>
References: <20250512-dev-adp5589-fw-v3-0-092b14b79a88@analog.com>
 <20250512-dev-adp5589-fw-v3-4-092b14b79a88@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250512-dev-adp5589-fw-v3-4-092b14b79a88@analog.com>

Hi Nuno,

Thank you for the patch.

On Mon, May 12, 2025 at 01:38:56PM +0100, Nuno Sá via B4 Relay wrote:
> From: Nuno Sá <nuno.sa@analog.com>
> 
> The adp5585 is a Multi Function Device that can also be a gpio
> controller and as it turns out, when OSC_EN is not set, we can't
> reliably read the gpio value when it's configured as input. Hence,
> OSC_EN will be set during probe by the parent device (and cleared on
> unbind).
> 
> Moreover, we'll add support for the keymap matrix (input device) which
> definitely needs OSC_EN to be set and so, we cannot afford that disabling
> the PWM output also breaks the keymap events generation.

I think you can squash this with 03/22 if you send a new version. Moving
the OSC_EN bit handling from the PWM child driver to the MFD driver is a
single logical change.

> Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> ---
>  drivers/pwm/pwm-adp5585.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-adp5585.c b/drivers/pwm/pwm-adp5585.c
> index 40472ac5db6410a33e4f790fe8e6c23b517502be..c8821035b7c1412a55a642e6e8a46b66e693a5af 100644
> --- a/drivers/pwm/pwm-adp5585.c
> +++ b/drivers/pwm/pwm-adp5585.c
> @@ -62,7 +62,6 @@ static int pwm_adp5585_apply(struct pwm_chip *chip,
>  	int ret;
>  
>  	if (!state->enabled) {
> -		regmap_clear_bits(regmap, ADP5585_GENERAL_CFG, ADP5585_OSC_EN);
>  		regmap_clear_bits(regmap, ADP5585_PWM_CFG, ADP5585_PWM_EN);
>  		return 0;
>  	}
> @@ -100,10 +99,6 @@ static int pwm_adp5585_apply(struct pwm_chip *chip,
>  	if (ret)
>  		return ret;
>  
> -	ret = regmap_set_bits(regmap, ADP5585_GENERAL_CFG, ADP5585_OSC_EN);
> -	if (ret)
> -		return ret;
> -
>  	return regmap_set_bits(regmap, ADP5585_PWM_CFG, ADP5585_PWM_EN);
>  }
>  

-- 
Regards,

Laurent Pinchart

