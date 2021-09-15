Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3DA40C2D8
	for <lists+linux-pwm@lfdr.de>; Wed, 15 Sep 2021 11:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232046AbhIOJiB (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 15 Sep 2021 05:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbhIOJiB (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 15 Sep 2021 05:38:01 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 597ECC061574;
        Wed, 15 Sep 2021 02:36:42 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id s3so3987266ljp.11;
        Wed, 15 Sep 2021 02:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RrwQh8igtNPDRK56BUFQSiyz5qFv9luSmitb0KLPd7M=;
        b=kC5e8IwyJkfK38bXodHqMJ16R7BvjeC96xLekpC5WDxgZkBqC0s6wNWHkXTeMWRTT/
         jG8uMsDaDzHOGYdFBZwKmIO+wJzaiWHlT9+eYjsohBxzOPDZwa6gXJp+Xj2Egnv5bGqV
         7cWB66GjpCf5sy99WRzm+yfTieJE+H4ULKzGV044wrclZzxMDrp3WOkSCZcvWyRUp2/E
         2bgJMj8MXT5JoYR+v7K2y1dO+fKgca+tuzHd9Ek2X4xVRjI0IojQ4ASC51bSMusMiBlq
         f3POS/Xq2WkrrtTElhOTNTkexBkxP1vQuo4nVLhWFe4nSe5JFxjFAM8ocIqAmwL+g6ye
         SOoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=RrwQh8igtNPDRK56BUFQSiyz5qFv9luSmitb0KLPd7M=;
        b=bJQ+FFlq1LalVsZq7zDsmdm1TMazteNIFIw+hNVYHnIDbpOGmjKq0m1u3ZMjPAlnqA
         ghLk+m036OVFRKQc9dxrKmYy8Mu7yxzE2nuMxHkP0Cpg2kC6emYW4Gbv5B6KTnvOFv/W
         jKEQ2Ur3sP+Q2bRDmZEAn0c0XaxOX26pgRARYqcmU8D99suMQkPRK+rmsDMH6zOdMqHf
         4RQLQ+xODXc4IWiGX2tbAMSv2Ndm5jjvUeDDH40rZR4YiO7VXNHFIf+UrsKC4qycCY5h
         5KYhcNzJ2kmvO2zgQL/xq7tnPK3cqw1/tGIionQgbXrO3Is4Lhsqlg+VtPQvC0eJiByR
         aZYQ==
X-Gm-Message-State: AOAM5330ljypCZSfYC4vIPWkLvOm+ZCugIsZo0Ur1dpFiAFDHvG0c4Ya
        hPSiQDCn4K+1rLwxl4mll9ep8w5pZgc=
X-Google-Smtp-Source: ABdhPJy5JO3VVGxXneJGpfTPKL0ubyHqwXxcurO51Y5Vv3nLiNh/VptpEFcALif/aTMtKIuSOpz8yA==
X-Received: by 2002:a2e:350e:: with SMTP id z14mr19649016ljz.183.1631698600593;
        Wed, 15 Sep 2021 02:36:40 -0700 (PDT)
Received: from [192.168.1.100] ([31.173.80.30])
        by smtp.gmail.com with ESMTPSA id e15sm1613895ljn.25.2021.09.15.02.36.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Sep 2021 02:36:40 -0700 (PDT)
Subject: Re: [PATCH 1/2] pwm: renesas-tpu: better errno for impossible rates
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-pwm@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Duc Nguyen <duc.nguyen.ub@renesas.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org
References: <20210915065542.1897-1-wsa+renesas@sang-engineering.com>
 <20210915065542.1897-2-wsa+renesas@sang-engineering.com>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Organization: Brain-dead Software
Message-ID: <be4b0937-4f75-8d9f-90fb-95414c9d5a56@gmail.com>
Date:   Wed, 15 Sep 2021 12:36:30 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210915065542.1897-2-wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 15.09.2021 9:55, Wolfram Sang wrote:

> From: Duc Nguyen <duc.nguyen.ub@renesas.com>
> 
> ENOTSUP has confused users. EINVAL has been considered clearer. Change
> the errno, we were the only ones using ENOTSUP in this subsystem anyhow.

    It's ENOTSUPP in the code. :-)

> 
> Signed-off-by: Duc Nguyen <duc.nguyen.ub@renesas.com>
> [wsa: split and reworded commit message]
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>   drivers/pwm/pwm-renesas-tpu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pwm/pwm-renesas-tpu.c b/drivers/pwm/pwm-renesas-tpu.c
> index 4381df90a527..754440194650 100644
> --- a/drivers/pwm/pwm-renesas-tpu.c
> +++ b/drivers/pwm/pwm-renesas-tpu.c
> @@ -269,7 +269,7 @@ static int tpu_pwm_config(struct pwm_chip *chip, struct pwm_device *_pwm,
>   
>   	if (prescaler == ARRAY_SIZE(prescalers) || period == 0) {
>   		dev_err(&tpu->pdev->dev, "clock rate mismatch\n");
> -		return -ENOTSUPP;
> +		return -EINVAL;
>   	}
>   
>   	if (duty_ns) {

MBR, Sergei
