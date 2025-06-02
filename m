Return-Path: <linux-pwm+bounces-6213-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8EEFACADDC
	for <lists+linux-pwm@lfdr.de>; Mon,  2 Jun 2025 14:16:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 930523A5D0E
	for <lists+linux-pwm@lfdr.de>; Mon,  2 Jun 2025 12:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24BDF1E376E;
	Mon,  2 Jun 2025 12:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="O39AVe9T"
X-Original-To: linux-pwm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6D41C32;
	Mon,  2 Jun 2025 12:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748866606; cv=pass; b=cawz5ZaqLiV3hQsupi75B6LkYYztETAUrApPSH8dUr6bKAzfbpZ02uwwz+i4Bq2VkRPRrOWHbdG5CKd+Ff/1NLI06Uvpch2D7PBJloHymiI1gd3/ChyOesGjZrxqSIHvuTQ+hTlQhCdFB8KdQW9bg+JCxkxTOemn/NJYsxTjfeY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748866606; c=relaxed/simple;
	bh=spiz+6jbQPJUaIKTN+CGRiXzusNZXCuqtp/xZHVjtfE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A7eNMzINlrvwtLrxSX9k4+IY8kyzJEYUEq1S8/FCFNs7zlnpC5oo3noYz4jpe9k3LvpyU/oYjFuU9uu5xck7SK936ZMjZpGxtxBuL2bVAw7dJ6V9CNX481tNYnlUNoBxHFZ1yMR4S3PF1AMfnX4zKMu5Td6mKNCIHIvrkE76Ous=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=O39AVe9T; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1748866555; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Vze/kjONo0AB70e1wZ0QkC2ynBo7Zq0uf545gqPwLvISGOTvuXAzUA+ZQUkgT/yabPY4SAI2wwfEWd++Pw3ju8eduO8POg4kuAyjrjtBUPFe1VIXQ8CPEs6/uW48a5pNQRRtUDuzPd49Pq89mcCcI+He1MfMlB0Ae4mruy/63t4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1748866555; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=+Aed1G3zEdiAE6/euJzRcaSWP5Y0mYDbnxPBMhKta6o=; 
	b=Iw8ItoI0JX6aQ7esTRNbGbiSqiY+ajT7E3BJrKp1tp4mWqzgrycY7i4VNskyjzLnX6K4u6E59RojQDqqL8WpN3cLmJNGRiLl1gHrZnTGn6eQP0ldwqgtMogpDTDMFSXhgOH1r9GUfwXsAAstygtb/1rooxcO3R0AsBzW1FynCsM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1748866555;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=+Aed1G3zEdiAE6/euJzRcaSWP5Y0mYDbnxPBMhKta6o=;
	b=O39AVe9TKwe84UGQR/XEuzyNvSLxFaej5EFC98AH5IcrJ9mhLCJkAz3qaYrbCR9o
	Noy0MVDMzoyJCuqqYeai7k8gxbeP26nKRLSelY36aQlr373aHsEfUJelARxQdb4wGdR
	nqdhZxkeKZF7d+Wr9EUcC0NT9lkWqv/EleeL9MEE=
Received: by mx.zohomail.com with SMTPS id 1748866552562746.0707424997689;
	Mon, 2 Jun 2025 05:15:52 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
To: Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <ukleinek@kernel.org>,
 William Breathitt Gray <wbg@kernel.org>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
Cc: linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
 linux-iio@vger.kernel.org, kernel@collabora.com,
 Jonas Karlman <jonas@kwiboo.se>,
 Detlev Casanova <detlev.casanova@collabora.com>
Subject: Re: [PATCH 4/7] soc: rockchip: add mfpwm driver
Date: Mon, 02 Jun 2025 14:15:45 +0200
Message-ID: <13790724.uLZWGnKmhe@workhorse>
In-Reply-To: <2188729.OBFZWjSADL@diego>
References:
 <20250408-rk3576-pwm-v1-0-a49286c2ca8e@collabora.com>
 <20250408-rk3576-pwm-v1-4-a49286c2ca8e@collabora.com>
 <2188729.OBFZWjSADL@diego>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Saturday, 31 May 2025 23:48:29 Central European Summer Time Heiko St=C3=
