Return-Path: <linux-pwm+bounces-3105-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB50996DF14
	for <lists+linux-pwm@lfdr.de>; Thu,  5 Sep 2024 18:03:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A5611F25E59
	for <lists+linux-pwm@lfdr.de>; Thu,  5 Sep 2024 16:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE6519EEB1;
	Thu,  5 Sep 2024 16:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="fiG0O4z/"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A8B19D06B
	for <linux-pwm@vger.kernel.org>; Thu,  5 Sep 2024 16:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725552188; cv=none; b=JHrWVkw4if9DmngN9VhuEef0JwIsK4I3r8MlaTa7Ufhy6V26Da5YFGBcQ673ev7vlLV5hHd6m6aPETIA8JH+qUTfUsZzjpL/fkLN+50ZGvSf05zlrlN4wll9asGqwL8FbqEHPX+IexUJFuKogzkC+x2jFojTXyDA/bDG/vWdHTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725552188; c=relaxed/simple;
	bh=jSEuUZjcp8/rMF65PChZ6aZD2yBciVNc5VVQVXUzAMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tonpe9Awo0Nd1spEcVgKPtE9YLHSY9OjJVVLiKmrJ0XWAT9zmxC0TGKF+0l/mcNicqL5gcwLjFZTQ5uag4/62YFb/YQVQWo/onGLoSyghUlioKqO78szCOuFUvRP7xK6C2yswEOGcekdgEDoINAhgNv9pxgA9XKMf4Xy7ndpk2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=fiG0O4z/; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a8a7596b7dfso127973866b.0
        for <linux-pwm@vger.kernel.org>; Thu, 05 Sep 2024 09:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725552184; x=1726156984; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0lO/webuLu6zbfLMn41bIDlXtl84yaoWf4AkCT6f/2o=;
        b=fiG0O4z/ofqujDWDkyf1DnUQTpAorCA5wBrPCDBKEv9Zzu56SIjG6l2xn1yLGo0A+/
         Kup06TVbk/CXPLJ6BrpBtQxLD04U8h2G4xDU8wD6B2tb9/B1SczgF+2kqLkw+UEGQYV/
         7c6BavH8FTMbaeOJW4VT/Env06KKCBrNW8OXqKDo3J5n2MpzSBM1ZcA3ZnPsvhn3Keye
         8Y78ZEO6aLmkQa7YwfNbeUEyPcoPk+yQgg7jK2NmlUFooP6jWaSrdzNiSUvTtHfnu0Cc
         GL3tM3/4wVIPWl+K8fBzxP4EGzbGlOd6qDPB5scRxAjaFeozOn0d1zM+b3c6j6CksylJ
         EnPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725552184; x=1726156984;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0lO/webuLu6zbfLMn41bIDlXtl84yaoWf4AkCT6f/2o=;
        b=tBzzEkcU3OgMusY+F5njz0j2vZRw6pN0cFozYZgqsSQloyvNmKoJIyvAwlgPEj/6zG
         QOhckYcl7mvmnIk//LaT55bsf9o5WyjDfkIMXpB0zTcomDwO4zNj7bk0eWGysx2XmZMU
         skeyBZpzoIlu2EIthoexeYzWeRQVYQ8WC6YoxqBxHcqxFfLJq59H2A3NVnDjNR64ORP7
         zHvD2fmHFtQvkohqjZVqUKkHiSXm+o2LAmbuMacUaxsUyIa7trhFImHrhTv1/sh3yWYh
         ueZ42wqRaGmBGJLM6rJenJ8NfKe1/UGaV795l5wpG4fwCnmr4IWEvU7/P0U8bBLvZDEB
         8AgQ==
X-Forwarded-Encrypted: i=1; AJvYcCXI5mGhU5aZC+FwMPWbigKJBsUbTitH7c1en88Y6/gQ2086vVhzJtlRvvpBUlCUsIMZ8GVtvL++R6M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuUjrxhxNVFGYHRxrlb0m/HcsH5u0wWLyUQ3c2ELD8bfweOeud
	wvZBe4EnuVxKQqBaDxhgJDgDbehS2xfDE1Bi5iNXJNj9OdtyXlsP7W3IYKA28Hw=
