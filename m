Return-Path: <linux-pwm+bounces-2979-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2620094A65C
	for <lists+linux-pwm@lfdr.de>; Wed,  7 Aug 2024 12:54:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB7E91F25501
	for <lists+linux-pwm@lfdr.de>; Wed,  7 Aug 2024 10:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3450E1DF688;
	Wed,  7 Aug 2024 10:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="ULDjLgRm"
X-Original-To: linux-pwm@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42AD515B57D;
	Wed,  7 Aug 2024 10:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723028085; cv=none; b=CXKZnjn7tFllAVg405YfNEFQpiJ/CTZ3K++zX/SU8ZZdfzt3tF2NpMB3F+m818s5Gnn4Ae3fbrnVVnzyNuUQ5drXeE/NDRRl0agFubXqBuZDK/zwpNRnnM/MejdLgfXbAyX14VI1jMaRbk/OCEoAbBg/JzuHX6XPIuimWcAZ5IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723028085; c=relaxed/simple;
	bh=M0aJMIl1tKX6mdJ2CgRErtb3XgMV71w2eZ8MP2LQRoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=maOcbSrHeL0xBc84kOI8MPKtp+4RPXaFE7ig0qvvr05+r057wUw6lbet8Vt/GgHfBXS1uEx9Du+gVatD8lXLlb2kIVh7PT167LoQIsiEhbiiukkXYK4BbwCoOuzDgugQdFYRDotR9jlRyP/9KzrVB604mCfxgAQOYtfRHQaLykM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=ULDjLgRm; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id A59242EC;
	Wed,  7 Aug 2024 12:53:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1723028028;
	bh=M0aJMIl1tKX6mdJ2CgRErtb3XgMV71w2eZ8MP2LQRoY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ULDjLgRmJJFbLwcwFrRD7xwTygjJAlh6xUlTNiIgPqblfjmp2iV0ykeFjNLhRRo7S
	 5jVC733XifjLE4II+3p+FG3iz8bXBCgeZGwJG99Z5L8SJEfXWZlahMgbnSQ1tHC/Ih
	 qQexxA5j0aQF1QvBvZEqyZFCrPxgE+v4KINwcNc4=
Date: Wed, 7 Aug 2024 13:54:18 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Haibo Chen <haibo.chen@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	Frank Li <Frank.li@nxp.com>
Subject: Re: [PATCH v7 0/4] ADP5585 GPIO expander, PWM and keypad controller
 support
Message-ID: <20240807105418.GA8562@pendragon.ideasonboard.com>
References: <20240722121100.2855-1-laurent.pinchart@ideasonboard.com>
 <20240725161616.GJ501857@google.com>
 <20240801131044.GF6756@google.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240801131044.GF6756@google.com>

Hi Lee,

On Thu, Aug 01, 2024 at 02:10:44PM +0100, Lee Jones wrote:
> On Thu, 25 Jul 2024, Lee Jones wrote:
> > On Mon, 22 Jul 2024, Laurent Pinchart wrote:
> > 
> > > Hello,
> > > 
> > > This patch series introduces support for the Analog Devices ADP5585, a
> > > GPIO expander, PWM and keyboard controller. It models the chip as an MFD
> > > device, and includes DT bindings (1/4), an MFD driver (2/4) and drivers
> > > for the GPIO (3/4) and PWM (4/4) functions.
> > > 
> > > Support for the keypad controller is left out, as I have no means to
> > > test it at the moment. The chip also includes a tiny reset controller,
> > > as well as a 3-bit input programmable logic block, which I haven't tried
> > > to support (and also have no means to test).
> > > 
> > > The driver is based on an initial version from the NXP BSP kernel, then
> > > extensively and nearly completely rewritten, with added DT bindings. I
> > > have nonetheless retained original authorship. Clark, Haibo, if you
> > > would prefer not being credited and/or listed as authors, please let me
> > > know.
> > > 
> > > Compared to v6, this version addresses small review comments. I believe
> > > it is ready to go, as the PWM and GPIO drivers have been acked by the
> > > respective subsystem maintainers, and I have addressed Lee's comments on
> > > the MFD side. Lee, if there's no more issue, could you apply this to
> > > your tree for v6.12 ?
> > > 
> > > Clark Wang (1):
> > >   pwm: adp5585: Add Analog Devices ADP5585 support
> > > 
> > > Haibo Chen (2):
> > >   mfd: adp5585: Add Analog Devices ADP5585 core support
> > >   gpio: adp5585: Add Analog Devices ADP5585 support
> > > 
> > > Laurent Pinchart (1):
> > >   dt-bindings: mfd: Add Analog Devices ADP5585
> > > 
> > >  .../devicetree/bindings/mfd/adi,adp5585.yaml  |  92 +++++++
> > >  .../devicetree/bindings/trivial-devices.yaml  |   4 -
> > >  MAINTAINERS                                   |  11 +
> > >  drivers/gpio/Kconfig                          |   7 +
> > >  drivers/gpio/Makefile                         |   1 +
> > >  drivers/gpio/gpio-adp5585.c                   | 229 ++++++++++++++++++
> > >  drivers/mfd/Kconfig                           |  12 +
> > >  drivers/mfd/Makefile                          |   1 +
> > >  drivers/mfd/adp5585.c                         | 205 ++++++++++++++++
> > >  drivers/pwm/Kconfig                           |   7 +
> > >  drivers/pwm/Makefile                          |   1 +
> > >  drivers/pwm/pwm-adp5585.c                     | 184 ++++++++++++++
> > >  include/linux/mfd/adp5585.h                   | 126 ++++++++++
> > >  13 files changed, 876 insertions(+), 4 deletions(-)
> > >  create mode 100644 Documentation/devicetree/bindings/mfd/adi,adp5585.yaml
> > >  create mode 100644 drivers/gpio/gpio-adp5585.c
> > >  create mode 100644 drivers/mfd/adp5585.c
> > >  create mode 100644 drivers/pwm/pwm-adp5585.c
> > >  create mode 100644 include/linux/mfd/adp5585.h
> > 
> > Note to self: This looks good to go.  Merge after -rc1 is released.
> 
> Submitted for build testing.

Are those tests public ? Will the series eventually be merged in
https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git/ ?

> Note to self: ib-mfd-gpio-pwm-6.12

-- 
Regards,

Laurent Pinchart

