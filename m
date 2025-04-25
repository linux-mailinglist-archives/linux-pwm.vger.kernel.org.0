Return-Path: <linux-pwm+bounces-5704-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70999A9C312
	for <lists+linux-pwm@lfdr.de>; Fri, 25 Apr 2025 11:15:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CB6D16CD62
	for <lists+linux-pwm@lfdr.de>; Fri, 25 Apr 2025 09:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31AE921D5B7;
	Fri, 25 Apr 2025 09:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="wevCCglA"
X-Original-To: linux-pwm@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100AE2153C7;
	Fri, 25 Apr 2025 09:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745572438; cv=none; b=WDxI2UAaMmydp6CTT0zsnx0LwL52c5BPWo3D8pO0hAtVzyD+gPrRfnH0+rjjbFz3TUCr+7waUYabLMgdUwaGrMopa0izt6/VdlsJvIZBp6DW0FUQpoKrpolzFaiT1IfnjIOqLCKfY611f8+9O8q6WEG6h+W09C3VEKdRUBP6fvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745572438; c=relaxed/simple;
	bh=IgeJAqgcuSThMaHuwjtA6Dk/yX8c+T7sRRiWPhVcyyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eliDSkkF/bcTfARnx2S1pHH3VoQSbSjC9LyorrBQ4U7G89LWQql4n2/yhOJnrCmpNc1qf0qfBRVW92FZ+4ZP2/iGi1vk3nPX1HNU/piiPoYS3bsQ0QIK/ulQkUnJcNZi3g7u7cfI8Sj5EB2bppmffNani6G8NRlKr28nZ8QeYZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=wevCCglA; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 89B8A605;
	Fri, 25 Apr 2025 11:13:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1745572431;
	bh=IgeJAqgcuSThMaHuwjtA6Dk/yX8c+T7sRRiWPhVcyyY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wevCCglAXOWamnksvZss+XzkcbTkx5gmYogDNssAasbtJ06q1Y8FMT3wfyDmWX7Ru
	 R9zJqW+o7ZMR+F0kAC5KKyllweI4B0Dbji4MdvS5Wr/DGhQ0MHj8OpCH1sVyg+UT+E
	 0fUcFPcSeOP/rSOc0BmERy65ERM8Fc2P7ajI5BF8=
Date: Fri, 25 Apr 2025 12:13:51 +0300
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
Message-ID: <20250425091351.GO18085@pendragon.ideasonboard.com>
References: <20250415-dev-adp5589-fw-v2-0-3a799c3ed812@analog.com>
 <20250415-dev-adp5589-fw-v2-6-3a799c3ed812@analog.com>
 <20250424161838.GM8734@google.com>
 <20250424163024.GL18085@pendragon.ideasonboard.com>
 <20250424163830.GO8734@google.com>
 <20250424193931.GM18085@pendragon.ideasonboard.com>
 <20250425075859.GQ8734@google.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250425075859.GQ8734@google.com>

Hi Lee,

