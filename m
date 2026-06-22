Return-Path: <linux-pwm+bounces-9345-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DiDaGgdjOWqorQcAu9opvQ
	(envelope-from <linux-pwm+bounces-9345-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 22 Jun 2026 18:29:59 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DEE186B1247
	for <lists+linux-pwm@lfdr.de>; Mon, 22 Jun 2026 18:29:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Z+cSt5zd;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9345-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9345-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A5AA8301CC7D
	for <lists+linux-pwm@lfdr.de>; Mon, 22 Jun 2026 16:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 310303264F7;
	Mon, 22 Jun 2026 16:29:42 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20002FFF8B;
	Mon, 22 Jun 2026 16:29:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782145782; cv=none; b=lBU83E4fQJ9HbX66wF+zdz5b8Oe7X2/98F0wBwf07FaXD6e7e01u8ROLZ9WgaIc5qnHqTMDDddgUV271o5lIOzQ3zv2m2/J04i1qIArxg8+CxuuqxyydzLrzQoabAUCYjAtLfIyLqZnHWclASX5enU4SL2zedtMicCuf3/R8YQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782145782; c=relaxed/simple;
	bh=osmF6oxzcB2rHRidxMuZ/vdC2DVmCpVYN5vr4IRuHlI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NUY0aWNip1p6n+SSaJDVnLilQ5yILIbja0AlFidb1co+MVD/MTV+NIpr8Pbw/59IAuE3kt/Z9ncqcYdxNEG4RyUcqKafmlRmipO3Fr3gAfS1l7JzBYHlAuc5SmJasw7mMtZtH2p1VPw0ToR1LF31pq3tSE67/kV4N9T+TZeBf9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z+cSt5zd; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 371F01F000E9;
	Mon, 22 Jun 2026 16:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782145780;
	bh=xB+xdkB0MbbV0hANSD1KBPCKOPjowcAhl3O/CZ4a47o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Z+cSt5zd7k0aBcBY9UFo0OOk/TsdA2vygY/dBIKJazVr22qbISFJkxjia6yokF8MF
	 8rvRSuUbA2PpP9u32cN/jFgKjfyO//WGAN277ZC1SpI2pZOXuKz1/joanFoXKVX7vI
	 qg38AaxkWlEVvhd7x3ii/VpcCZ3C4YPlfn66LCs++DTuUF4liPDFTjRfD1/L9MVgVE
	 AxXzXt/WFBY2CNhGn1SkPWiUUQYMXRFbMCiFvYfpMOQQrWN/XafXQbPT4qUML+iNu9
	 n30AHtPSHGr/N75wEzbABDEkeFvARr7y9VhY0CNCIZ0zuzuUAvwPaOuLUP0oEybWxU
	 J7zaYW67ZqpcA==
Date: Mon, 22 Jun 2026 18:29:38 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Petar Stepanovic <pstepanovic@axiado.com>
Cc: Akhila Kavi <akavi@axiado.com>, 
	Prasad Bolisetty <pbolisetty@axiado.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Harshit Shah <hshah@axiado.com>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] pwm: add Axiado AX3000 PWM driver
Message-ID: <ajlf4t_tuuX-Eplc@monoceros>
References: <20260618-axiado-ax3000-pwm-v1-0-c9797a909414@axiado.com>
 <20260618-axiado-ax3000-pwm-v1-2-c9797a909414@axiado.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7u3zpdkvzxvxdj6a"
Content-Disposition: inline
In-Reply-To: <20260618-axiado-ax3000-pwm-v1-2-c9797a909414@axiado.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.76 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-9345-lists,linux-pwm=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:pstepanovic@axiado.com,m:akavi@axiado.com,m:pbolisetty@axiado.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:hshah@axiado.com,m:linux-pwm@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[ukleinek@kernel.org,linux-pwm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ukleinek@kernel.org,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,axiado.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,monoceros:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DEE186B1247


--7u3zpdkvzxvxdj6a
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 2/2] pwm: add Axiado AX3000 PWM driver
MIME-Version: 1.0

Hello Petar,

Just a very high-level review:

