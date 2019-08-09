Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB65F88085
	for <lists+linux-pwm@lfdr.de>; Fri,  9 Aug 2019 18:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726219AbfHIQvv (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 9 Aug 2019 12:51:51 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:56021 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407401AbfHIQvu (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 9 Aug 2019 12:51:50 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1hw87H-0005Qj-So; Fri, 09 Aug 2019 18:51:47 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1hw87H-0004qM-2c; Fri, 09 Aug 2019 18:51:47 +0200
Date:   Fri, 9 Aug 2019 18:51:47 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Thierry Reding <thierry.reding@gmail.com>, od@zcrc.me,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mathieu Malaterre <malat@debian.org>,
        Artur Rojek <contact@artur-rojek.eu>
Subject: Re: [PATCH 1/7] pwm: jz4740: Obtain regmap from parent node
Message-ID: <20190809165147.wf7f5jfsvycysm5h@pengutronix.de>
References: <20190809123031.24219-1-paul@crapouillou.net>
 <20190809123031.24219-2-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190809123031.24219-2-paul@crapouillou.net>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, Aug 09, 2019 at 02:30:25PM +0200, Paul Cercueil wrote:
> The TCU registers are shared between a handful of drivers, accessing
> them through the same regmap.
> 
> While this driver is devicetree-compatible, it is never (as of now)
> probed from devicetree, so this change does not introduce a ABI problem
> with current devicetree files.

If you adapt the binding also update the binding doc please.

> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> Tested-by: Mathieu Malaterre <malat@debian.org>
> Tested-by: Artur Rojek <contact@artur-rojek.eu>

nitpick: put your S-o-b line after the other tags you added.

> ---
>  drivers/pwm/Kconfig      |  1 +
>  drivers/pwm/pwm-jz4740.c | 80 ++++++++++++++++++++++++++--------------
>  2 files changed, 53 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index a7e57516959e..cc4df0ec978a 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -225,6 +225,7 @@ config PWM_IMX_TPM
>  config PWM_JZ4740
>  	tristate "Ingenic JZ47xx PWM support"
>  	depends on MACH_INGENIC
> +	select MFD_SYSCON
>  	help
>  	  Generic PWM framework driver for Ingenic JZ47xx based
>  	  machines.
> diff --git a/drivers/pwm/pwm-jz4740.c b/drivers/pwm/pwm-jz4740.c
> index f901e8a0d33d..7aea5e0c6e18 100644
> --- a/drivers/pwm/pwm-jz4740.c
> +++ b/drivers/pwm/pwm-jz4740.c
> @@ -8,18 +8,20 @@
>  #include <linux/err.h>
>  #include <linux/gpio.h>
>  #include <linux/kernel.h>
> +#include <linux/mfd/ingenic-tcu.h>
> +#include <linux/mfd/syscon.h>
>  #include <linux/module.h>
>  #include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/pwm.h>
> -
> -#include <asm/mach-jz4740/timer.h>
> +#include <linux/regmap.h>
>  
>  #define NUM_PWM 8
>  
>  struct jz4740_pwm_chip {
>  	struct pwm_chip chip;
>  	struct clk *clk;
> +	struct regmap *map;
>  };
>  
>  static inline struct jz4740_pwm_chip *to_jz4740(struct pwm_chip *chip)
> @@ -29,6 +31,8 @@ static inline struct jz4740_pwm_chip *to_jz4740(struct pwm_chip *chip)
>  
>  static int jz4740_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
>  {
> +	struct jz4740_pwm_chip *jz = to_jz4740(chip);
> +
>  	/*
>  	 * Timers 0 and 1 are used for system tasks, so they are unavailable
>  	 * for use as PWMs.
> @@ -36,50 +40,53 @@ static int jz4740_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
>  	if (pwm->hwpwm < 2)
>  		return -EBUSY;
>  
> -	jz4740_timer_start(pwm->hwpwm);
> +	regmap_write(jz->map, TCU_REG_TSCR, BIT(pwm->hwpwm));

jz4740_timer_start does

	writel(BIT(timer), jz4740_timer_base + JZ_REG_TIMER_STOP_CLEAR);

with

#define JZ_REG_TIMER_STOP_CLEAR         0x2C

and

#define TCU_REG_TSCR            0x3c

I wonder why the offsets are different.

>  
>  	return 0;
>  }
>  
>  static void jz4740_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
>  {
> -	jz4740_timer_set_ctrl(pwm->hwpwm, 0);
> +	struct jz4740_pwm_chip *jz = to_jz4740(chip);
>  
> -	jz4740_timer_stop(pwm->hwpwm);
> +	regmap_write(jz->map, TCU_REG_TSCR, BIT(pwm->hwpwm));

jz4740_timer_set_ctrl writes to offset (((pwm->hwpwm) * 0x10) + 0x3C)
and jz4740_timer_stop to offset 0x1c. The regmap_write doesn't do both
of them but instead writes to offset 0x3c.

So this doesn't seem to be a 1:1 conversion. This either needs fixing,
splitting into several patches or a better commit log.

Stopping my review here.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
