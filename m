Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB6237EB0D4
	for <lists+linux-pwm@lfdr.de>; Tue, 14 Nov 2023 14:27:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbjKNN1S (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 14 Nov 2023 08:27:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231203AbjKNN1R (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 14 Nov 2023 08:27:17 -0500
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 598CB1AD
        for <linux-pwm@vger.kernel.org>; Tue, 14 Nov 2023 05:27:13 -0800 (PST)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3AEBsRff018227;
        Tue, 14 Nov 2023 14:27:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        message-id:date:mime-version:subject:to:cc:references:from
        :in-reply-to:content-type:content-transfer-encoding; s=
        selector1; bh=evZjVgwNaw4PqAniLHTlx6HSvZiK4aPjgz4DN6JbtEE=; b=ZY
        jhMjn7iwqbtdi2N3Kx2rv3UXSETDp0I5t9ygiPKpsfqbxaRUDB3EYyfdM3WhUaBG
        5V/w97UBuKZo6QRHiE5SBhbMQxFFF+digA02j1ertnsvJCspb8pggGAPUEJkfpmO
        tNvN2Zv9947ZRT1+BQUrKffx46YxuWjHJqb1XXG7nTcZqrk92WzIJoNDfdiVpI8m
        UIgeanoMQFiuSgy02tCbCOQ759gNreC4vNnPLjjAMozrt8HSnSXrUi5D6tYDd2UJ
        /IfHXmUlU/ncu9jc5k2xzuHbKrDb5Og3O7JvZ+q0E+HzowY8y7/WMpuRvGcWkkjz
        nav4kEdeDbw3QtPeAM9g==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ua1ch3yed-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Nov 2023 14:27:00 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0097B100038;
        Tue, 14 Nov 2023 14:26:58 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id ECD922122EF;
        Tue, 14 Nov 2023 14:26:58 +0100 (CET)
Received: from [10.201.20.59] (10.201.20.59) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 14 Nov
 2023 14:26:57 +0100
Message-ID: <09b09170-697e-44ac-aae1-581ba29481bf@foss.st.com>
Date:   Tue, 14 Nov 2023 14:26:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] pwm: stm32: Implement .get_state()
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
 <20231019200658.1754190-11-u.kleine-koenig@pengutronix.de>
From:   Fabrice Gasnier <fabrice.gasnier@foss.st.com>
In-Reply-To: <20231019200658.1754190-11-u.kleine-koenig@pengutronix.de>
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
> Implement the &pwm_ops->get_state callback so drivers can inherit PWM
> state set by the bootloader.
> 
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> [ukl: split off from a patch that also fixes clk enable count in .probe()]
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/pwm/pwm-stm32.c | 42 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
> 

Hi Uwe,

You can add my:
Reviewed-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>

Thanks,
Fabrice

> diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
> index cc6cae07c02c..68239567a564 100644
> --- a/drivers/pwm/pwm-stm32.c
> +++ b/drivers/pwm/pwm-stm32.c
> @@ -471,8 +471,50 @@ static int stm32_pwm_apply_locked(struct pwm_chip *chip, struct pwm_device *pwm,
>  	return ret;
>  }
>  
> +static int stm32_pwm_get_state(struct pwm_chip *chip,
> +			       struct pwm_device *pwm, struct pwm_state *state)
> +{
> +	struct stm32_pwm *priv = to_stm32_pwm_dev(chip);
> +	int ch = pwm->hwpwm;
> +	unsigned long rate;
> +	u32 ccer, psc, arr, ccr;
> +	u64 dty, prd;
> +	int ret;
> +
> +	mutex_lock(&priv->lock);
> +
> +	ret = regmap_read(priv->regmap, TIM_CCER, &ccer);
> +	if (ret)
> +		goto out;
> +
> +	state->enabled = ccer & (TIM_CCER_CC1E << (ch * 4));
> +	state->polarity = (ccer & (TIM_CCER_CC1P << (ch * 4))) ?
> +			  PWM_POLARITY_INVERSED : PWM_POLARITY_NORMAL;
> +	ret = regmap_read(priv->regmap, TIM_PSC, &psc);
> +	if (ret)
> +		goto out;
> +	ret = regmap_read(priv->regmap, TIM_ARR, &arr);
> +	if (ret)
> +		goto out;
> +	ret = regmap_read(priv->regmap, TIM_CCR1 + 4 * ch, &ccr);
> +	if (ret)
> +		goto out;
> +
> +	rate = clk_get_rate(priv->clk);
> +
> +	prd = (u64)NSEC_PER_SEC * (psc + 1) * (arr + 1);
> +	state->period = DIV_ROUND_UP_ULL(prd, rate);
> +	dty = (u64)NSEC_PER_SEC * (psc + 1) * ccr;
> +	state->duty_cycle = DIV_ROUND_UP_ULL(dty, rate);
> +
> +out:
> +	mutex_unlock(&priv->lock);
> +	return ret;
> +}
> +
>  static const struct pwm_ops stm32pwm_ops = {
>  	.apply = stm32_pwm_apply_locked,
> +	.get_state = stm32_pwm_get_state,
>  	.capture = IS_ENABLED(CONFIG_DMA_ENGINE) ? stm32_pwm_capture : NULL,
>  };
>  
