Return-Path: <linux-pwm+bounces-2728-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3129792A505
	for <lists+linux-pwm@lfdr.de>; Mon,  8 Jul 2024 16:46:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A067A1F216FD
	for <lists+linux-pwm@lfdr.de>; Mon,  8 Jul 2024 14:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F28D413FD8C;
	Mon,  8 Jul 2024 14:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ZfSp9frz"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9D513F45F
	for <linux-pwm@vger.kernel.org>; Mon,  8 Jul 2024 14:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720450009; cv=none; b=U+tc8IHibG/1OuAWNwJqE5yFGUQnilqAJtubgQ4O6Wi/O0wzW69dtahApUufA911JG+h3ICsE806C0f7rHGlDFgcbs2LWGwZQtgMQfPt9xTfvii0wQhgw9gG8Ba8Hbp/ZvNQyBpv2kP9UcXF5xQYbg5OXKJ9iEQ5mVVibsuSsH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720450009; c=relaxed/simple;
	bh=Y/1DhgE9P0CCbqA/uKdfxMfsXwdL918nuACh7Pb/R1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=txhupLFQ111mEMmz6TGxhIQTPhpd15GnuWvVDQG+nMULxc2DBRZEjwSpALIEyspiXxsa1aMqb/eS4Ur/8gWPRogDvB2grwIPIFWpEfwe05kJlbpOwNHEDt2yA6JMPK0NQOzbT8EhC1xbCX8wZPcO09ZDcI6ukNj8wTuzl0q2LTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ZfSp9frz; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a77d876273dso191008566b.0
        for <linux-pwm@vger.kernel.org>; Mon, 08 Jul 2024 07:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1720450005; x=1721054805; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=H4r3BW+xA7PHo4fZ3Dpc8IaHHzWSJm1jb9JSYWe9mMA=;
        b=ZfSp9frzFxm8rZq2CXMfHv7neDQ8p16g1Eit9RZjlTTiXVq8Qom/cx6rXluh3DONYX
         opsg9dhPIaydzZOMSuDwqZyWQOkIHWwProO/hh3u2qOveEMyeOZI20KolUQin1UGatv3
         UiQ2VyNUvSt7KhnjxDbIY4h63D+n5D9fro+Ypg6wUITjRam62sbmAsJbEyv+2FdZcZv6
         Jdm7Kvc0aupEGd2dhHSojFml0AjhC9tELTYw3yrcks4QjwU2cx1DTV6/Z2pwyXAkliUf
         3zqX+DMluP/AHTuWimDjSTAY9gNVNZxNK3w8D31iA6+Z/bwG47eAVX7ml57LQGRKADpK
         1BJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720450005; x=1721054805;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H4r3BW+xA7PHo4fZ3Dpc8IaHHzWSJm1jb9JSYWe9mMA=;
        b=nxOtBb0dYqoewiFdpg5sh7GO5jfr6j9xGFxGIo+3YFLTbRirF2mMhrlPWV2ymXHhVk
         nOo+TqiZeYdzWQZxfgmUbCj2Y6ScshsLajxYuiX2L+mHLpm4IYkMSSKVJpgY4Xd5EbH2
         LGRrZ6rxLq4/gmLYFdiMUzRy4BJ2wfNda49qdBo3Mgxj6Uu/suVsXUN+NCibbBU6Ig4U
         vh7en7Y/VqYjdgzDWniNOiqR9WK/vK7pV9jsqaay3vLCFWHCZuJK9GiJgFDF3SEMJRUm
         0ONLbUBFZg+P1yyg9Y9tfyw3POw9Rw76d5mjRUD60znOjRMieTKbloB8N1sUxStBG6by
         XQfg==
X-Forwarded-Encrypted: i=1; AJvYcCVLaS7DJKJcKcsVL8ZencCFf3lRfFg0xj3UyR9ShE7tx4+Ti44d/lJ1kvaQfqIvc95fB6jFD7QgkQyc9/YxggxzROiXshslUaNP
X-Gm-Message-State: AOJu0YzTtOAVEjHgX6XLWIamQJqCC6V3QJumL5hNFGpd0mPbFGsb5hMo
	2be0WowBEknksLJBQudtY8lAh9rcPozwWzDBb8DQBSeTpr4966tPJBDIhkqI6rs=