X-Google-Smtp-Source: AGHT+IG82zLauo7lsJQpVygAALA/UdkzGiyhIyE7hYYTStEpjuYBLEED9W8uQGP+TnDec4CXAxc0Qg==
X-Received: by 2002:a17:907:7286:b0:a7a:afe8:1013 with SMTP id a640c23a62f3a-a8a42fb1287mr714977766b.1.1725552183568;
        Thu, 05 Sep 2024 09:03:03 -0700 (PDT)
Received: from localhost (p200300f65f01db004d6a46a6454a1385.dip0.t-ipconnect.de. [2003:f6:5f01:db00:4d6a:46a6:454a:1385])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8a6236d16fsm153245266b.99.2024.09.05.09.03.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 09:03:02 -0700 (PDT)
Date: Thu, 5 Sep 2024 18:03:01 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Chen Wang <unicornxw@gmail.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	unicorn_wang@outlook.com, inochiama@outlook.com, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, linux-riscv@lists.infradead.org, 
	chao.wei@sophgo.com, haijiao.liu@sophgo.com, xiaoguang.xing@sophgo.com, 
	chunzhi.lin@sophgo.com
Subject: Re: [PATCH 2/2] pwm: sophgo: add driver for Sophgo SG2042 PWM
Message-ID: <id7arbp2z5ui3krscder6vrv5g7v3rvjxpde2eyg7pn5lxjvha@fdishk36pt35>
References: <cover.1725536870.git.unicorn_wang@outlook.com>
 <3985690b29340982a45314bdcc914c554621e909.1725536870.git.unicorn_wang@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ovkkq3mcs5nbjldh"
Content-Disposition: inline
In-Reply-To: <3985690b29340982a45314bdcc914c554621e909.1725536870.git.unicorn_wang@outlook.com>


--ovkkq3mcs5nbjldh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Thu, Sep 05, 2024 at 08:10:42PM +0800, Chen Wang wrote:
> From: Chen Wang <unicorn_wang@outlook.com>
>=20
> Add a PWM driver for PWM controller in Sophgo SG2042 SoC.
>=20
> Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
> ---
>  drivers/pwm/Kconfig             |   9 ++
>  drivers/pwm/Makefile            |   1 +
>  drivers/pwm/pwm-sophgo-sg2042.c | 148 ++++++++++++++++++++++++++++++++
>  3 files changed, 158 insertions(+)
>  create mode 100644 drivers/pwm/pwm-sophgo-sg2042.c
>=20
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 3e53838990f5..6287d63a84fd 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -577,6 +577,15 @@ config PWM_SL28CPLD
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm-sl28cpld.
> =20
> +config PWM_SOPHGO_SG2042
> +	tristate "Sophgo SG2042 PWM support"
> +	depends on ARCH_SOPHGO || COMPILE_TEST
> +	help
> +	  PWM driver for Sophgo SG2042 PWM controller.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called pwm_sophgo_sg2042.
> +
>  config PWM_SPEAR
>  	tristate "STMicroelectronics SPEAr PWM support"
>  	depends on PLAT_SPEAR || COMPILE_TEST
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index 0be4f3e6dd43..ef2555e83183 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -52,6 +52,7 @@ obj-$(CONFIG_PWM_RZ_MTU3)	+=3D pwm-rz-mtu3.o
>  obj-$(CONFIG_PWM_SAMSUNG)	+=3D pwm-samsung.o
>  obj-$(CONFIG_PWM_SIFIVE)	+=3D pwm-sifive.o
>  obj-$(CONFIG_PWM_SL28CPLD)	+=3D pwm-sl28cpld.o
> +obj-$(CONFIG_PWM_SOPHGO_SG2042)	+=3D pwm-sophgo-sg2042.o
>  obj-$(CONFIG_PWM_SPEAR)		+=3D pwm-spear.o
>  obj-$(CONFIG_PWM_SPRD)		+=3D pwm-sprd.o
>  obj-$(CONFIG_PWM_STI)		+=3D pwm-sti.o
> diff --git a/drivers/pwm/pwm-sophgo-sg2042.c b/drivers/pwm/pwm-sophgo-sg2=
042.c
> new file mode 100644
> index 000000000000..cf11ad54b4de
> --- /dev/null
> +++ b/drivers/pwm/pwm-sophgo-sg2042.c
> @@ -0,0 +1,148 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Sophgo SG2042 PWM Controller Driver
> + *
> + * Copyright (C) 2024 Sophgo Technology Inc.
> + * Copyright (C) 2024 Chen Wang <unicorn_wang@outlook.com>
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/pwm.h>
> +
> +#include <asm/div64.h>
> +
> +/*
> + * Offset RegisterName
> + * 0x0000 HLPERIOD0
> + * 0x0004 PERIOD0
> + * 0x0008 HLPERIOD1
> + * 0x000C PERIOD1
> + * 0x0010 HLPERIOD2
> + * 0x0014 PERIOD2
> + * 0x0018 HLPERIOD3
> + * 0x001C PERIOD3
> + * Four groups and every group is composed of HLPERIOD & PERIOD
> + */
> +#define REG_HLPERIOD	0x0
> +#define REG_PERIOD	0x4
> +
> +#define REG_GROUP	0x8
> +
> +#define SG2042_PWM_CHANNELNUM	4
> +
> +/**
> + * struct sg2042_pwm_chip - private data of PWM chip
> + * @base:		base address of mapped PWM registers
> + * @base_clk:		base clock used to drive the pwm controller
> + */
> +struct sg2042_pwm_chip {
> +	void __iomem *base;
> +	struct clk *base_clk;
> +};
> +
> +static inline
> +struct sg2042_pwm_chip *to_sg2042_pwm_chip(struct pwm_chip *chip)
> +{
> +	return pwmchip_get_drvdata(chip);
> +}
> +
> +static void pwm_sg2042_config(void __iomem *base, unsigned int channo, u=
32 period, u32 hlperiod)
> +{
> +	writel(period, base + REG_GROUP * channo + REG_PERIOD);
> +	writel(hlperiod, base + REG_GROUP * channo + REG_HLPERIOD);
> +}

