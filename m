Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1F0B109E9C
	for <lists+linux-pwm@lfdr.de>; Tue, 26 Nov 2019 14:12:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726005AbfKZNMx (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 26 Nov 2019 08:12:53 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:39223 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbfKZNMx (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 26 Nov 2019 08:12:53 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1iZae6-0001uy-KO; Tue, 26 Nov 2019 14:12:46 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1iZae5-0000Mz-Ro; Tue, 26 Nov 2019 14:12:45 +0100
Date:   Tue, 26 Nov 2019 14:12:45 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v3] gpio: pca953x: Add Maxim MAX7313 PWM support
Message-ID: <20191126131245.psqdooeqngdzvnfj@pengutronix.de>
References: <20191122113230.16486-1-miquel.raynal@bootlin.com>
 <20191125203849.fxvg74xrzp6rxahy@pengutronix.de>
 <20191126095156.292c03af@xps13>
 <20191126104920.rjlgfwetz2ov3u44@pengutronix.de>
 <20191126121514.394df10e@xps13>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191126121514.394df10e@xps13>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello Miquèl,

On Tue, Nov 26, 2019 at 12:15:14PM +0100, Miquel Raynal wrote:
> Uwe Kleine-König <u.kleine-koenig@pengutronix.de> wrote on Tue, 26 Nov
> 2019 11:49:20 +0100:
> 
> > Hallo Miquel,
> > 
> > On Tue, Nov 26, 2019 at 09:51:56AM +0100, Miquel Raynal wrote:
> > > > Also when switching from 0% to 50% you could prevent a glitch by
> > > > sticking to an unset blink phase 0 bit.  
> > > 
> > > You mean, when turning off the PWM, I should first change the intensity
> > > to 50%, then blink the phase, then change the intensity to 100%?
> > > (reversed logic when intensity > 0).  
> > 
> > No, that's not what I meant. Your hardware seems to have two different
> > "modes". One where you can set the intensity between 0 and 15/16, and
> > another where the intensity is between 1/16 and 16/16, right? Switching
> 
> Right!
> 
> > between these two results in a glitch and you use the first mode only
> > for intensity 0 and the second for the rest.
> 
> Indeed.
> 
> > If now you have to go from
> > 0 to 8/16 your driver does a mode switch while this isn't necessary.
> 
> This is right but it complicates a bit the logic as intensity changes
> become stateful. If this is what you want, I can do it.
> 
> > 
> > I also wonder if a glitch can at least be made less likely, even when
> > going from 0% to 100%. You claimed that changing intensity was glitch
> > free (i.e. the currently running period is completed before the changed
> > setting has an effect). Does this hold also for changing the blink
> > phase?
> 
> I honestly don't know, the datasheet does not tell anything about it.

So you don't have the equipment to test that?

> If I implement the above logic, glitches will be made less likely.

Sounds good.

> I could also add more logic to switch the blink state at the 50%
> whenever crossing this value but with the above logic added I think it
> becomes unreadable and error prone, the risks are not balanced with the
> benefits. Of course anyone can enhance the driver in the future.

I would just implement "lazy" switching. So switch if (and only if)
necessary.
 
> > > > > +	mutex_unlock(&pwm->count_lock);
> > > > > +
> > > > > +	gpiochip_free_own_desc(data->desc);
> > > > > +}
> > > > > +
> > > > > +static int max7313_pwm_apply(struct pwm_chip *pwm_chip,
> > > > > +			     struct pwm_device *pwm_device,
> > > > > +			     const struct pwm_state *state)
> > > > > +{
> > > > > +	struct max7313_pwm_data *data = pwm_get_chip_data(pwm_device);
> > > > > +	struct max7313_pwm *pwm = to_max7313_pwm(pwm_chip);
> > > > > +	struct pca953x_chip *chip = to_pca953x(pwm);
> > > > > +	unsigned int duty_cycle;
> > > > > +
> > > > > +	if (state->period != PWM_PERIOD_NS ||
> > > > > +	    state->polarity != PWM_POLARITY_NORMAL)
> > > > > +		return -EINVAL;    
> > > > 
> > > > The check for period is too strong. Anything bigger than PWM_PERIOD_NS
> > > > is acceptable, too. (The policy I'd like to see is: Provide the biggest
> > > > period possible not bigger than the requested policy.)  
> > > 
> > > I don't understand, what is this parameter supposed to mean? the period
> > > cannot be changed, it is ruled by an internal oscillator. In this case
> > > any period bigger than the actual period cannot be physically achieved.
> > > If we derive ratios with a bigger period than possible, why not
> > > allowing it for lower periods too?  
> > 
> > Yes, I understood that the period is fixed for your PWM. However
> > consider a consumer who would prefer a different period. If you decline
> > all requests unless state->period == PWM_PERIOD_NS the consumer has no
> > guide to determine that unless all periods are tested. If however asking
> > for period = 2s results in getting 31.25 ms this allows the consumer to
> > assume that no period setting between 2s and 31.25 ms is possible. And
> > so the usual policy to implement is as stated in my previous mail.
> 
> I am not sure to follow you, here are two possible understandings:
> 
> 1/ state->period > PWM_PERIOD_NS should not be refused, but in the end
> get_state should always return PWM_PERIOD_NS.
> 
> 2/ I should always do the ratio between state->period and
> state->duty_cycle as long as state->period >= PWM_PERIOD_NS (In this
> case I still don't understand why I should refuse state->period <
> PWM_PERIOD_NS).

The first is the one I want. There are some strange corner cases, but
the policy is easy and also for other policies there are corner cases.
So in general you should do (when .enabled = true):

 - use the requested polarity
 - choose the biggest period not bigger than the requested one
 - with the above period choose the biggest duty_cycle not bigger than
   the requested one.

> > > > > +	data->enabled = state->enabled;
> > > > > +	data->duty_cycle = state->duty_cycle;    
> > > > 
> > > > Storing these is only to let .get_state yield the last set values,
> > > > right?  
> > > 
> > > I can't guess the duty_cycle/enabled state just by reading the
> > > hardware. For instance, I cannot represent a "40% duty with PWM
> > > disabled". Reading the hardware will not be able to know if the PWM
> > > is enabled or not and the duty_cycle will be read as 0.  
> > 
> > I interpret that as a "yes". IMHO it's a misconcept that a PWM driver
> > has to remember the duty cycle (and period) with enabled=false even
> > though this has no influence on the actual output in that state. I'd
> > like to get rid of .enabled in struct pwm_state completely, but Thierry
> > doesn't agree.
> 
> I have no choice. Actually I don't understand why the core do not
> provide the 'last' duty cycle when enabled == false. It provides 0. So
> if I don't use the above trick here is what happens:
> 
> echo 1 > enabled
> echo 50 > duty_cycle
> echo 0 > enabled
> echo 1 > enabled
> * duty_cycle is 0 while I expect it to be 50 *

IMHO this should be fixed in the framework. As I assume this is a bigger
discussion I suggest to keep the code as is and when at some point in
time we have the framework fixed, we simplify all drivers that can
benefit.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
