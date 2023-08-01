Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBF0C76B413
	for <lists+linux-pwm@lfdr.de>; Tue,  1 Aug 2023 13:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233638AbjHAL6D (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 1 Aug 2023 07:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234422AbjHAL54 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 1 Aug 2023 07:57:56 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B86201734;
        Tue,  1 Aug 2023 04:57:47 -0700 (PDT)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id E94AB86ACB;
        Tue,  1 Aug 2023 13:57:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1690891065;
        bh=P3vt4uEEwiqIv/Bdy86/gY93zD6L6hfcmgfpfbajJjM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=CNt26ztBP3MxbCxe93JjQ+vcRLRJnnZ2wuxlzmJvDjMggMzUCkQTVt+OFOS7nzRXm
         dZCtIY39Dht5GivZZJxWrNZR27n+OFas54oOP3aID37aONiFGNV339D99msiXl6y7j
         Y1rOEaO0VrVYnZq3yGfo9/qeESWWfqtw4EFLCa3ip9iPN9dwCQgSUTWKx6RP5VTOfr
         vMUmrpul0Io0ixJi308lZC4OuyeUAxCRl4qV9aDDZow5LAN6wgtRdh0zSVtQM9Dn0W
         C35g5RpQGzri0RVmNbMDjS8aWnxNxXU2bgr+2NWOg7pTRn5hFpzP+nYOW6UCVvHx0t
         DYiUzYHL9UNsA==
Message-ID: <ce419a1e-bf1a-1087-a7ee-37f85a11c596@denx.de>
Date:   Tue, 1 Aug 2023 13:38:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH] Input: pwm-beeper - Support volume setting via sysfs
To:     Takashi Iwai <tiwai@suse.de>, Jeff LaBundy <jeff@labundy.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Manuel Traut <manuel.traut@mt.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org, alsa-devel@alsa-project.org,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
References: <06379f26-ab24-85f9-783f-0c49d4291b23@denx.de>
 <ZMdIZiC453onyeHh@google.com> <873514d2ju.wl-tiwai@suse.de>
 <63adce9a-df65-b462-9055-0ece5216d680@denx.de> <87tttkjmyu.wl-tiwai@suse.de>
 <0cffe366-75af-d8a8-8920-6fb94c321a89@denx.de> <87h6pkjh7q.wl-tiwai@suse.de>
 <618add56-3675-4efe-5b20-665c10040e03@denx.de> <ZMfgJ3o00nApkXGp@google.com>
 <f4612dc5-a7d4-74ba-2ed8-ea70314625b6@denx.de> <ZMh0Sa9s25JHhWw5@nixie71>
 <87a5vbi96v.wl-tiwai@suse.de>
