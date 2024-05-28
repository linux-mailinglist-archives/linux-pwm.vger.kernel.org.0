Return-Path: <linux-pwm+bounces-2270-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52C648D27B0
	for <lists+linux-pwm@lfdr.de>; Wed, 29 May 2024 00:03:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 768761C26446
	for <lists+linux-pwm@lfdr.de>; Tue, 28 May 2024 22:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5399313D8BE;
	Tue, 28 May 2024 22:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e5lK98bT"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8749113D8A6
	for <linux-pwm@vger.kernel.org>; Tue, 28 May 2024 22:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716933802; cv=none; b=evJblv5g9P3uRim7bQqI+AKGXyjdkakLQtwve60pJ1Ft27VotZcyIOsY03n0oYm2zksjhpl60FrfEERV3rebTZVcZYC0KxkXMTs36ITFy880fItBbq/kTV99GR1IfzFQHIyyYrgTQXRNbwHXIZD8Qn2Jg8zJfhn3TsiDUKZr+xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716933802; c=relaxed/simple;
	bh=uwUNBInJtPRR/82VvsVCLMZWPCGWGcWp8Zqi1Hc40gw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cHRwUpMrmr4RHYNwO0//dgXIl+HBmTsOkgJ4DlF4D4+CMF2mOwU++OKxcVQFE8Kv9zkTFl9KeD8aXx0P8PY4CV/xGILak9Ch6AkeaR3ZNqS7cYFiqK6tQJDYelE7wzsz0rID+3ZV5PM/IzRydq3Kbu0UcHAtEC5EpvVX6zVhTeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e5lK98bT; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-43e14f0bd75so51121cf.1
        for <linux-pwm@vger.kernel.org>; Tue, 28 May 2024 15:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716933799; x=1717538599; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NA2xl9SiVYXvH4ufbL9raYilr+WC4EJARiFmfxnkeQ0=;
        b=e5lK98bTETGsMLE52i7JzQLXF0zkuhRypIqwdnqkRmkdweglkBXFbG2fAQ+pNACNhS
         GOtyZ7Eae1yxRhVcpuAaUnszHAUWYQeYynwOBfNqF7+5XRbFy0jH9gEkjcEkAS128Eja
         rz4iNchYSEyOT8xHc4L1F92kNZpzQofFa1PpjkVTEB6Di9UZBhvV1zAJgzwfzzq4DWKd
         G6f0smtoSbmycAk4RCgy4ulQjYeNLclp1W51ylL6IjUDSBuiFYu561AgMd59qV5Rk+l1
         TDAEceOxvEGx7orsbobwP20jdNW8X871VY1o4/QjrrBt83UkNwNcShuAsyuH4zYK482M
         LkWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716933799; x=1717538599;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NA2xl9SiVYXvH4ufbL9raYilr+WC4EJARiFmfxnkeQ0=;
        b=c9X2A9v5K9qYkkw433392glXZ3ZqBsV8/mpRspjLMKnUfhEuUSmRlsE9RCg0TEhYp+
         PRkkntMAedmUkIi6wEpO7g6IxNNb67JsN0b7XErNEgqXw21qsK8TQ582sj4AedcIkYFH
         Xt3UuBhdJT6fJYVprgQTpM7iG+KsojjXjjA6F3pfVUQiVcIIplmZJHx0K2pvdTMvFATW
         5je5SrX8dbQXcy/VqFnYAvM4EwIrQfxGfT7jcy9TidMTkQPtk/DThEz5JElLcuHTd15W
         5X+DYbYaXcxOGyxITZQAps4HM3Sgv96Ddxc6hdytP9WARTLJB++hRgRxu9S10on58Gsm
         QmEw==
