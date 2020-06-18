Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57EA21FFC36
	for <lists+linux-pwm@lfdr.de>; Thu, 18 Jun 2020 22:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730355AbgFRUFJ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 18 Jun 2020 16:05:09 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:51554 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730108AbgFRUFI (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 18 Jun 2020 16:05:08 -0400
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 18 Jun 2020 13:05:08 -0700
Received: from gurus-linux.qualcomm.com ([10.46.162.81])
  by ironmsg04-sd.qualcomm.com with ESMTP; 18 Jun 2020 13:05:07 -0700
Received: by gurus-linux.qualcomm.com (Postfix, from userid 383780)
        id CDCAE184A; Thu, 18 Jun 2020 13:05:07 -0700 (PDT)
Date:   Thu, 18 Jun 2020 13:05:07 -0700
From:   Guru Das Srinagesh <gurus@codeaurora.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Linux PWM List <linux-pwm@vger.kernel.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] video: ssd1307fb: Print PWM period using 64-bit
 format specifier
Message-ID: <20200618200507.GA2905@codeaurora.org>
References: <20200615141606.2814208-1-thierry.reding@gmail.com>
 <20200615141606.2814208-2-thierry.reding@gmail.com>
 <CAMuHMdWaKgNOz02eVXkFnGRpsjdNNGVtuCf0setigH31-9aXQg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdWaKgNOz02eVXkFnGRpsjdNNGVtuCf0setigH31-9aXQg@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, Jun 17, 2020 at 09:18:34AM +0200, Geert Uytterhoeven wrote:
> Hi Thierry,
> 
> On Mon, Jun 15, 2020 at 4:17 PM Thierry Reding <thierry.reding@gmail.com> wrote:
> > The PWM core will soon change the duty cycle and period of PWMs to 64
> > bits to allow for a broader range of values. Use a 64-bit format
> > specifier to avoid a warning when that change is made.
> >
> > Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
> 
> > --- a/drivers/video/fbdev/ssd1307fb.c
> > +++ b/drivers/video/fbdev/ssd1307fb.c
> > @@ -312,7 +312,7 @@ static int ssd1307fb_init(struct ssd1307fb_par *par)
> >                 /* Enable the PWM */
> >                 pwm_enable(par->pwm);
> >
> > -               dev_dbg(&par->client->dev, "Using PWM%d with a %dns period.\n",
> > +               dev_dbg(&par->client->dev, "Using PWM%d with a %lluns period.\n",
> >                         par->pwm->pwm, pwm_get_period(par->pwm));
> >         }
> 
> This change must be done together with changing the return type of
> pwm_get_period(), else you will get a compiler warning, and will print a
> bogus value.

Hi Geert,

Yes, this is already being done in the patch series [1] that forms the
base for this specific patch.

[1] https://lore.kernel.org/lkml/64f9ba1c9d6c49a397f12846493707883cee430f.1591136989.git.gurus@codeaurora.org/

Thank you.

Guru Das.
