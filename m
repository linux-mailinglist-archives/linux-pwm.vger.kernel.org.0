Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E2F19236C
	for <lists+linux-pwm@lfdr.de>; Mon, 19 Aug 2019 14:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbfHSM3V (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 19 Aug 2019 08:29:21 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:40115 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726852AbfHSM3U (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 19 Aug 2019 08:29:20 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1hzgmj-0002vD-DX; Mon, 19 Aug 2019 14:29:17 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1hzgmh-0007dT-8g; Mon, 19 Aug 2019 14:29:15 +0200
Date:   Mon, 19 Aug 2019 14:29:15 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Daniel Thompson <daniel.thompson@linaro.org>
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
Message-ID: <20190819122915.icjszuvnwyjpa75n@pengutronix.de>
References: <20190709190007.91260-1-mka@chromium.org>
 <20190709190007.91260-3-mka@chromium.org>
 <20190816165148.7keg45fmlndr22fl@pengutronix.de>
 <20190816175157.GT250418@google.com>
 <20190816194754.ldzjqy2yjonfvaat@pengutronix.de>
 <20190816211051.GV250418@google.com>
 <20190819054628.asw3cxp46w3rpml7@pengutronix.de>
 <20190819095037.h3gig3quyhnzshm7@holly.lan>
 <20190819102127.wqudnbngottjakf5@pengutronix.de>
 <20190819111613.2kkn25tmjgyjhbip@holly.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190819111613.2kkn25tmjgyjhbip@holly.lan>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, Aug 19, 2019 at 12:16:13PM +0100, Daniel Thompson wrote:
> On Mon, Aug 19, 2019 at 12:21:27PM +0200, Uwe Kleine-König wrote:
> > > > > In an ideal world the backlight interface would be consistent as you
> > > > > suggest, however there are plenty of existing devices which use the
> > > > > 'other' scaling (regardless of which is chosen as the 'correct'
> > > > > one). Userspace still has to deal with these. And changing previously
> > > > > 'logarithmic' drivers to linear (or viceversa) may 'break' userspace,
> > > > > when it keeps using its 'old' scaling, which now isn't correct anymore.
> > > > 
> > > > It might be subjective, or maybe I'm just too optimistic, but I think if
> > > > there was no policy before about the meaning of
> > > > 
> > > > 	echo 17 > brightness
> > > > 
> > > > other than "brighter than lower values and darker than higher ones"
> > > > introducing (say) the scale is intended to represent a linear brightness
> > > > curve is ok.
> > > > 
> > > > Unless userspace jumps through hoops and tries to identify the actual
> > > > device it is running on it is wrong on some machines anyhow and we're
> > > > only shifting the set of affected machines with a tighter policy (until
> > > > that userspace application is fixed).
> > > 
> > > I believe that there are two common approaches by userspace at present:
> > > 
> > > 1. Assume the scale is perceptual and we can directly map a slider
> > >    to the backlight value. This is common simply because most ACPI
> > >    backlights are perceptual and therefore when tested in a laptop
> > >    it works OK.
> > > 
> > > 2. Assume that is max brightness is small (e.g. ACPI) then the
> > >    scale is perceptual and if the max brightness is large (e.g.
> > >    a PWM) then the scale is linear and apply a correction
> > >    function between the slider and the control.
> > > 
> > > That historic baggage makes is diffcult to "just define a standardized
> > > scale"... especially given that if we selected a standardized scale we
> > > would probably want a perceptual scale with lots of steps (e.g. break
> > > the heuristic).
> > 
> > With "perceptual" you mean that logarithmic stuff, right?
> 
> Human perception is fairly complex so it depends how strict you want to
> get. At the end of the day what it means is you can map a slider UI
> component directly to the backlight range and it will feel right. Thus
> a userspace that maps directly to a slider *is* assuming the scale
> is perceptual.

I have problems to declare something as "the right thing to do" that
depends on feeling of users. I much prefer to make a technical device
authoritative here (in this case a device that measures emitted light).

Other than that I don't have enough experience with backlights to judge
the decisions that have to be done and so will stop my participation in
this thread now.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
