Return-Path: <linux-pwm+bounces-5700-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3C71A9B44C
	for <lists+linux-pwm@lfdr.de>; Thu, 24 Apr 2025 18:39:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3193D3B4EFD
	for <lists+linux-pwm@lfdr.de>; Thu, 24 Apr 2025 16:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88F972857CF;
	Thu, 24 Apr 2025 16:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PO/yfO5T"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514B02820B3;
	Thu, 24 Apr 2025 16:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745512716; cv=none; b=iXz4axuo069HZypgdSm4M95cM8iKYytkPhuZUo+8fc++8m6iDr+SBrbPjRtfvCCT9e4T2P+pM/j9Xm50zKSyWOffmO64V9jWMn9tPPPZEEXoEoU2VUTCKhjuJZ8medL4SMdZgSPJT4bFECHi2IZdZ3Aqzu6avFCtFE4fhH2lpgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745512716; c=relaxed/simple;
	bh=ll3w0lsvdmkLiHxkvigNPmcFMMcoAwsNuGmp6cF0rqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KqsJmCEs+IZ2FWeH/ONe0nt4vke0GlT0ehDz37xVx1a0ZJGNGwuBWipD6wNcPuODYddtyavD5THd5vpEC2RSCjYuZ0cvpWOSIgmro8GkM4peqXZpFde58OqluP/MknjCX7mQEgENhQgChCI6JjVsdMms3UW9L6pI8tzxusyWldc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PO/yfO5T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DBBEC4CEE3;
	Thu, 24 Apr 2025 16:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745512715;
	bh=ll3w0lsvdmkLiHxkvigNPmcFMMcoAwsNuGmp6cF0rqE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PO/yfO5THZdfQfda3SHuXS0ZdVgxtt/bjZX4S8DnIJcQCXhPvWue87eTTqdKkg01c
	 3uupJdM4joHOaqmR73OT0m5Q5qLkIWqGwXOdpJ1RiHUc4miQztO8feKw1BQKjIc1Qn
	 ex9fq59g2X/P1uHIPCNeW5dRSzaGXjYQpz+BAF2+nXhu4pfjWRwq8lupS74VkrvvCi
	 Sy4Yb5mkpm1cn6rgusmSz9t6D75jB0JTdfcJ0ejhFylK3ydsmm0/3Vs8s72VMyWgAO
	 U1KxWYwbMrMwA2fuOXLDxHOYI7UFRnq5/hBTxdq4DqwR0PusqDcpV11c1wq8p3zhzq
	 6FO43os8N7PvQ==
Date: Thu, 24 Apr 2025 17:38:30 +0100
From: Lee Jones <lee@kernel.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: nuno.sa@analog.com, linux-gpio@vger.kernel.org,
	linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-input@vger.kernel.org, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Liu Ying <victor.liu@nxp.com>
Subject: Re: [PATCH v2 06/17] mfd: adp5585: add support for adp5589
Message-ID: <20250424163830.GO8734@google.com>
References: <20250415-dev-adp5589-fw-v2-0-3a799c3ed812@analog.com>
 <20250415-dev-adp5589-fw-v2-6-3a799c3ed812@analog.com>
 <20250424161838.GM8734@google.com>
 <20250424163024.GL18085@pendragon.ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250424163024.GL18085@pendragon.ideasonboard.com>

On Thu, 24 Apr 2025, Laurent Pinchart wrote:

> On Thu, Apr 24, 2025 at 05:18:38PM +0100, Lee Jones wrote:
> > On Tue, 15 Apr 2025, Nuno Sá via B4 Relay wrote:
> > 
> > > From: Nuno Sá <nuno.sa@analog.com>
> > > 
> > > The ADP5589 is a 19 I/O port expander with built-in keypad matrix decoder,
> > > programmable logic, reset generator, and PWM generator.
> > > 
> > > This patch adds the foundation to add support for the adp5589 gpio and pwm
> > > drivers. Most importantly, we need to differentiate between some
> > > registers addresses. It also hints to future keymap support.
> > > 
> > > Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> > > ---
> > >  drivers/mfd/adp5585.c       | 223 +++++++++++++++++++++++++++++++++++++++++---
> > >  include/linux/mfd/adp5585.h |  57 ++++++++++-
> > >  2 files changed, 268 insertions(+), 12 deletions(-)
> > 
> > [...]
> > 
> > > + * Bank 0 covers pins "GPIO 1/R0" to "GPIO 8/R7", numbered 0 to 7 by the
> > > + * driver, bank 1 covers pins "GPIO 9/C0" to "GPIO 16/C7", numbered 8 to
> > > + * 15 and bank 3 covers pins "GPIO 17/C8" to "GPIO 19/C10", numbered 16 to 18.
> > > + */
> > > +#define ADP5589_BANK(n)			((n) >> 3)
> > > +#define ADP5589_BIT(n)			BIT((n) & 0x7)
> > > +
> > > +struct adp5585_regs {
> > > +	unsigned int debounce_dis_a;
> > > +	unsigned int rpull_cfg_a;
> > > +	unsigned int gpo_data_a;
> > > +	unsigned int gpo_out_a;
> > > +	unsigned int gpio_dir_a;
> > > +	unsigned int gpi_stat_a;
> > > +	unsigned int pwm_cfg;
> > > +	unsigned int pwm_offt_low;
> > > +	unsigned int pwm_ont_low;
> > > +	unsigned int gen_cfg;
> > > +	unsigned int ext_cfg;
> > > +};
> > > +
> > > +struct adp5585_info {
> > > +	const struct mfd_cell *adp5585_devs;
> > 
> > Okay, we are never doing this.  Either use OF for platform registration
> > or use MFD (or ACPI or PCI), but please do not pass MFD data through OF.
> 
> When I upstreamed the initial driver, I modelled the different functions
> through child nodes in DT, with a compatible string for each child. I
> was told very strongly to remove that. We have therefore no other choice
> than constructing the name of the cells based on the model of the main
> device.

It's okay to add this information statically in this driver.  It's not
okay to then pass it through the OF API.  You can pass an identifier
through the .data attribute to match on, but we are not passing MFD cell
data through like this.

> > > +	const struct regmap_config *regmap_config;
> > > +	const struct adp5585_regs *regs;
> > > +	unsigned int n_devs;
> > > +	unsigned int id;
> > 
> > What ID is this?  We already have platform IDs and MFD cell IDs.
> 
> That's the value of the hardware model ID read-only register, it is used
> as a safety check to verify that the connected device corresponds to the
> compatible string.

I suggest changing the nomenclature to be more forthcoming.

'model', 'version', 'hwid', 'chipid', etc.

Why is it being stored?  Is it used to match on at a later date?

-- 
Lee Jones [李琼斯]

