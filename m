Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87A711A04FE
	for <lists+linux-pwm@lfdr.de>; Tue,  7 Apr 2020 04:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbgDGCkQ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 6 Apr 2020 22:40:16 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:6109 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726353AbgDGCkP (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 6 Apr 2020 22:40:15 -0400
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 06 Apr 2020 19:40:14 -0700
Received: from gurus-linux.qualcomm.com ([10.46.162.81])
  by ironmsg01-sd.qualcomm.com with ESMTP; 06 Apr 2020 19:40:13 -0700
Received: by gurus-linux.qualcomm.com (Postfix, from userid 383780)
        id 8A2DF4BBC; Mon,  6 Apr 2020 19:40:13 -0700 (PDT)
Date:   Mon, 6 Apr 2020 19:40:13 -0700
From:   Guru Das Srinagesh <gurus@codeaurora.org>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     'Arnd Bergmann' <arnd@arndb.de>,
        Linux PWM List <linux-pwm@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Subbaraman Narayanamurthy <subbaram@codeaurora.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>
Subject: Re: [PATCH v11 11/12] clk: pwm: Assign u64 divisor to unsigned int
 before use
Message-ID: <20200407024013.GB7019@codeaurora.org>
References: <cover.1584667964.git.gurus@codeaurora.org>
 <ab7b568b1d287949276b3b1c9efdb1cad1f92004.1584667964.git.gurus@codeaurora.org>
 <CAK8P3a0XrYGYBQ_hTKF4fVBr7DDZsLnR+8o=09cig_gAje=v3w@mail.gmail.com>
 <9943d663c74046d798f4614343f25187@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9943d663c74046d798f4614343f25187@AcuMS.aculab.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, Mar 20, 2020 at 06:42:39PM +0000, David Laight wrote:
> From: Arnd Bergmann
> > Sent: 20 March 2020 17:01
> > On Fri, Mar 20, 2020 at 2:42 AM Guru Das Srinagesh <gurus@codeaurora.org> wrote:
> > >
> > > Since the PWM framework is switching struct pwm_args.period's datatype
> > > to u64, prepare for this transition by assigning the 64-bit divisor to
> > > an unsigned int variable to use as the divisor. This is being done
> > > because the divisor is a 32-bit constant and the quotient will be zero
> > > if the divisor exceeds 2^32.

Correction: The quotient will be zero when the denominator exceeds the
numerator, i.e. NSECS_PER_SEC, and not U32_MAX. For this to happen, the
property "clock-frequency" must be specified to be more than
NSEC_PER_SEC, i.e. 1 GHz. Just observed that currently in the device
tree, all instances of this driver (compatible string "pwm-clock") are
setting this property to values within that limit.

> > >
> > > Cc: Michael Turquette <mturquette@baylibre.com>
> > > Cc: Stephen Boyd <sboyd@kernel.org>
> > > Cc: linux-clk@vger.kernel.org
> > > Cc: David Laight <David.Laight@ACULAB.COM>
> > >
> > > Reported-by: kbuild test robot <lkp@intel.com>
> > > Signed-off-by: Guru Das Srinagesh <gurus@codeaurora.org>
> > > ---
> > >  drivers/clk/clk-pwm.c | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/clk/clk-pwm.c b/drivers/clk/clk-pwm.c
> > > index 87fe0b0e..c0b5da3 100644
> > > --- a/drivers/clk/clk-pwm.c
> > > +++ b/drivers/clk/clk-pwm.c
> > > @@ -72,6 +72,7 @@ static int clk_pwm_probe(struct platform_device *pdev)
> > >         struct pwm_device *pwm;
> > >         struct pwm_args pargs;
> > >         const char *clk_name;
> > > +       unsigned int period;
> > >         int ret;
> > >
> > >         clk_pwm = devm_kzalloc(&pdev->dev, sizeof(*clk_pwm), GFP_KERNEL);
> > > @@ -88,8 +89,9 @@ static int clk_pwm_probe(struct platform_device *pdev)
> > >                 return -EINVAL;
> > >         }
> > >
> > > +       period = pargs.period;
> > >         if (of_property_read_u32(node, "clock-frequency", &clk_pwm->fixed_rate))
> > > -               clk_pwm->fixed_rate = NSEC_PER_SEC / pargs.period;
> > > +               clk_pwm->fixed_rate = NSEC_PER_SEC / period;
> > >
> > >         if (pargs.period != NSEC_PER_SEC / clk_pwm->fixed_rate &&
> > >             pargs.period != DIV_ROUND_UP(NSEC_PER_SEC, clk_pwm->fixed_rate)) {
> > 
> > Doesn't this one need a check for "pargs.period>UINT_MAX" or
> > "pargs.period > NSEC_PER_SEC"?
> > 

With the assignment of period to unsigned int, wouldn't doing
s/pargs.period/period suffice?

Also, will add a check to ensure that clk_pwm->fixed_rate is non-zero. If it
is zero, fail probe.

> > It looks like truncating the 64-bit value to a 32-bit type can result in
> > unexpected behavior.
> 
> I also suspect the last two lines ought to use the 32bit copy.
> And there is a chance that the division will explode.

The check mentioned above will ensure that the division will not
explode.

What do you guys think?

Thank you.

Guru Das.
