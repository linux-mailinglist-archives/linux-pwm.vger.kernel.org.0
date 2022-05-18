Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2F6152BE74
	for <lists+linux-pwm@lfdr.de>; Wed, 18 May 2022 17:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238547AbiEROUP (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 18 May 2022 10:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237392AbiEROUO (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 18 May 2022 10:20:14 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FA3A179C1B;
        Wed, 18 May 2022 07:20:13 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-f16a3e0529so2866438fac.2;
        Wed, 18 May 2022 07:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:content-language:to
         :cc:references:from:subject:in-reply-to:content-transfer-encoding;
        bh=IYBkaxdGMFnnqnJ5FLIkibW08Z+BnKTIDE+XpOrJwS0=;
        b=T7/WnDcH7Z8c4daf3tadCnYPlFxC1+eg6jswL+HpgSyHEP9jngBeMvz/i2c2AW+yc7
         O2B86gupoO4NgmnU9CFUaYYNNk//7cYNOxaDpO8Q4AKD+m1oQ9SLlvyIIp72QVwdjLv1
         qYkxpHx3nVzGNgW0S6cZ0zbinvvag9F2fpqnSMd30DgdWRC81poRUsuLLuCIbxMQCSUu
         GuKNkDLRslyA1+sR4M734l6LzTo7r/jH663ORboEi8NpW5PhZ9KRgassFViIShGYQBHZ
         r4Z3TyZO0RFr6w/FVBYxbUM+l2+pSSs1A5PzYiu50eyO4ORACYmT5J1YYC1te9x12ZXr
         qtbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=IYBkaxdGMFnnqnJ5FLIkibW08Z+BnKTIDE+XpOrJwS0=;
        b=R49CbqJYnIiDBRm+ZYNgLr91jze8fCTox+npTyAL+ovpe5iXZbWF99toaqS62zMr20
         h41pxnPoGffGLKOYlVzLY8EUsxAq/sxbZiPKyboyd2gC042dpv6gftmfHPn0YYZHmpFl
         DDOAQb33MSKDYvW0SP6nMDmJmVEYLdc/6/03TGejoDpTyZI+2VcPn01fB8Bu8P5r6pLO
         P9er34TaOA4Q/fAhCco+gM5DYSA5Frl48/d3yLEPBNkrFP0sr17pVc/AM3+L9cRoTDzd
         XukTi4RzHgfcPQtSDBMsHp6ElRs1lwwddKUlhsIPF2nh42+/GVxbkRYl8MXkzVpUOrT2
         W/MA==
X-Gm-Message-State: AOAM531cgbZpT6shS5dT7sXYH+h2AjCdOKO5w+rGTG5MT1XRz+3UJ6e/
        Lrw6Gz60sUPsmimO9C4S4PM=
X-Google-Smtp-Source: ABdhPJyiuJEf2L46lLQ44Yle1WJbhNSxmfZ3xF+F6lNsFMrEI/Zyn9g0Ycgxagme2Mq7wAcNWSbjng==
X-Received: by 2002:a05:6870:2194:b0:f1:c284:a9c5 with SMTP id l20-20020a056870219400b000f1c284a9c5mr130223oae.254.1652883612556;
        Wed, 18 May 2022 07:20:12 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q5-20020acaf205000000b0032643374d17sm787316oih.41.2022.05.18.07.20.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 May 2022 07:20:11 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <789bdaf1-bf58-3b8a-c739-513a962df529@roeck-us.net>
Date:   Wed, 18 May 2022 07:20:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Content-Language: en-US
To:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, linux-hwmon@vger.kernel.org,
        linux-pwm@vger.kernel.org,
        Markus Niebel <Markus.Niebel@ew.tq-group.com>
References: <20220517142620.1523143-1-alexander.stein@ew.tq-group.com>
 <355e6efa-dc65-771e-fcc0-2ca774d382de@roeck-us.net>
 <20220517170658.u3dpe6gglsihh6n6@pengutronix.de>
 <3435664.iIbC2pHGDl@steina-w>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: (EXT) Re: [PATCH v3 6/6] hwmon: pwm-fan: Add hwmon_pwm_enable
 attribute
In-Reply-To: <3435664.iIbC2pHGDl@steina-w>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 5/18/22 00:06, Alexander Stein wrote:
> Am Dienstag, 17. Mai 2022, 19:06:58 CEST schrieb Uwe Kleine-König:
>> * PGP Signed by an unknown key
>>
>> Hello,
>>
>> [dropped Bartlomiej Zolnierkiewicz from Cc:]
>>
>> On Tue, May 17, 2022 at 09:38:56AM -0700, Guenter Roeck wrote:
>>> On 5/17/22 07:26, Alexander Stein wrote:
>>>> This adds the enable attribute which is used to differentiate if PWM
>>>> duty
>>>> means to switch off regulator and PWM or to keep them enabled but
>>>> at inactive PWM output level.
>>>>
>>>> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
>>>> ---
>>>>
>>>>    Documentation/hwmon/pwm-fan.rst | 10 ++++
>>>>    drivers/hwmon/pwm-fan.c         | 95 +++++++++++++++++++++++++++++----
>>>>    2 files changed, 95 insertions(+), 10 deletions(-)
>>>>
>>>> diff --git a/Documentation/hwmon/pwm-fan.rst
>>>> b/Documentation/hwmon/pwm-fan.rst index 82fe96742fee..0083480068d1
>>>> 100644
>>>> --- a/Documentation/hwmon/pwm-fan.rst
>>>> +++ b/Documentation/hwmon/pwm-fan.rst
>>>> @@ -18,3 +18,13 @@ the hwmon's sysfs interface.
>>>>
>>>>    The fan rotation speed returned via the optional 'fan1_input' is
>>>>    extrapolated from the sampled interrupts from the tachometer signal
>>>>    within 1 second.> >
>>>> +
>>>> +The driver provides the following sensor accesses in sysfs:
>>>> +
>>>> +=============== =======
>>>> =======================================================
>>>> +fan1_input	ro	fan tachometer speed in RPM
>>>> +pwm1_enable	rw	keep enable mode, defines behaviour when
> pwm1=0
>>>> +			0=switch off regulator and disable PWM
>>>> +			1=keep regulator enabled and set PWM to
> inactive level
>>>
>>> Unless I am missing something, I think we have (at least) three
>>> conditions to handle:
>>>
>>> - regulator disabled (independent of pwm value)
>>> - regulator enabled, pwm output disabled if pwm=0
>>> - regulator enabled, pwm output enabled and set to 0 (or, if inverted,
>>>
>>>    to maximum) if pwm=0
>>
>> What is your expectation for a disabled PWM?
>> https://lore.kernel.org/linux-pwm/20220517150555.404363-1-u.kleine-koenig@pe
>> ngutronix.de might be relevant. If you assume that a pwm might output the
>> active level after disabling, the case "regulator enabled, pwm output
>> disabled if pwm=0" sounds wrong.
>>
>> Would "pwm1_disable_on_zero" be a better name than "pwm1_enable"? The
>> latter is completely unintuitive to me.
> 
> I guess Guenter suggested 'pwm1_enable' as it already exists as a predefined,

Correct.

> optional attribute, avoiding adding a new custom attribute.
> Reading Documentation/hwmon/w83627ehf.rst or Documentation/hwmon/nzxt-
> smart2.rst I get the impression their meaning is pretty unrestricted.
> If you are concerned by using 'pwm1_enable', what about 'pwm1_mode'?
> 

No. pwmX_mode sets the direct current vs. pulse width.

>> Maybe go for
>>
>>   0 -> keep pwm and regulator on
>>   1 -> disable pwm, keep regulator on
>>   2 -> keep pwm on, disable regulator
>>   3 -> disable pwm and regulator
>>
>> (so one bit for pwm and one for regulator), even if 1 is
>> wrong/unusual/dangerous?
> 

0 is for disable, not enable, and 1 should match the current implementation
for compatibility reasons. Something like

0 -> disable pwm and regulator
1 -> enable pwm; if pwm==0, disable pwm, keep regulator enabled
2 -> enable pwm; if pwm==0, keep pwm and regulator enabled
3 -> enable pwm; if pwm==0, disable pwm and regulator

should work.

Guenter

> I tend to like this approach, as it can handle all combinations. You can
> decide whether you want to actually shutdown the PWM fan, or keep it enabled
> but without providing any PWM. This can mean the fan still runs at the lowest
> speed. It also addresses the scenarios where regulator cannot be disabled at
> all.
> 
> Best regards,
> Alexander
> 
> 

