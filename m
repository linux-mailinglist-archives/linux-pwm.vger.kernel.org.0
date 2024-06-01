Return-Path: <linux-pwm+bounces-2313-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 523688D6F95
	for <lists+linux-pwm@lfdr.de>; Sat,  1 Jun 2024 13:54:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 089982829EF
	for <lists+linux-pwm@lfdr.de>; Sat,  1 Jun 2024 11:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F9CF14F9C4;
	Sat,  1 Jun 2024 11:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aRySKWS9"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108ED823A3;
	Sat,  1 Jun 2024 11:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717242846; cv=none; b=Bso0WxCfU/9yXNqlCAb36Q9DgEVA9MYlnqtkBrOl+KQx75CEIM5EG4XjDYz+Bur6Ws5mC3LUXJ+v3ugrwco4qjww0udVGdlJ4Ekbog2uiYQkuYO4D9DrceZsd4Bk27+zmJ0fp4OvA65iEh8pNDfd/z/a25bd61Ai++Du9yfX/pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717242846; c=relaxed/simple;
	bh=mQtDhd51AWq6YLrJqZrV321wR91AZdfTxW6PVSJC8xM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Goqjn62zANKtRmK0NcmcT87h9EKBWbdANPv+7HDGHuB79NTQ3iFjSex5ZhzQ11T6RYoucGqytkJmq2SIZLCSH4ljfUsjDsEU7WLyrx1tdWYK/Spoq9LoPil/RsAOs4u4P3niPoo0MdogzWmfvl0cgLoDvNWpJAkAtv2v2ZvZakI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aRySKWS9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A37A6C116B1;
	Sat,  1 Jun 2024 11:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717242845;
	bh=mQtDhd51AWq6YLrJqZrV321wR91AZdfTxW6PVSJC8xM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aRySKWS9iOByey0DiuIos6ZYSgpRFl6USVx4PiVvOnoVsTRdkxsW54AiZUS4A5huK
	 qBZVv6YqAnjWJxBHd7xACe+XidTBLVJvWBOdVNFTFxLiMqk9pjCA72knD2QDNYAsAY
	 iyDU2YzSen8mdqTwRWrDUT73ZCWwV/jPLG5mt7opeLRJE/mCDeninFk89ThuIcHQIt
	 aVIdbKoLQsxk7Pi8+DTH8/sEb6qSwoAjWgu+At5e/0jYZuuu761Vlu6sjQWl617NM6
	 yGk/oU6KUqfJrGMG3zJEs7VhzjFBNyreA2Zf8yeYocCUFO3QNtuAvbTUCPDUJ2i8A3
	 nOyBVgFCmLoww==
Date: Sat, 1 Jun 2024 13:53:51 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	unicorn_wang@outlook.com, dlan@gentoo.org, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 2/2] pwm: sophgo: add pwm support for Sophgo CV1800 SoC
Message-ID: <k6jbdbhkgwthxwutty6l4q75wds2nilb3chrv7n4ccycnzllw4@yubxfh5ciahr>
References: <20240501083242.773305-1-qiujingbao.dlmu@gmail.com>
 <20240501083242.773305-3-qiujingbao.dlmu@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dmhnbedd5ai7tszy"
Content-Disposition: inline
In-Reply-To: <20240501083242.773305-3-qiujingbao.dlmu@gmail.com>


--dmhnbedd5ai7tszy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

On Wed, May 01, 2024 at 04:32:42PM +0800, Jingbao Qiu wrote:
> [...]
> diff --git a/drivers/pwm/pwm-cv1800.c b/drivers/pwm/pwm-cv1800.c
> new file mode 100644
> index 000000000000..d487af637198
> --- /dev/null
> +++ b/drivers/pwm/pwm-cv1800.c
> @@ -0,0 +1,293 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Sophgo CV1800 PWM driver
> + * Author: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
> + *
> + * Limitations:
> + * - The hardware emits the inactive level when disabled.
> + * - This pwm device supports dynamic loading of PWM parameters. When PWMSTART
> + *   is written from 0 to 1, the register value (HLPERIODn, PERIODn) will be
> + *   temporarily stored inside the PWM. If you want to dynamically change the
> + *   waveform during PWM output, after writing the new value to HLPERIODn and
> + *   PERIODn, write 1 and then 0 to PWMUPDATE[n] to make the new value effective.

	To change polarity, the hardware has to be stopped though.

