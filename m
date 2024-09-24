Return-Path: <linux-pwm+bounces-3352-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F06C984336
	for <lists+linux-pwm@lfdr.de>; Tue, 24 Sep 2024 12:12:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F561281CA0
	for <lists+linux-pwm@lfdr.de>; Tue, 24 Sep 2024 10:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3EFF16E860;
	Tue, 24 Sep 2024 10:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dGPE0KNZ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73FD615B56E;
	Tue, 24 Sep 2024 10:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727172734; cv=none; b=sAngKONxRzX4y+jBfXLvflv+f+cySR0bY1dFXzZuDDIba8cMspyq+7vnmNPO/oNCcKJwmZDEhq6phBAoRiqojbgVQjDb2DgaiEmLsUT5FDTANzXC/f5M7X0La4HV7Gjat15feGKBxpV4ykAS6+KJhVW9MveTWAVOF+FCUYk/wyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727172734; c=relaxed/simple;
	bh=L8nehSf1ZOWTYA7cXJfnk7AMsnnjUPB0KMCQdqx1vvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aE9yVX/4G/4OAElSkV/vcbYNqjfovqTGEiU3+QqZKTrI+cMQoM1EpiefL1T0A8I1h8zx0gf3sLKDTKGgWztW2oQfKJm40oOYKucrmk2GEcMjwjAMGiNYoFr6fiKEP8K0VWc9zAiwnvcY+y2whN2Z8b2FIz4NrtoZPkcme7N+7oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dGPE0KNZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2968C4CEC4;
	Tue, 24 Sep 2024 10:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727172734;
	bh=L8nehSf1ZOWTYA7cXJfnk7AMsnnjUPB0KMCQdqx1vvc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dGPE0KNZWP7YRM5BS/k4gZtY4TbZr6vYgqkmBMXed8fatRJdCyT2sfvxuAoRJTRlU
	 p+6EMeDhKgEGdxBDlnkMNTGtti/a5AS9ScNaEPNHQkFEVvWMopblMKjW9lqLvQ+HwB
	 C5JltiFiov4SLtPEco1w/7W2PridJU50+qxQ64GYxu+YhudSIivmdj71FpTnZcveFA
	 QA/i9NcDQwFzc1etWvEL73QGx0/uRSSdJBjDVzxxIv9dqa2MTs+g55Ve2EC/ZS1d8x
	 Gs4b2n7Cw2FqMyslME+HrDU2XM7tW7LTatIMYly8Ye9LqY/Ci1wtgpn4hBTUfr5C7H
	 Fz7OulLApdbyg==
Date: Tue, 24 Sep 2024 12:12:11 +0200
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
Message-ID: <ZvKQe73ZKIFy4fny@lore-desk>
References: <20240911-en7581-pinctrl-v4-0-60ac93d760bb@kernel.org>
 <20240911-en7581-pinctrl-v4-4-60ac93d760bb@kernel.org>
 <CACRpkdZbyQ5bk8oR+Q4UmQCdM5h1mF1ztBc26YzqNsze_B=ehA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="odZwuQpJyyMuG14N"
Content-Disposition: inline
In-Reply-To: <CACRpkdZbyQ5bk8oR+Q4UmQCdM5h1mF1ztBc26YzqNsze_B=ehA@mail.gmail.com>


--odZwuQpJyyMuG14N
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Hi Lorenzo / Benjamin,
>=20
> thanks for your patch!
>=20
> This is a real nice driver, I like the design of the pin database to supp=
ort
> this pretty complex pin controller.

Hi Linus,

thx for the review, some questions inline.

Regards,
Lorenzo

