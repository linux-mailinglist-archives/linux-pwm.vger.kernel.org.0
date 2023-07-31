Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A11AA768B32
	for <lists+linux-pwm@lfdr.de>; Mon, 31 Jul 2023 07:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbjGaFgo (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 31 Jul 2023 01:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjGaFgo (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 31 Jul 2023 01:36:44 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 131FAE68;
        Sun, 30 Jul 2023 22:36:43 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-68336d06620so4150680b3a.1;
        Sun, 30 Jul 2023 22:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690781802; x=1691386602;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GEYDHdxW+GqO/A72zpM2Ivj3ad0HfR7AVeRSROhpavA=;
        b=hDTr062anlw+gU4Ml5fkr/Wqeg81olwlqGYFQzMcGd2un12W9W64LQ7TevFxj5f1Jm
         8o9JeYLduBM6K5Hs9Fj7tuqmRpQGaYtGr6HDisLzsMgBiLSA86A9ZmktUufhCxB2hKOs
         GWvdcmnVbpg7aBq4MFXNyMoigFMjx3JzHoDa9Qca6zbR/hnQAFtGcQgqHWfIE/7tI0RW
         Fe8z8zsvcNZsoNlq8LgtwJDeO+aOdsuM6dZGpYPPw7KZxhf/nFap6vsmRp6mgb/byoib
         yYlVAuMo8XAOylVDtFebP2AI0Z/lrKaAKBLd8rsdmkOVvROvRAlmmhJMWKD8SB325F4i
         UB9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690781802; x=1691386602;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GEYDHdxW+GqO/A72zpM2Ivj3ad0HfR7AVeRSROhpavA=;
        b=gZXBsfdv0hXqWl+gwnCAWU2G2w9mpD+ikB26owqVqoCHyzgggPzYB0ruOVk3fNP6wS
         8cFw3J6Yd3Tl8S1+zzDGaxtGlnSYsiKx3XfVSNjQzMzhQEXkDeq76wZalT67vL1i0dLl
         8o/HtQ7Yg4xp7Xlf5FzrJ8cdrYLLQom6mpwjEyapWwFN6MVn/YJcPQz86KIa04bQw0BR
         6IjTOnmpYTv76DhibA1+58WttNMnQ/ZpvKkKkmetkFqsy4dBJBlgwxT8DW2sf/pHEYt5
         MEDNB5tK4smSegFtoJBggmZTdsiUSMqHoR74To2QQi17jjPlxrILyvm8V/LuUNceoQIk
         jQEQ==
X-Gm-Message-State: ABy/qLbAjvTcLh2rS4h0XH4CyJqxEqkiEPUroAhaeBFADLCXd+2Qx83z
        eeLrl9Q+DkTtER1JePNKkAg=
X-Google-Smtp-Source: APBJJlE3/PWrxtTzXeEVgTjilO2kKRi76gBdRfysdoM8scgKejMgaNyfKWfKEnHr4SYWD58E0UkGlg==
X-Received: by 2002:a05:6a20:8f19:b0:13b:c4a8:1a68 with SMTP id b25-20020a056a208f1900b0013bc4a81a68mr9762941pzk.34.1690781802268;
        Sun, 30 Jul 2023 22:36:42 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:6d25:c0f1:d8d5:201c])
        by smtp.gmail.com with ESMTPSA id e26-20020aa78c5a000000b0064d57ecaa1dsm4052358pfd.28.2023.07.30.22.36.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jul 2023 22:36:41 -0700 (PDT)
Date:   Sun, 30 Jul 2023 22:36:38 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Marek Vasut <marex@denx.de>
Cc:     Jeff LaBundy <jeff@labundy.com>, linux-input@vger.kernel.org,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Manuel Traut <manuel.traut@mt.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org, alsa-devel@alsa-project.org,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: Re: [PATCH] Input: pwm-beeper - Support volume setting via sysfs
Message-ID: <ZMdIZiC453onyeHh@google.com>
References: <20230512185551.183049-1-marex@denx.de>
 <ZF7kCjKGVjsxK8ec@nixie71>
 <0ef98ec1-6191-c72e-2362-310db7f09b84@denx.de>
 <06379f26-ab24-85f9-783f-0c49d4291b23@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06379f26-ab24-85f9-783f-0c49d4291b23@denx.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Sat, May 13, 2023 at 11:02:30PM +0200, Marek Vasut wrote:
