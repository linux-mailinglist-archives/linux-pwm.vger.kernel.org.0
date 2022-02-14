Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDFD94B5A5D
	for <lists+linux-pwm@lfdr.de>; Mon, 14 Feb 2022 20:05:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbiBNTEj (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 14 Feb 2022 14:04:39 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:50690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbiBNTEM (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 14 Feb 2022 14:04:12 -0500
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCAEF8C49B
        for <linux-pwm@vger.kernel.org>; Mon, 14 Feb 2022 11:03:53 -0800 (PST)
Received: by mail-oo1-xc2c.google.com with SMTP id u25-20020a4ad0d9000000b002e8d4370689so20404027oor.12
        for <linux-pwm@vger.kernel.org>; Mon, 14 Feb 2022 11:03:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gjQfj41R5KVn7YKo4DlzGShePFVyEOei8SEk/9EmLAI=;
        b=JWxKgRZPQooVudM1lEX0C2gFiV74Mw/cJLutzo/Ym7EoOblEWnSCpVllQXBUo64G+h
         D7RYWOINarGqASyPel6JlXdEP60GYyBbYMoCRBFdSH6ZLaxIc4bfACm70e/mwxdg4VMT
         EL0V/AZgXDmf3Bg3/kn9+uLvH4xRJ7TleI+7onnfON9bdYi4WNp1/Y91HxRz70JIZi/m
         QO7gHIhzpkDtWvjSmK/3Ni4bu5MGcwzRDgbvM7uqDUP9lmqOGjEMdfBf/hWyEUHPGEK7
         0JlDu3uqgUifuGqpWPsFBdQ76Y9FSth1QXzwqkY0qLhZPjtc3FUZ70nax4tzI9tNbW3A
         yFtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gjQfj41R5KVn7YKo4DlzGShePFVyEOei8SEk/9EmLAI=;
        b=q1eSHP3DIFxz1Cc/U15gnroqF710MPEo6kWD6G4/Kah8WbGa58cVdDukof9oLKhNhX
         E1F4gT6C5wsyycDjGlLWuftyAH8FOSvqX9ffpvjZ5+P/+3QyxVIfzTGLmodcVS6uJodC
         04dvG8eBETv/z3p8j0OpS8qktCIGOgTRAc177Bk8rw3EiLlWo630xVwRYUMUl83l7nIN
         3eR6DqyJ+eQ2DtvPuCjGDFdUqbV+RXSk673pAo9sp2BoQCkdMB+e2Bx/5nKUpQ+RC7pb
         UgIejMpZAvN228rNiMgRrGQeZn06LOJ2iqEW91BmKZGSMY3lgqs+dq5cbBEYsYc9qwiW
         Ib9Q==
X-Gm-Message-State: AOAM5306Lq7FYheArApjjKFHstqExRCHM6d65ZnNrvgm7Jp9gnGJO6d2
        MNrWob/idGAjOEvM/6pGdZxxRuyYStI=
X-Google-Smtp-Source: ABdhPJykSq61dMPnIx945LOJUTiawPCDARsPuq8KCRDCM2TCPHZWpGJlmBA2U7jcXo5fXrq7tSBQOw==
X-Received: by 2002:a17:90a:8804:: with SMTP id s4mr52873pjn.129.1644864688136;
        Mon, 14 Feb 2022 10:51:28 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id 6sm275948pgx.36.2022.02.14.10.51.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Feb 2022 10:51:27 -0800 (PST)
Subject: Re: [PATCH 0/2] pwm: brcmstb: Some cleanups
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, linux-pwm@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org
References: <20220214082354.295451-1-u.kleine-koenig@pengutronix.de>
 <83f9a9b2-4a01-1f98-4783-d221cc3adf4f@gmail.com>
 <20220214183457.fdio34lhxe2umpll@pengutronix.de>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <ed40ee0d-d4ed-5995-5933-0d4ae0115b39@gmail.com>
Date:   Mon, 14 Feb 2022 10:51:24 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220214183457.fdio34lhxe2umpll@pengutronix.de>
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

On 2/14/22 10:34 AM, Uwe Kleine-König wrote:
> On Mon, Feb 14, 2022 at 09:18:49AM -0800, Florian Fainelli wrote:
>> On 2/14/22 12:23 AM, Uwe Kleine-König wrote:
>>> Hello,
>>>
>>> here are a few cleanups for the brcmstb PWM driver. There are a few
>>> issues left with it, that I'm not addressing for now. Just mention it in
>>> case someone wants to work on this driver:
>>>
>>>  - There is no .get_state() callback
>>>    (That needs to be implemented by some with hardware and
>>>    documentation)
> 
> Assuming you have access to documentation, can you confirm, that the
> registers that define the PWM's behaviour are readable? If I knew that I
> could come up with an implementation for .get_state().

Yes, the registers are read/write with no side effects, so this is going
to be working.

> 
>>>  - There are a few places where an overflow can happen in
>>>    brcmstb_pwm_config() that are not handled
>>>
>>>  - The loop in brcmstb_pwm_config() to calculate cword is ineffective,
>>>    cword could be calculated ad hoc.
>>>
>>>  - I don't understand
>>>
>>>                 /*
>>>                  * We can be called with separate duty and period updates,
>>>                  * so do not reject dc == 0 right away
>>>                  */
>>>                 if (pc == PWM_PERIOD_MIN || (dc < PWM_ON_MIN && duty_ns))
>>>                         return -EINVAL;
>>>
>>>    The usual policy is "With the selected period, pick the biggest
>>>    possible duty_cycle that isn't bigger thatn the requested duty_cycle.
>>>    So should this case be handled using dc = 0 instead?
>>>    But as I don't understand the real issue here (is this about changing
>>>    period and duty at the same time?), I don't want to touch that.
>>
>> IIRC, I was testing using a shell script that would exercise corner
>> cases by modifying the /sys/class/pwm/*/{period,duty_cycle} separately
>> was able to run into that. Let me see if I can dig up that script.
> 
> When you find it, it would be great to document the problem in a way
> that it's still understandable some time later.
> 
>> Can you give me a day or two to make sure your changes work properly? I
>> need to locate a board with an exposed PWM header so I can put a scope
>> on it. Thanks!
> 
> Sure, in my experience it takes longer than two days on average until
> Thierry picks up PWM patches. Thanks for your willingness to test!

The least I can do, short of doing the conversion myself ;) With that
said, I just tested your two patches and things still worked just fine:

Tested-by: Florian Fainelli <f.fainelli@gmail.com>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>

Thanks a lot Uwe!
-- 
Florian