> + * - Supports up to Rate/2 output, and the lowest is about Rate/(2^30-1).

Rate = input clock rate?

> + * - By setting HLPERIODn to 0, can produce 100% duty cycle.
> + * - This hardware could support inverted polarity. By default, the value of the
> + *   POLARITY register is 0x0. This means that HLPERIOD represents the number
> + *   of low level beats.
> + * - This hardware supports input mode and output mode, implemented through the
> + *   Output-Enable/OE register. However, this driver has not yet implemented
> + *   capture callback.

> + */
> +
> +#include <linux/clk.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/pwm.h>
> +#include <linux/regmap.h>
> +
> +#define PWM_CV1800_HLPERIOD_BASE    0x00
> +#define PWM_CV1800_PERIOD_BASE      0x04
> +#define PWM_CV1800_POLARITY         0x40
> +#define PWM_CV1800_START            0x44
> +#define PWM_CV1800_DONE             0x48
> +#define PWM_CV1800_UPDATE           0x4c
> +#define PWM_CV1800_OE               0xd0
> +
> +#define PWM_CV1800_HLPERIOD(n)      (PWM_CV1800_HLPERIOD_BASE + ((n)*0x08))
> +#define PWM_CV1800_PERIOD(n)        (PWM_CV1800_PERIOD_BASE + ((n)*0x08))

I suggest to drop the ..._BASE defines and hardcode the 0 and 4
respectively in the definition of PWM_CV1800_HLPERIOD and
PWM_CV1800_PERIOD. Also please use spaces around the multiplication *.

> +#define PWM_CV1800_UPDATE_MASK(n)   BIT(n)
> +#define PWM_CV1800_OE_MASK(n)       BIT(n)
> +#define PWM_CV1800_START_MASK(n)    BIT(n)
> +#define PWM_CV1800_POLARITY_MASK(n) BIT(n)
> +
> +#define PWM_CV1800_MAXPERIOD        0x3fffffff
> +#define PWM_CV1800_MINPERIOD        2
> +#define PWM_CV1800_CHANNELS         4
> +#define PWM_CV1800_PERIOD_RESET     BIT(1)

This is strange, the PWM_CV1800_PERIOD can be programmed with values >=
PWM_CV1800_MINPERIOD; if you program 2, you use period ==
PWM_CV1800_PERIOD_RESET.

