Return-Path: <linux-pwm+bounces-7736-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 939E4C94C7A
	for <lists+linux-pwm@lfdr.de>; Sun, 30 Nov 2025 09:29:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 528114E0ED0
	for <lists+linux-pwm@lfdr.de>; Sun, 30 Nov 2025 08:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEFF223E356;
	Sun, 30 Nov 2025 08:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P7uxO5Vy"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8014223D7DC;
	Sun, 30 Nov 2025 08:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764491348; cv=none; b=l2F1ChXFiSpwjfh1qhv4QHCOOKnNcJrVW/dn/p6mOugnrhofNM0tQ/5RODt0icsY/BD+n4YLh4PHVDXOiHekjbd31aUYf1RhEp6Y/4LJXPUy9v0bLk1SVT4rNSRZOON9YOwA/zlRMfYQXxAx/Tz1FNfC1myd8/GtZ/F5N+afndc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764491348; c=relaxed/simple;
	bh=LuYE9IbIxCvHMtTQOnIUmUyazPDisFT4OyvwBFCDr1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hrocdjjre5TyqL1utns0NetsuRI78u4hmtwpwOy3wW0nz5rCIUpELtgmctxcBkGoJ8BNb7snEeRiv/K+UC9ErjFo938GbEjloldBuXbTemMo+lT/ewAohzUN/5PlsgKbGtqGFdrS21aMph51X/8YgRjgL4QED97PMJH+Io1oDf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P7uxO5Vy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DF95C4CEF8;
	Sun, 30 Nov 2025 08:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764491348;
	bh=LuYE9IbIxCvHMtTQOnIUmUyazPDisFT4OyvwBFCDr1o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P7uxO5VyUPIgqdi/Qhi9OZi5SCDBi2Vad/q7DEsQMoquNbKWs3GCuaYabf3SXMPfu
	 aOpdOCwASt4I5oGL7SEpGICgfbfzsKJTuaRlxZylBRqRlV4iK0pxYezKgGHTfrOWGp
	 1AoFX6uV+L9ZfWCx528FLqsZSBabBgY+8386Zqksl5OxynbYThL0I3ojrwYYzCcxlX
	 uvncXAIVQ2PLuohzITNf2pkhyviV2/fcIRhr2tSHMAxMoo6RR8UXUuqGTaUY18yGvH
	 ynlxcWTFN2vN9EIGipR9e835dwvbdJPb9x0i1oRTVi8VpHOVzmSwypPd/ETaDn/KON
	 p2t72o0LFhM9g==
Date: Sun, 30 Nov 2025 09:29:05 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Biju <biju.das.au@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, 
	Magnus Damm <magnus.damm@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>, linux-pwm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Subject: Re: [PATCH v3 3/8] pwm: rzg2l-gpt: Add
 prescale_pow_of_two_mult_factor variable to struct rzg2l_gpt_info
Message-ID: <yvqxc75orn7t4iew3l74yesuclphcx7lfm7omyrid7gm2eq6ks@ulg5tcx75hyo>
References: <20250923144524.191892-1-biju.das.jz@bp.renesas.com>
 <20250923144524.191892-4-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7pkdsm4e4npwt2jl"
Content-Disposition: inline
In-Reply-To: <20250923144524.191892-4-biju.das.jz@bp.renesas.com>


--7pkdsm4e4npwt2jl
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 3/8] pwm: rzg2l-gpt: Add
 prescale_pow_of_two_mult_factor variable to struct rzg2l_gpt_info
MIME-Version: 1.0

Hello Biju,

On Tue, Sep 23, 2025 at 03:45:07PM +0100, Biju wrote:
> @@ -91,6 +91,7 @@
> =20
>  struct rzg2l_gpt_info {
>  	u32 gtcr_tpcs_mask;
> +	u8 prescale_pow_of_two_mult_factor;

To reduce the line length a bit I suggest to call this just
"prescale_mult". That this is (up to now :-) a power of two isn't
relevant enough to be mentioned in the name.

Otherwise looks fine.

Best regards
Uwe

--7pkdsm4e4npwt2jl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmksAE4ACgkQj4D7WH0S
/k5m/Af9Gsid61vEE9kV1LsRYsJ6mB6o4HhrnsHUufmh9tFe0x3bVVoAiX6Oe1zp
vlzzCNaQD7S+TREpvwabYX/93pIG7flxGtzjhecey1yRhZrqGBxs5VVwpK2WG0ug
n3QhPLOGYZ9VJxZ7RGfdmOIdiqK65AfTqPrdoNP6ekaOb9th2c5RpuZ9ZuxZaNEo
uoVIuceURGGKoozNpGYtYM2PD8LpFa+VQTDd5RQTKLrS3c5IW/J7zshazJVYw3Ja
kvu9fVsoDrUkBY5XGB3grDh5J0mRfiUZdT8sTBVWoVw4kNGx30QuKzuTsreU8Q2s
A/6YfVCkf1bp1HDzWV6FpZ30KUe8Cg==
=ubek
-----END PGP SIGNATURE-----

--7pkdsm4e4npwt2jl--

