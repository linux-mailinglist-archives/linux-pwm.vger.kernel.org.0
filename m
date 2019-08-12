Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC7789715
	for <lists+linux-pwm@lfdr.de>; Mon, 12 Aug 2019 08:15:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbfHLGPZ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 12 Aug 2019 02:15:25 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:56917 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbfHLGPZ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 12 Aug 2019 02:15:25 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1hx3c2-0003qC-1Z; Mon, 12 Aug 2019 08:15:22 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1hx3c0-0001Kz-CD; Mon, 12 Aug 2019 08:15:20 +0200
Date:   Mon, 12 Aug 2019 08:15:20 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Thierry Reding <thierry.reding@gmail.com>, od@zcrc.me,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mathieu Malaterre <malat@debian.org>,
        Artur Rojek <contact@artur-rojek.eu>
Subject: Re: [PATCH 4/7] pwm: jz4740: Improve algorithm of clock calculation
Message-ID: <20190812061520.lwzk3us4ginwwxov@pengutronix.de>
References: <20190809123031.24219-1-paul@crapouillou.net>
 <20190809123031.24219-5-paul@crapouillou.net>
 <20190809170551.u4ybilf5ay2rsvnn@pengutronix.de>
 <1565370885.2091.2@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1565370885.2091.2@crapouillou.net>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello Paul,

