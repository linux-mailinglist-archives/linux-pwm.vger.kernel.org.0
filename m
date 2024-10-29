Return-Path: <linux-pwm+bounces-3955-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45F989B4466
	for <lists+linux-pwm@lfdr.de>; Tue, 29 Oct 2024 09:41:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E1A2283739
	for <lists+linux-pwm@lfdr.de>; Tue, 29 Oct 2024 08:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DA522038DD;
	Tue, 29 Oct 2024 08:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="rRrscYia"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1AD202F64
	for <linux-pwm@vger.kernel.org>; Tue, 29 Oct 2024 08:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730191311; cv=none; b=sPRC/QuyiI9TnoINjt0GZM7jHt/8uaWCXSUcktTTQ3BBdd0jK0mIEYw9uXV8hi0xKKTju/n2hgIDQuUZ9AMqFg7SIwdSarDoflLkaLzRmT+6pcpu6MCYlP5KIjKd1UJUIQ0J93P/UPaKhqE7+kjgKmsdJh/psR4omup4rKUrJN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730191311; c=relaxed/simple;
	bh=+eooZs8no+0YVB+RKY16MetC/Wy9d5orr1cjOPjoL58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R5yNFI1LY8RXJCEEVJwnNxDbeBz4Hv2cqtBq6cwNhEvSsN9RZAdlslkaaNa6sXrZNiOvTf0wG5nqOw8z4Ue8AD8rnfRls+DC6J39Ffe4Bt8q+s9bxVoFzdGSBdBsidUPyzitgeX5Okp0grVbLYHneRyNdJiuqUGqKfT5CsOdPGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=rRrscYia; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-37f52925fc8so3673967f8f.1
        for <linux-pwm@vger.kernel.org>; Tue, 29 Oct 2024 01:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730191306; x=1730796106; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HWMsQ8Q07cRsdOgSemC4ISoy/HF90KN+3uJ4nbx4U10=;
        b=rRrscYia2OLMIRfkTWyX+VSuw/aO2wo9+U3ORVHFHN++XqP5EjieQBTKcB3oY59Stw
         AatnNWYi0WjyR3QZIwoqjVqjCtDGfbaVMavIoPu1+iVsSFs/VBWuL3Yc/NkUq4poPKPc
         gdZ6y0Bjh22PI3TUsxL0cpDguWUPOuHKssW3I8MyxOwgsvSMBwBoZLHCn4afsCZX6RmS
         132st+nf+72mOy2Q80z+fryGZELwExTEUqeo9Ato+QIM1/5/rTP6A6Ub70UVYE8QFUbt
         cMTuKeis8dxiSJVlj5614E/Y3Wvwbxnye8nZ6QXsPwsI4v0no2LQ2UIs6vrY8AG2h6ng
         MkeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730191306; x=1730796106;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HWMsQ8Q07cRsdOgSemC4ISoy/HF90KN+3uJ4nbx4U10=;
        b=uUFUHX3/uOxRLZd8qSBERCm3Qzw4TO5p3t5Pyc38L09+4BZ0sGm7+qOXxGV/xjp/PD
         pzZ6/pD61F6WF3s6NzBuc9CB9JSnmVMfaXXyERVxRmiPEifPTemYj9yH4L6XExnA5SMa
         rEE21omIpra84wd58gM6RkVHw0P5NoWm/ZNT+5IwImZCZuOnnCuldd1/ysFzFdM3ZUmb
         +kr/tnDGWVdKPCrfO/WHxvjcaK7p/B+qp2di0iy6fNfXhqUk3t3CEIMKASH6cutX9FBW
         SHnaKDmUg/VDfSG0KlfOV5fJCNXCLL8Jr+m6eDI5aBm+xSm0t4eGRGMYAbltIoo7Jehv
         30dw==
