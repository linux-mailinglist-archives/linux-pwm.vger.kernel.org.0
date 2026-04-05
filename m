Return-Path: <linux-pwm+bounces-8481-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id keXZNQ/Y0mlmbgcAu9opvQ
	(envelope-from <linux-pwm+bounces-8481-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Sun, 05 Apr 2026 23:45:51 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 40F3339FE67
	for <lists+linux-pwm@lfdr.de>; Sun, 05 Apr 2026 23:45:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AFD0630038FD
	for <lists+linux-pwm@lfdr.de>; Sun,  5 Apr 2026 21:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC4E536F433;
	Sun,  5 Apr 2026 21:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QvkVXYVg"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85BD017A31E;
	Sun,  5 Apr 2026 21:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775425547; cv=none; b=YA7Liimx1ayibfJi5/jN+oD1eXh8PPqbEaAJeGRzZrtB3HosXYMASNvIH+IXWLndc23R0cCardWK7j/j/lRyg5LNh0E8bNdKAiLdreA6crNl6uMnlhovWljFFopXxFSZS2M5OSPLkt0y9qVLdxocWGvFL5BTxRMh/rMXxrtVIOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775425547; c=relaxed/simple;
	bh=PqdifVWuHqeZEPWOsDp78YcovlCq6Q0AzxgG27WSl24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QcuTtHZiXonFZ4MDVpWBJDVLNxRGPzcPYRqvmzEVnt6mrEiUaOmCk3Iv6H8CunN3vMpgT2bcZrPfsi9wNgTt0PHapBuORRyMf/KGzYPSv1ixJMwLj3hHUsStWAq2xaC+YBOBpVI7YYyYmZQSbZljwGYwCU0tB2it/T7Ah8senPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QvkVXYVg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 895AAC116C6;
	Sun,  5 Apr 2026 21:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775425547;
	bh=PqdifVWuHqeZEPWOsDp78YcovlCq6Q0AzxgG27WSl24=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QvkVXYVguODmXLSnl09y0a2kNkUuJ/Da7Vfjj9DtLL7guQY43m9t+hLnGkNi+AWap
	 Ko1hJuNfARGLj9ucFsCUfHbuljaDgymE3ubBtb+aWuUrXsdquqKnxvppFI5es0b1/W
	 1pFBjuKoEks2OqWLqQTpbvfCCNgvii8nonrPl7HRcqKSEmSMnTQTOwxQuqXsGbyeds
	 7AUy615bvs9OH2d8nYQzcANR5pB0tk8GV3C6cPXSl6DbpInL5g0fGeGpwmWcrWOoVY
	 KY8w83f+rpFqnbOsBSl1gWRBJ+Hfs9OX8STBTUqIt7oVYCfLHxXxNFlACWT34gu5UC
	 b34qeqy3ezQKA==
Date: Sun, 5 Apr 2026 23:45:44 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Andrea della Porta <andrea.porta@suse.com>
Cc: linux-pwm@vger.kernel.org, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Naushir Patuck <naush@raspberrypi.com>, Stanimir Varbanov <svarbanov@suse.de>
Subject: Re: [PATCH 2/3] pwm: rp1: Add RP1 PWM controller driver
Message-ID: <adLTwOTbkJ0VQXy6@monoceros>
References: <cover.1775223441.git.andrea.porta@suse.com>
 <28e29fbfc20c0b8a115d006233c2759d8f49e639.1775223441.git.andrea.porta@suse.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="adsc23vehck6wpjh"
Content-Disposition: inline
In-Reply-To: <28e29fbfc20c0b8a115d006233c2759d8f49e639.1775223441.git.andrea.porta@suse.com>
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8481-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ukleinek@kernel.org,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 40F3339FE67
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--adsc23vehck6wpjh
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 2/3] pwm: rp1: Add RP1 PWM controller driver
MIME-Version: 1.0

Hello Andrea,

On Fri, Apr 03, 2026 at 04:31:55PM +0200, Andrea della Porta wrote:
> From: Naushir Patuck <naush@raspberrypi.com>
>=20
> The Raspberry Pi RP1 southbridge features an embedded PWM
> controller with 4 output channels, alongside an RPM interface
> to read the fan speed on the Raspberry Pi 5.
>=20
> Add the supporting driver.
>=20
> Signed-off-by: Naushir Patuck <naush@raspberrypi.com>
> Co-developed-by: Stanimir Varbanov <svarbanov@suse.de>
> Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>
> Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> ---
>  drivers/pwm/Kconfig   |  10 ++
>  drivers/pwm/Makefile  |   1 +
>  drivers/pwm/pwm-rp1.c | 244 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 255 insertions(+)
>  create mode 100644 drivers/pwm/pwm-rp1.c
>=20
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 6f3147518376a..22e4fc6385da2 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -625,6 +625,16 @@ config PWM_ROCKCHIP
>  	  Generic PWM framework driver for the PWM controller found on
>  	  Rockchip SoCs.
> =20
> +config PWM_RP1

