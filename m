Return-Path: <linux-pwm+bounces-4627-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAB89A1097F
	for <lists+linux-pwm@lfdr.de>; Tue, 14 Jan 2025 15:34:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 627403A3DF3
	for <lists+linux-pwm@lfdr.de>; Tue, 14 Jan 2025 14:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E1E14BF87;
	Tue, 14 Jan 2025 14:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TouwAPj9"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF3F146D6E
	for <linux-pwm@vger.kernel.org>; Tue, 14 Jan 2025 14:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736865253; cv=none; b=DcDAM49q5R+iLaRgXZ4XDOLuHULMSpfavpwObBS3FTVGp7sj0c5XKg66wiGek0JUVKtaEUCBSfqwFnB7Vs/891h7iK1WmRAtOdruwQ3zth6OKbYhxw9+WGKjRnJqFFaJp/n8dWfhHedKzFZLrT6ys9yFtXWlv9HxyDf6O2O0Ltg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736865253; c=relaxed/simple;
	bh=mRqlMMYPylerixeJFEQ1XMUDpxIrxKnYicJu/8FWdOc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TfZZnqNMm0X3sbgpbdokd8Bg1egc/rJt+tnQTsxWD8ZVu3LkRG5ifyIRU3xmzAZBGUTnPtZ4zV9sP6BG+t/A0peCGal3cGjpQTXeRG5VV4pcdIwHr3XXm1QBAhOtAgPHjz9cJ8P0hSF4w3+JRrDeFCuhEEG2AZC07bBCORcjL/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TouwAPj9; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-30219437e63so60786581fa.1
        for <linux-pwm@vger.kernel.org>; Tue, 14 Jan 2025 06:34:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736865247; x=1737470047; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u/rtgGN/QLv+j3RQVDV8iMIuyZLyBwwDReBCUrqlFI4=;
        b=TouwAPj95aK/Edd0u3BC1eDpsIVeGkitYBdXQiL4MDPD2MKd/qt4eapzEn1CwfNetv
         5DWj2xR0pv/BvSFR7Mkf1jFMTqX6xuZuA6EfxLLpfVIrEnybjfYcdWoXP0k4JoCNkd0G
         j5E7R2a9pli0E+G8SrzBSC91uEAz16iYQcPYGyZJ8SCrcG+W/Pu0OhJHNCtG6h1XIluK
         bk98fev0ngKrfmzn/Y4/LCDXhOR2/qu5QEtZWTLdYPwgIm3X2IjVZ5YAeoIW4iQc1u0f
         iXXcngQHFySch08cE6xgoenPYt/ts7fj89a4sJP03oO0swTOpK6c0YEfF1MnRxgIgR+j
         6gaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736865247; x=1737470047;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u/rtgGN/QLv+j3RQVDV8iMIuyZLyBwwDReBCUrqlFI4=;
        b=vJV9rOXFgQMQ64V4fT+84vjaoGTuep17g7grDt6ElDKW7dWqdN8EMStOqXaOw6pVZS
         LfnSdfCaJJGFS3PQKhudDP2ogThmNLXXo934DdrJcemEoScFdFEYa1Rap9jCQ/HfTmk7
         h2Nr4YbW9WeCSPqSNBD/2jtQPFLuetlXB9ING2fPglD3KpwReTxiQCY1w6bfFjOBjILI
         DThRxeCZmjEsGbVL8VaeRCWYz9xTc30Ujx+93Xn/dvz+HtZTDG0XHGDkVwt8dyBPq7cs
         KEc/O5l3dZyg/oQNb7R7SZqXgnydCKUEa0LsqKHwIcOJ6r51m6RRMW/WrPbRlhhJXQD5
         yyzg==
X-Forwarded-Encrypted: i=1; AJvYcCXO1hDdJSwlTBLpx1TUq/2WlhpvN6cf664191x247JHB0dbyi1PB9mlpHNonLYOCs7Flc4ok4D93DY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx248NkNUFbZhV6f6Zif8crD/7pcKYuXDbPwgH32pqHgwTocyv+
	pNuc9koWplafnx58Z8Z4C1srru/d02ndkQns76hYYmNSQxMoZAkCWwi7RKOjd6KOycNLjQD8VoP
	eNSHqVs8BUZwDJ9dx+M0YE34oe/rKKig0Yh6S6A==
