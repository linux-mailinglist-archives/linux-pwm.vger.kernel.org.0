Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B07FB7EB0CE
	for <lists+linux-pwm@lfdr.de>; Tue, 14 Nov 2023 14:26:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231203AbjKNN0p (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 14 Nov 2023 08:26:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbjKNN0p (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 14 Nov 2023 08:26:45 -0500
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A66361AA
        for <linux-pwm@vger.kernel.org>; Tue, 14 Nov 2023 05:26:41 -0800 (PST)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3AE9EmRn031609;
        Tue, 14 Nov 2023 14:26:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        message-id:date:mime-version:subject:to:cc:references:from
        :in-reply-to:content-type:content-transfer-encoding; s=
        selector1; bh=v6RHVxwutJkSi6Qco+qNtL7rvalniuJSr5bDH69HBw4=; b=Ja
        luzfrziUTgr5pbj04et5GPvMTssLHZgSX+oPmD48AIaNpxFPGdij8ZNcqIUyWd3Y
        G7x7dN2fKSwM4h2mreekTFLV/GpwA4eF2DwwlSXYQvFm6WiZWPzJC0q0goMsP5kY
        +8cbyGuDUk9yF8fuXM1vVIFL8+eKY8fGGZSZZfp16znrRd0Yvd633x/57P64kSbL
        aawFKASX3ca07xu8fIh3kIqLnNXY64y4DmhLnGPuy4YIfntvtJpGdRc1VysA5T7Y
        CP9jkZHmpEGdMQXeqNRcQ5OpwwqhHlBAfKVwCV6WdKNRMZ1E/pGrqmZoo1d32f7n
        c/F8MBRGIe6aosBI35Xg==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ua1u1uv72-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Nov 2023 14:26:29 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8A861100038;
        Tue, 14 Nov 2023 14:26:28 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 822642122E3;
        Tue, 14 Nov 2023 14:26:28 +0100 (CET)
Received: from [10.201.20.59] (10.201.20.59) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 14 Nov
 2023 14:26:27 +0100
Message-ID: <77d75b3e-f9b7-4360-9e92-223befc9b57b@foss.st.com>
Date:   Tue, 14 Nov 2023 14:26:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] pwm: stm32: Replace write_ccrx with regmap_write
To:     =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>
CC:     Philipp Zabel <p.zabel@pengutronix.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        <linux-pwm@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <kernel@pengutronix.de>
References: <20231019200658.1754190-7-u.kleine-koenig@pengutronix.de>
 <20231019200658.1754190-8-u.kleine-koenig@pengutronix.de>
Content-Language: en-US
From:   Fabrice Gasnier <fabrice.gasnier@foss.st.com>
In-Reply-To: <20231019200658.1754190-8-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.201.20.59]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-14_13,2023-11-09_01,2023-05-22_02
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 10/19/23 22:07, Uwe Kleine-König wrote:
> From: Philipp Zabel <p.zabel@pengutronix.de>
> 
> The TIM_CCR1...4 registers are consecutive, so replace the switch
> case with a simple calculation. Since ch is known to be in the 0...3
> range (it is set to hwpwm < npwm <= 4), drop the unnecessary error
> handling. The return value was not checked anyway. What remains does
> not warrant keeping the write_ccrx() function around, so instead call
> regmap_write() directly at the singular call site.
> 
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/pwm/pwm-stm32.c | 17 +----------------
>  1 file changed, 1 insertion(+), 16 deletions(-)

Hi Uwe,

Sorry for the late reply,
You can add my:
Reviewed-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>

Thanks,
Fabrice

> 
> diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
> index 3303a754ea02..5e48584e3bd4 100644
> --- a/drivers/pwm/pwm-stm32.c
> +++ b/drivers/pwm/pwm-stm32.c
> @@ -52,21 +52,6 @@ static u32 active_channels(struct stm32_pwm *dev)
>  	return ccer & TIM_CCER_CCXE;
>  }
>  
> -static int write_ccrx(struct stm32_pwm *dev, int ch, u32 value)
> -{
> -	switch (ch) {
> -	case 0:
> -		return regmap_write(dev->regmap, TIM_CCR1, value);
> -	case 1:
> -		return regmap_write(dev->regmap, TIM_CCR2, value);
> -	case 2:
> -		return regmap_write(dev->regmap, TIM_CCR3, value);
> -	case 3:
> -		return regmap_write(dev->regmap, TIM_CCR4, value);
> -	}
> -	return -EINVAL;
> -}
> -
>  #define TIM_CCER_CC12P (TIM_CCER_CC1P | TIM_CCER_CC2P)
>  #define TIM_CCER_CC12E (TIM_CCER_CC1E | TIM_CCER_CC2E)
>  #define TIM_CCER_CC34P (TIM_CCER_CC3P | TIM_CCER_CC4P)
> @@ -369,7 +354,7 @@ static int stm32_pwm_config(struct stm32_pwm *priv, int ch,
>  	dty = prd * duty_ns;
>  	do_div(dty, period_ns);
>  
> -	write_ccrx(priv, ch, dty);
> +	regmap_write(priv->regmap, TIM_CCR1 + 4 * ch, dty);
>  
>  	/* Configure output mode */
>  	shift = (ch & 0x1) * CCMR_CHANNEL_SHIFT;
