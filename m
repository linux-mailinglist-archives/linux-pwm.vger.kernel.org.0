Return-Path: <linux-pwm+bounces-5621-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 027AEA950CB
	for <lists+linux-pwm@lfdr.de>; Mon, 21 Apr 2025 14:22:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B48EE1889055
	for <lists+linux-pwm@lfdr.de>; Mon, 21 Apr 2025 12:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26A52264636;
	Mon, 21 Apr 2025 12:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lijlAaUy"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA5B25D8EE;
	Mon, 21 Apr 2025 12:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745238147; cv=none; b=tZzdO8PZnzD2RJAHdl8RaHBK51GyRZC2EiLcClZGgpqfudfEWFnxlUL7kmzYYdKtAMSjls/VAcbjhXSv1c585K93Y886O4J1Euf7yUeSaHAhZ7yK+doc+ELAu9qPY1jbGcUK2Z6Mm/0sRp4OsZq+P4kxqHs9Sy+thvyR8tOHlMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745238147; c=relaxed/simple;
	bh=PFt3nJNAK8U/gXFCq3I7roT//pRw7/VOmEfMsWonZCw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tWi5vrnSCjCu7vVyzM3wrfVxaAuQ6ofP0KepJNEWPnH6WNWynBWgsOdNj3TZMNMiFkwbTMh4/vUNUON+5um7PlcOv1bS3BTe+SmYKgjWiPca9a55winO+exThmkgnj3T6pHehspeZU6D2IxM7gXdlAGv7PAor7qHbISmELHKBUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lijlAaUy; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43d07ca6a80so19135475e9.1;
        Mon, 21 Apr 2025 05:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745238143; x=1745842943; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=h7wdPw6oEf/Je541KmTzwPRxWgw9ZbYGUOjQ/nCZ+Mw=;
        b=lijlAaUyFCNmKkgGjiCmytZjF6zenf8d0wQzLUGdk4Q4ckB9kT7BZRhOCz6qCeTT5/
         u3nuQHYyaFOj+fYoddq70ctHnPBxDlRFsxcWN49LjIhGQ9X9a3HjM28TnQ+rG+mHFbyz
         DvrCNziDFh9iwMNaJE5PdPSMqjG5NLJi0vFIIAH4uUAYAyMRXMAbjacC5peu96xrnAJ9
         /D0j8m+3yh5vfyamsVUAs1AnZRoM5O92dL0EzOn36l0pEI6peIDeRAHV+rMvKYEc0Zy/
         hUoKvohyqn3qLjtL+/kvwCcVqiCRwxfCB2aBn5GFtSG0CfZ/pfot2/DhUinXkJh6GfOT
         bCPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745238143; x=1745842943;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h7wdPw6oEf/Je541KmTzwPRxWgw9ZbYGUOjQ/nCZ+Mw=;
        b=uf3BgjwxPp0dmTrD3JvtVpkPox9wYdkQbdXSPL4hANqm+Z7ajyluza8c6iaGa/5TAz
         5iAt4T3g7t84cKZ7RN6cKlczFOTgKDNkvM8XwQxOXLoAXN3O6n64EsfwC2e0roQz84xr
         tO1R8lzk4n/1m6j0OAfuBsOXe/i9uckAClKLeo+aXau/hL4BS/e5uut8tiEa1zrFioQD
         EzHoCqk0l1FMI4XqGeO4QpCehraTSJKmRtgY+TjWU/2kenpO/IeJTEBHYI8R1gwZ5evs
         jnLMiuhfSbhEZlJTFDeHDwoSZ5/p47aSJRZxdY7XytgNgYa5PV1l9w2kBlvFt6VC9Hq9
         VS4A==
