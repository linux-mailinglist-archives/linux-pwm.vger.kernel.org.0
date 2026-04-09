Return-Path: <linux-pwm+bounces-8540-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WLn8HhHf12klTwgAu9opvQ
	(envelope-from <linux-pwm+bounces-8540-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 09 Apr 2026 19:17:05 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E50BB3CE036
	for <lists+linux-pwm@lfdr.de>; Thu, 09 Apr 2026 19:17:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CDCA8300A527
	for <lists+linux-pwm@lfdr.de>; Thu,  9 Apr 2026 17:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37C4F3DEFEC;
	Thu,  9 Apr 2026 17:16:36 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from leonov.paulk.fr (leonov.paulk.fr [185.233.101.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1288C1A682F;
	Thu,  9 Apr 2026 17:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.233.101.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775754996; cv=none; b=ahaeBxzJFxwu+5lsuCgkoKTZ3xOYY9Uz6+7BjAWFVpSixUXs8UB58vQcT2LuKjyMM1Gym4iXTgcQaa0a23+TQtbpz3EHoDVdq5SYcIW6MtK7s4bURLFsxyMZ0+AD5diC8uluZdtXKn1lIYUFJnnJG0FPShlYVwghYJghLDZ/odI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775754996; c=relaxed/simple;
	bh=hKA78I1dX+0HLcZMktBHihV3sCUPWKFWGrCjyXtK6Us=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hk5Xbgpq4luBzNrpk9kfWNWuuSW2eSCGqPxTAxtZovRerHoLpA8a4bhVFwpQh/kvJzNlIdmoLX0do8Da9JoHj9cJWRpttcXD6yTpDLQjY1M3VMvXvnozdD6tkJosnG4bJlC9eXPjELM/23rj0Xawp1itntM76nK2XYTt0zW5ar8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sys-base.io; spf=pass smtp.mailfrom=sys-base.io; arc=none smtp.client-ip=185.233.101.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sys-base.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sys-base.io
Received: from laika.paulk.fr (12.234.24.109.rev.sfr.net [109.24.234.12])
	by leonov.paulk.fr (Postfix) with ESMTPS id 89FB81F8005F;
	Thu,  9 Apr 2026 17:16:20 +0000 (UTC)
Received: by laika.paulk.fr (Postfix, from userid 65534)
	id 9CEF1B401D6; Thu,  9 Apr 2026 17:16:16 +0000 (UTC)
X-Spam-Level: 
Received: from shepard (unknown [192.168.1.1])
	by laika.paulk.fr (Postfix) with ESMTPSA id F0DBEB401B9;
	Thu,  9 Apr 2026 17:16:13 +0000 (UTC)
Date: Thu, 9 Apr 2026 19:16:11 +0200
From: Paul Kocialkowski <paulk@sys-base.io>
To: Richard Genoud <richard.genoud@bootlin.com>
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	John Stultz <jstultz@google.com>, Joao Schim <joao@schimsalabim.eu>,
	linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/4] Introduce Allwinner H616 PWM controller
Message-ID: <adfe2z2YeBxm_6oR@shepard>
References: <20260305091959.2530374-1-richard.genoud@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="GM3yK5VvFWNCjFXU"
Content-Disposition: inline
In-Reply-To: <20260305091959.2530374-1-richard.genoud@bootlin.com>
X-Spamd-Result: default: False [-1.56 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8540-lists,linux-pwm=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[baylibre.com,kernel.org,csie.org,gmail.com,sholland.org,pengutronix.de,bootlin.com,google.com,schimsalabim.eu,vger.kernel.org,lists.infradead.org,lists.linux.dev];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[sys-base.io];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paulk@sys-base.io,linux-pwm@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	R_DKIM_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sys-base.io:url,paulk.fr:url]
X-Rspamd-Queue-Id: E50BB3CE036
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--GM3yK5VvFWNCjFXU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Richard,

On Thu 05 Mar 26, 10:19, Richard Genoud wrote:
> Allwinner H616 PWM controller is quite different from the A10 one.

As I've mentionned before, this PWM controller is not specific to the H616
but also appears in other chips, so the name of the driver and registers
should not mention H616.

After further investigation, I can see multiple versions of this new PWM IP
being used in different chips, starting with the R40/V40 (sun8iw11) in 2016.

The latest downstream BSP driver has a list of the different generations:
https://github.com/radxa/allwinner-bsp/blob/cubie-aiot-v1.4.6/drivers/pwm/p=
wm-sunxi.c#L1901

We have a first generation called v100/v101 for the following chips:
H616, R328 and R40. A second generation is called v200 and brings slight
register layout differences for A133, D1/T113-S3 and V851. Subsequent
iterations (v201-5) are used in more recent chips like A527 and A733 and
seem register-compatible with v200 (from a quick look).

So what I suggest here is to rename the driver "sun8i-pwm" and eventually a=
dd
a list of generations to the driver and different registers when needed, wi=
th
an appropriate suffix in their name.

But since you're currently only dealing with H616, this work can be done la=
ter
when introducing support for more chips.

> It can drive 6 PWM channels, and like for the A10, each channel has a
> bypass that permits to output a clock, bypassing the PWM logic, when
> enabled.
>=20
> But, the channels are paired 2 by 2, sharing a first set of
> MUX/prescaler/gate.
> Then, for each channel, there's another prescaler (that will be bypassed
> if the bypass is enabled for this channel).
>=20
> It looks like that:
>             _____      ______      ________
> OSC24M --->|     |    |      |    |        |
> APB1 ----->| Mux |--->| Gate |--->| /div_m |-----> PWM_clock_src_xy
>            |_____|    |______|    |________|
>                           ________
>                          |        |
>                       +->| /div_k |---> PWM_clock_x
>                       |  |________|
>                       |    ______
>                       |   |      |
>                       +-->| Gate |----> PWM_bypass_clock_x
>                       |   |______|
> PWM_clock_src_xy -----+   ________
>                       |  |        |
>                       +->| /div_k |---> PWM_clock_y
>                       |  |________|
>                       |    ______
>                       |   |      |
>                       +-->| Gate |----> PWM_bypass_clock_y
>                           |______|
>=20
> Where xy can be 0/1, 2/3, 4/5
>=20
> PWM_clock_x/y serve for the PWM purpose.
> PWM_bypass_clock_x/y serve for the clock-provider purpose.
> The common clock framework has been used to manage those clocks.
>=20
> This PWM driver serves as a clock-provider for PWM_bypass_clocks.
> This is needed for example by the embedded AC300 PHY which clock comes
> from PMW5 pin (PB12).
>=20
> Usually, to get a clock from a PWM driver, we use the pwm-clock driver
> so that the PWM driver doesn't need to be a clk-provider itself.
> While this works in most cases, here it just doesn't.
> That's because the pwm-clock request a period from the PWM driver,
> without any clue that it actually wants a clock at a specific frequency,
> and not a PWM signal with duty cycle capability.

=46rom what I understand the pwm-clock driver will either assume a fixed ra=
te
set in device-tree or deduce the rate from the pwm period. In any case it w=
ill
check that the pwm period (which it cannot change) is the same as the reque=
sted
clock period.

So I agree that pwm-clock is unable to change the clock rate at runtime and=
 will
just use whatever frequency the pwm is running at (which is typically set
in the device-tree consumer property).

> So, the PWM driver doesn't know if it can use the bypass or not, it
> doesn't even have the real accurate frequency information (23809524 Hz
> instead of 24MHz) because PWM drivers only deal with periods.

