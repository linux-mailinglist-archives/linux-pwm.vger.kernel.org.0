Return-Path: <linux-pwm+bounces-2281-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FE458D3391
	for <lists+linux-pwm@lfdr.de>; Wed, 29 May 2024 11:48:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9AFC1F28C6D
	for <lists+linux-pwm@lfdr.de>; Wed, 29 May 2024 09:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C17716E887;
	Wed, 29 May 2024 09:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="eTc91OrI"
X-Original-To: linux-pwm@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7F216EC12;
	Wed, 29 May 2024 09:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716976085; cv=none; b=d5oxhNmwlN4KD5B3nhDb0h/ztEQB/23bD1mwKJigl8Q8osOzm+03F7IJs9RvdPRYnzizblWg+A0GOEzKF7Ki2n8zVeVHLEzpNQ3mTzqZ7slTiLIL491Njf6J+3g2lfZcdMRn3p6WAHrFR/RUxcMCJU8670m4sU7XFmclEzPGdfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716976085; c=relaxed/simple;
	bh=YJCG99S3w4sz2B1YAn/661fbrZ/2LxeGIP01KqD9fR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pddXulKTjpVmgLHdKzBrROpOz/ikdcJCjE0T6gHcykdTX55djyRKi3MRLn5y1HCwqYPvZ7S+Ur735H2pZ6lGg/rAlNVAUMjuprcYfgNRuP++8uFCkMStzZP+BsGVxy18puFPZYtQ+qSkGcnzgQy/O8cnGci4kEdWz9Psdi3T49w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=eTc91OrI; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 6B0959CA;
	Wed, 29 May 2024 11:47:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1716976078;
	bh=YJCG99S3w4sz2B1YAn/661fbrZ/2LxeGIP01KqD9fR8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eTc91OrIThKOVtEu/O83Gq9yxh9jAQlhvGa7u6xEZmoQrL8z4Xoczla4s+geeFJLt
	 56UAmtlaAwGWX3AwvCxQQut0Zs97u9n3F0yUk++9W0QJa/1iHuqYyll/apFQc2Xltg
	 qLELpNi8s9wbWTk7OQ7xPb6JwlY4XJ2jxd40maYc=
Date: Wed, 29 May 2024 12:47:48 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Haibo Chen <haibo.chen@nxp.com>
Subject: Re: [PATCH v2 3/4] gpio: adp5585: Add Analog Devices ADP5585 support
Message-ID: <20240529094748.GM1436@pendragon.ideasonboard.com>
References: <20240528190315.3865-1-laurent.pinchart@ideasonboard.com>
 <20240528190315.3865-4-laurent.pinchart@ideasonboard.com>
 <ZlYyJpLeDLD_T5V6@surfacebook.localdomain>
 <20240528202044.GB8500@pendragon.ideasonboard.com>
 <CAHp75Vc2-jOMybL7vwJHgrvb_434p094tgdLo1SyK4i_RXYiDw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75Vc2-jOMybL7vwJHgrvb_434p094tgdLo1SyK4i_RXYiDw@mail.gmail.com>

On Wed, May 29, 2024 at 09:16:43AM +0300, Andy Shevchenko wrote:
> On Tue, May 28, 2024 at 11:20 PM Laurent Pinchart wrote:
> > On Tue, May 28, 2024 at 10:36:06PM +0300, Andy Shevchenko wrote:
> 
> ...
> 
> > > > +   bit = off * 2 + (off > 5 ? 4 : 0);
> > >
> > > Right, but can you use >= 6 here which immediately follows to the next
> > > question, i.e. why not use bank in this conditional?
> >
> > The ADP5585_BANK() macro is meant to be used with ADP5585_BIT(), for a
> > set of registers with the same layout. Here the layout is different, the
> > registers contain multi-bit fields. I can't use ADP5585_BIT(), so I'd
> > rather not use ADP5585_BANK() either. I have decided to use > 5 instead
> > of >= 6 to match the R5 field name in the comment above:
> >
> >         /*
> >          * The bias configuration fields are 2 bits wide and laid down in
> >          * consecutive registers ADP5585_RPULL_CONFIG_*, with a hole of 4 bits
> >          * after R5.
> >          */
> 
> First of all, the 5 sounds misleading as one needs to think about "how
> many are exactly per the register" and the answer AFAIU is 6. >= 6
> shows this. Second, I haven't mentioned _BANK(), what I meant is
> something to
> 
>   unsigned int bank = ... >= 6 ? : ;

That doesn't reflect the organisation of the bits in the registers. If
you're interested, please check the datasheet.

> ...
> 
> > > > +   struct adp5585_dev *adp5585 = dev_get_drvdata(pdev->dev.parent);
> > >
> > > (see below)
> > >
> > > > +   struct adp5585_gpio_dev *adp5585_gpio;
> > > > +   struct device *dev = &pdev->dev;
> > >
> > >       struct adp5585_dev *adp5585 = dev_get_drvdata(dev->parent);
> >
> > I prefer keeping the current ordering, with long lines first, I think
> > that's more readable.
> 
> Does the compiler optimise these two?

If anyone is interested in figuring out, I'll let them test :-)

> > > > +   struct gpio_chip *gc;
> > > > +   int ret;
> 
> ...
> 
> > > > +   device_set_of_node_from_dev(dev, dev->parent);
> > >
> > > Why not device_set_node()?
> >
> > Because device_set_of_node_from_dev() is meant for this exact use case,
> > where the same node is used for multiple devices. It also puts any
> > previous dev->of_node, ensuring proper refcounting when devices are
> > unbound and rebound, without being deleted.
> 
> When will the refcount be dropped (in case of removal of this device)?
> Or you mean it shouldn't?

Any refcount taken on the OF node needs to be dropped. The device core
only drops the refcount when the device is being deleted, not when
there's an unbind-rebind cycle without deletion of the device (as
happens for instance when the module is unloaded and reloaded). This has
to be handled by the driver. device_set_of_node_from_dev() handles it.

-- 
Regards,

Laurent Pinchart

