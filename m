Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 329A317C51C
	for <lists+linux-pwm@lfdr.de>; Fri,  6 Mar 2020 19:14:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbgCFSOr (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 6 Mar 2020 13:14:47 -0500
Received: from muru.com ([72.249.23.125]:59204 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726194AbgCFSOr (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 6 Mar 2020 13:14:47 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id D761D8027;
        Fri,  6 Mar 2020 18:15:31 +0000 (UTC)
Date:   Fri, 6 Mar 2020 10:14:43 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Lokesh Vutla <lokeshvutla@ti.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        Sekhar Nori <nsekhar@ti.com>, Vignesh R <vigneshr@ti.com>,
        Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v2 4/6] pwm: omap-dmtimer: Fix pwm disabling sequence
Message-ID: <20200306181443.GJ37466@atomide.com>
References: <20200228095651.32464-1-lokeshvutla@ti.com>
 <20200228095651.32464-5-lokeshvutla@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200228095651.32464-5-lokeshvutla@ti.com>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

* Lokesh Vutla <lokeshvutla@ti.com> [200228 09:58]:
> pwm_omap_dmtimer_disable() calls .stop callback which abruptly stops the
> timer counter. This doesn't complete the current pwm cycle and
> immediately disables the pwm. Instead disable the auto reload
> functionality which allows to complete the current pwm cycle and then
> disables the timer.
> 
> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
> ---
>  drivers/pwm/pwm-omap-dmtimer.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pwm/pwm-omap-dmtimer.c b/drivers/pwm/pwm-omap-dmtimer.c
> index bc338619232d..89b3c25d02b8 100644
> --- a/drivers/pwm/pwm-omap-dmtimer.c
> +++ b/drivers/pwm/pwm-omap-dmtimer.c
> @@ -93,8 +93,16 @@ static void pwm_omap_dmtimer_disable(struct pwm_chip *chip,
>  {
>  	struct pwm_omap_dmtimer_chip *omap = to_pwm_omap_dmtimer_chip(chip);
>  
> +	/*
> +	 * Disable auto reload so that the current cycle gets completed and
> +	 * then the counter stops.
> +	 */
>  	mutex_lock(&omap->mutex);
> -	omap->pdata->stop(omap->dm_timer);
> +	omap->pdata->set_pwm(omap->dm_timer,
> +			     pwm_get_polarity(pwm) == PWM_POLARITY_INVERSED,
> +			     true, OMAP_TIMER_TRIGGER_OVERFLOW_AND_COMPARE,
> +			     false);
> +
>  	mutex_unlock(&omap->mutex);
>  }

I'm seeing an issue with this patch where after use something is
left on and power consumption stays higher by about 30 mW after
use.

I can reproduce this easily on droid4 with Sebastian's rumble-test
app[0]. After use, I sometimes also hear the vibrator keep chirping
quietly, so there seems to be some pwm still happening after disable :)

Reloading modules for pwm-vibra and pwm-omap-dmtimer make the power
consumption go back down again.

If you have a scope set up, maybe check the lines are quiet after
disable after this patch?

Regards,

Tony


[0] https://git.collabora.com/cgit/user/sre/rumble-test.git/plain/rumble-test.c
