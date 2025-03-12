Return-Path: <linux-pwm+bounces-5141-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE5F0A5E7BA
	for <lists+linux-pwm@lfdr.de>; Wed, 12 Mar 2025 23:56:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D7597A69E5
	for <lists+linux-pwm@lfdr.de>; Wed, 12 Mar 2025 22:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4A0F1F0E5A;
	Wed, 12 Mar 2025 22:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EdW41dJK"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8992C1D5CC6;
	Wed, 12 Mar 2025 22:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741820179; cv=none; b=PD/7CAhzeNuuQzFsblTV55wLdNR1ColnPmQedODTyp7mBD9wWeQftp+Ikhmiua7IIOGVxxwlp+pOCrEY5T9lAcFWoWNdRvCR6x5FUJhZepKwYXXSHSENk3yPOTOsBVSlhJxi7u9X39LO8PYL1zYYOPQ8doPUvaRJwJJDWq3aiOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741820179; c=relaxed/simple;
	bh=C2dVQHeQfpncIDsa2OOeet8ETBUJqNFX8r3zQxrGOsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ouw9SHDXw75KGBQuIuHQTVwi8T3ZGJ67DILVutEVk191KC7PHc1pu8YTpPgxfMOk2clnU5cJlMpwcLsK+STJrNuDgEIWgoRt/RCe/nzyrxanFu0kIu/gltIE7ESmZJDT4Su0ZKfjzjg65fKobM24w1lw6w5IIpOpum81DbniUoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EdW41dJK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 297B1C4CEDD;
	Wed, 12 Mar 2025 22:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741820179;
	bh=C2dVQHeQfpncIDsa2OOeet8ETBUJqNFX8r3zQxrGOsU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EdW41dJK5Ki4IRn7PulnBUlIvvFljDLIwvK+k1bdRF4zK2qTCqH2qou05o1nweoP/
	 9pmtgVbhPwhNBd5IJjyq1jabLoKsLNvoachJBoGKVrwFYf0z59apOTzCgFjQDxpYG2
	 HrHeAeVOzEX6aTYNCVcLxG0rVle9gOWEUFcJkT2FoZakc5iCAulKq26K1J/oO1xDuU
	 /wwRrLXIOTYhLUW2kLjzb2da1drOzrRBaR+e1c9YpusGxSU1veGqs7qFbT7kwB/G4j
	 2R2/kiojjpeY74sGWe+6bZtaukzASvexI+4xdoRoz3WtYZbkLgWU3Jme42Ljo7WaK7
	 gvF8DRqjd5sLQ==
Date: Wed, 12 Mar 2025 23:56:14 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Vladimir Zapolskiy <vz@mleia.com>
Cc: Purva Yeshi <purvayeshi550@gmail.com>, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, piotr.wojtaszczyk@timesys.com, 
	linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: pwm: Convert lpc32xx-pwm.txt to YAML
Message-ID: <yvljnqnlka3ecw2n3hw2zgfszlldvbww3k7gq72dczmf6jwzfo@4vqnygxuzvk5>
References: <20250312122750.6391-1-purvayeshi550@gmail.com>
 <57ae63a2-544b-4241-a54d-8fa9917c1e44@mleia.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="iy7a5myo3gppi3xw"
Content-Disposition: inline
In-Reply-To: <57ae63a2-544b-4241-a54d-8fa9917c1e44@mleia.com>


--iy7a5myo3gppi3xw
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] dt-bindings: pwm: Convert lpc32xx-pwm.txt to YAML
MIME-Version: 1.0

Hello,

On Wed, Mar 12, 2025 at 07:59:21PM +0200, Vladimir Zapolskiy wrote:
> > +  "#pwm-cells":
> > +    const: 3
>=20
> It shall be 1.

No, 3 is the right choice.

Best regards
Uwe

--iy7a5myo3gppi3xw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmfSEQsACgkQj4D7WH0S
/k5lVQgArXoPIgUnIlPyk8q9Bcn7jLJRpgGwO+O5sTvf38V4qPY9FLas1+z8dtZ1
DD9UQk18kX7sxyYTLpttv0dZIzSmDyp6SRLtX5Od+EglVN1Qot7XBGfVJpDXcUS0
LPsaEkW+fFGfo6akWOIhD59gmZ5tw6otczN9MhA5ADsqtlGQHDJr60gv0MKFiQwk
Oe+6CRMt74IXOTXvvmGLaP5dmTDY2ili1/jd8SApSUuOycSr2RKRgUmXyUmnuGlp
4c8ZS4Cc5FwhkvLb5bDSKfq2+V6LV1U+0GHpXjZeLxt0HMhac7OJfMrR3k/tDfv+
mMyHg2ZcC58v/HLLzlKGt+w/Wka6CA==
=Nzf2
-----END PGP SIGNATURE-----

--iy7a5myo3gppi3xw--

