Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4095218157B
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Mar 2020 11:06:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728444AbgCKKF6 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 11 Mar 2020 06:05:58 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39028 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728349AbgCKKF6 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 11 Mar 2020 06:05:58 -0400
Received: by mail-wm1-f66.google.com with SMTP id f7so1372857wml.4
        for <linux-pwm@vger.kernel.org>; Wed, 11 Mar 2020 03:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=93G/zDTaOyD8EFBjnQ5HIhSQ1W1zWJdEX89fmqSHRBM=;
        b=sphWW9cMhYeeZnLJ1WOkhyAMUglQ2PHyu4A4P4MLn5LhUtR9grWcvpv742AfsJD6Ae
         MTvz64bk2UZqLRIhYNkgXi2vDO0gtjl1Y1K0iLPsu9RZOBO+0NApphHzRa/dwzCffgyz
         JCPqgrdJC6G4t08cCPiiopuMy77kI75CX90AUD5PQDA+3LrRgoiWJLUkVupU0XhQnhM0
         uwQesF7rKRXr4TUN92Sp0L6xrs0pD8XnAGmGuAvA7PWJWJQ7eb/vVnHglk5SmVwwDU8w
         P5YMd7cfmZvPApO7oHcFhiAb6mDKRbVk5KH+MR1INXVq1NdWTwh8eg3ym3UH9qsNgraI
         a9Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=93G/zDTaOyD8EFBjnQ5HIhSQ1W1zWJdEX89fmqSHRBM=;
        b=eGmlFPnnWjFADBKcGVp6B/1d+yutia4a6q0XJqKUCx+4kZebYy0IkBYccJlh6UOGG2
         AutF1VfO6FGtua/IkTMSqbs+VARzkUYLpudu3JojtNSsW2DRqke1Y01+stJXn2tAHD5I
         Em0WQ2isUOr1DfjSjdQhVKL/B2M69RtDgOFFG3V5/fL5d6Ttz9Dz2yaOn9L8ArArKwpf
         3NDoWAHV8DMnUIgxM6vI85ljfB4pgxcP+uRaI+M4LNdQdLvHP2tRCN/36H3TrmnW3a11
         cZYrI1bQqfkp4OEh+0BOlSLBpRt0KclfpJYDjWB0z3XLfOosHcdXX8LhjltPjBI+2t91
         CI2A==
X-Gm-Message-State: ANhLgQ2jXC3/gZo5MZ6oSH56T1xeziEeS1LbKegteVFFVfNPuEwof3Hx
        rmCFLdwi7Bj9N2IXXsCczp6SGw==
X-Google-Smtp-Source: ADFU+vux58htGjgI+MQUNkO9EePfRE4OlardHqAxVYVpyO/Mn5vugUubYA/2NPUQF5VUi6osmAu/aQ==
X-Received: by 2002:a1c:1f14:: with SMTP id f20mr3005879wmf.61.1583921154070;
        Wed, 11 Mar 2020 03:05:54 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id i21sm8239881wmb.23.2020.03.11.03.05.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 03:05:53 -0700 (PDT)
Date:   Wed, 11 Mar 2020 10:05:51 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Guru Das Srinagesh <gurus@codeaurora.org>
Cc:     linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>,
        Subbaraman Narayanamurthy <subbaram@codeaurora.org>,
        linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v8 11/12] backlight: pwm_bl: Use 64-bit division function
Message-ID: <20200311100551.umvfqelrqzcfo7sa@holly.lan>
References: <cover.1583889178.git.gurus@codeaurora.org>
 <a9f914f92ee637c68e1d336e5b4894a565eb3cdc.1583889178.git.gurus@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a9f914f92ee637c68e1d336e5b4894a565eb3cdc.1583889178.git.gurus@codeaurora.org>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, Mar 10, 2020 at 06:41:20PM -0700, Guru Das Srinagesh wrote:
> Since the PWM framework is switching struct pwm_state.period's datatype
> to u64, prepare for this transition by using div_u64 to handle a 64-bit
> dividend instead of a straight division operation.
> 
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Jingoo Han <jingoohan1@gmail.com>
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Cc: linux-pwm@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-fbdev@vger.kernel.org
> 
> Signed-off-by: Guru Das Srinagesh <gurus@codeaurora.org>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>

> ---
>  drivers/video/backlight/pwm_bl.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
> index efb4efc..3e5dbcf 100644
> --- a/drivers/video/backlight/pwm_bl.c
> +++ b/drivers/video/backlight/pwm_bl.c
> @@ -625,7 +625,8 @@ static int pwm_backlight_probe(struct platform_device *pdev)
>  		pb->scale = data->max_brightness;
>  	}
>  
> -	pb->lth_brightness = data->lth_brightness * (state.period / pb->scale);
> +	pb->lth_brightness = data->lth_brightness * (div_u64(state.period,
> +				pb->scale));
>  
>  	props.type = BACKLIGHT_RAW;
>  	props.max_brightness = data->max_brightness;
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
