Return-Path: <linux-pwm+bounces-3358-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF680984CD7
	for <lists+linux-pwm@lfdr.de>; Tue, 24 Sep 2024 23:25:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 341821F21B57
	for <lists+linux-pwm@lfdr.de>; Tue, 24 Sep 2024 21:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA1C613FD86;
	Tue, 24 Sep 2024 21:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LC3r0Ajp"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A874013D251;
	Tue, 24 Sep 2024 21:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727212951; cv=none; b=T6jGMCr8wNxPVJje/IHHiywhwpt7odtzJuy64ZgaUm6uHDjMtj2QCtLf03NWoWH5lK7Y16chGjSUF/75qi9yWmQAnr69XAHvS4xHx3RpupyhG6xPAaGXK6k1lDxa0bsDo8/W8phF+Uv3Bl1WP5zBb4xRRo/trKTAbspdd7tt34c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727212951; c=relaxed/simple;
	bh=ORN8sDOxLyn58T65c1ZiKJe2Tx746oGRCmfs/xV060s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e9xFOAmFcd6ut4+hT+Ve82ydqceOBM0ogH4NKW0wZxRI/IqzqH3IJVkRDFo8GRu34H6HT3SbJbT9dg/VBZZNYInnJEnTxkLQpmD8fgj5/bB3zYe6buxT8ysT64QeLt+mCwSwrexsbsi6U5cVz/OUug0KM+2JczlRFmuDqo9BpS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LC3r0Ajp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F545C4CECD;
	Tue, 24 Sep 2024 21:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727212951;
	bh=ORN8sDOxLyn58T65c1ZiKJe2Tx746oGRCmfs/xV060s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LC3r0AjpUcP/CLjxzfq8ze/z2K+GqMsZdPos87MLlSua4xCqhNuyX2SlqI5yScJwk
	 dckS1FF9q73Ewk6gV1EpMgnMMNQxx7IxS0FzW1RNuH2Q4qRr/VBCru+sSvVMxsk0ET
	 +2HuJtamH6NeE6sRNsY4A7sfU1xysodQI3aEujAuSIP2mEOK3cX//30wW+6/p3ewby
	 APDVXz+UsumblA4hVP0vseua2oMIB1sdvTkxdFQHKjpsbfLR43uNGTWZMqKuEHLuXv
	 HWEigbUrdGVC1MPYmSS4aLSQPZX4bzpS9+vVCJKwGkFvzR9CTxtSqfQyadZugkHdmS
	 HoUAIt3yGrUCw==
Date: Tue, 24 Sep 2024 23:22:28 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sean Wang <sean.wang@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Lee Jones <lee@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	upstream@airoha.com, benjamin.larsson@genexis.eu,
	ansuelsmth@gmail.com, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v4 4/5] pinctrl: airoha: Add support for EN7581 SoC
Message-ID: <ZvMtlJN1xAMHoW-E@lore-desk>
References: <20240911-en7581-pinctrl-v4-0-60ac93d760bb@kernel.org>
 <20240911-en7581-pinctrl-v4-4-60ac93d760bb@kernel.org>
 <CACRpkdZbyQ5bk8oR+Q4UmQCdM5h1mF1ztBc26YzqNsze_B=ehA@mail.gmail.com>
 <ZvKQe73ZKIFy4fny@lore-desk>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="NZtxAZ5/yN8ueZoO"
Content-Disposition: inline
In-Reply-To: <ZvKQe73ZKIFy4fny@lore-desk>


--NZtxAZ5/yN8ueZoO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[...]
>=20
> I am fine to switch to regmap but I guess we need to enable fast_io
> since it can run even in interrupt context. Btw, I figured out even
> airoha_pinctrl_rmw needs to grab a spin_lock since we can exec a led
> trigger (like timer) where we run airoha_pinctrl_rmw in interrupt context
> (so it should be fine to use a single regmap for it).
> However, I guess we need to keep the spin_lock in airoha_pinctrl_gpiochip
> since we need to grab it in airoha_pinctrl_gpio_irq_unmask() and
> airoha_pinctrl_gpio_irq_type() (we access irq_type array there).
> A possible solution would be to keep the local spin_lock and set
> disable_locking. What do you think? Do you prefer to switch to regmap or
> keep the current implementation using 'guard(spinlock_irqsave)' instead?

