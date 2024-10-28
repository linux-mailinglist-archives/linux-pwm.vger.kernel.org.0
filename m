Return-Path: <linux-pwm+bounces-3942-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D69AA9B31D6
	for <lists+linux-pwm@lfdr.de>; Mon, 28 Oct 2024 14:38:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5763F1F224B6
	for <lists+linux-pwm@lfdr.de>; Mon, 28 Oct 2024 13:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C3F31DBB37;
	Mon, 28 Oct 2024 13:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="cvoVCWye"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4010D1DBB36
	for <linux-pwm@vger.kernel.org>; Mon, 28 Oct 2024 13:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730122725; cv=none; b=nSi8lIJG5PD6uaC+k+WQM3MmGwkCx4kAj6/aY7eHnGi3Dqjgd+k385M+X0Kbizmqewtu2rRN0s3sDrQglqBIfzJVUJQCvfcnpymmrqDOY1hRiL8SvcCEj5tMYLNhXK64qPh97/dlxbTkoUI2WVtvsnM6MrdiKrjneyKJ+hSsGFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730122725; c=relaxed/simple;
	bh=ImCDSQfVPz/nLq+bQZp4fY5LSkrred7qiEcvfTY0HG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=baigj0Hk+HDdtbb0/S9wBpgGgQK0WU6cI4f5MX5khaip1oS6OBtzhQyGm4VkxFx2vLsUg08ZwS2PGEMXji2vIlOwfvhKYWmImpjdz2nqu4l45XcR6gnAvkLRB/I2gaY0UoT5/JWK+Y54CmYlgwTXgZshChkslC2KLBoh4RUL6XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=cvoVCWye; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-539e5c15fd3so3777859e87.3
        for <linux-pwm@vger.kernel.org>; Mon, 28 Oct 2024 06:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730122720; x=1730727520; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=02+v7YcuVfRITYlTx76F0pUGUkoAHD9bSCAexfHSrP0=;
        b=cvoVCWyeVJlwNyTbC9mVfLmxb1zEjB1p+us+UakDy/gUtSpR2jTC/LH4FIfXa1YAnb
         GwlHGV6U/OiOlHRrdb7Fxs7GMZE14ZTnspyteond0MDDe4BdYyCND+HjStYP0q/bPlvL
         8JSvUmkYLrpzR+ABq5dHVKzSWPrbU0HJHQ7rzpUJNuZlFTfWP2JwMs+Y2sPs9YbEXC2H
         BJLovmUcrt3pwbWdtB3d41EryO6vcHlsT8oDgCYzw7cncweeNQjvMuKjUPLbSxBs13H/
         oJSXba1yTDOyZDK0si4wmVdOez6l3NUdqzRsnag/RY6lS3bD37tcgENxFibBfAjTuqzU
         1BCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730122720; x=1730727520;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=02+v7YcuVfRITYlTx76F0pUGUkoAHD9bSCAexfHSrP0=;
        b=EgtIvn3tjfAfJz+hrqFw3sw1hmd4/PZyoqK5eq2/BPE/uukBGmrNfIik9CjZ0ihwGJ
         qyw06GEX2T4RF4GbzrAQkSPwDrr712uc7gIcLUm/Z4a2nFv6LC4L9IiRetULNh6IpwDn
         tqLyJDUkXhBbcZv+7VF9lI/aSCpZIOuShk32YP1LXRcgGY0EAaCBYIcxH5zAOy4CYcA4
         t5x8jdIroZ9hIOlAczhAeeSggGyt2apyt+LZczdXH07X9xtwf4azMy3qht8JqY6eh5VI
         ZsUaFAhvdEwcUkNIujvVkEu3Yj+JH7xuS0ZuC6i8F8STSvIq2rbXIhJURTPVumZ4N88i
         Hyzw==
