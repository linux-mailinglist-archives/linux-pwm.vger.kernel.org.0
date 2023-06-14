Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43CD772F932
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Jun 2023 11:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244082AbjFNJah (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 14 Jun 2023 05:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244032AbjFNJaL (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 14 Jun 2023 05:30:11 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9370D1FEB;
        Wed, 14 Jun 2023 02:30:09 -0700 (PDT)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 825D386093;
        Wed, 14 Jun 2023 11:30:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1686735006;
        bh=gHe9QOpXgshvhLoIzYTw4Wb+apUJ5jktmuAeQ90/rDg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=I58B0kgb1VIeivyh1hT+Kz0J15HDxGRPOAuuXjbGumRfG2xSvsTg6RsAQx1WDefu8
         n8ZrgCU+h4BqeSjmCilvBL4aQLd6WvacqD1Szh589+9Iw9h8WPclx7+ulujp4ig/fW
         tc08egmQwbopwGCRwk4ZSXy/HScd5hfs9wozz4ieOSisUEuUSXaMqRGV8UaX7r8x29
         iCaX5zEup2v9MeKa8NVnlthMcrGcW/jh8w6GAoe1KPmfn466IKw+H+WGPenWTcJutr
         u/eTNs3tCWJiFsjgILB1iPU5XmaoPKoZwUAUdEKfTT6bELBGMndMaJ2siMOOy+kInh
         NqzJ/sMGUgkkw==
Message-ID: <2a910f52-6a33-5d5e-8bc3-a2ec01a65804@denx.de>
Date:   Wed, 14 Jun 2023 11:30:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] Input: pwm-beeper - Support volume setting via sysfs
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     linux-input@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Manuel Traut <manuel.traut@mt.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org
References: <20230512185551.183049-1-marex@denx.de>
 <20230614064510.nm3hhokjxe37hrjo@pengutronix.de>
Content-Language: en-US
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <20230614064510.nm3hhokjxe37hrjo@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 6/14/23 08:45, Uwe Kleine-König wrote:
> On Fri, May 12, 2023 at 08:55:51PM +0200, Marek Vasut wrote:
>> The PWM beeper volume can be controlled by adjusting the PWM duty cycle,
>> expose volume setting via sysfs, so users can make the beeper quieter.
>> This patch adds sysfs attribute 'volume' in range 0..50000, i.e. from 0
>> to 50% in 1/1000th of percent steps, this resolution should be sufficient.
>>
>> The reason for 50000 cap on volume or PWM duty cycle is because duty cycle
>> above 50% again reduces the loudness, the PWM wave form is inverted wave
>> form of the one for duty cycle below 50% and the beeper gets quieter the
>> closer the setting is to 100% . Hence, 50% cap where the wave form yields
>> the loudest result.
>>
>> Signed-off-by: Marek Vasut <marex@denx.de>
>> ---
>> An alternative option would be to extend the userspace input ABI, e.g. by
>> using SND_TONE top 16bits to encode the duty cycle in 0..50000 range, and
>> bottom 16bit to encode the existing frequency in Hz . Since frequency in
>> Hz is likely to be below some 25 kHz for audible bell, this fits in 16bits
>> just fine. Thoughts ?
>> ---
>> NOTE: This uses approach similar to [1], except it is much simpler.
>>        [1] https://patchwork.kernel.org/project/linux-input/cover/20230201152128.614439-1-manuel.traut@mt.com/
>> ---
>> Cc: "Uwe Kleine-König" <u.kleine-koenig@pengutronix.de>
>> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>> Cc: Frieder Schrempf <frieder.schrempf@kontron.de>
>> Cc: Manuel Traut <manuel.traut@mt.com>
>> Cc: Marek Vasut <marex@denx.de>
>> Cc: Thierry Reding <thierry.reding@gmail.com>
>> Cc: linux-input@vger.kernel.org
>> Cc: linux-pwm@vger.kernel.org
>> ---
>>   drivers/input/misc/pwm-beeper.c | 58 ++++++++++++++++++++++++++++++++-
>>   1 file changed, 57 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/input/misc/pwm-beeper.c b/drivers/input/misc/pwm-beeper.c
>> index 3cf1812384e6a..f63d0ebbaf573 100644
>> --- a/drivers/input/misc/pwm-beeper.c
>> +++ b/drivers/input/misc/pwm-beeper.c
>> @@ -21,6 +21,7 @@ struct pwm_beeper {
>>   	struct regulator *amplifier;
>>   	struct work_struct work;
>>   	unsigned long period;
>> +	unsigned long duty_cycle;
>>   	unsigned int bell_frequency;
>>   	bool suspended;
>>   	bool amplifier_on;
>> @@ -37,7 +38,7 @@ static int pwm_beeper_on(struct pwm_beeper *beeper, unsigned long period)
>>   
>>   	state.enabled = true;
>>   	state.period = period;
>> -	pwm_set_relative_duty_cycle(&state, 50, 100);
>> +	pwm_set_relative_duty_cycle(&state, beeper->duty_cycle, 100000);
>>   
>>   	error = pwm_apply_state(beeper->pwm, &state);
>>   	if (error)
>> @@ -119,6 +120,53 @@ static void pwm_beeper_close(struct input_dev *input)
>>   	pwm_beeper_stop(beeper);
>>   }
>>   
>> +static ssize_t volume_show(struct device *dev,
>> +			   struct device_attribute *attr,
>> +			   char *buf)
>> +{
>> +	struct pwm_beeper *beeper = dev_get_drvdata(dev);
>> +
>> +	return sysfs_emit(buf, "%ld\n", beeper->duty_cycle);
>> +}
>> +
>> +static ssize_t volume_store(struct device *dev,
>> +			    struct device_attribute *attr,
>> +			    const char *buf, size_t count)
>> +{
>> +	struct pwm_beeper *beeper = dev_get_drvdata(dev);
>> +	unsigned long val;
>> +
>> +	if (kstrtoul(buf, 0, &val) < 0)
>> +		return -EINVAL;
>> +
>> +	/*
>> +	 * Volume is really PWM duty cycle in pcm (per cent mille, 1/1000th
>> +	 * of percent). This value therefore ranges from 0 to 50000 . Duty
>> +	 * cycle of 50% = 50000pcm is the maximum volume .
>> +	 */
>> +	val = clamp(val, 0UL, 50000UL);
> 
> I wonder if you want to refuse values here that are not in the specified
> range, that is, something like:
> 
> 	if (val != clamp(val, 0UL, 50000UL))
> 		return -EINVAL;
> 
> I think this is more in line who other sysfs properties work?!

I am still waiting for the more general API design decision here from 
input maintainer, i.e. what was designed with Jeff above.

Yes, we can clamp the value, but I won't work on this unless there is 
clear answer how to go on with the API first.
