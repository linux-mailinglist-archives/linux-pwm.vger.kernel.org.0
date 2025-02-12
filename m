Return-Path: <linux-pwm+bounces-4865-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8610CA3210D
	for <lists+linux-pwm@lfdr.de>; Wed, 12 Feb 2025 09:27:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 896F6188A1C9
	for <lists+linux-pwm@lfdr.de>; Wed, 12 Feb 2025 08:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F26AA205ABB;
	Wed, 12 Feb 2025 08:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l2HRA1Kd"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13AF205AB4;
	Wed, 12 Feb 2025 08:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739348758; cv=none; b=b/TnC1u6CZzcX6R19122y8YQDkiE46QOrNuBQ2/q1aCZ5WYs4OCIhcq256ttXwsD1bNWMdjTsudI49FlUjvKPBqhwJyAq5eh7NadKDqvjR92nnich4jg0DNn1/JAAmSD220cK2IzZazwzcOi1JIG9XJ9dUDmLkrBMDCKwOmZdww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739348758; c=relaxed/simple;
	bh=iaafHC+QOh7ucrb1jk1Wl/0MaPzchf6dt+Z+vfrMZSk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O6P/u2lzxyclhNOhWzxu7+NA0jRyrFW8JgKI++CpqqNRLIRdC58xD8uSJUqTSsZ+N3xBnU9PP7+5wB/HTLd/wNKptqvuNZUNXEC5M7NEze00VKhKIGfboyY8bAj3LaAxrzcoBLOH8DxRu6TABQgZy4FrQ+asGvnThd0j005aymk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l2HRA1Kd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0EBDC4CEE2;
	Wed, 12 Feb 2025 08:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739348758;
	bh=iaafHC+QOh7ucrb1jk1Wl/0MaPzchf6dt+Z+vfrMZSk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l2HRA1KdVAe3Z8QSCBXlJtH9TSQuJwWmnykKdsGFypNHwQIPhuMQ4Hkaj2dcsj6Jw
	 Np5bWQusyHVgpzyR/qikYIGpyHtL+W4B7nimVjfOJKDd9Ftcnk8OZoBxhM46AN35gK
	 1r+/F08DQbQngxiu+6En12NUuvU6F0/JimZZRgULPVC3bVGNlz78o4zAB6KX+Selil
	 STerr/LkKym8W0DkKMs/FwjDl1jzBC/z41x13YUjsZuA55+Ke0/Lxzjfo33MkuqRjP
	 SjkibqDzz7rjcSA0C1xXJZ7fBOI1ivsfI9UvEbCAKFjt7cnLX0BOnST1VlGjeLAZW1
	 fSP8NHKE2+2GA==
Date: Wed, 12 Feb 2025 09:25:54 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Herve Codina <herve.codina@bootlin.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Luca Ceresoli <luca.ceresoli@bootlin.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v3 0/2] pwm: Add support for pwm nexus node
Message-ID: <ufl4kwrjyp4zid4muvghefevqc6hk3zyvxnsu72fxd4f46fzg6@hufkci2dzjid>
References: <20250205095547.536083-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wmjtzh42nhqulnry"
Content-Disposition: inline
In-Reply-To: <20250205095547.536083-1-herve.codina@bootlin.com>


--wmjtzh42nhqulnry
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v3 0/2] pwm: Add support for pwm nexus node
MIME-Version: 1.0

Hello,

applied both patches to

	https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for-next

with the fixup that Rob requested in the first patch. Thanks!

Best regards
Uwe

--wmjtzh42nhqulnry
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmesWw8ACgkQj4D7WH0S
/k7aFgf+PYpAgnm3DIYuICBhwNZsiuJqtDAJVnu1HZ63Zt6ZRDrVU9yiXL+1k65/
aalVG3qBLXQs+vYLJWz+ibEPv/42ucmJHr1w2iFt8ipO57bEVjxU5kS69h8jixBs
jrQn/WOLaAL9OL0ZBUHea7lh15jQ3cVDL35TsZrzDCl7uRKDIzgGMqQCHwpg2TCM
3Wy9wGiixU0SImNMr6BMpYfV5XrEFM+764u+8jwRK2KSWVPpeCj9DtOLMGuwFH9Z
WYxepE3l0AKWaBr69u164Um4ZR0BIQDvFTTWSRcEXcOyCyocKxBAKP/P8wQa840C
MZp+NmRASHPsS86kCg277sgSqUk0dA==
=L6H1
-----END PGP SIGNATURE-----

--wmjtzh42nhqulnry--

