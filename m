Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3010D7888
	for <lists+linux-pwm@lfdr.de>; Tue, 15 Oct 2019 16:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732614AbfJOOa6 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pwm@lfdr.de>); Tue, 15 Oct 2019 10:30:58 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:48333 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732087AbfJOOa6 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 15 Oct 2019 10:30:58 -0400
X-Originating-IP: 86.250.200.211
Received: from xps13 (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id C300D60014;
        Tue, 15 Oct 2019 14:30:55 +0000 (UTC)
Date:   Tue, 15 Oct 2019 16:30:55 +0200
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
Message-ID: <20191015163055.0d8f44e5@xps13>
In-Reply-To: <CAHp75Vc4vnNVKc+Q_TY8DpwV4rLZYGm2MvGBC7r67XjmtNoskQ@mail.gmail.com>
References: <20191014124803.13661-1-miquel.raynal@bootlin.com>
        <CAHp75Vc4vnNVKc+Q_TY8DpwV4rLZYGm2MvGBC7r67XjmtNoskQ@mail.gmail.com>
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

Thanks for the feedback.

Andy Shevchenko <andy.shevchenko@gmail.com> wrote on Mon, 14 Oct 2019
20:59:01 +0300:

> On Mon, Oct 14, 2019 at 4:09 PM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> >
> > The MAX7313 chip is fully compatible with the PCA9535 on its basic
> > functions but can also manage the intensity on each of its ports with
> > PWM. Each output is independent and may be tuned with 16 values (4
> > bits per output). The period is always 32kHz, only the duty-cycle may
> > be changed. One can use any output as GPIO or PWM.  
> 
> Can we rather not contaminate driver with this?
> 
> Just register a separate PWM driver and export its functionality to
> GPIO, or other way around (in the latter case we actually have PCA8685
> which provides a GPIO fgunctionality).
> 

I understand your concern but I am not sure to understand which
solution you have in mind. In the former case, could you explain a bit
more what you are thinking about? Would linking the PWM support with
the GPIO driver (code would be located in another .c file) work for
you? Or maybe you would prefer an MFD on top of the GPIO driver?

As for the later case, I am not willing to re-implement GPIO support in
an alternate driver for an already supported chip, it is too much work
for the time I can spend on it.


Thanks,
Miquèl