I suggest to use the following instead:

	#define SG2042_HLPERIOD(chan) ((chan) * 8 + 0)
	#define SG2042_PERIOD(chan) ((chan) * 8 + 4)

	...

	static void pwm_sg2042_config(void __iomem *base, unsigned int chan, u32 p=
eriod, u32 hlperiod)
	{
		writel(period, base + SG2042_PERIOD(chan));
		writel(hlperiod, base + SG2042_HLPERIOD(chan));
	}

The (subjective?) advantage is that the definition of SG2042_HLPERIOD
contains information about all channel's HLPERIOD register and the usage
in pwm_sg2042_config is obviously(?) right.

(Another advantage is that the register names have a prefix unique to
the driver, so there is no danger of mixing it up with some other
hardware's driver that might also have a register named "PERIOD".)

Is this racy? i.e. can it happen that between the two writel the output
is defined by the new period and old duty_cycle?

How does the hardware behave on reconfiguration? Does it complete the
currently running period? Please document that in a comment at the start
of the driver like many other drivers do. (See=20

	sed -rn '/Limitations:/,/\*\/?$/p' drivers/pwm/*.c

)

> +static int pwm_sg2042_apply(struct pwm_chip *chip, struct pwm_device *pw=
m,
> +			    const struct pwm_state *state)
> +{
> +	struct sg2042_pwm_chip *sg2042_pwm =3D to_sg2042_pwm_chip(chip);
> +	u32 hlperiod;
> +	u32 period;
> +	u64 f_clk;
> +	u64 p;
> +
> +	if (!state->enabled) {
> +		pwm_sg2042_config(sg2042_pwm->base, pwm->hwpwm, 0, 0);
> +		return 0;
> +	}

Here you're missing (I guess):

	if (state->polarity =3D=3D PWM_POLARITY_INVERSED)
		return -EINVAL;

> +	/*
> +	 * Period of High level (duty_cycle) =3D HLPERIOD x Period_clk
> +	 * Period of One Cycle (period) =3D PERIOD x Period_clk
> +	 */
> +	f_clk =3D clk_get_rate(sg2042_pwm->base_clk);
> +
> +	p =3D f_clk * state->period;

This might overflow.

> +	do_div(p, NSEC_PER_SEC);
> +	period =3D (u32)p;

This gets very wrong if p happens to be bigger than U32_MAX.

If you ensure f_clk <=3D NSEC_PER_SEC in .probe() (in combination with a
call to clk_rate_exclusive_get()), you can do:

	period_cycles =3D min(mul_u64_u64_div_u64(f_clk, state->period, NSEC_PER_S=
EC), U32_MAX);
	duty_cycles =3D min(mul_u64_u64_div_u64(f_clk, state->duty_cycle, NSEC_PER=
_SEC), U32_MAX);

This would also allow to store the clkrate in the driver private struct
and drop the pointer to the clk from there.

> +	p =3D f_clk * state->duty_cycle;
> +	do_div(p, NSEC_PER_SEC);
> +	hlperiod =3D (u32)p;
> +
> +	dev_dbg(pwmchip_parent(chip), "chan[%d]: period=3D%u, hlperiod=3D%u\n",
> +		pwm->hwpwm, period, hlperiod);

pwm->hwpwm is an unsigned int, so use %u for it.

> +	pwm_sg2042_config(sg2042_pwm->base, pwm->hwpwm, period, hlperiod);
> +
> +	return 0;
> +}
> +
> +static const struct pwm_ops pwm_sg2042_ops =3D {
> +	.apply		=3D pwm_sg2042_apply,

No .get_state() possible? Please use a single space before =3D.

> +};
> +
> +static const struct of_device_id sg2042_pwm_match[] =3D {
> +	{ .compatible =3D "sophgo,sg2042-pwm" },
> +	{ },

Please drop the , after the sentinel entry.

> +};
> +MODULE_DEVICE_TABLE(of, sg2042_pwm_match);
> +
> +static int pwm_sg2042_probe(struct platform_device *pdev)
> +{
> +	struct device *dev =3D &pdev->dev;
> +	struct sg2042_pwm_chip *sg2042_pwm;
> +	struct pwm_chip *chip;
> +	int ret;
> +
> +	chip =3D devm_pwmchip_alloc(&pdev->dev, SG2042_PWM_CHANNELNUM, sizeof(*=
sg2042_pwm));
> +	if (IS_ERR(chip))
> +		return PTR_ERR(chip);
> +	sg2042_pwm =3D to_sg2042_pwm_chip(chip);
> +
> +	chip->ops =3D &pwm_sg2042_ops;
> +
> +	sg2042_pwm->base =3D devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(sg2042_pwm->base))
> +		return PTR_ERR(sg2042_pwm->base);
> +
> +	sg2042_pwm->base_clk =3D devm_clk_get_enabled(&pdev->dev, "apb");
> +	if (IS_ERR(sg2042_pwm->base_clk))
> +		return dev_err_probe(dev, PTR_ERR(sg2042_pwm->base_clk),
> +				     "failed to get base clk\n");
> +
> +	ret =3D devm_pwmchip_add(&pdev->dev, chip);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "failed to register PWM chip\n");
> +
> +	platform_set_drvdata(pdev, chip);

