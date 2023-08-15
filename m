Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA7677D522
	for <lists+linux-pwm@lfdr.de>; Tue, 15 Aug 2023 23:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240192AbjHOVdd (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 15 Aug 2023 17:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240236AbjHOVdO (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 15 Aug 2023 17:33:14 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58E0919A5;
        Tue, 15 Aug 2023 14:33:12 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6887c3aac15so90547b3a.2;
        Tue, 15 Aug 2023 14:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692135192; x=1692739992;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Qz0Y5e25KK71HlghtqvnZ2oqoMd/S7LZgWMDTL4U4lY=;
        b=R4GrkMVWP9N2fDdvY8wpcs7flcNJy2CwTei6ceh0SZ3FlVO6TJTZGzGxPBTSz+Q9uR
         kXZcLjKpV2h1cSBoxReLS+u20AOtzWWvQ8vpmsxOkD4dzX5hxa5A6trOjCwbnmGVG25Z
         dWBquegb6iyXkXIQQ4qbeoyXIVQorICAHWGVtnk5003hBQuJ13G3DV+mFbosv2XST7C1
         tQ4uFwQh0tQbpzzfy+crzHQsqoicJkaL/xBpCWvHC7tJ015aMNJRHXf4ioB0LxTHoU2M
         10AofUOfjNM27wBgEeHv2cWZA+yvhqximNoKiqCfMGBGDBtUcX37oOdtb8/sVjkB2Awz
         ieWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692135192; x=1692739992;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qz0Y5e25KK71HlghtqvnZ2oqoMd/S7LZgWMDTL4U4lY=;
        b=HOKA32GFiUuOxnUQ2Eup0feDMMCX3BRJ+mEMP82egkWHyAhkmPG5xPoVqk6qBqiJHl
         LrHp6OVKnPASDZgFD0u4ZkKVhWzy3FI4kJ+qGQfSksKhgzX76oDd9uu3CCvAkQodOjWf
         XBIsNVwzvTfvtkcnzOILhQB86hsk1fXa7alsM5HRZ0AHi8N/MHxVXcBrHMcPI8qEcuK4
         ubWVaCcKCaIerbPaB0+V76mLGWXdX4Dk6DjPP8EGoFGTjhIUTafiwRZB4XJgjj9tEPHa
         /bDYBu3KXZUGPJhvrGt4IucHr/LDecBTIDhicCYJue1D/eCJVb/nZCX+a3J23WI59sO2
         kx+Q==
X-Gm-Message-State: AOJu0YxDX07ZxBcbwNRpG6V4avyv2Lm+yCI94vI20/belTdEdoRqrzlu
        b3IRYRAR0wkqjH5DPlXURrkL8BWgxj8=
X-Google-Smtp-Source: AGHT+IH0kEPryQGX1X8Vdi7rCnfjeURjyrYGgjW+gZ8FUalzPW0c/pzqxl7U1OnUU5qIQW8TF+183w==
X-Received: by 2002:a05:6a00:1594:b0:666:d78c:33ab with SMTP id u20-20020a056a00159400b00666d78c33abmr19676128pfk.21.1692135191508;
        Tue, 15 Aug 2023 14:33:11 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:508d:bf8e:5b19:a13b])
        by smtp.gmail.com with ESMTPSA id i12-20020aa78b4c000000b0068338b6667asm9742191pfd.212.2023.08.15.14.33.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 14:33:11 -0700 (PDT)
Date:   Tue, 15 Aug 2023 14:33:07 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Traut Manuel LCPF-CH <Manuel.Traut@mt.com>
Cc:     Takashi Iwai <tiwai@suse.de>, Jeff LaBundy <jeff@labundy.com>,
        Marek Vasut <marex@denx.de>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: Re: [PATCH] Input: pwm-beeper - Support volume setting via sysfs
