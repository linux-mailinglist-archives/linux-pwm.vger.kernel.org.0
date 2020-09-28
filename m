Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 603AC27AB34
	for <lists+linux-pwm@lfdr.de>; Mon, 28 Sep 2020 11:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbgI1Jwj (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 28 Sep 2020 05:52:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbgI1Jwi (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 28 Sep 2020 05:52:38 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 796F7C0613CE
        for <linux-pwm@vger.kernel.org>; Mon, 28 Sep 2020 02:52:38 -0700 (PDT)
Received: from dude02.hi.pengutronix.de ([2001:67c:670:100:1d::28])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1kMppg-0000wx-6b; Mon, 28 Sep 2020 11:52:32 +0200
Received: from mfe by dude02.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1kMppe-0000th-Ne; Mon, 28 Sep 2020 11:52:30 +0200
Date:   Mon, 28 Sep 2020 11:52:30 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     thierry.reding@gmail.com, lee.jones@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, Anson.Huang@nxp.com, michal.vokac@ysoft.com,
        l.majewski@majess.pl, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
Subject: Re: [PATCH v2 4/5] pwm: imx27: fix disable state for inverted PWMs
Message-ID: <20200928095230.GU29466@pengutronix.de>
References: <20200925155330.32301-1-m.felsch@pengutronix.de>
 <20200925155330.32301-5-m.felsch@pengutronix.de>
 <20200928074736.l63eecosjbyrcewe@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200928074736.l63eecosjbyrcewe@pengutronix.de>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 11:30:09 up 219 days, 20:47, 252 users,  load average: 0.27, 0.60,
 0.41
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::28
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 20-09-28 09:47, Uwe Kleine-K�nig wrote:
> Hello,
> 
> On Fri, Sep 25, 2020 at 05:53:29PM +0200, Marco Felsch wrote:
> > Up to now disabling the PWM is done using the PWMCR.EN register bit.
> > Setting this bit to zero results in the output pin driving a low value
> > independent of the polarity setting (PWMCR.POUTC).
> > 
> > There is only little documentation about expectations and requirements
> > in the PWM framework but the usual expectation seems to be that
> > disabling a PWM together with setting .duty_cycle = 0 results in the
> > output driving the inactive level. The pwm-bl driver for example uses
> > this setting to disable the backlight and with the pwm-imx27 driver
> > this results in an enabled backlight if the pwm signal is inverted.
> 
> This sounds as if the pwm-imx27 behaviour is a reason to believe that
> .duty_cycle = 0 + .enabled = false should drive the inactive level.

That was what you suggested in v1.

> I'd write:
> 	The pwm-bl driver for example uses this setting to disable the
> 	backlight. Up to now however, this request makes the pwm-imx27
> 	enable the backlight if the PWM signal is inverted.

I don't wanna but a specific user (pwm-bl driver) into the commit
message since this assumes that this fix is only needed because
of the pwm-bl driver.

> > Keep the PWMCR.EN bit always enabled and simulate a disabled PWM using
> > duty_cycle = 0 to fix this. Furthermore we have to drop the sw-reset
> > from apply() otherwise the PWMCR.EN is cleared too. Therefore the
> > pwm_imx27_wait_fifo_slot() is extended and renamed to guarantee a free
> > FIFO slot and to reflect the new meaning.
> > 
> > Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> > ---
> > v2:
> > - fix driver remove function
> > - rename pwm_imx27_wait_fifo_slot
> > - pwm_imx27_get_fifo_slot now returns the number of used fifo slots
> >   rather than 0 on success (needed for next patch).
> > 
> >  drivers/pwm/pwm-imx27.c | 78 ++++++++++++++++++++++++++---------------
> >  1 file changed, 49 insertions(+), 29 deletions(-)
> > 
> > diff --git a/drivers/pwm/pwm-imx27.c b/drivers/pwm/pwm-imx27.c
> > index 3b6bcd8d58b7..07c6a263a39c 100644
> > --- a/drivers/pwm/pwm-imx27.c
> > +++ b/drivers/pwm/pwm-imx27.c
> > @@ -141,12 +141,9 @@ static void pwm_imx27_get_state(struct pwm_chip *chip,
> >  	if (ret < 0)
> >  		return;
> >  
> > -	val = readl(imx->mmio_base + MX3_PWMCR);
> > +	state->enabled = imx->enabled;
> >  
> > -	if (val & MX3_PWMCR_EN)
> > -		state->enabled = true;
> > -	else
> > -		state->enabled = false;
> > +	val = readl(imx->mmio_base + MX3_PWMCR);
> 
> I'm not a big fan. IMHO the driver should report about reality and the
> framework (and maybe the consumers) should be able to handle that
> .get_state() reports
> 
> 	.enabled = true
> 	.duty_cycle = 0
> 
> after
> 
> 	.enabled = false
> 
> was requested.

So your suggestions will spam the pwm user with the ugly details?
IMHO the framework should abstract this since it is a nasty HW detail
the pwm user should not take care off.

> >  	switch (FIELD_GET(MX3_PWMCR_POUTC, val)) {
> >  	case MX3_PWMCR_POUTC_NORMAL:
> > @@ -169,8 +166,8 @@ static void pwm_imx27_get_state(struct pwm_chip *chip,
> >  	state->period = DIV_ROUND_UP_ULL(tmp, pwm_clk);
> >  
> >  	/*
> > -	 * PWMSAR can be read only if PWM is enabled. If the PWM is disabled,
> > -	 * use the cached value.
> > +	 * Use the cached value if the PWM is disabled since we are using the
> > +	 * PWMSAR to disable the PWM (see the notes in pwm_imx27_apply())
> >  	 */
> >  	if (state->enabled)
> >  		val = readl(imx->mmio_base + MX3_PWMSAR);
> > @@ -199,8 +196,8 @@ static void pwm_imx27_sw_reset(struct pwm_imx27_chip *imx, struct device *dev)
> >  		dev_warn(dev, "software reset timeout\n");
> >  }
> >  
> > -static void pwm_imx27_wait_fifo_slot(struct pwm_chip *chip,
> > -				     struct pwm_device *pwm)
> > +static int pwm_imx27_get_fifo_slot(struct pwm_chip *chip,
> > +				   struct pwm_device *pwm)
> >  {
> >  	struct pwm_imx27_chip *imx = to_pwm_imx27_chip(chip);
> >  	struct device *dev = chip->dev;
> > @@ -216,9 +213,13 @@ static void pwm_imx27_wait_fifo_slot(struct pwm_chip *chip,
> >  		msleep(period_ms);
> >  
> >  		sr = readl(imx->mmio_base + MX3_PWMSR);
> > -		if (fifoav == FIELD_GET(MX3_PWMSR_FIFOAV, sr))
> > +		if (fifoav == FIELD_GET(MX3_PWMSR_FIFOAV, sr)) {
> >  			dev_warn(dev, "there is no free FIFO slot\n");
> > +			return -EBUSY;
> > +		}
> >  	}
> > +
> > +	return fifoav;
> >  }
> >  
> >  static int pwm_imx27_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> > @@ -257,16 +258,25 @@ static int pwm_imx27_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> >  	else
> >  		period_cycles = 0;
> >  
> > +	/* Wait for a free FIFO slot */
> > +	ret = pwm_imx27_get_fifo_slot(chip, pwm);
> > +	if (ret < 0)
> > +		goto out;
> > +
> >  	/*
> > -	 * Wait for a free FIFO slot if the PWM is already enabled, and flush
> > -	 * the FIFO if the PWM was disabled and is about to be enabled.
> > +	 * We can't use the enable bit to control the en-/disable squence
> > +	 * correctly because the output pin is pulled low if setting this bit
> > +	 * to '0' regardless of the poutc value. Instead we have to use the
> > +	 * sample register. According the RM:
> 
> According to the reference manual:

K.

> > +	 * A value of zero in the sample register will result in the PWMO output
> > +	 * signal always being low/high (POUTC = 00 it will be low and
> > +	 * POUTC = 01 it will be high), and no output waveform will be produced.
> > +	 * If the value in this register is higher than the PERIOD
> 
> Did you forget to insert the end of this sentence here?

Ups, thanks for covering that.

> 
> >  	 */
> > -	if (imx->enabled)
> > -		pwm_imx27_wait_fifo_slot(chip, pwm);
> > +	if (state->enabled)
> > +		writel(duty_cycles, imx->mmio_base + MX3_PWMSAR);
> >  	else
> > -		pwm_imx27_sw_reset(imx, chip->dev);
> > -
> > -	writel(duty_cycles, imx->mmio_base + MX3_PWMSAR);
> > +		writel(0, imx->mmio_base + MX3_PWMSAR);
> >  	writel(period_cycles, imx->mmio_base + MX3_PWMPR);
> 
> I think you can simplify the code a bit using the following idiom:
> 
> 	/* 
> 	 * comment as above
> 	 */
> 	
> 	if (!state->enabled)
> 		duty_cycle = 0;
> 
> 	writel(duty_cycles, imx->mmio_base + MX3_PWMSAR);

I don't think so because this will throw aways the duty_cycle. What
should happen if the user disable the pwm by: state->enable = false and
enable it later again e.g. if you configure the pwm from the sysfs?
My assumption is that the previouse set duty-cycle should be applied
which isn't possible with your solution.

> With the change from the next patch I could also imagine to write a
> smaller period in the !enabled case. The upside would be that the second
> call in:
> 
> 	pwm_apply(mypwm, { .enabled = false, .period = 3s });
> 	pwm_apply(mypwm, { .enabled = true, ... });
> 
> wouldn't take longer than a second in the average case.

Sorry I don't get this.

> @Thierry, we really need to agree on the expected behaviour in these
> cases and document them.

+1

> >  	/*
> > @@ -276,15 +286,10 @@ static int pwm_imx27_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> >  	imx->duty_cycle = duty_cycles;
> >  
> >  	cr = MX3_PWMCR_PRESCALER_SET(prescale);
> > -
> >  	if (state->polarity == PWM_POLARITY_INVERSED)
> > -		cr |= FIELD_PREP(MX3_PWMCR_POUTC,
> > -				MX3_PWMCR_POUTC_INVERTED);
> > -
> > -	if (state->enabled)
> > -		cr |= MX3_PWMCR_EN;
> > +		cr |= FIELD_PREP(MX3_PWMCR_POUTC, MX3_PWMCR_POUTC_INVERTED);
> >  
> > -	mask = MX3_PWMCR_PRESCALER | MX3_PWMCR_POUTC | MX3_PWMCR_EN;
> > +	mask = MX3_PWMCR_PRESCALER | MX3_PWMCR_POUTC;
> >  
> >  	pwm_imx27_update_bits(imx->mmio_base + MX3_PWMCR, mask, cr);
> >  
> > @@ -373,10 +378,13 @@ static int pwm_imx27_probe(struct platform_device *pdev)
> >  	if (!(pwmcr & MX3_PWMCR_EN)) {
> >  		pwm_imx27_sw_reset(imx, &pdev->dev);
> >  		mask = MX3_PWMCR_STOPEN | MX3_PWMCR_DOZEN | MX3_PWMCR_WAITEN |
> > -		       MX3_PWMCR_DBGEN | MX3_PWMCR_CLKSRC;
> > +		       MX3_PWMCR_DBGEN | MX3_PWMCR_CLKSRC | MX3_PWMCR_POUTC |
> > +		       MX3_PWMCR_EN;
> >  		pwmcr = MX3_PWMCR_STOPEN | MX3_PWMCR_DOZEN | MX3_PWMCR_WAITEN |
> >  			MX3_PWMCR_DBGEN |
> > -			FIELD_PREP(MX3_PWMCR_CLKSRC, MX3_PWMCR_CLKSRC_IPG_HIGH);
> > +			FIELD_PREP(MX3_PWMCR_CLKSRC, MX3_PWMCR_CLKSRC_IPG_HIGH) |
> > +			FIELD_PREP(MX3_PWMCR_POUTC, MX3_PWMCR_POUTC_OFF) |
> > +			MX3_PWMCR_EN;
> >  		pwm_imx27_update_bits(imx->mmio_base + MX3_PWMCR, mask, pwmcr);
> >  		pwm_imx27_clk_disable_unprepare(imx);
> >  	} else {
> > @@ -385,6 +393,7 @@ static int pwm_imx27_probe(struct platform_device *pdev)
> >  		pwmcr = MX3_PWMCR_STOPEN | MX3_PWMCR_DOZEN | MX3_PWMCR_WAITEN |
> >  			MX3_PWMCR_DBGEN;
> >  		pwm_imx27_update_bits(imx->mmio_base + MX3_PWMCR, mask, pwmcr);
> > +		imx->enabled = true;
> >  	}
> >  
> >  	return pwmchip_add(&imx->chip);
> > @@ -392,11 +401,22 @@ static int pwm_imx27_probe(struct platform_device *pdev)
> >  
> >  static int pwm_imx27_remove(struct platform_device *pdev)
> >  {
> > -	struct pwm_imx27_chip *imx;
> > +	struct pwm_imx27_chip *imx = platform_get_drvdata(pdev);
> > +	int ret;
> >  
> > -	imx = platform_get_drvdata(pdev);
> > +	ret = pwm_imx27_clk_prepare_enable(imx);
> > +	if (ret)
> > +		return ret;
> >  
> > -	return pwmchip_remove(&imx->chip);
> > +	ret = pwmchip_remove(&imx->chip);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/* Ensure module is disabled after remove */
> > +	pwm_imx27_update_bits(imx->mmio_base + MX3_PWMCR, MX3_PWMCR_EN, 0);
> > +	pwm_imx27_clk_disable_unprepare(imx);
> 
> This is wrong. You are supposed to assume the PWM is already off in
> .remove and don't touch it.

Nope it isn't. The hardware is still running after the remove call since
we don't enable/disable the HW anymore by toggling the PWMCR.EN bit. So
we need to do it here.

Regards,
  Marco

> 
> Best regards
> Uwe
> 
> -- 
> Pengutronix e.K.                           | Uwe Kleine-K�nig            |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ |



-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
