Return-Path: <linux-pwm+bounces-6166-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2473EAC6851
	for <lists+linux-pwm@lfdr.de>; Wed, 28 May 2025 13:25:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7CE816AF7F
	for <lists+linux-pwm@lfdr.de>; Wed, 28 May 2025 11:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E02E280CE5;
	Wed, 28 May 2025 11:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QwoKX6a1"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CFE86A33B;
	Wed, 28 May 2025 11:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748431513; cv=none; b=qjtixVWm9bmM7yqy8xnK2HgYDCWHTJeS40kI6N+2jHoaD3fkiNa3u9ZbSs6cti7Xg/eyXgXnRMtP/6Pjvdm8e0TFrdZVyFmdB6yHNjLSf4go2Y1fvdw1gE/CUe9MonkJqZBFmXIozWHqlCKRSH/CnJh7ckuSkc9eI8BsyKL5OuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748431513; c=relaxed/simple;
	bh=K4InY6t48H5O8zLU+hNLlWosd5sv42G9OLlcDO3H+MM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ajW3SijWpqoXoaEohr/pNuO5dEHhneN7V8EXC+oOCiY/DaLvVHEZtexml4IeBANUElKPBYJb5TnVY+dUg89kRlJ2QhoiqULBE/qiozj7jglgc2ryieLzFefIuUmObqb3GosXXUsZmwQQsUw9cQUnCGiuXENS39/gZit6cLjre9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QwoKX6a1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E887C4CEE7;
	Wed, 28 May 2025 11:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748431512;
	bh=K4InY6t48H5O8zLU+hNLlWosd5sv42G9OLlcDO3H+MM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QwoKX6a1HAKgzaBvCoyOhIO1pbBz2pF8HqQ6xzKdeassjWxQp/uPE2yINhGaXIjfr
	 i1BTW4VEIqJDTrxbg1TcM02zEBwplZQsnflyhFFmQ6rcjkq/Fy+K3ucy9antZBM7Zg
	 4g4d/3F3/o1AMvGRKdJmVZ9WX9hDCeOVS+OBXMxuoyiitH+GopNhwLOXn96RVuKzpL
	 mt/MBXKlat/QdW+wXlVAjh0NzmwVtlPpl+w+Om/e+RlG07WeHDamx4VTiQ2hm9T4cn
	 /eVm2oE9s8eXY7zg7krfYb0jKUnvQQt+8NtyJin6kJ8/e1hWedaIf98Hq44+UidJfT
	 wO6C59/hn4iIg==
Date: Wed, 28 May 2025 12:25:08 +0100
From: Conor Dooley <conor@kernel.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>
Cc: Nylon Chen <nylon.chen@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, devicetree@vger.kernel.org,
	linux-pwm@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	paul.walmsley@sifive.com, samuel.holland@sifive.com
Subject: Re: [PATCH v14 0/5] Change PWM-controlled LED pin active mode and
 algorithm
Message-ID: <20250528-obedience-staff-8c7115a1e72c@spud>
References: <20250509095234.643890-1-nylon.chen@sifive.com>
 <crcfskukqifse6gqrydx2iezargv5frv6dguj3iqdkfm7xxbqh@4v2dvo4zcmbz>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="g+WxYtHMM8gBZU/7"
Content-Disposition: inline
In-Reply-To: <crcfskukqifse6gqrydx2iezargv5frv6dguj3iqdkfm7xxbqh@4v2dvo4zcmbz>


--g+WxYtHMM8gBZU/7
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 28, 2025 at 12:21:45PM +0200, Uwe Kleine-K=F6nig wrote:
> Hello,
>=20
> patches 1 and 2 ideally go in together, right? @Conor, does your Ack
> mean that you're OK with me taking the dts change via my pwm tree?

That's exactly what an ack from me means, yes.

--g+WxYtHMM8gBZU/7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaDbylAAKCRB4tDGHoIJi
0o5UAP9VjzL/ZyLA/i/SUt2+q4K+R5tvVDuyf86ESthCZ26OnwEA5B0jDEtRBnoF
IdZ9OaRAigLh373m9zVKDnSsP1nKCQA=
=B2ga
-----END PGP SIGNATURE-----

--g+WxYtHMM8gBZU/7--

