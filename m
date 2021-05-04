Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC48D372D2B
	for <lists+linux-pwm@lfdr.de>; Tue,  4 May 2021 17:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbhEDPoD (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 4 May 2021 11:44:03 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:48860 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbhEDPoC (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 4 May 2021 11:44:02 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 878731C0B87; Tue,  4 May 2021 17:43:06 +0200 (CEST)
Date:   Tue, 4 May 2021 17:43:05 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Dan Murphy <dmurphy@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>,
        Lee Jones <lee.jones@linaro.org>,
        Martin Botka <martin.botka1@gmail.com>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH v6 2/4] leds: Add driver for Qualcomm LPG
Message-ID: <YJFridMwwMV1K98m@mobian>
References: <20201021201224.3430546-1-bjorn.andersson@linaro.org>
 <20201021201224.3430546-3-bjorn.andersson@linaro.org>
 <20201029181357.GE26053@duo.ucw.cz>
 <YIn50NW+Pimqfsih@builder.lan>
 <20210429211223.GA5480@amd>
 <20210429212920.GB2484@yoga>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210429212920.GB2484@yoga>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi!

> > > One such example is the laptop in front of me, which has 3 channels
> > > wired to an RGB LED and 1 channel wired as a backlight control signal
> > > (i.e. using pwm-backlight).  Another example is a devboard where the
> > > 4 channels are wired to 4 LEDs.
> > 
> > Ok, so this is actually important. In this case you should have PWM
> > layer, exporting PWMs, and then rgb-LED driver that takes three of
> > those PWMs and turns them into LED, no?
> > 
> > And ... surprise ... that is likely to help other people, as LEDs
> > connected to PWMs are quite common.
> > 
> > Hmm.?
> > 
> > If you can't do this for some reason, you should probably explain in
> > the changelog, because this is going to be FAQ.
> > 
> 
> This is exactly what the downstream implementation does and in the case
> of a solid color LED this works fine.
> 
> But the hardware has a shared chunk of memory where you can write
> duty-cycle values, then for each PWM channel you can specify the
> start/stop index and pace for the PWM to read and update the configured
> duty-cycle. This is how the hardware implements pattern support.

Ok.

> So downstream they have (last time I looked at the code) an addition in
> the PWM API where the LED driver can inform the PWM driver part about
> the indices to use. Naturally I don't think that's a good idea.

Dunno. Is it bad idea?

pattern support for other PWMs (vibration?) seems useful, too. Yes, it
means more discussion and extending PWMs properly..

> Additionally, representing this as individual PWM channels means we're
> loosing the grouping that now comes from the description of multicolor
> LEDs, which serves the basis for synchronizing the pattern traversal
> between the involved channels.

Yes, keeping grouping would be nice, but perhaps pattern API for PWMs
can do that too?

You can have solid-color-only driver now, with patterns being added
as discussion with PWM people progresses...

Best regards,
									Pavel

-- 
