Return-Path: <linux-pwm+bounces-2873-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41769938544
	for <lists+linux-pwm@lfdr.de>; Sun, 21 Jul 2024 17:23:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E92A8280F2D
	for <lists+linux-pwm@lfdr.de>; Sun, 21 Jul 2024 15:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D18DB16729D;
	Sun, 21 Jul 2024 15:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="dCNjLv3u"
X-Original-To: linux-pwm@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906DB15FA8A;
	Sun, 21 Jul 2024 15:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721575381; cv=none; b=KWSnzI5UBDkewPP0HMbefvDLvaP4BVcwGfBttHzvprFMnO8yN+QLmBYRlHm0WD0+5stJ+30p5A+BKftD0ITZ+lNDmRKQmD67iWKBzKZV9pWQ8ixqbhyU/YnH6Ijoz8EC3SxXB6zEO1QL/X67EHytU1KG/3Wsxq4mRQ/6raHnos8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721575381; c=relaxed/simple;
	bh=tUDe+QmMY6roC0Ieiylzm4lAp5M/CpN4laEk+oAyua0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bc5bM/RNjSNqYVWrmp9tagBkMDUrl0aiMAwP5Kj9bh4idKfMtVaOAucobGiD2RC36/Hf47bxHoh/BpXD600Oltb3z+sguY5rgAhBNQO0bGL1sS3cRbDIL5G/T8fV43ixU68yUL9WYrBlI/I+QQijeEcK4FCCfeWt119Dt6Fe1J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=dCNjLv3u; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id F3F5FB3;
	Sun, 21 Jul 2024 17:22:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1721575337;
	bh=tUDe+QmMY6roC0Ieiylzm4lAp5M/CpN4laEk+oAyua0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dCNjLv3u05U1JXe6t5eOh01IQ3Rits1SF3TVG9X0c31EDaYtYwZYUCGNv/PmiSGPh
	 Be8KmA5zIK7CA+TD575wFNO0hBWhw12KplwfqIPApq7N5R6svKn1JKfAjM61lRCPJd
	 1yd0WjbQt9OmyQYefCZENPyRLfxEbfA0pQ5ClSig=
Date: Sun, 21 Jul 2024 18:22:39 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Rob Herring <robh@kernel.org>, Haibo Chen <haibo.chen@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>, Frank Li <Frank.li@nxp.com>
Subject: Re: [PATCH v5 4/4] pwm: adp5585: Add Analog Devices ADP5585 support
Message-ID: <20240721152239.GC5732@pendragon.ideasonboard.com>
References: <20240719203946.22909-1-laurent.pinchart@ideasonboard.com>
 <20240719203946.22909-5-laurent.pinchart@ideasonboard.com>
 <cc3omm4oaenx6knihusxbez4bntcsa72ht75yvelyyl6irkpwr@uotoqchzdh2o>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cc3omm4oaenx6knihusxbez4bntcsa72ht75yvelyyl6irkpwr@uotoqchzdh2o>

Hi Uwe,

