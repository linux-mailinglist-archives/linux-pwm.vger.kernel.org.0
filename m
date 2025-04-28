Return-Path: <linux-pwm+bounces-5735-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EFABA9EC79
	for <lists+linux-pwm@lfdr.de>; Mon, 28 Apr 2025 11:36:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97891160E1F
	for <lists+linux-pwm@lfdr.de>; Mon, 28 Apr 2025 09:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2511925F965;
	Mon, 28 Apr 2025 09:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ASuTi8rC"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED35525F7AC;
	Mon, 28 Apr 2025 09:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745832295; cv=none; b=rpRAjaaALoYPL6z+mv7IgK0hrRD8I0VmAOv87U3HLowi/EQTQFkss1H//D3YXFAmthHMQHz0wUN4oqLP4AHQuGxI4bspM/WIYtgyAWFgjZM9d/nZqkbepJwJvk0TtDKJNy+SrpuSH3twfyd10IlwhxTEUISoC9T370FLAskXtLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745832295; c=relaxed/simple;
	bh=qmgsWZ1GzK/GW9iAVIPST1c4WvqsdQXVgtOkR4qxxcs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AAso8f9esJFYn5c48i714+FpSMA4UCLNa8WIlV87e4hCqi0J0+j6tlxREc0tSo1BuvEUKExD3I87SIft3hNEIiti5wVpY1d0HMhg4zBUvR1/CpuDQkq6viLDauteXy+Lh7WqAEf43v0i0yONnIUtusxYc7G6BxJPArpiVAb6QCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ASuTi8rC; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-39c14016868so4415405f8f.1;
        Mon, 28 Apr 2025 02:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745832291; x=1746437091; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uCYc+AFuWp5xglFO7B+MSyNGiFwZsXhhnb8DnA3v3t8=;
        b=ASuTi8rC/chaLfcdxuFGa2DyfWZW/R4kA34cmsnoVw2MSrEFWuHkNNMe05f8kqOzPk
         kX5JrSS2Ts46vjx7Wt43zoj9+T7k8S464zKkBwaFkPd/Twi8x7eAIm+RwwPSlaIxf+CI
         K92Ln1geOGP1ibO/NQRG3u/Em+RAUy5bshRyf3K9qzCbqD6MMc/UL2yBoBMTwNq2Z6dE
         SyAHPiLdX8iJEscehLMkLYt+pBzTMOtmczkRTrZOrWiX5oGdHyQ8bj2UKMLuHuvvTdLD
         /GPjiyOEizKWqvDy8p3nlc38OiclhdqzYpctflLKaIHXE7CSC1mbTqlw/ugyQXfR0gj1
         Ud3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745832291; x=1746437091;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uCYc+AFuWp5xglFO7B+MSyNGiFwZsXhhnb8DnA3v3t8=;
        b=WdEa4BgdkAaFHT+mkTDMG5hap1LFAMPmaePLC1x7LUVLb6Hv1jCUxe01dTIp7yb6xX
         P+h0yUP1q328gFjFnEuaoZRc7xRO1mqYHbDk25H5l9eXTsgV9sNtcxfS2HnEet0M4XbL
         Po0+M5/j1upBAiPoBJXaO9hG8HKo9t1EhgFm1bv5wZDiY/Gej0Qa8j8P2wlkQgVrdCcQ
         E7UiAp3eM3tbRhOMlMmHy+9fKi/noQ6GDwkSvJUwGGsMCFFuWEq13apMFLNacnaNxZfx
         6xOsswk8+w6IFh2I6CtYNPcooHPRw79CagHfA3s0B/rNydVZ/ew7O65oJh+yWzgIAzZL
         oMvA==
X-Forwarded-Encrypted: i=1; AJvYcCU/77ndEMP2U0BkneVGnF751G9sbsOESzuo2nGJm6RW6sh5jHt5GOHDfIF9bMseYqTSjOxL9bolZ3HkjQ==@vger.kernel.org, AJvYcCVyBIMQginCHpN8HncauH1BRJNgGXPkJrSYFCx1X7V2m9mjgeWvza7HGPJwc13g3hSkh/cyGGuDNsBdtK0=@vger.kernel.org, AJvYcCWBspZpX5GS7y4qEFmmyYigy6eenxfJr/YTZFVbyr06BBq812m28vHFACFh+vxOt/Uhfa9WC77RGXkt@vger.kernel.org, AJvYcCXtojbbr/yuzEjYT2+aaOeSE3pPKCORp9pmpsC/ut+K73dbD+XVzvAWUIb2XzFiupFsVqmyetivspO0@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj6orj/0aM34lGyz1J0BmgU590F+6HP8uKT7J1e6rOJMYEFFs+
	loQIfy46SeUz3WPyvJRJvz4KujE/mTrYy5jiVyKTnsUefVYY3q7D
