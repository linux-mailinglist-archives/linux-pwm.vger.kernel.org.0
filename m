Return-Path: <linux-pwm+bounces-5973-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BE79AB5D9E
	for <lists+linux-pwm@lfdr.de>; Tue, 13 May 2025 22:19:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB3E21B45796
	for <lists+linux-pwm@lfdr.de>; Tue, 13 May 2025 20:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A1A31F1538;
	Tue, 13 May 2025 20:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="euec/vgw"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE3653365;
	Tue, 13 May 2025 20:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747167581; cv=none; b=AuYVANJmfqfauvKpFGxVJ1Gq/1jcaTODQwZ6fuW13Uy3IkkN1e4KoFisCLOPTAlVmMGABXwfA7dOfs26pnbQXCE2CmELSP4a1iwX/YT8HoCTp5+g7kx9nspOXgUH34HbGqbjezvCwuYJW1hiEOMikUyQH5efc1w1AfbRwHIHTsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747167581; c=relaxed/simple;
	bh=m/9128nTWOeQ0Cjn2C5OaprvMtrWAAhIHE9AX/wZpfc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W44Bb5FOm5Y4JKZs0snVpL7SyVr82NDBBvfzrzx75OHF5fLgRE+90kbKqCb4FXEgfpKRAjYPY9/C+/KsxOiXR1s04Sh9DaKqo7qRrYDkSP8TPsC8Bny6Q/OqQm52t36TvvHRA3caTA+zCNhz0KFgafWcLdDlNBXjeq2MT0NxN94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=euec/vgw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE7DCC4CEE4;
	Tue, 13 May 2025 20:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747167580;
	bh=m/9128nTWOeQ0Cjn2C5OaprvMtrWAAhIHE9AX/wZpfc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=euec/vgwDxF/no7xO/G9cTs66OH2A8yDwh3350sWn3gqp1RuF9gSJNCd+3lhuggbc
	 GcYTDZ796gXx+o/DActOQFBhJJmVWcQ5FiIa8wGLQTx/52FPNBKqmASlC/2K+dRPP0
	 V9kbK3u99x/GbmkSSeGS9bRR8SQnn+UP+VB+BgHSZfNSWxXcR95Jqdv/vHmd0OUXBj
	 DcbZoz1i+0Gekf6ENPxN8cGM1t1zl6/aX7o0SEFoN8mYmxQqp50TcO8AgltpQ0xebM
	 sHYiuRKrmwSlrcag+vIQnGPkXf6EqK5QYAOUR9kTWHuBVEFUTPr1woW5g/mOoONUjg
	 5x/+GyJvj5QAw==
Date: Tue, 13 May 2025 22:19:36 +0200
From: =?utf-8?Q?=22Uwe_Kleine-K=C3=B6nig=22?= <ukleinek@kernel.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Catalin Marinas <catalin.marinas@arm.com>, 
	Russell King <linux@armlinux.org.uk>, Will Deacon <will@kernel.org>, linux-pwm@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH v4] pwm: tidyup PWM menu for Renesas
Message-ID: <62gkja5ysv47yos2hcurluudxwvl54uv4ih7pjnmnjrzuik6cs@a5oxhyyy6vsm>
References: <877c2mxrrr.wl-kuninori.morimoto.gx@renesas.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ips6fdf4qicsfzml"
Content-Disposition: inline
In-Reply-To: <877c2mxrrr.wl-kuninori.morimoto.gx@renesas.com>


--ips6fdf4qicsfzml
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4] pwm: tidyup PWM menu for Renesas
MIME-Version: 1.0

Hello,

