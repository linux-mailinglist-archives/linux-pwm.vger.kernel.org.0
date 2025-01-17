Return-Path: <linux-pwm+bounces-4657-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27687A152C5
	for <lists+linux-pwm@lfdr.de>; Fri, 17 Jan 2025 16:22:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99C781885192
	for <lists+linux-pwm@lfdr.de>; Fri, 17 Jan 2025 15:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F4B81802DD;
	Fri, 17 Jan 2025 15:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="m3IUwG8O"
X-Original-To: linux-pwm@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16982B9B9;
	Fri, 17 Jan 2025 15:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737127365; cv=none; b=pH0iCZROn61iwUJPTEV9YSDOKp7KX/GG7/v1vvWkt9dJGiowChYDmhtHet7nHLB4TAW4fDJ7NFumhJfpY17JJHx5FSt8qtLQr5yZmCtteocPzAVZ9HtGR9C1O0qk6YVN/N21Xvvk9W/IJ8Tn+/mdHCJxSlMGEsj9d78zl1Smwjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737127365; c=relaxed/simple;
	bh=7PhJw7mo1SQ6wUmL3zAzxLF+Z/WrZMp16H0K1GB6vKU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=YPL9EPxJeUwV8HlLr9tIyY7I/fESrK3cQ2tGLvZ0FkM7ziW0uH2yygzqt2A7pmI/ZPyygpkKk1PY75dlVi5pMm9o68yk8RU5dKlYPTNPQWEPDXGhMOlg/tjmXMPsUXnZBdxirfz3FT2nFg5zY/vHauG9jOD5D45eB1EuKLMUDBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=m3IUwG8O; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A67D2240002;
	Fri, 17 Jan 2025 15:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1737127354;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7PhJw7mo1SQ6wUmL3zAzxLF+Z/WrZMp16H0K1GB6vKU=;
	b=m3IUwG8ObNkRRt1Rm94xVayR7ZciAse9i7TSiTRmMRWLgy1Xf8Zm5jP26Mag1xLiZqQqtI
	v8sSO596nmwLIpsqKkrqvswM3sAQAUyEXwgrJs5ysC/kenJouaWZ37Wdsg3EunIE4VLykw
	3G8zkazykLuE6RgXmqpnK8A3kr9tG7kYiKjwPDZ3i9SaRUvgGKDOn4gIi2IqEEpKXd4/4X
	KtQXovFgzG863SAy7bRG/Li2IUMpp0ciMRQ3SXSQNL+uX8MDz8pn9cYajQe8HEwrgBwycN
	SGmAflr2CYNUsviPsEhrlzV9JmIsRqsQi2hjmVEzc8rwD2n5sg7KZp/K6j1noA==
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 17 Jan 2025 16:22:33 +0100
Message-Id: <D74G95A3DHG3.OD522T88GX83@bootlin.com>
Subject: Re: [PATCH v3 4/7] gpio: max7360: Add MAX7360 gpio support
Cc: "Lee Jones" <lee@kernel.org>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley"
 <conor+dt@kernel.org>, "Kamel Bouhara" <kamel.bouhara@bootlin.com>,
 "Bartosz Golaszewski" <brgl@bgdev.pl>, "Dmitry Torokhov"
 <dmitry.torokhov@gmail.com>, =?utf-8?q?Uwe_Kleine-K=C3=B6nig?=
 <ukleinek@kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
 <linux-input@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
 =?utf-8?q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>, "Thomas
 Petazzoni" <thomas.petazzoni@bootlin.com>
From: "Mathieu Dubois-Briand" <mathieu.dubois-briand@bootlin.com>
To: "Linus Walleij" <linus.walleij@linaro.org>
X-Mailer: aerc 0.18.2-0-ge037c095a049
References: <20250113-mdb-max7360-support-v3-0-9519b4acb0b1@bootlin.com>
 <20250113-mdb-max7360-support-v3-4-9519b4acb0b1@bootlin.com>
 <CACRpkdb5rmUK06uW3M2Lsy4Wam8JvrjmGM83cJa-V3LZwTX9dg@mail.gmail.com>
In-Reply-To: <CACRpkdb5rmUK06uW3M2Lsy4Wam8JvrjmGM83cJa-V3LZwTX9dg@mail.gmail.com>
X-GND-Sasl: mathieu.dubois-briand@bootlin.com

On Tue Jan 14, 2025 at 3:33 PM CET, Linus Walleij wrote:
> On Mon, Jan 13, 2025 at 1:43=E2=80=AFPM Mathieu Dubois-Briand
> My most generic feedback is if you have looked at using
> select GPIO_REGMAP for this driver?
>
> The regmap utility library is very helpful, look how other driver
> selecting GPIO_REGMAP gets default implementations
> from the library just git grep GPIO_REGMAP drivers/gpio/
>

I tried to switch to GPIO_REGMAP and I really like it overall, as it
does simplify a lot the code. However, I identified two features that I
was not able to port so far: the request()/free() callbacks and the
interrupts.

So for the request()/free() callbacks, I cannot add them anymore, as
they are set on the gpio_chip structure, and this structure is hidden
behind the gpio_regmap structure. I could easily modify the
gpio_regmap_config structure and gpio_regmap_register() to allow to
provide these callbacks, but is this acceptable? Or should I switch to a
different way to prevent concurrent use of the same pin? I saw you
mentioned the possibility of defining pin control.

On the IRQ side, before switching to GPIO_REGMAP, I was able to define
the IRQ configuration using the irq member of the gpio_chip structure.
This does create the IRQ domain for me in a quite straightforward way.
Again, I will not be able to do that anymore, as the gpio_chip structure
is hidden.=20

I saw I can specify my own irq_domain in gpio_regmap_config, so that
would be a way, but I was wondering if there is any way to have
something as easy as previously.

I had a quick look at existing drivers using GPIO_REGMAP and providing
IRQ support: I believe they are all using REGMAP_IRQ. And I believe I
cannot use REGMAP_IRQ here, as if I understood correctly, I would need
to have a register telling me exactly on which GPIO I have a pending
interrupt and I don't have such a thing: all I know is there was an
interrupt related to the GPIOs, and then I have to compare each GPIO
with the previous known state to know which pin is affected.

Do you have any thought about this?

Best regards,
Mathieu

--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


