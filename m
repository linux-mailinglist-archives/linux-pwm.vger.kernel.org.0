Return-Path: <linux-pwm+bounces-2457-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4A7F908A28
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Jun 2024 12:37:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EA77285722
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Jun 2024 10:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA2FD1946A0;
	Fri, 14 Jun 2024 10:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="BLT4kW81"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7586148319
	for <linux-pwm@vger.kernel.org>; Fri, 14 Jun 2024 10:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718361452; cv=none; b=dWAl1C27Nv7RT2EPAEMmWVNjQ4wgbrQw3Ts+QRFxmAQ+uOc9F1MpWoqokZyyad1NF4boMOzFL09ASwNCk+5ZbGl4L7DVTZV/fkMlBYKK80reDhoknfdsvNpmCoy3TR1ytTf91YJBZpWtGopegzvN/Ek2yU9ScoBp+CbwqJ0nMGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718361452; c=relaxed/simple;
	bh=zmtM9P8EOqx1FZjRdKTb5n/z6vFq5gDORgSkGrxnYuk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uSSEGW4Q1kg9TKR+8SVPOahNqq/EKG7XfcRnOQCsn0RG+ADOrTGPwNtVdEyKDUUIYKczCGQShKvYsa/kPuM1DplsDohLNZoiZiZuCXwj8LTeEbErfW9gB30RcyTrlop8Lso8RMF08yoblykwY2910n3N34XZlqrj9r8bOjPPPoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=BLT4kW81; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-57c6011d75dso2351229a12.3
        for <linux-pwm@vger.kernel.org>; Fri, 14 Jun 2024 03:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718361447; x=1718966247; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0OriRI7xNCMkxlWs2IiRsExQGF8yht7ObcIi6rihikc=;
        b=BLT4kW811cw5ReF4z09DjJF9eWr+0mHyEfOhoX3ondfHVjhsyQQcNOX+sTNwwQP3Be
         MisNvEdYQgcXrghIIdRy0Ksez+JWulkIHfyRGjzLjSamFHaVXOzeKQFFjgz5XCj/Z9oM
         RdmZ9LBVzRN7IDaSPYMHQHJ/8clbfuFWVboXRBqzjjPUU3ww31I2CGc/DaT2PRcQ9N2L
         NJrCX2o4dpcgXMTpo9imzt/Tuz7eoRtwCvSxkjKhtmFj0ebWlkigpHGRxW7k04zkkvlc
         Iv5+GQkw7rXpIyUlpF7JslX5Hi6+bjcj5Uk6hKmGJUIjIuNxNL0x8pcVsbuvPvAOjwoK
         anDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718361447; x=1718966247;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0OriRI7xNCMkxlWs2IiRsExQGF8yht7ObcIi6rihikc=;
        b=iqdptv6aAim7hBD28QIfYGlObKZaW33SR3hMCcCgNkl5xRHuFVE4VRJsW029qeOvfI
         OLwFx0mZK5Or5x90ePyq/sYFVh9SPPAaHCjFJO54SVg6W9AhXx8i8eqjoA2k/af2y9QY
         8pbWmnlxx8nubEJ2ZJ1GwIaIchV/5jo+PdGSvCJCBXVzFXnXgHon5n4O+LAZe8oQiDo3
         BtX+qbDvof4oTesepWqgxFpA3gvuuSvcjHjp5Hc7tKEiIzJDb6v1jXCdm9kK2zENEST9
         Tpbu8nMyfQkFIKkUdTsDm5p50wrDDXGI28/Ybw7r+Xbcz3HQWm3CpJPXFwcar6ZUXx4K
         C/Bg==
X-Forwarded-Encrypted: i=1; AJvYcCVp4O5Y/h5SMZcDZ8qnwtDw0h9U2soMAF9NjFABM/ddE+FxKwbfwDodcvUex8NCra+YgAAaWYgo8VAdN/GY8r3SqWXAWdonKH1M
X-Gm-Message-State: AOJu0Yxkd1nZOklwQAJVkKdukdYLrxfZ6Xzwhsg5sAMu+Q2u7pAHAidD
	+IZ6NI5jZxzFHNoWaAO/mFeAVxxLjs9fd3RwENPMJxkx7IeqczVaBXTKBWpa3g0=
X-Google-Smtp-Source: AGHT+IGHSLoRi8jypxNAigXEWnfdZMZjy36n3Gkuce88q62zGrV4fmJpD9TsNdDubWdWIkt2IVlp3A==
X-Received: by 2002:a50:9ea9:0:b0:57a:2327:d2d2 with SMTP id 4fb4d7f45d1cf-57cbd6c6e54mr1653455a12.29.1718361446835;
        Fri, 14 Jun 2024 03:37:26 -0700 (PDT)