X-Gm-Message-State: AOJu0Ywcuhlo7smgi5MpVmS3MZ3YXkKWgFqorOR+DN4SwS8q9sSa+nxR
	nZ1Sz51rYMfx9UOEVE1raetMZHHstTUMSKrCKJtlBaU0gueXnypL1eeaSRKXLO8=
X-Google-Smtp-Source: AGHT+IHQ9kkDkDDwqrca3eXj9wkNdwUFStSj7GRVlo1X3afIuAZ0EnVWMqdzrUhsLSIY92JqDVlFAw==
X-Received: by 2002:a05:6512:23a0:b0:539:f995:5b00 with SMTP id 2adb3069b0e04-53b348c3a47mr3138052e87.7.1730122720009;
        Mon, 28 Oct 2024 06:38:40 -0700 (PDT)
Received: from localhost (p200300f65f0c3200f401bf2b6011cd64.dip0.t-ipconnect.de. [2003:f6:5f0c:3200:f401:bf2b:6011:cd64])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4318b55f5e1sm142011765e9.14.2024.10.28.06.38.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 06:38:39 -0700 (PDT)
Date: Mon, 28 Oct 2024 14:38:38 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Ben Zong-You Xie <ben717@andestech.com>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Subject: Re: [PATCH 2/2] pwm: atcpit100: add Andes PWM driver support
Message-ID: <3sd27d74rp4nb7h23dquynuytzsipceeue4b46dm6ti4yyuu57@txg5n3u5ztn6>
References: <20241028102721.1961289-1-ben717@andestech.com>
 <20241028102721.1961289-3-ben717@andestech.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="r2fscrji3kbonftc"
Content-Disposition: inline
In-Reply-To: <20241028102721.1961289-3-ben717@andestech.com>


--r2fscrji3kbonftc
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH 2/2] pwm: atcpit100: add Andes PWM driver support
MIME-Version: 1.0

On Mon, Oct 28, 2024 at 06:27:21PM +0800, Ben Zong-You Xie wrote:
> Add PWM driver suuport for Andes atcpit100.

s/uup/upp/

> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index 9081e0c0e9e0..ad6e803f12d0 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -3,6 +3,7 @@ obj-$(CONFIG_PWM)		+= core.o
>  obj-$(CONFIG_PWM_AB8500)	+= pwm-ab8500.o
>  obj-$(CONFIG_PWM_ADP5585)	+= pwm-adp5585.o
>  obj-$(CONFIG_PWM_APPLE)		+= pwm-apple.o
> +obj-$(CONFIG_PWM_ATCPIT100)	+= pwm-atcpit100.o
>  obj-$(CONFIG_PWM_ATMEL)		+= pwm-atmel.o
>  obj-$(CONFIG_PWM_ATMEL_HLCDC_PWM)	+= pwm-atmel-hlcdc.o
>  obj-$(CONFIG_PWM_ATMEL_TCB)	+= pwm-atmel-tcb.o
> diff --git a/drivers/pwm/pwm-atcpit100.c b/drivers/pwm/pwm-atcpit100.c
> new file mode 100644
> index 000000000000..cf83e8702d60
> --- /dev/null
> +++ b/drivers/pwm/pwm-atcpit100.c
> @@ -0,0 +1,240 @@
> +// SPDX-License-Identifier: GPL-2.0-only