X-Google-Smtp-Source: AGHT+IFXdkWPuIZ3PdfBlVCG6r/kikoWYZCKiD/krZTizcVI5zWXgET/qWLSzQNI79qcuhFXjddV1w==
X-Received: by 2002:a05:6402:b29:b0:58c:3252:3ab8 with SMTP id 4fb4d7f45d1cf-58e5bd7d6f3mr8807096a12.37.1720450005110;
        Mon, 08 Jul 2024 07:46:45 -0700 (PDT)
Received: from localhost (p200300f65f217d00930e0db224f9e8ed.dip0.t-ipconnect.de. [2003:f6:5f21:7d00:930e:db2:24f9:e8ed])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a871f03sm419166b.197.2024.07.08.07.46.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 07:46:44 -0700 (PDT)
Date: Mon, 8 Jul 2024 16:46:42 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Aleksandr Shubin <privatesub2@gmail.com>
Cc: linux-kernel@vger.kernel.org, 
	Brandon Cheo Fusi <fusibrandon13@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Philipp Zabel <p.zabel@pengutronix.de>, 
	John Watts <contact@jookia.org>, Marc Kleine-Budde <mkl@pengutronix.de>, 
	Maksim Kiselev <bigunclemax@gmail.com>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v9 2/3] pwm: Add Allwinner's D1/T113-S3/R329 SoCs PWM
 support
Message-ID: <dkoqgfvl2s4ly7jjzvln6x2nt4ztti4vxuiazx45vhwm5nb6e3@5ia7l3h2cnge>
References: <20240520184227.120956-1-privatesub2@gmail.com>
 <20240520184227.120956-3-privatesub2@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="oaiqbv4wt72i4lvm"
Content-Disposition: inline
In-Reply-To: <20240520184227.120956-3-privatesub2@gmail.com>


--oaiqbv4wt72i4lvm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 20, 2024 at 09:42:20PM +0300, Aleksandr Shubin wrote:
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
>  drivers/pwm/Kconfig      |  10 +
>  drivers/pwm/Makefile     |   1 +
>  drivers/pwm/pwm-sun20i.c | 387 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 398 insertions(+)
>  create mode 100644 drivers/pwm/pwm-sun20i.c
>=20
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 4b956d661755..d2e0a080eb3c 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -625,6 +625,16 @@ config PWM_SUN4I
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm-sun4i.
> =20
> +config PWM_SUN20I
> +	tristate "Allwinner D1/T113s/R329 PWM support"
> +	depends on ARCH_SUNXI || COMPILE_TEST
> +	depends on COMMON_CLK
> +	help
> +	  Generic PWM framework driver for Allwinner D1/T113s/R329 SoCs.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called pwm-sun20i.
> +
>  config PWM_SUNPLUS
>  	tristate "Sunplus PWM support"
>  	depends on ARCH_SUNPLUS || COMPILE_TEST
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index c5ec9e168ee7..dcad0d5a2430 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -58,6 +58,7 @@ obj-$(CONFIG_PWM_STM32)		+=3D pwm-stm32.o
>  obj-$(CONFIG_PWM_STM32_LP)	+=3D pwm-stm32-lp.o
>  obj-$(CONFIG_PWM_STMPE)		+=3D pwm-stmpe.o
>  obj-$(CONFIG_PWM_SUN4I)		+=3D pwm-sun4i.o
> +obj-$(CONFIG_PWM_SUN20I)	+=3D pwm-sun20i.o
>  obj-$(CONFIG_PWM_SUNPLUS)	+=3D pwm-sunplus.o
>  obj-$(CONFIG_PWM_TEGRA)		+=3D pwm-tegra.o
>  obj-$(CONFIG_PWM_TIECAP)	+=3D pwm-tiecap.o
> diff --git a/drivers/pwm/pwm-sun20i.c b/drivers/pwm/pwm-sun20i.c
> new file mode 100644
> index 000000000000..3e3b5b138b30
> --- /dev/null
> +++ b/drivers/pwm/pwm-sun20i.c
> @@ -0,0 +1,387 @@
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
> +#define SUN20I_PWM_CLK_CFG(chan)		(0x20 + (((chan) >> 1) * 0x4))
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
> +
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

