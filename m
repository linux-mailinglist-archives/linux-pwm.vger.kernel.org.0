Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD2E635A59
	for <lists+linux-pwm@lfdr.de>; Wed, 23 Nov 2022 11:41:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236065AbiKWKkH (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 23 Nov 2022 05:40:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237642AbiKWKjf (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 23 Nov 2022 05:39:35 -0500
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E62114ECAA
        for <linux-pwm@vger.kernel.org>; Wed, 23 Nov 2022 02:23:54 -0800 (PST)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AN9OPFc021301;
        Wed, 23 Nov 2022 11:23:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=SGry+RXaYobNxy94dZwABKmwWE82iqGqvu00CijFF8M=;
 b=GpGtTYpFtxCpqHIlejYPePZfPJ5MY2h6GVphcH1wfLwAuTF4NjoUL5w/Ah8dVtUEubJ6
 zLO7GOjHsFxvOPfaAX3uLQT822tlVn3gLk3dpJzgcNoVsgTSm2jqE2Jc4wnjVYbmZlDP
 6YdqctjGM3XFKHkn3BwLq6C+h8zlMLbVZskc+P+crJrYiT5zRTx//SS+WNarktoUB2r6
 L9m9lBC7K655OqyAjnDi7Xos4Txs1W4u6WooEXSf32O3cqG2GULbuPtLz3NzMbiF7qu2
 cyQvtIXCb7DWsIdnZZ4+19wfXMLdISE2dyDyk9lRAMbrh6jBKxrbB3VmWfqgv0ZJ6SB6 3Q== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3kxrax7xh0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Nov 2022 11:23:34 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 598A1100039;
        Wed, 23 Nov 2022 11:23:31 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 52CBB218CFF;
        Wed, 23 Nov 2022 11:23:31 +0100 (CET)
Received: from [10.48.1.102] (10.48.1.102) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.13; Wed, 23 Nov
 2022 11:23:28 +0100
Message-ID: <11ecd39d-af16-ed8e-6d70-cbb369e387c5@foss.st.com>
Date:   Wed, 23 Nov 2022 11:23:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 5/5] pwm: stm32: Use regmap_clear_bits and regmap_set_bits
 where applicable
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     Mark Brown <broonie@kernel.org>, <linux-pwm@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <kernel@pengutronix.de>
References: <20221115111347.3705732-1-u.kleine-koenig@pengutronix.de>
 <20221115111347.3705732-6-u.kleine-koenig@pengutronix.de>
From:   Fabrice Gasnier <fabrice.gasnier@foss.st.com>
In-Reply-To: <20221115111347.3705732-6-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.48.1.102]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-23_04,2022-11-23_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 11/15/22 12:13, Uwe Kleine-König wrote:
> Found using coccinelle and the following semantic patch:
> 
> @@
> expression map, reg, bits;
> @@
> 
> - regmap_update_bits(map, reg, bits, bits)
> + regmap_set_bits(map, reg, bits)
> 
> @@
> expression map, reg, bits;
> @@
> 
> - regmap_update_bits(map, reg, bits, 0)
> + regmap_clear_bits(map, reg, bits)
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/pwm/pwm-stm32.c | 34 ++++++++++++++++------------------
>  1 file changed, 16 insertions(+), 18 deletions(-)

Hi Uwe,

You can add my:
Tested-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>

Best Regards,
Thanks
Fabrice

