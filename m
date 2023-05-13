Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24C527019F3
	for <lists+linux-pwm@lfdr.de>; Sat, 13 May 2023 23:02:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbjEMVCh (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 13 May 2023 17:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235216AbjEMVCg (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 13 May 2023 17:02:36 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC4D12D6B;
        Sat, 13 May 2023 14:02:33 -0700 (PDT)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 6840484702;
        Sat, 13 May 2023 23:02:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1684011751;
        bh=xMKngEpU+tbf1H2EtUq2y+MuhxwSpJotx4AqYJpDGRA=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=AHw3/S8vxhc/DtBLcBSczWZL0731O9FsWqy7W8xvTU72PTzOGdV6SwlM/tfC8gNu0
         XB5XsD80b4m1NoVb6W7pz3N0U+WRvWEc5Q3p4gmvQ6aVukqo1MFxJ1ph6Mz0JrZgE7
         2ITz+1HltXVQkoEoBhaRSubtVOQboydKvjcYsE/tWFV3PQlxb+fksEMxBHA14jHEPL
         eQTxsNRCu1jSGbqE0XUisVcAy+58QBIwvXlJkJNze5hQIGaIdjjKNzj7ldT7VbMKTx
         fhgAp0laPm/8ut0bK5eWqMANcksqptENoFsxuLFVAyWCTzw8ohrxQwN8j9TMmpTQBH
         7tZrIH5BSreLA==
Message-ID: <06379f26-ab24-85f9-783f-0c49d4291b23@denx.de>
Date:   Sat, 13 May 2023 23:02:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] Input: pwm-beeper - Support volume setting via sysfs
From:   Marek Vasut <marex@denx.de>
To:     Jeff LaBundy <jeff@labundy.com>
Cc:     linux-input@vger.kernel.org,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Manuel Traut <manuel.traut@mt.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org
References: <20230512185551.183049-1-marex@denx.de> <ZF7kCjKGVjsxK8ec@nixie71>
 <0ef98ec1-6191-c72e-2362-310db7f09b84@denx.de>
Content-Language: en-US
In-Reply-To: <0ef98ec1-6191-c72e-2362-310db7f09b84@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 5/13/23 03:51, Marek Vasut wrote:
> On 5/13/23 03:12, Jeff LaBundy wrote:
>> Hi Marek,
> 
> Hi,
> 
>> On Fri, May 12, 2023 at 08:55:51PM +0200, Marek Vasut wrote:
>>> The PWM beeper volume can be controlled by adjusting the PWM duty cycle,
>>> expose volume setting via sysfs, so users can make the beeper quieter.
>>> This patch adds sysfs attribute 'volume' in range 0..50000, i.e. from 0
>>> to 50% in 1/1000th of percent steps, this resolution should be 
>>> sufficient.
>>>
>>> The reason for 50000 cap on volume or PWM duty cycle is because duty 
>>> cycle
>>> above 50% again reduces the loudness, the PWM wave form is inverted wave
>>> form of the one for duty cycle below 50% and the beeper gets quieter the
>>> closer the setting is to 100% . Hence, 50% cap where the wave form 
>>> yields
>>> the loudest result.
>>>
>>> Signed-off-by: Marek Vasut <marex@denx.de>
>>> ---
>>> An alternative option would be to extend the userspace input ABI, 
>>> e.g. by
>>> using SND_TONE top 16bits to encode the duty cycle in 0..50000 range, 
>>> and
>>> bottom 16bit to encode the existing frequency in Hz . Since frequency in
>>> Hz is likely to be below some 25 kHz for audible bell, this fits in 
>>> 16bits
>>> just fine. Thoughts ?
>>> ---
>>
>> Thanks for the patch; this seems like a useful feature.
>>
>> My first thought is that 50000 seems like an oddly specific limit to 
>> impose
>> upon user space. Ideally, user space need not even care that the 
>> beeper is
>> implemented via PWM and why 50000 is significant.
>>
>> Instead, what about accepting 0..255 as the LED subsystem does for 
>> brightness,
>> then map these values to 0..50000 internally? In fact, the leds-pwm 
>> driver
>> does something similar.
> 
> The pwm_set_relative_duty_cycle() function can map whatever range to 
> whatever other range of the PWM already, so that's not an issues here. 
> It seems to me the 0..127 or 0..255 range is a bit too limiting . I 
> think even for the LEDs the reason for that limit is legacy design, but 
> here I might be wrong.
> 
>> I'm also curious as to whether this function should be a rogue sysfs 
>> control
>> limited to this driver, or a generic operation in input. For example, 
>> input
>> already allows user space to specify the magnitude of an FF effect; 
>> perhaps
>> something similar is warranted here?
> 
> See the "An alternative ..." part above, I was wondering about this too, 
> whether this can be added into the input ABI, but I am somewhat 
> reluctant to fiddle with the ABI.

Thinking about this further, we could try and add some

EV_SND SND_TONE_WITH_VOLUME

to avoid overloading EV_SND SND_TONE , and at the same time allow the 
user to set both frequency and volume for the tone without any race 
condition between the two.

The EV_SND SND_TONE_WITH_VOLUME would still take one 32bit parameter, 
except this time the parameter 16 LSbits would be the frequency and 16 
MSbits would be the volume.

But again, here I would like input from the maintainers.