X-Gm-Gg: ASbGnctBtkOE0qk/PodJY5qaGRl+FVda142T5vGRm7M1n25QVcmOsRo+ouluY3gG0eQ
	sYLbH5oYWE5gtctoRahgmuT2dfAhKrJBGphrZ
X-Google-Smtp-Source: AGHT+IE+vz7/K0HuG0S9skrbEiWiTvx1npscF70ElA+FngUIWm7FHUa7G5bFdeVPKnq3pG6gurY1CJLKB8ScxP1gh9s=
X-Received: by 2002:a2e:bc87:0:b0:306:162d:5fbc with SMTP id
 38308e7fff4ca-306162d6437mr36405911fa.15.1736865247144; Tue, 14 Jan 2025
 06:34:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250113-mdb-max7360-support-v3-0-9519b4acb0b1@bootlin.com> <20250113-mdb-max7360-support-v3-4-9519b4acb0b1@bootlin.com>
In-Reply-To: <20250113-mdb-max7360-support-v3-4-9519b4acb0b1@bootlin.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 14 Jan 2025 15:33:55 +0100
X-Gm-Features: AbW1kva1cgvCaAn7BBZyA6Xhlcb_6Fmn62ErjKoOSbRoy3etkC67hb02bAjCC1U
Message-ID: <CACRpkdb5rmUK06uW3M2Lsy4Wam8JvrjmGM83cJa-V3LZwTX9dg@mail.gmail.com>
Subject: Re: [PATCH v3 4/7] gpio: max7360: Add MAX7360 gpio support
To: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Kamel Bouhara <kamel.bouhara@bootlin.com>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-pwm@vger.kernel.org, =?UTF-8?Q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mathieu,

thanks for your patch!

On Mon, Jan 13, 2025 at 1:43=E2=80=AFPM Mathieu Dubois-Briand
<mathieu.dubois-briand@bootlin.com> wrote:

> Add driver for Maxim Integrated MAX7360 GPIO/GPO controller.
>
> Two sets of GPIOs are provided by the device:
> - Up to 8 GPIOs, shared with the PWM and rotary encoder functionalities.
>   These GPIOs also provide interrupts on input changes.
> - Up to 6 GPOs, on unused keypad columns pins.
>
> Co-developed-by: Kamel Bouhara <kamel.bouhara@bootlin.com>
> Signed-off-by: Kamel Bouhara <kamel.bouhara@bootlin.com>
> Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
(...)
> +#include <linux/gpio/consumer.h>

Why?

My most generic feedback is if you have looked at using
select GPIO_REGMAP for this driver?

The regmap utility library is very helpful, look how other driver
selecting GPIO_REGMAP gets default implementations
from the library just git grep GPIO_REGMAP drivers/gpio/