=BCbner wrote:
> Am Dienstag, 8. April 2025, 14:32:16 Mitteleurop=C3=A4ische Sommerzeit sc=
hrieb Nicolas Frattaroli:
> > With the Rockchip RK3576, the PWM IP used by Rockchip has changed
> > substantially. Looking at both the downstream pwm-rockchip driver as
> > well as the mainline pwm-rockchip driver made it clear that with all its
> > additional features and its differences from previous IP revisions, it
> > is best supported in a new driver.
> >=20
> > This brings us to the question as to what such a new driver should be.
> > To me, it soon became clear that it should actually be several new
> > drivers, most prominently when Uwe Kleine-K=C3=B6nig let me know that I
> > should not implement the pwm subsystem's capture callback, but instead
> > write a counter driver for this functionality.
> >=20
> > Combined with the other as-of-yet unimplemented functionality of this
> > new IP, it became apparent that it needs to be spread across several
> > subsystems.
> >=20
> > For this reason, we add a new platform bus based driver, called mfpwm
> > (short for "Multi-function PWM"). This "parent" driver makes sure that
> > only one device function driver is using the device at a time, and is in
> > charge of registering the platform bus devices for the individual device
> > functions offered by the device.
> >=20
> > An acquire/release pattern is used to guarantee that device function
> > drivers don't step on each other's toes.
> >=20
> > Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
>=20
> actually trying to compile this, led me to
>=20
> aarch64-linux-gnu-ld: drivers/soc/rockchip/mfpwm.o: in function `mfpwm_re=
g_read':
> /home/devel/hstuebner/00_git-repos/linux-rockchip/_build-arm64/../include=
/soc/rockchip/mfpwm.h:423: multiple definition of `mfpwm_reg_read'; drivers=
/pwm/pwm-rockchip-v4.o:/home/devel/hstuebner/00_git-repos/linux-rockchip/_b=
uild-arm64/../include/soc/rockchip/mfpwm.h:423: first defined here
> aarch64-linux-gnu-ld: drivers/soc/rockchip/mfpwm.o: in function `mfpwm_re=
g_write':
> /home/devel/hstuebner/00_git-repos/linux-rockchip/_build-arm64/../include=
/soc/rockchip/mfpwm.h:428: multiple definition of `mfpwm_reg_write'; driver=
s/pwm/pwm-rockchip-v4.o:/home/devel/hstuebner/00_git-repos/linux-rockchip/_=
build-arm64/../include/soc/rockchip/mfpwm.h:428: first defined here
> make[3]: *** [../scripts/Makefile.vmlinux_o:72: vmlinux.o] Fehler 1
>=20
>=20
> during the linking stage - with the driver as builtin
>=20
>=20
> > +inline u32 mfpwm_reg_read(void __iomem *base, u32 reg)
> > +{
> > +	return readl(base + reg);
> > +}
> > +
> > +inline void mfpwm_reg_write(void __iomem *base, u32 reg, u32 val)
> > +{
> > +	writel(val, base + reg);
> > +}
>=20
> making that a "static inline ..." solves that.

Ack, will change

>=20
>=20
> On a more general note, what is the differentiation to an MFD here?
>=20
> Like you can already bind dt-nodes to MFD subdevices, and can implement
> the exclusivity API thing on top of a general mfd device, to make sure on=
ly
> one mfd-cell gets activated at one time.
>=20
> Other than that, this looks like it reimplements MFDs?

What initially made me not make this an MFD was Uwe Kleine-K=C3=B6nig expre=
ssing
some doubts, which lead me to alternatives like the auxiliary bus. Reading =
the
auxiliary bus docs I found:

  A key requirement for utilizing the auxiliary bus is that there is no
  dependency on a physical bus, device, register accesses or regmap support.
  These individual devices split from the core cannot live on the platform
  bus as they are not physical devices that are controlled by DT/ACPI. The
  same argument applies for not using MFD in this scenario as MFD relies on
  individual function devices being physical devices.

Additionally, LWN[1] about the auxiliary bus, which I've read up on during =
my
ill-fated journey into that version of the driver, also goes further into w=
hy
MFD is sometimes a bad fit:

  Linux already includes a number of drivers for multi-function devices. One
  of the ways to support them is the Multi-Function Devices (MFD) subsystem.
  It handles independent devices "glued" together into one hardware block
  which may contain some shared resources. MFD allows access to device
  registers either directly, or using a common bus. In this second case, it
  conveniently multiplexes accesses on Inter-Integrated Circuit (I2C) or
  Serial Peripheral Interface (SPI) buses. As the MFD sub-devices are
  separate, MFD drivers do not share a common state.

  The devices Ertman addresses do not fit well into the MFD model. Devices
  using the auxiliary bus provide subsets of the capabilities of a single
  hardware device. They do not expose separate register sets for each
  function; thus they cannot be described by devicetrees or discovered by
  ACPI. Their drivers need to share access to the hardware. Events concerni=
ng
  all sub-functionalities (like power management) need to be properly handl=
ed
  by all drivers.

The individual function devices may be all pointing at the same physical
device here, but they're not distinct parts of the device. However, there
still *is* a physical device, which convinced me that auxiliary bus wasn't
the right one either, and the idea for just using the platform bus came
during a work meeting. If someone with experience on aux bus vs platform bus
(what this uses) vs MFD, then feel free to chime in. Unfortunately, as is t=
he
norm, I can't seem to find much in terms of MFD documentation. Needing to k=
now
what type of exclusion they guarantee and what type of abstractions they br=
ing
with them that would make them more useful than my solution would need some
justification in more than just an auto-generated header listing.

I am very inclined to start pretending things that aren't documented do
not actually exist in the kernel, because it's very annoying to have to
constantly deal with this.

>=20
> Also handing around a regmap might be nicer, compared to readl/writel.

Strong disagree, adding error handling around every single register read
and write, and needing to always read into a variable rather than getting
the read value as a return value, made the drivers a lot uglier in a
previous iteration of this.

>=20
>=20
> Heiko
>=20

Kind regards,
Nicolas Frattaroli

[1]: https://lwn.net/Articles/840416/