X-Forwarded-Encrypted: i=1; AJvYcCWZ6K8xiqythpXiLSkOFBBuuTJZmA5dRJKAa1/ZVJBMVRXaIH7ZEM2ZiixWgCeAe++Qr3Nm+pXYZVo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyIzGayC36ONcmdTx3nc07Z5BuGF/+Y3kmIz/Iz1OU3CPhERpm
	E558mvMqKmTj7scSrSp7Dei0AkzE5bwwRW/pajsms/+p0rkmiTJzDYYfLGlkR9E=
X-Google-Smtp-Source: AGHT+IGr59PqkpM/A9KZqffpxuYegoDGYbEcOTvHe1Db8ujgVbTotnexeJrd1XD0mnRpRjH5gr/ovA==
X-Received: by 2002:adf:a341:0:b0:37d:4cee:55b with SMTP id ffacd0b85a97d-3806121a2c1mr7893113f8f.59.1730191306008;
        Tue, 29 Oct 2024 01:41:46 -0700 (PDT)
Received: from localhost (p50915d2d.dip0.t-ipconnect.de. [80.145.93.45])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b1cc0asm11984664f8f.10.2024.10.29.01.41.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 01:41:45 -0700 (PDT)
Date: Tue, 29 Oct 2024 09:41:44 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Aleksandr Shubin <privatesub2@gmail.com>
Cc: linux-kernel@vger.kernel.org, 
	Brandon Cheo Fusi <fusibrandon13@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Philipp Zabel <p.zabel@pengutronix.de>, 
	linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v10 2/3] pwm: Add Allwinner's D1/T113-S3/R329 SoCs PWM
 support
Message-ID: <vvpfehfcvcimghnzzeejhs5qklgvfkpbjioqlmrl64kiaaxjrg@lw2t4djyvt36>
References: <20241011102751.153248-1-privatesub2@gmail.com>
 <20241011102751.153248-3-privatesub2@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="h3uobxordgujekfx"
Content-Disposition: inline
In-Reply-To: <20241011102751.153248-3-privatesub2@gmail.com>


--h3uobxordgujekfx
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v10 2/3] pwm: Add Allwinner's D1/T113-S3/R329 SoCs PWM
 support
MIME-Version: 1.0

Hello,

On Fri, Oct 11, 2024 at 01:27:33PM +0300, Aleksandr Shubin wrote:
> [...]
> diff --git a/drivers/pwm/pwm-sun20i.c b/drivers/pwm/pwm-sun20i.c
> new file mode 100644
> index 000000000000..7d1b47843bb6
> --- /dev/null
> +++ b/drivers/pwm/pwm-sun20i.c
> @@ -0,0 +1,379 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * PWM Controller Driver for sunxi platforms (D1, T113-S3 and R329)
> + *
> + * Limitations:
> + * - When the parameters change, current running period will not be comp=
leted
> + *   and run new settings immediately.
> + * - It output HIGH-Z state when PWM channel disabled.
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
> +#define SUN20I_PWM_CLK_CFG(chan)		(0x20 + ((chan) * 0x4))
> +#define SUN20I_PWM_CLK_CFG_SRC			GENMASK(8, 7)
> +#define SUN20I_PWM_CLK_CFG_DIV_M		GENMASK(3, 0)
> +#define SUN20I_PWM_CLK_DIV_M_MAX		8
> +
> +#define SUN20I_PWM_CLK_GATE			0x40
> +#define SUN20I_PWM_CLK_GATE_BYPASS(chan)	BIT((chan) + 16)
> +#define SUN20I_PWM_CLK_GATE_GATING(chan)	BIT(chan)
> +
> +#define SUN20I_PWM_ENABLE			0x80
> +#define SUN20I_PWM_ENABLE_EN(chan)		BIT(chan)
> +
> +#define SUN20I_PWM_CTL(chan)			(0x100 + (chan) * 0x20)
> +#define SUN20I_PWM_CTL_ACT_STA			BIT(8)
> +#define SUN20I_PWM_CTL_PRESCAL_K		GENMASK(7, 0)
> +#define SUN20I_PWM_CTL_PRESCAL_K_MAX		field_max(SUN20I_PWM_CTL_PRESCAL_K)
> +
> +#define SUN20I_PWM_PERIOD(chan)			(0x104 + (chan) * 0x20)
> +#define SUN20I_PWM_PERIOD_ENTIRE_CYCLE		GENMASK(31, 16)
> +#define SUN20I_PWM_PERIOD_ACT_CYCLE		GENMASK(15, 0)
> +
> +#define SUN20I_PWM_PCNTR_SIZE			BIT(16)