This is unused and should/can be dropped.

> +
> +	return 0;
> +}
> +
> +static struct platform_driver pwm_sg2042_driver =3D {
> +	.driver	=3D {
> +		.name	=3D "sg2042-pwm",
> +		.of_match_table =3D of_match_ptr(sg2042_pwm_match),
> +	},
> +	.probe =3D pwm_sg2042_probe,
> +};
> +module_platform_driver(pwm_sg2042_driver);

Please use a single space before =3D.

> +MODULE_AUTHOR("Chen Wang");
> +MODULE_DESCRIPTION("Sophgo SG2042 PWM driver");
> +MODULE_LICENSE("GPL");
> --=20
> 2.34.1
>=20

Best regards
Uwe

--ovkkq3mcs5nbjldh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmbZ1jMACgkQj4D7WH0S
/k5GnQgAl62Yk2r77cgUH8x8m4JwTMuj2lYh2Xd+lLWn6zOk047Iw1zcN7YNTFqa
Ou7f8v5+rTxmHRThrMe5SPWVwiFNCMxLt0zcqy6/RUs1BWGtgX9l7FVLqemJ2L/m
vB8musR7QCpENLQI9Kty0G8RN84H7wAX7tMXScj7vwRrJgXzGPyZ7+PmLNro2bkH
hNs25W+wVEGUOzgsJ1bQl0aMKBbokYoJNBpCSJMQqa4z18Y5sKkduprGv63qcp97
V0tl4eoKJukWlnHkNepWngppSJ83VddOkvlepzeGbecCcQAw57nt0MXPldVnqEH8
rLVKVd9uS/h9vy3WnuDR9pPGHuWGwQ==
=lRuO
-----END PGP SIGNATURE-----

--ovkkq3mcs5nbjldh--

