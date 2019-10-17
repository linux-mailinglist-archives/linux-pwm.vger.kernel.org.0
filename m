Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 007FADB838
	for <lists+linux-pwm@lfdr.de>; Thu, 17 Oct 2019 22:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403832AbfJQUZQ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 17 Oct 2019 16:25:16 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:58257 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731007AbfJQUZQ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 17 Oct 2019 16:25:16 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1iLCKg-0002Pi-93; Thu, 17 Oct 2019 22:25:14 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1iLCKf-000507-Ea; Thu, 17 Oct 2019 22:25:13 +0200
Date:   Thu, 17 Oct 2019 22:25:13 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Michal =?utf-8?B?Vm9rw6HEjQ==?= <michal.vokac@ysoft.com>,
        linux-pwm@vger.kernel.org,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, kernel@pengutronix.de,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Lee Jones <lee.jones@linaro.org>,
        Adam Ford <aford173@gmail.com>
Subject: Re: [PATCH] backlight: pwm_bl: configure pwm only once per backlight
 toggle
Message-ID: <20191017202513.r2nrkpig5vzq73lc@pengutronix.de>
References: <20191017081059.31761-1-u.kleine-koenig@pengutronix.de>
 <c89925bd-857d-874f-b74f-c5700d4c9fbd@ysoft.com>
 <20191017101116.3d5okxmto5coecad@pengutronix.de>
 <20191017111131.GB3122066@ulmo>
 <20191017120917.fcb7x4fq4tbl2iat@pengutronix.de>
 <20191017125932.GB3768303@ulmo>
 <aa73b430-527c-8066-ad9c-edab62a05fc9@ysoft.com>
 <20191017151437.GA85210@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191017151437.GA85210@ulmo>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello Thierry,

