Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA6CB3913BA
	for <lists+linux-pwm@lfdr.de>; Wed, 26 May 2021 11:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233212AbhEZJct (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 26 May 2021 05:32:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31987 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233283AbhEZJcs (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 26 May 2021 05:32:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622021476;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vFXLc3fcSO6eZw1ZdBBw4BdJk+fkezoKN/eYVrA+mnY=;
        b=BQvqa5i9B32E1xdfJim9Lov+N39MMnTSJC/rNSD12mKK4Va0kqs+QoXHzAsT1Y+gp1mWmq
        gV49U/Y8ucU3WsSJFBKNjTHJgcZ8OvFC4a1OoLkiRDz+tpgHBrYmO6pP62noKRM/JhrDPr
        9gv7/R7iY+6xHabuDzLjpvXov0nJhsE=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-355-RGLjlaSjPNe5mMdJK7nYnQ-1; Wed, 26 May 2021 05:31:13 -0400
X-MC-Unique: RGLjlaSjPNe5mMdJK7nYnQ-1
Received: by mail-ed1-f69.google.com with SMTP id b8-20020a05640202c8b029038f1782a77eso196186edx.15
        for <linux-pwm@vger.kernel.org>; Wed, 26 May 2021 02:31:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vFXLc3fcSO6eZw1ZdBBw4BdJk+fkezoKN/eYVrA+mnY=;
        b=mIxnalXoT2oKx6PKsJmDc92LbGgRYDtvWmxFgVHn7385heVKaCtGIS5bJQ/yHNVH/R
         fqkSXc57wEf3jjHKhc6iCC9cxtPmYYezXxuMz2RT1g4a0rNKsj7qmN81y5UAIURoh3yt
         dvO/7NnpsiESDYF977IqkpR6h7+YB1BU3ks84hBkWyJkd+Op0E0KwDYz3/DG47Wpi69W
         VcV8BWYhQutrcGykzNQn6/7HH5L+jwWqdZ/Zol4sFNIFMhLUmeOWNfTabX3IskNAAxZA
         6QuvFtTNzJ44Wnbvg0L7yr43jNFKQmDNO2GJGMY1omEuq2Cd6AK3trDaFoiXC9wEQ/+z
         ZOfg==
X-Gm-Message-State: AOAM531XXy1kgQnbZrQkBrDOSblUkp3sTK8SmcRKCufSdT3UZzkucF+U
        5+nDPahxCnMGuZL7FeQkmSRHrC5cZalkEKbgQAVbbWj6Ic1TyFn5Kg7Hlgxq++KAIoWPospEDXU
        PcGBVg/vx1dJF3b3cN/ua
X-Received: by 2002:a05:6402:1755:: with SMTP id v21mr674134edx.22.1622021472035;
        Wed, 26 May 2021 02:31:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwJTHjWlsG0MukW4/gWaKfOVPvdqqkghR1WdVcwJ38KM0mmQQ5h7p956EXbDeJvyV5aVrVFDw==
X-Received: by 2002:a05:6402:1755:: with SMTP id v21mr674126edx.22.1622021471903;
        Wed, 26 May 2021 02:31:11 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id m10sm12002581edp.48.2021.05.26.02.31.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 May 2021 02:31:11 -0700 (PDT)
Subject: Re: [PATCH] pwm: crc: Simplify using devm_pwmchip_add()
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <20210525203156.969295-1-u.kleine-koenig@pengutronix.de>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <4542407d-01c7-c2f2-5a58-d46da8708604@redhat.com>
Date:   Wed, 26 May 2021 11:31:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210525203156.969295-1-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi,

On 5/25/21 10:31 PM, Uwe Kleine-König wrote:
> With devm_pwmchip_add() we can drop pwmchip_remove() from the device
> remove callback. The latter can then go away, too and as this is the
> only user of platform_get_drvdata(), the respective call to
> platform_set_drvdata() can go, too.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
> Hello,
> 
> this patch depends on my earlier patch "pwm: Add a devm managed function to add
> pwm_chips" that you can find at
> 
>         https://patchwork.ozlabs.org/project/linux-pwm/patch/20210407080155.55004-2-u.kleine-koenig@pengutronix.de/
> 
> or
> 
>         https://lore.kernel.org/r/20210407080155.55004-2-u.kleine-koenig@pengutronix.de
> 
> Best regards
> Uwe
> 
>  drivers/pwm/pwm-crc.c | 12 +-----------
>  1 file changed, 1 insertion(+), 11 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-crc.c b/drivers/pwm/pwm-crc.c
> index 02522a9a3073..7b357d1cf642 100644
> --- a/drivers/pwm/pwm-crc.c
> +++ b/drivers/pwm/pwm-crc.c
> @@ -173,21 +173,11 @@ static int crystalcove_pwm_probe(struct platform_device *pdev)
>  	/* get the PMIC regmap */
>  	pwm->regmap = pmic->regmap;
>  
> -	platform_set_drvdata(pdev, pwm);
> -
> -	return pwmchip_add(&pwm->chip);
> -}
> -
> -static int crystalcove_pwm_remove(struct platform_device *pdev)
> -{
> -	struct crystalcove_pwm *pwm = platform_get_drvdata(pdev);
> -
> -	return pwmchip_remove(&pwm->chip);
> +	return devm_pwmchip_add(&pdev->dev, &pwm->chip);
>  }
>  
>  static struct platform_driver crystalcove_pwm_driver = {
>  	.probe = crystalcove_pwm_probe,
> -	.remove = crystalcove_pwm_remove,
>  	.driver = {
>  		.name = "crystal_cove_pwm",
>  	},
> 
> base-commit: 6efb943b8616ec53a5e444193dccf1af9ad627b5
> prerequisite-patch-id: fa39cd0c852d109ed957dc44dca5bdcf5dff0685
> 

