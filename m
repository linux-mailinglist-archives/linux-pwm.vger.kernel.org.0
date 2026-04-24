Return-Path: <linux-pwm+bounces-8686-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CP6bEqxC62nZKAAAu9opvQ
	(envelope-from <linux-pwm+bounces-8686-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 24 Apr 2026 12:15:08 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C375C45CCEC
	for <lists+linux-pwm@lfdr.de>; Fri, 24 Apr 2026 12:15:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7FBAB3016536
	for <lists+linux-pwm@lfdr.de>; Fri, 24 Apr 2026 10:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4133D363092;
	Fri, 24 Apr 2026 10:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="geGxdJvA"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9F81ACEDF;
	Fri, 24 Apr 2026 10:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777025637; cv=none; b=EQRzyDwsMxnJTFxEPCivISENod4qPsrnSXBXkftoz0tjuONLbbYHRXlwzNziApZHxPWJGpwYz1yAscNZ+EY+UOEs1VOG6+5tH40rlZE43IB5pjUtlpg6uJXiQ5xxQIblcMjqKs5i37zCzvDJed7HG85FJTd5//rxpik5pJD/9uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777025637; c=relaxed/simple;
	bh=t177GNxpYQx3XFWvysW1fq+ESjiafp+KZ6iHk2sP/ig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cm0o6+mJlhLRhJbZWgt0dbjMX9oswJudqPFY0S6uEdCkCFz37StF2SUpU6Bn+ocByjJhLhmK0d0NMimeLWCGt83fUYLYuVMJSLWdtE7bI9fJnRfC6WKur/o+Th6Qnar+6zPhjFPW9QObzbznGjVc/7WjY48FpkMEaYn9iZrOIcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=geGxdJvA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AFE9C19425;
	Fri, 24 Apr 2026 10:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777025636;
	bh=t177GNxpYQx3XFWvysW1fq+ESjiafp+KZ6iHk2sP/ig=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=geGxdJvA75Bs5geXi6ICsODk213tDp+XcM60ceWfPa9pAtQylvHYnR7byDMcwpc8g
	 moFP4rRQ+EBNAr8xjLH+ITLCgWngWZJQa8F+y7XiIGxjnGzIh28EjhQAcRsVdgQeQu
	 r6djFhH8ksjUJzEglfG1ZCwAEiPtfwxH2WqCLIgakpV+gj/esKAQ5j90c3c5TvZiV9
	 Ct2FXphWI2laTQvbhaXSHPrnJWM6az8v7VHWDyhJ2Nujki5/11Q6VsqLH236IO7i94
	 g2GCwQK8ayjM6VbMdiaeA+Yvjuh9yN1MpO9p1gvIwNxoTV1gYBT0jq2wdR31VxvS6N
	 vWe67+b/45dUw==
Date: Fri, 24 Apr 2026 12:13:54 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Aleksandr Shubin <privatesub2@gmail.com>
Cc: linux-kernel@vger.kernel.org, 
	Brandon Cheo Fusi <fusibrandon13@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Lukas Schmid <lukas.schmid@netcube.li>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v13 2/3] pwm: Add Allwinner's D1/T113-S3/R329 SoCs PWM
 support
Message-ID: <aes2BuCaAUgelKGy@monoceros>
References: <20260221183609.95403-1-privatesub2@gmail.com>
 <20260221183609.95403-3-privatesub2@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ch74tvkiwmuhhpsw"
Content-Disposition: inline
In-Reply-To: <20260221183609.95403-3-privatesub2@gmail.com>
X-Rspamd-Queue-Id: C375C45CCEC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8686-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ukleinek@kernel.org,linux-pwm@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,sholland.org,dabbelt.com,eecs.berkeley.edu,ghiti.fr,pengutronix.de,netcube.li,lists.infradead.org,lists.linux.dev];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]


--ch74tvkiwmuhhpsw
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v13 2/3] pwm: Add Allwinner's D1/T113-S3/R329 SoCs PWM
 support
MIME-Version: 1.0