On Sun, Jul 21, 2024 at 09:09:07AM +0200, Uwe Kleine-König wrote:
> Hello Laurent,
> 
> thanks for your reiteration of the series.
> 
> Just a few questions and minor suggestions left; see below.
> 
> On Fri, Jul 19, 2024 at 11:39:46PM +0300, Laurent Pinchart wrote:
> > From: Clark Wang <xiaoning.wang@nxp.com>
> > 
> > The ADP5585 is a 10/11 input/output port expander with a built in keypad
> > matrix decoder, programmable logic, reset generator, and PWM generator.
> > This driver supports the PWM function using the platform device
> > registered by the core MFD driver.
> > 
> > The driver is derived from an initial implementation from NXP, available
> > in commit 113113742208 ("MLK-25922-1 pwm: adp5585: add adp5585 PWM
> > support") in their BSP kernel tree. It has been extensively rewritten.
> > 
> > Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
> > Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> 
> Would your changes justify a Co-developed-by:?

Sounds like a good idea.

> > diff --git a/drivers/pwm/pwm-adp5585.c b/drivers/pwm/pwm-adp5585.c
> > new file mode 100644
> > index 000000000000..472a4c20b7a9
> > --- /dev/null
> > +++ b/drivers/pwm/pwm-adp5585.c
> > @@ -0,0 +1,189 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Analog Devices ADP5585 PWM driver
> > + *
> > + * Copyright 2022 NXP
> > + * Copyright 2024 Ideas on Board Oy
> > + *
> > + * Limitations:
> > + * - The .apply() operation executes atomically, but may not wait for the
> > + *   period to complete (this is not documented and would need to be tested).
> 
> So writing to ADP5585_PWM_OFFT and ADP5585_PWM_ONT is shadowed until
> what happens?

The datasheet only tells that the PWM times are latched when the
ADP5585_PWM_ONT_HIGH register is written. Whether that will affect the
timings immediately, or wait until the end of the current period, I
don't know.

> > + * - Disabling the PWM drives the output pin to a low level immediately.
> > + * - The hardware can only generate normal polarity output.
> > + */
> > +
> > +#include <asm/byteorder.h>
> > +
> > +#include <linux/device.h>
> > +#include <linux/err.h>
> > +#include <linux/math64.h>
> > +#include <linux/mfd/adp5585.h>
> > +#include <linux/minmax.h>
> > +#include <linux/module.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/pwm.h>
> > +#include <linux/regmap.h>
> > +#include <linux/time.h>
> > +#include <linux/types.h>
> > +
> > +#define ADP5585_PWM_CHAN_NUM		1
> > +
> > +#define ADP5585_PWM_OSC_FREQ_HZ		1000000U
> > +#define ADP5585_PWM_MIN_PERIOD_NS	(2ULL * NSEC_PER_SEC / ADP5585_PWM_OSC_FREQ_HZ)
> > +#define ADP5585_PWM_MAX_PERIOD_NS	(2ULL * 0xffff * NSEC_PER_SEC / ADP5585_PWM_OSC_FREQ_HZ)
> > +
> > +static int pwm_adp5585_request(struct pwm_chip *chip, struct pwm_device *pwm)
> > +{
> > +	struct regmap *regmap = pwmchip_get_drvdata(chip);
> > +	int ret;
> > +
> > +	ret = regmap_update_bits(regmap, ADP5585_PIN_CONFIG_C,
> > +				 ADP5585_R3_EXTEND_CFG_MASK,
> > +				 ADP5585_R3_EXTEND_CFG_PWM_OUT);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return regmap_update_bits(regmap, ADP5585_GENERAL_CFG,
> > +				  ADP5585_OSC_EN, ADP5585_OSC_EN);
> 
> The purpose of this function is pinmuxing and oscillator enabling,
> right? Would it make sense to enable the oscillator only in .apply() with
> .enabled = true to save some power?

I'll do that. Note that the OSC_EN bit also affects the GPI scan and the
key scan functions, which the driver doesn't support yet. When support
for those functions will be added, we will need to move handling of the
OSC_EN bit to the MFD driver, and reference-count the oscillator
enable/disable calls.

> > +}
> > +
> > +static void pwm_adp5585_free(struct pwm_chip *chip, struct pwm_device *pwm)
> > +{
> > +	struct regmap *regmap = pwmchip_get_drvdata(chip);
> > +
> > +	regmap_update_bits(regmap, ADP5585_PIN_CONFIG_C,
> > +			   ADP5585_R3_EXTEND_CFG_MASK,
> > +			   ADP5585_R3_EXTEND_CFG_GPIO4);
> > +	regmap_update_bits(regmap, ADP5585_GENERAL_CFG,
> > +			   ADP5585_OSC_EN, 0);
> > +}
> > +
> > +static int pwm_adp5585_apply(struct pwm_chip *chip,
> > +			     struct pwm_device *pwm,
> > +			     const struct pwm_state *state)
> > +{
> > +	struct regmap *regmap = pwmchip_get_drvdata(chip);
> > +	u64 period, duty_cycle;
> > +	u32 on, off;
> > +	__le16 val;
> > +	int ret;
> > +
> > +	if (!state->enabled)
> > +		return regmap_update_bits(regmap, ADP5585_PWM_CFG,
> > +					  ADP5585_PWM_EN, 0);
> > +
> > +	if (state->polarity != PWM_POLARITY_NORMAL)
> > +		return -EINVAL;
> > +
> > +	if (state->period < ADP5585_PWM_MIN_PERIOD_NS)
> > +		return -EINVAL;
> > +
> > +	period = min(state->period, ADP5585_PWM_MAX_PERIOD_NS);
> > +	duty_cycle = min(state->duty_cycle, period);
> > +
> > +	/*
> > +	 * Compute the on and off time. As the internal oscillator frequency is
> > +	 * 1MHz, the calculation can be simplified without loss of precision.
> > +	 */
> > +	on = div_u64(duty_cycle, NSEC_PER_SEC / ADP5585_PWM_OSC_FREQ_HZ);
> > +	off = div_u64(period, NSEC_PER_SEC / ADP5585_PWM_OSC_FREQ_HZ) - on;
> > +
> > +	val = cpu_to_le16(off);
> > +	ret = regmap_bulk_write(regmap, ADP5585_PWM_OFFT_LOW, &val, 2);
> > +	if (ret)
> > +		return ret;
> > +
> > +	val = cpu_to_le16(on);
> > +	ret = regmap_bulk_write(regmap, ADP5585_PWM_ONT_LOW, &val, 2);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/* Enable PWM in continuous mode and no external AND'ing. */
> > +	ret = regmap_update_bits(regmap, ADP5585_PWM_CFG,
> > +				 ADP5585_PWM_IN_AND | ADP5585_PWM_MODE |
> > +				 ADP5585_PWM_EN, ADP5585_PWM_EN);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return 0;
> 
> This could be simplified to just:
> 
> 	return regmap_update_bits(...);
> 
> (but some people feel strong here, so just a suggestion)

I don't have a strong preference in this case so I'll apply your
suggestion.

> > +}
> > +
> > +static int pwm_adp5585_get_state(struct pwm_chip *chip,
> > +				 struct pwm_device *pwm,
> > +				 struct pwm_state *state)
> > +{
> > +	struct regmap *regmap = pwmchip_get_drvdata(chip);
> > +	unsigned int on, off;
> > +	unsigned int val;
> > +	__le16 on_off;
> > +	int ret;
> > +
> > +	ret = regmap_bulk_read(regmap, ADP5585_PWM_OFFT_LOW, &on_off, 2);
> > +	if (ret)
> > +		return ret;
> > +	off = le16_to_cpu(on_off);
> > +
> > +	ret = regmap_bulk_read(regmap, ADP5585_PWM_ONT_LOW, &on_off, 2);
> > +	if (ret)
> > +		return ret;
> > +	on = le16_to_cpu(on_off);
> > +
> > +	state->duty_cycle = on * (NSEC_PER_SEC / ADP5585_PWM_OSC_FREQ_HZ);
> > +	state->period = (on + off) * (NSEC_PER_SEC / ADP5585_PWM_OSC_FREQ_HZ);
> > +
> > +	state->polarity = PWM_POLARITY_NORMAL;
> > +
> > +	regmap_read(regmap, ADP5585_PWM_CFG, &val);
> > +	state->enabled = !!(val & ADP5585_PWM_EN);
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct pwm_ops adp5585_pwm_ops = {
> > +	.request = pwm_adp5585_request,
> > +	.free = pwm_adp5585_free,
> > +	.apply = pwm_adp5585_apply,
> > +	.get_state = pwm_adp5585_get_state,
> > +};
> > +
> > +static int adp5585_pwm_probe(struct platform_device *pdev)
> > +{
> > +	struct device *dev = &pdev->dev;
> > +	struct adp5585_dev *adp5585 = dev_get_drvdata(dev->parent);
> > +	struct pwm_chip *chip;
> > +	int ret;
> > +
> > +	chip = devm_pwmchip_alloc(dev, ADP5585_PWM_CHAN_NUM, 0);
> 
> ADP5585_PWM_CHAN_NUM is only used once. I would prefer passing a plain 1
> here, as this makes the output of $(grep devm_pwmchip_alloc) a bit more
> useful.

I think the macro makes the code more readable, it clearly shows that
the second argument is the number of channels, while

	chip = devm_pwmchip_alloc(dev, 1, 0);

is harder to read. If you insist, I can change it. I don't have a
sentimental attachment to this driver, I just want to get it upstream to
avoid carrying it locally.

> > +	if (IS_ERR(chip))
> > +		return PTR_ERR(chip);
> > +
> > +	device_set_of_node_from_dev(dev, dev->parent);
> > +
> > +	pwmchip_set_drvdata(chip, adp5585->regmap);
> > +	chip->ops = &adp5585_pwm_ops;
> > +
> > +	ret = devm_pwmchip_add(dev, chip);
> > +	if (ret)
> > +		return dev_err_probe(dev, ret, "failed to add PWM chip\n");
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct platform_device_id adp5585_pwm_id_table[] = {
> > +	{ "adp5585-pwm" },
> > +	{ /* Sentinel */ },
> 
> The trailing comma should be dropped here.

OK.

> > +};
> > +MODULE_DEVICE_TABLE(platform, adp5585_pwm_id_table);
> > +
> > +static struct platform_driver adp5585_pwm_driver = {
> > +	.driver	= {
> > +		.name = "adp5585-pwm",
> > +	},
> > +	.probe = adp5585_pwm_probe,
> > +	.id_table = adp5585_pwm_id_table,
> > +};
> > +module_platform_driver(adp5585_pwm_driver);
> > +
> > +MODULE_AUTHOR("Xiaoning Wang <xiaoning.wang@nxp.com>");
> > +MODULE_DESCRIPTION("ADP5585 PWM Driver");
> > +MODULE_LICENSE("GPL");

-- 
Regards,

Laurent Pinchart

