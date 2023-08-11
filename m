Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44117778FCF
	for <lists+linux-pwm@lfdr.de>; Fri, 11 Aug 2023 14:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235494AbjHKMp7 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 11 Aug 2023 08:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235465AbjHKMp6 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 11 Aug 2023 08:45:58 -0400
X-Greylist: delayed 332 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 11 Aug 2023 05:45:56 PDT
Received: from out-108.mta0.migadu.com (out-108.mta0.migadu.com [IPv6:2001:41d0:1004:224b::6c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 811D626A0
        for <linux-pwm@vger.kernel.org>; Fri, 11 Aug 2023 05:45:56 -0700 (PDT)
Date:   Fri, 11 Aug 2023 22:39:54 +1000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
        t=1691757620;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8vNMSKN+vtwKFHAf06jkI6GM9sIuZ9HaDo3mOdRlVL0=;
        b=BchVAq6XdbomT9nJbHcoXXXO290cJ6HsWBHEoegfNiBXIvC9sMXlAhFNYv8k87Ja8wK6Wb
        0uTwT/ou6jTOVhBmR/kaiJ4p36ruEdBegikdugGr+cszRl+OlTzPh7JXDMojRQBlbF0XnU
        Jeu1r+jLz0YH5IHoNCnDgiocILxQmdcZk0zZlT9j7AgGgZSQIyt/yrH3VVShoqt7ve3vf0
        /MqDD8yYX2fG/UDnO8efHTMtm+FFoTMp3aKgpiRwVYmghaGH0uIZlzj/7jBVdwWASKze/j
        len8GdK8MNuEPLJ1Ui5zfEz3YjdTfFcbQf6cgGHS7xFx/8zBd3jPAdbNacClFA==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   John Watts <contact@jookia.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Jeff LaBundy <jeff@labundy.com>, Marek Vasut <marex@denx.de>,
        Takashi Iwai <tiwai@suse.de>, linux-input@vger.kernel.org,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Manuel Traut <manuel.traut@mt.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org, alsa-devel@alsa-project.org,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: Re: [PATCH] Input: pwm-beeper - Support volume setting via sysfs
Message-ID: <ZNYsGr6yBeVTtNMK@titan>
References: <873514d2ju.wl-tiwai@suse.de>
 <63adce9a-df65-b462-9055-0ece5216d680@denx.de>
 <87tttkjmyu.wl-tiwai@suse.de>
 <0cffe366-75af-d8a8-8920-6fb94c321a89@denx.de>
 <87h6pkjh7q.wl-tiwai@suse.de>
 <618add56-3675-4efe-5b20-665c10040e03@denx.de>
 <ZMfgJ3o00nApkXGp@google.com>
 <f4612dc5-a7d4-74ba-2ed8-ea70314625b6@denx.de>
 <ZMh0Sa9s25JHhWw5@nixie71>
 <ZMi0HT/yaTo9uTyi@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZMi0HT/yaTo9uTyi@google.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, Aug 01, 2023 at 12:28:29AM -0700, Dmitry Torokhov wrote:
> If we want to extend the API we will need to define exactly how it will
> all work. I.e. what happens if userspace mixes the old SND_TONE and
> SND_BELL with the new SND_BELL_VOL or whatever. Does it play with
> previously set volume? The default one? How to set the default one? How
> to figure out what the current volume is if we decide to make volume
> "sticky"?
> 
> As far as userspace I expect it is more common to have one program (or
> component of a program) to set volume and then something else requests
> sound, so having one-shot API is of dubious value to me.
> 
> I hope we can go with Takashi's proposal downthread, but if not I wonder
> if the sysfs approach is not the simplest one. Do we expect more beepers
> that can control volume besides pwm-beeper?
> 
> Thanks.
> 
> -- 
> Dmitry

(Just to duck in as someone that has written a little program to play beeps and
tones using the EV_TONE API)

It might be worth distinguishing between the goals of having some beeps with
different volumes compared to all beeps with different volumes.

Sound card mixers generally control some sort of global volume while I would
imagine the tone API would control per-tone volume. I don't know too much about
safety guarantees but writing an input then sysfs or mixer then input again
seems like it could get jumbled up.

In that speicfic case I think it would make more sense to send volume and tone
from whatever beep API is being used, with the volume being a multiplier of the
loudest volume. This is similar to how audio works with PCM output. Existing
beeps would have the volume set to 100%.

John.
