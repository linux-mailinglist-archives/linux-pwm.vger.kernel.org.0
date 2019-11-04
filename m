Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBE8CEE9AC
	for <lists+linux-pwm@lfdr.de>; Mon,  4 Nov 2019 21:34:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728409AbfKDUd5 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 4 Nov 2019 15:33:57 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:51129 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729614AbfKDUdt (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 4 Nov 2019 15:33:49 -0500
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1iRj2p-00051i-3m; Mon, 04 Nov 2019 21:33:47 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1iRj2o-00070j-61; Mon, 04 Nov 2019 21:33:46 +0100
Date:   Mon, 4 Nov 2019 21:33:46 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-pwm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        kernel@pengutronix.de
Subject: Re: [PATCH] gpio: pca953x: Add Maxim MAX7313 PWM support
Message-ID: <20191104203346.epdbzflnynh2gf3z@pengutronix.de>
References: <20191014124803.13661-1-miquel.raynal@bootlin.com>
 <CAHp75Vc4vnNVKc+Q_TY8DpwV4rLZYGm2MvGBC7r67XjmtNoskQ@mail.gmail.com>
 <20191015163055.0d8f44e5@xps13>
 <CAHp75VemkA7kap0O7=iACX4cD5_r6QXaLF6nS8R94ErStK0DwA@mail.gmail.com>
 <20191104161103.64995b8a@xps13>
 <CAMpxmJVjyUXSNFEiTxMC1bdzXTex74DqeiHPqLBPdnb2_LYRnQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMpxmJVjyUXSNFEiTxMC1bdzXTex74DqeiHPqLBPdnb2_LYRnQ@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello,

On Mon, Nov 04, 2019 at 04:32:23PM +0100, Bartosz Golaszewski wrote:
> pon., 4 lis 2019 o 16:11 Miquel Raynal <miquel.raynal@bootlin.com> napisał(a):
> > Andy Shevchenko <andy.shevchenko@gmail.com> wrote on Tue, 15 Oct 2019
> > 17:55:33 +0300:
> >
> > > Or other way around. PWM registers GPIO (which actually I prefer since
> > > we have PCA9685 case where PWM provides GPIO functionality, though via
> > > different means)
> > >
> >
> > Can I have your input on this proposal?
> >
> > On one hand I agree that the GPIO driver is already quite big due to
> > its genericity and the amount of controllers it supports, on the other
> > hand:
> > 1/ Registering a PWM driver from the GPIO core seems strange. Maybe
> > registering a platform device could do the trick but I am not convinced
> > it is worth the trouble.
> > 2/ Putting the PWM logic in the drivers/pwm/ directory is not very
> > convenient as the object file will have to be embedded within the GPIO
> > one; this line in drivers/gpio/Makefile would be horrible:
> > ... += gpio-pca953x.o ../pwm/pwm-max7313.o (not even sure it works)
> > 3/ In any cases, the regmap's ->readable_reg(), ->writable_reg()
> > callbacks shall be tweaked to turn the PWM registers accessible, so we
> > would still have PWM related code in the PCA953x GPIO driver.
> >
> > In the end, I wonder if keeping everything in one file is not better?
> > Eventually I can create a separate file and fill it with just the PWM
> > helpers/hooks. Please advise on the better solution for you, I'll wait
> > your feedback before addressing Thierry Reding's other review and
> > resubmit.
> >
> 
> I'm not sure if this has been discussed, but is it possible to create
> an MFD driver for this chip and conditionally plug in the GPIO part
> from pca953x? I don't like the idea of having PWM functionality in a
> GPIO driver either.

I didn't check the manual or driver in depth, but I guess it doesn't
match the MFD abstraction well. (That is, the PWM and GPIO parts live in
different address areas of the chip and can be used independently of
each other.)

While it's not nice to have a driver that provides two different devices
(here: gpio controller and pwm controller) similar things are not
unseen. And for example the splitting of watchdog
(drivers/watchdog/stmp3xxx_rtc_wdt.c) and rtc
(drivers/rtc/rtc-stmp3xxx.c) of the device in the mx28 is more trouble
than worth.

So I'd vote for putting it in a single file that lives where the
bigger/more complex part fits to. So assuming that's the GPIO part (as
the driver supports several variants and not all of them have a PWM
function if I'm not mistaken) having it in drivers/gpio is fine for me.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
