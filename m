Return-Path: <linux-pwm+bounces-7163-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51413B338A1
	for <lists+linux-pwm@lfdr.de>; Mon, 25 Aug 2025 10:22:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B1441B20AF6
	for <lists+linux-pwm@lfdr.de>; Mon, 25 Aug 2025 08:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D4BC298CC7;
	Mon, 25 Aug 2025 08:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uLntcf0m"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518922628C;
	Mon, 25 Aug 2025 08:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756110121; cv=none; b=PTye34+Cf6MCb0QV8Hlbt6v18NWSYvlCZ2yJ32HcTtWdTy0JBH8fY6xVoWCn52WKncO+kcjk8PSYbFRu96SUyUqV16tbDUIqXppMGTxzrvhRQJpV7G1xCJZbdmsjsBOeQ2olMaBKHls2b6jomLYHbIzGzqmt8Ywsu3zBoaJVQOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756110121; c=relaxed/simple;
	bh=CKnLcSVz8hscKq3KGHj3mdxzbcry0EZQxCr+2htcfA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h63JczEd/SR5Wojs6VMdaQkI6Kvo1iTozsujtvq1tRK7tii0NbeoJnaVZ70vWdB516/TsMEPj6H/jOCKsZFv4Tpzsv0GhwpM7cA2PZeR+wZ2jv1cfM8lQX/sGoL3xeR8kzrw97LF6mO76sE90G+O1nRlRQU714G+tyiMgBzW+aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uLntcf0m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39939C4CEED;
	Mon, 25 Aug 2025 08:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756110120;
	bh=CKnLcSVz8hscKq3KGHj3mdxzbcry0EZQxCr+2htcfA8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uLntcf0m2ZEJ2lsoGZuVH/TBOGWDqrWGIGQ10Ru/jUpPAWI6bt5istJ8qLL62wlUr
	 FQvAUwHfzIEDP6zy1d4RkuIbXQslFBEgOPquSOpfT1CC4VjPLSzZ246ExR4yn++UJe
	 iG4Ex5KF9vQ1l2i3gxP36L5tgchGdvYIp3+t4eBw2K56uRLfh0RM6FrmqriSUwTYG2
	 3SRkFtMl1AgbNvSU9hHise9asVc1B+J4r9vsCRCynOoh862bDww4crnAgQHjYLKI3G
	 zAOhUZFN7p0Pp1lHxSFi6M/ajv0B20icb8AOhU4KG9JewuKoESZvpFYiEPlKB8SbPX
	 oOWQ7bDgQK70A==
Date: Mon, 25 Aug 2025 10:21:57 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
	linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: pwm: nxp,lpc1850-sct-pwm: Minor whitespace
 cleanup in example
Message-ID: <aw5yie2bdi75hjnxw4khpazn4sugh53wdkdr3jpn4pinhyjshp@srangotw74yv>
References: <20250821083110.46420-2-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jur2vay2jsrneuka"
Content-Disposition: inline
In-Reply-To: <20250821083110.46420-2-krzysztof.kozlowski@linaro.org>


--jur2vay2jsrneuka
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] dt-bindings: pwm: nxp,lpc1850-sct-pwm: Minor whitespace
 cleanup in example
MIME-Version: 1.0

Hello,

On Thu, Aug 21, 2025 at 10:31:11AM +0200, Krzysztof Kozlowski wrote:
> The DTS code coding style expects exactly one space around '=3D'
> character.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied and pushed to

https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for-=
next

as 6.18-rc1 material.

Best regards
Uwe

--jur2vay2jsrneuka
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmisHSIACgkQj4D7WH0S
/k5SWAf+LsV6TJJJUCwZqllyqnag2N6DccHnJV/3o4ILE53EAQr5r9ciNDTHvjVz
WFLO/377ofO2cZado0vBrA6wN8Ahx8RvGjktV1+4rmSEIG4obfs27My5h98AiIIU
ai8OBGoaLXqd7ezzUhNFOIjm1pI8jHeEvD5wSeLzlyr9y4ZbY9LFeanvhmdskdnI
6vTPpEN7emuFJ6xWpGgZ2I/CQgnLbvtHJvmnWX72fDC4VgPsk9lkX/pPYJFUvwRJ
cKJ4DYZuPEttg+NfjgvaYKMcYOLMuhIL5wJgFqpX2IzwBOroEHvK39BJH/7bXfBJ
Pm2kwgjRhm6H/4S/d9IJXr0t71uYvA==
=03Co
-----END PGP SIGNATURE-----

--jur2vay2jsrneuka--