On Mon, May 12, 2025 at 06:33:12AM +0000, Kuninori Morimoto wrote:
> Because current PWM Kconfig is sorting by symbol name,
> it looks strange ordering in menuconfig.
>=20
> =3D>	[ ]   Renesas R-Car PWM support
> =3D>	[ ]   Renesas TPU PWM support
> 	[ ]   Rockchip PWM support
> =3D>	[ ]   Renesas RZ/G2L General PWM Timer support
> =3D>	[ ]   Renesas RZ/G2L MTU3a PWM Timer support
>=20
> Let's use common CONFIG_PWM_RENESAS_xxx symbol name for Renesas,
> and sort it.
>=20
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
> v3 -> v4
> 	- Based on linux-next/master
>=20
>  arch/arm/configs/multi_v7_defconfig |  2 +-
>  arch/arm/configs/shmobile_defconfig |  2 +-
>  arch/arm64/configs/defconfig        |  6 ++--
>  drivers/pwm/Kconfig                 | 44 ++++++++++++++---------------
>  drivers/pwm/Makefile                |  6 ++--
>  5 files changed, 30 insertions(+), 30 deletions(-)
>=20
> diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi=
_v7_defconfig
> index dc4b722ad4b5..50c170b4619f 100644
> --- a/arch/arm/configs/multi_v7_defconfig
> +++ b/arch/arm/configs/multi_v7_defconfig
> @@ -1184,7 +1184,7 @@ CONFIG_PWM_BCM2835=3Dy
> [...]
> diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmob=
ile_defconfig
> index 0ea34d5d797c..7c3d6a8f0038 100644
> --- a/arch/arm/configs/shmobile_defconfig
> +++ b/arch/arm/configs/shmobile_defconfig
> @@ -203,7 +203,7 @@ CONFIG_RZ_DMAC=3Dy
> [...]
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index d0768584647c..fe021cbb6393 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -1536,11 +1536,11 @@ CONFIG_PWM_IMX27=3Dm
>  CONFIG_PWM_MESON=3Dm
>  CONFIG_PWM_MTK_DISP=3Dm
>  CONFIG_PWM_MEDIATEK=3Dm
> -CONFIG_PWM_RCAR=3Dm
> +CONFIG_PWM_RENESAS_RCAR=3Dm
> +CONFIG_PWM_RENESAS_RZG2L_GPT=3Dm
> +CONFIG_PWM_RENESAS_RZ_MTU3=3Dm
>  CONFIG_PWM_RENESAS_TPU=3Dm
>  CONFIG_PWM_ROCKCHIP=3Dy
> -CONFIG_PWM_RZG2L_GPT=3Dm
> -CONFIG_PWM_RZ_MTU3=3Dm
>  CONFIG_PWM_SAMSUNG=3Dy
>  CONFIG_PWM_SL28CPLD=3Dm
>  CONFIG_PWM_SUN4I=3Dm

I was about to apply this patch, but here in
arch/arm64/configs/defconfig is an not entirely trivial merge conflict.
The problem is that CONFIG_PWM_RZG2L_GPT=3Dm is only added in commit
5ad7de623853 ("arm64: defconfig: Enable Renesas RZ/G2L GPT config")
which isn't included in my tree yet but only in Geert's
renesas-devel.git/next. So conceptually I'd need to do:

--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1536,11 +1536,11 @@ CONFIG_PWM_IMX27=3Dm
 CONFIG_PWM_MESON=3Dm
 CONFIG_PWM_MTK_DISP=3Dm
 CONFIG_PWM_MEDIATEK=3Dm
-CONFIG_PWM_RCAR=3Dm
+CONFIG_PWM_RENESAS_RCAR=3Dm
+CONFIG_PWM_RENESAS_RZ_MTU3=3Dm
 CONFIG_PWM_RENESAS_TPU=3Dm
 CONFIG_PWM_ROCKCHIP=3Dy
-CONFIG_PWM_RZ_MTU3=3Dm
 CONFIG_PWM_SAMSUNG=3Dy
 CONFIG_PWM_SL28CPLD=3Dm
 CONFIG_PWM_SUN4I=3Dm

and the merge conflict resolution needs to add
CONFIG_PWM_RENESAS_RZG2L_GPT=3Dm. This is too bad IMHO.

The obvious options are (in order of my preference):

 - Geert declares his renesas-arm-defconfig-for-v6.16 to be stable and I
   merge it into my tree and then apply the patch
 - I cherry pick 5ad7de623853 in my pwm tree and Geert drops it
 - I delay applying the patch until after v6.16-rc1

Geert: What is your preference? Let's discuss on irc?

Best regards
Uwe

--ips6fdf4qicsfzml
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmgjqVUACgkQj4D7WH0S
/k4N6Qf/Z5/BS3nBaa+9S+S1dZYBR6gLh4rcQTSPlPbc3sEu8c0tbPozyZrIVOaC
FJrZa1t5BKRop4wXKyaDK/ZHbNeqLEcPr9w/AfsTh8zwkaQlA/NXD96AmoVqy+U4
aZJdMwM6kUPCfPWbR0uTELds4NwMwUURPwFl45Eumgd6cCmN1V2+VQaXXINBNUrs
/ag1ae5gC6wTuHcdUGfTVgJHySs/HIJGTOlIta362s7Vtjz17SFnl7+Zup8dUphF
t9nSIuyOBTveKEHLesAt+L6HTU5PIcGDKnxha/kwsI9F3EisanXezSX+aSFXHoqd
PcNCCLw7Da4h9NWNTgm2c11jV9JeMg==
=eBj4
-----END PGP SIGNATURE-----

--ips6fdf4qicsfzml--

