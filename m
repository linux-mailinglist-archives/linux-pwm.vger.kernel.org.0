Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 155B9136801
	for <lists+linux-pwm@lfdr.de>; Fri, 10 Jan 2020 08:13:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725948AbgAJHNO (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 10 Jan 2020 02:13:14 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:44925 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbgAJHNO (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 10 Jan 2020 02:13:14 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ipoTj-0001U6-9h; Fri, 10 Jan 2020 08:13:07 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1ipoTi-00020H-LB; Fri, 10 Jan 2020 08:13:06 +0100
Date:   Fri, 10 Jan 2020 08:13:06 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     =?iso-8859-1?Q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Alex Mobigo <alex.mobigo@gmail.com>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org
Subject: Re: [PATCH] [RFC] pwm: sun4i: Move pwm_calculate out of spin_lock
Message-ID: <20200110071306.uyqcyftb4bt7b2gw@pengutronix.de>
References: <20200109233106.17060-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200109233106.17060-1-peron.clem@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello Clément,

On Fri, Jan 10, 2020 at 12:31:06AM +0100, Clément Péron wrote:
> pwm_calculate calls clk_get_rate while holding a spin_lock.
> 
> This create an issue as clk_get_rate() may sleep.

Slightly orthogonal to this issue, it might be a good idea to add a
might_sleep() to clk_get_rate(). (Added clk maintainers to Cc: for this
suggestion.)

> Move pwm_calculate out of this spin_lock.
> 
> Fixes: c32c5c50d4fe ("pwm: sun4i: Switch to atomic PWM")
> Reported-by: Alex Mobigo <alex.mobigo@gmail.com>
> Suggested-by: Vasily Khoruzhick <anarsoul@gmail.com>
> Signed-off-by: Clément Péron <peron.clem@gmail.com>
> ---
> 
> Hi,
> 
> this issue has been reported on linux-sunxi Google groups.
> 
> I don't have a board with PWM to confirm it.
> 
> Please wait a tested-by.
> 
> Thanks,
> Clément
> 
>  drivers/pwm/pwm-sun4i.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
> index 1afd41ebd3fd..6b230029dc49 100644
> --- a/drivers/pwm/pwm-sun4i.c
> +++ b/drivers/pwm/pwm-sun4i.c
> @@ -248,19 +248,18 @@ static int sun4i_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>  		}
>  	}
>  
> -	spin_lock(&sun4i_pwm->ctrl_lock);
> -	ctrl = sun4i_pwm_readl(sun4i_pwm, PWM_CTRL_REG);
> -
>  	ret = sun4i_pwm_calculate(sun4i_pwm, state, &duty, &period, &prescaler,
>  				  &bypass);
>  	if (ret) {
>  		dev_err(chip->dev, "period exceeds the maximum value\n");
> -		spin_unlock(&sun4i_pwm->ctrl_lock);
>  		if (!cstate.enabled)
>  			clk_disable_unprepare(sun4i_pwm->clk);
>  		return ret;
>  	}
>  
> +	spin_lock(&sun4i_pwm->ctrl_lock);
> +	ctrl = sun4i_pwm_readl(sun4i_pwm, PWM_CTRL_REG);
> +
>  	if (sun4i_pwm->data->has_direct_mod_clk_output) {
>  		if (bypass) {
>  			ctrl |= BIT_CH(PWM_BYPASS, pwm->hwpwm);

As sun4i_pwm_calculate does nothing that depends on (or modifies)
hardware state (apart from clk_get_rate(sun4i_pwm->clk) which can be
assumed to be constant) the change looks good.

Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
