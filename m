Return-Path: <linux-pwm+bounces-6947-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 556E0B19FC7
	for <lists+linux-pwm@lfdr.de>; Mon,  4 Aug 2025 12:38:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE2D5189576E
	for <lists+linux-pwm@lfdr.de>; Mon,  4 Aug 2025 10:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02825200113;
	Mon,  4 Aug 2025 10:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UW1lm50m"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE5815DBC1;
	Mon,  4 Aug 2025 10:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754303898; cv=none; b=fiizblvlwdJ/eB/zpwvsWFF1dpNOBjjDEbZCBMXWzsuqj4QjOdtqJZVAOKaZhvNEs0AXU8Qu7F93f5YXfAlvHtA1DUA36QmxlnFnfyTRvzyGpkK7qCgJYRRpVDDFnjeOofzUxpQ34jnMlnpodnpebKQjo7k9KemAMJz8Ogyo7k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754303898; c=relaxed/simple;
	bh=IqtOYEY67cnFw38l0aA60iFvDRXwR+z0X41m7vP9EjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DZ1wYCNG4wNQA8RndEaxlST3AnA+Gn6d7s3znahibHLPllAev9m6PbfAw6Gk5h3o1p9SKxJJrq3GOkBYb3oHkFl+bTYIyQLmCxaNQSgiTbrPo6p5EVWRYOosB1F+uYHw8lRptXcrj2fuU9iBHGMfxC//PVWuKxMulBVJ3BM+idc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UW1lm50m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB150C4CEE7;
	Mon,  4 Aug 2025 10:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754303898;
	bh=IqtOYEY67cnFw38l0aA60iFvDRXwR+z0X41m7vP9EjM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UW1lm50mSYKT/tfvcbbBAGCiwc7WntZMM20TZIi2BpApiFiYIECaat6VZTV8PBehB
	 lDGFW9un4oJ3hiVRKwkxOYsFbX0WiG8EGTJb38+1mOVrzC0qAKndC8t7RtPkH1a7dP
	 vJB8TKC0Q7Tb5htbHp3n1mxS60SwBCBrkHD4isWRS4pIYpXDQfR/bMteWtQXgSmwiG
	 wMu46Eiwg08TX024ixGM97h3Huga/IBIqExpFvSqwD+PVQyVHyjulpXH7FQgBSyuJ7
	 BLp3MAtF/z8F+njhr0f6P3ycEez6WIciYGBxGftQOdmQYuVKNvr0/YPTNf/DUYicr1
	 tY3sTcp1XEm8g==
Date: Mon, 4 Aug 2025 12:38:15 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: patches@lists.linux.dev, stable@vger.kernel.org, 
	Nylon Chen <nylon.chen@sifive.com>, Zong Li <zong.li@sifive.com>, 
	Vincent Chen <vincent.chen@sifive.com>, paul.walmsley@sifive.com, samuel.holland@sifive.com, 
	linux-pwm@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH AUTOSEL 6.1 24/51] pwm: sifive: Fix PWM algorithm and
 clarify inverted compare behavior
Message-ID: <52ycm5nf2jrxdmdmcijz57xhm2twspjmmiign6zq6rp3d5wt6t@tq5w47fmiwgg>
References: <20250804003643.3625204-1-sashal@kernel.org>
 <20250804003643.3625204-24-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qfo5vfkivwrbc725"
Content-Disposition: inline
In-Reply-To: <20250804003643.3625204-24-sashal@kernel.org>


--qfo5vfkivwrbc725
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH AUTOSEL 6.1 24/51] pwm: sifive: Fix PWM algorithm and
 clarify inverted compare behavior
MIME-Version: 1.0

Hello,

