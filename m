Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 157CD171550
	for <lists+linux-pwm@lfdr.de>; Thu, 27 Feb 2020 11:52:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728743AbgB0Kwx (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 27 Feb 2020 05:52:53 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:36303 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728680AbgB0Kwx (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 27 Feb 2020 05:52:53 -0500
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1j7Gmg-0004u9-0P; Thu, 27 Feb 2020 11:52:50 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1j7Gma-0002Lt-3N; Thu, 27 Feb 2020 11:52:44 +0100
Date:   Thu, 27 Feb 2020 11:52:44 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Sam Shih <sam.shih@mediatek.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        John Crispin <john@phrozen.org>, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 1/1] pwm: mediatek: add longer period support
Message-ID: <20200227105244.orwitjst3wzoqcsq@pengutronix.de>
References: <1582789610-23133-1-git-send-email-sam.shih@mediatek.com>
 <1582789610-23133-2-git-send-email-sam.shih@mediatek.com>
 <20200227080450.rkvwfjx6vikn5ls3@pengutronix.de>
 <1582797590.25607.10.camel@mtksdccf07>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1582797590.25607.10.camel@mtksdccf07>
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

On Thu, Feb 27, 2020 at 05:59:50PM +0800, Sam Shih wrote:
> On Thu, 2020-02-27 at 09:04 +0100, Uwe Kleine-König wrote:
> On Thu, Feb 27, 2020 at 03:46:50PM +0800, Sam Shih wrote:
> > > The pwm clock source could be divided by 1625 with PWM_CON
> > > BIT(3) setting in mediatek hardware.
> > > 
> > > This patch add support for longer pwm period configuration,
> > > which allowing blinking LEDs via pwm interface.
> > > 
> > > Signed-off-by: Sam Shih <sam.shih@mediatek.com>
> > > ---
> > >  drivers/pwm/pwm-mediatek.c | 21 +++++++++++++++++----
> > >  1 file changed, 17 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
> > > index b94e0d09c300..9af309bea01a 100644
> > > --- a/drivers/pwm/pwm-mediatek.c
> > > +++ b/drivers/pwm/pwm-mediatek.c
> > > @@ -121,8 +121,8 @@ static int pwm_mediatek_config(struct pwm_chip
> *chip, struct pwm_device *pwm,
> > >  			       int duty_ns, int period_ns)
> > >  {
> > >  	struct pwm_mediatek_chip *pc = to_pwm_mediatek_chip(chip);
> > > -	u32 clkdiv = 0, cnt_period, cnt_duty, reg_width = PWMDWIDTH,
> > > -	    reg_thres = PWMTHRES;
> > > +	u32 clkdiv = 0, clksel = 0, cnt_period, cnt_duty,
> > > +	    reg_width = PWMDWIDTH, reg_thres = PWMTHRES;
> > >  	u64 resolution;
> > >  	int ret;
> > >  
> > Adding some more context:
> > 
> 
> + /* The pwm source clock can be divided by 2^clkdiv. When the clksel  +
> * bit is set to 1, The final clock output needs to be divided by an +  *
> extra 1625.
> +  */

I'd write:

The source clock is divided by 2^clkdiv or iff the clksel bit is set by
2^clkdiv + 1625.

> 
> Is this ok ?
> 
> 
> > > @@ -139,11 +139,20 @@ static int pwm_mediatek_config(struct pwm_chip
> *chip, struct pwm_device *pwm,
> > > 	while (cnt_period > 8191) {
> > >  		resolution *= 2;
> > >  		clkdiv++;
> > >  		cnt_period = DIV_ROUND_CLOSEST_ULL((u64)period_ns * 1000,
> > >  						   resolution);
> > > +		if (clkdiv > PWM_CLK_DIV_MAX && !clksel) {
> > > +			clksel = 1;
> > > +			clkdiv = 0;
> > > +			resolution = (u64)NSEC_PER_SEC * 1000 * 1625;
> > > +			do_div(resolution,
> > > +				clk_get_rate(pc->clk_pwms[pwm->hwpwm]));
> > > +			cnt_period = DIV_ROUND_CLOSEST_ULL(
> > > +					(u64)period_ns * 1000, resolution);
> > 
> > The assignment is a repetition from just above the if. Maybe just put
> it
> > once after this if block?
> 
> The cnt_period represents the effective range of the PWM period counter,
> when we need changing the pwm output period to a longer value at the
> same clock frequency, we can setting a larger cnt_period, but the width
> of the cnt_peroid register is 12 bits,
> When the request period is too long, we need to divide the clock source
> and then recalculate cnt_period outputs the correct waveform.
> As mentioned above, when changing clkdiv, we need to recalculate
> cnt_period immediately.
> 
> If the request period is very long (for example, LED blinking), clkdiv
> may be insufficient. 
> In this case, we will use clksel to divide the pwm source clock by an
> additional 1625, and recalculate clkdiv and cnt_period.
> 
> I don't think we can just place assignments after the if block.

I didn't care enough to read your reasoning and retry to convince you
with mine:

With your patch you have:

	cnt_period = someexpression;

	if (somecondition) {
		...
		cnt_period = someexpression;
	}

As somecondition doesn't make use of cnt_period this is equivalent to:

	if (somecondition) {
		...
	}
	cnt_period = someexpression;

isn't it?

> > The code is hard to follow, I wonder if this could be cleaned up with
> > some comments added that explain the hardware details enough to be able
> > to actually understand the code without having the hardware reference
> > manual handy.
> 
> Is it sufficient to add some context into comment like the response of
> the second question?

I didn't check but I wouldn't be surprised if the code is more
complicated than necessary. If you don't see something to simplify, go
for adding an explanation as suggested and I will take a look in a quiet
moment.

Not sure I already pointed out that having a link to a publicly
available reference manual in the driver's header is useful. If there is
such a manual, please add a link there. Your benefit is that you
simplify others to improve your driver.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
