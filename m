Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B635852A7F8
	for <lists+linux-pwm@lfdr.de>; Tue, 17 May 2022 18:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232072AbiEQQcb (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 17 May 2022 12:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbiEQQc3 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 17 May 2022 12:32:29 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5453714D1E;
        Tue, 17 May 2022 09:32:28 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-f18e6ff0f6so10499561fac.11;
        Tue, 17 May 2022 09:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=qGnWbWy3aO1eGRVxepjzhSmYZUn2XL3s9RtV8/5QDEs=;
        b=Fs8GEuXcOh9SmKwe149VvNfnSQkMisvdVGJSLHSZ4ayBXXJnmTQkinANxSW9pmh+1e
         PgZjojphaVYYu+h5x+8p6JzatoQy2YUN5I71G8fzE6oOf09jAxOi9WkIa23sO5ozdlnr
         QhOpiV9C1UwvkMkHl8uthsElboiTjZjQlfsnQ4IcF+FOaqzy3dl5Ry2waFl80++sR3is
         Pa9zL2OWBrd2KBGmRSjWfVGGU3tRkp/C6uphHMAXp7LFnU8BMOMDRSQeDj14kwZESSOM
         Sv32Ckw+m5QthpXEQUx4sIXRQHxaHoWJwwWLakmIvUWBlByAU+tirYdrSXomO+KNI1jL
         RRZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=qGnWbWy3aO1eGRVxepjzhSmYZUn2XL3s9RtV8/5QDEs=;
        b=tw49FUyGAIazJqv9ujsDMjI1+9FcBZV1G/Ouol7a4Q90WdwFRXAe+q9xyN535GfpSU
         Yw877aQxU6MjHtK4GRBZtYceP15frfNnm3VGq4/XPbapn0I9OnDGtJOCE7gSUlmkymlR
         UEoO5EPeZYI/Qk2sLMPFYaWcBzU5OCBNuqqlR8ODXY0SO2mysP2LxvbLRs4/Jy/3U1go
         DLd1tubwnJEZxES5/KPWgGc7QgQOJgEcQBD2AzbZy9Ad9u2LHNUfVPS8YzPRnxVWYbrn
         VcTGa4CuOQZEuMCMnV2moEdce7XAGuRoALNFeCADPt8r0p4uXwcYyglG/5w7Kwde9VJH
         aMAw==
X-Gm-Message-State: AOAM530o+dL5izXyxnsjvMLiOWQzixzPTpYKtAmH5SrpOuH55IEpianS
        mgHdOH+7U2gjMQj+UC5V/FazemgrKcKanA==
X-Google-Smtp-Source: ABdhPJxjOsF9qSonKPfTHvN63tD/BYCISbLB+/bfHGSVFy97BNjF/E/YILvW+SKcl22aRPAjWAR1EA==
X-Received: by 2002:a05:6870:392b:b0:f1:914e:25e7 with SMTP id b43-20020a056870392b00b000f1914e25e7mr7478220oap.31.1652805147282;
        Tue, 17 May 2022 09:32:27 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o14-20020a056870910e00b000f193e656c5sm3780660oae.15.2022.05.17.09.32.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 May 2022 09:32:26 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <194f33ea-18fa-4cb3-56b4-5d423463fa82@roeck-us.net>
Date:   Tue, 17 May 2022 09:32:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v3 6/6] hwmon: pwm-fan: Add hwmon_pwm_enable attribute
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Alexander Stein <alexander.stein@ew.tq-group.com>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, linux-hwmon@vger.kernel.org,
        linux-pwm@vger.kernel.org,
        Markus Niebel <Markus.Niebel@ew.tq-group.com>
References: <20220517142620.1523143-1-alexander.stein@ew.tq-group.com>
 <20220517142620.1523143-7-alexander.stein@ew.tq-group.com>
 <20220517145331.7ffab4pyjwrh5lkg@pengutronix.de>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20220517145331.7ffab4pyjwrh5lkg@pengutronix.de>
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

On 5/17/22 07:53, Uwe Kleine-König wrote:
> Hello,
> 
> On Tue, May 17, 2022 at 04:26:20PM +0200, Alexander Stein wrote:
>> This adds the enable attribute which is used to differentiate if PWM duty
>> means to switch off regulator and PWM or to keep them enabled but
>> at inactive PWM output level.
>>
>> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
>> ---
>>   Documentation/hwmon/pwm-fan.rst | 10 ++++
>>   drivers/hwmon/pwm-fan.c         | 95 +++++++++++++++++++++++++++++----
>>   2 files changed, 95 insertions(+), 10 deletions(-)
>>
>> diff --git a/Documentation/hwmon/pwm-fan.rst b/Documentation/hwmon/pwm-fan.rst
>> index 82fe96742fee..0083480068d1 100644
>> --- a/Documentation/hwmon/pwm-fan.rst
>> +++ b/Documentation/hwmon/pwm-fan.rst
>> @@ -18,3 +18,13 @@ the hwmon's sysfs interface.
>>   
>>   The fan rotation speed returned via the optional 'fan1_input' is extrapolated
>>   from the sampled interrupts from the tachometer signal within 1 second.
>> +
>> +The driver provides the following sensor accesses in sysfs:
>> +
>> +=============== ======= =======================================================
>> +fan1_input	ro	fan tachometer speed in RPM
>> +pwm1_enable	rw	keep enable mode, defines behaviour when pwm1=0
>> +			0=switch off regulator and disable PWM
>> +			1=keep regulator enabled and set PWM to inactive level
> 
> Is the pwm1_enable supposed to be set to 0 if that only does the right
> thing if the PWM emits low after pwm_disable()? The question I raised in
> v2 about "what is the meaning of disable?" hasn't evolved, has it?
> 
> I still think it's unfortunate, that "pwm1_enable" has an effect on the
> regulator.
> 

Trying to understand. Are you saying that you are ok with affecting the
regulator when setting pwm := 0 (even though that doesn't really mean
"disable pwm output"), but not with making the behavior explicit by
using pwm1_enable ?

Thanks,
Guenter
