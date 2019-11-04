Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17440EDA81
	for <lists+linux-pwm@lfdr.de>; Mon,  4 Nov 2019 09:24:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727267AbfKDIYS (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 4 Nov 2019 03:24:18 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:56473 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbfKDIYS (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 4 Nov 2019 03:24:18 -0500
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1iRXel-0000b5-8H; Mon, 04 Nov 2019 09:24:11 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1iRXek-00081I-88; Mon, 04 Nov 2019 09:24:10 +0100
Date:   Mon, 4 Nov 2019 09:24:10 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     =?iso-8859-1?Q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@siol.net>, kernel@pengutronix.de
Subject: Re: [PATCH v2 3/7] pwm: sun4i: Add an optional probe for bus clock
Message-ID: <20191104082410.qdgcnphkamlzaipf@pengutronix.de>
References: <20191103203334.10539-1-peron.clem@gmail.com>
 <20191103203334.10539-4-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191103203334.10539-4-peron.clem@gmail.com>
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

On Sun, Nov 03, 2019 at 09:33:30PM +0100, Clément Péron wrote:
> From: Jernej Skrabec <jernej.skrabec@siol.net>
> 
> H6 PWM core needs bus clock to be enabled in order to work.
> 
> Add an optional probe for it and a fallback for previous
> bindings without name on module clock.
> 
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> Signed-off-by: Clément Péron <peron.clem@gmail.com>
> ---
>  drivers/pwm/pwm-sun4i.c | 36 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
> 
> diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
> index d194b8ebdb00..b5e7ac364f59 100644
> --- a/drivers/pwm/pwm-sun4i.c
> +++ b/drivers/pwm/pwm-sun4i.c
> @@ -78,6 +78,7 @@ struct sun4i_pwm_data {
>  
>  struct sun4i_pwm_chip {
>  	struct pwm_chip chip;
> +	struct clk *bus_clk;
>  	struct clk *clk;
>  	struct reset_control *rst;
>  	void __iomem *base;
> @@ -367,6 +368,31 @@ static int sun4i_pwm_probe(struct platform_device *pdev)

Adding more context here:

|       pwm->clk = devm_clk_get(&pdev->dev, NULL);
>  	if (IS_ERR(pwm->clk))
>  		return PTR_ERR(pwm->clk);
>  
> +	/* Get all clocks and reset line */
> +	pwm->clk = devm_clk_get_optional(&pdev->dev, "mod");
> +	if (IS_ERR(pwm->clk)) {
> +		dev_err(&pdev->dev, "get clock failed %ld\n",
> +			PTR_ERR(pwm->clk));
> +		return PTR_ERR(pwm->clk);
> +	}

I guess you want to drop the first assignment to pwm->clk.

> +	/* Fallback for old dtbs with a single clock and no name */
> +	if (!pwm->clk) {
> +		pwm->clk = devm_clk_get(&pdev->dev, NULL);
> +		if (IS_ERR(pwm->clk)) {
> +			dev_err(&pdev->dev, "get clock failed %ld\n",
> +				PTR_ERR(pwm->clk));
> +			return PTR_ERR(pwm->clk);
> +		}
> +	}

There is a slight change of behaviour if I'm not mistaken. If you have
this:

	clocks = <&clk1>;
	clock-names = "mod";

	pwm {
		compatible = "allwinner,sun4i-a10-pwm"
		clocks = <&clk2>;
	}

you now use clk1 instead of clk2 before.

Assuming this is only a theoretical problem, at least pointing this out
in the commit log would be good I think.

> +	pwm->bus_clk = devm_clk_get_optional(&pdev->dev, "bus");
> +	if (IS_ERR(pwm->bus_clk)) {
> +		dev_err(&pdev->dev, "get bus_clock failed %ld\n",
> +			PTR_ERR(pwm->bus_clk));
> +		return PTR_ERR(pwm->bus_clk);
> +	}
> +
>  	pwm->rst = devm_reset_control_get_optional(&pdev->dev, NULL);
>  	if (IS_ERR(pwm->rst)) {
>  		if (PTR_ERR(pwm->rst) == -EPROBE_DEFER)
> @@ -381,6 +407,13 @@ static int sun4i_pwm_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> +	/* Enable bus clock */
> +	ret = clk_prepare_enable(pwm->bus_clk);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Cannot prepare_enable bus_clk\n");

I'd do s/prepare_enable/prepare and enable/ here.

> +		goto err_bus;
> +	}
> +
>  	pwm->chip.dev = &pdev->dev;
>  	pwm->chip.ops = &sun4i_pwm_ops;
>  	pwm->chip.base = -1;
> @@ -401,6 +434,8 @@ static int sun4i_pwm_probe(struct platform_device *pdev)
>  	return 0;
>  
>  err_pwm_add:
> +	clk_disable_unprepare(pwm->bus_clk);
> +err_bus:
>  	reset_control_assert(pwm->rst);
>  
>  	return ret;

What is that clock used for? Is it required to access the hardware
registers? Or is it only required while the PWM is enabled? If so you
could enable the clock more finegrainded.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
