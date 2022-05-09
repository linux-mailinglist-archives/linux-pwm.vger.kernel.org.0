Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6497B52077B
	for <lists+linux-pwm@lfdr.de>; Tue, 10 May 2022 00:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231502AbiEIWXP (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 9 May 2022 18:23:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231486AbiEIWXO (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 9 May 2022 18:23:14 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B79F126C4C1;
        Mon,  9 May 2022 15:19:18 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id v65so16722343oig.10;
        Mon, 09 May 2022 15:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=pQ+NFz48u/PVAao/3y8aTxUEtE0Q3CzofdOnqfSSLRM=;
        b=SRHDpOMWwSStBa2So+3KgzgNUSgKuGz1Pv5JZzkRKaL1taQta/d0mlGTwL+wgEFVS9
         XZsklJP5mA99lFz4N+XYC1YG9Gv61wSSeWgXHIAcYhirKFP0zEtf6bfWn5Vm8CxlfX80
         0TonBjXQF3kKIR9YqV6RISEOzQxj7Ug1fP0O6TEDsNnUpRT536F3s5SF7Lbo/Vuj7ZXy
         2o5bE6Q3K3dYGsAotX2RtLSgAZZy0TcmQt9ixRsVpT9o5I1FKNQ3ysCEVREGBrfe6eDB
         OfKUpu5l86I2kJ+09dflDPjrtlw8SMvofpOl5aPnTrSobxk5tW9OgnmQGuIW/DVl9MRw
         OTMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=pQ+NFz48u/PVAao/3y8aTxUEtE0Q3CzofdOnqfSSLRM=;
        b=oBixN26v+EwVKeyTZm9ebd/uqOfpgcCotHPZmIbg2HY7ZTHv7y5+g45PsE1/9ani0D
         C0YFPZ3x1AZOn3Ai15NwV1sfeY+Kb/cHoaJ8TNV99yNa7G66T1lwBnlarnNcKQsJQyq+
         GtmghqkiYz07YYje+qoMczyyrXVBP5dtvQxCBXhqTQFqwY1MNTwnFm1EoG0H3Dp7mqRw
         by6vdUeWtqZe/0zkq4QjmJFzVwGx/jX2ytuxZR9UvwcplPY6p9dFK41rv92hTPaoyzLn
         I3Jjd9mlykPKRO5EDAWlyYEDmhM0KsZq6BOTzyR1LcoEd0qDRxuQv3hC66Tls5VIJsog
         KZwg==
X-Gm-Message-State: AOAM5307ai/wonybnorkRl26lz7Aq5LGte5GrUWRq5nX8lhrGEyOWSTv
        kDk+5eBfU317iwReEOAoKhEUAP9SOGYHIg==
X-Google-Smtp-Source: ABdhPJwszSFM3fp5nHHTMxyVLySFOJj7h3zjbtkCLBA4VJjfy4go1mb0G/yoqB7qlfyMhBxXHIOK6g==
X-Received: by 2002:a05:6808:645:b0:325:abf1:e7d0 with SMTP id z5-20020a056808064500b00325abf1e7d0mr8712229oih.123.1652134758073;
        Mon, 09 May 2022 15:19:18 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f5-20020a9d5e85000000b0060603221262sm5106207otl.50.2022.05.09.15.19.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 May 2022 15:19:16 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <c2e5b342-bdc3-727f-25d0-843f4ae3d51a@roeck-us.net>
Date:   Mon, 9 May 2022 15:19:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: (EXT) Re: (EXT) Re: (EXT) Re: [PATCH v2 1/1] hwmon: pwm-fan:
 dynamically switch regulator
Content-Language: en-US
To:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Markus Niebel <Markus.Niebel@ew.tq-group.com>,
        linux-hwmon@vger.kernel.org, linux-pwm@vger.kernel.org
References: <20220504124551.1083383-1-alexander.stein@ew.tq-group.com>
 <20220506142913.vbddyvkmhuvfd5o5@pengutronix.de>
 <20220506183124.GA2997799@roeck-us.net> <2184650.iZASKD2KPV@steina-w>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <2184650.iZASKD2KPV@steina-w>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 5/9/22 00:39, Alexander Stein wrote:
> Am Freitag, 6. Mai 2022, 20:31:24 CEST schrieb Guenter Roeck:
>> On Fri, May 06, 2022 at 04:29:13PM +0200, Uwe Kleine-König wrote:
>>> [Dropped Bartlomiej Zolnierkiewicz from Cc:; my mailer daemon claims the
>>> email address doens't exist.]
>>>
>>> Hello Guenter,
>>>
>>> On Fri, May 06, 2022 at 07:12:44AM -0700, Guenter Roeck wrote:
>>>> On Fri, May 06, 2022 at 02:23:11PM +0200, Alexander Stein wrote:
>>>>> Am Freitag, 6. Mai 2022, 12:23:01 CEST schrieb Uwe Kleine-König:
>>>>>> See
>>>>>> https://lore.kernel.org/linux-pwm/20180806155129.cjcc7okmwtaujf43@pe
>>>>>> ngutronix.de/ for one of the previous discussions.
>>>>>
>>>>> Thanks for the link. I took a look into it. I'm on your side here,
>>>>> IMHO
>>>>> pwm_disable() implies that the PWM perphery is disabled, including any
>>>>> clocks or powerdomain. This is what pwm-imx27 actually does. This
>>>>> might lead to a, probably platform dependent, (undefined?) state of
>>>>> the PWM output pin. This implies it is not possible to disable the
>>>>> PWM periphery for inverted signals, if the disabled state is not the
>>>>> inactive level. You know all about it already.
>>>>> Then again from pwm-fan side I want be able to disable the FAN,
>>>>> turning of
>>>>> regulator and PWM, so powersaving is possible. That's what this patch
>>>>> is
>>>>> about. This is similar also what pwm_bl is doing.
>>>>> Independent of the exact semantics, it makes sense to disable the
>>>>> regulator in pwm-fan as well when the fan shall be disabled.
>>>>
>>>> There are fans which never stop if pwm==0, such as some CPU fans. I
>>>> don't
>>>
>>> I assume with pwm==0 you actually mean duty_cycle == 0?
>>
>> Correct. The "pwm" attribute sets the duty cycle.
>>
>>>> think it is a good idea to force those off by turning off their power.
>>>> The
>>>> problem in the driver is that it treats pwm==0 as "disable pwm", not as
>>>> "set pwm output to 0", Part of the probem may be that the ABI doesn't
>>>> have
>>>> a good representation for "disable pwm output", which is what is really
>>>> wanted/needed here.
>>>
>>> Disable pwm output == set pwm output to High-Z? Not all PWMs are able to
>>> provide that.
>>
>> It is up to us to define whate it means exactly. If you are ok that "set
>> duty cycle to 0" reflects "set duty cycle to 0, disable pwm, and turn off
>> regulator", I would hope that you are ok with using the _enable attribute
>> to do the same and leaving pwm==0 to do what it is supposed to do, ie to
>> keep pwm control enabled and set the duty cycle to 0.
> 
> Just to make sure to be on the same side and summarize a bit. What you mean is
> to add a new sysfs attribute to pwm-fan driver which controls what pwm_duty==0
> implies. I would suggest to name is 'keep_pwm_enabled' (but I am open for
> other suggestions) with the following meaning:
> 1 - pwm_duty==0 just means that. Set PWM duty to 0 and keep PWM (and fan
> regulator) enabled.
> 

No, I am not suggesting that. I am suggesting to add support for the existing
standard attribute pwm1_enable, and define what its values mean in the driver
documentation. There is no need to provide a non-standard attribute.

Guenter

> 0 - pwm_duty==0 means that the PWM duty is set to 0, PWM is disabled and any
> PWM fan regulator is disabled as well.
> 
> For pwm_duty!=0 this setting is irrelevant. Having the default to be '1' seems
> sensible in order to not brake boards as regulator will be kept enabled. PWM
> duty and/or PWM disable is irrelevant as PWM inversion is not yet supported
> properly anyway.
> 
> IMHO this should address all the mentioned issues. With 'keep_pwm_enabled=1'
> only the duty is set and the regulators are not forced to be disabled. E.g.
> the CPU fans mentioned by Guenter. This is also the case for hardware where
> the regulator is shared or not switchable at all.
> On hardware where it is safe to disable the regulator and PWM
> keep_pwm_enabled=0' allows the system to poweroff PWM and powersupply for the
> fan to improve powersavings.
> 
> With this it is up to the administrator to provide the correct setting for
> this attribute as it highly depends on the actual hardware and/or usage.
> 
> Best regards,
> Alexander
> 
> 
> 

