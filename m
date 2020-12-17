Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFFFE2DD682
	for <lists+linux-pwm@lfdr.de>; Thu, 17 Dec 2020 18:47:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbgLQRqG (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 17 Dec 2020 12:46:06 -0500
Received: from mail.pqgruber.com ([52.59.78.55]:55984 "EHLO mail.pqgruber.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729285AbgLQRqG (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 17 Dec 2020 12:46:06 -0500
Received: from workstation.tuxnet (213-47-165-233.cable.dynamic.surfer.at [213.47.165.233])
        by mail.pqgruber.com (Postfix) with ESMTPSA id 0A1F4C727E0;
        Thu, 17 Dec 2020 18:45:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pqgruber.com;
        s=mail; t=1608227124;
        bh=RoE1euIuNMQzgC1ALLhy/pbhfHp1J1Yqi1exnRxa2Zw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p+XVpevS4Hf6zx1Kl+gHhvFV7kgdQVcTJ3Q1tydkRwaYpSW3IcJnrKmk4K0TKjcdS
         qXk4WLMutSMrrhbAsDf/lash62naZ3cfOAQdgPtiegnULNDr98iMOujUOiFGPIoUFx
         Vf5TpdZTH6BGLlrfR6wWCeAe09hpeeytkcBjm1J0=
Date:   Thu, 17 Dec 2020 18:45:22 +0100
From:   Clemens Gruber <clemens.gruber@pqgruber.com>
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        David Jander <david@protonic.nl>
Subject: Re: [PATCH v5 4/7] pwm: pca9685: Reset registers to POR state in
 probe
Message-ID: <X9uZMsjugJXbEfAO@workstation.tuxnet>
References: <20201215212228.185517-1-clemens.gruber@pqgruber.com>
 <20201215212228.185517-4-clemens.gruber@pqgruber.com>
 <CAGngYiUj-4mnJKQYnyJXmvr21tCzhXJA-bGnCwMkJ-0RTSYnNw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGngYiUj-4mnJKQYnyJXmvr21tCzhXJA-bGnCwMkJ-0RTSYnNw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, Dec 16, 2020 at 11:02:03PM -0500, Sven Van Asbroeck wrote:
> Hi Clemens, minor nit below.
> 
> On Wed, Dec 16, 2020 at 7:53 AM Clemens Gruber
> <clemens.gruber@pqgruber.com> wrote:
> >
> > Reset the prescale and ON/OFF registers to their POR default state in
> > the probe function. Otherwise, the PWMs could still be active after a
> > watchdog reset and reboot, etc.
> >
> > Signed-off-by: Clemens Gruber <clemens.gruber@pqgruber.com>
> > ---
> >  drivers/pwm/pwm-pca9685.c | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
> > index 7b14447f3c05..38aadaf50996 100644
> > --- a/drivers/pwm/pwm-pca9685.c
> > +++ b/drivers/pwm/pwm-pca9685.c
> > @@ -47,6 +47,7 @@
> >  #define PCA9685_ALL_LED_OFF_H  0xFD
> >  #define PCA9685_PRESCALE       0xFE
> >
> > +#define PCA9685_PRESCALE_DEF   0x1E    /* => default frequency of ~200 Hz */
> >  #define PCA9685_PRESCALE_MIN   0x03    /* => max. frequency of 1526 Hz */
> >  #define PCA9685_PRESCALE_MAX   0xFF    /* => min. frequency of 24 Hz */
> >
> > @@ -446,9 +447,11 @@ static int pca9685_pwm_probe(struct i2c_client *client,
> >         reg &= ~(MODE1_ALLCALL | MODE1_SUB1 | MODE1_SUB2 | MODE1_SUB3);
> >         regmap_write(pca->regmap, PCA9685_MODE1, reg);
> >
> > -       /* Clear all "full off" bits */
> > +       /* Reset ON/OFF registers to HW defaults (only full OFF bit is set) */
> > +       regmap_write(pca->regmap, PCA9685_ALL_LED_ON_L, 0);
> > +       regmap_write(pca->regmap, PCA9685_ALL_LED_ON_H, 0);
> >         regmap_write(pca->regmap, PCA9685_ALL_LED_OFF_L, 0);
> > -       regmap_write(pca->regmap, PCA9685_ALL_LED_OFF_H, 0);
> > +       regmap_write(pca->regmap, PCA9685_ALL_LED_OFF_H, LED_FULL);
> >
> >         pca->chip.ops = &pca9685_pwm_ops;
> >         /* Add an extra channel for ALL_LED */
> > @@ -470,8 +473,10 @@ static int pca9685_pwm_probe(struct i2c_client *client,
> >         /*
> >          * The chip comes out of power-up in the sleep state,
> >          * but force it to sleep in case it was woken up before
> > +        * and set the default prescale value
> >          */
> >         pca9685_set_sleep_mode(pca, true);
> > +       regmap_write(pca->regmap, PCA9685_PRESCALE, PCA9685_PRESCALE_DEF);
> >         pm_runtime_set_suspended(&client->dev);
> >         pm_runtime_enable(&client->dev);
> 
> Consider making it clearer that prescale can only be touched when the chip is
> in sleep mode. Suggestion:
> 
>     /* set the default prescale value - chip _must_ be in sleep mode */
>     regmap_write(pca->regmap, PCA9685_PRESCALE, PCA9685_PRESCALE_DEF);

Good point, thanks.

> 
> >
> > --
> > 2.29.2
> >