X-Forwarded-Encrypted: i=1; AJvYcCXb6eTw+xFd36fLPGBmA0xYc8Js7hscDwkw4jiWJgV0B7to3K9SVbAcSYMBBb4fu4PGhJGH7P8OFleJO3+0CBNr9JrbF+vmMBNp
X-Gm-Message-State: AOJu0Yx5aQm5ItVMjJDZV/3M2PxXvGnN8R7Bwzn7y/+Ml5yjim4gOWEn
	dqjCsNrVe5ipsPqXaZCawDOAKvtqWje/TB4sD6vWvmCE7V3dEd/91WBgnTde8wkESqYHfXmb69E
	95h90e1LPotiBWx8vwvVWNtnZIveY/BFMxq03
X-Google-Smtp-Source: AGHT+IEmN2OJDyxfJnhhXMrwa8Lv5oXov0Mgq8RPnKBxTQzjJh9W/RZ57flfBDvJJ4D/UkTnvKPOhOiMBYwXJYdXGuY=
X-Received: by 2002:a05:622a:5a06:b0:43f:d9d0:4a68 with SMTP id
 d75a77b69052e-43fe0f2aa8dmr668221cf.6.1716933798851; Tue, 28 May 2024
 15:03:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240520195942.11582-1-laurent.pinchart@ideasonboard.com>
 <20240520195942.11582-3-laurent.pinchart@ideasonboard.com>
 <11a383f3-a6db-4de7-a5f8-2938c69e98fc@kernel.org> <20240521194309.GA8863@pendragon.ideasonboard.com>
 <075f5a03-f288-4dfb-a293-3a6c0675881b@kernel.org> <20240522072224.GC8863@pendragon.ideasonboard.com>
 <92e85dff-ad02-4673-a625-2248b249c262@kernel.org> <20240523231641.GJ6640@pendragon.ideasonboard.com>
 <20240528151251.GA155664-robh@kernel.org> <20240528180820.GE29970@pendragon.ideasonboard.com>
In-Reply-To: <20240528180820.GE29970@pendragon.ideasonboard.com>
From: Saravana Kannan <saravanak@google.com>
Date: Wed, 29 May 2024 00:02:39 +0200
Message-ID: <CAGETcx8itgsP+mDmO_rAo4m7ytMx34MV28q-5vS0ETPvQYAXqg@mail.gmail.com>
Subject: Re: [PATCH 2/5] dt-bindings: Add bindings for the Analog Devices ADP5585
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org, 
	Alexandru Ardelean <alexandru.ardelean@analog.com>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Lee Jones <lee@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 28, 2024 at 8:08=E2=80=AFPM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Rob,