I prefer PWM_RASPBERRYPI1, or PWM_RASPBERRYPI_RP1 here.

> +	tristate "RP1 PWM support"
> +	depends on MISC_RP1 || COMPILE_TEST
> +	depends on HWMON
> +	help
> +	  PWM framework driver for Raspberry Pi RP1 controller
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called pwm-rp1.
> +
>  config PWM_SAMSUNG
>  	tristate "Samsung PWM support"
>  	depends on PLAT_SAMSUNG || ARCH_S5PV210 || ARCH_EXYNOS || COMPILE_TEST
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index 0dc0d2b69025d..895a7c42fe9c0 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -56,6 +56,7 @@ obj-$(CONFIG_PWM_RENESAS_RZG2L_GPT)	+=3D pwm-rzg2l-gpt.o
>  obj-$(CONFIG_PWM_RENESAS_RZ_MTU3)	+=3D pwm-rz-mtu3.o
>  obj-$(CONFIG_PWM_RENESAS_TPU)	+=3D pwm-renesas-tpu.o
>  obj-$(CONFIG_PWM_ROCKCHIP)	+=3D pwm-rockchip.o
> +obj-$(CONFIG_PWM_RP1)		+=3D pwm-rp1.o
>  obj-$(CONFIG_PWM_SAMSUNG)	+=3D pwm-samsung.o
>  obj-$(CONFIG_PWM_SIFIVE)	+=3D pwm-sifive.o
>  obj-$(CONFIG_PWM_SL28CPLD)	+=3D pwm-sl28cpld.o
> diff --git a/drivers/pwm/pwm-rp1.c b/drivers/pwm/pwm-rp1.c
> new file mode 100644
> index 0000000000000..0a1c1c1dd27e9
> --- /dev/null
> +++ b/drivers/pwm/pwm-rp1.c
> @@ -0,0 +1,244 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * pwm-rp1.c
> + *
> + * Raspberry Pi RP1 PWM.
> + *
> + * Copyright =A9 2026 Raspberry Pi Ltd.
> + *
> + * Author: Naushir Patuck (naush@raspberrypi.com)
> + *
> + * Based on the pwm-bcm2835 driver by:
> + * Bart Tanghe <bart.tanghe@thomasmore.be>
> + */

Please add a paragraph here named "Limitations" in the same format as
several other drivers describing how the driver behaves on disable and
configuration changes (can glitches occur? Is the currently running
period completed or aborted?)

> +#include <linux/bitops.h>
> +#include <linux/clk.h>
> +#include <linux/err.h>
> +#include <linux/hwmon.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/pwm.h>
> +
> +#define PWM_GLOBAL_CTRL		0x000
> +#define PWM_CHANNEL_CTRL(x)	(0x014 + ((x) * 0x10))
> +#define PWM_RANGE(x)		(0x018 + ((x) * 0x10))
> +#define PWM_PHASE(x)		(0x01C + ((x) * 0x10))
> +#define PWM_DUTY(x)		(0x020 + ((x) * 0x10))
> +
> +/* 8:FIFO_POP_MASK + 0:Trailing edge M/S modulation */
> +#define PWM_CHANNEL_DEFAULT	(BIT(8) + BIT(0))
> +#define PWM_CHANNEL_ENABLE(x)	BIT(x)
> +#define PWM_POLARITY		BIT(3)
> +#define SET_UPDATE		BIT(31)
> +#define PWM_MODE_MASK		GENMASK(1, 0)
> +
> +#define NUM_PWMS		4

Please prefix all #defines by something driver specific (e.g. RP1_PWM_).

> +
> +struct rp1_pwm {
> +	void __iomem	*base;
> +	struct clk	*clk;
> +};
> +
> +static const struct hwmon_channel_info * const rp1_fan_hwmon_info[] =3D {
> +	HWMON_CHANNEL_INFO(fan, HWMON_F_INPUT),
> +	NULL
> +};
> +
> +static umode_t rp1_fan_hwmon_is_visible(const void *data, enum hwmon_sen=
sor_types type,
> +					u32 attr, int channel)
> +{
> +	umode_t mode =3D 0;
> +
> +	if (type =3D=3D hwmon_fan && attr =3D=3D hwmon_fan_input)
> +		mode =3D 0444;
> +
> +	return mode;
> +}
> +
> +static int rp1_fan_hwmon_read(struct device *dev, enum hwmon_sensor_type=
s type,
> +			      u32 attr, int channel, long *val)
> +{
> +	struct rp1_pwm *rp1 =3D dev_get_drvdata(dev);
> +
> +	if (type !=3D hwmon_fan || attr !=3D hwmon_fan_input)
> +		return -EOPNOTSUPP;
> +
> +	*val =3D readl(rp1->base + PWM_PHASE(2));
> +
> +	return 0;
> +}

