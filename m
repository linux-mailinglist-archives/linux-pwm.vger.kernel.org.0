Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB6CEEF7AE
	for <lists+linux-pwm@lfdr.de>; Tue,  5 Nov 2019 10:02:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730576AbfKEJCC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pwm@lfdr.de>); Tue, 5 Nov 2019 04:02:02 -0500
Received: from relay12.mail.gandi.net ([217.70.178.232]:55211 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727925AbfKEJCC (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 5 Nov 2019 04:02:02 -0500
Received: from xps13 (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 5CE50200012;
        Tue,  5 Nov 2019 09:01:58 +0000 (UTC)
Date:   Tue, 5 Nov 2019 10:01:57 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-pwm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Sascha Hauer <kernel@pengutronix.de>
Subject: Re: [PATCH] gpio: pca953x: Add Maxim MAX7313 PWM support
Message-ID: <20191105100157.2b6eb22b@xps13>
In-Reply-To: <CAHp75VdULzZ6NXP7fp=6KQFAHOSvoJ-_WTqfcmhQJbrLUw3M4Q@mail.gmail.com>
References: <20191014124803.13661-1-miquel.raynal@bootlin.com>
        <CAHp75Vc4vnNVKc+Q_TY8DpwV4rLZYGm2MvGBC7r67XjmtNoskQ@mail.gmail.com>
        <20191015163055.0d8f44e5@xps13>
        <CAHp75VemkA7kap0O7=iACX4cD5_r6QXaLF6nS8R94ErStK0DwA@mail.gmail.com>
        <20191104161103.64995b8a@xps13>
        <CAMpxmJVjyUXSNFEiTxMC1bdzXTex74DqeiHPqLBPdnb2_LYRnQ@mail.gmail.com>
        <20191104203346.epdbzflnynh2gf3z@pengutronix.de>
        <CAHp75VdULzZ6NXP7fp=6KQFAHOSvoJ-_WTqfcmhQJbrLUw3M4Q@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

Andy Shevchenko <andy.shevchenko@gmail.com> wrote on Tue, 5 Nov 2019
09:06:37 +0200:

> On Mon, Nov 4, 2019 at 10:33 PM Uwe Kleine-König
> <u.kleine-koenig@pengutronix.de> wrote:
> > On Mon, Nov 04, 2019 at 04:32:23PM +0100, Bartosz Golaszewski wrote:  
> > > pon., 4 lis 2019 o 16:11 Miquel Raynal <miquel.raynal@bootlin.com> napisał(a):  
> > > > Andy Shevchenko <andy.shevchenko@gmail.com> wrote on Tue, 15 Oct 2019
> > > > 17:55:33 +0300:
> > > >  
> > > > > Or other way around. PWM registers GPIO (which actually I prefer since
> > > > > we have PCA9685 case where PWM provides GPIO functionality, though via
> > > > > different means)  
> 
> > While it's not nice to have a driver that provides two different devices
> > (here: gpio controller and pwm controller) similar things are not
> > unseen. And for example the splitting of watchdog
> > (drivers/watchdog/stmp3xxx_rtc_wdt.c) and rtc
> > (drivers/rtc/rtc-stmp3xxx.c) of the device in the mx28 is more trouble
> > than worth.
> >
> > So I'd vote for putting it in a single file that lives where the
> > bigger/more complex part fits to. So assuming that's the GPIO part (as
> > the driver supports several variants and not all of them have a PWM
> > function if I'm not mistaken) having it in drivers/gpio is fine for me.  
> 
> For me it sounds more likely that PWM is a *pin function* of a pin
> controller and actually this GPIO driver should be a pin controller
> with corresponding function(s).
> 

Ok, thanks for the input, I will address Thierry's comments and
re-submit as a single file (same shape as in v1).

Kind regards,
Miquèl
