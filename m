Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A934702E3B
	for <lists+linux-pwm@lfdr.de>; Mon, 15 May 2023 15:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242140AbjEONgH (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 15 May 2023 09:36:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242071AbjEONgG (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 15 May 2023 09:36:06 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F17F269D;
        Mon, 15 May 2023 06:36:05 -0700 (PDT)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id DF812865B9;
        Mon, 15 May 2023 15:36:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1684157763;
        bh=VvwtXNmqT+9Xv9njSAwrHnTTGKYxSQ01nyZaDrzJaj4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=yT/pnU8MPVOx1PpOoqWtluzsZz5/0bIclcRnIXH0J9Pjzrkjy3bXArNn/u828p8t6
         AudEt1vaiKHxP+VGsJm4IZozhjn76n0lgZdp+HD0OZWn1eIAsLQkIyprGAqM4T5Lgc
         s7ivXcUFXM5bcU7Y65PMLdsGGg6OzPDNn0w6Ou08G+B7FqbnQ+goBshP9WsUQOj1wI
         NbTLz8zSkEv4ugn1CcPMAwj5dwXaalbjkzfqiStVP7XF/nbLjc65UOqF7BPZ9/k3U7
         1iwPrrrDOwW7O1DX6VhGHz6MJ46XYvoCMfDBTUurC+LgZfPVyp/ES42/W++V9VHANu
         jrEAgWBaSHOuA==
Message-ID: <a5293af4-8d02-ed8f-52d1-722c71d47f37@denx.de>
Date:   Mon, 15 May 2023 15:36:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: AW: EXTERNAL - [PATCH] Input: pwm-beeper - Support volume setting
 via sysfs
Content-Language: en-US
To:     Traut Manuel LCPF-CH <Manuel.Traut@mt.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
Cc:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>
References: <20230512185551.183049-1-marex@denx.de>
 <AS8PR03MB76211DFFD1261B00E55FF50BFA789@AS8PR03MB7621.eurprd03.prod.outlook.com>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <AS8PR03MB76211DFFD1261B00E55FF50BFA789@AS8PR03MB7621.eurprd03.prod.outlook.com>
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

On 5/15/23 08:50, Traut Manuel LCPF-CH wrote:
> Hi Marek,

Hi,

>> The PWM beeper volume can be controlled by adjusting the PWM duty cycle, expose volume setting via sysfs, so users can make the beeper quieter.
>> This patch adds sysfs attribute 'volume' in range 0..50000, i.e. from 0 to 50% in 1/1000th of percent steps, this resolution should be sufficient.
>>
>> The reason for 50000 cap on volume or PWM duty cycle is because duty cycle above 50% again reduces the loudness, the PWM wave form is inverted > wave form of the one for duty cycle below 50% and the beeper gets quieter the closer the setting is to 100% . Hence, 50% cap where the wave form yields the loudest result.
>>
>>   Signed-off-by: Marek Vasut <marex@denx.de>
>> ---
>> An alternative option would be to extend the userspace input ABI, e.g. by using SND_TONE top 16bits to encode the duty cycle in 0..50000 range, and bottom 16bit to encode the existing frequency in Hz . Since frequency in Hz is likely to be below some 25 kHz for audible bell, this fits in 16bits just fine. Thoughts ?
> 
> I tend to not change existing user-space interfaces. I would prefer to have an additional event or using sysfs.

I am increasingly concerned about the race condition between change of 
volume (via sysfs) and frequency (via SND_TONE) . So I would be banking 
toward additional event, like SND_TONE_WITH_VOLUME or something along 
those lines.

>> ---
>> NOTE: This uses approach similar to [1], except it is much simpler.
>>       [1] https://patchwork.kernel.org/project/linux-input/cover/20230201152128.614439-1-manuel.traut@mt.com/
> 
> This one is more complex, because the mapping between duty cycle and volume is not linear. Probably it depends also on the used beeper hardware which values are doing a significant change in volume. Therefore the patchset introduced a mapping between volume levels and duty cycle times in the device-tree to allow user-space applications to control the beeper volume hardware independently.

I wonder whether this mapping shouldn't be considered policy and left to 
userspace to deal with, instead of swamping the kernel or DT with it ?

-- 
Best regards,
Marek Vasut
