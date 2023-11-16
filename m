Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 670E17EE387
	for <lists+linux-pwm@lfdr.de>; Thu, 16 Nov 2023 15:59:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345378AbjKPO77 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 16 Nov 2023 09:59:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345377AbjKPO76 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 16 Nov 2023 09:59:58 -0500
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D27CD5A
        for <linux-pwm@vger.kernel.org>; Thu, 16 Nov 2023 06:59:54 -0800 (PST)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3AGEb9US015530;
        Thu, 16 Nov 2023 15:59:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        message-id:date:mime-version:subject:to:cc:references:from
        :in-reply-to:content-type:content-transfer-encoding; s=
        selector1; bh=VcgYHId+3Co15KQMFgacBowjpEeoDBueQbWQxDh7oX0=; b=qA
        57mKutUYPigVOkghwCkp1KH5CFD1InLqTKndEHOCZLCwpuT+4YlDsfjnbxz2qWsT
        quplqgeKhS/Gi63vX2w3BBl7y7un6Wy3hEWwNipJvONehtoYSY3bW7xzx4bC8BA7
        YnVMEmTaXAcO3iyjODV7semzU6H1K1zQeISOjeAeAl+eR7UDsvaLqZT+LqzYA6DG
        3/x85B9iFC4VleaunO2R/yAp7feJ6Q96Qg2JVEz0XK1TKJIx8tOi0yHfykYeEj+b
        8kIuTsqeskLu+OGo5IPrJwZi80vYO/KR3qHqvQbjun5utOL0wGVFcVj+NYciOqUA
        sHm7pOxmJHdGXucjkVag==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3udn0m02v7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Nov 2023 15:59:50 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E70B2100056;
        Thu, 16 Nov 2023 15:59:49 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E0507233C84;
        Thu, 16 Nov 2023 15:59:49 +0100 (CET)
Received: from [10.201.20.59] (10.201.20.59) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 16 Nov
 2023 15:59:49 +0100
Message-ID: <045e7e79-db14-40c1-bc87-8c0dcb76afbd@foss.st.com>
Date:   Thu, 16 Nov 2023 15:59:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pwm: stm32: Mark capture support as broken
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>
CC:     <linux-pwm@vger.kernel.org>, <kernel@pengutronix.de>
References: <20231115211815.441067-1-u.kleine-koenig@pengutronix.de>
From:   Fabrice Gasnier <fabrice.gasnier@foss.st.com>
In-Reply-To: <20231115211815.441067-1-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.201.20.59]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-16_15,2023-11-16_01,2023-05-22_02
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 11/15/23 22:18, Uwe Kleine-König wrote:
> As described in the added comment, calling capture on one channel stops
> all PWM output on the other channels. While it probably isn't hard to
> fix, I cannot test it. Also this bug supports my guess that capture

Hi Uwe,

No, there's a check in stm32_pwm_capture() not to break a running PWM
channel:

	if (active_channels(priv)) {
		ret = -EBUSY;
		goto unlock;
	}

> isn't used in practise. So instead of an untested fix, mark capture
> support as broken. If indeed there are users this will hopefully make
> them speak up and provide a tested fix.

That looks like a revival of earlier discussion[1] to deprecate the
capture interface[1].

[1]
https://lore.kernel.org/linux-pwm/Yz%2F4V0gH%2FvrWSS8U@orome/T/#mc5fb080c2576e3c2558a646dc5db40f6ff00c9b0

Please notice there's a on-going work to move on the counter interface
to support capture[1]. There's still some pending work & review at my
end to address.
So I don't agree to mark this as broken. For now, there may be users
without alternative.

Best Regards,
Fabrice

> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/pwm/pwm-stm32.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
> index 3303a754ea02..20705bc814f1 100644
> --- a/drivers/pwm/pwm-stm32.c
> +++ b/drivers/pwm/pwm-stm32.c
> @@ -488,7 +488,13 @@ static int stm32_pwm_apply_locked(struct pwm_chip *chip, struct pwm_device *pwm,
>  
>  static const struct pwm_ops stm32pwm_ops = {
>  	.apply = stm32_pwm_apply_locked,
> -	.capture = IS_ENABLED(CONFIG_DMA_ENGINE) ? stm32_pwm_capture : NULL,
> +	/*
> +	 * stm32_pwm_raw_capture() (which is called by stm32_pwm_capture())
> +	 * unconditionally clears TIM_CR1_CEN. So capturing on one channel
> +	 * results in stopping all PWM outputs on the other channels of the same
> +	 * chip.
> +	 */
> +	.capture = IS_ENABLED(CONFIG_BROKEN) && IS_ENABLED(CONFIG_DMA_ENGINE) ? stm32_pwm_capture : NULL,
>  };
>  
>  static int stm32_pwm_set_breakinput(struct stm32_pwm *priv,
> 
> base-commit: b85ea95d086471afb4ad062012a4d73cd328fa86
