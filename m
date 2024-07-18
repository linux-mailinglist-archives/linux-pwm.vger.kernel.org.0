Return-Path: <linux-pwm+bounces-2848-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4657993486C
	for <lists+linux-pwm@lfdr.de>; Thu, 18 Jul 2024 08:57:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E29601F2202C
	for <lists+linux-pwm@lfdr.de>; Thu, 18 Jul 2024 06:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20EA57347E;
	Thu, 18 Jul 2024 06:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="OlB6nsD5"
X-Original-To: linux-pwm@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A009F2CCA3;
	Thu, 18 Jul 2024 06:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721285833; cv=none; b=fNmUaH5/hDAeWsLLvkppIIirgmi1HtbJnuKnYqml9XcyWghm6dQ0du5cbbl9lGMp/uVT21LNCzIcGIFrEPxbQY+muuwMfwitKnnkwLQvTCyb6xuhA0REMgSsgoInLb+0Mq0qvqXOq9oC95A5W0TTZAbZj/VzxzslgLsYebixoxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721285833; c=relaxed/simple;
	bh=z+aCMhKYfdvSH3LqcS7QRiHX5Ygt46joT7nhNjNOLXA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R6V6ocq6oikBjxhzj8+vNfcMiWTu45ZEzHbhFgRHS4+nC6GeFhk81jBnyENm1YSo++iXzaZ1tfBJdxX+Dx2IpYBffxq1vvSDPIikQ1n9+bjxTEe0xWaT6Q7Ooc3L/Myt/6rFktvb5dlU/5RMviYmnc0bsfk8t91KKzRBpzY/tRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=OlB6nsD5; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 66B00C0011;
	Thu, 18 Jul 2024 06:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1721285821;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TgZHkXL2FGs1/bjZPDSboGR72yBe//NfgloPvNTjUQ0=;
	b=OlB6nsD5RtGZmYjd7bhjEoZx7QMkbbOT8V45YhxxCFz4y2iiCJe+cf2PVPl+VsXD6UUMqk
	Yc28bGhZQ13OubzP5CW/pjPqqFo91MRM0eVoREVGLvn0MLgNZy6pPxquFKWhNBkv4SbFT2
	sax9ioW5vC5M5bokQz4XncM9ZdU0GCDemzBwA+l1XJdTnXTEUKHI48dxPqMAjv00+G3aQG
	rBXI5/ojqb79XSjovNP74Rn6wSf1My85vfzfK9OmlUEoc3d8vGPg+knHhqSD5yHTRQLUcZ
	BDxiKiWHxBRawYhcLiwX+N2Krj0xmgk4IRTokaqbJaztXMntEG+p6mo1v3ON7A==
Date: Thu, 18 Jul 2024 08:56:51 +0200
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Stephen Boyd <sboyd@kernel.org>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>, Alim Akhtar <alim.akhtar@samsung.com>,
 Andreas Kemnade <andreas@kemnade.info>, Bartosz Golaszewski
 <brgl@bgdev.pl>, Bjorn Andersson <andersson@kernel.org>, Broadcom internal
 kernel review list <bcm-kernel-feedback-list@broadcom.com>, Chen-Yu Tsai
 <wens@csie.org>, Chester Lin <chester62515@gmail.com>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Damien Le Moal <dlemoal@kernel.org>, Daniel Lezcano
 <daniel.lezcano@linaro.org>, Dong Aisheng <aisheng.dong@nxp.com>, Doug
 Berger <opendmb@gmail.com>, Emilio =?UTF-8?Q?L=C3=B3pez?=
 <emilio@elopez.com.ar>, Fabio Estevam <festevam@gmail.com>, Florian
 Fainelli <florian.fainelli@broadcom.com>, Ghennadi Procopciuc
 <ghennadi.procopciuc@oss.nxp.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Jacky Bai <ping.bai@nxp.com>, Jaroslav Kysela
 <perex@perex.cz>, Jernej Skrabec <jernej.skrabec@gmail.com>, Jiri Slaby 
 <jirislaby@kernel.org>, Jonathan Cameron <jic23@kernel.org>, Kevin Hilman
 <khilman@baylibre.com>, Krzysztof Kozlowski <krzk@kernel.org>, Lars-Peter
 Clausen <lars@metafoo.de>, Lee Jones <lee@kernel.org>, Liam Girdwood
 <lgirdwood@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Mark Brown
 <broonie@kernel.org>, Matthias Brugger <mbrugger@suse.com>, Michael
 Ellerman <mpe@ellerman.id.au>, Michael Turquette <mturquette@baylibre.com>,
 Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, Nicholas Piggin
 <npiggin@gmail.com>, Nicolas Ferre <nicolas.ferre@microchip.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>, Richard Leitner
 <richard.leitner@linux.dev>, Rob Herring <robh@kernel.org>, Roger Quadros
 <rogerq@kernel.org>, Samuel Holland <samuel@sholland.org>, Saravana Kannan
 <saravanak@google.com>, Shawn Guo <shawnguo@kernel.org>, Takashi Iwai
 <tiwai@suse.com>, Thomas Gleixner  <tglx@linutronix.de>, Tony Lindgren
 <tony@atomide.com>, Uwe =?UTF-8?Q?Kleine-K=C3=B6nig?=
 <ukleinek@kernel.org>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, Thomas
 Petazzoni <thomas.petazzoni@bootlin.com>, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, llvm@lists.linux.dev,
 linux-clk@vger.kernel.org, linux-omap@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-samsung-soc@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-pwm@vger.kernel.org, linux-serial@vger.kernel.org,
 linux-usb@vger.kernel.org, patches@opensource.cirrus.com,
 linux-sound@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, Andre Przywara <andre.przywara@arm.com>,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Uwe =?UTF-8?Q?Kleine-K=C3=B6nig?=
 <u.kleine-koenig@baylibre.com>, Richard Fitzgerald
 <rf@opensource.cirrus.com>
Subject: Re: [PATCH v2] of: remove internal arguments from
 of_property_for_each_u32()
Message-ID: <20240718085651.63ddfb20@booty>
In-Reply-To: <1e36b1ba8af3584128550822a70cb072.sboyd@kernel.org>
References: <20240717-of_property_for_each_u32-v2-1-4060990f49c9@bootlin.com>
	<1e36b1ba8af3584128550822a70cb072.sboyd@kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: luca.ceresoli@bootlin.com

Hello Stephen,

On Wed, 17 Jul 2024 16:33:34 -0700
Stephen Boyd <sboyd@kernel.org> wrote:

> > @@ -1191,20 +1191,24 @@ static int si5351_dt_parse(struct i2c_client *client,
> >          * property silabs,pll-source : <num src>, [<..>]
> >          * allow to selectively set pll source
> >          */
> > -       of_property_for_each_u32(np, "silabs,pll-source", prop, p, num) {
> > +       sz = of_property_read_variable_u32_array(np, "silabs,pll-source", array, 2, 4);
> > +       sz = (sz == -EINVAL) ? 0 : sz; /* Missing property is OK */
> > +       if (sz < 0)
> > +               return dev_err_probe(&client->dev, sz, "invalid pll-source");  
> 
> Needs a newline on the printk message.

Ouch! Fix queued for v3.

Thanks,
Luca

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

