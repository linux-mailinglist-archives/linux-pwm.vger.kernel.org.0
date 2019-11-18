Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3370E1001B2
	for <lists+linux-pwm@lfdr.de>; Mon, 18 Nov 2019 10:50:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbfKRJuL (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 18 Nov 2019 04:50:11 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:48385 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726488AbfKRJuL (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 18 Nov 2019 04:50:11 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1iWdfW-0003GP-SK; Mon, 18 Nov 2019 10:50:02 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1iWdfU-00055N-AT; Mon, 18 Nov 2019 10:50:00 +0100
Date:   Mon, 18 Nov 2019 10:50:00 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     =?iso-8859-1?Q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Philipp Zabel <pza@pengutronix.de>, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH v5 3/8] pwm: sun4i: Prefer "mod" clock to unnamed
Message-ID: <20191118095000.gmvnmrtsbjf7nbsq@pengutronix.de>
References: <20191118093727.21899-1-peron.clem@gmail.com>
 <20191118093727.21899-4-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191118093727.21899-4-peron.clem@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, Nov 18, 2019 at 10:37:22AM +0100, Clément Péron wrote:
> New device tree bindings called the source clock of the module
> "mod" when several clocks are defined.
> 
> Try to get a clock called "mod" if nothing is found try to get
> an unnamed clock.
> 
> Signed-off-by: Clément Péron <peron.clem@gmail.com>
> ---
>  drivers/pwm/pwm-sun4i.c | 29 +++++++++++++++++++++++++++--
>  1 file changed, 27 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
> index c17935805690..bbb1ed194c0e 100644
> --- a/drivers/pwm/pwm-sun4i.c
> +++ b/drivers/pwm/pwm-sun4i.c
> @@ -362,9 +362,34 @@ static int sun4i_pwm_probe(struct platform_device *pdev)
>  	if (IS_ERR(pwm->base))
>  		return PTR_ERR(pwm->base);
>  
> -	pwm->clk = devm_clk_get(&pdev->dev, NULL);
> -	if (IS_ERR(pwm->clk))
> +	/*
> +	 * All hardware variants need a source clock that is divided and
> +	 * then feeds the counter that defines the output wave form. In the
> +	 * device tree this clock is either unnamed or called "mod".
> +	 * Some variants (e.g. H6) need another clock to access the
> +	 * hardware registers; this is called "bus".
> +	 * So we request "mod" first (and ignore the corner case that a
> +	 * parent provides a "mod" clock while the right one would be the
> +	 * unnamed one of the PWM device) and if this is not found we fall
> +	 * back to the first clock of the PWM.
> +	 */
> +	pwm->clk = devm_clk_get_optional(&pdev->dev, "mod");
> +	if (IS_ERR(pwm->clk)) {
> +		if (PTR_ERR(pwm->rst) != -EPROBE_DEFER)
> +			dev_err(&pdev->dev, "get clock failed %pe\n",
> +				pwm->clk);

I think the line break isn't needed here. Unless I'm mistaken the final
; will end in column 80 which is fine.

>  		return PTR_ERR(pwm->clk);
> +	}
> +
> +	if (!pwm->clk) {
> +		pwm->clk = devm_clk_get(&pdev->dev, NULL);
> +		if (IS_ERR(pwm->clk)) {
> +			if (PTR_ERR(pwm->rst) != -EPROBE_DEFER)
> +				dev_err(&pdev->dev, "get clock failed %pe\n",
> +					pwm->clk);

A different error message than above would be nice to be able to
distinguish the two cases.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
