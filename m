Return-Path: <linux-pwm+bounces-2913-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0D4F93C70A
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jul 2024 18:16:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DC4E1C20846
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jul 2024 16:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEC1119D884;
	Thu, 25 Jul 2024 16:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SNzI3fKY"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F8817588;
	Thu, 25 Jul 2024 16:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721924182; cv=none; b=b+yaZSvWTw5LqpR6o6LHYmB6vZftGgOcbGMPQdzjeuo/WcHMwLV7otqVlmOP7eVqt4VRB/PTikJGig2BDHeluzD4GtiEUZ5OXbdnw7NtDPE6NYlaAKgmtYCcdsZQxmu62+t3Di1RKoNFoO2K+LXU2iK6+9GTvLEJtcqC/le9NUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721924182; c=relaxed/simple;
	bh=wSl7dU8k38O3kEBowowvVz0xiEyS8E2H52ryb/QbeBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g1mmOKbaQ0DNn1tTIYdK8u7ZkstBKetTbr/f6zxGo4wvHkE40SpM/qmp98nyJsHiNIIjz/rLOtll8k2dLlNmlGhPhw4VcKHFV/ZcChXhL8MiueDLqVwwuZVvJI3p5BWRtTLqgVhJ+gy+zeg3LkGSXXEX7CJQBA8X+JleLItRt3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SNzI3fKY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4316AC32782;
	Thu, 25 Jul 2024 16:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721924182;
	bh=wSl7dU8k38O3kEBowowvVz0xiEyS8E2H52ryb/QbeBI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SNzI3fKYixRUWNQpyNNkIGvI6aaRP1z2Jwy/L5siZ7h11j9aje2SDTUtweUc+p02a
	 Mlu8F8o9Q4AC2ClVmv8jh6X+TS8IKHkOTom1T5HmBaFgHXFVXRGTm+4bJJXbLX25Tc
	 Wj/7N4lZN+AVYeuDFuNfXZcCU11WB7JchW6L1f/YeJXc+6OyetD8POx0ikDFZrlZlL
	 jrn1CL/57c9fR9u9PNK3NvRboMA8wOMJ9MjcAIhKDsfXCZyCwkermnBWyZqbXjUFGI
	 YjnYEqak+/T7bs6bhRVHdoPOK/WCoR5HrMULHRBAO0uysxS0B9qUU6tJBOY/+LdZB7
	 1EZFjX1+j4unA==
Date: Thu, 25 Jul 2024 17:16:16 +0100
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
Message-ID: <20240725161616.GJ501857@google.com>
References: <20240722121100.2855-1-laurent.pinchart@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240722121100.2855-1-laurent.pinchart@ideasonboard.com>

On Mon, 22 Jul 2024, Laurent Pinchart wrote:

> Hello,
> 
> This patch series introduces support for the Analog Devices ADP5585, a
> GPIO expander, PWM and keyboard controller. It models the chip as an MFD
> device, and includes DT bindings (1/4), an MFD driver (2/4) and drivers
> for the GPIO (3/4) and PWM (4/4) functions.
> 
> Support for the keypad controller is left out, as I have no means to
> test it at the moment. The chip also includes a tiny reset controller,
> as well as a 3-bit input programmable logic block, which I haven't tried
> to support (and also have no means to test).
> 
> The driver is based on an initial version from the NXP BSP kernel, then
> extensively and nearly completely rewritten, with added DT bindings. I
> have nonetheless retained original authorship. Clark, Haibo, if you
> would prefer not being credited and/or listed as authors, please let me
> know.
> 
> Compared to v6, this version addresses small review comments. I believe
> it is ready to go, as the PWM and GPIO drivers have been acked by the
> respective subsystem maintainers, and I have addressed Lee's comments on
> the MFD side. Lee, if there's no more issue, could you apply this to
> your tree for v6.12 ?
> 
> Clark Wang (1):
>   pwm: adp5585: Add Analog Devices ADP5585 support
> 
> Haibo Chen (2):
>   mfd: adp5585: Add Analog Devices ADP5585 core support
>   gpio: adp5585: Add Analog Devices ADP5585 support
> 
> Laurent Pinchart (1):
>   dt-bindings: mfd: Add Analog Devices ADP5585
> 
>  .../devicetree/bindings/mfd/adi,adp5585.yaml  |  92 +++++++
>  .../devicetree/bindings/trivial-devices.yaml  |   4 -
>  MAINTAINERS                                   |  11 +
>  drivers/gpio/Kconfig                          |   7 +
>  drivers/gpio/Makefile                         |   1 +
>  drivers/gpio/gpio-adp5585.c                   | 229 ++++++++++++++++++
>  drivers/mfd/Kconfig                           |  12 +
>  drivers/mfd/Makefile                          |   1 +
>  drivers/mfd/adp5585.c                         | 205 ++++++++++++++++
>  drivers/pwm/Kconfig                           |   7 +
>  drivers/pwm/Makefile                          |   1 +
>  drivers/pwm/pwm-adp5585.c                     | 184 ++++++++++++++
>  include/linux/mfd/adp5585.h                   | 126 ++++++++++
>  13 files changed, 876 insertions(+), 4 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mfd/adi,adp5585.yaml
>  create mode 100644 drivers/gpio/gpio-adp5585.c
>  create mode 100644 drivers/mfd/adp5585.c
>  create mode 100644 drivers/pwm/pwm-adp5585.c
>  create mode 100644 include/linux/mfd/adp5585.h

Note to self: This looks good to go.  Merge after -rc1 is released.

-- 
Lee Jones [李琼斯]

