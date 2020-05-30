Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 059E61E8F56
	for <lists+linux-pwm@lfdr.de>; Sat, 30 May 2020 09:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728599AbgE3Hzk (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 30 May 2020 03:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725813AbgE3Hzj (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 30 May 2020 03:55:39 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1A7FC03E969
        for <linux-pwm@vger.kernel.org>; Sat, 30 May 2020 00:55:39 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1jewLA-00087q-S0; Sat, 30 May 2020 09:55:36 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1jewL8-0000hI-V9; Sat, 30 May 2020 09:55:34 +0200
Date:   Sat, 30 May 2020 09:55:34 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc:     linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Raymond Tan <raymond.tan@intel.com>,
        Felipe Balbi <balbi@kernel.org>
Subject: Re: [PATCH v2] pwm: Add DesignWare PWM Controller Driver
Message-ID: <20200530075534.jzmhgpykos5alsoe@pengutronix.de>
References: <20200508123233.712610-1-jarkko.nikula@linux.intel.com>
 <20200524201116.pc7jmffr6jxlwren@pengutronix.de>
 <4d2b00a9-7970-03b0-c842-4338ac160c43@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4d2b00a9-7970-03b0-c842-4338ac160c43@linux.intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello Jarkko,

On Fri, May 29, 2020 at 04:25:30PM +0300, Jarkko Nikula wrote:
> > > +	__dwc_pwm_set_enable(dwc, pwm->hwpwm, false);
> > > +	__dwc_pwm_configure(dwc, pwm->hwpwm, state->duty_cycle,
> > > +			    state->period);
> > > +	__dwc_pwm_set_enable(dwc, pwm->hwpwm, state->enabled);
> > 
> > Is it necessary to disable the hardware for reconfiguration? Please
> > document if disabling the hardware completes the currently running
> > period.
>
> I forgot also this from the changelog. I was testing this with a script
> toggling minor 1 step duty cycle changes back and forth in a 1 s loop using
> relatively long period (a few seconds IIRC) and didn't see differences with
> or without disabling. Not sure was that methodology correct.
> 
> However, usage flow in the spec says that timer must be disabled before
> writing load counter registers "in order to avoid potential synchronization
> problems" so best to document it here.

Yes, then disabling and telling why is the right path. Also the question
about completion is interesting (to me at least). So if you configure
for say

	.duty_cycle = 1s
	.period = 4s

at time A and then immediately after that (at time B) configure:

	.duty_cycle = 3s
	.period = 4s

the optimal result would look as follows:


	      _____                   _________________       ____
	_____/     \_________________/                 \_____/
	     ^                       ^                       ^
	    A    B

(with ^ marking the start of a period).

That is we get (at least) one complete period of 4s with the first
setting before the second request is implemented by the hardware.

In practise for most hardware IP you usually get:

	      ______________________       _________________
	_____/                      \_____/                 \_____
	     ^    ^                       ^
	    A    B

or even:
	      ___  _________________       _________________
	_____/   \/                 \_____/                 \_____
	     ^    ^                       ^
	    A    B

. I'd like to see a comment explaining which case we're in with your
hardware.

> > > +static void dwc_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
> > > +			      struct pwm_state *state)
> > > +{
> > > +	struct dwc_pwm *dwc = to_dwc_pwm(chip);
> > > +	u64 duty, period;
> > > +
> > > +	pm_runtime_get_sync(dwc->dev);
> > > +
> > > +	state->enabled = !!(dwc_pwm_readl(dwc->base,
> > > +				DWC_TIM_CTRL(pwm->hwpwm)) & DWC_TIM_CTRL_EN);
> > > +
> > > +	duty = dwc_pwm_readl(dwc->base, DWC_TIM_LD_CNT2(pwm->hwpwm));
> > > +	duty += 1;
> > > +	duty *= dwc->clk_period_ns;
> > 
> > So the hardware doesn't support a zero duty_cycle? Please document this
> > in a Limitations paragraph as do some other drivers. (In the same format
> > please to make this easily greppable.)
> > 
> ...
> > And the hardware also doesn't support a 100% duty cycle? -> document
> > please.
>
> Yes to both. Will add.

Remember to do this in a greppable Limitiation paragraph as some other
drivers do, please.

> > > +	/* Cap the value to 2^32-1 ns */
> > > +	state->period = min(period, (u64)(u32)-1);
> > 
> > Instead of describing in the comment what you do, please tell why.
>
> Or, would it make sense to convert period and duty_cycle in PWM core to
> 64-bit? I'm fine to both commenting capping here or changing the period and
> duty to 64-bit.

There are efforts converting the internal representation to 64 bit, see
https://patchwork.ozlabs.org/project/linux-pwm/list/?series=179397

> > > +	ret = pcim_enable_device(pci);
> > > +	if (ret) {
> > > +		dev_err(&pci->dev, "Failed to enable device (%d)\n", ret);
> > 
> > Please use %pE for error codes.
>
> That (%pe I guess?) looks awesome! Will certainly add.

Indeed. (The series that introduced this had %dE in its v1, so I tend to
mix these up.) %pe is the right one.

> > > +		return ret;
> > > +	}
> > > +
> > > +	pci_set_master(pci);
> > > +
> > > +	ret = pcim_iomap_regions(pci, BIT(0), pci_name(pci));
> > > +	if (ret) {
> > > +		dev_err(&pci->dev, "Failed to iomap PCI BAR (%d)\n", ret);
> > 
> > Don't you need to undo pcim_enable_device?
>
> Yes for pci_enable_device(), pcim_enable_device() is the managed one.

Ah, TIL ...

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
