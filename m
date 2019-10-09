Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03BC9D0BEF
	for <lists+linux-pwm@lfdr.de>; Wed,  9 Oct 2019 11:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729790AbfJIJ4k (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 9 Oct 2019 05:56:40 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37965 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbfJIJ4k (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 9 Oct 2019 05:56:40 -0400
Received: by mail-wm1-f65.google.com with SMTP id 3so1829625wmi.3
        for <linux-pwm@vger.kernel.org>; Wed, 09 Oct 2019 02:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=hxsH3GTQwNHLdOw5Q3OdNk0c6ypT5eKzYZW7xFORZ1w=;
        b=EwqXO91U89voAZZgK4r8r/6JEomJfDCkHUPJswri+0lmgGB4uGECUPwAqgrxsMdB3u
         mtHVF2ROrbo7X5IVW6emaGY6DXmsrtjgCfVHgmwxmuuLnbiNAOWcDAo3awvgBsVCaSMs
         /E0lbp6cNMF/Ho5XTWxiQ53BkCtG4Mi+viufedal8Ziv30/sr0z+UjkPjXiW9yaNU5D7
         ojg/+4EOsCoqlws1bqtfbLiOvNmZ3EVdgHlnEP1Vg6epRK361SQo4rAWVDZ12rKACyw1
         W7hOpstagl9wEMAnXFITv7uamQNYK3zVSuC9Ar0BFD4asAQ2sPdzUfPxyaFXydZ1/BUx
         12Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=hxsH3GTQwNHLdOw5Q3OdNk0c6ypT5eKzYZW7xFORZ1w=;
        b=gwdFGUcMxPGW1hvdQoU+TMtrKt1z/jEi819yrMZMOUzefs4ieVykTOSCPiS1WNQ07C
         PskKPP0bisQ3GWNzspECVFa8YlcM8RvzoOZu0CnTzccjg2bEfaZ04QjeUfHOMyLUSunl
         7iSLdljLDEsrTGZw3YqinEm1EMtWGyQeQjlkJTGN0dQBy/Q8YU5FDrGzolr4VcYVCAPs
         oJ7Y1ryJ0hFWWSoCxMdqs669ZDztoICUQwQZKZK0H2IJsP3nwBFAmL3OssUnBqQX4h/y
         uEJKyMsJWGWnvSHLkqGYMntKrffUv9gI6bRajwMgbn+HNqY5H4rl+jXHSW5ehwlMFhFq
         jtaw==
X-Gm-Message-State: APjAAAWXHiT3DcDLfZ7PXcfGMiWJC+psMQth9WYB06zJk3mLQeIq+6MV
        rDv8g4g6kyfUWp8rzG8Z9of1aw==
X-Google-Smtp-Source: APXvYqykMolF/GFDnS3dpUQWijyd/lH/UiuWQEj924XkgMileNAmUU2j4IopMiyQRtc9Fl0UVjpbsg==
X-Received: by 2002:a7b:cf0e:: with SMTP id l14mr1983091wmg.46.1570614997677;
        Wed, 09 Oct 2019 02:56:37 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id r12sm1569593wrq.88.2019.10.09.02.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 02:56:36 -0700 (PDT)
Date:   Wed, 9 Oct 2019 10:56:35 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-kernel@vger.kernel.org,
        thierry.reding@gmail.com, heiko@sntech.de, dianders@chromium.org,
        mka@chromium.org, groeck@chromium.org, kernel@collabora.com,
        bleung@chromium.org, linux-pwm@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH] pwm: cros-ec: Let cros_ec_pwm_get_state() return the
 last applied state
Message-ID: <20191009095635.yysr33lnwldicyng@holly.lan>
References: <20191008105417.16132-1-enric.balletbo@collabora.com>
 <20191008143432.pbhcqamd6f4qwbqn@pengutronix.de>
 <4f009344-242e-19a7-6872-2c55df086044@collabora.com>
 <20191008203137.s22clq6v2om5ktio@pengutronix.de>
 <53b7d02b-1a2d-11da-fdd0-5378f360d876@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <53b7d02b-1a2d-11da-fdd0-5378f360d876@collabora.com>
User-Agent: NeoMutt/20180716
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, Oct 09, 2019 at 11:27:13AM +0200, Enric Balletbo i Serra wrote:
> Hi Uwe,
> 
> Adding Daniel and Lee to the discussion ...

Thanks!

> On 8/10/19 22:31, Uwe Kleine-König wrote:
> > On Tue, Oct 08, 2019 at 06:33:15PM +0200, Enric Balletbo i Serra wrote:
> >>> A few thoughts to your approach here ...:
> >>>
> >>>  - Would it make sense to only store duty_cycle and enabled in the
> >>>    driver struct?
> >>>
> >>
> >> Yes, in fact, my first approach (that I didn't send) was only storing enabled
> >> and duty cycle. For some reason I ended storing the full pwm_state struct, but I
> >> guess is not really needed.
> >>
> >>
> >>>  - Which driver is the consumer of your pwm? If I understand correctly
> >>>    the following sequence is the bad one:
> >>>
> >>
> >> The consumer is the pwm_bl driver. Actually I'n trying to identify
> >> other consumers.
> > 
> 
> So far, the pwm_bl driver is the only consumer of cros-ec-pwm.
> 
> > Ah, I see why I missed to identify the problem back when I checked this
> > driver. The problem is not that .duty_cycle isn't set but there .enabled
> > isn't set. So maybe we just want:
> > 
> > diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
> > index 2201b8c78641..0468c6ee4448 100644
> > --- a/drivers/video/backlight/pwm_bl.c
> > +++ b/drivers/video/backlight/pwm_bl.c
> > @@ -123,6 +123,7 @@ static int pwm_backlight_update_status(struct backlight_device *bl)
> >         if (brightness > 0) {
> >                 pwm_get_state(pb->pwm, &state);
> >                 state.duty_cycle = compute_duty_cycle(pb, brightness);
> > +               state.enabled = true;
> >                 pwm_apply_state(pb->pwm, &state);
> >                 pwm_backlight_power_on(pb);
> >         } else
> > 
> > ? On a side note: It's IMHO strange that pwm_backlight_power_on
> > reconfigures the PWM once more.
> > 
> 
> Looking again to the pwm_bl code, now, I am not sure this is correct (although
> it probably solves the problem for me).

Looking at the pwm_bl code I wouldn't accept the above as it is but I'd
almost certainly accept a patch to pwm_bl to move the PWM enable/disable
out of both the power on/off functions so the duty-cycle/enable or
disable can happen in one go within the update_status function. I don't
think such a change would interfere with the power and enable sequencing
needed by panels and it would therefore be a nice continuation of the
work to convert over to the pwm_apply_state() API.

None of the above has anything to do with what is right or wrong for
the PWM API evolution. Of course, if this thread does conclude that it
is OK the duty cycle of a disabled PWM to be retained for some drivers
and not others then I'd hope to see some WARN_ON()s added to the PWM
framework to help bring problems to the surface with all drivers.


Daniel.