> 
> diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
> index 794ca5b02968..21e4a34dfff3 100644
> --- a/drivers/pwm/pwm-stm32.c
> +++ b/drivers/pwm/pwm-stm32.c
> @@ -115,14 +115,14 @@ static int stm32_pwm_raw_capture(struct stm32_pwm *priv, struct pwm_device *pwm,
>  	int ret;
>  
>  	/* Ensure registers have been updated, enable counter and capture */
> -	regmap_update_bits(priv->regmap, TIM_EGR, TIM_EGR_UG, TIM_EGR_UG);
> -	regmap_update_bits(priv->regmap, TIM_CR1, TIM_CR1_CEN, TIM_CR1_CEN);
> +	regmap_set_bits(priv->regmap, TIM_EGR, TIM_EGR_UG);
> +	regmap_set_bits(priv->regmap, TIM_CR1, TIM_CR1_CEN);
>  
>  	/* Use cc1 or cc3 DMA resp for PWM input channels 1 & 2 or 3 & 4 */
>  	dma_id = pwm->hwpwm < 2 ? STM32_TIMERS_DMA_CH1 : STM32_TIMERS_DMA_CH3;
>  	ccen = pwm->hwpwm < 2 ? TIM_CCER_CC12E : TIM_CCER_CC34E;
>  	ccr = pwm->hwpwm < 2 ? TIM_CCR1 : TIM_CCR3;
> -	regmap_update_bits(priv->regmap, TIM_CCER, ccen, ccen);
> +	regmap_set_bits(priv->regmap, TIM_CCER, ccen);
>  
>  	/*
>  	 * Timer DMA burst mode. Request 2 registers, 2 bursts, to get both
> @@ -160,8 +160,8 @@ static int stm32_pwm_raw_capture(struct stm32_pwm *priv, struct pwm_device *pwm,
>  	}
>  
>  stop:
> -	regmap_update_bits(priv->regmap, TIM_CCER, ccen, 0);
> -	regmap_update_bits(priv->regmap, TIM_CR1, TIM_CR1_CEN, 0);
> +	regmap_clear_bits(priv->regmap, TIM_CCER, ccen);
> +	regmap_clear_bits(priv->regmap, TIM_CR1, TIM_CR1_CEN);
>  
>  	return ret;
>  }
> @@ -359,7 +359,7 @@ static int stm32_pwm_config(struct stm32_pwm *priv, int ch,
>  
>  	regmap_write(priv->regmap, TIM_PSC, prescaler);
>  	regmap_write(priv->regmap, TIM_ARR, prd - 1);
> -	regmap_update_bits(priv->regmap, TIM_CR1, TIM_CR1_ARPE, TIM_CR1_ARPE);
> +	regmap_set_bits(priv->regmap, TIM_CR1, TIM_CR1_ARPE);
>  
>  	/* Calculate the duty cycles */
>  	dty = prd * duty_ns;
> @@ -377,7 +377,7 @@ static int stm32_pwm_config(struct stm32_pwm *priv, int ch,
>  	else
>  		regmap_update_bits(priv->regmap, TIM_CCMR2, mask, ccmr);
>  
> -	regmap_update_bits(priv->regmap, TIM_BDTR, TIM_BDTR_MOE, TIM_BDTR_MOE);
> +	regmap_set_bits(priv->regmap, TIM_BDTR, TIM_BDTR_MOE);
>  
>  	return 0;
>  }
> @@ -411,13 +411,13 @@ static int stm32_pwm_enable(struct stm32_pwm *priv, int ch)
>  	if (priv->have_complementary_output)
>  		mask |= TIM_CCER_CC1NE << (ch * 4);
>  
> -	regmap_update_bits(priv->regmap, TIM_CCER, mask, mask);
> +	regmap_set_bits(priv->regmap, TIM_CCER, mask);
>  
>  	/* Make sure that registers are updated */
> -	regmap_update_bits(priv->regmap, TIM_EGR, TIM_EGR_UG, TIM_EGR_UG);
> +	regmap_set_bits(priv->regmap, TIM_EGR, TIM_EGR_UG);
>  
>  	/* Enable controller */
> -	regmap_update_bits(priv->regmap, TIM_CR1, TIM_CR1_CEN, TIM_CR1_CEN);
> +	regmap_set_bits(priv->regmap, TIM_CR1, TIM_CR1_CEN);
>  
>  	return 0;
>  }
> @@ -431,11 +431,11 @@ static void stm32_pwm_disable(struct stm32_pwm *priv, int ch)
>  	if (priv->have_complementary_output)
>  		mask |= TIM_CCER_CC1NE << (ch * 4);
>  
> -	regmap_update_bits(priv->regmap, TIM_CCER, mask, 0);
> +	regmap_clear_bits(priv->regmap, TIM_CCER, mask);
>  
>  	/* When all channels are disabled, we can disable the controller */
>  	if (!active_channels(priv))
> -		regmap_update_bits(priv->regmap, TIM_CR1, TIM_CR1_CEN, 0);
> +		regmap_clear_bits(priv->regmap, TIM_CR1, TIM_CR1_CEN);
>  
>  	clk_disable(priv->clk);
>  }
> @@ -568,10 +568,9 @@ static void stm32_pwm_detect_complementary(struct stm32_pwm *priv)
>  	 * If complementary bit doesn't exist writing 1 will have no
>  	 * effect so we can detect it.
>  	 */
> -	regmap_update_bits(priv->regmap,
> -			   TIM_CCER, TIM_CCER_CC1NE, TIM_CCER_CC1NE);
> +	regmap_set_bits(priv->regmap, TIM_CCER, TIM_CCER_CC1NE);
>  	regmap_read(priv->regmap, TIM_CCER, &ccer);
> -	regmap_update_bits(priv->regmap, TIM_CCER, TIM_CCER_CC1NE, 0);
> +	regmap_clear_bits(priv->regmap, TIM_CCER, TIM_CCER_CC1NE);
>  
>  	priv->have_complementary_output = (ccer != 0);
>  }
> @@ -585,10 +584,9 @@ static int stm32_pwm_detect_channels(struct stm32_pwm *priv)
>  	 * If channels enable bits don't exist writing 1 will have no
>  	 * effect so we can detect and count them.
>  	 */
> -	regmap_update_bits(priv->regmap,
> -			   TIM_CCER, TIM_CCER_CCXE, TIM_CCER_CCXE);
> +	regmap_set_bits(priv->regmap, TIM_CCER, TIM_CCER_CCXE);
>  	regmap_read(priv->regmap, TIM_CCER, &ccer);
> -	regmap_update_bits(priv->regmap, TIM_CCER, TIM_CCER_CCXE, 0);
> +	regmap_clear_bits(priv->regmap, TIM_CCER, TIM_CCER_CCXE);
>  
>  	if (ccer & TIM_CCER_CC1E)
>  		npwm++;
