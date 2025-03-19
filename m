Return-Path: <linux-pwm+bounces-5249-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F410BA693DC
	for <lists+linux-pwm@lfdr.de>; Wed, 19 Mar 2025 16:45:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59EFE1B65664
	for <lists+linux-pwm@lfdr.de>; Wed, 19 Mar 2025 15:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D11631D5AB9;
	Wed, 19 Mar 2025 15:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tw7aGefd"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2BD916F8F5;
	Wed, 19 Mar 2025 15:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742398666; cv=none; b=eM+7Kr4NtiX0ojuqJ+DOorIWdwXB4UCIDreJ3fOCK9szrUFoAyv0ufP6Y6Jg7hkwXObc392e3cdETuGmwTXR93H8O1qOtXMrE0AQkquECpOo+AXWf+5N85L4+lX8mCyfn5zMZ0inwPtXfyTM7oObZDwWqrxD8vXvQOtVXdHVfT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742398666; c=relaxed/simple;
	bh=iSccAdrbMdSYTVoJGCyl+oR6D67tBx4631b4F9IOrl8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YvGm7m5f0KuQO5DQlhKMMExJdCOt/OzuhqB4vhSJHMbhiSxsNZJGqmdJ9qhJImCdHve0mRKnBMAsdRlNOXuU68NN+c1WzyQyqBksysSz4NaspK8IDWJEEoV8PxDR/2iO/OGeH2TqimPHbC12WzGlQZwpJBJlUmbEXwSY6JMYlVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tw7aGefd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5992C4CEE4;
	Wed, 19 Mar 2025 15:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742398666;
	bh=iSccAdrbMdSYTVoJGCyl+oR6D67tBx4631b4F9IOrl8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tw7aGefd99U0Zye6b11gwjcvrU98QnWwsPTb1qdriFt8GaGN6oIlK++TRBAvdmygL
	 RDPmQZwYkOQsyvTx9pQfk1Kf0EqAQM6/CcN6DJBJVXSFqVxdqkLJeTKLSX8HROEGdG
	 20H11yXrYbQ7VK/rsNCEzoptvBdBTb0yBXVmozjie0NmunmaDKkFPQ2qp71m8+RDsz
	 j4PofWlNvyJexTTNzf9Cb/nqEPFMfHDWF101lZ32O0HoXxLP3bbKv+B2U2D2KAY8n+
	 J9e48F1GXFEvZMvpRMqAL7pn+rOQTpmPceIxSUCLs4dNHf3tnbeik+5i6vMS5aNPdH
	 dFlEdu6PPp7rA==
Date: Wed, 19 Mar 2025 16:37:43 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Dimitri Fedrau <dima.fedrau@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 2/2] pwm: add support for NXPs high-side switch
 MC33XS2410
Message-ID: <lzmsvwzidng7f6ybbfkusauohjya2rlyqrpprjc63y6pczo774@hklfplsgb3un>
References: <20250110073755.29541-1-dima.fedrau@gmail.com>
 <20250110073755.29541-3-dima.fedrau@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rvlbwstdatw47xlj"
Content-Disposition: inline
In-Reply-To: <20250110073755.29541-3-dima.fedrau@gmail.com>


--rvlbwstdatw47xlj
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v8 2/2] pwm: add support for NXPs high-side switch
 MC33XS2410
MIME-Version: 1.0

Hello Dimitri,

