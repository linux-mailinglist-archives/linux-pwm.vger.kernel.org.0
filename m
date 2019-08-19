Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6BB91CAD
	for <lists+linux-pwm@lfdr.de>; Mon, 19 Aug 2019 07:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbfHSFqf (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 19 Aug 2019 01:46:35 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:34043 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbfHSFqf (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 19 Aug 2019 01:46:35 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1hzaUx-0002T6-GH; Mon, 19 Aug 2019 07:46:31 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1hzaUu-0004xO-7b; Mon, 19 Aug 2019 07:46:28 +0200
Date:   Mon, 19 Aug 2019 07:46:28 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
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
Message-ID: <20190819054628.asw3cxp46w3rpml7@pengutronix.de>
References: <20190709190007.91260-1-mka@chromium.org>
 <20190709190007.91260-3-mka@chromium.org>
 <20190816165148.7keg45fmlndr22fl@pengutronix.de>
 <20190816175157.GT250418@google.com>
 <20190816194754.ldzjqy2yjonfvaat@pengutronix.de>
 <20190816211051.GV250418@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190816211051.GV250418@google.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello Matthias,

On Fri, Aug 16, 2019 at 02:10:51PM -0700, Matthias Kaehlcke wrote:
> On Fri, Aug 16, 2019 at 09:47:54PM +0200, Uwe Kleine-König wrote:
> > On Fri, Aug 16, 2019 at 10:51:57AM -0700, Matthias Kaehlcke wrote:
> > > Hi Uwe,
> > > 
> > > On Fri, Aug 16, 2019 at 06:51:48PM +0200, Uwe Kleine-König wrote:
> > > > On Tue, Jul 09, 2019 at 12:00:05PM -0700, Matthias Kaehlcke wrote:
> > > > > Backlight brightness curves can have different shapes. The two main
> > > > > types are linear and non-linear curves. The human eye doesn't
> > > > > perceive linearly increasing/decreasing brightness as linear (see
> > > > > also 88ba95bedb79 "backlight: pwm_bl: Compute brightness of LED
> > > > > linearly to human eye"), hence many backlights use non-linear (often
> > > > > logarithmic) brightness curves. The type of curve currently is opaque
> > > > > to userspace, so userspace often uses more or less reliable heuristics
> > > > > (like the number of brightness levels) to decide whether to treat a
> > > > > backlight device as linear or non-linear.
> > > > > 
> > > > > Export the type of the brightness curve via the new sysfs attribute
> > > > > 'scale'. The value of the attribute can be 'linear', 'non-linear' or
> > > > > 'unknown'. For devices that don't provide information about the scale
> > > > > of their brightness curve the value of the 'scale' attribute is 'unknown'.
> > > > > 
> > > > > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > > > 
> > > > I wonder what kind of problem you are solving here. Can you describe
> > > > that in a few words?
> > > 
> > > The human eye perceives brightness in a logarithmic manner. For
> > > backlights with a linear brightness curve brightness controls like
> > > sliders need to use a mapping to achieve a behavior that is perceived
> > > as linear-ish (more details: http://www.pathwaylighting.com/products/downloads/brochure/technical_materials_1466797044_Linear+vs+Logarithmic+Dimming+White+Paper.pdf)
> > > 
> > > As of now userspace doesn't have information about the type of the
> > > brightness curve, and often uses heuristics to make a guess, which may
> > > be right most of the time, but not always. The new attribute eliminates
> > > the need to guess.
> > 
> > This is about backlights right? So the kernel provides to userspace an
> > interval [0, x] for some x and depending on the physics of the the
> > backlight configuring x/2 (probably?) either means 50% measured light or
> > 50% perceived light, right?
> 
> correct
> 
> > I wonder if it would be possible instead of giving different backlight
> > implementations the freedom to use either linear or logarithmic (or
> > quadratic?) scaling and tell userspace which of the options were picked
> > require the drivers to provide a (say) linear scaling and then userspace
> > wouldn't need to care about the exact physics.
> 
> In an ideal world the backlight interface would be consistent as you
> suggest, however there are plenty of existing devices which use the
> 'other' scaling (regardless of which is chosen as the 'correct'
> one). Userspace still has to deal with these. And changing previously
> 'logarithmic' drivers to linear (or viceversa) may 'break' userspace,
> when it keeps using its 'old' scaling, which now isn't correct anymore.

It might be subjective, or maybe I'm just too optimistic, but I think if
there was no policy before about the meaning of

	echo 17 > brightness

other than "brighter than lower values and darker than higher ones"
introducing (say) the scale is intended to represent a linear brightness
curve is ok.

Unless userspace jumps through hoops and tries to identify the actual
device it is running on it is wrong on some machines anyhow and we're
only shifting the set of affected machines with a tighter policy (until
that userspace application is fixed).

And the big upside is that in the end (i.e. when all kernel drivers and
userspace applications are adapted to provide/consume the "correct"
curve) the result is simpler.

Just my 0.02€
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
