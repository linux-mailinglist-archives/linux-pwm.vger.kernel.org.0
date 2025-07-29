Return-Path: <linux-pwm+bounces-6909-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DCF8B150F3
	for <lists+linux-pwm@lfdr.de>; Tue, 29 Jul 2025 18:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 296327A1A8D
	for <lists+linux-pwm@lfdr.de>; Tue, 29 Jul 2025 16:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4EFE286897;
	Tue, 29 Jul 2025 16:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FTA0aK9U"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E25222597;
	Tue, 29 Jul 2025 16:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753805423; cv=none; b=CU7zao/E8uRqto8SkVROOzLOwvcW0o463K8U1SVNlqRJFaBZTmwIRHh8ASz4N7vDftFJJ8fHVF1TLY34OpKX2K2b5X17tGQa1KL92rb7NRwxqPkfsEgAgz8yhe5bdCr36y85ZfAi1q3s/AWsBNIE7O0ZnvfJI1DitRVGGcqi/3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753805423; c=relaxed/simple;
	bh=8PqRrJ4T1GIZlo9A5K1NFm+LtDjYC1pJgTCd4O4aAMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N5UC06zx5G0MWYfwMWIKOPQ+insDWcyBdUdoW8bVNEEdYq7aNvTagCBkt9jFqGQI5Xs+aQ/cFdU5XDQDjq8dGUUPtDz38U7YGr37OzDoAtkuMG/Wwngjjbfxnun/lyDe8XJkU4PKB4ZANKEZZp3Wdwry3gMOohILgpL8d34MlHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FTA0aK9U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51CF4C4CEEF;
	Tue, 29 Jul 2025 16:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753805422;
	bh=8PqRrJ4T1GIZlo9A5K1NFm+LtDjYC1pJgTCd4O4aAMI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FTA0aK9UOoK2ym/J1kozYqDufRATC87ozTu2dcOE8R9riGJty2rKAH0ZFwyS5etFG
	 znwiee/8xiGhtqzLxLAi79OYj5gGqeevHhw+dEXpY5Z1McQ8cWJ42pGi815NRBDhJK
	 7jl+GMCchEUyoMkK6m7dCQhEnMwF85xdwQuNP2uKWNYnfGCNqyTmdz4g58FmeTzjF+
	 9C12Q0PBu3+TUV9aaeZURd1EwZr4KPRCF1231dnTIeMXWjOIEQKw05WY515GP0SkGC
	 h8ZTqThxhxX9t0UB2tMyv5XoDA1BR2AIU4NuJTltnXXKRSpRWOVziBbvNsMnUI5UgW
	 WdEgRH/dnRJuw==
Date: Tue, 29 Jul 2025 18:10:20 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	linux-pwm@vger.kernel.org, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] pwm: imx-tpm: reset counter if CMOD is 0
Message-ID: <ylg2wadbfbyg6ncvoxxz5zthxokphs52lgzscus4qwqgn7q3vy@xzljjzukbtle>
References: <20250728194144.22884-1-laurentiumihalcea111@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lcvyewca57ejyx32"
Content-Disposition: inline
In-Reply-To: <20250728194144.22884-1-laurentiumihalcea111@gmail.com>


--lcvyewca57ejyx32
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3] pwm: imx-tpm: reset counter if CMOD is 0
MIME-Version: 1.0

Hello Laurentiu,

On Mon, Jul 28, 2025 at 03:41:44PM -0400, Laurentiu Mihalcea wrote:
> From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
>=20
> As per the i.MX93 TRM, section 67.3.2.1 "MOD register update", the value
> of the TPM counter does NOT get updated when writing MOD.MOD unless
> SC.CMOD !=3D 0. Therefore, with the current code, assuming the following
> sequence:
>=20
> 	1) pwm_disable()
> 	2) pwm_apply_might_sleep() /* period is changed here */
> 	3) pwm_enable()
>=20
> and assuming only one channel is active, if CNT.COUNT is higher than the
> MOD.MOD value written during the pwm_apply_might_sleep() call then, when
> re-enabling the PWM during pwm_enable(), the counter will end up resetting
> after UINT32_MAX - CNT.COUNT + MOD.MOD cycles instead of MOD.MOD cycles as
> normally expected.
>=20
> Fix this problem by forcing a reset of the TPM counter before MOD.MOD is
> written.
>=20
> Fixes: 738a1cfec2ed ("pwm: Add i.MX TPM PWM driver support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>

Thanks for the respin, looks good now. For consistency I capitalized
"Reset" in the Subject.

Applied to
https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/fixes

=2E I'll give that a day or two in next and then send it to Linus for
6.17-rc1.

Thanks
Uwe

--lcvyewca57ejyx32
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmiI8mgACgkQj4D7WH0S
/k79agf+LH57UR0G6y7RA0SZ7VTuCOOu8rGs7cN4IkwsVO/fpcWnZvidGDVERCL7
HCk0IuDvQJIk1zCIv54AgJkHcMk3HtWfWf/lYM5QhVZxHbHQSKEDQgMM6J2pAEBJ
uE0PJ+4fvdYrPY0YPQhSIICwuKS+rhUyFi5ksRbeKetgMRtuiBEFETkt1MmfWOWd
cGDljyV724kVk3uD6PpuK1OMdWb9Rx09ZMCxwER+HllGGks2Esiia0F3NLIXQm8R
8p1a9CRVSq/zNO+/vS83imY/XAmwkOJ2ucS/oH+zFhu3EJQysY3FSzXsen+ywl7V
YKCb1/VjVFk7SX7puGqqE2Viv9oXJA==
=N9cL
-----END PGP SIGNATURE-----

--lcvyewca57ejyx32--

