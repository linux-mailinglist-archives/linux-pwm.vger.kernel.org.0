Return-Path: <linux-pwm+bounces-4493-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ECD29FBD20
	for <lists+linux-pwm@lfdr.de>; Tue, 24 Dec 2024 13:11:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DA51161FC2
	for <lists+linux-pwm@lfdr.de>; Tue, 24 Dec 2024 12:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F2DF1C3C13;
	Tue, 24 Dec 2024 12:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="b1Onl73r"
X-Original-To: linux-pwm@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2D31B218E;
	Tue, 24 Dec 2024 12:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735042263; cv=none; b=a1IpECGtzAz5PXVU8K2pCzrA/oVGu8AEdcqeTSHJq0Z/wZBQrA6tT1osnBxuspXrrNdp103UKU9MV1xbDBYVqxkON/g2zdfuM7Jt5kfe0lxl62BuMF8X5GNum/6bdSQVoEbsKIshRC6t+3sVtTYVpagvZqMsYnfabCeZ66arHw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735042263; c=relaxed/simple;
	bh=XMK3h0rVDQ9sZfKj5FKzl84voIKX0jtLZlI83yqUA9k=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=PmJcnVL9+0e8xz0bGjcfgqDiOlCxpqLdWExGvCoxpPcR9pNSPCTvOiuya7lwxcB4iNlSsp/Bl5CgL7nqn2iykw2bevjQWzuSoDXF3ONuG/2Y+xJtTp+3GPD0+K/e2w0ZL+CKzvlXKWZRWQGU0NAt8MsDLJOY8effaRGxu6fx/AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=b1Onl73r; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 37ED0240005;
	Tue, 24 Dec 2024 12:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1735042257;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vNqq83jvbujdlgwbJCu0n+UTClTPkjzCBzlXc/71ElM=;
	b=b1Onl73reMkjxoEjEpjCsnTGzsYGcxst0ZaZ05wYWQzoRY7K6tnB2qsMnSj50bbqM2T2zV
	MtP1ZTAzv621I1a/n9gI1RB2uNxF1stQl7vPfzyfA+nnBgOSTlyHZfmvP3eDPeEo9B0cED
	isklxqKzNUybB7UItv9sf4liQqAJtdLBoNe7jAA0uBEth37pEZgHhxXJCUD7LiStWdkn5E
	kRgg9eq14FhSXI3ccilR2GvQ2cIZPHHrTlX9v8lE74MxJsv79hAWMJRffwQFl07EPDxof7
	7W8oV10xZPhzRjJgZXpYaA10+2G04KGrUGHd54JkjhxSd5y8Lq/K/SBzakvpKQ==
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 24 Dec 2024 13:10:56 +0100
Message-Id: <D6JX5D6SX41A.2GFEDU0WMH5ZC@bootlin.com>
Subject: Re: [PATCH 2/8] dt-bindings: Add MAX7360 subdevices
Cc: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-gpio@vger.kernel.org>, <linux-input@vger.kernel.org>,
 <linux-pwm@vger.kernel.org>, =?utf-8?q?Gr=C3=A9gory_Clement?=
 <gregory.clement@bootlin.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>
From: "Mathieu Dubois-Briand" <mathieu.dubois-briand@bootlin.com>
To: "Krzysztof Kozlowski" <krzk@kernel.org>, "Lee Jones" <lee@kernel.org>,
 "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski"
 <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, "Kamel Bouhara"
 <kamel.bouhara@bootlin.com>, "Linus Walleij" <linus.walleij@linaro.org>,
 "Bartosz Golaszewski" <brgl@bgdev.pl>, "Dmitry Torokhov"
 <dmitry.torokhov@gmail.com>, =?utf-8?q?Uwe_Kleine-K=C3=B6nig?=
 <ukleinek@kernel.org>
X-Mailer: aerc 0.18.2-0-ge037c095a049
References: <20241219-mdb-max7360-support-v1-0-8e8317584121@bootlin.com>
 <20241219-mdb-max7360-support-v1-2-8e8317584121@bootlin.com>
 <58c80c2a-2532-4bc5-9c9f-52480b3af52a@kernel.org>
 <D6J6JNPPZRKM.3F9YUY9CW3L2F@bootlin.com>
 <b1d541c1-296a-4b56-bea3-52e5becadf0e@kernel.org>
In-Reply-To: <b1d541c1-296a-4b56-bea3-52e5becadf0e@kernel.org>
X-GND-Sasl: mathieu.dubois-briand@bootlin.com

On Tue Dec 24, 2024 at 10:00 AM CET, Krzysztof Kozlowski wrote:
> On 23/12/2024 16:20, Mathieu Dubois-Briand wrote:
> > On Sat Dec 21, 2024 at 9:34 PM CET, Krzysztof Kozlowski wrote:
> >> On 19/12/2024 17:21, Mathieu Dubois-Briand wrote:
> >>> ---
> >>> diff --git a/Documentation/devicetree/bindings/gpio/max7360-gpio.yaml=
 b/Documentation/devicetree/bindings/gpio/max7360-gpio.yaml
