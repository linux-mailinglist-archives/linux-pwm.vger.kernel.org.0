Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA7B7EB0F7
	for <lists+linux-pwm@lfdr.de>; Tue, 14 Nov 2023 14:35:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbjKNNff (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 14 Nov 2023 08:35:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbjKNNff (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 14 Nov 2023 08:35:35 -0500
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A161BE
        for <linux-pwm@vger.kernel.org>; Tue, 14 Nov 2023 05:35:31 -0800 (PST)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3AEBvpL3018212;
        Tue, 14 Nov 2023 14:35:22 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        message-id:date:mime-version:subject:to:cc:references:from
        :in-reply-to:content-type:content-transfer-encoding; s=
        selector1; bh=uDF1LKg+LNckCmIf1p02zUMvTaTbnhhNepD4Klmyu/k=; b=zs
        A2lLz0eiu9VqRgd0YzfeEqMO2oxrvxCs9Jd8HWe59W1KqHVnJw5dxCQPQWZ4/UDJ
        4am576zZH7WAjWQSUH2Mk7LHibO0m3TAVhVl5mCn/sERQDyKEKbrt1ylHp7Jnlbo
        jQUUyG+rJy/Dv4a3i5Ma1z8mwdclibGWy6EOSo/LypWRHMPF4CbCMMszpI9L51X5
        Xhy1g8lpz8uAXYOMndoYXqbCUi3uQPw1lreevg4GpsuL0AnYRLGPELgQdhVM/cVm
        H3ITNr1dEdWY0+6F1I3f6xEOzRaN5fx9OW9cw5i54yyjBgV9ts381TCZ3L7nypkr
        4LUwnZnhay0A4MLkPXrA==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ua1ch40gt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Nov 2023 14:35:22 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6DC15100038;
        Tue, 14 Nov 2023 14:35:21 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 60FA42128CE;
        Tue, 14 Nov 2023 14:35:21 +0100 (CET)
Received: from [10.201.20.59] (10.201.20.59) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 14 Nov
 2023 14:35:20 +0100
Message-ID: <c2da3f60-595c-4938-809a-c5640388c13c@foss.st.com>
Date:   Tue, 14 Nov 2023 14:35:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] pwm: stm32: Fix enable count for clk in .probe()
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
 <20231019200658.1754190-12-u.kleine-koenig@pengutronix.de>
From:   Fabrice Gasnier <fabrice.gasnier@foss.st.com>
In-Reply-To: <20231019200658.1754190-12-u.kleine-koenig@pengutronix.de>
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
> Make the driver take over hardware state without disabling in .probe()
> and enable the clock for each enabled channel.
> 
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> [ukleinek: split off from a patch that also implemented .get_state()]
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/pwm/pwm-stm32.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)


Hi Uwe,

I'd only have a suggestion on the commit title:
pwm: stm32: Fix enable count for clk in .probe()
            ^
On first sight, the "Fix" may suggest that this fixes something older in
the tree. This would suggest a Fixes tag which isn't the case in this
series, as this is a split of the .get_state() patch.
Is it possible to rephrase ?
something like: set clk enable count when probing channels ?

Apart from that, you can add my:
Reviewed-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>

---
I've additional questions, unrelated to this patch. I had a look at
pwm-stm32-lp.c, the clock enabling is done directly in the .get_state()
routine. I think this should be moved to the .probe() routine as done
here. There's likely a risk, that clk enable count gets increased
artificially, at least since commit cfc4c189bc70 "pwm: Read initial
hardware state at request time".
Shall I send a patch for pwm-stm32-lp.c, similar as this patch ? Or has
it been spotted already ?

Best Regards,
Thanks,
Fabrice

> 
> diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
> index 68239567a564..97a2c3c09b69 100644
> --- a/drivers/pwm/pwm-stm32.c
> +++ b/drivers/pwm/pwm-stm32.c
> @@ -605,17 +605,21 @@ static void stm32_pwm_detect_complementary(struct stm32_pwm *priv)
>  	priv->have_complementary_output = (ccer != 0);
>  }
>  
> -static unsigned int stm32_pwm_detect_channels(struct stm32_pwm *priv)
> +static unsigned int stm32_pwm_detect_channels(struct stm32_pwm *priv,
> +					      unsigned int *num_enabled)
>  {
> -	u32 ccer;
> +	u32 ccer, ccer_backup;
>  
>  	/*
>  	 * If channels enable bits don't exist writing 1 will have no
>  	 * effect so we can detect and count them.
>  	 */
> +	regmap_read(priv->regmap, TIM_CCER, &ccer_backup);
>  	regmap_set_bits(priv->regmap, TIM_CCER, TIM_CCER_CCXE);
>  	regmap_read(priv->regmap, TIM_CCER, &ccer);
> -	regmap_clear_bits(priv->regmap, TIM_CCER, TIM_CCER_CCXE);
> +	regmap_write(priv->regmap, TIM_CCER, ccer_backup);
> +
> +	*num_enabled = hweight32(ccer_backup & TIM_CCER_CCXE);
>  
>  	return hweight32(ccer & TIM_CCER_CCXE);
>  }
> @@ -626,6 +630,8 @@ static int stm32_pwm_probe(struct platform_device *pdev)
>  	struct device_node *np = dev->of_node;
>  	struct stm32_timers *ddata = dev_get_drvdata(pdev->dev.parent);
>  	struct stm32_pwm *priv;
> +	unsigned int num_enabled;
> +	unsigned int i;
>  	int ret;
>  
>  	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> @@ -648,7 +654,11 @@ static int stm32_pwm_probe(struct platform_device *pdev)
>  
>  	priv->chip.dev = dev;
>  	priv->chip.ops = &stm32pwm_ops;
> -	priv->chip.npwm = stm32_pwm_detect_channels(priv);
> +	priv->chip.npwm = stm32_pwm_detect_channels(priv, &num_enabled);
> +
> +	/* Initialize clock refcount to number of enabled PWM channels. */
> +	for (i = 0; i < num_enabled; i++)
> +		clk_enable(priv->clk);
>  
>  	ret = devm_pwmchip_add(dev, &priv->chip);
>  	if (ret < 0)