Received: from localhost (p509153eb.dip0.t-ipconnect.de. [80.145.83.235])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57cbb30ba30sm1564062a12.39.2024.06.14.03.37.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 03:37:26 -0700 (PDT)
Date: Fri, 14 Jun 2024 12:37:25 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: William Qiu <william.qiu@starfivetech.com>
Cc: linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, 
	Hal Feng <hal.feng@starfivetech.com>, Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH v12] pwm: opencores: Add PWM driver support
Message-ID: <6hbj4uua442il6koeaypkqapctlwrhrmsbguyx74hwqzkycepf@7zpqo6mojqvn>
References: <20240429075140.56867-1-william.qiu@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pz7cmbt7u7ur6jmg"
Content-Disposition: inline
In-Reply-To: <20240429075140.56867-1-william.qiu@starfivetech.com>


--pz7cmbt7u7ur6jmg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello William,

thanks for your patience and sorry for taking so long until I came
around to review this.

On Mon, Apr 29, 2024 at 03:51:40PM +0800, William Qiu wrote:
> diff --git a/drivers/pwm/pwm-ocores.c b/drivers/pwm/pwm-ocores.c
> new file mode 100644
> index 000000000000..039fb3c526a7
> --- /dev/null
> +++ b/drivers/pwm/pwm-ocores.c
> @@ -0,0 +1,240 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * OpenCores PWM Driver
> + *
> + * https://opencores.org/projects/ptc
> + *
> + * Copyright (C) 2018-2023 StarFive Technology Co., Ltd.
> + *
> + * Limitations:
> + * - The hardware only do inverted polarity.

s/do/does/

> + * - The hardware minimum period / duty_cycle is (1 / pwm_apb clock frequency) ns.
> + * - The hardware maximum period / duty_cycle is (U32_MAX / pwm_apb clock frequency) ns.

How does the hardware behave on disable? Does it complete the currently
running period when reconfiguring or disabling? Are glitches expected
in .apply()? Please answer these questions in the Limitations paragraph.

> + */
> +
> +#include <linux/clk.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/pwm.h>
> +#include <linux/reset.h>
> +#include <linux/slab.h>
> +
> +/* OpenCores Register offsets */
> +#define REG_OCPWM_CNTR    0x0
> +#define REG_OCPWM_HRC     0x4
> +#define REG_OCPWM_LRC     0x8
> +#define REG_OCPWM_CTRL    0xC
> +
> +/* OCPWM_CTRL register bits*/
> +#define REG_OCPWM_EN      BIT(0)

I would prefer this one to be called REG_OCPWM_CNTR_EN. Ditto for the
following definitions.

> +#define REG_OCPWM_ECLK    BIT(1)
> +#define REG_OCPWM_NEC     BIT(2)
> +#define REG_OCPWM_OE      BIT(3)
> +#define REG_OCPWM_SIGNLE  BIT(4)
> +#define REG_OCPWM_INTE    BIT(5)
> +#define REG_OCPWM_INT     BIT(6)
> +#define REG_OCPWM_CNTRRST BIT(7)
> +#define REG_OCPWM_CAPTE   BIT(8)
> +
> [...]
> +static int ocores_pwm_apply(struct pwm_chip *chip,
> +			    struct pwm_device *pwm,
> +			    const struct pwm_state *state)
> +{
> +	struct ocores_pwm_device *ddata = chip_to_ocores(chip);
> +	u32 ctrl_data = 0;
> +	u64 period_data, duty_data;
> +
> +	if (state->polarity != PWM_POLARITY_INVERSED)
> +		return -EINVAL;
> +
> +	ctrl_data = ocores_pwm_readl(ddata, pwm->hwpwm, REG_OCPWM_CTRL);
> +	ocores_pwm_writel(ddata, pwm->hwpwm, REG_OCPWM_CTRL, 0);
> +
> +	period_data = mul_u64_u32_div(state->period, ddata->clk_rate, NSEC_PER_SEC);
> +	if (period_data > U32_MAX)
> +		period_data = U32_MAX;

This assignment is useless, the value of period_data isn't used later,

I think you want:

	period_data = ...

	if (!period_data)
		return -EINVAL

	if (period_data > U32_MAX)
		period_data = U32_MAX;

	ocores_pwm_writel(ddata, pwm->hwpwm, 0x8, (u32)period_data);


> +	else if (period_data > 0)
> +		ocores_pwm_writel(ddata, pwm->hwpwm, 0x8, (u32)period_data);
> +	else
> +		return -EINVAL;
> +
> +	duty_data = mul_u64_u32_div(state->duty_cycle, ddata->clk_rate, NSEC_PER_SEC);
> +	if (duty_data <= U32_MAX)
> +		ocores_pwm_writel(ddata, pwm->hwpwm, REG_OCPWM_HRC, (u32)duty_data);
> +	else
> +		return -EINVAL;

duty_data > U32_MAX should be handled in the same way as period_data >
U32_MAX.

> +	ocores_pwm_writel(ddata, pwm->hwpwm, REG_OCPWM_CNTR, 0);
> +
> +	if (state->enabled) {
> +		ctrl_data = ocores_pwm_readl(ddata, pwm->hwpwm, REG_OCPWM_CTRL);
> +		ocores_pwm_writel(ddata, pwm->hwpwm, REG_OCPWM_CTRL,
> +				  ctrl_data | REG_OCPWM_EN | REG_OCPWM_OE);
> +	}

Wouldn't it make sense to unset REG_OCPWM_EN | REG_OCPWM_OE if
(!state->enabled)?

> +	return 0;
> +}
> +
> +static const struct pwm_ops ocores_pwm_ops = {
> +	.get_state	= ocores_pwm_get_state,
> +	.apply		= ocores_pwm_apply,

In other structs you're using a single space before =. I'd prefer that
here, too.

> +};
> +
> +static const struct ocores_pwm_data jh7100_pwm_data = {
> +	.get_ch_base = starfive_jh71x0_get_ch_base,
> +};
> +
> +static const struct ocores_pwm_data jh7110_pwm_data = {
> +	.get_ch_base = starfive_jh71x0_get_ch_base,
> +};