Message-ID: <ZNvvE3usP86bgctB@google.com>
References: <87h6pkjh7q.wl-tiwai@suse.de>
 <618add56-3675-4efe-5b20-665c10040e03@denx.de>
 <ZMfgJ3o00nApkXGp@google.com>
 <f4612dc5-a7d4-74ba-2ed8-ea70314625b6@denx.de>
 <ZMh0Sa9s25JHhWw5@nixie71>
 <ZMi0HT/yaTo9uTyi@google.com>
 <d0f284d5-6922-ea3b-3447-c089b0d24587@denx.de>
 <ZNW25qlzh8YbZtu8@nixie71>
 <87h6p6rp6k.wl-tiwai@suse.de>
 <AS8PR03MB7621C4E9B338259499AD24DBFA10A@AS8PR03MB7621.eurprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AS8PR03MB7621C4E9B338259499AD24DBFA10A@AS8PR03MB7621.eurprd03.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, Aug 11, 2023 at 10:47:34AM +0000, Traut Manuel LCPF-CH wrote:
> Hi
> 
> > On Fri, 11 Aug 2023 06:19:50 +0200,
> > Jeff LaBundy wrote:
> > >
> > > Hi Marek, Dmitry and Takashi,
> > >
> > > On Tue, Aug 01, 2023 at 01:51:50PM +0200, Marek Vasut wrote:
> > > > On 8/1/23 09:28, Dmitry Torokhov wrote:
> > > > > On Mon, Jul 31, 2023 at 09:56:09PM -0500, Jeff LaBundy wrote:
> > > > > > Hi all,
> > > > > >
> > > > > > On Mon, Jul 31, 2023 at 07:49:50PM +0200, Marek Vasut wrote:
> > > > > > > On 7/31/23 18:24, Dmitry Torokhov wrote:
> > > > > > > > On Mon, Jul 31, 2023 at 04:36:01PM +0200, Marek Vasut wrote:
> > > > > > > > > On 7/31/23 16:20, Takashi Iwai wrote:
> > > > > > > > >
> > > > > > > > > [...]
> > > > > > > > >
> > > > > > > > > > > > > Uh, I don't need a full sound device to emit
> > > > > > > > > > > > > beeps, that's not even possible with this hardware.
> > > > > > > > > > > >
> > > > > > > > > > > > Heh, I also don't recommend that route, either :)
> > > > > > > > > > > > (Though, it must be possible to create a sound
> > > > > > > > > > > > device with that beep control in theory)
> > > > > > > > > > >
> > > > > > > > > > > I mean, I can imagine one could possibly use PCM DMA
> > > > > > > > > > > to cook samples to feed some of the PWM devices so
> > > > > > > > > > > they could possibly be used to generate low quality
> > > > > > > > > > > audio, as a weird limited DAC, but ... that's not really generic,
> > and not what I want.
> > > > > > > > > >
> > > > > > > > > > Oh I see how the misunderstanding came; I didn't mean
> > > > > > > > > > the PCM implementation like pcsp driver.  The pcsp
> > > > > > > > > > driver is a real hack and it's there just for fun, not for any real
> > practical use.
> > > > > > > > >
> > > > > > > > > Ah :)
> > > > > > > > >
> > > > > > > > > > What I meant was rather that you can create a sound
> > > > > > > > > > device containing a mixer volume control that serves
> > > > > > > > > > exactly like the sysfs or whatever other interface, without any
> > PCM stream or other interface.
> > > > > > > > >
> > > > > > > > > Ahhh, hum, I still feel like this might be a bit overkill here.
> > > > > > > > >
> > > > > > > > > > > > > I only need to control loudness of the beeper that
> > > > > > > > > > > > > is controlled by PWM output. That's why I am
> > > > > > > > > > > > > trying to extend the pwm-beeper driver, which
> > > > > > > > > > > > > seems the best fit for such a device, it is only missing this
> > one feature (loudness control).
> > > > > > > > > > > >
> > > > > > > > > > > > So the question is what's expected from user-space
> > > > > > > > > > > > POV.  If a more generic control of beep volume is
> > > > > > > > > > > > required, e.g. for desktop-like usages, an implementation
> > of sound driver wouldn't be too bad.
> > > > > > > > > > > > OTOH, for other specific use-cases, it doesn't
> > > > > > > > > > > > matter much in which interface it's implemented, and sysfs
> > could be an easy choice.
> > > > > > > > > > >
> > > > > > > > > > > The whole discussion above has been exactly about
> > > > > > > > > > > this. Basically the thing is, we can either have:
> > > > > > > > > > > - SND_TONE (via some /dev/input/eventX) + sysfs volume
> > control
> > > > > > > > > > >      -> This is simple, but sounds racy between input
> > > > > > > > > > > and sysfs accesses
> > > > > > > > > >
> > > > > > > > > > Hmm, how can it be racy if you do proper locking?
> > > > > > > > >
> > > > > > > > > I can imagine two applications can each grab one of the
> > > > > > > > > controls and that makes the interface a bit not nice. That
> > > > > > > > > would require extra synchronization in userspace and so on.
> > > > > > > > >
> > > > > > > > > > > - SND_TONE + SND_TONE_SET_VOLUME
> > > > > > > > > > >      -> User needs to do two ioctls, hum
> > > > > > > > > > > - some new SND_TONE_WITH_VOLUME
> > > > > > > > > > >      -> Probably the best option, user sets both tone frequency
> > and volume
> > > > > > > > > > >         in one go, and it also only extends the IOCTL interface, so
> > older
> > > > > > > > > > >         userspace won't have issues
> > > > > > > > > >
> > > > > > > > > > Those are "extensions" I have mentioned, and I'm not a
> > > > > > > > > > big fan for that, honestly speaking.
> > > > > > > > > >
> > > > > > > > > > The fact that the beep *output* stuff is provided by the
> > > > > > > > > > *input* device is already confusing
> > > > > > > > >
> > > > > > > > > I agree, this confused me as well.
> > > > > > > >
> > > > > > > > This comes from the times when keyboards themselves were
> > > > > > > > capable of emitting bells (SUN, DEC, etc). In hindsight it
> > > > > > > > was not the best way of structuring things, same with the
> > > > > > > > keyboard LEDs (that are now plugged into the LED subsystem, but
> > still allow be driven through input).
> > > > > > > >
> > > > > > > > And in the same vein I wonder if we should bite the bullet
> > > > > > > > and pay with a bit of complexity but move sound-related things to
> > sound subsystem.
> > > > > > >
> > > > > > > I am not sure that's the right approach here, since the device
> > > > > > > cannot do PCM playback, just bleeps.
> > > > > > >
> > > > > > > > > > (it was so just because of historical reason), and yet
> > > > > > > > > > you start implementing more full-featured mixer control.
> > > > > > > > > > I'd rather keep fingers away.
> > > > > > > > > >
> > > > > > > > > > Again, if user-space requires the compatible behavior
> > > > > > > > > > like the existing desktop usages
> > > > > > > > >
> > > > > > > > > It does not. These pwm-beeper devices keep showing up in
> > > > > > > > > various embedded devices these days.
> > > > > > > > >
> > > > > > > > > > , it can be implemented in a similar way like the
> > > > > > > > > > existing ones; i.e. provide a mixer control with a
> > > > > > > > > > proper sound device.  The sound device doesn't need to
> > > > > > > > > > provide a PCM interface but just with a mixer interface.
> > > > > > > > > >
> > > > > > > > > > Or, if the purpose of your target device is a special
> > > > > > > > > > usage, you don't need to consider too much about the
> > > > > > > > > > existing interface, and try to keep the change as
> > > > > > > > > > minimal as possible without too intrusive API changes.
> > > > > > > > >
> > > > > > > > > My use case is almost perfectly matched by the current
> > > > > > > > > input pwm-beeper driver, the only missing bit is the
> > > > > > > > > ability to control the loudness at runtime. I think adding
> > > > > > > > > the SND_TONE_WITH_VOLUME parameter would cover it, with
> > least intrusive API changes.
> > > > > > > > >
> > > > > > > > > The SND_TONE already supports configuring tone frequency
> > > > > > > > > in Hz as its parameter. Since anything above 64 kHz is
> > > > > > > > > certainly not hearable by humans, I would say the
> > > > > > > > > SND_TONE_WITH_VOLUME could use 16 LSbits for frequency (so
> > up to 65535 Hz , 0 is OFF), and 16 MSbits for volume .
> > > > > > > > >
> > > > > > > > > I'm hesitant to overcomplicate something which can
> > > > > > > > > currently be controlled via single ioctl by pulling in sound
> > subsystem into the picture.
> > > > > > > >
> > > > > > > > Can you tell a bit more about your use case? What needs to
> > > > > > > > control the volume of beeps? Is this the only source of sounds on
> > the system?
> > > > > > >
> > > > > > > Custom user space application. The entire userspace is custom
> > > > > > > built in this case.
> > > > > > >
> > > > > > > In this case, it is a single-use device (think e.g. the kind
> > > > > > > of thermometer you stick in your ear when you're ill, to find out
> > how warm you are).
> > > > > > >
> > > > > > > The beeper there is used to do just that, bleep (with
> > > > > > > different frequencies to indicate different stuff), and that
> > > > > > > works. What I need in addition to that is control the volume
> > > > > > > of the bleeps from the application, so it isn't too noisy. And
> > > > > > > that needs to be user-controllable at runtime, so not something that
> > goes in DT.
> > > > > > >
> > > > > > > Right now there is just the bleeper , yes.
> > > > > >
> > > > > > It sounds like we essentially need an option within pcsp to
> > > > > > drive PWM instead of PCM, but input already has pwm-beeper; it
> > > > > > seems harmless to gently extend the latter for this use-case as
> > > > > > opposed to reworking the former.
> > > > > >
> > > > > > I agree that we should not invest too heavily in a legacy ABI,
> > > > > > however something like SND_BELL_VOL seems like a low-cost
> > > > > > addition that doesn't work against extending pcsp in the future.
> > > > > > In fact, input already has precedent for this exact same thing
> > > > > > by way of FF rumble effects, which are often PWM-based themselves.
> > > > > >
> > > > > > If SND_BELL_VOL or similar is not acceptable, then the original
> > > > > > sysfs approach seems like the next-best compromise. My only
> > > > > > issue with it was that I felt the range was not abstracted enough.
> > > > >
> > > > > If we want to extend the API we will need to define exactly how it
> > > > > will all work. I.e. what happens if userspace mixes the old
> > > > > SND_TONE and SND_BELL with the new SND_BELL_VOL or whatever.
> > Does
> > > > > it play with previously set volume? The default one?
> > > >
> > > > Default one, to preserve current behavior, yes.
> > >
> > > This was my idea as well, but I appreciate that the devil is in the
> > > details and each driver may have to duplicate some overhead.
> > >
> > > >
> > > > > How to set the default one?
> > > >
> > > > We do not, we can call pwm_get_duty_cycle() to get the current duty
> > > > cycle of the PWM to figure out the default.
> > > >
> > > > > How
> > > > > to figure out what the current volume is if we decide to make
> > > > > volume "sticky"?
> > > >
> > > > The patch stores the current volume configured via sysfs into
> > > > beeper->duty_cycle .
> > > >
> > > > > As far as userspace I expect it is more common to have one program
> > > > > (or component of a program) to set volume and then something else
> > > > > requests sound, so having one-shot API is of dubious value to me.
> > > >
> > > > Currently the use case I have for this is a single user facing
> > > > application which configures both.
> > > >
> > > > > I hope we can go with Takashi's proposal downthread, but if not I
> > > > > wonder if the sysfs approach is not the simplest one. Do we expect
> > > > > more beepers that can control volume besides pwm-beeper?
> > > >
> > > > It seems to me pulling in dependency on the entire sound subsystem
> > > > only to set beeper volume is overkill. I currently don't even have
> > > > sound subsystem compiled in.
> > >
> > > I like Takashi's patch; it seems like a more scalable solution.
> > > However, I can appreciate the reluctance to bring in the entire sound
> > > subsytem for what is probably a tiny piezoelectric buzzer.
> > >
> > > It seems like the sysfs solution is the best compromise in the
> > > meantime. If more and more users need to shoe-horn these kind of
> > > features in the future, we can make more informed decisions as to how to
> > extend the API (if at all).
> > 
> > That's my impression, too.  The original sysfs usage would be the right fit at
> > this moment.
> 
> I am fine with both using the Sound API and sysfs. I would additionally like to
> specify the pwm values in device-tree like done in pwm-backlight. It really depends
> on the hardware which values actually make a difference in volume.

OK, let's go with the sysfs API for now as I am not sure if we have more
drivers being able to control volume of beeps.

Marek, I think there were some minor comments on the patch, could you
please address them and respin?

Thanks.

-- 
Dmitry
