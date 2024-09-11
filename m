Return-Path: <linux-pwm+bounces-3206-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 420E4975BD2
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Sep 2024 22:35:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E31D287C4C
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Sep 2024 20:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F88B1BBBF2;
	Wed, 11 Sep 2024 20:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="kyD3opri"
X-Original-To: linux-pwm@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FDD21BB69A;
	Wed, 11 Sep 2024 20:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726086880; cv=none; b=EfriqOWEGa940Yvtf/FJG1DKKi0k+ewpmJiwVC5AHtdqmDb2Cbj+DQshyYkYUKkTjK2bW9m9zgN6Kh5sykWdPV3PsPhY9b40XqQsuhzwEH2z67DbYsdai1lqG6XJAmPVOx5rhIclPFV1Zy8Gdu4fnZjsejL+IdbRRIiGqV57Sng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726086880; c=relaxed/simple;
	bh=gEudtiPCzCxVqopBXaUE/SMC6Te12ig5VrFW1mJA2L0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bWzA4D82OK6UISPOMTP0CWniuWtaIzr1Hn4O6OP/mzM9kxWTsKrW5m4csjPPf1Xj1uDWaEv5fJWGl/p/adSDoWFlLizZJeeq9q1deFdYnON2vZAnHMpZlZDmrNTDDL/tyqZb7YabD7n1IrejpekAVHnEqDtb2G0lmoLabGeJp8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=kyD3opri; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 7A4CC88A0D;
	Wed, 11 Sep 2024 22:34:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1726086876;
	bh=Ok+BUDNrfexcljnvB4T1qmpytCr6OBWgfdYb5mlMJSY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kyD3opri7Bs+bmNEaHbYZKs6HiNYTJNVNJehYTgQIoTnR4//QQ2hiznLOmkgZWzc5
	 FX5wurs8IWh0ByqSbp1GmGLmqRTqr4xCSQ9ZyuSjUsSCga0f27mL3UzBDTW6BfXSVR
	 UEDw2LIc8IuMVVBj7pvaaFiv3+qp21DMnrxJoh+LFoY1pmk//lwT7CRaY2STIoSDMY
	 FyzbLlY7rkdzLwbA7e7Fcl+YVWNdFobpZk20Mef72rSOoN5XlEITke61iZtj53z1IM
	 0thot4wtoK7PEn2QOGCn4yzWjmJRYT5bvv6R3AjI+1tmXODSZtCw4NseKFV0mkP/SP
	 ctqlqCsrQrkYw==
Message-ID: <40ecdbb2-8470-4e33-8a74-ccae6532174a@denx.de>
Date: Wed, 11 Sep 2024 22:31:40 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] pwm: imx27: Add optional 32k clock for pwm in
 i.MX8QXP MIPI subsystem
To: Frank Li <Frank.Li@nxp.com>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
 <ukleinek@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, pratikmanvar09@gmail.com,
 francesco@dolcini.it, Liu Ying <victor.liu@nxp.com>
References: <20240910-pwm-v3-0-fbb047896618@nxp.com>
 <20240910-pwm-v3-3-fbb047896618@nxp.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240910-pwm-v3-3-fbb047896618@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 9/10/24 9:07 PM, Frank Li wrote:
> From: Liu Ying <victor.liu@nxp.com>
> 
> PWM in i.MX8QXP MIPI subsystem needs the clock '32k'. Use it if the DTS
> provides that.
> 
> Signed-off-by: Liu Ying <victor.liu@nxp.com>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> Change from v2 to v3
> - use buck clk API
> 
> Change from v1 to v2
> - remove if check for clk
> - use dev_err_probe
> - remove int val
> ---
>   drivers/pwm/pwm-imx27.c | 13 ++++++++++++-
>   1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pwm/pwm-imx27.c b/drivers/pwm/pwm-imx27.c
> index ce9208540f1b8..2a9fba6f9d0a8 100644
> --- a/drivers/pwm/pwm-imx27.c
> +++ b/drivers/pwm/pwm-imx27.c
> @@ -81,10 +81,11 @@
>   #define MX3_PWMPR_MAX			0xfffe
>   
>   static const char * const pwm_imx27_clks[] = {"ipg", "per"};
> +static const char * const pwm_imx27_opt_clks[] = {"32k"};
>   #define PWM_IMX27_PER			1
>   
>   struct pwm_imx27_chip {
> -	struct clk_bulk_data clks[ARRAY_SIZE(pwm_imx27_clks)];
> +	struct clk_bulk_data clks[ARRAY_SIZE(pwm_imx27_clks) + ARRAY_SIZE(pwm_imx27_opt_clks)];
>   	int clks_cnt;
>   	void __iomem	*mmio_base;
>   
> @@ -371,6 +372,16 @@ static int pwm_imx27_probe(struct platform_device *pdev)
>   		return dev_err_probe(&pdev->dev, ret,
>   				     "getting clocks failed\n");
>   
> +	for (i = 0; i < ARRAY_SIZE(pwm_imx27_opt_clks); i++)
> +		imx->clks[i + imx->clks_cnt].id = pwm_imx27_opt_clks[i];
> +
> +	ret = devm_clk_bulk_get_optional(&pdev->dev, ARRAY_SIZE(pwm_imx27_opt_clks),
> +					 imx->clks + imx->clks_cnt);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret, "get optional clocks failed\n");
> +
> +	imx->clks_cnt += ARRAY_SIZE(pwm_imx27_opt_clks);
> +

This will succeed even if the regular PWM clock are invalid or not 
present, wouldn't it? I don't think removing that protection is an 
improvement.

Also, it is not clear whether the 32kHz clock are really supplying the 
PWM, see my comment on 1/3 in this series.

