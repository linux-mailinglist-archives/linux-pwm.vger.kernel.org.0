Return-Path: <linux-pwm+bounces-3552-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3158D9961F2
	for <lists+linux-pwm@lfdr.de>; Wed,  9 Oct 2024 10:10:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4FB5287612
	for <lists+linux-pwm@lfdr.de>; Wed,  9 Oct 2024 08:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F87B184527;
	Wed,  9 Oct 2024 08:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="pTzDL30i"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BB8184528
	for <linux-pwm@vger.kernel.org>; Wed,  9 Oct 2024 08:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728461446; cv=none; b=TOPYKzqwXKrlW+KC3yaYb0TbupQHBa7H8Q6Rzopfwau4JU6YsAyFzFZD8EUTeZ032qdcI3OKu6igeRfMZPnN1l/EEMldtQfckI2o2Z0+Q963cZcA3LSN/NyA8oSQzuFRGMbUcXcvX1QohKEyu8HP3nh7b/rzBFBJxo1M9pmHzCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728461446; c=relaxed/simple;
	bh=JTALTDfpJwLvZW8krOmlWY7fXxiJm7mB5IXqDHxOnis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tjn5PvyG9WXDDPA5PpYNcns9+YndwJUbiUwiLgI1hLAQmGT2K20PnRShlzdk5kB/vT0aQn6sCx/iIsKMv4W+EndwfuHMfZ993IIr7iQ24lDm/d+BceHNmUyUv8JrGyrxW0Ubqcj766v9+ZBh664YsHReeQmFJC5IrDmxBe+l8S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=pTzDL30i; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-37cd8972738so4562098f8f.3
        for <linux-pwm@vger.kernel.org>; Wed, 09 Oct 2024 01:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728461442; x=1729066242; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gnWodi7I3io7lPP1RwAH8LUYr+WZNKZMf06zlJ4yNoo=;
        b=pTzDL30i4XA6nuvXQiuLfQ4ITZ7VNA1EUZQD5hibztUpgAdYS+nxkqJWq56uEGPKUm
         6z/wCAcIkGOtxT2zrc2G4xykj0aDHUKysz8zHE4CfY1525m3O8InNQVTkMiJdWhHVwIu
         AuaUCl7OMM+mnPCNX0UaHYYuCptFJlbCSJ/05Hj3s18QXj/wfqHsIaImwVxhXeczv7uL
         dbuiYddYgdiM9BXuNorXI2iXMA+qRey8hcpBxjKEaTMacbsz/66uFD9vH7ZYUaIuBTEM
         xceXARKzHL2u/p8mIDaKXT5spNjELZmjuo5uummUA6HOAIFP/Cfy+m20AV97YQB2k+rJ
         ZZSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728461442; x=1729066242;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gnWodi7I3io7lPP1RwAH8LUYr+WZNKZMf06zlJ4yNoo=;
        b=ooJ/qCYK9iAZn87oSuB7g1LzLhy60hLVEFUNQ7+aIhNKCJCrDAiIASJ0s6zNz6R7Dp
         BCs6oRg4swt+ZXEfWlZ71Hl+Z5OF+eat1pRuSSP2HxhlOAn0UT5k+NzlWJb5HbsImpn+
         wA/Pue8LINxEQORPIo0FAc5+BquYD8m/tVXRLLZX790+2cdAMY2KkL7YoxJFUnQqnKQx
         tdDFVCxFBpA8wv3CS2TWVZ8DOjb3P6WXu3l/6K3704G/Yumavh4e/0ZmbQ5d2iZ2WOxR
         dmqdlkZkgIOrSjWQpdviF69eXs05OjSNToDKTDkrU1jkN9O+Glbk3SSTsxxxi7PeGaL5
         cGlQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYLk0fMwpKgXOptxTOjwSJQrcvC//Qsgr12J+j2EBktl0XLXnJKsu0OgBilYI9dq/oITkktaoZerY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0TNfDFxib9EKS2m6XYtlUXAhej3hkpddutTavuhzqYTbKV9yc
	nCrL+wrbtuw9xIktFJ17BpXiFI0gN/7lpoaQnUXTFsCVNVRt2MlJ07M36l7NnpyKbDAwGBGJ0Sp
	5
X-Google-Smtp-Source: AGHT+IGh8K2dUO1w72QQsRRDwWg/X9XbAnFa43Fl/ahd72gRhImUWO/xzGJZhmEAsokUQYN6eBnxCg==
X-Received: by 2002:a5d:4e51:0:b0:37d:39e8:cb6d with SMTP id ffacd0b85a97d-37d3ab318acmr716234f8f.56.1728461442237;
        Wed, 09 Oct 2024 01:10:42 -0700 (PDT)
Received: from localhost (p509151f9.dip0.t-ipconnect.de. [80.145.81.249])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-430ccf1f776sm12305265e9.3.2024.10.09.01.10.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 01:10:41 -0700 (PDT)
Date: Wed, 9 Oct 2024 10:10:40 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: William Qiu <william.qiu@starfivetech.com>
Cc: linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, 
	Hal Feng <hal.feng@starfivetech.com>, Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH v15] pwm: opencores: Add PWM driver support
