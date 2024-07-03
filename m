Return-Path: <linux-pwm+bounces-2688-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE51B925E9A
	for <lists+linux-pwm@lfdr.de>; Wed,  3 Jul 2024 13:38:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DD3B1C23CEC
	for <lists+linux-pwm@lfdr.de>; Wed,  3 Jul 2024 11:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDBD2185E78;
	Wed,  3 Jul 2024 11:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="R8bLTIY4"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04607178384;
	Wed,  3 Jul 2024 11:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720006299; cv=none; b=OfsRMQ0UwjRqkflh5jblzSOfbH/hyGB/1DoazB4BBR4FJAWhk2TBiFknBF559ceEbvOIkSd40snp35xhSQdeWJqgXZiTz53+ZDCxSZp4hu44eFHD00lPC/LUXw28t5NVhN8TWaUJiYqweNST+orpW9UNhVxrABcabeNR2u1yFhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720006299; c=relaxed/simple;
	bh=vZi55+d/iX+EuvKV8mN+e7KkXuHSSU/Dtl2KCpiRmP0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=TxVXCTNO4xhj/YhSJJFXInbRJlYYK+0gasUXO3Vt0tdZ3kuT0vf0CAZKDwsZj8UPD6IgDRtQfB43Y8zAyM4wQutwcfS+P06gcBwyRTgai4ccmCsVk7CFjoP6v1b9/st8ntGb6yi3S3R9RTQIFi85O43cVy1VGnxXq2UI6a/u+Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=R8bLTIY4; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4639QCoB025213;
	Wed, 3 Jul 2024 06:31:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=f37i3vEXbnh14lMCwflrH5FfWLKGacpcQ9pw+V8X0GM=; b=
	R8bLTIY48RtsMO5W33X+WUtLDu015SRIt038i3YUvPba2aFZ7qg1vmymuu0VzVPR
	dTOIzN4nyuQGhE4jknIXboTsF2dzcFPkPmeWIKcJtCmEgaVgMrjEmIzccsKy9Y8V
	gTkxIHEYLW6x2BHovPiV3+uVqxE3yIOULX083IeUlFzfdF+H+7Nu9fF09fxUfNvo
	7GJ3s/dORuiyVA+rpnqAre/JMlyS014k+dTNzTwfeLkP53pduKo/9QGu+mEYVHBV
	mg+Esn5db3/+dmU+PB4khD9QCkxVtDsMDxYJgYoBe209i/M/ETe4MjdHBOmpSoKg
	DCKOVEz1XZpndZXCmxku/g==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 402epjd9kw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jul 2024 06:31:30 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 3 Jul 2024
 12:31:29 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Wed, 3 Jul 2024 12:31:29 +0100
Received: from [198.90.208.18] (ediswws06.ad.cirrus.com [198.90.208.18])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id E8801820244;
	Wed,  3 Jul 2024 11:31:28 +0000 (UTC)
Message-ID: <0796b481-3eec-4618-b92e-a372b7da5381@opensource.cirrus.com>
Date: Wed, 3 Jul 2024 12:31:28 +0100
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/20] ASoC: arizona: convert to
 of_property_for_each_u32_new()
To: Luca Ceresoli <luca.ceresoli@bootlin.com>,
        Miguel Ojeda
	<ojeda@kernel.org>, Rob Herring <robh@kernel.org>,
        Saravana Kannan
	<saravanak@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Michael
 Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Tony
 Lindgren <tony@atomide.com>,
        Bjorn Andersson <andersson@kernel.org>,
        =?UTF-8?Q?Emilio_L=C3=B3pez?= <emilio@elopez.com.ar>,
        Chen-Yu Tsai
	<wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland
	<samuel@sholland.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Daniel Lezcano
	<daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Florian
 Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review
 list <bcm-kernel-feedback-list@broadcom.com>,
        Linus Walleij
	<linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Jonathan
 Cameron <jic23@kernel.org>, Lee Jones <lee@kernel.org>,
        Shawn Guo
	<shawnguo@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Richard
 Leitner <richard.leitner@linux.dev>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "Naveen N. Rao"
	<naveen.n.rao@linux.ibm.com>,
        Damien Le Moal <dlemoal@kernel.org>
