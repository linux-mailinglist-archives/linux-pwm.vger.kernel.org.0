Return-Path: <linux-pwm+bounces-4629-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF9FA10EB7
	for <lists+linux-pwm@lfdr.de>; Tue, 14 Jan 2025 19:00:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CC461885B8C
	for <lists+linux-pwm@lfdr.de>; Tue, 14 Jan 2025 18:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1D4C207643;
	Tue, 14 Jan 2025 17:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="R4RWdRTH"
X-Original-To: linux-pwm@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C5E2066CE;
	Tue, 14 Jan 2025 17:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736877476; cv=none; b=okllLSkpfQqYXB4J5jCYqASs0qwhdIS/PWoPNHdT3f00AflwMF0GxsbrjWz/BKcILFdxo024Qgv719TfZ463ywB1GHdsPD38DgJX3KkgpDyEgsnJZo2ZiO7vGV1VuHejrNXSKQWuM9x9GyC0JuMZYjkmDyRAx9r48pxkiumO6oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736877476; c=relaxed/simple;
	bh=SgFT1UWpPmVo0Y98co/q2WsoNw9++nsxnDkJ/dhtUQc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=guCYoW2ANpgVF59PW+MxMUcEfDnU0YyzlWPMcJ9y6kPOs84pSRmIara5cQ9KgdjkzQAil8qwRZuIIJ1sETaXLSGX8lQrxqt/RlhwsepNIFXawRN1uNkcxt2tyDepuCcDWxDWG0ZB07qsPzUPmCX4oBK9Qq2Y184wKj/n8PNtel0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=R4RWdRTH; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id ED70A240003;
	Tue, 14 Jan 2025 17:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1736877466;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lzZWLx1qDKjqrP+46ITVilq+OsTRK7y1u7bGvKmKqbA=;
	b=R4RWdRTHBej/D5sjufp9dYMMS3NyDJEYWbAs52H+nvubOO+0oLxu4RuLpEHo3kS0WFseaP
	jNlglDrZGzpIuJsjsdITohg2lOF4LSEDIwI4eF6EZmTYixzJQ4jBXnWt0rqY0LbeBlkTDo
	Ltj+UeQcYGyUVLPkPwz67qCk6aviHI8yeOc/aqhn7ESmVJGsyco4MhKP5R0hu4HTe4b0qQ
	XLoNmm9tSdECZLJPXgggBWpkl4N50EI1+I9xDXPLt+biF2rObEvIziMf35EqRZn0sJmMBM
	TxpvSrZi0lQW0RRVrM7KA0ARp251YoYNWCQHzCSevA2XVaRdBkKfrmPWa81VsQ==
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 14 Jan 2025 18:57:45 +0100
Message-Id: <D71ZOCDV6CTL.G3BF0PKHLUTU@bootlin.com>
Subject: Re: [PATCH v3 4/7] gpio: max7360: Add MAX7360 gpio support
Cc: "Lee Jones" <lee@kernel.org>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley"
 <conor+dt@kernel.org>, "Kamel Bouhara" <kamel.bouhara@bootlin.com>,
 "Bartosz Golaszewski" <brgl@bgdev.pl>, "Dmitry Torokhov"
 <dmitry.torokhov@gmail.com>, =?utf-8?q?Uwe_Kleine-K=C3=B6nig?=
 <ukleinek@kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
 <linux-input@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
 =?utf-8?q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>, "Thomas
 Petazzoni" <thomas.petazzoni@bootlin.com>
From: "Mathieu Dubois-Briand" <mathieu.dubois-briand@bootlin.com>
To: "Linus Walleij" <linus.walleij@linaro.org>
X-Mailer: aerc 0.18.2-0-ge037c095a049
References: <20250113-mdb-max7360-support-v3-0-9519b4acb0b1@bootlin.com>
 <20250113-mdb-max7360-support-v3-4-9519b4acb0b1@bootlin.com>
 <CACRpkdb5rmUK06uW3M2Lsy4Wam8JvrjmGM83cJa-V3LZwTX9dg@mail.gmail.com>
