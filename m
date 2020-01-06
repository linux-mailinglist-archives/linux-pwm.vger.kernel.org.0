Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55CBA131330
	for <lists+linux-pwm@lfdr.de>; Mon,  6 Jan 2020 14:44:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgAFNom convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pwm@lfdr.de>); Mon, 6 Jan 2020 08:44:42 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:38561 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726292AbgAFNol (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 6 Jan 2020 08:44:41 -0500
X-Originating-IP: 91.224.148.103
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 0EE02E000B;
        Mon,  6 Jan 2020 13:44:38 +0000 (UTC)
Date:   Mon, 6 Jan 2020 14:44:37 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-pwm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v4] gpio: pca953x: Add Maxim MAX7313 PWM support
Message-ID: <20200106144437.615698c1@xps13>
In-Reply-To: <CAHp75VeJNZWz_Cv=dozAwt74OBu8TgyYe5bNU3sHreRMdqxR8A@mail.gmail.com>
References: <20191129191023.2209-1-miquel.raynal@bootlin.com>
        <CAHp75VeJNZWz_Cv=dozAwt74OBu8TgyYe5bNU3sHreRMdqxR8A@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Andy,

> >  #define PCA_INT                        BIT(8)
> >  #define PCA_PCAL               BIT(9)  
> 
> > +#define MAX_PWM                        BIT(10)  
> 
> Use same prefix.

I am not sure it is relevant here, I think showing the specificity of
the MAXIM PWM is okay.

> 
> ...
> 
> > +#define PWM_MAX_COUNT 16
> > +#define PWM_PER_REG 2  
> 
> > +#define PWM_BITS_PER_REG (8 / PWM_PER_REG)  
> 
> Can we simple put 4 here?
> 

Fine

> ...
> 
> > +#define PWM_INTENSITY_MASK GENMASK(PWM_BITS_PER_REG - 1, 0)  
> 
> Please use plain numbers for the GENMASK() arguments.

Ok

> 
> ...
> 
> > +struct max7313_pwm_data {
> > +       struct gpio_desc *desc;
> > +};  
> 
> Are you plan to extend this? Can we directly use struct gpio_desc pointer?

I'm not a fan of this method at all, I think it is better practice to
keep a container in this case, which can be easily extended when needed.

> 
> ...
> 
> > +       if (PCA_CHIP_TYPE(chip->driver_data) == PCA953X_TYPE &&
> > +           chip->driver_data & MAX_PWM) {  
> 
> Can't we simple check only for a flag for now?

I don't get it. You just want the driver_data & MAX_PWM check?

> 
> > +               if (reg >= MAX7313_MASTER &&
> > +                   reg < (MAX7313_INTENSITY + bank_sz))
> > +                       return true;
> > +       }  
> 
> ...
> 
> > +       if (PCA_CHIP_TYPE(chip->driver_data) == PCA953X_TYPE &&
> > +           chip->driver_data & MAX_PWM) {
> > +               if (reg >= MAX7313_MASTER &&
> > +                   reg < (MAX7313_INTENSITY + bank_sz))
> > +                       return true;
> > +       }  
> 
> This is a duplicate from above. Need a helper?

Perhaps!

> 
> ...
> 
> > +/*
> > + * Max7313 PWM specific methods
> > + *
> > + * Limitations:
> > + * - Does not support a disabled state
> > + * - Period fixed to 31.25ms
> > + * - Only supports normal polarity
> > + * - Some glitches cannot be prevented
> > + */  
> 
> Can we have below in a separate file and attach it to the gpio-pca953x
> code iff CONFIG_PWM != n?

I'll check, why not.

> 
> ...
> 
> > +       mutex_lock(&pca_chip->i2c_lock);  
> 
> > +       regmap_read(pca_chip->regmap, reg, &val);  
> 
> No error check?
> 
> > +       mutex_unlock(&pca_chip->i2c_lock);  
> 
> ...
> 
> > +       if (shift)  
> 
> Redundant.

Ok

> 
> > +               val >>= shift;  
> 
> ...
> 
> > +       mutex_lock(&pca_chip->i2c_lock);
> > +       regmap_read(pca_chip->regmap, reg, &output);
> > +       mutex_unlock(&pca_chip->i2c_lock);  
> 
> No error check?
> 
> ...
> 
> > +       mutex_lock(&pca_chip->i2c_lock);
> > +       regmap_read(pca_chip->regmap, reg, &output);
> > +       mutex_unlock(&pca_chip->i2c_lock);  
> 
> No error check?
> 
> ...
> 
> > +static int max7313_pwm_request(struct pwm_chip *chip,
> > +                              struct pwm_device *pwm)
> > +{
> > +       struct max7313_pwm *max_pwm = to_max7313_pwm(chip);
> > +       struct pca953x_chip *pca_chip = to_pca953x(max_pwm);
> > +       struct max7313_pwm_data *data;
> > +       struct gpio_desc *desc;
> > +
> > +       desc = gpiochip_request_own_desc(&pca_chip->gpio_chip, pwm->hwpwm,
> > +                                        "max7313-pwm", GPIO_ACTIVE_HIGH, 0);
> > +       if (IS_ERR(desc)) {  
> 
> > +               dev_err(&pca_chip->client->dev,  
> 
> Can't we get to struct device easily?
> If it's possible maybe we could move next line to this one?

I'll try.

> 
> > +                       "pin already in use (probably as GPIO): %ld\n",
> > +                       PTR_ERR(desc));
> > +               return PTR_ERR(desc);
> > +       }  
> 
> > +       return 0;
> > +}  
> 
> ...
> 
> > +       if (intensity)
> > +               set_bit(pwm->hwpwm, max_pwm->active_pwm);
> > +       else
> > +               clear_bit(pwm->hwpwm, max_pwm->active_pwm);  
> 
> assign_bit()

Nice!

> 
> By the way, do you really need it to be atomic? Perhaps __asign_bit()?

Maybe not, indeed.

> 
> ...
> 
> > +       active = bitmap_weight(max_pwm->active_pwm, PWM_MAX_COUNT);  
> 
> > +       if (!active)  
> 
> In this case more readable will be active == 0 since you compare this
> to the exact value.
> 

"if (!active)" is read "if not active" which is IMHO very descriptive!

I'll correct most of your comments and send a v5.

Thanks,
Miquèl
