Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C8C952A948
	for <lists+linux-pwm@lfdr.de>; Tue, 17 May 2022 19:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245557AbiEQRcU (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 17 May 2022 13:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbiEQRcT (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 17 May 2022 13:32:19 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC18839BB5;
        Tue, 17 May 2022 10:32:18 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id l16so23137358oil.6;
        Tue, 17 May 2022 10:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=BJElMM5glBuikAlneHtVK8Xyaeh/Q6HpqJfojQYBOpY=;
        b=THs9ZoSuwm1t8oeajABxV5sJnjaYI3vICw1E+k2fjpgH6rTc9J4wMere5w3WHkxB7s
         GmMYjnumNA4ffTIfc/T7S3iEMRwQRgRWJiEcvz1FP2vCKohgc4L+wxW7mJBRWW8qVLgG
         H36uUVzzyasQ3ruq8AyJHPVJ6Gc/EHyd/PWeyPjvPaMRTOpjUChJ4YTeXZ1muDawj8KN
         FTgmiVrgfkWISpSeyyiAzXarfL5qk4yXyhAy1cPe5zqHIte5Iy8poMHup752Fjy7MK/S
         kKnX9FwlU9LLju+gLoshZ3imXeMPX5kez6BRGumWFGGBD2IgIWc5jT2uyQ31UgKhdxiA
         RPww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=BJElMM5glBuikAlneHtVK8Xyaeh/Q6HpqJfojQYBOpY=;
        b=wHoaXc657zXOJhfcM6YVvwj0Kajuf+ivIriPQJa70Td1TNcn8dIW8gcT82qIobwE3g
         jqwnifP/bZTBqA5SJjYOLJvMc29myOz8d7PIKTJDLhnjkrQVvo7uRK0nYXG1mMk5BM0e
         gn09CVxayh2fES0Rl5J0cVJuzG7wV63+GSA6+r4j/7x7anCDzVhl7a6TFoJM1sod8AIU
         waq3D8v71wmdLvnizyDWWm8BudPig9LUvgDdISpookWw/eiZJ/KPESn3oiKpHTJ9RN/P
         yMJ5k2Q3EDeHBboIR2A1oCYOgAvz4T5+RsySpSloMMrbh48oaGmbFSbGEHX5OZEe1a/T
         dsJg==
X-Gm-Message-State: AOAM530cY6o8ugth7QYxnkhtIF4jIr0aNOxRTxndPO3ifL4ekWqwtiuc
        Sty1ivFpy5uWFNCa+LLFISjuMwXmFpxfNg==
X-Google-Smtp-Source: ABdhPJytQGHxVYUPBBCqbrYVfWYGdfVG5jHpZKaFfFhDgKmIFvg/Hklre3Urgxe0XYKjO1EXGOlEOQ==
X-Received: by 2002:a05:6808:118f:b0:2d9:a01a:48be with SMTP id j15-20020a056808118f00b002d9a01a48bemr16047571oil.265.1652808738009;
        Tue, 17 May 2022 10:32:18 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a9-20020a056870618900b000edda81f868sm15201oah.10.2022.05.17.10.32.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 May 2022 10:32:17 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <c8f3e1b3-23e4-1dcb-7da3-e21a01062e9d@roeck-us.net>
Date:   Tue, 17 May 2022 10:32:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v3 6/6] hwmon: pwm-fan: Add hwmon_pwm_enable attribute
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, linux-hwmon@vger.kernel.org,
        linux-pwm@vger.kernel.org,
        Markus Niebel <Markus.Niebel@ew.tq-group.com>
References: <20220517142620.1523143-1-alexander.stein@ew.tq-group.com>
 <20220517142620.1523143-7-alexander.stein@ew.tq-group.com>
 <20220517145331.7ffab4pyjwrh5lkg@pengutronix.de>
 <194f33ea-18fa-4cb3-56b4-5d423463fa82@roeck-us.net>
 <20220517165726.trxa7lpz6kluvrg3@pengutronix.de>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20220517165726.trxa7lpz6kluvrg3@pengutronix.de>
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

On 5/17/22 09:57, Uwe Kleine-König wrote:
> Hello,
> 
> [dropping Bartlomiej Zolnierkiewicz from Cc as the address bounces]
> 
> On Tue, May 17, 2022 at 09:32:24AM -0700, Guenter Roeck wrote:
>> On 5/17/22 07:53, Uwe Kleine-König wrote:
>>> Hello,
>>>
>>> On Tue, May 17, 2022 at 04:26:20PM +0200, Alexander Stein wrote:
>>>> This adds the enable attribute which is used to differentiate if PWM duty
>>>> means to switch off regulator and PWM or to keep them enabled but
>>>> at inactive PWM output level.
>>>>
>>>> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
>>>> ---
>>>>    Documentation/hwmon/pwm-fan.rst | 10 ++++
>>>>    drivers/hwmon/pwm-fan.c         | 95 +++++++++++++++++++++++++++++----
>>>>    2 files changed, 95 insertions(+), 10 deletions(-)
>>>>
>>>> diff --git a/Documentation/hwmon/pwm-fan.rst b/Documentation/hwmon/pwm-fan.rst
>>>> index 82fe96742fee..0083480068d1 100644
>>>> --- a/Documentation/hwmon/pwm-fan.rst
>>>> +++ b/Documentation/hwmon/pwm-fan.rst
>>>> @@ -18,3 +18,13 @@ the hwmon's sysfs interface.
>>>>    The fan rotation speed returned via the optional 'fan1_input' is extrapolated
>>>>    from the sampled interrupts from the tachometer signal within 1 second.
>>>> +
>>>> +The driver provides the following sensor accesses in sysfs:
>>>> +
>>>> +=============== ======= =======================================================
>>>> +fan1_input	ro	fan tachometer speed in RPM
>>>> +pwm1_enable	rw	keep enable mode, defines behaviour when pwm1=0
>>>> +			0=switch off regulator and disable PWM
>>>> +			1=keep regulator enabled and set PWM to inactive level
>>>
>>> Is the pwm1_enable supposed to be set to 0 if that only does the right
>>> thing if the PWM emits low after pwm_disable()? The question I raised in
>>> v2 about "what is the meaning of disable?" hasn't evolved, has it?
>>>
>>> I still think it's unfortunate, that "pwm1_enable" has an effect on the
>>> regulator.
>>>
>>
>> Trying to understand. Are you saying that you are ok with affecting the
>> regulator when setting pwm := 0 (even though that doesn't really mean
>> "disable pwm output"), but not with making the behavior explicit by
>> using pwm1_enable ?
> 
> Not sure about being ok with affecting the regulator when setting
> pwm := 0. I don't know enough about pwm-fans to have a strong opinion
> for that.
> 
> Some questions to refine the semantics and my opinion:
> 
> There are fans without a regulator? (I think: yes)
> 
> A fan with a regulator always stops if the regulator is off?
> (Hmm, there might be problems with shared regulators that only go off
> when all consumers are off? What about always-on regulators, these don't
> go off on the last consumer calling disable, right?)
> 
> Having said that I think the sane behaviour is:
> 
> The intention of pwm := 0 is to stop the fan. So disabling the regulator
> (if available) sounds right.
> 

There are fans (eg at least some CPU fans) which never stop, even with
pwm=0. How do you suggest to handle those ?

Guenter

> I'm unsure what to reasonably expect from a disabled PWM. I think "stops
> to oscillate" can be assumed. So I'd say: If a fan continues to rotate
> when the PWM input is constantly active, don't call pwm_disable().
> 
> Best regards
> Uwe
> 