> +#define PWM_CV1800_HLPERIOD_RESET   BIT(0)
> +#define PWM_CV1800_REG_ENABLE(n)    BIT(n)
> +
> +struct cv1800_pwm {
> +	struct regmap *map;
> +	struct clk *clk;
> +	unsigned long clk_rate;
> +};
> +
> +static inline struct cv1800_pwm *to_cv1800_pwm_dev(struct pwm_chip *chip)
> +{
> +	return pwmchip_get_drvdata(chip);
> +}
> +
> +static const struct regmap_config cv1800_pwm_regmap_config = {
> +	.reg_bits = 32,
> +	.val_bits = 32,
> +	.reg_stride = 4,
> +};
> +
> +static int cv1800_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm,
> +			     bool enable)
> +{
> +	struct cv1800_pwm *priv = to_cv1800_pwm_dev(chip);
> +	u32 pwm_enable, state;
> +
> +	regmap_read(priv->map, PWM_CV1800_START, &pwm_enable);
> +	pwm_enable &= PWM_CV1800_START_MASK(pwm->hwpwm);

This value tells if the HW is enabled, right. Maybe rename the variable
to pwm_enabled (or pwm_is_enabled).

> +	/*
> +	 * If the parameters are changed during runtime, Register needs
> +	 * to be updated to take effect.
> +	 */
> +	if (pwm_enable && enable) {
> +		regmap_update_bits(priv->map, PWM_CV1800_UPDATE,
> +				   PWM_CV1800_UPDATE_MASK(pwm->hwpwm),
> +				   PWM_CV1800_REG_ENABLE(pwm->hwpwm));

I would consider

		regmap_set_bits(priv->map, PWM_CV1800_UPDATE, BIT(pwm->hwpwm));

more readable.

> +		regmap_update_bits(priv->map, PWM_CV1800_UPDATE,
> +				   PWM_CV1800_UPDATE_MASK(pwm->hwpwm), 0);

Maybe add a comment about why you modify the same bit here twice.

> +	} else if (!pwm_enable && enable) {
> +		regmap_update_bits(priv->map, PWM_CV1800_START,
> +				   PWM_CV1800_START_MASK(pwm->hwpwm),
> +				   PWM_CV1800_REG_ENABLE(pwm->hwpwm));
> +	} else if (pwm_enable && !enable) {
> +		regmap_update_bits(priv->map, PWM_CV1800_START,
> +				   PWM_CV1800_START_MASK(pwm->hwpwm), 0);
> +	}

The previous construct can be (IMO) simplified by doing:

	if (!enable) {
		if (pwm_enabled)
			regmap_clear_bits(...);
		return 0;
	}

	if (pwm_enabled) {
		...
	} else {
		...
	}

(This slightly changes semantics, but that's fine.)

> +
> +	/* check and set OE/Output-Enable mode */
> +	regmap_read(priv->map, PWM_CV1800_OE, &state);
> +
> +	if ((state & BIT(pwm->hwpwm)) && enable)
> +		regmap_update_bits(priv->map, PWM_CV1800_OE,
> +				   PWM_CV1800_OE_MASK(pwm->hwpwm),
> +				   PWM_CV1800_REG_ENABLE(pwm->hwpwm));

This looks strange. If BIT(hwpwm) is already set, set it again?!
Also if you used the caching implemented in regmap, you don't need to
make this conditional.

> +	return 0;
> +}
> +
> +static void cv1800_pwm_set_polarity(struct pwm_chip *chip,
> +				    struct pwm_device *pwm,
> +				    enum pwm_polarity polarity)
> +{
> +	struct cv1800_pwm *priv = to_cv1800_pwm_dev(chip);
> +	u32 config_polarity = 0;
> +
> +	if (pwm->state.enabled)
> +		cv1800_pwm_enable(chip, pwm, !pwm->state.enabled);

Using false instead of !pwm->state.enabled would be more straight
forward.

> +	if (polarity == PWM_POLARITY_NORMAL)
> +		config_polarity = PWM_CV1800_POLARITY_MASK(pwm->hwpwm);
> +
> +	regmap_update_bits(priv->map, PWM_CV1800_POLARITY,
> +			   PWM_CV1800_POLARITY_MASK(pwm->hwpwm),
> +			   config_polarity);
> +}
> +
> +static int cv1800_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> +			    const struct pwm_state *state)
> +{
> +	struct cv1800_pwm *priv = to_cv1800_pwm_dev(chip);
> +	u32 period_val, hlperiod_val;
> +	u64 ticks;
> +
> +	if (state->polarity != pwm->state.polarity)
> +		cv1800_pwm_set_polarity(chip, pwm, state->polarity);
> +
> +	/*
> +	 * This hardware use PERIOD and HLPERIOD registers to represent PWM waves.
> +	 *
> +	 * The meaning of PERIOD is how many clock cycles (from the clock source)
> +	 * are used to represent PWM waves.
> +	 * PERIOD = rate(MHz) / target(MHz)
> +	 * PERIOD = period(ns) * rate(Hz) / NSEC_PER_SEC
> +	 */
> +	ticks = mul_u64_u64_div_u64(state->period, priv->clk_rate,
> +				    NSEC_PER_SEC);
> +	if (ticks < PWM_CV1800_MINPERIOD)
> +		return -EINVAL;

If you check this before configuring the period, it won't happen that
the hw state is modified before you notice you cannot fulfill the
requested state.

> +	if (ticks > PWM_CV1800_MAXPERIOD)
> +		ticks = PWM_CV1800_MAXPERIOD;
> +	period_val = (u32)ticks;

Maybe use period_ticks instead of period_val to have a consistent
naming.

> +
> +	/*
> +	 * After mapping, hlperiod represents the same polarity as duty.
> +	 * HLPERIOD = rate(MHz) / duty(MHz)
> +	 * HLPERIOD = duty(ns) * rate(Hz) / NSEC_PER_SEC
> +	 */

I don't understand that comment.

> +	ticks = mul_u64_u64_div_u64(state->duty_cycle, priv->clk_rate,
> +				    NSEC_PER_SEC);
> +	if (ticks > period_val)
> +		ticks = period_val;
> +	hlperiod_val = (u32)ticks;
> +
> +	regmap_write(priv->map, PWM_CV1800_PERIOD(pwm->hwpwm), period_val);
> +	regmap_write(priv->map, PWM_CV1800_HLPERIOD(pwm->hwpwm), hlperiod_val);
> +
> +	cv1800_pwm_enable(chip, pwm, state->enabled);
> +
> +	return 0;
> +}
> +
> [...]
> +static int cv1800_pwm_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct cv1800_pwm *priv;
> +	struct pwm_chip *chip;
> +	void __iomem *base;
> +	int ret;
> +
> +	chip = devm_pwmchip_alloc(dev, PWM_CV1800_CHANNELS, sizeof(*priv));