On Sat, Feb 21, 2026 at 09:35:52PM +0300, Aleksandr Shubin wrote:
> Allwinner's D1, T113-S3 and R329 SoCs have a quite different PWM
> controllers with ones supported by pwm-sun4i driver.
>=20
> This patch adds a PWM controller driver for Allwinner's D1,
> T113-S3 and R329 SoCs. The main difference between these SoCs
> is the number of channels defined by the DT property.
>=20
> Co-developed-by: Brandon Cheo Fusi <fusibrandon13@gmail.com>
> Signed-off-by: Brandon Cheo Fusi <fusibrandon13@gmail.com>
> Signed-off-by: Aleksandr Shubin <privatesub2@gmail.com>
> ---
>  drivers/pwm/Kconfig     |  10 +
>  drivers/pwm/Makefile    |   1 +
>  drivers/pwm/pwm-sun8i.c | 393 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 404 insertions(+)
>  create mode 100644 drivers/pwm/pwm-sun8i.c
>=20
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 6f3147518376..44d844eba589 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -736,6 +736,16 @@ config PWM_SUN4I
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm-sun4i.
> =20
> +config PWM_SUN8I
> +	tristate "Allwinner D1/T113s/R329 PWM support"
> +	depends on ARCH_SUNXI || COMPILE_TEST
> +	depends on COMMON_CLK
> +	help
> +	  Generic PWM framework driver for Allwinner D1/T113s/R329 SoCs.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called pwm-sun8i.
> +
>  config PWM_SUNPLUS
>  	tristate "Sunplus PWM support"
>  	depends on ARCH_SUNPLUS || COMPILE_TEST
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index 0dc0d2b69025..ba2e0ec7fc17 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -67,6 +67,7 @@ obj-$(CONFIG_PWM_STM32)		+=3D pwm-stm32.o
>  obj-$(CONFIG_PWM_STM32_LP)	+=3D pwm-stm32-lp.o
>  obj-$(CONFIG_PWM_STMPE)		+=3D pwm-stmpe.o
>  obj-$(CONFIG_PWM_SUN4I)		+=3D pwm-sun4i.o
> +obj-$(CONFIG_PWM_SUN8I)		+=3D pwm-sun8i.o
>  obj-$(CONFIG_PWM_SUNPLUS)	+=3D pwm-sunplus.o
>  obj-$(CONFIG_PWM_TEGRA)		+=3D pwm-tegra.o
>  obj-$(CONFIG_PWM_TH1520)	+=3D pwm_th1520.o
> diff --git a/drivers/pwm/pwm-sun8i.c b/drivers/pwm/pwm-sun8i.c
> new file mode 100644
> index 000000000000..6e196f31314b
> --- /dev/null
> +++ b/drivers/pwm/pwm-sun8i.c
> @@ -0,0 +1,393 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * PWM Controller Driver for sunxi platforms (D1, T113-S3 and R329)
> + *
> + * Limitations:
> + * - When the parameters change, the current running period is not compl=
eted
> + *   and new settings are applied immediately.
> + * - The PWM output goes to a HIGH-Z state when the channel is disabled.
> + * - Changing the clock configuration (SUN8I_PWM_CLK_CFG)
> + *   may cause a brief output glitch.
> + *
> + * Copyright (c) 2023 Aleksandr Shubin <privatesub2@gmail.com>
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/clk.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/pwm.h>
> +#include <linux/reset.h>
> +
> +#define SUN8I_PWM_CLK_CFG(pair)			(0x20 + ((pair) * 0x4))

A word about the range of `pair` would be good. Something like:

/*
 * Shared clock register. SUN8I_PWM_CLK_CFG(pair) configures the settings
 * for channels 2=C2=B7pair and 2=C2=B7pair+1. Maximal value for pair is ha=
rdware
 * dependant, it cannot be bigger than 8.
 */

> +#define SUN8I_PWM_CLK_CFG_SRC			GENMASK(8, 7)
> +#define SUN8I_PWM_CLK_SRC_HOSC			0x0
> +#define SUN8I_PWM_CLK_SRC_BUS			0x1

SUN8I_PWM_CLK_SRC_HOSC and SUN8I_PWM_CLK_SRC_BUS are values for
SUN8I_PWM_CLK_CFG_SRC, right? It would be great if they were named
SUN8I_PWM_CLK_CFG_SRC_HOSC and SUN8I_PWM_CLK_CFG_SRC_BUS then.
And then it might be sensible to define it to
	FIELD_PREP(SUN8I_PWM_CLK_CFG_SRC, 1)
(and 0 respectively).

I hope there is no conflict with the reference manual.

Speaking of the reference manual: Is there a public one? If yes, adding
a link to it would be awesome.