> +static void max7360_gpio_set_value(struct gpio_chip *gc,
> +                                  unsigned int pin, int state)
> +{
> +       struct max7360_gpio *max7360_gpio =3D gpiochip_get_data(gc);
> +       int ret;
> +
> +       if (max7360_gpio->gpio_function =3D=3D MAX7360_GPIO_COL) {

OK some custom stuff...

> +               int off =3D MAX7360_MAX_GPIO - (gc->ngpio - pin);
> +
> +               ret =3D regmap_write_bits(max7360_gpio->regmap, MAX7360_R=
EG_PORTS,
> +                                       BIT(off), state ? BIT(off) : 0);

Fairly standard.

> +       } else {
> +               ret =3D regmap_write(max7360_gpio->regmap,
> +                                  MAX7360_REG_PWMBASE + pin, state ? 0xF=
F : 0);
> +       }

Some custom stuff.

> +static int max7360_gpio_get_value(struct gpio_chip *gc, unsigned int pin=
)
> +{
> +       struct max7360_gpio *max7360_gpio =3D gpiochip_get_data(gc);
> +       unsigned int val;
> +       int off;
> +       int ret;
> +
> +       if (max7360_gpio->gpio_function =3D=3D MAX7360_GPIO_COL) {
> +               off =3D MAX7360_MAX_GPIO - (gc->ngpio - pin);
> +
> +               ret =3D regmap_read(max7360_gpio->regmap, MAX7360_REG_POR=
TS, &val);
> +       } else {
> +               off =3D pin;
> +               ret =3D regmap_read(max7360_gpio->regmap, MAX7360_REG_GPI=
OIN, &val);
> +       }
> +
> +       if (ret) {
> +               dev_err(max7360_gpio->dev, "failed to read gpio-%d", pin)=
;
> +               return ret;
> +       }
> +
> +       return !!(val & BIT(off));
> +}

Looks like stock template regmap-gpio.

> +static int max7360_gpio_get_direction(struct gpio_chip *gc, unsigned int=
 pin)
> +{
> +       struct max7360_gpio *max7360_gpio =3D gpiochip_get_data(gc);
> +       unsigned int val;
> +       int ret;
> +
> +       if (max7360_gpio->gpio_function =3D=3D MAX7360_GPIO_COL)
> +               return GPIO_LINE_DIRECTION_OUT;
> +
> +       ret =3D regmap_read(max7360_gpio->regmap, MAX7360_REG_GPIOCTRL, &=
val);
> +       if (ret) {
> +               dev_err(max7360_gpio->dev, "failed to read gpio-%d direct=
ion",
> +                       pin);
> +               return ret;
> +       }
> +
> +       if (val & BIT(pin))
> +               return GPIO_LINE_DIRECTION_OUT;
> +
> +       return GPIO_LINE_DIRECTION_IN;
> +}

Dito.

> +static int max7360_gpio_direction_input(struct gpio_chip *gc, unsigned i=
nt pin)
> +{
> +       struct max7360_gpio *max7360_gpio =3D gpiochip_get_data(gc);
> +       int ret;
> +
> +       if (max7360_gpio->gpio_function =3D=3D MAX7360_GPIO_COL)
> +               return -EIO;
> +
> +       ret =3D regmap_write_bits(max7360_gpio->regmap, MAX7360_REG_GPIOC=
TRL,
> +                               BIT(pin), 0);
> +       if (ret) {
> +               dev_err(max7360_gpio->dev, "failed to set gpio-%d directi=
on",
> +                       pin);
> +               return ret;
> +       }
> +
> +       return 0;
> +}

Dito.

> +static int max7360_gpio_direction_output(struct gpio_chip *gc, unsigned =
int pin,
> +                                        int state)
> +{
> +       struct max7360_gpio *max7360_gpio =3D gpiochip_get_data(gc);
> +       int ret;
> +
> +       if (max7360_gpio->gpio_function =3D=3D MAX7360_GPIO_PORT) {
> +               ret =3D regmap_write_bits(max7360_gpio->regmap,
> +                                       MAX7360_REG_GPIOCTRL, BIT(pin),
> +                                       BIT(pin));
> +               if (ret) {
> +                       dev_err(max7360_gpio->dev,
> +                               "failed to set gpio-%d direction", pin);
> +                       return ret;
> +               }
> +       }
> +
> +       max7360_gpio_set_value(gc, pin, state);
> +
> +       return 0;
> +}

Dito.

> +static int max7360_gpio_request(struct gpio_chip *gc, unsigned int pin)
> +{
> +       struct max7360_gpio *max7360_gpio =3D gpiochip_get_data(gc);
> +
> +       /*
> +        * GPOs on COL pins (keypad columns) can always be requested: thi=
s
> +        * driver has full access to them, up to the number set in chip.n=
gpio.
> +        * GPIOs on PORT pins are shared with the PWM and rotary encoder
> +        * drivers: they have to be requested from the MFD driver.
> +        */
> +       if (max7360_gpio->gpio_function =3D=3D MAX7360_GPIO_COL)
> +               return 0;
> +
> +       return max7360_port_pin_request(max7360_gpio->dev->parent, pin, t=
rue);
> +}
> +
> +static void max7360_gpio_free(struct gpio_chip *gc, unsigned int pin)
> +{
> +       struct max7360_gpio *max7360_gpio =3D gpiochip_get_data(gc);
> +
> +       if (max7360_gpio->gpio_function =3D=3D MAX7360_GPIO_COL)
> +               return;
> +
> +       max7360_port_pin_request(max7360_gpio->dev->parent, pin, false);
> +}

The pin request looks a bit like a custom pin control implementation...

But I think it's fine, pin control can be a bit heavy to implement on simpl=
e
devices, but if there is elaborate muxing and config going on, pin control
should be used.

Yours,
Linus Walleij

