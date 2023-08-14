Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B628C77AFAD
	for <lists+linux-pwm@lfdr.de>; Mon, 14 Aug 2023 04:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbjHNCyF (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 13 Aug 2023 22:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232603AbjHNCxn (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 13 Aug 2023 22:53:43 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FDC0E65;
        Sun, 13 Aug 2023 19:53:42 -0700 (PDT)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id EE2E6833BF;
        Mon, 14 Aug 2023 04:53:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1691981619;
        bh=lV7bVhPDLY4Nxhzg+uqDkNUFK5eh+AMesuLtIf2K9i4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=uIWDMnTfPAx3QESbCKb4oU0RVCcS/hGicTDzwBPtp3J01PSuyly/xilcrfre27nbi
         zr31B5duhAo7fgKtcG9zX3xn4KQ3tCB+Tx7z6Rzx4KVuADl2EwUBMfKGPowqmD0CDp
         1yZg4vyZ+F0lYCF8HUo+aPqydjZwjTdiBluJDxnWxy4G77WYq1GqD6OznD6MAO00id
         v15qnspOuJkzTSuiacXewifoINv/CBej8u8FqyUTirOhTtaRXKfB3iGgblUBuZUrrZ
         vfViUo28wC4dF3zWtj2mBa8kZvDngk/Zn45LPFLLG7pZ58G74CsejMkJ77VmfEM/wt
         i5ArMNRuibfrA==
Message-ID: <545844bb-c16e-4675-0f13-d76646d866fd@denx.de>
Date:   Mon, 14 Aug 2023 04:26:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] Input: pwm-beeper - Support volume setting via sysfs
Content-Language: en-US
To:     John Watts <contact@jookia.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Jeff LaBundy <jeff@labundy.com>, Takashi Iwai <tiwai@suse.de>,
        linux-input@vger.kernel.org,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Manuel Traut <manuel.traut@mt.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org, alsa-devel@alsa-project.org,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
References: <873514d2ju.wl-tiwai@suse.de>
 <63adce9a-df65-b462-9055-0ece5216d680@denx.de> <87tttkjmyu.wl-tiwai@suse.de>
 <0cffe366-75af-d8a8-8920-6fb94c321a89@denx.de> <87h6pkjh7q.wl-tiwai@suse.de>
 <618add56-3675-4efe-5b20-665c10040e03@denx.de> <ZMfgJ3o00nApkXGp@google.com>
 <f4612dc5-a7d4-74ba-2ed8-ea70314625b6@denx.de> <ZMh0Sa9s25JHhWw5@nixie71>
 <ZMi0HT/yaTo9uTyi@google.com> <ZNYsGr6yBeVTtNMK@titan>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <ZNYsGr6yBeVTtNMK@titan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-8.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 8/11/23 14:39, John Watts wrote:
> On Tue, Aug 01, 2023 at 12:28:29AM -0700, Dmitry Torokhov wrote:
>> If we want to extend the API we will need to define exactly how it will
>> all work. I.e. what happens if userspace mixes the old SND_TONE and
>> SND_BELL with the new SND_BELL_VOL or whatever. Does it play with
>> previously set volume? The default one? How to set the default one? How
>> to figure out what the current volume is if we decide to make volume
>> "sticky"?
>>
>> As far as userspace I expect it is more common to have one program (or
>> component of a program) to set volume and then something else requests
>> sound, so having one-shot API is of dubious value to me.
>>
>> I hope we can go with Takashi's proposal downthread, but if not I wonder
>> if the sysfs approach is not the simplest one. Do we expect more beepers
>> that can control volume besides pwm-beeper?
>>
>> Thanks.
>>
>> -- 
>> Dmitry
> 
> (Just to duck in as someone that has written a little program to play beeps and
> tones using the EV_TONE API)
> 
> It might be worth distinguishing between the goals of having some beeps with
> different volumes compared to all beeps with different volumes.
> 
> Sound card mixers generally control some sort of global volume while I would
> imagine the tone API would control per-tone volume. I don't know too much about
> safety guarantees but writing an input then sysfs or mixer then input again
> seems like it could get jumbled up.
> 
> In that speicfic case I think it would make more sense to send volume and tone
> from whatever beep API is being used, with the volume being a multiplier of the
> loudest volume. This is similar to how audio works with PCM output. Existing
> beeps would have the volume set to 100%.

I agree binding tone frequency and volume together would be better.
The API would be nicer and easier to use in my opinion too.
