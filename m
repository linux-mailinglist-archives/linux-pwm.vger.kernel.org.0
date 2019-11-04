Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F41B1EE33E
	for <lists+linux-pwm@lfdr.de>; Mon,  4 Nov 2019 16:11:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728356AbfKDPLH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pwm@lfdr.de>); Mon, 4 Nov 2019 10:11:07 -0500
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:56735 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727998AbfKDPLG (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 4 Nov 2019 10:11:06 -0500
X-Originating-IP: 86.250.200.211
Received: from xps13 (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 63294240015;
        Mon,  4 Nov 2019 15:11:04 +0000 (UTC)
Date:   Mon, 4 Nov 2019 16:11:03 +0100
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
Subject: Re: [PATCH] gpio: pca953x: Add Maxim MAX7313 PWM support
Message-ID: <20191104161103.64995b8a@xps13>
In-Reply-To: <CAHp75VemkA7kap0O7=iACX4cD5_r6QXaLF6nS8R94ErStK0DwA@mail.gmail.com>
References: <20191014124803.13661-1-miquel.raynal@bootlin.com>
        <CAHp75Vc4vnNVKc+Q_TY8DpwV4rLZYGm2MvGBC7r67XjmtNoskQ@mail.gmail.com>
        <20191015163055.0d8f44e5@xps13>
        <CAHp75VemkA7kap0O7=iACX4cD5_r6QXaLF6nS8R94ErStK0DwA@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Linus,

Andy Shevchenko <andy.shevchenko@gmail.com> wrote on Tue, 15 Oct 2019
17:55:33 +0300:

> On Tue, Oct 15, 2019 at 5:30 PM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> >
> > Hi Andy,
> >
> > Thanks for the feedback.
> >
> > Andy Shevchenko <andy.shevchenko@gmail.com> wrote on Mon, 14 Oct 2019
> > 20:59:01 +0300:
> >  
> > > On Mon, Oct 14, 2019 at 4:09 PM Miquel Raynal <miquel.raynal@bootlin.com> wrote:  
> > > >
> > > > The MAX7313 chip is fully compatible with the PCA9535 on its basic
> > > > functions but can also manage the intensity on each of its ports with
> > > > PWM. Each output is independent and may be tuned with 16 values (4
> > > > bits per output). The period is always 32kHz, only the duty-cycle may
> > > > be changed. One can use any output as GPIO or PWM.  
> > >
> > > Can we rather not contaminate driver with this?
> > >
> > > Just register a separate PWM driver and export its functionality to
> > > GPIO, or other way around (in the latter case we actually have PCA8685
> > > which provides a GPIO fgunctionality).
> > >  
> >
> > I understand your concern but I am not sure to understand which
> > solution you have in mind. In the former case, could you explain a bit
> > more what you are thinking about? Would linking the PWM support with
> > the GPIO driver (code would be located in another .c file) work for
> > you? Or maybe you would prefer an MFD on top of the GPIO driver?
> >
> > As for the later case, I am not willing to re-implement GPIO support in
> > an alternate driver for an already supported chip, it is too much work
> > for the time I can spend on it.  
> 
> 
> drivers/pwm/pwm-max7313.c:
> 
> probe(platform_device)
> {
>   struct regmap = pdata;
>   ...
> }
> 
> --- 8< --- 8< ---
> drivers/gpio/gpio-pca953x.c:
> 
> probe()
> {
>   struct regmap rm;
> ...
>   if (dev_has_pwm)
>    pca953x_register_pwm_driver(rm);
> ...
> }
> 
> In the above regmap may be replaced with some (shared) container.
> 
> Or other way around. PWM registers GPIO (which actually I prefer since
> we have PCA9685 case where PWM provides GPIO functionality, though via
> different means)
> 

Can I have your input on this proposal?

On one hand I agree that the GPIO driver is already quite big due to
its genericity and the amount of controllers it supports, on the other
hand:
1/ Registering a PWM driver from the GPIO core seems strange. Maybe
registering a platform device could do the trick but I am not convinced
it is worth the trouble.
2/ Putting the PWM logic in the drivers/pwm/ directory is not very
convenient as the object file will have to be embedded within the GPIO
one; this line in drivers/gpio/Makefile would be horrible:
... += gpio-pca953x.o ../pwm/pwm-max7313.o (not even sure it works)
3/ In any cases, the regmap's ->readable_reg(), ->writable_reg()
callbacks shall be tweaked to turn the PWM registers accessible, so we
would still have PWM related code in the PCA953x GPIO driver.

In the end, I wonder if keeping everything in one file is not better?
Eventually I can create a separate file and fill it with just the PWM
helpers/hooks. Please advise on the better solution for you, I'll wait
your feedback before addressing Thierry Reding's other review and
resubmit.


Thanks,
Miquèl
