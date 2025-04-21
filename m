Return-Path: <linux-pwm+bounces-5617-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BBA6A94F23
	for <lists+linux-pwm@lfdr.de>; Mon, 21 Apr 2025 12:08:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A6D13AA78E
	for <lists+linux-pwm@lfdr.de>; Mon, 21 Apr 2025 10:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7B5F25FA0F;
	Mon, 21 Apr 2025 10:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="cYU84Q0e"
X-Original-To: linux-pwm@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9DA13B2A4;
	Mon, 21 Apr 2025 10:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745230125; cv=none; b=cksZAO7n2VnDCH7bViztWc1J/4FFc4OXqQ70vCs6WmKD36zkq/AR4SlkU/Wwrw/pX1GHL7TiGM2o6yC3xy2RUFckMDjhQxjKfa3lyUNkLiULt9cRl0b4r2UGd5lf+cJTZiDII3BKBCKT0dSyIZHoXyRAuDCgfwV8k6PVsceR0Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745230125; c=relaxed/simple;
	bh=6pGa6Cbc38hPIdqm8esZILVQjx4bJAqWDNuqbaBlbgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Efv+GYX+PMENwY+mHiC/qIwpbVo7KYa62hHuaEWu51UIBJnOdpfyMWeF0S75bBG5mV/K44Vgvs9KKxqwAFXRJA5PIBD1YBXS7oOx4qzKBfDZEKmYzbZhKZDPmpq3/Or+Uk4p/9vLTz5HHaUKO+17IcJD0+pcVjn7+oJtAW1+joI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=cYU84Q0e; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 5053056D;
	Mon, 21 Apr 2025 12:06:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1745229995;
	bh=6pGa6Cbc38hPIdqm8esZILVQjx4bJAqWDNuqbaBlbgQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cYU84Q0eBMEvMoSewxFDvBtXngQWR1BDp2CGHSpB5qW41R10xCX58tuts6oDvb7wt
	 2or2Qc7ywNnmG+wr0f4XtT4D4aS/dwfBCewiAEKMYjmBBzM21p00QdC/mASyaIZSuf
	 jATWy5lleQwdBVw7Qsj7Mvpjfj4gGjM0P481QjA8=
Date: Mon, 21 Apr 2025 13:08:40 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: nuno.sa@analog.com
Cc: linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-input@vger.kernel.org,
	Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Liu Ying <victor.liu@nxp.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2 00/17] mfd: adp5585: support keymap events and drop
 legacy Input driver
Message-ID: <20250421100840.GO29968@pendragon.ideasonboard.com>
References: <20250415-dev-adp5589-fw-v2-0-3a799c3ed812@analog.com>
 <20250415155607.GI9439@pendragon.ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250415155607.GI9439@pendragon.ideasonboard.com>

Hi Nuno,

On Tue, Apr 15, 2025 at 06:56:09PM +0300, Laurent Pinchart wrote:
> On Tue, Apr 15, 2025 at 03:49:16PM +0100, Nuno Sá via B4 Relay wrote:
> > The adp5585 MFD driver was introduced in 6.11 adding support for gpio
> > and PWM. However, the gpio part of it was already supported as part of
> > the keyboard driver:
> > 
> > https://elixir.bootlin.com/linux/v6.14-rc6/source/drivers/input/keyboard/adp5589-keys.c#L532
> > 
> > On top of that it also overlapped with my refactoring of the above driver [1]
> > to drop usage of platform data and use FW properties instead.
> > 
> > Now, it actually makes sense for this device to be supported under MFD
> > and since the "legacy" input device depends on platform data that is not
> > defined anywhere the plan in this series is to add support for the
> > keyboard and adp5589 devices as part of the MFD driver. Once the MFD
> > driver supports all that's supported in the Input one, we drop it...
> > 
> > For DT Maintainers:
> > 
> > The compatible for adp5589 is part of trivial devices. To me, it makes
> > sense to remove it in the patch where we drop the driver but doing so
> > would result in a warning when adding the same compatible for the MFD
> > bindings. Hence, I remove it in that patch. Is that ok?
> > 
> > Uwe:
> > 
> > In my eval board, I could see that reading the GPIO value (when
> > configured as input) does not work when OSC_EN is not set. Therefore,