Please add a comment here to list hardware limitations (such that the
gist is available from the output in

	sed -rn '/Limitations:/,/\*\/?$/p' drivers/pwm/*.c

. Check how other newer driver do it.) Questions to answer there (at
least) include:

 - How does the hardware behave when disabled? (Typical: HighZ, constant
   0, constant inactive)
 - Are there glitches during reconfiguration?

> +#include <linux/err.h>
> +#include <linux/math64.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/pwm.h>
> +#include <linux/regmap.h>
> +#include <linux/time.h>
> +#include <linux/types.h>
> +
> +#define ATCPIT100_CHANNEL_MAX			4
> +#define ATCPIT100_CHANNEL_ENABLE		0x1C
> +#define ATCPIT100_CHANNEL_ENABLE_PWM(ch)	BIT(3 + (4 * ch))
> +#define ATCPIT100_CHANNEL_CTRL(ch)		(0x20 + (0x10 * ch))
> +#define ATCPIT100_CHANNEL_CTRL_MODE_PWM		0x04
> +#define ATCPIT100_CHANNEL_CTRL_CLK		BIT(3)
> +#define ATCPIT100_CHANNEL_CTRL_MASK		GENMASK(4, 0)
> +#define ATCPIT100_CHANNEL_RELOAD(ch)		(0x24 + (0x10 * ch))
> +#define CLK_EXTERNAL				32768
> +#define CLK_APB					60000000
> +#define CYCLE_MIN				0x01
> +#define CYCLE_MAX				0x010000

Please give these last 4 constants a name that makes it clear that they
belong to this driver. I.e. use "ATCPIT100_" as prefix.

CYCLE_MIN is one because you have to write numcycles - 1 to the
respective register, right? I would have use a plain 1 in the
implementation then.

> +struct atcpit100_pwm {
> +	struct regmap *regmap;
> +	u32 clk_src[ATCPIT100_CHANNEL_MAX];
> +};
> +
> +static const struct regmap_config atcpit100_pwm_regmap_config = {
> +	.reg_bits = 32,
> +	.reg_stride = 4,
> +	.val_bits = 32,
> +};
> +
> +static inline struct atcpit100_pwm *to_atcpit100_pwm(struct pwm_chip *chip)
> +{
> +	return pwmchip_get_drvdata(chip);
> +}
> +
> +static int of_atcpit100_pwm_set_clk_src(struct atcpit100_pwm *ap,
> +					struct device_node *np)
> +{
> +	int ret;
> +
> +	for (int i = 0; i < ATCPIT100_CHANNEL_MAX; i++) {
> +		ret = of_property_read_u32_index(np, "andestech,clock-source",
> +						 i, &(ap->clk_src[i]));
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}

Instead of having that statically configured in the dtb, it would be
beneficial to switch the parent depending on the requested setting.

> +static int atcpit100_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm,
> +				bool enable)
> +{
> +	unsigned int channel = pwm->hwpwm;
> +	unsigned int enable_bit = ATCPIT100_CHANNEL_ENABLE_PWM(channel);
> +	struct atcpit100_pwm *ap = to_atcpit100_pwm(chip);
> +
> +	pwm->state.enabled = enable;

The pwm core cares for that. Please drop that assignment.

> +	return regmap_update_bits(ap->regmap, ATCPIT100_CHANNEL_ENABLE,
> +				  enable_bit, enable ? enable_bit : 0);
> +}
> +
> +static int atcpit100_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
> +				const struct pwm_state *state)
> +{
> +	int ret;
> +	u64 period_cycle;
> +	u64 duty_cycle;
> +	u16 pwm_high;
> +	u16 pwm_low;
> +	struct atcpit100_pwm *ap = to_atcpit100_pwm(chip);
> +	unsigned int ctrl_val = 0;
> +	unsigned int channel = pwm->hwpwm;
> +	u64 rate = ap->clk_src[channel] ? CLK_APB : CLK_EXTERNAL;

Huh, I would have expected a call to clk_get_rate() here.

> +	/* cycle count = clock rate * time */
> +	period_cycle = mul_u64_u64_div_u64(rate, state->period, NSEC_PER_SEC);
> +	duty_cycle = mul_u64_u64_div_u64(rate, state->duty_cycle,
> +					 NSEC_PER_SEC);
> +	if (period_cycle < CYCLE_MIN || period_cycle > CYCLE_MAX ||
> +	    duty_cycle < CYCLE_MIN || duty_cycle > CYCLE_MAX) {
> +		dev_err(pwmchip_parent(chip),
> +			"channel%d: period cycles = 0x%llx, duty cycles = 0x%llx\n",
> +			channel, period_cycle, duty_cycle);
> +		return -EINVAL;
> +	}

Don't error out on period_cycle > CYCLE_MAX or duty_cycle > CYCLE_MAX.
Just continue with period_cycle = CYCLE_MAX (and duty_cycle = CYCLE_MAX
resp.).

> +	/*
> +	 * In the PWM mode, the high period is (PWM16_Hi + 1) cycles, and the
> +	 * low period is (PWM16_Lo + 1) cycles.
> +	 * For example, if period is 30 cycles and duty_cycle is 10 cycles,
> +	 * PWM16_Hi = 10 - 1 = 9, PWM16_Lo = 30 - 10 - 1 = 19.
> +	 */
> +	pwm_high = duty_cycle - 1;
> +	pwm_low = period_cycle - duty_cycle - 1;

If period_cycle == duty_cycle surprising things happen?

I guess the hardware can neither do a 0% nor a 100% relative duty cycle?
That's something to document in the above mentioned Limitations
paragraph.

> +
> +	/* Set control register. */
> +	ctrl_val |= ATCPIT100_CHANNEL_CTRL_MODE_PWM;
> +	ctrl_val |= ap->clk_src[channel] ? ATCPIT100_CHANNEL_CTRL_CLK : 0;
> +	ret = regmap_update_bits(ap->regmap, ATCPIT100_CHANNEL_CTRL(channel),
> +				 ATCPIT100_CHANNEL_CTRL_MASK, ctrl_val);
> +	if (ret)
> +		return ret;

What happens to the output here? I guess it might already change and so
it might emit a wave form that is neither the old nor the new one?
(=> Limitations)

> +
> +	/* Set reload register. */
> +	ret = regmap_write(ap->regmap, ATCPIT100_CHANNEL_RELOAD(channel),
> +			   (pwm_high << 16) | pwm_low);

Please define proper bitfield accessors. E.g.

	ATCPIT100_CHANNEL_RELOAD_HIGH	GENMASK(31, 16)
	...

and then use FIELD_PREP to assign.

> +	if (ret)
> +		return ret;
> +
> +	return 0;

This can be abbreviated to

	return regmap_write(....);

> +}
> +
> +static int atcpit100_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> +			       const struct pwm_state *state)
> +{
> +	int ret;
> +
> +	/* ATCPIT100 PWM driver now only supports normal polarity. */
> +	if (state->polarity != PWM_POLARITY_NORMAL) {
> +		dev_err(pwmchip_parent(chip),
> +			"only supports normal polarity now\n");

No error message in .apply() please. Returning an error code is enough.

> +		return -EINVAL;
> +	}
> +
> +	if (!state->enabled) {
> +		if (pwm->state.enabled)
> +			return atcpit100_pwm_enable(chip, pwm, 0);
> +
> +		return 0;
> +	}
> +
> +	ret = atcpit100_pwm_config(chip, pwm, state);
> +	if (ret)
> +		return ret;
> +
> +	return atcpit100_pwm_enable(chip, pwm, 1);
> +}
> +
> +static int atcpit100_pwm_get_state(struct pwm_chip *chip,
> +				   struct pwm_device *pwm,
> +				   struct pwm_state *state)
> +{
> +	int ret;
> +	unsigned int reload_val;
> +	u16 pwm_high;
> +	u16 pwm_low;
> +	unsigned int channel = pwm->hwpwm;
> +	struct atcpit100_pwm *ap = to_atcpit100_pwm(chip);
> +	u64 rate = ap->clk_src[channel] ? CLK_APB : CLK_EXTERNAL;
> +
> +	state->enabled =
> +		regmap_test_bits(ap->regmap, ATCPIT100_CHANNEL_ENABLE,
> +				 ATCPIT100_CHANNEL_ENABLE_PWM(channel));
> +	state->polarity = PWM_POLARITY_NORMAL;
> +	ret = regmap_read(ap->regmap, ATCPIT100_CHANNEL_RELOAD(channel),
> +			  &reload_val);
> +	if (ret)
> +		return ret;
> +
> +	pwm_high = reload_val >> 16;
> +	pwm_low = reload_val & 0xFFFF;
> +	state->duty_cycle = mul_u64_u64_div_u64(pwm_high + 1, NSEC_PER_SEC,
> +						rate);
> +	state->period = mul_u64_u64_div_u64(pwm_low + pwm_high + 1,
> +					    NSEC_PER_SEC, rate);
> +

Please enable PWM_DEBUG and test extensively. Hint: You have to round up
here.

> +	return 0;
> +}
> +
> +static const struct pwm_ops atcpit_pwm_ops = {
> +	.apply = atcpit100_pwm_apply,
> +	.get_state = atcpit100_pwm_get_state,
> +};
> +
> +static int atcpit100_pwm_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct device_node *np = dev->of_node;
> +	struct atcpit100_pwm *ap;
> +	struct pwm_chip *chip;
> +	void __iomem *base;
> +	int ret;
> +
> +	chip = devm_pwmchip_alloc(dev, ATCPIT100_CHANNEL_MAX, sizeof(*ap));
> +	if (IS_ERR(chip))
> +		return PTR_ERR(chip);
> +
> +	ap = to_atcpit100_pwm(chip);
> +
> +	/*
> +	 * Each channel can select two different clock sources by toggling the
> +	 * third bit in its control register. 0 means using an external clock,
> +	 * and 1 means using APB clock from APB bus. Select the clock source for
> +	 * each channel by DTS.
> +	 */
> +	ret = of_atcpit100_pwm_set_clk_src(ap, np);
> +	if (ret)
> +		return ret;
> +
> +	base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);
> +
> +	ap->regmap = devm_regmap_init_mmio(dev, base,
> +					   &atcpit100_pwm_regmap_config);
> +	if (IS_ERR(ap->regmap))
> +		return dev_err_probe(dev, PTR_ERR(ap->regmap),
> +				     "failed to init register map\n");
> +
> +	chip->ops = &atcpit_pwm_ops;
> +	ret = devm_pwmchip_add(dev, chip);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to add PWM chip\n");
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id atcpit100_pwm_dt[] = {
> +	{ .compatible = "andestech,atcpit100-pwm" },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, atcpit100_pwm_dt);
> +
> +static struct platform_driver atcpit100_pwm_driver = {
> +	.driver = {
> +		.name = "atcpit100-pwm",
> +		.of_match_table = atcpit100_pwm_dt,
> +	},
> +	.probe = atcpit100_pwm_probe,
> +};
> +module_platform_driver(atcpit100_pwm_driver);

