Return-Path: <linux-pwm+bounces-2829-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CBABD9330AC
	for <lists+linux-pwm@lfdr.de>; Tue, 16 Jul 2024 20:49:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 666BFB22DB9
	for <lists+linux-pwm@lfdr.de>; Tue, 16 Jul 2024 18:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E3C61A0714;
	Tue, 16 Jul 2024 18:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="En/lnwRE"
X-Original-To: linux-pwm@vger.kernel.org
Received: from msa.smtpout.orange.fr (msa-213.smtpout.orange.fr [193.252.23.213])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9511BC43;
	Tue, 16 Jul 2024 18:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.23.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721155757; cv=none; b=PZWG0kGbSOhyq3POBayZ0djL0whx6H5liWw+LI2l63hK8Ta4eCMS35nMUfeKSRsH+mEQ9NVmcHFF7k74k/nGTQxDNn1Gs9Qn4PVWvXFwPP2JJt4hVWtdzrkBnH77ae5GriFhCNHnpfQgdtKz4eYywsR48clvpIfC7cevL2cf1Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721155757; c=relaxed/simple;
	bh=JbHDzSk339pVt8FIkuVLH3SiTT1tiWmH6YYuqnIdXf4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uatbMia3Hb9jNBzz9B+mM15VOLAQrilZj67V+AL3VNT2buWSqeGwoI5t0hnCu9AwgnzA/2RfRd2sbfqMp/1gLW88knyVrO/BarB65aCTO764UD9S86JOd2iObKiX7sld+aIWCnLcdH0JuIwt+8UadOnqQwkKnqtZTcKNIoI44Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=En/lnwRE; arc=none smtp.client-ip=193.252.23.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id TnEWsVD3Ct4p9TnEWsmpjH; Tue, 16 Jul 2024 20:49:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1721155746;
	bh=Y9EqEgYNw6i/aumvZC5AG9uD8+LrAD0SR2i8Uffr6Gs=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=En/lnwREl/G1EMb4RmSKJtvC4NiyhXrykXj1RwOoNswa7dbPoEsQgHQU0Sq4DSQ62
	 +XAmm0b5MBjP9jBcNjj6U+y1lWbiIGMdoraox5vYhYOJb7KfgRFD08gLN/GiGuCnRU
	 z4qCFv8XFq+4mCDEwDM872MrIn5dg11YmAUxwbSHxQPjXCUw0vcBEtu1KcvC6/iAOp
	 8LvJ62Zb910kd8JnO2uQRn40gDfVhR4xwU1pbFp+X77SiXMruTvCbvB/E02mtFpSLn
	 UJwldAPapM+L6c2XYpxcd7Tq/e9De1enJDSkwhQLplQNc1pavi+nXCxdjfSzsvoGLe
	 UnnxYIQQeaShw==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Tue, 16 Jul 2024 20:49:06 +0200
X-ME-IP: 90.11.132.44
Message-ID: <4cdcfde7-1b79-411d-9a1b-131105b113ab@wanadoo.fr>
Date: Tue, 16 Jul 2024 20:49:04 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] pwm: imx27: Add 32k clock for pwm in i.MX8QXP MIPI
 subsystem
To: Frank Li <Frank.Li@nxp.com>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, festevam@gmail.com,
 francesco@dolcini.it, imx@lists.linux.dev, kernel@pengutronix.de,
 krzk+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
 p.zabel@pengutronix.de, pratikmanvar09@gmail.com, robh@kernel.org,
 s.hauer@pengutronix.de, shawnguo@kernel.org, ukleinek@kernel.org,
 victor.liu@nxp.com
References: <20240715-pwm-v2-0-ff3eece83cbb@nxp.com>
 <20240715-pwm-v2-2-ff3eece83cbb@nxp.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20240715-pwm-v2-2-ff3eece83cbb@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 15/07/2024 à 22:29, Frank Li a écrit :
> From: Liu Ying <victor.liu-3arQi8VN3Tc@public.gmane.org>
> 
> PWM in i.MX8QXP MIPI subsystem needs the clock '32k'. Use it if the DTS
> provides that.
> 
> Signed-off-by: Liu Ying <victor.liu-3arQi8VN3Tc@public.gmane.org>
> Signed-off-by: Frank Li <Frank.Li-3arQi8VN3Tc@public.gmane.org>
> ---
> Change from v1 to v2
> - remove if check for clk
> - use dev_err_probe
> - remove int val

Hi,

maybe, switching to clk_bulk_get_all() and the clk_bulk API would 
simplify the code?

See [1] for a similar discussion related to devicetrees and binding if 
such a change is done.
I'm not familiar with it, so I just point it out.

Just my 2c.

CJ

[1]: 
https://lore.kernel.org/all/65b422fe-ecc1-4f57-bb72-f2fef3a5af28@collabora.com/

> ---
>   drivers/pwm/pwm-imx27.c | 26 +++++++++++++++++++++-----
>   1 file changed, 21 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-imx27.c b/drivers/pwm/pwm-imx27.c
> index 9e2bbf5b4a8ce..253afe94c4776 100644
> --- a/drivers/pwm/pwm-imx27.c
> +++ b/drivers/pwm/pwm-imx27.c
> @@ -15,6 +15,7 @@
>   #include <linux/delay.h>
>   #include <linux/err.h>
>   #include <linux/io.h>
> +#include <linux/iopoll.h>
>   #include <linux/kernel.h>
>   #include <linux/module.h>
>   #include <linux/of.h>
> @@ -82,6 +83,7 @@
>   struct pwm_imx27_chip {
>   	struct clk	*clk_ipg;
>   	struct clk	*clk_per;
> +	struct clk	*clk_32k;
>   	void __iomem	*mmio_base;
>   
>   	/*
> @@ -101,23 +103,32 @@ static int pwm_imx27_clk_prepare_enable(struct pwm_imx27_chip *imx)
>   {
>   	int ret;
>   
> +	ret = clk_prepare_enable(imx->clk_32k);
> +	if (ret)
> +		goto err1;
> +
>   	ret = clk_prepare_enable(imx->clk_ipg);
>   	if (ret)
> -		return ret;
> +		goto err2;
>   
>   	ret = clk_prepare_enable(imx->clk_per);
> -	if (ret) {
> -		clk_disable_unprepare(imx->clk_ipg);
> -		return ret;
> -	}
> +	if (ret)
> +		goto err3;
>   
>   	return 0;
> +err3:
> +	clk_disable_unprepare(imx->clk_ipg);
> +err2:
> +	clk_disable_unprepare(imx->clk_32k);
> +err1:
> +	return ret;
>   }
>   
>   static void pwm_imx27_clk_disable_unprepare(struct pwm_imx27_chip *imx)
>   {
>   	clk_disable_unprepare(imx->clk_per);
>   	clk_disable_unprepare(imx->clk_ipg);
> +	clk_disable_unprepare(imx->clk_32k);
>   }
>   
>   static int pwm_imx27_get_state(struct pwm_chip *chip,
> @@ -325,6 +336,11 @@ static int pwm_imx27_probe(struct platform_device *pdev)
>   		return dev_err_probe(&pdev->dev, PTR_ERR(imx->clk_per),
>   				     "failed to get peripheral clock\n");
>   
> +	imx->clk_32k = devm_clk_get_optional(&pdev->dev, "32k");
> +	if (IS_ERR(imx->clk_32k))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(imx->clk_32k),
> +				     "failed to get 32k clock\n");
> +
>   	chip->ops = &pwm_imx27_ops;
>   
>   	imx->mmio_base = devm_platform_ioremap_resource(pdev, 0);
> 


