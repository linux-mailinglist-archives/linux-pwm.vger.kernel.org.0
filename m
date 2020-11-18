Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35DB42B8845
	for <lists+linux-pwm@lfdr.de>; Thu, 19 Nov 2020 00:19:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725947AbgKRXSX (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 18 Nov 2020 18:18:23 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:36704 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725823AbgKRXSW (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 18 Nov 2020 18:18:22 -0500
Received: from andrew by vps0.lunn.ch with local (Exim 4.94)
        (envelope-from <andrew@lunn.ch>)
        id 1kfWiJ-007oq6-2L; Thu, 19 Nov 2020 00:18:11 +0100
Date:   Thu, 19 Nov 2020 00:18:11 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Baruch Siach <baruch@tkos.co.il>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Ralph Sennhauser <ralph.sennhauser@gmail.com>,
        linux-pwm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/5] gpio: mvebu: add pwm support for Armada 8K/7K
Message-ID: <20201118231811.GH1853236@lunn.ch>
References: <cover.1605694661.git.baruch@tkos.co.il>
 <db0d6d619a0686eef1b15ca7409d73813440856f.1605694661.git.baruch@tkos.co.il>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db0d6d619a0686eef1b15ca7409d73813440856f.1605694661.git.baruch@tkos.co.il>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, Nov 18, 2020 at 12:30:44PM +0200, Baruch Siach wrote:
> Use the pwm-offset DT property to store the location of PWM signal
> duration registers.
> 
> Since we have more than two GPIO chips per system, we can't use the
> alias id to differentiate between them. Use the offset value for that.
> 
> Move mvebu_pwm_probe() call before irq support code. The AP80x does not
> provide irq support, but does provide PWM. Don't skip PWM probe because
> of that.
> 
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> ---
>  drivers/gpio/gpio-mvebu.c | 112 +++++++++++++++++++++++++-------------
>  1 file changed, 75 insertions(+), 37 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
> index 946571e70928..8602afd21673 100644
> --- a/drivers/gpio/gpio-mvebu.c
> +++ b/drivers/gpio/gpio-mvebu.c
> @@ -70,7 +70,12 @@
>   */
>  #define PWM_BLINK_ON_DURATION_OFF	0x0
>  #define PWM_BLINK_OFF_DURATION_OFF	0x4
> +#define PWM_BLINK_COUNTER_B_OFF		0x8
>  
> +/* Armada 8k variant gpios register offsets */
> +#define AP80X_GPIO0_OFF_A8K		0x1040
> +#define CP11X_GPIO0_OFF_A8K		0x100
> +#define CP11X_GPIO1_OFF_A8K		0x140
>  
>  /* The MV78200 has per-CPU registers for edge mask and level mask */
>  #define GPIO_EDGE_MASK_MV78200_OFF(cpu)	  ((cpu) ? 0x30 : 0x18)
> @@ -93,6 +98,7 @@
>  
>  struct mvebu_pwm {
>  	struct regmap		*regs;
> +	u32			 offset;
>  	unsigned long		 clk_rate;
>  	struct gpio_desc	*gpiod;
>  	struct pwm_chip		 chip;
> @@ -283,12 +289,12 @@ mvebu_gpio_write_level_mask(struct mvebu_gpio_chip *mvchip, u32 val)
>   */
>  static unsigned int mvebu_pwmreg_blink_on_duration(struct mvebu_pwm *mvpwm)
>  {
> -	return PWM_BLINK_ON_DURATION_OFF;
> +	return mvpwm->offset + PWM_BLINK_ON_DURATION_OFF;
>  }
>  
>  static unsigned int mvebu_pwmreg_blink_off_duration(struct mvebu_pwm *mvpwm)
>  {
> -	return PWM_BLINK_OFF_DURATION_OFF;
> +	return mvpwm->offset + PWM_BLINK_OFF_DURATION_OFF;
>  }
>  
>  /*
> @@ -781,51 +787,80 @@ static int mvebu_pwm_probe(struct platform_device *pdev,
>  	struct device *dev = &pdev->dev;
>  	struct mvebu_pwm *mvpwm;
>  	void __iomem *base;
> +	u32 offset;
>  	u32 set;
>  
> -	if (!of_device_is_compatible(mvchip->chip.of_node,
> -				     "marvell,armada-370-gpio"))
> -		return 0;
> -
> -	/*
> -	 * There are only two sets of PWM configuration registers for
> -	 * all the GPIO lines on those SoCs which this driver reserves
> -	 * for the first two GPIO chips. So if the resource is missing
> -	 * we can't treat it as an error.
> -	 */
> -	if (!platform_get_resource_byname(pdev, IORESOURCE_MEM, "pwm"))
> +	if (of_device_is_compatible(mvchip->chip.of_node,
> +				    "marvell,armada-370-gpio")) {
> +		/*
> +		 * There are only two sets of PWM configuration registers for
> +		 * all the GPIO lines on those SoCs which this driver reserves
> +		 * for the first two GPIO chips. So if the resource is missing
> +		 * we can't treat it as an error.
> +		 */
> +		if (!platform_get_resource_byname(pdev, IORESOURCE_MEM, "pwm"))
> +			return 0;
> +		offset = 0;
> +	} else if (mvchip->soc_variant == MVEBU_GPIO_SOC_VARIANT_A8K) {
> +		int ret = of_property_read_u32(dev->of_node, "pwm-offset",
> +					       &offset);
> +		if (ret < 0)
> +			return 0;

It would look more uniform if this was

	if (of_device_is_compatible(mvchip->chip.of_node,
				    "marvell,armada-8k-gpio")) {

> +	} else {
>  		return 0;
> +	}
>  
>  	if (IS_ERR(mvchip->clk))
>  		return PTR_ERR(mvchip->clk);
>  
> -	/*
> -	 * Use set A for lines of GPIO chip with id 0, B for GPIO chip
> -	 * with id 1. Don't allow further GPIO chips to be used for PWM.
> -	 */
> -	if (id == 0)
> -		set = 0;
> -	else if (id == 1)
> -		set = U32_MAX;
> -	else
> -		return -EINVAL;
> -	regmap_write(mvchip->regs,
> -		     GPIO_BLINK_CNT_SELECT_OFF + mvchip->offset, set);
> -
>  	mvpwm = devm_kzalloc(dev, sizeof(struct mvebu_pwm), GFP_KERNEL);
>  	if (!mvpwm)
>  		return -ENOMEM;
>  	mvchip->mvpwm = mvpwm;
>  	mvpwm->mvchip = mvchip;
> +	mvpwm->offset = offset;
> +
> +	if (mvchip->soc_variant == MVEBU_GPIO_SOC_VARIANT_A8K) {
> +		mvpwm->regs = mvchip->regs;
> +
> +		switch (mvchip->offset) {
> +		case AP80X_GPIO0_OFF_A8K:
> +		case CP11X_GPIO0_OFF_A8K:
> +			/* Blink counter A */
> +			set = 0;
> +			break;
> +		case CP11X_GPIO1_OFF_A8K:
> +			/* Blink counter B */
> +			set = U32_MAX;
> +			mvpwm->offset += PWM_BLINK_COUNTER_B_OFF;
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +	} else {
> +		base = devm_platform_ioremap_resource_byname(pdev, "pwm");
> +		if (IS_ERR(base))
> +			return PTR_ERR(base);
>  
> -	base = devm_platform_ioremap_resource_byname(pdev, "pwm");
> -	if (IS_ERR(base))
> -		return PTR_ERR(base);
> +		mvpwm->regs = devm_regmap_init_mmio(&pdev->dev, base,
> +						    &mvebu_gpio_regmap_config);
> +		if (IS_ERR(mvpwm->regs))
> +			return PTR_ERR(mvpwm->regs);
> +
> +		/*
> +		 * Use set A for lines of GPIO chip with id 0, B for GPIO chip
> +		 * with id 1. Don't allow further GPIO chips to be used for PWM.
> +		 */
> +		if (id == 0)
> +			set = 0;
> +		else if (id == 1)
> +			set = U32_MAX;
> +		else
> +			return -EINVAL;
> +	}
>  
> -	mvpwm->regs = devm_regmap_init_mmio(&pdev->dev, base,
> -					    &mvebu_gpio_regmap_config);
> -	if (IS_ERR(mvpwm->regs))
> -		return PTR_ERR(mvpwm->regs);
> +	regmap_write(mvchip->regs,
> +		     GPIO_BLINK_CNT_SELECT_OFF + mvchip->offset, set);
>  
>  	mvpwm->clk_rate = clk_get_rate(mvchip->clk);
>  	if (!mvpwm->clk_rate) {
> @@ -1200,6 +1235,13 @@ static int mvebu_gpio_probe(struct platform_device *pdev)
>  
>  	devm_gpiochip_add_data(&pdev->dev, &mvchip->chip, mvchip);
>  
> +	/* Some MVEBU SoCs have simple PWM support for GPIO lines */
> +	if (IS_ENABLED(CONFIG_PWM)) {
> +		err = mvebu_pwm_probe(pdev, mvchip, id);
> +		if (err)
> +			return err;
> +	}
> +

The existing error handling looks odd here. Why is there no goto
err_domain when probing the PWMs fails? I wonder if this a bug from me
from a long time again?

	Andrew
