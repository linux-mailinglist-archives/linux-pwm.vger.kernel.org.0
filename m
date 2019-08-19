Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8708F920B4
	for <lists+linux-pwm@lfdr.de>; Mon, 19 Aug 2019 11:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbfHSJum (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 19 Aug 2019 05:50:42 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39227 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbfHSJum (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 19 Aug 2019 05:50:42 -0400
Received: by mail-wm1-f67.google.com with SMTP id i63so1023887wmg.4
        for <linux-pwm@vger.kernel.org>; Mon, 19 Aug 2019 02:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=wICfFLnXhIBKpRL3MkChT8cnTtZKk7MVOyrCJIfR7D4=;
        b=jWDr4u7KdKLlFacXo7dujEGjOc/1AXUmMpT0Ji/Pdu4LLH2ALWJ8i7wPh/C1iVIbYn
         bwZnMTvkfCMFE4O3yPzd4bDvO1mXRsSRESmgwtTEetC0GVmNHDe4GX+8vIsFeHZfjLbK
         jAujLEvOtZxgzNlXLRW8NmUlr0QvI0c7rKtlMg42PU86FWlSxy0epJzqjrqiSupx2Z4w
         ZNP1BvKM2hnEZXgCYNgLKtW1CdFKQ49JTia96GIE6vT1jKxOdQ4NaKCpgArrzD2rZ3qV
         q4p6uw1juHGyc8DfyirFfCO0V/w4034IBfD/1/m/bAB1mZlnjXSBY+3d2Xdza74dTIRi
         4sNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=wICfFLnXhIBKpRL3MkChT8cnTtZKk7MVOyrCJIfR7D4=;
        b=GK9AigDeYj6zJwa17YQr1g7CGkeuwpZtSg3+yJv2u55a1eZP7LhBX9gc1DNoLS7Aj8
         b/mxBWt3cunkBpykePMfaBiVPrU3aNu/UAcUJszoNz7q/lW3WLgDrH0BHaAUwl8tt0oT
         /6TpiZOjcf5gcMqCy1vixkdzRqjGfbLIiX7MiaY9Vr6iKIuZec7N8QzsBGR6jPLKLWSP
         GMxLjL67SywD//12+UK+8AgWvGE2uJoTc0L0gLF9xuD+9PEz4/luOJF16jO6pQNsc7A8
         8Mg7tnTWe+KK9ucfY/tPSsJWw4TP/QGKgb/lGe837de3z8KcRYzyEjJN6GNqVfg/J/lu
         dMbw==
X-Gm-Message-State: APjAAAWprUIkpFjWnXBTVVsgvAfi//XCBYQqINig/63jIrH15YqZqjyj
        hIHtYagbD07LQDBgbeYl5h6tmQ==
X-Google-Smtp-Source: APXvYqzo8MEEXCCxdKSZfzaFQthu5ElI1s13ZbbnpzjLTOaUkTmyi8JDnWb7nZOqVe1cES2YKuJZjA==
X-Received: by 2002:a1c:630b:: with SMTP id x11mr19227174wmb.135.1566208239870;
        Mon, 19 Aug 2019 02:50:39 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id f13sm4491631wrr.5.2019.08.19.02.50.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2019 02:50:39 -0700 (PDT)
Date:   Mon, 19 Aug 2019 10:50:37 +0100
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
Message-ID: <20190819095037.h3gig3quyhnzshm7@holly.lan>
References: <20190709190007.91260-1-mka@chromium.org>
 <20190709190007.91260-3-mka@chromium.org>
 <20190816165148.7keg45fmlndr22fl@pengutronix.de>
 <20190816175157.GT250418@google.com>
 <20190816194754.ldzjqy2yjonfvaat@pengutronix.de>
 <20190816211051.GV250418@google.com>
 <20190819054628.asw3cxp46w3rpml7@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190819054628.asw3cxp46w3rpml7@pengutronix.de>
User-Agent: NeoMutt/20180716
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, Aug 19, 2019 at 07:46:28AM +0200, Uwe Kleine-K�nig wrote:
> Hello Matthias,
> 
> On Fri, Aug 16, 2019 at 02:10:51PM -0700, Matthias Kaehlcke wrote:
> > On Fri, Aug 16, 2019 at 09:47:54PM +0200, Uwe Kleine-K�nig wrote:
> > > On Fri, Aug 16, 2019 at 10:51:57AM -0700, Matthias Kaehlcke wrote:
> > > > Hi Uwe,
> > > > 
> > > > On Fri, Aug 16, 2019 at 06:51:48PM +0200, Uwe Kleine-K�nig wrote:
> > > > > On Tue, Jul 09, 2019 at 12:00:05PM -0700, Matthias Kaehlcke wrote:
> > > > > > Backlight brightness curves can have different shapes. The two main
> > > > > > types are linear and non-linear curves. The human eye doesn't
> > > > > > perceive linearly increasing/decreasing brightness as linear (see
> > > > > > also 88ba95bedb79 "backlight: pwm_bl: Compute brightness of LED
> > > > > > linearly to human eye"), hence many backlights use non-linear (often
> > > > > > logarithmic) brightness curves. The type of curve currently is opaque
> > > > > > to userspace, so userspace often uses more or less reliable heuristics
> > > > > > (like the number of brightness levels) to decide whether to treat a
> > > > > > backlight device as linear or non-linear.
> > > > > > 
> > > > > > Export the type of the brightness curve via the new sysfs attribute
> > > > > > 'scale'. The value of the attribute can be 'linear', 'non-linear' or
> > > > > > 'unknown'. For devices that don't provide information about the scale
> > > > > > of their brightness curve the value of the 'scale' attribute is 'unknown'.
> > > > > > 
> > > > > > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > > > > 
> > > > > I wonder what kind of problem you are solving here. Can you describe
> > > > > that in a few words?
> > > > 
> > > > The human eye perceives brightness in a logarithmic manner. For
> > > > backlights with a linear brightness curve brightness controls like
> > > > sliders need to use a mapping to achieve a behavior that is perceived
> > > > as linear-ish (more details: http://www.pathwaylighting.com/products/downloads/brochure/technical_materials_1466797044_Linear+vs+Logarithmic+Dimming+White+Paper.pdf)
> > > > 
> > > > As of now userspace doesn't have information about the type of the
> > > > brightness curve, and often uses heuristics to make a guess, which may
> > > > be right most of the time, but not always. The new attribute eliminates
> > > > the need to guess.
> > > 
> > > This is about backlights right? So the kernel provides to userspace an
> > > interval [0, x] for some x and depending on the physics of the the
> > > backlight configuring x/2 (probably?) either means 50% measured light or
> > > 50% perceived light, right?
> > 
> > correct
> > 
> > > I wonder if it would be possible instead of giving different backlight
> > > implementations the freedom to use either linear or logarithmic (or
> > > quadratic?) scaling and tell userspace which of the options were picked
> > > require the drivers to provide a (say) linear scaling and then userspace
> > > wouldn't need to care about the exact physics.
> > 
> > In an ideal world the backlight interface would be consistent as you
> > suggest, however there are plenty of existing devices which use the
> > 'other' scaling (regardless of which is chosen as the 'correct'
> > one). Userspace still has to deal with these. And changing previously
> > 'logarithmic' drivers to linear (or viceversa) may 'break' userspace,
> > when it keeps using its 'old' scaling, which now isn't correct anymore.
> 
> It might be subjective, or maybe I'm just too optimistic, but I think if
> there was no policy before about the meaning of
> 
> 	echo 17 > brightness
> 
> other than "brighter than lower values and darker than higher ones"
> introducing (say) the scale is intended to represent a linear brightness
> curve is ok.
> 
> Unless userspace jumps through hoops and tries to identify the actual
> device it is running on it is wrong on some machines anyhow and we're
> only shifting the set of affected machines with a tighter policy (until
> that userspace application is fixed).

I believe that there are two common approaches by userspace at present:

1. Assume the scale is perceptual and we can directly map a slider
   to the backlight value. This is common simply because most ACPI
   backlights are perceptual and therefore when tested in a laptop
   it works OK.

2. Assume that is max brightness is small (e.g. ACPI) then the
   scale is perceptual and if the max brightness is large (e.g.
   a PWM) then the scale is linear and apply a correction
   function between the slider and the control.

That historic baggage makes is diffcult to "just define a standardized
scale"... especially given that if we selected a standardized scale we
would probably want a perceptual scale with lots of steps (e.g. break
the heuristic).


> And the big upside is that in the end (i.e. when all kernel drivers and
> userspace applications are adapted to provide/consume the "correct"
> curve) the result is simpler.

My view is that this convergence will eventually be achieved but it will
happen through the obsolescence of the backlight sysfs interface. The
sysfs interface has other flaws, in particular no integration with the
DRM connector API.

Thus I would expect an alternative interface to emerge, most likely as
part of the DRM connector API. I'd expect such a new API to a
perceptual scale and to have a fixed max brightness with enough
steps to support animated backlight effects (IIRC 0..100 has been
proposed in the past) 

In the mean time getting the existing collection of backlight drivers
marked up as linear/logarithmic/etc will ease the introduction of that
API because, within the kernel, we might have gathered enough knowledge
to have some hope of correctly mapping each backlight onto a
standardized scale.


Daniel.
