Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7752920FFB2
	for <lists+linux-pwm@lfdr.de>; Tue, 30 Jun 2020 23:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727819AbgF3V4O convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pwm@lfdr.de>); Tue, 30 Jun 2020 17:56:14 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:55991 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727050AbgF3V4O (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 30 Jun 2020 17:56:14 -0400
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id D85FB240008;
        Tue, 30 Jun 2020 21:56:10 +0000 (UTC)
Date:   Tue, 30 Jun 2020 23:56:09 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        linux-pwm@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6] gpio: pca953x: Add Maxim MAX7313 PWM support
Message-ID: <20200630235609.52611e41@xps13>
In-Reply-To: <CAHp75VcxQ-qK+RYmfULDx3cHQW9W8__-Gf8EFw7Hgqsz0oPkjA@mail.gmail.com>
References: <20200503105453.23658-1-miquel.raynal@bootlin.com>
        <20200629160844.6ecf79c1@xps13>
        <20200629195044.uvgma53cajiko3gf@pengutronix.de>
        <20200630085828.1aebdf99@xps13>
        <CAMpxmJUHy+5ynmsU6FhX=MJR6XbwoNr65NGqzuAd0Bm-JS1kWw@mail.gmail.com>
        <20200630124500.m765t276atb3wqgy@pengutronix.de>
        <CAHp75VcxQ-qK+RYmfULDx3cHQW9W8__-Gf8EFw7Hgqsz0oPkjA@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello,

Andy Shevchenko <andy.shevchenko@gmail.com> wrote on Wed, 1 Jul 2020
00:27:31 +0300:

> On Tue, Jun 30, 2020 at 3:45 PM Uwe Kleine-König
> <u.kleine-koenig@pengutronix.de> wrote:
> > On Tue, Jun 30, 2020 at 11:13:31AM +0200, Bartosz Golaszewski wrote:
> > > I can't find anything in any of the previous threads. What was the
> > > reason to not go the MFD way here?
> >
> > MFD doesn't work because the different "modes" are not orthogonal. So
> > this is not a single device that provides several functions at the same
> > time that can be used in parallel.
> 
> Did I get this correctly that it's either *all* pins are GPIO or *all* are PWM?
> 
> Otherwise, it fits from my point of view.
> 

Sorry for not being clear in the first place : the choice between
pure GPIO and PWM is on a per output basis. As Uwe said, the two
"modes" are not orthogonal hence the MFD does not fit here IMHO.

Thanks,
Miquèl