It's a bit unfortunate that SUN20I_PWM_CLK_CFG is passed hwpwm/2 while
SUN20I_PWM_CTL gets a plain hwpwm. I suggest to at least name the
parameters differently.

> +/*
> + * SUN20I_PWM_MAGIC is used to quickly compute the values of the clock d=
ividers
> + * div_m (SUN20I_PWM_CLK_CFG_DIV_M) & prescale_k (SUN20I_PWM_CTL_PRESCAL=
_K)
> + * without using a loop. These dividers limit the # of cycles in a period
> + * to SUN20I_PWM_PCNTR_SIZE by applying a scaling factor of
> + * 1/(div_m * (prescale_k + 1)) to the clock source.
> + *
> + * SUN20I_PWM_MAGIC is derived by solving for div_m and prescale_k
> + * such that for a given requested period,
> + *
> + * i) div_m is minimized for any prescale_k =E2=89=A4 SUN20I_PWM_CTL_PRE=
SCAL_K_MAX,
> + * ii) prescale_k is minimized.
> + *
> + * The derivation proceeds as follows, with val =3D # of cycles for requ=
ested
> + * period:
> + *
> + * for a given value of div_m we want the smallest prescale_k such that
> + *
> + * (val >> div_m) // (prescale_k + 1) =E2=89=A4 65536 (SUN20I_PWM_PCNTR_=
SIZE)
                                                  ^
I'd add a =3D here ---------------------------------' to make it clear
that SUN20I_PWM_PCNTR_SIZE is a description for 65536 and this isn't a
multiplication.

> + *
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
> + * (i.e SUN20I_PWM_CTL_PRESCAL_K_MAX),
> + *
> + * ((val >> div_m) - 65536) // 65537 =E2=89=A4 255
> + * =E2=9F=BA (val >> div_m) - 65536 =E2=89=A4 255 * 65537 + 65536
> + * =E2=9F=BA val >> div_m =E2=89=A4 255 * 65537 + 2 * 65536
> + * =E2=9F=BA val >> div_m < (255 * 65537 + 2 * 65536 + 1)
> + * =E2=9F=BA div_m =3D fls((val) / (255 * 65537 + 2 * 65536 + 1))
> + *
> + * Suggested by Uwe Kleine-K=C3=B6nig
> + */
> +#define SUN20I_PWM_MAGIC			(255 * 65537 + 2 * 65536 + 1)
> +
> +struct sun20i_pwm_chip {
> +	struct clk *clk_bus, *clk_hosc, *clk_apb;
> +	struct reset_control *rst;

clk_bus and rst are only used in probe and so can be a local variable there.

> +	void __iomem *base;
> +	struct mutex mutex; /* Protect PWM apply state */

Since commit 1cc2e1faafb3 ("pwm: Add more locking") that currently waits
in next for the merge window the callbacks for a single chip are
serialized, so (unless I miss something) this mutex can be dropped.

> +};
> +
> +static inline struct sun20i_pwm_chip *to_sun20i_pwm_chip(struct pwm_chip=
 *chip)
