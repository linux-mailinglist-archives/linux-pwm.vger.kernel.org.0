Return-Path: <linux-pwm+bounces-4704-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 462DAA19201
	for <lists+linux-pwm@lfdr.de>; Wed, 22 Jan 2025 14:04:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16EA77A14E1
	for <lists+linux-pwm@lfdr.de>; Wed, 22 Jan 2025 13:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B8B1DF26F;
	Wed, 22 Jan 2025 13:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="cL7zb1Jz"
X-Original-To: linux-pwm@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A9083CC7;
	Wed, 22 Jan 2025 13:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737551081; cv=none; b=HCBVOkIfRRqQ0Q0xl2Dv26G6/3bYwd2NixyUlS+NceoOJg8IAX7IPEAIsaOmGbRi62Sy+7gnB8fFqqNr2ZsDQ+cqlEaoWLv+K82G99ow09INKriyU0VS5OxEcsFOr4J46/Y2oo3mwc9GmDYChe47dIqp0/iZlbL9QTxmYzDUPrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737551081; c=relaxed/simple;
	bh=ckL2x/+RTB5jAcJLnM5BfuXl2iIy6tnRr5PkfWQG42M=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=dh5gNbfM6I3fhzytk3KaJ5yKqsAKtCBefoXykmSLSrggDXstYRgLXogtGVm71mCya5ug7q1biruNbtobek3OomL3mnaioVU//BGLOVVE5DRsV5gw+2FQo547xnWF0RopE21D6NzGmnRTgA+4npBSNIJadPKUDzkb7zIy9AIJyxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=cL7zb1Jz; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 99A5F1BF206;
	Wed, 22 Jan 2025 13:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1737551076;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ksjZ4xQCGyZLDepNWwwjcpxbv8bZUSMokPqB1agcAH0=;
	b=cL7zb1JzhvAMAWsY58IHEk0qfYTqWXDrNCL18wpEKaPliFTA+0Lv1y3l+3d/0lCWTZO0nJ
	PzvPxhRX0kjFU0Q3AC9E8w/lnzEkzOy8+dFMotGy21jvKXCUXbZeamWHPhCZTFu4ATk2z2
	Uwt5p3eK/WqwjxDABC3IaXtU6R/m1xFeYBg2Y/jBV12ge4tzuI6PYZXrXNFViIgoIA3P9a
	4q5Vj27r/5xYwxCOIG+I7l3xkLlB/OE7Q3lxB5FCe2ezKHSJjXJs7tgEp0YKYbs2xhck4a
	QKeX26wwanpqdElCaX82wUmqzz2rPADU42uMcDRprG7Bk127Lq79IuC8tmITLw==
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 22 Jan 2025 14:04:35 +0100
Message-Id: <D78MG8EQMSBU.2U6T5DXG2YJXI@bootlin.com>
Subject: Re: [PATCH v2 4/7] gpio: max7360: Add MAX7360 gpio support
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
To: "Andy Shevchenko" <andriy.shevchenko@intel.com>
X-Mailer: aerc 0.18.2-0-ge037c095a049
References: <20241223-mdb-max7360-support-v2-0-37a8d22c36ed@bootlin.com>
 <20241223-mdb-max7360-support-v2-4-37a8d22c36ed@bootlin.com>
 <Z4-7KAUhfXUSmD9I@black.fi.intel.com>
In-Reply-To: <Z4-7KAUhfXUSmD9I@black.fi.intel.com>
X-GND-Sasl: mathieu.dubois-briand@bootlin.com

On Tue Jan 21, 2025 at 4:20 PM CET, Andy Shevchenko wrote:
> On Mon, Dec 23, 2024 at 05:42:36PM +0100, Mathieu Dubois-Briand wrote:

Hi Andy,

Thanks for your review. I'm not sure you have seen it, but there is a v3
of this series. V3 of this patch can be seen here:
https://lore.kernel.org/all/20250113-mdb-max7360-support-v3-4-9519b4acb0b1@=
bootlin.com/

Yet, your comments are still valid for the v3.

> > Add driver for Maxim Integrated MAX7360 GPIO/GPO controller.
> >=20
> > Two sets of GPIOs are provided by the device:
> > - Up to 8 GPIOs, shared with the PWM and rotary encoder functionalities=
.
> >   These GPIOs also provide interrupts on input changes.
> > - Up to 6 GPOs, on unused keypad columns pins.
>
> May I ask if you researched for the existing drivers that may host this w=
ithout
> much to modify?
>

I did had a look at the existing drivers and in particular at all
gpio-max* drivers. Unfortunately, I believe none of them target chipsets
similar to the MAX7360.

The only similarity I noted, is with the MAX732x chipsets, on the IRQ
side: both lack of dedicated bits for each line, leading to some logic
to try to recover the corresponding lines on interrupt. My code is
partly based on the MAX732x code on this specific point.


> Second, please, avoid OF-centric APIs in a new code. Use fwnode and/or de=
vice
> property APIs. (This stands for the whole series and any new contribution=
s)

Yes, I definitely need to remove these of_property_read_*() calls. I'm
going to replace them with device_property_read_*() calls.

Best regards,
Mathieu

--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


