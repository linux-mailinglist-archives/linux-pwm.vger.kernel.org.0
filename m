Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41EFA2DD695
	for <lists+linux-pwm@lfdr.de>; Thu, 17 Dec 2020 18:51:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727543AbgLQRvG (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 17 Dec 2020 12:51:06 -0500
Received: from mail.pqgruber.com ([52.59.78.55]:56072 "EHLO mail.pqgruber.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727368AbgLQRvG (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 17 Dec 2020 12:51:06 -0500
Received: from workstation.tuxnet (213-47-165-233.cable.dynamic.surfer.at [213.47.165.233])
        by mail.pqgruber.com (Postfix) with ESMTPSA id 558C5C727E0;
        Thu, 17 Dec 2020 18:50:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pqgruber.com;
        s=mail; t=1608227423;
        bh=5yv6lGeSgyryVCNTl8aoCTVLcb95oe95IW/ZaqfogQw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R3LLK/FB1wRB0FrDR4XOoYTk4Z2wq1g5a9f6hYSj4dxKcpxZ5+gKj3kJIp6wWAmqe
         55FqK4NYQuDNhqLVZtTpZImcG83LMYyAVha2mNMjgvtUTqjqn/LFqHIqaCjLDnaN9D
         keGIykFcA0Kx5UNm/ZWvDKIl8d1ihFtMGCjJ6w5Q=
Date:   Thu, 17 Dec 2020 18:50:22 +0100
From:   Clemens Gruber <clemens.gruber@pqgruber.com>
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        David Jander <david@protonic.nl>
Subject: Re: [PATCH v5 5/7] pwm: pca9685: Support staggered output ON times
Message-ID: <X9uaXpZ5FmKZgZqs@workstation.tuxnet>
References: <20201215212228.185517-1-clemens.gruber@pqgruber.com>
 <20201215212228.185517-5-clemens.gruber@pqgruber.com>
 <CAGngYiXCS-FwQkA7nzizXw_5417_u7VmPAXPbZeDv4dUFs2cog@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGngYiXCS-FwQkA7nzizXw_5417_u7VmPAXPbZeDv4dUFs2cog@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, Dec 16, 2020 at 11:02:57PM -0500, Sven Van Asbroeck wrote:
> Hi Clemens, see below.
> 
> On Wed, Dec 16, 2020 at 7:53 AM Clemens Gruber
> <clemens.gruber@pqgruber.com> wrote:
> >
> > The PCA9685 supports staggered LED output ON times to minimize current
> > surges and reduce EMI.
> > When this new option is enabled, the ON times of each channel are
> > delayed by channel number x counter range / 16, which avoids asserting
> > all enabled outputs at the same counter value while still maintaining
> > the configured duty cycle of each output.
> >
> > Signed-off-by: Clemens Gruber <clemens.gruber@pqgruber.com>
> > ---
> >  drivers/pwm/pwm-pca9685.c | 62 +++++++++++++++++++++++++++++++--------
> >  1 file changed, 50 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
> > index 38aadaf50996..ff916980de49 100644
> > --- a/drivers/pwm/pwm-pca9685.c
> > +++ b/drivers/pwm/pwm-pca9685.c
> > @@ -79,6 +79,7 @@
> >  struct pca9685 {
> >         struct pwm_chip chip;
> >         struct regmap *regmap;
> > +       bool staggered_outputs;
> >  #if IS_ENABLED(CONFIG_GPIOLIB)
> >         struct mutex lock;
> >         struct gpio_chip gpio;
> > @@ -93,45 +94,79 @@ static inline struct pca9685 *to_pca(struct pwm_chip *chip)
> >
> >  static void pca9685_pwm_set_duty(struct pca9685 *pca, int channel, unsigned int duty)
> >  {
> > +       unsigned int on, off;
> > +
> >         if (duty == 0) {
> >                 /* Set the full OFF bit, which has the highest precedence */
> >                 regmap_write(pca->regmap, REG_OFF_H(channel), LED_FULL);
> > +               return;
> >         } else if (duty >= PCA9685_COUNTER_RANGE) {
> >                 /* Set the full ON bit and clear the full OFF bit */
> >                 regmap_write(pca->regmap, REG_ON_H(channel), LED_FULL);
> >                 regmap_write(pca->regmap, REG_OFF_H(channel), 0);
> > -       } else {
> > -               /* Set OFF time (clears the full OFF bit) */
> > -               regmap_write(pca->regmap, REG_OFF_L(channel), duty & 0xff);
> > -               regmap_write(pca->regmap, REG_OFF_H(channel), (duty >> 8) & 0xf);
> > -               /* Clear the full ON bit */
> > -               regmap_write(pca->regmap, REG_ON_H(channel), 0);
> > +               return;
> > +       }
> > +
> > +       if (pca->staggered_outputs) {
> > +               if (channel < PCA9685_MAXCHAN) {
> > +                       /*
> > +                        * To reduce EMI, the ON times of each channel are
> > +                        * spread out evenly within the counter range, while
> > +                        * still maintaining the configured duty cycle
> > +                        */
> > +                       on = channel * PCA9685_COUNTER_RANGE / PCA9685_MAXCHAN;
> > +                       off = (on + duty) % PCA9685_COUNTER_RANGE;
> > +                       regmap_write(pca->regmap, REG_ON_L(channel), on & 0xff);
> > +                       regmap_write(pca->regmap, REG_ON_H(channel), (on >> 8) & 0xf);
> > +                       regmap_write(pca->regmap, REG_OFF_L(channel), off & 0xff);
> > +                       regmap_write(pca->regmap, REG_OFF_H(channel), (off >> 8) & 0xf);
> > +                       return;
> > +               }
> > +               /* No staggering possible if "all LEDs" channel is used */
> > +               regmap_write(pca->regmap, PCA9685_ALL_LED_ON_L, 0);
> >         }
> > +       /* Set OFF time (clears the full OFF bit) */
> > +       regmap_write(pca->regmap, REG_OFF_L(channel), duty & 0xff);
> > +       regmap_write(pca->regmap, REG_OFF_H(channel), (duty >> 8) & 0xf);
> > +       /* Clear the full ON bit */
> > +       regmap_write(pca->regmap, REG_ON_H(channel), 0);
> >  }
> 
> I find the set_duty() function quite hard to follow.
> Can we simplify this by eliminating the !staggered_outputs special case?
> E.g. always calculate and write 'on' and 'off'.
> But if !staggered_outputs => on = 0 and off = duty.
> 
> Yes this adds one extra/unnecessary register write in the !staggered case,
> but simplicity/maintainability >>> efficiency here. And this "issue" will
> disappear when we switch on regmap caching.

No objections, I will eliminate the special case.

> 
> >
> >  static unsigned int pca9685_pwm_get_duty(struct pca9685 *pca, int channel)
> >  {
> > -       unsigned int off_h, val;
> > +       unsigned int off, on, val;
> >
> >         if (WARN_ON(channel >= PCA9685_MAXCHAN)) {
> >                 /* Hardware readout not supported for "all LEDs" channel */
> >                 return 0;
> >         }
> >
> > -       regmap_read(pca->regmap, LED_N_OFF_H(channel), &off_h);
> > -       if (off_h & LED_FULL) {
> > +       regmap_read(pca->regmap, LED_N_OFF_H(channel), &off);
> > +       if (off & LED_FULL) {
> >                 /* Full OFF bit is set */
> >                 return 0;
> >         }
> >
> > -       regmap_read(pca->regmap, LED_N_ON_H(channel), &val);
> > -       if (val & LED_FULL) {
> > +       regmap_read(pca->regmap, LED_N_ON_H(channel), &on);
> > +       if (on & LED_FULL) {
> >                 /* Full ON bit is set */
> >                 return PCA9685_COUNTER_RANGE;
> >         }
> >
> >         regmap_read(pca->regmap, LED_N_OFF_L(channel), &val);
> > -       return ((off_h & 0xf) << 8) | (val & 0xff);
> > +       off = ((off & 0xf) << 8) | (val & 0xff);
> > +
> > +       if (pca->staggered_outputs) {
> > +               regmap_read(pca->regmap, LED_N_ON_L(channel), &val);
> > +               on = ((on & 0xf) << 8) | (val & 0xff);
> > +
> > +               if (off >= on)
> > +                       return off - on;
> > +               else
> > +                       return off + PCA9685_COUNTER_RANGE - on;
> 
> I think the if/else is unnecessary. unsigned int is twos-complement,
> so we can just write:
> 
>         return (off - on) & 0xfff; (or PCA9685_COUNTER_RANGE - 1)
> 
> and it will "magically" work even if off < on.

Ah, yes of course. Good catch!

> 
> 
> > +       }
> > +
> > +       return off;
> >  }
> 
> As in set_duty(), consider removing the !staggered_outputs special case,
> to make this function clearer and simpler.

Yes, thanks.

> 
> >
> >  #if IS_ENABLED(CONFIG_GPIOLIB)
> > @@ -442,6 +477,9 @@ static int pca9685_pwm_probe(struct i2c_client *client,
> >
> >         regmap_write(pca->regmap, PCA9685_MODE2, reg);
> >
> > +       pca->staggered_outputs = device_property_read_bool(
> > +               &client->dev, "nxp,staggered-outputs");
> > +
> >         /* Disable all LED ALLCALL and SUBx addresses to avoid bus collisions */
> >         regmap_read(pca->regmap, PCA9685_MODE1, &reg);
> >         reg &= ~(MODE1_ALLCALL | MODE1_SUB1 | MODE1_SUB2 | MODE1_SUB3);
> > --
> > 2.29.2
> >