How did you test that, through the GPI_STATUS_x register ?

> > commit ("pwm: adp5585: don't control OSC_EN in the pwm driver") could
> > very well have a Fixes tag. However I'm not 100% sure it's a real issue
> > or something special to my eval board.
> > 
> > It would be nice if Laurent or Liu could test the PWM bits or even
> > check that the above is also an issue for their platform.
> 
> I'll give it a try, but it will need to wait until next week.

I can't easily test GPI or PWM with my hardware setup at the moment :-(.
I can however confirm that this series doesn't break GPO support for my
use case.

> > [1]: https://lore.kernel.org/linux-input/d1395bd61ce58b3734121bca4e09605a3e997af3.camel@gmail.com/
> > 
> > BTW the series is based on linux-next/master
> > 
> > ---
> > Changes in v2:
> > - Patch 5:
> >    * Do not nest if:then:else::if:then.
> > - Patch 6:
> >    * Make use of the adp5585 info variables and adp5589 volatile regs.
> > - Patch 9:
> >    * Use standard "poll-interval" property (and move it before vendor
> >      properties).
> > - Patch 10:
> >    * Make sure to include bitfield.h.
> > 
> > - Link to v1: https://lore.kernel.org/r/20250313-dev-adp5589-fw-v1-0-20e80d4bd4ea@analog.com
> > 
> > ---
> > Nuno Sá (17):
> >       dt-bindings: mfd: adp5585: ease on the required properties
> >       mfd: adp5585: enable oscilator during probe
> >       pwm: adp5585: don't control OSC_EN in the pwm driver
> >       mfd: adp5585: make use of MFD_CELL_NAME()
> >       dt-bindings: mfd: adp5585: document adp5589 I/O expander
> >       mfd: adp5585: add support for adp5589
> >       gpio: adp5585: add support for the ad5589 expander
> >       pwm: adp5585: add support for adp5589
> >       dt-bindings: mfd: adp5585: add properties for input events
> >       mfd: adp5585: add support for key events
> >       gpio: adp5585: support gpi events
> >       Input: adp5585: Add Analog Devices ADP5585/89 support
> >       Input: adp5589: remove the driver
> >       mfd: adp5585: support getting vdd regulator
> >       dt-bindings: mfd: adp5585: document reset gpio
> >       mfd: adp5585: add support for a reset pin
> >       pwm: adp5585: make sure to include mod_devicetable.h
> > 
> >  .../devicetree/bindings/mfd/adi,adp5585.yaml       |  240 ++++-
> >  .../devicetree/bindings/trivial-devices.yaml       |    2 -
> >  MAINTAINERS                                        |    1 +
> >  drivers/gpio/Kconfig                               |    1 +
> >  drivers/gpio/gpio-adp5585.c                        |  299 +++++-
> >  drivers/input/keyboard/Kconfig                     |   21 +-
> >  drivers/input/keyboard/Makefile                    |    2 +-
> >  drivers/input/keyboard/adp5585-keys.c              |  221 ++++
> >  drivers/input/keyboard/adp5589-keys.c              | 1066 --------------------
> >  drivers/mfd/adp5585.c                              |  808 ++++++++++++++-
> >  drivers/pwm/pwm-adp5585.c                          |   57 +-
> >  include/linux/mfd/adp5585.h                        |  153 ++-
> >  12 files changed, 1709 insertions(+), 1162 deletions(-)
> > ---
> > base-commit: 5b37f7bfff3b1582c34be8fb23968b226db71ebd
> > change-id: 20250311-dev-adp5589-fw-e04cfd945286
> > --

-- 
Regards,

Laurent Pinchart

