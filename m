Return-Path: <linux-pwm+bounces-9165-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CLW8EuuyFmokogcAu9opvQ
	(envelope-from <linux-pwm+bounces-9165-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 27 May 2026 11:01:31 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B7DB5E1771
	for <lists+linux-pwm@lfdr.de>; Wed, 27 May 2026 11:01:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 094DA30686DD
	for <lists+linux-pwm@lfdr.de>; Wed, 27 May 2026 08:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E16933E3145;
	Wed, 27 May 2026 08:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cjgFmfHv"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A853976AD;
	Wed, 27 May 2026 08:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779872136; cv=none; b=oZNuax8jQtGNrnu/WkjrPMvI2xhN3PL3pYpM3CLAyRlhNjFJ0PScLPeiABwhwLV3GFbUj2hBuWk6o+xag/q+7w2MEchRZID5H0emVG6sJ16CefQw62pPXpCEBeWzl4eWucCrThBO4Z/gPw1BGvO7DA2/JCdRS8r01/J580FJa+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779872136; c=relaxed/simple;
	bh=lEwCr6BuCo1SL4vbLe2Es4zN1+pS2TYQxjLgtYqgtik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hdhwz07eGzgw1y3B69WlBR2ZoqmNbIVQi9xkGO88gyUx29006GAs2Y4lvZFhSRlqlX3EIDQ5yM7pCIDW+n6Q97yGwmxeyI/qpoRtwYheNcCcUKwkGvnv4fbzTiVN4w/bPup70h7B/vzTUQaBmMZdJ0gaOdwDkvZmyE1BGvlntjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cjgFmfHv; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 450011F00ACF;
	Wed, 27 May 2026 08:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779872134;
	bh=ZEcr3GfgN9GEDhisD/lw9lF9PWEQ66FnzcFrj0iaVW4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cjgFmfHvb8bt+bgXOEPlY/W5TzS2vOcqwIOF+galjlid0Z+JorL52XE73LczqCWoD
	 MJW0tvkWN9+gbbx8W145gWexMiqlebLylB1W/rybjzjbK9m5QVZrCXOEyoCZgFP7Ap
	 SwZIBt0IEuf5OnrhsP90NyBjB7DDiFIXPRMFBnT9i58keH16AR7zLOK24zrSUsvhqY
	 Y3bjNsheJkGd70cDhVqMoCJYDzz2iwOiMx9IPf6Llo8lOwIw3SczPlMiue6AoVPktj
	 DOIFs5FEfy6BcVAo5EciItnWywN6CHiM92JfQHxSdY8n4tZy+bkVcGXoJEnTWVSf1z
	 tI4iUhxcOLYWA==
Date: Wed, 27 May 2026 10:55:32 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: ben717@andestech.com
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/3] pwm: add Andes PWM driver support
Message-ID: <ahajkcejv71TwV5f@monoceros>
References: <20260330-andes-pwm-v5-0-01c59a659d2c@andestech.com>
 <20260330-andes-pwm-v5-2-01c59a659d2c@andestech.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qvg65orckwj2rpzn"
Content-Disposition: inline
In-Reply-To: <20260330-andes-pwm-v5-2-01c59a659d2c@andestech.com>
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9165-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ukleinek@kernel.org,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,andestech.com:email]
X-Rspamd-Queue-Id: 9B7DB5E1771
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--qvg65orckwj2rpzn
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v5 2/3] pwm: add Andes PWM driver support
MIME-Version: 1.0

Hello Ben,

