Return-Path: <linux-pwm+bounces-3054-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 092FA95EC5F
	for <lists+linux-pwm@lfdr.de>; Mon, 26 Aug 2024 10:51:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BBB71C20833
	for <lists+linux-pwm@lfdr.de>; Mon, 26 Aug 2024 08:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5D6A13DDCC;
	Mon, 26 Aug 2024 08:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="IzPLqbsX"
X-Original-To: linux-pwm@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062FE13AD22;
	Mon, 26 Aug 2024 08:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724662256; cv=none; b=LeiLyM6bHRKFyTjzrKwuiwm2o/a0Y2R4Du8BDix6rhH/C0MOzJ7sIf6s/dXM0L/pO+tNtFN6oUhiKfVb0NDYZYbeOBNdknulWdBlIVJ2K/5GDRK54v34dEDITIyHi9Aqs3DsrtZ+vLROvo4DWIeLLpTtyNEEjbHqUOx9tGfX5xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724662256; c=relaxed/simple;
	bh=+AAnGphO/V8TJKxCbBXXQF+Kt7V94H4YdOr5ElaF+qA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TGW5gOVlVbnxwvCM3BeljohGK0fJXXFPrhowwNAaICqQ7+jBmJu8+nIhpl3r4sQSbDXUpNw0MwqYjC1zr2UtqbDdi0+IpylwFQDQI+H3A/DFi5Tcfrd1HJfid3TYywLWrXNFUxaaURYzGvD6/QjhiI1EgG5Ojge8E4FU/88SbYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=IzPLqbsX; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 001CFE4;
	Mon, 26 Aug 2024 10:49:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1724662187;
	bh=+AAnGphO/V8TJKxCbBXXQF+Kt7V94H4YdOr5ElaF+qA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IzPLqbsXU6vPbAiV4OixrkvXb9qUvw/1lyI7SrDHdRh2VPNzjDIFoBLWdz/PpgO7/
	 0rK+Zg+iCKBpWtDtlUinWZPWd1WU4t/Dj4IjzPHIUt8o6NkJY/hKlVt8QnWQTz2XdT
	 wTk3hevf1xT90DIL+mRPrEh7yrW6N9obL7C7YWTo=
Date: Mon, 26 Aug 2024 11:50:49 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Liu Ying <victor.liu@nxp.com>
Cc: linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org, ukleinek@kernel.org,
	xiaoning.wang@nxp.com, Frank.Li@nxp.com, lee@kernel.org
Subject: Re: [PATCH] pwm: adp5585: Set OSC_EN bit to 1 when PWM state is
 enabled
Message-ID: <20240826085049.GA23129@pendragon.ideasonboard.com>
References: <20240826083337.1835405-1-victor.liu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240826083337.1835405-1-victor.liu@nxp.com>

Hi Liu,

Thank you for the patch.

On Mon, Aug 26, 2024 at 04:33:37PM +0800, Liu Ying wrote:
> It turns out that OSC_EN bit in GERNERAL_CFG register has to be set to 1
> when PWM state is enabled, otherwise PWM signal won't be generated.

Indeed, this likely got lost during one of the reworks. The apply
function correctly clears the bit when disabling PWM, but doesn't set it
otherwise.

> Fixes: e9b503879fd2 ("pwm: adp5585: Add Analog Devices ADP5585 support")
> Signed-off-by: Liu Ying <victor.liu@nxp.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Uwe, would you be able to queue this for v6.12 ?

> ---
>  drivers/pwm/pwm-adp5585.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/pwm/pwm-adp5585.c b/drivers/pwm/pwm-adp5585.c
> index ed7e8c6bcf32..40472ac5db64 100644
> --- a/drivers/pwm/pwm-adp5585.c
> +++ b/drivers/pwm/pwm-adp5585.c
> @@ -100,6 +100,10 @@ static int pwm_adp5585_apply(struct pwm_chip *chip,
>  	if (ret)
>  		return ret;
>  
> +	ret = regmap_set_bits(regmap, ADP5585_GENERAL_CFG, ADP5585_OSC_EN);
> +	if (ret)
> +		return ret;
> +
>  	return regmap_set_bits(regmap, ADP5585_PWM_CFG, ADP5585_PWM_EN);
>  }
>  

-- 
Regards,

Laurent Pinchart