On Fri, Jan 10, 2025 at 08:37:55AM +0100, Dimitri Fedrau wrote:
> The MC33XS2410 is a four channel high-side switch. Featuring advanced
> monitoring and control function, the device is operational from 3.0 V to
> 60 V. The device is controlled by SPI port for configuration.
>=20
> Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
> ---
>  drivers/pwm/Kconfig          |  12 ++
>  drivers/pwm/Makefile         |   1 +
>  drivers/pwm/pwm-mc33xs2410.c | 378 +++++++++++++++++++++++++++++++++++
>  3 files changed, 391 insertions(+)
>  create mode 100644 drivers/pwm/pwm-mc33xs2410.c
>=20
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 0915c1e7df16..f513513f9b2f 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -411,6 +411,18 @@ config PWM_LPSS_PLATFORM
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm-lpss-platform.
> =20
> +config PWM_MC33XS2410
> +	tristate "MC33XS2410 PWM support"
> +	depends on OF
> +	depends on SPI
> +	help
> +	  NXP MC33XS2410 high-side switch driver. The MC33XS2410 is a four
> +	  channel high-side switch. The device is operational from 3.0 V
> +	  to 60 V. The device is controlled by SPI port for configuration.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called pwm-mc33xs2410.
> +
>  config PWM_MESON
>  	tristate "Amlogic Meson PWM driver"
>  	depends on ARCH_MESON || COMPILE_TEST
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index 9081e0c0e9e0..c75deeeace40 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -36,6 +36,7 @@ obj-$(CONFIG_PWM_LPC32XX)	+=3D pwm-lpc32xx.o
>  obj-$(CONFIG_PWM_LPSS)		+=3D pwm-lpss.o
>  obj-$(CONFIG_PWM_LPSS_PCI)	+=3D pwm-lpss-pci.o
>  obj-$(CONFIG_PWM_LPSS_PLATFORM)	+=3D pwm-lpss-platform.o
> +obj-$(CONFIG_PWM_MC33XS2410)	+=3D pwm-mc33xs2410.o
>  obj-$(CONFIG_PWM_MESON)		+=3D pwm-meson.o
>  obj-$(CONFIG_PWM_MEDIATEK)	+=3D pwm-mediatek.o
>  obj-$(CONFIG_PWM_MICROCHIP_CORE)	+=3D pwm-microchip-core.o
> diff --git a/drivers/pwm/pwm-mc33xs2410.c b/drivers/pwm/pwm-mc33xs2410.c
> new file mode 100644
> index 000000000000..432693b4f8eb
> --- /dev/null
> +++ b/drivers/pwm/pwm-mc33xs2410.c
> @@ -0,0 +1,378 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2024 Liebherr-Electronics and Drives GmbH
> + *
> + * Reference Manual : https://www.nxp.com/docs/en/data-sheet/MC33XS2410.=
pdf
> + *
> + * Limitations:
> + * - Supports frequencies between 0.5Hz and 2048Hz with following steps:
> + *   - 0.5 Hz steps from 0.5 Hz to 32 Hz
> + *   - 2 Hz steps from 2 Hz to 128 Hz
> + *   - 8 Hz steps from 8 Hz to 512 Hz
> + *   - 32 Hz steps from 32 Hz to 2048 Hz
> + * - Cannot generate a 0 % duty cycle.
> + * - Always produces low output if disabled.
> + * - Configuration isn't atomic. When changing polarity, duty cycle or p=
eriod
> + *   the data is taken immediately, counters not being affected, resulti=
ng in a
> + *   behavior of the output pin that is neither the old nor the new stat=
e,
> + *   rather something in between.
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/math64.h>
> +#include <linux/minmax.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/pwm.h>
> +
> +#include <linux/spi/spi.h>
> +
> +#define MC33XS2410_GLB_CTRL			0x00
> +#define MC33XS2410_GLB_CTRL_MODE		GENMASK(7, 6)
> +#define MC33XS2410_GLB_CTRL_MODE_NORMAL		FIELD_PREP(MC33XS2410_GLB_CTRL_=
MODE, 1)
> +
> +#define MC33XS2410_PWM_CTRL1			0x05
> +/* x in { 1 ... 4 } */

s/x/chan/

> +#define MC33XS2410_PWM_CTRL1_POL_INV(chan)	BIT((chan) + 1)
> +
> +#define MC33XS2410_PWM_CTRL3			0x07
> +/* x in { 1 ... 4 } */
> +#define MC33XS2410_PWM_CTRL3_EN(chan)		BIT(4 + (chan) - 1)
> +
> +/* x in { 1 ... 4 } */
> +#define MC33XS2410_PWM_FREQ(chan)		(0x08 + (chan) - 1)
> +#define MC33XS2410_PWM_FREQ_STEP		GENMASK(7, 6)
> +#define MC33XS2410_PWM_FREQ_COUNT		GENMASK(5, 0)
> +
> +/* x in { 1 ... 4 } */
> +#define MC33XS2410_PWM_DC(chan)			(0x0c + (chan) - 1)
> +
> +#define MC33XS2410_WDT				0x14
> +
> +#define MC33XS2410_PWM_MIN_PERIOD		488282
> +/* x in { 0 ... 3 } */