CC: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        Thomas Petazzoni
	<thomas.petazzoni@bootlin.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <llvm@lists.linux.dev>, <linux-clk@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-sunxi@lists.linux.dev>,
        <linux-samsung-soc@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        <linux-serial@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <patches@opensource.cirrus.com>, <linux-sound@vger.kernel.org>,
        <linuxppc-dev@lists.ozlabs.org>, <linux-riscv@lists.infradead.org>
References: <20240703-of_property_for_each_u32-v1-0-42c1fc0b82aa@bootlin.com>
 <20240703-of_property_for_each_u32-v1-17-42c1fc0b82aa@bootlin.com>
Content-Language: en-GB
From: Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <20240703-of_property_for_each_u32-v1-17-42c1fc0b82aa@bootlin.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 76f180QPbr034NdfsL7n2lcoXt87nILT
X-Proofpoint-ORIG-GUID: 76f180QPbr034NdfsL7n2lcoXt87nILT
X-Proofpoint-Spam-Reason: safe

On 03/07/2024 11:37, Luca Ceresoli wrote:
> Simplify code using of_property_for_each_u32_new() as the two additional
> parameters in of_property_for_each_u32() are not used here.
> 
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> ---
>   sound/soc/codecs/arizona.c | 12 +++++-------
>   1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
> index 7434aeeda292..1a64b9815809 100644
> --- a/sound/soc/codecs/arizona.c
> +++ b/sound/soc/codecs/arizona.c
> @@ -2786,15 +2786,13 @@ int arizona_of_get_audio_pdata(struct arizona *arizona)
>   {
>   	struct arizona_pdata *pdata = &arizona->pdata;
>   	struct device_node *np = arizona->dev->of_node;
> -	struct property *prop;
> -	const __be32 *cur;
>   	u32 val;
>   	u32 pdm_val[ARIZONA_MAX_PDM_SPK];
>   	int ret;
>   	int count = 0;
>   
>   	count = 0;
> -	of_property_for_each_u32(np, "wlf,inmode", prop, cur, val) {
> +	of_property_for_each_u32_new(np, "wlf,inmode", val) {
>   		if (count == ARRAY_SIZE(pdata->inmode))
>   			break;
>   
> @@ -2803,7 +2801,7 @@ int arizona_of_get_audio_pdata(struct arizona *arizona)
>   	}
>   
>   	count = 0;
> -	of_property_for_each_u32(np, "wlf,dmic-ref", prop, cur, val) {
> +	of_property_for_each_u32_new(np, "wlf,dmic-ref", val) {
>   		if (count == ARRAY_SIZE(pdata->dmic_ref))
>   			break;
>   
> @@ -2812,7 +2810,7 @@ int arizona_of_get_audio_pdata(struct arizona *arizona)
>   	}
>   
>   	count = 0;
> -	of_property_for_each_u32(np, "wlf,out-mono", prop, cur, val) {
> +	of_property_for_each_u32_new(np, "wlf,out-mono", val) {
>   		if (count == ARRAY_SIZE(pdata->out_mono))
>   			break;
>   
> @@ -2821,7 +2819,7 @@ int arizona_of_get_audio_pdata(struct arizona *arizona)
>   	}
>   
>   	count = 0;
> -	of_property_for_each_u32(np, "wlf,max-channels-clocked", prop, cur, val) {
> +	of_property_for_each_u32_new(np, "wlf,max-channels-clocked", val) {
>   		if (count == ARRAY_SIZE(pdata->max_channels_clocked))
>   			break;
>   
> @@ -2830,7 +2828,7 @@ int arizona_of_get_audio_pdata(struct arizona *arizona)
>   	}
>   
>   	count = 0;
> -	of_property_for_each_u32(np, "wlf,out-volume-limit", prop, cur, val) {
> +	of_property_for_each_u32_new(np, "wlf,out-volume-limit", val) {
>   		if (count == ARRAY_SIZE(pdata->out_vol_limit))
>   			break;
>   
> 
Reviewed-by: Richard Fitzgerald <rf@opensource.cirrus.com>

