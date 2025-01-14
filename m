Return-Path: <linux-pwm+bounces-4624-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B66CA10746
	for <lists+linux-pwm@lfdr.de>; Tue, 14 Jan 2025 14:02:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B82171683DA
	for <lists+linux-pwm@lfdr.de>; Tue, 14 Jan 2025 13:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 543F1236EB4;
	Tue, 14 Jan 2025 13:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="LbPiOzlq"
X-Original-To: linux-pwm@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A26C236EB3;
	Tue, 14 Jan 2025 13:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736859751; cv=none; b=LdpsjMKgPp8T9FC7vBQMl8qNgc9ismlbcQ4slHOcgL962wTM6okTEd8BIWQ8GHlv4YGbb02ewyTToNXM7TlYXQnxbhoUXrhD5vu6mEPS+DXUG3MImB3NQv4vm3mDWgB650wpkh1U4Y+ACxh5X0kTeKyVsRMxFCOqsQ3f25oAxGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736859751; c=relaxed/simple;
	bh=AA+nLKTJ9G19sEotsK0fooLH6CtrjmfqCp5x8ReVJmg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:From:To:Subject:
	 References:In-Reply-To; b=hc9UVrq0HC0Y2AHiYNWUXCaYMItFQfp6bgKUKLwbTGRu2jMtoGOvKLlH81nV5wjt+RH29uo61ALczphfiK1Pguy7DpmPQMCCzkiJSvtfLxPY6x1iUX9Yh6ofePzYKFp0QzZclYNAyt/vCbt+MYlKgNQqFitwxd8w0UxEyZwzghU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=LbPiOzlq; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2D77A60003;
	Tue, 14 Jan 2025 13:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1736859740;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y4tNhYxMV5qxeGa31gl/wwt8loSJo/cJhQFWwxvcrC0=;
	b=LbPiOzlqgfjA+x/iz0pT7pIJaygL//AWTmm6jgkrOImtC2JtWblLZqESpURvFF8DDOsCIl
	o5SKJY6oijCEb7sYlJUkAmywKWSCGmNOjmX4MY3GRm/QYF0zjf0KCoFsRg9yUJWNyPBOZT
	q0C9335cUddIGjpsP1iKwNkIrO7uOeDKhrI1YwtKDP3dxev9OsGk4iVzsATdy3Yqm/2BII
	dyG1LovtYPy7L88EbpKf8sAOiBFtb/4O25ssBS2wBEcMJKj3PS9jfDjcf3mVNiYd2DzsmT
	drK3DGIeJx99RtDfjBybNVDh/wdg2zmP5mSuYEIWbXWAYqqDKP3ERImI9niBmw==
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 14 Jan 2025 14:02:18 +0100
Message-Id: <D71TE4TEJKDF.1QRNYB2TKOMYJ@bootlin.com>
Cc: "Lee Jones" <lee@kernel.org>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley"
 <conor+dt@kernel.org>, "Kamel Bouhara" <kamel.bouhara@bootlin.com>, "Linus
 Walleij" <linus.walleij@linaro.org>, "Bartosz Golaszewski" <brgl@bgdev.pl>,
 "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-gpio@vger.kernel.org>, <linux-input@vger.kernel.org>,
 <linux-pwm@vger.kernel.org>, =?utf-8?q?Gr=C3=A9gory_Clement?=
 <gregory.clement@bootlin.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>
From: "Mathieu Dubois-Briand" <mathieu.dubois-briand@bootlin.com>
To: "Krzysztof Kozlowski" <krzk@kernel.org>
Subject: Re: [PATCH v3 1/7] dt-bindings: mfd: gpio: Add MAX7360
X-Mailer: aerc 0.18.2-0-ge037c095a049
References: <20250113-mdb-max7360-support-v3-0-9519b4acb0b1@bootlin.com>
 <20250113-mdb-max7360-support-v3-1-9519b4acb0b1@bootlin.com>
 <gerivs3f3gd3a227tu3ojn6wi6l2fbtwvw4q6n4k5aaqqupyya@xojqkp6nkrkb>
In-Reply-To: <gerivs3f3gd3a227tu3ojn6wi6l2fbtwvw4q6n4k5aaqqupyya@xojqkp6nkrkb>
X-GND-Sasl: mathieu.dubois-briand@bootlin.com

On Tue Jan 14, 2025 at 9:11 AM CET, Krzysztof Kozlowski wrote:
> On Mon, Jan 13, 2025 at 01:42:25PM +0100, Mathieu Dubois-Briand wrote:
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
> Missing type. I guess you wanted to reference rotary encoder schema,
> next to input and matrix-keymap?
>

I'm not sure I fully understood your suggestion. Do you mean adding a
reference to rotary-encoder.yaml, at the root of the document? Like:

allOf:
  - $ref: /schemas/input/matrix-keymap.yaml#
  - $ref: /schemas/input/input.yaml#
  - $ref: /schemas/input/rotary-encoder.yaml#

I did base the schema of the rotary encoder part on rotary-encoder.yaml,
but I believe we cannot reference it directly: it adds some properties
that do not make sense here (gpios, rotary-encoder,steps...) and also
some of them are mandatory.

Yet I see that I'm not referring to any type here. Also I did not
specify the default value. Would the following be OK?

  linux,axis:
    description: The input subsystem axis to map to the rotary encoder.
    $ref: /schemas/types.yaml#/definitions/uint32
    default: 0

> > +      COL2 to COL7 general purpose output pins configuration.
> > +      Allows to use unused keypad columns as outputs.
> > +      The MAX7360 has 8 column lines and 6 of them can be used as GPOs=
. Value
> > +      of ngpios must be coherent with the value of keypad,num-columns,=
 as their
> > +      sum must not exceed the number of physical lines.
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +  - interrupt-names
> > +  - linux,keymap
> > +  - linux,axis
> > +  - "#pwm-cells"
>
> gpio and gpo nodes are optional? How would the driver behave? I assume
> you need to define the partition between GPIOs, especially that 'ngpios'
> are a required property in their schema.
>

No, you are right. In my mind it was optional, but current driver
implementation will complain if the gpo node is missing. I could make it
optional in the code, but it's probably better to make it required in
the device tree, so the hardware is correctly described.

> >=20
> > --=20
> > 2.39.5
> >=20

I have fixed the other points listed in your mail. Thanks for your review.


--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


