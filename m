Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D198522463C
	for <lists+linux-pwm@lfdr.de>; Sat, 18 Jul 2020 00:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbgGQW11 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 17 Jul 2020 18:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726512AbgGQW10 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 17 Jul 2020 18:27:26 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32729C0619D3
        for <linux-pwm@vger.kernel.org>; Fri, 17 Jul 2020 15:27:26 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id b6so12590785wrs.11
        for <linux-pwm@vger.kernel.org>; Fri, 17 Jul 2020 15:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EvZfM7tSlBvQupdfYs+4sQhtafmRlnSnH6RQB9/57lE=;
        b=BALRBWDK3OFtn2VmJ5nZHTR9pM51ksljccFyTBcyyX7bpgsd19EjLqCBWtl9kKUX0Y
         4w8epWV9R2HFpGWlCx1dzLRDdnLdYREVQM8r6L74qPC44o8FZH2+Bc+XQEumOKfBQ7qB
         8SffiaN/Prgk7fuWau8BRzfpotRm4p67pf/zw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EvZfM7tSlBvQupdfYs+4sQhtafmRlnSnH6RQB9/57lE=;
        b=qj+I83OzXB2vLtpXZ5AFGDQlvr6B4QX41XC58o/lRz5w/gXhY6l0rCvHjF7+5jXfmX
         v07tcQsSf+NWpfsWYoPChYYlEooGE82VqAzvlhGiImwjTY/ktG5KN1bSVedWZHxHIzqy
         LFKkuuduuWhJUESmehzQKgZEQL4EgZSlP2uBKvGoMOSPjG5XRK9DwM1iI6EjAXWdMaPz
         EqxLtkN1LzSBtiqvtlaZwUDFbd1JyJ16CSzgX6oAnDuSa4f/LGQrlkmNzj3FeOMXRCE2
         OY1jDo/G3g553Fy1bvXYh4C4AONOomdEyvBkb+6/A2CwBOVqdGkIPflMFLHgiRjwksFC
         Ywvw==
X-Gm-Message-State: AOAM530ac164XRR17nG/R5AtdjbLG1GSjJHWlAFp5GJb/7XOQEcw91kf
        qPGn0Axiwzs3LFPnzhuSKMb7tg==
X-Google-Smtp-Source: ABdhPJx0qOnDdZN6gx4AvHIXjO6Am9+EduH4EbfKF2bXMV+Mc2rxaCL6YsZxoJ/EKxkzWy2AC+xdbA==
X-Received: by 2002:a5d:4b4f:: with SMTP id w15mr11924497wrs.84.1595024844553;
        Fri, 17 Jul 2020 15:27:24 -0700 (PDT)
Received: from [10.230.182.181] ([192.19.224.250])
        by smtp.gmail.com with ESMTPSA id c17sm821888wrc.42.2020.07.17.15.27.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jul 2020 15:27:23 -0700 (PDT)
Subject: Re: [PATCH v2] pwm: bcm-iproc: handle clk_get_rate() return
To:     Scott Branden <scott.branden@broadcom.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
References: <20200717182512.26001-1-scott.branden@broadcom.com>
From:   Ray Jui <ray.jui@broadcom.com>
Message-ID: <c4f5cb1a-c94e-9b05-b8ad-c9eecd7e70e3@broadcom.com>
Date:   Fri, 17 Jul 2020 15:27:19 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200717182512.26001-1-scott.branden@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org



On 7/17/2020 11:25 AM, Scott Branden wrote:
> From: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
> 
> Handle clk_get_rate() returning <= 0 condition to avoid
> possible division by zero.
> 
> Fixes: daa5abc41c80 ("pwm: Add support for Broadcom iProc PWM controller")
> Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
> Signed-off-by: Scott Branden <scott.branden@broadcom.com>
> 
> ---
> Changes from v1: ensure  'polarity' and 'enabled' are populated
> when clk_get_rate is 0.
> ---
>  drivers/pwm/pwm-bcm-iproc.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-bcm-iproc.c b/drivers/pwm/pwm-bcm-iproc.c
> index 1f829edd8ee7..d392a828fc49 100644
> --- a/drivers/pwm/pwm-bcm-iproc.c
> +++ b/drivers/pwm/pwm-bcm-iproc.c
> @@ -85,8 +85,6 @@ static void iproc_pwmc_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
>  	u64 tmp, multi, rate;
>  	u32 value, prescale;
>  
> -	rate = clk_get_rate(ip->clk);
> -
>  	value = readl(ip->base + IPROC_PWM_CTRL_OFFSET);
>  
>  	if (value & BIT(IPROC_PWM_CTRL_EN_SHIFT(pwm->hwpwm)))
> @@ -99,6 +97,13 @@ static void iproc_pwmc_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
>  	else
>  		state->polarity = PWM_POLARITY_INVERSED;
>  
> +	rate = clk_get_rate(ip->clk);
> +	if (rate == 0) {
> +		state->period = 0;
> +		state->duty_cycle = 0;
> +		return;
> +	}
> +
>  	value = readl(ip->base + IPROC_PWM_PRESCALE_OFFSET);
>  	prescale = value >> IPROC_PWM_PRESCALE_SHIFT(pwm->hwpwm);
>  	prescale &= IPROC_PWM_PRESCALE_MAX;
> 

This patch looks good to me. Thanks!

Reviewed-by: Ray Jui <ray.jui@broadcom.com>

