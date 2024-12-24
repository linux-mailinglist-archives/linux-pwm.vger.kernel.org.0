Return-Path: <linux-pwm+bounces-4494-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 06FDA9FBD3E
	for <lists+linux-pwm@lfdr.de>; Tue, 24 Dec 2024 13:22:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A1177A1E33
	for <lists+linux-pwm@lfdr.de>; Tue, 24 Dec 2024 12:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F127F1B85C0;
	Tue, 24 Dec 2024 12:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="T9JFTXGT"
X-Original-To: linux-pwm@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38DFE192D80;
	Tue, 24 Dec 2024 12:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735042932; cv=none; b=WpC6oIaM4CZNaCjjwIzR4Z7eizlE/36ZNRQTRT9+tBXrq/6ofcjg7o7byOj/SUslXx51KvMiC4yDzXKIA5x/v1y7u5Fub7LbiAEpBABntqlyOUcKB0qzqH5bDCCALaOl9KmJZbHOZgUjDfKhDf5pv5/4v6GcEYiGrAEgiZisWac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735042932; c=relaxed/simple;
	bh=Tpk2lyufDIJeqEB4SYmFoIx0pp4yyZFa8sPDQSM0lho=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=i+5NpZRmHwPHvoiiWmlOBMx82k+Ro+gzSYW7kox7RWgjdGAGjafiUnwdWlRZgcy0Rz/PSJsraK3Nbx7UHa+zCe+FoQl7Ng5TBwImWKLt/tom23Zaxn7nWBBid9to1Ug2QyfU0x9+ukh2SieGkzEyATl5qzN5436pX0MJWrtnTp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=T9JFTXGT; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id CD2CF1BF205;
	Tue, 24 Dec 2024 12:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1735042927;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4RrDwPMK97cYRabWdHRnkpA6/8aqN4PYvEtEzjM12i8=;
	b=T9JFTXGTWurKWlhVPkz/zKE2SELy+egAJf5O5Q6oZzqJjZUXfRxX65lk/OL+0hWrPujxM/
	6ZxlQDoVqHHaXejfFYrQSrBloWkpeYOwz7iexs5q/AyxWtnTbogISJyA6IpB01vAnt3E4U
	muSZMIstcKnt2LN0m1G0WNMuflKjeIk0Z0srKxHqzXuPPFxkwvGgMM333O0WYh0SbVdwGu
	l3sYNH01xLn+9jZ8MTflxPcbXjBcjRsfQ6OaphqIFdZHlZHcCyD2yxnF2gPxcdE7QaHGDh
	oL49pDTaexsdEZTuJWzVPSZOHb4nD/MLosYsEm9XQp1AFUwY4I2/WT29TTr7gQ==
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 24 Dec 2024 13:22:06 +0100
Message-Id: <D6JXDWUG8PIC.1HWXX7RCA9N6E@bootlin.com>
Subject: Re: [PATCH v2 1/7] dt-bindings: mfd: gpio: Add MAX7360
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
References: <20241223-mdb-max7360-support-v2-0-37a8d22c36ed@bootlin.com>
 <20241223-mdb-max7360-support-v2-1-37a8d22c36ed@bootlin.com>
 <93295e50-aa16-42a1-b489-fb4c3312f05b@kernel.org>
In-Reply-To: <93295e50-aa16-42a1-b489-fb4c3312f05b@kernel.org>
X-GND-Sasl: mathieu.dubois-briand@bootlin.com