Content-Language: en-US
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <87a5vbi96v.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 8/1/23 08:11, Takashi Iwai wrote:
> On Tue, 01 Aug 2023 04:56:09 +0200,
> Jeff LaBundy wrote:
>>
>> Hi all,
>>
>> On Mon, Jul 31, 2023 at 07:49:50PM +0200, Marek Vasut wrote:
>>> On 7/31/23 18:24, Dmitry Torokhov wrote:
>>>> On Mon, Jul 31, 2023 at 04:36:01PM +0200, Marek Vasut wrote:
>>>>> On 7/31/23 16:20, Takashi Iwai wrote:
>>>>>
>>>>> [...]
>>>>>
>>>>>>>>> Uh, I don't need a full sound device to emit beeps, that's not even
>>>>>>>>> possible with this hardware.
>>>>>>>>
>>>>>>>> Heh, I also don't recommend that route, either :)
>>>>>>>> (Though, it must be possible to create a sound device with that beep
>>>>>>>> control in theory)
>>>>>>>
>>>>>>> I mean, I can imagine one could possibly use PCM DMA to cook samples
>>>>>>> to feed some of the PWM devices so they could possibly be used to
>>>>>>> generate low quality audio, as a weird limited DAC, but ... that's not
>>>>>>> really generic, and not what I want.
>>>>>>
>>>>>> Oh I see how the misunderstanding came; I didn't mean the PCM
>>>>>> implementation like pcsp driver.  The pcsp driver is a real hack and
>>>>>> it's there just for fun, not for any real practical use.
>>>>>
>>>>> Ah :)
>>>>>
>>>>>> What I meant was rather that you can create a sound device containing
>>>>>> a mixer volume control that serves exactly like the sysfs or whatever
>>>>>> other interface, without any PCM stream or other interface.
>>>>>
>>>>> Ahhh, hum, I still feel like this might be a bit overkill here.
>>>>>
>>>>>>>>> I only need to control loudness of the
>>>>>>>>> beeper that is controlled by PWM output. That's why I am trying to
>>>>>>>>> extend the pwm-beeper driver, which seems the best fit for such a
>>>>>>>>> device, it is only missing this one feature (loudness control).
>>>>>>>>
>>>>>>>> So the question is what's expected from user-space POV.  If a more
>>>>>>>> generic control of beep volume is required, e.g. for desktop-like
>>>>>>>> usages, an implementation of sound driver wouldn't be too bad.
>>>>>>>> OTOH, for other specific use-cases, it doesn't matter much in which
>>>>>>>> interface it's implemented, and sysfs could be an easy choice.
>>>>>>>
>>>>>>> The whole discussion above has been exactly about this. Basically the
>>>>>>> thing is, we can either have:
>>>>>>> - SND_TONE (via some /dev/input/eventX) + sysfs volume control
>>>>>>>      -> This is simple, but sounds racy between input and sysfs accesses
>>>>>>
>>>>>> Hmm, how can it be racy if you do proper locking?
>>>>>
>>>>> I can imagine two applications can each grab one of the controls and that
>>>>> makes the interface a bit not nice. That would require extra synchronization
>>>>> in userspace and so on.
>>>>>
>>>>>>> - SND_TONE + SND_TONE_SET_VOLUME
>>>>>>>      -> User needs to do two ioctls, hum
>>>>>>> - some new SND_TONE_WITH_VOLUME
>>>>>>>      -> Probably the best option, user sets both tone frequency and volume
>>>>>>>         in one go, and it also only extends the IOCTL interface, so older
>>>>>>>         userspace won't have issues
>>>>>>
>>>>>> Those are "extensions" I have mentioned, and I'm not a big fan for
>>>>>> that, honestly speaking.
>>>>>>
>>>>>> The fact that the beep *output* stuff is provided by the *input*
>>>>>> device is already confusing
>>>>>
>>>>> I agree, this confused me as well.
>>>>
>>>> This comes from the times when keyboards themselves were capable of
>>>> emitting bells (SUN, DEC, etc). In hindsight it was not the best way of
>>>> structuring things, same with the keyboard LEDs (that are now plugged
>>>> into the LED subsystem, but still allow be driven through input).
>>>>
>>>> And in the same vein I wonder if we should bite the bullet and pay with
>>>> a bit of complexity but move sound-related things to sound subsystem.
>>>
>>> I am not sure that's the right approach here, since the device cannot do PCM
>>> playback, just bleeps.
>>>
>>>>>> (it was so just because of historical
>>>>>> reason), and yet you start implementing more full-featured mixer
>>>>>> control.  I'd rather keep fingers away.
>>>>>>
>>>>>> Again, if user-space requires the compatible behavior like the
>>>>>> existing desktop usages
>>>>>
>>>>> It does not. These pwm-beeper devices keep showing up in various embedded
>>>>> devices these days.
>>>>>
>>>>>> , it can be implemented in a similar way like
>>>>>> the existing ones; i.e. provide a mixer control with a proper sound
>>>>>> device.  The sound device doesn't need to provide a PCM interface but
>>>>>> just with a mixer interface.
>>>>>>
>>>>>> Or, if the purpose of your target device is a special usage, you don't
>>>>>> need to consider too much about the existing interface, and try to
>>>>>> keep the change as minimal as possible without too intrusive API
>>>>>> changes.
>>>>>
>>>>> My use case is almost perfectly matched by the current input pwm-beeper
>>>>> driver, the only missing bit is the ability to control the loudness at
>>>>> runtime. I think adding the SND_TONE_WITH_VOLUME parameter would cover it,
>>>>> with least intrusive API changes.
>>>>>
>>>>> The SND_TONE already supports configuring tone frequency in Hz as its
>>>>> parameter. Since anything above 64 kHz is certainly not hearable by humans,
>>>>> I would say the SND_TONE_WITH_VOLUME could use 16 LSbits for frequency (so
>>>>> up to 65535 Hz , 0 is OFF), and 16 MSbits for volume .
>>>>>
>>>>> I'm hesitant to overcomplicate something which can currently be controlled
>>>>> via single ioctl by pulling in sound subsystem into the picture.
>>>>
>>>> Can you tell a bit more about your use case? What needs to control the
>>>> volume of beeps? Is this the only source of sounds on the system?
>>>
>>> Custom user space application. The entire userspace is custom built in this
>>> case.
>>>
>>> In this case, it is a single-use device (think e.g. the kind of thermometer
>>> you stick in your ear when you're ill, to find out how warm you are).
>>>
>>> The beeper there is used to do just that, bleep (with different frequencies
>>> to indicate different stuff), and that works. What I need in addition to
>>> that is control the volume of the bleeps from the application, so it isn't
>>> too noisy. And that needs to be user-controllable at runtime, so not
>>> something that goes in DT.
>>>
>>> Right now there is just the bleeper , yes.
>>
>> It sounds like we essentially need an option within pcsp to drive PWM
>> instead of PCM, but input already has pwm-beeper; it seems harmless to
>> gently extend the latter for this use-case as opposed to reworking the
>> former.
> 
> Nah, please forget pcsp driver.  As mentioned earlier, it's a driver
> that is present just for fun.
> 
> I believe what we need is a simple sound card instance providing a
> mixer control for the beep volume, something like a patch like below
> (totally untested!)

Do we really want to add dependency on the entire sound subsystem (which 
is currently not needed on the device I care about) only to configure 
one single tunable of the PWM beeper ? It seems to add too much bloat to me.
