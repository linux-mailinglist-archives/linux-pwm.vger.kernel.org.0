Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12D5B6EAE16
	for <lists+linux-pwm@lfdr.de>; Fri, 21 Apr 2023 17:33:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231910AbjDUPdg (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 21 Apr 2023 11:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbjDUPdf (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 21 Apr 2023 11:33:35 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB1640D8
        for <linux-pwm@vger.kernel.org>; Fri, 21 Apr 2023 08:33:32 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-2febac9cacdso1183807f8f.1
        for <linux-pwm@vger.kernel.org>; Fri, 21 Apr 2023 08:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682091211; x=1684683211;
        h=content-transfer-encoding:in-reply-to:subject:from:content-language
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HC3svFk4XAPKdzjA+OTrAzU2Lfe2zHdqn7Mlo6gk9NI=;
        b=Kf0UrYdVVOH5GK9XokEsyp9sWqwnBzD1CqqnWbMR7dticBjiAZ6kMfgt7WPKi5q38b
         cc9JAjiyZLlYgfNFxQRoilv4jS9PFXzSdDFL+o352heVE2I/KqDd9Kui1ZAd1WGNr4bs
         6KkNHt626jSDQWk40/OANG8+66i4YKDjW4gzRhA2ngjmyo+eSmdjMo/V6fLLDas115WF
         5VrnbFTDeoyaV9LpnlTnFYiZyPYbnMqxBZLePcRCiKx4XvZ4LvEuQh8aVds2hD5Tsyd+
         /5QAuSMhJjKaztn7U6mwxufNeBsJYLZi6HgYSTbf9tU74OpT3/6BZLlSqKpdApwA2fow
         BO8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682091211; x=1684683211;
        h=content-transfer-encoding:in-reply-to:subject:from:content-language
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HC3svFk4XAPKdzjA+OTrAzU2Lfe2zHdqn7Mlo6gk9NI=;
        b=ASITAi1hXUlsPmEKZ6dMtIeiJf2+U0Jei/jh4u+lqPfICczSE9I4ybBARybF07NUEV
         S+gwNGNA7KdWoDhS3okUsl2ElzCmXqYATCzOOIAMx10mH2gUctw5DMZb6NQbPbOzFDUn
         AmgF6wkikJP9+yv8i+d7YalB6GUCwP6BfuexD4Wp+4IrZmY1OpP/gZ2IPK7CUkvZHPIu
         Tut8eJUDYPk7A/pzFskfNg0KQDkaD03sIeRvw1oG4Hi5wv/RUcrBQqGqa/8amttwJnWf
         jWSR4ay3f6BhcNKtdrVsa8ghd5hxHnjZuXgoSAsvG3+awauXTmnT8IMR5GxA/9WRSojs
         afEA==
X-Gm-Message-State: AAQBX9dTuzUq56QPQ/+mzUUECB1gB1OjfSlMRC+xSvsxFS7iW0YkQ+Ui
        u4xN+aZ8jBu7drDbbfyLr40=
X-Google-Smtp-Source: AKy350bGA4afJcGNnGUG1GskKygwZhFCP6vVswVC+F0QdnciS8gk+botp/N1mwm/kOKMSV+m2IyTSw==
X-Received: by 2002:adf:ef0d:0:b0:2fc:ec82:4dbf with SMTP id e13-20020adfef0d000000b002fcec824dbfmr4145646wro.1.1682091210923;
        Fri, 21 Apr 2023 08:33:30 -0700 (PDT)
Received: from ?IPV6:2a01:c23:b8bd:100:e56d:8c4a:e6a8:c253? (dynamic-2a01-0c23-b8bd-0100-e56d-8c4a-e6a8-c253.c23.pool.telefonica.de. [2a01:c23:b8bd:100:e56d:8c4a:e6a8:c253])
        by smtp.googlemail.com with ESMTPSA id h15-20020a05600c314f00b003f1978bbcd6sm9947wmo.3.2023.04.21.08.33.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Apr 2023 08:33:30 -0700 (PDT)
Message-ID: <5b1a84ee-1f96-1585-5167-4f4e266a7fb7@gmail.com>
Date:   Fri, 21 Apr 2023 17:33:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
To:     Dmitry Rokosov <ddrokosov@sberdevices.ru>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        linux-pwm@vger.kernel.org, kernel@sberdevices.ru
References: <5a5920db-4c32-25e8-d1e3-bd2f724dd242@gmail.com>
 <20230421145723.oq7zqbhhz4fhkmyj@CAB-WSD-L081021>
Content-Language: en-US
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH] pwm: meson: simplify calculation in meson_pwm_get_state
In-Reply-To: <20230421145723.oq7zqbhhz4fhkmyj@CAB-WSD-L081021>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 21.04.2023 16:57, Dmitry Rokosov wrote:
> Hello Heiner,
> 
> Thank you for the patch! Please find my comments below.
> 
> On Wed, Apr 19, 2023 at 11:30:55PM +0200, Heiner Kallweit wrote:
>> I don't see a reason why we should treat the case lo < hi that
>> different and return 0 as period and duty_cycle. Let's handle it as
>> normal use case and also remove the optimization for lo == 0.
>> I think the improved readability is worth it.
>>
>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> 
> Inside this patch, in my opinion, you have not only simplified and
> optimized but have also modified the logic. It is important to provide
> more details on this modification. Previously, in cases where
> (channel->lo != 0) && (channel->lo < channel->hi), period and duty_cycle
> were not calculated. However, in your patchset, duty_cycle and polarity
> are calculated and returned to the caller in such cases.
> Can you please share the details of why this is the right solution?

It's the obvious solution. I see no reason to return all zero's for
lo < hi, and also the commit that added this calculation doesn't provide
an explanation. It just references the calculation in meson_pwm_calc(),
however I fail to see that lo < hi is treated differently there.

c375bcbaabdb ("pwm: meson: Read the full hardware state in meson_pwm_get_state()")

> Also, please rephrase the commit message using 'modify' instead of
> 'simplify'.
> 
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
>> +	state->period = meson_pwm_cnt_to_ns(chip, pwm, channel->lo + channel->hi);
>> +	state->duty_cycle = meson_pwm_cnt_to_ns(chip, pwm, channel->hi);
>>  
>>  	state->polarity = PWM_POLARITY_NORMAL;
>>  
>> -- 
>> 2.40.0
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

