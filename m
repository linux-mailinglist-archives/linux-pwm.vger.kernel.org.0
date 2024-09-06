Return-Path: <linux-pwm+bounces-3123-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1847B96F46F
	for <lists+linux-pwm@lfdr.de>; Fri,  6 Sep 2024 14:41:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 448C51C20899
	for <lists+linux-pwm@lfdr.de>; Fri,  6 Sep 2024 12:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C53A2158853;
	Fri,  6 Sep 2024 12:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="omyyWlJP"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D561CBE90
	for <linux-pwm@vger.kernel.org>; Fri,  6 Sep 2024 12:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725626491; cv=none; b=AgulITglsDD95lNzMEiRvqRv427aGP5cvwBU/qgy3ScVSidLdPz/RblDSQWZ8CCAP3iRAlkWEyTGRG+iAgXoBrXIqJmQDg/BvF8OKQcxP6a1N4/PeRC9vURCGfVEnJ75hMy+QAQua5GrHt2AzCn0WDGd/mHnGNxurOOVj3foEJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725626491; c=relaxed/simple;
	bh=0WSIZxbfFQ7q9NWKEA6HUNGrRXt512xUY0elXKj+9Pk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=q4XnBCVdLmINs9PRj1aRAq5Z/MzDzukeFziC72oDR75nuUlc562dYDXBNRgqU4cXyHdNGsh26z4T7ZDk+1fx9/VrB/Or5P7hY+//cYpvjI3pxeQXcJHqjgbUzbvS7H8pb7wgz82Hr/zEoU/3vRtxvTN4Jc4ZrOfFMnqLF7yH80g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=omyyWlJP; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 486CFkcU026449;
	Fri, 6 Sep 2024 14:41:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	9glpbHtTCF0WQ+AaJaOaFsxFPEJjjJaHTg3W5Y5Bp00=; b=omyyWlJPa9o0uo1+
	rGeatWEl+pXoj9ycdqbKTyoJ5oVf3TLtXnOjURW0cMLACakQIjCLgjMxQp4qZn4B
	dx7fnQOEWISQU83czPa171rTK2sJKe+WdAg0AicIX3xYMn9dXJz2n1XUdE7LYmzq
	G2qHETv5uZHny/UtT9bonPS8z91mxZHHKpG+Wm+ml5PxSzs8oO9Qcp+B0pTKd5A3
	wIX2KYjEOxCOI0ydZl62/KogksqzIQ9fmBYhjKwo2LcZDXL7rhaQ6lJ4UohD1joe
	Th+DaDN8iATMIQJNE/6if74J7lQL81w9jVCReburdimKUsprxW7kD/2/64FA2wtR
	lbCU4g==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 41fhwquf07-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Sep 2024 14:41:11 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id A01C440044;
	Fri,  6 Sep 2024 14:40:25 +0200 (CEST)
Received: from Webmail-eu.st.com (eqndag1node6.st.com [10.75.129.135])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id EC087267F26;
	Fri,  6 Sep 2024 14:40:02 +0200 (CEST)
Received: from SAFDAG1NODE1.st.com (10.75.90.17) by EQNDAG1NODE6.st.com
 (10.75.129.135) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Fri, 6 Sep
 2024 14:40:02 +0200
Received: from [10.48.86.222] (10.48.86.222) by SAFDAG1NODE1.st.com
 (10.75.90.17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Fri, 6 Sep
 2024 14:40:02 +0200
Message-ID: <07ad0918-c1bf-4ae2-8091-33e75aac4778@foss.st.com>
Date: Fri, 6 Sep 2024 14:40:01 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pwm: stm32: Use the right CCxNP bit in stm32_pwm_enable()
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
        <linux-pwm@vger.kernel.org>
CC: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue
	<alexandre.torgue@foss.st.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>
References: <20240905090627.197536-2-u.kleine-koenig@baylibre.com>
Content-Language: en-US
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
In-Reply-To: <20240905090627.197536-2-u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SAFDAG1NODE1.st.com
 (10.75.90.17)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_02,2024-09-05_01,2024-09-02_01



On 9/5/24 11:06, Uwe Kleine-König wrote:
> The pwm devices for a pwm_chip are numbered starting at 0, the first hw
> channel however has the number 1. While introducing a parametrised macro
> to simplify register bit usage and making that offset explicit, one of
> the usages was converted wrongly. This is fixed here.
> 
> Fixes: 7cea05ae1d4e ("pwm-stm32: Make use of parametrised register definitions")
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
> ---
> Hello,
> 
> during review of a patch to the stm32 pwm driver Fabrice pointed out a
> wrong usage of TIM_CCER_CCxNE. While (I think) we both assumed this was
> a problem in said patch, that problem existed already before and the
> proposed change just moved the problem around. So instead of (only)
> updating the patch later, here comes a separate fix for the driver.
> 
> I intend to send this to Linus tomorrow to get it into 6.11-rc7.

Hi UWe,

Good catch, I haven't noticed this has been introduced in earlier patch.

You can add my:
Reviewed-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>

Does it need to be CC'ed to stable list also ?

Thanks,
BR,
Fabrice

> 
> Best regards
> Uwe
> 
>  drivers/pwm/pwm-stm32.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
> index fd754a99cf2e..f85eb41cb084 100644
> --- a/drivers/pwm/pwm-stm32.c
> +++ b/drivers/pwm/pwm-stm32.c
> @@ -412,7 +412,7 @@ static int stm32_pwm_enable(struct stm32_pwm *priv, unsigned int ch)
>  	/* Enable channel */
>  	mask = TIM_CCER_CCxE(ch + 1);
>  	if (priv->have_complementary_output)
> -		mask |= TIM_CCER_CCxNE(ch);
> +		mask |= TIM_CCER_CCxNE(ch + 1);
>  
>  	regmap_set_bits(priv->regmap, TIM_CCER, mask);
>  
> base-commit: 8400291e289ee6b2bf9779ff1c83a291501f017b

