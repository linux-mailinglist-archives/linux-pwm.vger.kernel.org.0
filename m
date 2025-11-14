Return-Path: <linux-pwm+bounces-7628-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 955FBC5CA80
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Nov 2025 11:47:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C05783489EA
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Nov 2025 10:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92CB9310621;
	Fri, 14 Nov 2025 10:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZQGgHFes"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB19309EE1;
	Fri, 14 Nov 2025 10:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763116871; cv=none; b=MMH+t6YH0q0SUTBFjFR0Cckj9nEB6D0JYtWX8mHEubiTIk/aGl/dVKkcFT8WW/ul2GCUdvM3w3nKqnPH28Fl9quAUKQQIcBGReY+Nrhj5vqdvrOlr0n5tCfwWCuelUyLKOA6f4d3Dqh0EHFznEQCgig+9ivufHL0BEdQ5ua71uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763116871; c=relaxed/simple;
	bh=4W0ULHAy2cGRMJgeys4gL5NNTPO0TdPTo+3Aii9Ibqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=txQNHPaog9kdZI3wCmyAeGEfuSPKQdWE/K8Qw87O45H3ghjxmPseJonUU6op6kNCynO8WSHDUBOSiE4V3MVa7qNAhiyTCI3yrmkIqIsz86CYHKtI1MmJrm7R/IHl0s9toxf1A4LmXTcngtHtedIScXJqnoaKwkxN8dzmDbFfnxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZQGgHFes; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BAF3C4CEF8;
	Fri, 14 Nov 2025 10:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763116870;
	bh=4W0ULHAy2cGRMJgeys4gL5NNTPO0TdPTo+3Aii9Ibqw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZQGgHFespGeTJV5RsJ2W73IHbr1fl2qwFFp9V4gazzMvRIwLQrKOLVHkJOst56hTO
	 /L1M2JpTgdIjab4Zdle1gMRNYHs7+7myEU7oMcbc16WksZwl415CEc9sVcn3jo9WnB
	 59kimepZIVlsQ3JjzvwruyDJXB98h7S1SwYddhKsUXoa9HTiLJoWj6qWBoCPIKq5Jl
	 N1uVWdvMoLe5LpqkYfgE3t8OV1XYhTaqnMud8U5O5EzmbA3cd3TbxWXB5Pko42thvL
	 XdjrJBr8YVA9Fjawir1NUp5vNs0X6h9KvPPL76nbJCKfzc1ji8KnjtBxqq5JAhE/mZ
	 VQ2SV9HSNOoeA==
Date: Fri, 14 Nov 2025 11:41:07 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Lee Jones <lee@kernel.org>, 
	William Breathitt Gray <wbg@kernel.org>, kernel@collabora.com, Jonas Karlman <jonas@kwiboo.se>, 
	Alexey Charkov <alchark@gmail.com>, linux-rockchip@lists.infradead.org, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 3/5] pwm: Add rockchip PWMv4 driver
Message-ID: <hgiib7nbvz34kmeusuhso6zvluyuvpbz5lm2kzkv6kkm4pq5ms@2xu44lkkdcap>
References: <20251027-rk3576-pwm-v3-0-654a5cb1e3f8@collabora.com>
 <20251027-rk3576-pwm-v3-3-654a5cb1e3f8@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ariuc2jwdr43jb5d"
Content-Disposition: inline
In-Reply-To: <20251027-rk3576-pwm-v3-3-654a5cb1e3f8@collabora.com>


--ariuc2jwdr43jb5d
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 3/5] pwm: Add rockchip PWMv4 driver
MIME-Version: 1.0

Hello Nicolas,

