Return-Path: <linux-pwm+bounces-6201-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75FA0AC9B27
	for <lists+linux-pwm@lfdr.de>; Sat, 31 May 2025 15:27:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AE59189E531
	for <lists+linux-pwm@lfdr.de>; Sat, 31 May 2025 13:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 885B123C514;
	Sat, 31 May 2025 13:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="Mu8596DQ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D93101F2;
	Sat, 31 May 2025 13:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748698021; cv=none; b=AUcAerOuOFUBlWhaUOt5J3bvmECnlHMthJXMSCrsdZQZBgjKVlAbfbF5K886bymFHu6hYCLdmbIqfOEky6E4XgUUiYWXQ5NVe+zBlqRl8I2rUNJN0qMDzOMzNE5ZfCrEKrv4J4avWJJlCYxYcxBZ18p4AjEQJt7GpC4bLigYrI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748698021; c=relaxed/simple;
	bh=/wIF/TryaTRf16TItuBGroDgD3DysoPOltvJzZR8kfw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=okBZ+WXLBGFMM9L/NzNj9VYuPJ0u9OVMrX4EywnQtRnwMtX9eTH9qwZ71psCg0yutiudc7oEcoUDXe6CMOZ0rVHWXWr2xUjmmXKPN5nmj6qTldh3Rwv64qgty1O67BvmxHBQ6W+tAEmxJPROTpib39j3TNj9vUKGrmvP9Njwa8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=Mu8596DQ; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=71D51htRSeJGCuuHOHD8b943bYQGqpFoTtzqn/JTPCw=; b=Mu8596DQ4iCe89ntwpBhl75Pbp
	UheiA2gyCWpuQhWw8b+IX+5gbOtCZswwY5Xe8KuS/I4A48P8o/P4mEZISgII/se1hHD6R6IxbsHgV
	e9BdNKzWi7CpVokSVpeCfkBjrnSPDGRB/w9vroZHTQbQTBZTG2TED1T6hwk/euJVOmfb9G2A3dkYv
	uSne6voiWy5YpvDLrxPwEFPmEIOiCkm6LGZve9/GjbZVivXqmDjkBl01K6nf7Zzdkggh8En1GCF6l
	NmZKWsqO4E8i1MUsHSf784QwDDMlnFzqg6z+X53hre+VK2rG5jaDs0E/fzbuter6WUOugo8zwX+Yk
	Ql/UoCMA==;
Received: from i53875a3e.versanet.de ([83.135.90.62] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1uLMEd-0002yn-Tg; Sat, 31 May 2025 15:26:51 +0200
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
Subject:
 Re: [PATCH 3/7] soc: rockchip: add utils header for things shared across
 drivers
Date: Sat, 31 May 2025 15:26:50 +0200
Message-ID: <1895349.atdPhlSkOF@diego>
In-Reply-To: <20250408-rk3576-pwm-v1-3-a49286c2ca8e@collabora.com>
References:
 <20250408-rk3576-pwm-v1-0-a49286c2ca8e@collabora.com>
 <20250408-rk3576-pwm-v1-3-a49286c2ca8e@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Hi,

Am Dienstag, 8. April 2025, 14:32:15 Mitteleurop=C3=A4ische Sommerzeit schr=
ieb Nicolas Frattaroli:
> Rockchip hardware has some functionality that is shared across many
> hardware IPs, and therefore many drivers for them.
>=20
> Most notably is "HIWORD_UPDATE", a macro with slightly different
> semantics replicated across many a rockchip driver. It currently can be
> found defined in 19 files, of which 18 are Rockchip drivers.
>=20
> Instead of continuing this tradition with yet another version of it in
> my new drivers, add a rockchip soc header for utility macros and such.
> In this header, we define a new set of macros: REG_UPDATE_WE and its
> little brother REG_UPDATE_BIT_WE. These are purposefully named something
> other than "HIWORD_UPDATE", to reduce the likelihood of macro
> redefinitions and also reduce the potential to mislead any adopter into
> thinking this HIWORD_UPDATE is just like their HIWORD_UPDATE.
>=20
> Old drivers can be moved over to the new macros over the next while if
> their maintainers think it makes sense for them, which it probably does.
>=20
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

when you're doing these fancy nice new macros, I think they might want to
be even more centrally located for _everyone_ :-) .


Because while true, Rockchip seems to be the biggest user of hiword-mask-
registers, they're not the only one.

Just simply grepping for HIWORD in kernel drivers revealed
=2D Sunplus sp7021 clock and reset drivers [0]
=2D a number of hisilicon clock drivers [1]
=2D some other clock drivers

and as the naming is not really standarized, I guess there will be more
of the same thing under different names in other places.

Similarly, we already have a FIELD_PREP_HIWORD in [2], so all in all
I think all of this wants to move in with the other bitfield stuff like
=46IELD_PREP.


Heiko