> +{
> +	return pwmchip_get_drvdata(chip);
> +}
> +
> +static inline u32 sun20i_pwm_readl(struct sun20i_pwm_chip *chip,
> +				   unsigned long offset)
> +{
> +	return readl(chip->base + offset);
> +}
> +
> +static inline void sun20i_pwm_writel(struct sun20i_pwm_chip *chip,
> +				     u32 val, unsigned long offset)
> +{
> +	writel(val, chip->base + offset);
> +}
> +
> +static int sun20i_pwm_get_state(struct pwm_chip *chip,
> +				struct pwm_device *pwm,
> +				struct pwm_state *state)
> +{
> +	struct sun20i_pwm_chip *sun20i_chip =3D to_sun20i_pwm_chip(chip);
> +	u16 ent_cycle, act_cycle, prescale_k;
> +	u64 clk_rate, tmp;
> +	u8 div_m;
> +	u32 val;
> +
> +	mutex_lock(&sun20i_chip->mutex);
> +
> +	val =3D sun20i_pwm_readl(sun20i_chip, SUN20I_PWM_CLK_CFG(pwm->hwpwm / 2=
));
> +	div_m =3D FIELD_GET(SUN20I_PWM_CLK_CFG_DIV_M, val);
> +	if (div_m > SUN20I_PWM_CLK_DIV_M_MAX)
> +		div_m =3D SUN20I_PWM_CLK_DIV_M_MAX;
> +
> +	if (FIELD_GET(SUN20I_PWM_CLK_CFG_SRC, val) =3D=3D 0)

SUN20I_PWM_CLK_CFG_SRC is two bits wide. Do all values !=3D 0 mean APB?

> +		clk_rate =3D clk_get_rate(sun20i_chip->clk_hosc);
> +	else
> +		clk_rate =3D clk_get_rate(sun20i_chip->clk_apb);
> +
> +	val =3D sun20i_pwm_readl(sun20i_chip, SUN20I_PWM_CTL(pwm->hwpwm));
> +	state->polarity =3D (SUN20I_PWM_CTL_ACT_STA & val) ?
> +			   PWM_POLARITY_NORMAL : PWM_POLARITY_INVERSED;
> +
> +	prescale_k =3D FIELD_GET(SUN20I_PWM_CTL_PRESCAL_K, val) + 1;
> +
> +	val =3D sun20i_pwm_readl(sun20i_chip, SUN20I_PWM_ENABLE);
> +	state->enabled =3D (SUN20I_PWM_ENABLE_EN(pwm->hwpwm) & val) ? true : fa=
lse;
> +
> +	val =3D sun20i_pwm_readl(sun20i_chip, SUN20I_PWM_PERIOD(pwm->hwpwm));
> +
> +	mutex_unlock(&sun20i_chip->mutex);
> +
> +	act_cycle =3D FIELD_GET(SUN20I_PWM_PERIOD_ACT_CYCLE, val);
> +	ent_cycle =3D FIELD_GET(SUN20I_PWM_PERIOD_ENTIRE_CYCLE, val);
> +
> +	/*
> +	 * The duration of the active phase should not be longer
> +	 * than the duration of the period
> +	 */
> +	if (act_cycle > ent_cycle)
> +		act_cycle =3D ent_cycle;
> +
> +	/*
> +	 * We have act_cycle <=3D ent_cycle <=3D 0xffff, prescale_k <=3D 0x100,
> +	 * div_m <=3D 8. So the multiplication fits into an u64 without
> +	 * overflow.
> +	 */
> +	tmp =3D ((u64)(act_cycle) * prescale_k << div_m) * NSEC_PER_SEC;
> +	state->duty_cycle =3D DIV_ROUND_UP_ULL(tmp, clk_rate);
> +	tmp =3D ((u64)(ent_cycle) * prescale_k << div_m) * NSEC_PER_SEC;
> +	state->period =3D DIV_ROUND_UP_ULL(tmp, clk_rate);
> +
> +	return 0;
> +}
> +
> +static int sun20i_pwm_apply(struct pwm_chip *chip, struct pwm_device *pw=
m,
> +			    const struct pwm_state *state)
> +{
> +	struct sun20i_pwm_chip *sun20i_chip =3D to_sun20i_pwm_chip(chip);
> +	u64 bus_rate, hosc_rate, val, ent_cycle, act_cycle;
> +	u32 clk_gate, clk_cfg, pwm_en, ctl, reg_period;
> +	u32 prescale_k, div_m;
> +	bool use_bus_clk;
> +
> +	guard(mutex)(&sun20i_chip->mutex);
> +
> +	pwm_en =3D sun20i_pwm_readl(sun20i_chip, SUN20I_PWM_ENABLE);
> +
> +	if (state->enabled !=3D pwm->state.enabled) {
> +		clk_gate =3D sun20i_pwm_readl(sun20i_chip, SUN20I_PWM_CLK_GATE);
> +
> +		if (!state->enabled) {
> +			clk_gate &=3D ~SUN20I_PWM_CLK_GATE_GATING(pwm->hwpwm);
> +			pwm_en &=3D ~SUN20I_PWM_ENABLE_EN(pwm->hwpwm);
> +			sun20i_pwm_writel(sun20i_chip, pwm_en, SUN20I_PWM_ENABLE);
> +			sun20i_pwm_writel(sun20i_chip, clk_gate, SUN20I_PWM_CLK_GATE);
> +
> +			return 0;
> +		}
> +	}
> +
> +	ctl =3D sun20i_pwm_readl(sun20i_chip, SUN20I_PWM_CTL(pwm->hwpwm));
> +	clk_cfg =3D sun20i_pwm_readl(sun20i_chip, SUN20I_PWM_CLK_CFG(pwm->hwpwm=
 / 2));
> +	hosc_rate =3D clk_get_rate(sun20i_chip->clk_hosc);
> +	bus_rate =3D clk_get_rate(sun20i_chip->clk_apb);
> +	if (pwm_en & SUN20I_PWM_ENABLE_EN(pwm->hwpwm ^ 1)) {
> +		/* if the neighbor channel is enabled, check period only */
> +		use_bus_clk =3D FIELD_GET(SUN20I_PWM_CLK_CFG_SRC, clk_cfg) !=3D 0;
> +		val =3D mul_u64_u64_div_u64(state->period,
> +					  (use_bus_clk ? bus_rate : hosc_rate),
> +					  NSEC_PER_SEC);
> +
> +		div_m =3D FIELD_GET(SUN20I_PWM_CLK_CFG_DIV_M, clk_cfg);
> +	} else {
> +		/*
> +		 * Select the clock source based on the period,
> +		 * since bus_rate > hosc_rate, which means bus_rate
> +		 * can provide a higher frequency than hosc_rate.
> +		 */
> +		use_bus_clk =3D false;
> +		val =3D mul_u64_u64_div_u64(state->period, hosc_rate, NSEC_PER_SEC);
> +		if (val <=3D 1) {

Why is val =3D=3D 1 already problematic?

> +			use_bus_clk =3D true;
> +			val =3D mul_u64_u64_div_u64(state->period, bus_rate, NSEC_PER_SEC);
> +			if (val <=3D 1)
> +				return -EINVAL;
> +		}
> +		div_m =3D fls(DIV_ROUND_DOWN_ULL(val, SUN20I_PWM_MAGIC));
> +		if (div_m > SUN20I_PWM_CLK_DIV_M_MAX)
> +			return -EINVAL;
> +
> +		/* set up the CLK_DIV_M and clock CLK_SRC */
> +		clk_cfg =3D FIELD_PREP(SUN20I_PWM_CLK_CFG_DIV_M, div_m);
> +		clk_cfg |=3D FIELD_PREP(SUN20I_PWM_CLK_CFG_SRC, use_bus_clk);
> +
> +		sun20i_pwm_writel(sun20i_chip, clk_cfg, SUN20I_PWM_CLK_CFG(pwm->hwpwm =
/ 2));
> +	}

Does writing SUN20I_PWM_CLK_CFG already influence the output? If so this
needs mentioning in the Limitations paragraph at the driver's top as the
output might glitch more than suggested there currently.

> +	/* calculate prescale_k, PWM entire cycle */
> +	ent_cycle =3D val >> div_m;
> +	prescale_k =3D DIV_ROUND_DOWN_ULL(ent_cycle, 65537);

A #define for 65537?

> +	if (prescale_k > SUN20I_PWM_CTL_PRESCAL_K_MAX)
> +		prescale_k =3D SUN20I_PWM_CTL_PRESCAL_K_MAX;
> +
> +	do_div(ent_cycle, prescale_k + 1);
> +
> +	/* for N cycles, PPRx.PWM_ENTIRE_CYCLE =3D (N-1) */
> +	reg_period =3D FIELD_PREP(SUN20I_PWM_PERIOD_ENTIRE_CYCLE, ent_cycle - 1=
);

Is ent_cycle known to be =E2=89=A5 1?

> +	/* set duty cycle */
> +	val =3D mul_u64_u64_div_u64(state->duty_cycle,
> +				  (use_bus_clk ? bus_rate : hosc_rate),
> +				  NSEC_PER_SEC);
> +	act_cycle =3D val >> div_m;
> +	do_div(act_cycle, prescale_k + 1);
> +
> +	/*
> +	 * The formula of the output period and the duty-cycle for PWM are as f=
ollows.
> +	 * T period =3D PWM0_PRESCALE_K / PWM01_CLK * (PPR0.PWM_ENTIRE_CYCLE + =
1)
> +	 * T high-level =3D PWM0_PRESCALE_K / PWM01_CLK * PPR0.PWM_ACT_CYCLE
> +	 * Duty-cycle =3D T high-level / T period
> +	 */
> +	reg_period |=3D FIELD_PREP(SUN20I_PWM_PERIOD_ACT_CYCLE, act_cycle);
> +	sun20i_pwm_writel(sun20i_chip, reg_period, SUN20I_PWM_PERIOD(pwm->hwpwm=
));
> +
> +	ctl =3D FIELD_PREP(SUN20I_PWM_CTL_PRESCAL_K, prescale_k);
> +	if (state->polarity =3D=3D PWM_POLARITY_NORMAL)
> +		ctl |=3D SUN20I_PWM_CTL_ACT_STA;
> +
> +	sun20i_pwm_writel(sun20i_chip, ctl, SUN20I_PWM_CTL(pwm->hwpwm));
> +
> +	if (state->enabled !=3D pwm->state.enabled && state->enabled) {
> +		clk_gate &=3D ~SUN20I_PWM_CLK_GATE_BYPASS(pwm->hwpwm);
> +		clk_gate |=3D SUN20I_PWM_CLK_GATE_GATING(pwm->hwpwm);
> +		pwm_en |=3D SUN20I_PWM_ENABLE_EN(pwm->hwpwm);
> +		sun20i_pwm_writel(sun20i_chip, pwm_en, SUN20I_PWM_ENABLE);
> +		sun20i_pwm_writel(sun20i_chip, clk_gate, SUN20I_PWM_CLK_GATE);
> +	}

There is an early return at the start of the function for
state->enabled !=3D pwm->state.enabled && !state->enabled
=2E So just checking for

	if (state->enabled !=3D pwm->state.enabled)

is enough.

> +
> +	return 0;
> +}
> +
> +static const struct pwm_ops sun20i_pwm_ops =3D {
> +	.apply =3D sun20i_pwm_apply,
> +	.get_state =3D sun20i_pwm_get_state,
> +};
> +
> +static const struct of_device_id sun20i_pwm_dt_ids[] =3D {
> +	{ .compatible =3D "allwinner,sun20i-d1-pwm" },
> +	{ },

No comma after the sentinel entry please.

> +};
> +MODULE_DEVICE_TABLE(of, sun20i_pwm_dt_ids);
> +
> +static void sun20i_pwm_reset_ctrl_release(void *data)
> +{
> +	struct reset_control *rst =3D data;
> +
> +	reset_control_assert(rst);
> +}
> +
> +static int sun20i_pwm_probe(struct platform_device *pdev)
> +{
> +	struct pwm_chip *chip;
> +	struct sun20i_pwm_chip *sun20i_chip;
> +	int ret;
> +
> +	chip =3D devm_pwmchip_alloc(&pdev->dev, 8, sizeof(*sun20i_chip));
> +	if (IS_ERR(chip))
> +		return PTR_ERR(chip);
> +	sun20i_chip =3D to_sun20i_pwm_chip(chip);
> +
> +	sun20i_chip->base =3D devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(sun20i_chip->base))
> +		return PTR_ERR(sun20i_chip->base);
> +
> +	sun20i_chip->clk_bus =3D devm_clk_get_enabled(&pdev->dev, "bus");
> +	if (IS_ERR(sun20i_chip->clk_bus))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(sun20i_chip->clk_bus),
> +				     "failed to get bus clock\n");

