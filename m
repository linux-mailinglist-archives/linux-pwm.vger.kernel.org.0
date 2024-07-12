Return-Path: <linux-pwm+bounces-2783-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6BE492FC29
	for <lists+linux-pwm@lfdr.de>; Fri, 12 Jul 2024 16:06:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FEBC1F233D7
	for <lists+linux-pwm@lfdr.de>; Fri, 12 Jul 2024 14:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C2B2171086;
	Fri, 12 Jul 2024 14:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s/YM1ouc"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4FC16F85A;
	Fri, 12 Jul 2024 14:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720793196; cv=none; b=C8a2JJiKkDiBWua8z5onRXf5RseuCtEpYn1rCcfZNQjJKlWt/J5RlrNspNs9vp9BC+ObULTrxmbkJdnZUqSz8MCP9UXqg/oUhmeq3oANY3EX0I1hmYo6uhillaGbVftZhNcq/tteZ+Jg6Y970n7VZauJCCRo9RE7Xtzyynng9t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720793196; c=relaxed/simple;
	bh=WPERRxXlbQFKhcwOK8ZIyfxpsLzkQC4aKZvfMn+JrAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UlRFF0GubDPUqnHxyyuWQlcgKsfk/tUHhxw4VYg/TSTbeSxkQjsSR9OIz1iSL9vkKsUhyr+BtCKK9cPE2lsyhoIQrn3E8v9BpcVcLrt4EqsmVDBIAe6ScohBjsaQA0d9ZhEycMos7lw3kb7S/6DCvjdXLDThHWXTQdrjXLAisYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s/YM1ouc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C1F4C32782;
	Fri, 12 Jul 2024 14:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720793195;
	bh=WPERRxXlbQFKhcwOK8ZIyfxpsLzkQC4aKZvfMn+JrAE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s/YM1oucc/pGbGd9GyTbAZ3r9Es5qx6j9iFxYX66g0MxRgNZtK8bT4LFKhRPRPK+I
	 JayOFdCtjDVvQwhEiqZLeEaKU/4V/a7QcmRcHtnAn+tysmjdn7hsmu76wrcu7RiSz9
	 lw2etQ5gPlvLZ22OT4BsLi4G5UK+vuTFbjUyzaokd9UJ/SWFC7BiOuHxURgBtrC8xb
	 FPDaGn0ojNrMLYyhjGM3zFm7UI/aDefDKzgjcqy7SUYHJS4T7JTtE9VVsox5Og3eLG
	 a+CRBdL8K52UUFa9wzN4P4RECa0ivj68kmbflQ29loDzokNN3zCy5Wt8S0zjrL7236
	 3tWII4eBFHSGQ==
Date: Fri, 12 Jul 2024 08:06:34 -0600
From: Rob Herring <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>, linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Liu Ying <victor.liu@nxp.com>
Subject: Re: [PATCH 2/3] pwm: imx27: Add 32k clock for pwm in i.MX8QXP MIPI
 subsystem
Message-ID: <20240712140634.GA595171-robh@kernel.org>
References: <20240711-pwm-v1-0-4d5766f99b8b@nxp.com>
 <20240711-pwm-v1-2-4d5766f99b8b@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240711-pwm-v1-2-4d5766f99b8b@nxp.com>

On Thu, Jul 11, 2024 at 05:08:57PM -0400, Frank Li wrote:
> From: Liu Ying <victor.liu@nxp.com>
> 
> PWM in i.MX8QXP MIPI subsystem needs the clock '32k'. Use it if the DTS
> provides that.
> 
> Signed-off-by: Liu Ying <victor.liu@nxp.com>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/pwm/pwm-imx27.c | 33 ++++++++++++++++++++++++++++-----
>  1 file changed, 28 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-imx27.c b/drivers/pwm/pwm-imx27.c
> index 9e2bbf5b4a8ce..032bce7d1fdd3 100644
> --- a/drivers/pwm/pwm-imx27.c
> +++ b/drivers/pwm/pwm-imx27.c
> @@ -15,6 +15,7 @@
>  #include <linux/delay.h>
>  #include <linux/err.h>
>  #include <linux/io.h>
> +#include <linux/iopoll.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> @@ -82,6 +83,7 @@
>  struct pwm_imx27_chip {
>  	struct clk	*clk_ipg;
>  	struct clk	*clk_per;
> +	struct clk	*clk_32k;
>  	void __iomem	*mmio_base;
>  
>  	/*
> @@ -101,23 +103,36 @@ static int pwm_imx27_clk_prepare_enable(struct pwm_imx27_chip *imx)
>  {
>  	int ret;
>  
> +	if (imx->clk_32k) {
> +		ret = clk_prepare_enable(imx->clk_32k);

IIRC, no need for the 'if' here. clk_prepare_enable() returns success 
for a NULL clock which is what devm_clk_get_optional() returns if the 
clock doesn't exist.

> +		if (ret)
> +			goto err1;
> +	}
> +
>  	ret = clk_prepare_enable(imx->clk_ipg);
>  	if (ret)
> -		return ret;
> +		goto err2;
>  
>  	ret = clk_prepare_enable(imx->clk_per);
> -	if (ret) {
> -		clk_disable_unprepare(imx->clk_ipg);
> -		return ret;
> -	}
> +	if (ret)
> +		goto err3;
>  
>  	return 0;
> +err3:
> +	clk_disable_unprepare(imx->clk_ipg);
> +err2:
> +	if (imx->clk_32k)
> +		clk_disable_unprepare(imx->clk_32k);
> +err1:
> +	return ret;
>  }
>  
>  static void pwm_imx27_clk_disable_unprepare(struct pwm_imx27_chip *imx)
>  {
>  	clk_disable_unprepare(imx->clk_per);
>  	clk_disable_unprepare(imx->clk_ipg);
> +	if (imx->clk_32k)
> +		clk_disable_unprepare(imx->clk_32k);

Same here.

>  }
>  
>  static int pwm_imx27_get_state(struct pwm_chip *chip,
> @@ -223,6 +238,7 @@ static int pwm_imx27_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>  	struct pwm_imx27_chip *imx = to_pwm_imx27_chip(chip);
>  	unsigned long long c;
>  	unsigned long long clkrate;
> +	int val;

Goes in next patch.

>  	int ret;
>  	u32 cr;
>  
> @@ -325,6 +341,13 @@ static int pwm_imx27_probe(struct platform_device *pdev)
>  		return dev_err_probe(&pdev->dev, PTR_ERR(imx->clk_per),
>  				     "failed to get peripheral clock\n");
>  
> +	imx->clk_32k = devm_clk_get_optional(&pdev->dev, "32k");
> +	if (IS_ERR(imx->clk_32k)) {
> +		dev_err(&pdev->dev, "getting 32k clock failed with %ld\n",
> +				PTR_ERR(imx->clk_32k));

dev_err_probe.

> +		return PTR_ERR(imx->clk_32k);
> +	}
> +
>  	chip->ops = &pwm_imx27_ops;
>  
>  	imx->mmio_base = devm_platform_ioremap_resource(pdev, 0);
> 
> -- 
> 2.34.1
> 