> +#define SUN8I_PWM_CLK_CFG_DIV_M			GENMASK(3, 0)
> +#define SUN8I_PWM_CLK_DIV_M_MAX			8
> +
> +#define SUN8I_PWM_CLK_GATE			0x40
> +#define SUN8I_PWM_CLK_GATE_BYPASS(chan)		BIT((chan) + 16)
> +#define SUN8I_PWM_CLK_GATE_GATING(chan)		BIT(chan)
> +
> +#define SUN8I_PWM_ENABLE			0x80
> +#define SUN8I_PWM_ENABLE_EN(chan)		BIT(chan)
> +
> +#define SUN8I_PWM_CTL(chan)			(0x100 + (chan) * 0x20)
> +#define SUN8I_PWM_CTL_ACT_STA			BIT(8)
> +#define SUN8I_PWM_CTL_PRESCAL_K			GENMASK(7, 0)
> +#define SUN8I_PWM_CTL_PRESCAL_K_MAX		field_max(SUN8I_PWM_CTL_PRESCAL_K)
> +
> +#define SUN8I_PWM_PERIOD(chan)			(0x104 + (chan) * 0x20)
> +#define SUN8I_PWM_PERIOD_ENTIRE_CYCLE		GENMASK(31, 16)
> +#define SUN8I_PWM_PERIOD_ACT_CYCLE		GENMASK(15, 0)
> +
> +#define SUN8I_PWM_PCNTR_SIZE			BIT(16)

This is unused (apart from the comment below). I'm unsure if this is a
bit field, if so to which register? Does it need a comment? Or should it
be dropped? From the discussion below, should this be
field_max(SUN8I_PWM_PERIOD_ACT_CYCLE)?  (The value is different then
the calculations below needed some adaption if that is chosen.)