I like error messages starting with a capital letter. Would you mind
converting accordingly?

> +	sun20i_chip->clk_hosc =3D devm_clk_get_enabled(&pdev->dev, "hosc");
> +	if (IS_ERR(sun20i_chip->clk_hosc))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(sun20i_chip->clk_hosc),
> +				     "failed to get hosc clock\n");
> +
> +	sun20i_chip->clk_apb =3D devm_clk_get_enabled(&pdev->dev, "apb");
> +	if (IS_ERR(sun20i_chip->clk_apb))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(sun20i_chip->clk_apb),
> +				     "failed to get apb clock\n");
> +
> +	if (clk_get_rate(sun20i_chip->clk_apb) > clk_get_rate(sun20i_chip->clk_=
hosc))
> +		dev_info(&pdev->dev, "apb clock must be greater than hosc clock");
> +
> +	sun20i_chip->rst =3D devm_reset_control_get_exclusive(&pdev->dev, NULL);
> +	if (IS_ERR(sun20i_chip->rst))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(sun20i_chip->rst),
> +				     "failed to get bus reset\n");
> +
> +	ret =3D of_property_read_u32(pdev->dev.of_node, "allwinner,pwm-channels=
",
> +				   &chip->npwm);

error checking for ret?

> +	if (chip->npwm > 16) {
> +		dev_info(&pdev->dev, "limiting number of PWM lines from %u to 16",
> +			 chip->npwm);
> +		chip->npwm =3D 16;

Layer violation; drivers are not supposed to assign npwm. Also above you
only allocated 8. Better check allwinner,pwm-channels before calling
devm_pwmchip_alloc().

> +	}
> +
> +	/* Deassert reset */
> +	ret =3D reset_control_deassert(sun20i_chip->rst);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret, "failed to deassert reset\n");
> +
> +	ret =3D devm_add_action_or_reset(&pdev->dev, sun20i_pwm_reset_ctrl_rele=
ase, sun20i_chip->rst);
> +	if (ret)
> +		return ret;

