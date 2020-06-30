Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA9620EEE4
	for <lists+linux-pwm@lfdr.de>; Tue, 30 Jun 2020 08:58:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730463AbgF3G6d convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pwm@lfdr.de>); Tue, 30 Jun 2020 02:58:33 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:46569 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbgF3G6d (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 30 Jun 2020 02:58:33 -0400
X-Originating-IP: 91.224.148.103
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id D812D6000A;
        Tue, 30 Jun 2020 06:58:29 +0000 (UTC)
Date:   Tue, 30 Jun 2020 08:58:28 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6] gpio: pca953x: Add Maxim MAX7313 PWM support
Message-ID: <20200630085828.1aebdf99@xps13>
In-Reply-To: <20200629195044.uvgma53cajiko3gf@pengutronix.de>
References: <20200503105453.23658-1-miquel.raynal@bootlin.com>
        <20200629160844.6ecf79c1@xps13>
        <20200629195044.uvgma53cajiko3gf@pengutronix.de>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

Uwe Kleine-König <u.kleine-koenig@pengutronix.de> wrote on Mon, 29 Jun
2020 21:50:44 +0200:

> On Mon, Jun 29, 2020 at 04:08:44PM +0200, Miquel Raynal wrote:
> > Hello Uwe, Thierry,
> > 
> > Miquel Raynal <miquel.raynal@bootlin.com> wrote on Sun,  3 May 2020
> > 12:54:53 +0200:
> >   
> > > The MAX7313 chip is fully compatible with the PCA9535 on its basic
> > > functions but can also manage the intensity on each of its ports with
> > > PWM. Each output is independent and may be tuned with 16 values (4
> > > bits per output). The period is always 32kHz, only the duty-cycle may
> > > be changed. One can use any output as GPIO or PWM.
> > > 
> > > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > > ---  
> > 
> > Can I have a status on this patch please?
> > 
> > If it was forgotten, I would be good to have it queued now, otherwise,
> > may I know the reason?  
> 
> You could reply to my feedback ... If you could say there: "What you
> want isn't possible" I'd count this as a strong indication to not ask to
> implement Andy's suggestion. (Even if this would be possible, I'm not
> sure this is a good idea, but still ...)

Sorry for the misunderstanding, but I already replied twice to Andy
about this. Once in October, again in November, then I gave a shot to
the idea of splitting the drivers (GPIO vs. PWM) in January. So I
thought you were sharing your thoughts out loud but was not expecting
any specific feedback on it.

So, no, even if the idea might make sense, it is not doable in a
reasonable amount of time. I am not saying it is impossible, but someone
has to think about it deeper and propose a core structure to handle it
in a generic and clean way so that other drivers sharing the same
properties can rely on it. I am not qualified enough to do it the proper
way in a reasonable time frame.

Thanks,
Miquèl
