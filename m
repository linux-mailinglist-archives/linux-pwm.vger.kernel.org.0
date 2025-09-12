Return-Path: <linux-pwm+bounces-7296-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BFDAB542D0
	for <lists+linux-pwm@lfdr.de>; Fri, 12 Sep 2025 08:24:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B8925A440F
	for <lists+linux-pwm@lfdr.de>; Fri, 12 Sep 2025 06:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA97D28466A;
	Fri, 12 Sep 2025 06:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="eAE+Tka1"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3056927FB2A
	for <linux-pwm@vger.kernel.org>; Fri, 12 Sep 2025 06:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757658252; cv=none; b=LVy5eyH8oImPFMNaGVhq3r1zbGWWLFy0NQYKXmdCYvp+gAnr3WKXkT123DUOqSo+FmcF9lRU8xs36tNs68DcYL5Cvu0LRU6PrmkE1srQKtF6UYnJzT/WjEJtM8g+SK2la3dGIAlunAPkMQ+iaoPzZAlXqZe/jCeRRXosyn8y0I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757658252; c=relaxed/simple;
	bh=7ifweptQB82L2fvWYkjraRwW321Ua213iGlPWa7zjsk=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Subject:Cc:From:
	 References:In-Reply-To; b=jRICyI3jnvyA/+TELqWkca7rZN+YNQQ9L0/0hi01ptiGnof+RBkeTJ4lLkbK/ElNVfn0/N9vQxq40hMShziX/nJsjqgqIEaHLnT9L6Nlp0dViTnnrCGN536ySAjgk8mTw8WOPDn3peImbsH7YutwnFeQrNU7CWy+JjyBGtyYXDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=eAE+Tka1; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 7DDC01A0DE3;
	Fri, 12 Sep 2025 06:24:07 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 46F0360638;
	Fri, 12 Sep 2025 06:24:07 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 03705102F29D8;
	Fri, 12 Sep 2025 08:23:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1757658246; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=5owq+y5TmSlW6EKLN0YJ4cOpLUP+7KPBn1QVcPQ/Stk=;
	b=eAE+Tka1pUnbJaGLXfPStw22RvgK+i0hE2uVw8hJmvOMgHK6PyfcfvBoDZTSwBM0NePU0J
	ExVmezdkjPIst+QZFPuYArE+X4rRcXwjtkGIxMHXy5FY45dzGr3Wa9QFGzx80cwGQ3IQlY
	hMY4y+Zyd3CDUlW2o2crO8dDTZGnucoTCtRSvf4WWmxfN2PWSu0YDQvthgHxy+PzvCxBD9
	04n/wTMnnuuGvnxi554ibnlKZI79PtMwYh7wMS6TdkTAb2+Su94bcyaIpKakPZk2vgi6R/
	nyUMJ9Z9iHi/9t42mkdlNvz7duzjwC3hsHeghArI2edfVrkQhAANYyBCCUr00g==
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 12 Sep 2025 08:23:48 +0200
Message-Id: <DCQLUB80GU6Y.18U540Q0R3YFP@bootlin.com>
To: "Lee Jones" <lee@kernel.org>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley"
 <conor+dt@kernel.org>, "Kamel Bouhara" <kamel.bouhara@bootlin.com>, "Linus
 Walleij" <linus.walleij@linaro.org>, "Bartosz Golaszewski" <brgl@bgdev.pl>,
 "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, "Michael Walle"
 <mwalle@kernel.org>, "Mark Brown" <broonie@kernel.org>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v14 04/10] pwm: max7360: Add MAX7360 PWM support
Cc: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-gpio@vger.kernel.org>, <linux-input@vger.kernel.org>,
 <linux-pwm@vger.kernel.org>, <andriy.shevchenko@intel.com>,
 =?utf-8?q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>, "Thomas
 Petazzoni" <thomas.petazzoni@bootlin.com>, "Andy Shevchenko"
 <andriy.shevchenko@linux.intel.com>
