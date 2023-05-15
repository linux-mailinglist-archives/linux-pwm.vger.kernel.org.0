Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C51470384C
	for <lists+linux-pwm@lfdr.de>; Mon, 15 May 2023 19:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242834AbjEORbb (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 15 May 2023 13:31:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244288AbjEORam (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 15 May 2023 13:30:42 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15ECB13C22;
        Mon, 15 May 2023 10:27:55 -0700 (PDT)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 1888E8478A;
        Mon, 15 May 2023 19:27:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1684171641;
        bh=euDgCkO4r8bbwet9NVtgE1o4qDkednG2I68NfVUeIwo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=nerVXWmkqhfEzPEOdz7N1oZg+XLqBDNPDdq51oTObWz55Ic5LtvyyZeAw3eyG3gKT
         gOpZ0I7maKLEQrPfqSJ2/bFiMP78BBg1xqRVlMxbkVzZlcA3jMmc3c9hnnt+DbZHrA
         M+UN1/vAkAlV1lDEWo1SFwyREzb/c8E4NVyy+hsALe/9CtUosN6o7yAEV4eO2kEYDx
         7+e5jMS5hTe1m7k9mJyAOHMeQBOfyOku7zKDIY1Pmysyr9c+c3BAbl14xMzmIZ7sTy
         GzCCv5fUQ07kIQjhy81YIkF1VciUDqQWZhTQis1EO5FFWcSHoRpoMnpFPxdbhZUqmV
         NMZM5/weu7+8g==
Message-ID: <5e11dd95-f087-336e-bff2-7d5de3c02319@denx.de>
Date:   Mon, 15 May 2023 19:27:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: AW: EXTERNAL - [PATCH] Input: pwm-beeper - Support volume setting
 via sysfs
To:     Jeff LaBundy <jeff@labundy.com>
Cc:     Traut Manuel LCPF-CH <Manuel.Traut@mt.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>
References: <20230512185551.183049-1-marex@denx.de>
 <AS8PR03MB76211DFFD1261B00E55FF50BFA789@AS8PR03MB7621.eurprd03.prod.outlook.com>
 <a5293af4-8d02-ed8f-52d1-722c71d47f37@denx.de> <ZGJA2M+V8ualidHH@nixie71>
Content-Language: en-US
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <ZGJA2M+V8ualidHH@nixie71>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 5/15/23 16:25, Jeff LaBundy wrote:
> Hi Marek and Traut,

Hi,

> On Mon, May 15, 2023 at 03:36:02PM +0200, Marek Vasut wrote:
>> On 5/15/23 08:50, Traut Manuel LCPF-CH wrote:
>>> Hi Marek,
>>
>> Hi,
>>
>>>> The PWM beeper volume can be controlled by adjusting the PWM duty cycle, expose volume setting via sysfs, so users can make the beeper quieter.
>>>> This patch adds sysfs attribute 'volume' in range 0..50000, i.e. from 0 to 50% in 1/1000th of percent steps, this resolution should be sufficient.
>>>>
>>>> The reason for 50000 cap on volume or PWM duty cycle is because duty cycle above 50% again reduces the loudness, the PWM wave form is inverted > wave form of the one for duty cycle below 50% and the beeper gets quieter the closer the setting is to 100% . Hence, 50% cap where the wave form yields the loudest result.
>>>>
>>>>    Signed-off-by: Marek Vasut <marex@denx.de>
>>>> ---
>>>> An alternative option would be to extend the userspace input ABI, e.g. by using SND_TONE top 16bits to encode the duty cycle in 0..50000 range, and bottom 16bit to encode the existing frequency in Hz . Since frequency in Hz is likely to be below some 25 kHz for audible bell, this fits in 16bits just fine. Thoughts ?
>>>
>>> I tend to not change existing user-space interfaces. I would prefer to have an additional event or using sysfs.
>>
>> I am increasingly concerned about the race condition between change of
>> volume (via sysfs) and frequency (via SND_TONE) . So I would be banking
>> toward additional event, like SND_TONE_WITH_VOLUME or something along those
>> lines.
> 
> This is just my $.02, but I don't see anything wrong with proposing an
> _additive_ change to the ABI such as this. My only concern is that this
> kind of change seems useful to any effect (e.g. SND_BEEP) and not limited
> to only tones. Unless volume adjustment is less useful for those?

I would say the volume should also apply to SND_BEEP, sure.

>>>> ---
>>>> NOTE: This uses approach similar to [1], except it is much simpler.
>>>>        [1] https://patchwork.kernel.org/project/linux-input/cover/20230201152128.614439-1-manuel.traut@mt.com/
>>>
>>> This one is more complex, because the mapping between duty cycle and volume is not linear. Probably it depends also on the used beeper hardware which values are doing a significant change in volume. Therefore the patchset introduced a mapping between volume levels and duty cycle times in the device-tree to allow user-space applications to control the beeper volume hardware independently.
>>
>> I wonder whether this mapping shouldn't be considered policy and left to
>> userspace to deal with, instead of swamping the kernel or DT with it ?
> 
> I agree that the kernel need not try and linearize the values; in fact LEDs
> already have the same problem. I still feel however that imposing a unique
> maximum value (e.g. 50,000) is inappropriate because the range should remain
> the same regardless of the underlying HW implementation (PWM, class A/B, etc.).

We can easily just say 0..65536 if we agree the 16 MSbits are the volume 
, that's really not a problem.
