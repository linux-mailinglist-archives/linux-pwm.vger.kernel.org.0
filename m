Return-Path: <linux-pwm+bounces-2973-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DF2A949692
	for <lists+linux-pwm@lfdr.de>; Tue,  6 Aug 2024 19:19:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A2421F26FEC
	for <lists+linux-pwm@lfdr.de>; Tue,  6 Aug 2024 17:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C30E52F70;
	Tue,  6 Aug 2024 17:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="VMCq0vmm"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B12482E2
	for <linux-pwm@vger.kernel.org>; Tue,  6 Aug 2024 17:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722964776; cv=none; b=HjXPGnoF2o+k3ci8LN6uP2W55T/R0sm0PkG2h4OUdk1xW5WNljL1vwSsQa+CYCieXtBtbPg76XZBhbZDcQmAu73spC4lEg7bfKx4PEXTFpE4LqwzC2kUCzRKp/z7R4ISIILaGnHz7LHD7p/zQ649qQgM6nfnrU3GY35slX7SpTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722964776; c=relaxed/simple;
	bh=n0EbpY+AuK++gHUExLxK5CB8Hdlh0Fpyi6gDtcvmJZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LKpIQzsgGHnyaJygbzFWzk4b+xRrwbxmqO0kljrON6wgA9FDpcPwwBKIlzSjNGAvsSrzCZ2lHx57/pkGMKeQw1LTgQbFbXGcbnUJmchNIW3U3lwOAXB/IfB96p9zEnKUax1pjII/D++7Rg3LIo1oUKMhtAZDtUN4M6YpsFFm8Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=VMCq0vmm; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5b9d48d1456so101404a12.1
        for <linux-pwm@vger.kernel.org>; Tue, 06 Aug 2024 10:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1722964770; x=1723569570; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/6OEOUBwem7fyjbJCOBAKLPUV4TtLzCihhhkYx5oH3A=;
        b=VMCq0vmmKpmdKxGedrEsEMTIFD/CgkV81+p3Nl8+b81KpxLlJkR4RxkfHrxNdkE+iR
         Hnh5pRbej2YLEAI3laUwab21JO8AyVQ0ZHj9kzwMfknqI9QqoncuPlZDbKYLPCv6tZvu
         LC+ZP4h8b8G4K2xaGE4f5XwPdkooDRHnzLXo4TxbHIWu0MnHuho735AhILfnp2GpQKh7
         6m1npOmVsoTwGzGsb5Oue8nRLVUBFENax+Yjq4sZ8nYIlan2wua0LB4eUViYGfT+hH1X
         3SV0VytaRc4GjE/LI0ww6DnymLBH5W3eIHysvJjVG4wjx4Le8C44BakPXcxpGm2dgOug
         zn/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722964770; x=1723569570;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/6OEOUBwem7fyjbJCOBAKLPUV4TtLzCihhhkYx5oH3A=;
        b=ZPaf3msHqHiD4iavYzDCz+MV8dDU8yIsrVK9m5t2uQaLNdct9HiLeKjfGgOUzUhh7A
         8o+qylt/X7/vYaLazK7MwLeqtoza1DOR/kqn6Ykmon8XdjGtCsBkzve3RQ7EAbrIcSFs
         6UGNaRGpoJvhAG3YZojbIJ7s5UQ+B8XdICnpTgayB7W0L7Ly7iFHE+v1uhVJwetdJqy0
         RAxADpWGxFTHZv7oEkpHgAVuhEwSKjutIQyMqcPK1avIyc63248rS1/eqWa5RZTdiVdS
         m5sMYTB56+GzsjM/TMu2rvB2G6Y7VCzQnbQH2NpBmgzD1ule3sr4o1j4xdNZRzNUanFm
         HJug==
X-Forwarded-Encrypted: i=1; AJvYcCVc+lXkAgX2Mj8pzeG1ck17B34/0jQa/EBUqd7R0aERhTwFYUT3i71I3mgXitl0035gKq55eEASw06eskgWurGUBCncwwqzgPKU
X-Gm-Message-State: AOJu0YxpzdICTpe+O0QdJUB68Om+myQQl0v1HbdtOWchUGacLEIWM/fK
	nXsvtMJv9s1uQ0deKFOyeIosjw1ykFPMzu7LM3PfVcVfCZr5ILpPTSOFDw+CCzg=
X-Google-Smtp-Source: AGHT+IGGmt68Tn4u8F9UWhYajwx7R+rtC249mqk8uFR78UzEbd7KLtC8bdOm/uEkOobMENBdjcM78g==
X-Received: by 2002:a05:6402:5253:b0:57d:455:d395 with SMTP id 4fb4d7f45d1cf-5b77c28ed64mr15224495a12.7.1722964769739;
        Tue, 06 Aug 2024 10:19:29 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:737d:4823:35a2:b40a])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5b839716279sm6124082a12.12.2024.08.06.10.19.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 10:19:29 -0700 (PDT)
