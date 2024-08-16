Return-Path: <linux-pwm+bounces-3025-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F079954D3E
	for <lists+linux-pwm@lfdr.de>; Fri, 16 Aug 2024 16:57:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D86AB23E27
	for <lists+linux-pwm@lfdr.de>; Fri, 16 Aug 2024 14:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 659811BE853;
	Fri, 16 Aug 2024 14:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oklD/Sg+"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B9F1BD01F;
	Fri, 16 Aug 2024 14:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723820061; cv=none; b=W3uYabY0VaMFlOEPml+l+mxyomTWcTNDqVLVdTgn2rJZxgmFN+vTE88SoHqB6GqY1wrRoFrnC8OIVUnlyihSjHoodE7Ai95IFkgAhEMrCIZbdTXkMrDPdCkfwF+AHZipAVaxOUvqOLpVTB9IkHGUoLM3nI2h+4GLuuLfh9hIncQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723820061; c=relaxed/simple;
	bh=78otssZMSXfx1mx9AaYXC8oqCx4zvXSJqowAtShFVRw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pdE5mygnhmOmtzf95b5ADItaeYREy5wn15lWZ9vHxvfGZFD8vpSq2WTpVMTpp2AmBh+DtWUmoPoLmPDgkG9BhhZhRaxCCsAp3we6vUm0ITZS38lrqHEc6qXBXwLR0DUT29rwqnqjKmus0zPRe0zBY/wCcBA9PbBeUGQEgXMjgtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oklD/Sg+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B18F9C32782;
	Fri, 16 Aug 2024 14:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723820060;
	bh=78otssZMSXfx1mx9AaYXC8oqCx4zvXSJqowAtShFVRw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oklD/Sg+QQth2aZWuDJhvPlnx9zq+cenScXXGlKdQe25lUnoPUp9xpTQnkcf9LTOG
	 hrojpvRi5rhro7xjvXb4TXfPF68qBJoJwOSFMZ4LPNhqf/i47B/jfa2CY2O814syVm
	 tVa7BdBW86tsnbriMcDmMNWVR36bTan9GbOgQfbSw8rvpioT2pZTU7qh9eEnQ7mSAp
	 x2TtstSgqw7O7obKtigVMS2IRrec5gHUgs8F1ct93D3KmfHyj/q67xxq8HN3PtTO/R
	 U/ReIucT4pBfiyTkQkmbvXeh4PQ11mC6PHY2od5eij7uXq6b4VwQTCjN3cwGSTBBYT
	 s+vhCyK7tf1Uw==
Date: Fri, 16 Aug 2024 15:54:05 +0100
From: Lee Jones <lee@kernel.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Haibo Chen <haibo.chen@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	Frank Li <Frank.li@nxp.com>
Subject: Re: [PATCH v7 0/4] ADP5585 GPIO expander, PWM and keypad controller
 support
Message-ID: <20240816145405.GA5853@google.com>
References: <20240722121100.2855-1-laurent.pinchart@ideasonboard.com>
 <20240725161616.GJ501857@google.com>
 <20240801131044.GF6756@google.com>
 <20240807105418.GA8562@pendragon.ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240807105418.GA8562@pendragon.ideasonboard.com>

On Wed, 07 Aug 2024, Laurent Pinchart wrote:

> Hi Lee,
> 
> On Thu, Aug 01, 2024 at 02:10:44PM +0100, Lee Jones wrote:
> > On Thu, 25 Jul 2024, Lee Jones wrote:
> > > On Mon, 22 Jul 2024, Laurent Pinchart wrote:
> > > 
> > > > Hello,
> > > > 
> > > > This patch series introduces support for the Analog Devices ADP5585, a
> > > > GPIO expander, PWM and keyboard controller. It models the chip as an MFD
> > > > device, and includes DT bindings (1/4), an MFD driver (2/4) and drivers
> > > > for the GPIO (3/4) and PWM (4/4) functions.
> > > > 
> > > > Support for the keypad controller is left out, as I have no means to
> > > > test it at the moment. The chip also includes a tiny reset controller,
> > > > as well as a 3-bit input programmable logic block, which I haven't tried
> > > > to support (and also have no means to test).
> > > > 
> > > > The driver is based on an initial version from the NXP BSP kernel, then
> > > > extensively and nearly completely rewritten, with added DT bindings. I
> > > > have nonetheless retained original authorship. Clark, Haibo, if you
> > > > would prefer not being credited and/or listed as authors, please let me
> > > > know.
> > > > 
> > > > Compared to v6, this version addresses small review comments. I believe
> > > > it is ready to go, as the PWM and GPIO drivers have been acked by the
> > > > respective subsystem maintainers, and I have addressed Lee's comments on
> > > > the MFD side. Lee, if there's no more issue, could you apply this to
> > > > your tree for v6.12 ?
> > > > 
> > > > Clark Wang (1):
> > > >   pwm: adp5585: Add Analog Devices ADP5585 support
> > > > 
> > > > Haibo Chen (2):
> > > >   mfd: adp5585: Add Analog Devices ADP5585 core support
> > > >   gpio: adp5585: Add Analog Devices ADP5585 support
> > > > 
> > > > Laurent Pinchart (1):
> > > >   dt-bindings: mfd: Add Analog Devices ADP5585
> > > > 
> > > >  .../devicetree/bindings/mfd/adi,adp5585.yaml  |  92 +++++++
> > > >  .../devicetree/bindings/trivial-devices.yaml  |   4 -
> > > >  MAINTAINERS                                   |  11 +
> > > >  drivers/gpio/Kconfig                          |   7 +
> > > >  drivers/gpio/Makefile                         |   1 +
> > > >  drivers/gpio/gpio-adp5585.c                   | 229 ++++++++++++++++++
> > > >  drivers/mfd/Kconfig                           |  12 +
> > > >  drivers/mfd/Makefile                          |   1 +
> > > >  drivers/mfd/adp5585.c                         | 205 ++++++++++++++++
> > > >  drivers/pwm/Kconfig                           |   7 +
> > > >  drivers/pwm/Makefile                          |   1 +
> > > >  drivers/pwm/pwm-adp5585.c                     | 184 ++++++++++++++
> > > >  include/linux/mfd/adp5585.h                   | 126 ++++++++++
> > > >  13 files changed, 876 insertions(+), 4 deletions(-)
> > > >  create mode 100644 Documentation/devicetree/bindings/mfd/adi,adp5585.yaml
> > > >  create mode 100644 drivers/gpio/gpio-adp5585.c
> > > >  create mode 100644 drivers/mfd/adp5585.c
> > > >  create mode 100644 drivers/pwm/pwm-adp5585.c
> > > >  create mode 100644 include/linux/mfd/adp5585.h
> > > 
> > > Note to self: This looks good to go.  Merge after -rc1 is released.
> > 
> > Submitted for build testing.
> 
> Are those tests public ? Will the series eventually be merged in
> https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git/ ?

Sorry for the delay - vacation.

No, the tests/branches are not public.

> > Note to self: ib-mfd-gpio-pwm-6.12

-- 
Lee Jones [李琼斯]

