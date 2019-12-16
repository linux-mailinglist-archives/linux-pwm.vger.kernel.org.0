Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B30C31200BF
	for <lists+linux-pwm@lfdr.de>; Mon, 16 Dec 2019 10:18:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727202AbfLPJOV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pwm@lfdr.de>); Mon, 16 Dec 2019 04:14:21 -0500
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:50393 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727189AbfLPJOV (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 16 Dec 2019 04:14:21 -0500
X-Originating-IP: 91.224.148.103
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 0331624000B;
        Mon, 16 Dec 2019 09:14:17 +0000 (UTC)
Date:   Mon, 16 Dec 2019 10:14:16 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de,
        linux-gpio@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v4] gpio: pca953x: Add Maxim MAX7313 PWM support
Message-ID: <20191216101416.339d873f@xps13>
In-Reply-To: <20191216085424.x6fqr4gxkph5zqjh@pengutronix.de>
References: <20191129191023.2209-1-miquel.raynal@bootlin.com>
        <20191212211434.455trhnlcvn26zl6@pengutronix.de>
        <20191216093955.177a04af@xps13>
        <20191216085424.x6fqr4gxkph5zqjh@pengutronix.de>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

Uwe Kleine-König <u.kleine-koenig@pengutronix.de> wrote on Mon, 16 Dec
2019 09:54:24 +0100:

> Hi Miquel,
> 
> On Mon, Dec 16, 2019 at 09:39:55AM +0100, Miquel Raynal wrote:
> > Uwe Kleine-König <u.kleine-koenig@pengutronix.de> wrote on Thu, 12 Dec
> > 2019 22:14:34 +0100:
> >   
> > > On Fri, Nov 29, 2019 at 08:10:23PM +0100, Miquel Raynal wrote:  
> > > > +static int max7313_pwm_apply(struct pwm_chip *chip,
> > > > +			     struct pwm_device *pwm,
> > > > +			     const struct pwm_state *state)
> > > > +{
> > > > +	struct max7313_pwm *max_pwm = to_max7313_pwm(chip);
> > > > +	struct pca953x_chip *pca_chip = to_pca953x(max_pwm);
> > > > +	unsigned int intensity, active;
> > > > +	int ret = 0;
> > > > +
> > > > +	if (!state->enabled ||
> > > > +	    state->period < PWM_PERIOD_NS ||
> > > > +	    state->polarity != PWM_POLARITY_NORMAL)
> > > > +		return -EINVAL;
> > > > +
> > > > +	/* Convert the duty-cycle to be in the [0;16] range */
> > > > +	intensity = DIV_ROUND_DOWN_ULL(state->duty_cycle,
> > > > +				       state->period / PWM_DC_STATES);    
> > > 
> > > this looks wrong. The period must not have an influence on the selection
> > > of the duty_cycle (other than duty_cycle < period). So given that the
> > > period is fixed at 31.25 ms, the result of
> > > 
> > > 	pwm_apply_state(pwm, { .enabled = 1, .period = 2s, .duty_cycle = 16 ms })
> > > 
> > > must be the same as for
> > > 
> > > 	pwm_apply_state(pwm, { .enabled = 1, .period = 3s, .duty_cycle = 16 ms })  
> > 
> > This was not my understanding of our previous discussion and, again, I
> > don't really understand this choice but if the framework works like
> > that we shall probably continue with this logic. However, all this
> > should probably be explained directly in the kernel doc of each core
> > helper, that would help a lot.  
> 
> I agree. There is a pending doc patch and once Thierry applies it I plan
> to add these details.

Great!

> 
> The idea is to make the policy simple (both computational and to
> understand). With each policy there are strange corner cases, so for
> sure you can come up with examples that yield results that are way off
> from the request. The idea is that drivers all implement the same policy
> and then create helper functions to match the different consumer needs.

I fully understand and comply with this.

The above logic was not the first one that would have came off my mind
but it is 100% true that it keeps the computation easy (= less bugs, =
quicker) and has probably been much more pondered than mine.

> 
> > > . Also dividing by a division looses precision.  
> > 
> > I agree but this is a problem with fixed point calculations. Maybe I
> > could first multiply the numerator by a factor of 100 or 1000 to
> > minimize the error. Do you have a better idea?  
> 
> intensity = DIV_ROUND_DOWN_ULL((unsigned long long)state->duty_cycle * PWM_DC_STATES, state->period);
> 
> should be both more exact and cheaper to calculate. (But this is
> somewhat moot given that state->period shouldn't be there.)

I feel stupid now - let's put it on monday mood. Of course it's more
accurate this way.

> (And in general you have to care for overflowing, but I think that's not
> a problem in practise here as struct pwm_state::duty_cycle is an int
> (still), and PWM_DC_STATES is small.)

Do you plan to change duty_cycle type?

Right now the multiplication cannot be over 500 000 which is totally
okay for a s32 but not for a s16 for instance. 

> > > > +static void max7313_pwm_get_state(struct pwm_chip *chip,
> > > > +				  struct pwm_device *pwm,
> > > > +				  struct pwm_state *state)
> > > > +{
> > > > +	struct max7313_pwm *max_pwm = to_max7313_pwm(chip);
> > > > +	struct pca953x_chip *pca_chip = to_pca953x(max_pwm);
> > > > +	u8 intensity;
> > > > +
> > > > +	state->enabled = true;
> > > > +	state->period = PWM_PERIOD_NS;
> > > > +	state->polarity = PWM_POLARITY_NORMAL;
> > > > +
> > > > +	intensity = max7313_pwm_get_intensity(pca_chip, pwm->hwpwm);
> > > > +	state->duty_cycle = intensity * PWM_OFFSET_NS;    
> > > 
> > > I think you need to take into account the blink phase bit.  
> > 
> > It is already done by .pwm_get_intensity itself, no?  
> 
> Ah, possible, I admin I didn't look deep enough to catch it there.

No problem, thanks anyway for all the careful reviews!

Thanks,
Miquèl
