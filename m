Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55866357644
	for <lists+linux-pwm@lfdr.de>; Wed,  7 Apr 2021 22:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231197AbhDGUr6 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 7 Apr 2021 16:47:58 -0400
Received: from mail.pqgruber.com ([52.59.78.55]:39958 "EHLO mail.pqgruber.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229586AbhDGUr5 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 7 Apr 2021 16:47:57 -0400
Received: from workstation.tuxnet (213-47-165-233.cable.dynamic.surfer.at [213.47.165.233])
        by mail.pqgruber.com (Postfix) with ESMTPSA id 98964C6B24A;
        Wed,  7 Apr 2021 22:47:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pqgruber.com;
        s=mail; t=1617828466;
        bh=ABMI0EjtBbX5kyaLQx8W5hqb07nbu/QgaIGt0Obbm7A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xkrCS7QRsSaS0nLAC91OgjhcPtmPAg7uODIsItOQ19L0/F5Ay0W8JHw58ubc8e77d
         sCB0uXAniAww2PIfOz8+zZsnaPShGuzIcoF6NwzLbTPMYaPdLUv2+tttq7onOJtj20
         c2tPI+/mMkabAQfCCzyok5TFSUcRT6xy9rzO7Imw=
Date:   Wed, 7 Apr 2021 22:47:45 +0200
From:   Clemens Gruber <clemens.gruber@pqgruber.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Sven Van Asbroeck <TheSven73@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 8/8] pwm: pca9685: Add error messages for failed
 regmap calls
Message-ID: <YG4acW/xZS2+/kDz@workstation.tuxnet>
References: <20210406164140.81423-1-clemens.gruber@pqgruber.com>
 <20210406164140.81423-8-clemens.gruber@pqgruber.com>
 <20210407061619.fl6ffos6csvgtnjh@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210407061619.fl6ffos6csvgtnjh@pengutronix.de>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, Apr 07, 2021 at 08:16:19AM +0200, Uwe Kleine-König wrote:
> On Tue, Apr 06, 2021 at 06:41:40PM +0200, Clemens Gruber wrote:
> > Regmap operations can fail if the underlying subsystem is not working
> > properly (e.g. hogged I2C bus, etc.)
> > As this is useful information for the user, print an error message if it
> > happens.
> > Let probe fail if the first regmap_read or the first regmap_write fails.
> > 
> > Signed-off-by: Clemens Gruber <clemens.gruber@pqgruber.com>
> > ---
> > Changes since v6:
> > - Rebased
> > 
> >  drivers/pwm/pwm-pca9685.c | 83 ++++++++++++++++++++++++++++-----------
> >  1 file changed, 59 insertions(+), 24 deletions(-)
> > 
> > diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
> > index cf0c98e4ef44..8a4993882b40 100644
> > --- a/drivers/pwm/pwm-pca9685.c
> > +++ b/drivers/pwm/pwm-pca9685.c
> > @@ -107,6 +107,30 @@ static bool pca9685_prescaler_can_change(struct pca9685 *pca, int channel)
> >  	return test_bit(channel, pca->pwms_enabled);
> >  }
> >  
> > +static int pca9685_read_reg(struct pca9685 *pca, unsigned int reg, unsigned int *val)
> > +{
> > +	struct device *dev = pca->chip.dev;
> > +	int err;
> > +
> > +	err = regmap_read(pca->regmap, reg, val);
> > +	if (err != 0)
> > +		dev_err(dev, "regmap_read of register 0x%x failed: %d\n", reg, err);
> 
> Please use %pe to emit the error code instead of %d.

Will do.

> 
> > +
> > +	return err;
> > +}
> > +
> > +static int pca9685_write_reg(struct pca9685 *pca, unsigned int reg, unsigned int val)
> > +{
> > +	struct device *dev = pca->chip.dev;
> > +	int err;
> > +
> > +	err = regmap_write(pca->regmap, reg, val);
> > +	if (err != 0)
> > +		dev_err(dev, "regmap_write to register 0x%x failed: %d\n", reg, err);
> > +
> > +	return err;
> > +}
> > +
> >  /* Helper function to set the duty cycle ratio to duty/4096 (e.g. duty=2048 -> 50%) */
> >  static void pca9685_pwm_set_duty(struct pca9685 *pca, int channel, unsigned int duty)
> >  {
> > @@ -115,12 +139,12 @@ static void pca9685_pwm_set_duty(struct pca9685 *pca, int channel, unsigned int
> >  
> >  	if (duty == 0) {
> >  		/* Set the full OFF bit, which has the highest precedence */
> > -		regmap_write(pca->regmap, REG_OFF_H(channel), LED_FULL);
> > +		pca9685_write_reg(pca, REG_OFF_H(channel), LED_FULL);
> 
> You didn't check all return codes? How did you select the calls to
> check?

No, because it would become a big mess and really obstruct readability
in my opinion.

So I chose some kind of middleground:
I decided to check the first regmap_read and regmap_write in probe and
return the error code if something goes wrong there.
If something goes wrong after probe, I only print an error message.

Is that acceptable?

Thanks,
Clemens
