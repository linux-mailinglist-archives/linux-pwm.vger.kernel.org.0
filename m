Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A51D2224312
	for <lists+linux-pwm@lfdr.de>; Fri, 17 Jul 2020 20:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726351AbgGQSYv (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 17 Jul 2020 14:24:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726322AbgGQSYu (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 17 Jul 2020 14:24:50 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5F01C0619D3
        for <linux-pwm@vger.kernel.org>; Fri, 17 Jul 2020 11:24:50 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id q17so5793234pfu.8
        for <linux-pwm@vger.kernel.org>; Fri, 17 Jul 2020 11:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=DDNq82UFJqZNA4W/58Gu3txutqShlfCsws0dFK3kxJE=;
        b=LLG+jSbKBImbmDFyI1xmUqQ8xLaVWPxVVlBhinJlrp11+Qk9Pz/8Y8lOvrj2H/XFZG
         lR0bYUIVNJYfGHVeK8GJn4GjqjS3tXTclQ1E2EVjbZ+/80+DnnwH5ga1gRkDGr8PjwLM
         Psh3JwTCEgHNPQ7Zk0WL9iOaxSbp3q2+AqlBw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=DDNq82UFJqZNA4W/58Gu3txutqShlfCsws0dFK3kxJE=;
        b=of6A85D437kG2RFxBXQF6/dI/n9q1Z25QipPzTR80FBQTE75c89hXcWH3QVYzseY7g
         VdWm1iHHs9Kclds8donauJ5lwd11cXgPy8DRqduC9FDzAO17WVHD9oavZWTdSsm2j2br
         HLziWVuf5Pnylg5o0PfpIUfnQbR3TBO3C74Urzyno7WxsqnOPSZTr2U4qUwZK+Dp3C8a
         YYU7PRwct4mtOlTX52gZkJ1gB1oSX1PlZgGaKGVjEKXyeoqTqApJJgN2ZXlQap835OT3
         LY1Pxuvuy73usJkVFl7zaXSEF0iGq5ZIW1vW8OeDZx1i2CslyG2DcXHPX5vPBF4EZP59
         3xHw==
X-Gm-Message-State: AOAM530kgD+uiH1xxQCI251OT9zk2wE5IL9psWu7lDeUjf+dtBs2xste
        ZXhyxEDQEtAKe4Fb5F7mv2xL46JDDL0T4Q==
X-Google-Smtp-Source: ABdhPJzHBxA4qQJdJjyjh4nIIw26BQZ4hlojbOjvE6qAHsf1d8PLr7Qq6XtDzcWP4F9dgCGjxwWCNw==
X-Received: by 2002:a63:9d87:: with SMTP id i129mr9829976pgd.412.1595010289936;
        Fri, 17 Jul 2020 11:24:49 -0700 (PDT)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id e18sm8344527pff.37.2020.07.17.11.24.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jul 2020 11:24:49 -0700 (PDT)
Subject: Re: [PATCH] pwm: bcm-iproc: handle clk_get_rate() return
To:     Ray Jui <ray.jui@broadcom.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
References: <20200717170743.25466-1-scott.branden@broadcom.com>
 <94f2aed1-d88d-3ee0-6e57-917f665951f2@broadcom.com>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <6f9b0a94-6289-990b-84b3-80d70e17d3e2@broadcom.com>
Date:   Fri, 17 Jul 2020 11:24:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <94f2aed1-d88d-3ee0-6e57-917f665951f2@broadcom.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org



On 2020-07-17 10:22 a.m., Ray Jui wrote:
>
> On 7/17/2020 10:07 AM, Scott Branden wrote:
>> From: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
>>
>> Handle clk_get_rate() returning <= 0 condition to avoid
>> possible division by zero.
>>
>> Fixes: daa5abc41c80 ("pwm: Add support for Broadcom iProc PWM controller")
>> Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
>> Signed-off-by: Scott Branden <scott.branden@broadcom.com>
>> ---
>>   drivers/pwm/pwm-bcm-iproc.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/pwm/pwm-bcm-iproc.c b/drivers/pwm/pwm-bcm-iproc.c
>> index 1f829edd8ee7..72a8607b6c8d 100644
>> --- a/drivers/pwm/pwm-bcm-iproc.c
>> +++ b/drivers/pwm/pwm-bcm-iproc.c
>> @@ -86,6 +86,11 @@ static void iproc_pwmc_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
>>   	u32 value, prescale;
>>   
>>   	rate = clk_get_rate(ip->clk);
>> +	if (rate == 0) {
>> +		state->period = 0;
>> +		state->duty_cycle = 0;
>> +		return;
>> +	}
I'll move the logic after the polarity and enabled fields are populated.
> Based on the pwm core code, 'get_state' expects the following fields to
> be populated: 'polarity', 'enabled', 'period', and 'duty cycle'.
>
> The above logic will leave 'polarity' and 'enabled' completely
> unpopulated when clock rate is zero.
>
>>   
>>   	value = readl(ip->base + IPROC_PWM_CTRL_OFFSET);
>>   
>>

