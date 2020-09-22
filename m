Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 116C7273B85
	for <lists+linux-pwm@lfdr.de>; Tue, 22 Sep 2020 09:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729608AbgIVHO1 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 22 Sep 2020 03:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728526AbgIVHO1 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 22 Sep 2020 03:14:27 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87E10C061755
        for <linux-pwm@vger.kernel.org>; Tue, 22 Sep 2020 00:14:27 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kKcVB-0001w2-Qe; Tue, 22 Sep 2020 09:14:13 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1kKcV7-0005eb-8l; Tue, 22 Sep 2020 09:14:09 +0200
Date:   Tue, 22 Sep 2020 09:14:09 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, punit1.agrawal@toshiba.co.jp,
        yuji2.ishikawa@toshiba.co.jp, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org,
        Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Subject: Re: [PATCH 2/2] pwm: visconti: Add Toshiba Visconti SoC PWM support
Message-ID: <20200922071409.lkmnhs73fu472va6@pengutronix.de>
References: <20200917223140.227542-1-nobuhiro1.iwamatsu@toshiba.co.jp>
 <20200917223140.227542-3-nobuhiro1.iwamatsu@toshiba.co.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="iquqfa67vjcgsgmr"
Content-Disposition: inline
In-Reply-To: <20200917223140.227542-3-nobuhiro1.iwamatsu@toshiba.co.jp>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--iquqfa67vjcgsgmr
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Fri, Sep 18, 2020 at 07:31:40AM +0900, Nobuhiro Iwamatsu wrote:
> diff --git a/drivers/pwm/pwm-visconti.c b/drivers/pwm/pwm-visconti.c
> new file mode 100644
> index 000000000000..601450111166
> --- /dev/null
> +++ b/drivers/pwm/pwm-visconti.c
> @@ -0,0 +1,141 @@
> +// SPDX-License-Identifier: GPL-2.0

The SPDX guys deprecated "GPL-2.0" as identifier and recommend
"GPL-2.0-only" instead. As in the kernel both are allowed I prefer the
latter.

> +/*
> + * Toshiba Visconti pulse-width-modulation controller driver
> + *
> + * Copyright (c) 2020 TOSHIBA CORPORATION
> + * Copyright (c) 2020 Toshiba Electronic Devices & Storage Corporation
> + * Copyright (c) 2020 Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.j=
p>
> + *
> + */

If there is a publically available manual, please add a link here.

> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/pwm.h>
> +#include <linux/platform_device.h>
> +
> +#define PWMC0_PWMACT BIT(5)
> +
> +#define REG_PCSR(ch) (0x400 + 4 * (ch))
> +#define REG_PDUT(ch) (0x420 + 4 * (ch))
> +#define REG_PWM0(ch) (0x440 + 4 * (ch))

Please us a prefix for the register defines. Also it would be great if
it would be obvious from the naming to which register the PWMACT bit
belongs.

