Return-Path: <linux-pwm+bounces-1775-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E1687D14A
	for <lists+linux-pwm@lfdr.de>; Fri, 15 Mar 2024 17:40:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FD96B21B20
	for <lists+linux-pwm@lfdr.de>; Fri, 15 Mar 2024 16:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F3291E4A1;
	Fri, 15 Mar 2024 16:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="Yy62tgn3"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7AEE1C2B2
	for <linux-pwm@vger.kernel.org>; Fri, 15 Mar 2024 16:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710520832; cv=none; b=vGQoEn2cu3Tevd6ayXVI1HwpirzG0+IhuRxhk6AvTuQMbC90+UWJccXeQxAwMME/wQLg7cZzjcddi5XxiFPZsXOsWWFoG2m7gwAki7ACdR4v10YYAV0wbUYObMcju7PNC0O5MGW63z/CzajrCbtdYUvP3FFX/r6usPjncnSUKyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710520832; c=relaxed/simple;
	bh=8utTH7njzJkXKPLE5cqUe/ga97JXC3TCRWDp+Bt/R1E=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=nD5tkLvf/oc2XbCHFjF75RJQEf4xGthpvNnH6b/nqw0qP5GusX1/9xOaywTRtAJ/K5B2kcjy2sZBYtbqApkUy1vZW7GU23LEfpACR62AK8dMw782TY1olLCwl/0WcJmlYZ0W+YkDmuHHezAEOiPog1L2clcjFGBeZGEaGsxwSTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=Yy62tgn3; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42FEkFZJ021920;
	Fri, 15 Mar 2024 17:40:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	selector1; bh=8yeqzO7B3mr+EiV0jNhU6eDDqyUYHa/uGezqm7wGIkE=; b=Yy
	62tgn3Hs4grXiop+HVWVvKqNlc14T5Jo0qKRA+dy4ZrcehKjkKVOS02Yzbkq/EqE
	deDE2uk+QO6Ya+Yj6rKoFubJJu9A99/DXSJv6rkgMXRR/Yu3PUTn1LO+RGEmnPYK
	3vHCXCDEs0anPL5igDIUFqXCQuBYwsmdLgSU65gb31u62WaFU7mD+egLTgUoDG2Y
	dZUA/vcyz6t1o4HMMX5tZnflVOJIcYAZXYeJnlwLBSyWgBIyeQXJACtiZPv0+C5v
	eLhsc82Bn70D4IK/by7RUXr03LuNcezsjN9Ua27B7A3FBZvE4md7lj1+Y7yYeSZc
	BXaBEBQGxisDhQoiw6MQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3wv9y9ut90-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Mar 2024 17:40:02 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id A03034002D;
	Fri, 15 Mar 2024 17:39:58 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id CBF7D2801CF;
	Fri, 15 Mar 2024 17:39:36 +0100 (CET)
Received: from [10.252.9.197] (10.252.9.197) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 15 Mar
 2024 17:39:35 +0100
Message-ID: <861cb184-42ee-4f27-9b0c-3129d52cc706@foss.st.com>
Date: Fri, 15 Mar 2024 17:39:34 +0100
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pwm: stm32: Add error messages in .probe()'s error paths
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        <linux-pwm@vger.kernel.org>
CC: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue
	<alexandre.torgue@foss.st.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>
References: <20240315145443.982807-2-u.kleine-koenig@pengutronix.de>
Content-Language: en-US
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
In-Reply-To: <20240315145443.982807-2-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-15_04,2024-03-13_01,2023-05-22_02

On 3/15/24 15:54, Uwe Kleine-König wrote:
> Giving an indication about the problem if probing a device fails is a
> nice move. Do that for the stm32 pwm driver.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Hi Uwe,

Thanks for your patch, you can add my:
Reviewed-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>

Best Regards,
Fabrice

> ---
>  drivers/pwm/pwm-stm32.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
> index 0c028d17c075..ffe572b76174 100644
> --- a/drivers/pwm/pwm-stm32.c
> +++ b/drivers/pwm/pwm-stm32.c
> @@ -648,11 +648,13 @@ static int stm32_pwm_probe(struct platform_device *pdev)
>  	priv->max_arr = ddata->max_arr;
>  
>  	if (!priv->regmap || !priv->clk)
> -		return -EINVAL;
> +		return dev_err_probe(dev, -EINVAL, "Failed to get %s\n",
> +				     priv->regmap ? "clk" : "regmap");
>  
>  	ret = stm32_pwm_probe_breakinputs(priv, np);
>  	if (ret)
> -		return ret;
> +		return dev_err_probe(dev, ret,
> +				     "Failed to configure breakinputs\n");
>  
>  	stm32_pwm_detect_complementary(priv);
>  
> @@ -664,7 +666,8 @@ static int stm32_pwm_probe(struct platform_device *pdev)
>  
>  	ret = devm_pwmchip_add(dev, chip);
>  	if (ret < 0)
> -		return ret;
> +		return dev_err_probe(dev, ret,
> +				     "Failed to register pwmchip\n");
>  
>  	platform_set_drvdata(pdev, chip);
>  
> 
> base-commit: dd6c6d57ab61d496f6ff7d6ca38611062af142a1

