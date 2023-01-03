Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 975DE65BFEE
	for <lists+linux-pwm@lfdr.de>; Tue,  3 Jan 2023 13:34:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbjACMeM (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 3 Jan 2023 07:34:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230337AbjACMeM (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 3 Jan 2023 07:34:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51998FD39
        for <linux-pwm@vger.kernel.org>; Tue,  3 Jan 2023 04:34:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EEA75B80E4D
        for <linux-pwm@vger.kernel.org>; Tue,  3 Jan 2023 12:34:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 464C4C433EF;
        Tue,  3 Jan 2023 12:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672749248;
        bh=Zv0HsH9alRe3Jbp1PCQVCB97IUwOrnBLb1PFj5noLvA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H3/rMFsQkZ3HRh69JTFc5GNCuxsaem2VgYzhg3lormXHW92nyLCqSKHKl/TTdmTnm
         4+ES9BkLkNgzL1WcY/yxGnglu8W5P+ZYfSwr7bV/Nyug7ydPjs8yxyzFz65cb+FUqg
         3Ap7KpEIdCNjxkzgzsfLrrRxAogANSp9YiLNYZ3K50RQHWXtgbKfHAj4/cIMrOihEM
         BeFRQ+S7rBGVdZAj93i9kWtYT6XVGdJoDj4QWQN6Tx/UqUP4vLQe+VVi0MZ5t5nTpC
         vrdVNUWdscq/nJkN7Sq1Sa9WyxugJrcM8zvtuvWlVTMd0680wZ21pxT/LwZqptm+9Q
         r4LSYSaV6TXNQ==
Date:   Tue, 3 Jan 2023 12:34:03 +0000
From:   Lee Jones <lee@kernel.org>
To:     Olivier Moysan <olivier.moysan@foss.st.com>
Cc:     Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        linux-pwm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] pwm: stm32: enforce settings for pwm capture
Message-ID: <Y7Qgu8ugq/l7JzwU@google.com>
References: <20221213102707.1096345-1-olivier.moysan@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221213102707.1096345-1-olivier.moysan@foss.st.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, 13 Dec 2022, Olivier Moysan wrote:

> The PWM capture assumes that the input selector is set to default
> input and that the slave mode is disabled. Force reset state for
> TISEL and SMCR registers to match this requirement.
> 
> Note that slave mode disabling is not a pre-requisite by itself
> for capture mode, as hardware supports it for PWM capture.
> However, the current implementation of the driver does not
> allow slave mode for PWM capture. Setting slave mode for PWM
> capture results in wrong capture values.
> 
> Fixes: 53e38fe73f94 ("pwm: stm32: Add capture support")
> Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
> ---
>  drivers/pwm/pwm-stm32.c          | 4 ++++
>  include/linux/mfd/stm32-timers.h | 1 +

Acked-by: Lee Jones <lee@kernel.org>

>  2 files changed, 5 insertions(+)
> 
> diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
> index 794ca5b02968..24aab0450c78 100644
> --- a/drivers/pwm/pwm-stm32.c
> +++ b/drivers/pwm/pwm-stm32.c
> @@ -207,6 +207,10 @@ static int stm32_pwm_capture(struct pwm_chip *chip, struct pwm_device *pwm,
>  	regmap_write(priv->regmap, TIM_ARR, priv->max_arr);
>  	regmap_write(priv->regmap, TIM_PSC, psc);
>  
> +	/* Reset input selector to its default input and disable slave mode */
> +	regmap_write(priv->regmap, TIM_TISEL, 0x0);
> +	regmap_write(priv->regmap, TIM_SMCR, 0x0);
> +
>  	/* Map TI1 or TI2 PWM input to IC1 & IC2 (or TI3/4 to IC3 & IC4) */
>  	regmap_update_bits(priv->regmap,
>  			   pwm->hwpwm < 2 ? TIM_CCMR1 : TIM_CCMR2,
> diff --git a/include/linux/mfd/stm32-timers.h b/include/linux/mfd/stm32-timers.h
> index 5f5c43fd69dd..1b94325febb3 100644
> --- a/include/linux/mfd/stm32-timers.h
> +++ b/include/linux/mfd/stm32-timers.h
> @@ -31,6 +31,7 @@
>  #define TIM_BDTR	0x44	/* Break and Dead-Time Reg */
>  #define TIM_DCR		0x48	/* DMA control register    */
>  #define TIM_DMAR	0x4C	/* DMA register for transfer */
> +#define TIM_TISEL	0x68	/* Input Selection         */
>  
>  #define TIM_CR1_CEN	BIT(0)	/* Counter Enable	   */
>  #define TIM_CR1_DIR	BIT(4)  /* Counter Direction	   */
> -- 
> 2.25.1
> 

-- 
Lee Jones [李琼斯]
