Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF2C1357639
	for <lists+linux-pwm@lfdr.de>; Wed,  7 Apr 2021 22:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbhDGUlk (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 7 Apr 2021 16:41:40 -0400
Received: from mail.pqgruber.com ([52.59.78.55]:39898 "EHLO mail.pqgruber.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229586AbhDGUlk (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 7 Apr 2021 16:41:40 -0400
Received: from workstation.tuxnet (213-47-165-233.cable.dynamic.surfer.at [213.47.165.233])
        by mail.pqgruber.com (Postfix) with ESMTPSA id 98A9CC6B24A;
        Wed,  7 Apr 2021 22:41:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pqgruber.com;
        s=mail; t=1617828088;
        bh=Xl/ESSD4/hhMuitp64+ekC4g7ibiaBi8k1rzUFGoZNI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Hql7Nxg0TS3eQEQ7YhCH0EaTWzpFa3P5UfnWA0MZd1dMwsnp9xJe/HcZCxUCakeQ0
         Dp+FDQyf4bi1Xsrpwx7SQYP9ulvc9MhWMlGqgI0mI3UIail/mEq40WtBNLIGag730n
         av8XwzEjXG3/l9g1MKuwpS7HnKn2pSdqM6LHyYf0=
Date:   Wed, 7 Apr 2021 22:41:27 +0200
From:   Clemens Gruber <clemens.gruber@pqgruber.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Sven Van Asbroeck <TheSven73@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 7/8] pwm: pca9685: Restrict period change for enabled
 PWMs
Message-ID: <YG4Y94sIL/xO2u/N@workstation.tuxnet>
References: <20210406164140.81423-1-clemens.gruber@pqgruber.com>
 <20210406164140.81423-7-clemens.gruber@pqgruber.com>
 <20210407061229.lsyg7blh3ebxtvx6@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210407061229.lsyg7blh3ebxtvx6@pengutronix.de>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, Apr 07, 2021 at 08:12:29AM +0200, Uwe Kleine-König wrote:
> On Tue, Apr 06, 2021 at 06:41:39PM +0200, Clemens Gruber wrote:
> > Previously, the last used PWM channel could change the global prescale
> > setting, even if other channels are already in use.
> > 
> > Fix it by only allowing the first enabled PWM to change the global
> > chip-wide prescale setting. If there is more than one channel in use,
> > the prescale settings resulting from the chosen periods must match.
> > 
> > GPIOs do not count as enabled PWMs as they are not using the prescaler
> > and can't change it.
> > 
> > Signed-off-by: Clemens Gruber <clemens.gruber@pqgruber.com>
> > ---
> > Changes since v6:
> > - Only allow the first PWM that is enabled to change the prescaler, not
> >   the first one that uses the prescaler
> > 
> >  drivers/pwm/pwm-pca9685.c | 66 +++++++++++++++++++++++++++++++++------
> >  1 file changed, 56 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
> > index 24221ee7a77a..cf0c98e4ef44 100644
> > --- a/drivers/pwm/pwm-pca9685.c
> > +++ b/drivers/pwm/pwm-pca9685.c
> > @@ -23,11 +23,11 @@
> >  #include <linux/bitmap.h>
> >  
> >  /*
> > - * Because the PCA9685 has only one prescaler per chip, changing the period of
> > - * one channel affects the period of all 16 PWM outputs!
> > - * However, the ratio between each configured duty cycle and the chip-wide
> > - * period remains constant, because the OFF time is set in proportion to the
> > - * counter range.
> > + * Because the PCA9685 has only one prescaler per chip, only the first channel
> > + * that is enabled is allowed to change the prescale register.
> > + * PWM channels requested afterwards must use a period that results in the same
> > + * prescale setting as the one set by the first requested channel.
> > + * GPIOs do not count as enabled PWMs as they are not using the prescaler.
> >   */
> >  
> >  #define PCA9685_MODE1		0x00
> > @@ -78,8 +78,9 @@
> >  struct pca9685 {
> >  	struct pwm_chip chip;
> >  	struct regmap *regmap;
> > -#if IS_ENABLED(CONFIG_GPIOLIB)
> >  	struct mutex lock;
> > +	DECLARE_BITMAP(pwms_enabled, PCA9685_MAXCHAN + 1);
> > +#if IS_ENABLED(CONFIG_GPIOLIB)
> >  	struct gpio_chip gpio;
> >  	DECLARE_BITMAP(pwms_inuse, PCA9685_MAXCHAN + 1);
> >  #endif
> > @@ -90,6 +91,22 @@ static inline struct pca9685 *to_pca(struct pwm_chip *chip)
> >  	return container_of(chip, struct pca9685, chip);
> >  }
> >  
> > +/* This function is supposed to be called with the lock mutex held */
> > +static bool pca9685_prescaler_can_change(struct pca9685 *pca, int channel)
> > +{
> > +	/* No PWM enabled: Change allowed */
> > +	if (bitmap_empty(pca->pwms_enabled, PCA9685_MAXCHAN + 1))
> > +		return true;
> > +	/* More than one PWM enabled: Change not allowed */
> > +	if (bitmap_weight(pca->pwms_enabled, PCA9685_MAXCHAN + 1) > 1)
> > +		return false;
> > +	/*
> > +	 * Only one PWM enabled: Change allowed if the PWM about to
> > +	 * be changed is the one that is already enabled
> > +	 */
> > +	return test_bit(channel, pca->pwms_enabled);
> 
> Maybe this is a bit more effective?:
> 
> 	DECLARE_BITMAP(blablub, PCA9685_MAXCHAN + 1);	
> 	bitmap_zero(blablub, PCA9685_MAXCHAN + 1);
> 	bitmap_set(blablub, channel);
> 	return bitmap_subset(pca->pwms_enabled, blablub);

But if no PWM is enabled, it should return true, not false.

> (but that's a minor issue, the suggested algorithm is correct.)

I would prefer to keep it explicit because it is a little easier to
follow and probably not worth optimizing.

> 
> So:
> 
> Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Thanks.

> 
> (side-note: I wonder if the handling of the set-all channel is correct
> here. But given that it is messy anyhow, (e.g. because setting some
> state to this set-all channel doesn't influence pwm_get_state for the
> individual channels) I don't object if there is another problem in this
> corner case. IMHO just dropping this virtual channel would be nice.)

As you can't request the all channel and the individual channels
together, there shouldn't be any problems.

I agree that it would be nice to drop the ALL channel support.

Clemens
