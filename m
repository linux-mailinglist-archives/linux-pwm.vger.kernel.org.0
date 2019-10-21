Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BAD56DE8BC
	for <lists+linux-pwm@lfdr.de>; Mon, 21 Oct 2019 11:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727433AbfJUJ5R (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 21 Oct 2019 05:57:17 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:51807 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727328AbfJUJ5Q (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 21 Oct 2019 05:57:16 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1iMUR7-0004jG-Jp; Mon, 21 Oct 2019 11:57:13 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1iMUR6-00049N-Dq; Mon, 21 Oct 2019 11:57:12 +0200
Date:   Mon, 21 Oct 2019 11:57:12 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        linux-kernel@vger.kernel.org, heiko@sntech.de,
        dianders@chromium.org, mka@chromium.org, groeck@chromium.org,
        kernel@collabora.com, bleung@chromium.org,
        linux-pwm@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH] pwm: cros-ec: Let cros_ec_pwm_get_state() return the
 last applied state
Message-ID: <20191021095712.5tush7e7tlsfsbou@pengutronix.de>
References: <20191008203137.s22clq6v2om5ktio@pengutronix.de>
 <53b7d02b-1a2d-11da-fdd0-5378f360d876@collabora.com>
 <20191009095635.yysr33lnwldicyng@holly.lan>
 <20191009101637.gmvghwdvcmfw4yyk@pengutronix.de>
 <20191009104236.ux23ywnhvsym2qcb@holly.lan>
 <20191009112126.slpyxhnuqpiqgmes@pengutronix.de>
 <20191009113540.x6uxo3ryiuf7ql55@holly.lan>
 <49990b56-44f9-7c3c-ce81-ed295895f90a@collabora.com>
 <20191017113552.GC3122066@ulmo>
 <bb32d5f8-6915-d5f1-06ba-1cf0da99f6b1@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bb32d5f8-6915-d5f1-06ba-1cf0da99f6b1@collabora.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, Oct 21, 2019 at 11:42:05AM +0200, Enric Balletbo i Serra wrote:
> Hi Thierry,
> On 17/10/19 13:35, Thierry Reding wrote:
> > On Wed, Oct 09, 2019 at 03:47:43PM +0200, Enric Balletbo i Serra wrote:
> 
> [snip]
> 
> > 
> > --- >8 ---
> > From 15245e5f0dc02af021451b098df93901c9f49373 Mon Sep 17 00:00:00 2001
> > From: Thierry Reding <thierry.reding@gmail.com>
> > Date: Thu, 17 Oct 2019 13:21:15 +0200
> > Subject: [PATCH] pwm: cros-ec: Cache duty cycle value
> > 
> > The ChromeOS embedded controller doesn't differentiate between disabled
> > and duty cycle being 0. In order not to potentially confuse consumers,
> > cache the duty cycle and return the cached value instead of the real
> > value when the PWM is disabled.
> > 
> > Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
> > ---
> >  drivers/pwm/pwm-cros-ec.c | 58 ++++++++++++++++++++++++++++++++++++---
> >  1 file changed, 54 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/pwm/pwm-cros-ec.c b/drivers/pwm/pwm-cros-ec.c
> > index 89497448d217..09c08dee099e 100644
> > --- a/drivers/pwm/pwm-cros-ec.c
> > +++ b/drivers/pwm/pwm-cros-ec.c
> > @@ -25,11 +25,39 @@ struct cros_ec_pwm_device {
> >  	struct pwm_chip chip;
> >  };
> >  
> > +/**
> > + * struct cros_ec_pwm - per-PWM driver data
> > + * @duty_cycle: cached duty cycle
> > + */
> > +struct cros_ec_pwm {
> > +	u16 duty_cycle;
> > +};
> > +
> >  static inline struct cros_ec_pwm_device *pwm_to_cros_ec_pwm(struct pwm_chip *c)
> >  {
> >  	return container_of(c, struct cros_ec_pwm_device, chip);
> >  }
> >  
> > +static int cros_ec_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
> > +{
> > +	struct cros_ec_pwm *channel;
> > +
> > +	channel = kzalloc(sizeof(*channel), GFP_KERNEL);
> > +	if (!channel)
> > +		return -ENOMEM;
> > +
> > +	pwm_set_chip_data(pwm, channel);
> > +
> > +	return 0;
> > +}
> > +
> > +static void cros_ec_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
> > +{
> > +	struct cros_ec_pwm *channel = pwm_get_chip_data(pwm);
> > +
> > +	kfree(channel);
> > +}
> > +
> >  static int cros_ec_pwm_set_duty(struct cros_ec_device *ec, u8 index, u16 duty)
> >  {
> >  	struct {
> > @@ -96,7 +124,9 @@ static int cros_ec_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> >  			     const struct pwm_state *state)
> >  {
> >  	struct cros_ec_pwm_device *ec_pwm = pwm_to_cros_ec_pwm(chip);
> > -	int duty_cycle;
> > +	struct cros_ec_pwm *channel = pwm_get_chip_data(pwm);
> > +	u16 duty_cycle;
> > +	int ret;
> >  
> >  	/* The EC won't let us change the period */
> >  	if (state->period != EC_PWM_MAX_DUTY)
> > @@ -108,13 +138,20 @@ static int cros_ec_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> >  	 */
> >  	duty_cycle = state->enabled ? state->duty_cycle : 0;
> >  
> > -	return cros_ec_pwm_set_duty(ec_pwm->ec, pwm->hwpwm, duty_cycle);
> > +	ret = cros_ec_pwm_set_duty(ec_pwm->ec, pwm->hwpwm, duty_cycle);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	channel->duty_cycle = state->duty_cycle;
> > +
> > +	return 0;
> >  }
> >  
> >  static void cros_ec_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
> >  				  struct pwm_state *state)
> >  {
> >  	struct cros_ec_pwm_device *ec_pwm = pwm_to_cros_ec_pwm(chip);
> > +	struct cros_ec_pwm *channel = pwm_get_chip_data(pwm);
> >  	int ret;
> >  
> >  	ret = cros_ec_pwm_get_duty(ec_pwm->ec, pwm->hwpwm);
> > @@ -126,8 +163,19 @@ static void cros_ec_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
> >  	state->enabled = (ret > 0);
> >  	state->period = EC_PWM_MAX_DUTY;
> >  
> > -	/* Note that "disabled" and "duty cycle == 0" are treated the same */
> > -	state->duty_cycle = ret;
> > +	/*
> > +	 * Note that "disabled" and "duty cycle == 0" are treated the same. If
> > +	 * the cached duty cycle is not zero, used the cached duty cycle. This
> > +	 * ensures that the configured duty cycle is kept across a disable and
> > +	 * enable operation and avoids potentially confusing consumers.
> > +	 *
> > +	 * For the case of the initial hardware readout, channel->duty_cycle
> > +	 * will be 0 and the actual duty cycle read from the EC is used.
> > +	 */
> > +	if (ret == 0 && channel->duty_cycle > 0)
> > +		state->duty_cycle = channel->duty_cycle;
> > +	else
> > +		state->duty_cycle = ret;
> >  }
> >  
> >  static struct pwm_device *
> > @@ -149,6 +197,8 @@ cros_ec_pwm_xlate(struct pwm_chip *pc, const struct of_phandle_args *args)
> >  }
> >  
> >  static const struct pwm_ops cros_ec_pwm_ops = {
> > +	.request = cros_ec_pwm_request,
> > +	.free = cros_ec_pwm_free,
> >  	.get_state	= cros_ec_pwm_get_state,
> >  	.apply		= cros_ec_pwm_apply,
> >  	.owner		= THIS_MODULE,
> > 
> 
> I just tried your approach but I got a NULL pointer dereference while probe. I
> am just back from a week off but I'll be able to dig into it between today and
> tomorrow, just wanted to let you know that the patch doesn't works as is for me.
> 
> [   10.128455] Unable to handle kernel NULL pointer dereference at virtual
> address 0000000000000000
> [   10.141895] Mem abort info:
> 
> [   10.145090]   ESR = 0x96000004
> 
> [   10.148537]   EC = 0x25: DABT (current EL), IL = 32 bits
> 
> [   10.154560]   SET = 0, FnV = 0
> 
> [   10.157986]   EA = 0, S1PTW = 0
> 
> [   10.161548] Data abort info:
> 
> [   10.164804]   ISV = 0, ISS = 0x00000004
> 
> [   10.169111]   CM = 0, WnR = 0
> 
> [   10.172436] user pgtable: 4k pages, 48-bit VAs, pgdp=00000000ed44b000
> 
> [   10.179660] [0000000000000000] pgd=0000000000000000
> 
> [   10.179669] Internal error: Oops: 96000004 [#1] PREEMPT SMP
> 
> [   10.179673] Modules linked in: atmel_mxt_ts(+) rockchip_saradc pwm_cros_ec(+)
> rockchip_thermal pcie_rockchip_host snd_soc_rl6231 ip_tables x_
> tables ipv6 nf_defrag_ipv6
> 
> [   10.179694] CPU: 1 PID: 255 Comm: systemd-udevd Not tainted 5.4.0-rc4+ #230
> 
> [   10.179696] Hardware name: Google Kevin (DT)
> 
> [   10.179700] pstate: 60000005 (nZCv daif -PAN -UAO)
> 
> [   10.179714] pc : cros_ec_pwm_get_state+0xcc/0xf8 [pwm_cros_ec]
> 
> [   10.179721] lr : cros_ec_pwm_get_state+0x80/0xf8 [pwm_cros_ec]
> 
> [   10.247829] sp : ffff800012433810
> 
> [   10.251531] x29: ffff800012433810 x28: 0000000200000026
> 
> [   10.257469] x27: ffff800012433942 x26: ffff0000ef075010
> 
> [   10.263405] x25: ffff800011ca8508 x24: ffff800011e68e30
> 
> [   10.269341] x23: 0000000000000000 x22: ffff0000ee273190
> [   10.275278] x21: ffff0000ee2e3240 x20: ffff0000ee2e3270
> [   10.281214] x19: ffff800011bc98c8 x18: 0000000000000003
> [   10.287150] x17: 0000000000000007 x16: 000000000000000e
> [   10.293088] x15: 0000000000000001 x14: 0000000000000019
> [   10.299024] x13: 0000000000000033 x12: 0000000000000018
> [   10.304962] x11: 071c71c71c71c71c x10: 00000000000009d0
> [   10.310379] atmel_mxt_ts 5-004a: Family: 164 Variant: 17 Firmware V2.0.AA
> Objects: 31
> [   10.310901] x9 : ffff800012433490 x8 : ffff0000edb81830
> [   10.310905] x7 : 000000000000011b x6 : 0000000000000001
> [   10.310908] x5 : 0000000000000000 x4 : 0000000000000000
> [   10.310911] x3 : ffff0000edb80e00 x2 : 0000000000000002
> [   10.310914] x1 : 0000000000000000 x0 : 0000000000000000
> [   10.310918] Call trace:
> [   10.310931]  cros_ec_pwm_get_state+0xcc/0xf8 [pwm_cros_ec]
> [   10.310944]  pwmchip_add_with_polarity+0x134/0x290

The problem is that .get_state is called from the core without
requesting the pwm and so .request wasn't called before.

I still think it's wrong to cache the duty-cycle in the driver, but if
you still want to do it, .duty_cycle must go into the driver struct
which however is very inefficient given that probably most of the
machines don't actually have 255 PWMs.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
