Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD3C927AABD
	for <lists+linux-pwm@lfdr.de>; Mon, 28 Sep 2020 11:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbgI1J35 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 28 Sep 2020 05:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbgI1J34 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 28 Sep 2020 05:29:56 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B77E0C061755
        for <linux-pwm@vger.kernel.org>; Mon, 28 Sep 2020 02:29:56 -0700 (PDT)
Received: from dude02.hi.pengutronix.de ([2001:67c:670:100:1d::28])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1kMpTi-0006e3-Ac; Mon, 28 Sep 2020 11:29:50 +0200
Received: from mfe by dude02.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1kMpTg-0005PS-V2; Mon, 28 Sep 2020 11:29:48 +0200
Date:   Mon, 28 Sep 2020 11:29:48 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     thierry.reding@gmail.com, lee.jones@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, Anson.Huang@nxp.com, michal.vokac@ysoft.com,
        l.majewski@majess.pl, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
Subject: Re: [PATCH v2 3/5] pwm: imx27: reset the PWM if it is not running
Message-ID: <20200928092948.GT29466@pengutronix.de>
References: <20200925155330.32301-1-m.felsch@pengutronix.de>
 <20200925155330.32301-4-m.felsch@pengutronix.de>
 <20200928073019.led4eyfl3emv6aau@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200928073019.led4eyfl3emv6aau@pengutronix.de>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 11:24:16 up 219 days, 20:41, 252 users,  load average: 1.11, 0.63,
 0.31
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::28
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 20-09-28 09:30, Uwe Kleine-König wrote:
> On Fri, Sep 25, 2020 at 05:53:28PM +0200, Marco Felsch wrote:
> > Trigger a software reset during probe to clear the FIFO and reset the
> > register values to their default. According the datasheet the DBGEN,
> > STOPEN, DOZEN and WAITEN bits should be untouched by the software reset
> > but this is not the case.
> > 
> > Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> > ---
> > v2:
> > - new patch
> > 
> >  drivers/pwm/pwm-imx27.c | 26 ++++++++++++++------------
> >  1 file changed, 14 insertions(+), 12 deletions(-)
> > 
> > diff --git a/drivers/pwm/pwm-imx27.c b/drivers/pwm/pwm-imx27.c
> > index b761764b8375..3b6bcd8d58b7 100644
> > --- a/drivers/pwm/pwm-imx27.c
> > +++ b/drivers/pwm/pwm-imx27.c
> > @@ -183,10 +183,8 @@ static void pwm_imx27_get_state(struct pwm_chip *chip,
> >  	pwm_imx27_clk_disable_unprepare(imx);
> >  }
> >  
> > -static void pwm_imx27_sw_reset(struct pwm_chip *chip)
> > +static void pwm_imx27_sw_reset(struct pwm_imx27_chip *imx, struct device *dev)
> >  {
> > -	struct pwm_imx27_chip *imx = to_pwm_imx27_chip(chip);
> > -	struct device *dev = chip->dev;
> >  	int wait_count = 0;
> >  	u32 cr;
> 
> This is an unrelated hunk that I don't expect to result in any changes
> in the code. If you consider it better this way, you should at least
> mention it in the commit log.

IMO this is required due to the usage from the probe. I'm not a fan of
passing the 'struct pwm_chip' before initializing it. So it is not
unrelated. I will mention it in v3.

> 
> > @@ -266,7 +264,7 @@ static int pwm_imx27_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> >  	if (imx->enabled)
> >  		pwm_imx27_wait_fifo_slot(chip, pwm);
> >  	else
> > -		pwm_imx27_sw_reset(chip);
> > +		pwm_imx27_sw_reset(imx, chip->dev);
> >  
> >  	writel(duty_cycles, imx->mmio_base + MX3_PWMSAR);
> >  	writel(period_cycles, imx->mmio_base + MX3_PWMPR);
> > @@ -370,19 +368,23 @@ static int pwm_imx27_probe(struct platform_device *pdev)
> >  	if (ret)
> >  		return ret;
> >  
> > -	mask = MX3_PWMCR_STOPEN | MX3_PWMCR_DOZEN | MX3_PWMCR_WAITEN |
> > -	       MX3_PWMCR_DBGEN;
> > -	pwmcr = MX3_PWMCR_STOPEN | MX3_PWMCR_DOZEN | MX3_PWMCR_WAITEN |
> > -		MX3_PWMCR_DBGEN;
> > -	pwm_imx27_update_bits(imx->mmio_base + MX3_PWMCR, mask, pwmcr);
> > -
> >  	/* keep clks on and clk settings unchanged if pwm is running */
> >  	pwmcr = readl(imx->mmio_base + MX3_PWMCR);
> >  	if (!(pwmcr & MX3_PWMCR_EN)) {
> > -		mask = MX3_PWMCR_CLKSRC;
> > -		pwmcr = FIELD_PREP(MX3_PWMCR_CLKSRC, MX3_PWMCR_CLKSRC_IPG_HIGH);
> > +		pwm_imx27_sw_reset(imx, &pdev->dev);
> > +		mask = MX3_PWMCR_STOPEN | MX3_PWMCR_DOZEN | MX3_PWMCR_WAITEN |
> > +		       MX3_PWMCR_DBGEN | MX3_PWMCR_CLKSRC;
> > +		pwmcr = MX3_PWMCR_STOPEN | MX3_PWMCR_DOZEN | MX3_PWMCR_WAITEN |
> > +			MX3_PWMCR_DBGEN |
> > +			FIELD_PREP(MX3_PWMCR_CLKSRC, MX3_PWMCR_CLKSRC_IPG_HIGH);
> >  		pwm_imx27_update_bits(imx->mmio_base + MX3_PWMCR, mask, pwmcr);
> >  		pwm_imx27_clk_disable_unprepare(imx);
> > +	} else {
> > +		mask = MX3_PWMCR_STOPEN | MX3_PWMCR_DOZEN | MX3_PWMCR_WAITEN |
> > +			MX3_PWMCR_DBGEN;
> > +		pwmcr = MX3_PWMCR_STOPEN | MX3_PWMCR_DOZEN | MX3_PWMCR_WAITEN |
> > +			MX3_PWMCR_DBGEN;
> > +		pwm_imx27_update_bits(imx->mmio_base + MX3_PWMCR, mask, pwmcr);
> >  	}
> 
> IMHO this is worse than the stuff I suggested for one of the earlier
> patches because there is much repetition. I'd put
> 
> 	mask = MX3_PWMCR_STOPEN | MX3_PWMCR_DOZEN | MX3_PWMCR_WAITEN | MX3_PWMCR_DBGEN;
> 	value = MX3_PWMCR_STOPEN | MX3_PWMCR_DOZEN | MX3_PWMCR_WAITEN | MX3_PWMCR_DBGEN;
> 
> before the if and just modify as necessary in the first branch of the
> if.

I've changed the behaviour in v3.

Regards,
  Marco

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