PWM_CV1800_CHANNELS is only used here. I'd prefer a plain 4 here. This
also makes this value easier to grep for.

> +	if (!chip)
> +		return PTR_ERR(chip);
> +	priv = to_cv1800_pwm_dev(chip);
> +
> +	base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);
> +
> +	priv->map = devm_regmap_init_mmio(&pdev->dev, base,
> +					  &cv1800_pwm_regmap_config);
> +	if (IS_ERR(priv->map)) {
> +		dev_err(dev, "Couldn't create PWM regmap\n");
> +		return PTR_ERR(priv->map);

Use dev_err_probe please.

> +	}
> +
> +	priv->clk = devm_clk_get_enabled(&pdev->dev, NULL);
> +	if (IS_ERR(priv->clk))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(priv->clk),
> +				     "clk not found\n");
> +
> +	ret = devm_clk_rate_exclusive_get(dev, priv->clk);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret,
> +				     "failed to get exclusive rate\n");
> +
> +	priv->clk_rate = clk_get_rate(priv->clk);
> +	if (!priv->clk_rate)
> +		return dev_err_probe(&pdev->dev, -EINVAL,
> +				     "Invalid clock rate: %lu\n",
> +				     priv->clk_rate);

Please also error out if clk_rate > NSEC_PER_SEC, because otherwise you
might get overflows for the calculations in .apply().

> +
> +	chip->ops = &cv1800_pwm_ops;
> +
> +	ret = devm_pwmchip_add(dev, chip);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to add PWM chip\n");
> +
> +	return 0;
> +}
> [...]

Best regards
Uwe

--dmhnbedd5ai7tszy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmZbC7wACgkQj4D7WH0S
/k5b1gf/RllMWyJU0W0EdBHc95DZbdJYePgvIo8GBPmcmcShca+0b+B81XlVkE9d
O2/9v58B/0hI7F/g1vbxjk+h0j6lBLjgNeC8Ke2FWDTbuagxk+h3DDxbw3TAaF0M
rErHO22dMFaIvJTB/AKM5r8B3COvZXtyLMRDEVhVK8zRvLcdQMu+Pw8L0QqSxja1
LIzsbVltneMVG2s0CrM4oAwTguqCKSnScF31fsXbjbxbETI8A3z8SLDQGAb+j/Ge
vTzFK8WCBX+ccNbCDD/tKRDgh/NVTvX/1JvEzhHuGyS5LWXK1wRI/qqKyqDw5x/W
hDkTNm8z/S89qEF5MZdXlhO+LXtaEg==
=rwZj
-----END PGP SIGNATURE-----

--dmhnbedd5ai7tszy--

