Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2E07366DF8
	for <lists+linux-pwm@lfdr.de>; Wed, 21 Apr 2021 16:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243573AbhDUOUH (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 21 Apr 2021 10:20:07 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:57081 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243454AbhDUOTQ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 21 Apr 2021 10:19:16 -0400
Received: from localhost (lfbn-lyo-1-1676-55.w90-65.abo.wanadoo.fr [90.65.108.55])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 5121C240003;
        Wed, 21 Apr 2021 14:18:38 +0000 (UTC)
Date:   Wed, 21 Apr 2021 16:18:37 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, linux-pwm@vger.kernel.org,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org
Subject: Re: overflow and wrong timeout errors in pwm-atmel
Message-ID: <YIA0PXR+oxxpkrzL@piout.net>
References: <20210420095118.1571344-1-u.kleine-koenig@pengutronix.de>
 <20210421092606.1634092-1-u.kleine-koenig@pengutronix.de>
 <20210421110336.bd5s6e2kjxqilddi@pengutronix.de>
 <20210421134825.powx5tvqvce32fho@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210421134825.powx5tvqvce32fho@pengutronix.de>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 21/04/2021 15:48:25+0200, Uwe Kleine-König wrote:
> On Wed, Apr 21, 2021 at 01:03:36PM +0200, Uwe Kleine-König wrote:
> > On Wed, Apr 21, 2021 at 11:26:08AM +0200, Uwe Kleine-König wrote:
> > > With these three patches PWM_DEBUG is now happy. (At least I couldn't
> > > trigger a warning any more. I think there are still a few problems with
> > > integer overflows.)
> > 
> > BTW, setting the period to 138350580899 (with a clock rate of 133333333
> > Hz) results in setting period=0 because
> > 
> > 	state->period * clkrate =
> > 	138350580899 * 133333333 =
> > 	40254751 (discarded from 18446744073749806367).
> 
> As a first remedy the following could be done:
> 
> diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
> index 38d86340201c..02d69fa5f7d2 100644
> --- a/drivers/pwm/pwm-atmel.c
> +++ b/drivers/pwm/pwm-atmel.c
> @@ -199,6 +199,11 @@ static int atmel_pwm_calculate_cprd_and_pres(struct pwm_chip *chip,
>  	unsigned long long cycles = state->period;
>  	int shift;
>  
> +	if (fls(cycles) + fls(clkrate) > 64) {
> +		dev_err(chip->dev, "period to big to calculate HW parameters\n");
> +		return -EINVAL;
> +	}
> +
>  	/* Calculate the period cycles and prescale value */
>  	cycles *= clkrate;
>  	do_div(cycles, NSEC_PER_SEC);
> 
> Is this sensible? (Actually I'd prefer to just continue with
> 
> 	period = (ULL(1) << (64 - fls(clkrate))) - 1
> 
> according to the motto to yield the highest possible period, but this
> function has another error path that returns -EINVAL so this would be
> inconsistent.)

Shouldn't that be -ERANGE? I do think it is better to return an error
and let userspace decide what is the policy instead of having the policy
in the driver.


-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
