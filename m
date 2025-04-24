Return-Path: <linux-pwm+bounces-5702-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB23A9B862
	for <lists+linux-pwm@lfdr.de>; Thu, 24 Apr 2025 21:39:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1555F7A7BF1
	for <lists+linux-pwm@lfdr.de>; Thu, 24 Apr 2025 19:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2EA2291175;
	Thu, 24 Apr 2025 19:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="FLrAhCTw"
X-Original-To: linux-pwm@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C5F2820A3;
	Thu, 24 Apr 2025 19:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745523580; cv=none; b=ZA4Avb8U2kBsoC3lbXHLyw2LEiaxmkJPC9snet6h2uPuzVuGA4kFMCxgOXZ1fIo+SQ6crjCkiKdf/MvzO+fLqi/Ts5ARxB8QMez5F+GFJI3KbTmGrk0CO8ldgAtT42T4b5kjnvrlQwJ1iA8w+iWyCdWXJ01RCbyLkQOH4STHoQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745523580; c=relaxed/simple;
	bh=QK8LMZcWNVSvVADahLdBSm+Pf+LwdXcAz3enJv8MT8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mScOiXcA8wjmtQPpfJCWVGW26GLNr7MZCEZiJbiwJod5mLWu9BGGXOUiIO0Lj5fy+W/eb70OVrJFbmBQZn9LcZTyT5VFqoEwaBRK6beWAQSdRTECrTVkVa4to4K+0HkYHKQiXppgpCE7Q6x0ujK1dg3Xh+hdyg+lEf/rUvRoIss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=FLrAhCTw; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id BC95F16A;
	Thu, 24 Apr 2025 21:39:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1745523572;
	bh=QK8LMZcWNVSvVADahLdBSm+Pf+LwdXcAz3enJv8MT8M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FLrAhCTwc7DGB1jyHGpStkTh8HORYL0PrIWGEw6vWxSiNKtWaFAXU5kduuUBeC3+C
	 w8RWaDcN8G9yXZWOl9eLN9vl1I1nJD1c2stQLG2hBuDi9vp4yrZxGBXg1k6VDruBD1
	 PshSkkeAxUC70RrQ8dEgiSJWoL001h68WJQkjh6M=
Date: Thu, 24 Apr 2025 22:39:31 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Lee Jones <lee@kernel.org>
Cc: nuno.sa@analog.com, linux-gpio@vger.kernel.org,
	linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-input@vger.kernel.org, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Liu Ying <victor.liu@nxp.com>
Subject: Re: [PATCH v2 06/17] mfd: adp5585: add support for adp5589
Message-ID: <20250424193931.GM18085@pendragon.ideasonboard.com>
References: <20250415-dev-adp5589-fw-v2-0-3a799c3ed812@analog.com>
 <20250415-dev-adp5589-fw-v2-6-3a799c3ed812@analog.com>
 <20250424161838.GM8734@google.com>
 <20250424163024.GL18085@pendragon.ideasonboard.com>
 <20250424163830.GO8734@google.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250424163830.GO8734@google.com>

On Thu, Apr 24, 2025 at 05:38:30PM +0100, Lee Jones wrote:
> On Thu, 24 Apr 2025, Laurent Pinchart wrote:
> > On Thu, Apr 24, 2025 at 05:18:38PM +0100, Lee Jones wrote:
> > > On Tue, 15 Apr 2025, Nuno Sá via B4 Relay wrote:
> > > 
> > > > From: Nuno Sá <nuno.sa@analog.com>
> > > > 
> > > > The ADP5589 is a 19 I/O port expander with built-in keypad matrix decoder,
> > > > programmable logic, reset generator, and PWM generator.
> > > > 
> > > > This patch adds the foundation to add support for the adp5589 gpio and pwm
> > > > drivers. Most importantly, we need to differentiate between some
> > > > registers addresses. It also hints to future keymap support.
> > > > 
> > > > Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> > > > ---
> > > >  drivers/mfd/adp5585.c       | 223 +++++++++++++++++++++++++++++++++++++++++---
> > > >  include/linux/mfd/adp5585.h |  57 ++++++++++-
> > > >  2 files changed, 268 insertions(+), 12 deletions(-)
> > > 
> > > [...]
> > > 
> > > > + * Bank 0 covers pins "GPIO 1/R0" to "GPIO 8/R7", numbered 0 to 7 by the
> > > > + * driver, bank 1 covers pins "GPIO 9/C0" to "GPIO 16/C7", numbered 8 to
> > > > + * 15 and bank 3 covers pins "GPIO 17/C8" to "GPIO 19/C10", numbered 16 to 18.
> > > > + */
> > > > +#define ADP5589_BANK(n)			((n) >> 3)
> > > > +#define ADP5589_BIT(n)			BIT((n) & 0x7)
> > > > +
> > > > +struct adp5585_regs {
> > > > +	unsigned int debounce_dis_a;
> > > > +	unsigned int rpull_cfg_a;
> > > > +	unsigned int gpo_data_a;
> > > > +	unsigned int gpo_out_a;
> > > > +	unsigned int gpio_dir_a;
> > > > +	unsigned int gpi_stat_a;
> > > > +	unsigned int pwm_cfg;
> > > > +	unsigned int pwm_offt_low;
> > > > +	unsigned int pwm_ont_low;
> > > > +	unsigned int gen_cfg;
> > > > +	unsigned int ext_cfg;
> > > > +};
> > > > +
> > > > +struct adp5585_info {
> > > > +	const struct mfd_cell *adp5585_devs;
> > > 
> > > Okay, we are never doing this.  Either use OF for platform registration
> > > or use MFD (or ACPI or PCI), but please do not pass MFD data through OF.
> > 
> > When I upstreamed the initial driver, I modelled the different functions
> > through child nodes in DT, with a compatible string for each child. I
> > was told very strongly to remove that. We have therefore no other choice
> > than constructing the name of the cells based on the model of the main
> > device.
> 
> It's okay to add this information statically in this driver.  It's not
> okay to then pass it through the OF API.  You can pass an identifier
> through the .data attribute to match on, but we are not passing MFD cell
> data through like this.

Sorry, I'm not following you. What's the issue with the .data field
pointing to an instance of a structure that lists properties related to
the device model ?

> > > > +	const struct regmap_config *regmap_config;
> > > > +	const struct adp5585_regs *regs;
> > > > +	unsigned int n_devs;
> > > > +	unsigned int id;
> > > 
> > > What ID is this?  We already have platform IDs and MFD cell IDs.
> > 
> > That's the value of the hardware model ID read-only register, it is used
> > as a safety check to verify that the connected device corresponds to the
> > compatible string.
> 
> I suggest changing the nomenclature to be more forthcoming.
> 
> 'model', 'version', 'hwid', 'chipid', etc.
> 
> Why is it being stored?  Is it used to match on at a later date?

The adp5585_info structure contains static information the describe each
device model. There's one global static const instance per device model,
and they are referenced from device id structures (e.g. of_device_id).
The driver gets an info pointer corresponding to the model reported by
the platform firmware (e.g. DT). It reads the device ID from the device
at probe time, and compares it with the value stored in the structure as
a safety check to ensure there's no mismatch.

-- 
Regards,

Laurent Pinchart

