Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2CE116B9ED
	for <lists+linux-pwm@lfdr.de>; Tue, 25 Feb 2020 07:43:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbgBYGnv (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 25 Feb 2020 01:43:51 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:50551 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729099AbgBYGnv (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 25 Feb 2020 01:43:51 -0500
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1j6Twa-0006m6-5S; Tue, 25 Feb 2020 07:43:48 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1j6TwY-0006WO-W1; Tue, 25 Feb 2020 07:43:46 +0100
Date:   Tue, 25 Feb 2020 07:43:46 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Lokesh Vutla <lokeshvutla@ti.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH 1/4] pwm: omap-dmtimer: Drop unused header file
Message-ID: <20200225064346.xj5gejuvu76riou2@pengutronix.de>
References: <20200224052135.17278-1-lokeshvutla@ti.com>
 <20200224052135.17278-2-lokeshvutla@ti.com>
 <20200224075302.jd3vcrdl6fuqrkpb@pengutronix.de>
 <ca33326e-22c8-e57b-c5fe-900f4749e640@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ca33326e-22c8-e57b-c5fe-900f4749e640@ti.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, Feb 25, 2020 at 10:32:04AM +0530, Lokesh Vutla wrote:
> Hi Uwe,
> 
> On 24/02/20 1:23 PM, Uwe Kleine-König wrote:
> > Hello,
> > 
> > On Mon, Feb 24, 2020 at 10:51:32AM +0530, Lokesh Vutla wrote:
> >> @@ -190,9 +190,8 @@ static int pwm_omap_dmtimer_config(struct pwm_chip *chip,
> >>  		load_value, load_value,	match_value, match_value);
> >>  
> >>  	omap->pdata->set_pwm(omap->dm_timer,
> >> -			      pwm_get_polarity(pwm) == PWM_POLARITY_INVERSED,
> >> -			      true,
> >> -			      PWM_OMAP_DMTIMER_TRIGGER_OVERFLOW_AND_COMPARE);
> >> +			     pwm_get_polarity(pwm) == PWM_POLARITY_INVERSED,
> >> +			     true, OMAP_TIMER_TRIGGER_OVERFLOW_AND_COMPARE);
> > 
> > This is unrelated.
> 
> PWM_OMAP_DMTIMER_TRIGGER_OVERFLOW_AND_COMPARE is deleted along with header file
> and used OMAP_TIMER_TRIGGER_OVERFLOW_AND_COMPARE. I should have mentioned this
> in my commit description. Will fix it in v2.

Ah, indeed I missed that the register name was changed in that hunk and
considered that an indention only change.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
