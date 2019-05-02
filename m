Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2652F11385
	for <lists+linux-pwm@lfdr.de>; Thu,  2 May 2019 08:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725772AbfEBGsS (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 2 May 2019 02:48:18 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:32917 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbfEBGsS (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 2 May 2019 02:48:18 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1hM5Vu-0007Ur-4B; Thu, 02 May 2019 08:48:14 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1hM5Vr-0007UN-Na; Thu, 02 May 2019 08:48:11 +0200
Date:   Thu, 2 May 2019 08:48:11 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Brian Norris <briannorris@chromium.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        linux-pwm <linux-pwm@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        kernel@pengutronix.de,
        Boris Brezillon <boris.brezillon@collabora.com>
Subject: Re: [PATCH v2 1/3] pwm: rockchip: Don't update the state for the
 caller of pwm_apply_state()
Message-ID: <20190502064811.p7hbsf5rxu2lrmmf@pengutronix.de>
References: <20190312214605.10223-1-u.kleine-koenig@pengutronix.de>
 <20190312214605.10223-2-u.kleine-koenig@pengutronix.de>
 <1707507.TOMHpQGrZ7@phil>
 <CAD=FV=WZHouhGcxOgNG3006XajJQaAp0uq9WjeKRikQx1ru4TA@mail.gmail.com>
 <20190408143914.uucb5dwafq3cnsmk@pengutronix.de>
 <CA+ASDXO=szekU97iTDK9vqWjT+JtAKeCNTyoY=8aSi5d+v4mkA@mail.gmail.com>
 <20190429065613.n52uwgys5eugmssd@pengutronix.de>
 <CAD=FV=U71u39ZHkBBfAXVAP=_hY-bAw3L7JdhC=36jkUVxPOmQ@mail.gmail.com>
 <20190430092824.ijtq3gfh6mqujvnk@pengutronix.de>
 <CAD=FV=WUi0NbsRDJA_4WeC62QYXjLNH2OygU1FOCx==W0SyqpQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=WUi0NbsRDJA_4WeC62QYXjLNH2OygU1FOCx==W0SyqpQ@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello Doug,

On Tue, Apr 30, 2019 at 07:38:09AM -0700, Doug Anderson wrote:
> On Tue, Apr 30, 2019 at 2:28 AM Uwe Kleine-König
> <u.kleine-koenig@pengutronix.de> wrote:
> >
> > > > Also it should be possible to know the result before actually
> > > > configuring the hardware. Otherwise things might already go wrong
> > > > because the driver implements a setting that is too far from the
> > > > requested configuration.
> > >
> > > Later in this thread Thierry didn't like the "round rate" idea due to
> > > races.  One way to solve that could be to indicate to the PWM
> > > framework which direction you'd like it to error in: a higher duty
> > > cycle or a lower one.
> >
> > I don't think this would result in settings as optimal as with my
> > suggestion. If you don't agree and want to convince me: Show how your
> > suggestion would work with a PWM that can implement only multiples of 3
> > for duty_cycle and period and you want 20% duty cycle with period <= 1
> > ms (without making use of the knowledge about the limitation of the
> > PWM in the algorithm).
> 
> I guess I was assuming that somehow this would percolate down into an
> API call that the PWM driver would implement, so you could make use of
> the PWM knowledge in the algorithm.

As there are so many different possibilities what could be "best" for a
consumer use case, I believe that it would end in a maintenance
mess if each lowlevel driver would need a callback to implement each
rounding strategy.
 
> ...but I don't have any real strong feelings about this API so I'll
> leave it to you and Thierry to hash out what makes you both happy.

I look forward to us two agreeing on a best approach ... :-)

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
