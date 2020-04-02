Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 126BE19CAE1
	for <lists+linux-pwm@lfdr.de>; Thu,  2 Apr 2020 22:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387913AbgDBUQz (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 2 Apr 2020 16:16:55 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:57134 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729123AbgDBUQz (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 2 Apr 2020 16:16:55 -0400
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 02 Apr 2020 13:16:55 -0700
Received: from gurus-linux.qualcomm.com ([10.46.162.81])
  by ironmsg03-sd.qualcomm.com with ESMTP; 02 Apr 2020 13:16:54 -0700
Received: by gurus-linux.qualcomm.com (Postfix, from userid 383780)
        id 67DD14BDB; Thu,  2 Apr 2020 13:16:54 -0700 (PDT)
Date:   Thu, 2 Apr 2020 13:16:54 -0700
From:   Guru Das Srinagesh <gurus@codeaurora.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux PWM List <linux-pwm@vger.kernel.org>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Subbaraman Narayanamurthy <subbaram@codeaurora.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        David Collins <collinsd@codeaurora.org>
Subject: Re: [PATCH v11 06/12] pwm: imx27: Use 64-bit division macro and
 function
Message-ID: <20200402201654.GA9191@codeaurora.org>
References: <cover.1584667964.git.gurus@codeaurora.org>
 <5aae102e21c0e63ad2588ae1e174b48b06d25e96.1584667964.git.gurus@codeaurora.org>
 <CAK8P3a0qUMMMDmbp2FM-7D-U0Ys_zv0paYguFeyifafZurndEw@mail.gmail.com>
 <20200330204359.GB5107@codeaurora.org>
 <CAK8P3a1VC6+0Tydm=BoK2NvHB1ZCPjE1Gfi-sTE5O-xnu3Ya3A@mail.gmail.com>
 <20200331202058.GB25781@codeaurora.org>
 <20200331204929.GC2954599@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200331204929.GC2954599@ulmo>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, Mar 31, 2020 at 10:49:29PM +0200, Thierry Reding wrote:
> On Tue, Mar 31, 2020 at 01:20:58PM -0700, Guru Das Srinagesh wrote:
> > On Tue, Mar 31, 2020 at 05:24:52PM +0200, Arnd Bergmann wrote:
> > > On Mon, Mar 30, 2020 at 10:44 PM Guru Das Srinagesh
> > > <gurus@codeaurora.org> wrote:
> > > >
> > > > On Fri, Mar 20, 2020 at 06:09:39PM +0100, Arnd Bergmann wrote:
> > > > > On Fri, Mar 20, 2020 at 2:42 AM Guru Das Srinagesh <gurus@codeaurora.org> wrote:
> > > > >
> > > > > > @@ -240,8 +240,7 @@ static int pwm_imx27_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> > > > > >
> > > > > >         period_cycles /= prescale;
> > > > > >         c = (unsigned long long)period_cycles * state->duty_cycle;
> > > > > > -       do_div(c, state->period);
> > > > > > -       duty_cycles = c;
> > > > > > +       duty_cycles = div64_u64(c, state->period);
> > > > > >
> > > > >
> > > > > This change looks fine, but I wonder if the code directly above it
> > > > >
> > > > >         c = clk_get_rate(imx->clk_per);
> > > > >         c *= state->period;
> > > > >         do_div(c, 1000000000);
> > > > >         period_cycles = c;
> > > > >
> > > > > might run into an overflow when both the clock rate and the period
> > > > > are large numbers.
> > > >
> > > > Hmm. Seems to me like addressing this would be outside the scope of this
> > > > patch series.
> > > 
> > > I think it should be part of the same series, addressing bugs that
> > > were introduced
> > > by the change to 64-bit period. If it's not getting fixed along with
> > > the other regressions,
> > > I fear nobody is going to go back and fix it later.
> > 
> > Makes sense, I agree. Would this be an acceptable fix?
> > 
> > Instead of multiplying c and state->period first and then dividing by
> > 10^9, first divide state->period by 10^9 and then multiply the quotient
> > of that division with c and assign it to period_cycles. Like so:
> > 
> > 	c = clk_get_rate(imx->clk_per);
> > 	c *= div_u64(state->period, 1000000000);
> > 	period_cycles = c;
> > 
> > This should take care of overflow not happening because state->period is
> > converted from nanoseconds to seconds early on and so becomes a small
> > number.
> 
> Doesn't that mean that anything below a 1 second period will be clamped
> to just 0?

True. How about this then?

int pwm_imx27_calc_period_cycles(struct pwm_state state,
				 unsigned long clk_rate,
				 unsigned long *period_cycles)
{
	u64 c1, c2;

	c1 = clk_rate;
	c2 = state->period;
	if (c2 > c1) {
		c2 = c1;
		c1 = state->period;
	}

	if (!c1 || !c2) {
		pr_err("clk rate and period should be nonzero\n");
		return -EINVAL;
	}

	if (c2 <= div64_u64(U64_MAX, c1)) {
		c = c1 * c2;
		do_div(c, 1000000000);
	} else if (c2 <= div64_u64(U64_MAX, div64_u64(c1, 1000))) {
		do_div(c1, 1000);
		c = c1 * c2;
		do_div(c, 1000000);
	} else if (c2 <= div64_u64(U64_MAX, div64_u64(c1, 1000000))) {
		do_div(c1, 1000000);
		c = c1 * c2;
		do_div(c, 1000);
	} else if (c2 <= div64_u64(U64_MAX, div64_u64(c1, 1000000000))) {
		do_div(c1, 1000000000);
		c = c1 * c2;
	}

	*period_cycles = c;

	return 0;
}

...

ret = pwm_imx27_calc_period_cycles(state, clk_get_rate(imx->clk_per),
				   &period_cycles);
if (ret)
	return ret;

I unit tested this logic out by calculating period_cycles using both the
existing logic and the proposed one, and the results are as below.

--------------------------------------------------------------------------------
 clk_rate		period		  existing 	      proposed
--------------------------------------------------------------------------------
1000000000	18446744073709551615	 18446744072 	18446744073000000000
                      (U64_MAX)
--------------------------------------------------------------------------------
1000000000	     4294967291		 4294967291	    4294967291
--------------------------------------------------------------------------------

Overflow occurs in the first case with the existing logic, whereas the
proposed logic handles it correctly. As for the second case where there are
more typical values of period, the proposed logic handles that correctly
too.

Thank you.

Guru Das.