I don't like having hwmon bits in pwm drivers. Is the PWM only usable
for a fan? I guess the hwmon parts should be dropped and a pwm-fan
defined in dt.

> +static const struct hwmon_ops rp1_fan_hwmon_ops =3D {
> +	.is_visible =3D rp1_fan_hwmon_is_visible,
> +	.read =3D rp1_fan_hwmon_read,
> +};
> +
> +static const struct hwmon_chip_info rp1_fan_hwmon_chip_info =3D {
> +	.ops =3D &rp1_fan_hwmon_ops,
> +	.info =3D rp1_fan_hwmon_info,
> +};
> +
> +static void rp1_pwm_apply_config(struct pwm_chip *chip, struct pwm_devic=
e *pwm)
> +{
> +	struct rp1_pwm *rp1 =3D pwmchip_get_drvdata(chip);
> +	u32 value;
> +
> +	value =3D readl(rp1->base + PWM_GLOBAL_CTRL);
> +	value |=3D SET_UPDATE;
> +	writel(value, rp1->base + PWM_GLOBAL_CTRL);
> +}
> +
> +static int rp1_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
> +{
> +	struct rp1_pwm *rp1 =3D pwmchip_get_drvdata(chip);
> +
> +	writel(PWM_CHANNEL_DEFAULT, rp1->base + PWM_CHANNEL_CTRL(pwm->hwpwm));

Please add a comment about what this does.

> +	return 0;
> +}
> +
> +static void rp1_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
> +{
> +	struct rp1_pwm *rp1 =3D pwmchip_get_drvdata(chip);
> +	u32 value;
> +
> +	value =3D readl(rp1->base + PWM_CHANNEL_CTRL(pwm->hwpwm));
> +	value &=3D ~PWM_MODE_MASK;
> +	writel(value, rp1->base + PWM_CHANNEL_CTRL(pwm->hwpwm));
> +
> +	rp1_pwm_apply_config(chip, pwm);

What is the purpose of this call?

> +}
> +
> +static int rp1_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> +			 const struct pwm_state *state)
> +{
> +	struct rp1_pwm *rp1 =3D pwmchip_get_drvdata(chip);
> +	unsigned long clk_rate =3D clk_get_rate(rp1->clk);
> +	unsigned long clk_period;
> +	u32 value;
> +
> +	if (!clk_rate) {
> +		dev_err(&chip->dev, "failed to get clock rate\n");
> +		return -EINVAL;
> +	}
> +
> +	/* set period and duty cycle */
> +	clk_period =3D DIV_ROUND_CLOSEST(NSEC_PER_SEC, clk_rate);

DIV_ROUND_CLOSEST is wrong here. (I don't go into details as .apply()
should be dropped.)

> +	writel(DIV_ROUND_CLOSEST(state->duty_cycle, clk_period),

Dividing by the result of a division loses precision.

> +	       rp1->base + PWM_DUTY(pwm->hwpwm));
> +
> +	writel(DIV_ROUND_CLOSEST(state->period, clk_period),
> +	       rp1->base + PWM_RANGE(pwm->hwpwm));
> +
> +	/* set polarity */
> +	value =3D readl(rp1->base + PWM_CHANNEL_CTRL(pwm->hwpwm));
> +	if (state->polarity =3D=3D PWM_POLARITY_NORMAL)
> +		value &=3D ~PWM_POLARITY;
> +	else
> +		value |=3D PWM_POLARITY;
> +	writel(value, rp1->base + PWM_CHANNEL_CTRL(pwm->hwpwm));
> +
> +	/* enable/disable */
> +	value =3D readl(rp1->base + PWM_GLOBAL_CTRL);
> +	if (state->enabled)
> +		value |=3D PWM_CHANNEL_ENABLE(pwm->hwpwm);
> +	else
> +		value &=3D ~PWM_CHANNEL_ENABLE(pwm->hwpwm);
> +	writel(value, rp1->base + PWM_GLOBAL_CTRL);
> +
> +	rp1_pwm_apply_config(chip, pwm);
> +
> +	return 0;
> +}
> +
> +static const struct pwm_ops rp1_pwm_ops =3D {
> +	.request =3D rp1_pwm_request,
> +	.free =3D rp1_pwm_free,
> +	.apply =3D rp1_pwm_apply,

Please implement the waveform callbacks instead of .apply().

> +};
> +
> +static int rp1_pwm_probe(struct platform_device *pdev)
> +{
> +	struct device *dev =3D &pdev->dev;
> +	struct device *hwmon_dev;
> +	struct pwm_chip *chip;
> +	struct rp1_pwm *rp1;
> +	int ret;
> +
> +	chip =3D devm_pwmchip_alloc(dev, NUM_PWMS, sizeof(*rp1));
> +	if (IS_ERR(chip))
> +		return PTR_ERR(chip);
> +
> +	rp1 =3D pwmchip_get_drvdata(chip);
> +
> +	rp1->base =3D devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(rp1->base))
> +		return PTR_ERR(rp1->base);
> +
> +	rp1->clk =3D devm_clk_get_enabled(dev, NULL);
> +	if (IS_ERR(rp1->clk))
> +		return dev_err_probe(dev, PTR_ERR(rp1->clk), "clock not found\n");