empty new line here

> +MODULE_AUTHOR("Andes Technology Corporation <ben717@andestech.com>");

I would have expected your name here given that's also your email
address.

> +MODULE_DESCRIPTION("Andes ATCPIT100 PWM driver");
> +MODULE_LICENSE("GPL");

Best regards
Uwe

--r2fscrji3kbonftc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmcfk9sACgkQj4D7WH0S
/k4ByAf/RPuya+EQVZbPB8hdgDSCU9CFzZPaxWt48ofcGae18KKNWNptmnirnpwL
/7qibQkc6npUy8n19BpbVvRJkzpvyg/jQjVAm5G7+a+Wh4HGm/8ylATarsFmTPm/
VQG0faE/d2aF8xR6ZmPQwPICMwvInw+mEq2PQZgPoSGN4gU9dPidXs4F/yB/xVRi
XNX8YpLxAWgNCaTSGKKnUg5qRRxYucCvuToCAmt1h98R6RQop4dvk/MKB84WEnBv
vEQgvKWZUUuBprF3rDnN9BnXlL/h7UHA2cEtUEcyPT0plPEI0dzSNwodR6+WZYCv
9CfVT0LYCidtR7cY6XEGaSflbKYTpw==
=yKMg
-----END PGP SIGNATURE-----

--r2fscrji3kbonftc--