On Thu, Jun 18, 2026 at 05:26:57AM -0700, Petar Stepanovic wrote:
> The Axiado AX3000 and AX3005 SoCs include PWM controllers that can be
> used to generate configurable PWM output signals.
>=20
> Add a PWM driver with support for configuring period, duty cycle, and
> enable state through the Linux PWM framework.
>=20
> Signed-off-by: Petar Stepanovic <pstepanovic@axiado.com>
> ---
>  MAINTAINERS              |   1 +
>  drivers/pwm/Kconfig      |  11 +++
>  drivers/pwm/Makefile     |   1 +
>  drivers/pwm/pwm-axiado.c | 193 +++++++++++++++++++++++++++++++++++++++++=
++++++
>  4 files changed, 206 insertions(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 394c4a3527e8..db93fc235c32 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4319,6 +4319,7 @@ M:	Prasad Bolisetty <pbolisetty@axiado.com>
>  L:	linux-pwm@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/pwm/axiado,ax3000-pwm.yaml
> +F:	drivers/pwm/pwm-axiado.c
> =20
>  AXIS ARTPEC ARM64 SoC SUPPORT
>  M:	Jesper Nilsson <jesper.nilsson@axis.com>
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 6f3147518376..76f6c04b0e23 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -129,6 +129,17 @@ config PWM_ATMEL_TCB
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm-atmel-tcb.
> =20
> +config PWM_AXIADO
> +	tristate "Axiado PWM support"
> +	depends on ARCH_AXIADO || COMPILE_TEST
> +	depends on HAS_IOMEM
> +	help
> +	  PWM framework driver for the PWM controller found on Axiado
> +	  AX3000 and AX3005 SoCs.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called pwm-axiado.
> +
>  config PWM_AXI_PWMGEN
>  	tristate "Analog Devices AXI PWM generator"
>  	depends on MICROBLAZE || NIOS2 || ARCH_ZYNQ || ARCH_ZYNQMP || ARCH_INTE=
L_SOCFPGA || COMPILE_TEST
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index 0dc0d2b69025..4466a29e780a 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -8,6 +8,7 @@ obj-$(CONFIG_PWM_ARGON_FAN_HAT)	+=3D pwm-argon-fan-hat.o
>  obj-$(CONFIG_PWM_ATMEL)		+=3D pwm-atmel.o
>  obj-$(CONFIG_PWM_ATMEL_HLCDC_PWM)	+=3D pwm-atmel-hlcdc.o
>  obj-$(CONFIG_PWM_ATMEL_TCB)	+=3D pwm-atmel-tcb.o
> +obj-$(CONFIG_PWM_AXIADO)	+=3D pwm-axiado.o
>  obj-$(CONFIG_PWM_AXI_PWMGEN)	+=3D pwm-axi-pwmgen.o
>  obj-$(CONFIG_PWM_BCM2835)	+=3D pwm-bcm2835.o
>  obj-$(CONFIG_PWM_BCM_IPROC)	+=3D pwm-bcm-iproc.o
> diff --git a/drivers/pwm/pwm-axiado.c b/drivers/pwm/pwm-axiado.c
> new file mode 100644
> index 000000000000..db197886c5c4
> --- /dev/null
> +++ b/drivers/pwm/pwm-axiado.c
> @@ -0,0 +1,193 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2021-2026 Axiado Corporation.

Please add a Limitations paragraph here like the ones found in the newer
driver files. It should answer:

 - Is a period completed on configuration change?
 - Is a period completed on disable?
 - How does the output behave when disabled? (Low? Inactive? Freeze? High-Z=
?)

Also mention special properties, like being unable to set 0% or 100%
relative duty.

> + */
> +
> +#include <linux/bits.h>
> +#include <linux/clk.h>
> +#include <linux/io.h>
> +#include <linux/math64.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/pwm.h>
> +
> +/* Register offsets */
> +#define AX_PWM_CNTRL_REG     0x0000
> +#define AX_PWM_PERIOD_REG    0x0004
> +#define AX_PWM_HIGH_REG      0x0008
> +
> +/* PWM channels */
> +#define AX_PWM_NUM 1

This is only used once, and having

	chip =3D devm_pwmchip_alloc(dev, 1, sizeof(*axpwm));

below simplifies grepping for channel numbers.

> +
> +/* Period and duty cycle limits */
> +#define AX_PWM_PERIOD_MIN       2
> +#define AX_PWM_PERIOD_MAX       0xfffffffeU
> +#define AX_PWM_DUTY_MIN         1
> +#define AX_PWM_DUTY_MAX         0xfffffffdU

The U suffix is not needed for hex constants (AFAIK).

> +
> +/* Control register bits */
> +#define AX_PWM_CTRL_ENABLE BIT(0)
> +#define AX_PWM_CTRL_DISABLE 0x0
> +
> +struct axiado_pwm_chip {
> +	struct clk *clk;
> +	void __iomem *base;
> +};

If you use axiado_pwm_ as prefix for structs and functions, please use
AXIADO_PWM_ as prefix for #defines.

> +
> +static int axiado_pwm_config(struct pwm_chip *chip, struct pwm_device *p=
wm,
> +			     u64 duty_ns, u64 period_ns)
> +{
> +	struct axiado_pwm_chip *axpwm =3D pwmchip_get_drvdata(chip);
> +	unsigned long rate;
> +	u64 period_cycles, duty_cycles;
> +
> +	/*
> +	 * The hardware does not support a zero period, 0% duty cycle, or
> +	 * 100% duty cycle. The caller should handle 0% duty cycle by
> +	 * disabling the PWM.
> +	 */
> +	if (!period_ns || !duty_ns || duty_ns >=3D period_ns)
> +		return -EINVAL;
> +
> +	rate =3D clk_get_rate(axpwm->clk);
> +	if (!rate)
> +		return -EINVAL;
> +
> +	period_cycles =3D mul_u64_u64_div_u64(period_ns, rate, NSEC_PER_SEC);
> +	if (period_cycles < AX_PWM_PERIOD_MIN ||
> +	    period_cycles > AX_PWM_PERIOD_MAX)
> +		return -EINVAL;
> +
> +	duty_cycles =3D mul_u64_u64_div_u64(duty_ns, rate, NSEC_PER_SEC);
> +	if (duty_cycles < AX_PWM_DUTY_MIN ||
> +	    duty_cycles > AX_PWM_DUTY_MAX)
> +		return -EINVAL;
> +
> +	if (duty_cycles >=3D period_cycles)
> +		return -EINVAL;
> +
> +	writel((u32)period_cycles, axpwm->base + AX_PWM_PERIOD_REG);
> +	writel((u32)duty_cycles, axpwm->base + AX_PWM_HIGH_REG);
> +
> +	return 0;
> +}
> +
> +static int axiado_pwm_apply(struct pwm_chip *chip, struct pwm_device *pw=
m,
> +			    const struct pwm_state *state)
> +{
> +	struct axiado_pwm_chip *axpwm =3D pwmchip_get_drvdata(chip);
> +	int ret;
> +
> +	if (state->polarity !=3D PWM_POLARITY_NORMAL)
> +		return -EINVAL;
> +
> +	if (!state->enabled || !state->duty_cycle) {
> +		if (pwm->state.enabled)
> +			writel(AX_PWM_CTRL_DISABLE, axpwm->base + AX_PWM_CNTRL_REG);
> +
> +		return 0;
> +	}
> +
> +	ret =3D axiado_pwm_config(chip, pwm, state->duty_cycle, state->period);
> +	if (ret)
> +		return ret;
> +
> +	if (!pwm->state.enabled)

Ideally check hardware state and not PWM internal variables.

> +		writel(AX_PWM_CTRL_ENABLE, axpwm->base + AX_PWM_CNTRL_REG);
> +
> +	return 0;
> +}
> +
> +static int axiado_pwm_get_state(struct pwm_chip *chip, struct pwm_device=
 *pwm,
> +				struct pwm_state *state)
> +{
> +	struct axiado_pwm_chip *axpwm =3D pwmchip_get_drvdata(chip);
> +	unsigned long rate;
> +	u32 period_cycles;
> +	u32 duty_cycles;
> +	u32 ctrl;
> +
> +	rate =3D clk_get_rate(axpwm->clk);
> +	if (!rate)
> +		return -EINVAL;
> +
> +	ctrl =3D readl(axpwm->base + AX_PWM_CNTRL_REG);
> +	period_cycles =3D readl(axpwm->base + AX_PWM_PERIOD_REG);
> +	duty_cycles =3D readl(axpwm->base + AX_PWM_HIGH_REG);
> +
> +	state->enabled =3D !!(ctrl & AX_PWM_CTRL_ENABLE);
> +	state->period =3D mul_u64_u64_div_u64(period_cycles, NSEC_PER_SEC, rate=
);
> +	state->duty_cycle =3D mul_u64_u64_div_u64(duty_cycles, NSEC_PER_SEC, ra=
te);
> +	state->polarity =3D PWM_POLARITY_NORMAL;

Please test your driver with PWM_DEBUG enabled, the rounding is wrong
here.

> +
> +	return 0;
> +}
> +
> +static const struct pwm_ops axiado_pwm_ops =3D {
> +	.get_state =3D axiado_pwm_get_state,
> +	.apply =3D axiado_pwm_apply,

Please implement the waveform callbacke instead of .get_state() and
=2Eapply()

> +};
> +
> +static void axiado_pwm_disable(void *data)
> +{
> +	struct axiado_pwm_chip *axpwm =3D data;
> +
> +	writel(AX_PWM_CTRL_DISABLE, axpwm->base + AX_PWM_CNTRL_REG);
> +}
> +
> +static int axiado_pwm_probe(struct platform_device *pdev)
> +{
> +	struct device *dev =3D &pdev->dev;
> +	struct axiado_pwm_chip *axpwm;
> +	struct pwm_chip *chip;
> +	int ret;
> +
> +	chip =3D devm_pwmchip_alloc(dev, AX_PWM_NUM, sizeof(*axpwm));
> +	if (IS_ERR(chip))
> +		return PTR_ERR(chip);
> +
> +	axpwm =3D pwmchip_get_drvdata(chip);
> +
> +	axpwm->base =3D devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(axpwm->base))
> +		return dev_err_probe(dev, PTR_ERR(axpwm->base),
> +				     "failed to map registers\n");

Start error messages with a capital letter please.

> +
> +	ret =3D devm_add_action_or_reset(dev, axiado_pwm_disable, axpwm);
> +	if (ret)
> +		return ret;

This isn't supposed to happen. It's the responsibility of the consumer
to disable the PWM before it's freed.

> +
> +

Single empty line only.

> +	axpwm->clk =3D devm_clk_get_enabled(dev, "pwm");
> +	if (IS_ERR(axpwm->clk))
> +		return dev_err_probe(dev, PTR_ERR(axpwm->clk),
> +				     "failed to get/enable clock\n");

Please ensure that the clk rate doesn't change while the PWM is enabled.
Then you can cache the clk rate and set chip->atomic.

> +
> +	chip->ops =3D &axiado_pwm_ops;
> +
> +	ret =3D devm_pwmchip_add(dev, chip);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to add PWM chip\n");
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id axiado_pwm_match[] =3D {
> +	{ .compatible =3D "axiado,ax3000-pwm" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, axiado_pwm_match);
> +
> +static struct platform_driver axiado_pwm_driver =3D {
> +	.driver =3D {
> +		.name =3D  "axiado-pwm",
> +		.of_match_table =3D axiado_pwm_match,
> +	},
> +	.probe =3D axiado_pwm_probe,
> +};
> +
> +module_platform_driver(axiado_pwm_driver);

No empty line between the driver struct and the module_platform helper
please.

> +
> +MODULE_AUTHOR("Axiado Corporation");
> +MODULE_DESCRIPTION("Axiado PWM driver");
> +MODULE_LICENSE("GPL");

Best regards
Uwe

--7u3zpdkvzxvxdj6a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmo5YvAACgkQj4D7WH0S
/k6iZgf9FZNSIp7jKBztkT1RSuqEn0oI1F4XpHV3DCVQADUdYjSEINV/0Eiy8NgI
SPOf44shKAePL2csxgaLhg80NZaTLmFvj1AcF/ayHa8Z1bCl+wP+/GF7jln0KE+N
zUe2sr6ng8dEC2/MjphXReUOXkY0zB3R1vzrtHR2JWKfNrVZNp6FYehRjDdZypm/
GDYHYIaEKZSgpa/6JvkmXZ+s14HahyNA4NHvA/Ey6jG7Yt56jl/JpDb9X0Zw84K3
5wkebSa3t/jZPGfjndlR8T1Ia6z988sLaI6wqWPD9JY3nJZzpVq/zSGT9HsyVH99
l+fbWVn+7x6VuV7VXEnBd+n+k1DzKQ==
=JhcT
-----END PGP SIGNATURE-----

--7u3zpdkvzxvxdj6a--

