Return-Path: <linux-pwm+bounces-2406-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E69F19025A6
	for <lists+linux-pwm@lfdr.de>; Mon, 10 Jun 2024 17:30:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BCB01F270E3
	for <lists+linux-pwm@lfdr.de>; Mon, 10 Jun 2024 15:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE48E1411E7;
	Mon, 10 Jun 2024 15:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="okom6Ki0"
X-Original-To: linux-pwm@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC11142624;
	Mon, 10 Jun 2024 15:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718033336; cv=none; b=i4bWdB9JZU4Q6L0IUnc1pMbuJzHBg6TBMZ1gjnHrm12xlniXx3/vJ3OZVvbZP0wHjzeBwlwVWI67Hm61rnL++RsQanA2m2Ry2kyYfdqwWui5AgaupWpUHDO7RHiBkERbNNJVulGM5ELLvrR+DEYCpikmCRSDEFVLSKfJgvBAJ40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718033336; c=relaxed/simple;
	bh=zRnGYwKBxb8rEXOmr0bMdweQrWUjhdVu2QR81He6TCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a3FzQLkOMkwJmKsqs+qBRXQFFbik1cL6FB5qmqWVWx4P+14yw3z7clr/VnFx0Hhkd5IbP/MDl/6Nz6ZW+84N01rSA27clS5Vx76lG8B/3O4WXeYglR5NAhI923/08UvwhBXJoban/vfeDotfLhS4XQOejIoYrqom4yXFfflsvUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=okom6Ki0; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 241A539F;
	Mon, 10 Jun 2024 17:28:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1718033321;
	bh=zRnGYwKBxb8rEXOmr0bMdweQrWUjhdVu2QR81He6TCQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=okom6Ki06UsNkQzHrakvp2IpuXLO6LDdjKvRpt6Jy5/5O6u+EFC5kx/sXmAV+Oj6K
	 FLhHcFOK5DMRRzGKmFb2b3JaE/6ME9d+CHAD83O6I49KFNFhpKCR/Ri+m2uW4Db8si
	 uzQKYD3fzLH09PyUIkqycEqoCr+pxo+ZHEqZ97jg=
Date: Mon, 10 Jun 2024 18:28:33 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Clark Wang <xiaoning.wang@nxp.com>
Subject: Re: [PATCH v4 4/4] pwm: adp5585: Add Analog Devices ADP5585 support
Message-ID: <20240610152833.GW18479@pendragon.ideasonboard.com>
References: <20240608141633.2562-1-laurent.pinchart@ideasonboard.com>
 <20240608141633.2562-5-laurent.pinchart@ideasonboard.com>
 <ZmcWi08u6-u4MyKu@surfacebook.localdomain>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZmcWi08u6-u4MyKu@surfacebook.localdomain>

On Mon, Jun 10, 2024 at 06:06:51PM +0300, Andy Shevchenko wrote:
> Sat, Jun 08, 2024 at 05:16:33PM +0300, Laurent Pinchart kirjoitti:
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
> 
> ...
> 
> > +#define ADP5585_PWM_OSC_FREQ_HZ		1000000U
> 
> (1 * HZ_PER_MHZ) ?
> 
> Variant to use MEGA. Or even #define MHz in units.h if you wish.
> Putting a few 0:s in a row is error prone.

Feel free to send follow-up patches.

Andy, we're reaching a level of nitpicking and yakshaving that even I
can't deal with. I will have to simply ignore the comments I disagree
with.

> ...
> 
> > +	ret = regmap_write(regmap, ADP5585_PWM_OFFT_LOW,
> > +			   off & 0xff);
> > +	if (ret)
> > +		return ret;
> > +	ret = regmap_write(regmap, ADP5585_PWM_OFFT_HIGH,
> > +			   (off >> 8) & 0xff);
> > +	if (ret)
> > +		return ret;
> 
> This is regular I²C regmap, why do you avoid using regmap bulk APIs?
> 
> > +	ret = regmap_write(regmap, ADP5585_PWM_ONT_LOW,
> > +			   on & 0xff);
> > +	if (ret)
> > +		return ret;
> > +	ret = regmap_write(regmap, ADP5585_PWM_ONT_HIGH,
> > +			   (on >> 8) & 0xff);
> > +	if (ret)
> > +		return ret;
> 
> Ditto.
> 
> ...
> 
> > +static int pwm_adp5585_get_state(struct pwm_chip *chip,
> > +				 struct pwm_device *pwm,
> > +				 struct pwm_state *state)
> > +{
> > +	struct regmap *regmap = pwmchip_get_drvdata(chip);
> > +	unsigned int on, off;
> > +	unsigned int val;
> > +
> > +	regmap_read(regmap, ADP5585_PWM_OFFT_LOW, &off);
> > +	regmap_read(regmap, ADP5585_PWM_OFFT_HIGH, &val);
> > +	off |= val << 8;
> 
> Ditto.
> 
> > +	regmap_read(regmap, ADP5585_PWM_ONT_LOW, &on);
> > +	regmap_read(regmap, ADP5585_PWM_ONT_HIGH, &val);
> > +	on |= val << 8;
> 
> Ditto.
> 
> > +	state->duty_cycle = on * (NSEC_PER_SEC / ADP5585_PWM_OSC_FREQ_HZ);
> > +	state->period = (on + off) * (NSEC_PER_SEC / ADP5585_PWM_OSC_FREQ_HZ);
> > +
> > +	state->polarity = PWM_POLARITY_NORMAL;
> > +
> > +	regmap_read(regmap, ADP5585_PWM_CFG, &val);
> > +	state->enabled = !!(val & ADP5585_PWM_EN);
> > +
> > +	return 0;
> 
> Besides that, how do you guarantee that no IO may happen in between of those
> calls? Probably you want a driver explicit lock? In that case, would you still
> want to have a regmap internal lock?
> 
> > +}
> 
> ...
> 
> > +static int adp5585_pwm_probe(struct platform_device *pdev)
> > +{
> > +	struct device *dev = &pdev->dev;
> > +	struct adp5585_dev *adp5585 = dev_get_drvdata(dev->parent);
> > +	struct pwm_chip *chip;
> > +	int ret;
> > +
> > +	chip = devm_pwmchip_alloc(dev, ADP5585_PWM_CHAN_NUM, 0);
> > +	if (IS_ERR(chip))
> > +		return PTR_ERR(chip);
> 
> > +	device_set_of_node_from_dev(dev, dev->parent);
> 
> Still unclear to me why only few drivers use this.
> 
> > +	pwmchip_set_drvdata(chip, adp5585->regmap);
> > +	chip->ops = &adp5585_pwm_ops;
> > +
> > +	ret = devm_pwmchip_add(dev, chip);
> > +	if (ret)
> > +		return dev_err_probe(dev, ret, "failed to add PWM chip\n");
> > +
> > +	return 0;
> > +}
> 
> ...
> 
> > +static const struct platform_device_id adp5585_pwm_id_table[] = {
> > +	{ "adp5585-pwm" },
> > +	{ /* Sentinel */ },
> 
> Drop comma. Otherwise it's not a sentinel strictly speaking.
>
> > +};

-- 
Regards,

Laurent Pinchart