On Mon, Mar 30, 2026 at 03:45:44PM +0800, Ben Zong-You Xie via B4 Relay wro=
te:
> From: Ben Zong-You Xie <ben717@andestech.com>
>=20
> Add a driver for the PWM controller found in Andes AE350 platforms and
> QiLai SoCs.
>=20
> The Andes PWM controller features:
> - 4 independent channels.
> - Dual clock source support (APB clock and external clock) to provide
>   a flexible range of frequencies.
> - Support for normal and inversed polarity.
>=20
> The driver implements the .apply() and .get_state() callbacks. Since the
> clock source of each channel can be selected by programming the
> register, clock selection logic is implemented to prioritize the
> external clock to maximize the supported period range, falling back to
> the APB clock for higher frequency requirements.
>=20
> Signed-off-by: Ben Zong-You Xie <ben717@andestech.com>
> ---
>  drivers/pwm/Kconfig     |  10 ++
>  drivers/pwm/Makefile    |   1 +
>  drivers/pwm/pwm-andes.c | 306 ++++++++++++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 317 insertions(+)
>=20
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 6f3147518376..b82f2c857ada 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -73,6 +73,16 @@ config PWM_AIROHA
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm-airoha.
> =20
> +config PWM_ANDES
> +	tristate "Andes PWM support"
> +	depends on ARCH_ANDES || COMPILE_TEST
> +	help
> +	  Generic PWM framework driver for Andes platform, such as QiLai SoC
> +	  and AE350 platform.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called pwm-andes.
> +
>  config PWM_APPLE
>  	tristate "Apple SoC PWM support"
>  	depends on ARCH_APPLE || COMPILE_TEST
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index 0dc0d2b69025..858f225289cc 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -3,6 +3,7 @@ obj-$(CONFIG_PWM)		+=3D core.o
>  obj-$(CONFIG_PWM_AB8500)	+=3D pwm-ab8500.o
>  obj-$(CONFIG_PWM_ADP5585)	+=3D pwm-adp5585.o
>  obj-$(CONFIG_PWM_AIROHA)	+=3D pwm-airoha.o
> +obj-$(CONFIG_PWM_ANDES)		+=3D pwm-andes.o
>  obj-$(CONFIG_PWM_APPLE)		+=3D pwm-apple.o
>  obj-$(CONFIG_PWM_ARGON_FAN_HAT)	+=3D pwm-argon-fan-hat.o
>  obj-$(CONFIG_PWM_ATMEL)		+=3D pwm-atmel.o
> diff --git a/drivers/pwm/pwm-andes.c b/drivers/pwm/pwm-andes.c
> new file mode 100644
> index 000000000000..835c8db55987
> --- /dev/null
> +++ b/drivers/pwm/pwm-andes.c
> @@ -0,0 +1,306 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Driver for Andes PWM, used in Andes AE350 platform and QiLai SoC
> + *
> + * Copyright (C) 2026 Andes Technology Corporation.
> + *
> + * Limitations:
> + * - When disabling a channel, the current period will not be completed,=
 and the
> + *   output will be constant zero.

You could use that to simulate a 0% relative duty cycle instead of
erroring out.

Just to be sure: A disabled channel emits zero independant of
ANDES_PWM_CH_CTRL_PARK being set or not?!

> + * - The current period will be completed first if reconfiguring.
> + * - Further, if the reconfiguration changes the clock source, the outpu=
t will
> + *   not be the old one nor the new one. And the output will be the new =
one
> + *   until writing to the reload register.
> + * - The hardware can neither do a 0% nor a 100% relative duty cycle.
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/clk.h>
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
> +#define ANDES_PWM_CH_ENABLE		0x1C
> +#define ANDES_PWM_CH_ENABLE_PWM(ch)	BIT(3 + (4 * (ch)))
> +
> +#define ANDES_PWM_CH_CTRL(ch)		(0x20 + (0x10 * (ch)))
> +#define ANDES_PWM_CH_CTRL_MODE_PWM	BIT(2)
> +#define ANDES_PWM_CH_CTRL_CLK		BIT(3)
> +#define ANDES_PWM_CH_CTRL_PARK		BIT(4)
> +#define ANDES_PWM_CH_CTRL_MASK		GENMASK(4, 0)
> +
> +#define ANDES_PWM_CH_RELOAD(ch)		(0x24 + (0x10 * (ch)))
> +#define ANDES_PWM_CH_RELOAD_HIGH	GENMASK(31, 16)
> +#define ANDES_PWM_CH_RELOAD_LOW		GENMASK(15, 0)
> +
> +#define ANDES_PWM_CH_COUNTER(ch)	(0x28 + (0x10 * (ch)))
> +
> +#define ANDES_PWM_CH_MAX		4
> +#define ANDES_PWM_CYCLE_MIN		1
> +#define ANDES_PWM_CYCLE_MAX		0x10000
> +
> +struct andes_pwm {
> +	struct regmap *regmap;
> +	struct clk *pclk;
> +	struct clk *extclk;
> +	unsigned int pclk_rate;
> +	unsigned int extclk_rate;
> +};
> +
> +static const struct regmap_config andes_pwm_regmap_config =3D {
> +	.name =3D "andes_pwm",
> +	.reg_bits =3D 32,
> +	.reg_stride =3D 4,
> +	.val_bits =3D 32,
> +	.pad_bits =3D 0,
> +	.max_register =3D ANDES_PWM_CH_COUNTER(ANDES_PWM_CH_MAX - 1),
> +	.cache_type =3D REGCACHE_NONE,
> +};
> +
> +static inline struct andes_pwm *to_andes_pwm(struct pwm_chip *chip)