I reworked the code using regmap APIs and setting disable_locking flag
in order to keep the spinlock local (I switch to guard(spinlock) as
well). Thx for pointing this out, the code is simpler and more readable,
I will add it in v5.

>=20
> >=20
> > > +static int airoha_pinctrl_get_gpio_from_pin(struct pinctrl_dev *pctr=
l_dev,
> > > +                                           int pin)
> > > +{
> > > +       struct pinctrl_gpio_range *range;
> > > +       int gpio;
> > > +
> > > +       range =3D pinctrl_find_gpio_range_from_pin_nolock(pctrl_dev, =
pin);
> > > +       if (!range)
> > > +               return -EINVAL;
> > > +
> > > +       gpio =3D pin - range->pin_base;
> > > +       if (gpio < 0)
> > > +               return -EINVAL;
> > > +
> > > +       return gpio;
> > > +}
> >=20
> > This function is just used here:
>=20
> it is used in airoha_pinconf_get()/airoha_pinconf_set()
>=20
> >=20

[...]

> > > +       case PIN_CONFIG_OUTPUT_ENABLE:
> > > +       case PIN_CONFIG_INPUT_ENABLE: {
> > > +               int gpio =3D airoha_pinctrl_get_gpio_from_pin(pctrl_d=
ev, pin);
> > > +
> > > +               if (gpio < 0)
> > > +                       return gpio;
> > > +
> > > +               arg =3D airoha_pinctrl_gpio_get_direction(pinctrl, gp=
io);
> >=20
> > I don't see why a pin would have to exist in a GPIO range in order to
> > be set as output or input?
> >=20
> > Can't you just set up the pin as requested and not care whether
> > it has a corresponding GPIO range?
> >=20
> > Is it over-reuse of the GPIO code? I'd say just set up the pin instead.
>=20
> Do you mean to get rid of PIN_CONFIG_OUTPUT_ENABLE, PIN_CONFIG_INPUT_ENAB=
LE
> (and even PIN_CONFIG_OUTPUT in airoha_pinconf_set()) here?
> E.g. we need PIN_CONFIG_OUTPUT_ENABLE to enable pwm for pwm-leds:
>=20
> &mfd {
> 	...
> 	pio: pinctrl {
> 		...
> 		pwm_gpio18_idx10_pins: pwm-gpio18-idx10-pins {
> 			function =3D "pwm";
> 			pins =3D "gpio18";
> 			output-enable;
> 		};
> 	};
> };

I reworked the code here in order to not explicitly use gpio value in
airoha_pinconf_get/airoha_pinconf_set routines. However, we need to switch
=66rom pin to gpio configuring data/direction/out hw registers since:
- not all pins can be used as gpio (actually we can configure just pins in =
the
  range [13, 59])
- data, dir and out hw register are indexed using gpio id and not pin one.
  (e.g BIT(0) in data[0] refers to GPIO0 and not to PIN0).

Regards,
Lorenzo

>=20
> >=20
> > > +static int airoha_pinconf_set(struct pinctrl_dev *pctrl_dev,
> > > +                             unsigned int pin, unsigned long *config=
s,
> > > +                             unsigned int num_configs)
> > > +{
> > > +       struct airoha_pinctrl *pinctrl =3D pinctrl_dev_get_drvdata(pc=
trl_dev);
> > > +       int i;
> > > +
> > > +       for (i =3D 0; i < num_configs; i++) {
> > > +               u32 param =3D pinconf_to_config_param(configs[i]);
> > > +               u32 arg =3D pinconf_to_config_argument(configs[i]);
> > > +
> > > +               switch (param) {
> > > +               case PIN_CONFIG_BIAS_DISABLE:
> > > +                       airoha_pinctrl_set_pulldown_conf(pinctrl, pin=
, 0);
> > > +                       airoha_pinctrl_set_pullup_conf(pinctrl, pin, =
0);
> > > +                       break;
> > > +               case PIN_CONFIG_BIAS_PULL_UP:
> > > +                       airoha_pinctrl_set_pulldown_conf(pinctrl, pin=
, 0);
> > > +                       airoha_pinctrl_set_pullup_conf(pinctrl, pin, =
1);
> > > +                       break;
> > > +               case PIN_CONFIG_BIAS_PULL_DOWN:
> > > +                       airoha_pinctrl_set_pulldown_conf(pinctrl, pin=
, 1);
> > > +                       airoha_pinctrl_set_pullup_conf(pinctrl, pin, =
0);
> > > +                       break;
> > > +               case PIN_CONFIG_DRIVE_STRENGTH: {
> > > +                       u32 e2 =3D 0, e4 =3D 0;
> > > +
> > > +                       switch (arg) {
> > > +                       case MTK_DRIVE_2mA:
> > > +                               break;
> > > +                       case MTK_DRIVE_4mA:
> > > +                               e2 =3D 1;
> > > +                               break;
> > > +                       case MTK_DRIVE_6mA:
> > > +                               e4 =3D 1;
> > > +                               break;
> > > +                       case MTK_DRIVE_8mA:
> > > +                               e2 =3D 1;
> > > +                               e4 =3D 1;
> > > +                               break;
> > > +                       default:
> > > +                               return -EINVAL;
> > > +                       }
> > > +
> > > +                       airoha_pinctrl_set_drive_e2_conf(pinctrl, pin=
, e2);
> > > +                       airoha_pinctrl_set_drive_e4_conf(pinctrl, pin=
, e4);
> > > +                       break;
> > > +               }
> > > +               case PIN_CONFIG_DRIVE_OPEN_DRAIN:
> > > +                       airoha_pinctrl_set_pcie_rst_od_conf(pinctrl, =
pin, !!arg);
> > > +                       break;
> > > +               case PIN_CONFIG_OUTPUT_ENABLE:
> > > +               case PIN_CONFIG_INPUT_ENABLE:
> > > +               case PIN_CONFIG_OUTPUT: {
> > > +                       int gpio =3D airoha_pinctrl_get_gpio_from_pin=
(pctrl_dev, pin);
> > > +                       bool input =3D param =3D=3D PIN_CONFIG_INPUT_=
ENABLE;
> > > +
> > > +                       if (gpio < 0)
> > > +                               return gpio;
> > > +
> > > +                       airoha_pinctrl_gpio_set_direction(pinctrl, gp=
io, input);
> > > +                       if (param =3D=3D PIN_CONFIG_OUTPUT)
> > > +                               airoha_pinctrl_gpio_set_value(pinctrl=
, gpio, !!arg);
> > > +                       break;
> >=20
> > Dito. No need to reuse the GPIO set direction function. Make a helper
> > that just work on the pin instead, and perhaps the GPIO set direction
> > can use that instead.
>=20
> ack, I will fix it in v5.
>=20
> >=20
> > > +static int airoha_pinctrl_gpio_direction_output(struct gpio_chip *ch=
ip,
> > > +                                               unsigned int gpio, in=
t value)
> > > +{
> > > +       int err;
> > > +
> > > +       err =3D pinctrl_gpio_direction_output(chip, gpio);
> > > +       if (err)
> > > +               return err;
> > > +
> > > +       airoha_pinctrl_gpio_set(chip, gpio, value);
> >=20
> > Hm I get a bit confused by the similarly named helpers I guess...
>=20
> Naming is always hard, I will try to improve :)
>=20
> >=20
> > > +static void airoha_pinctrl_gpio_irq_unmask(struct irq_data *data)
> > > +{
> > > +       u8 offset =3D data->hwirq % AIROHA_REG_GPIOCTRL_NUM_GPIO;
> > > +       u8 index =3D data->hwirq / AIROHA_REG_GPIOCTRL_NUM_GPIO;
> > > +       u32 mask =3D GENMASK(2 * offset + 1, 2 * offset);
> > > +       struct airoha_pinctrl_gpiochip *gpiochip;
> > > +       u32 val =3D BIT(2 * offset);
> > > +       unsigned long flags;
> > > +
> > > +       gpiochip =3D irq_data_get_irq_chip_data(data);
> > > +       if (WARN_ON_ONCE(data->hwirq >=3D ARRAY_SIZE(gpiochip->irq_ty=
pe)))
> > > +               return;
> > > +
> > > +       spin_lock_irqsave(&gpiochip->lock, flags);
> >=20
> > Use a scoped guard here
> >=20
> > guard(spinlock_irqsave)(&gpiochip->lock);
> >=20
> > > +static void airoha_pinctrl_gpio_irq_mask(struct irq_data *data)
> > > +{
> > > +       u8 offset =3D data->hwirq % AIROHA_REG_GPIOCTRL_NUM_GPIO;
> > > +       u8 index =3D data->hwirq / AIROHA_REG_GPIOCTRL_NUM_GPIO;
> > > +       u32 mask =3D GENMASK(2 * offset + 1, 2 * offset);
> > > +       struct airoha_pinctrl_gpiochip *gpiochip;
> > > +       unsigned long flags;
> > > +
> > > +       gpiochip =3D irq_data_get_irq_chip_data(data);
> > > +
> > > +       spin_lock_irqsave(&gpiochip->lock, flags);
> >=20
> > Dito
> >=20
> > > +static int airoha_pinctrl_gpio_irq_type(struct irq_data *data,
> > > +                                       unsigned int type)
> > > +{
> > > +       struct airoha_pinctrl_gpiochip *gpiochip;
> > > +       unsigned long flags;
> > > +
> > > +       gpiochip =3D irq_data_get_irq_chip_data(data);
> > > +       if (data->hwirq >=3D ARRAY_SIZE(gpiochip->irq_type))
> > > +               return -EINVAL;
> > > +
> > > +       spin_lock_irqsave(&gpiochip->lock, flags);
> >=20
> > Dito
> >=20
> > > +       girq->chip =3D devm_kzalloc(dev, sizeof(*girq->chip), GFP_KER=
NEL);
> > > +       if (!girq->chip)
> > > +               return -ENOMEM;
> > > +
> > > +       girq->chip->name =3D dev_name(dev);
> > > +       girq->chip->irq_unmask =3D airoha_pinctrl_gpio_irq_unmask;
> > > +       girq->chip->irq_mask =3D airoha_pinctrl_gpio_irq_mask;
> > > +       girq->chip->irq_mask_ack =3D airoha_pinctrl_gpio_irq_mask;
> > > +       girq->chip->irq_set_type =3D airoha_pinctrl_gpio_irq_type;
> > > +       girq->chip->flags =3D IRQCHIP_SET_TYPE_MASKED | IRQCHIP_IMMUT=
ABLE;
> > > +       girq->default_type =3D IRQ_TYPE_NONE;
> > > +       girq->handler =3D handle_simple_irq;
> >=20
> > If the irqchip is immutable it is const and there is no point to malloc=
 it.
> >=20
> > Just
> >=20
> > static const struct irq_chip airoha_gpio_irq_chip =3D {...
> >=20
> > And assign it:
> >=20
> > girq =3D &g->gc.irq;
> > gpio_irq_chip_set_chip(girq, &airoha_gpio_irq_chip);
>=20
> ack, I will fix it in v5.
>=20
> Regards,
> Lorenzo
>=20
> >=20
> > Yours,
> > Linus Walleij



--NZtxAZ5/yN8ueZoO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZvMtlAAKCRA6cBh0uS2t
rNZFAQDh1TQOTGsS6AJYn4S0E1QSvJxVk5y3yGM385PlB1UoHAEA8edZ+wyz5q9H
yo2JKGgyRdNvxRP0tcPbnjEYEvDbnAg=
=6/CL
-----END PGP SIGNATURE-----

--NZtxAZ5/yN8ueZoO--

