Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68E5719C386
	for <lists+linux-pwm@lfdr.de>; Thu,  2 Apr 2020 16:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387919AbgDBOC1 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 2 Apr 2020 10:02:27 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:56621 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732694AbgDBOC1 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 2 Apr 2020 10:02:27 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1jK0QI-0000HP-9D; Thu, 02 Apr 2020 16:02:22 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1jK0QH-0002RZ-4J; Thu, 02 Apr 2020 16:02:21 +0200
Date:   Thu, 2 Apr 2020 16:02:21 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Lokesh Vutla <lokeshvutla@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        Sekhar Nori <nsekhar@ti.com>, Vignesh R <vigneshr@ti.com>,
        kernel@pengutronix.de
Subject: Re: [PATCH v3 4/5] pwm: omap-dmtimer: Do not disable pwm before
 changing period/duty_cycle
Message-ID: <20200402140221.bjbol77uegjma6oz@pengutronix.de>
References: <20200312042210.17344-1-lokeshvutla@ti.com>
 <20200312042210.17344-5-lokeshvutla@ti.com>
 <20200312064042.p7himm3odxjyzroi@pengutronix.de>
 <20200330141436.GG2431644@ulmo>
 <20200330191654.waoocllctanh5nk5@pengutronix.de>
 <20200331204559.GB2954599@ulmo>
 <20200401082227.sxtarbttsmmhs2of@pengutronix.de>
 <20200401182833.GB2978178@ulmo>
 <20200401203156.d7x5ynnnhob3jyoo@pengutronix.de>
 <20200401213738.GA3052587@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200401213738.GA3052587@ulmo>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello Thierry,

On Wed, Apr 01, 2020 at 11:37:38PM +0200, Thierry Reding wrote:
> On Wed, Apr 01, 2020 at 10:31:56PM +0200, Uwe Kleine-König wrote:
> > There are people out there that are more demanding. If you have 1000000
> > machines in the field and only then find out that they all fail to
> > operate correctly with a certain small but positive probability and you
> > have to send someone to each machine to fix that, that's bad.
> 
> Agreed. But that's not really what we're talking about here, right? This
> isn't some undefined behaviour that would spontaneously trigger.
> We're still talking about deterministic behaviour that's going to be
> the same whether you do it once in a test lab or a million times in
> the field. A PWM-controlled backlight that you adjust the brightness
> of in the lab is going to work the same way as in the field. Any
> potential glitch would be happening in the lab as well. It would in
> fact, constantly happen.

The glitch we're talking about really doesn't happen that often that we
should rely on this problem popping up during testing. To change both
period and duty_cycle two register writes are necessary. The hickup only
happens if after the first register write a period ends before the
second register write hits the hardware. (For the omap driver it might
happen a bit more often, don't remember the details, but I think the
above is what could be reached theoretically.)

> For the rare cases where you can't fake it, it doesn't really matter
> whether the framework refuses to do something because it knows that the
> hardware isn't capable of doing it, or whether the driver will simply
> try its best to do what it was asked to do and fails to deliver. You'll
> notice one way or another and then you need to go back to the drawing
> board and redo the design.

I think you didn't understand up to now that the glitch depends on
timing between register access and the PWM period and so is really hard
to actually reproduce. In the hope you understood that now, I assume you
see that your argumentation is incomplete.

And I think to assume that somebody would complain about a race
condition in a patch that just hit next is quite optimistic.

Having said that I don't know how critical this really is. Given that
the PWM under discussion doesn't complete periods on stop, it probably
isn't.

I spend some time thinking about when the glitch actually happens.
Currently the load value is written first and then the match value.
If no period ends between the two writes there is only a problem when in
the currently running period the match event didn't happen yet. Then we
see a cycle with

   .period = oldperiod + newperiod
   .dutycycle = oldperiod + newdutycycle

(if the new match value isn't hit in the current cycle) or one with

   .period = oldperiod
   .duty_cycle = newdutycycle + (oldperiod - newperiod)

(if the new match value is hit in the current cycle). The probability
that one of the two happen is: olddutycycle / oldperiod which is quite
probable. (With olddutycycle = oldperiod there is no problem though.)

If after writing the new load value and before writing the new match
value a period ends it might happen that we see a cycle with

  .period = newperiod
  .dutycycle = olddutycycle + (newperiod - oldperiod)

(if the previous match value is used) or one with

  .period = 2 * newperiod
  .dutycycle = newperiod + newdutycycle

(if new match value is written too late for the first cycle with the new
period).

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
