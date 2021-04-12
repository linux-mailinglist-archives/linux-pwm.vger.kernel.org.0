Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BE7435CF43
	for <lists+linux-pwm@lfdr.de>; Mon, 12 Apr 2021 19:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240644AbhDLRMT (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 12 Apr 2021 13:12:19 -0400
Received: from mail.pqgruber.com ([52.59.78.55]:33300 "EHLO mail.pqgruber.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239716AbhDLRMT (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 12 Apr 2021 13:12:19 -0400
Received: from workstation.tuxnet (213-47-165-233.cable.dynamic.surfer.at [213.47.165.233])
        by mail.pqgruber.com (Postfix) with ESMTPSA id 8292EC725CF;
        Mon, 12 Apr 2021 19:11:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pqgruber.com;
        s=mail; t=1618247519;
        bh=s70jJ6PUcq1vMW2f9OQQPQXe2SFSJs1hmfS8w1t+mBI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ok66qAe83uGzzW0JSXD++tUQXyjBZbgHfcwj3mUqOUSEaGbg6ItOzfsMin32rAPlX
         C264jO/Zo2j03Q+dmoRm7Xubl0MqJ2vNTt/jbWMJRkbPKPIuhAVN6GPYt53EKLnO29
         JayCN2TCfxYGa2JEfsXuyl6wFpZ9BCF9JH0r3/rs=
Date:   Mon, 12 Apr 2021 19:11:58 +0200
From:   Clemens Gruber <clemens.gruber@pqgruber.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Sven Van Asbroeck <TheSven73@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 6/8] pwm: pca9685: Support new PWM_USAGE_POWER flag
Message-ID: <YHR/Xm5nOjrSwVYs@workstation.tuxnet>
References: <20210412132745.76609-1-clemens.gruber@pqgruber.com>
 <20210412132745.76609-6-clemens.gruber@pqgruber.com>
 <20210412163045.apgnac7atgpboths@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210412163045.apgnac7atgpboths@pengutronix.de>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi,

On Mon, Apr 12, 2021 at 06:30:45PM +0200, Uwe Kleine-König wrote:
> On Mon, Apr 12, 2021 at 03:27:43PM +0200, Clemens Gruber wrote:
> > If PWM_USAGE_POWER is set on a PWM, the pca9685 driver will phase shift
> > the individual channels relative to their channel number. This improves
> > EMI because the enabled channels no longer turn on at the same time,
> > while still maintaining the configured duty cycle / power output.
> > 
> > Signed-off-by: Clemens Gruber <clemens.gruber@pqgruber.com>
> > ---
> >  drivers/pwm/pwm-pca9685.c | 63 ++++++++++++++++++++++++++++++---------
> >  1 file changed, 49 insertions(+), 14 deletions(-)
> > 
> > diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
> > index 7f97965033e7..410b93b115dc 100644
> > --- a/drivers/pwm/pwm-pca9685.c
> > +++ b/drivers/pwm/pwm-pca9685.c
> > @@ -93,46 +93,76 @@ static inline struct pca9685 *to_pca(struct pwm_chip *chip)
> >  /* Helper function to set the duty cycle ratio to duty/4096 (e.g. duty=2048 -> 50%) */
> >  static void pca9685_pwm_set_duty(struct pca9685 *pca, int channel, unsigned int duty)
> >  {
> > +	struct pwm_device *pwm = &pca->chip.pwms[channel];
> > +	unsigned int on, off;
> > +
> >  	if (duty == 0) {
> >  		/* Set the full OFF bit, which has the highest precedence */
> >  		regmap_write(pca->regmap, REG_OFF_H(channel), LED_FULL);
> > +		return;
> >  	} else if (duty >= PCA9685_COUNTER_RANGE) {
> >  		/* Set the full ON bit and clear the full OFF bit */
> >  		regmap_write(pca->regmap, REG_ON_H(channel), LED_FULL);
> >  		regmap_write(pca->regmap, REG_OFF_H(channel), 0);
> > -	} else {
> > -		/* Set OFF time (clears the full OFF bit) */
> > -		regmap_write(pca->regmap, REG_OFF_L(channel), duty & 0xff);
> > -		regmap_write(pca->regmap, REG_OFF_H(channel), (duty >> 8) & 0xf);
> > -		/* Clear the full ON bit */
> > -		regmap_write(pca->regmap, REG_ON_H(channel), 0);
> > +		return;
> >  	}
> > +
> > +
> > +	if (pwm->args.usage_power && channel < PCA9685_MAXCHAN) {
> > +		/*
> > +		 * If PWM_USAGE_POWER is set on a PWM, the pca9685
> > +		 * driver will phase shift the individual channels
> > +		 * relative to their channel number.
> > +		 * This improves EMI because the enabled channels no
> > +		 * longer turn on at the same time, while still
> > +		 * maintaining the configured duty cycle / power output.
> > +		 */
> > +		on = channel * PCA9685_COUNTER_RANGE / PCA9685_MAXCHAN;
> > +	} else
> > +		on = 0;
> > +
> > +	off = (on + duty) % PCA9685_COUNTER_RANGE;
> > +
> > +	/* Set ON time (clears full ON bit) */
> > +	regmap_write(pca->regmap, REG_ON_L(channel), on & 0xff);
> > +	regmap_write(pca->regmap, REG_ON_H(channel), (on >> 8) & 0xf);
> > +	/* Set OFF time (clears full OFF bit) */
> > +	regmap_write(pca->regmap, REG_OFF_L(channel), off & 0xff);
> > +	regmap_write(pca->regmap, REG_OFF_H(channel), (off >> 8) & 0xf);
> >  }
> >  
> >  static unsigned int pca9685_pwm_get_duty(struct pca9685 *pca, int channel)
> >  {
> > -	unsigned int off_h = 0, val = 0;
> > +	struct pwm_device *pwm = &pca->chip.pwms[channel];
> > +	unsigned int off = 0, on = 0, val = 0;
> >  
> >  	if (WARN_ON(channel >= PCA9685_MAXCHAN)) {
> >  		/* HW does not support reading state of "all LEDs" channel */
> >  		return 0;
> >  	}
> >  
> > -	regmap_read(pca->regmap, LED_N_OFF_H(channel), &off_h);
> > -	if (off_h & LED_FULL) {
> > +	regmap_read(pca->regmap, LED_N_OFF_H(channel), &off);
> > +	if (off & LED_FULL) {
> >  		/* Full OFF bit is set */
> >  		return 0;
> >  	}
> >  
> > -	regmap_read(pca->regmap, LED_N_ON_H(channel), &val);
> > -	if (val & LED_FULL) {
> > +	regmap_read(pca->regmap, LED_N_ON_H(channel), &on);
> > +	if (on & LED_FULL) {
> >  		/* Full ON bit is set */
> >  		return PCA9685_COUNTER_RANGE;
> >  	}
> >  
> > -	val = 0;
> >  	regmap_read(pca->regmap, LED_N_OFF_L(channel), &val);
> > -	return ((off_h & 0xf) << 8) | (val & 0xff);
> > +	off = ((off & 0xf) << 8) | (val & 0xff);
> > +	if (!pwm->args.usage_power)
> > +		return off;
> > +
> > +	/* Read ON register to calculate duty cycle of staggered output */
> > +	val = 0;
> > +	regmap_read(pca->regmap, LED_N_ON_L(channel), &val);
> > +	on = ((on & 0xf) << 8) | (val & 0xff);
> > +	return (off - on) & (PCA9685_COUNTER_RANGE - 1);
> 
> If LED_N_ON is != 0 but usage_power is false, the returned state is
> bogus.

If usage_power is false, LED_N_ON is guaranteed to be 0. It is reset to
0 in probe and never changed. Or did I miss something?

> 
> >  }
> >  
> >  #if IS_ENABLED(CONFIG_GPIOLIB)
> > @@ -439,9 +469,11 @@ static int pca9685_pwm_probe(struct i2c_client *client,
> >  	reg &= ~(MODE1_ALLCALL | MODE1_SUB1 | MODE1_SUB2 | MODE1_SUB3);
> >  	regmap_write(pca->regmap, PCA9685_MODE1, reg);
> >  
> > -	/* Reset OFF registers to POR default */
> > +	/* Reset OFF/ON registers to POR default */
> >  	regmap_write(pca->regmap, PCA9685_ALL_LED_OFF_L, LED_FULL);
> >  	regmap_write(pca->regmap, PCA9685_ALL_LED_OFF_H, LED_FULL);
> > +	regmap_write(pca->regmap, PCA9685_ALL_LED_ON_L, 0);
> > +	regmap_write(pca->regmap, PCA9685_ALL_LED_ON_H, 0);
> >  
> >  	pca->chip.ops = &pca9685_pwm_ops;
> >  	/* Add an extra channel for ALL_LED */
> > @@ -450,6 +482,9 @@ static int pca9685_pwm_probe(struct i2c_client *client,
> >  	pca->chip.dev = &client->dev;
> >  	pca->chip.base = -1;
> >  
> > +	pca->chip.of_xlate = of_pwm_xlate_with_flags;
> > +	pca->chip.of_pwm_n_cells = 3;
> > +
> 
> Huh, you're incompatibly changing the device tree binding here.

No, I don't think so:

The third cell is optional with of_pwm_xlate_with_flags.
So previous DTs with pwm-cells = <2> will still work.
If you want to use the new flag for some PWMs you have to set pwm-cells
to <3> and PWM_USAGE_POWER (or 0) in the third field at the consumer.

This should not break backwards compatibility. Let me know if I missed
something.

Thanks for your review,
Clemens
