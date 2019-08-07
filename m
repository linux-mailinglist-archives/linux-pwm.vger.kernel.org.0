Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68C3C84519
	for <lists+linux-pwm@lfdr.de>; Wed,  7 Aug 2019 09:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbfHGHDf (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 7 Aug 2019 03:03:35 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:33367 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727151AbfHGHDf (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 7 Aug 2019 03:03:35 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1hvFyq-00015L-Tl; Wed, 07 Aug 2019 09:03:28 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1hvFyo-0007J0-Pu; Wed, 07 Aug 2019 09:03:26 +0200
Date:   Wed, 7 Aug 2019 09:03:26 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     linus.walleij@linaro.org, geert+renesas@glider.be,
        thierry.reding@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH RFC 6/7] pwm: rcar: Add gpio support to output duty zero
Message-ID: <20190807070326.cgkbt4kpzhqvo5a3@pengutronix.de>
References: <1562576868-8124-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1562576868-8124-7-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1562576868-8124-7-git-send-email-yoshihiro.shimoda.uh@renesas.com>
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

On Mon, Jul 08, 2019 at 06:07:47PM +0900, Yoshihiro Shimoda wrote:
> The R-Car SoCs PWM Timer cannot output duty zero. So, this patch
> adds gpio support to output it.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  drivers/pwm/pwm-rcar.c | 36 ++++++++++++++++++++++++++++++++++--
>  1 file changed, 34 insertions(+), 2 deletions(-)

I'd like to see a paragraph at the top of the driver describing the
limitations of this driver similar to what pwm-sifive.c does.

Something like:

diff --git a/drivers/pwm/pwm-rcar.c b/drivers/pwm/pwm-rcar.c
index 5b2b8ecc354c..b67ac84db834 100644
--- a/drivers/pwm/pwm-rcar.c
+++ b/drivers/pwm/pwm-rcar.c
@@ -3,6 +3,9 @@
  * R-Car PWM Timer driver
  *
  * Copyright (C) 2015 Renesas Electronics Corporation
+ *
+ * Limitations:
+ * - The hardware cannot generate a 0% duty cycle.
  */
 
 #include <linux/clk.h>

While at it: If there is a publicly available reference manual adding a line:

	Reference Manual: https://...

would be great, too.

> diff --git a/drivers/pwm/pwm-rcar.c b/drivers/pwm/pwm-rcar.c
> index c8cd43f..1c19a8b 100644
> --- a/drivers/pwm/pwm-rcar.c
> +++ b/drivers/pwm/pwm-rcar.c
> @@ -7,6 +7,7 @@
>  
>  #include <linux/clk.h>
>  #include <linux/err.h>
> +#include <linux/gpio/consumer.h>
>  #include <linux/io.h>
>  #include <linux/log2.h>
>  #include <linux/math64.h>
> @@ -38,6 +39,7 @@ struct rcar_pwm_chip {
>  	struct pwm_chip chip;
>  	void __iomem *base;
>  	struct clk *clk;
> +	struct gpio_desc *gpio;
>  };
>  
>  static inline struct rcar_pwm_chip *to_rcar_pwm_chip(struct pwm_chip *chip)
> @@ -119,8 +121,11 @@ static int rcar_pwm_set_counter(struct rcar_pwm_chip *rp, int div, int duty_ns,
>  	ph = tmp & RCAR_PWMCNT_PH0_MASK;
>  
>  	/* Avoid prohibited setting */
> -	if (cyc == 0 || ph == 0)
> +	if (cyc == 0)
>  		return -EINVAL;
> +	/* Try to use GPIO to output duty zero */
> +	if (ph == 0)
> +		return -EAGAIN;

If there is no gpio requesting cyc=0 should still yield an error.

>  	rcar_pwm_write(rp, cyc | ph, RCAR_PWMCNT);
>  
> @@ -157,6 +162,28 @@ static void rcar_pwm_disable(struct rcar_pwm_chip *rp)
>  	rcar_pwm_update(rp, RCAR_PWMCR_EN0, 0, RCAR_PWMCR);
>  }
>  
> +static int rcar_pwm_gpiod_get(struct rcar_pwm_chip *rp)
> +{
> +	if (rp->gpio)
> +		return 0;
> +
> +	rp->gpio = gpiod_get(rp->chip.dev, "renesas,duty-zero", GPIOD_OUT_LOW);
> +	if (!IS_ERR(rp->gpio))
> +		return 0;
> +
> +	rp->gpio = NULL;
> +	return -EINVAL;

Please use gpiod_get_optional() instead of open coding it.

Does getting the gpio automatically switch the pinmuxing?

If yes, this is IMHO a really surprising mis-feature of the gpio
subsystem. I'd prefer to "get" the gpio at probe time and only switch
the pinmuxing in .apply(). This makes .apply() quicker, ensures that all
resources necessary for pwm operation are available, handles
-EPROBE_DEFER (and maybe other errors) correctly.

Note you're introducing a bug here because switching to gpio doesn't
ensure that the currently running period is completed.

> +static void rcar_pwm_gpiod_put(struct rcar_pwm_chip *rp)
> +{
> +	if (!rp->gpio)
> +		return;
> +
> +	gpiod_put(rp->gpio);
> +	rp->gpio = NULL;
> +}
> +
>  static int rcar_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>  			  struct pwm_state *state)
>  {
> @@ -171,6 +198,7 @@ static int rcar_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>  
>  	if (!state->enabled) {
>  		rcar_pwm_disable(rp);
> +		rcar_pwm_gpiod_put(rp);

From the framework's POV disabling a PWM is quite similar to duty cycle
0. Assuming disabling the PWM completes the currently running period[1]
it might be better and easier to disable instead of switching to gpio.
(Further assuming that disable really yields the inactive level which is
should and is another limitation if not.)

>  		return 0;
>  	}
>  
> @@ -187,8 +215,12 @@ static int rcar_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>  	/* The SYNC should be set to 0 even if rcar_pwm_set_counter failed */
>  	rcar_pwm_update(rp, RCAR_PWMCR_SYNC, 0, RCAR_PWMCR);
>  
> -	if (!ret)
> +	if (!ret) {
>  		ret = rcar_pwm_enable(rp);
> +		rcar_pwm_gpiod_put(rp);
> +	} else if (ret == -EAGAIN) {
> +		ret = rcar_pwm_gpiod_get(rp);
> +	}
>  
>  	return ret;
>  }

Best regards
Uwe

[1] if not, please add "Disabling doesn't complete the currently running
    period" to the list of limitations.

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
