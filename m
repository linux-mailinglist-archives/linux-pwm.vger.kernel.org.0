Return-Path: <linux-pwm+bounces-7634-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB215C601BB
	for <lists+linux-pwm@lfdr.de>; Sat, 15 Nov 2025 10:00:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42FEA3BF126
	for <lists+linux-pwm@lfdr.de>; Sat, 15 Nov 2025 09:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CB52258CE2;
	Sat, 15 Nov 2025 09:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sI5eKwhu"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396C6257830;
	Sat, 15 Nov 2025 09:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763197212; cv=none; b=NQy4GpBQbl212YLgyd/rs2I5n92Pmn/CNQCjSy0w2Z4JM8ItDFmK6WxQNaX3+gBWk8mYGZ3y0sCy/uMT067acF/0kvFpDMmz5/liiX7sxpDYFTJkcKbABa5LyEhP2qf+6kruho9Y+CudpOVVikxEqfdY4P74VqIi//TstIzce1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763197212; c=relaxed/simple;
	bh=WJ7Ofhc9Ah65PBaTH26V2SciLv3qEIw1kYSsGi0ZQww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h+J6dXXgk8MZ1TsjmVtOPuwXJ/ETgXz2ctKxDzgHKMQYnWawx8RjOBPxnZzxMfnhaK9z2bhRuj4tagktxViMwxd+cTMYuWFrHTygIzgO+U3msrOL9ew8+DkMSgkdtiBNpM6dboEsyHezCxho9SsOYxbS9oQkDfHFwwfknvfEGag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sI5eKwhu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F3B9C19421;
	Sat, 15 Nov 2025 09:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763197211;
	bh=WJ7Ofhc9Ah65PBaTH26V2SciLv3qEIw1kYSsGi0ZQww=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sI5eKwhuML0yiWynjqtEalPUtmt9MVKwhTm7LplUV2emYkCWJXYcwEpJtEAs3bms8
	 HQp0pjllgB73g6NnqBQ+5FdZaryerKpUEAEGJzrT9GtRPYuO3QC6OMsIp9NPUw39/Q
	 0hMTUj5mFzEeC87N1aGcS7OvuI+g+V7AUzTlMXOYf7Q9z8s6Kc7YFU4nYTvOonbB3g
	 8UA8kMsnZ/W1zUH/4sSSBSwryKyrpP2OwroNr84KXXNktHUo1G9zJuzAmprlnKMXbt
	 Fh/524ZZAUhjbMjkny84CX9WFU8yHxUHac3WBLrpoGqxX6BTYm+s9i2Ft9VKsoxBQr
	 OylOm7j2CF/JA==
Date: Sat, 15 Nov 2025 10:00:07 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: ziniu.wang_1@nxp.com
Cc: laurent.pinchart@ideasonboard.com, nuno.sa@analog.com, lee@kernel.org, 
	linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	imx@lists.linux.dev
Subject: Re: [PATCH v2] pwm: adp5585: correct mismatched pwm chip info
Message-ID: <7nsxp5s344xcxq2n2cqq6wrkef7vjyzwtkb3uhfgs4cyrah2ot@cntzr3wughku>
References: <20251114104250.2080030-1-ziniu.wang_1@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5h2yymshnr3ns4js"
Content-Disposition: inline
In-Reply-To: <20251114104250.2080030-1-ziniu.wang_1@nxp.com>


--5h2yymshnr3ns4js
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] pwm: adp5585: correct mismatched pwm chip info
MIME-Version: 1.0

Hello,=20

On Fri, Nov 14, 2025 at 06:42:50PM +0800, ziniu.wang_1@nxp.com wrote:
> From: Luke Wang <ziniu.wang_1@nxp.com>
>=20
> The register addresses of ADP5585 and ADP5589 are swapped.
>=20
> Fixes: 75024f97e82e ("pwm: adp5585: add support for adp5589")
>=20
> Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>
> Tested-by: Liu Ying <victor.liu@nxp.com>
> Acked-by: Nuno S=E1 <nuno.sa@analog.com>
> ---
> v2: amend commit message

Note that I already applied (implicit) v1 and replaced the wording as I
suggested.

Also typically there is no empty line between Fixes: and the S-o-b area
(also fixed).

See https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git/comm=
it/?h=3Dpwm/for-next&id=3Df84fd5bec502447df145f31734793714690ce27f

Best regards
Uwe

--5h2yymshnr3ns4js
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmkYQRQACgkQj4D7WH0S
/k7GcQf/bqFNkMjKTipiBMy7Gjqu+htlOy0puh6P9OZkaBtxDepJa0I0zSAyi/At
abRXtOi7usPki3yYzdn6Sk/V2FQn8fqjQAP4Xyfb79ULbHYNiUfu/KADfa4TCySw
Tomb0hbMdAjdSIbsok+cspo1q9+1xO1VkeTXFfUcfLOpxpDcvG1/qdCkorv8HBWF
MpSob4qCs4jUbCoW3Kkw09Smasll1IaIgvrMMSQHKXiNdoAOyWhyK2pGVtVKeUUq
qtHrtWuY3uK5FIv1vv9yFysy3C2TR7mrO4YJeWm5xWqn/pvsKK2aT/TtjFbQqc6/
nGQX1Jn4HoGwqkL0fY5VvNJqKq+8Bw==
=lh60
-----END PGP SIGNATURE-----

--5h2yymshnr3ns4js--

