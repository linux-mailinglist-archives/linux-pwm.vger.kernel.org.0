Return-Path: <linux-pwm+bounces-2955-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FA02944CDC
	for <lists+linux-pwm@lfdr.de>; Thu,  1 Aug 2024 15:15:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAD91283BBA
	for <lists+linux-pwm@lfdr.de>; Thu,  1 Aug 2024 13:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EBD21A0B06;
	Thu,  1 Aug 2024 13:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R2jub7gC"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03BCC183CC5;
	Thu,  1 Aug 2024 13:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722517850; cv=none; b=eWwWfrtrlPJhea0MCU192SlcZb18uX4X3oovnHSK7VqdUlsNt3LjFXSWfu1pbp4pOPTpofbI1id1p25rSQ0d2P7DSNa5H9R1T+ZHmw1O44Ak1rJ03d4v2T5r1ClSrHyPoINE4+z1i8CBc8oAUcKx5nuDUBlE8R90tZHX8x+tYGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722517850; c=relaxed/simple;
	bh=7jgGoq3kHAetq8lHpHCYvhYxpy6UwVAIz5wE90KY7Ko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uXw5Sp5/ccjDQXrZVKI5eScfi7N9jfDFAvNQLzUTZTQFNJlmIwJuZA8xwA5rky7z3WynHjxTCN23nX9sxHUTkMePDYxoAO54xO2oyhLbDztzsVAlnJ2IcfIoA56V4KgAnZsULLvfVAr2LzxvDMeA0uzFJmTIoMykYmlZaRWpUKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R2jub7gC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA0C4C32786;
	Thu,  1 Aug 2024 13:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722517849;
	bh=7jgGoq3kHAetq8lHpHCYvhYxpy6UwVAIz5wE90KY7Ko=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R2jub7gCIeqcSxZuuYmIHuUyRyJROegf85SByA87QSvkcJ/g6Jh2fOiU/+rIBMKOJ
	 7y3AtHbQr/wHgT/PmkRRHfIU382zoIu+QIfMUoqhOqHunnLn3jHBsihHmCMp+w6Aqk
	 2Y3uDqWl36b3ZMJ2AKvZqRNL3LouRWpZPIVAvxfY/WDz7dabpqgPQopYucX1gYiV9S
	 v5OQxnxDc8jqOq94jK80MEjU5FBwmNRp8H2JqfGzo4K5Oxj4HRigz2kYDOYd9gsJ5G
	 to83GlKq2G8gceF2rYisjgzn1kgUzXAYl2+Q3S1DenSHC3tyJORpPOEddeMJYn3Ctf
	 ASIJDarMOeiPw==
Date: Thu, 1 Aug 2024 14:10:44 +0100
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
Message-ID: <20240801131044.GF6756@google.com>
References: <20240722121100.2855-1-laurent.pinchart@ideasonboard.com>
 <20240725161616.GJ501857@google.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240725161616.GJ501857@google.com>

On Thu, 25 Jul 2024, Lee Jones wrote:

> On Mon, 22 Jul 2024, Laurent Pinchart wrote:
> 
> > Hello,
> > 
> > This patch series introduces support for the Analog Devices ADP5585, a
> > GPIO expander, PWM and keyboard controller. It models the chip as an MFD
> > device, and includes DT bindings (1/4), an MFD driver (2/4) and drivers
> > for the GPIO (3/4) and PWM (4/4) functions.
> > 
> > Support for the keypad controller is left out, as I have no means to
> > test it at the moment. The chip also includes a tiny reset controller,
> > as well as a 3-bit input programmable logic block, which I haven't tried
> > to support (and also have no means to test).
> > 
> > The driver is based on an initial version from the NXP BSP kernel, then
> > extensively and nearly completely rewritten, with added DT bindings. I
> > have nonetheless retained original authorship. Clark, Haibo, if you
> > would prefer not being credited and/or listed as authors, please let me
> > know.
> > 
> > Compared to v6, this version addresses small review comments. I believe
> > it is ready to go, as the PWM and GPIO drivers have been acked by the
> > respective subsystem maintainers, and I have addressed Lee's comments on
> > the MFD side. Lee, if there's no more issue, could you apply this to
> > your tree for v6.12 ?
> > 
> > Clark Wang (1):
> >   pwm: adp5585: Add Analog Devices ADP5585 support
> > 
> > Haibo Chen (2):
> >   mfd: adp5585: Add Analog Devices ADP5585 core support
> >   gpio: adp5585: Add Analog Devices ADP5585 support
> > 
> > Laurent Pinchart (1):
> >   dt-bindings: mfd: Add Analog Devices ADP5585
> > 
> >  .../devicetree/bindings/mfd/adi,adp5585.yaml  |  92 +++++++
> >  .../devicetree/bindings/trivial-devices.yaml  |   4 -
> >  MAINTAINERS                                   |  11 +
> >  drivers/gpio/Kconfig                          |   7 +
> >  drivers/gpio/Makefile                         |   1 +
> >  drivers/gpio/gpio-adp5585.c                   | 229 ++++++++++++++++++
> >  drivers/mfd/Kconfig                           |  12 +
> >  drivers/mfd/Makefile                          |   1 +
> >  drivers/mfd/adp5585.c                         | 205 ++++++++++++++++
> >  drivers/pwm/Kconfig                           |   7 +
> >  drivers/pwm/Makefile                          |   1 +
> >  drivers/pwm/pwm-adp5585.c                     | 184 ++++++++++++++
> >  include/linux/mfd/adp5585.h                   | 126 ++++++++++
> >  13 files changed, 876 insertions(+), 4 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/mfd/adi,adp5585.yaml
> >  create mode 100644 drivers/gpio/gpio-adp5585.c
> >  create mode 100644 drivers/mfd/adp5585.c
> >  create mode 100644 drivers/pwm/pwm-adp5585.c
> >  create mode 100644 include/linux/mfd/adp5585.h
> 
> Note to self: This looks good to go.  Merge after -rc1 is released.

Submitted for build testing.

Note to self: ib-mfd-gpio-pwm-6.12

-- 
Lee Jones [李琼斯]

