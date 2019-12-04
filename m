Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 607E2112391
	for <lists+linux-pwm@lfdr.de>; Wed,  4 Dec 2019 08:27:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726166AbfLDH1u (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 4 Dec 2019 02:27:50 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:46523 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726048AbfLDH1t (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 4 Dec 2019 02:27:49 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1icP4b-0004xz-E4; Wed, 04 Dec 2019 08:27:45 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1icP4b-0007QK-0N; Wed, 04 Dec 2019 08:27:45 +0100
Date:   Wed, 4 Dec 2019 08:27:44 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "rjui@broadcom.com" <rjui@broadcom.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "bgolaszewski@baylibre.com" <bgolaszewski@baylibre.com>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "sbranden@broadcom.com" <sbranden@broadcom.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "bcm-kernel-feedback-list@broadcom.com" 
        <bcm-kernel-feedback-list@broadcom.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alice Guo <alice.guo@nxp.com>
Subject: Re: [PATCH v2 2/2] gpio: bcm-kona: use platform_irq_count
Message-ID: <20191204072744.b7ytzi5gffjcq6sj@pengutronix.de>
References: <1575433106-16171-1-git-send-email-peng.fan@nxp.com>
 <1575433106-16171-2-git-send-email-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1575433106-16171-2-git-send-email-peng.fan@nxp.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, Dec 04, 2019 at 04:20:45AM +0000, Peng Fan wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> platform_irq_count() is the more generic way (independent of
> device trees) to determine the count of available interrupts. So
> use this instead.
> 
> As platform_irq_count() might return an error code (which
> of_irq_count doesn't) some additional handling is necessary.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
> 
> V2:
>  Update commit log, and add err handling
>  Not tested, just code inspection
> 
>  drivers/gpio/gpio-bcm-kona.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-bcm-kona.c b/drivers/gpio/gpio-bcm-kona.c
> index 4122683eb1f9..52ff56166263 100644
> --- a/drivers/gpio/gpio-bcm-kona.c
> +++ b/drivers/gpio/gpio-bcm-kona.c
> @@ -19,7 +19,6 @@
>  #include <linux/io.h>
>  #include <linux/gpio/driver.h>
>  #include <linux/of_device.h>
> -#include <linux/of_irq.h>
>  #include <linux/init.h>
>  #include <linux/irqdomain.h>
>  #include <linux/irqchip/chained_irq.h>
> @@ -586,11 +585,18 @@ static int bcm_kona_gpio_probe(struct platform_device *pdev)
>  
>  	kona_gpio->gpio_chip = template_chip;
>  	chip = &kona_gpio->gpio_chip;
> -	kona_gpio->num_bank = of_irq_count(dev->of_node);
> -	if (kona_gpio->num_bank == 0) {
> +	ret = platform_irq_count(pdev);
> +	if (!ret) {
>  		dev_err(dev, "Couldn't determine # GPIO banks\n");
>  		return -ENOENT;
> +	} else if (ret < 0) {
> +		if (ret != -EPROBE_DEFER)
> +			dev_err(dev, "Couldn't determine GPIO banks: %d\n",
> +				ret);

You can use the new %pe feature here:

	dev_err(dev, "Couldn't determine GPIO banks: %pe\n",
		ERR_PTR(ret));

> +		return ret;
>  	}
> +	kona_gpio->num_bank = ret;
> +

Looks otherwise ok.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
