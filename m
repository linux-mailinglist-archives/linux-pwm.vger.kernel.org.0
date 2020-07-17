Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18693224740
	for <lists+linux-pwm@lfdr.de>; Sat, 18 Jul 2020 01:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728001AbgGQX5w (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 17 Jul 2020 19:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726851AbgGQX5v (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 17 Jul 2020 19:57:51 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30B80C0619D2
        for <linux-pwm@vger.kernel.org>; Fri, 17 Jul 2020 16:57:51 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id y10so12661684eje.1
        for <linux-pwm@vger.kernel.org>; Fri, 17 Jul 2020 16:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=90BDAQt2ZKjpK6dC2RjNJvlJ6X9bNG9d2FjodAiTaIs=;
        b=QOvLbloSaN5KHLKmGPPgrN2pCkLUwBvPDo3+63ct4xAZbGv8y8iBEtS5iP7XP/4rUk
         Y4lZShsdYs+6AzwCkUtJBBKHgwUj2L2uaI0p/JNx6ooMbyU5ivWKklcm9U63APZ8USIm
         1dpu9UsPvaSvEBCikT2WBCJMi4zKMZDJxXDuk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=90BDAQt2ZKjpK6dC2RjNJvlJ6X9bNG9d2FjodAiTaIs=;
        b=CWkXuYMZvyt5jdD0EqkLw5jRQLGt4wqXaMwCle9nUCtMUkIFvrMtuSluXgdHmSMO+l
         cWj0QsDuPJ5dRqvDKptaEF0oBNNIrnz5INI7r0k7tZoTCxurLqKlLpdvPd59/91sYFCu
         qcSToD8tDtuM2mozs/iujZ/rpTXe0oQ5sZHvb4Enuxkt8ptBzTaZlHf2XZ6MV19uFzVp
         ewLeirt2InO+75ohfn9Z3QX8HSuqJSQ/2JsyvPNZy16+LFW2BdlsrHvvQczo75XYqODK
         /GXEEzDqeW0LvLypDm+1dxBCfX1s8HZmOgVZ0i7e9ah5CiWLDbMENbOmJJ0o2QMucs/w
         UlnA==
X-Gm-Message-State: AOAM530f/QinrhiD+XK9rTt99R3iovDfjwsgtG+ZSB51tSPBLjJdQf30
        t36qCIxPU9su1tOJouZK0qmhCQ==
X-Google-Smtp-Source: ABdhPJzZICwvD2lHCdBPoedxxdB9CsLD8/5+wD8myd8nLObsSVSXyyF19NYub8OSky354S+yneJZXQ==
X-Received: by 2002:a17:906:aac9:: with SMTP id kt9mr10580040ejb.488.1595030269688;
        Fri, 17 Jul 2020 16:57:49 -0700 (PDT)
Received: from [192.168.1.201] (d66-183-107-60.bchsia.telus.net. [66.183.107.60])
        by smtp.gmail.com with ESMTPSA id g21sm9593764edr.45.2020.07.17.16.57.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jul 2020 16:57:48 -0700 (PDT)
Subject: Re: [PATCH v3] pwm: bcm-iproc: handle clk_get_rate() return
To:     Scott Branden <scott.branden@broadcom.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
References: <20200717231954.11695-1-scott.branden@broadcom.com>
From:   Ray Jui <ray.jui@broadcom.com>
Message-ID: <ebf62731-29bd-078b-e815-55751c9c7ccf@broadcom.com>
Date:   Fri, 17 Jul 2020 16:57:44 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200717231954.11695-1-scott.branden@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org



On 7/17/2020 4:19 PM, Scott Branden wrote:
> From: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
> 
> Handle clk_get_rate() returning 0 to avoid possible division by zero.
> 
> Fixes: daa5abc41c80 ("pwm: Add support for Broadcom iProc PWM controller")
> Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
> Signed-off-by: Scott Branden <scott.branden@broadcom.com>
> Reviewed-off-by: Ray Jui <ray.jui@broadcom.com>

Typo. Should be 'Reviewed-by: Ray Jui <ray.jui@broadcom.com>', :)

> 
> ---
> Changes from v2: update commit message to remove <= condition
> as clk_get_rate only returns value >= 0
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
