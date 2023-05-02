Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 994996F4B57
	for <lists+linux-pwm@lfdr.de>; Tue,  2 May 2023 22:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbjEBU15 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 2 May 2023 16:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbjEBU14 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 2 May 2023 16:27:56 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 499E41988
        for <linux-pwm@vger.kernel.org>; Tue,  2 May 2023 13:27:53 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-957dbae98b4so665038866b.1
        for <linux-pwm@vger.kernel.org>; Tue, 02 May 2023 13:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683059272; x=1685651272;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PvaKk2xIJRJAr0HLadgsY7MzLEb/bHxzszEYtp5mQjo=;
        b=HB9NHckuN3pzMs6VnxlxYMiTVWaTFi/NK7jZvJE6wIQKSLZM4NBuuFvldUs/G5sh18
         HHdnPg6xVKCNwp3LQDyK24rO++rhCaT7QdiXcWcALk+BfKXvbp/XeA5VnWZKG/XDfnFb
         d71/UO/XuQy8A9jOlSufFuzEeNQM/ritEWKMYp9HNMEJ4TmCtbAr1iHZhp2b8AGF2EZq
         8EQIm+ImwpG7qvzTQ25MAw65q+JT3P6a7GdqRNeB1/dBJIWIQLm00yBMnc1FcB6b3gkp
         yTyn3xtT50x14Z0BRVFNKH5KzDdc5tkidaMr96ha4f/e36EnXF1Ftqb6oQesCMQWjM9Q
         sWBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683059272; x=1685651272;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PvaKk2xIJRJAr0HLadgsY7MzLEb/bHxzszEYtp5mQjo=;
        b=lB39x6JfrnZTbmEosSrPXJTsVx97s/1mHAFwSIjLk1lWt6YSJ9ep6CfjsBhEj/XUS6
         YLp0Cw0E1BalWteKQdj125JIf+mDKx41kv4s2p+NIxIlvzWEbqWibh5ixrR5FUYBQUpE
         l1b4F5YOsHZqiNdd/GbQcHc38gOxdw7bdwa46KSCDU1rvUUpyS/gINGMJFU9dEUYSxrm
         2wvffG7yjhoRD86e3wNqOGeF6duDyJgBaHMpkZpMh5katflz6SNHWRu2sZPzcuzfbbyP
         95vnYDR3Af82J6ay2QnjpmZ4DCb2ZraiVulTM25RtpCz8eeydVDLAQmsdV6Fo6b/Wbu1
         wLeQ==
X-Gm-Message-State: AC+VfDzsoAvhlKUgbcRgYDdmdoebxOJW7yuPWahNFREHh2iO55hWm6vM
        Bm1L+RbTC6hKj9tzXgjTL1jlgKifP7U=
X-Google-Smtp-Source: ACHHUZ4haDUcwTKgGDS/6gTdOVZ7SmHx8hWAkXJhOA+iAY+TenriJaeDzTcoa2X/H0TknLQ3HRz1yA==
X-Received: by 2002:a17:907:9496:b0:94e:ed5d:c864 with SMTP id dm22-20020a170907949600b0094eed5dc864mr1274429ejc.19.1683059271299;
        Tue, 02 May 2023 13:27:51 -0700 (PDT)
Received: from ?IPV6:2a02:3100:9545:b300:8dc9:588b:ac03:5082? (dynamic-2a02-3100-9545-b300-8dc9-588b-ac03-5082.310.pool.telefonica.de. [2a02:3100:9545:b300:8dc9:588b:ac03:5082])
        by smtp.googlemail.com with ESMTPSA id ia1-20020a170907a06100b009614fea69e8sm4406117ejc.74.2023.05.02.13.27.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 May 2023 13:27:50 -0700 (PDT)