> On 5/13/23 03:51, Marek Vasut wrote:
> > On 5/13/23 03:12, Jeff LaBundy wrote:
> > > Hi Marek,
> > 
> > Hi,
> > 
> > > On Fri, May 12, 2023 at 08:55:51PM +0200, Marek Vasut wrote:
> > > > The PWM beeper volume can be controlled by adjusting the PWM duty cycle,
> > > > expose volume setting via sysfs, so users can make the beeper quieter.
> > > > This patch adds sysfs attribute 'volume' in range 0..50000, i.e. from 0
> > > > to 50% in 1/1000th of percent steps, this resolution should be
> > > > sufficient.
> > > > 
> > > > The reason for 50000 cap on volume or PWM duty cycle is because
> > > > duty cycle
> > > > above 50% again reduces the loudness, the PWM wave form is inverted wave
> > > > form of the one for duty cycle below 50% and the beeper gets quieter the
> > > > closer the setting is to 100% . Hence, 50% cap where the wave
> > > > form yields
> > > > the loudest result.
> > > > 
> > > > Signed-off-by: Marek Vasut <marex@denx.de>
> > > > ---
> > > > An alternative option would be to extend the userspace input
> > > > ABI, e.g. by
> > > > using SND_TONE top 16bits to encode the duty cycle in 0..50000
> > > > range, and
> > > > bottom 16bit to encode the existing frequency in Hz . Since frequency in
> > > > Hz is likely to be below some 25 kHz for audible bell, this fits
> > > > in 16bits
> > > > just fine. Thoughts ?
> > > > ---
> > > 
> > > Thanks for the patch; this seems like a useful feature.
> > > 
> > > My first thought is that 50000 seems like an oddly specific limit to
> > > impose
> > > upon user space. Ideally, user space need not even care that the
> > > beeper is
> > > implemented via PWM and why 50000 is significant.
> > > 
> > > Instead, what about accepting 0..255 as the LED subsystem does for
> > > brightness,
> > > then map these values to 0..50000 internally? In fact, the leds-pwm
> > > driver
> > > does something similar.
> > 
> > The pwm_set_relative_duty_cycle() function can map whatever range to
> > whatever other range of the PWM already, so that's not an issues here.
> > It seems to me the 0..127 or 0..255 range is a bit too limiting . I
> > think even for the LEDs the reason for that limit is legacy design, but
> > here I might be wrong.
> > 
> > > I'm also curious as to whether this function should be a rogue sysfs
> > > control
> > > limited to this driver, or a generic operation in input. For
> > > example, input
> > > already allows user space to specify the magnitude of an FF effect;
> > > perhaps
> > > something similar is warranted here?
> > 
> > See the "An alternative ..." part above, I was wondering about this too,
> > whether this can be added into the input ABI, but I am somewhat
> > reluctant to fiddle with the ABI.
> 
> Thinking about this further, we could try and add some
> 
> EV_SND SND_TONE_WITH_VOLUME
> 
> to avoid overloading EV_SND SND_TONE , and at the same time allow the user
> to set both frequency and volume for the tone without any race condition
> between the two.
> 
> The EV_SND SND_TONE_WITH_VOLUME would still take one 32bit parameter, except
> this time the parameter 16 LSbits would be the frequency and 16 MSbits would
> be the volume.
> 
> But again, here I would like input from the maintainers.

Beeper was supposed to be an extremely simple device with minimal
controls. I wonder if there is need for volume controls, etc, etc are we
not better moving it over to the sound subsystem. We already have:

	sound/drivers/pcsp/pcsp.c

and

	sound/pci/hda/hda_beep.c

there, can we have other "advanced" beepers there as well? Adding sound
maintainers to CC...

Thanks.

-- 
Dmitry