Please start error messages with a capital letter.

> +
> +	ret =3D devm_clk_rate_exclusive_get(dev, rp1->clk);

After this call you can determine the rate just once and fail if it's =3D=3D
0.

> +	if (ret)
> +		return dev_err_probe(dev, ret, "fail to get exclusive rate\n");
> +
> +	chip->ops =3D &rp1_pwm_ops;
> +
> +	platform_set_drvdata(pdev, chip);
> +
> +	ret =3D devm_pwmchip_add(dev, chip);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to register PWM chip\n");
> +
> +	hwmon_dev =3D devm_hwmon_device_register_with_info(dev, "rp1_fan_tach",=
 rp1,
> +							 &rp1_fan_hwmon_chip_info,
> +							 NULL);
> +
> +	if (IS_ERR(hwmon_dev))
> +		return dev_err_probe(dev, PTR_ERR(hwmon_dev),
> +				     "failed to register hwmon fan device\n");
> +
> +	return 0;
> +}
> +
> +static int rp1_pwm_suspend(struct device *dev)
> +{
> +	struct rp1_pwm *rp1 =3D dev_get_drvdata(dev);
> +
> +	clk_disable_unprepare(rp1->clk);
> +
> +	return 0;
> +}
> +
> +static int rp1_pwm_resume(struct device *dev)
> +{
> +	struct rp1_pwm *rp1 =3D dev_get_drvdata(dev);
> +
> +	return clk_prepare_enable(rp1->clk);

Hmm, if this fails and then the driver is unbound, the clk operations
are not balanced.

> +}
> +
> +static DEFINE_SIMPLE_DEV_PM_OPS(rp1_pwm_pm_ops, rp1_pwm_suspend, rp1_pwm=
_resume);
> +
> +static const struct of_device_id rp1_pwm_of_match[] =3D {
> +	{ .compatible =3D "raspberrypi,rp1-pwm" },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, rp1_pwm_of_match);
> +
> +static struct platform_driver rp1_pwm_driver =3D {
> +	.probe =3D rp1_pwm_probe,
> +	.driver =3D {
> +		.name =3D "rp1-pwm",
> +		.of_match_table =3D rp1_pwm_of_match,
> +		.pm =3D pm_ptr(&rp1_pwm_pm_ops),
> +	},
> +};
> +module_platform_driver(rp1_pwm_driver);
> +
> +MODULE_DESCRIPTION("RP1 PWM driver");
> +MODULE_AUTHOR("Naushir Patuck <naush@raspberrypi.com>");
> +MODULE_LICENSE("GPL");
> --=20
> 2.35.3
>=20

Best regards
Uwe

--adsc23vehck6wpjh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmnS2AUACgkQj4D7WH0S
/k5mswf/TUCC5nF0OuTSMULn2cuRQsH3gFVXNmkEYbMWCM98yGoh8gYDk7aNdIl5
8FfYhADd4LPjWTlKa+Tg/NoZoPeonvIhodfvRo30AaomnEdeAnI56Shk8OMelwI4
xjbwHyQq0Ar0RKJRz5AU8GAGj/ShBgGWOIBEnFnbWSBHVDD/b56vGvQul3ZSCygZ
Q1aI7kQZLEpF9MYoALdasc1SxrDLzfO5zL2CV7umpmwsnVSF66Dpr5PSLk6PYzMT
owBTgJhmsqX/0E1cI9Krv+5HxtdF1pVUwcavvuRVbW5Uyk7BktiB7GhQKWU6qaBn
s0UM6EisqsrFM7ILp5gdRe34lso6Zg==
=hAUy
-----END PGP SIGNATURE-----

--adsc23vehck6wpjh--