There is devm_reset_control_get_exclusive_asserted() scheduled to go
into v6.13-rc1. Please group the operations concerning rst together such
that it can be converted trivially to that function.

> +	chip->ops =3D &sun20i_pwm_ops;
> +
> +	mutex_init(&sun20i_chip->mutex);
> +
> +	ret =3D devm_pwmchip_add(&pdev->dev, chip);
> +	if (ret < 0)
> +		return dev_err_probe(&pdev->dev, ret, "failed to add PWM chip\n");
> +
> +	return 0;
> +}

Best regards
Uwe

--h3uobxordgujekfx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmcgn8UACgkQj4D7WH0S
/k7xhwf9HjfsvCYXMcz5IPGcu942SVgllDJRSLTrnTzLCkDQ106GNTGpXYvXb072
GssHnqN6kmfc8E+gyWczt5lnJH4HAhnrIrmhPMrXHLQDJYNZr7zAZ4rR9USwYvE6
s2YZzGMAd2CTb/GWCGJcKtwAbAHxFeeXJbtSSs5X0AHnixI9kpWLtfn6rJwtXOeY
k/JRp/2N5ecbuAFA34y5f4cP60h2Eb22Ig6eb4i0HcBS2Wu0zVbPFiDjzV/YGFzs
J+dDt5Nq1AsfEC6JFqzHm2gtENpyVCzaquBEF9w15CyAPXV58Qq0P00hMAT2otOw
XmAzX33FrLtDaK55WkDdpJCQdjLNBA==
=CeHb
-----END PGP SIGNATURE-----

--h3uobxordgujekfx--