On Thu, Oct 17, 2019 at 05:14:37PM +0200, Thierry Reding wrote:
> On Thu, Oct 17, 2019 at 03:58:25PM +0200, Michal Vokáč wrote:
> > On 17. 10. 19 14:59, Thierry Reding wrote:
> > > On Thu, Oct 17, 2019 at 02:09:17PM +0200, Uwe Kleine-König wrote:
> > > > On Thu, Oct 17, 2019 at 01:11:31PM +0200, Thierry Reding wrote:
> > > > > On Thu, Oct 17, 2019 at 12:11:16PM +0200, Uwe Kleine-König wrote:
> > > > > > On Thu, Oct 17, 2019 at 11:48:08AM +0200, Michal Vokáč wrote:
> > > > > > > On 17. 10. 19 10:10, Uwe Kleine-König wrote:
> > > > > > > > A previous change in the pwm core (namely 01ccf903edd6 ("pwm: Let
> > > > > > > > pwm_get_state() return the last implemented state")) changed the
> > > > > > > > semantic of pwm_get_state() and disclosed an (as it seems) common
> > > > > > > > problem in lowlevel PWM drivers. By not relying on the period and duty
> > > > > > > > cycle being retrievable from a disabled PWM this type of problem is
> > > > > > > > worked around.
> > > > > > > > 
> > > > > > > > Apart from this issue only calling the pwm_get_state/pwm_apply_state
> > > > > > > > combo once is also more effective.
> > > > > > > > 
> > > > > > > > Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> > > > > > > > ---
> > > > > > > > Hello,
> > > > > > > > 
> > > > > > > > There are now two reports about 01ccf903edd6 breaking a backlight. As
> > > > > > > > far as I understand the problem this is a combination of the backend pwm
> > > > > > > > driver yielding surprising results and the pwm-bl driver doing things
> > > > > > > > more complicated than necessary.
> > > > > > > > 
> > > > > > > > So I guess this patch works around these problems. Still it would be
> > > > > > > > interesting to find out the details in the imx driver that triggers the
> > > > > > > > problem. So Adam, can you please instrument the pwm-imx27 driver to
> > > > > > > > print *state at the beginning of pwm_imx27_apply() and the end of
> > > > > > > > pwm_imx27_get_state() and provide the results?
> > > > > > > > 
> > > > > > > > Note I only compile tested this change.
> > > > > > > 
> > > > > > > Hi Uwe,
> > > > > > > I was just about to respond to the "pwm_bl on i.MX6Q broken on 5.4-RC1+"
> > > > > > > thread that I have a similar problem when you submitted this patch.
> > > > > > > 
> > > > > > > So here are my few cents:
> > > > > > > 
> > > > > > > My setup is as follows:
> > > > > > >   - imx6dl-yapp4-draco with i.MX6Solo
> > > > > > >   - backlight is controlled with inverted PWM signal
> > > > > > >   - max brightness level = 32, default brightness level set to 32 in DT.
> > > > > > > 
> > > > > > > 1. Almost correct backlight behavior before 01ccf903edd6 ("pwm: Let
> > > > > > >     pwm_get_state() return the last implemented state):
> > > > > > > 
> > > > > > >   - System boots to userspace and backlight is enabled all the time from
> > > > > > >     power up.
> > > > > > > 
> > > > > > >     $ dmesg | grep state
> > > > > > >     [    1.763381] get state end: -1811360608, enabled: 0
> > > > > > 
> > > > > > What is -1811360608? When I wrote "print *state" above, I thought about
> > > > > > something like:
> > > > > > 
> > > > > > 	pr_info("%s: period: %u, duty: %u, polarity: %d, enabled: %d",
> > > > > > 		__func__, state->period, state->duty_cycle, state->polarity, state->enabled);
> > > > > > 
> > > > > > A quick look into drivers/pwm/pwm-imx27.c shows that this is another
> > > > > > driver that yields duty_cycle = 0 when the hardware is off.
> > > > > 
> > > > > It seems to me like the best recourse to fix this for now would be to
> > > > > patch up the drivers that return 0 when the hardware is off by caching
> > > > > the currently configured duty cycle.
> > > > > 
> > > > > How about the patch below?
> > > > > 
> > > > > Thierry
> > > > > 
> > > > > --- >8 ---
> > > > >  From 15a52a7f1b910804fabd74a5882befd3f9d6bb37 Mon Sep 17 00:00:00 2001
> > > > > From: Thierry Reding <thierry.reding@gmail.com>
> > > > > Date: Thu, 17 Oct 2019 12:56:00 +0200
> > > > > Subject: [PATCH] pwm: imx27: Cache duty cycle register value
> > > > > 
> > > > > The hardware register containing the duty cycle value cannot be accessed
> > > > > when the PWM is disabled. This causes the ->get_state() callback to read
> > > > > back a duty cycle value of 0, which can confuse consumer drivers.
> > > > > 
> > > > > Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
> > > > > ---
> > > > >   drivers/pwm/pwm-imx27.c | 31 ++++++++++++++++++++++++-------
> > > > >   1 file changed, 24 insertions(+), 7 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/pwm/pwm-imx27.c b/drivers/pwm/pwm-imx27.c
> > > > > index ae11d8577f18..4113d5cd4c62 100644
> > > > > --- a/drivers/pwm/pwm-imx27.c
> > > > > +++ b/drivers/pwm/pwm-imx27.c
> > > > > @@ -85,6 +85,13 @@ struct pwm_imx27_chip {
> > > > >   	struct clk	*clk_per;
> > > > >   	void __iomem	*mmio_base;
> > > > >   	struct pwm_chip	chip;
> > > > > +
> > > > > +	/*
> > > > > +	 * The driver cannot read the current duty cycle from the hardware if
> > > > > +	 * the hardware is disabled. Cache the last programmed duty cycle
> > > > > +	 * value to return in that case.
> > > > > +	 */
> > > > > +	unsigned int duty_cycle;
> > > > >   };
> > > > >   #define to_pwm_imx27_chip(chip)	container_of(chip, struct pwm_imx27_chip, chip)
> > > > > @@ -155,14 +162,17 @@ static void pwm_imx27_get_state(struct pwm_chip *chip,
> > > > >   	tmp = NSEC_PER_SEC * (u64)(period + 2);
> > > > >   	state->period = DIV_ROUND_CLOSEST_ULL(tmp, pwm_clk);
> > > > > -	/* PWMSAR can be read only if PWM is enabled */
> > > > > -	if (state->enabled) {
> > > > > +	/*
> > > > > +	 * PWMSAR can be read only if PWM is enabled. If the PWM is disabled,
> > > > > +	 * use the cached value.
> > > > > +	 */
> > > > > +	if (state->enabled)
> > > > >   		val = readl(imx->mmio_base + MX3_PWMSAR);
> > > > > -		tmp = NSEC_PER_SEC * (u64)(val);
> > > > > -		state->duty_cycle = DIV_ROUND_CLOSEST_ULL(tmp, pwm_clk);
> > > > > -	} else {
> > > > > -		state->duty_cycle = 0;
> > > > > -	}
> > > > > +	else
> > > > > +		val = imx->duty_cycle;
> > > > > +
> > > > > +	tmp = NSEC_PER_SEC * (u64)(val);
> > > > > +	state->duty_cycle = DIV_ROUND_CLOSEST_ULL(tmp, pwm_clk);
> > > > >   	if (!state->enabled)
> > > > >   		pwm_imx27_clk_disable_unprepare(chip);
> > > > > @@ -261,6 +271,13 @@ static int pwm_imx27_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> > > > >   		writel(duty_cycles, imx->mmio_base + MX3_PWMSAR);
> > > > >   		writel(period_cycles, imx->mmio_base + MX3_PWMPR);
> > > > > +		/*
> > > > > +		 * Store the duty cycle for future reference in cases where
> > > > > +		 * the MX3_PWMSAR register can't be read (i.e. when the PWM
> > > > > +		 * is disabled).
> > > > > +		 */
> > > > > +		imx->duty_cycle = duty_cycles;
> > > > > +
> > > > 
> > > > I wonder if it would be more sensible to do this in the pwm core
> > > > instead. Currently there are two drivers known with this problem. I
> > > > wouldn't be surprised if there were more.
> > > 
> > > I've inspected all the drivers and didn't spot any beyond cros-ec and
> > > i.MX that have this problem. There's also no good way to do this in the
> > > core, because the core doesn't know whether or not the driver is capable
> > > of returning the correct duty cycle on hardare readout. So the core
> > > would have to rely on state->duty_cycle that is passed in, but then the
> > > offending commit becomes useless because the whole point was to return
> > > the state as written to hardware (rather than the software state which
> > > was being returned before that patch).
> > > 
> > > > If we want to move clients to not rely on .period and .duty_cycle for a
> > > > disabled PWM (do we?) a single change in the core is also beneficial
> > > > compared to fixing several lowlevel drivers.
> > > 
> > > These are really two orthogonal problems. We don't currently consider
> > > enabled = 0 to be equivalent to duty_cycle = 0 at an API level. I'm not
> > > prepared to do that at this point in the release cycle either.
> > > 
> > > What this here has shown is that we have at least two drivers that don't
> > > behave the way they are supposed to according to the API and they break
> > > consumers. If they break for pwm-backlight, it's possible that they will
> > > break for other consumers as well. So the right thing to do is fix the
> > > two drivers that are broken.
> > > 
> > > After -rc1 we no longer experiment. Instead we clean up the messes we've
> > > made. We can revisit the other points once mainline is fixed.
> > 
> > Hi Thierry,
> > I just tried your patch with v5.4-rc3 with this result:
> > 
> > root@hydraco:~# dmesg | grep pwm_
> > [    1.772089] pwm_imx27_get_state: period: 992970, duty: 0, polarity: 0, enabled: 0
> > [    4.938759] pwm_imx27_apply: period: 500000, duty: 0, polarity: 1, enabled: 0
> > [    4.947431] pwm_imx27_get_state: period: 992970, duty: 0, polarity: 0, enabled: 0
> 
> Okay... this is interesting. If I understand correctly, that first line
> here is where the initial hardware readout happens. The second one is
> the first time when the backlight is configured, so it sets period and
> polarity. But then for some reason when we read out after that to read
> what state was written... we see that actually nothing was written at
> all.
> 
> And we can see why in pwm_imx27_apply(): If the PWM is not enabled, we
> don't actually program any of the registers, so it's not a surprise that
> things fall apart.
> 
> > [    4.956484] pwm_imx27_apply: period: 992970, duty: 992970, polarity: 0, enabled: 0
> > [    4.965473] pwm_imx27_get_state: period: 992970, duty: 0, polarity: 0, enabled: 0
> > [    4.974410] pwm_imx27_apply: period: 992970, duty: 0, polarity: 0, enabled: 1
> > [    4.988617] pwm_imx27_get_state: period: 992970, duty: 0, polarity: 0, enabled: 1
> > 
> > Backlight is on with full brightness at this stage.
> > 
> > root@hydraco:/sys/class/backlight/backlight# cat brightness
> > 32
> > 
> > root@hydraco:/sys/class/backlight/backlight# echo 32 > brightness
> > [  153.386391] pwm_imx27_apply: period: 992970, duty: 992970, polarity: 0, enabled: 1
> > [  153.398311] pwm_imx27_get_state: period: 992970, duty: 992970, polarity: 0, enabled: 1
> > 
> > Backlight goes down.
> > 
> > root@hydraco:/sys/class/backlight/backlight# echo 1 > brightness
> > [  168.506261] pwm_imx27_apply: period: 992970, duty: 15576, polarity: 0, enabled: 1
> > [  168.518064] pwm_imx27_get_state: period: 992970, duty: 15576, polarity: 0, enabled: 1
> > 
> > Backlight goes up to almost full brightness.
> > 
> > root@hydraco:/sys/class/backlight/backlight# echo 0 > brightness
> > [  177.496265] pwm_imx27_apply: period: 992970, duty: 0, polarity: 0, enabled: 0
> > [  177.507602] pwm_imx27_get_state: period: 496485, duty: 7788, polarity: 0, enabled: 0
> > 
> > Backlight goes up to full brightness.
> > 
> > So your patch does not solve my issue.
> > 
> > The main problem I see is incorrect polarity setting. In my DT
> > the pwm-backlight consumer requests PWM_POLARITY_INVERTED and
> > period 500000ns. Though after reset the PWM HW registers are
> > configured to normal polarity. This initial setting is read out
> > and used by the consumer instead of the DT configuration.
> 
> So the problem with the i.MX driver is that it doesn't actually write
> the full state to the hardware and therefore the patch that caused these
> things to break reads back an incomplete state. So we've basically got
> two options: 1) make sure the hardware state is fully written or 2) make
> sure that we return the cached state.

My preference would be 3) make consumers not rely on .duty_cycle and
.period if the PWM is disabled. This questions of course the common
PWM idiom

	pwm_get_state(...)
	only = change(what, you, think, is, necessary);
	pwm_apply_state(...)

but I don't like this that much anyhow. YMMV.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