s/x/step/

> +#define MC33XS2410_PWM_MAX_PERIOD(step)		(2000000000 >> (2 * (step)))
> +
> +#define MC33XS2410_FRAME_IN_ADDR		GENMASK(15, 8)
> +#define MC33XS2410_FRAME_IN_DATA		GENMASK(7, 0)
> +#define MC33XS2410_FRAME_IN_ADDR_WR		BIT(7)
> +#define MC33XS2410_FRAME_IN_DATA_RD		BIT(7)
> +#define MC33XS2410_FRAME_OUT_DATA		GENMASK(13, 0)
> +
> +#define MC33XS2410_MAX_TRANSFERS		5
> +
> +static int mc33xs2410_write_regs(struct spi_device *spi, u8 *reg, u8 *va=
l,
> +				 unsigned int len)
> +{
> +	u16 tx[MC33XS2410_MAX_TRANSFERS];
> +	int i;
> +
> +	if (len > MC33XS2410_MAX_TRANSFERS)
> +		return -EINVAL;
> +
> +	for (i =3D 0; i < len; i++)
> +		tx[i] =3D FIELD_PREP(MC33XS2410_FRAME_IN_DATA, val[i]) |
> +			FIELD_PREP(MC33XS2410_FRAME_IN_ADDR,
> +				   MC33XS2410_FRAME_IN_ADDR_WR | reg[i]);
> +
> +	return spi_write(spi, tx, len * 2);
> +}
> +
> +static int mc33xs2410_read_regs(struct spi_device *spi, u8 *reg, u8 flag,
> +				u16 *val, unsigned int len)
> +{
> +	u16 tx[MC33XS2410_MAX_TRANSFERS];
> +	u16 rx[MC33XS2410_MAX_TRANSFERS];
> +	struct spi_transfer t =3D {
> +		.tx_buf =3D tx,
> +		.rx_buf =3D rx,
> +	};
> +	int i, ret;
> +
> +	len++;
> +	if (len > MC33XS2410_MAX_TRANSFERS)
> +		return -EINVAL;
> +
> +	t.len =3D len * 2;
> +	for (i =3D 0; i < len - 1; i++)
> +		tx[i] =3D FIELD_PREP(MC33XS2410_FRAME_IN_DATA, flag) |
> +			FIELD_PREP(MC33XS2410_FRAME_IN_ADDR, reg[i]);
> +
> +	ret =3D spi_sync_transfer(spi, &t, 1);
> +	if (ret < 0)
> +		return ret;
> +
> +	for (i =3D 1; i < len; i++)
> +		val[i - 1] =3D FIELD_GET(MC33XS2410_FRAME_OUT_DATA, rx[i]);
> +
> +	return 0;
> +}
> +
> +static int mc33xs2410_write_reg(struct spi_device *spi, u8 reg, u8 val)
> +{
> +	return mc33xs2410_write_regs(spi, &reg, &val, 1);
> +}
> +
> +static int mc33xs2410_read_reg(struct spi_device *spi, u8 reg, u16 *val,=
 u8 flag)