> >>> new file mode 100644
> >>> index 000000000000..3c006dc0380b
> >>> --- /dev/null
> >>> +++ b/Documentation/devicetree/bindings/gpio/max7360-gpio.yaml
> >>> @@ -0,0 +1,96 @@
> >>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> >>> +%YAML 1.2
> >>> +---
> >>> +$id: http://devicetree.org/schemas/gpio/max7360-gpio.yaml#
> >>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >>> +
> >>> +title: Maxim MAX7360 GPIO controller
> >>> +
> >>> +maintainers:
> >>> +  - Kamel Bouhara <kamel.bouhara@bootlin.com>
> >>> +  - Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
> >>> +
> >>> +description: |
> >>> +  Maxim MAX7360 GPIO controller, in MAX7360 MFD
> >>> +  https://www.analog.com/en/products/max7360.html
> >>> +
> >>> +properties:
> >>> +  compatible:
> >>> +    enum:
> >>> +      - maxim,max7360-gpio
> >>> +      - maxim,max7360-gpo
> >>
> >> Why? What are the differences?
> >>
> >=20
> > Ok, so maybe my approach here is completely wrong. I'm not sure what
> > would be the best way to describe the device here, if you have any
> > suggestion I would be happy to use it. Let me try to summarize the GPIO
> > setup of the chip.
> >=20
> > First we have two series of GPIOs on the chips, which I tend to think
> > about as two separate "banks". Thus two separate subnodes of the max736=
0
> > node.
>
> First, splitting MFD device into multiple children is pretty often wrong
> approach because it tries to mimic Linux driver design.
>
> Such split in DT makes sense if these are really separate blocks, e.g.
> separate I2C addresses, re-usable on different designs.
>
> In this case Functional Block Diagram shows separate blocks, but still
> the same I2C block. This can be one device. This can be also two devices
> if that's easier to represent in DT.

Ok, I get it. So I could try to remove the children, but I'm not really
sure about the way to go:
- About the two series of GPIOs, how should I represent them? In a
  continuous way, like 0-7 is gpios and 8+ is gpos? Or maybe setting
  #gpio-cells to 3 and using the added cell to select between gpios and
  gpos ?
- About the interrupt-controller: today we have a children where all
  gpios have a corresponding interrupt and another one without any
  interrupt. If I remove the children, we will have a mix of both. I
  don't think there is anything preventing to do this, but is this ok?

So I'm keeping the two children for now, but I'm open to the possibility
of removing them.

>
> But in any case binding description should explain this.
>

Ok, I will add some documentation.

> >=20
> > - On one side we have what I refer to as GPIOs, here with
> >   maxim,max7360-gpio:
> >   - PORT0 to PORT7 pins of the chip.
> >   - Shared with PWM and rotary encoder functionalities. Functionality
> >     selection can be made independently for each pin. This selection is
> >     not described here. Runtime will have to ensure the same pin is not
> >     used by two drivers at the same time. E.g. we cannot have at the
> >     same time GPIO4 and PWM4.
> >   - Supports input and interrupts.
> >   - Outputs may be configured as constant current.
> >   - 8 GPIOS supported, so ngpios maximum is 8. Thinking about it now, w=
e
> >     should probably also set minimum to 8, I don't see any reason to
> >     have ngpios set to something less.
> >=20
> > On the other side, we have what I refer to as GPOs, here with
> > maxim,max7360-gpo compatible:
> >   - COL2 to COL7 pins of the chip.
> >   - Shared with the keypad functionality. Selections is made by
> >     partitioning the pins: first pins for keypad columns, last pins for
> >     GPOs. Partition is described here by ngpios and on keypad node by
> >     keypad,num-columns. Runtime will have to ensure values are coherent
> >     and configure the chip accordingly.
> >   - Only support outputs.
> >   - No support for constant current mode.
> >   - Supports 0 to 6 GPOs, so ngpios maximum is 6.
> >=20
> >>> +
> >>> +  gpio-controller: true
> >>> +
> >>> +  "#gpio-cells":
> >>> +    const: 2
> >>> +
> >>> +  ngpios:
> >>> +    minimum: 0
> >>> +    maximum: 8
> >>
> >> Why this is flexible?
> >>
> >=20
> > I believe this makes sense, as this keypad/gpos partition really change=
s
> > the actual number of GPIOS. Yet we could argue that this is just runtim=
e
> > configuration. Tell me what you think about it, if you think this shoul=
d
> > be a fixed value, I will find a way.
>
> Depends whether this is actual runtime configuration. If you configure
> keypad in DT, then the pins go away from GPIOs (especially considering
> that board might have these pins really connected to keypad). Anyway,
> explain this briefly in binding description.

Keypad is configured in DT and yes, the pins partition is a consequence
of the hardware implementation on the board. So on second thought I
believe this is cannot be a runtime configuration and should be
described in the DT.

I will add some documentation about it.

>
> >=20
> Best regards,
> Krzysztof

Thanks again for your review.
Mathieu

--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


