Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4195675498C
	for <lists+linux-pwm@lfdr.de>; Sat, 15 Jul 2023 17:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbjGOPEv (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 15 Jul 2023 11:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjGOPEu (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 15 Jul 2023 11:04:50 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A45D32738
        for <linux-pwm@vger.kernel.org>; Sat, 15 Jul 2023 08:04:47 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id e9e14a558f8ab-345ff33d286so13749315ab.3
        for <linux-pwm@vger.kernel.org>; Sat, 15 Jul 2023 08:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1689433487; x=1692025487;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8gOGWAD6wBVovUk2BHvSqIfOjzXSeVMRftgvw0qpfvg=;
        b=Dq890GHuhMH3ZbDuB9bZXTLcJD42Y7MTkD+Fb+3WQZMCsN4S7EW/o8q/zy8vwm1ewH
         2WkvXs/uUU5MO+7s5tdCYy4R3zwhpiOhhGqAdRIClaywsmn8BLqJ+kFswcWpdylW3Acc
         9+WnXhEzLih006uvdqL9Mpf+JT/dQS0WEP7V8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689433487; x=1692025487;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8gOGWAD6wBVovUk2BHvSqIfOjzXSeVMRftgvw0qpfvg=;
        b=cWZAhKfTHdV9eaPM1oDMYahWUyBlMP+dxs8W6rLqNA3QdMfM3sI7Ezd0Ob3nCyROgN
         dibKc4+fPD4WJj5W8t0cCM5hqVd1Y2/kIha2znXb5sGaWgWHKxlKm/4APVOB8g9IB8If
         ooxGMsFNu5f5BMjvMAIzZzkBOodHECSWeYNRHzDzAu67AWnZlNqA4GRj7FEpXkM+CIyw
         R9XlufsX+IGWQGOJwgXPnuHKfQyP8JV+Zwzsjdgcin8p3Kc9TlprJQjmNoDWatO667qJ
         vfUIi7tg0MSzRjelVDkZ7Pnx1Fs1mIP9eKKdtnp1glXHHk5kgcaF17LiAts8aHyHqXGg
         iU/Q==
X-Gm-Message-State: ABy/qLZpAk6M6Eq/pl8DhQqQksD+K6y5l4MJ6/CAWzGcT8Th/Owg+Pcl
        bWcgHoLQ4hPXu8bndFIDkciLuw==
X-Google-Smtp-Source: APBJJlFLQ3qqt+bf2ZY7TjorWA6fP5Mtk4I1NR6VlGwIKrAhe/fQRo9Dg0t06pQGdEpXhw8baAKnrg==
X-Received: by 2002:a6b:917:0:b0:77e:3e85:34ee with SMTP id t23-20020a6b0917000000b0077e3e8534eemr7761979ioi.13.1689433487040;
        Sat, 15 Jul 2023 08:04:47 -0700 (PDT)
Received: from [10.211.55.3] (c-98-61-227-136.hsd1.mn.comcast.net. [98.61.227.136])
        by smtp.googlemail.com with ESMTPSA id z16-20020a6b5c10000000b0076373f90e46sm3414217ioh.33.2023.07.15.08.04.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Jul 2023 08:04:46 -0700 (PDT)
Message-ID: <f8aec2a1-45ae-712f-db60-f923f2bf2a5b@ieee.org>
Date:   Sat, 15 Jul 2023 10:04:45 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 10/10] staging: greybus: pwm: Consistenly name pwm_chip
 variables "chip"
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        kernel@pengutronix.de, linux-pwm@vger.kernel.org
References: <20230714205623.2496590-1-u.kleine-koenig@pengutronix.de>
 <20230714205623.2496590-11-u.kleine-koenig@pengutronix.de>
From:   Alex Elder <elder@ieee.org>
In-Reply-To: <20230714205623.2496590-11-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 7/14/23 3:56 PM, Uwe Kleine-König wrote:
> All function parameters of type pointer to struct pwm_chip in this
> driver are called chip which is also the usual name of function
> parameters and local variables in most other pwm drivers. For consistency
> use the same name for the local variable of that type.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Looks good to me.

Reviewed-by: Alex Elder <elder@linaro.org>

> ---
>   drivers/staging/greybus/pwm.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/staging/greybus/pwm.c b/drivers/staging/greybus/pwm.c
> index 88da1d796f13..c483e1f0738e 100644
> --- a/drivers/staging/greybus/pwm.c
> +++ b/drivers/staging/greybus/pwm.c
> @@ -267,7 +267,7 @@ static int gb_pwm_probe(struct gbphy_device *gbphy_dev,
>   {
>   	struct gb_connection *connection;
>   	struct gb_pwm_chip *pwmc;
> -	struct pwm_chip *pwm;
> +	struct pwm_chip *chip;
>   	int ret;
>   
>   	pwmc = kzalloc(sizeof(*pwmc), GFP_KERNEL);
> @@ -295,13 +295,13 @@ static int gb_pwm_probe(struct gbphy_device *gbphy_dev,
>   	if (ret)
>   		goto exit_connection_disable;
>   
> -	pwm = &pwmc->chip;
> +	chip = &pwmc->chip;
>   
> -	pwm->dev = &gbphy_dev->dev;
> -	pwm->ops = &gb_pwm_ops;
> -	pwm->npwm = pwmc->pwm_max + 1;
> +	chip->dev = &gbphy_dev->dev;
> +	chip->ops = &gb_pwm_ops;
> +	chip->npwm = pwmc->pwm_max + 1;
>   
> -	ret = pwmchip_add(pwm);
> +	ret = pwmchip_add(chip);
>   	if (ret) {
>   		dev_err(&gbphy_dev->dev,
>   			"failed to register PWM: %d\n", ret);