If you rename this to andes_pwm_from_chip this function has the driver's
function name prefix, too.

> +{
> +	return pwmchip_get_drvdata(chip);
> +}
> +
> +static int andes_pwm_enable(struct pwm_chip *chip, unsigned int channel,
> +			    bool enable)
> +{
> +	struct andes_pwm *ap =3D to_andes_pwm(chip);
> +
> +	return regmap_assign_bits(ap->regmap, ANDES_PWM_CH_ENABLE,
> +				  ANDES_PWM_CH_ENABLE_PWM(channel), enable);
> +}
> +
> +static int andes_pwm_config(struct pwm_chip *chip, unsigned int channel,
> +			    const struct pwm_state *state)
> +{
> +	struct andes_pwm *ap =3D to_andes_pwm(chip);
> +	unsigned int clk_rate =3D ap->extclk_rate;
> +	unsigned int try =3D 2;
> +	u64 high_ns =3D state->duty_cycle;
> +	u64 low_ns =3D state->period - high_ns;

This results in rounding errors. Consider:

	clk_rate =3D 500000000
	state->duty_cycle =3D 17
	state->period =3D 32

then you configure=20

	high_cycles =3D 8
	low_cycles =3D 7

which corresponds to a period =3D 30 ns, while you can do 32 ns. So you
have to convert state->period to ticks and do the subtraction in the
tick domain.

> +	unsigned int ctrl =3D ANDES_PWM_CH_CTRL_MODE_PWM;
> +	u64 high_cycles;
> +	u64 low_cycles;
> +	u32 reload;
> +
> +	/*
> +	 * Reload register for PWM mode:
> +	 *
> +	 *		31 : 16    15 : 0
> +	 *		PWM16_Hi | PWM16_Lo
> +	 *
> +	 * The high duration is (PWM16_Hi + 1) cycles and the low duration is
> +	 * (PWM16_Lo + 1) cycles. For a duty cycle of 10 cycles and a total
> +	 * period of 30 cycles in normal polarity, PWM16_Hi is set to
> +	 * 9 (10 - 1) and PWM16_Lo to 19 (30 - 10 - 1). Also, PWM16_Hi is set to
> +	 * 19 and PWM16_Lo is set to 9 in inversed polarity.
> +	 *
> +	 * Because the register stores "cycles - 1", the valid range for
> +	 * each phase is 1 to 65536 (0x10000) cycles. This implies the hardware
> +	 * cannot achieve a true 0% or 100% duty cycle.
> +	 *
> +	 * The controller supports two clock sources: the APB clock and an
> +	 * external clock. The driver first attempts to use the external clock
> +	 * to widest possible range of supported periods. If the requests
> +	 * exceeds the valid range of the register, it falls back to the APB
> +	 * clock. The request is rejected if the timing cannot be met by either
> +	 * source.
> +	 */
> +	if (state->polarity =3D=3D PWM_POLARITY_INVERSED)
> +		swap(high_ns, low_ns);
> +
> +	while (try) {
> +		high_cycles =3D mul_u64_u64_div_u64(clk_rate, high_ns,
> +						  NSEC_PER_SEC);
> +		low_cycles =3D mul_u64_u64_div_u64(clk_rate, low_ns,
> +						 NSEC_PER_SEC);
> +		if (high_cycles > ANDES_PWM_CYCLE_MAX)
> +			high_cycles =3D ANDES_PWM_CYCLE_MAX;
> +
> +		if (low_cycles > ANDES_PWM_CYCLE_MAX)
> +			low_cycles =3D ANDES_PWM_CYCLE_MAX;
> +
> +		if (high_cycles >=3D ANDES_PWM_CYCLE_MIN &&
> +		    low_cycles >=3D ANDES_PWM_CYCLE_MIN)
> +			break;
> +
> +		try--;
> +		clk_rate =3D ap->pclk_rate;
> +	}

This loop implements:

	if extclk_rate is too high:
		if pclk is too high:
			error out
		else:
			use pclk
	else:
		use extclk

This might be surprising for a user because the emitted period depends
on the requested duty_cycle.

> +
> +	/*
> +	 * try =3D=3D 0 : no clock is valid
> +	 * try =3D=3D 1 : use APB clock
> +	 * try =3D=3D 2 : use external clock
> +	 */
> +	if (!try)
> +		return -EINVAL;
> +
> +	/*
> +	 * If changing the clock source here, the output will not be the old one
> +	 * nor the new one. And the output will be the new one until writing to
> +	 * the reload register.

And the output will be the new one *after* writing to the reload register?

> +	 */
> +	ctrl |=3D (try =3D=3D 1) ? ANDES_PWM_CH_CTRL_CLK : 0;
> +	ctrl |=3D (state->polarity =3D=3D PWM_POLARITY_INVERSED) ?
> +		ANDES_PWM_CH_CTRL_PARK : 0;
> +	regmap_update_bits(ap->regmap, ANDES_PWM_CH_CTRL(channel),
> +			   ANDES_PWM_CH_CTRL_MASK, ctrl);
> +	reload =3D FIELD_PREP(ANDES_PWM_CH_RELOAD_HIGH, high_cycles - 1) |
> +		 FIELD_PREP(ANDES_PWM_CH_RELOAD_LOW, low_cycles - 1);
> +
> +	return regmap_write(ap->regmap, ANDES_PWM_CH_RELOAD(channel), reload);
> +}
> +
> +static int andes_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> +			   const struct pwm_state *state)
> +{
> +	unsigned int channel =3D pwm->hwpwm;
> +	int ret;
> +
> +	if (!state->enabled) {
> +		if (pwm->state.enabled)
> +			andes_pwm_enable(chip, channel, false);
> +
> +		return 0;
> +	}
> +
> +	ret =3D andes_pwm_config(chip, channel, state);
> +	if (ret)
> +		return ret;
> +
> +	return andes_pwm_enable(chip, channel, true);
> +}
> +
> +static int andes_pwm_get_state(struct pwm_chip *chip, struct pwm_device =
*pwm,
> +			       struct pwm_state *state)
> +{
> +	struct andes_pwm *ap =3D to_andes_pwm(chip);
> +	unsigned int channel =3D pwm->hwpwm;
> +	unsigned int ctrl;
> +	unsigned int clk_rate;
> +	unsigned int reload;
> +	u64 high_cycles;
> +	u64 low_cycles;
> +
> +	regmap_read(ap->regmap, ANDES_PWM_CH_CTRL(channel), &ctrl);
> +	clk_rate =3D FIELD_GET(ANDES_PWM_CH_CTRL_CLK, ctrl) ? ap->pclk_rate
> +							  : ap->extclk_rate;
> +	state->enabled =3D regmap_test_bits(ap->regmap, ANDES_PWM_CH_ENABLE,
> +					  ANDES_PWM_CH_ENABLE_PWM(channel));
> +	state->polarity =3D regmap_test_bits(ap->regmap,
> +					   ANDES_PWM_CH_CTRL(channel),
> +					   ANDES_PWM_CH_CTRL_PARK);

This can be simplified to use FIELD_GET(..., ctrl);

> +	regmap_read(ap->regmap, ANDES_PWM_CH_RELOAD(channel), &reload);
> +	high_cycles =3D FIELD_GET(ANDES_PWM_CH_RELOAD_HIGH, reload) + 1;
> +	low_cycles =3D FIELD_GET(ANDES_PWM_CH_RELOAD_LOW, reload) + 1;
> +
> +	/*
> +	 * high_cycles and low_cycles are both 16 bits, and NSEC_PER_SEC is 30
> +	 * bits. Thus, the multiplication is safe from overflow

Missing . at the end.

> +	 */
> +	if (state->polarity =3D=3D PWM_POLARITY_NORMAL) {
> +		state->duty_cycle =3D DIV_ROUND_UP_ULL(high_cycles * NSEC_PER_SEC,
> +						     clk_rate);
> +		state->period =3D state->duty_cycle +
> +				DIV_ROUND_UP_ULL(low_cycles * NSEC_PER_SEC,
> +						 clk_rate);
> +	} else {
> +		state->duty_cycle =3D DIV_ROUND_UP_ULL(low_cycles * NSEC_PER_SEC,
> +						     clk_rate);
> +		state->period =3D state->duty_cycle +
> +				DIV_ROUND_UP_ULL(high_cycles * NSEC_PER_SEC,
> +						 clk_rate);

Here is a rounding error. You need

	state->period =3D DIV_ROUND_UP_ULL((low_cycles + high_cycles) * NSEC_PER_S=
EC, clk_rate);

(for both polarities, so it can be moved out of the if).

To see the difference, consider clk_rate =3D 2 * NSEC_PER_SEC,
high_cycles =3D 15 and low_cycles =3D 15.

> +	}
> +
> +	return 0;
> +}
> +
> +static const struct pwm_ops andes_pwm_ops =3D {
> +	.apply =3D andes_pwm_apply,
> +	.get_state =3D andes_pwm_get_state,
> +};
> +
> +static int andes_pwm_probe(struct platform_device *pdev)
> +{
> +	struct device *dev =3D &pdev->dev;
> +	struct pwm_chip *chip;
> +	struct andes_pwm *ap;
> +	void __iomem *reg_base;
> +	int ret;
> +
> +	chip =3D devm_pwmchip_alloc(dev, ANDES_PWM_CH_MAX, sizeof(*ap));
> +	if (IS_ERR(chip))
> +		return PTR_ERR(chip);
> +
> +	ap =3D to_andes_pwm(chip);
> +	reg_base =3D devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(reg_base))
> +		return dev_err_probe(dev, PTR_ERR(reg_base),
> +				     "failed to map I/O space\n");
> +
> +	ap->pclk =3D devm_clk_get_enabled(dev, "pclk");
> +	if (IS_ERR(ap->pclk))
> +		return dev_err_probe(dev, PTR_ERR(ap->pclk),
> +				     "failed to get APB clock\n");
> +
> +	ap->extclk =3D devm_clk_get_optional_enabled(dev, "extclk");
> +	if (IS_ERR(ap->extclk))
> +		return dev_err_probe(dev, PTR_ERR(ap->extclk),
> +				     "failed to get external clock\n");
> +
> +	/*
> +	 * If the clock rate is greater than 10^9, there may be an overflow when
> +	 * calculating the cycles in andes_pwm_config()
> +	 */
> +	ap->pclk_rate =3D clk_get_rate(ap->pclk);
> +	if (ap->pclk_rate > NSEC_PER_SEC)
> +		ap->pclk =3D NULL;

