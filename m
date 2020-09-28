Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4A8B27A713
	for <lists+linux-pwm@lfdr.de>; Mon, 28 Sep 2020 07:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbgI1FuY (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 28 Sep 2020 01:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725308AbgI1FuY (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 28 Sep 2020 01:50:24 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48DF6C0613CE
        for <linux-pwm@vger.kernel.org>; Sun, 27 Sep 2020 22:50:24 -0700 (PDT)
Received: from dude02.hi.pengutronix.de ([2001:67c:670:100:1d::28])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1kMm3G-0006O4-HH; Mon, 28 Sep 2020 07:50:18 +0200
Received: from mfe by dude02.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1kMm3E-0003Yd-R4; Mon, 28 Sep 2020 07:50:16 +0200
Date:   Mon, 28 Sep 2020 07:50:16 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     thierry.reding@gmail.com, lee.jones@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, Anson.Huang@nxp.com, michal.vokac@ysoft.com,
        l.majewski@majess.pl, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
Subject: Re: [PATCH v2 2/5] pwm: imx27: move constant PWMCR register values
 into probe
Message-ID: <20200928055016.GP29466@pengutronix.de>
References: <20200925155330.32301-1-m.felsch@pengutronix.de>
 <20200925155330.32301-3-m.felsch@pengutronix.de>
 <20200926134641.fkqhoez4j3fktbnh@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200926134641.fkqhoez4j3fktbnh@pengutronix.de>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 07:47:41 up 219 days, 17:04, 234 users,  load average: 3.67, 3.74,
 5.02
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::28
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 20-09-26 15:46, Uwe Kleine-König wrote:
> On Fri, Sep 25, 2020 at 05:53:27PM +0200, Marco Felsch wrote:
> > The STOPEN, DOZEN, WAITEN, DBGEN and the CLKSRC bit values never change.
> > So it should be safe to move this bit settings into probe() and change
> > only the necessary bits during apply(). Therefore I added the
> > pwm_imx27_update_bits() helper.
> > 
> > Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> > ---
> > v2:
> > - drop software reset from the logic
> > - fix setting STOPEN, DOZEN, WAITEN and DBGEN bits in case the pwm is
> >   already enabled
> > 
> >  drivers/pwm/pwm-imx27.c | 37 ++++++++++++++++++++++++++++---------
> >  1 file changed, 28 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/pwm/pwm-imx27.c b/drivers/pwm/pwm-imx27.c
> > index 7edac4ac6395..b761764b8375 100644
> > --- a/drivers/pwm/pwm-imx27.c
> > +++ b/drivers/pwm/pwm-imx27.c
> > @@ -96,6 +96,16 @@ struct pwm_imx27_chip {
> >  
> >  #define to_pwm_imx27_chip(chip)	container_of(chip, struct pwm_imx27_chip, chip)
> >  
> > +static void pwm_imx27_update_bits(void __iomem *reg, u32 mask, u32 val)
> > +{
> > +	u32 tmp;
> > +
> > +	tmp = readl(reg);
> > +	tmp &= ~mask;
> > +	tmp |= val & mask;
> > +	return writel(tmp, reg);
> > +}
> > +
> >  static int pwm_imx27_clk_prepare_enable(struct pwm_imx27_chip *imx)
> >  {
> >  	int ret;
> > @@ -221,7 +231,7 @@ static int pwm_imx27_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> >  	unsigned long long c;
> >  	unsigned long long clkrate;
> >  	int ret;
> > -	u32 cr;
> > +	u32 cr, mask;
> >  
> >  	ret = pwm_imx27_clk_prepare_enable(imx);
> >  	if (ret)
> > @@ -267,10 +277,7 @@ static int pwm_imx27_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> >  	 */
> >  	imx->duty_cycle = duty_cycles;
> >  
> > -	cr = MX3_PWMCR_PRESCALER_SET(prescale) |
> > -	     MX3_PWMCR_STOPEN | MX3_PWMCR_DOZEN | MX3_PWMCR_WAITEN |
> > -	     FIELD_PREP(MX3_PWMCR_CLKSRC, MX3_PWMCR_CLKSRC_IPG_HIGH) |
> > -	     MX3_PWMCR_DBGEN;
> > +	cr = MX3_PWMCR_PRESCALER_SET(prescale);
> >  
> >  	if (state->polarity == PWM_POLARITY_INVERSED)
> >  		cr |= FIELD_PREP(MX3_PWMCR_POUTC,
> > @@ -279,7 +286,9 @@ static int pwm_imx27_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> >  	if (state->enabled)
> >  		cr |= MX3_PWMCR_EN;
> >  
> > -	writel(cr, imx->mmio_base + MX3_PWMCR);
> > +	mask = MX3_PWMCR_PRESCALER | MX3_PWMCR_POUTC | MX3_PWMCR_EN;
> > +
> > +	pwm_imx27_update_bits(imx->mmio_base + MX3_PWMCR, mask, cr);
> >  
> >  	if (imx->enabled != state->enabled) {
> >  		if (state->enabled) {
> > @@ -314,7 +323,7 @@ static int pwm_imx27_probe(struct platform_device *pdev)
> >  {
> >  	struct pwm_imx27_chip *imx;
> >  	int ret;
> > -	u32 pwmcr;
> > +	u32 pwmcr, mask;
> >  
> >  	imx = devm_kzalloc(&pdev->dev, sizeof(*imx), GFP_KERNEL);
> >  	if (imx == NULL)
> > @@ -361,10 +370,20 @@ static int pwm_imx27_probe(struct platform_device *pdev)
> >  	if (ret)
> >  		return ret;
> >  
> > -	/* keep clks on if pwm is running */
> > +	mask = MX3_PWMCR_STOPEN | MX3_PWMCR_DOZEN | MX3_PWMCR_WAITEN |
> > +	       MX3_PWMCR_DBGEN;
> > +	pwmcr = MX3_PWMCR_STOPEN | MX3_PWMCR_DOZEN | MX3_PWMCR_WAITEN |
> > +		MX3_PWMCR_DBGEN;
> > +	pwm_imx27_update_bits(imx->mmio_base + MX3_PWMCR, mask, pwmcr);
> > +
> > +	/* keep clks on and clk settings unchanged if pwm is running */
> >  	pwmcr = readl(imx->mmio_base + MX3_PWMCR);
> > -	if (!(pwmcr & MX3_PWMCR_EN))
> > +	if (!(pwmcr & MX3_PWMCR_EN)) {
> > +		mask = MX3_PWMCR_CLKSRC;
> > +		pwmcr = FIELD_PREP(MX3_PWMCR_CLKSRC, MX3_PWMCR_CLKSRC_IPG_HIGH);
> > +		pwm_imx27_update_bits(imx->mmio_base + MX3_PWMCR, mask, pwmcr);
> >  		pwm_imx27_clk_disable_unprepare(imx);
> > +	}
> 
> You're doing more register accesses here than necessary, that is 3 reads
> and two writes while one read and (maybe) one write would be enough.
> (Though this doesn't work if you want to use the pwm_imx27_update_bits
> helper.)

This shouldn't be a real timing issue.

> You'd need to do something like:
> 
> 	val = MX3_PWMCR_STOPEN | MX3_PWMCR_DOZEN | MX3_PWMCR_WAITEN | MX3_PWMCR_DBGEN;
> 	mask = MX3_PWMCR_STOPEN | MX3_PWMCR_DOZEN | MX3_PWMCR_WAITEN | MX3_PWMCR_DBGEN;
> 
> 	pwmcr = readl(imx->mmio_base + MX3_PWMCR);
> 
> 	if (pwmcr & MX3_PWMCR_EN) {
> 		imx->enabled = true;
> 	} else {
> 		val |= FIELD_PREP(MX3_PWMCR_CLKSRC, MX3_PWMCR_CLKSRC_IPG_HIGH);
> 		mask |= MX3_PWMCR_CLKSRC;
> 	}
> 
> 	pwmcr_new = (pwmcr & ~mask) | val;
> 
> 	if (pwmcr_new != val)
> 		writel(imx->mmio_base + MX3_PWMCR, pwmcr_new);
> 
> 	if (!imx->enabled)
> 		pwm_imx27_clk_disable_unprepare(imx);
> 
> Hmm, not sure this is pretty enough to actually recommend this. I let
> you decide.

I don't like this version since it is more confusing.

Regards,
  Marco

> >  	return pwmchip_add(&imx->chip);
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
