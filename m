Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD8D87EB0D2
	for <lists+linux-pwm@lfdr.de>; Tue, 14 Nov 2023 14:26:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232103AbjKNN04 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 14 Nov 2023 08:26:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbjKNN0z (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 14 Nov 2023 08:26:55 -0500
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FAB81A1
        for <linux-pwm@vger.kernel.org>; Tue, 14 Nov 2023 05:26:51 -0800 (PST)
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3AEDN0vU025095;
        Tue, 14 Nov 2023 14:26:45 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        message-id:date:mime-version:subject:to:cc:references:from
        :in-reply-to:content-type:content-transfer-encoding; s=
        selector1; bh=CDqcl3qizlmsvgyIJtirdFlv7IU9taiD9Ey6VLthwRE=; b=Oh
        npQaIjh4gMjm8jk76JXbItZteVmaqCbwKZt5Mudwu3QCkCFflqdH2ChRxCGlNKu+
        jW/hOHTg+geMEHQwUEJJ3xiHokDwIuxZp+OlJk2VU/4smxjFVDLWIWCGgeIJpcuK
        DIP/MHE+rOzS/Z6heQ0/3SLgkDvLuqJmwrmohUDi32ssGqTxu7NkAH9PPyY73SpI
        UDuvFPb/WzJYQvXryBwVeSaT1gR8NatG6RAH2eAkqR0HLm1hDsmcQIH6RC7cd5Qp
        +zk+5yPvdmBCxuRjfeX5XuD9mJd1/t/oExG/NBaoF+a0yllqWsZVP9iPRRzm7jZ4
        dSqGT7GYpabGNyLs/ihw==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3uam249hw9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Nov 2023 14:26:45 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 27477100038;
        Tue, 14 Nov 2023 14:26:45 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 1F25C2122E6;
        Tue, 14 Nov 2023 14:26:45 +0100 (CET)
Received: from [10.201.20.59] (10.201.20.59) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 14 Nov
 2023 14:26:43 +0100
Message-ID: <617f2adf-5dec-4caf-b4d4-a706c0a83f31@foss.st.com>
Date:   Tue, 14 Nov 2023 14:26:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] pwm: stm32: Use hweight32 in
 stm32_pwm_detect_channels
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>
CC:     Philipp Zabel <p.zabel@pengutronix.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        <linux-pwm@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <kernel@pengutronix.de>
References: <20231019200658.1754190-7-u.kleine-koenig@pengutronix.de>
 <20231019200658.1754190-10-u.kleine-koenig@pengutronix.de>
From:   Fabrice Gasnier <fabrice.gasnier@foss.st.com>
In-Reply-To: <20231019200658.1754190-10-u.kleine-koenig@pengutronix.de>
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
> Use hweight32() to count the CCxE bits in stm32_pwm_detect_channels().
> Since the return value is assigned to chip.npwm, change it to unsigned
> int as well.
> 
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/pwm/pwm-stm32.c | 17 ++---------------
>  1 file changed, 2 insertions(+), 15 deletions(-)

Hi Uwe,

You can add my:
Reviewed-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>

Thanks,
Fabrice

> 
> diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
> index 009f9c1a5eca..cc6cae07c02c 100644
> --- a/drivers/pwm/pwm-stm32.c
> +++ b/drivers/pwm/pwm-stm32.c
> @@ -563,10 +563,9 @@ static void stm32_pwm_detect_complementary(struct stm32_pwm *priv)
>  	priv->have_complementary_output = (ccer != 0);
>  }
>  
> -static int stm32_pwm_detect_channels(struct stm32_pwm *priv)
> +static unsigned int stm32_pwm_detect_channels(struct stm32_pwm *priv)
>  {
>  	u32 ccer;
> -	int npwm = 0;
>  
>  	/*
>  	 * If channels enable bits don't exist writing 1 will have no
> @@ -576,19 +575,7 @@ static int stm32_pwm_detect_channels(struct stm32_pwm *priv)
>  	regmap_read(priv->regmap, TIM_CCER, &ccer);
>  	regmap_clear_bits(priv->regmap, TIM_CCER, TIM_CCER_CCXE);
>  
> -	if (ccer & TIM_CCER_CC1E)
> -		npwm++;
> -
> -	if (ccer & TIM_CCER_CC2E)
> -		npwm++;
> -
> -	if (ccer & TIM_CCER_CC3E)
> -		npwm++;
> -
> -	if (ccer & TIM_CCER_CC4E)
> -		npwm++;
> -
> -	return npwm;
> +	return hweight32(ccer & TIM_CCER_CCXE);
>  }
>  
>  static int stm32_pwm_probe(struct platform_device *pdev)
