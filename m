Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF38016A0BD
	for <lists+linux-pwm@lfdr.de>; Mon, 24 Feb 2020 09:56:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727323AbgBXIzg (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 24 Feb 2020 03:55:36 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:38849 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727553AbgBXIzg (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 24 Feb 2020 03:55:36 -0500
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1j69WW-00077v-B4; Mon, 24 Feb 2020 09:55:32 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1j69WV-0006J8-IS; Mon, 24 Feb 2020 09:55:31 +0100
Date:   Mon, 24 Feb 2020 09:55:31 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Lokesh Vutla <lokeshvutla@ti.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH 3/4] pwm: omap-dmtimer: Do not disable pwm before
 changing period/duty_cycle
Message-ID: <20200224085531.zab5ewr2nfi2shem@pengutronix.de>
References: <20200224052135.17278-1-lokeshvutla@ti.com>
 <20200224052135.17278-4-lokeshvutla@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200224052135.17278-4-lokeshvutla@ti.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello,

On Mon, Feb 24, 2020 at 10:51:34AM +0530, Lokesh Vutla wrote:
> Only the Timer control register(TCLR) can be updated only when the timer
> is stopped. Registers like Counter register(TCRR), loader register(TLDR),
> match register(TMAR) can be updated when the counter is running. Since
> TCLR is not updated in pwm_omap_dmtimer_config(), do not stop the
> timer for period/duty_cycle update.
> 
> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
> ---
>  drivers/pwm/pwm-omap-dmtimer.c | 14 --------------
>  1 file changed, 14 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-omap-dmtimer.c b/drivers/pwm/pwm-omap-dmtimer.c
> index f13be7216847..58c61559e72f 100644
> --- a/drivers/pwm/pwm-omap-dmtimer.c
> +++ b/drivers/pwm/pwm-omap-dmtimer.c
> @@ -102,7 +102,6 @@ static int pwm_omap_dmtimer_config(struct pwm_chip *chip,
>  	u32 load_value, match_value;
>  	struct clk *fclk;
>  	unsigned long clk_rate;
> -	bool timer_active;
>  
>  	dev_dbg(chip->dev, "requested duty cycle: %d ns, period: %d ns\n",
>  		duty_ns, period_ns);
> @@ -178,25 +177,12 @@ static int pwm_omap_dmtimer_config(struct pwm_chip *chip,
>  	load_value = (DM_TIMER_MAX - period_cycles) + 1;
>  	match_value = load_value + duty_cycles - 1;
>  
> -	/*
> -	 * We MUST stop the associated dual-mode timer before attempting to
> -	 * write its registers, but calls to omap_dm_timer_start/stop must
> -	 * be balanced so check if timer is active before calling timer_stop.
> -	 */
> -	timer_active = pm_runtime_active(&omap->dm_timer_pdev->dev);
> -	if (timer_active)
> -		omap->pdata->stop(omap->dm_timer);
> -
>  	omap->pdata->set_load(omap->dm_timer, true, load_value);
>  	omap->pdata->set_match(omap->dm_timer, true, match_value);

(Without having looked into the depths of the driver I assume
.set_load() sets the period of the PWM and .set_match() the duty cycle.)

What happens on a running PWM if you change the period? Consider you
change from duty_cycle = 1000, period = 5000 to duty_cycle = 4000,
period = 10000. As you set the period first, can it happen the hardware
produces a cycle with duty_cycle = 1000, period = 10000?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K�nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
