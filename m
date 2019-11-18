Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29E6DFFF63
	for <lists+linux-pwm@lfdr.de>; Mon, 18 Nov 2019 08:15:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbfKRHPn (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 18 Nov 2019 02:15:43 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:34955 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726551AbfKRHPn (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 18 Nov 2019 02:15:43 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1iWbG8-0003v1-60; Mon, 18 Nov 2019 08:15:40 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1iWbG6-0005ge-HV; Mon, 18 Nov 2019 08:15:38 +0100
Date:   Mon, 18 Nov 2019 08:15:38 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Thierry Reding <thierry.reding@gmail.com>, od@zcrc.me,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mathieu Malaterre <malat@debian.org>,
        Artur Rojek <contact@artur-rojek.eu>, kernel@pengutronix.de
Subject: Re: [PATCH v2 1/3] pwm: jz4740: Use clocks from TCU driver
Message-ID: <20191118071538.46egokrswvjxdvfp@pengutronix.de>
References: <20191116173613.72647-1-paul@crapouillou.net>
 <20191116173613.72647-2-paul@crapouillou.net>
 <20191117202028.4chgjv2kulyyq2eu@pengutronix.de>
 <1574031523.3.0@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1574031523.3.0@crapouillou.net>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello Paul,

On Sun, Nov 17, 2019 at 11:58:43PM +0100, Paul Cercueil wrote:
> Le dim., nov. 17, 2019 at 21:20, Uwe Kleine-König
> <u.kleine-koenig@pengutronix.de> a écrit :
> > On Sat, Nov 16, 2019 at 06:36:11PM +0100, Paul Cercueil wrote:
> > >  The ingenic-timer "TCU" driver provides us with clocks, that can be
> > >  (un)gated, reparented or reclocked from devicetree, instead of having
> > >  these settings hardcoded in this driver.
> > > 
> > >  While this driver is devicetree-compatible, it is never (as of now)
> > >  probed from devicetree, so this change does not introduce a ABI problem
> > >  with current devicetree files.
> > > 
> > >  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> > >  Tested-by: Mathieu Malaterre <malat@debian.org>
> > >  Tested-by: Artur Rojek <contact@artur-rojek.eu>
> > >  ---
> > > 
> > >  Notes:
> > >      v2: This patch is now before the patch introducing regmap, so
> > > the code
> > >          has changed a bit.
> > > 
> > >   drivers/pwm/Kconfig      |  1 +
> > >   drivers/pwm/pwm-jz4740.c | 45 ++++++++++++++++++++++++++++------------
> > >   2 files changed, 33 insertions(+), 13 deletions(-)
> > > 
> > >  diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> > >  index e3a2518503ed..e998e5cb01b0 100644
> > >  --- a/drivers/pwm/Kconfig
> > >  +++ b/drivers/pwm/Kconfig
> > >  @@ -225,6 +225,7 @@ config PWM_IMX_TPM
> > >   config PWM_JZ4740
> > >   	tristate "Ingenic JZ47xx PWM support"
> > >   	depends on MACH_INGENIC
> > >  +	depends on COMMON_CLK
> > >   	help
> > >   	  Generic PWM framework driver for Ingenic JZ47xx based
> > >   	  machines.
> > >  diff --git a/drivers/pwm/pwm-jz4740.c b/drivers/pwm/pwm-jz4740.c
> > >  index 9d78cc21cb12..fd83644f9323 100644
> > >  --- a/drivers/pwm/pwm-jz4740.c
> > >  +++ b/drivers/pwm/pwm-jz4740.c
> > >  @@ -24,7 +24,6 @@
> > > 
> > >   struct jz4740_pwm_chip {
> > >   	struct pwm_chip chip;
> > >  -	struct clk *clk;
> > 
> > What is the motivation to go away from this approach to store the clock?
> 
> It's actually not the same clock. Instead of obtaining "ext" clock from the
> probe, we obtain "timerX" clocks (X being the PWM channel) from the request
> callback.

Before you used driver data and container_of to get it, now you used
pwm_set_chip_data. I wondered why you changed the approach to store
data. That the actual data is different now is another thing (and
obviously ok).

> > >   };
> > > 
> > >   static inline struct jz4740_pwm_chip *to_jz4740(struct pwm_chip *chip)
> > >  @@ -34,6 +33,11 @@ static inline struct jz4740_pwm_chip *to_jz4740(struct pwm_chip *chip)
> > > 
> > >   static int jz4740_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
> > >   {
> > >  +	struct jz4740_pwm_chip *jz = to_jz4740(chip);
> > >  +	struct clk *clk;
> > >  +	char clk_name[16];
> > >  +	int ret;
> > >  +
> > >   	/*
> > >   	 * Timers 0 and 1 are used for system tasks, so they are unavailable
> > >   	 * for use as PWMs.
> > >  @@ -41,16 +45,31 @@ static int jz4740_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
> > >   	if (pwm->hwpwm < 2)
> > >   		return -EBUSY;
> > > 
> > >  -	jz4740_timer_start(pwm->hwpwm);
> > >  +	snprintf(clk_name, sizeof(clk_name), "timer%u", pwm->hwpwm);
> > >  +
> > >  +	clk = clk_get(chip->dev, clk_name);
> > >  +	if (IS_ERR(clk))
> > 
> > 		if (PTR_ERR(clk) != -EPROBE_DEFER)
> > 			dev_err(chip->dev, "Failed to get clock: %pe\n", clk);
> 
> Never heard about that %pe. Will do that.

Yeah, that's new and IMHO quite nice.
 
> > >  +		return PTR_ERR(clk);
> > >  +
> > >  +	ret = clk_prepare_enable(clk);
> > >  +	if (ret) {
> > >  +		clk_put(clk);
> > >  +		return ret;
> > >  +	}
> > >  +
> > >  +	pwm_set_chip_data(pwm, clk);
> > > 
> > >   	return 0;
> > >   }
> > > 
> > >   static void jz4740_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
> > >   {
> > >  +	struct clk *clk = pwm_get_chip_data(pwm);
> > >  +
> > >   	jz4740_timer_set_ctrl(pwm->hwpwm, 0);
> > 
> > What is the purpose of this call? I would have expected that all these
> > would go away when converting to the clk stuff?!
> 
> Some go away in patch [1/3] as they are clock-related, this one will go away
> in patch [2/3] when the driver is converted to use regmap.

I'd like to understand what it does. Judging from the name I expect this
is somehow related to the clock stuff and so I wonder if the conversion
to the clk API is as complete as it should be.

> > >  -	jz4740_timer_stop(pwm->hwpwm);
> > >  +	clk_disable_unprepare(clk);
> > >  +	clk_put(clk);
> > >   }
> > > 
> > >   static int jz4740_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
> > >  @@ -91,17 +110,21 @@ static int jz4740_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> > >   			    const struct pwm_state *state)
> > >   {
> > >   	struct jz4740_pwm_chip *jz4740 = to_jz4740(pwm->chip);
> > >  +	struct clk *clk = pwm_get_chip_data(pwm),
> > >  +		   *parent_clk = clk_get_parent(clk);
> > >  +	unsigned long rate, period, duty;
> > >   	unsigned long long tmp;
> > >  -	unsigned long period, duty;
> > >   	unsigned int prescaler = 0;
> > >   	uint16_t ctrl;
> > > 
> > >  -	tmp = (unsigned long long)clk_get_rate(jz4740->clk) * state->period;
> > >  +	rate = clk_get_rate(parent_clk);
> > 
> > Why is it the parent's rate that is relevant here?
> 
> We calculate the divider to be used for the "timerX" clock, so we need to
> know the parent clock.

Then the approach here is wrong. You should not assume anything about
the internal details of the clock, that's the task of the clock driver.
As a consumer of the clock just request a rate (or use clk_round_rate to
find a good setting first) and use that.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
