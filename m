Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18A6076999E
	for <lists+linux-pwm@lfdr.de>; Mon, 31 Jul 2023 16:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbjGaOgG (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 31 Jul 2023 10:36:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbjGaOgG (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 31 Jul 2023 10:36:06 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C33BD3;
        Mon, 31 Jul 2023 07:36:04 -0700 (PDT)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id D81E986607;
        Mon, 31 Jul 2023 16:36:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1690814162;
        bh=jnZo8rrdvercbOObm4FArnawsutg/GxcCBnaawS7O0g=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=DfMNxxhfACUopJ7R4pclUnxUrO3OOawfS7gOFob+CdnRkYRS+tNW9KLSofuq7q/rE
         OmZBjaegL2CyTts51zPT34erOr9DobJZ1XRCvXmtN4AIDNnqXjwVe32hUgd7fqBCtV
         pZU3HQC4cj2zSb5Wyzku/TS5taAt7q0bCjHPlBULKdCZ/s5/mINKBqDZyMQRNQD7es
         8MmTOElHb/fTvzUbBrrOQffXRlQueMwPMrzke5PRbctbqQ4dCc5I2meE9x3eC3IoPs
         rcBkSBOiEC/DYkjBqLBIwgC5lyU2Qk51NJIse61yXwkK3r55r/IhQevphp+ObCMvKA
         Bhcb94QLSvfkQ==
Message-ID: <618add56-3675-4efe-5b20-665c10040e03@denx.de>
Date:   Mon, 31 Jul 2023 16:36:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH] Input: pwm-beeper - Support volume setting via sysfs
Content-Language: en-US
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jeff LaBundy <jeff@labundy.com>, linux-input@vger.kernel.org,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Manuel Traut <manuel.traut@mt.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org, alsa-devel@alsa-project.org,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
References: <20230512185551.183049-1-marex@denx.de> <ZF7kCjKGVjsxK8ec@nixie71>
 <0ef98ec1-6191-c72e-2362-310db7f09b84@denx.de>
 <06379f26-ab24-85f9-783f-0c49d4291b23@denx.de> <ZMdIZiC453onyeHh@google.com>
 <873514d2ju.wl-tiwai@suse.de> <63adce9a-df65-b462-9055-0ece5216d680@denx.de>
 <87tttkjmyu.wl-tiwai@suse.de> <0cffe366-75af-d8a8-8920-6fb94c321a89@denx.de>
 <87h6pkjh7q.wl-tiwai@suse.de>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <87h6pkjh7q.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 7/31/23 16:20, Takashi Iwai wrote:

[...]

>>>> Uh, I don't need a full sound device to emit beeps, that's not even
>>>> possible with this hardware.
>>>
>>> Heh, I also don't recommend that route, either :)
>>> (Though, it must be possible to create a sound device with that beep
>>> control in theory)
>>
>> I mean, I can imagine one could possibly use PCM DMA to cook samples
>> to feed some of the PWM devices so they could possibly be used to
>> generate low quality audio, as a weird limited DAC, but ... that's not
>> really generic, and not what I want.
> 
> Oh I see how the misunderstanding came; I didn't mean the PCM
> implementation like pcsp driver.  The pcsp driver is a real hack and
> it's there just for fun, not for any real practical use.

Ah :)

> What I meant was rather that you can create a sound device containing
> a mixer volume control that serves exactly like the sysfs or whatever
> other interface, without any PCM stream or other interface.

Ahhh, hum, I still feel like this might be a bit overkill here.

>>>> I only need to control loudness of the
>>>> beeper that is controlled by PWM output. That's why I am trying to
>>>> extend the pwm-beeper driver, which seems the best fit for such a
>>>> device, it is only missing this one feature (loudness control).
>>>
>>> So the question is what's expected from user-space POV.  If a more
>>> generic control of beep volume is required, e.g. for desktop-like
>>> usages, an implementation of sound driver wouldn't be too bad.
>>> OTOH, for other specific use-cases, it doesn't matter much in which
>>> interface it's implemented, and sysfs could be an easy choice.
>>
>> The whole discussion above has been exactly about this. Basically the
>> thing is, we can either have:
>> - SND_TONE (via some /dev/input/eventX) + sysfs volume control
>>    -> This is simple, but sounds racy between input and sysfs accesses
> 
> Hmm, how can it be racy if you do proper locking?

I can imagine two applications can each grab one of the controls and 
that makes the interface a bit not nice. That would require extra 
synchronization in userspace and so on.

>> - SND_TONE + SND_TONE_SET_VOLUME
>>    -> User needs to do two ioctls, hum
>> - some new SND_TONE_WITH_VOLUME
>>    -> Probably the best option, user sets both tone frequency and volume
>>       in one go, and it also only extends the IOCTL interface, so older
>>       userspace won't have issues
> 
> Those are "extensions" I have mentioned, and I'm not a big fan for
> that, honestly speaking.
> 
> The fact that the beep *output* stuff is provided by the *input*
> device is already confusing

I agree, this confused me as well.

> (it was so just because of historical
> reason), and yet you start implementing more full-featured mixer
> control.  I'd rather keep fingers away.
> 
> Again, if user-space requires the compatible behavior like the
> existing desktop usages

It does not. These pwm-beeper devices keep showing up in various 
embedded devices these days.

>, it can be implemented in a similar way like
> the existing ones; i.e. provide a mixer control with a proper sound
> device.  The sound device doesn't need to provide a PCM interface but
> just with a mixer interface.
> 
> Or, if the purpose of your target device is a special usage, you don't
> need to consider too much about the existing interface, and try to
> keep the change as minimal as possible without too intrusive API
> changes.

My use case is almost perfectly matched by the current input pwm-beeper 
driver, the only missing bit is the ability to control the loudness at 
runtime. I think adding the SND_TONE_WITH_VOLUME parameter would cover 
it, with least intrusive API changes.

The SND_TONE already supports configuring tone frequency in Hz as its 
parameter. Since anything above 64 kHz is certainly not hearable by 
humans, I would say the SND_TONE_WITH_VOLUME could use 16 LSbits for 
frequency (so up to 65535 Hz , 0 is OFF), and 16 MSbits for volume .

I'm hesitant to overcomplicate something which can currently be 
controlled via single ioctl by pulling in sound subsystem into the picture.