[0] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/drivers/clk/clk-sp7021.c#n42
    https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/drivers/reset/reset-sunplus.c
[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/drivers/clk/hisilicon/clk-hi3620.c
    https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/drivers/clk/hisilicon/clk-hi3660.c
    https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/drivers/clk/hisilicon/clk-hi3670.c
    https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/drivers/clk/hisilicon/clk-hi6220.c
[2] https://elixir.bootlin.com/linux/v6.15/source/drivers/phy/rockchip/phy-=
rockchip-samsung-dcphy.c#L23

> ---
>  include/soc/rockchip/utils.h | 76 ++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 76 insertions(+)
>=20
> diff --git a/include/soc/rockchip/utils.h b/include/soc/rockchip/utils.h
> new file mode 100644
> index 0000000000000000000000000000000000000000..3349069e75ff51ebd7a22089a=
f796feafd227ffb
> --- /dev/null
> +++ b/include/soc/rockchip/utils.h
> @@ -0,0 +1,76 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Copyright (c) 2025 Collabora Ltd.
> + *
> + * Utility types, inline functions, and macros that are used across seve=
ral
> + * Rockchip-specific drivers.
> + *
> + * Authors:
> + *     Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> + */
> +
> +#ifndef __SOC_ROCKCHIP_UTILS_H__
> +#define __SOC_ROCKCHIP_UTILS_H__
> +
> +#include <linux/bits.h>
> +#include <linux/build_bug.h>
> +#include <linux/limits.h>
> +
> +/*
> + * Incoming macro basilisks, stare directly at them at your own peril.
> + * As a gentle reminder to help with code comprehension: BUILD_BUG_ON_ZE=
RO
> + * is confusingly named; it's a version of BUILD_BUG_ON that evaluates t=
o zero
> + * if it does not trigger, i.e. the assertion within the macro still che=
cks
> + * for a truthy value, not zero.
> + */
> +
> +/**
> + * REG_UPDATE_WE - generate a register write value with a write-enable m=
ask
> + * @_val: unshifted value we wish to update between @_low and @_high
> + * @_low: index of the low bit of the bit range we want to update
> + * @_high: index of the high bit of the bit range we want to update
> + *
> + * This macro statically generates a value consisting of @_val shifted t=
o the
> + * left by @_low, and a write-enable mask in the upper 16 bits of the va=
lue
> + * that sets bit ``i << 16`` to ``1`` if bit ``i`` is within the @_low t=
o @_high
> + * range. Only up to bit (@_high - @_low) of @_val is used for safety, i=
=2Ee.
> + * trying to write a value that doesn't fit in the specified range will =
simply
> + * truncate it.
> + *
> + * This is useful for some hardware, like some of Rockchip's registers, =
where
> + * a 32-bit width register is divided into a value low half, and a write=
 enable
> + * high half. Bits in the low half are only update if the corresponding =
bit in
> + * the high half is ``1``, allowing for lock-free atomic updates of a re=
gister.
> + *
> + * This macro replaces the venerable ``HIWORD_UPDATE``, which is copied =
and
> + * pasted in slightly different forms across many different Rockchip dri=
vers.
> + * Before switching drivers to use it, familiarise yourself with the sem=
antics
> + * of your specific ``HIWORD_UPDATE`` compared to this function-like mac=
ro's
> + * semantics.
> + *
> + * Return: the value, shifted into place, with the required write-enable=
 bits
> + */
> +#define REG_UPDATE_WE(_val, _low, _high) ( \
> +	BUILD_BUG_ON_ZERO(const_true((_low) > (_high))) + \
> +	BUILD_BUG_ON_ZERO(const_true((_high) > 15)) + \
> +	BUILD_BUG_ON_ZERO(const_true((_low) < 0)) + \
> +	BUILD_BUG_ON_ZERO(const_true((u64) (_val) > U16_MAX)) + \
> +	((_val & GENMASK((_high) - (_low), 0)) << (_low) | \
> +	(GENMASK((_high), (_low)) << 16)))
> +
> +/**
> + * REG_UPDATE_BIT_WE - update a bit with a write-enable mask
> + * @__val: new value of the bit, either ``0`` 0r ``1``
> + * @__bit: bit index to modify, 0 <=3D @__bit < 16.
> + *
> + * This is like REG_UPDATE_WE() but only modifies a single bit, thereby =
making
> + * invocation easier by avoiding having to pass a repeated value.
> + *
> + * Return: a value with bit @__bit set to @__val and @__bit << 16 set to=
 ``1``
> + */
> +#define REG_UPDATE_BIT_WE(__val, __bit) ( \
> +	BUILD_BUG_ON_ZERO(const_true((__val) > 1)) + \
> +	BUILD_BUG_ON_ZERO(const_true((__val) < 0)) + \
> +	REG_UPDATE_WE((__val), (__bit), (__bit)))
> +
> +#endif /* __SOC_ROCKCHIP_UTILS_H__ */
>=20
>=20