X-Forwarded-Encrypted: i=1; AJvYcCV63ybMsdynU5gRtpcoY7LahAEVgKk6MNlazdEw3P6U46EeBhFb6OVJSNgJrbwd4M+LSbLbcSM8XZIxjlY=@vger.kernel.org, AJvYcCVQXRVQS5gPBUVogvQQVaRvaFC5+zg2CqmobHhntfiJgmZJJP1g22JPLtu7Vu5yTlK5g8qNzB3KI9L9@vger.kernel.org, AJvYcCXh32h/8ewckBix524FUP5bFmhQFDPWHJ9X4Xw4SJ7TXox/qSUqfi6qDh8HuMYtAbT1Ix8Eue5Lk/Do@vger.kernel.org
X-Gm-Message-State: AOJu0YxYfFJYnXIAb3hDkiRtSaNx6y3tqzFnwDzzoLloJawgOUGFFeZu
	cmi+gbjwQr03H7Rlxza8piGkHTOrdL7GqtRfq96+Cw0XPhZ5i+ow
X-Gm-Gg: ASbGncswmZvYF7XTVsfhfJxyuoLpQgdPlqUaYU+Wsf9kvEhi5ZmgXB95bN0lVZKZwbx
	5yDCJAVxqmth8JrlsF95ZUhDO0qm4H1uPVtLdIacTILXrmTT/VJIPnj1iHNLDdC08gS3l9a92Jy
	1rlB7WhuAnRuuLGIoo5rcmtqIKom39oFiG239IrjTR9gU/k8hXwboF40rBoiVLOB3V6JaldA3GL
	1SuYs1Xiqi0+3Ku3rlgRBK31YcDpymEcMqe1C47Z+7GCqnYe/8IXHB/hoyM9avebRII0eaQ0lVg
	fd1LMXoBIiT26QTARe42lc/5gzO/O45U8L6TWL0wskh4q1sFRDTt8DEhd7lo07wDTv04pvOb1d9
	iB6Q5C7oV2/SP
X-Google-Smtp-Source: AGHT+IEOgF4q9KSi8axfLY/hqMbVgLQmcXoaXHWhVcf2FdWqaOvTtd7bjfYH9Xw5QCxJ3xs1SFU3TA==
X-Received: by 2002:a05:600c:548e:b0:43d:a90:9f1 with SMTP id 5b1f17b1804b1-4406ab67708mr84381195e9.6.1745238143000;
        Mon, 21 Apr 2025 05:22:23 -0700 (PDT)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4406d5a9e43sm132286845e9.5.2025.04.21.05.22.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 05:22:22 -0700 (PDT)
Message-ID: <f478582f9d5af6b3ab55d6f84a6342bcf90f8707.camel@gmail.com>
Subject: Re: [PATCH v2 07/17] gpio: adp5585: add support for the ad5589
 expander
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, nuno.sa@analog.com
Cc: linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-input@vger.kernel.org, Lee Jones
 <lee@kernel.org>,  Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,  Uwe
 =?ISO-8859-1?Q?Kleine-K=F6nig?=	 <ukleinek@kernel.org>, Linus Walleij
 <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, Dmitry
 Torokhov <dmitry.torokhov@gmail.com>, Liu Ying <victor.liu@nxp.com>
