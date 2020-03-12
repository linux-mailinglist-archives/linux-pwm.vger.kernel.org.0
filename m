Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E529818293C
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Mar 2020 07:40:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387898AbgCLGkr (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 12 Mar 2020 02:40:47 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:46345 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387862AbgCLGkr (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 12 Mar 2020 02:40:47 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1jCHWN-0008Mo-GT; Thu, 12 Mar 2020 07:40:43 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1jCHWN-0003bp-0t; Thu, 12 Mar 2020 07:40:43 +0100
Date:   Thu, 12 Mar 2020 07:40:42 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Lokesh Vutla <lokeshvutla@ti.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        Sekhar Nori <nsekhar@ti.com>, Vignesh R <vigneshr@ti.com>
Subject: Re: [PATCH v3 4/5] pwm: omap-dmtimer: Do not disable pwm before
 changing period/duty_cycle
Message-ID: <20200312064042.p7himm3odxjyzroi@pengutronix.de>
References: <20200312042210.17344-1-lokeshvutla@ti.com>
 <20200312042210.17344-5-lokeshvutla@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200312042210.17344-5-lokeshvutla@ti.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, Mar 12, 2020 at 09:52:09AM +0530, Lokesh Vutla wrote:
> Only the Timer control register(TCLR) cannot be updated when the timer
> is running. Registers like Counter register(TCRR), loader register(TLDR),
> match register(TMAR) can be updated when the counter is running. Since
> TCLR is not updated in pwm_omap_dmtimer_config(), do not stop the
> timer for period/duty_cycle update.

I'm not sure what is sensible here. Stopping the PWM for a short period
is bad, but maybe emitting a wrong period isn't better. You can however
optimise it if only one of period or duty_cycle changes.

@Thierry, what is your position here? I tend to say a short stop is
preferable.

> Tested-by: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
> ---
>  drivers/pwm/pwm-omap-dmtimer.c | 21 +++++++--------------
>  1 file changed, 7 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-omap-dmtimer.c b/drivers/pwm/pwm-omap-dmtimer.c
> index 85b17b49980b..c56e7256e923 100644
> --- a/drivers/pwm/pwm-omap-dmtimer.c
> +++ b/drivers/pwm/pwm-omap-dmtimer.c
> @@ -19,6 +19,13 @@
>   * Limitations:
>   * - When PWM is stopped, timer counter gets stopped immediately. This
>   *   doesn't allow the current PWM period to complete and stops abruptly.
> + * - When PWM is running and changing both duty cycle and period,
> + *   we cannot prevent in software that the output might produce
> + *   a period with mixed settings. Especially when period/duty_cyle
> + *   is updated while the pwm pin is high, current pwm period/duty_cycle
> + *   can get updated as below based on the current timer counter:
> + *   	- period for current cycle =  current_period + new period
> + *   	- duty_cycle for current period = current period + new duty_cycle.

In case we stay with a short stop, adding something like:

 - The PWM has to be stopped for updates of both period and duty_cycle.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