> +{
> +	return mc33xs2410_read_regs(spi, &reg, flag, val, 1);
> +}
> +
> +static int mc33xs2410_read_reg_ctrl(struct spi_device *spi, u8 reg, u16 =
*val)
> +{
> +	return mc33xs2410_read_reg(spi, reg, val, MC33XS2410_FRAME_IN_DATA_RD);
> +}
> +
> +static int mc33xs2410_modify_reg(struct spi_device *spi, u8 reg, u8 mask=
, u8 val)
> +{
> +	u16 tmp;
> +	int ret;
> +
> +	ret =3D mc33xs2410_read_reg_ctrl(spi, reg, &tmp);
> +	if (ret < 0)
> +		return ret;
> +
> +	tmp &=3D ~mask;
> +	tmp |=3D val & mask;
> +
> +	return mc33xs2410_write_reg(spi, reg, tmp);
> +}
> +
> +static u8 mc33xs2410_pwm_get_freq(u64 period)
> +{
> +	u8 step, count;
> +
> +	/*
> +	 * Check which step is appropriate for the given period, starting with
> +	 * the highest frequency(lowest period). Higher frequencies are
> +	 * represented with better resolution by the device. Therefore favor
> +	 * frequency range with the better resolution to minimize error
> +	 * introduced by the frequency steps.

This is hard to understand as the argument is presented in several
steps:
	algo starts with high step values (that's not in the comment,
		you have to take that from the switch statement)
	high step represents high freq =3D low period
	high freq yield better resolution
	better resolution is what is favoured.

After investing some time to reunderstand the rational here
I suggest:

	/*
	 * Check which step [0 .. 3] is appropriate for the given
	 * period. The period ranges for the different step values
	 * overlap. Prefer big step values as these allow more
	 * finegrained duty cycle selection.
	 */

> +	 */
> +
> +	switch (period) {
> +	case MC33XS2410_PWM_MIN_PERIOD ... MC33XS2410_PWM_MAX_PERIOD(3):
> +		step =3D 3;
> +		break;
> +	case MC33XS2410_PWM_MAX_PERIOD(3) + 1 ... MC33XS2410_PWM_MAX_PERIOD(2):
> +		step =3D 2;
> +		break;
> +	case MC33XS2410_PWM_MAX_PERIOD(2) + 1 ... MC33XS2410_PWM_MAX_PERIOD(1):
> +		step =3D 1;
> +		break;
> +	case MC33XS2410_PWM_MAX_PERIOD(1) + 1 ... MC33XS2410_PWM_MAX_PERIOD(0):
> +		step =3D 0;
> +		break;
> +	}
> +
> +	/*
> +	 * Round up here because a higher count results in a higher frequency
> +	 * and so a smaller period.
> +	 */
> +	count =3D DIV_ROUND_UP((u32)MC33XS2410_PWM_MAX_PERIOD(step), (u32)perio=
d);
> +	return FIELD_PREP(MC33XS2410_PWM_FREQ_STEP, step) |
> +	       FIELD_PREP(MC33XS2410_PWM_FREQ_COUNT, count - 1);
> +}
> +
> +static u64 mc33xs2410_pwm_get_period(u8 reg)
> +{
> +	u32 freq, code, doubled_steps;
> +
> +	/*
> +	 * steps:
> +	 *   - 0 =3D 0.5Hz
> +	 *   - 1 =3D 2Hz
> +	 *   - 2 =3D 8Hz
> +	 *   - 3 =3D 32Hz
> +	 * frequency =3D (code + 1) x steps.
> +	 *
> +	 * To avoid losing precision in case steps value is zero, scale the
> +	 * steps value for now by two and keep it in mind when calculating the
> +	 * period that the frequency had been doubled.
> +	 */
> +	doubled_steps =3D 1 << (FIELD_GET(MC33XS2410_PWM_FREQ_STEP, reg) * 2);
> +	code =3D FIELD_GET(MC33XS2410_PWM_FREQ_COUNT, reg);
> +	freq =3D (code + 1) * doubled_steps;

doubled_freq?

> +	/* Convert frequency to period, considering the doubled frequency. */
> +	return DIV_ROUND_UP(2 * NSEC_PER_SEC, freq);
> +}
> +
> +static int mc33xs2410_pwm_apply(struct pwm_chip *chip, struct pwm_device=
 *pwm,
> +				const struct pwm_state *state)
> +{
> +	struct spi_device *spi =3D pwmchip_get_drvdata(chip);
> +	u8 reg[4] =3D {
> +			MC33XS2410_PWM_FREQ(pwm->hwpwm + 1),
> +			MC33XS2410_PWM_DC(pwm->hwpwm + 1),
> +			MC33XS2410_PWM_CTRL1,
> +			MC33XS2410_PWM_CTRL3
> +		    };
> +	u64 period, duty_cycle;
> +	int ret, rel_dc;
> +	u16 rd_val[2];
> +	u8 wr_val[4];
> +	u8 mask;
> +
> +	period =3D min(state->period, MC33XS2410_PWM_MAX_PERIOD(0));
> +	if (period < MC33XS2410_PWM_MIN_PERIOD)
> +		return -EINVAL;
> +
> +	ret =3D mc33xs2410_read_regs(spi, &reg[2], MC33XS2410_FRAME_IN_DATA_RD,=
 rd_val, 2);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* frequency */
> +	wr_val[0] =3D mc33xs2410_pwm_get_freq(period);
> +	/* Continue calculations with the possibly truncated period */
> +	period =3D mc33xs2410_pwm_get_period(wr_val[0]);
> +
> +	/* duty cycle */
> +	duty_cycle =3D min(period, state->duty_cycle);
> +	rel_dc =3D div64_u64(duty_cycle * 256, period) - 1;
> +	if (rel_dc < 0)
> +		wr_val[1] =3D 0;
> +	else
> +		wr_val[1] =3D rel_dc;
> +
> +	/* polarity */
> +	mask =3D MC33XS2410_PWM_CTRL1_POL_INV(pwm->hwpwm + 1);
> +	wr_val[2] =3D (state->polarity =3D=3D PWM_POLARITY_INVERSED) ?
> +		    (rd_val[0] | mask) : (rd_val[0] & ~mask);
> +
> +	/*
> +	 * As the hardware cannot generate a 0% relative duty cycle but emits a
> +	 * constant low signal when disabled, also disable in the duty_cycle =
=3D 0
> +	 * case.
> +	 */
> +	mask =3D MC33XS2410_PWM_CTRL3_EN(pwm->hwpwm + 1);
> +	wr_val[3] =3D (state->enabled && rel_dc >=3D 0) ? (rd_val[1] | mask) :
> +						      (rd_val[1] & ~mask);

This is wrong for inversed polarity I think.

> +	return mc33xs2410_write_regs(spi, reg, wr_val, 4);
> +}
> +
> [..]
> +static int mc33xs2410_probe(struct spi_device *spi)
> +{
> +	struct device *dev =3D &spi->dev;
> +	struct pwm_chip *chip;
> +	int ret;
> +
> +	chip =3D devm_pwmchip_alloc(dev, 4, 0);
> +	if (IS_ERR(chip))
> +		return PTR_ERR(chip);
> +
> +	spi->bits_per_word =3D 16;
> +	spi->mode |=3D SPI_CS_WORD;
> +	ret =3D spi_setup(spi);
> +	if (ret < 0)
> +		return ret;
> +
> +	pwmchip_set_drvdata(chip, spi);
> +	chip->ops =3D &mc33xs2410_pwm_ops;
> +	ret =3D mc33xs2410_reset(dev);

What does this reset? Does it change the output signal if the bootloader
already setup the hardware? The answer to that has to go into a comment.
(And if it interupts the output, better skip the reset part.)

> +	if (ret)
> +		return ret;

Best regards
Uwe

--rvlbwstdatw47xlj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmfa5MUACgkQj4D7WH0S
/k4kXwgAp6os1qo1UO9Vfw8zQFjDTpw+qxSb5nssObJkzAmlM2jYxcKPQ96ojEx3
74hYuFP77E5HKJ254QAR4m//0havY8YrkQX21UnSAWTIxTIxNIAnGsK/zq0qjEev
+TZBHpRoFTwcXwoKWBNfm1NhZvxHmudTTiInu06rk5QYNlPT3vcbMI9+1aLcKMn4
rVTurindRrULMF8qnIorUrblsAfWgWMMD7oukwbubqeM4fBBcAVlJEeAzIw0OC5+
n4hQ9kwIDLS16wqcJcq+J9RFfC8Z955j4S4hy1owyy26qQEiODxwl0+PRmICcVb7
QXpyJ8WVyYTf9OjOp5UzMnxZly5d/A==
=uDxk
-----END PGP SIGNATURE-----

--rvlbwstdatw47xlj--

