Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 785B1509C4
	for <lists+linux-pwm@lfdr.de>; Mon, 24 Jun 2019 13:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728761AbfFXL2u (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 24 Jun 2019 07:28:50 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44141 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727525AbfFXL2u (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 24 Jun 2019 07:28:50 -0400
Received: by mail-wr1-f65.google.com with SMTP id r16so13463812wrl.11
        for <linux-pwm@vger.kernel.org>; Mon, 24 Jun 2019 04:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UNcy8eWqctDZ/B0vQmCYKv2pj1uHfmf+ueIIuptmq+g=;
        b=HofRi30RbWmoIRYk082kCxt/H5Be+HRHLSug71DnVgsW1wmNEH1LPvTG3PsCttbvvC
         dtgv/zgBiH8OcGz6bjsS+7FCSFCUUKoTnHE73WfOV5DzNs+J9G3iHEFI01fSqUDb4WiP
         DD1uXfJgSvKavkWwFeOqvzsVA0ysnXDZLodb3SzosUwEiqzCMpjIf0Wj9dwrujNb/FMj
         A/SM1HD1ACjmDGDvr4ePjLI8NkmXQ3ntpR4oh50Uka9zAsBoO354aXnu9yU2SIszxli1
         Nw6EUWjdsKmvji+uM12gtlfuYf3uqQ74XZR5TI6X5qiiSkkBYCAPOtDYZ4GIcOQWx1F/
         G2UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UNcy8eWqctDZ/B0vQmCYKv2pj1uHfmf+ueIIuptmq+g=;
        b=LYTisfw2ZMuJPnTd2WGBEqiQI0BzBlwnf/uij5ij4NCK1I7xkgG8kdnQHm7/Nlbw1f
         +i6lQYJ2i6gDh1Bp7dDSE/gH5MBTP+/Ulaj0TqgE6i3Yld64E5Qfjn7QD0PR36uvf91H
         Q9W78lq9LclXl1yMZ+wFkUWdovBzVC7cvbOtNOsLV0NkCAwvcsgrRKmAVCI2qS3Dph3w
         PQL08lrIJxSDDN11HHTmXvcBdBZ75dHPywjyJD/mMxDl81FUsl/z3aL+Ru2aX/uLlVrj
         4MEI6Hjg5cfbBRRGGcy9xs4R55Vhc3A7BXiVa7hmvdJmwJJcTghptVR4z0n+J9RQkMU+
         eS0w==
X-Gm-Message-State: APjAAAU+KLKUZl4KMMmDF4A8u9pSm5kwfPKTR7+opFv5GV3+LUUJ/MO3
        zBmoZBm6pah1X2IwyQgCCtdcdA==
X-Google-Smtp-Source: APXvYqx2FMSxOtUi9i/iRHzrVCNGDY7XivA/wMjvC/gHwJYcWyvkHAQGW/e4L15l5LzoWyz6R8VRig==
X-Received: by 2002:a5d:46c7:: with SMTP id g7mr59955676wrs.215.1561375727072;
        Mon, 24 Jun 2019 04:28:47 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id h8sm8951645wmf.12.2019.06.24.04.28.45
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 24 Jun 2019 04:28:46 -0700 (PDT)
Date:   Mon, 24 Jun 2019 12:28:44 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        od@zcrc.me, linux-pwm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] backlight: pwm_bl: Set pin to sleep state when powered
 down
Message-ID: <20190624112844.fmwbfpdxjkst3u7r@holly.lan>
References: <20190522163428.7078-1-paul@crapouillou.net>
 <5b0f8bb3-e7b0-52c1-1f2f-9709992b76fc@linaro.org>
 <20190621135608.GB11839@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190621135608.GB11839@ulmo>
User-Agent: NeoMutt/20180716
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, Jun 21, 2019 at 03:56:08PM +0200, Thierry Reding wrote:
> On Fri, Jun 21, 2019 at 01:41:45PM +0100, Daniel Thompson wrote:
> > On 22/05/2019 17:34, Paul Cercueil wrote:
> > > When the driver probes, the PWM pin is automatically configured to its
> > > default state, which should be the "pwm" function.
> > 
> > At which point in the probe... and by who?
> 
> The driver core will select the "default" state of a device right before
> calling the driver's probe, see:
> 
> 	drivers/base/pinctrl.c: pinctrl_bind_pins()
> 
> which is called from:
> 
> 	drivers/base/dd.c: really_probe()
> 

Thanks. I assumed it would be something like that... although given
pwm-backlight is essentially a wrapper driver round a PWM I wondered why
the pinctrl was on the backlight node (rather than the PWM node).

Looking at the DTs in the upstream kernel it looks like ~20% of the
backlight drivers have pinctrl on the backlight node. Others presumable
have none or have it on the PWM node (and it looks like support for
sleeping the pins is *very* rare amoung the PWM drivers).


> > > However, at this
> > > point we don't know the actual level of the pin, which may be active or
> > > inactive. As a result, if the driver probes without enabling the
> > > backlight, the PWM pin might be active, and the backlight would be
> > > lit way before being officially enabled.
> > > 
> > > To work around this, if the probe function doesn't enable the backlight,
> > > the pin is set to its sleep state instead of the default one, until the
> > > backlight is enabled. Whenk the backlight is disabled, the pin is reset
> > > to its sleep state.
> > Doesn't this workaround result in a backlight flash between whatever enables
> > it and the new code turning it off again?
> 
> Yeah, I think it would. I guess if you're very careful on how you set up
> the device tree you might be able to work around it. Besides the default
> and idle standard pinctrl states, there's also the "init" state. The
> core will select that instead of the default state if available. However
> there's also pinctrl_init_done() which will try again to switch to the
> default state after probe has finished and the driver didn't switch away
> from the init state.
> 
> So you could presumably set up the device tree such that you have three
> states defined: "default" would be the one where the PWM pin is active,
> "idle" would be used when backlight is off (PWM pin inactive) and then
> another "init" state that would be the same as "idle" to be used during
> probe. During probe the driver could then switch to the "idle" state so
> that the pin shouldn't glitch.
> 
> I'm not sure this would actually work because I think the way that
> pinctrl handles states both "init" and "idle" would be the same pointer
> values and therefore pinctrl_init_done() would think the driver didn't
> change away from the "init" state because it is the same pointer value
> as the "idle" state that the driver selected. One way to work around
> that would be to duplicate the "idle" state definition and associate one
> instance of it with the "idle" state and the other with the "init"
> state. At that point both states should be different (different pointer
> values) and we'd get the init state selected automatically before probe,
> select "idle" during probe and then the core will leave it alone. That's
> of course ugly because we duplicate the pinctrl state in DT, but perhaps
> it's the least ugly solution.
> Adding Linus for visibility. Perhaps he can share some insight.

To be honest I'm happy to summarize in my head as "if it flashes then it's not
a pwm_bl.c's problem" ;-).


Daniel.


> 
> On that note, I'm wondering if perhaps it'd make sense for pinctrl to
> support some mode where a device would start out in idle mode. That is,
> where pinctrl_bind_pins() would select the "idle" mode as the default
> before probe. With something like that we could easily support this
> use-case without glitching.
> 
> I suppose yet another variant would be for the PWM backlight to not use
> any of the standard pinctrl states at all. Instead it could just define
> custom states, say "active" and "inactive". Looking at the code that
> would prevent pinctrl_bind_pins() from doing anything with pinctrl
> states and given the driver exact control over when each of the states
> will be selected. That's somewhat suboptimal because we can't make use
> of the pinctrl PM helpers and it'd require more boilerplate.
> 
> Thierry
> 
> > > Signed-off-by: Paul Cercueil <paul@crapouillou.net> > ---
> > >   drivers/video/backlight/pwm_bl.c | 9 +++++++++
> > >   1 file changed, 9 insertions(+)
> > > 
> > > diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
> > > index fb45f866b923..422f7903b382 100644
> > > --- a/drivers/video/backlight/pwm_bl.c
> > > +++ b/drivers/video/backlight/pwm_bl.c
> > > @@ -16,6 +16,7 @@
> > >   #include <linux/module.h>
> > >   #include <linux/kernel.h>
> > >   #include <linux/init.h>
> > > +#include <linux/pinctrl/consumer.h>
> > >   #include <linux/platform_device.h>
> > >   #include <linux/fb.h>
> > >   #include <linux/backlight.h>
> > > @@ -50,6 +51,8 @@ static void pwm_backlight_power_on(struct pwm_bl_data *pb)
> > >   	struct pwm_state state;
> > >   	int err;
> > > +	pinctrl_pm_select_default_state(pb->dev);
> > > +
> > >   	pwm_get_state(pb->pwm, &state);
> > >   	if (pb->enabled)
> > >   		return;
> > > @@ -90,6 +93,8 @@ static void pwm_backlight_power_off(struct pwm_bl_data *pb)
> > >   	regulator_disable(pb->power_supply);
> > >   	pb->enabled = false;
> > > +
> > > +	pinctrl_pm_select_sleep_state(pb->dev);
> > >   }
> > >   static int compute_duty_cycle(struct pwm_bl_data *pb, int brightness)
> > > @@ -626,6 +631,10 @@ static int pwm_backlight_probe(struct platform_device *pdev)
> > >   	backlight_update_status(bl);
> > >   	platform_set_drvdata(pdev, bl);
> > > +
> > > +	if (bl->props.power == FB_BLANK_POWERDOWN)
> > > +		pinctrl_pm_select_sleep_state(&pdev->dev);
> > 
> > Didn't backlight_update_status(bl) already do this?
> > 
> > 
> > Daniel.
> > 
> > 
> > > +
> > >   	return 0;
> > >   err_alloc:
> > > 
> > 