> +struct visconti_pwm_chip {
> +	struct pwm_chip chip;
> +	struct device *dev;
> +	void __iomem *base;
> +};
> +
> +#define to_visconti_chip(chip) \
> +	container_of(chip, struct visconti_pwm_chip, chip)
> +
> +static int visconti_pwm_apply(struct pwm_chip *chip, struct pwm_device *=
pwm,
> +			  const struct pwm_state *state)
> +{
> +	struct visconti_pwm_chip *priv =3D to_visconti_chip(chip);
> +	u32 period, duty, pwmc0;
> +
> +	dev_dbg(priv->dev, "%s: ch =3D %d en =3D %d p =3D 0x%llx d =3D 0x%llx\n=
", __func__,
> +		pwm->hwpwm, state->enabled, state->period, state->duty_cycle);
> +	if (state->enabled) {
> +		period =3D state->period / 1000;
> +		duty =3D state->duty_cycle / 1000;
> +		if (period < 0x10000)
> +			pwmc0 =3D 0;
> +		else if (period < 0x20000)
> +			pwmc0 =3D 1;
> +		else if (period < 0x40000)
> +			pwmc0 =3D 2;
> +		else if (period < 0x80000)
> +			pwmc0 =3D 3;
> +		else
> +			return -EINVAL;
> +
> +		if (pwmc0) {
> +			period /=3D BIT(pwmc0);
> +			duty /=3D BIT(pwmc0);
> +		}

You can drop the if and just make this:

	period <<=3D pwmc0;
	duty <<=3D pwmc0;

as this is a noop if pwmc0 is zero.

> +		if (state->polarity =3D=3D PWM_POLARITY_INVERSED)
> +			pwmc0 |=3D PWMC0_PWMACT;
> +
> +		writel(pwmc0, priv->base + REG_PWM0(pwm->hwpwm));
> +		writel(duty, priv->base + REG_PDUT(pwm->hwpwm));
> +		writel(period, priv->base + REG_PCSR(pwm->hwpwm));

Some comments about the function of the hardware would be good.
Something like (I assume the optimal hardware here, please adapt to
reality):

	pwmc is a 2-bit divider for the input clock running at 1 MHz.
	When the settings of the PWM are modified, the new values are
	shadowed in hardware until the period register (PCSR) is written
	and the currently running period is completed. This way the
	hardware switches atomically from the old setting to the new.
	Also disabling the hardware completes the currently running
	period and then the output drives the inactive state.

(I'm sure however this is wrong because you don't consider
state->polarity in the !state-enabled case.)

If your hardware doesn't behave as indicated please add a Limitations
paragraph at the beginning of the driver as is done for several other
drivers already describing the shortcomings.

> +	} else {
> +		writel(0, priv->base + REG_PCSR(pwm->hwpwm));
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct pwm_ops visconti_pwm_ops =3D {
> +	.apply =3D visconti_pwm_apply,

Please implement .get_state(). (And test it using PWM_DEBUG.)

> +	.owner =3D THIS_MODULE,
> +};
> +
> +static int visconti_pwm_probe(struct platform_device *pdev)
> +{
> +	struct device *dev =3D &pdev->dev;
> +	struct visconti_pwm_chip *priv;
> +	int ret;
> +
> +	priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->dev =3D &pdev->dev;

You can better use

	priv->dev =3D dev;

here. (But I agree to the previous review that it makes little sense to
keep this member in struct visconti_pwm_chip.)

> +	priv->base =3D devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(priv->base)) {
> +		dev_err(dev, "unable to map I/O space\n");

devm_platform_ioremap_resource already emits an error message on failure,
so no need to add another.

> +		return PTR_ERR(priv->base);
> +	}
> +
> +	platform_set_drvdata(pdev, priv);
> +
> +	priv->chip.dev =3D dev;
> +	priv->chip.ops =3D &visconti_pwm_ops;
> +	priv->chip.base =3D -1;
> +	priv->chip.npwm =3D 4;
> +
> +	ret =3D pwmchip_add(&priv->chip);
> +	if (ret < 0) {
> +		dev_err(dev, "Cannot register visconti PWM: %d\n", ret);

Please use dev_err_probe here or %pe for the error code.

> +		return ret;
> +	}
> +
> +	dev_info(&pdev->dev, "visconti PWM registered\n");

Please degrade this to dev_dbg.

> +	return 0;
> +}
> +
> +static int visconti_pwm_remove(struct platform_device *pdev)
> +{
> +	struct visconti_pwm_chip *priv =3D platform_get_drvdata(pdev);
> +
> +	return pwmchip_remove(&priv->chip);
> +}
> +
> +static const struct of_device_id visconti_pwm_of_match[] =3D {
> +	{ .compatible =3D "toshiba,pwm-visconti", },
> +	{ }
> +};
> +
> +MODULE_DEVICE_TABLE(of, visconti_pwm_of_match);

Please drop the empty line before MODULE_DEVICE_TABLE.

> +static struct platform_driver visconti_pwm_driver =3D {
> +	.driver =3D {
> +		.name =3D "pwm-visconti",
> +		.of_match_table =3D visconti_pwm_of_match,
> +	},
> +	.probe =3D visconti_pwm_probe,
> +	.remove =3D visconti_pwm_remove,
> +};
> +
> +module_platform_driver(visconti_pwm_driver);

The empty line before module_platform_driver is also unusual.

> +MODULE_LICENSE("GPL v2");
> +MODULE_AUTHOR("Toshiba");
> +MODULE_ALIAS("platform:visconti-pwm");

This is wrong; as the driver name is pwm-visconti this should be
MODULE_ALIAS("platform:pwm-visconti");

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--iquqfa67vjcgsgmr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl9ppD4ACgkQwfwUeK3K
7AnbxQf8Cvo29NR9D+o6AI0DZe9T5COF9a/0TZlwNqTHXz7TKf3wRaBl2izcsYRI
Roz1yxDAV1BhAuK56oi+oY7vtaMqxgNm5N3fIEZA7q/9rMoJ3qK81UF6AO7Kbgyw
1XVvx6/ji9hhdvYfGFx+QCEXrLELfETVA0chqrU9uB0w/R+RNtEvEqy7U8Y3iKMf
kiETqpbcb5V2C6j3nKIKZMT6oju5DIRmPVM26oMLF1ZL6TqLYr1odS1ktIJrxByP
W2EgWLkUPtSSlPpPdsKmAFs+/5EvR01oUrPXN9foCe20zCGNmcUA2Z897MVHcjkR
8gqFwGtpsKAvpU2nw59YOJGgBtBs9g==
=xUoW
-----END PGP SIGNATURE-----

--iquqfa67vjcgsgmr--
