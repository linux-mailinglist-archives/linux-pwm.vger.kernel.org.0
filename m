Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE284921F0
	for <lists+linux-pwm@lfdr.de>; Mon, 19 Aug 2019 13:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbfHSLQU (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 19 Aug 2019 07:16:20 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37433 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbfHSLQU (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 19 Aug 2019 07:16:20 -0400
Received: by mail-wr1-f67.google.com with SMTP id z11so8293984wrt.4
        for <linux-pwm@vger.kernel.org>; Mon, 19 Aug 2019 04:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=sYL7MwOhoekZXAIluRkO4O6abKwPV5xWDSz9SiG3XnI=;
        b=SrHhkSlCRR2gmBXnlZ9FI5HFBABzwxvNa8AhHAvI55DKcotx0ZIziAITNc4rkC66aD
         6CTuNdnVos38qUQQAg5ZVzHr+KVoEgJVRZMR2SP9Nw26RmjP59ThVgfezhDhQk+UbAkP
         W5avi1hf+yf9eEImqE7iFj2DVNOLyMsS130AOZ6dbQATdLxkq+gV34DG4uPglDxVEHU1
         Cb/lVVLAc0dowOkblz8Xd5vckOST7hY/v1co7mc4H1eXelT4fVsEBwQCyBVkw6lOPKaS
         ziJ/aWZGhaZGNGK2oCPHTkd8JJmLDv/tjr1cJcbtTScdaHaXh7euFPnDpov0SVxl7cdl
         e3KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=sYL7MwOhoekZXAIluRkO4O6abKwPV5xWDSz9SiG3XnI=;
        b=SdUZLqTf2a8xDlAEzWuLop03cle2it4OxbNGaz1TnEb/IVgYFgafzHi23r7wpuNV5N
         OZ7r3vrmr0njOSGTEr3dYLHNBW2cLD0hcn2+ns+m3Uc6P5In52sU8xnXXP7KCPutLmdV
         DnmPMBHxnczVw6D7ScF2XBxtNIIEeFJSdRXwc0tU9vn5prA/3cnsQx8A1bRUiAQYZ/OL
         LN8Hon8WII0Xn01y1UgTd8bhEcH5Y30+cByw2imF/Lm6OyDZyzdf3gVuxoU11A+A1RMh
         mqY7tyCu40G8WIHiAfGoJQmwMq/FFnwchZ1hFpk/l3MJDNuQ9GgDCZw4rgBkMIIrrCTI
         Vraw==
X-Gm-Message-State: APjAAAVZ9Oo0FKLWGqgkTPgAeDZuzskWhjqPxS/lBqBVMZQVRQy2Zku8
        HC2HPNe2Gc7ZAq6T0ZhFunUMHQ==
X-Google-Smtp-Source: APXvYqweSsDDDlqBAEDnwhoSEhwjNEKT31VkZ/6tRaiTaurHW9p/OwYt4u6J+AkcMUwdc9v+6GjfMg==
X-Received: by 2002:adf:f710:: with SMTP id r16mr100240wrp.81.1566213376861;
        Mon, 19 Aug 2019 04:16:16 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id t13sm15081515wrr.0.2019.08.19.04.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2019 04:16:15 -0700 (PDT)
Date:   Mon, 19 Aug 2019 12:16:13 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Matthias Kaehlcke <mka@chromium.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-pwm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Douglas Anderson <dianders@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Pavel Machek <pavel@ucw.cz>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        kernel@pengutronix.de
Subject: Re: [PATCH v3 2/4] backlight: Expose brightness curve type through
 sysfs
Message-ID: <20190819111613.2kkn25tmjgyjhbip@holly.lan>
References: <20190709190007.91260-1-mka@chromium.org>
 <20190709190007.91260-3-mka@chromium.org>
 <20190816165148.7keg45fmlndr22fl@pengutronix.de>
 <20190816175157.GT250418@google.com>
 <20190816194754.ldzjqy2yjonfvaat@pengutronix.de>
 <20190816211051.GV250418@google.com>
 <20190819054628.asw3cxp46w3rpml7@pengutronix.de>
 <20190819095037.h3gig3quyhnzshm7@holly.lan>
 <20190819102127.wqudnbngottjakf5@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190819102127.wqudnbngottjakf5@pengutronix.de>
User-Agent: NeoMutt/20180716
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, Aug 19, 2019 at 12:21:27PM +0200, Uwe Kleine-König wrote:
> > > > In an ideal world the backlight interface would be consistent as you
> > > > suggest, however there are plenty of existing devices which use the
> > > > 'other' scaling (regardless of which is chosen as the 'correct'
> > > > one). Userspace still has to deal with these. And changing previously
> > > > 'logarithmic' drivers to linear (or viceversa) may 'break' userspace,
> > > > when it keeps using its 'old' scaling, which now isn't correct anymore.
> > > 
> > > It might be subjective, or maybe I'm just too optimistic, but I think if
> > > there was no policy before about the meaning of
> > > 
> > > 	echo 17 > brightness
> > > 
> > > other than "brighter than lower values and darker than higher ones"
> > > introducing (say) the scale is intended to represent a linear brightness
> > > curve is ok.
> > > 
> > > Unless userspace jumps through hoops and tries to identify the actual
> > > device it is running on it is wrong on some machines anyhow and we're
> > > only shifting the set of affected machines with a tighter policy (until
> > > that userspace application is fixed).
> > 
> > I believe that there are two common approaches by userspace at present:
> > 
> > 1. Assume the scale is perceptual and we can directly map a slider
> >    to the backlight value. This is common simply because most ACPI
> >    backlights are perceptual and therefore when tested in a laptop
> >    it works OK.
> > 
> > 2. Assume that is max brightness is small (e.g. ACPI) then the
> >    scale is perceptual and if the max brightness is large (e.g.
> >    a PWM) then the scale is linear and apply a correction
> >    function between the slider and the control.
> > 
> > That historic baggage makes is diffcult to "just define a standardized
> > scale"... especially given that if we selected a standardized scale we
> > would probably want a perceptual scale with lots of steps (e.g. break
> > the heuristic).
> 
> With "perceptual" you mean that logarithmic stuff, right?

Human perception is fairly complex so it depends how strict you want to
get. At the end of the day what it means is you can map a slider UI
component directly to the backlight range and it will feel right. Thus
a userspace that maps directly to a slider *is* assuming the scale
is perceptual.

Logarithmic scales are often mentioned in this kind of conversation
because they are hoped to be "perceptual enough". They are not strictly
matched to human perception but with a sane exponent shouldn't feel
as broken as a linear scale does.

Finally note that for people with an audio background then logarithmic
and perceptual are used interchangably (based on the assumption that
decibels are a preceptual scale).


> I would tend to go for linear because this is easily measureable and
> also is straight forward to implement in the usual cases (attention: I
> assume that "usual" means something like PWM and I don't know much about
> the physics of backlights but just assume that a PWM will create a
> linear mapping).

Mandating a linear scale makes things difficult for ACPI systems (which
are amoung the most common cases) since we would have to un-perceptualize
it. Additionally it is not a particularly helpful scale to offer the
userspace.

All proposals I have seen in this space assume we will map linear
hardware to a perceptual scale rather than trying to unmap devices that
are already perceptual.

Within the backlight space we are also moving (slowly) towards
perceptual scales to align with this. For example pwm_bl.c will
automatically generate a perceptual table unless the DT tells it
not to.


> > > And the big upside is that in the end (i.e. when all kernel drivers and
> > > userspace applications are adapted to provide/consume the "correct"
> > > curve) the result is simpler.
> > 
> > My view is that this convergence will eventually be achieved but it will
> > happen through the obsolescence of the backlight sysfs interface. The
> > sysfs interface has other flaws, in particular no integration with the
> > DRM connector API.
> > 
> > Thus I would expect an alternative interface to emerge, most likely as
> > part of the DRM connector API. I'd expect such a new API to a
> > perceptual scale and to have a fixed max brightness with enough
> > steps to support animated backlight effects (IIRC 0..100 has been
> > proposed in the past) 
> 
> Then work on the new stuff instead of making the old stuff (that is
> intended to die) harder to use correctly?

I do not accept this this change makes it harder to use the backlight
correctly.

We know the current userspace heuristics are fragile and that as
backlight animation becomes more popular will become unmaintainable
(backlight animation encourages backlights with a perceptual scale to
introduce more steps... resulting in them being mishandled by
userspace).

Anyhow given we know sophisticated userspaces already have two code
paths controls by heuristic and that this will break then we are
simply providing a clear indication that allows their maintainers a
non-heuristic solution when bug reports come in. It also means that
userspaces that are currently naive (e.g. assume perceptual scale) need
not introduce a heuristic if they get a bug report.


> > In the mean time getting the existing collection of backlight drivers
> > marked up as linear/logarithmic/etc will ease the introduction of that
> > API because, within the kernel, we might have gathered enough knowledge
> > to have some hope of correctly mapping each backlight onto a
> > standardized scale.
> 
> It would be enough to do this in a code comment then. That would come
> without the need to adapt the old userspace API. Also when the old
> solution works at 95% instead of 90% before, it will resist harder to
> dying.

To be honest I think the traction for the sysfs interface comes from
the fact that, with or without the proposed change, it is good enough
for the ACPI systems that dominate the landscape.


Daniel.
