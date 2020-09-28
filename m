Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B49FB27AB6A
	for <lists+linux-pwm@lfdr.de>; Mon, 28 Sep 2020 12:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbgI1KAH (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 28 Sep 2020 06:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726540AbgI1KAH (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 28 Sep 2020 06:00:07 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C3A1C061755
        for <linux-pwm@vger.kernel.org>; Mon, 28 Sep 2020 03:00:07 -0700 (PDT)
Received: from dude02.hi.pengutronix.de ([2001:67c:670:100:1d::28])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1kMpwu-0001ba-Pf; Mon, 28 Sep 2020 12:00:00 +0200
Received: from mfe by dude02.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1kMpwt-0002Tv-Nu; Mon, 28 Sep 2020 11:59:59 +0200
Date:   Mon, 28 Sep 2020 11:59:59 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     thierry.reding@gmail.com, lee.jones@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, Anson.Huang@nxp.com, michal.vokac@ysoft.com,
        l.majewski@majess.pl, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
Subject: Re: [PATCH v2 5/5] pwm: imx27: wait till the duty cycle is applied
Message-ID: <20200928095959.GV29466@pengutronix.de>
References: <20200925155330.32301-1-m.felsch@pengutronix.de>
 <20200925155330.32301-6-m.felsch@pengutronix.de>
 <20200928080425.ugyrgznw6o3kwdz5@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200928080425.ugyrgznw6o3kwdz5@pengutronix.de>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 11:53:49 up 219 days, 21:10, 254 users,  load average: 0.31, 0.16,
 0.18
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::28
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 20-09-28 10:04, Uwe Kleine-König wrote:
> On Fri, Sep 25, 2020 at 05:53:30PM +0200, Marco Felsch wrote:
> > Currently the driver don't check if the new state was applied or not.
> 
> s/don't/doesn't/
> 
> > This can cause glitches on the output pin if the new state disables the
> > PWM. In this case the PWM clocks are disabled before the new duty cycle
> > value gets applied.
> 
> Hmm, the problem that is addressed here is that .apply() might turn off
> the clock input for the counter before the inactive value is on the pin,
> right? So an alternative fix would be to not disable the clock, wouldn't
> it?

Yes, till the new state is applied.

> > The fix is to wait till the desired duty cycle was applied.
> > 
> > Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> > ---
> > v2:
> > - new patch
> > 
> >  drivers/pwm/pwm-imx27.c | 25 +++++++++++++++++++++++++
> >  1 file changed, 25 insertions(+)
> > 
> > diff --git a/drivers/pwm/pwm-imx27.c b/drivers/pwm/pwm-imx27.c
> > index 07c6a263a39c..ffa00bcd81da 100644
> > --- a/drivers/pwm/pwm-imx27.c
> > +++ b/drivers/pwm/pwm-imx27.c
> > @@ -222,6 +222,26 @@ static int pwm_imx27_get_fifo_slot(struct pwm_chip *chip,
> >  	return fifoav;
> >  }
> >  
> > +static int pwm_imx27_wait_till_applied(struct pwm_chip *chip,
> > +				       struct pwm_device *pwm)
> > +{
> > +	unsigned int attempts = 4;
> > +	unsigned int period_ms;
> > +	int busy_slots;
> > +
> > +	do {
> > +		busy_slots = pwm_imx27_get_fifo_slot(chip, pwm);
> > +		if (busy_slots == 0)
> > +			return 0;
> > +
> > +		period_ms = DIV_ROUND_UP(pwm_get_period(pwm),
> 
> I was glad you removed the call to pwm_get_state() from .apply(), now it is
> back in disguised form here :-\ 

I reused the code from pwm_imx27_get_fifo_slot().

> Also the value shouldn't change over the
> iteration of this loop, so determining it once should be enough.

Yes, you are right. I will change that.

> > +					 NSEC_PER_MSEC);
> > +		msleep(period_ms);
> > +	} while (attempts--);
> > +
> > +	return -ETIMEDOUT;
> > +}
> > +
> >  static int pwm_imx27_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> >  			   const struct pwm_state *state)
> >  {
> > @@ -277,6 +297,11 @@ static int pwm_imx27_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> >  		writel(duty_cycles, imx->mmio_base + MX3_PWMSAR);
> >  	else
> >  		writel(0, imx->mmio_base + MX3_PWMSAR);
> > +
> > +	ret = pwm_imx27_wait_till_applied(chip, pwm);
> > +	if (ret)
> > +		goto out;
> > +
> 
> The framework doesn't define (and this is a problem there) if .apply is
> supposed to sleep.

Current upstream driver sleeps as well if pwm_imx27_wait_fifo_slot()
waits. So this patch don't changes the bevhaviour.

Regards,
  Marco

> OTOH at least sun4i has a similar behaviour.
> Thierry, what is your thought on this?
> 
> Best regards
> Uwe
> 
> -- 
> Pengutronix e.K.                           | Uwe Kleine-König            |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ |



-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