X-Gm-Gg: ASbGncv4mZ3Mpd5+jVFc5ejUmbjp8t3cOE3j66jSmliPdPy7QH13ChP6AjpgmMBqJVu
	8deSZkiOZF7ujnpmKxBGJ8ZE1RuwzhuXN0FgLMQ9bAgmRuulchMOc3uNP2BdCeljFb+UlV+cAXN
	UhDCpAc7C92qmQgW95VyeOlTIQJFAcaAqIMlTv4voaNfm9aMkM8VMfWWJjDaJWMK8imzTTrrrkN
	x5hi8xYHY4B2gaEAkJC4CRIfSXb00+QQhU5SX76I+n22NSsPARYOQyYpbrYxphJBTBAGLFvPLeJ
	gSFWb6ETN35fD0EdRqOvduTom2mbwvn8Chct9XqJhNCbyJut7/cLLnIY4J+g4Z4PeOlJyH1jNXn
	Gb0vdDGYKGQ07Kf3a3qAcS9M=
X-Google-Smtp-Source: AGHT+IEoTYCAJIY+3XTCbuisVDxV3hvzciDnkil7hDlAUARbsa4fyppYgVPeH8gl+Zni90n0OKlQ9g==
X-Received: by 2002:a5d:4535:0:b0:39e:cbc7:ad45 with SMTP id ffacd0b85a97d-3a074fa65dbmr6603690f8f.52.1745832290970;
        Mon, 28 Apr 2025 02:24:50 -0700 (PDT)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4409d2abdf7sm149247655e9.19.2025.04.28.02.24.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 02:24:50 -0700 (PDT)
Message-ID: <4803aa6736c031a437517e2572cd8475e7ed18ee.camel@gmail.com>
Subject: Re: [PATCH v2 06/17] mfd: adp5585: add support for adp5589
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Lee Jones
	 <lee@kernel.org>
Cc: nuno.sa@analog.com, linux-gpio@vger.kernel.org,
 linux-pwm@vger.kernel.org, 	devicetree@vger.kernel.org,
 linux-input@vger.kernel.org, Rob Herring	 <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley	 <conor+dt@kernel.org>, Uwe
 =?ISO-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,  Linus Walleij
 <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, Dmitry
 Torokhov	 <dmitry.torokhov@gmail.com>, Liu Ying <victor.liu@nxp.com>
Date: Mon, 28 Apr 2025 10:24:55 +0100
In-Reply-To: <20250425091351.GO18085@pendragon.ideasonboard.com>
References: <20250415-dev-adp5589-fw-v2-0-3a799c3ed812@analog.com>
	 <20250415-dev-adp5589-fw-v2-6-3a799c3ed812@analog.com>
	 <20250424161838.GM8734@google.com>
	 <20250424163024.GL18085@pendragon.ideasonboard.com>
	 <20250424163830.GO8734@google.com>
	 <20250424193931.GM18085@pendragon.ideasonboard.com>
	 <20250425075859.GQ8734@google.com>
	 <20250425091351.GO18085@pendragon.ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-04-25 at 12:13 +0300, Laurent Pinchart wrote:
> Hi Lee,
>=20
> On Fri, Apr 25, 2025 at 08:58:59AM +0100, Lee Jones wrote:
> > On Thu, 24 Apr 2025, Laurent Pinchart wrote:
> > > On Thu, Apr 24, 2025 at 05:38:30PM +0100, Lee Jones wrote:
> > > > On Thu, 24 Apr 2025, Laurent Pinchart wrote:
> > > > > On Thu, Apr 24, 2025 at 05:18:38PM +0100, Lee Jones wrote:
> > > > > > On Tue, 15 Apr 2025, Nuno S=C3=A1 via B4 Relay wrote:
> > > > > >=20
> > > > > > > From: Nuno S=C3=A1 <nuno.sa@analog.com>
> > > > > > >=20
> > > > > > > The ADP5589 is a 19 I/O port expander with built-in keypad ma=
trix
> > > > > > > decoder,
> > > > > > > programmable logic, reset generator, and PWM generator.
> > > > > > >=20
> > > > > > > This patch adds the foundation to add support for the adp5589=
 gpio