This is really sophisticated, that guy seems to be a genius :-)
Ok, honestly: I didn't try to reunderstand this in this round. Will do
that for the next iteration again.

> + */
> +#define SUN20I_PWM_MAGIC			(255 * 65537 + 2 * 65536 + 1)
> +
> +struct sun20i_pwm_chip {
> +	struct clk *clk_bus, *clk_hosc, *clk_apb;
> +	struct reset_control *rst;
> +	struct pwm_chip chip;
> +	void __iomem *base;
> +	/* Mutex to protect pwm apply state */
> +	struct mutex mutex;
> +};

Having a pwm_chip embedded in your driver private data doesn't work any
more since v6.10-rc1~168^2~31. See e.g. commit 792bc12573a3 ("pwm:
spear: Make use of devm_pwmchip_alloc() function") for an easy
conversion to what needs to be done today.

> [...]
> +static int sun20i_pwm_apply(struct pwm_chip *chip, struct pwm_device *pw=
m,
> +			    const struct pwm_state *state)
> +{
> +	struct sun20i_pwm_chip *sun20i_chip =3D to_sun20i_pwm_chip(chip);
> +	u64 bus_rate, hosc_rate, val, ent_cycle, act_cycle;
> +	u32 clk_gate, clk_cfg, pwm_en, ctl, reg_period;
> +	u32 prescale_k, div_m;
> +	bool use_bus_clk;
> +	int ret =3D 0;
> +
> +	mutex_lock(&sun20i_chip->mutex);
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

return 0 here?

> +		}
> +	}
> +
> +	if (state->polarity !=3D pwm->state.polarity ||
> +	    state->duty_cycle !=3D pwm->state.duty_cycle ||
> +	    state->period !=3D pwm->state.period) {

I guess this is true often enough that checking for it isn't worth the
effort. Also note that with the early return suggested above, the check
becomes bogous.

> +		ctl =3D sun20i_pwm_readl(sun20i_chip, SUN20I_PWM_CTL(pwm->hwpwm));
> +		clk_cfg =3D sun20i_pwm_readl(sun20i_chip, SUN20I_PWM_CLK_CFG(pwm->hwpw=
m));
> +		hosc_rate =3D clk_get_rate(sun20i_chip->clk_hosc);
> +		bus_rate =3D clk_get_rate(sun20i_chip->clk_apb);
> +		if (pwm_en & SUN20I_PWM_ENABLE_EN(pwm->hwpwm ^ 1)) {
> +			/* if the neighbor channel is enable, check period only */

s/enable/enabled/, maybe also mention that each SUN20I_PWM_CLK_CFG is
shared by two channels. I find it irritating that SUN20I_PWM_CLK_CFG(0)
=3D=3D SUN20I_PWM_CLK_CFG(1). I suggest to drop the shift from the defintion
and use SUN20I_PWM_CLK_CFG(pwm->hwpwm / 2) to make this more visible in
the source code.

> +			use_bus_clk =3D FIELD_GET(SUN20I_PWM_CLK_CFG_SRC, clk_cfg) !=3D 0;
> +			val =3D mul_u64_u64_div_u64(state->period,
> +						  (use_bus_clk ? bus_rate : hosc_rate),
> +						  NSEC_PER_SEC);
> +
> +			div_m =3D FIELD_GET(SUN20I_PWM_CLK_CFG_DIV_M, clk_cfg);
> +		} else {
> +			/* check period and select clock source */

You're implicitly assuming here that bus_rate > hosc_rate. Maybe make
this explicit in a comment (and check for that in .probe()?)

> +			use_bus_clk =3D false;
> +			val =3D mul_u64_u64_div_u64(state->period, hosc_rate, NSEC_PER_SEC);
> +			if (val <=3D 1) {
> +				use_bus_clk =3D true;
> +				val =3D mul_u64_u64_div_u64(state->period, bus_rate, NSEC_PER_SEC);
> +				if (val <=3D 1) {
> +					ret =3D -EINVAL;
> +					goto unlock_mutex;

If you use a guard to lock the mutex, these gotos can just be replaced
by a return statement.

> +				}
> +			}
> +			div_m =3D fls(DIV_ROUND_DOWN_ULL(val, SUN20I_PWM_MAGIC));
> +			if (div_m > SUN20I_PWM_CLK_DIV_M_MAX) {
> +				ret =3D -EINVAL;
> +				goto unlock_mutex;
> +			}
> +
> +			/* set up the CLK_DIV_M and clock CLK_SRC */
> +			clk_cfg =3D FIELD_PREP(SUN20I_PWM_CLK_CFG_DIV_M, div_m);
> +			clk_cfg |=3D FIELD_PREP(SUN20I_PWM_CLK_CFG_SRC, use_bus_clk);
> +
> +			sun20i_pwm_writel(sun20i_chip, clk_cfg, SUN20I_PWM_CLK_CFG(pwm->hwpwm=
));
> +		}
> +
> +		/* calculate prescale_k, PWM entire cycle */
> +		ent_cycle =3D val >> div_m;
> +		prescale_k =3D DIV_ROUND_DOWN_ULL(ent_cycle, 65537);
> +		if (prescale_k > SUN20I_PWM_CTL_PRESCAL_K_MAX)
> +			prescale_k =3D SUN20I_PWM_CTL_PRESCAL_K_MAX;
> +
> +		do_div(ent_cycle, prescale_k + 1);
> +
> +		/* for N cycles, PPRx.PWM_ENTIRE_CYCLE =3D (N-1) */
> +		reg_period =3D FIELD_PREP(SUN20I_PWM_PERIOD_ENTIRE_CYCLE, ent_cycle - =
1);
> +
> +		/* set duty cycle */
> +		val =3D mul_u64_u64_div_u64(state->duty_cycle,
> +					  (use_bus_clk ? bus_rate : hosc_rate),
> +					  NSEC_PER_SEC);
> +		act_cycle =3D val >> div_m;
> +		do_div(act_cycle, prescale_k + 1);
> +
> +		/*
> +		 * The formula of the output period and the duty-cycle for PWM are as =
follows.
> +		 * T period =3D (PWM01_CLK / PWM0_PRESCALE_K)^-1 * (PPR0.PWM_ENTIRE_CY=
CLE + 1)

(PWM01_CLK / PWM0_PRESCALE_K)^-1 =3D PWM0_PRESCALE_K / PWM01_CLK

> +		 * T high-level =3D (PWM01_CLK / PWM0_PRESCALE_K)^-1 * PPR0.PWM_ACT_CY=
CLE
> +		 * Duty-cycle =3D T high-level / T period
> +		 */
> +		reg_period |=3D FIELD_PREP(SUN20I_PWM_PERIOD_ACT_CYCLE, act_cycle);
> +		sun20i_pwm_writel(sun20i_chip, reg_period, SUN20I_PWM_PERIOD(pwm->hwpw=
m));
> +
> +		ctl =3D FIELD_PREP(SUN20I_PWM_CTL_PRESCAL_K, prescale_k);
> +		if (state->polarity =3D=3D PWM_POLARITY_NORMAL)
> +			ctl |=3D SUN20I_PWM_CTL_ACT_STA;
> +
> +		sun20i_pwm_writel(sun20i_chip, ctl, SUN20I_PWM_CTL(pwm->hwpwm));
> +	}
> +
> +	if (state->enabled !=3D pwm->state.enabled && state->enabled) {
> +		clk_gate &=3D ~SUN20I_PWM_CLK_GATE_BYPASS(pwm->hwpwm);
> +		clk_gate |=3D SUN20I_PWM_CLK_GATE_GATING(pwm->hwpwm);
> +		pwm_en |=3D SUN20I_PWM_ENABLE_EN(pwm->hwpwm);
> +		sun20i_pwm_writel(sun20i_chip, pwm_en, SUN20I_PWM_ENABLE);
> +		sun20i_pwm_writel(sun20i_chip, clk_gate, SUN20I_PWM_CLK_GATE);
> +	}
> +
> +unlock_mutex:
> +	mutex_unlock(&sun20i_chip->mutex);
> +
> +	return ret;
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
> +	struct sun20i_pwm_chip *sun20i_chip;
> +	int ret;
> +
> +	sun20i_chip =3D devm_kzalloc(&pdev->dev, sizeof(*sun20i_chip), GFP_KERN=
EL);
> +	if (!sun20i_chip)
> +		return -ENOMEM;
> +
> +	sun20i_chip->base =3D devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(sun20i_chip->base))
> +		return PTR_ERR(sun20i_chip->base);
> +
> +	sun20i_chip->clk_bus =3D devm_clk_get_enabled(&pdev->dev, "bus");
> +	if (IS_ERR(sun20i_chip->clk_bus))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(sun20i_chip->clk_bus),
> +				     "failed to get bus clock\n");
> +
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
> +	sun20i_chip->rst =3D devm_reset_control_get_exclusive(&pdev->dev, NULL);
> +	if (IS_ERR(sun20i_chip->rst))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(sun20i_chip->rst),
> +				     "failed to get bus reset\n");
> +
> +	ret =3D of_property_read_u32(pdev->dev.of_node, "allwinner,pwm-channels=
",
> +				   &sun20i_chip->chip.npwm);
> +	if (ret)
> +		sun20i_chip->chip.npwm =3D 8;
> +
> +	if (sun20i_chip->chip.npwm > 16) {
> +		dev_info(&pdev->dev, "Limiting number of PWM lines from %u to 16",
> +			 sun20i_chip->chip.npwm);
> +		sun20i_chip->chip.npwm =3D 16;
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

At some point in the future this can be simplified using
devm_reset_control_get_exclusive_deasserted(). See
https://lore.kernel.org/linux-arm-kernel/20240621-reset-get-deasserted-v1-2=
-94ee76fb7b7d@pengutronix.de

> +	sun20i_chip->chip.dev =3D &pdev->dev;
> +	sun20i_chip->chip.ops =3D &sun20i_pwm_ops;
> +
> +	mutex_init(&sun20i_chip->mutex);
> +
> +	ret =3D devm_pwmchip_add(&pdev->dev, &sun20i_chip->chip);
> +	if (ret < 0)
> +		return dev_err_probe(&pdev->dev, ret, "failed to add PWM chip\n");
> +
> +	platform_set_drvdata(pdev, sun20i_chip);

This is unused.

> +	return 0;
> +}
> +
> +static struct platform_driver sun20i_pwm_driver =3D {
> +	.driver =3D {
> +		.name =3D "sun20i-pwm",
> +		.of_match_table =3D sun20i_pwm_dt_ids,
> +	},
> +	.probe =3D sun20i_pwm_probe,
> +};
> +module_platform_driver(sun20i_pwm_driver);
> +
> +MODULE_AUTHOR("Aleksandr Shubin <privatesub2@gmail.com>");
> +MODULE_DESCRIPTION("Allwinner sun20i PWM driver");
> +MODULE_LICENSE("GPL");

Best regards
Uwe

--oaiqbv4wt72i4lvm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmaL+9AACgkQj4D7WH0S
/k5U6Af8CdwrhNJTquCLRakWZtum3pUd1I57gAyPTlNnbeS29MTXx6dI/yGYyII5
x8HlvseHTSeAIZOo9OfX2SavBbcgsqOdjMttUvzWXRf5GmRGIxY8m4YjKsID803Z
MaQ6Qr5UwNvJSqUeVleTrOcu0YIpT8jN0EM0gDge9SlG1/zMarSpEktXI6VKsTJJ
F61uTczokCxFX1KBs/w31WQQrv/yyut6i2lk4VMOmnvAttittQSZT2ufoMmvTA7p
P/9WrzrgHxaW59P8YM9iA70c4DkHmaXWJWbk3fc+eZC0WUxq5h08QqmJxsNzR86h
YVPMx6MuBm3OdUZYs/lVT3adLxcmmQ==
=V6vI
-----END PGP SIGNATURE-----

--oaiqbv4wt72i4lvm--

