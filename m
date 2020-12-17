Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD042DD679
	for <lists+linux-pwm@lfdr.de>; Thu, 17 Dec 2020 18:44:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727253AbgLQRnu (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 17 Dec 2020 12:43:50 -0500
Received: from mail.pqgruber.com ([52.59.78.55]:55938 "EHLO mail.pqgruber.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727388AbgLQRnu (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 17 Dec 2020 12:43:50 -0500
Received: from workstation.tuxnet (213-47-165-233.cable.dynamic.surfer.at [213.47.165.233])
        by mail.pqgruber.com (Postfix) with ESMTPSA id 73C5EC727E0;
        Thu, 17 Dec 2020 18:43:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pqgruber.com;
        s=mail; t=1608226985;
        bh=6TcCAg/WkHdSeIZq4U3n4mVZZNVmTV0MBy/nU7U8pJI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pftSHLPuTEHcNXYRK6B9oKpV4ijhodMf306IaV4P5rAwytxQ+hubaSK51zpMofj1G
         n5U3tejvgpyZUW851vTqTH2IbOavclEgSJCgg8zKJruu4zWEqem6jzMtYG4fS9FnYE
         rO/wKqevpp+PIwMjr8BCDaJ9hWXw9njs4HWC9GqQ=
Date:   Thu, 17 Dec 2020 18:43:04 +0100
From:   Clemens Gruber <clemens.gruber@pqgruber.com>
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pwm@vger.kernel.org, u.kleine-koenig@pengutronix.de
Subject: Re: [PATCH v5 2/7] pwm: pca9685: Support hardware readout
Message-ID: <X9uYqGboZg5DuEtf@workstation.tuxnet>
References: <20201216125320.5277-1-clemens.gruber@pqgruber.com>
 <20201216125320.5277-2-clemens.gruber@pqgruber.com>
 <CAGngYiWkKZGkQ4TTTy8bQYvnGBK45V0A0JCe_+M5V+vuVU+zkQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGngYiWkKZGkQ4TTTy8bQYvnGBK45V0A0JCe_+M5V+vuVU+zkQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, Dec 16, 2020 at 11:00:59PM -0500, Sven Van Asbroeck wrote:
> On Wed, Dec 16, 2020 at 7:53 AM Clemens Gruber
> <clemens.gruber@pqgruber.com> wrote:
> >
> > Implements .get_state to read-out the current hardware state.
> >
> 
> I am not convinced that we actually need this.
> 
> Looking at the pwm core, .get_state() is only called right after .request(),
> to initialize the cached value of the state. The core then uses the cached
> value throughout, it'll never read out the h/w again, until the next .request().
> 
> In our case, we know that the state right after request is always disabled,
> because:
> - we disable all pwm channels on probe (in PATCH v5 4/7)
> - .free() disables the pwm channel
> 
> Conclusion: .get_state() will always return "pwm disabled", so why do we
> bother reading out the h/w?

If there are no plans for the PWM core to call .get_state more often in
the future, we could just read out the period and return 0 duty and
disabled.

Thierry, Uwe, what's your take on this?

> Of course, if we choose to leave the pwm enabled after .free(), then
> .get_state() can even be left out! Do we want that? Genuine question, I do
> not know the answer.

I do not think we should leave it enabled after free. It is less
complicated if we know that unrequested channels are not in use.

> 
> > The hardware readout may return slightly different values than those
> > that were set in apply due to the limited range of possible prescale and
> > counter register values.
> >
> > Also note that although the datasheet mentions 200 Hz as default
> > frequency when using the internal 25 MHz oscillator, the calculated
> > period from the default prescaler register setting of 30 is 5079040ns.
> >
> > Signed-off-by: Clemens Gruber <clemens.gruber@pqgruber.com>
> > ---
> >  drivers/pwm/pwm-pca9685.c | 41 +++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 41 insertions(+)
> >
> > diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
> > index 1b5b5fb93b43..b3398963c0ff 100644
> > --- a/drivers/pwm/pwm-pca9685.c
> > +++ b/drivers/pwm/pwm-pca9685.c
> > @@ -331,6 +331,46 @@ static int pca9685_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> >         return 0;
> >  }
> >
> > +static void pca9685_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
> > +                                 struct pwm_state *state)
> > +{
> > +       struct pca9685 *pca = to_pca(chip);
> > +       unsigned long long duty;
> > +       unsigned int val;
> > +
> > +       /* Calculate (chip-wide) period from prescale value */
> > +       regmap_read(pca->regmap, PCA9685_PRESCALE, &val);
> > +       state->period = (PCA9685_COUNTER_RANGE * 1000 / PCA9685_OSC_CLOCK_MHZ) *
> > +                       (val + 1);
> > +
> > +       /* The (per-channel) polarity is fixed */
> > +       state->polarity = PWM_POLARITY_NORMAL;
> > +
> > +       if (pwm->hwpwm >= PCA9685_MAXCHAN) {
> > +               /*
> > +                * The "all LEDs" channel does not support HW readout
> > +                * Return 0 and disabled for backwards compatibility
> > +                */
> > +               state->duty_cycle = 0;
> > +               state->enabled = false;
> > +               return;
> > +       }
> > +
> > +       duty = pca9685_pwm_get_duty(pca, pwm->hwpwm);
> > +
> > +       state->enabled = !!duty;
> > +       if (!state->enabled) {
> > +               state->duty_cycle = 0;
> > +               return;
> > +       } else if (duty == PCA9685_COUNTER_RANGE) {
> > +               state->duty_cycle = state->period;
> > +               return;
> > +       }
> > +
> > +       duty *= state->period;
> > +       state->duty_cycle = duty / PCA9685_COUNTER_RANGE;
> > +}
> > +
> >  static int pca9685_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
> >  {
> >         struct pca9685 *pca = to_pca(chip);
> > @@ -353,6 +393,7 @@ static void pca9685_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
> >
> >  static const struct pwm_ops pca9685_pwm_ops = {
> >         .apply = pca9685_pwm_apply,
> > +       .get_state = pca9685_pwm_get_state,
> >         .request = pca9685_pwm_request,
> >         .free = pca9685_pwm_free,
> >         .owner = THIS_MODULE,
> > --
> > 2.29.2
> >