>
> On Tue, May 28, 2024 at 10:12:51AM -0500, Rob Herring wrote:
> > On Fri, May 24, 2024 at 02:16:41AM +0300, Laurent Pinchart wrote:
> > > Hi Krzysztof,
> > >
> > > (There's a question for the GPIO and PWM maintainers below)
> > >
> > > On Wed, May 22, 2024 at 09:40:02AM +0200, Krzysztof Kozlowski wrote:
> > > > On 22/05/2024 09:22, Laurent Pinchart wrote:
> > > > > On Wed, May 22, 2024 at 08:57:56AM +0200, Krzysztof Kozlowski wro=
te:
> > > > >> On 21/05/2024 21:43, Laurent Pinchart wrote:
> > > > >>> On Tue, May 21, 2024 at 09:05:50PM +0200, Krzysztof Kozlowski w=
rote:
> > > > >>>> On 20/05/2024 21:59, Laurent Pinchart wrote:
> > > > >>>>> The ADP5585 is a 10/11 input/output port expander with a buil=
t in keypad
> > > > >>>>> matrix decoder, programmable logic, reset generator, and PWM =
generator.
> > > > >>>>> These bindings model the device as an MFD, and support the GP=
IO expander
> > > > >>>>> and PWM functions.
> > > > >>>>>
> > > > >>>>> These bindings support the GPIO and PWM functions.
> > > > >>>>>
> > > > >>>>> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboar=
d.com>
> > > > >>>>> ---
> > > > >>>>> I've limited the bindings to GPIO and PWM as I lack hardware =
to design,
> > > > >>>>> implement and test the rest of the features the chip supports=
.
> > > > >>>>> ---
> > > > >>>>>  .../bindings/gpio/adi,adp5585-gpio.yaml       |  36 ++++++
> > > > >>>>>  .../devicetree/bindings/mfd/adi,adp5585.yaml  | 117 ++++++++=
++++++++++
> > > > >>>>>  .../bindings/pwm/adi,adp5585-pwm.yaml         |  35 ++++++
> > > > >>>>>  MAINTAINERS                                   |   7 ++
> > > > >>>>>  4 files changed, 195 insertions(+)
> > > > >>>>>  create mode 100644 Documentation/devicetree/bindings/gpio/ad=
i,adp5585-gpio.yaml
> > > > >>>>>  create mode 100644 Documentation/devicetree/bindings/mfd/adi=
,adp5585.yaml
> > > > >>>>>  create mode 100644 Documentation/devicetree/bindings/pwm/adi=
,adp5585-pwm.yaml
> > > > >>>>>
> > > > >>>>> diff --git a/Documentation/devicetree/bindings/gpio/adi,adp55=
85-gpio.yaml b/Documentation/devicetree/bindings/gpio/adi,adp5585-gpio.yaml
> > > > >>>>> new file mode 100644
> > > > >>>>> index 000000000000..210e4d53e764
> > > > >>>>> --- /dev/null
> > > > >>>>> +++ b/Documentation/devicetree/bindings/gpio/adi,adp5585-gpio=
.yaml
> > > > >>>>> @@ -0,0 +1,36 @@
> > > > >>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > > >>>>> +%YAML 1.2
> > > > >>>>> +---
> > > > >>>>> +$id: http://devicetree.org/schemas/gpio/adi,adp5585-gpio.yam=
l#
> > > > >>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > >>>>> +
> > > > >>>>> +title: Analog Devices ADP5585 GPIO Expander
> > > > >>>>> +
> > > > >>>>> +maintainers:
> > > > >>>>> +  - Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > > > >>>>> +
> > > > >>>>> +description: |
> > > > >>>>> +  The Analog Devices ADP5585 has up to 11 GPIOs represented =
by a "gpio" child
> > > > >>>>> +  node of the parent MFD device. See
> > > > >>>>> +  Documentation/devicetree/bindings/mfd/adi,adp5585.yaml for=
 further details as
> > > > >>>>> +  well as an example.
> > > > >>>>> +
> > > > >>>>> +properties:
> > > > >>>>> +  compatible:
> > > > >>>>> +    const: adi,adp5585-gpio
> > > > >>>>> +
> > > > >>>>> +  gpio-controller: true
> > > > >>>>> +
> > > > >>>>> +  '#gpio-cells':
> > > > >>>>> +    const: 2
> > > > >>>>> +
> > > > >>>>> +  gpio-reserved-ranges: true
> > > > >>>>
> > > > >>>> There are no resources here, so new compatible is not really w=
arranted.
> > > > >>>> Squash the node into parent.
> > > > >>>
> > > > >>> Child nodes seem (to me) to be the standard way to model functi=
ons in
> > > > >>> MFD devices. Looking at mfd_add_device(), for OF-based systems,=
 the
> > > > >>> function iterates over child nodes. I don't mind going a differ=
ent
> > > > >>
> > > > >> Only to assign of node, which could be skipped as well.
> > > > >
> > > > > It has to be assigned somehow, otherwise the GPIO and PWM lookups=
 won't
> > > > > work. That doesn't have to be done in mfd_add_device() though, it=
 can
> > > > > also be done manually by the driver. Looking at the example you g=
ave,
> > > > > cs42l43_pin_probe() handles that assignment. I would have conside=
red
> > > > > that a bit of a hack, but if that's your preferred approach, I'm =
fine
> > > > > with it. Could you confirm you're OK with that ?
> > > >
> > > > I am fine with the drivers doing that. It's not a hack, for all
> > > > sub-devices (e.g. also auxiliary bus) you won't have automatic of_n=
ode
> > > > assignment.
> > >
> > > I gave this a try, and here's what I came up with to drop the compati=
ble
> > > string. Please ignore for a moment the fact that the child nodes are
> > > still there, that's an orthogonal question which I can address
> > > separately. What I would like is feedback on how the OF nodes are
> > > handled.
> > >
> > > diff --git a/drivers/gpio/gpio-adp5585.c b/drivers/gpio/gpio-adp5585.=
c
> > > index 9696a4cdcfc1..8480ceef05ce 100644
> > > --- a/drivers/gpio/gpio-adp5585.c
> > > +++ b/drivers/gpio/gpio-adp5585.c
> > > @@ -174,6 +174,7 @@ static int adp5585_gpio_probe(struct platform_dev=
ice *pdev)
> > >     struct adp5585_dev *adp5585 =3D dev_get_drvdata(pdev->dev.parent)=
;
> > >     struct adp5585_gpio_dev *adp5585_gpio;
> > >     struct device *dev =3D &pdev->dev;
> > > +   struct device_node *node;
> > >     struct gpio_chip *gc;
> > >     int ret;
> > >
> > > @@ -187,6 +188,13 @@ static int adp5585_gpio_probe(struct platform_de=
vice *pdev)
> > >
> > >     mutex_init(&adp5585_gpio->lock);
> > >
> > > +   node =3D of_get_child_by_name(dev->parent->of_node, "gpio");
> > > +   if (!node)
> > > +           return dev_err_probe(dev, -ENXIO, "'gpio' child node not =
found\n");
> > > +
> > > +   dev->of_node =3D node;
> > > +   dev->fwnode =3D &node->fwnode;
> >
> > Use device_set_of_node_from_dev().
>
> That only works without child nodes in DT. Here I'm assigning the gpio
> child node, not the node of the parent device.
>
> > > +
> > >     gc =3D &adp5585_gpio->gpio_chip;
> > >     gc->parent =3D dev;
> > >     gc->direction_input =3D adp5585_gpio_direction_input;
> > > @@ -204,6 +212,9 @@ static int adp5585_gpio_probe(struct platform_dev=
ice *pdev)
> > >     ret =3D devm_gpiochip_add_data(&pdev->dev, &adp5585_gpio->gpio_ch=
ip,
> > >                                  adp5585_gpio);
> > >     if (ret) {
> > > +           of_node_put(dev->of_node);
> > > +           dev->of_node =3D NULL;
> > > +           dev->fwnode =3D NULL;
> > >             mutex_destroy(&adp5585_gpio->lock);
> > >             return dev_err_probe(&pdev->dev, ret, "failed to add GPIO=
 chip\n");
> > >     }
> > > @@ -215,6 +226,10 @@ static void adp5585_gpio_remove(struct platform_=
device *pdev)
> > >  {
> > >     struct adp5585_gpio_dev *adp5585_gpio =3D platform_get_drvdata(pd=
ev);
> > >
> > > +   of_node_put(pdev->dev.of_node);
> > > +   pdev->dev.of_node =3D NULL;
> > > +   pdev->dev.fwnode =3D NULL;
> > > +
> > >     mutex_destroy(&adp5585_gpio->lock);
> > >  }
> > >
> > > diff --git a/drivers/pwm/pwm-adp5585.c b/drivers/pwm/pwm-adp5585.c
> > > index e39a6ea5f794..3b190567ea0b 100644
> > > --- a/drivers/pwm/pwm-adp5585.c
> > > +++ b/drivers/pwm/pwm-adp5585.c
> > > @@ -146,6 +146,8 @@ static const struct pwm_ops adp5585_pwm_ops =3D {
> > >  static int adp5585_pwm_probe(struct platform_device *pdev)
> > >  {
> > >     struct adp5585_dev *adp5585 =3D dev_get_drvdata(pdev->dev.parent)=
;
> > > +   struct device *dev =3D &pdev->dev;
> > > +   struct device_node *node;
> > >     struct pwm_chip *chip;
> > >     int ret;
> > >
> > > @@ -153,16 +155,34 @@ static int adp5585_pwm_probe(struct platform_de=
vice *pdev)
> > >     if (IS_ERR(chip))
> > >             return PTR_ERR(chip);
> > >
> > > +   node =3D of_get_child_by_name(dev->parent->of_node, "pwm");
> > > +   if (!node)
> > > +           return dev_err_probe(dev, -ENXIO, "'pwm' child node not f=
ound\n");
> > > +
> > > +   dev->of_node =3D node;
> > > +   dev->fwnode =3D &node->fwnode;
> > > +
> > >     pwmchip_set_drvdata(chip, adp5585->regmap);
> > >     chip->ops =3D &adp5585_pwm_ops;
> > >
> > >     ret =3D devm_pwmchip_add(&pdev->dev, chip);
> > > -   if (ret)
> > > +   if (ret) {
> > > +           of_node_put(dev->of_node);
> > > +           dev->of_node =3D NULL;
> > > +           dev->fwnode =3D NULL;
> > >             return dev_err_probe(&pdev->dev, ret, "failed to add PWM =
chip\n");
> > > +   }
> > >
> > >     return 0;
> > >  }
> > >
> > > +static void adp5585_pwm_remove(struct platform_device *pdev)
> > > +{
> > > +   of_node_put(pdev->dev.of_node);
> >
> > Wouldn't the driver core do this already? It's not going to know how or
> > when of_node was set, so should be doing a put regardless.
>
> It does, but only when the struct device is being destroyed. Unbinding
> and rebinding would leak a reference. Using
> device_set_of_node_from_dev() solves that problem, but doesn't work with
> child nodes.
>
> I'm going to send a v2 that squashes everything in a single DT node,
> which allows usage of device_set_of_node_from_dev(). Let's see if it
> will be more palatable.
>
> > > +   pdev->dev.of_node =3D NULL;
> > > +   pdev->dev.fwnode =3D NULL;
> > > +}
> > > +
> > >  static struct platform_driver adp5585_pwm_driver =3D {
> > >     .driver =3D {
> > >             .name =3D "adp5585-pwm",
> > >
> > > Is this acceptable ? I'm a bit concerned about poking the internals o=
f
> > > struct device directly from drivers.
> > >
> > > I have also refrained from setting fnode->dev to point back to the
> > > device as fone by cs42l43_pin_probe(), as a comment in struct
> > > fwnode_handle indicates that the dev field is for device links only a=
nd
> > > shouldn't be touched by anything else. I'm not sure if I should set i=
t.
> >
> > I think no, but best for Saravana to comment.

Don't set fwnode->dev. But I'd actually go even further and say don't
set dev->fwnode to NULL. If it ever needs to be set to NULL the driver
core will take care of it. And when it does that is when it'll set
fwnode->dev to NULL too. So, you setting dev->fwnode to NULL is
actually not good once you add the device.

-Saravana

> >
> > > > >>> routes, could you indicate what you have in mind, perhaps point=
ing to an
> > > > >>> existing driver as an example ?
> > > > >>
> > > > >> Most of them? OK, let's take the last added driver in MFD direct=
ory:
> > > > >> cirrus,cs42l43
> > > > >> It has three children and only two nodes, because only these two=
 devices
> > > > >> actually need/use/benefit the subnodes.
> > > > >
> > > > > Still trying to understand what bothers you here, is it the child=
 nodes,
> > > > > or the fact that they have a compatible string and are documented=
 in a
> > > > > separate binding ? Looking at the cirrus,cs42l43 bindings and the
> > > >
> > > > What bothers me (and as expressed in many reviews by us) is represe=
nting
> > > > driver structure directly in DT. People model DT based how their Li=
nux
> > > > drivers are represented. I don't care about driver stuff here, but =
DT/DTS.
> > >
> > > DT models the hardware as seen from a software point of view.
> >
> > True, but it's for all software's PoV, not some specific s/w.
>
> Agreed.
>
> > > It
> > > shouldn't reflect the structure of Linux drivers, but it has to be
> > > usable by drivers.
> >
> > Either way is usable.
>
> --
> Regards,
>
> Laurent Pinchart