In-Reply-To: <CACRpkdb5rmUK06uW3M2Lsy4Wam8JvrjmGM83cJa-V3LZwTX9dg@mail.gmail.com>
X-GND-Sasl: mathieu.dubois-briand@bootlin.com

On Tue Jan 14, 2025 at 3:33 PM CET, Linus Walleij wrote:
> Hi Mathieu,
>
> thanks for your patch!
>
> On Mon, Jan 13, 2025 at 1:43=E2=80=AFPM Mathieu Dubois-Briand
> <mathieu.dubois-briand@bootlin.com> wrote:
>
> > Add driver for Maxim Integrated MAX7360 GPIO/GPO controller.
> >
> > Two sets of GPIOs are provided by the device:
> > - Up to 8 GPIOs, shared with the PWM and rotary encoder functionalities=
.
> >   These GPIOs also provide interrupts on input changes.
> > - Up to 6 GPOs, on unused keypad columns pins.
> >
> > Co-developed-by: Kamel Bouhara <kamel.bouhara@bootlin.com>
> > Signed-off-by: Kamel Bouhara <kamel.bouhara@bootlin.com>
> > Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com=
>
> (...)
> > +#include <linux/gpio/consumer.h>
>
> Why?
>
> My most generic feedback is if you have looked at using
> select GPIO_REGMAP for this driver?
>
> The regmap utility library is very helpful, look how other driver
> selecting GPIO_REGMAP gets default implementations
> from the library just git grep GPIO_REGMAP drivers/gpio/
>

Thanks, I was not aware of that. I tested it and I should be able to get
rid of a lot of code using GPIO_REGMAP.

My main concern so far is with the request()/free() functions, as I
believe I will not be able to define them as callback anymore.

I also saw the equivalent REGMAP_IRQ, but I'm not sure I will be able to
use it, as I believe I would need to have registers identifying the
exact GPIO source of the IRQ.