>=20
> Some comments and nits:
>=20
> On Wed, Sep 11, 2024 at 9:51=E2=80=AFPM Lorenzo Bianconi <lorenzo@kernel.=
org> wrote:
>=20
> > Introduce pinctrl driver for EN7581 SoC. Current EN7581 pinctrl driver
> > supports the following functionalities:
> > - pin multiplexing
> > - pin pull-up, pull-down, open-drain, current strength,
> >   {input,output}_enable, output_{low,high}
> > - gpio controller
> > - irq controller
> >
> > Tested-by: Benjamin Larsson <benjamin.larsson@genexis.eu>
> > Co-developed-by: Benjamin Larsson <benjamin.larsson@genexis.eu>
> > Signed-off-by: Benjamin Larsson <benjamin.larsson@genexis.eu>
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
>=20
> (...)
>=20
> > +#include <dt-bindings/pinctrl/mt65xx.h>
> > +#include <linux/bitfield.h>
>=20
> Isn't just <linux/bits.h> enough for what you're using?

ack, I will fix it in v5

>=20
> > +#include <linux/gpio/driver.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/io.h>
> > +#include <linux/irq.h>
> > +#include <linux/irqdomain.h>
> > +#include <linux/kernel.h>
>=20
> What do you use from kernel.h? We usually use more fingrained
> headers these days.

ack, I will remove it in v5

>=20
> (...)
>=20
> > +#include <linux/mfd/airoha-en7581-mfd.h>
> > +#include <linux/mfd/syscon.h>
> > +#include <linux/of.h>
> > +#include <linux/of_irq.h>
> > +#include <linux/of_platform.h>
> > +#include <linux/pinctrl/consumer.h>
>=20
> Why do you need the consumer header?

we need it for pinctrl_gpio_direction_output() and
pinctrl_gpio_direction_input() for direction_input and direction_output
callbacks.

>=20
> (...)
>=20
> > +static u32 airoha_pinctrl_rmw_unlock(void __iomem *addr, u32 mask, u32=
 val)
> > +{
> > +       val |=3D (readl(addr) & ~mask);
> > +       writel(val, addr);
> > +
> > +       return val;
> > +}
> > +
> > +#define airoha_pinctrl_set_unlock(addr, val)                          =
         \
> > +       airoha_pinctrl_rmw_unlock((addr), 0, (val))
> > +#define airoha_pinctrl_clear_unlock(addr, mask)                       =
                 \
> > +       airoha_pinctrl_rmw_unlock((addr), (mask), (0))
> > +
> > +static u32 airoha_pinctrl_rmw(struct airoha_pinctrl *pinctrl,
> > +                             void __iomem *addr, u32 mask, u32 val)
> > +{
> > +       mutex_lock(&pinctrl->mutex);
> > +       val =3D airoha_pinctrl_rmw_unlock(addr, mask, val);
> > +       mutex_unlock(&pinctrl->mutex);
> > +
> > +       return val;
> > +}
>=20
> Thus looks like a reimplementation of regmap-mmio, can't you just use
> regmap MMIO? You use it for the SCU access already...
>=20
> If you persist with this solution, please use a guard:
>=20
> #include <linux/cleanup.h>
>=20
> guard(mutex)(&pinctrl->mutex);
>=20
> And the lock will be released when you exit the function.

I am fine to switch to regmap but I guess we need to enable fast_io
since it can run even in interrupt context. Btw, I figured out even
airoha_pinctrl_rmw needs to grab a spin_lock since we can exec a led
trigger (like timer) where we run airoha_pinctrl_rmw in interrupt context
(so it should be fine to use a single regmap for it).
However, I guess we need to keep the spin_lock in airoha_pinctrl_gpiochip
since we need to grab it in airoha_pinctrl_gpio_irq_unmask() and
airoha_pinctrl_gpio_irq_type() (we access irq_type array there).
A possible solution would be to keep the local spin_lock and set
disable_locking. What do you think? Do you prefer to switch to regmap or
keep the current implementation using 'guard(spinlock_irqsave)' instead?

>=20
> > +static int airoha_pinctrl_get_gpio_from_pin(struct pinctrl_dev *pctrl_=
dev,
> > +                                           int pin)
> > +{
> > +       struct pinctrl_gpio_range *range;
> > +       int gpio;
> > +
> > +       range =3D pinctrl_find_gpio_range_from_pin_nolock(pctrl_dev, pi=
n);
> > +       if (!range)
> > +               return -EINVAL;
> > +
> > +       gpio =3D pin - range->pin_base;
> > +       if (gpio < 0)
> > +               return -EINVAL;
> > +
> > +       return gpio;
> > +}
>=20
> This function is just used here:

it is used in airoha_pinconf_get()/airoha_pinconf_set()

>=20
> > +static int airoha_pinconf_get(struct pinctrl_dev *pctrl_dev,
> > +                             unsigned int pin, unsigned long *config)
> > +{
> > +       struct airoha_pinctrl *pinctrl =3D pinctrl_dev_get_drvdata(pctr=
l_dev);
> > +       enum pin_config_param param =3D pinconf_to_config_param(*config=
);
> > +       u32 arg;
> > +
> > +       switch (param) {
> > +       case PIN_CONFIG_BIAS_PULL_DOWN:
> > +       case PIN_CONFIG_BIAS_DISABLE:
> > +       case PIN_CONFIG_BIAS_PULL_UP: {
> > +               u32 pull_up, pull_down;
> > +
> > +               if (airoha_pinctrl_get_pullup_conf(pinctrl, pin, &pull_=
up) ||
> > +                   airoha_pinctrl_get_pulldown_conf(pinctrl, pin, &pul=
l_down))
> > +                       return -EINVAL;
> > +
> > +               if (param =3D=3D PIN_CONFIG_BIAS_PULL_UP &&
> > +                   !(pull_up && !pull_down))
> > +                       return -EINVAL;
> > +               else if (param =3D=3D PIN_CONFIG_BIAS_PULL_DOWN &&
> > +                        !(pull_down && !pull_up))
> > +                       return -EINVAL;
> > +               else if (pull_up || pull_down)
> > +                       return -EINVAL;
> > +
> > +               arg =3D 1;
> > +               break;
> > +       }
> > +       case PIN_CONFIG_DRIVE_STRENGTH: {
> > +               u32 e2, e4;
> > +
> > +               if (airoha_pinctrl_get_drive_e2_conf(pinctrl, pin, &e2)=
 ||
> > +                   airoha_pinctrl_get_drive_e4_conf(pinctrl, pin, &e4))
> > +                       return -EINVAL;
> > +
> > +               arg =3D e4 << 1 | e2;
> > +               break;
> > +       }
> > +       case PIN_CONFIG_DRIVE_OPEN_DRAIN:
> > +               if (airoha_pinctrl_get_pcie_rst_od_conf(pinctrl, pin, &=
arg))
> > +                       return -EINVAL;
> > +               break;
> > +       case PIN_CONFIG_OUTPUT_ENABLE:
> > +       case PIN_CONFIG_INPUT_ENABLE: {
> > +               int gpio =3D airoha_pinctrl_get_gpio_from_pin(pctrl_dev=
, pin);
> > +
> > +               if (gpio < 0)
> > +                       return gpio;
> > +
> > +               arg =3D airoha_pinctrl_gpio_get_direction(pinctrl, gpio=
);
>=20
> I don't see why a pin would have to exist in a GPIO range in order to
> be set as output or input?
>=20
> Can't you just set up the pin as requested and not care whether
> it has a corresponding GPIO range?
>=20
> Is it over-reuse of the GPIO code? I'd say just set up the pin instead.

Do you mean to get rid of PIN_CONFIG_OUTPUT_ENABLE, PIN_CONFIG_INPUT_ENABLE
(and even PIN_CONFIG_OUTPUT in airoha_pinconf_set()) here?
E.g. we need PIN_CONFIG_OUTPUT_ENABLE to enable pwm for pwm-leds:

&mfd {
	...
	pio: pinctrl {
		...
		pwm_gpio18_idx10_pins: pwm-gpio18-idx10-pins {
			function =3D "pwm";
			pins =3D "gpio18";
			output-enable;
		};
	};
};

>=20
> > +static int airoha_pinconf_set(struct pinctrl_dev *pctrl_dev,
> > +                             unsigned int pin, unsigned long *configs,
> > +                             unsigned int num_configs)
> > +{
> > +       struct airoha_pinctrl *pinctrl =3D pinctrl_dev_get_drvdata(pctr=
l_dev);
> > +       int i;
> > +
> > +       for (i =3D 0; i < num_configs; i++) {
> > +               u32 param =3D pinconf_to_config_param(configs[i]);
> > +               u32 arg =3D pinconf_to_config_argument(configs[i]);
> > +
> > +               switch (param) {
> > +               case PIN_CONFIG_BIAS_DISABLE:
> > +                       airoha_pinctrl_set_pulldown_conf(pinctrl, pin, =
0);
> > +                       airoha_pinctrl_set_pullup_conf(pinctrl, pin, 0);
> > +                       break;
> > +               case PIN_CONFIG_BIAS_PULL_UP:
> > +                       airoha_pinctrl_set_pulldown_conf(pinctrl, pin, =
0);
> > +                       airoha_pinctrl_set_pullup_conf(pinctrl, pin, 1);
> > +                       break;
> > +               case PIN_CONFIG_BIAS_PULL_DOWN:
> > +                       airoha_pinctrl_set_pulldown_conf(pinctrl, pin, =
1);
> > +                       airoha_pinctrl_set_pullup_conf(pinctrl, pin, 0);
> > +                       break;
> > +               case PIN_CONFIG_DRIVE_STRENGTH: {
> > +                       u32 e2 =3D 0, e4 =3D 0;
> > +
> > +                       switch (arg) {
> > +                       case MTK_DRIVE_2mA:
> > +                               break;
> > +                       case MTK_DRIVE_4mA:
> > +                               e2 =3D 1;
> > +                               break;
> > +                       case MTK_DRIVE_6mA:
> > +                               e4 =3D 1;
> > +                               break;
> > +                       case MTK_DRIVE_8mA:
> > +                               e2 =3D 1;
> > +                               e4 =3D 1;
> > +                               break;
> > +                       default:
> > +                               return -EINVAL;
> > +                       }
> > +
> > +                       airoha_pinctrl_set_drive_e2_conf(pinctrl, pin, =
e2);
> > +                       airoha_pinctrl_set_drive_e4_conf(pinctrl, pin, =
e4);
> > +                       break;
> > +               }
> > +               case PIN_CONFIG_DRIVE_OPEN_DRAIN:
> > +                       airoha_pinctrl_set_pcie_rst_od_conf(pinctrl, pi=
n, !!arg);
> > +                       break;
> > +               case PIN_CONFIG_OUTPUT_ENABLE:
> > +               case PIN_CONFIG_INPUT_ENABLE:
> > +               case PIN_CONFIG_OUTPUT: {
> > +                       int gpio =3D airoha_pinctrl_get_gpio_from_pin(p=
ctrl_dev, pin);
> > +                       bool input =3D param =3D=3D PIN_CONFIG_INPUT_EN=
ABLE;
> > +
> > +                       if (gpio < 0)
> > +                               return gpio;
> > +
> > +                       airoha_pinctrl_gpio_set_direction(pinctrl, gpio=
, input);
> > +                       if (param =3D=3D PIN_CONFIG_OUTPUT)
> > +                               airoha_pinctrl_gpio_set_value(pinctrl, =
gpio, !!arg);
> > +                       break;
>=20
> Dito. No need to reuse the GPIO set direction function. Make a helper
> that just work on the pin instead, and perhaps the GPIO set direction
> can use that instead.

ack, I will fix it in v5.

>=20
> > +static int airoha_pinctrl_gpio_direction_output(struct gpio_chip *chip,
> > +                                               unsigned int gpio, int =
value)
> > +{
> > +       int err;
> > +
> > +       err =3D pinctrl_gpio_direction_output(chip, gpio);
> > +       if (err)
> > +               return err;
> > +
> > +       airoha_pinctrl_gpio_set(chip, gpio, value);
>=20
> Hm I get a bit confused by the similarly named helpers I guess...

Naming is always hard, I will try to improve :)

>=20
> > +static void airoha_pinctrl_gpio_irq_unmask(struct irq_data *data)
> > +{
> > +       u8 offset =3D data->hwirq % AIROHA_REG_GPIOCTRL_NUM_GPIO;
> > +       u8 index =3D data->hwirq / AIROHA_REG_GPIOCTRL_NUM_GPIO;
> > +       u32 mask =3D GENMASK(2 * offset + 1, 2 * offset);
> > +       struct airoha_pinctrl_gpiochip *gpiochip;
> > +       u32 val =3D BIT(2 * offset);
> > +       unsigned long flags;
> > +
> > +       gpiochip =3D irq_data_get_irq_chip_data(data);
> > +       if (WARN_ON_ONCE(data->hwirq >=3D ARRAY_SIZE(gpiochip->irq_type=
)))
> > +               return;
> > +
> > +       spin_lock_irqsave(&gpiochip->lock, flags);
>=20
> Use a scoped guard here
>=20
> guard(spinlock_irqsave)(&gpiochip->lock);
>=20
> > +static void airoha_pinctrl_gpio_irq_mask(struct irq_data *data)
> > +{
> > +       u8 offset =3D data->hwirq % AIROHA_REG_GPIOCTRL_NUM_GPIO;
> > +       u8 index =3D data->hwirq / AIROHA_REG_GPIOCTRL_NUM_GPIO;
> > +       u32 mask =3D GENMASK(2 * offset + 1, 2 * offset);
> > +       struct airoha_pinctrl_gpiochip *gpiochip;
> > +       unsigned long flags;
> > +
> > +       gpiochip =3D irq_data_get_irq_chip_data(data);
> > +
> > +       spin_lock_irqsave(&gpiochip->lock, flags);
>=20
> Dito
>=20
> > +static int airoha_pinctrl_gpio_irq_type(struct irq_data *data,
> > +                                       unsigned int type)
> > +{
> > +       struct airoha_pinctrl_gpiochip *gpiochip;
> > +       unsigned long flags;
> > +
> > +       gpiochip =3D irq_data_get_irq_chip_data(data);
> > +       if (data->hwirq >=3D ARRAY_SIZE(gpiochip->irq_type))
> > +               return -EINVAL;
> > +
> > +       spin_lock_irqsave(&gpiochip->lock, flags);
>=20
> Dito
>=20
> > +       girq->chip =3D devm_kzalloc(dev, sizeof(*girq->chip), GFP_KERNE=
L);
> > +       if (!girq->chip)
> > +               return -ENOMEM;
> > +
> > +       girq->chip->name =3D dev_name(dev);
> > +       girq->chip->irq_unmask =3D airoha_pinctrl_gpio_irq_unmask;
> > +       girq->chip->irq_mask =3D airoha_pinctrl_gpio_irq_mask;
> > +       girq->chip->irq_mask_ack =3D airoha_pinctrl_gpio_irq_mask;
> > +       girq->chip->irq_set_type =3D airoha_pinctrl_gpio_irq_type;
> > +       girq->chip->flags =3D IRQCHIP_SET_TYPE_MASKED | IRQCHIP_IMMUTAB=
LE;
> > +       girq->default_type =3D IRQ_TYPE_NONE;
> > +       girq->handler =3D handle_simple_irq;
>=20
> If the irqchip is immutable it is const and there is no point to malloc i=
t.
>=20
> Just
>=20
> static const struct irq_chip airoha_gpio_irq_chip =3D {...
>=20
> And assign it:
>=20
> girq =3D &g->gc.irq;
> gpio_irq_chip_set_chip(girq, &airoha_gpio_irq_chip);

ack, I will fix it in v5.

Regards,
Lorenzo

>=20
> Yours,
> Linus Walleij

--odZwuQpJyyMuG14N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZvKQewAKCRA6cBh0uS2t
rIOEAPwLJEIGo9DhC/Xay+37OQZdNofyAqZbZXQ3ppCO2RL7KwEArtuiHhhh7M2s
P2gdNhRr/6e9slvOcmFY9kXml90vmgI=
=y5LY
-----END PGP SIGNATURE-----

--odZwuQpJyyMuG14N--