> > > > > > > and pwm
> > > > > > > drivers. Most importantly, we need to differentiate between s=
ome
> > > > > > > registers addresses. It also hints to future keymap support.
> > > > > > >=20
> > > > > > > Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> > > > > > > ---
> > > > > > > =C2=A0drivers/mfd/adp5585.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 223
> > > > > > > +++++++++++++++++++++++++++++++++++++++++---
> > > > > > > =C2=A0include/linux/mfd/adp5585.h |=C2=A0 57 ++++++++++-
> > > > > > > =C2=A02 files changed, 268 insertions(+), 12 deletions(-)
> > > > > >=20
> > > > > > [...]
> > > > > >=20
> > > > > > > + * Bank 0 covers pins "GPIO 1/R0" to "GPIO 8/R7", numbered 0=
 to 7
> > > > > > > by the
> > > > > > > + * driver, bank 1 covers pins "GPIO 9/C0" to "GPIO 16/C7",
> > > > > > > numbered 8 to
> > > > > > > + * 15 and bank 3 covers pins "GPIO 17/C8" to "GPIO 19/C10",
> > > > > > > numbered 16 to 18.
> > > > > > > + */
> > > > > > > +#define ADP5589_BANK(n)			((n) >> 3)
> > > > > > > +#define ADP5589_BIT(n)			BIT((n) & 0x7)
> > > > > > > +
> > > > > > > +struct adp5585_regs {
> > > > > > > +	unsigned int debounce_dis_a;
> > > > > > > +	unsigned int rpull_cfg_a;
> > > > > > > +	unsigned int gpo_data_a;
> > > > > > > +	unsigned int gpo_out_a;
> > > > > > > +	unsigned int gpio_dir_a;
> > > > > > > +	unsigned int gpi_stat_a;
> > > > > > > +	unsigned int pwm_cfg;
> > > > > > > +	unsigned int pwm_offt_low;
> > > > > > > +	unsigned int pwm_ont_low;
> > > > > > > +	unsigned int gen_cfg;
> > > > > > > +	unsigned int ext_cfg;
> > > > > > > +};
> > > > > > > +
> > > > > > > +struct adp5585_info {
> > > > > > > +	const struct mfd_cell *adp5585_devs;
> > > > > >=20
> > > > > > Okay, we are never doing this.=C2=A0 Either use OF for platform
> > > > > > registration
> > > > > > or use MFD (or ACPI or PCI), but please do not pass MFD data th=
rough
> > > > > > OF.
> > > > >=20
> > > > > When I upstreamed the initial driver, I modelled the different
> > > > > functions
> > > > > through child nodes in DT, with a compatible string for each chil=
d. I
> > > > > was told very strongly to remove that. We have therefore no other
> > > > > choice
> > > > > than constructing the name of the cells based on the model of the=
 main
> > > > > device.
> > > >=20
> > > > It's okay to add this information statically in this driver.=C2=A0 =
It's not
> > > > okay to then pass it through the OF API.=C2=A0 You can pass an iden=
tifier
> > > > through the .data attribute to match on, but we are not passing MFD=
 cell
> > > > data through like this.
> > >=20
> > > Sorry, I'm not following you. What's the issue with the .data field
> > > pointing to an instance of a structure that lists properties related =
to
> > > the device model ?
> >=20
> > There isn't one.=C2=A0 By all means place any type of platform data you=
 want
> > in there.=C2=A0 Similar to the information you'd find in Device Tree or=
 the
> > old board-files type pdata.=C2=A0 You can even extract the platform dat=
a you
> > pass through the OF API and place it into MFD platform data.=C2=A0 The =
line
> > is being drawn on passing through one type of initialisation API with
> > another, MFD through OF in this case.=C2=A0 MFD cells containing device
> > registration data (including platform data!) is not itself platform
> > data.
>=20
> I'm still not following you. The issue will likely go away in the next
> version anyway, as the MFD cells registration code needs to be rewritten
> to be more dynamic.

Not sure if there's any real issue but I think Lee's main concern is passin=
g MFD
related data (struct mfd_cell) though OF (via the of table). Not sure if th=
is is
one of the things Lee does not like but in theory, like this, you can get t=
his
data from child platform devices for example.

>=20
> > > > > > > +	const struct regmap_config *regmap_config;
> > > > > > > +	const struct adp5585_regs *regs;
> > > > > > > +	unsigned int n_devs;
> > > > > > > +	unsigned int id;
> > > > > >=20
> > > > > > What ID is this?=C2=A0 We already have platform IDs and MFD cel=
l IDs.
> > > > >=20
> > > > > That's the value of the hardware model ID read-only register, it =
is
> > > > > used
> > > > > as a safety check to verify that the connected device corresponds=
 to
> > > > > the
> > > > > compatible string.
> > > >=20
> > > > I suggest changing the nomenclature to be more forthcoming.
> > > >=20
> > > > 'model', 'version', 'hwid', 'chipid', etc.
> > > >=20
> > > > Why is it being stored?=C2=A0 Is it used to match on at a later dat=
e?
> > >=20
> > > The adp5585_info structure contains static information the describe e=
ach
> > > device model. There's one global static const instance per device mod=
el,
> > > and they are referenced from device id structures (e.g. of_device_id)=
.
> > > The driver gets an info pointer corresponding to the model reported b=
y
> > > the platform firmware (e.g. DT). It reads the device ID from the devi=
ce
> > > at probe time, and compares it with the value stored in the structure=
 as
> > > a safety check to ensure there's no mismatch.
> >=20
> > I think the current implementation (as a whole, not just the IDs) needs
> > a rethink.=C2=A0 Very few attributes are changing here, both between th=
e 2
> > platforms and the several variants you're trying to support, leading to
> > masses of repetition.
> >=20
> > Looking at the static configuration here, this is starting to look like
> > 2 pieces of hardware with the only variation within each being the
> > default register values.=C2=A0 Is that a correct assumption?
>=20
> The variants of the ADP5585 differ mainly by how they handle the default
> configuration of pull-up and pull-down resistors. The consequence on the
> driver side is limited to default register values, yes.
>=20
> ADP5589 differs more significantly from the ADP5585. Differences between
> the ADP5589 variants are small as far as I understand (datasheets are
> public, should you want to have a look).
>=20
> > If so, does
> > mean all of this added complexity is just to configure a few register
> > values such that the two platforms can be used for different things?=C2=
=A0 Or
> > are these really 6 true hardware variants of one another?
>=20
> They are different physical chips with different product numbers.
>=20
> > Either way, this approach doesn't scale.=C2=A0 Instead of multiplying t=
he
> > amount of platforms / variants together and creating that number of
> > static structs, I'd suggest using templating and only adapting what
> > actually changes.
> >=20
> > For instance, the following attributes in 'struct regmap_config' never
> > change; reg_bits, val_bits, and cache_type.=C2=A0 And max_register only
> > changes between the 2 hardware platforms.=C2=A0 The reg_defaults_raw va=
lues
> > can be changed in a switch statement.
>=20
> All the fields of the adp5585_info structure that you would like to
> dynamically set would then need to be stored in the adp5585 structure.
> The would essentially trade static const data for dynamic data and more
> code. Is that a personal coding style preference, or are there clear
> advantages ?
>=20
> > Same goes for 'struct adp5585_info'.=C2=A0 Only regmap_config changes b=
etween
> > variants.=C2=A0 Everything else is exactly the same.
>=20
> I assume this comment relates only to the different variants of the info
> structure for the same model (e.g. ADP5585 or ADP5589). There are more
> differences between the ADP5585 and ADP5589 entries.
>=20
> > So, with the use of a
> > few of templates and a couple of succinct switch cases, you can control
> > all of the differentiation you need.=C2=A0 And for every variant you wi=
sh to
> > add, it's a couple of extra lines rather than many, leading to a
> > much more scaleable implementation.
>=20
> That also seems like a personal coding style preference :-) Adding a new
> compatible variant with the existing approach only requires adding an
> instance of the info structure, while your proposal would require
> changes in multiple places. It seems more work to me (from a personal
> preference point of view).
>=20
> Of course, if the new variant requires developing abstractions that
> don't exist (such as supporting large differences in the registers
> layout as needed for the ADP5589), refactoring of the code will always
> be required. This seems a bit of a theoretical concern though, as I'm
> not aware of any other chip that would require such development.
>=20
> In any case, let's see how the next version will look like, after
> reworking the MFD cells registration code. Maybe it will make everybody
> happy :-)

Let's see! There's a lot to cover for v3 :sweat_smile:.I think I got the ge=
neral
idea that Lee proposed. I'll probably try it so we can have a taste of it i=
n v3.
If needed we can then rollback (not ideal, but that's life).

- Nuno S=C3=A1