This is not enough to prevent that pclk is used.

> +	ap->extclk_rate =3D ap->extclk ? clk_get_rate(ap->extclk) : 0;
> +	if (ap->extclk_rate > NSEC_PER_SEC)
> +		ap->extclk =3D NULL;
> +
> +	if (!ap->pclk && !ap->extclk)
> +		return dev_err_probe(dev, -EINVAL, "clocks are out of range\n");

If you mention the clk rates in the error message, the problem to fix
becomes easier to identify.

> +	ap->regmap =3D devm_regmap_init_mmio(dev, reg_base,
> +					   &andes_pwm_regmap_config);
> +	if (IS_ERR(ap->regmap)) {
> +		return dev_err_probe(dev, PTR_ERR(ap->regmap),
> +				     "failed to initialize regmap\n");
> +	}

Don't use { ... } for single statements. Please start error messages
with a capital letter.

> +
> +	chip->ops =3D &andes_pwm_ops;
> +	ret =3D devm_pwmchip_add(dev, chip);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to add pwm chip\n");
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id andes_pwm_of_match[] =3D {
> +	{ .compatible =3D "andestech,ae350-pwm" },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, andes_pwm_of_match);
> +
> +static struct platform_driver andes_pwm_driver =3D {
> +	.driver =3D {
> +		.name =3D "andes_pwm",
> +		.of_match_table =3D andes_pwm_of_match,
> +	},
> +	.probe =3D andes_pwm_probe,
> +};
> +module_platform_driver(andes_pwm_driver);
> +
> +MODULE_AUTHOR("Ben Zong-You Xie <ben717@andestech.com>");
> +MODULE_DESCRIPTION("Andes PWM driver");
> +MODULE_LICENSE("GPL");

Best regards
Uwe

--qvg65orckwj2rpzn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmoWsYEACgkQj4D7WH0S
/k4jNggAqFVLZhPZJ0m9WaJgawfWORstcdHvHU9J1b6W9wUOOm+Pd8zZ2/zEbjhZ
D2ecmhFYsqQqikXoz2clcrZLQRP/qSK00DC5Ox72IfD4aHF6ijNqcZ/UxKfwgcsz
ri1KMkJp3SohzuCULUs+S/gAQXULEAUMOSK2zZllRSslxrzUBEQLzqR/3H65voz3
HRFCTaByI3LZjpuTD79Iz1RV0Nfyah3YX0v7PsY42PPtifIQ30Nd1blWJatzLW7L
RRT8bMySKlbUIXq4ss7iZSRFlu/CCALgeLPxIplKfpOUwvNWxRnSA0QjcU0JPsG5
sNBeSIW0Opv4fKqueHWaOjRkg2j9hg==
=4zvY
-----END PGP SIGNATURE-----

--qvg65orckwj2rpzn--