On Fri, Aug 09, 2019 at 07:14:45PM +0200, Paul Cercueil wrote:
> Le ven. 9 août 2019 à 19:05, Uwe =?iso-8859-1?q?Kleine-K=F6nig?=
> <u.kleine-koenig@pengutronix.de> a écrit :
> > On Fri, Aug 09, 2019 at 02:30:28PM +0200, Paul Cercueil wrote:
> > >  The previous algorithm hardcoded details about how the TCU clocks
> > > work.
> > >  The new algorithm will use clk_round_rate to find the perfect clock
> > > rate
> > >  for the PWM channel.
> > > 
> > >  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> > >  Tested-by: Mathieu Malaterre <malat@debian.org>
> > >  Tested-by: Artur Rojek <contact@artur-rojek.eu>
> > >  ---
> > >   drivers/pwm/pwm-jz4740.c | 60
> > > +++++++++++++++++++++++++++++-----------
> > >   1 file changed, 44 insertions(+), 16 deletions(-)
> > > 
> > >  diff --git a/drivers/pwm/pwm-jz4740.c b/drivers/pwm/pwm-jz4740.c
> > >  index 6ec8794d3b99..f20dc2e19240 100644
> > >  --- a/drivers/pwm/pwm-jz4740.c
> > >  +++ b/drivers/pwm/pwm-jz4740.c
> > >  @@ -110,24 +110,56 @@ static int jz4740_pwm_apply(struct pwm_chip
> > > *chip, struct pwm_device *pwm,
> > >   	struct jz4740_pwm_chip *jz4740 = to_jz4740(pwm->chip);
> > >   	struct clk *clk = pwm_get_chip_data(pwm),
> > >   		   *parent_clk = clk_get_parent(clk);
> > >  -	unsigned long rate, period, duty;
> > >  +	unsigned long rate, parent_rate, period, duty;
> > >   	unsigned long long tmp;
> > >  -	unsigned int prescaler = 0;
> > >  +	int ret;
> > > 
> > >  -	rate = clk_get_rate(parent_clk);
> > >  -	tmp = (unsigned long long)rate * state->period;
> > >  -	do_div(tmp, 1000000000);
> > >  -	period = tmp;
> > >  +	parent_rate = clk_get_rate(parent_clk);
> > >  +
> > >  +	jz4740_pwm_disable(chip, pwm);
> > > 
> > >  -	while (period > 0xffff && prescaler < 6) {
> > >  -		period >>= 2;
> > >  -		rate >>= 2;
> > >  -		++prescaler;
> > >  +	/* Reset the clock to the maximum rate, and we'll reduce it if needed */
> > >  +	ret = clk_set_max_rate(clk, parent_rate);
> > 
> > What is the purpose of this call? IIUC this limits the allowed range of
> > rates for clk. I assume the idea is to prevent other consumers to change
> > the rate in a way that makes it unsuitable for this pwm. But this only
> > makes sense if you had a notifier for clk changes, doesn't it? I'm
> > confused.
> 
> Nothing like that. The second call to clk_set_max_rate() might have set
> a maximum clock rate that's lower than the parent's rate, and we want to
> undo that.

I still don't get the purpose of this call. Why do you limit the clock
rate at all?

> > I think this doesn't match the commit log, you didn't even introduced a
> > call to clk_round_rate().
> 
> Right, I'll edit the commit message.
> 
> 
> > >  +	if (ret) {
> > >  +		dev_err(chip->dev, "Unable to set max rate: %d\n", ret);
> > >  +		return ret;
> > >   	}
> > > 
> > >  -	if (prescaler == 6)
> > >  -		return -EINVAL;
> > >  +	ret = clk_set_rate(clk, parent_rate);
> > >  +	if (ret) {
> > >  +		dev_err(chip->dev, "Unable to reset to parent rate (%lu Hz)",
> > >  +			parent_rate);
> > >  +		return ret;
> > >  +	}
> > >  +
> > >  +	/*
> > >  +	 * Limit the clock to a maximum rate that still gives us a period value
> > >  +	 * which fits in 16 bits.
> > >  +	 */
> > >  +	tmp = 0xffffull * NSEC_PER_SEC;
> > >  +	do_div(tmp, state->period);
> > > 
> > >  +	ret = clk_set_max_rate(clk, tmp);
> > 
> > And now you change the maximal rate again?
> 
> Basically, we start from the maximum clock rate we can get for that PWM
> - which is the rate of the parent clk - and from that compute the maximum
> clock rate that we can support that still gives us < 16-bits hardware
> values for the period and duty.
> 
> We then pass that computed maximum clock rate to clk_set_max_rate(), which
> may or may not update the current PWM clock's rate to match the new limits.
> Finally we read back the PWM clock's rate and compute the period and duty
> from that.

If you change the clk rate, is this externally visible on the PWM
output? Does this affect other PWM instances?

> > >  +	if (ret) {
> > >  +		dev_err(chip->dev, "Unable to set max rate: %d\n", ret);
> > >  +		return ret;
> > >  +	}
> > >  +
> > >  +	/*
> > >  +	 * Read back the clock rate, as it may have been modified by
> > >  +	 * clk_set_max_rate()
> > >  +	 */
> > >  +	rate = clk_get_rate(clk);
> > >  +
> > >  +	if (rate != parent_rate)
> > >  +		dev_dbg(chip->dev, "PWM clock updated to %lu Hz\n", rate);
> > >  +
> > >  +	/* Calculate period value */
> > >  +	tmp = (unsigned long long)rate * state->period;
> > >  +	do_div(tmp, NSEC_PER_SEC);
> > >  +	period = (unsigned long)tmp;
> > >  +
> > >  +	/* Calculate duty value */
> > >   	tmp = (unsigned long long)period * state->duty_cycle;
> > >   	do_div(tmp, state->period);
> > >   	duty = period - tmp;
> > >  @@ -135,14 +167,10 @@ static int jz4740_pwm_apply(struct pwm_chip
> > > *chip, struct pwm_device *pwm,
> > >   	if (duty >= period)
> > >   		duty = period - 1;
> > > 
> > >  -	jz4740_pwm_disable(chip, pwm);
> > >  -
> > >   	/* Set abrupt shutdown */
> > >   	regmap_update_bits(jz4740->map, TCU_REG_TCSRc(pwm->hwpwm),
> > >   			   TCU_TCSR_PWM_SD, TCU_TCSR_PWM_SD);
> > > 
> > >  -	clk_set_rate(clk, rate);
> > >  -
> > 
> > It's not obvious to me why removing these two lines belong in the
> > current patch.
> 
> They're not removed, they're both moved up in the function.

OK, will look closer in the next iteration.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
