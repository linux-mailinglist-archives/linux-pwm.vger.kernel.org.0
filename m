Return-Path: <linux-pwm+bounces-2296-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 978E18D3A86
	for <lists+linux-pwm@lfdr.de>; Wed, 29 May 2024 17:17:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 114901F23075
	for <lists+linux-pwm@lfdr.de>; Wed, 29 May 2024 15:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED41417F390;
	Wed, 29 May 2024 15:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="P644GBvN"
X-Original-To: linux-pwm@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F90417BB17;
	Wed, 29 May 2024 15:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716995849; cv=none; b=LE0t3aAnuiyza8SGyt19Q3mu7Vow9vd5TULXGOD23nTfn2ByrC933vAsZ5LGh2U7lsInbxnlhSyGqgT60hwNGeWij2KT67Ojgg8pc/SEET/MuKFV0T3i/vA3pB1geBPQBAng8z1VKdJufXix8aNZWlXigsa414ekdgdOKMQMd7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716995849; c=relaxed/simple;
	bh=bIoj1gt/76OXi9ltSEQLk37IOmdkLDQg29Qc3G4ia1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RjHMv3A1sQHGWUeWfSAARVyJr+PJByw6DOv3VvNs50RBzBwwA5845Y7qXGmxja+Z3JnhqeDljheaCiZBduUthchmEkLlU62ToQxa6EAX9+aWAGVuvqCcbWgv+n9AsAGZ9p1TFd4J1I1TIsyqeJaC1//rLV6rll8SJ916ZMtS8f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=P644GBvN; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 0D948149B;
	Wed, 29 May 2024 17:17:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1716995843;
	bh=bIoj1gt/76OXi9ltSEQLk37IOmdkLDQg29Qc3G4ia1w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P644GBvNF57A3SEZttURwrZLx+vZ8hohyD+dBurxQ0u7GbHDQ2MXl/LEP80dEqK76
	 6AeQ1XgAI/P+LynMcHKE6CC/3MAme+gmcU2bKErjLVX/+YMC+Fyd02MwXRNVQOeFsj
	 PjNMnkIJzt1h/ayrSQiYXMqGUDxDOdO9671LXj1E=
Date: Wed, 29 May 2024 18:17:14 +0300
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
Message-ID: <20240529151714.GA8388@pendragon.ideasonboard.com>
References: <20240528190315.3865-1-laurent.pinchart@ideasonboard.com>
 <20240528190315.3865-4-laurent.pinchart@ideasonboard.com>
 <ZlYyJpLeDLD_T5V6@surfacebook.localdomain>
 <20240528202044.GB8500@pendragon.ideasonboard.com>
 <CAHp75Vc2-jOMybL7vwJHgrvb_434p094tgdLo1SyK4i_RXYiDw@mail.gmail.com>
 <20240529094748.GM1436@pendragon.ideasonboard.com>
 <CAHp75Vf1uBTKHGazcuLCRvEo9k01t3+6oJnfZgpPZQ_dVCOeDg@mail.gmail.com>
 <20240529143506.GD19014@pendragon.ideasonboard.com>
 <CAHp75Vd9kPBZJAod9auvE3W7Wn=0dZ8QSqUARk-aUgxkLHbpaA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75Vd9kPBZJAod9auvE3W7Wn=0dZ8QSqUARk-aUgxkLHbpaA@mail.gmail.com>

