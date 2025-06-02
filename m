Return-Path: <linux-pwm+bounces-6230-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC12ACBBE0
	for <lists+linux-pwm@lfdr.de>; Mon,  2 Jun 2025 21:41:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4F27188317B
	for <lists+linux-pwm@lfdr.de>; Mon,  2 Jun 2025 19:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CCDE22E00E;
	Mon,  2 Jun 2025 19:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="ZbiIOWWr"
X-Original-To: linux-pwm@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98EFB22D4E9;
	Mon,  2 Jun 2025 19:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748893209; cv=none; b=Y36+zAxlGdJitaIQVGPKUH7opUg0Lo5SSteBvriDfm85vDj6EhFkJYpWoR8VhxP+E3jjRT3oR4ER0lPcJHMD/HfffiYw1dJDzWV0L+oemiD4tVy7Mc9k1Faj/7SQsgq44Xw2dahI613EG5g7F7DaC8t416j/V5Sb0vqZ28JsvyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748893209; c=relaxed/simple;
	bh=hWu5mf/ibSOw0ioy3LC7dcXEKAsj0y+UB5ogGus1Hcc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C3v3jpIsMy4epryyXNq0vNEZc+0LZpY1jIFhFolrXh7XBnvgtbU0ZPPdWH98kcfboZn5Ef6XIW7Ls1UqER7Ht/k7QmaetpJx4jcNxXyqtZtQyQ+qcZOToxiDsi9iBMufRjefMw3tpbB9+KpquLx23wV9uwyQ4JiWQ8Mhq/WoHig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=ZbiIOWWr; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=SPw9tHv+YFqDOgHItgDh6WWYcZqPEA6GRstSGC7FvMw=; b=ZbiIOWWrqz4Xo+xhj4MkrCq550
	Ab4dft5PIpkhNivF6xz0iT41AGSWYazCmEw52oUzY7yke177u5Jn17ClfKLKgG86ri9LUrUqJfOno
	Pn8EjwT7yFIYPwULfA5k8jmbuEcqPmanrMBT6HWnehBEexpPbTctIyfSzqURX979tYqk8d8ZxaeAD
	jl7R9E9YJwLs5A++pG9KovRDmiemI6nsgopOBXLBY6wp5Qz1gt6cS9JxgKLJ/+G7HdDvCllOuAHm5
	DiccjOKDXbLRNQCJsqtSXDCl/3Kw+ALRxQJGiewJj2UNSwAU0dVdGWerCn7sT4gW0/MUXsK05vjRb
	UIfpB2rw==;
