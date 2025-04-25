Return-Path: <linux-pwm+bounces-5703-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0653CA9C03E
	for <lists+linux-pwm@lfdr.de>; Fri, 25 Apr 2025 09:59:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12D691B88523
	for <lists+linux-pwm@lfdr.de>; Fri, 25 Apr 2025 07:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68DE923315A;
	Fri, 25 Apr 2025 07:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CrrPLYLY"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362BB231A23;
	Fri, 25 Apr 2025 07:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745567945; cv=none; b=pWFDjyzZIHBycZdHEHTo0ALR7rNKAWkpbz1ylN2XRA3SlwWACtUXM+6k9aVz5IPWstrtBiKzlXto4G7SjDCBHCKztTlB5QgOeF/rwEnOrqOgTJ3prHDNA7CrSx9PGUwViTcz9A2pWNYktj0+ov0UTNee9LIip/oxxJrI1dUT3Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745567945; c=relaxed/simple;
	bh=K3sEsMJ0EA7gcajxBx214Jzm7OZ+qxsCiyntNJbobEY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rrcKa8nDFH3pQM4klsTS40i/9DE0h0NHYWzWOFLprcvUUzcqR8dHGX4dpzqyfMVXC2dZxQon96eHsU7Stnggb3CoJkw8ByGbv0wvMxIVZ0u2EuaNBo4ET7HqkQIRf2/vw41vOmu9O1FWRfntxPcNwLvpvsQ0F/T8NkP21RQHEg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CrrPLYLY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F997C4CEE4;
	Fri, 25 Apr 2025 07:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745567945;
	bh=K3sEsMJ0EA7gcajxBx214Jzm7OZ+qxsCiyntNJbobEY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CrrPLYLYKiKg2B8SlWl5gXeeY201MyBTl+9R/ba/Z3+8/00ivov+W6TqQ1tEuqfI9
	 KaqQMGNgxXUENDSabh6TrWLfjwbVrhE2M/8MvEupSl5s7D99SrLyzauzMSyQU2ly45
	 de7gCukg3deI7uzATR6pcL1NrMxA+U3Sqhzm324S6LaespwrUnk8XzSUGLJtp4iJpl
	 os8q5QeOwzrkTU2i/plge5Vv3rggxiw8VQdQ9uU7NDlqOrcDZUNbKhmXAz06gc0Fre
	 2B6xiAB3aVRlxwRuX6RcdohwJhB8u+eE44aMvSC+rcv4xCtvZNrMKVMQsx36Fhjvab
	 gFPcNRqZR8n1w==
Date: Fri, 25 Apr 2025 08:58:59 +0100
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
Message-ID: <20250425075859.GQ8734@google.com>
References: <20250415-dev-adp5589-fw-v2-0-3a799c3ed812@analog.com>
 <20250415-dev-adp5589-fw-v2-6-3a799c3ed812@analog.com>
 <20250424161838.GM8734@google.com>
 <20250424163024.GL18085@pendragon.ideasonboard.com>
 <20250424163830.GO8734@google.com>
 <20250424193931.GM18085@pendragon.ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250424193931.GM18085@pendragon.ideasonboard.com>

On Thu, 24 Apr 2025, Laurent Pinchart wrote:

