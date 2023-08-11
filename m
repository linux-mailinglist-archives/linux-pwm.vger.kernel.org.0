Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 421EC778896
	for <lists+linux-pwm@lfdr.de>; Fri, 11 Aug 2023 09:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234232AbjHKHwj (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 11 Aug 2023 03:52:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233100AbjHKHwi (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 11 Aug 2023 03:52:38 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 670F82132;
        Fri, 11 Aug 2023 00:52:37 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 28DCD1F889;
        Fri, 11 Aug 2023 07:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1691740356; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wOCK0rx4jiooJcgLdZXfhmYlqIl9i62DBdQvyTIvknQ=;
        b=up+kI99g4JXNbS5WdO4yqtzv8oTuYiZ9d0rNggaRg9nUdIUUT7nJDcnA2dZtda4LmXiKIO
        7IoeEqBsBl5j4a74sRmvzcy+oihbajqc9KbpwZOLcP35+PYJFrrW0f8Aqdo+if5fEQB1Zy
        ZFoBhdG+G093aMiDCojr6trKOi/iQDI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1691740356;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wOCK0rx4jiooJcgLdZXfhmYlqIl9i62DBdQvyTIvknQ=;
        b=fF9Rf2tsmTMdwyQqMEVx5cbPhvWaPJkCoG+sUb4aWEgjCgFZkTLu98vCb9qOf2QYZ9w153
        KGCir7+ARYea+7Cw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D6D44138E2;
        Fri, 11 Aug 2023 07:52:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 5YxfM8Po1WQVcAAAMHmgww
        (envelope-from <tiwai@suse.de>); Fri, 11 Aug 2023 07:52:35 +0000
Date:   Fri, 11 Aug 2023 09:52:35 +0200
Message-ID: <87h6p6rp6k.wl-tiwai@suse.de>
From:   Takashi Iwai <tiwai@suse.de>
To:     Jeff LaBundy <jeff@labundy.com>
Cc:     Marek Vasut <marex@denx.de>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org,
        Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Manuel Traut <manuel.traut@mt.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org, alsa-devel@alsa-project.org,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: Re: [PATCH] Input: pwm-beeper - Support volume setting via sysfs
In-Reply-To: <ZNW25qlzh8YbZtu8@nixie71>
References: <63adce9a-df65-b462-9055-0ece5216d680@denx.de>
        <87tttkjmyu.wl-tiwai@suse.de>
        <0cffe366-75af-d8a8-8920-6fb94c321a89@denx.de>
        <87h6pkjh7q.wl-tiwai@suse.de>
        <618add56-3675-4efe-5b20-665c10040e03@denx.de>
        <ZMfgJ3o00nApkXGp@google.com>
        <f4612dc5-a7d4-74ba-2ed8-ea70314625b6@denx.de>
        <ZMh0Sa9s25JHhWw5@nixie71>
        <ZMi0HT/yaTo9uTyi@google.com>
        <d0f284d5-6922-ea3b-3447-c089b0d24587@denx.de>
        <ZNW25qlzh8YbZtu8@nixie71>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, 11 Aug 2023 06:19:50 +0200,
Jeff LaBundy wrote:
> 
> Hi Marek, Dmitry and Takashi,
> 
> On Tue, Aug 01, 2023 at 01:51:50PM +0200, Marek Vasut wrote:
> > On 8/1/23 09:28, Dmitry Torokhov wrote:
> > > On Mon, Jul 31, 2023 at 09:56:09PM -0500, Jeff LaBundy wrote:
> > > > Hi all,
> > > > 
> > > > On Mon, Jul 31, 2023 at 07:49:50PM +0200, Marek Vasut wrote:
> > > > > On 7/31/23 18:24, Dmitry Torokhov wrote:
> > > > > > On Mon, Jul 31, 2023 at 04:36:01PM +0200, Marek Vasut wrote:
> > > > > > > On 7/31/23 16:20, Takashi Iwai wrote:
> > > > > > > 
> > > > > > > [...]
> > > > > > > 
> > > > > > > > > > > Uh, I don't need a full sound device to emit beeps, that's not even
> > > > > > > > > > > possible with this hardware.
> > > > > > > > > > 
> > > > > > > > > > Heh, I also don't recommend that route, either :)
> > > > > > > > > > (Though, it must be possible to create a sound device with that beep
> > > > > > > > > > control in theory)
> > > > > > > > > 
> > > > > > > > > I mean, I can imagine one could possibly use PCM DMA to cook samples
> > > > > > > > > to feed some of the PWM devices so they could possibly be used to
> > > > > > > > > generate low quality audio, as a weird limited DAC, but ... that's not
> > > > > > > > > really generic, and not what I want.
> > > > > > > > 
> > > > > > > > Oh I see how the misunderstanding came; I didn't mean the PCM
> > > > > > > > implementation like pcsp driver.  The pcsp driver is a real hack and
> > > > > > > > it's there just for fun, not for any real practical use.
> > > > > > > 
> > > > > > > Ah :)
> > > > > > > 
> > > > > > > > What I meant was rather that you can create a sound device containing
> > > > > > > > a mixer volume control that serves exactly like the sysfs or whatever
> > > > > > > > other interface, without any PCM stream or other interface.
> > > > > > > 
> > > > > > > Ahhh, hum, I still feel like this might be a bit overkill here.
> > > > > > > 
> > > > > > > > > > > I only need to control loudness of the
> > > > > > > > > > > beeper that is controlled by PWM output. That's why I am trying to
> > > > > > > > > > > extend the pwm-beeper driver, which seems the best fit for such a
> > > > > > > > > > > device, it is only missing this one feature (loudness control).
> > > > > > > > > > 
> > > > > > > > > > So the question is what's expected from user-space POV.  If a more
> > > > > > > > > > generic control of beep volume is required, e.g. for desktop-like
> > > > > > > > > > usages, an implementation of sound driver wouldn't be too bad.
> > > > > > > > > > OTOH, for other specific use-cases, it doesn't matter much in which
> > > > > > > > > > interface it's implemented, and sysfs could be an easy choice.
> > > > > > > > > 
> > > > > > > > > The whole discussion above has been exactly about this. Basically the
> > > > > > > > > thing is, we can either have:
> > > > > > > > > - SND_TONE (via some /dev/input/eventX) + sysfs volume control
> > > > > > > > >      -> This is simple, but sounds racy between input and sysfs accesses
> > > > > > > > 
> > > > > > > > Hmm, how can it be racy if you do proper locking?
> > > > > > > 
> > > > > > > I can imagine two applications can each grab one of the controls and that
> > > > > > > makes the interface a bit not nice. That would require extra synchronization
> > > > > > > in userspace and so on.
> > > > > > > 
> > > > > > > > > - SND_TONE + SND_TONE_SET_VOLUME
> > > > > > > > >      -> User needs to do two ioctls, hum
> > > > > > > > > - some new SND_TONE_WITH_VOLUME
> > > > > > > > >      -> Probably the best option, user sets both tone frequency and volume
> > > > > > > > >         in one go, and it also only extends the IOCTL interface, so older
> > > > > > > > >         userspace won't have issues
> > > > > > > > 
> > > > > > > > Those are "extensions" I have mentioned, and I'm not a big fan for
> > > > > > > > that, honestly speaking.
> > > > > > > > 
> > > > > > > > The fact that the beep *output* stuff is provided by the *input*
> > > > > > > > device is already confusing
> > > > > > > 
> > > > > > > I agree, this confused me as well.
> > > > > > 
> > > > > > This comes from the times when keyboards themselves were capable of
> > > > > > emitting bells (SUN, DEC, etc). In hindsight it was not the best way of
> > > > > > structuring things, same with the keyboard LEDs (that are now plugged
> > > > > > into the LED subsystem, but still allow be driven through input).
> > > > > > 
> > > > > > And in the same vein I wonder if we should bite the bullet and pay with
> > > > > > a bit of complexity but move sound-related things to sound subsystem.
> > > > > 
> > > > > I am not sure that's the right approach here, since the device cannot do PCM
> > > > > playback, just bleeps.
> > > > > 
> > > > > > > > (it was so just because of historical
> > > > > > > > reason), and yet you start implementing more full-featured mixer
> > > > > > > > control.  I'd rather keep fingers away.
> > > > > > > > 
> > > > > > > > Again, if user-space requires the compatible behavior like the
> > > > > > > > existing desktop usages
> > > > > > > 
> > > > > > > It does not. These pwm-beeper devices keep showing up in various embedded
> > > > > > > devices these days.
> > > > > > > 
> > > > > > > > , it can be implemented in a similar way like
> > > > > > > > the existing ones; i.e. provide a mixer control with a proper sound
> > > > > > > > device.  The sound device doesn't need to provide a PCM interface but
> > > > > > > > just with a mixer interface.
> > > > > > > > 
> > > > > > > > Or, if the purpose of your target device is a special usage, you don't
> > > > > > > > need to consider too much about the existing interface, and try to
> > > > > > > > keep the change as minimal as possible without too intrusive API
> > > > > > > > changes.
> > > > > > > 
> > > > > > > My use case is almost perfectly matched by the current input pwm-beeper
> > > > > > > driver, the only missing bit is the ability to control the loudness at
> > > > > > > runtime. I think adding the SND_TONE_WITH_VOLUME parameter would cover it,
> > > > > > > with least intrusive API changes.
> > > > > > > 
> > > > > > > The SND_TONE already supports configuring tone frequency in Hz as its
> > > > > > > parameter. Since anything above 64 kHz is certainly not hearable by humans,
> > > > > > > I would say the SND_TONE_WITH_VOLUME could use 16 LSbits for frequency (so
> > > > > > > up to 65535 Hz , 0 is OFF), and 16 MSbits for volume .
> > > > > > > 
> > > > > > > I'm hesitant to overcomplicate something which can currently be controlled
> > > > > > > via single ioctl by pulling in sound subsystem into the picture.
> > > > > > 
> > > > > > Can you tell a bit more about your use case? What needs to control the
> > > > > > volume of beeps? Is this the only source of sounds on the system?
> > > > > 
> > > > > Custom user space application. The entire userspace is custom built in this
> > > > > case.
> > > > > 
> > > > > In this case, it is a single-use device (think e.g. the kind of thermometer
> > > > > you stick in your ear when you're ill, to find out how warm you are).
> > > > > 
> > > > > The beeper there is used to do just that, bleep (with different frequencies
> > > > > to indicate different stuff), and that works. What I need in addition to
> > > > > that is control the volume of the bleeps from the application, so it isn't
> > > > > too noisy. And that needs to be user-controllable at runtime, so not
> > > > > something that goes in DT.
> > > > > 
> > > > > Right now there is just the bleeper , yes.
> > > > 
> > > > It sounds like we essentially need an option within pcsp to drive PWM
> > > > instead of PCM, but input already has pwm-beeper; it seems harmless to
> > > > gently extend the latter for this use-case as opposed to reworking the
> > > > former.
> > > > 
> > > > I agree that we should not invest too heavily in a legacy ABI, however
> > > > something like SND_BELL_VOL seems like a low-cost addition that doesn't
> > > > work against extending pcsp in the future. In fact, input already has
> > > > precedent for this exact same thing by way of FF rumble effects, which
> > > > are often PWM-based themselves.
> > > > 
> > > > If SND_BELL_VOL or similar is not acceptable, then the original sysfs
> > > > approach seems like the next-best compromise. My only issue with it was
> > > > that I felt the range was not abstracted enough.
> > > 
> > > If we want to extend the API we will need to define exactly how it will
> > > all work. I.e. what happens if userspace mixes the old SND_TONE and
> > > SND_BELL with the new SND_BELL_VOL or whatever. Does it play with
> > > previously set volume? The default one?
> > 
> > Default one, to preserve current behavior, yes.
> 
> This was my idea as well, but I appreciate that the devil is in the details
> and each driver may have to duplicate some overhead.
> 
> > 
> > > How to set the default one?
> > 
> > We do not, we can call pwm_get_duty_cycle() to get the current duty cycle of
> > the PWM to figure out the default.
> > 
> > > How
> > > to figure out what the current volume is if we decide to make volume
> > > "sticky"?
> > 
> > The patch stores the current volume configured via sysfs into
> > beeper->duty_cycle .
> > 
> > > As far as userspace I expect it is more common to have one program (or
> > > component of a program) to set volume and then something else requests
> > > sound, so having one-shot API is of dubious value to me.
> > 
> > Currently the use case I have for this is a single user facing application
> > which configures both.
> > 
> > > I hope we can go with Takashi's proposal downthread, but if not I wonder
> > > if the sysfs approach is not the simplest one. Do we expect more beepers
> > > that can control volume besides pwm-beeper?
> > 
> > It seems to me pulling in dependency on the entire sound subsystem only to
> > set beeper volume is overkill. I currently don't even have sound subsystem
> > compiled in.
> 
> I like Takashi's patch; it seems like a more scalable solution. However, I
> can appreciate the reluctance to bring in the entire sound subsytem for what
> is probably a tiny piezoelectric buzzer.
> 
> It seems like the sysfs solution is the best compromise in the meantime. If
> more and more users need to shoe-horn these kind of features in the future,
> we can make more informed decisions as to how to extend the API (if at all).

That's my impression, too.  The original sysfs usage would be the
right fit at this moment.


thanks,

Takashi