Date: Mon, 21 Apr 2025 13:22:25 +0100
In-Reply-To: <20250421092351.GF29968@pendragon.ideasonboard.com>
References: <20250415-dev-adp5589-fw-v2-0-3a799c3ed812@analog.com>
	 <20250415-dev-adp5589-fw-v2-7-3a799c3ed812@analog.com>
	 <20250421092351.GF29968@pendragon.ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0 
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-04-21 at 12:23 +0300, Laurent Pinchart wrote:
> Hi Nuno,
>=20
> Thank you for the patch.
>=20
> On Tue, Apr 15, 2025 at 03:49:23PM +0100, Nuno S=C3=A1 via B4 Relay wrote=
:
> > From: Nuno S=C3=A1 <nuno.sa@analog.com>
> >=20
> > Support the adp5589 I/O expander which supports up to 19 pins. We need
> > to add a chip_info based struct since accessing register "banks"
> > and "bits" differs between devices.
> >=20
> > Also some register addresses are different.
>=20
> Same comment as for 06/17, splitting the patch in two will make it
> easier to review.
>=20
> > Acked-by: Linus Walleij <linus.walleij@linaro.org>
> > Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> > ---
> > =C2=A0drivers/gpio/gpio-adp5585.c | 121 +++++++++++++++++++++++++++++++=
+---------
> > ---
> > =C2=A01 file changed, 88 insertions(+), 33 deletions(-)
> >=20
> > diff --git a/drivers/gpio/gpio-adp5585.c b/drivers/gpio/gpio-adp5585.c
> > index
> > d5c0f1b267c82a5002b50cbb7a108166439e4785..d8f8d5513d7f6a9acf5bdecccacc8=
9c461
> > 5ce237 100644
> > --- a/drivers/gpio/gpio-adp5585.c
> > +++ b/drivers/gpio/gpio-adp5585.c
> > @@ -4,6 +4,7 @@
> > =C2=A0 *
> > =C2=A0 * Copyright 2022 NXP
> > =C2=A0 * Copyright 2024 Ideas on Board Oy
> > + * Copyright 2025 Analog Devices, Inc.
> > =C2=A0 */
> > =C2=A0
> > =C2=A0#include <linux/device.h>
> > @@ -14,21 +15,49 @@
> > =C2=A0#include <linux/regmap.h>
> > =C2=A0#include <linux/types.h>
> > =C2=A0
> > -#define ADP5585_GPIO_MAX	11
> > +struct adp5585_gpio_chip {
> > +	unsigned int max_gpio;
> > +	int (*bank)(unsigned int off);
> > +	int (*bit)(unsigned int off);
> > +	bool has_bias_hole;
> > +};
> > =C2=A0
> > =C2=A0struct adp5585_gpio_dev {
> > =C2=A0	struct gpio_chip gpio_chip;
> > +	const struct adp5585_gpio_chip *info;
> > =C2=A0	struct regmap *regmap;
> > +	const struct adp5585_regs *regs;
> > =C2=A0};
> > =C2=A0
> > +static int adp5585_gpio_bank(unsigned int off)
> > +{
> > +	return ADP5585_BANK(off);
>=20
> While at it, let's move the ADP558[59]_{BANK,BIT} macros to this file,
> and name them ADP558[59]_GPIO_{BANK_BIT}.

Sure...

>=20
> > +}
> > +
> > +static int adp5585_gpio_bit(unsigned int off)
> > +{
> > +	return ADP5585_BIT(off);
> > +}
> > +
> > +static int adp5589_gpio_bank(unsigned int off)
> > +{
> > +	return ADP5589_BANK(off);
> > +}
> > +
> > +static int adp5589_gpio_bit(unsigned int off)
> > +{
> > +	return ADP5589_BIT(off);
> > +}
> > +
> > =C2=A0static int adp5585_gpio_get_direction(struct gpio_chip *chip, uns=
igned int
> > off)
> > =C2=A0{
> > =C2=A0	struct adp5585_gpio_dev *adp5585_gpio =3D gpiochip_get_data(chip=
);
> > -	unsigned int bank =3D ADP5585_BANK(off);
> > -	unsigned int bit =3D ADP5585_BIT(off);
> > +	const struct adp5585_regs *regs =3D adp5585_gpio->regs;
> > +	unsigned int bank =3D adp5585_gpio->info->bank(off);
> > +	unsigned int bit =3D adp5585_gpio->info->bit(off);
> > =C2=A0	unsigned int val;
> > =C2=A0
> > -	regmap_read(adp5585_gpio->regmap, ADP5585_GPIO_DIRECTION_A + bank,
> > &val);
> > +	regmap_read(adp5585_gpio->regmap, regs->gpio_dir_a + bank, &val);
> > =C2=A0
> > =C2=A0	return val & bit ? GPIO_LINE_DIRECTION_OUT :
> > GPIO_LINE_DIRECTION_IN;
> > =C2=A0}
> > @@ -36,35 +65,37 @@ static int adp5585_gpio_get_direction(struct gpio_c=
hip
> > *chip, unsigned int off)
> > =C2=A0static int adp5585_gpio_direction_input(struct gpio_chip *chip, u=
nsigned
> > int off)
> > =C2=A0{
> > =C2=A0	struct adp5585_gpio_dev *adp5585_gpio =3D gpiochip_get_data(chip=
);
> > -	unsigned int bank =3D ADP5585_BANK(off);
> > -	unsigned int bit =3D ADP5585_BIT(off);
> > +	const struct adp5585_regs *regs =3D adp5585_gpio->regs;
> > +	unsigned int bank =3D adp5585_gpio->info->bank(off);
> > +	unsigned int bit =3D adp5585_gpio->info->bit(off);
> > =C2=A0
> > -	return regmap_clear_bits(adp5585_gpio->regmap,
> > -				 ADP5585_GPIO_DIRECTION_A + bank, bit);
> > +	return regmap_clear_bits(adp5585_gpio->regmap, regs->gpio_dir_a +
> > bank,
> > +				 bit);
> > =C2=A0}
> > =C2=A0
> > =C2=A0static int adp5585_gpio_direction_output(struct gpio_chip *chip, =
unsigned
> > int off, int val)
> > =C2=A0{
> > =C2=A0	struct adp5585_gpio_dev *adp5585_gpio =3D gpiochip_get_data(chip=
);
> > -	unsigned int bank =3D ADP5585_BANK(off);
> > -	unsigned int bit =3D ADP5585_BIT(off);
> > +	const struct adp5585_regs *regs =3D adp5585_gpio->regs;
> > +	unsigned int bank =3D adp5585_gpio->info->bank(off);
> > +	unsigned int bit =3D adp5585_gpio->info->bit(off);
> > =C2=A0	int ret;
> > =C2=A0
> > -	ret =3D regmap_update_bits(adp5585_gpio->regmap,
> > -				 ADP5585_GPO_DATA_OUT_A + bank, bit,
> > -				 val ? bit : 0);
> > +	ret =3D regmap_update_bits(adp5585_gpio->regmap, regs->gpo_data_a +
> > bank,
> > +				 bit, val ? bit : 0);
> > =C2=A0	if (ret)
> > =C2=A0		return ret;
> > =C2=A0
> > -	return regmap_set_bits(adp5585_gpio->regmap,
> > -			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ADP5585_GPIO_DIRECTION_A + ban=
k, bit);
> > +	return regmap_set_bits(adp5585_gpio->regmap, regs->gpio_dir_a +
> > bank,
> > +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bit);
> > =C2=A0}
> > =C2=A0
> > =C2=A0static int adp5585_gpio_get_value(struct gpio_chip *chip, unsigne=
d int off)
> > =C2=A0{
> > =C2=A0	struct adp5585_gpio_dev *adp5585_gpio =3D gpiochip_get_data(chip=
);
> > -	unsigned int bank =3D ADP5585_BANK(off);
> > -	unsigned int bit =3D ADP5585_BIT(off);
> > +	const struct adp5585_regs *regs =3D adp5585_gpio->regs;
> > +	unsigned int bank =3D adp5585_gpio->info->bank(off);
> > +	unsigned int bit =3D adp5585_gpio->info->bit(off);
> > =C2=A0	unsigned int reg;
> > =C2=A0	unsigned int val;
> > =C2=A0
> > @@ -79,8 +110,8 @@ static int adp5585_gpio_get_value(struct gpio_chip *=
chip,
> > unsigned int off)
> > =C2=A0	 * .direction_input(), .direction_output() or .set() operations
> > racing
> > =C2=A0	 * with this.
> > =C2=A0	 */
> > -	regmap_read(adp5585_gpio->regmap, ADP5585_GPIO_DIRECTION_A + bank,
> > &val);
> > -	reg =3D val & bit ? ADP5585_GPO_DATA_OUT_A : ADP5585_GPI_STATUS_A;
> > +	regmap_read(adp5585_gpio->regmap, regs->gpio_dir_a + bank, &val);
> > +	reg =3D val & bit ? regs->gpo_data_a : regs->gpi_stat_a;
> > =C2=A0	regmap_read(adp5585_gpio->regmap, reg + bank, &val);
> > =C2=A0
> > =C2=A0	return !!(val & bit);
> > @@ -90,17 +121,19 @@ static int adp5585_gpio_set_value(struct gpio_chip
> > *chip, unsigned int off,
> > =C2=A0				=C2=A0 int val)
> > =C2=A0{
> > =C2=A0	struct adp5585_gpio_dev *adp5585_gpio =3D gpiochip_get_data(chip=
);
> > -	unsigned int bank =3D ADP5585_BANK(off);
> > -	unsigned int bit =3D ADP5585_BIT(off);
> > +	const struct adp5585_regs *regs =3D adp5585_gpio->regs;
> > +	unsigned int bank =3D adp5585_gpio->info->bank(off);
> > +	unsigned int bit =3D adp5585_gpio->info->bit(off);
> > =C2=A0
> > -	return regmap_update_bits(adp5585_gpio->regmap,
> > -				=C2=A0 ADP5585_GPO_DATA_OUT_A + bank,
> > +	return regmap_update_bits(adp5585_gpio->regmap, regs->gpo_data_a +
> > bank,
> > =C2=A0				=C2=A0 bit, val ? bit : 0);
> > =C2=A0}
> > =C2=A0
> > =C2=A0static int adp5585_gpio_set_bias(struct adp5585_gpio_dev *adp5585=
_gpio,
> > =C2=A0				 unsigned int off, unsigned int bias)
> > =C2=A0{
> > +	const struct adp5585_gpio_chip *info =3D adp5585_gpio->info;
> > +	const struct adp5585_regs *regs =3D adp5585_gpio->regs;
> > =C2=A0	unsigned int bit, reg, mask, val;
> > =C2=A0
> > =C2=A0	/*
> > @@ -108,8 +141,10 @@ static int adp5585_gpio_set_bias(struct
> > adp5585_gpio_dev *adp5585_gpio,
> > =C2=A0	 * consecutive registers ADP5585_RPULL_CONFIG_*, with a hole of =
4
> > bits
> > =C2=A0	 * after R5.
> > =C2=A0	 */
> > -	bit =3D off * 2 + (off > 5 ? 4 : 0);
> > -	reg =3D ADP5585_RPULL_CONFIG_A + bit / 8;
> > +	bit =3D off * 2;
> > +	if (info->has_bias_hole)
> > +		bit +=3D (off > 5 ? 4 : 0);
> > +	reg =3D regs->rpull_cfg_a + bit / 8;
> > =C2=A0	mask =3D ADP5585_Rx_PULL_CFG_MASK << (bit % 8);
> > =C2=A0	val =3D bias << (bit % 8);
> > =C2=A0
> > @@ -119,22 +154,24 @@ static int adp5585_gpio_set_bias(struct
> > adp5585_gpio_dev *adp5585_gpio,
> > =C2=A0static int adp5585_gpio_set_drive(struct adp5585_gpio_dev *adp558=
5_gpio,
> > =C2=A0				=C2=A0 unsigned int off, enum pin_config_param
> > drive)
> > =C2=A0{
> > -	unsigned int bank =3D ADP5585_BANK(off);
> > -	unsigned int bit =3D ADP5585_BIT(off);
> > +	const struct adp5585_regs *regs =3D adp5585_gpio->regs;
> > +	unsigned int bank =3D adp5585_gpio->info->bank(off);
> > +	unsigned int bit =3D adp5585_gpio->info->bit(off);
> > =C2=A0
> > =C2=A0	return regmap_update_bits(adp5585_gpio->regmap,
> > -				=C2=A0 ADP5585_GPO_OUT_MODE_A + bank, bit,
> > +				=C2=A0 regs->gpo_out_a + bank, bit,
> > =C2=A0				=C2=A0 drive =3D=3D PIN_CONFIG_DRIVE_OPEN_DRAIN ?
> > bit : 0);
> > =C2=A0}
> > =C2=A0
> > =C2=A0static int adp5585_gpio_set_debounce(struct adp5585_gpio_dev *adp=
5585_gpio,
> > =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int off, unsigned int
> > debounce)
> > =C2=A0{
> > -	unsigned int bank =3D ADP5585_BANK(off);
> > -	unsigned int bit =3D ADP5585_BIT(off);
> > +	const struct adp5585_regs *regs =3D adp5585_gpio->regs;
> > +	unsigned int bank =3D adp5585_gpio->info->bank(off);
> > +	unsigned int bit =3D adp5585_gpio->info->bit(off);
> > =C2=A0
> > =C2=A0	return regmap_update_bits(adp5585_gpio->regmap,
> > -				=C2=A0 ADP5585_DEBOUNCE_DIS_A + bank, bit,
> > +				=C2=A0 regs->debounce_dis_a + bank, bit,
> > =C2=A0				=C2=A0 debounce ? 0 : bit);
> > =C2=A0}
> > =C2=A0
> > @@ -175,6 +212,7 @@ static int adp5585_gpio_set_config(struct gpio_chip
> > *chip, unsigned int off,
> > =C2=A0static int adp5585_gpio_probe(struct platform_device *pdev)
> > =C2=A0{
> > =C2=A0	struct adp5585_dev *adp5585 =3D dev_get_drvdata(pdev->dev.parent=
);
> > +	const struct platform_device_id *id =3D platform_get_device_id(pdev);
> > =C2=A0	struct adp5585_gpio_dev *adp5585_gpio;
> > =C2=A0	struct device *dev =3D &pdev->dev;
> > =C2=A0	struct gpio_chip *gc;
> > @@ -185,6 +223,11 @@ static int adp5585_gpio_probe(struct platform_devi=
ce
> > *pdev)
> > =C2=A0		return -ENOMEM;
> > =C2=A0
> > =C2=A0	adp5585_gpio->regmap =3D adp5585->regmap;
> > +	adp5585_gpio->regs =3D adp5585->info->regs;
> > +
> > +	adp5585_gpio->info =3D (const struct adp5585_gpio_chip *)id-
> > >driver_data;
> > +	if (!adp5585_gpio->info)
> > +		return -ENODEV;
> > =C2=A0
> > =C2=A0	device_set_of_node_from_dev(dev, dev->parent);
> > =C2=A0
> > @@ -199,7 +242,7 @@ static int adp5585_gpio_probe(struct platform_devic=
e
> > *pdev)
> > =C2=A0	gc->can_sleep =3D true;
> > =C2=A0
> > =C2=A0	gc->base =3D -1;
> > -	gc->ngpio =3D ADP5585_GPIO_MAX;
> > +	gc->ngpio =3D adp5585->info->max_cols + adp5585->info->max_rows;
> > =C2=A0	gc->label =3D pdev->name;
> > =C2=A0	gc->owner =3D THIS_MODULE;
> > =C2=A0
> > @@ -211,8 +254,20 @@ static int adp5585_gpio_probe(struct platform_devi=
ce
> > *pdev)
> > =C2=A0	return 0;
> > =C2=A0}
> > =C2=A0
> > +static const struct adp5585_gpio_chip adp5585_gpio_chip_info =3D {
> > +	.bank =3D adp5585_gpio_bank,
> > +	.bit =3D adp5585_gpio_bit,
> > +	.has_bias_hole =3D true,
> > +};
> > +
> > +static const struct adp5585_gpio_chip adp5589_gpio_chip_info =3D {
> > +	.bank =3D adp5589_gpio_bank,
> > +	.bit =3D adp5589_gpio_bit,
> > +};
> > +
> > =C2=A0static const struct platform_device_id adp5585_gpio_id_table[] =
=3D {
> > -	{ "adp5585-gpio" },
> > +	{ "adp5585-gpio", (kernel_ulong_t)&adp5585_gpio_chip_info },
> > +	{ "adp5589-gpio", (kernel_ulong_t)&adp5589_gpio_chip_info },
> > =C2=A0	{ /* Sentinel */ }
> > =C2=A0};
> > =C2=A0MODULE_DEVICE_TABLE(platform, adp5585_gpio_id_table);

