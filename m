Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58F4A1B81FD
	for <lists+linux-pwm@lfdr.de>; Sat, 25 Apr 2020 00:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbgDXWVb (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 24 Apr 2020 18:21:31 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:55410 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725874AbgDXWVb (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 24 Apr 2020 18:21:31 -0400
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 24 Apr 2020 15:21:30 -0700
Received: from gurus-linux.qualcomm.com ([10.46.162.81])
  by ironmsg03-sd.qualcomm.com with ESMTP; 24 Apr 2020 15:21:29 -0700
Received: by gurus-linux.qualcomm.com (Postfix, from userid 383780)
        id E22914C90; Fri, 24 Apr 2020 15:21:29 -0700 (PDT)
Date:   Fri, 24 Apr 2020 15:21:29 -0700
From:   Guru Das Srinagesh <gurus@codeaurora.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux PWM List <linux-pwm@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Subbaraman Narayanamurthy <subbaram@codeaurora.org>,
        David Collins <collinsd@codeaurora.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Shiyan <shc_work@mail.ru>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v13 04/11] pwm: clps711x: Cast period to u32 before use
 as divisor
Message-ID: <20200424222129.GC31118@codeaurora.org>
References: <cover.1587523702.git.gurus@codeaurora.org>
 <02ba64d8289bf84a8d140f5a3c38ed64a9474d3b.1587523702.git.gurus@codeaurora.org>
 <CAMuHMdVOPKWL9u_4QCvcBZKFrW-7aKZonXjODqUx9HwS=CF09g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdVOPKWL9u_4QCvcBZKFrW-7aKZonXjODqUx9HwS=CF09g@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, Apr 23, 2020 at 11:30:19AM +0200, Geert Uytterhoeven wrote:
> On Wed, Apr 22, 2020 at 5:00 AM Guru Das Srinagesh <gurus@codeaurora.org> wrote:
> > Since the PWM framework is switching struct pwm_args.period's datatype
> > to u64, prepare for this transition by typecasting it to u32.
> >
> > Also, since the dividend is still a 32-bit number, any divisor greater
> > than the numerator will cause the quotient to be zero, so return 0 in
> > that case to efficiently skip the division.
> >
> > Cc: Alexander Shiyan <shc_work@mail.ru>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> >
> > Signed-off-by: Guru Das Srinagesh <gurus@codeaurora.org>
> > ---
> >  drivers/pwm/pwm-clps711x.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/pwm/pwm-clps711x.c b/drivers/pwm/pwm-clps711x.c
> > index 924d39a..0d368ac 100644
> > --- a/drivers/pwm/pwm-clps711x.c
> > +++ b/drivers/pwm/pwm-clps711x.c
> > @@ -43,7 +43,10 @@ static void clps711x_pwm_update_val(struct clps711x_chip *priv, u32 n, u32 v)
> >  static unsigned int clps711x_get_duty(struct pwm_device *pwm, unsigned int v)
> >  {
> >         /* Duty cycle 0..15 max */
> > -       return DIV_ROUND_CLOSEST(v * 0xf, pwm->args.period);
> > +       if ((u32)pwm->args.period > (v * 0xf))
> 
> Shouldn't the cast be removed from the expression above?
> Else a period larger than or equal to 2^32 may be accepted, but truncated
> silently.  And even cause a division by zero error.

I agree. Will remove the cast in the next patchset.

Thank you.

Guru Das.