> +/*
> + * SUN8I_PWM_MAGIC is used to quickly compute the values of the clock di=
viders
> + * div_m (SUN8I_PWM_CLK_CFG_DIV_M) & prescale_k (SUN8I_PWM_CTL_PRESCAL_K)
> + * without using a loop. These dividers limit the # of cycles in a period
> + * to SUN8I_PWM_PCNTR_SIZE (65536) by applying a scaling factor of
> + * 1 / (div_m * (prescale_k + 1)) to the clock source.

Here div_m is a plain divider, ...

> + *
> + * SUN8I_PWM_MAGIC is derived by solving for div_m and prescale_k
> + * such that for a given requested period,
> + *
> + * i) div_m is minimized for any prescale_k =E2=89=A4 SUN8I_PWM_CTL_PRES=
CAL_K_MAX,
> + * ii) prescale_k is minimized.
> + *
> + * The derivation proceeds as follows, with val =3D # of cycles for requ=
ested
> + * period:
> + *
> + * for a given value of div_m we want the smallest prescale_k such that
> + *
> + * (val >> div_m) // (prescale_k + 1) =E2=89=A4 65536 (=3D SUN8I_PWM_PCN=
TR_SIZE)

=2E.. and here it is a shift. I assume that above 1 << div_m is actually
meant, right?

> + * This is equivalent to:
> + *
> + * (val >> div_m) =E2=89=A4 65536 * (prescale_k + 1) + prescale_k
> + * =E2=9F=BA (val >> div_m) =E2=89=A4 65537 * prescale_k + 65536
> + * =E2=9F=BA (val >> div_m) - 65536 =E2=89=A4 65537 * prescale_k
> + * =E2=9F=BA ((val >> div_m) - 65536) / 65537 =E2=89=A4 prescale_k
> + *
> + * As prescale_k is integer, this becomes
> + *
> + * ((val >> div_m) - 65536) // 65537 =E2=89=A4 prescale_k
> + *
> + * And is minimized at
> + *
> + * ((val >> div_m) - 65536) // 65537
> + *
> + * Now we pick the smallest div_m that satifies prescale_k =E2=89=A4 255
> + * (i.e SUN8I_PWM_CTL_PRESCAL_K_MAX),
> + *
> + * ((val >> div_m) - 65536) // 65537 =E2=89=A4 255
> + * =E2=9F=BA (val >> div_m) - 65536 =E2=89=A4 255 * 65537 + 65536
> + * =E2=9F=BA val >> div_m =E2=89=A4 255 * 65537 + 2 * 65536
> + * =E2=9F=BA val >> div_m < (255 * 65537 + 2 * 65536 + 1)
> + * =E2=9F=BA div_m =3D fls((val) / (255 * 65537 + 2 * 65536 + 1))
> + *
> + * Suggested by Uwe Kleine-K=C3=B6nig
> + */
> +#define SUN8I_PWM_MAGIC				(255 * 65537 + 2 * 65536 + 1)
> +#define SUN8I_PWM_DIV_CONST			65537
> [...]
> +static int sun8i_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> +			    const struct pwm_state *state)
> +{
> +	struct sun8i_pwm_chip *sun8i_chip =3D to_sun8i_pwm_chip(chip);
> +	u64 bus_rate, hosc_rate, val, ent_cycle, act_cycle;
> +	u32 clk_gate, clk_cfg, pwm_en, ctl, reg_period;
> +	u32 prescale_k, div_m;
> +	u64 clk_src_rate;
> +	u8 clk_src;
> +
> +	pwm_en =3D sun8i_pwm_readl(sun8i_chip, SUN8I_PWM_ENABLE);
> +	clk_gate =3D sun8i_pwm_readl(sun8i_chip, SUN8I_PWM_CLK_GATE);
> +
> +	if (!state->enabled) {
> +		if (state->enabled !=3D pwm->state.enabled) {

Can we make this

		if (pwm_en & SUN8I_PWM_ENABLE_EN(pwm->hwpwm)) {

? Then it depends on the hardware settings instead of cached state. Same
for the other usage of pwm->state below.

> +			clk_gate &=3D ~SUN8I_PWM_CLK_GATE_GATING(pwm->hwpwm);
> +			pwm_en &=3D ~SUN8I_PWM_ENABLE_EN(pwm->hwpwm);
> +			sun8i_pwm_writel(sun8i_chip, pwm_en, SUN8I_PWM_ENABLE);
> +			sun8i_pwm_writel(sun8i_chip, clk_gate, SUN8I_PWM_CLK_GATE);
> +		}
> +		return 0;
> +	}
> +
> +	ctl =3D sun8i_pwm_readl(sun8i_chip, SUN8I_PWM_CTL(pwm->hwpwm));
> +	clk_cfg =3D sun8i_pwm_readl(sun8i_chip, SUN8I_PWM_CLK_CFG(pwm->hwpwm / =
2));
> +	hosc_rate =3D clk_get_rate(sun8i_chip->clk_hosc);
> +	bus_rate =3D clk_get_rate(sun8i_chip->clk_apb);
> +
> [...]
> +static int sun8i_pwm_probe(struct platform_device *pdev)
> +{
> +	struct pwm_chip *chip;
> +	struct sun8i_pwm_chip *sun8i_chip;
> +	struct clk *clk_bus;
> +	struct reset_control *rst;
> +	u32 npwm;
> +	int ret;
> +
> +	ret =3D of_property_read_u32(pdev->dev.of_node, "allwinner,npwms", &npw=
m);
> +	if (ret < 0)
> +		return dev_err_probe(&pdev->dev, ret,
> +				     "Failed to get allwinner,npwms\n");

I failed to reply to your question about a non-vendored name for this in
v10
(https://lore.kernel.org/linux-pwm/CAF4idNmDMQpFppUvCBbC1=3DSNMQBrTOqmFO60S=
MvKvaHvNJy=3DBg@mail.gmail.com).

"npwms" would be good.

> +	if (npwm < 1 || npwm > 16)
> +		return dev_err_probe(&pdev->dev, -EINVAL,
> +				     "Invalid allwinner,npwms\n");

I think there is a corner case if npwm is odd. In that case the last
channel must not check for hwpwm ^ 1 being enabled in .apply(). So
either .apply() should be more clever, or only even values for npwm
should be supported.

> +	chip =3D devm_pwmchip_alloc(&pdev->dev, npwm, sizeof(*sun8i_chip));
> +	if (IS_ERR(chip))
> +		return PTR_ERR(chip);
> +	sun8i_chip =3D to_sun8i_pwm_chip(chip);
> +
> +	sun8i_chip->base =3D devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(sun8i_chip->base))
> +		return PTR_ERR(sun8i_chip->base);
> [...]

Best regards
Uwe

--ch74tvkiwmuhhpsw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmnrQl8ACgkQj4D7WH0S
/k6scAgAn/0pDIYz2bAwUkDKaKeuPSiZvM+qmY6SFJ1w+GckDDKQbRMKqM5uDrEY
EWS7ubhDZ9I2MNSIB/AIKMsM/7CkCtE8Vpfh3JSM9f5GzDhJ0vIF6V9zBH4tc9OV
yCmIdHET/SPl6v9I1kszOG/+JK5jx+VelmPkIFbuhIxQhcg/P3iuG4EE1TKsRrNh
OZu0sT9zHz/1Lh7hyQRx1K6dA6RQat35CnYLHah9JG0E5iIwS4XZ5S3OFwNrm1Ji
1gX8GgGM7cgovSIx5sZzwHDxtSiregtnbtg9pEhguwEsDMuhVDeT5BM+EIoIZFjR
jE24yAph4qmJMavKIQYVft3Rd754Kw==
=AWnj
-----END PGP SIGNATURE-----

--ch74tvkiwmuhhpsw--

