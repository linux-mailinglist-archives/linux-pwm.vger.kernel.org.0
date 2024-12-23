Return-Path: <linux-pwm+bounces-4456-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 456949FB0A8
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Dec 2024 16:20:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B20791607DF
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Dec 2024 15:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34B4974E09;
	Mon, 23 Dec 2024 15:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="CyKrfSqH"
X-Original-To: linux-pwm@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929F2632;
	Mon, 23 Dec 2024 15:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734967219; cv=none; b=ai4poc8obzM499w2FSNTHBtuX/KM3OK7Jst00w5/obYHlds6oKdvcj7quKJMAUV6sJoUa20YEMYp4d1Gzad661IZm261MEREqbVTMjq5GbnJyD9/jA2xPauiW8TzRMa2YI/TQwn5XjsKP3oPS/9RmpdFrwTpa13w9+OA0YUPu7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734967219; c=relaxed/simple;
	bh=62f7MR0lvrWRvwYt+jP3G+C5AuOHr6wimnLsDb2fZ8o=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:From:To:Subject:
	 References:In-Reply-To; b=aDtywXHaFfiLGh+XgRodKQ+g9qFOW7Xcv4nzhJqQue6bEtdQPuehfFfLp8pBdsGucqPS5OTeVPmQHhZjOzdy+sObXhgn0qH58VbYLP1lg/xzdRMuugB3eiHH6dhlTJpVAmhzneeuXolXgKF0+j0swyqg264838ykrTuJRYauUj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=CyKrfSqH; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 560F824000D;
	Mon, 23 Dec 2024 15:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1734967208;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RRVcBhzqu08zrLHWPj0Xl/roM7wAyKWNWiZLKd4f5Jk=;
	b=CyKrfSqHIX/0s2GehqCYWtnaBxUl6NK/R9yPpnhg4bdZrgW2qQYt8rFy8tL6tcW9FOYfUY
	FAbjoXlgHcMgOoZXcwP6CMlJZGRIA2T3yyjObxIhhesHqL8ebeM1vJs3cgDMwF3nExxUlp
	QqsCHEE9KIpMLjUDAgSIqBNGO6DZoynQrbTqCx+N+t+XHnnIGU51lfWirJVr7L5H27Ymz6
	II/tx2SfyXvfM69GBqle+YlHtG4SkzTaugQZcLpXzVJblvJmysXipjqe8iKW1G+ajf5cUG
	OBDi9vc5OypHt5jv/xB/YOwFTJz2haQ3W/nakvFFphpBN4W3E0/VRYc8NMt5ZQ==
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 23 Dec 2024 16:20:06 +0100
Message-Id: <D6J6JNPPZRKM.3F9YUY9CW3L2F@bootlin.com>
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
Subject: Re: [PATCH 2/8] dt-bindings: Add MAX7360 subdevices
X-Mailer: aerc 0.18.2-0-ge037c095a049
References: <20241219-mdb-max7360-support-v1-0-8e8317584121@bootlin.com>
 <20241219-mdb-max7360-support-v1-2-8e8317584121@bootlin.com>
 <58c80c2a-2532-4bc5-9c9f-52480b3af52a@kernel.org>
In-Reply-To: <58c80c2a-2532-4bc5-9c9f-52480b3af52a@kernel.org>
X-GND-Sasl: mathieu.dubois-briand@bootlin.com

On Sat Dec 21, 2024 at 9:34 PM CET, Krzysztof Kozlowski wrote:
> On 19/12/2024 17:21, Mathieu Dubois-Briand wrote:
> > ---
> >  .../devicetree/bindings/gpio/max7360-gpio.yaml     | 96 ++++++++++++++=
++++++++
> >  .../devicetree/bindings/input/max7360-keypad.yaml  | 67 ++++++++++++++=
+
> >  .../devicetree/bindings/input/max7360-rotary.yaml  | 52 ++++++++++++
> >  .../devicetree/bindings/pwm/max7360-pwm.yaml       | 35 ++++++++
> >  4 files changed, 250 insertions(+)
>
>
> I don't understand how this patchset was split. MFD binding cannot be
> empty and cannot be before child devices.
>

Ok, my bad. So I believe squashing both dt-bindings commit should fix
this.

> > diff --git a/Documentation/devicetree/bindings/gpio/max7360-gpio.yaml b=
/Documentation/devicetree/bindings/gpio/max7360-gpio.yaml
> > new file mode 100644
> > index 000000000000..3c006dc0380b
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/gpio/max7360-gpio.yaml
> > @@ -0,0 +1,96 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/gpio/max7360-gpio.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Maxim MAX7360 GPIO controller
> > +
> > +maintainers:
> > +  - Kamel Bouhara <kamel.bouhara@bootlin.com>
> > +  - Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
> > +
> > +description: |
> > +  Maxim MAX7360 GPIO controller, in MAX7360 MFD
> > +  https://www.analog.com/en/products/max7360.html
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - maxim,max7360-gpio
> > +      - maxim,max7360-gpo
>
> Why? What are the differences?
>

Ok, so maybe my approach here is completely wrong. I'm not sure what
would be the best way to describe the device here, if you have any
suggestion I would be happy to use it. Let me try to summarize the GPIO
setup of the chip.

First we have two series of GPIOs on the chips, which I tend to think
about as two separate "banks". Thus two separate subnodes of the max7360
node.

- On one side we have what I refer to as GPIOs, here with
  maxim,max7360-gpio:
  - PORT0 to PORT7 pins of the chip.
  - Shared with PWM and rotary encoder functionalities. Functionality
    selection can be made independently for each pin. This selection is
    not described here. Runtime will have to ensure the same pin is not
    used by two drivers at the same time. E.g. we cannot have at the
    same time GPIO4 and PWM4.
  - Supports input and interrupts.
  - Outputs may be configured as constant current.
  - 8 GPIOS supported, so ngpios maximum is 8. Thinking about it now, we
    should probably also set minimum to 8, I don't see any reason to
    have ngpios set to something less.

On the other side, we have what I refer to as GPOs, here with
maxim,max7360-gpo compatible:
  - COL2 to COL7 pins of the chip.
  - Shared with the keypad functionality. Selections is made by
    partitioning the pins: first pins for keypad columns, last pins for
    GPOs. Partition is described here by ngpios and on keypad node by
    keypad,num-columns. Runtime will have to ensure values are coherent
    and configure the chip accordingly.
  - Only support outputs.
  - No support for constant current mode.
  - Supports 0 to 6 GPOs, so ngpios maximum is 6.

> > +
> > +  gpio-controller: true
> > +
> > +  "#gpio-cells":
> > +    const: 2
> > +
> > +  ngpios:
> > +    minimum: 0
> > +    maximum: 8
>
> Why this is flexible?
>

I believe this makes sense, as this keypad/gpos partition really changes
the actual number of GPIOS. Yet we could argue that this is just runtime
configuration. Tell me what you think about it, if you think this should
be a fixed value, I will find a way.

>
> Best regards,
> Krzysztof

Thanks a lot for your review. I am preparing a new version of this
series that should address all of your other comments.

--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


