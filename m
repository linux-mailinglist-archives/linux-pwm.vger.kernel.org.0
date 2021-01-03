Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F16B62E8D68
	for <lists+linux-pwm@lfdr.de>; Sun,  3 Jan 2021 18:05:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727236AbhACREy (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 3 Jan 2021 12:04:54 -0500
Received: from mail.pqgruber.com ([52.59.78.55]:57830 "EHLO mail.pqgruber.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726952AbhACREy (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sun, 3 Jan 2021 12:04:54 -0500
Received: from workstation.tuxnet (213-47-165-233.cable.dynamic.surfer.at [213.47.165.233])
        by mail.pqgruber.com (Postfix) with ESMTPSA id 1EE9DC68B88;
        Sun,  3 Jan 2021 18:04:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pqgruber.com;
        s=mail; t=1609693452;
        bh=5dqq/DsJwfVHsgRwxYYIC0zb6W8E9Tab6yx3XUhiPgk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZrhMgvCZoiIvHxr4i0+l4IoL7AL5J4mPkOi9NXMdTEW92fVjRmNmhO8DMvVOmeNAa
         DE4GKX1Mzy8vPzwj3OKG6dHGCiKpsUdlkJGEhfzlf0iVrPcMuJsy4Wd06LMYUcQ1g6
         HFFLguxQModKdMFhZXKgGPDRSo/EXQBObus0il/k=
Date:   Sun, 3 Jan 2021 18:04:10 +0100
From:   Clemens Gruber <clemens.gruber@pqgruber.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Sven Van Asbroeck <thesven73@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH v5 2/7] pwm: pca9685: Support hardware readout
Message-ID: <X/H5CqcRHelg5M4p@workstation.tuxnet>
References: <20201216125320.5277-1-clemens.gruber@pqgruber.com>
 <20201216125320.5277-2-clemens.gruber@pqgruber.com>
 <CAGngYiWkKZGkQ4TTTy8bQYvnGBK45V0A0JCe_+M5V+vuVU+zkQ@mail.gmail.com>
 <X9uYqGboZg5DuEtf@workstation.tuxnet>
 <CAGngYiUYOL6EF3VTGwcwTuN4EmE26ML3ye7689FTEpowjEcU2w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGngYiUYOL6EF3VTGwcwTuN4EmE26ML3ye7689FTEpowjEcU2w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi everyone,

happy new year, hope you are all well!

On Thu, Dec 17, 2020 at 12:52:42PM -0500, Sven Van Asbroeck wrote:
> On Thu, Dec 17, 2020 at 12:43 PM Clemens Gruber
> <clemens.gruber@pqgruber.com> wrote:
> > >
> > > Conclusion: .get_state() will always return "pwm disabled", so why do we
> > > bother reading out the h/w?
> >
> > If there are no plans for the PWM core to call .get_state more often in
> > the future, we could just read out the period and return 0 duty and
> > disabled.
> 
> I'm not sure why we should even read out the period?
> When a channel is disabled, the period is not externally visible,
> therefore it's meaningless ?
> 
> As far as I can tell, we can use this for .get_state():
> memset(&pwm->state, 0, sizeof(pwm_state));
> 
> >
> > Thierry, Uwe, what's your take on this?

I will continue working on this series in the upcoming weeks.
Feedback on the .get_state issue would be greatly appreciated.

To summarize:
Is it OK for a driver to expect the chip->ops->get_state function to be
only called from the place in pwm core it is currently called from?
(Namely in pwm_device_request after chip->ops->request)

If yes, we could always return a 0 duty cycle and disabled state,
because this is the state we left it in after .probe (and .free).

However, if in the future, the pwm core adds additional calls to
chip->ops->get_state in other places, this could lead to problems.

--

Another point is the period: Sven suggested we do not read out the
period at all, as the PWM is disabled anyway (see above).
Is this acceptable?

And, if we never return anything but 0 in .get_state, should it be
implemented at all?

> >
> > > Of course, if we choose to leave the pwm enabled after .free(), then
> > > .get_state() can even be left out! Do we want that? Genuine question, I do
> > > not know the answer.
> >
> > I do not think we should leave it enabled after free. It is less
> > complicated if we know that unrequested channels are not in use.
> >
> 
> Good point, I agree with you.

Thanks and best regards,
Clemens