Message-ID: <na6yfg45w74l3deaoi5gr5wcefxbjslztsltm6737rs4cktpbn@myvsa6ye6xpp>
References: <20240914095114.31100-1-william.qiu@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5ft5dx5frm54rk25"
Content-Disposition: inline
In-Reply-To: <20240914095114.31100-1-william.qiu@starfivetech.com>


--5ft5dx5frm54rk25
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello William,

On Sat, Sep 14, 2024 at 05:51:14PM +0800, William Qiu wrote:
> diff --git a/drivers/pwm/pwm-ocores.c b/drivers/pwm/pwm-ocores.c
> new file mode 100644
> index 000000000000..d0161b9379d1
> --- /dev/null
> +++ b/drivers/pwm/pwm-ocores.c
> @@ -0,0 +1,241 @@
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
> + * - The hardware minimum period / duty_cycle is (1 / pwm_apb clock frequency).
> + * - The hardware maximum period / duty_cycle is (U32_MAX / pwm_apb clock frequency).
> + * - The output is set to a low level immediately when disabled.

Huh, that's a 100% relative duty cycle. But fine, that gives the
opportunity to find bugs in consumer drivers. :-)

> + * - When configuration changes are done, they get active immediately without resetting
> + *   the counter. This might result in one period affected by both old and new settings.
> + */
> +
> [...]
> +static inline void ocores_pwm_writel(struct ocores_pwm_device *ddata,
> +				     unsigned int channel,
> +				     unsigned int offset, u32 val)
> [...]
> +static inline struct ocores_pwm_device *chip_to_ocores(struct pwm_chip *chip)
> [...]
> +static void __iomem *starfive_get_ch_base(void __iomem *base,
> +					  unsigned int channel)

Would be great if all functions had the same prefix. This simplifies
debugging with tracing, because you can just enable traces for
"ocores_pwm_*".

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
> +	period_data = mul_u64_u32_div(state->period, ddata->clk_rate, NSEC_PER_SEC);
> +	if (!period_data)
> +		return -EINVAL;
> +
> +	if (period_data > U32_MAX)
> +		period_data = U32_MAX;
> +
> +	ocores_pwm_writel(ddata, pwm->hwpwm, REG_OCPWM_LRC, (u32)period_data);

The cast isn't needed.

> +	duty_data = mul_u64_u32_div(state->duty_cycle, ddata->clk_rate, NSEC_PER_SEC);
> +	if (!duty_data)
> +		return -EINVAL;
> +
> +	if (duty_data > U32_MAX)
> +		duty_data = U32_MAX;
> +
> +	ocores_pwm_writel(ddata, pwm->hwpwm, REG_OCPWM_HRC, (u32)duty_data);

ditto.

> +	ctrl_data = ocores_pwm_readl(ddata, pwm->hwpwm, REG_OCPWM_CTRL);
> +	if (state->enabled)
> +		ocores_pwm_writel(ddata, pwm->hwpwm, REG_OCPWM_CTRL,
> +				  ctrl_data | REG_OCPWM_CNTR_EN | REG_OCPWM_CNTR_OE);
> +	else
> +		ocores_pwm_writel(ddata, pwm->hwpwm, REG_OCPWM_CTRL,
> +				  ctrl_data & ~(REG_OCPWM_CNTR_EN | REG_OCPWM_CNTR_OE));

If you're clearing REG_OCPWM_CNTR_OE (Output Enable?), does the output
really go low? Or is that due to an external pull down on your board?

> +
> +	return 0;
> +}
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

Error message here? Better use device_get_match_data() here. Then you
don't need the of-specific headers (IIUC).

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
> +	ret = reset_control_deassert(rst);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_add_action_or_reset(dev, ocores_pwm_reset_control_assert, rst);
> +	if (ret)
> +		return ret;

If you respin anyhow, switch to
devm_reset_control_get_optional_exclusive_deasserted(). Up to now this
only exists in next, but I'd care to apply this is a way that doesn't
fail to build then.

> +	ddata->clk_rate = clk_get_rate(clk);
> +	if (ddata->clk_rate > NSEC_PER_SEC)
> +		return -EINVAL;
> +
> +	ret = devm_pwmchip_add(dev, chip);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "Could not register PWM chip\n");
> +
> +	return 0;
> +}

Best regards
Uwe

--5ft5dx5frm54rk25
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmcGOn0ACgkQj4D7WH0S
/k7nQAf/bNcqXvu5TM3xqi4I4b+vs57zbYGuw+lY9NUbX36V9Jb2oWrOO1Tx+nh2
RJnM2SCN7UyH4+LHxlMmwBeIiTKRUDJNxmA9b0pUq4EJEGu+xFRaKuMQwKfQIvxI
WiHmMTOpNykYfyG2tWfSC36Hjkg1oUT1JoYVsOpQsld6oF6MVmeWBVRY7eGA0EV0
/kLjPJPUTWHAMv6IW679W8HzWJqoSg6b+c8Y5Xi6sYAo6Nu9SX9WR43BFPV3Kj4N
USlNSw2dUgzd8aTvJhNpX5WIaWwi8X3xUwxP5BtY5540clB68nzkFJHrw65nZKwz
ERTDsQkQT2C2tZ63uMZGmFUp+PRmXA==
=9Var
-----END PGP SIGNATURE-----

--5ft5dx5frm54rk25--

