Return-Path: <linux-pwm+bounces-5251-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5873AA69538
	for <lists+linux-pwm@lfdr.de>; Wed, 19 Mar 2025 17:43:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8278B189CF4F
	for <lists+linux-pwm@lfdr.de>; Wed, 19 Mar 2025 16:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C1241E0E1A;
	Wed, 19 Mar 2025 16:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="O0afLCMd"
X-Original-To: linux-pwm@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3DE1DED44;
	Wed, 19 Mar 2025 16:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742402600; cv=none; b=a+9vlgTMgIvcHdfGmpoHrqqzi0cnOsopF4WDUDIIGlNpaXPRlb1F0bgu5R8nLJlYoRqT8FjMiM6q+9mLQiCF0S9BHlA2KlUkA0PSDAJr6eIjnJsyhLKK4/AyjYJEHRAGexIE7rVVj/Z/HqSinT6LcAsG9z+YIf+bqpxjakDC4fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742402600; c=relaxed/simple;
	bh=ZBQvYxGhQSH0Yw5IAUgX+qNDMDI41AR+NNF1w+Ttoik=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:From:To:Subject:
	 References:In-Reply-To; b=YBDEvjDTxdDf/zw1zu5IbrTYxnJrnDZ3SCStyghZ5te7xYBUw/M3FVrdFUOQDrSP6vZjoAqByDUAFAknuNnojIyRhdnVw4MHm32Jtz7XnejDOEM7md2pcu0NJGimWEiw8tDlsvU2zaodBTLYS4xCEbMlcIe7OBT8nzTw9TgDx1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=O0afLCMd; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2DFE1443C5;
	Wed, 19 Mar 2025 16:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1742402588;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aEftfqUViqbyks2Nod6W5VcZut5c+VqF8qcwHjc/Cq4=;
	b=O0afLCMdM8LsDaWO5uzNKe9f6iLnloSalc3qlYsHWmDpkVdFuDWGtULBDXdJNZ9Ggkh0i/
	GCxfuTsPnAvx4zjxBYsDnyH8Kw9b0zU1FHdXOe9WRhrKTyRDMDcNUr2rKJGUcBR4FF/cwj
	1VvLXpmS839TkiJDKnWcveuXNKNSrNrJ/pk82iheN8O+qIigEfQkydf+c7DkrSvGzjegGW
	hhPEC4C2eDvGas61Z/C8Xq5CjWhGGh/RYQ2UzI8gEKLicN+jR5mSjnnq6V7GUoHfDrbtsU
	lPTlHFx9NvDeHO8HSI35Qu+t2R0Pe5OdhygOE1tqWjlEWXzKMgVP36HaGAqCcw==
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 19 Mar 2025 17:43:06 +0100
Message-Id: <D8KE623GMSW0.2FWRYKEDOJ4UH@bootlin.com>
Cc: "Lee Jones" <lee@kernel.org>, "Krzysztof Kozlowski"
 <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, "Kamel Bouhara"
 <kamel.bouhara@bootlin.com>, "Linus Walleij" <linus.walleij@linaro.org>,
 "Bartosz Golaszewski" <brgl@bgdev.pl>, "Dmitry Torokhov"
 <dmitry.torokhov@gmail.com>, =?utf-8?q?Uwe_Kleine-K=C3=B6nig?=
 <ukleinek@kernel.org>, "Michael Walle" <mwalle@kernel.org>, "Mark Brown"
 <broonie@kernel.org>, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, "Danilo Krummrich"
 <dakr@kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
 <linux-input@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
 <andriy.shevchenko@intel.com>, =?utf-8?q?Gr=C3=A9gory_Clement?=
 <gregory.clement@bootlin.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>
From: "Mathieu Dubois-Briand" <mathieu.dubois-briand@bootlin.com>
To: "Rob Herring" <robh@kernel.org>
Subject: Re: [PATCH v5 01/11] dt-bindings: mfd: gpio: Add MAX7360
X-Mailer: aerc 0.18.2-0-ge037c095a049
References: <20250318-mdb-max7360-support-v5-0-fb20baf97da0@bootlin.com>
 <20250318-mdb-max7360-support-v5-1-fb20baf97da0@bootlin.com>
 <20250318173902.GA3256960-robh@kernel.org>
