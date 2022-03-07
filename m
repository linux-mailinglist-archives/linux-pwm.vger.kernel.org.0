Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9729A4D0B0D
	for <lists+linux-pwm@lfdr.de>; Mon,  7 Mar 2022 23:27:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243127AbiCGW2Y (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 7 Mar 2022 17:28:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236042AbiCGW2V (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 7 Mar 2022 17:28:21 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 495EF44773
        for <linux-pwm@vger.kernel.org>; Mon,  7 Mar 2022 14:27:25 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id p3-20020a17090a680300b001bbfb9d760eso502989pjj.2
        for <linux-pwm@vger.kernel.org>; Mon, 07 Mar 2022 14:27:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LZeFkuF0xRxL13a460mNOCcA6lAqF5a9TcjKrO9DM9w=;
        b=iq+Q+jZMAeA3G0Qv0O/crXE0lKZ4KGEk7v9BUuuN3N4N9QELwhSDJyU6Qkc/YapfoM
         SBfICOfSuPBGuHdAKgujKnz56CXx8dR8i2hgaMdVEI9/1Hq6g4am774L9+hmyzXxrwpz
         UXATvbMMhD4qBXNyZ4U3jLOleJBfFbAMJtKbhui571gCAHBFo5qA10aFsSscUeZlUSPv
         4pmkhT1z7Ee4LM4yMveHQjXA7xZ16efcc5dLbMj45LsCLAvl9LuBPjhfM/7jk3qQJ9TL
         VxbxmcmOhDoZq30/4hhfZrZ7fC52hBhAZSbgaF5UyS4sQQCqtlXYJYQFu7NtRMBZzKuJ
         ksPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LZeFkuF0xRxL13a460mNOCcA6lAqF5a9TcjKrO9DM9w=;
        b=WxGXq6V6iCm+MRXdzKAPefvk9lmi2UJ2izbnLbN6etreggOm4qr4mSfI4P+oHw5/gT
         n/l79SnjGXmUfyYwAeAVQBcITUf5e5WMxL0yRolixReBapbFXM4zH+rfTXL5HfGFTl9R
         mCd6G+ByFFX6x/Kb2IKCoLfOAGsm4YgdfMGTvbY2TKv8xs3eLSNKdGg+v9YhLIYWOv9/
         P+r/zxlqOO/49V8UjKjvcQwoSYiIf3f7hami5fkQP/VfpLk80cw6fkw+Tno37oSGW6HG
         ZxFDI0pPG96U9Xh8OIzpyUXKMhUUn3eUb+xJFPJWmdAQFt/g7cEPYsyWfXS/+Su3cejd
         s+9Q==
X-Gm-Message-State: AOAM5306sNajmQphaPUgDlEh7z3CICVnbUXYPozRv3isGC4ltC330rlG
        vbSwZl8r4Hb5IxTZ42IyK04=
X-Google-Smtp-Source: ABdhPJxrn9rmNxu32tEY6qROjaeAk0jq86AjfU/U2W4fC9jTyt6cnZnfPolOWd/pKS+Dvs96AzIMSQ==
X-Received: by 2002:a17:90b:250f:b0:1bc:e520:91e6 with SMTP id ns15-20020a17090b250f00b001bce52091e6mr1278188pjb.43.1646692044667;
        Mon, 07 Mar 2022 14:27:24 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id k12-20020a056a00168c00b004e15818cda3sm18319533pfc.114.2022.03.07.14.27.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Mar 2022 14:27:24 -0800 (PST)
Subject: Re: [PATCH 0/2] pwm: brcmstb: Some cleanups
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, kernel@pengutronix.de,
        Lee Jones <lee.jones@linaro.org>,
        linux-arm-kernel@lists.infradead.org
References: <20220214082354.295451-1-u.kleine-koenig@pengutronix.de>
 <20220307184750.qkbueadgqohbvv2g@pengutronix.de>
 <bfcda0d1-7855-7ab6-ef2c-950ead5f8b15@gmail.com>
 <20220307204430.24h572t6ftvjqzaq@pengutronix.de>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <0aebcb3d-c100-cb1c-7033-3228702bc51c@gmail.com>
Date:   Mon, 7 Mar 2022 14:27:22 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220307204430.24h572t6ftvjqzaq@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 3/7/22 12:44 PM, Uwe Kleine-König wrote:
> Hello Florian,
> 
> great to get answers from you in such a timely fashion. That helps a
> lot!
> 
> On Mon, Mar 07, 2022 at 11:11:05AM -0800, Florian Fainelli wrote:
>> On 3/7/22 10:47 AM, Uwe Kleine-König wrote:
>>> I have a few questions here looking in more detail into the brcmstb
>>> driver:
>>>
>>>  - What happens on PWM_ON(channel) = 0?
>>>    I guess it just emits a flat inactive line, and refusing a small
>>>    duty_cycle that results in PWM_ON(channel) = 0 is just artificial?
>>>
>>>  - There is a line describing:
>>>
>>>    	W = cword, if cword < 2 ^ 15 else 16-bit 2's complement of cword
>>>
>>>    The driver only considers powers of two <= 2^15 for cword. Is the
>>>    implementation just lazy, or is the comment misleading?
>>>    At least s/</<=/ ?
>>>    There is no sense in using a value > 2^15 as for each such value
>>>    there is a smaller value with the same result, right?
>>
>> This was copied from the specification which now that you mention it,
>> seems off by one in its formula, it should be <=. This is further
>> confirmed with:
>>
>> pwm1_cword[15:0] must be less than or equal to 32768 when the
>> variable-frequency PWM is used as a clock for the constant-frequency PWM.
>> Reset value is 0x0.
>>
>> so I believe that the comment is wrong and so is the specification of
>> the block that was used to write the driver.
> 
> OK, so the right thing would be:
> 
> 	W = cword with cword <= 32768
> 
> and there is no limitation to powers of two. (However it's unclear to me
> how this works in hardware for arbitrary values.)
> 
>>>  - clk_get_rate(p->clk) is expected to return 27 MHz, right?
>>>    (Just for my understanding, not about to hardcode this in the code)
>>
>> That is right.
> 
> ok.
> 
>>>  - The explanation about period in the comment is:
>>>
>>>    	The period is: (period + 1) / Fv
>>>
>>>    so I would have expected:
>>>
>>>    	pc = (period_ns * clkrate * cword / (NSEC_PER_SEC << 16)) - 1
>>>
>>>    (assuming no overflows). However the -1 isn't in the code.
> 
> You didn't comment on that one, I still assume this to be correct, i.e.
> the -1 must be coped for in the code.
> 
>>>  - Duty-cycle calculation is unclear, the docs say:
>>>
>>>  	"on" time is on / (period + 1)
>>>
>>>    I suspect on time is $on / Fv though?
>>
>> Yes, that is also what the specification says, not sure why I wrote that
>> down TBH.
> 
> OK. on / (period + 1) would be the relative duty cycle then.
> 
>>>    But even with that I don't understand the +1 in
>>>
>>>  	dc = mul_u64_u64_div_u64(duty_ns + 1, rate, NSEC_PER_SEC);
>>>
>>> Can you enlighten me?
>>
>> I wish, this was 7 years ago, and I do not remember why there was a +1
>> being added here, it might have been that this should have been a
>> DIV_ROUND_UP().
> 
> The most usual thing to do is to round down in .apply().
> 
> To sum up: The hardware works in quantums Q = 2^16 / (W * 27 MHz).
> (This is nice for W = 2^n: Q = 2^(16 - n) / (27 MHz))
> 
> The period length is 
> 
> 	(PWM_PERIOD(channel) + 1) * Q
> 
> and duty_cycle is defined by
>  
> 	PWM_ON(channel) * Q
> 
> . (No +1 there?)

Yes, I think what you are saying here is correct and matches what is
being described in the specification:

In the case where cword < 2^15, a period in the output waveform consists
of a single 1/27 microsecond HIGH pulse followed by LOW pulse for the
rest of the period. In the case where cword ≥ 2^15, a period in the
output waveform consists of a single 1/27 microsecond LOW pulse followed
by HIGH pulse for the rest of the period. In a sequence of pulse cycles,
one cycle can have a duty cycle and period that is different from those
of the other cycles. In order to have every cycle have exactly
the same duty cycle and period, cword must be chosen such that
cword=2^i,, i=0..15.
-- 
Florian
