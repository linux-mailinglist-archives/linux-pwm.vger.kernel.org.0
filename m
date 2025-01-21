Return-Path: <linux-pwm+bounces-4692-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BFE4A17CC6
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Jan 2025 12:15:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A4071643D1
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Jan 2025 11:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C46DF1F1314;
	Tue, 21 Jan 2025 11:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ndOOpZGW"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947B31F12FB;
	Tue, 21 Jan 2025 11:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737458074; cv=none; b=WK9hJdVWPwraDD/QEM3JTQJrA5XqUdWJ60j+vB+YhfBXeKhS/9dQ2bDxgKL2QtPCOAqBe2b9nkXxh5bl7z87OmY5omFsu+HiggylFHhxZ1wNzEHbQk5YkvYdr/NrKXN820EUMR6+afSzCP5vkPNKoKYp7A5q7wByO4VGXA48rI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737458074; c=relaxed/simple;
	bh=5/YCTSHK2CJDfikWF0It1IwBABtFMXUjR9+mLjH7RtI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uNOfkmxQMPvzNazLQCB5Arn4f0uaLRmiypMCWPGQXn1UAKxWir7++VCzZ6Hc4G5DpVJ0+NAorhrqNQRU/zN8ONQgMZvKosHDMCLCYHU3pQYVGm0Fx4WQnLCTMmd3e0mxzMkLNwVH6kbQ2A67KEKCwL8lwmxKAAuq9b7Z7+ChoPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ndOOpZGW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51113C4CEDF;
	Tue, 21 Jan 2025 11:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737458074;
	bh=5/YCTSHK2CJDfikWF0It1IwBABtFMXUjR9+mLjH7RtI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ndOOpZGWB6nYeAhqVRCP12Zx3iC2HSgWO0u5HLz+UpW9cctjQBhL3HYR/aCKi0/c6
	 T20fV70O7taLR33PX2egNoR+qUuoHtJy1jFObFI5a/anTLlPX2laXNXHPWU8J8ZFl8
	 Cxpcdwrom+X2UcT/NKLnsA9eJzXLeQykQzN4PGTEIcOpS2k1FVT+47C5MPZk1TgkyD
	 Bfvo3CgxqGZYvuvIvelHwNWcq+Wbb7T+b/fKaCgZWhTFbfBhw9p69NPwDmuOz2JXvE
	 Z3LNRaQI2FBlrPzBt1PsMhe0LR0kDGTK0l7jZUo9wtCccUfygalG6oV4/L5IWOPmv/
	 s7o3ICT2wNNSA==
Date: Tue, 21 Jan 2025 12:14:30 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Chen Wang <unicornxw@gmail.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	unicorn_wang@outlook.com, inochiama@outlook.com, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, linux-riscv@lists.infradead.org, 
	chao.wei@sophgo.com, haijiao.liu@sophgo.com, xiaoguang.xing@sophgo.com, 
	chunzhi.lin@sophgo.com, Sean Young <sean@mess.org>
Subject: Re: [PATCH v6 2/3] pwm: sophgo: add driver for Sophgo SG2042 PWM
Message-ID: <e2we4klv7w234zyc4vnbcydieyhcte63sdwcp43vmolmlasv5f@scsiepnnw3db>
References: <cover.1733281657.git.unicorn_wang@outlook.com>
 <4a7db3ecac9ac2b00c063360334834d6656672e3.1733281657.git.unicorn_wang@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="keq26qvpnouvfvzg"
Content-Disposition: inline
In-Reply-To: <4a7db3ecac9ac2b00c063360334834d6656672e3.1733281657.git.unicorn_wang@outlook.com>


--keq26qvpnouvfvzg
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v6 2/3] pwm: sophgo: add driver for Sophgo SG2042 PWM
MIME-Version: 1.0

