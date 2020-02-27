Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E9031711E6
	for <lists+linux-pwm@lfdr.de>; Thu, 27 Feb 2020 09:04:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728441AbgB0IE4 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 27 Feb 2020 03:04:56 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:40973 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726999AbgB0IE4 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 27 Feb 2020 03:04:56 -0500
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1j7EA7-0003ca-9X; Thu, 27 Feb 2020 09:04:51 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1j7EA6-0004yp-Ki; Thu, 27 Feb 2020 09:04:50 +0100
Date:   Thu, 27 Feb 2020 09:04:50 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Sam Shih <sam.shih@mediatek.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        John Crispin <john@phrozen.org>, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 1/1] pwm: mediatek: add longer period support
Message-ID: <20200227080450.rkvwfjx6vikn5ls3@pengutronix.de>
References: <1582789610-23133-1-git-send-email-sam.shih@mediatek.com>
 <1582789610-23133-2-git-send-email-sam.shih@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1582789610-23133-2-git-send-email-sam.shih@mediatek.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, Feb 27, 2020 at 03:46:50PM +0800, Sam Shih wrote:
> The pwm clock source could be divided by 1625 with PWM_CON
> BIT(3) setting in mediatek hardware.
> 
> This patch add support for longer pwm period configuration,
> which allowing blinking LEDs via pwm interface.
> 
> Signed-off-by: Sam Shih <sam.shih@mediatek.com>
> ---
>  drivers/pwm/pwm-mediatek.c | 21 +++++++++++++++++----
>  1 file changed, 17 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
> index b94e0d09c300..9af309bea01a 100644
> --- a/drivers/pwm/pwm-mediatek.c
> +++ b/drivers/pwm/pwm-mediatek.c
> @@ -121,8 +121,8 @@ static int pwm_mediatek_config(struct pwm_chip *chip, struct pwm_device *pwm,
>  			       int duty_ns, int period_ns)
>  {
>  	struct pwm_mediatek_chip *pc = to_pwm_mediatek_chip(chip);
> -	u32 clkdiv = 0, cnt_period, cnt_duty, reg_width = PWMDWIDTH,
> -	    reg_thres = PWMTHRES;
> +	u32 clkdiv = 0, clksel = 0, cnt_period, cnt_duty,
> +	    reg_width = PWMDWIDTH, reg_thres = PWMTHRES;
>  	u64 resolution;
>  	int ret;
>  
Adding some more context:

> @@ -139,11 +139,20 @@ static int pwm_mediatek_config(struct pwm_chip *chip, struct pwm_device *pwm,
> 	while (cnt_period > 8191) {
>  		resolution *= 2;
>  		clkdiv++;
>  		cnt_period = DIV_ROUND_CLOSEST_ULL((u64)period_ns * 1000,
>  						   resolution);
> +		if (clkdiv > PWM_CLK_DIV_MAX && !clksel) {
> +			clksel = 1;
> +			clkdiv = 0;
> +			resolution = (u64)NSEC_PER_SEC * 1000 * 1625;
> +			do_div(resolution,
> +				clk_get_rate(pc->clk_pwms[pwm->hwpwm]));
> +			cnt_period = DIV_ROUND_CLOSEST_ULL(
> +					(u64)period_ns * 1000, resolution);

The assignment is a repetition from just above the if. Maybe just put it
once after this if block?

> +		}
>  	}
>  
> -	if (clkdiv > PWM_CLK_DIV_MAX) {
> +	if (clkdiv > PWM_CLK_DIV_MAX && clksel) {

Is this change actually relevant? If the while loop that starts at line
139 is never run (because cnt_period is <= 8191) clkdiv is zero and so
the condition is false with and without "&& clksel". If however the
while loop is entered and clkdiv becomes bigger than PWM_CLK_DIV_MAX
clksel is 1 and the "&& clksel" doesn't make a difference, too.

The code is hard to follow, I wonder if this could be cleaned up with
some comments added that explain the hardware details enough to be able
to actually understand the code without having the hardware reference
manual handy.

>  		pwm_mediatek_clk_disable(chip, pwm);
>  		dev_err(chip->dev, "period %d not supported\n", period_ns);
>  		return -EINVAL;
> @@ -159,7 +168,11 @@ static int pwm_mediatek_config(struct pwm_chip *chip, struct pwm_device *pwm,
>  	}
>  
>  	cnt_duty = DIV_ROUND_CLOSEST_ULL((u64)duty_ns * 1000, resolution);
> -	pwm_mediatek_writel(pc, pwm->hwpwm, PWMCON, BIT(15) | clkdiv);
> +	if (clksel)
> +		pwm_mediatek_writel(pc, pwm->hwpwm, PWMCON, BIT(15) | BIT(3) |
> +				    clkdiv);
> +	else
> +		pwm_mediatek_writel(pc, pwm->hwpwm, PWMCON, BIT(15) | clkdiv);
>  	pwm_mediatek_writel(pc, pwm->hwpwm, reg_width, cnt_period);
>  	pwm_mediatek_writel(pc, pwm->hwpwm, reg_thres, cnt_duty);
>  
> -- 
> 2.17.1

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