On Sun, Aug 03, 2025 at 08:36:16PM -0400, Sasha Levin wrote:
> From: Nylon Chen <nylon.chen@sifive.com>
>=20
> [ Upstream commit 7dbc4432ea6bf9d709391eb57f1e9fb44e99845a ]
>=20
> The `frac` variable represents the pulse inactive time, and the result
> of this algorithm is the pulse active time. Therefore, we must reverse
> the result.
>=20
> Although the SiFive Reference Manual states "pwms >=3D pwmcmpX -> HIGH",
> the hardware behavior is inverted due to a fixed XNOR with 0. As a result,
> the pwmcmp register actually defines the low (inactive) portion of the pu=
lse.
>=20
> The reference is SiFive FU740-C000 Manual[0]
>=20
> Link: https://sifive.cdn.prismic.io/sifive/1a82e600-1f93-4f41-b2d8-86ed8b=
16acba_fu740-c000-manual-v1p6.pdf [0]
>=20
> Co-developed-by: Zong Li <zong.li@sifive.com>
> Signed-off-by: Zong Li <zong.li@sifive.com>
> Co-developed-by: Vincent Chen <vincent.chen@sifive.com>
> Signed-off-by: Vincent Chen <vincent.chen@sifive.com>
> Signed-off-by: Nylon Chen <nylon.chen@sifive.com>
> Link: https://lore.kernel.org/r/20250529035341.51736-3-nylon.chen@sifive.=
com
> Signed-off-by: Uwe Kleine-K=F6nig <ukleinek@kernel.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>=20
> LLM Generated explanations, may be completely bogus:
>=20
> **Backport Status: YES**
>=20
> This commit should be backported to stable kernel trees. Here's my
> extensive analysis:
>=20
> ## Critical Bug Fix Analysis
>=20
> 1. **The commit fixes a significant functional bug** - The PWM algorithm
>    was fundamentally broken:
>    - The `frac` variable was incorrectly used (lines 158-161 in
>      original, now 168-171)
>    - The driver was writing the duty cycle value directly to PWMCMP
>      register (line 193), but the hardware actually expects the
>      **inactive** (low) time
>    - This results in inverted PWM output behavior where users get the
>      opposite duty cycle from what they request
>=20
> 2. **Hardware behavior discrepancy** - The commit reveals and fixes a
>    critical mismatch between documentation and actual hardware:
>    - The documentation states "pwms >=3D pwmcmpX -> HIGH"
>    - But the hardware has a hard-tied XNOR with 0 that inverts this
>      behavior
>    - The driver now correctly compensates for this hardware quirk
>=20
> 3. **User-visible impact**:
>    - **In `pwm_sifive_get_state()`**: The driver now correctly inverts
>      the value read from hardware (lines 115->122-126)
>    - **In `pwm_sifive_apply()`**: The driver now inverts the duty cycle
>      before writing to hardware (lines 162->171)
>    - **Polarity change**: Changed from `PWM_POLARITY_INVERSED` to
>      `PWM_POLARITY_NORMAL` (lines 126->137, 142->152)
>    - **Documentation fix**: Updated comment from "cannot generate 100%
>      duty" to "cannot generate 0% duty" (lines 11->27, 160->170)
>=20
> 4. **The fix is relatively small and contained**:
>    - Changes are isolated to the PWM algorithm logic
>    - No architectural changes or new features
>    - Simple mathematical inversion: `duty =3D (1U << PWM_SIFIVE_CMPWIDTH)
>      - 1 - inactive`
>=20
> 5. **No risky side effects**:
>    - The change is straightforward and mathematically correct
>    - Doesn't affect other subsystems
>    - Maintains the same register interface
>=20
> 6. **Affects all SiFive PWM users**:
>    - Any system using SiFive FU540 or FU740 SoCs would have incorrect
>      PWM output
>    - This includes various RISC-V development boards and embedded
>      systems
>    - Users would get inverted duty cycles, potentially breaking motor
>      controls, LED dimming, etc.
>=20
> 7. **Clear documentation reference**:
>    - The commit references the official SiFive FU740-C000 Manual
>    - Provides clear explanation of the hardware behavior mismatch
>=20
> The bug causes PWM outputs to be inverted from user expectations, which
> is a significant functional issue that would affect any system relying
> on proper PWM behavior for motor control, LED dimming, or other PWM-
> dependent functionality. The fix is clean, minimal, and addresses a
> clear hardware/software mismatch that exists in production systems.

What your LLM missed is that the device trees using this PWM relied on
this "bug" and so this commit should be applied either together with
f4bcf818e5d6 ("riscv: dts: sifive: unleashed/unmatched: Remove PWM
controlled LED's active-low properties") or not at all.

Given that there might be device trees in use that are not in mainline
and that break in the same way without a possiblity for us to fix that I
tend to prefer not to backport this breaking change to stable.

Best regards
Uwe

--qfo5vfkivwrbc725
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmiQjZQACgkQj4D7WH0S
/k4P/Af9Es0+24qpGdgkAMPcr7a3SUM2X2+zjV+eo73yCNLcWS5ouW1qTVL+nVL8
HlvFVt1Haf4FecuV3O4WuR00mJfnYsG1W6Nrf0+PGHUnlO+j5XBwdf9TmxWC018g
BXrW8UDgMotiE5ybc7ySZtRVkCd8oCf0BkJNrS+wl40nTN2NZHZggQ9Q72P2slNY
X6NObEAaJkZLoST2Wn70e1A5MarBNfTmmZUsURdrsCXdTx/rxncC7yxfYloKYxzr
iC91hksP/r24EGgHS8x5s3E5KvKrqYfg+jvpQMlj2N33T4DohSKJarQDue5+YBr8
7gTU73kN36h9lunrIfPfqQYJNBjqbQ==
=TUM5
-----END PGP SIGNATURE-----

--qfo5vfkivwrbc725--

