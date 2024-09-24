Return-Path: <linux-pwm+bounces-3351-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B71E9983F23
	for <lists+linux-pwm@lfdr.de>; Tue, 24 Sep 2024 09:35:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 486281F229C1
	for <lists+linux-pwm@lfdr.de>; Tue, 24 Sep 2024 07:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8775B147C79;
	Tue, 24 Sep 2024 07:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N7phybYa"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53615770F5
	for <linux-pwm@vger.kernel.org>; Tue, 24 Sep 2024 07:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727163314; cv=none; b=sfcB0r4dhVPhhYeRavvmzEOh7ozAXMGIHSyYSJqO63OXmLKv/ENzVnvtdMRWGOlm+z82KtYt2mvIImW4Gsml+QE4mSfmUOXSMFq7g0b7zunxMKpXmeZ/btB7yq2y3BvM1AjXPE57zsIDs9eo0RVdhp2r1NnBcUCCmhJrseQ6YLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727163314; c=relaxed/simple;
	bh=xDWDpu6IAtKAFxOuiszH6QCZYto+EVgv92InBRudEz8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pS3xeqLlzCU9rgHemY1IwqbyCTwi9ct/yPcJkUlWmHYs17lOGmVYDxbaYiP9kpsDJ0WU5cHfGJpKK6Aev5NA9ex0VezdKatTp4zn5B5k2iE2tiqICBTe9YlcToJV5Fd7etY9jQIjhN5sghO5aOP86vJWiiGmZTNVuiMSZFXEbrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=N7phybYa; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2f8ca33ef19so21529501fa.2
        for <linux-pwm@vger.kernel.org>; Tue, 24 Sep 2024 00:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727163310; x=1727768110; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x6jC7dLYj5DhEJuVDkwTLOL7wYPS+ONiODGiB9WMaMM=;
        b=N7phybYaDMpoy7tzv/qZBYN1418HCFid+3NDrWyqzN4fElukqUWZ1EXnXPEyweH+P/
         3hznJ9W5cMMJxvCyoWE5YbHiFiqemg15jbOdm9IWlwBpm77gvKHRUYChgEQBfvohGVmC
         FRLEVheJrAa6qtxioA54oSlIDocMs2exo8U7p9X/1SsQ6+zcXbOpN4vwK4lUrH/W/4uI
         ecxu5y20AucwYd2k7b3CCOlHneSUrkIa3v0Fja1ylZs2bebGS7tA7Y7PZNMGo0cHgZq5
         CmwOOdAf4mGXVKgUeX7gLvXncAcA9zdJgDwxroP/NHOY6YA7LhagdaZjtzyV30A0+kbM
         6A2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727163310; x=1727768110;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x6jC7dLYj5DhEJuVDkwTLOL7wYPS+ONiODGiB9WMaMM=;
        b=FAfzhX4jx6qlQreSC+I347e2oc8wSqRdQamOQJ3Gni6rC2RYimuU563q4o+VnSd1kg
         Yd0ROZD386M+r+21cAvFXHbCV9TVNv+LF3QY67BLHMm4yeZS4SBVlSyrcjX+mYGrGkY4
         Zhjs2VjNU+o9RmBF//j/pfJ3w6v++RzED9TLkmjAQVIkbrR18yO8pX4XbPI0Bcp0mh+7
         y/BY2UZ2SynCB+1ekdgnFgwoBJwjinDoRmHwCmA+UvR7h4S2v2Z4sQlWLSzoSln7mPGk
         NdNVt8+8WDKZSCqJFIvk91aA8991ugSs/XwlgapPKZl8XePaRxYYW7RnJVxXVhARZ8pD
         OUqQ==
X-Forwarded-Encrypted: i=1; AJvYcCXT08C0GVZRpUPBa7HX/ZpuDQwuOeZjzcPjbalhY/2YNxIZeAoSIlsohHj9gYyycWEYjfzY8QxkQos=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4G2Uyvqkt6sbMhwlWWCCHQt5tsXHG/JQwWP6m9sRuOm8EJUEk
	9g22W1fqGW7VhAKJYT1TkzHoZas7QLPRsFeB3FR/56BwQkxBZ4zSHoWfWO+IRAr6IXVtNoALjIm
	QYp/lKD1HNDCIfeIpLYL5qzm9PjdTX53W/6fMyw==
X-Google-Smtp-Source: AGHT+IEdre6uDn55gw82LdZ2pu50IDPqSAXWNGKnyTnveP66xuQ0JFOZY4LGtLABBGvFkj0anWjqmCFJ+EhaGSJNf7U=
X-Received: by 2002:a2e:5149:0:b0:2f0:27da:6864 with SMTP id
 38308e7fff4ca-2f7cb30dbabmr76774681fa.17.1727163310389; Tue, 24 Sep 2024
 00:35:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240911-en7581-pinctrl-v4-0-60ac93d760bb@kernel.org> <20240911-en7581-pinctrl-v4-4-60ac93d760bb@kernel.org>
