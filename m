Return-Path: <linux-pwm+bounces-6214-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD1BEACAEBB
	for <lists+linux-pwm@lfdr.de>; Mon,  2 Jun 2025 15:14:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85DBD3A3402
	for <lists+linux-pwm@lfdr.de>; Mon,  2 Jun 2025 13:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B48D21C176;
	Mon,  2 Jun 2025 13:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="Zltz4DYE"
X-Original-To: linux-pwm@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA2520371E;
	Mon,  2 Jun 2025 13:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748870080; cv=none; b=CVcE4UQHaO9ek9E3mKIaJ5Y3c5NXIE0N/Uqvaek3dhw1g+gyqslDBZpIYbgYaLlU4yKX9BwdVWSk0Cifx4cdYVgDV+Wbx/BfDYZaisdHtZM/RKkB8yAgtLEryvVF+rcA6T2e68RcJOsXKAePwDrOFUiZz4O1Yk5f20iVR8yZp0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748870080; c=relaxed/simple;
	bh=TTwL/BKTMRfWSpnqfREP0hMXmoloFSrx+yYMDC7F1Z4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q/hcrdVD27zfBU/7OgkT/8d869GVkDrf7BPJMr7QVhwNUUrpLu7DUow8w3dTl2nIcpOETa3b17lsbKSYQfXfu7mVmi603ltDYjQblQrQsdLtMVwrNDBv+vXN3mEU+LdPPB5RdeNEamAbU6zVlmrBDPV2T9ar2FPdpP+ljW5AM34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=Zltz4DYE; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=Th1bsXYbOdZNBdF4HpkqWzJZdFEbTYJpHy2+yVwfjLk=; b=Zltz4DYEAJKKQbIDz9XRJRi/AJ
	59wjiN/h8OXZGaXQGB0452s2iFnI1zU+IPY1w8k5EKp4u81L8YgToJme/4Y7pK4jA7yez7TWCegkN
	OQGc6sZvsIGtymAkACMrMnE+3y/Vp/fxEgFVrLGadY4xXOxOmQoQjzfqn8Jw08rbA0Dys9bFKdTiw
	G2mLBp2M1MzNsCfMVOOIWHQmWJHz3hU0XprPlfMM2WzxPYznBwsqZaI8KwuAnwKZ6jyx/ju6Onc+R
	+P9cVvuKJ90OZhDAIq7vBruure411VR6UT/1AJtSwfuDuniO2L7l0hC3GCGZge3bprxpiH4EYriKg
	Pip1Md9A==;
Received: from i53875a2b.versanet.de ([83.135.90.43] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1uM4zc-00038Y-5g; Mon, 02 Jun 2025 15:14:20 +0200
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <ukleinek@kernel.org>,
 William Breathitt Gray <wbg@kernel.org>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
 linux-iio@vger.kernel.org, kernel@collabora.com,
 Jonas Karlman <jonas@kwiboo.se>,
 Detlev Casanova <detlev.casanova@collabora.com>
Subject: Re: [PATCH 4/7] soc: rockchip: add mfpwm driver
Date: Mon, 02 Jun 2025 15:14:19 +0200
Message-ID: <1970051.6tgchFWduM@diego>
In-Reply-To: <13790724.uLZWGnKmhe@workhorse>
References:
 <20250408-rk3576-pwm-v1-0-a49286c2ca8e@collabora.com>
 <2188729.OBFZWjSADL@diego> <13790724.uLZWGnKmhe@workhorse>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Am Montag, 2. Juni 2025, 14:15:45 Mitteleurop=C3=A4ische Sommerzeit schrieb=
 Nicolas Frattaroli:
> On Saturday, 31 May 2025 23:48:29 Central European Summer Time Heiko St=
=C3=BCbner wrote:
> > Am Dienstag, 8. April 2025, 14:32:16 Mitteleurop=C3=A4ische Sommerzeit =
schrieb Nicolas Frattaroli:

> > On a more general note, what is the differentiation to an MFD here?
> >=20
> > Like you can already bind dt-nodes to MFD subdevices, and can implement
> > the exclusivity API thing on top of a general mfd device, to make sure =
only
> > one mfd-cell gets activated at one time.
> >=20
> > Other than that, this looks like it reimplements MFDs?
>=20
> What initially made me not make this an MFD was Uwe Kleine-K=C3=B6nig exp=
ressing
> some doubts, which lead me to alternatives like the auxiliary bus. Readin=
g the
> auxiliary bus docs I found:
>=20
>   A key requirement for utilizing the auxiliary bus is that there is no
>   dependency on a physical bus, device, register accesses or regmap suppo=
rt.
>   These individual devices split from the core cannot live on the platform
>   bus as they are not physical devices that are controlled by DT/ACPI. The
>   same argument applies for not using MFD in this scenario as MFD relies =
on
>   individual function devices being physical devices.

Interestingly the 5 year old LWN article seems to have been overtaken by
real-world usage ;-) .

I see pinctrl/pinctrl-ep93xx.c using regmaps (and thus registers), similarly
in gpu/drm/bridge/ti-sn65dsi86.c and a number more.


> Additionally, LWN[1] about the auxiliary bus, which I've read up on durin=
g my
> ill-fated journey into that version of the driver, also goes further into=
 why
> MFD is sometimes a bad fit:

[...] LWN excerpt [...]

> The individual function devices may be all pointing at the same physical
> device here, but they're not distinct parts of the device. However, there
> still *is* a physical device, which convinced me that auxiliary bus wasn't
> the right one either, and the idea for just using the platform bus came
> during a work meeting. If someone with experience on aux bus vs platform =
bus
> (what this uses) vs MFD, then feel free to chime in. Unfortunately, as is=
 the
> norm, I can't seem to find much in terms of MFD documentation. Needing to=
 know
> what type of exclusion they guarantee and what type of abstractions they =
bring
> with them that would make them more useful than my solution would need so=
me
> justification in more than just an auto-generated header listing.

I think MFD itself does not provide any exclusivity - aka allowing definiti=
ons
that combinations of sub-devices cannot be used at the same time.

But as I see it right now, you have sort of a mfd-device in there, creating
all the sub-devices and then the aquire/release logic on top making sure
only one device is ever active at the same time.

Right now I really don't see (prone to code-blindness though) why the
aquire/release logic could not live in a mfd-device.


> I am very inclined to start pretending things that aren't documented do
> not actually exist in the kernel, because it's very annoying to have to
> constantly deal with this.

Sadly the "ostrich method" won't work ;-)

So as a way forward, I'd suggest you posting your v2, so that all the
current review comments get addressed and amending the
cover-letter with the aux-bux / mfd discussion thing (ideally in a
somewhat highlighed block so that people skimming along will notice)
and include the relevant people:

=2D for aux-bux get_maintainer.pl says:
Greg Kroah-Hartman <gregkh@linuxfoundation.org> (maintainer:AUXILIARY BUS D=
RIVER)
Dave Ertman <david.m.ertman@intel.com> (reviewer:AUXILIARY BUS DRIVER)
Ira Weiny <ira.weiny@intel.com> (reviewer:AUXILIARY BUS DRIVER)
Leon Romanovsky <leon@kernel.org> (reviewer:AUXILIARY BUS DRIVER)

=2D and for MFD it's of course Lee:
Lee Jones <lee@kernel.org> (maintainer:MULTIFUNCTION DEVICES (MFD))


Heiko


> [1]: https://lwn.net/Articles/840416/