From: "Mathieu Dubois-Briand" <mathieu.dubois-briand@bootlin.com>
X-Mailer: aerc 0.19.0-0-gadd9e15e475d
References: <20250824-mdb-max7360-support-v14-0-435cfda2b1ea@bootlin.com>
 <20250824-mdb-max7360-support-v14-4-435cfda2b1ea@bootlin.com>
In-Reply-To: <20250824-mdb-max7360-support-v14-4-435cfda2b1ea@bootlin.com>
X-Last-TLS-Session-Version: TLSv1.3

On Sun Aug 24, 2025 at 1:57 PM CEST, Mathieu Dubois-Briand wrote:
> From: Kamel Bouhara <kamel.bouhara@bootlin.com>
>
> Add driver for Maxim Integrated MAX7360 PWM controller, supporting up to
> 8 independent PWM outputs.
>
> Signed-off-by: Kamel Bouhara <kamel.bouhara@bootlin.com>
> Co-developed-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com=
>
> Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/pwm/Kconfig       |  10 +++
>  drivers/pwm/Makefile      |   1 +
>  drivers/pwm/pwm-max7360.c | 209 ++++++++++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 220 insertions(+)
>
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index f00ce973dddf..f2b1ce47de7f 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -432,6 +432,16 @@ config PWM_LPSS_PLATFORM
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm-lpss-platform.
> =20
> +config PWM_MAX7360
> +	tristate "MAX7360 PWMs"
> +	depends on MFD_MAX7360
> +	help
> +	  PWM driver for Maxim Integrated MAX7360 multifunction device, with
> +	  support for up to 8 PWM outputs.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called pwm-max7360.
> +
>  config PWM_MC33XS2410
>  	tristate "MC33XS2410 PWM support"
>  	depends on OF
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index ff4f47e5fb7a..dfa8b4966ee1 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -38,6 +38,7 @@ obj-$(CONFIG_PWM_LPC32XX)	+=3D pwm-lpc32xx.o
>  obj-$(CONFIG_PWM_LPSS)		+=3D pwm-lpss.o
>  obj-$(CONFIG_PWM_LPSS_PCI)	+=3D pwm-lpss-pci.o
>  obj-$(CONFIG_PWM_LPSS_PLATFORM)	+=3D pwm-lpss-platform.o
> +obj-$(CONFIG_PWM_MAX7360)	+=3D pwm-max7360.o
>  obj-$(CONFIG_PWM_MC33XS2410)	+=3D pwm-mc33xs2410.o
>  obj-$(CONFIG_PWM_MEDIATEK)	+=3D pwm-mediatek.o
>  obj-$(CONFIG_PWM_MESON)		+=3D pwm-meson.o
> diff --git a/drivers/pwm/pwm-max7360.c b/drivers/pwm/pwm-max7360.c
> new file mode 100644
> index 000000000000..ebf93a7aee5b
> --- /dev/null
> +++ b/drivers/pwm/pwm-max7360.c
> @@ -0,0 +1,209 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright 2025 Bootlin
> + *
> + * Author: Kamel BOUHARA <kamel.bouhara@bootlin.com>
> + * Author: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
> + *
> + * PWM functionality of the MAX7360 multi-function device.
> + * https://www.analog.com/media/en/technical-documentation/data-sheets/M=
AX7360.pdf
> + *
> + * Limitations:
> + * - Only supports normal polarity.
> + * - The period is fixed to 2 ms.
> + * - Only the duty cycle can be changed, new values are applied at the b=
eginning
> + *   of the next cycle.
> + * - When disabled, the output is put in Hi-Z immediately.
> + */
> +#include <linux/bits.h>
> +#include <linux/dev_printk.h>
> +#include <linux/err.h>
> +#include <linux/math64.h>
> +#include <linux/mfd/max7360.h>
> +#include <linux/minmax.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/pwm.h>
> +#include <linux/regmap.h>
> +#include <linux/time.h>
> +#include <linux/types.h>
> +
> +#define MAX7360_NUM_PWMS			8
> +#define MAX7360_PWM_MAX				255
> +#define MAX7360_PWM_STEPS			256
> +#define MAX7360_PWM_PERIOD_NS			(2 * NSEC_PER_MSEC)
> +
> +struct max7360_pwm_waveform {
> +	u8 duty_steps;
> +	bool enabled;
> +};
> +
> +static int max7360_pwm_request(struct pwm_chip *chip, struct pwm_device =
*pwm)
> +{
> +	struct regmap *regmap =3D pwmchip_get_drvdata(chip);
> +
> +	/*
> +	 * Make sure we use the individual PWM configuration register and not
> +	 * the global one.
> +	 * We never need to use the global one, so there is no need to revert
> +	 * that in the .free() callback.
> +	 */
> +	return regmap_write_bits(regmap, MAX7360_REG_PWMCFG(pwm->hwpwm),
> +				 MAX7360_PORT_CFG_COMMON_PWM, 0);
> +}
> +
> +static int max7360_pwm_round_waveform_tohw(struct pwm_chip *chip,
> +					   struct pwm_device *pwm,
> +					   const struct pwm_waveform *wf,
> +					   void *_wfhw)
> +{
> +	struct max7360_pwm_waveform *wfhw =3D _wfhw;
> +	u64 duty_steps;
> +
> +	/*
> +	 * Ignore user provided values for period_length_ns and duty_offset_ns:
> +	 * we only support fixed period of MAX7360_PWM_PERIOD_NS and offset of =
0.
> +	 * Values from 0 to 254 as duty_steps will provide duty cycles of 0/256
> +	 * to 254/256, while value 255 will provide a duty cycle of 100%.
> +	 */
> +	if (wf->duty_length_ns >=3D MAX7360_PWM_PERIOD_NS) {
> +		duty_steps =3D MAX7360_PWM_MAX;
> +	} else {
> +		duty_steps =3D (u32)wf->duty_length_ns * MAX7360_PWM_STEPS / MAX7360_P=
WM_PERIOD_NS;
> +		if (duty_steps =3D=3D MAX7360_PWM_MAX)
> +			duty_steps =3D MAX7360_PWM_MAX - 1;
> +	}
> +
> +	wfhw->duty_steps =3D min(MAX7360_PWM_MAX, duty_steps);
> +	wfhw->enabled =3D !!wf->period_length_ns;
> +
> +	if (wf->period_length_ns && wf->period_length_ns < MAX7360_PWM_PERIOD_N=
S)
> +		return 1;
> +	else
> +		return 0;
> +}
> +
> +static int max7360_pwm_round_waveform_fromhw(struct pwm_chip *chip, stru=
ct pwm_device *pwm,
> +					     const void *_wfhw, struct pwm_waveform *wf)
> +{
> +	const struct max7360_pwm_waveform *wfhw =3D _wfhw;
> +
> +	wf->period_length_ns =3D wfhw->enabled ? MAX7360_PWM_PERIOD_NS : 0;
> +	wf->duty_offset_ns =3D 0;
> +
> +	if (wfhw->enabled) {
> +		if (wfhw->duty_steps =3D=3D MAX7360_PWM_MAX)
> +			wf->duty_length_ns =3D MAX7360_PWM_PERIOD_NS;
> +		else
> +			wf->duty_length_ns =3D DIV_ROUND_UP(wfhw->duty_steps * MAX7360_PWM_PE=
RIOD_NS,
> +							  MAX7360_PWM_STEPS);
> +	} else {
> +		wf->duty_length_ns =3D 0;
> +	}
> +
> +	return 0;
> +}
> +
> +static int max7360_pwm_write_waveform(struct pwm_chip *chip,
> +				      struct pwm_device *pwm,
> +				      const void *_wfhw)
> +{
> +	struct regmap *regmap =3D pwmchip_get_drvdata(chip);
> +	const struct max7360_pwm_waveform *wfhw =3D _wfhw;
> +	unsigned int val;
> +	int ret;
> +
> +	if (wfhw->enabled) {
> +		ret =3D regmap_write(regmap, MAX7360_REG_PWM(pwm->hwpwm), wfhw->duty_s=
teps);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	val =3D wfhw->enabled ? BIT(pwm->hwpwm) : 0;
> +	return regmap_write_bits(regmap, MAX7360_REG_GPIOCTRL, BIT(pwm->hwpwm),=
 val);
> +}
> +
> +static int max7360_pwm_read_waveform(struct pwm_chip *chip,
> +				     struct pwm_device *pwm,
> +				     void *_wfhw)
> +{
> +	struct regmap *regmap =3D pwmchip_get_drvdata(chip);
> +	struct max7360_pwm_waveform *wfhw =3D _wfhw;
> +	unsigned int val;
> +	int ret;
> +
> +	ret =3D regmap_read(regmap, MAX7360_REG_GPIOCTRL, &val);
> +	if (ret)
> +		return ret;
> +
> +	if (val & BIT(pwm->hwpwm)) {
> +		wfhw->enabled =3D true;
> +		ret =3D regmap_read(regmap, MAX7360_REG_PWM(pwm->hwpwm), &val);
> +		if (ret)
> +			return ret;
> +
> +		wfhw->duty_steps =3D val;
> +	} else {
> +		wfhw->enabled =3D false;
> +		wfhw->duty_steps =3D 0;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct pwm_ops max7360_pwm_ops =3D {
> +	.request =3D max7360_pwm_request,
> +	.round_waveform_tohw =3D max7360_pwm_round_waveform_tohw,
> +	.round_waveform_fromhw =3D max7360_pwm_round_waveform_fromhw,
> +	.read_waveform =3D max7360_pwm_read_waveform,
> +	.write_waveform =3D max7360_pwm_write_waveform,
> +};
> +
> +static int max7360_pwm_probe(struct platform_device *pdev)
> +{
> +	struct device *dev =3D &pdev->dev;
> +	struct pwm_chip *chip;
> +	struct regmap *regmap;
> +	int ret;
> +
> +	regmap =3D dev_get_regmap(dev->parent, NULL);
> +	if (!regmap)
> +		return dev_err_probe(dev, -ENODEV, "Could not get parent regmap\n");
> +
> +	/*
> +	 * This MFD sub-device does not have any associated device tree node:
> +	 * properties are stored in the device node of the parent (MFD) device
> +	 * and this same node is used in phandles of client devices.
> +	 * Reuse this device tree node here, as otherwise the PWM subsystem
> +	 * would be confused by this topology.
> +	 */
> +	device_set_of_node_from_dev(dev, dev->parent);
> +
> +	chip =3D devm_pwmchip_alloc(dev, MAX7360_NUM_PWMS, 0);
> +	if (IS_ERR(chip))
> +		return PTR_ERR(chip);
> +	chip->ops =3D &max7360_pwm_ops;
> +
> +	pwmchip_set_drvdata(chip, regmap);
> +
> +	ret =3D devm_pwmchip_add(dev, chip);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to add PWM chip\n");
> +
> +	return 0;
> +}
> +
> +static struct platform_driver max7360_pwm_driver =3D {
> +	.driver =3D {
> +		.name =3D "max7360-pwm",
> +		.probe_type =3D PROBE_PREFER_ASYNCHRONOUS,
> +	},
> +	.probe =3D max7360_pwm_probe,
> +};
> +module_platform_driver(max7360_pwm_driver);
> +
> +MODULE_DESCRIPTION("MAX7360 PWM driver");
> +MODULE_AUTHOR("Kamel BOUHARA <kamel.bouhara@bootlin.com>");
> +MODULE_AUTHOR("Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>=
");
> +MODULE_LICENSE("GPL");


Hi Uwe,

Any thought about this new version? I believe I fixed all the points we
have been discussing previously.

Thanks,
Mathieu

--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


