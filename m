Return-Path: <linux-pwm+bounces-5178-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15244A60325
	for <lists+linux-pwm@lfdr.de>; Thu, 13 Mar 2025 22:03:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F568173E4D
	for <lists+linux-pwm@lfdr.de>; Thu, 13 Mar 2025 21:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DCC51F4717;
	Thu, 13 Mar 2025 21:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aJ9RsEmp"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F252945948;
	Thu, 13 Mar 2025 21:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741899813; cv=none; b=ZtFPev2252PkrKyXLfLNNja9XsBGOe+bINklevPHwlLQ4A9X+0SwVsRL+T68vNnX8KKuFKgKvfeHhezYSIpijjm6OGfHUgzwANhU/87+bSaJ7wbiyaPc+1QBlRexFFElyxcYDVTjaTmuHothTmIqMTAg1mXOk0YUCMVTN1ETveA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741899813; c=relaxed/simple;
	bh=FMKfqv6jRr1fYhjht5XVCh7cRsPq1e2AMVhPlkaHSLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d1/1XZAjGFJr5aP+pF3n3P9FEarp3VntsLpaof2vxiIPTm7eJ3kQwNJgPS4nrdRr/DVDoJgTGWRVdzbOvVBed4+XMSWhb8L48VmkNPb2o7bO4GLaYCxnfxkLdbSro7yQdHOSxFVkdYJZHXM1eS+wwtcaHRm6/oaT+ylq6SLklqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aJ9RsEmp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4E80C4CEDD;
	Thu, 13 Mar 2025 21:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741899810;
	bh=FMKfqv6jRr1fYhjht5XVCh7cRsPq1e2AMVhPlkaHSLM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aJ9RsEmp+F4rW4SSK+hS9s9FtOwkooxWCR8/i4oRD7XqDdTV0RMispdtOSNpRDrAw
	 30FKwvR4bAQagYjbkE8n04WPJszMweTJDQabrL4rZbGS4JK2t0aWKaB+gVk8rF6hBR
	 DPQvCGH5LdU7uw//IqdBYwab9jv3aL/OWv90NDuLqwQY8ufoyhcmv2MekOL0Fl1jCo
	 o1PqB+6AWO5KvH/YJfkMjyaayUcAEBqZ0tmdEFxS0IzI3mAY5s7N8yVYvggmSX+eb1
	 u7gZID03OU4jF+lQLJf0aaI/OrKCk/iOjIZ0/pdW/CZC9LlcUdKGg8slxlvhc655m3
	 1h8Je48uMSPCQ==
Date: Thu, 13 Mar 2025 22:03:27 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: mathieu.dubois-briand@bootlin.com, 
	Linus Walleij <linus.walleij@linaro.org>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Kamel Bouhara <kamel.bouhara@bootlin.com>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Michael Walle <mwalle@kernel.org>, 
	Mark Brown <broonie@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-pwm@vger.kernel.org, andriy.shevchenko@intel.com, 
	=?utf-8?Q?Gr=C3=A9gory?= Clement <gregory.clement@bootlin.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v4 03/10] pwm: max7360: Add MAX7360 PWM support
Message-ID: <e7epeegrp6cz27s63gnqe7b6me7h3rn5d6mo7mbd6rwgnwyys6@j7f6cy4uy3wq>
References: <20250214-mdb-max7360-support-v4-0-8a35c6dbb966@bootlin.com>
 <20250214-mdb-max7360-support-v4-3-8a35c6dbb966@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rbw3oslor4q675uu"
Content-Disposition: inline
In-Reply-To: <20250214-mdb-max7360-support-v4-3-8a35c6dbb966@bootlin.com>


--rbw3oslor4q675uu
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v4 03/10] pwm: max7360: Add MAX7360 PWM support
MIME-Version: 1.0

Hello Mathieu,

