Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9973718F0CF
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Mar 2020 09:25:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727581AbgCWIZq (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 23 Mar 2020 04:25:46 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:33171 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727565AbgCWIZp (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 23 Mar 2020 04:25:45 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1jGIOz-0004Ux-QJ; Mon, 23 Mar 2020 09:25:41 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1jGIOy-0007Z4-UY; Mon, 23 Mar 2020 09:25:40 +0100
Date:   Mon, 23 Mar 2020 09:25:40 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Yendapally Reddy Dhananjaya Reddy 
        <yendapally.reddy@broadcom.com>, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] pwm: bcm-iproc: handle clk_get_rate() return
Message-ID: <20200323082540.2gvbbxtwadvzeeos@pengutronix.de>
References: <20200323065318.16533-1-rayagonda.kokatanur@broadcom.com>
 <20200323065318.16533-2-rayagonda.kokatanur@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200323065318.16533-2-rayagonda.kokatanur@broadcom.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, Mar 23, 2020 at 12:23:17PM +0530, Rayagonda Kokatanur wrote:
> Handle clk_get_rate() returning <= 0 condition to avoid
> possible division by zero.

Was this noticed during a review and is more theoretic. Or does this
(depending on pre-boot state) result in a kernel crash?

> Fixes: daa5abc41c80 ("pwm: Add support for Broadcom iProc PWM controller")
> Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
> ---
>  drivers/pwm/pwm-bcm-iproc.c | 32 +++++++++++++++++++-------------
>  1 file changed, 19 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-bcm-iproc.c b/drivers/pwm/pwm-bcm-iproc.c
> index 1f829edd8ee7..8bbd2a04fead 100644
> --- a/drivers/pwm/pwm-bcm-iproc.c
> +++ b/drivers/pwm/pwm-bcm-iproc.c
> @@ -99,19 +99,25 @@ static void iproc_pwmc_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
>  	else
>  		state->polarity = PWM_POLARITY_INVERSED;
>  
> -	value = readl(ip->base + IPROC_PWM_PRESCALE_OFFSET);
> -	prescale = value >> IPROC_PWM_PRESCALE_SHIFT(pwm->hwpwm);
> -	prescale &= IPROC_PWM_PRESCALE_MAX;
> -
> -	multi = NSEC_PER_SEC * (prescale + 1);
> -
> -	value = readl(ip->base + IPROC_PWM_PERIOD_OFFSET(pwm->hwpwm));
> -	tmp = (value & IPROC_PWM_PERIOD_MAX) * multi;
> -	state->period = div64_u64(tmp, rate);
> -
> -	value = readl(ip->base + IPROC_PWM_DUTY_CYCLE_OFFSET(pwm->hwpwm));
> -	tmp = (value & IPROC_PWM_PERIOD_MAX) * multi;
> -	state->duty_cycle = div64_u64(tmp, rate);
> +	if (rate == 0) {
> +		state->period = 0;
> +		state->duty_cycle = 0;
> +	} else {
> +		value = readl(ip->base + IPROC_PWM_PRESCALE_OFFSET);
> +		prescale = value >> IPROC_PWM_PRESCALE_SHIFT(pwm->hwpwm);
> +		prescale &= IPROC_PWM_PRESCALE_MAX;
> +
> +		multi = NSEC_PER_SEC * (prescale + 1);
> +
> +		value = readl(ip->base + IPROC_PWM_PERIOD_OFFSET(pwm->hwpwm));
> +		tmp = (value & IPROC_PWM_PERIOD_MAX) * multi;
> +		state->period = div64_u64(tmp, rate);
> +
> +		value = readl(ip->base +
> +			      IPROC_PWM_DUTY_CYCLE_OFFSET(pwm->hwpwm));
> +		tmp = (value & IPROC_PWM_PERIOD_MAX) * multi;
> +		state->duty_cycle = div64_u64(tmp, rate);
> +	}

The change looks fine.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