On Wed, May 29, 2024 at 06:00:19PM +0300, Andy Shevchenko wrote:
> On Wed, May 29, 2024 at 5:35 PM Laurent Pinchart wrote:
> > On Wed, May 29, 2024 at 05:24:03PM +0300, Andy Shevchenko wrote:
> > > On Wed, May 29, 2024 at 12:48 PM Laurent Pinchart wrote:
> > > > On Wed, May 29, 2024 at 09:16:43AM +0300, Andy Shevchenko wrote:
> > > > > On Tue, May 28, 2024 at 11:20 PM Laurent Pinchart wrote:
> > > > > > On Tue, May 28, 2024 at 10:36:06PM +0300, Andy Shevchenko wrote:
> 
> ...
> 
> > > > > > > > +   device_set_of_node_from_dev(dev, dev->parent);
> > > > > > >
> > > > > > > Why not device_set_node()?
> > > > > >
> > > > > > Because device_set_of_node_from_dev() is meant for this exact use case,
> > > > > > where the same node is used for multiple devices. It also puts any
> > > > > > previous dev->of_node, ensuring proper refcounting when devices are
> > > > > > unbound and rebound, without being deleted.
> > > > >
> > > > > When will the refcount be dropped (in case of removal of this device)?
> > > > > Or you mean it shouldn't?
> > > >
> > > > Any refcount taken on the OF node needs to be dropped. The device core
> > > > only drops the refcount when the device is being deleted, not when
> > > > there's an unbind-rebind cycle without deletion of the device (as
> > > > happens for instance when the module is unloaded and reloaded).
> > >
> > > Under "device" you meant the real hardware, as Linux device (instance
> > > of the struct device object) is being rebuilt AFAIK)?
> >
> > I mean struct device. The driver core will drop the reference in
> > platform_device_release(), called when the last reference to the
> > platform device is released, just before freeing the platform_device
> > instance. This happens after the device is removed from the system (e.g.
> > hot-unplug), but not when a device is unbound from a driver and rebound
> > (e.g. module unload and reload).
> 
> This is something I need to refresh in my memory. Any pointers (the
> links to the exact code lines are also okay) where I can find the
> proof of what you are saying. (It's not that I untrust you, it's just
> that I take my time on studying it.)

I wish this was documented, I could then point you to a nice text that
explains it all :-) My understanding comes from reading
platform_device_release(), and from failing to find other of_node_put()
calls that would be relevant to this.

> > > > This has
> > > > to be handled by the driver. device_set_of_node_from_dev() handles it.
> > >
> > > But why do you need to keep a parent node reference bumped?
> > > Only very few drivers in the kernel use this API and I believe either
> 
> s/very/a/ (sorry for the confusion)
> 
> > > nobody knows what they are doing and you are right, or you are doing
> > > something which is not needed.
> >
> > I need to set the of_node and fwnode fields of struct device to enable
> > OF-based lookups of GPIOs and PWMs. The of_node field is meant to be
> > populated by the driver core when the device is created, with a
> > reference to the OF node. When populated directly by driver, this needs
> > to be taken into account, and drivers need to ensure the reference will
> > be released correctly. device_set_of_node_from_dev() is meant for that.
> 
> What you are doing is sharing the parent node with the child, but at
> the same time you bump the parent's reference count. As this is a
> child of MFD I don't think you need this as MFD already takes care of
> it via parent -> child natural dependencies. Is it incorrect
> understanding?

It is true that the parent device will not be destroyed as long as the
child device exists. The parent device's of_node will thus be kept
around by the reference that the parent device holds on it. However, if
I set dev.of_node for the child device without acquiring a reference, we
will have dev.of_node pointing to the same device_node, with a single
reference to it. This means that when the child device is destroyed and
platform_device_release() is called for it, of_node_put() will release
that reference, and the parent dev.of_node will point to a device_node
without holding a reference. Then, when the parent device, which is an
i2c_client, is unregistered, the call to i2c_unregister_device() will
call of_node_put(), releasing a reference we don't have.

The order of i2c_unregister_device() and platform_device_release() may
be swapped in practice, I haven't double-checked, but the reasoning
still holds. We have two functions that expect dev.of_node to hold a
reference, so both dev.of_node need to hold a reference.

Another way to handle the problem would be to borrow the parent's
reference in the probe function of the child, and set dev.of_node to
NULL manually in the child .remove() function. This will ensure that
platform_device_release(), which is called after .remove() (not
necessarily directly after, but certainly not before), will not attempt
to incorrectly release a reference on dev.of_node. This will however not
be safe if i2c_unregister_device() is called before the child .remove(),
as the child dev.of_node would then for some amount of time point to a
device_node without a reference.

TL;DR: Using device_set_of_node_from_dev() seems the safest option,
especially given that it was designed for this purpose.

-- 
Regards,

Laurent Pinchart

