Return-Path: <linux-pwm+bounces-5299-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D46C2A7464E
	for <lists+linux-pwm@lfdr.de>; Fri, 28 Mar 2025 10:23:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D65B13BDB3F
	for <lists+linux-pwm@lfdr.de>; Fri, 28 Mar 2025 09:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E71D213E9C;
	Fri, 28 Mar 2025 09:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l0eUeWyp"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52AC20E003;
	Fri, 28 Mar 2025 09:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743153801; cv=none; b=g3yskJ4U1W/bD9OtXUy9pxhv7AWdQmqPTsP55ntntV7a5hjy52rRrLJy3mAiGQdDl8BVNxcnx1VHwCsBicrb/OyQu41zt6y5gS06xcDgI79maSi8g84xN6soQCtBE4fvEhr+FLsBumVss8aHD/m+OQe0yaQYZs/bP/8sWVUuFEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743153801; c=relaxed/simple;
	bh=QZkdGMqYSeofD4QkFEFcC2WLZK8qw7M5AVsVnjP/Va4=;
	h=Content-Type:Date:Message-Id:Subject:Cc:From:To:References:
	 In-Reply-To; b=a72YevJufLSU97NvbdINFdlpFPA7yXKNCSjicKT7mkafDKXLDNBxF7OgHr+/WD9qXr37T4np8y5fiurWgSLzaBwxrCQiIcrRNeqDF1Xb7d2ZaDFp/pJ92mgIGgfdlYBFPDrHWL05wInFvwTD6jJMD/S+/TPCayO1Yd3NddzPnLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l0eUeWyp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA0ACC4CEE4;
	Fri, 28 Mar 2025 09:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743153798;
	bh=QZkdGMqYSeofD4QkFEFcC2WLZK8qw7M5AVsVnjP/Va4=;
	h=Date:Subject:Cc:From:To:References:In-Reply-To:From;
	b=l0eUeWypphwWBqdLB+n30N1Zqu/dkhLFSj4ZZ3RqQIFRDHTks2Ka8nUyfVUH4ObjB
	 2SIcO208qB+psmgrkBPMNYxPDESLTjqzHlwy4DzGuvPdH2tStJJKDNGfF+GY9vKpO3
	 E/ipFaLEH9xj0Gfe0fAmn6arY4z4ygFcrqTEuMpLZbKdlrykK+5C/qUqfAoqGTo17k
	 M6PKkGskM4BFAZGELiKJXuXl9OYiR3SME0zLUASWMqotX0nhpwb6YA6vBP8FhttXSW
	 pkCdD+g6O2rgFq6NcA2vwhYoHcumMCSkpeqUKgBGWNKAh+pmugc0q9EDzzZ5DNiOJz
	 5TwdrfbPuFdzQ==
Content-Type: multipart/signed;
 boundary=1e29379ea3eb5baf229b0e769d5ff67e0454bea00ddd123a52e73aaabf27;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Fri, 28 Mar 2025 10:23:14 +0100
Message-Id: <D8RSG5W6EBLG.2JU3UDS8X8IDY@kernel.org>
Subject: Re: [PATCH v5 06/11] gpio: regmap: Allow to allocate regmap-irq
 device
Cc: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-gpio@vger.kernel.org>, <linux-input@vger.kernel.org>,
 <linux-pwm@vger.kernel.org>, <andriy.shevchenko@intel.com>,
 =?utf-8?q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>, "Thomas
 Petazzoni" <thomas.petazzoni@bootlin.com>
From: "Michael Walle" <mwalle@kernel.org>
To: "Mathieu Dubois-Briand" <mathieu.dubois-briand@bootlin.com>, "Lee Jones"
 <lee@kernel.org>, "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski"
 <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, "Kamel Bouhara"
 <kamel.bouhara@bootlin.com>, "Linus Walleij" <linus.walleij@linaro.org>,
 "Bartosz Golaszewski" <brgl@bgdev.pl>, "Dmitry Torokhov"
 <dmitry.torokhov@gmail.com>, =?utf-8?q?Uwe_Kleine-K=C3=B6nig?=
 <ukleinek@kernel.org>, "Mark Brown" <broonie@kernel.org>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Danilo Krummrich" <dakr@kernel.org>
X-Mailer: aerc 0.16.0
References: <20250318-mdb-max7360-support-v5-0-fb20baf97da0@bootlin.com>
 <20250318-mdb-max7360-support-v5-6-fb20baf97da0@bootlin.com>
 <D8K23TCWC5TO.3T1YPKL3G0OY5@kernel.org>
 <D8KYF2DZOBT4.1337YU51E0ZKH@bootlin.com>
 <D8P6L65D69PS.1VQKHJJA8TNL4@kernel.org>
 <D8Q59RC90U0H.SCFK1LVIKPGN@bootlin.com>
In-Reply-To: <D8Q59RC90U0H.SCFK1LVIKPGN@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>

--1e29379ea3eb5baf229b0e769d5ff67e0454bea00ddd123a52e73aaabf27
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Wed Mar 26, 2025 at 12:00 PM CET, Mathieu Dubois-Briand wrote:
> On Tue Mar 25, 2025 at 8:50 AM CET, Michael Walle wrote:
> > > > > +#ifdef CONFIG_GPIOLIB_IRQCHIP
> > > >
> > > > Why do we need this ifdef?
> > > >
> > >
> > > Hum yes, on second thought we probably need to depend on
> > > CONFIG_REGMAP_IRQ here.
> >
> > But then, you'd also require the regmap_irq support for chips that
> > don't support IRQs at all. devm_regmap_add_irq_fwnode() seems to be
> > missing a stub version.
> >
>
> Sorry, maybe my previous message was not clear, when I said "depend",
> what I meant is having an "#ifdef CONFIG_REGMAP_IRQ" here in place of
> "#ifdef CONFIG_GPIOLIB_IRQCHIP"
>
> If CONFIG_REGMAP_IRQ is enabled, drivers/base/regmap/regmap-irq.c is
> built, so we do have both devm_regmap_add_irq_chip_fwnode() and
> regmap_irq_get_domain(). So this code block should compile and link
> correctly.

Yes.

> I did some build tests with and without CONFIG_GPIOLIB_IRQCHIP and I
> believe this is fine.
>
> Or am I missing something?

I'd like to avoid the ifdef macros if possible. Thus you'd need
stubs for devm_regmap_add_irq_chip_fwnode() and
regmap_irq_get_domain() if CONFIG_REGMAP_IRQ is not defined.

Not sure if broonie agrees though (?).

-michael

--1e29379ea3eb5baf229b0e769d5ff67e0454bea00ddd123a52e73aaabf27
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCZ+ZqghIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/heGQF7BeTdmhRXVFQ5Z4GZ3zaTwdoUiPIpKiEq
HyJmjsr7sZq+jERRAijg+dS9tGmCMAUyAXwNlu/mxFtlV62wOCXhcU1NeoLXv+7Y
95EnF3cGtA51xh3LDWdd5OT5CkdkYlZ6cpI=
=Q1Lp
-----END PGP SIGNATURE-----

--1e29379ea3eb5baf229b0e769d5ff67e0454bea00ddd123a52e73aaabf27--