> On Thu, Apr 24, 2025 at 05:38:30PM +0100, Lee Jones wrote:
> > On Thu, 24 Apr 2025, Laurent Pinchart wrote:
> > > On Thu, Apr 24, 2025 at 05:18:38PM +0100, Lee Jones wrote:
> > > > On Tue, 15 Apr 2025, Nuno Sá via B4 Relay wrote:
> > > > 
> > > > > From: Nuno Sá <nuno.sa@analog.com>
> > > > > 
> > > > > The ADP5589 is a 19 I/O port expander with built-in keypad matrix decoder,
> > > > > programmable logic, reset generator, and PWM generator.
> > > > > 
> > > > > This patch adds the foundation to add support for the adp5589 gpio and pwm
> > > > > drivers. Most importantly, we need to differentiate between some
> > > > > registers addresses. It also hints to future keymap support.
> > > > > 
> > > > > Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> > > > > ---
> > > > >  drivers/mfd/adp5585.c       | 223 +++++++++++++++++++++++++++++++++++++++++---
> > > > >  include/linux/mfd/adp5585.h |  57 ++++++++++-
> > > > >  2 files changed, 268 insertions(+), 12 deletions(-)
> > > > 
> > > > [...]
> > > > 
> > > > > + * Bank 0 covers pins "GPIO 1/R0" to "GPIO 8/R7", numbered 0 to 7 by the
> > > > > + * driver, bank 1 covers pins "GPIO 9/C0" to "GPIO 16/C7", numbered 8 to
> > > > > + * 15 and bank 3 covers pins "GPIO 17/C8" to "GPIO 19/C10", numbered 16 to 18.
> > > > > + */
> > > > > +#define ADP5589_BANK(n)			((n) >> 3)
> > > > > +#define ADP5589_BIT(n)			BIT((n) & 0x7)
> > > > > +
> > > > > +struct adp5585_regs {
> > > > > +	unsigned int debounce_dis_a;
> > > > > +	unsigned int rpull_cfg_a;
> > > > > +	unsigned int gpo_data_a;
> > > > > +	unsigned int gpo_out_a;
> > > > > +	unsigned int gpio_dir_a;
> > > > > +	unsigned int gpi_stat_a;
> > > > > +	unsigned int pwm_cfg;
> > > > > +	unsigned int pwm_offt_low;
> > > > > +	unsigned int pwm_ont_low;
> > > > > +	unsigned int gen_cfg;
> > > > > +	unsigned int ext_cfg;
> > > > > +};
> > > > > +
> > > > > +struct adp5585_info {
> > > > > +	const struct mfd_cell *adp5585_devs;
> > > > 
> > > > Okay, we are never doing this.  Either use OF for platform registration
> > > > or use MFD (or ACPI or PCI), but please do not pass MFD data through OF.
> > > 
> > > When I upstreamed the initial driver, I modelled the different functions
> > > through child nodes in DT, with a compatible string for each child. I
> > > was told very strongly to remove that. We have therefore no other choice
> > > than constructing the name of the cells based on the model of the main
> > > device.
> > 
> > It's okay to add this information statically in this driver.  It's not
> > okay to then pass it through the OF API.  You can pass an identifier
> > through the .data attribute to match on, but we are not passing MFD cell
> > data through like this.
> 
> Sorry, I'm not following you. What's the issue with the .data field
> pointing to an instance of a structure that lists properties related to
> the device model ?

There isn't one.  By all means place any type of platform data you want
in there.  Similar to the information you'd find in Device Tree or the
old board-files type pdata.  You can even extract the platform data you
pass through the OF API and place it into MFD platform data.  The line
is being drawn on passing through one type of initialisation API with
another, MFD through OF in this case.  MFD cells containing device
registration data (including platform data!) is not itself platform
data.

> > > > > +	const struct regmap_config *regmap_config;
> > > > > +	const struct adp5585_regs *regs;
> > > > > +	unsigned int n_devs;
> > > > > +	unsigned int id;
> > > > 
> > > > What ID is this?  We already have platform IDs and MFD cell IDs.
> > > 
> > > That's the value of the hardware model ID read-only register, it is used
> > > as a safety check to verify that the connected device corresponds to the
> > > compatible string.
> > 
> > I suggest changing the nomenclature to be more forthcoming.
> > 
> > 'model', 'version', 'hwid', 'chipid', etc.
> > 
> > Why is it being stored?  Is it used to match on at a later date?
> 
> The adp5585_info structure contains static information the describe each
> device model. There's one global static const instance per device model,
> and they are referenced from device id structures (e.g. of_device_id).
> The driver gets an info pointer corresponding to the model reported by
> the platform firmware (e.g. DT). It reads the device ID from the device
> at probe time, and compares it with the value stored in the structure as
> a safety check to ensure there's no mismatch.

I think the current implementation (as a whole, not just the IDs) needs
a rethink.  Very few attributes are changing here, both between the 2
platforms and the several variants you're trying to support, leading to
masses of repetition.

Looking at the static configuration here, this is starting to look like
2 pieces of hardware with the only variation within each being the
default register values.  Is that a correct assumption?  If so, does
mean all of this added complexity is just to configure a few register
values such that the two platforms can be used for different things?  Or
are these really 6 true hardware variants of one another?

Either way, this approach doesn't scale.  Instead of multiplying the
amount of platforms / variants together and creating that number of
static structs, I'd suggest using templating and only adapting what
actually changes.

For instance, the following attributes in 'struct regmap_config' never
change; reg_bits, val_bits, and cache_type.  And max_register only
changes between the 2 hardware platforms.  The reg_defaults_raw values
can be changed in a switch statement.

Same goes for 'struct adp5585_info'.  Only regmap_config changes between
variants.  Everything else is exactly the same.  So, with the use of a
few of templates and a couple of succinct switch cases, you can control
all of the differentiation you need.  And for every variant you wish to
add, it's a couple of extra lines rather than many, leading to a
much more scaleable implementation.

-- 
Lee Jones [李琼斯]

