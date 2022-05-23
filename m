Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAE445312AB
	for <lists+linux-pwm@lfdr.de>; Mon, 23 May 2022 18:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237057AbiEWOTH (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 23 May 2022 10:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237060AbiEWOTG (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 23 May 2022 10:19:06 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D560D5A157;
        Mon, 23 May 2022 07:19:02 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-f1d2ea701dso18625336fac.10;
        Mon, 23 May 2022 07:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=p++q/oInJLNZnlYXEB0nnaM1Y3DC5PNbKabEhiejSmg=;
        b=Lhu/MBRskR+Zlfx5jjDJWR1GIrczulVhn1Tyf1PL5c7nMmEcF7gVyJyRDKjfIFHjcA
         XmIbmCO5p971jickZyYFDqifYDls1M9e6xyIRrkS0cJ+VGmKD3FK50Q4YWoT4GfPFdO4
         2vwGZGPd/eosZNwXuBrY3ngFcrj4xrU2RkRiVpW8MAhCQZz745qL/iaiDnj47oaInLmu
         2X2XxZAEap1fTkvevVgoaJowP6pPG+jAwAWD/txNKyiS2tJZSq11M0AmKcmbK2ruL8TX
         Y4xxQ1/JXTdkg5PrhciR4RJYAZVrbINLckvljLVH+xPgKj1cVNp8lecGi8stb5fVs6cw
         zlCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=p++q/oInJLNZnlYXEB0nnaM1Y3DC5PNbKabEhiejSmg=;
        b=jG1+2QUAYECaNiyBo0DNliJylaz9cKD6wxvBrVMfiA1q7X+9b5xixhsqZkP0hdvN4f
         gSIYAX0YqbOmLiV3qY+IAnIXrPZA+TMszMHbLy5AHkP48qdrhD2v6O/91omE1b1gDtkB
         vtWkPQr6GbhgSivveNLljBm8MOyg6hEtFOtdGcUQZopTPKZs6Kunvc68d+m0CDZ7QD+E
         d/0dvEG0cpsWTCCgo55wczfP+9D2x3v7djmEUJ3hdauE3cPOsb5d19w1oKAns5FJ06tg
         mgWyOUbfRwHwh0+aRoQ5Jt4swttJIDCo3Plyse+1z63n6JQ2G7lFH0Gk6CDe1U6/Wvae
         fs7w==
X-Gm-Message-State: AOAM53157els3BO6wUS4XCFOpqde0yoKbqSAUqH1ZF91extnSHT0TfXF
        1WXinGZ5k8R3QrbvAdxihJnzjj90ko9cKQ==
X-Google-Smtp-Source: ABdhPJybnhyvlsDP88NwMXC29nt0MyZPWfTBxXED+laoMkmkgBVy4R3Nic0/X7YN+ZjZ76XgExVG+w==
X-Received: by 2002:a05:6870:61cd:b0:e9:8de7:9c51 with SMTP id b13-20020a05687061cd00b000e98de79c51mr12071570oah.50.1653315540722;
        Mon, 23 May 2022 07:19:00 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v202-20020acaacd3000000b0032ae3d9bf6asm4024756oie.16.2022.05.23.07.18.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 May 2022 07:19:00 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <aa6f8c6c-6d8f-6d23-f035-00d27e7ec0af@roeck-us.net>
Date:   Mon, 23 May 2022 07:18:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v4 6/6] hwmon: pwm-fan: Remove internal duplicated
 pwm_state
Content-Language: en-US
To:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, linux-hwmon@vger.kernel.org,
        linux-pwm@vger.kernel.org,
        Markus Niebel <Markus.Niebel@ew.tq-group.com>
References: <20220523110513.407516-1-alexander.stein@ew.tq-group.com>
 <20220523110513.407516-7-alexander.stein@ew.tq-group.com>
 <20220523124614.74hwex5a4eedpitl@pengutronix.de>
 <4715301.GXAFRqVoOG@steina-w>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <4715301.GXAFRqVoOG@steina-w>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 5/23/22 06:55, Alexander Stein wrote:
> Hi Uwe,
> 
> Am Montag, 23. Mai 2022, 14:46:14 CEST schrieb Uwe Kleine-König:
>> * PGP Signed by an unknown key
>>
>> Hello,
>>
>> On Mon, May 23, 2022 at 01:05:13PM +0200, Alexander Stein wrote:
>>> Each pwm device has already a pwm_state. Use this one instead of
>>> managing an own copy of it.
>>>
>>> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
>>> ---
>>>
>>>   drivers/hwmon/pwm-fan.c | 49 +++++++++++++++++++++++++----------------
>>>   1 file changed, 30 insertions(+), 19 deletions(-)
>>>
>>> diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c
>>> index e5d4b3b1cc49..e0ce81cdf5e0 100644
>>> --- a/drivers/hwmon/pwm-fan.c
>>> +++ b/drivers/hwmon/pwm-fan.c
>>> @@ -40,7 +40,6 @@ struct pwm_fan_ctx {
>>>
>>>   	struct mutex lock;
>>>   	struct pwm_device *pwm;
>>>
>>> -	struct pwm_state pwm_state;
>>>
>>>   	struct regulator *reg_en;
>>>   	enum pwm_fan_enable_mode enable_mode;
>>>   	bool regulator_enabled;
>>>
>>> @@ -142,7 +141,7 @@ static int pwm_fan_switch_power(struct pwm_fan_ctx
>>> *ctx, bool on)>
>>>   static int pwm_fan_power_on(struct pwm_fan_ctx *ctx)
>>>   {
>>>
>>> -	struct pwm_state *state = &ctx->pwm_state;
>>> +	struct pwm_state state;
>>>
>>>   	int ret;
>>>   	
>>>   	if (ctx->enabled)
>>>
>>> @@ -154,8 +153,9 @@ static int pwm_fan_power_on(struct pwm_fan_ctx *ctx)
>>>
>>>   		return ret;
>>>   	
>>>   	}
>>>
>>> -	state->enabled = true;
>>> -	ret = pwm_apply_state(ctx->pwm, state);
>>> +	pwm_get_state(ctx->pwm, &state);
>>> +	state.enabled = true;
>>> +	ret = pwm_apply_state(ctx->pwm, &state);
>>>
>>>   	if (ret) {
>>>   	
>>>   		dev_err(ctx->dev, "failed to enable PWM\n");
>>>   		goto disable_regulator;
>>
>> IMHO this isn't a net win. You trade the overhead of pwm_get_state
>> against some memory savings. I personally am not a big fan of the
>> get_state + modify + apply codeflow. The PWM framework does internal
>> caching of the last applied state, but the details are a bit ugly. (i.e.
>> pwm_get_state returns the last applied state, unless there was no state
>> applied before. In that case it returns what .get_state returned during
>> request time, unless there is no .get_state callback ... not sure if the
>> device tree stuff somehow goes into that, didn't find it on a quick
>> glance)
>>
>> Also there is a (small) danger, that pwm_state contains something that
>> isn't intended by the driver, e.g. a wrong polarity. So I like the
>> consumer to fully specify what they intend and not use pwm_get_state().
> 
> Ah, I see. I have no hard feelings for this patch. I just wondered why the PWM
> state is duplicated. and wanted to get rid of it. If there is a specific
> reason for this, I'm ok with that.
> 

I don't see the value of continuous runtime overhead to save a few bytes of data,
so I don't see a reason to _not_ cache the state locally. This is similar to
caching a clock frequency locally instead of calling the clock subsystem again
and again to read it. Sure, nowadays CPUs are more powerful than they used to be,
but I don't see that as reason or argument for wasting their power.

Guenter
