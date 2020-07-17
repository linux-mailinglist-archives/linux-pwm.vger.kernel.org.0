Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C631F2241AB
	for <lists+linux-pwm@lfdr.de>; Fri, 17 Jul 2020 19:22:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbgGQRWV (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 17 Jul 2020 13:22:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbgGQRWU (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 17 Jul 2020 13:22:20 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 934B8C0619D2
        for <linux-pwm@vger.kernel.org>; Fri, 17 Jul 2020 10:22:20 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id l2so18384231wmf.0
        for <linux-pwm@vger.kernel.org>; Fri, 17 Jul 2020 10:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AoGGlbrqDdPdAt7SZnkfIe6cI/q8MK4oBz8zz9M/acQ=;
        b=eBRo3SW05EhHdbRiObyZVkdToB+SfnAgfcwfG1UziRDO9imQP66XiFEiflsyu7G768
         FmF/sg++nQJp84LORbbmQkWzuXcpIJyVD/dBxXCSOTueCiV5pr6ULXJoxaOpjCogUSbo
         liKDKgBvilIpKfw9Z9uzB7iI6If0J1WJpzaWg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AoGGlbrqDdPdAt7SZnkfIe6cI/q8MK4oBz8zz9M/acQ=;
        b=D+1REYrt6SkJPSCJQZa16VGzkcTm/G3wvxkZhDJAFyFwwORQl8e0tVBfX6Zp2Yxuot
         AVNCPGFZouHi4p+mWBiUpOi91cKYOiaPcFAgWXxvziWYKAaRr2Q8v2PAOOkymZrbOWB9
         +WJSl9EXdR71EV1HQQRHLE+e8G5V2Hrx++GVr8cXrpoeAmkhJkWFtmsv/GqHoUA9FSKP
         r9FZgus6x52XxRug0MrJhcWx00nRaNW/0YNazzmuXecFqBIqankaHib6vTekIvryyug4
         Wc32lljsFvkp+BpvC7kA1Jfa2LxpNdgJibp9rLxDDJDKaP6NOfFXVbuIA9EJqaBUv5aX
         wS7Q==
X-Gm-Message-State: AOAM532O9Wk+A97GhJj0hhAVGt41ecPqqFZmONYpT5isuS1kuAixPJQM
        3WxGsWs1+++d4KGDr7vgNIfEWXELqR6TRpnc
X-Google-Smtp-Source: ABdhPJx5HuoCQvje9YbfNYXj5ZyRp/BF5z5HnFlrq0fsNt7tkJM1VBsvb8LP25MSY4X9JxW4ybylpA==
X-Received: by 2002:a7b:cb98:: with SMTP id m24mr10210755wmi.98.1595006539117;
        Fri, 17 Jul 2020 10:22:19 -0700 (PDT)
Received: from [10.230.182.181] ([192.19.224.250])
        by smtp.gmail.com with ESMTPSA id g13sm15986896wro.84.2020.07.17.10.22.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jul 2020 10:22:18 -0700 (PDT)
Subject: Re: [PATCH] pwm: bcm-iproc: handle clk_get_rate() return
To:     Scott Branden <scott.branden@broadcom.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
References: <20200717170743.25466-1-scott.branden@broadcom.com>
From:   Ray Jui <ray.jui@broadcom.com>
Message-ID: <94f2aed1-d88d-3ee0-6e57-917f665951f2@broadcom.com>
Date:   Fri, 17 Jul 2020 10:22:13 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200717170743.25466-1-scott.branden@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org



On 7/17/2020 10:07 AM, Scott Branden wrote:
> From: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
> 
> Handle clk_get_rate() returning <= 0 condition to avoid
> possible division by zero.
> 
> Fixes: daa5abc41c80 ("pwm: Add support for Broadcom iProc PWM controller")
> Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
> Signed-off-by: Scott Branden <scott.branden@broadcom.com>
> ---
>  drivers/pwm/pwm-bcm-iproc.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/pwm/pwm-bcm-iproc.c b/drivers/pwm/pwm-bcm-iproc.c
> index 1f829edd8ee7..72a8607b6c8d 100644
> --- a/drivers/pwm/pwm-bcm-iproc.c
> +++ b/drivers/pwm/pwm-bcm-iproc.c
> @@ -86,6 +86,11 @@ static void iproc_pwmc_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
>  	u32 value, prescale;
>  
>  	rate = clk_get_rate(ip->clk);
> +	if (rate == 0) {
> +		state->period = 0;
> +		state->duty_cycle = 0;
> +		return;
> +	}

Based on the pwm core code, 'get_state' expects the following fields to
be populated: 'polarity', 'enabled', 'period', and 'duty cycle'.

The above logic will leave 'polarity' and 'enabled' completely
unpopulated when clock rate is zero.

>  
>  	value = readl(ip->base + IPROC_PWM_CTRL_OFFSET);
>  
> 
