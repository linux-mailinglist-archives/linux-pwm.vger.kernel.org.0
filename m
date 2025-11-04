Return-Path: <linux-pwm+bounces-7589-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1F1FC30B35
	for <lists+linux-pwm@lfdr.de>; Tue, 04 Nov 2025 12:19:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBB4C188D54A
	for <lists+linux-pwm@lfdr.de>; Tue,  4 Nov 2025 11:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A79082D73A6;
	Tue,  4 Nov 2025 11:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ODIrewYx"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0F82BE631;
	Tue,  4 Nov 2025 11:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762255100; cv=none; b=CUHRt0VuMfk200TdMueHB3nzZsIlCSku3DIkY04baAx3BFBXkmmA+35XNImZy9McjzI2z0dRjZiCTS9pT6oRD8ErooB+gBpZLq6S87VMNqWLFz8DwY7FIENez5PWouXrBxyg038x9XtUP2n79K6CgvZ8sfC30GfRHf4EuhKUOhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762255100; c=relaxed/simple;
	bh=fj2SbyxXmiKjzW12lEreh+2amPcsYkSH41R8tYD90kA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pxTi9oGLkiBcBiHVmaysa51pcNwh0agEC+j8RXjw0qjJx81BTJaLiV4FQFzQIaQuHMvAfpBgVDd856oD4nYsluOrsMtFt5rc/fPGgcPcNvNB/IiBOzXsPp0vgRKR6RS4QOt0GwmCRZdGkYMaecjaZpX8B9BojaiH61q889Kcn+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ODIrewYx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B317C116D0;
	Tue,  4 Nov 2025 11:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762255099;
	bh=fj2SbyxXmiKjzW12lEreh+2amPcsYkSH41R8tYD90kA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ODIrewYxNyso5c2rt/VaDZXqgu/poQAMspD22EfeDrIJbVyn4oYhMRhMiLZ3qAgQM
	 646/Ez+EWV9QVIhoNBw2pROpZDEOiCXfsf1Lw9CMtAdzROmReaKwBQitI8cITstrBR
	 R2YkRwgMMe/di/6klhrmqWO8JOxOKDx8Y00TCmnERpBx2G4GCyXGA3TgsPV3CRKlRS
	 Xn54IYZ1CudQXLGmYh9j0tPVxXQOVFvgz+dc15piV3SyStL/Hca+G7MDF2oRq2Xrx6
	 qUw7DKCEB/AzoBgG6M/YY08dYwEZl+S28yzseIKCiFYiI0Jc/6O5VSUSNH9YVBneL6
	 bF2yNORuo+3FQ==
Date: Tue, 4 Nov 2025 12:18:17 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Chen Ni <nichen@iscas.ac.cn>
Cc: matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com, 
	linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] pwm: mediatek: Remove unneeded semicolon
Message-ID: <3sgj7ykavhum3svp657khyp3udqrov7nuzvuaaneu6fo7wlxys@uyhlvrl7lnqi>
References: <20251105214847.1279520-1-nichen@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fc7lriu56xblnb2a"
Content-Disposition: inline
In-Reply-To: <20251105214847.1279520-1-nichen@iscas.ac.cn>


--fc7lriu56xblnb2a
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] pwm: mediatek: Remove unneeded semicolon
MIME-Version: 1.0

Hello,

On Thu, Nov 06, 2025 at 05:48:47AM +0800, Chen Ni wrote:
> Remove unnecessary semicolons reported by Coccinelle/coccicheck and the
> semantic patch at scripts/coccinelle/misc/semicolon.cocci.
>=20
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>

Applied to
https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for-=
next
=2E I added a reference to the commit that introduced it and fixed the
author date assuming you're not living in the future :-)

Best regards
Uwe

--fc7lriu56xblnb2a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmkJ4PYACgkQj4D7WH0S
/k4PGQf/cEvFbnM8Pdp7I6Y6+Z2EVEtr1DR5c1dnmi1a4/Nk1P8D8V364eyXb7WH
vmf+iI01U7XBfybzS49Z5EpJyXixcffYr83siyshJK2YADFKV5APYMlQ9w1uiC1k
pIA2gMyqGxk6BkgaEyotHKdgX/JTByR9nP2ks4i736D/+8Exu4LA8WHjHc8yd/ht
C5Zmqe1HnBB7MKlWw4SwvXvXdpU+cYY7pztBsaP8dMdN/dGBc5aafbWvL2YCdQjX
CeEIyGQ14pUWk+bm8gup5I975XOrYmaIdnGEPmNxC3/1M1xyxfop+LbZ16QsrN9U
qd6i5iUddF4Fva29kBrfvHMuVDgsFg==
=XArI
-----END PGP SIGNATURE-----

--fc7lriu56xblnb2a--