Date: Tue, 6 Aug 2024 19:19:26 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: William Qiu <william.qiu@starfivetech.com>
Cc: linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, 
	Hal Feng <hal.feng@starfivetech.com>, Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH v13] pwm: opencores: Add PWM driver support
Message-ID: <hyzutti2cwarxqx32frw5ytui3xib5tus3hb2loekq6s4s3442@wit2usgcci6v>
References: <20240702083848.1947449-1-william.qiu@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fvrt3gxgqdw6zdk5"
Content-Disposition: inline
In-Reply-To: <20240702083848.1947449-1-william.qiu@starfivetech.com>


--fvrt3gxgqdw6zdk5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello William,

On Tue, Jul 02, 2024 at 04:38:48PM +0800, William Qiu wrote:
> Add driver for OpenCores PWM Controller. And add compatibility code
> which based on StarFive SoC.
>=20
> Co-developed-by: Hal Feng <hal.feng@starfivetech.com>
> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> Signed-off-by: William Qiu <william.qiu@starfivetech.com>
> ---
>  MAINTAINERS              |   7 ++
>  drivers/pwm/Kconfig      |  12 ++
>  drivers/pwm/Makefile     |   1 +
>  drivers/pwm/pwm-ocores.c | 239 +++++++++++++++++++++++++++++++++++++++
>  4 files changed, 259 insertions(+)
>  create mode 100644 drivers/pwm/pwm-ocores.c
> [...]
> diff --git a/drivers/pwm/pwm-ocores.c b/drivers/pwm/pwm-ocores.c
> new file mode 100644
> index 000000000000..c8f08aa14e44
> --- /dev/null
> +++ b/drivers/pwm/pwm-ocores.c
> @@ -0,0 +1,239 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * OpenCores PWM Driver
> + *
> + * https://opencores.org/projects/ptc
> + *
> + * Copyright (C) 2018-2023 StarFive Technology Co., Ltd.
> + *
> + * Limitations:
> + * - The hardware only supports inverted polarity.
> + * - The hardware minimum period / duty_cycle is (1 / pwm_apb clock freq=
uency) ns.
> + * - The hardware maximum period / duty_cycle is (U32_MAX / pwm_apb cloc=
k frequency) ns.

Nitpick: s/ ns//

> + * - The hardware is set to a low level immediately when disabledThe har=
dware is set to
> + *   a low level immediately when disabled.

This sentence is duplicated somehow. Maybe also: s/hardware/output/ ?

> + * - The hardware will have a conversion cycle when reconfiguring.