On Wed, Dec 04, 2024 at 11:17:18AM +0800, Chen Wang wrote:
> From: Chen Wang <unicorn_wang@outlook.com>
>=20
> Add a PWM driver for PWM controller in Sophgo SG2042 SoC.
>=20
> Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
> Signed-off-by: Sean Young <sean@mess.org>
> ---
>  drivers/pwm/Kconfig             |  10 ++
>  drivers/pwm/Makefile            |   1 +
>  drivers/pwm/pwm-sophgo-sg2042.c | 194 ++++++++++++++++++++++++++++++++
>  3 files changed, 205 insertions(+)
>  create mode 100644 drivers/pwm/pwm-sophgo-sg2042.c
>=20
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 0915c1e7df16..ec85f3895936 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -584,6 +584,16 @@ config PWM_SL28CPLD
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm-sl28cpld.
> =20
> +config PWM_SOPHGO_SG2042
> +	tristate "Sophgo SG2042 PWM support"
> +	depends on ARCH_SOPHGO || COMPILE_TEST
> +	help
> +	  PWM driver for the PWM controller on Sophgo SG2042 SoC. The PWM
> +	  controller supports outputing 4 channels of PWM waveforms.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called pwm_sophgo_sg2042.
> +
>  config PWM_SPEAR
>  	tristate "STMicroelectronics SPEAr PWM support"
>  	depends on PLAT_SPEAR || COMPILE_TEST
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index 9081e0c0e9e0..539e0def3f82 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -53,6 +53,7 @@ obj-$(CONFIG_PWM_RZ_MTU3)	+=3D pwm-rz-mtu3.o
>  obj-$(CONFIG_PWM_SAMSUNG)	+=3D pwm-samsung.o
>  obj-$(CONFIG_PWM_SIFIVE)	+=3D pwm-sifive.o
>  obj-$(CONFIG_PWM_SL28CPLD)	+=3D pwm-sl28cpld.o
> +obj-$(CONFIG_PWM_SOPHGO_SG2042)	+=3D pwm-sophgo-sg2042.o
>  obj-$(CONFIG_PWM_SPEAR)		+=3D pwm-spear.o
>  obj-$(CONFIG_PWM_SPRD)		+=3D pwm-sprd.o
>  obj-$(CONFIG_PWM_STI)		+=3D pwm-sti.o
> diff --git a/drivers/pwm/pwm-sophgo-sg2042.c b/drivers/pwm/pwm-sophgo-sg2=
042.c
> new file mode 100644
> index 000000000000..a3d12505e4aa
> --- /dev/null
> +++ b/drivers/pwm/pwm-sophgo-sg2042.c
> @@ -0,0 +1,194 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Sophgo SG2042 PWM Controller Driver
> + *
> + * Copyright (C) 2024 Sophgo Technology Inc.
> + * Copyright (C) 2024 Chen Wang <unicorn_wang@outlook.com>
> + *
> + * Limitations:
> + * - After reset, the output of the PWM channel is always high.
> + *   The value of HLPERIOD/PERIOD is 0.
> + * - When HLPERIOD or PERIOD is reconfigured, PWM will start to
> + *   output waveforms with the new configuration after completing
> + *   the running period.
> + * - When PERIOD and HLPERIOD is set to 0, the PWM wave output will
> + *   be stopped and the output is pulled to high.

Maybe I already asked: If there is a public manual for this chip, please
add a link to it here.

> + */
> +
> +#include <linux/clk.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/pwm.h>
> +#include <linux/reset.h>
> +
> +#include <asm/div64.h>

The canonical include for that is <linux/math64.h>. This is also the
header that defines mul_u64_u64_div_u64(). Your driver seems to compile
only because clk.h includes math64.h via <linux/notifier.h> ->
<linux/srcu.h> -> <linux/workqueue.h> -> <linux/timer.h> ->
<linux/ktime.h> -> <linux/jiffies.h> -> <linux/math64.h>.

> +/*
> + * Offset RegisterName
> + * 0x0000 HLPERIOD0
> + * 0x0004 PERIOD0
> + * 0x0008 HLPERIOD1
> + * 0x000C PERIOD1
> + * 0x0010 HLPERIOD2
> + * 0x0014 PERIOD2
> + * 0x0018 HLPERIOD3
> + * 0x001C PERIOD3
> + * Four groups and every group is composed of HLPERIOD & PERIOD
> + */
> +#define SG2042_HLPERIOD(chan) ((chan) * 8 + 0)
> +#define SG2042_PERIOD(chan) ((chan) * 8 + 4)

s/SG2042_/SG2042_PWM_/ to match the function prefix and driver name?

> +
> +#define SG2042_PWM_CHANNELNUM	4
> +
> +/**
> + * struct sg2042_pwm_ddata - private driver data
> + * @base:		base address of mapped PWM registers
> + * @clk_rate_hz:	rate of base clock in HZ
> + */
> +struct sg2042_pwm_ddata {
> +	void __iomem *base;
> +	unsigned long clk_rate_hz;
> +};
> +
> +static void pwm_sg2042_config(void __iomem *base, unsigned int chan, u32=
 period, u32 hlperiod)

