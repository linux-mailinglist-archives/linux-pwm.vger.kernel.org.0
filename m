Return-Path: <linux-pwm+bounces-7164-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AE3CB338B7
	for <lists+linux-pwm@lfdr.de>; Mon, 25 Aug 2025 10:27:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B5053A5487
	for <lists+linux-pwm@lfdr.de>; Mon, 25 Aug 2025 08:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E7F229B8D3;
	Mon, 25 Aug 2025 08:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JKRKjMaB"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF6B27FD5A;
	Mon, 25 Aug 2025 08:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756110450; cv=none; b=MS8ryn7X7t27TbZcix3o9ieaj6vF16SuVcMxeBXi0oMDDTkcdRf00MYiqdDkExOElER9RP36COuwYbknLydfU3Vlbb7+p0Vv8EJXMYtFCW7VRDz4I0rS2qX6IcqyD/j2k+0Dv3rBcyhCNUv1PvdOId/TKT8lL8iBzSQdwRuEmwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756110450; c=relaxed/simple;
	bh=MThLF13oP8kAhHUfPkaokmWovqJkKnUrqODR2st45Es=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xnd1i16pK8WWMsPzEJKUaGwzkwsp3ZPSuMNVZiPOWRPwr/ax1Z0zx8ziLbm+Bg3GYD/7pBoVeXopPZE0p6nbBKXBl4QDegm8DD3YSbu13OI83ebDhNYn9bB4S1RBucm8T2oREvuz7kIQNsr+QIV3RhGLCjgmyo/9xr4OTiUK498=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JKRKjMaB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A9D3C4CEED;
	Mon, 25 Aug 2025 08:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756110449;
	bh=MThLF13oP8kAhHUfPkaokmWovqJkKnUrqODR2st45Es=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JKRKjMaBmlKTxG95DhC8FbKhxi/QcYemBieWq9oFAr8wpwlA/HH57gPrixGa6Gneh
	 gO3PGunR94J3ezDuSkIW+Be28rOH9fBq+jt6nJuG7w/JMQn9dI6SkymppN7P+xPOAf
	 Sy5WB4oIS6p7KQnG6SIVwscMyZCOwILPBXv3bBTL173DkqVIUNrGu+pNe3zf4fRZTs
	 jPIfCS3uot7mi8Lc3UPioNJlDJNYRo2VsSqOncw/ycd/ZnhY/hzsUmjx3pm3OjqMa3
	 TDrrWmNERcGJDrFggkJx4QGkW2XSXEr+0fq2KuwXTxZ4Dq47+93XfddYj5PkdmUJvd
	 TV3bkfY85LsvQ==
Date: Mon, 25 Aug 2025 10:27:26 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: "Rafael V. Volkmer" <rafael.v.volkmer@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v5 1/6] pwm: tiehrpwm: use GENMASK()/FIELD_PREP() for
 register fields
Message-ID: <dithxhozx4k6n6xu7qrunsxec2wrklj2fipp3r24tlunmj7zid@vgqvfjw7onld>
References: <20250822044024.4015-1-rafael.v.volkmer@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2aaouuvjthevybze"
Content-Disposition: inline
In-Reply-To: <20250822044024.4015-1-rafael.v.volkmer@gmail.com>


--2aaouuvjthevybze
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v5 1/6] pwm: tiehrpwm: use GENMASK()/FIELD_PREP() for
 register fields
MIME-Version: 1.0

Hello Rafael,

On Fri, Aug 22, 2025 at 01:40:24AM -0300, Rafael V. Volkmer wrote:
> Make register field definitions use GENMASK() and FIELD_PREP() across
> AQCTL, AQCSFRC, and TBCTL. This clarifies bit layout, reduces hand-rolled
> shift logic, and aligns the driver with common kernel patterns.
>=20
> No functional change intended.

just a meta-comment without a deeper look into this series:

There is another series touching this driver at
https://lore.kernel.org/linux-pwm/cover.1754927682.git.u.kleine-koenig@bayl=
ibre.com/
that would be great to get some testing and that I tend to apply first
given that is contains also fixes. I guess you dind't base your series
on top of that?

Best regards
Uwe

--2aaouuvjthevybze
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmisHmgACgkQj4D7WH0S
/k7roQgAppnoXvecN/8m5PR11H4UdfLVaDm2QinOqwBRHXExK23ldkQ0364yRrHr
lv+xiP+r58SWRAzOEzNvyO4Y8PctJpcQg74+0EbP9KdyhnsZbH0gnm3pYRaOKXdV
G30P059lZoMNfORxNTo1JpOrG157cArSpTLl90C+UUWXfLKo2G8GHNNLl+LcpjeM
0ukPSK8OxpUqj5B63tQNIJ6S9yYtjJ1v0g0tUr2lw17nWkezZ7kT74Kin12O7OxU
+pJsg20zqt9mq3pdydfKOY532qWRHe3ZcvqHhoy7J+QHftyGr7ctCVaS19qVkmVL
JfM6d2zicycXXtbaes7xLVTNJSkkQg==
=Ew6H
-----END PGP SIGNATURE-----

--2aaouuvjthevybze--