On Mon, Oct 27, 2025 at 06:11:58PM +0100, Nicolas Frattaroli wrote:
> The Rockchip RK3576 brings with it a new PWM IP, in downstream code
> referred to as "v4". This new IP is different enough from the previous
> Rockchip IP that I felt it necessary to add a new driver for it, instead
> of shoehorning it in the old one.
>=20
> Add this new driver, based on the PWM core's waveform APIs. Its platform
> device is registered by the parent mfpwm driver, from which it also
> receives a little platform data struct, so that mfpwm can guarantee that
> all the platform device drivers spread across different subsystems for
> this specific hardware IP do not interfere with each other.
>=20
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> ---
>  MAINTAINERS                   |   1 +
>  drivers/pwm/Kconfig           |  13 ++
>  drivers/pwm/Makefile          |   1 +
>  drivers/pwm/pwm-rockchip-v4.c | 353 ++++++++++++++++++++++++++++++++++++=
++++++
>  4 files changed, 368 insertions(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8f3235ba825e..2079c2d51d5c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -22372,6 +22372,7 @@ L:	linux-rockchip@lists.infradead.org
>  L:	linux-pwm@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/pwm/rockchip,rk3576-pwm.yaml
> +F:	drivers/pwm/pwm-rockchip-v4.c
>  F:	drivers/soc/rockchip/mfpwm.c
>  F:	include/soc/rockchip/mfpwm.h
> =20
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index c2fd3f4b62d9..b852a7b2a29d 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -615,6 +615,19 @@ config PWM_ROCKCHIP
>  	  Generic PWM framework driver for the PWM controller found on
>  	  Rockchip SoCs.
> =20
> +config PWM_ROCKCHIP_V4
> +	tristate "Rockchip PWM v4 support"
> +	depends on ARCH_ROCKCHIP || COMPILE_TEST
> +	depends on HAS_IOMEM
> +	depends on MFD_ROCKCHIP_MFPWM

IMHO it's a bit strange that PWM_ROCKCHIP_V4 depends on ARCH_ROCKCHIP
while MFD_ROCKCHIP_MFPWM doesn't. So you can enable the MFD on all
platforms but the PWM component driver only on rockchip.

> +	help
> +	  Generic PWM framework driver for the PWM controller found on
> +	  later Rockchip SoCs such as the RK3576.
> +
> +	  Uses the Rockchip Multi-function PWM controller driver infrastructure
> +	  to guarantee fearlessly concurrent operation with other functions of
> +	  the same device implemented by drivers in other subsystems.
> +
>  config PWM_SAMSUNG
>  	tristate "Samsung PWM support"
>  	depends on PLAT_SAMSUNG || ARCH_S5PV210 || ARCH_EXYNOS || COMPILE_TEST
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index dfa8b4966ee1..fe0d16558d99 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -55,6 +55,7 @@ obj-$(CONFIG_PWM_RENESAS_RZG2L_GPT)	+=3D pwm-rzg2l-gpt.o
>  obj-$(CONFIG_PWM_RENESAS_RZ_MTU3)	+=3D pwm-rz-mtu3.o
>  obj-$(CONFIG_PWM_RENESAS_TPU)	+=3D pwm-renesas-tpu.o
>  obj-$(CONFIG_PWM_ROCKCHIP)	+=3D pwm-rockchip.o
> +obj-$(CONFIG_PWM_ROCKCHIP_V4)	+=3D pwm-rockchip-v4.o
>  obj-$(CONFIG_PWM_SAMSUNG)	+=3D pwm-samsung.o
>  obj-$(CONFIG_PWM_SIFIVE)	+=3D pwm-sifive.o
>  obj-$(CONFIG_PWM_SL28CPLD)	+=3D pwm-sl28cpld.o
> diff --git a/drivers/pwm/pwm-rockchip-v4.c b/drivers/pwm/pwm-rockchip-v4.c
> new file mode 100644
> index 000000000000..7afa83f12b6a
> --- /dev/null
> +++ b/drivers/pwm/pwm-rockchip-v4.c
> @@ -0,0 +1,353 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2025 Collabora Ltd.
> + *
> + * A Pulse-Width-Modulation (PWM) generator driver for the generators fo=
und in
> + * Rockchip SoCs such as the RK3576, internally referred to as "PWM v4".=
 Uses
> + * the MFPWM infrastructure to guarantee exclusive use over the device w=
ithout
> + * other functions of the device from different drivers interfering with=
 its
> + * operation while it's active.
> + *
> + * Technical Reference Manual: Chapter 31 of the RK3506 TRM Part 1, a So=
C which
> + * uses the same PWM hardware and has a publicly available TRM.
> + * https://opensource.rock-chips.com/images/3/36/Rockchip_RK3506_TRM_Par=
t_1_V1.2-20250811.pdf
> + *
> + * Authors:
> + *     Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> + *
> + * Limitations:
> + * - When the output is disabled, it will end abruptly without letting t=
he
> + *   current period complete.
> + *   TODO: This can be fixed in the driver in the future by having the e=
nable-
> + *         to-disable transition switch to oneshot mode with one repetit=
ion,
> + *         and then disable the pwmclk and release mfpwm when the oneshot
> + *         complete interrupt fires.

I don't consider this behaviour a bug. So maybe:

  - The hardware supports both completing the currently running period
    on disable (by switching to oneshot mode with a single repetition
    and only disable when the complete irq fires) and abrupt disable.
    Only the latter is implemented in the driver.

> + * - When the output is disabled, the pin will remain driven to whatever=
 state
> + *   it last had.
> + * - Adjustments to the duty cycle will only take effect during the next=
 period.
> + * - Adjustments to the period length will only take effect during the n=
ext
> + *   period.

Is it possible that a race condition occurs here and between updating
duty and period a new cycle starts and thus a period with the new duty
and old period (or vice versa) is externally visible?

> + * - offset should be between 0 and (period - duty)

This sounds wrong here. Assuming the driver enforces that (it should,
didn't check yet), this should be:

  - The hardware only supports offsets in [0, period-duty_cycle]

> + */
> +
> +#include <linux/math64.h>
> +#include <linux/mfd/rockchip-mfpwm.h>
> +#include <linux/platform_device.h>
> +#include <linux/pwm.h>
> +
> +struct rockchip_pwm_v4 {
> +	struct rockchip_mfpwm_func *pwmf;
> +	struct pwm_chip chip;
> +};
> +
> +struct rockchip_pwm_v4_wf {
> +	u32 period;
> +	u32 duty;
> +	u32 offset;
> +	u8 enable;
> +};
> +
> +static inline struct rockchip_pwm_v4 *to_rockchip_pwm_v4(struct pwm_chip=
 *chip)
> +{
> +	return pwmchip_get_drvdata(chip);
> +}
> +
> +/**
> + * rockchip_pwm_v4_round_single - convert a PWM parameter to hardware
> + * @rate: clock rate of the PWM clock, as per clk_get_rate
> + * @in_val: parameter in nanoseconds to convert
> + *
> + * Returns the rounded value, saturating at U32_MAX if too large
> + */
> +static u32 rockchip_pwm_v4_round_single(unsigned long rate, u64 in_val)
> +{
> +	u64 tmp;
> +
> +	tmp =3D mul_u64_u64_div_u64(rate, in_val, NSEC_PER_SEC);

This might overflow for rate > NSEC_PER_SEC and big values of in_val.

I suggest to call devm_clk_rate_exclusive_get() in .probe() and fail to
probe for rate > NSEC_PER_SEC.

> +	if (tmp > U32_MAX)
> +		tmp =3D U32_MAX;
> +
> +	return (u32)tmp;

unneeded cast.

> +}
> +
> +/**
> + * rockchip_pwm_v4_round_params - convert PWM parameters to hardware
> + * @rate: PWM clock rate to do the calculations at
> + * @duty: PWM duty cycle in nanoseconds
> + * @period: PWM period in nanoseconds
> + * @offset: PWM offset in nanoseconds
> + * @out_duty: pointer to where the rounded duty value should be stored
> + * @out_period: pointer to where the rounded period value should be stor=
ed
> + * @out_offset: pointer to where the rounded offset value should be stor=
ed
> + *
> + * Convert nanosecond-based duty/period/offset parameters to the PWM har=
dware's
> + * native rounded representation in number of cycles at clock rate @rate=
=2E Should
> + * any of the input parameters be out of range for the hardware, the
> + * corresponding output parameter is the maximum permissible value for s=
aid
> + * parameter with considerations to the others.
> + */
> +static void rockchip_pwm_v4_round_params(unsigned long rate, u64 duty,
> +					u64 period, u64 offset, u32 *out_duty,
> +					u32 *out_period, u32 *out_offset)

Hmm, it would be more natural to pass rate, wf and wfhw here, wouldn't
it?

> +{
> +	*out_period =3D rockchip_pwm_v4_round_single(rate, period);
> +
> +	*out_duty =3D rockchip_pwm_v4_round_single(rate, duty);
> +
> +	/* As per TRM, PWM_OFFSET: "The value ranges from 0 to (period-duty)" */
> +	*out_offset =3D rockchip_pwm_v4_round_single(rate, offset);
> +	if (*out_offset > (*out_period - *out_duty))

needless parenthesis

You rely on out_period >=3D out_duty. You can assume that
rockchip_pwm_v4_round_wf_tohw() is only called with wf->period_length_ns
>=3D wf->duty_offset_ns, but still worth a comment IMHO.

> +		*out_offset =3D *out_period - *out_duty;
> +}
> +
> +static int rockchip_pwm_v4_round_wf_tohw(struct pwm_chip *chip,
> +					 struct pwm_device *pwm,
> +					 const struct pwm_waveform *wf,
> +					 void *_wfhw)
> +{
> +	struct rockchip_pwm_v4 *pc =3D to_rockchip_pwm_v4(chip);
> +	struct rockchip_pwm_v4_wf *wfhw =3D _wfhw;
> +	unsigned long rate;
> +
> +	rate =3D clk_get_rate(pc->pwmf->core);
> +
> +	rockchip_pwm_v4_round_params(rate, wf->duty_length_ns,
> +				     wf->period_length_ns, wf->duty_offset_ns,
> +				     &wfhw->duty, &wfhw->period, &wfhw->offset);
> +
> +	if (wf->period_length_ns > 0)
> +		wfhw->enable =3D PWMV4_EN_BOTH_MASK;
> +	else
> +		wfhw->enable =3D 0;
> +
> +	dev_dbg(&chip->dev,
> +		"tohw: duty %llu -> %u, period %llu -> %u, offset %llu -> %u, rate %lu=
\n",
> +		wf->duty_length_ns, wfhw->duty, wf->period_length_ns,
> +		wfhw->period, wf->duty_offset_ns, wfhw->offset, rate);

Can you make that:

	dev_dbg(&chip->dev,
		"tohw: pwm#%u: %lld/%lld [+%lld] @%lu -> DUTY: %08x, PERIOD: %08x, OFFSET=
: %08x\n",
		pwm->hwpwm, wf->duty_length_ns, wf->period_length_ns,
		wf->duty_offset_ns, rate, wfhw->duty, wfhw->period,
		wfhw->offset);

to stick to the common way to format a struct pwm_waveform and have
input and output separated. (This is not objectively better than pairing
input and matching output parameter, but also it's not worse and matches
what other drivers are doing.)

> +
> +	return 0;
> +}
> +
> +static int rockchip_pwm_v4_round_wf_fromhw(struct pwm_chip *chip,
> +					   struct pwm_device *pwm,
> +					   const void *_wfhw,
> +					   struct pwm_waveform *wf)
> +{
> +	struct rockchip_pwm_v4 *pc =3D to_rockchip_pwm_v4(chip);
> +	const struct rockchip_pwm_v4_wf *wfhw =3D _wfhw;
> +	unsigned long rate;
> +
> +	rate =3D clk_get_rate(pc->pwmf->core);
> +
> +	if (rockchip_pwm_v4_is_enabled(wfhw->enable)) {
> +		if (!rate)
> +			return -EINVAL;

Can rate be 0? Either consider it fixed, or store rate in wfhw.

> +
> +		wf->period_length_ns =3D (u64)wfhw->period * NSEC_PER_SEC / rate;
> +		wf->duty_length_ns =3D (u64)wfhw->duty * NSEC_PER_SEC / rate;
> +		wf->duty_offset_ns =3D (u64)wfhw->offset * NSEC_PER_SEC / rate;

You need to round up here.

> +	} else {
> +		wf->period_length_ns =3D 0;
> +		wf->duty_length_ns =3D 0;
> +		wf->duty_offset_ns =3D 0;
> +	}
> +
> +	dev_dbg(&chip->dev,
> +		"fromhw: duty %u -> %llu, period %u -> %llu, offset %u -> %llu, rate %=
lu\n",
> +		wfhw->duty, wf->duty_length_ns, wfhw->period,
> +		wf->period_length_ns, wfhw->offset, wf->duty_offset_ns, rate);
> +
> +	return 0;
> +}
> +
> +static int rockchip_pwm_v4_read_wf(struct pwm_chip *chip, struct pwm_dev=
ice *pwm,
> +				   void *_wfhw)
> +{
> +	struct rockchip_pwm_v4 *pc =3D to_rockchip_pwm_v4(chip);
> +	struct rockchip_pwm_v4_wf *wfhw =3D _wfhw;
> +	int ret =3D 0;
> +
> +
> +	ret =3D mfpwm_acquire(pc->pwmf);
> +	if (ret)
> +		return ret;
> +
> +	wfhw->period =3D mfpwm_reg_read(pc->pwmf->base, PWMV4_REG_PERIOD);
> +	wfhw->duty =3D mfpwm_reg_read(pc->pwmf->base, PWMV4_REG_DUTY);
> +	wfhw->offset =3D mfpwm_reg_read(pc->pwmf->base, PWMV4_REG_OFFSET);
> +	wfhw->enable =3D mfpwm_reg_read(pc->pwmf->base, PWMV4_REG_ENABLE) & PWM=
V4_EN_BOTH_MASK;

Can it happen that only a part of the bits in PWMV4_EN_BOTH_MASK are
set? rockchip_pwm_v4_is_enabled() then returns true.

> +
> +	mfpwm_release(pc->pwmf);
> +
> +	return 0;
> +}
> +
> +static int rockchip_pwm_v4_write_wf(struct pwm_chip *chip, struct pwm_de=
vice *pwm,
> +				    const void *_wfhw)
> +{
> +	struct rockchip_pwm_v4 *pc =3D to_rockchip_pwm_v4(chip);
> +	const struct rockchip_pwm_v4_wf *wfhw =3D _wfhw;
> +	bool was_enabled =3D false;
> +	int ret =3D 0;
> +
> +	ret =3D mfpwm_acquire(pc->pwmf);
> +	if (ret)
> +		return ret;
> +
> +	was_enabled =3D rockchip_pwm_v4_is_enabled(mfpwm_reg_read(pc->pwmf->bas=
e,
> +								PWMV4_REG_ENABLE));
> +
> +	/*
> +	 * "But Nicolas", you ask with valid concerns, "why would you enable the
> +	 * PWM before setting all the parameter registers?"
> +	 *
> +	 * Excellent question, Mr. Reader M. Strawman! The RK3576 TRM Part 1
> +	 * Section 34.6.3 specifies that this is the intended order of writes.
> +	 * Doing the PWM_EN and PWM_CLK_EN writes after the params but before
> +	 * the CTRL_UPDATE_EN, or even after the CTRL_UPDATE_EN, results in
> +	 * erratic behaviour where repeated turning on and off of the PWM may
> +	 * not turn it off under all circumstances. This is also why we don't
> +	 * use relaxed writes; it's not worth the footgun.
> +	 */
> +	mfpwm_reg_write(pc->pwmf->base, PWMV4_REG_ENABLE,
> +			FIELD_PREP_WM16(PWMV4_EN_BOTH_MASK, wfhw->enable));
> +
> +	mfpwm_reg_write(pc->pwmf->base, PWMV4_REG_PERIOD, wfhw->period);
> +	mfpwm_reg_write(pc->pwmf->base, PWMV4_REG_DUTY, wfhw->duty);
> +	mfpwm_reg_write(pc->pwmf->base, PWMV4_REG_OFFSET, wfhw->offset);
> +
> +	mfpwm_reg_write(pc->pwmf->base, PWMV4_REG_CTRL, PWMV4_CTRL_CONT_FLAGS);
> +
> +	/* Commit new configuration to hardware output. */
> +	mfpwm_reg_write(pc->pwmf->base, PWMV4_REG_ENABLE,
> +			PWMV4_CTRL_UPDATE_EN);
> +
> +	if (rockchip_pwm_v4_is_enabled(wfhw->enable)) {
> +		if (!was_enabled) {
> +			dev_dbg(&chip->dev, "Enabling PWM output\n");
> +			ret =3D clk_enable(pc->pwmf->core);
> +			if (ret)
> +				goto err_mfpwm_release;
> +			ret =3D clk_rate_exclusive_get(pc->pwmf->core);
> +			if (ret) {
> +				clk_disable(pc->pwmf->core);
> +				goto err_mfpwm_release;
> +			}
> +
> +			/*
> +			 * Output should be on now, acquire device to guarantee
> +			 * exclusion with other device functions while it's on.
> +			 */
> +			ret =3D mfpwm_acquire(pc->pwmf);
> +			if (ret)
> +				goto err_mfpwm_release;

Missing clk_disable() + clk_rate_exclusive_put() in the error path?
(Though that would violate that PWMV4_REG_ENABLE and clk state are in
sync.)

> +		}
> +	} else if (was_enabled) {
> +		dev_dbg(&chip->dev, "Disabling PWM output\n");
> +		clk_rate_exclusive_put(pc->pwmf->core);
> +		clk_disable(pc->pwmf->core);
> +		/* Output is off now, extra release to balance extra acquire */
> +		mfpwm_release(pc->pwmf);
> +	}
> +
> +err_mfpwm_release:
> +	mfpwm_release(pc->pwmf);
> +
> +	return ret;
> +}
> +
> +static const struct pwm_ops rockchip_pwm_v4_ops =3D {
> +	.sizeof_wfhw =3D sizeof(struct rockchip_pwm_v4_wf),
> +	.round_waveform_tohw =3D rockchip_pwm_v4_round_wf_tohw,
> +	.round_waveform_fromhw =3D rockchip_pwm_v4_round_wf_fromhw,
> +	.read_waveform =3D rockchip_pwm_v4_read_wf,
> +	.write_waveform =3D rockchip_pwm_v4_write_wf,
> +};
> +
> +static bool rockchip_pwm_v4_on_and_continuous(struct rockchip_pwm_v4 *pc)
> +{
> +	bool en;
> +	u32 val;
> +
> +	en =3D rockchip_pwm_v4_is_enabled(mfpwm_reg_read(pc->pwmf->base,
> +						       PWMV4_REG_ENABLE));
> +	val =3D mfpwm_reg_read(pc->pwmf->base, PWMV4_REG_CTRL);
> +
> +	return en && ((val & PWMV4_MODE_MASK) =3D=3D PWMV4_MODE_CONT);
> +}
> +
> +static int rockchip_pwm_v4_probe(struct platform_device *pdev)
> +{
> +	struct rockchip_mfpwm_func *pwmf =3D dev_get_platdata(&pdev->dev);
> +	struct rockchip_pwm_v4 *pc;
> +	struct pwm_chip *chip;
> +	struct device *dev =3D &pdev->dev;
> +	int ret;
> +
> +	/*
> +	 * For referencing the PWM in the DT to work, we need the parent MFD
> +	 * device's OF node. Code shamelessly adapted from `drivers/pci/of.c`'s
> +	 * pci_set_of_node(), which does this for bus reasons.
> +	 */
> +	dev->parent->of_node_reused =3D true;

The help text for of_node_reused says: "Set if the device-tree node is
shared with an ancestor device". So I wonder if it's dev->of_node_reused
that should be set?

> +	device_set_node(dev,
> +			of_fwnode_handle(no_free_ptr(dev->parent->of_node)));

Huh, so you're setting dev->parent->of_node to NULL. Is that really what
should happen here?

> +	chip =3D devm_pwmchip_alloc(dev, 1, sizeof(*pc));
> +	if (IS_ERR(chip))
> +		return PTR_ERR(chip);
> +
> +	pc =3D to_rockchip_pwm_v4(chip);
> +	pc->pwmf =3D pwmf;
> +
> +	ret =3D mfpwm_acquire(pwmf);
> +	if (ret =3D=3D -EBUSY)
> +		dev_warn(dev, "PWM hardware already in use, can't check initial state\=
n");

I think it's sensible to let .probe() fail here.

> +	else if (ret < 0)
> +		return dev_err_probe(dev, ret, "Couldn't acquire mfpwm in probe\n");
> +
> +	if (!rockchip_pwm_v4_on_and_continuous(pc))
> +		mfpwm_release(pwmf);
> +	else {
> +		dev_dbg(dev, "PWM was already on at probe time\n");
> +		ret =3D clk_enable(pwmf->core);
> +		if (ret)
> +			return dev_err_probe(dev, ret, "Enabling pwm clock failed\n");
> +		ret =3D clk_rate_exclusive_get(pc->pwmf->core);
> +		if (ret) {
> +			clk_disable(pwmf->core);
> +			return dev_err_probe(dev, ret, "Protecting pwm clock failed\n");
> +		}
> +	}
> +
> +	platform_set_drvdata(pdev, chip);
> +
> +	chip->ops =3D &rockchip_pwm_v4_ops;
> +
> +	ret =3D devm_pwmchip_add(dev, chip);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to add PWM chip\n");

Missing mfpwm_release() if rockchip_pwm_v4_on_and_continuous() returned
true above.

> +
> +	return 0;
> +}
> +
> +static const struct platform_device_id rockchip_pwm_v4_ids[] =3D {
> +	{ .name =3D "pwm-rockchip-v4", },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(platform, rockchip_pwm_v4_ids);
> +
> +static struct platform_driver rockchip_pwm_v4_driver =3D {
> +	.probe =3D rockchip_pwm_v4_probe,
> +	.driver =3D {
> +		.name =3D "pwm-rockchip-v4",
> +	},
> +	.id_table =3D rockchip_pwm_v4_ids,
> +};
> +module_platform_driver(rockchip_pwm_v4_driver);
> +
> +MODULE_AUTHOR("Nicolas Frattaroli <nicolas.frattaroli@collabora.com>");
> +MODULE_DESCRIPTION("Rockchip PWMv4 Driver");
> +MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS("ROCKCHIP_MFPWM");
> +MODULE_ALIAS("platform:pwm-rockchip-v4");

Best regards
Uwe

--ariuc2jwdr43jb5d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmkXB0AACgkQj4D7WH0S
/k6l+wf/cwlFpqNQUBv2R9s8fhLqhyqqLDgrM+AVb0mVwrawl2432uDXhVF1FRCd
0xFpxNfEqQ4ymGYb2LHUbAb+gPr14uh7XhEI2a+gIZRhrqfIh4Y5rDnZ19ZuClxy
Rhjzsr1/nvxhQBTwipuTMyEtMslcKw2+xiJ2Bf1hGbabTWD9QtgB3huFwhfvnkDw
bgCP73F+hkiNjuYr8OGSNhUemNVqVPANJagknFEoBDIs7eA13RlmNHulcwuqR/Vh
AM8uHLIL87KkpRSCuJCPgPn8qsI5MPNP69hMAds+2dY1gd+bNNOM6KWmtw+z5j9M
6g9XXenSi2OKTjYEOpJqk6KEHDznXw==
=/URo
-----END PGP SIGNATURE-----

--ariuc2jwdr43jb5d--

