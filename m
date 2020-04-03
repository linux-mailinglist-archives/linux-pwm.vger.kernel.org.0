Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38AAE19D84C
	for <lists+linux-pwm@lfdr.de>; Fri,  3 Apr 2020 15:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728213AbgDCN7p (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 3 Apr 2020 09:59:45 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:36167 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390990AbgDCN7p (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 3 Apr 2020 09:59:45 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1jKMrE-0005V1-3h; Fri, 03 Apr 2020 15:59:40 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1jKMrD-000573-17; Fri, 03 Apr 2020 15:59:39 +0200
Date:   Fri, 3 Apr 2020 15:59:38 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Lokesh Vutla <lokeshvutla@ti.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        Sekhar Nori <nsekhar@ti.com>, Vignesh R <vigneshr@ti.com>,
        kernel@pengutronix.de
Subject: Re: [PATCH v3 4/5] pwm: omap-dmtimer: Do not disable pwm before
 changing period/duty_cycle
Message-ID: <20200403135938.qmrvhclm6evfibqj@pengutronix.de>
References: <20200312064042.p7himm3odxjyzroi@pengutronix.de>
 <20200330141436.GG2431644@ulmo>
 <20200330191654.waoocllctanh5nk5@pengutronix.de>
 <20200331204559.GB2954599@ulmo>
 <20200401082227.sxtarbttsmmhs2of@pengutronix.de>
 <20200401182833.GB2978178@ulmo>
 <20200401203156.d7x5ynnnhob3jyoo@pengutronix.de>
 <20200401213738.GA3052587@ulmo>
 <20200402140221.bjbol77uegjma6oz@pengutronix.de>
 <5dbdbc15-ff29-f577-0632-6a28378b0104@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5dbdbc15-ff29-f577-0632-6a28378b0104@ti.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello,

On Fri, Apr 03, 2020 at 02:21:38PM +0530, Lokesh Vutla wrote:
> On 02/04/20 7:32 PM, Uwe Kleine-König wrote:
> > Having said that I don't know how critical this really is. Given that
> > the PWM under discussion doesn't complete periods on stop, it probably
> > isn't.
> 
> It is a limitation with the existing driver as well. Nothing is being changed
> regarding stopping of PWM. The same is marked under the limitations in the driver.

What I wrote was ambiguous and I think you understood the meaning I
didn't intend. What I wanted to say is: Given that the PWM stops
abruptly there is only little (if any at all) advantage of
"stop-to-update" over "racy-atomic-update" as we see broken cycles no
matter which alternative we pick.

> > I spend some time thinking about when the glitch actually happens.
> > Currently the load value is written first and then the match value.
> > If no period ends between the two writes there is only a problem when in
> > the currently running period the match event didn't happen yet. Then we
> > see a cycle with
> > 
> >    .period = oldperiod + newperiod
> >    .dutycycle = oldperiod + newdutycycle
> > 
> > (if the new match value isn't hit in the current cycle) or one with
> > 
> >    .period = oldperiod
> >    .duty_cycle = newdutycycle + (oldperiod - newperiod)
> > 
> > (if the new match value is hit in the current cycle). The probability
> > that one of the two happen is: olddutycycle / oldperiod which is quite
> > probable. (With olddutycycle = oldperiod there is no problem though.)
> > 
> > If after writing the new load value and before writing the new match
> > value a period ends it might happen that we see a cycle with
> > 
> >   .period = newperiod
> >   .dutycycle = olddutycycle + (newperiod - oldperiod)
> > 
> > (if the previous match value is used) or one with
> > 
> >   .period = 2 * newperiod
> >   .dutycycle = newperiod + newdutycycle
> > 
> > (if new match value is written too late for the first cycle with the new
> > period).
> 
> That's exactly why we have marked in the Limitations sections that the current
> period might produce a cycle with mixed settings.  Frankly, I'm a bit torn here.
> There are other PWMs inside Linux with  similar limitations and documented
> similarly. If there is an overall objection for such hardware, the entire policy
> should be changed or the framework should be updated to allow user to choose for
> dynamic updates. IMHO, this series should not be blocked for this decision.

Yes, there are other drivers that have similar "problems" and the status
quo is that depending on the driver author one or the other workaround
is chosen. I think the PWM framework would benefit if there were a
common guideline which path to choose in such a situation.

> Please consider it for the coming merge window.

It's already in next, so I assume it will be merged.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
