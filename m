Return-Path: <linux-pwm+bounces-2700-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52C69927E98
	for <lists+linux-pwm@lfdr.de>; Thu,  4 Jul 2024 23:34:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84F9A1C22599
	for <lists+linux-pwm@lfdr.de>; Thu,  4 Jul 2024 21:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BC71143895;
	Thu,  4 Jul 2024 21:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="OW87Yyqx"
X-Original-To: linux-pwm@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9D06EB7D;
	Thu,  4 Jul 2024 21:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720128846; cv=none; b=T7gwvFceKmXueK1W0WUoBG0O+0vaURCAz3mHHC/I8L2TEA4j9loSogbsiDmBjzWic9381U8EB+gHpOGKXpzQ5V7aeavTxWxQo26LCUrtIg9v8viqKCng+n35xD+TLhCGPb72HHoVAiopg/K8olaiLAeRXBG1Bt23FHpgUDsrqi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720128846; c=relaxed/simple;
	bh=3vfbqv9gQQpm1LW9Dts5ISDGsd5fjFLtPgac8Es5wPo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uQxQjDowf0w6HFYDNPTI+AlfN8d4qzPBvgbt/gzyo0wfcLIZ33sGgmMbX3z5DA9DbDTGXy9nAt5ELsGI4xtA4ZWK2QCZUqhtlaaBndO3SX4fZpqYpmU8ahxat2jNTTg7qlGJGd65f8aVo2C97321R4fsr7Z3q46A/lh0T7sCoaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=OW87Yyqx; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2FECD240006;
	Thu,  4 Jul 2024 21:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1720128840;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q5IBUlpk519TSgD6Osr1ZyaFchjMZnggQfjeK80Zda4=;
	b=OW87YyqxfC/aisrIaK1t9t5rNi1tv8W2h+PNzPy/mbY2MLmPV40lXp/tAQHoWvKu4AWsjJ
	t1azANkvi0z3C8c1zRY+dEwMFTe4IitMjntGqs0weShRTHE6S9YLuTRM50bq5PQggOGH3h
	VTb1TQxTb2kbXJ5aFHoZUbrXoTHiCyUiMq8h02kLT12CEGs/CoF9H4DdX4VqNE0u4czR5l
	eyYcAzvCetxJAj9pUcmrGPPibpICDtqgs90easLdjOXXyAP4rPd46IcoQOzY7rAZwcoezR
	bPShL3nDBJRC3irR8YI4aF7W8jyTpxGZxv27dKpKX4ap2xqwkURoZOagKsVprQ==
Date: Thu, 4 Jul 2024 23:33:46 +0200
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Rob Herring <robh@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Saravana Kannan <saravanak@google.com>,
 Nathan Chancellor <nathan@kernel.org>, Michael Turquette
 <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Tony Lindgren
 <tony@atomide.com>, Bjorn Andersson <andersson@kernel.org>, Emilio
 =?UTF-8?Q?L=C3=B3pez?= <emilio@elopez.com.ar>, Chen-Yu Tsai
 <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland
 <samuel@sholland.org>, Krzysztof Kozlowski <krzk@kernel.org>, Daniel
 Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>,
 Florian Fainelli <florian.fainelli@broadcom.com>, Broadcom internal kernel
 review list <bcm-kernel-feedback-list@broadcom.com>, Linus Walleij
 <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, Jonathan
 Cameron <jic23@kernel.org>, Lee Jones <lee@kernel.org>, Shawn Guo
 <shawnguo@kernel.org>, Pengutronix Kernel Team <kernel@pengutronix.de>, Uwe
 =?UTF-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, Richard
 Leitner <richard.leitner@linux.dev>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Nicolas Ferre
 <nicolas.ferre@microchip.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, "Naveen N. Rao"
 <naveen.n.rao@linux.ibm.com>, Damien Le Moal <dlemoal@kernel.org>, "Peng
 Fan (OSS)" <peng.fan@oss.nxp.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, llvm@lists.linux.dev,
 linux-clk@vger.kernel.org, linux-omap@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-samsung-soc@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-pwm@vger.kernel.org, linux-serial@vger.kernel.org,
 linux-usb@vger.kernel.org, patches@opensource.cirrus.com,
 linux-sound@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org
Subject: Re: [PATCH 20/20] of: deprecate and rename
 of_property_for_each_u32()
Message-ID: <20240704233346.478431f8@booty>
In-Reply-To: <20240703180111.GA1245093-robh@kernel.org>
References: <20240703-of_property_for_each_u32-v1-0-42c1fc0b82aa@bootlin.com>
	<20240703-of_property_for_each_u32-v1-20-42c1fc0b82aa@bootlin.com>
	<20240703180111.GA1245093-robh@kernel.org>
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

Hello Rob,

On Wed, 3 Jul 2024 12:01:11 -0600
Rob Herring <robh@kernel.org> wrote:

> On Wed, Jul 03, 2024 at 12:37:04PM +0200, Luca Ceresoli wrote:
> > of_property_for_each_u32() is meant to disappear. All the call sites not
> > using the 3rd and 4th arguments have already been replaced by
> > of_property_for_each_u32_new().
> > 
> > Deprecate the old macro. Also rename it to minimize the number of new
> > usages and encourage conversion to the of_property_for_each_u32_new() macro
> > in not(-yet)-upstream code.
> > 
> > Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> > 
> > ---
> > 
> > Notes:
> > 
> >  * The following files have not been build-tested simply because I haven't
> >    managed to have a config that enables them so far:
> > 
> >      drivers/irqchip/irq-pic32-evic.c
> >      drivers/pinctrl/pinctrl-k210.c
> > 
> >  * These have not been converted yet as they are not trivial, and they will
> >    need to use a more specific function that does the lookup they need and
> >    returns the result:
> > 
> >      drivers/clk/clk-si5351.c  
> 
> I would do something like this:

Thanks for the suggestions.

I literally did not even try to look at what the code does in these few
places, and still haven't, simply due to time availability. But I wanted
to get a first series out as soon as possible as it would probably be
useful to Peng [0]. Yours will be a good starting point for when I
tackle those few remaining usages of the "old" macro. Thanks.

[0] https://lore.kernel.org/all/20240628161617.6bc9ca3c@booty/

Luca

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