> > +static void max7360_gpio_set_value(struct gpio_chip *gc,
> > +                                  unsigned int pin, int state)
> > +{
> > +       struct max7360_gpio *max7360_gpio =3D gpiochip_get_data(gc);
> > +       int ret;
> > +
> > +       if (max7360_gpio->gpio_function =3D=3D MAX7360_GPIO_COL) {
>
> OK some custom stuff...
>
> > +               int off =3D MAX7360_MAX_GPIO - (gc->ngpio - pin);
> > +
> > +               ret =3D regmap_write_bits(max7360_gpio->regmap, MAX7360=
_REG_PORTS,
> > +                                       BIT(off), state ? BIT(off) : 0)=
;
>
> Fairly standard.
>
> > +       } else {
> > +               ret =3D regmap_write(max7360_gpio->regmap,
> > +                                  MAX7360_REG_PWMBASE + pin, state ? 0=
xFF : 0);
> > +       }
>
> Some custom stuff.
>
> > +static int max7360_gpio_get_value(struct gpio_chip *gc, unsigned int p=
in)
> > +{
> > +       struct max7360_gpio *max7360_gpio =3D gpiochip_get_data(gc);
> > +       unsigned int val;
> > +       int off;
> > +       int ret;
> > +
> > +       if (max7360_gpio->gpio_function =3D=3D MAX7360_GPIO_COL) {
> > +               off =3D MAX7360_MAX_GPIO - (gc->ngpio - pin);
> > +
> > +               ret =3D regmap_read(max7360_gpio->regmap, MAX7360_REG_P=
ORTS, &val);
> > +       } else {
> > +               off =3D pin;
> > +               ret =3D regmap_read(max7360_gpio->regmap, MAX7360_REG_G=
PIOIN, &val);
> > +       }
> > +
> > +       if (ret) {
> > +               dev_err(max7360_gpio->dev, "failed to read gpio-%d", pi=
n);
> > +               return ret;
> > +       }
> > +
> > +       return !!(val & BIT(off));
> > +}
>
> Looks like stock template regmap-gpio.
>
> > +static int max7360_gpio_get_direction(struct gpio_chip *gc, unsigned i=
nt pin)
> > +{
> > +       struct max7360_gpio *max7360_gpio =3D gpiochip_get_data(gc);
> > +       unsigned int val;
> > +       int ret;
> > +
> > +       if (max7360_gpio->gpio_function =3D=3D MAX7360_GPIO_COL)
> > +               return GPIO_LINE_DIRECTION_OUT;
> > +
> > +       ret =3D regmap_read(max7360_gpio->regmap, MAX7360_REG_GPIOCTRL,=
 &val);
> > +       if (ret) {
> > +               dev_err(max7360_gpio->dev, "failed to read gpio-%d dire=
ction",
> > +                       pin);
> > +               return ret;
> > +       }
> > +
> > +       if (val & BIT(pin))
> > +               return GPIO_LINE_DIRECTION_OUT;
> > +
> > +       return GPIO_LINE_DIRECTION_IN;
> > +}
>
> Dito.
>
> > +static int max7360_gpio_direction_input(struct gpio_chip *gc, unsigned=
 int pin)
> > +{
> > +       struct max7360_gpio *max7360_gpio =3D gpiochip_get_data(gc);
> > +       int ret;
> > +
> > +       if (max7360_gpio->gpio_function =3D=3D MAX7360_GPIO_COL)
> > +               return -EIO;
> > +
> > +       ret =3D regmap_write_bits(max7360_gpio->regmap, MAX7360_REG_GPI=
OCTRL,
> > +                               BIT(pin), 0);
> > +       if (ret) {
> > +               dev_err(max7360_gpio->dev, "failed to set gpio-%d direc=
tion",
> > +                       pin);
> > +               return ret;
> > +       }
> > +
> > +       return 0;
> > +}
>
> Dito.
>
> > +static int max7360_gpio_direction_output(struct gpio_chip *gc, unsigne=
d int pin,
> > +                                        int state)
> > +{
> > +       struct max7360_gpio *max7360_gpio =3D gpiochip_get_data(gc);
> > +       int ret;
> > +
> > +       if (max7360_gpio->gpio_function =3D=3D MAX7360_GPIO_PORT) {
> > +               ret =3D regmap_write_bits(max7360_gpio->regmap,
> > +                                       MAX7360_REG_GPIOCTRL, BIT(pin),
> > +                                       BIT(pin));
> > +               if (ret) {
> > +                       dev_err(max7360_gpio->dev,
> > +                               "failed to set gpio-%d direction", pin)=
;
> > +                       return ret;
> > +               }
> > +       }
> > +
> > +       max7360_gpio_set_value(gc, pin, state);
> > +
> > +       return 0;
> > +}
>
> Dito.
>
> > +static int max7360_gpio_request(struct gpio_chip *gc, unsigned int pin=
)
> > +{
> > +       struct max7360_gpio *max7360_gpio =3D gpiochip_get_data(gc);
> > +
> > +       /*
> > +        * GPOs on COL pins (keypad columns) can always be requested: t=
his
> > +        * driver has full access to them, up to the number set in chip=
.ngpio.
> > +        * GPIOs on PORT pins are shared with the PWM and rotary encode=
r
> > +        * drivers: they have to be requested from the MFD driver.
> > +        */
> > +       if (max7360_gpio->gpio_function =3D=3D MAX7360_GPIO_COL)
> > +               return 0;
> > +
> > +       return max7360_port_pin_request(max7360_gpio->dev->parent, pin,=
 true);
> > +}
> > +
> > +static void max7360_gpio_free(struct gpio_chip *gc, unsigned int pin)
> > +{
> > +       struct max7360_gpio *max7360_gpio =3D gpiochip_get_data(gc);
> > +
> > +       if (max7360_gpio->gpio_function =3D=3D MAX7360_GPIO_COL)
> > +               return;
> > +
> > +       max7360_port_pin_request(max7360_gpio->dev->parent, pin, false)=
;
> > +}
>
> The pin request looks a bit like a custom pin control implementation...
>
> But I think it's fine, pin control can be a bit heavy to implement on sim=
ple
> devices, but if there is elaborate muxing and config going on, pin contro=
l
> should be used.

Just so remove any doubt, all this does is request the pin for the
exclusive use of this driver, preventing the PWM or rotary encoder
drivers to use it. There is no hardware configuration done here.

Yet I agree that this does look a bit like some pin muxing.

>
> Yours,
> Linus Walleij

Thanks for your review.


--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