I don't understand that.

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
> +#define REG_OCPWM_CNTR_EN      BIT(0)
> +#define REG_OCPWM_CNTR_ECLK    BIT(1)
> +#define REG_OCPWM_CNTR_NEC     BIT(2)
> +#define REG_OCPWM_CNTR_OE      BIT(3)
> +#define REG_OCPWM_CNTR_SIGNLE  BIT(4)
> +#define REG_OCPWM_CNTR_INTE    BIT(5)
> +#define REG_OCPWM_CNTR_INT     BIT(6)
> +#define REG_OCPWM_CNTR_RST     BIT(7)
> +#define REG_OCPWM_CNTR_CAPTE   BIT(8)
> +
> +struct ocores_pwm_device {
> +	const struct ocores_pwm_data *data;

I admit I didn't try to compile this, but I wonder if this doesn't
result in a compiler warning given that struct ocores_pwm_data is only
defined below.

> +	void __iomem *regs;
> +	u32 clk_rate; /* PWM APB clock frequency */
> +};
> +
> +struct ocores_pwm_data {
> +	void __iomem *(*get_ch_base)(void __iomem *base, unsigned int channel);
> +};
> [...]
> +static int ocores_pwm_apply(struct pwm_chip *chip,
> +			    struct pwm_device *pwm,
> +			    const struct pwm_state *state)
> +{
> +	struct ocores_pwm_device *ddata =3D chip_to_ocores(chip);
> +	u32 ctrl_data =3D 0;
> +	u64 period_data, duty_data;
> +
> +	if (state->polarity !=3D PWM_POLARITY_INVERSED)
> +		return -EINVAL;
> +
> +	period_data =3D mul_u64_u32_div(state->period, ddata->clk_rate, NSEC_PE=
R_SEC);
> +	if (!period_data)
> +		return -EINVAL;
> +
> +	if (period_data > U32_MAX)
> +		period_data =3D U32_MAX;
> +
> +	ocores_pwm_writel(ddata, pwm->hwpwm, 0x8, (u32)period_data);

s/0x8/REG_OCPWM_LRC/ ?

That cast can be dropped.

> +	duty_data =3D mul_u64_u32_div(state->duty_cycle, ddata->clk_rate, NSEC_=
PER_SEC);
> +	if (duty_data <=3D U32_MAX)
> +		ocores_pwm_writel(ddata, pwm->hwpwm, REG_OCPWM_HRC, (u32)duty_data);
> +	else if (duty_data > U32_MAX)
> +		duty_data =3D U32_MAX;
> +	else
> +		return -EINVAL;

That looks wrong. If duty_data > U32_MAX you assign duty_data but don't
reuse this variable later.

> +
> +	ctrl_data =3D ocores_pwm_readl(ddata, pwm->hwpwm, REG_OCPWM_CTRL);
> +	if (state->enabled)
> +		ocores_pwm_writel(ddata, pwm->hwpwm, REG_OCPWM_CTRL,
> +				  ctrl_data | REG_OCPWM_CNTR_EN | REG_OCPWM_CNTR_OE);
> +	else
> +		ocores_pwm_writel(ddata, pwm->hwpwm, REG_OCPWM_CTRL,
> +				  ctrl_data & ~(REG_OCPWM_CNTR_EN | REG_OCPWM_CNTR_OE));
> +
> +	return 0;
> +}
> [...]
> +static int ocores_pwm_probe(struct platform_device *pdev)
> +{
> +	const struct of_device_id *id;
> +	struct device *dev =3D &pdev->dev;
> +	struct ocores_pwm_device *ddata;
> +	struct pwm_chip *chip;
> +	struct clk *clk;
> +	struct reset_control *rst;
> +	int ret;
> +
> +	id =3D of_match_device(ocores_pwm_of_match, dev);
> +	if (!id)
> +		return -EINVAL;
> +
> +	chip =3D devm_pwmchip_alloc(&pdev->dev, 8, sizeof(*ddata));
> +	if (IS_ERR(chip))
> +		return -ENOMEM;
> +
> +	ddata =3D chip_to_ocores(chip);
> +	ddata->data =3D id->data;
> +	chip->ops =3D &ocores_pwm_ops;
> +
> +	ddata->regs =3D devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(ddata->regs))
> +		return dev_err_probe(dev, PTR_ERR(ddata->regs),
> +				     "Unable to map IO resources\n");
> +
> +	clk =3D devm_clk_get_enabled(dev, NULL);
> +	if (IS_ERR(clk))
> +		return dev_err_probe(dev, PTR_ERR(clk),
> +				     "Unable to get pwm's clock\n");
> +
> +	ret =3D devm_clk_rate_exclusive_get(dev, clk);
> +	if (ret)
> +		return ret;
> +
> +	rst =3D devm_reset_control_get_optional_exclusive(dev, NULL);
> +	if (IS_ERR(rst))
> +		return dev_err_probe(dev, PTR_ERR(rst),
> +				     "Unable to get pwm's reset\n");
> +
> +	reset_control_deassert(rst);

I think you want to check the return value of reset_control_deassert().

> +	ret =3D devm_add_action_or_reset(dev, ocores_pwm_reset_control_assert, =
rst);
> +	if (ret)
> +		return ret;
> +
> +	ddata->clk_rate =3D clk_get_rate(clk);
> +	if (ddata->clk_rate > NSEC_PER_SEC)
> +		return dev_err_probe(dev, ddata->clk_rate,
> +				     "Unable to get clock's rate\n");

Best regards
Uwe

--fvrt3gxgqdw6zdk5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmayWxwACgkQj4D7WH0S
/k6U9Af7Bc7JmOmAXQQgy0gjd6g163S8ejRAZOxzxnX6ZQGVFc+Q9rrs93AGuqYs
732BXq37ckqX70PK3CXXI9Ws2KlaoDn3gB3cvtEMOcxs3JO5V+MYblcLxwRduYc/
69mFM/tqpTymb/rLKglWLnQNA98Q7nCYTHdpa/LipwjK3b/KukKqZLO5d/j+QXup
z8Y6XebcnmJZensDmqbig37BOuvUK2Jztorh6cPuEgxoECoPJ8elxDIDLluTjZtp
iiKbj/Sbja3BFUnGbOzijoJ0RhVcdIfEmaVVYXBsiLBOgVkEy0srR4mPWwy/8rMb
TCr+AbGp2iYRTsm4snQkYPGmTxz9aA==
=0PFS
-----END PGP SIGNATURE-----

--fvrt3gxgqdw6zdk5--