On Fri, Apr 25, 2025 at 08:58:59AM +0100, Lee Jones wrote:
> On Thu, 24 Apr 2025, Laurent Pinchart wrote:
> > On Thu, Apr 24, 2025 at 05:38:30PM +0100, Lee Jones wrote:
> > > On Thu, 24 Apr 2025, Laurent Pinchart wrote:
> > > > On Thu, Apr 24, 2025 at 05:18:38PM +0100, Lee Jones wrote:
> > > > > On Tue, 15 Apr 2025, Nuno Sá via B4 Relay wrote:
> > > > > 
> > > > > > From: Nuno Sá <nuno.sa@analog.com>
> > > > > > 
> > > > > > The ADP5589 is a 19 I/O port expander with built-in keypad matrix decoder,
> > > > > > programmable logic, reset generator, and PWM generator.
> > > > > > 
> > > > > > This patch adds the foundation to add support for the adp5589 gpio and pwm
> > > > > > drivers. Most importantly, we need to differentiate between some
> > > > > > registers addresses. It also hints to future keymap support.
> > > > > > 
> > > > > > Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> > > > > > ---
> > > > > >  drivers/mfd/adp5585.c       | 223 +++++++++++++++++++++++++++++++++++++++++---
> > > > > >  include/linux/mfd/adp5585.h |  57 ++++++++++-
> > > > > >  2 files changed, 268 insertions(+), 12 deletions(-)
> > > > > 
> > > > > [...]
> > > > > 
> > > > > > + * Bank 0 covers pins "GPIO 1/R0" to "GPIO 8/R7", numbered 0 to 7 by the
> > > > > > + * driver, bank 1 covers pins "GPIO 9/C0" to "GPIO 16/C7", numbered 8 to
> > > > > > + * 15 and bank 3 covers pins "GPIO 17/C8" to "GPIO 19/C10", numbered 16 to 18.
> > > > > > + */
> > > > > > +#define ADP5589_BANK(n)			((n) >> 3)
> > > > > > +#define ADP5589_BIT(n)			BIT((n) & 0x7)
> > > > > > +
> > > > > > +struct adp5585_regs {
> > > > > > +	unsigned int debounce_dis_a;
> > > > > > +	unsigned int rpull_cfg_a;
> > > > > > +	unsigned int gpo_data_a;
> > > > > > +	unsigned int gpo_out_a;
> > > > > > +	unsigned int gpio_dir_a;
> > > > > > +	unsigned int gpi_stat_a;
> > > > > > +	unsigned int pwm_cfg;
> > > > > > +	unsigned int pwm_offt_low;
> > > > > > +	unsigned int pwm_ont_low;
> > > > > > +	unsigned int gen_cfg;
> > > > > > +	unsigned int ext_cfg;
> > > > > > +};
> > > > > > +
> > > > > > +struct adp5585_info {
> > > > > > +	const struct mfd_cell *adp5585_devs;
> > > > > 
> > > > > Okay, we are never doing this.  Either use OF for platform registration
> > > > > or use MFD (or ACPI or PCI), but please do not pass MFD data through OF.
> > > > 
> > > > When I upstreamed the initial driver, I modelled the different functions
> > > > through child nodes in DT, with a compatible string for each child. I
> > > > was told very strongly to remove that. We have therefore no other choice
> > > > than constructing the name of the cells based on the model of the main
> > > > device.
> > > 
> > > It's okay to add this information statically in this driver.  It's not
> > > okay to then pass it through the OF API.  You can pass an identifier
> > > through the .data attribute to match on, but we are not passing MFD cell
> > > data through like this.
> > 
> > Sorry, I'm not following you. What's the issue with the .data field
> > pointing to an instance of a structure that lists properties related to
> > the device model ?
> 
> There isn't one.  By all means place any type of platform data you want
> in there.  Similar to the information you'd find in Device Tree or the
> old board-files type pdata.  You can even extract the platform data you
> pass through the OF API and place it into MFD platform data.  The line
> is being drawn on passing through one type of initialisation API with
> another, MFD through OF in this case.  MFD cells containing device
> registration data (including platform data!) is not itself platform
> data.

I'm still not following you. The issue will likely go away in the next
version anyway, as the MFD cells registration code needs to be rewritten
to be more dynamic.

> > > > > > +	const struct regmap_config *regmap_config;
> > > > > > +	const struct adp5585_regs *regs;
> > > > > > +	unsigned int n_devs;
> > > > > > +	unsigned int id;
> > > > > 
> > > > > What ID is this?  We already have platform IDs and MFD cell IDs.
> > > > 
> > > > That's the value of the hardware model ID read-only register, it is used
> > > > as a safety check to verify that the connected device corresponds to the
> > > > compatible string.
> > > 
> > > I suggest changing the nomenclature to be more forthcoming.
> > > 
> > > 'model', 'version', 'hwid', 'chipid', etc.
> > > 
> > > Why is it being stored?  Is it used to match on at a later date?
> > 
> > The adp5585_info structure contains static information the describe each
> > device model. There's one global static const instance per device model,
> > and they are referenced from device id structures (e.g. of_device_id).
> > The driver gets an info pointer corresponding to the model reported by
> > the platform firmware (e.g. DT). It reads the device ID from the device
> > at probe time, and compares it with the value stored in the structure as
> > a safety check to ensure there's no mismatch.
> 
> I think the current implementation (as a whole, not just the IDs) needs
> a rethink.  Very few attributes are changing here, both between the 2
> platforms and the several variants you're trying to support, leading to
> masses of repetition.
> 
> Looking at the static configuration here, this is starting to look like
> 2 pieces of hardware with the only variation within each being the
> default register values.  Is that a correct assumption?

The variants of the ADP5585 differ mainly by how they handle the default
configuration of pull-up and pull-down resistors. The consequence on the
driver side is limited to default register values, yes.

ADP5589 differs more significantly from the ADP5585. Differences between
the ADP5589 variants are small as far as I understand (datasheets are
public, should you want to have a look).

> If so, does
> mean all of this added complexity is just to configure a few register
> values such that the two platforms can be used for different things?  Or
> are these really 6 true hardware variants of one another?

They are different physical chips with different product numbers.

> Either way, this approach doesn't scale.  Instead of multiplying the
> amount of platforms / variants together and creating that number of
> static structs, I'd suggest using templating and only adapting what
> actually changes.
> 
> For instance, the following attributes in 'struct regmap_config' never
> change; reg_bits, val_bits, and cache_type.  And max_register only
> changes between the 2 hardware platforms.  The reg_defaults_raw values
> can be changed in a switch statement.

All the fields of the adp5585_info structure that you would like to
dynamically set would then need to be stored in the adp5585 structure.
The would essentially trade static const data for dynamic data and more
code. Is that a personal coding style preference, or are there clear
advantages ?

> Same goes for 'struct adp5585_info'.  Only regmap_config changes between
> variants.  Everything else is exactly the same.

I assume this comment relates only to the different variants of the info
structure for the same model (e.g. ADP5585 or ADP5589). There are more
differences between the ADP5585 and ADP5589 entries.

> So, with the use of a
> few of templates and a couple of succinct switch cases, you can control
> all of the differentiation you need.  And for every variant you wish to
> add, it's a couple of extra lines rather than many, leading to a
> much more scaleable implementation.

That also seems like a personal coding style preference :-) Adding a new
compatible variant with the existing approach only requires adding an
instance of the info structure, while your proposal would require
changes in multiple places. It seems more work to me (from a personal
preference point of view).

Of course, if the new variant requires developing abstractions that
don't exist (such as supporting large differences in the registers
layout as needed for the ADP5589), refactoring of the code will always
be required. This seems a bit of a theoretical concern though, as I'm
not aware of any other chip that would require such development.

In any case, let's see how the next version will look like, after
reworking the MFD cells registration code. Maybe it will make everybody
happy :-)

-- 
Regards,

Laurent Pinchart