On Tue Dec 24, 2024 at 10:12 AM CET, Krzysztof Kozlowski wrote:
> On 23/12/2024 17:42, Mathieu Dubois-Briand wrote:
> > Add device tree bindings for Maxim Integrated MAX7360 device with
> > support for keypad, rotary, gpios and pwm functionalities.
> >=20
> > Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com=
>
> > ---
> >  .../bindings/gpio/maxim,max7360-gpio.yaml          |  80 +++++++++++++=
++
> >  .../devicetree/bindings/mfd/maxim,max7360.yaml     | 107 +++++++++++++=
++++++++
> >  2 files changed, 187 insertions(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/gpio/maxim,max7360-gpio.=
yaml b/Documentation/devicetree/bindings/gpio/maxim,max7360-gpio.yaml
> > new file mode 100644
> > index 000000000000..6e6133ce6e68
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/gpio/maxim,max7360-gpio.yaml
> > @@ -0,0 +1,80 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/gpio/maxim,max7360-gpio.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Maxim MAX7360 GPIO controller
> > +
> > +maintainers:
> > +  - Kamel Bouhara <kamel.bouhara@bootlin.com>
> > +  - Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
> > +
> > +description: |
> > +  Maxim MAX7360 GPIO controller, in MAX7360 chipset
> > +  https://www.analog.com/en/products/max7360.html
>
> Don't send new versions so fast, especially for larger patchsets, so we
> can finish previous discussion.
>
> You gave me yesterday around 1 hour to respond to your last email and
> then you sent v2.
>

Soddy, I didn't mean to. I thought having a v2 would be easier to show
how I addressed the previous comments, but I definitely was too fast. I
will make sure to wait more next time.

> Please implement my last comments on v1.
>
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - maxim,max7360-gpio
> > +      - maxim,max7360-gpo
>
>
> ...
>
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    gpio {
> > +      compatible =3D "maxim,max7360-gpio";
> > +
> > +      gpio-controller;
> > +      #gpio-cells =3D <0x2>;
>
> Not a hex, <2>
>
> > +      ngpios =3D <8>;
> > +      maxim,constant-current-disable =3D <0x06>;
> > +
> > +      interrupt-controller;
> > +      #interrupt-cells =3D <0x2>;
>
> Not a hex, <2>
>

Ok, I will fix both values.

> > +      };
> > diff --git a/Documentation/devicetree/bindings/mfd/maxim,max7360.yaml b=
/Documentation/devicetree/bindings/mfd/maxim,max7360.yaml
> > new file mode 100644
> > index 000000000000..1f761707070a
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mfd/maxim,max7360.yaml
> > @@ -0,0 +1,107 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/mfd/maxim,max7360.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Maxim MAX7360 Keypad, Rotary encoder, PWM and GPIO controller
> > +
> > +maintainers:
> > +  - Kamel Bouhara <kamel.bouhara@bootlin.com>
> > +  - Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
> > +
> > +description: |
> > +  Maxim MAX7360 device, with following functions:
> > +    - keypad controller
> > +    - rotary controller
> > +    - GPIO and GPO controller
> > +    - PWM controller
> > +
> > +  https://www.analog.com/en/products/max7360.html
> > +
> > +allOf:
> > +  - $ref: /schemas/input/matrix-keymap.yaml#
> > +  - $ref: /schemas/input/input.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - maxim,max7360
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    minItems: 2
>
> You can drop minItems.
>

Ok, fixed.

> > +    maxItems: 2
> > +> +  interrupt-names:
> > +    items:
> > +      - const: inti
> > +      - const: intk
> > +
> > +  keypad-debounce-delay-ms:
> > +    description: Keypad debounce delay in ms
> > +    minimum: 9
> > +    maximum: 40
> > +    default: 9
> > +
> > +  autorepeat: true
> > +
> > +  rotary-debounce-delay-ms:
> > +    description: Rotary encoder debounce delay in ms
> > +    minimum: 0
> > +    maximum: 15
> > +    default: 0
> > +
> > +  linux,axis:
> > +    description: The input subsystem axis to map to this rotary encode=
r.
> > +
> > +  "#pwm-cells":
> > +    const: 3
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +  - interrupt-names
> > +  - linux,keymap
> > +  - linux,axis
> > +  - "#pwm-cells"
> > +
> > +unevaluatedProperties: false
> > +
>
> Well, I still see it incomplete... and to prove it, please post your DTS
> for entire max7360 and validate it against bindings.
>
> There is no way this works, unless GPIO is not part of this device but
> then it is obviously incorrect design.
>

Ok, it looks like I completely missed how it was supposed to be
described. So, if I got it right, I need to:
- Add two properties, gpio and gpo, with $ref: /schemas/gpio/maxim,max7360-=
gpio.yaml#
- Add the two gpio and gpo child nodes in the example.

>
> Best regards,
> Krzysztof

Thanks for your review,
Mathieu

--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