I agree that the driver needs to register as a proper clock provider in
addition to pwm. But what happens if the same PWM clock is requested both f=
rom
the clk side and the pwm side?

> With pwm-clock, we loose a precious information along the way (that we
> actually want a clock and not a PWM signal).
> That's ok with simple PWM drivers that don't have multiple input clocks,
> but in this case, without this information, we can't know for sure which
> clock to use.
> And here, for instance, if we ask for a 24MHz clock, pwm-clock will
> requests 42ns (assigned-clocks doesn't help for that matter). The logic
> is to select the highest clock (100MHz) with no prescaler and a duty
> cycle value of 2/4 =3D> we have 25MHz instead of 24MHz.
> And that's a perfectly fine choice for a PMW, because we still can
> change the duty cycle in the range [0-4]/4.
> But obviously for a clock, we don't care about the duty cycle, but more
> about the clock accuracy.
>=20
> And actually, this PWM is really a PWM AND a real clock when the bypass
> is set.

Make sense to me.

> This series is based onto v6.19-rc4
>=20
> NB: checkpatch is not happy with patch 2, but it's a false positive.
> It doesn't detect that PWM_XY_SRC_MUX/GATE/DIV are structures, but as
> it's more readable like that, I prefer keeping it that way.
>=20
> NB2: for geopolitical reasons, I didn't re-use the old series that Paul
> was referring to.
>=20
> Changes since v3:
> - gather Acked-by/Tested-by
> - fix cast from pointer to integer of different size (kernel test robot
>   with arc platform)
> - add devm_action for clk_hw_unregister_composite as suggested by Philipp
> - remove now unused pwm_remove as suggested by Philipp
>=20
> Changes since v2:
> - use U32_MAX instead of defining UINT32_MAX
> - add a comment on U32_MAX usage in clk_round_rate()
> - change clk_table_div_m (use macros)
> - fix formatting (double space, superfluous comma, extra line feed)
> - fix the parent clock order
> - simplify code by using scoped_guard()
> - add missing const in to_h616_pwm_chip() and rename to
> h616_pwm_from_chip()
> - add/remove missing/superflous error messages
> - rename cnt->period_ticks, duty_cnt->duty_ticks
> - fix PWM_PERIOD_MAX
> - add .remove() callback
> - fix DIV_ROUND_CLOSEST_ULL->DIV_ROUND_UP_ULL
> - add H616_ prefix
> - protect _reg in macros
> - switch to waveforms instead of apply/get_state
> - shrink struct h616_pwm_channel
> - rebase on v6.19-rc4
>=20
> Changes since v1:
> - rebase onto v6.19-rc1
> - add missing headers
> - remove MODULE_ALIAS (suggested by Krzysztof)
> - use sun4i-pwm binding instead of creating a new one (suggested by Krzys=
ztof)
> - retrieve the parent clocks from the devicetree
> - switch num_parents to unsigned int
>=20
> Richard Genoud (4):
>   dt-bindings: pwm: allwinner: add h616 pwm compatible
>   pwm: sun50i: Add H616 PWM support
>   arm64: dts: allwinner: h616: add PWM controller
>   MAINTAINERS: Add entry on Allwinner H616 PWM driver
>=20
>  .../bindings/pwm/allwinner,sun4i-a10-pwm.yaml |  19 +-
>  MAINTAINERS                                   |   5 +
>  .../arm64/boot/dts/allwinner/sun50i-h616.dtsi |  47 +
>  drivers/pwm/Kconfig                           |  12 +
>  drivers/pwm/Makefile                          |   1 +
>  drivers/pwm/pwm-sun50i-h616.c                 | 936 ++++++++++++++++++
>  6 files changed, 1019 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/pwm/pwm-sun50i-h616.c
>=20
>=20
> base-commit: 11439c4635edd669ae435eec308f4ab8a0804808

--=20
Paul Kocialkowski,

Independent contractor - sys-base - https://www.sys-base.io/
Free software developer - https://www.paulk.fr/

Expert in multimedia, graphics and embedded hardware support with Linux.

--GM3yK5VvFWNCjFXU
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEAbcMXZQMtj1fphLChP3B6o/ulQwFAmnX3tsACgkQhP3B6o/u
lQwk+w//QSTIo2Z2JfHqRQgKtfE7esbTJaJLnzIMtQX3ZuOZBp5a+Vbv4e3Nyz8O
7e2Nmt32oc1btCB0YPKVAKSCzEhQvh+MAleVwDQA49+QndCIWbhDGS1dg6xlELuZ
J/db4zzNOBwj8kj100nkKzXs9oXosWJrBfUFBYxUVKaiX7BdtAghGsGrDZLKDOuX
rZX3uv0zLTULBWIN43TR++CHiOKeXoi7BP3ya4CUUZTg6JSPRpv6Dua79DrL20kF
WezYBoiKJhE+gIE5iBtsmgR/uZ3pPBUBR8aE3yQnWVyaPCJf4GaqQTmA0Br/Mu5q
I/xhS1z4KLNidsK+iJ4Hi1W/dHubBDXsXi29OrC36Yn2mCSQvSvAjz59b/dQ1hXE
5m44RxP7QhNNrL/VsNOwC3LugnAOtFfH+IUIWLLXs6Z8aOT7GmMk1KazKuaS1Geg
VHGEbFI2Hq9/oC6BhRFFa0YCMFioq6VWwjGsCibEQcA2A1qNMXaaeI5ZaRUblaAD
nWOYEAF89i4Pe7qVXu7RSVhQOUoKzUnpuExfbt9qIKWX74Yi+D04K6iKAyhpdGke
QX30RRp6zaB/pof9J0JS/UwpWdnxo/bwVKZ5MHA7nhN/fcGJnpqpxbCoMcSs2hyI
/zMj6cC+bYy96AX5Onb8hjsEmf6R7KjPbDjY/nsU9x/93MvJSRs=
=7IMJ
-----END PGP SIGNATURE-----

--GM3yK5VvFWNCjFXU--

