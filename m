Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52ABC769C4A
	for <lists+linux-pwm@lfdr.de>; Mon, 31 Jul 2023 18:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbjGaQYP (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 31 Jul 2023 12:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232880AbjGaQYN (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 31 Jul 2023 12:24:13 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB8CAA7;
        Mon, 31 Jul 2023 09:24:11 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id 5614622812f47-3a3efebcc24so3569766b6e.1;
        Mon, 31 Jul 2023 09:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690820651; x=1691425451;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=L9rhceQtuuvQvLAHRqCDzkk04w/Xm9Wlb19XjSIzh4U=;
        b=OvSNkuwUS4cQ7HOzQm3pKCNkoucj/y5rWTWy4MY/+Wmb/yNEKBKhySivBR/eFwayti
         AThPhiJLKe7eP77HU2XAWxOSdBFkrXK64GYDuYF+Up3nFzZFQj/aa3l58aHk/tOizvLR
         kGhr3I2qxEjEMaI/2DiaUTS/ukNGGZ9yYkqoEnKS6OTsEl27m3i4s2P0HFDXqZhWEn9f
         425Er54y2va8cCa411+qQqx/KAQP+eMr8mwYGOnm4uk5Yt5rd4e/XFk2TdLvEiLatEna
         8B4Dcp3xPckS/6Tn3aIjkCSo8YFuxzfSM1GiMpLSZIyAUMBrQ0H3vSJBmecXSropl/Py
         wt4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690820651; x=1691425451;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L9rhceQtuuvQvLAHRqCDzkk04w/Xm9Wlb19XjSIzh4U=;
        b=ITiqmuiir228u5gjrEE2zHWPMziPE34jHjvNZSRAjzUxqGEgDvIv7/z2B2ADUWXj+L
         4hGaErdnhW2R1REqdBVYZu0Pp8suoRBpbIgoZL4k4pjLtptNnxTEYJ7Xcv3o9StyXnq7
         SSBQdXWdSKuTv0Fmvg8/Myif0Q7xAXkKOE2QBe+UOvSBpM1ii9fUaAj3trZBZH9SWEiG
         NVas4yaECWzJTq2wDpRywiNuJxYZ5kkf4c55RwJnnbWaXePIJGScYEbgSy1VGAm+fotU
         Rr0yGqWGDo/P6GCeTsc2Zv4rli0MF56GHrGB5wy3nrSrYJzwAaxZm6NI+aNjEI4Q2qCU
         cdVQ==
X-Gm-Message-State: ABy/qLaUNwf+/DfxWx3JPS1IzE+RWYrn+zacMjE69tIK7JT6AMzcSCTy
        DUviQTAjR5iFwnO24S7HI0s=
X-Google-Smtp-Source: APBJJlEE5GK8axdu6jXUVo93q7HwBviqeT5s2wQCZ0zp0xyXwWRLxL7Ecu3wWbGyTx24liqzQyUa9w==
X-Received: by 2002:a05:6808:f89:b0:3a4:2826:4197 with SMTP id o9-20020a0568080f8900b003a428264197mr11998276oiw.37.1690820650669;
        Mon, 31 Jul 2023 09:24:10 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:6d25:c0f1:d8d5:201c])
        by smtp.gmail.com with ESMTPSA id t28-20020a63b25c000000b00563dfd98982sm8409911pgo.42.2023.07.31.09.24.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 09:24:10 -0700 (PDT)
Date:   Mon, 31 Jul 2023 09:24:07 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Marek Vasut <marex@denx.de>
Cc:     Takashi Iwai <tiwai@suse.de>, Jeff LaBundy <jeff@labundy.com>,
        linux-input@vger.kernel.org,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Manuel Traut <manuel.traut@mt.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org, alsa-devel@alsa-project.org,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: Re: [PATCH] Input: pwm-beeper - Support volume setting via sysfs
Message-ID: <ZMfgJ3o00nApkXGp@google.com>
References: <ZF7kCjKGVjsxK8ec@nixie71>
 <0ef98ec1-6191-c72e-2362-310db7f09b84@denx.de>
 <06379f26-ab24-85f9-783f-0c49d4291b23@denx.de>
 <ZMdIZiC453onyeHh@google.com>
 <873514d2ju.wl-tiwai@suse.de>
 <63adce9a-df65-b462-9055-0ece5216d680@denx.de>
 <87tttkjmyu.wl-tiwai@suse.de>
 <0cffe366-75af-d8a8-8920-6fb94c321a89@denx.de>
 <87h6pkjh7q.wl-tiwai@suse.de>
 <618add56-3675-4efe-5b20-665c10040e03@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <618add56-3675-4efe-5b20-665c10040e03@denx.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, Jul 31, 2023 at 04:36:01PM +0200, Marek Vasut wrote:
