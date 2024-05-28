Return-Path: <linux-pwm+bounces-2250-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D623F8D1B43
	for <lists+linux-pwm@lfdr.de>; Tue, 28 May 2024 14:28:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 912A328667E
	for <lists+linux-pwm@lfdr.de>; Tue, 28 May 2024 12:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6304B16D4F2;
	Tue, 28 May 2024 12:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="kDdVQQAG"
X-Original-To: linux-pwm@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC6716B722;
	Tue, 28 May 2024 12:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716899270; cv=none; b=LWZQNFU1yLMsuMbh48gVHuC/fEtM3Pt1FRsE635QHdeTjrAgMGYt1loYYlYbcp5Kvr10TGRBOyg32fdtz7quteT3rJ9PTa5xaPJesztYJxDtSTbohXO/sviKqmj9h72D2T2SBJsa1NDWtNFTQNhVBBRKMJfBQTzpMDyyLV4f9LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716899270; c=relaxed/simple;
	bh=I8xyTDSo2DdUfwiGqFmJGZhy5ikIjBhPpjVahgmEH2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dFjtME/UzMqLIWHj350d2pfRxkMr220bemSSMu1p/UV3JnXiXf92GjU2hRXDFSGt2v+AOEvgTAFa9nSlophK0pflGI9rXcDuSjlvyfDWWZf/dJ88BUUm1CSRLP6N9HRAhtecdSV4i0XpUwgVuehevzMx0Cbl2qgJbvV+de0/2SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=kDdVQQAG; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 601208D0;
	Tue, 28 May 2024 14:27:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1716899263;
	bh=I8xyTDSo2DdUfwiGqFmJGZhy5ikIjBhPpjVahgmEH2k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kDdVQQAGaDRMwpDxn+N+kHyvAbTb3NMVBSx1ViZ2jWmu7ZOqZ9f40Yare7Sa1PKn/
	 FLia8QxHpNUngQuB05RXVCkUKKd0gNFCumWF9F2WeLpez3uNuZHEGjeAArYBxQaJcd
	 pCitUJFW/MXne08UYXX9iudRsw0LEBRUOUymRwZ0=
Date: Tue, 28 May 2024 15:27:34 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org,
	Alexandru Ardelean <alexandru.ardelean@analog.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Haibo Chen <haibo.chen@nxp.com>
Subject: Re: [PATCH 4/5] gpio: adp5585: Add Analog Devices ADP5585 support
Message-ID: <20240528122734.GA29970@pendragon.ideasonboard.com>
References: <20240520195942.11582-1-laurent.pinchart@ideasonboard.com>
 <20240520195942.11582-5-laurent.pinchart@ideasonboard.com>
 <CACRpkdbAq1Cqr4X8fjEjOTxw7ky9b6V0ye1NYKfDy5E1BmAX6g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdbAq1Cqr4X8fjEjOTxw7ky9b6V0ye1NYKfDy5E1BmAX6g@mail.gmail.com>

Hi Linus,

On Tue, May 28, 2024 at 01:54:29PM +0200, Linus Walleij wrote:
> On Mon, May 20, 2024 at 9:59 PM Laurent Pinchart wrote:
> 
> > From: Haibo Chen <haibo.chen@nxp.com>
> >
> > The ADP5585 is a 10/11 input/output port expander with a built in keypad
> > matrix decoder, programmable logic, reset generator, and PWM generator.
> > This driver supports the GPIO function using the platform device
> > registered by the core MFD driver.
> >
> > The driver is derived from an initial implementation from NXP, available
> > in commit 451f61b46b76 ("MLK-25917-2 gpio: adp5585-gpio: add
> > adp5585-gpio support") in their BSP kernel tree. It has been extensively
> > rewritten.
> >
> > Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> > Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> 
> (...)
> 
> > +static int adp5585_gpio_direction_input(struct gpio_chip *chip, unsigned int off)
> > +{
> > +       struct adp5585_gpio_dev *adp5585_gpio = gpiochip_get_data(chip);
> > +       unsigned int bank = ADP5585_BANK(off);
> > +       unsigned int bit = ADP5585_BIT(off);
> > +
> > +       guard(mutex)(&adp5585_gpio->lock);
> > +
> > +       return regmap_update_bits(adp5585_gpio->regmap,
> > +                                 ADP5585_GPIO_DIRECTION_A + bank,
> > +                                 bit, 0);
> 
> First, I love the guarded mutex!

Yes, it's neat :-)

> But doesn't regmap already contain a mutex? Or is this one of those
> cases where regmap has been instantiated without a lock?

regmap indeed includes a lock, but it will lock each register access
independently. In adp5585_gpio_get_value() we need to read two
registers atomically, so we need to cover them by a single lock.

I could drop the lock from regmap, but I would then likely need to
introduce a lock in the parent mfd device that both the PWM and GPIO
children would use to protect bus access. That may make sense in the
future, but is a bit overkill for now I think.

> > +       gc = &adp5585_gpio->gpio_chip;
> > +       gc->parent = dev;
> > +       gc->direction_input  = adp5585_gpio_direction_input;
> > +       gc->direction_output = adp5585_gpio_direction_output;
> 
> And chance to implemen ->get_direction()?

Sure, I'll add that to v2.

> Other than this I think the driver is ready for merge, so with the
> comments fixed or addressed:
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Thank you.

-- 
Regards,

Laurent Pinchart