In-Reply-To: <20250318173902.GA3256960-robh@kernel.org>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeehkeegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpegggfgtfffkvefhvffuofhfjgesthhqredtredtjeenucfhrhhomhepfdforghthhhivghuucffuhgsohhishdquehrihgrnhgufdcuoehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeeftedvgfegteehjeejtdefgffhteevvddtvdejleeghfefuefgledtteduvdetkeenucffohhmrghinhepsghoohhtlhhinhdrtghomhenucfkphepvdgrtddumegtsgdugeemheehieemjegrtddtmeeffhgtfhemfhgstdgumeduvdeivdemvdgvjeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgdugeemheehieemjegrtddtmeeffhgtfhemfhgstdgumeduvdeivdemvdgvjeeipdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvvddprhgtphhtthhopehrohgshheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhgvvgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepk
 hhriihkodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghonhhorhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghmvghlrdgsohhuhhgrrhgrsegsohhothhlihhnrdgtohhmpdhrtghpthhtoheplhhinhhushdrfigrlhhlvghijheslhhinhgrrhhordhorhhgpdhrtghpthhtohepsghrghhlsegsghguvghvrdhplhdprhgtphhtthhopegumhhithhrhidrthhorhhokhhhohhvsehgmhgrihhlrdgtohhm
X-GND-Sasl: mathieu.dubois-briand@bootlin.com

On Tue Mar 18, 2025 at 6:39 PM CET, Rob Herring wrote:
> On Tue, Mar 18, 2025 at 05:26:17PM +0100, Mathieu Dubois-Briand wrote:
> > Add device tree bindings for Maxim Integrated MAX7360 device with
> > support for keypad, rotary, gpios and pwm functionalities.
> >=20
> > Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com=
>
> > ---
> >  .../bindings/gpio/maxim,max7360-gpio.yaml          |  83 ++++++++++
> >  .../devicetree/bindings/mfd/maxim,max7360.yaml     | 170 +++++++++++++=
++++++++
> >  2 files changed, 253 insertions(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/gpio/maxim,max7360-gpio.=
yaml b/Documentation/devicetree/bindings/gpio/maxim,max7360-gpio.yaml
> > new file mode 100644
> > index 000000000000..21d603d9504c
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/gpio/maxim,max7360-gpio.yaml
> > @@ -0,0 +1,83 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)

...

> > +
> > +  keypad-debounce-delay-ms:
>
> The existing debounce-delay-ms or poll-interval properties don't work=20
> for you?
>

The issue is this node also describes the rotary encoder (just below),
so I feel using only debounce-delay-ms is a bit misleading.

> > +    description: Keypad debounce delay in ms
> > +    minimum: 9
> > +    maximum: 40
> > +    default: 9
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
>
> You should have a $ref to rotary-encoder.yaml too. None of the other=20
> properties in it are needed?=20

Makes sense, thanks!

And no, I believe this is the only property we need.

>
> > +
> > +  "#pwm-cells":
> > +    const: 3
> > +
> > +  gpio:
> > +    $ref: /schemas/gpio/maxim,max7360-gpio.yaml#
> > +    description:
> > +      PORT0 to PORT7 general purpose input/output pins configuration.
> > +
> > +  gpo:
> > +    $ref: /schemas/gpio/maxim,max7360-gpio.yaml#
> > +    description: >
> > +      COL2 to COL7 general purpose output pins configuration.
> > +      Allows to use unused keypad columns as outputs.
>
> Are these paragraphs? If so, add a blank line between paragraphs. If=20
> not, re-wrap the lines.
>

OK

> > +      The MAX7360 has 8 column lines and 6 of them can be used as GPOs=
. GPIOs
> > +      numbers used for this gpio-controller node do correspond to the =
column
> > +      numbers: values 0 and 1 are never valid, values from 2 to 7 migh=
t be valid
> > +      depending on the value of the keypad,num-column property.
> > +
> > +patternProperties:
> > +  '-pins$':
> > +    type: object
> > +    description:
> > +      Pinctrl node's client devices use subnodes for desired pin confi=
guration.
> > +      Client device subnodes use below standard properties.
> > +    $ref: /schemas/pinctrl/pincfg-node.yaml
> > +
> > +    properties:
> > +      pins:
> > +        description:
> > +          List of gpio pins affected by the properties specified in th=
is
> > +          subnode.
> > +        items:
> > +          pattern: '^PORT[0-7]|ROTARY$'
>
> Don't you need ()?:
>
> ^(PORT[0-7]|ROTARY)$'
>

Yes!

Thanks for your review.
Mathieu

--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


