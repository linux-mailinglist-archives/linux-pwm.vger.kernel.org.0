Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E52E435687C
	for <lists+linux-pwm@lfdr.de>; Wed,  7 Apr 2021 11:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350375AbhDGJxd (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 7 Apr 2021 05:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350328AbhDGJxc (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 7 Apr 2021 05:53:32 -0400
Received: from mail.pqgruber.com (mail.pqgruber.com [IPv6:2a05:d014:575:f70b:4f2c:8f1d:40c4:b13e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B8C6C061756;
        Wed,  7 Apr 2021 02:53:23 -0700 (PDT)
Received: from workstation.tuxnet (213-47-165-233.cable.dynamic.surfer.at [213.47.165.233])
        by mail.pqgruber.com (Postfix) with ESMTPSA id 0C113C759B8;
        Wed,  7 Apr 2021 11:53:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pqgruber.com;
        s=mail; t=1617789202;
        bh=LFiHf0QEFRJ4AYLD+eXO5VI/qCJ28NzXBY108U/TRM0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Mz4hB6THRjLdImcnOlQuUH8io8ULNR06r7iyX15tHPIEpwxhCEfUC7lx0JOjOgKiJ
         MJLYe72hbowaeXYKxomoFX9hC1v1c7Ikdq7eZBlKduRi+xMLzZOqv759+cHkebb5yI
         qRVi0llJXs2egQLcx+COEP8KQCyaB280/VV76UfE=
Date:   Wed, 7 Apr 2021 11:53:20 +0200
From:   Clemens Gruber <clemens.gruber@pqgruber.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Sven Van Asbroeck <TheSven73@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 2/8] pwm: pca9685: Support hardware readout
Message-ID: <YG2BEGsPU8jWzvPq@workstation.tuxnet>
References: <20210406164140.81423-1-clemens.gruber@pqgruber.com>
 <20210406164140.81423-2-clemens.gruber@pqgruber.com>
 <20210407053135.tx2q4bzxf2lwtqna@pengutronix.de>
 <YG1gQNdDYA1RwrCo@workstation.tuxnet>
 <20210407090943.vshoxqhaha4j6wq7@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210407090943.vshoxqhaha4j6wq7@pengutronix.de>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, Apr 07, 2021 at 11:09:43AM +0200, Uwe Kleine-König wrote:
> On Wed, Apr 07, 2021 at 09:33:20AM +0200, Clemens Gruber wrote:
> > On Wed, Apr 07, 2021 at 07:31:35AM +0200, Uwe Kleine-König wrote:
> > > On Tue, Apr 06, 2021 at 06:41:34PM +0200, Clemens Gruber wrote:
> > > > Implements .get_state to read-out the current hardware state.
> > > > 
> > > > The hardware readout may return slightly different values than those
> > > > that were set in apply due to the limited range of possible prescale and
> > > > counter register values.
> > > > 
> > > > Also note that although the datasheet mentions 200 Hz as default
> > > > frequency when using the internal 25 MHz oscillator, the calculated
> > > > period from the default prescaler register setting of 30 is 5079040ns.
> > > > 
> > > > Signed-off-by: Clemens Gruber <clemens.gruber@pqgruber.com>
> > > > ---
> > > > Changes since v6:
> > > > - Added a comment regarding the division (Suggested by Uwe)
> > > > - Rebased
> > > > 
> > > >  drivers/pwm/pwm-pca9685.c | 46 +++++++++++++++++++++++++++++++++++++++
> > > >  1 file changed, 46 insertions(+)
> > > > 
> > > > diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
> > > > index 5a2ce97e71fd..d4474c5ff96f 100644
> > > > --- a/drivers/pwm/pwm-pca9685.c
> > > > +++ b/drivers/pwm/pwm-pca9685.c
> > > > @@ -333,6 +333,51 @@ static int pca9685_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> > > >  	return 0;
> > > >  }
> > > >  
> > > > +static void pca9685_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
> > > > +				  struct pwm_state *state)
> > > > +{
> > > > +	struct pca9685 *pca = to_pca(chip);
> > > > +	unsigned long long duty;
> > > > +	unsigned int val = 0;
> > > > +
> > > > +	/* Calculate (chip-wide) period from prescale value */
> > > > +	regmap_read(pca->regmap, PCA9685_PRESCALE, &val);
> > > > +	/*
> > > > +	 * PCA9685_OSC_CLOCK_MHZ is 25, i.e. an integer divider of 1000.
> > > > +	 * The following calculation is therefore only a multiplication
> > > > +	 * and we are not losing precision.
> > > > +	 */
> > > > +	state->period = (PCA9685_COUNTER_RANGE * 1000 / PCA9685_OSC_CLOCK_MHZ) *
> > > > +			(val + 1);
> > > > +
> > > > +	/* The (per-channel) polarity is fixed */
> > > > +	state->polarity = PWM_POLARITY_NORMAL;
> > > > +
> > > > +	if (pwm->hwpwm >= PCA9685_MAXCHAN) {
> > > > +		/*
> > > > +		 * The "all LEDs" channel does not support HW readout
> > > > +		 * Return 0 and disabled for backwards compatibility
> > > > +		 */
> > > > +		state->duty_cycle = 0;
> > > > +		state->enabled = false;
> > > > +		return;
> > > > +	}
> > > > +
> > > > +	duty = pca9685_pwm_get_duty(pca, pwm->hwpwm);
> > > > +
> > > > +	state->enabled = !!duty;
> > > > +	if (!state->enabled) {
> > > > +		state->duty_cycle = 0;
> > > > +		return;
> > > > +	} else if (duty == PCA9685_COUNTER_RANGE) {
> > > > +		state->duty_cycle = state->period;
> > > > +		return;
> > > > +	}
> > > > +
> > > > +	duty *= state->period;
> > > > +	state->duty_cycle = duty / PCA9685_COUNTER_RANGE;
> > > 
> > > Given that with duty = 0 the chip is still "on" and changing the duty
> > > will first complete the currently running period, I'd model duty=0 as
> > > enabled. This also simplifies the code a bit, to something like:
> > > 
> > > 
> > > 	state->enabled = true;
> > > 	duty = pca9685_pwm_get_duty(pca, pwm->hwpwm);
> > > 	state->duty_cycle = div_round_up(duty * state->period, PCA9685_COUNTER_RANGE);
> > > 
> > > (I'm using round-up here assuming apply uses round-down to get
> > > idempotency. In the current patch set state this is wrong however.)
> > 
> > So, in your opinion, every requested PWM of the pca9685 should always be
> > enabled by default (from the PWM core viewpoint) ?
> > 
> > And this wouldn't break the following because pwm_get_state does not
> > actually read out the hw state:
> > pwm_get_state -> enabled=true duty=0
> > pwm_apply_state -> enabled =false duty=0
> > pwm_get_state -> enabled=false duty=0
> 
> I don't see any breakage here. Either there is none or I failed to grasp
> where you see a problem.

Me neither, I was just thinking out loud.

Clemens