These two are identical. Does it make sense to use only one instance of
these?

> [...]
> +static int ocores_pwm_probe(struct platform_device *pdev)
> +{
> +	const struct of_device_id *id;
> +	struct device *dev = &pdev->dev;
> +	struct ocores_pwm_device *ddata;
> +	struct pwm_chip *chip;
> +	struct clk *clk;
> +	struct reset_control *rst;
> +	int ret;
> +
> +	id = of_match_device(ocores_pwm_of_match, dev);
> +	if (!id)
> +		return -EINVAL;
> +
> +	chip = devm_pwmchip_alloc(&pdev->dev, 8, sizeof(*ddata));
> +	if (IS_ERR(chip))
> +		return -ENOMEM;
> +
> +	ddata = chip_to_ocores(chip);
> +	ddata->data = id->data;
> +	chip->ops = &ocores_pwm_ops;
> +
> +	ddata->regs = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(ddata->regs))
> +		return dev_err_probe(dev, PTR_ERR(ddata->regs),
> +				     "Unable to map IO resources\n");
> +
> +	clk = devm_clk_get_enabled(dev, NULL);
> +	if (IS_ERR(clk))
> +		return dev_err_probe(dev, PTR_ERR(clk),
> +				     "Unable to get pwm's clock\n");
> +
> +	ret = devm_clk_rate_exclusive_get(dev, clk);
> +	if (ret)
> +		return ret;
> +
> +	rst = devm_reset_control_get_optional_exclusive(dev, NULL);
> +	if (IS_ERR(rst))
> +		return dev_err_probe(dev, PTR_ERR(rst),
> +				     "Unable to get pwm's reset\n");
> +
> +	reset_control_deassert(rst);
> +
> +	ret = devm_add_action_or_reset(dev, ocores_pwm_reset_control_assert, rst);
> +	if (ret)
> +		return ret;
> +
> +	ddata->clk_rate = clk_get_rate(clk);
> +	if (ddata->clk_rate <= 0 || ddata->clk_rate > NSEC_PER_SEC)

clk_rate is an u32. So ddata->clk_rate <= 0 will never be true. Also on
64bit archs clk_get_rate() might return 4294967297 which results in
ddata->clk_rate being assigned 1 and then passing this test.

> +		return dev_err_probe(dev, ddata->clk_rate,
> +				     "Unable to get clock's rate\n");
> +
> +	ret = devm_pwmchip_add(dev, chip);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "Could not register PWM chip\n");
> +
> +	return 0;
> +}

Best regards
Uwe

--pz7cmbt7u7ur6jmg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmZsHWAACgkQj4D7WH0S
/k6lKQf+NrcJlhAWZK2lB9x1qKMuEf//I36x7OJfXngdmSPtftOITcdOcDS7lTsA
IHIwvdbt6lLAVKAIfAH1jj5BMEXYj7JnqggU4HCaGVPFA8/60Tiviwf++x1KMmqS
wb/Z2gUunjqLkZH74ur/RlNb2wfkr/vE9UAjsMqXSimQvvcwiCpnthOld7/VPwG/
Ud+mvxizzs/rlXNDHR/wDB8tuTVLjzxGjpdhgOI0huSoA5EUT8HhrdMqcmzmwUHc
cvcDNIT9BaXRzlEIHvRrBVh8G1OigEOJChdA6Z+ncPf+L7U6sNMATjcReJiCta01
3pfQy2GISFd9JefXZGMjNkVHn/ti/A==
=TK0N
-----END PGP SIGNATURE-----

--pz7cmbt7u7ur6jmg--