Received: from i53875a2b.versanet.de ([83.135.90.43] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1uMAPg-0001RE-Cy; Mon, 02 Jun 2025 21:01:36 +0200
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <ukleinek@kernel.org>,
 William Breathitt Gray <wbg@kernel.org>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Kever Yang <kever.yang@rock-chips.com>, Yury Norov <yury.norov@gmail.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Leon Romanovsky <leon@kernel.org>, Lee Jones <lee@kernel.org>,
 linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
 linux-iio@vger.kernel.org, kernel@collabora.com,
 Jonas Karlman <jonas@kwiboo.se>,
 Detlev Casanova <detlev.casanova@collabora.com>,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Subject: Re: [PATCH v2 3/7] bitfield: introduce HI16_WE bitfield prep macros
Date: Mon, 02 Jun 2025 21:01:35 +0200
Message-ID: <6139278.alqRGMn8q6@diego>
In-Reply-To: <20250602-rk3576-pwm-v2-3-a6434b0ce60c@collabora.com>
References:
 <20250602-rk3576-pwm-v2-0-a6434b0ce60c@collabora.com>
 <20250602-rk3576-pwm-v2-3-a6434b0ce60c@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Am Montag, 2. Juni 2025, 18:19:14 Mitteleurop=C3=A4ische Sommerzeit schrieb=
 Nicolas Frattaroli:
> Hardware of various vendors, but very notably Rockchip, often uses
> 32-bit registers where the upper 16-bit half of the register is a
> write-enable mask for the lower half.
>=20
> This type of hardware setup allows for more granular concurrent register
> write access.
>=20
> Over the years, many drivers have hand-rolled their own version of this
> macro, usually without any checks, often called something like
> HIWORD_UPDATE or FIELD_PREP_HIWORD, commonly with slightly different
> semantics between them.
>=20
> Clearly there is a demand for such a macro, and thus the demand should
> be satisfied in a common header file.
>=20
> Add two macros: FIELD_PREP_HI16_WE, and FIELD_PREP_HI16_WE_CONST. The
> latter is a version that can be used in initializers, like
> FIELD_PREP_CONST. The macro names are chosen to explicitly reference the
> assumed half-register width, and its function, while not clashing with
> any potential other macros that drivers may already have implemented
> themselves.
>=20
> Future drivers should use these macros instead of handrolling their own,
> and old drivers can be ported to the new macros as time and opportunity
> allows.
>=20
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> ---
>  include/linux/bitfield.h | 47 ++++++++++++++++++++++++++++++++++++++++++=
+++++
>  1 file changed, 47 insertions(+)
>=20
> diff --git a/include/linux/bitfield.h b/include/linux/bitfield.h
> index 6d9a53db54b66c0833973c880444bd289d9667b1..2b3e7cb90ccb5d48f510104f6=
1443b06748bb7eb 100644
> --- a/include/linux/bitfield.h
> +++ b/include/linux/bitfield.h
> @@ -8,6 +8,7 @@
>  #define _LINUX_BITFIELD_H
> =20
>  #include <linux/build_bug.h>
> +#include <linux/limits.h>
>  #include <linux/typecheck.h>
>  #include <asm/byteorder.h>
> =20
> @@ -142,6 +143,52 @@
>  		(((typeof(_mask))(_val) << __bf_shf(_mask)) & (_mask))	\
>  	)
> =20
> +/**
> + * FIELD_PREP_HI16_WE() - prepare a bitfield element with a write-enable=
 mask
> + * @_mask: shifted mask defining the field's length and position
> + * @_val:  value to put in the field
> + *
> + * FIELD_PREP_HI16_WE() masks and shifts up the value, as well as bitwis=
e ORs
> + * the result with the mask shifted up by 16.
> + *
> + * This is useful for a common design of hardware registers where the up=
per
> + * 16-bit half of a 32-bit register is used as a write-enable mask. In s=
uch a
> + * register, a bit in the lower half is only updated if the correspondin=
g bit
> + * in the upper half is high.
> + */
> +#define FIELD_PREP_HI16_WE(_mask, _val)					\
> +	({								\
> +		__BF_FIELD_CHECK(_mask, ((u16) 0U), _val,		\
> +				 "FIELD_PREP_HI16_WE: ");		\
> +		((typeof(_mask))(_val) << __bf_shf(_mask)) & (_mask) |	\

gcc is quite adamant about suggesting more parentheses here:

=2E./include/linux/bitfield.h:163:70: warning: suggest parentheses around a=
rithmetic in operand of =E2=80=98|=E2=80=99 [-Wparentheses]
  163 |                 ((typeof(_mask))(_val) << __bf_shf(_mask)) & (_mask=
) |  \
      |                                                                    =
  ^
=2E./include/soc/rockchip/mfpwm.h:225:41: note: in expansion of macro =E2=
=80=98FIELD_PREP_HI16_WE=E2=80=99
  225 | #define PWMV4_MODE(v)                   FIELD_PREP_HI16_WE(PWMV4_MO=
DE_MASK, (v))
      |                                         ^~~~~~~~~~~~~~~~~~
=2E./include/soc/rockchip/mfpwm.h:230:34: note: in expansion of macro =E2=
=80=98PWMV4_MODE=E2=80=99
  230 | #define PWMV4_CTRL_CONT_FLAGS   (PWMV4_MODE(PWMV4_MODE_CONT) | \
      |                                  ^~~~~~~~~~
=2E./drivers/pwm/pwm-rockchip-v4.c:237:57: note: in expansion of macro =E2=
=80=98PWMV4_CTRL_CONT_FLAGS=E2=80=99
  237 |         mfpwm_reg_write(pc->pwmf->base, PWMV4_REG_CTRL, PWMV4_CTRL_=
CONT_FLAGS);
      |                                                         ^~~~~~~~~~~=
~~~~~~~~~~


Heiko



