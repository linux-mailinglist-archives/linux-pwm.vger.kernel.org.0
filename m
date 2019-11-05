Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECDA8F001E
	for <lists+linux-pwm@lfdr.de>; Tue,  5 Nov 2019 15:44:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730852AbfKEOoY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pwm@lfdr.de>); Tue, 5 Nov 2019 09:44:24 -0500
Received: from relay12.mail.gandi.net ([217.70.178.232]:47597 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbfKEOoY (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 5 Nov 2019 09:44:24 -0500
Received: from xps13 (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 358F920000E;
        Tue,  5 Nov 2019 14:44:20 +0000 (UTC)
Date:   Tue, 5 Nov 2019 15:44:19 +0100
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
Message-ID: <20191105154419.11e7f625@xps13>
In-Reply-To: <CAHp75Ve6_8dXJgF6c2OdZDeV=icyRondvMKwTxhom-RXDACfUA@mail.gmail.com>
References: <20191014124803.13661-1-miquel.raynal@bootlin.com>
        <CAHp75Vc4vnNVKc+Q_TY8DpwV4rLZYGm2MvGBC7r67XjmtNoskQ@mail.gmail.com>
        <20191015163055.0d8f44e5@xps13>
        <CAHp75VemkA7kap0O7=iACX4cD5_r6QXaLF6nS8R94ErStK0DwA@mail.gmail.com>
        <20191104161103.64995b8a@xps13>
        <CAMpxmJVjyUXSNFEiTxMC1bdzXTex74DqeiHPqLBPdnb2_LYRnQ@mail.gmail.com>
        <20191104203346.epdbzflnynh2gf3z@pengutronix.de>
        <CAHp75VdULzZ6NXP7fp=6KQFAHOSvoJ-_WTqfcmhQJbrLUw3M4Q@mail.gmail.com>
        <20191105100157.2b6eb22b@xps13>
        <CAHp75Ve6_8dXJgF6c2OdZDeV=icyRondvMKwTxhom-RXDACfUA@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Andy,

Andy Shevchenko <andy.shevchenko@gmail.com> wrote on Tue, 5 Nov 2019
11:08:39 +0200:

> On Tue, Nov 5, 2019 at 11:02 AM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> > Andy Shevchenko <andy.shevchenko@gmail.com> wrote on Tue, 5 Nov 2019
> > 09:06:37 +0200:  
> > > On Mon, Nov 4, 2019 at 10:33 PM Uwe Kleine-König
> > > <u.kleine-koenig@pengutronix.de> wrote:  
> 
> > > For me it sounds more likely that PWM is a *pin function* of a pin
> > > controller and actually this GPIO driver should be a pin controller
> > > with corresponding function(s).
> > >  
> >
> > Ok, thanks for the input, I will address Thierry's comments and
> > re-submit as a single file (same shape as in v1).  
> 
> Perhaps I have to be more clear. What I meant is that pin control
> should support PWM pin function and PCA953x be converted to a pin
> control + GPIO + PWM.
> Above definitely is not what you did and it's not for immediate submission.

Sorry for the misunderstanding, I was answering Uwe.

> I really would like to hear if it makes sense.

While this would probably be the nicest and cleanest solution, I don't
think it is doable in a reasonable amount of time compared to the
benefits.


Thanks,
Miquèl
