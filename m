Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1676576465B
	for <lists+linux-pwm@lfdr.de>; Thu, 27 Jul 2023 07:59:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbjG0F75 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 27 Jul 2023 01:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbjG0F74 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 27 Jul 2023 01:59:56 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 301BF92
        for <linux-pwm@vger.kernel.org>; Wed, 26 Jul 2023 22:59:55 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id 6a1803df08f44-63d2b7d77bfso4360256d6.3
        for <linux-pwm@vger.kernel.org>; Wed, 26 Jul 2023 22:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1690437594; x=1691042394;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7Q/MVEZh/dayqwddeCvnC4H216XnM0Geeo+ApH94KXE=;
        b=lfkasZE2beA/u8e8/ZK7+BcwATeWD0PdFFhHspfjXgmF5GJKG/iLnZRuD6WSi+ePTR
         UIKP1JjUY9L3vzvRgBH7wC9jPxsaJhrnKAwxYBOGPbMxZ7uos6jVMNmAyZ4LQGJbWdDR
         kq1dxJdz964Jctomx72yhY4nA80Yj94ue2MWgEEHFlr1nr1Dy7vhQtPOEx9K8oX8V3oR
         HfYHpWcRXRLN3OfwziM+UuV1eE/UF9FEUFWGfaRWQ0mUm1JBtgdP2pg32sztnYrrezir
         2zl4jvf5exigvWwka/huCMCWLJ3RDc0ko+Wj8Uhyh2xsRDLLmw9tLRmpHRjPc2B5jl2J
         YbrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690437594; x=1691042394;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7Q/MVEZh/dayqwddeCvnC4H216XnM0Geeo+ApH94KXE=;
        b=Opw4TLJmcKwMEiFbjTUw36GytFoGmi6/SIy42f7QD96PyL4ex9jiyZD9nT49qYFZU6
         rJ1dPgTkN20w1BlS+USkPtby0dP0sF/MrTaOVSAj0Ph72Sk1mC+z7Zxdw0RfDT2+vz8o
         S9otukGYiKsSojLIscj5RNmf8Mt3Lx7JwtheKJ/eXmDMDvTRPFsWjOqyhX7ROYrRKtOz
         fsh+5BLzxFYJy4N4pMKd3XMKggiFd6i4A8W5MCkVc0w0NmOQGFqZibvRnXdC/0CawUWo
         X4hikQClMzQXJujTi+C3ib57skX3dHN802EQg5HFtYyYWFJgkLDyRshfQEFYuHU5bs4T
         yz8Q==
X-Gm-Message-State: ABy/qLbSG1OuEYJxE7Wtp7QA+kNhoP3uQUrCgL2lsdOXgywMeV2k3In4
        /bjyVlzquCmI975jFkLsrF09+w==
X-Google-Smtp-Source: APBJJlEffbQSrk0Y43Ba6VHY01oc4IyQVXvTAkE5DyJytuDJ4lxfm1L9QU8X+hVkNp1fK64s8bTnPA==
X-Received: by 2002:a05:620a:4d2:b0:767:3d52:fb7 with SMTP id 18-20020a05620a04d200b007673d520fb7mr4215962qks.61.1690437594338;
        Wed, 26 Jul 2023 22:59:54 -0700 (PDT)
Received: from [10.0.2.15] ([82.78.167.79])
        by smtp.gmail.com with ESMTPSA id j5-20020a170902c3c500b001bb40b880efsm622024plj.101.2023.07.26.22.59.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jul 2023 22:59:54 -0700 (PDT)
Message-ID: <6ec02864-6e18-d2c7-3ad6-e3c2c3df73e8@tuxon.dev>
Date:   Thu, 27 Jul 2023 08:59:45 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 4/5] pwm: atmel-tcb: Unroll atmel_tcb_pwm_set_polarity()
 into only caller
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de
References: <20230719192013.4051193-1-u.kleine-koenig@pengutronix.de>
 <20230719192013.4051193-5-u.kleine-koenig@pengutronix.de>
From:   claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20230719192013.4051193-5-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org



On 19.07.2023 22:20, Uwe Kleine-König wrote:
> atmel_tcb_pwm_set_polarity() is only called once and effectively wraps
> an assignment only. Replace the function call by the respective
> assignment.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>

> ---
>   drivers/pwm/pwm-atmel-tcb.c | 17 +++--------------
>   1 file changed, 3 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-atmel-tcb.c b/drivers/pwm/pwm-atmel-tcb.c
> index ae274bd7907d..32a60d7f8ed2 100644
> --- a/drivers/pwm/pwm-atmel-tcb.c
> +++ b/drivers/pwm/pwm-atmel-tcb.c
> @@ -68,18 +68,6 @@ static inline struct atmel_tcb_pwm_chip *to_tcb_chip(struct pwm_chip *chip)
>   	return container_of(chip, struct atmel_tcb_pwm_chip, chip);
>   }
>   
> -static int atmel_tcb_pwm_set_polarity(struct pwm_chip *chip,
> -				      struct pwm_device *pwm,
> -				      enum pwm_polarity polarity)
> -{
> -	struct atmel_tcb_pwm_chip *tcbpwmc = to_tcb_chip(chip);
> -	struct atmel_tcb_pwm_device *tcbpwm = &tcbpwmc->pwms[pwm->hwpwm];
> -
> -	tcbpwm->polarity = polarity;
> -
> -	return 0;
> -}
> -
>   static int atmel_tcb_pwm_request(struct pwm_chip *chip,
>   				 struct pwm_device *pwm)
>   {
> @@ -357,11 +345,12 @@ static int atmel_tcb_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
>   static int atmel_tcb_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>   			       const struct pwm_state *state)
>   {
> +	struct atmel_tcb_pwm_chip *tcbpwmc = to_tcb_chip(chip);
> +	struct atmel_tcb_pwm_device *tcbpwm = &tcbpwmc->pwms[pwm->hwpwm];
>   	int duty_cycle, period;
>   	int ret;
>   
> -	/* This function only sets a flag in driver data */
> -	atmel_tcb_pwm_set_polarity(chip, pwm, state->polarity);
> +	tcbpwm->polarity = state->polarity;
>   
>   	if (!state->enabled) {
>   		atmel_tcb_pwm_disable(chip, pwm);
