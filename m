Return-Path: <linux-pwm+bounces-7469-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8629CBF5E56
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Oct 2025 12:54:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3E4024ED95F
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Oct 2025 10:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E14132ABC3;
	Tue, 21 Oct 2025 10:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i8NQ6Jnz"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6267C320391;
	Tue, 21 Oct 2025 10:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761043989; cv=none; b=ZhWpWD6c2oMyHq0ii9zxBJWv1itGkxzpv0kaUQnCHWQIiQ1lkLdhxd/B2lO6luryYgqA1VuptvE7Lzm7GezrnL6I+TKC8Cl9VxLYcHnZmQkEWJP7TVhKS8sBQEcbrX05NTMySL5CtXE9H0HyKYKQw3Zyj2sFy4qIuIm5s0mC7xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761043989; c=relaxed/simple;
	bh=1QeLTVRxBhcRERrORHNftTh+znULUhILRB4YxyimvB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dYh6iajbHWjIH189teYy4iBOLyAuKCfJivhnD4LaDq9fzkN2XFLC5SxHKY8cMEVOqKa1JHM4C/KRn+Wu2QpyHR7FJwklpl9/6jJA4dNyGY0ybNeuvZaq2wqMtJSsYUEKeP2WmB+dMKoKxZFQ8p3KwaLwHxImsxmkfCzC7w1OC8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i8NQ6Jnz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96BB1C4CEF1;
	Tue, 21 Oct 2025 10:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761043989;
	bh=1QeLTVRxBhcRERrORHNftTh+znULUhILRB4YxyimvB0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i8NQ6JnzmoEOvxcsQcaby/WV/pE56AYDIqGdIKLdT4wS6Y6PzcgB24LWoCoazajEk
	 wAEGW8yOfah9C/jy6sIETa1HnH92mvgvFT+WTew15h6wcIcLZUnynk7HwD90bt/0Zl
	 l6HiFmBdVjcctvFNt+XvKtYVV9JOjzxeBnGJ6Z/E3ehzOiEFx5nHLw26KI+mauaUJ+
	 eFWC0KhhHq1i4B5f6IVEE9eqH2Mdbo4Rsll/ptAsUt+DQsR533BcKTa0Sn1FxOQvok
	 BxEY1Oe441lCdods3gTH9m0pgIdFrwBARThomOSP3gwQIBMx/3G6XmZN9vJOpjLYtM
	 uoIQzcFOxcSFQ==
Date: Tue, 21 Oct 2025 12:53:06 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pwm: max7360: Clean MAX7360 code
Message-ID: <ejndpxm7iwim5dj7rmokoqdstk3vmscqrk6yltppzl6o7dfnbg@l2usqskhr5wt>
References: <20250924-mdb-max7360-pwm-optimize-v1-1-5959eeed20d8@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ulbtnrhehjarj7sc"
Content-Disposition: inline
In-Reply-To: <20250924-mdb-max7360-pwm-optimize-v1-1-5959eeed20d8@bootlin.com>


--ulbtnrhehjarj7sc
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] pwm: max7360: Clean MAX7360 code
MIME-Version: 1.0

On Wed, Sep 24, 2025 at 11:06:40AM +0200, Mathieu Dubois-Briand wrote:
> Duty steps computation can never end in values higher than
> MAX7360_PWM_MAX: remove useless use of min().
>=20
> Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
> ---
> This was discussed in the MAX7360 series[1], and I believe we can indeed
> remove this check.
>=20
> [1] https://lore.kernel.org/all/20250824-mdb-max7360-support-v14-0-435cfd=
a2b1ea@bootlin.com/

Applied to
https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for-=
next
as 4.19-rc1 material.

Thanks
Uwe

--ulbtnrhehjarj7sc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmj3Zg8ACgkQj4D7WH0S
/k6h7QgApLuQenQUeKX5QHuKrGhLelqnBZZo/6C7G+YNqC+PFy2D3iLJtBa7NbNK
Y+FRa0N1OLJhicDGFRE75yllU+Fvp4mUJvE/QoeqdDhwnquIgmZMhF4zwjpb7LJG
w96WjDnsb+H5HqnoSRPgBlBUZAvCjY2hlr90p9nntB5VIAoBa0iC6X8sXOun8ywl
0tdibJ5cmvrmp4hvaq1K4DSXjHYxIc40O4Ou6JjPRQWX+5w36Y0QeUcHqr956KFi
th4PqSnPmYGX28fj0CioovnzQnKW3vU5qrVSG5sk5C3lvS4+arWXooslD+DHThs7
iy9hIOcDFRZ+VpglVwt8avoNzBM2pw==
=vFp/
-----END PGP SIGNATURE-----

--ulbtnrhehjarj7sc--

