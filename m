Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6C2378501
	for <lists+linux-pwm@lfdr.de>; Mon, 29 Jul 2019 08:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbfG2Ggk (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 29 Jul 2019 02:36:40 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:37251 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfG2Ggk (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 29 Jul 2019 02:36:40 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1hrzGq-0006RE-Jk; Mon, 29 Jul 2019 08:36:32 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1hrzGo-0003FU-Dg; Mon, 29 Jul 2019 08:36:30 +0200
Date:   Mon, 29 Jul 2019 08:36:30 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     thierry.reding@gmail.com, mripard@kernel.org, wens@csie.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH 2/6] pwm: sun4i: Add a quirk for reset line
Message-ID: <20190729063630.rn325whatfnc3m7n@pengutronix.de>
References: <20190726184045.14669-1-jernej.skrabec@siol.net>
 <20190726184045.14669-3-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190726184045.14669-3-jernej.skrabec@siol.net>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Cc += reset framework maintainer

Hello Jernej,

On Fri, Jul 26, 2019 at 08:40:41PM +0200, Jernej Skrabec wrote:
> H6 PWM core needs deasserted reset line in order to work.
> 
> Add a quirk for it.
> 
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> ---
>  drivers/pwm/pwm-sun4i.c | 27 +++++++++++++++++++++++++--
>  1 file changed, 25 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
> index de78c824bbfd..1b7be8fbde86 100644
> --- a/drivers/pwm/pwm-sun4i.c
> +++ b/drivers/pwm/pwm-sun4i.c
> @@ -16,6 +16,7 @@
>  #include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/pwm.h>
> +#include <linux/reset.h>
>  #include <linux/slab.h>
>  #include <linux/spinlock.h>
>  #include <linux/time.h>
> @@ -72,12 +73,14 @@ static const u32 prescaler_table[] = {
>  
>  struct sun4i_pwm_data {
>  	bool has_prescaler_bypass;
> +	bool has_reset;
>  	unsigned int npwm;
>  };
>  
>  struct sun4i_pwm_chip {
>  	struct pwm_chip chip;
>  	struct clk *clk;
> +	struct reset_control *rst;
>  	void __iomem *base;
>  	spinlock_t ctrl_lock;
>  	const struct sun4i_pwm_data *data;
> @@ -371,6 +374,14 @@ static int sun4i_pwm_probe(struct platform_device *pdev)
>  	if (IS_ERR(pwm->clk))
>  		return PTR_ERR(pwm->clk);
>  
> +	if (pwm->data->has_reset) {
> +		pwm->rst = devm_reset_control_get(&pdev->dev, NULL);
> +		if (IS_ERR(pwm->rst))
> +			return PTR_ERR(pwm->rst);
> +
> +		reset_control_deassert(pwm->rst);
> +	}
> +

I wonder why there is a need to track if a given chip needs a reset
line. I'd just use devm_reset_control_get_optional() and drop the
.has_reset member in struct sun4i_pwm_data.

>  	pwm->chip.dev = &pdev->dev;
>  	pwm->chip.ops = &sun4i_pwm_ops;
>  	pwm->chip.base = -1;
> @@ -383,19 +394,31 @@ static int sun4i_pwm_probe(struct platform_device *pdev)
>  	ret = pwmchip_add(&pwm->chip);
>  	if (ret < 0) {
>  		dev_err(&pdev->dev, "failed to add PWM chip: %d\n", ret);
> -		return ret;
> +		goto err_pwm_add;
>  	}
>  
>  	platform_set_drvdata(pdev, pwm);
>  
>  	return 0;
> +
> +err_pwm_add:
> +	reset_control_assert(pwm->rst);
> +
> +	return ret;
>  }
>  
>  static int sun4i_pwm_remove(struct platform_device *pdev)
>  {
>  	struct sun4i_pwm_chip *pwm = platform_get_drvdata(pdev);
> +	int ret;
> +
> +	ret = pwmchip_remove(&pwm->chip);
> +	if (ret)
> +		return ret;
>  
> -	return pwmchip_remove(&pwm->chip);
> +	reset_control_assert(pwm->rst);
> +
> +	return 0;
>  }
>  
>  static struct platform_driver sun4i_pwm_driver = {

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