Maybe pass ddata here instead of base and add

	void __iomem *base =3D ddata->base;

to the function body. Then the calls simplify from

	pwm_sg2042_config(ddata->base, pwm->hwpwm, period, hlperiod);

to

	pwm_sg2042_config(ddata, pwm->hwpwm, period, hlperiod);

=2E

> +{
> +	writel(period, base + SG2042_PERIOD(chan));
> +	writel(hlperiod, base + SG2042_HLPERIOD(chan));
> +}
> +
> +static int pwm_sg2042_apply(struct pwm_chip *chip, struct pwm_device *pw=
m,
> +			    const struct pwm_state *state)
> +{
> +	struct sg2042_pwm_ddata *ddata =3D pwmchip_get_drvdata(chip);
> +	u32 hlperiod;
> +	u32 period;

state->period is measured in ns, the local variable period however
holds a value measured in clock ticks. To make this still clearer than
it already is, I suggest to rename the variable to period_ticks. Ditto
for hlperiod.

> +	if (state->polarity =3D=3D PWM_POLARITY_INVERSED)
> +		return -EINVAL;
> +
> +	if (!state->enabled) {
> +		pwm_sg2042_config(ddata->base, pwm->hwpwm, 0, 0);
> +		return 0;
> +	}
> +
> +	/*
> +	 * Period of High level (duty_cycle) =3D HLPERIOD x Period_clk
> +	 * Period of One Cycle (period) =3D PERIOD x Period_clk

s/Period/Duration/ ? What is Period_clk?

> +	 */
> +	period =3D min(mul_u64_u64_div_u64(ddata->clk_rate_hz, state->period, N=
SEC_PER_SEC), U32_MAX);
> +	hlperiod =3D min(mul_u64_u64_div_u64(ddata->clk_rate_hz, state->duty_cy=
cle, NSEC_PER_SEC), U32_MAX);
> +
> +	if (hlperiod > period) {
> +		dev_err(pwmchip_parent(chip), "period < hlperiod, failed to apply curr=
ent setting\n");
> +		return -EINVAL;

No need to check for that, .apply() is only called with
state->duty_cycle <=3D state->period.

> +	}
> +
> +	dev_dbg(pwmchip_parent(chip), "chan[%u]: period=3D%u, hlperiod=3D%u\n",
> +		pwm->hwpwm, period, hlperiod);
> +
> +	pwm_sg2042_config(ddata->base, pwm->hwpwm, period, hlperiod);
> +
> +	return 0;
> +}
> +
> +static int pwm_sg2042_get_state(struct pwm_chip *chip, struct pwm_device=
 *pwm,
> +				struct pwm_state *state)
> +{
> +	struct sg2042_pwm_ddata *ddata =3D pwmchip_get_drvdata(chip);
> +	unsigned int chan =3D pwm->hwpwm;
> +	u32 hlperiod;
> +	u32 period;
> +
> +	period =3D readl(ddata->base + SG2042_PERIOD(chan));
> +	hlperiod =3D readl(ddata->base + SG2042_HLPERIOD(chan));
> +
> +	if (!period && !hlperiod)
> +		state->enabled =3D false;
> +	else
> +		state->enabled =3D true;

What happens if hlperiod > period? Isn't period=3D=3D0 enough for
state->enabled =3D false? Also if period=3D=3D0 there is no use in determin=
ing
state->period and state->duty_cycle.

So I would expect here:

	period_ticks =3D readl(ddata->base + SG2042_PERIOD(chan));
	hlperiod_ticks =3D readl(ddata->base + SG2042_HLPERIOD(chan));

	if (!period_ticks) {
		state->enabled =3D false;
		return 0;
	}

	if (hlperiod_ticks > period_ticks)
		hlperiod_ticks =3D period_ticks;

	state->enabled =3D true;
	state->period =3D DIV_ROUND_UP_ULL((u64)period_ticks * NSEC_PER_SEC, ddata=
->clk_rate_hz);
	state->duty_cycle =3D DIV_ROUND_UP_ULL((u64)hlperiod_ticks * NSEC_PER_SEC,=
 ddata->clk_rate_hz);
	state->polarity =3D PWM_POLARITY_NORMAL;

> +	state->period =3D DIV_ROUND_UP_ULL((u64)period * NSEC_PER_SEC, ddata->c=
lk_rate_hz);
> +	state->duty_cycle =3D DIV_ROUND_UP_ULL((u64)hlperiod * NSEC_PER_SEC, dd=
ata->clk_rate_hz);
> +
> +	state->polarity =3D PWM_POLARITY_NORMAL;
> +
> +	return 0;
> +}
> +
> +static const struct pwm_ops pwm_sg2042_ops =3D {
> +	.apply =3D pwm_sg2042_apply,
> +	.get_state =3D pwm_sg2042_get_state,
> +};
> +
> +static const struct of_device_id sg2042_pwm_ids[] =3D {
> +	{ .compatible =3D "sophgo,sg2042-pwm" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, sg2042_pwm_ids);
> +
> +static int pwm_sg2042_probe(struct platform_device *pdev)
> +{
> +	struct device *dev =3D &pdev->dev;
> +	struct sg2042_pwm_ddata *ddata;
> +	struct reset_control *rst;
> +	struct pwm_chip *chip;
> +	struct clk *clk;
> +	int ret;
> +
> +	chip =3D devm_pwmchip_alloc(dev, SG2042_PWM_CHANNELNUM, sizeof(*ddata));
> +	if (IS_ERR(chip))
> +		return PTR_ERR(chip);
> +	ddata =3D pwmchip_get_drvdata(chip);
> +
> +	ddata->base =3D devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(ddata->base))
> +		return PTR_ERR(ddata->base);
> +
> +	clk =3D devm_clk_get_enabled(dev, "apb");
> +	if (IS_ERR(clk))
> +		return dev_err_probe(dev, PTR_ERR(clk), "failed to get base clk\n");

I like error messages to start consistently with a capital letter.

> +	ret =3D devm_clk_rate_exclusive_get(dev, clk);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to get exclusive rate\n");
> +
> +	ddata->clk_rate_hz =3D clk_get_rate(clk);
> +	if (!ddata->clk_rate_hz || ddata->clk_rate_hz > NSEC_PER_SEC)

Please add a comment about why you check for > NSEC_PER_SEC.

> +		return dev_err_probe(dev, -EINVAL,
> +				     "Invalid clock rate: %lu\n", ddata->clk_rate_hz);
> +
> +	rst =3D devm_reset_control_get_optional_shared(dev, NULL);
> +	if (IS_ERR(rst))
> +		return dev_err_probe(dev, PTR_ERR(rst), "failed to get reset\n");
> +
> +	/* Deassert reset */
> +	ret =3D reset_control_deassert(rst);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to deassert\n");

There is devm_reset_control_get_optional_shared_deasserted() that does
the two calls devm_reset_control_get_optional_shared() and
reset_control_deassert() together and also cares for reasserting the
reset at remove time.

> +	chip->ops =3D &pwm_sg2042_ops;
> +	chip->atomic =3D true;
> +
> +	ret =3D devm_pwmchip_add(dev, chip);
> +	if (ret < 0) {
> +		reset_control_assert(rst);
> +		return dev_err_probe(dev, ret, "failed to register PWM chip\n");
> +	}
> +
> +	return 0;
> +}

Best regards
Uwe

--keq26qvpnouvfvzg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmePgZQACgkQj4D7WH0S
/k5eqAgAr3xkmwsD66/DdJwayu+mz1FRtzDgSgIF1iJ5aUygTLg7fPBpk3lnHuDu
7Tg0uYKl8a3SO+8vHeTYXbqw6zZoxmBTmOM7O3FG+AHifrXcb6KCV02VJnh646mC
2yQ3zZ9RKSFpiQMTFp9fHJnk1XyjkQpnBAnJJY9pec4yM7W4LhoB+iGvKby1HriW
lIqs4l2Te7G0pO0iXOuzagMPKqqubLQ/JLPgnaTqC80T430gtjBOyggWve7oFrYu
uEQxZC2x5CvXMqNcwV5u5CzG/qu66xfiXiG1Kktt2xD05cQy7OUDoT/sM5FeCZdz
b2VoieJWLWhscZSSdS94e9ITqs/Kuw==
=KCo3
-----END PGP SIGNATURE-----

--keq26qvpnouvfvzg--

