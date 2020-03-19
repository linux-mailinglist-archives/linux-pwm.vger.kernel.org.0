Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57E7618C1E0
	for <lists+linux-pwm@lfdr.de>; Thu, 19 Mar 2020 21:53:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725787AbgCSUxJ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 19 Mar 2020 16:53:09 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:64684 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725817AbgCSUxI (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 19 Mar 2020 16:53:08 -0400
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 19 Mar 2020 13:53:08 -0700
Received: from gurus-linux.qualcomm.com ([10.46.162.81])
  by ironmsg05-sd.qualcomm.com with ESMTP; 19 Mar 2020 13:53:07 -0700
Received: by gurus-linux.qualcomm.com (Postfix, from userid 383780)
        id E84BE4B82; Thu, 19 Mar 2020 13:53:07 -0700 (PDT)
Date:   Thu, 19 Mar 2020 13:53:07 -0700
From:   Guru Das Srinagesh <gurus@codeaurora.org>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>,
        Subbaraman Narayanamurthy <subbaram@codeaurora.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
Subject: Re: [PATCH v8 01/12] clk: pwm: Use 64-bit division function
Message-ID: <20200319205307.GB17255@codeaurora.org>
References: <cover.1583889178.git.gurus@codeaurora.org>
 <338966686a673c241905716c90049993e7bb7d6a.1583889178.git.gurus@codeaurora.org>
 <7506bc2972324fd286dac6327ec73a3a@AcuMS.aculab.com>
 <20200312020938.GA14827@codeaurora.org>
 <fea86a43b28f4493abe0826654369513@AcuMS.aculab.com>
 <20200312190859.GA19605@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200312190859.GA19605@codeaurora.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, Mar 12, 2020 at 12:09:12PM -0700, Guru Das Srinagesh wrote:
> On Thu, Mar 12, 2020 at 09:14:09AM +0000, David Laight wrote:
> > From: Guru Das Srinagesh
> > > Sent: 12 March 2020 02:10
> > > On Wed, Mar 11, 2020 at 04:58:24PM +0000, David Laight wrote:
> > > > From: Guru Das Srinagesh
> > > > > Sent: 11 March 2020 01:41
> > > > >
> > > > > Since the PWM framework is switching struct pwm_args.period's datatype
> > > > > to u64, prepare for this transition by using div64_u64 to handle a
> > > > > 64-bit divisor.
> > > > >
> > ...
> > > > > --- a/drivers/clk/clk-pwm.c
> > > > > +++ b/drivers/clk/clk-pwm.c
> > > > > @@ -89,7 +89,7 @@ static int clk_pwm_probe(struct platform_device *pdev)
> > > > >  	}
> > > > >
> > > > >  	if (of_property_read_u32(node, "clock-frequency", &clk_pwm->fixed_rate))
> > > > > -		clk_pwm->fixed_rate = NSEC_PER_SEC / pargs.period;
> > > > > +		clk_pwm->fixed_rate = div64_u64(NSEC_PER_SEC, pargs.period);
> > > >
> > > > That cannot be needed, a 32 bit division is fine.
> > > 
> > > Could you please explain why? I think the use of this function is
> > > warranted in order to handle the division properly with a 64-bit
> > > divisor.
> > ...
> > > > I'd assign pargs.period to an 'unsigned int' variable
> > > > prior to the division (I hate casts - been bitten by them in the past.).
> > > 
> > > Wouldn't this truncate the 64-bit value? The intention behind this patch
> > > is to allow the processing of 64-bit values in full.
> > 
> > You are dividing a 32bit constant by a value.
> > If pargs.period is greater than 2^32 the result is zero.
> 
> Thanks for the explanation. 
> 
> > I think you divide by 'fixed_rate' a bit later on - better not be zero.
> 
> Good point, but this issue exists with or without this patch, and fixing
> it is beyond this patch's scope.
> 
> Just to check if this patch can be dropped, I tested out compilation
> with this patch reverted and there were no errors, so I'm leaning
> towards dropping this patch unless you have any further comments on how
> to proceed.

Turns out I couldn't drop this patch after all - kbuild test robot
complained [1]. Accordingly, I've brought this patch back in my v10
patchset with the modifications you suggested. Could you kindly review it?

[1] https://www.spinics.net/lists/linux-pwm/msg11906.html

Thank you.

Guru Das.