Message-ID: <3e1a041e-f721-1535-840c-3e1970a80bc8@gmail.com>
Date:   Tue, 2 May 2023 22:27:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2] pwm: meson: modify and simplify calculation in
 meson_pwm_get_state
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        linux-pwm@vger.kernel.org,
        Dmitry Rokosov <ddrokosov@sberdevices.ru>
References: <f48f17a7-7f50-c5ef-cc8f-007d0cb302b0@gmail.com>
 <20230501180755.mxua3owqyaa26jnq@pengutronix.de>
Content-Language: en-US
From:   Heiner Kallweit <hkallweit1@gmail.com>
In-Reply-To: <20230501180755.mxua3owqyaa26jnq@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 01.05.2023 20:07, Uwe Kleine-König wrote:
> On Mon, May 01, 2023 at 04:03:16PM +0200, Heiner Kallweit wrote:
>> I don't see a reason why we should treat the case lo < hi differently
>> and return 0 as period and duty_cycle. The current logic was added with
>> c375bcbaabdb ("pwm: meson: Read the full hardware state in
>> meson_pwm_get_state()"), Martin as original author doesn't remember why
>> it was implemented this way back then.
>> So let's handle it as normal use case and also remove the optimization
>> for lo == 0. I think the improved readability is worth it.
>>
>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>> ---
>> v2:
>> - improve commit description
>> ---
>>  drivers/pwm/pwm-meson.c | 14 ++------------
>>  1 file changed, 2 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
>> index 5732300eb..3865538dd 100644
>> --- a/drivers/pwm/pwm-meson.c
>> +++ b/drivers/pwm/pwm-meson.c
>> @@ -351,18 +351,8 @@ static int meson_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
>>  	channel->lo = FIELD_GET(PWM_LOW_MASK, value);
>>  	channel->hi = FIELD_GET(PWM_HIGH_MASK, value);
>>  
>> -	if (channel->lo == 0) {
>> -		state->period = meson_pwm_cnt_to_ns(chip, pwm, channel->hi);
>> -		state->duty_cycle = state->period;
>> -	} else if (channel->lo >= channel->hi) {
>> -		state->period = meson_pwm_cnt_to_ns(chip, pwm,
>> -						    channel->lo + channel->hi);
>> -		state->duty_cycle = meson_pwm_cnt_to_ns(chip, pwm,
>> -							channel->hi);
>> -	} else {
>> -		state->period = 0;
>> -		state->duty_cycle = 0;
>> -	}
> 
> The last else branch is even wrong, isn't it? .apply() can for a greater
> than 50% relative duty cycle well have lo < hi, right? So this is not a
> mere optimisation but a fix?!
> 

I *think* too that it's wrong. However I have no test hw and I'm not aware
of any problem caused by the current code. Therefore I was reluctant to make
the patch a fix.

>> +	state->period = meson_pwm_cnt_to_ns(chip, pwm, channel->lo + channel->hi);
>> +	state->duty_cycle = meson_pwm_cnt_to_ns(chip, pwm, channel->hi);
> 
> Note that meson_pwm_calc() has a similar construct that can be
> simplified in a similar way. All three variants have
> 
> 	channel->pre_div = pre_div;
> 
The pre_div member will be gone anyway with a patch series that is in
discussion currently ("make full use of CCF").

> and the last else branch is universal and can replace the others.
> 
> Another issue I just spotted is that
> 
> 	duty = state->duty_cycle
> 
> is wrong for state->duty_cycle > UINT_MAX. (Ditto the assignment to
> period.) Making both duty and period u64 shoudl fix that. After that
> duty_cnt > 0xffff cannot happen as the core ensures that duty_cycle <=
> period.
> 
I saw that one too. It's something for a follow-up patch.

> Having said that, the proposed change here is an improvement, so:
> 
> Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> 
> I also suggest to add a Fixes line, i.e.
> 
> Fixes: c375bcbaabdb ("pwm: meson: Read the full hardware state in meson_pwm_get_state()")
> 
OK

> Best regards
> Uwe
> 
Heiner

