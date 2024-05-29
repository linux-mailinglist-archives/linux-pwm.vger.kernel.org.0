Return-Path: <linux-pwm+bounces-2294-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 124888D396E
	for <lists+linux-pwm@lfdr.de>; Wed, 29 May 2024 16:35:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9204B28910B
	for <lists+linux-pwm@lfdr.de>; Wed, 29 May 2024 14:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6083915956E;
	Wed, 29 May 2024 14:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="iwBFRY/S"
X-Original-To: linux-pwm@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC2B1E878;
	Wed, 29 May 2024 14:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716993321; cv=none; b=NOX/PswX36YSnIDVMAygO22GNwLviBkaO7wE3w3Om9nVjZRpX9gphyR5LO84Oe9+cFM2shvdT8UdmFU1WtkiGnVVcU2Ua2zWonRRcxiStC6haknF8aI35l9BWg06aMcQIQH8IwfsM7R/eWor4o3sxpxmaK7esCKTPHPGNkwY+4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716993321; c=relaxed/simple;
	bh=L5QOuW20k+ogAmMWdD97uiioC0T9avtdcJFTVooK+iY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S/7XhHnLlLnxAQc3PSGEzHsQf7O03L53dEKZmkRRfK82ZCP3XWfRnQ7Z2a4W6TK00hapn1SHWS+txN7wdIz8F9CPwaKgVI8hXi6T/X+IQC0IsVOpB9+wOhJWvqZiTcgexGVE4KZNL/aumoKB6/lkAml+W2QdOh9oWs48ewDe/00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=iwBFRY/S; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 477B74AB;
	Wed, 29 May 2024 16:35:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1716993314;
	bh=L5QOuW20k+ogAmMWdD97uiioC0T9avtdcJFTVooK+iY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iwBFRY/SoMbnxNfbatbIcrnb12Crw5w7FqQAZG0LGFFaHXAVvGWW+j/B8yD3C6Eqn
	 q4StBl2YqExw5oLdEuHUX3cIKrqBvzY23fnhblpiqKMkFEImcj3+82GD+QZXhENzo+
	 0zguCzlZI5MHt65ftZVohuaoGnrfF6S5hr/7Y1rk=
Date: Wed, 29 May 2024 17:35:06 +0300
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
Message-ID: <20240529143506.GD19014@pendragon.ideasonboard.com>
References: <20240528190315.3865-1-laurent.pinchart@ideasonboard.com>
 <20240528190315.3865-4-laurent.pinchart@ideasonboard.com>
 <ZlYyJpLeDLD_T5V6@surfacebook.localdomain>
 <20240528202044.GB8500@pendragon.ideasonboard.com>
 <CAHp75Vc2-jOMybL7vwJHgrvb_434p094tgdLo1SyK4i_RXYiDw@mail.gmail.com>
 <20240529094748.GM1436@pendragon.ideasonboard.com>
 <CAHp75Vf1uBTKHGazcuLCRvEo9k01t3+6oJnfZgpPZQ_dVCOeDg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75Vf1uBTKHGazcuLCRvEo9k01t3+6oJnfZgpPZQ_dVCOeDg@mail.gmail.com>

On Wed, May 29, 2024 at 05:24:03PM +0300, Andy Shevchenko wrote:
> On Wed, May 29, 2024 at 12:48 PM Laurent Pinchart wrote:
> > On Wed, May 29, 2024 at 09:16:43AM +0300, Andy Shevchenko wrote:
> > > On Tue, May 28, 2024 at 11:20 PM Laurent Pinchart wrote:
> > > > On Tue, May 28, 2024 at 10:36:06PM +0300, Andy Shevchenko wrote:
> 
> ...
> 
> > > > > > +   device_set_of_node_from_dev(dev, dev->parent);
> > > > >
> > > > > Why not device_set_node()?
> > > >
> > > > Because device_set_of_node_from_dev() is meant for this exact use case,
> > > > where the same node is used for multiple devices. It also puts any
> > > > previous dev->of_node, ensuring proper refcounting when devices are
> > > > unbound and rebound, without being deleted.
> > >
> > > When will the refcount be dropped (in case of removal of this device)?
> > > Or you mean it shouldn't?
> >
> > Any refcount taken on the OF node needs to be dropped. The device core
> > only drops the refcount when the device is being deleted, not when
> > there's an unbind-rebind cycle without deletion of the device (as
> > happens for instance when the module is unloaded and reloaded).
> 
> Under "device" you meant the real hardware, as Linux device (instance
> of the struct device object) is being rebuilt AFAIK)?

I mean struct device. The driver core will drop the reference in
platform_device_release(), called when the last reference to the
platform device is released, just before freeing the platform_device
instance. This happens after the device is removed from the system (e.g.
hot-unplug), but not when a device is unbound from a driver and rebound
(e.g. module unload and reload).

> > This has
> > to be handled by the driver. device_set_of_node_from_dev() handles it.
> 
> But why do you need to keep a parent node reference bumped?
> Only very few drivers in the kernel use this API and I believe either
> nobody knows what they are doing and you are right, or you are doing
> something which is not needed.

I need to set the of_node and fwnode fields of struct device to enable
OF-based lookups of GPIOs and PWMs. The of_node field is meant to be
populated by the driver core when the device is created, with a
reference to the OF node. When populated directly by driver, this needs
to be taken into account, and drivers need to ensure the reference will
be released correctly. device_set_of_node_from_dev() is meant for that.

-- 
Regards,

Laurent Pinchart