> On 7/31/23 16:20, Takashi Iwai wrote:
> 
> [...]
> 
> > > > > Uh, I don't need a full sound device to emit beeps, that's not even
> > > > > possible with this hardware.
> > > > 
> > > > Heh, I also don't recommend that route, either :)
> > > > (Though, it must be possible to create a sound device with that beep
> > > > control in theory)
> > > 
> > > I mean, I can imagine one could possibly use PCM DMA to cook samples
> > > to feed some of the PWM devices so they could possibly be used to
> > > generate low quality audio, as a weird limited DAC, but ... that's not
> > > really generic, and not what I want.
> > 
> > Oh I see how the misunderstanding came; I didn't mean the PCM
> > implementation like pcsp driver.  The pcsp driver is a real hack and
> > it's there just for fun, not for any real practical use.
> 
> Ah :)
> 
> > What I meant was rather that you can create a sound device containing
> > a mixer volume control that serves exactly like the sysfs or whatever
> > other interface, without any PCM stream or other interface.
> 
> Ahhh, hum, I still feel like this might be a bit overkill here.
> 
> > > > > I only need to control loudness of the
> > > > > beeper that is controlled by PWM output. That's why I am trying to
> > > > > extend the pwm-beeper driver, which seems the best fit for such a
> > > > > device, it is only missing this one feature (loudness control).
> > > > 
> > > > So the question is what's expected from user-space POV.  If a more
> > > > generic control of beep volume is required, e.g. for desktop-like
> > > > usages, an implementation of sound driver wouldn't be too bad.
> > > > OTOH, for other specific use-cases, it doesn't matter much in which
> > > > interface it's implemented, and sysfs could be an easy choice.
> > > 
> > > The whole discussion above has been exactly about this. Basically the
> > > thing is, we can either have:
> > > - SND_TONE (via some /dev/input/eventX) + sysfs volume control
> > >    -> This is simple, but sounds racy between input and sysfs accesses
> > 
> > Hmm, how can it be racy if you do proper locking?
> 
> I can imagine two applications can each grab one of the controls and that
> makes the interface a bit not nice. That would require extra synchronization
> in userspace and so on.
> 
> > > - SND_TONE + SND_TONE_SET_VOLUME
> > >    -> User needs to do two ioctls, hum
> > > - some new SND_TONE_WITH_VOLUME
> > >    -> Probably the best option, user sets both tone frequency and volume
> > >       in one go, and it also only extends the IOCTL interface, so older
> > >       userspace won't have issues
> > 
> > Those are "extensions" I have mentioned, and I'm not a big fan for
> > that, honestly speaking.
> > 
> > The fact that the beep *output* stuff is provided by the *input*
> > device is already confusing
> 
> I agree, this confused me as well.

This comes from the times when keyboards themselves were capable of
emitting bells (SUN, DEC, etc). In hindsight it was not the best way of
structuring things, same with the keyboard LEDs (that are now plugged
into the LED subsystem, but still allow be driven through input).

And in the same vein I wonder if we should bite the bullet and pay with
a bit of complexity but move sound-related things to sound subsystem.

> 
> > (it was so just because of historical
> > reason), and yet you start implementing more full-featured mixer
> > control.  I'd rather keep fingers away.
> > 
> > Again, if user-space requires the compatible behavior like the
> > existing desktop usages
> 
> It does not. These pwm-beeper devices keep showing up in various embedded
> devices these days.
> 
> > , it can be implemented in a similar way like
> > the existing ones; i.e. provide a mixer control with a proper sound
> > device.  The sound device doesn't need to provide a PCM interface but
> > just with a mixer interface.
> > 
> > Or, if the purpose of your target device is a special usage, you don't
> > need to consider too much about the existing interface, and try to
> > keep the change as minimal as possible without too intrusive API
> > changes.
> 
> My use case is almost perfectly matched by the current input pwm-beeper
> driver, the only missing bit is the ability to control the loudness at
> runtime. I think adding the SND_TONE_WITH_VOLUME parameter would cover it,
> with least intrusive API changes.
> 
> The SND_TONE already supports configuring tone frequency in Hz as its
> parameter. Since anything above 64 kHz is certainly not hearable by humans,
> I would say the SND_TONE_WITH_VOLUME could use 16 LSbits for frequency (so
> up to 65535 Hz , 0 is OFF), and 16 MSbits for volume .
> 
> I'm hesitant to overcomplicate something which can currently be controlled
> via single ioctl by pulling in sound subsystem into the picture.

Can you tell a bit more about your use case? What needs to control the
volume of beeps? Is this the only source of sounds on the system?

Thanks.

-- 
Dmitry
