Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB7367CF38
	for <lists+linux-pwm@lfdr.de>; Thu, 26 Jan 2023 16:07:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231846AbjAZPHN (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 26 Jan 2023 10:07:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjAZPHM (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 26 Jan 2023 10:07:12 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6859F48A24;
        Thu, 26 Jan 2023 07:07:11 -0800 (PST)
Received: from notapiano (unknown [IPv6:2600:4041:5b1a:cd00:524d:e95d:1a9c:492a])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1D9B06602E6E;
        Thu, 26 Jan 2023 15:07:09 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1674745630;
        bh=Ky0b++ybJbVNuqVRHMRXowRfT9Paz4o9u/pczWd8hKo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jCpm+mYDIaxj7I2OC4CjFRbivVH6XZY67zfCXl03rs+PYEeANB6wRvyngXR7Uc1uB
         VqqKnzMDwLOfNM+epFVDoiGbrftbZ25h3gGbbOcLRq2pi6yFAdsE2qnPbTLFwFpc2r
         xfToxQAH0Me5WUp5Nh+f3YOzCOcubTwbcYbCwACpsdO+RiqW+mhPBbs8IZ5j6fvCGJ
         vLCdVJMOnmEzq9Z3ikc09nnSLYFi5zY+XTJHjMpF52KRCCwT3MMZcJzWp6owZGR8DR
         HOUrXZ5DX+QvArVPZSSM28TRJC9ZhG5kmIinqnabTdy3a/PQoGhKmzLAMGcseUsHpd
         iKBNiLnhP8DUw==
Date:   Thu, 26 Jan 2023 10:06:50 -0500
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        matthias.bgg@gmail.com, weiqing.kong@mediatek.com,
        jitao.shi@mediatek.com, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCH 1/2] pwm: mtk-disp: Disable shadow registers before
 setting backlight values
Message-ID: <20230126150203.dnsbw2l2fzyg3oi5@notapiano>
References: <20230123160615.375969-1-angelogioacchino.delregno@collabora.com>
 <20230123160615.375969-2-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230123160615.375969-2-angelogioacchino.delregno@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, Jan 23, 2023 at 05:06:14PM +0100, AngeloGioacchino Del Regno wrote:
> If shadow registers usage is not desired, disable that before performing
> any write to CON0/1 registers in the .apply() callback, otherwise we may
> lose clkdiv or period/width updates.
> 
> Fixes: cd4b45ac449a ("pwm: Add MediaTek MT2701 display PWM driver support")
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  drivers/pwm/pwm-mtk-disp.c | 24 +++++++++++++-----------
>  1 file changed, 13 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-mtk-disp.c b/drivers/pwm/pwm-mtk-disp.c
> index 692a06121b28..82b430d881a2 100644
> --- a/drivers/pwm/pwm-mtk-disp.c
> +++ b/drivers/pwm/pwm-mtk-disp.c
> @@ -138,6 +138,19 @@ static int mtk_disp_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>  	high_width = mul_u64_u64_div_u64(state->duty_cycle, rate, div);
>  	value = period | (high_width << PWM_HIGH_WIDTH_SHIFT);
>  
> +	if (mdp->data->bls_debug && !mdp->data->has_commit) {
> +		/*
> +		 * For MT2701, disable double buffer before writing register

Not necessarily part of this series, but I guess it would make sense to remove
the "For MT2701". It's no longer exclusive to that SoC and the condition in the
if above makes it clear when this happens.

Reviewed-by: N�colas F. R. A. Prado <nfraprado@collabora.com>
Tested-by: N�colas F. R. A. Prado <nfraprado@collabora.com>

On MT8192 Asurada Spherion.

Thanks,
N�colas

> +		 * and select manual mode and use PWM_PERIOD/PWM_HIGH_WIDTH.
> +		 */
> +		mtk_disp_pwm_update_bits(mdp, mdp->data->bls_debug,
> +					 mdp->data->bls_debug_mask,
> +					 mdp->data->bls_debug_mask);
> +		mtk_disp_pwm_update_bits(mdp, mdp->data->con0,
> +					 mdp->data->con0_sel,
> +					 mdp->data->con0_sel);
> +	}
> +
>  	mtk_disp_pwm_update_bits(mdp, mdp->data->con0,
>  				 PWM_CLKDIV_MASK,
>  				 clk_div << PWM_CLKDIV_SHIFT);
> @@ -152,17 +165,6 @@ static int mtk_disp_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>  		mtk_disp_pwm_update_bits(mdp, mdp->data->commit,
>  					 mdp->data->commit_mask,
>  					 0x0);
> -	} else {
> -		/*
> -		 * For MT2701, disable double buffer before writing register
> -		 * and select manual mode and use PWM_PERIOD/PWM_HIGH_WIDTH.
> -		 */
> -		mtk_disp_pwm_update_bits(mdp, mdp->data->bls_debug,
> -					 mdp->data->bls_debug_mask,
> -					 mdp->data->bls_debug_mask);
> -		mtk_disp_pwm_update_bits(mdp, mdp->data->con0,
> -					 mdp->data->con0_sel,
> -					 mdp->data->con0_sel);
>  	}
>  
>  	mtk_disp_pwm_update_bits(mdp, DISP_PWM_EN, mdp->data->enable_mask,
> -- 
> 2.39.0
> 
> 
