Return-Path: <linux-pwm+bounces-4279-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C909E7673
	for <lists+linux-pwm@lfdr.de>; Fri,  6 Dec 2024 17:53:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79CD1161307
	for <lists+linux-pwm@lfdr.de>; Fri,  6 Dec 2024 16:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC751F3D2F;
	Fri,  6 Dec 2024 16:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MHza94HH"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B481E206271;
	Fri,  6 Dec 2024 16:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733503991; cv=none; b=AVUQcWmZpnzH02QiQML+Kjfy2pAdXOrqjGjnOUqEPvhCI+QNejUmBQtP5EoWNExPeLyTrR4b00ctx68osUoD8zIJ5vwt7K4LsaXSlr7EDjgZLVyWZbnhFBcr9oghqaU7HXLPpQ1e3UPZPs7qx5N3/7MRxaBpDYJILGzaCl2pvT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733503991; c=relaxed/simple;
	bh=JpS/Zt5Xq9vuGvkn4jptuxcPyo4ktemXE6eY8TMimTI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DKpAuAixGg9hc2puNRQ5PA3+MlCydTIU6ncRvg6G3H3W4p3Qj5sbJcpDOPjjVeK7bYGKHWrtymo9yUcnomMMoA0kGMcMqKrMHmFmeo4uFEqN2WlyMieemcEH1IvIdx5FxCieS9DbwgGkTCpkSqr9rZBSAjiinauQyj0lAVoCPno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MHza94HH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE2E6C4CED1;
	Fri,  6 Dec 2024 16:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733503991;
	bh=JpS/Zt5Xq9vuGvkn4jptuxcPyo4ktemXE6eY8TMimTI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MHza94HH8zx5zpl+tyZniMpGI8BVsXN6Ue6b1SnP0Q2AeEPTMtSpePIt0PNJ7ln5e
	 Bi8fql9veu1U3/o5xq0bkxI8FinVXnn5uxim3eo/IA2y/t3LGchsLlmh7Qm2s2qrae
	 lDtyaJUupUDJ2Oxf7PNi68ZUKN5YK26EiBhd8DAxIYdWA8aBkLlkqpIppabcDR9PpU
	 eBZ++wepN8+6I3qTEUj3RCuJmHq8Rjr/De8FAfTMIew/3IrS15ou8lfHgZQ0EHeed9
	 llM9rjlFP/esIVb0Ef1TSlkYCbxvsJalbYZ/0bY5ZgOsEufHV9g6xvBhPzdJmLlhYW
	 Ni3LPwqthYfyA==
Date: Fri, 6 Dec 2024 17:53:08 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Mingwei Zheng <zmw12306@gmail.com>
Cc: fabrice.gasnier@foss.st.com, mcoquelin.stm32@gmail.com, 
	alexandre.torgue@foss.st.com, hierry.reding@gmail.com, lee@kernel.org, 
	linux-pwm@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Jiasheng Jiang <jiashengjiangcool@gmail.com>
Subject: Re: [PATCH V2] pwm: stm32-lp: Add check for clk_enable()
Message-ID: <o6rh2bcxnnubhx6xem55otgequw5zrqmkretcgofohvcpbygdw@z3qagurhjyp3>
References: <20241206012605.2877412-1-zmw12306@gmail.com>
 <cim6rnzdvhik4kdibfmglf6jiky7xccynqwazmxmnr2f5fvu3f@lvoo3drlgaua>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lvtle2mtnfezbcjm"
Content-Disposition: inline
In-Reply-To: <cim6rnzdvhik4kdibfmglf6jiky7xccynqwazmxmnr2f5fvu3f@lvoo3drlgaua>


--lvtle2mtnfezbcjm
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH V2] pwm: stm32-lp: Add check for clk_enable()
MIME-Version: 1.0

On Fri, Dec 06, 2024 at 08:12:57AM +0100, Uwe Kleine-K=F6nig wrote:
> On Thu, Dec 05, 2024 at 08:26:05PM -0500, Mingwei Zheng wrote:
> > Add check for the return value of clk_enable() to catch the potential
> > error.
> >=20
> > Fixes: e70a540b4e02 ("pwm: Add STM32 LPTimer PWM driver")
> > Signed-off-by: Mingwei Zheng <zmw12306@gmail.com>
> > Signed-off-by: Jiasheng Jiang <jiashengjiangcool@gmail.com>
>=20
> In reply to (implicit) v1 you wrote:
> > We detected this through static analysis, instead of actually hit.
>=20
> Would be nice to mention the tool that actually found it in the commit
> log.
>=20
> Otherwise I'm happy with that change now.
>=20
> Given the issue is old (the offending commit is in v4.14-rc1), I'd note
> send it as a fix before v4.14. I'd send it along however if something
> more urgent pops up.

I wasn't very attentive when I wrote that mail, what I meant was:

Given the issue is old (the offending commit is in v4.14-rc1), I'd not
send it as a fix before v6.13. I'd send it along however if something
more urgent pops up.

Best regards
Uwe



--lvtle2mtnfezbcjm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmdTK/IACgkQj4D7WH0S
/k42UAgAs6H2mPbme8oPwP5+Vo7po8iDZLSjx2VBZfboLqKgg60SSEgkWJDW3QRW
JSMgjh22hbHhuXTjBDM3281KZfebAxFyiVCUoLkFX4dxsP/HBJGb1VCovMAAIdzp
aKNyDDpyGzvbXv+rNdV8nIRLYooE0AxWuoZiQU5/54Zsg6BQOdRYOw/7NrUffYHx
Y4cuErXghldB8y6lDG86quZffAwnAp0BFuV55mixSpcV1MKiwiPWqRmr9w605/m3
e8V6BYUoh+IK/2hvFlcdl95pULgQjAtzaq+NNMQgBU3mT05sD5oOl6EAtvVbJEVd
fNXPXDr9aVWZWRuTWR8pnjJFn9t/wA==
=eYs8
-----END PGP SIGNATURE-----

--lvtle2mtnfezbcjm--