On Fri, Feb 14, 2025 at 12:49:53PM +0100, mathieu.dubois-briand@bootlin.com wrote:
> diff --git a/drivers/pwm/pwm-max7360.c b/drivers/pwm/pwm-max7360.c
> new file mode 100644
> index 000000000000..f1257c20add2
> --- /dev/null
> +++ b/drivers/pwm/pwm-max7360.c
> @@ -0,0 +1,213 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright 2024 Bootlin
> + *
> + * Author: Kamel BOUHARA <kamel.bouhara@bootlin.com>
> + * Author: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
> + *
> + * Limitations:
> + * - Only supports normal polarity.
> + * - The period is fixed to 2 ms.
> + * - Only the duty cycle can be changed, new values are applied at the beginning
> + *   of the next cycle.
> + * - When disabled, the output is put in Hi-Z.
> + */
> +#include <linux/err.h>
> +#include <linux/math.h>
> +#include <linux/mfd/max7360.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/pwm.h>
> +#include <linux/regmap.h>
> +
> +#define MAX7360_NUM_PWMS			8
> +#define MAX7360_PWM_MAX_RES			255
> +#define MAX7360_PWM_PERIOD_NS			2000000 /* 500 Hz */
> +#define MAX7360_PWM_COMMON_PWN			BIT(5)
> +#define MAX7360_PWM_CTRL_ENABLE(n)		BIT(n)
> +#define MAX7360_PWM_PORT(n)			BIT(n)
> +
> +struct max7360_pwm {
> +	struct device *parent;
> +	struct regmap *regmap;
> +};
> +
> +struct max7360_pwm_waveform {
> +	u8 duty_steps;
> +};
> +
> +static inline struct max7360_pwm *max7360_pwm_from_chip(struct pwm_chip *chip)
> +{
> +	return pwmchip_get_drvdata(chip);
> +}
> +
> +static int max7360_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
> +{
> +	struct max7360_pwm *max7360_pwm;
> +	int ret;
> +
> +	max7360_pwm = max7360_pwm_from_chip(chip);
> +	ret = max7360_port_pin_request(max7360_pwm->parent, pwm->hwpwm, true);
> +	if (ret) {
> +		dev_warn(&chip->dev, "failed to request pwm-%d\n", pwm->hwpwm);

Please drop this warning, just returning ret here is fine. (The rule of
thumb is: Emit runtime messages only in probe, not during usage.)

> +		return ret;
> +	}
> +
> +	ret = regmap_write_bits(max7360_pwm->regmap,
> +				MAX7360_REG_PWMCFG(pwm->hwpwm),
> +				MAX7360_PWM_COMMON_PWN,
> +				0);
> +	if (ret)
> +		return ret;
> +
> +	return regmap_write_bits(max7360_pwm->regmap, MAX7360_REG_PORTS,
> +				 MAX7360_PWM_PORT(pwm->hwpwm),
> +				 MAX7360_PWM_PORT(pwm->hwpwm));
> +}
> +
> +static void max7360_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
> +{
> +	struct max7360_pwm *max7360_pwm;
> +
> +	max7360_pwm = max7360_pwm_from_chip(chip);
> +	max7360_port_pin_request(max7360_pwm->parent, pwm->hwpwm, false);

Would be nice if pinmuxing would be abstracted as a pinctrl driver. Not
sure how much effort that is. Maybe Linus has an idea?

> +}
> +
> [...]
> +
> +static int max7360_pwm_write_waveform(struct pwm_chip *chip,
> +				      struct pwm_device *pwm,
> +				      const void *_wfhw)
> +{
> +	const struct max7360_pwm_waveform *wfhw = _wfhw;
> +	struct max7360_pwm *max7360_pwm;
> +	unsigned int val;
> +	int ret;
> +
> +	max7360_pwm = max7360_pwm_from_chip(chip);
> +
> +	val = (wfhw->duty_steps == 0) ? 0 : MAX7360_PWM_CTRL_ENABLE(pwm->hwpwm);

Does not setting MAX7360_PWM_CTRL_ENABLE result in the pin going to
Hi-Z? If yes: That's wrong. You're only supposed to do that if
period_length_ns = 0 was requested. If no: This needs a comment why
duty_steps = 0 is special here.

> +	ret = regmap_write_bits(max7360_pwm->regmap, MAX7360_REG_GPIOCTRL,
> +				MAX7360_PWM_CTRL_ENABLE(pwm->hwpwm), val);
> +
> +	if (!ret && wfhw->duty_steps != 0) {
> +		ret = regmap_write(max7360_pwm->regmap, MAX7360_REG_PWM(pwm->hwpwm),
> +				   wfhw->duty_steps);
> +	}
> +
> +	return ret;
> +}
> +
> +static int max7360_pwm_read_waveform(struct pwm_chip *chip,
> +				     struct pwm_device *pwm,
> +				     void *_wfhw)
> +{
> +	struct max7360_pwm_waveform *wfhw = _wfhw;
> +	struct max7360_pwm *max7360_pwm;
> +	unsigned int val;
> +	int ret;
> +
> +	max7360_pwm = max7360_pwm_from_chip(chip);
> +
> +	ret = regmap_read(max7360_pwm->regmap, MAX7360_REG_GPIOCTRL, &val);
> +	if (ret)
> +		return ret;
> +
> +	if (val & MAX7360_PWM_CTRL_ENABLE(pwm->hwpwm)) {
> +		ret = regmap_read(max7360_pwm->regmap, MAX7360_REG_PWM(pwm->hwpwm),
> +				  &val);
> +		val = wfhw->duty_steps;

wfhw->duty_steps = val;

> +	} else {
> +		wfhw->duty_steps = 0;
> +	}
> +
> +	return ret;
> +}

Best regards
Uwe

--rbw3oslor4q675uu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmfTSBwACgkQj4D7WH0S
/k6Q6gf/XjsQoHf9RBzxgyUlezFotMDPpH1zwZOGLGbyQ1EN58ltZOo2a44SokYF
R7TtXX47mBqKHhdlCgShc8153LM8sBwcDS+9HqaaHS/rR+5URMszklQSdAIh+nqW
bZHXKmLGWNrHvdLZlb0NFK+fKNs+AJmABFVrYH0dLXRc5OPlD4/GrrtGFXbkPjha
1KWUVnceG6eZn+WsgYRN8ki+Gv4AwpxyvCovuKHpur3e2dXpF0rXBeMKRLSDX2Ox
Hi6YnfKxukcqf6JRljStl29d1xOBrMy6FZpcMEYBnMCAM9pVYLFFo+Wbnki2qt1O
890RD9gfXgLYaeC7AlejZxp1dkkarg==
=NVYJ
-----END PGP SIGNATURE-----

--rbw3oslor4q675uu--

