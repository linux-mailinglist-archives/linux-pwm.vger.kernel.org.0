Return-Path: <linux-pwm+bounces-6202-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FFA8AC9CF0
	for <lists+linux-pwm@lfdr.de>; Sat, 31 May 2025 23:48:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9DC3189CDDB
	for <lists+linux-pwm@lfdr.de>; Sat, 31 May 2025 21:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECC0E1D95B3;
	Sat, 31 May 2025 21:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="S/veJHBk"
X-Original-To: linux-pwm@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D279C1ACE0C;
	Sat, 31 May 2025 21:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748728122; cv=none; b=orv2GTHXDICSB/zhEQEI17r+xj5Ks9RUWpJTeEaRAYiwB6fxr12b1ab/RHIfxWg94YPBfzJN+VpI0/g6tA5BFiDtRp1TSTkQEbWsU6EwHrhhAKow6cGp97HisjPEmEGDiiRDTVrG365/9OV1r9Dfv35LzJ6rb3CqMESTGY0Vk9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748728122; c=relaxed/simple;
	bh=dr5WfIFnDvxt8uCn0X7Wh0AAlu8MV4VHpUff1slIYog=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iFYxdfu8MXiWLpJDLIEkngqXcB6ntMvbb9yZCy3jnaFee+TEgy8PRqx0QSGBcP2kMslR8Tdu3X6Ro5HlXBkOeffFywegjm75wlLmasc/EmPd0tz5ZRpRYjUnWq91WG2dCm18zOucUjBxPfqRCS9wcbf2t8B5Mc6amwZ7l+hQpBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=S/veJHBk; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=7u2qauzFTP/rcfL2a+zDfaRZel9Pi3gl/2pshUKS3Yk=; b=S/veJHBk4K4AhMATBTSQloGQ/s
	SExGYxn3vLkx2Q5mkmsp0Kv0K+HTFKscAq30eVlszyNmHjpIMlxe/wFsDhlRhxi/yl2bItdRpd/c3
	YP4DoEl8pZojG29DsB8iQbYu6yCJ0Id9+IuvCdPqOIV/cAMqalAKqDw6vmBtKD/L0UKJVIeHaLKg1
	S1cNU9BLdN+/Nw1QA81Z2eyTzfCHis7/U5yc1Vh/VPMWkmL45r+AKeIdy/7b3dTX39inxEWjBsoMT
	9Ij0k2rb6NW1oewrgOJadOIq1GjyOWNqT9uiD5ORDZ/YR9vh5FDP+HssP53zQGw5j8slLg9mO45xs
	RNYOc6kg==;
Received: from i53875a3e.versanet.de ([83.135.90.62] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1uLU46-0001IH-Ji; Sat, 31 May 2025 23:48:30 +0200
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
 Detlev Casanova <detlev.casanova@collabora.com>,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Subject: Re: [PATCH 4/7] soc: rockchip: add mfpwm driver
Date: Sat, 31 May 2025 23:48:29 +0200
Message-ID: <2188729.OBFZWjSADL@diego>
In-Reply-To: <20250408-rk3576-pwm-v1-4-a49286c2ca8e@collabora.com>
References:
 <20250408-rk3576-pwm-v1-0-a49286c2ca8e@collabora.com>
 <20250408-rk3576-pwm-v1-4-a49286c2ca8e@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Am Dienstag, 8. April 2025, 14:32:16 Mitteleurop=C3=A4ische Sommerzeit schr=
ieb Nicolas Frattaroli:
> With the Rockchip RK3576, the PWM IP used by Rockchip has changed
> substantially. Looking at both the downstream pwm-rockchip driver as
> well as the mainline pwm-rockchip driver made it clear that with all its
> additional features and its differences from previous IP revisions, it
> is best supported in a new driver.
>=20
> This brings us to the question as to what such a new driver should be.
> To me, it soon became clear that it should actually be several new
> drivers, most prominently when Uwe Kleine-K=C3=B6nig let me know that I
> should not implement the pwm subsystem's capture callback, but instead
> write a counter driver for this functionality.
>=20
> Combined with the other as-of-yet unimplemented functionality of this
> new IP, it became apparent that it needs to be spread across several
> subsystems.
>=20
> For this reason, we add a new platform bus based driver, called mfpwm
> (short for "Multi-function PWM"). This "parent" driver makes sure that
> only one device function driver is using the device at a time, and is in
> charge of registering the platform bus devices for the individual device
> functions offered by the device.
>=20
> An acquire/release pattern is used to guarantee that device function
> drivers don't step on each other's toes.
>=20
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

actually trying to compile this, led me to

aarch64-linux-gnu-ld: drivers/soc/rockchip/mfpwm.o: in function `mfpwm_reg_=
read':
/home/devel/hstuebner/00_git-repos/linux-rockchip/_build-arm64/../include/s=
oc/rockchip/mfpwm.h:423: multiple definition of `mfpwm_reg_read'; drivers/p=
wm/pwm-rockchip-v4.o:/home/devel/hstuebner/00_git-repos/linux-rockchip/_bui=
ld-arm64/../include/soc/rockchip/mfpwm.h:423: first defined here
aarch64-linux-gnu-ld: drivers/soc/rockchip/mfpwm.o: in function `mfpwm_reg_=
write':
/home/devel/hstuebner/00_git-repos/linux-rockchip/_build-arm64/../include/s=
oc/rockchip/mfpwm.h:428: multiple definition of `mfpwm_reg_write'; drivers/=
pwm/pwm-rockchip-v4.o:/home/devel/hstuebner/00_git-repos/linux-rockchip/_bu=
ild-arm64/../include/soc/rockchip/mfpwm.h:428: first defined here
make[3]: *** [../scripts/Makefile.vmlinux_o:72: vmlinux.o] Fehler 1


during the linking stage - with the driver as builtin


> +inline u32 mfpwm_reg_read(void __iomem *base, u32 reg)
> +{
> +	return readl(base + reg);
> +}
> +
> +inline void mfpwm_reg_write(void __iomem *base, u32 reg, u32 val)
> +{
> +	writel(val, base + reg);
> +}

making that a "static inline ..." solves that.


On a more general note, what is the differentiation to an MFD here?

Like you can already bind dt-nodes to MFD subdevices, and can implement
the exclusivity API thing on top of a general mfd device, to make sure only
one mfd-cell gets activated at one time.

Other than that, this looks like it reimplements MFDs?

Also handing around a regmap might be nicer, compared to readl/writel.


Heiko