In-Reply-To: <20240911-en7581-pinctrl-v4-4-60ac93d760bb@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 24 Sep 2024 09:34:57 +0200
Message-ID: <CACRpkdZbyQ5bk8oR+Q4UmQCdM5h1mF1ztBc26YzqNsze_B=ehA@mail.gmail.com>
Subject: Re: [PATCH v4 4/5] pinctrl: airoha: Add support for EN7581 SoC
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Sean Wang <sean.wang@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Lee Jones <lee@kernel.org>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	upstream@airoha.com, benjamin.larsson@genexis.eu, ansuelsmth@gmail.com, 
	linux-pwm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Lorenzo / Benjamin,

thanks for your patch!

This is a real nice driver, I like the design of the pin database to suppor=
t
this pretty complex pin controller.

Some comments and nits:

On Wed, Sep 11, 2024 at 9:51=E2=80=AFPM Lorenzo Bianconi <lorenzo@kernel.or=
g> wrote:

> Introduce pinctrl driver for EN7581 SoC. Current EN7581 pinctrl driver
> supports the following functionalities:
> - pin multiplexing
> - pin pull-up, pull-down, open-drain, current strength,
>   {input,output}_enable, output_{low,high}
> - gpio controller
> - irq controller
>
> Tested-by: Benjamin Larsson <benjamin.larsson@genexis.eu>
> Co-developed-by: Benjamin Larsson <benjamin.larsson@genexis.eu>
> Signed-off-by: Benjamin Larsson <benjamin.larsson@genexis.eu>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

(...)

> +#include <dt-bindings/pinctrl/mt65xx.h>
> +#include <linux/bitfield.h>

Isn't just <linux/bits.h> enough for what you're using?

> +#include <linux/gpio/driver.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/irq.h>
> +#include <linux/irqdomain.h>
> +#include <linux/kernel.h>

What do you use from kernel.h? We usually use more fingrained
headers these days.

(...)

> +#include <linux/mfd/airoha-en7581-mfd.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/of.h>
> +#include <linux/of_irq.h>
> +#include <linux/of_platform.h>
> +#include <linux/pinctrl/consumer.h>

Why do you need the consumer header?

(...)

> +static u32 airoha_pinctrl_rmw_unlock(void __iomem *addr, u32 mask, u32 v=
al)
> +{
> +       val |=3D (readl(addr) & ~mask);
> +       writel(val, addr);
> +
> +       return val;
> +}
> +
> +#define airoha_pinctrl_set_unlock(addr, val)                            =
       \
> +       airoha_pinctrl_rmw_unlock((addr), 0, (val))
> +#define airoha_pinctrl_clear_unlock(addr, mask)                         =
               \
> +       airoha_pinctrl_rmw_unlock((addr), (mask), (0))
> +
> +static u32 airoha_pinctrl_rmw(struct airoha_pinctrl *pinctrl,
> +                             void __iomem *addr, u32 mask, u32 val)
> +{
> +       mutex_lock(&pinctrl->mutex);
> +       val =3D airoha_pinctrl_rmw_unlock(addr, mask, val);
> +       mutex_unlock(&pinctrl->mutex);
> +
> +       return val;
> +}

Thus looks like a reimplementation of regmap-mmio, can't you just use
regmap MMIO? You use it for the SCU access already...

If you persist with this solution, please use a guard:

#include <linux/cleanup.h>

guard(mutex)(&pinctrl->mutex);

And the lock will be released when you exit the function.

> +static int airoha_pinctrl_get_gpio_from_pin(struct pinctrl_dev *pctrl_de=
v,
> +                                           int pin)
> +{
> +       struct pinctrl_gpio_range *range;
> +       int gpio;
> +
> +       range =3D pinctrl_find_gpio_range_from_pin_nolock(pctrl_dev, pin)=
;
> +       if (!range)
> +               return -EINVAL;
> +
> +       gpio =3D pin - range->pin_base;
> +       if (gpio < 0)
> +               return -EINVAL;
> +
> +       return gpio;
> +}

This function is just used here:

> +static int airoha_pinconf_get(struct pinctrl_dev *pctrl_dev,
> +                             unsigned int pin, unsigned long *config)
> +{
> +       struct airoha_pinctrl *pinctrl =3D pinctrl_dev_get_drvdata(pctrl_=
dev);
> +       enum pin_config_param param =3D pinconf_to_config_param(*config);
> +       u32 arg;
> +
> +       switch (param) {
> +       case PIN_CONFIG_BIAS_PULL_DOWN:
> +       case PIN_CONFIG_BIAS_DISABLE:
> +       case PIN_CONFIG_BIAS_PULL_UP: {
> +               u32 pull_up, pull_down;
> +
> +               if (airoha_pinctrl_get_pullup_conf(pinctrl, pin, &pull_up=
) ||
> +                   airoha_pinctrl_get_pulldown_conf(pinctrl, pin, &pull_=
down))
> +                       return -EINVAL;
> +
> +               if (param =3D=3D PIN_CONFIG_BIAS_PULL_UP &&
> +                   !(pull_up && !pull_down))
> +                       return -EINVAL;
> +               else if (param =3D=3D PIN_CONFIG_BIAS_PULL_DOWN &&
> +                        !(pull_down && !pull_up))
> +                       return -EINVAL;
> +               else if (pull_up || pull_down)
> +                       return -EINVAL;
> +
> +               arg =3D 1;
> +               break;
> +       }
> +       case PIN_CONFIG_DRIVE_STRENGTH: {
> +               u32 e2, e4;
> +
> +               if (airoha_pinctrl_get_drive_e2_conf(pinctrl, pin, &e2) |=
|
> +                   airoha_pinctrl_get_drive_e4_conf(pinctrl, pin, &e4))
> +                       return -EINVAL;
> +
> +               arg =3D e4 << 1 | e2;
> +               break;
> +       }
> +       case PIN_CONFIG_DRIVE_OPEN_DRAIN:
> +               if (airoha_pinctrl_get_pcie_rst_od_conf(pinctrl, pin, &ar=
g))
> +                       return -EINVAL;
> +               break;
> +       case PIN_CONFIG_OUTPUT_ENABLE:
> +       case PIN_CONFIG_INPUT_ENABLE: {
> +               int gpio =3D airoha_pinctrl_get_gpio_from_pin(pctrl_dev, =
pin);
> +
> +               if (gpio < 0)
> +                       return gpio;
> +
> +               arg =3D airoha_pinctrl_gpio_get_direction(pinctrl, gpio);

I don't see why a pin would have to exist in a GPIO range in order to
be set as output or input?

Can't you just set up the pin as requested and not care whether
it has a corresponding GPIO range?

Is it over-reuse of the GPIO code? I'd say just set up the pin instead.

> +static int airoha_pinconf_set(struct pinctrl_dev *pctrl_dev,
> +                             unsigned int pin, unsigned long *configs,
> +                             unsigned int num_configs)
> +{
> +       struct airoha_pinctrl *pinctrl =3D pinctrl_dev_get_drvdata(pctrl_=
dev);
> +       int i;
> +
> +       for (i =3D 0; i < num_configs; i++) {
> +               u32 param =3D pinconf_to_config_param(configs[i]);
> +               u32 arg =3D pinconf_to_config_argument(configs[i]);
> +
> +               switch (param) {
> +               case PIN_CONFIG_BIAS_DISABLE:
> +                       airoha_pinctrl_set_pulldown_conf(pinctrl, pin, 0)=
;
> +                       airoha_pinctrl_set_pullup_conf(pinctrl, pin, 0);
> +                       break;
> +               case PIN_CONFIG_BIAS_PULL_UP:
> +                       airoha_pinctrl_set_pulldown_conf(pinctrl, pin, 0)=
;
> +                       airoha_pinctrl_set_pullup_conf(pinctrl, pin, 1);
> +                       break;
> +               case PIN_CONFIG_BIAS_PULL_DOWN:
> +                       airoha_pinctrl_set_pulldown_conf(pinctrl, pin, 1)=
;
> +                       airoha_pinctrl_set_pullup_conf(pinctrl, pin, 0);
> +                       break;
> +               case PIN_CONFIG_DRIVE_STRENGTH: {
> +                       u32 e2 =3D 0, e4 =3D 0;
> +
> +                       switch (arg) {
> +                       case MTK_DRIVE_2mA:
> +                               break;
> +                       case MTK_DRIVE_4mA:
> +                               e2 =3D 1;
> +                               break;
> +                       case MTK_DRIVE_6mA:
> +                               e4 =3D 1;
> +                               break;
> +                       case MTK_DRIVE_8mA:
> +                               e2 =3D 1;
> +                               e4 =3D 1;
> +                               break;
> +                       default:
> +                               return -EINVAL;
> +                       }
> +
> +                       airoha_pinctrl_set_drive_e2_conf(pinctrl, pin, e2=
);
> +                       airoha_pinctrl_set_drive_e4_conf(pinctrl, pin, e4=
);
> +                       break;
> +               }
> +               case PIN_CONFIG_DRIVE_OPEN_DRAIN:
> +                       airoha_pinctrl_set_pcie_rst_od_conf(pinctrl, pin,=
 !!arg);
> +                       break;
> +               case PIN_CONFIG_OUTPUT_ENABLE:
> +               case PIN_CONFIG_INPUT_ENABLE:
> +               case PIN_CONFIG_OUTPUT: {
> +                       int gpio =3D airoha_pinctrl_get_gpio_from_pin(pct=
rl_dev, pin);
> +                       bool input =3D param =3D=3D PIN_CONFIG_INPUT_ENAB=
LE;
> +
> +                       if (gpio < 0)
> +                               return gpio;
> +
> +                       airoha_pinctrl_gpio_set_direction(pinctrl, gpio, =
input);
> +                       if (param =3D=3D PIN_CONFIG_OUTPUT)
> +                               airoha_pinctrl_gpio_set_value(pinctrl, gp=
io, !!arg);
> +                       break;

Dito. No need to reuse the GPIO set direction function. Make a helper
that just work on the pin instead, and perhaps the GPIO set direction
can use that instead.

> +static int airoha_pinctrl_gpio_direction_output(struct gpio_chip *chip,
> +                                               unsigned int gpio, int va=
lue)
> +{
> +       int err;
> +
> +       err =3D pinctrl_gpio_direction_output(chip, gpio);
> +       if (err)
> +               return err;
> +
> +       airoha_pinctrl_gpio_set(chip, gpio, value);

Hm I get a bit confused by the similarly named helpers I guess...

> +static void airoha_pinctrl_gpio_irq_unmask(struct irq_data *data)
> +{
> +       u8 offset =3D data->hwirq % AIROHA_REG_GPIOCTRL_NUM_GPIO;
> +       u8 index =3D data->hwirq / AIROHA_REG_GPIOCTRL_NUM_GPIO;
> +       u32 mask =3D GENMASK(2 * offset + 1, 2 * offset);
> +       struct airoha_pinctrl_gpiochip *gpiochip;
> +       u32 val =3D BIT(2 * offset);
> +       unsigned long flags;
> +
> +       gpiochip =3D irq_data_get_irq_chip_data(data);
> +       if (WARN_ON_ONCE(data->hwirq >=3D ARRAY_SIZE(gpiochip->irq_type))=
)
> +               return;
> +
> +       spin_lock_irqsave(&gpiochip->lock, flags);

Use a scoped guard here

guard(spinlock_irqsave)(&gpiochip->lock);

> +static void airoha_pinctrl_gpio_irq_mask(struct irq_data *data)
> +{
> +       u8 offset =3D data->hwirq % AIROHA_REG_GPIOCTRL_NUM_GPIO;
> +       u8 index =3D data->hwirq / AIROHA_REG_GPIOCTRL_NUM_GPIO;
> +       u32 mask =3D GENMASK(2 * offset + 1, 2 * offset);
> +       struct airoha_pinctrl_gpiochip *gpiochip;
> +       unsigned long flags;
> +
> +       gpiochip =3D irq_data_get_irq_chip_data(data);
> +
> +       spin_lock_irqsave(&gpiochip->lock, flags);

Dito

> +static int airoha_pinctrl_gpio_irq_type(struct irq_data *data,
> +                                       unsigned int type)
> +{
> +       struct airoha_pinctrl_gpiochip *gpiochip;
> +       unsigned long flags;
> +
> +       gpiochip =3D irq_data_get_irq_chip_data(data);
> +       if (data->hwirq >=3D ARRAY_SIZE(gpiochip->irq_type))
> +               return -EINVAL;
> +
> +       spin_lock_irqsave(&gpiochip->lock, flags);

Dito

> +       girq->chip =3D devm_kzalloc(dev, sizeof(*girq->chip), GFP_KERNEL)=
;
> +       if (!girq->chip)
> +               return -ENOMEM;
> +
> +       girq->chip->name =3D dev_name(dev);
> +       girq->chip->irq_unmask =3D airoha_pinctrl_gpio_irq_unmask;
> +       girq->chip->irq_mask =3D airoha_pinctrl_gpio_irq_mask;
> +       girq->chip->irq_mask_ack =3D airoha_pinctrl_gpio_irq_mask;
> +       girq->chip->irq_set_type =3D airoha_pinctrl_gpio_irq_type;
> +       girq->chip->flags =3D IRQCHIP_SET_TYPE_MASKED | IRQCHIP_IMMUTABLE=
;
> +       girq->default_type =3D IRQ_TYPE_NONE;
> +       girq->handler =3D handle_simple_irq;

If the irqchip is immutable it is const and there is no point to malloc it.

Just

static const struct irq_chip airoha_gpio_irq_chip =3D {...

And assign it:

girq =3D &g->gc.irq;
gpio_irq_chip_set_chip(girq, &airoha_gpio_irq_chip);

Yours,
Linus Walleij

