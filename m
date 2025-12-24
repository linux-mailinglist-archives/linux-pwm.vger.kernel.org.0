Return-Path: <linux-pwm+bounces-7825-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 47EF2CDB739
	for <lists+linux-pwm@lfdr.de>; Wed, 24 Dec 2025 07:08:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3CE2F30080C0
	for <lists+linux-pwm@lfdr.de>; Wed, 24 Dec 2025 06:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 592D22C0F76;
	Wed, 24 Dec 2025 06:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U4VldoX9"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317FE21B195
	for <linux-pwm@vger.kernel.org>; Wed, 24 Dec 2025 06:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766556503; cv=none; b=q+xcJDKk2vazH2RPfLGeQYQ8sDE9KCJrCq/cwl+gCsJAo77LQ8PZ4MErwspOSDTqa+GD1hieoXt2IIpyffm6zRd/NQoBP2+IkXutgc9SnNttmohKEprGxwMYrb5FivdZR+6/2LvQjilrnNS2Uau+nmgDGSLD/GmRCJLnCc5Q28I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766556503; c=relaxed/simple;
	bh=JH7yUvlHQDGqNLxdaPjzVelCIJF6UKoq/31b9kvkkp0=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sicx8Svroumzp5I1SxvGWMMK7+//pGXV1ti6orWxOEiN8irKBRVU561dF/ayVKu7C+oFHYwfxXw1AGrN6VA4kp+zRvabdEYd/LsT9fSLK7U8zO0Uy3UwaB/fPpIIsc6EjbOWjGTi/TLpmtBDdxFkoxo50c3TD1uc70QeV6JYunI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U4VldoX9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48684C4CEFB
	for <linux-pwm@vger.kernel.org>; Wed, 24 Dec 2025 06:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766556502;
	bh=JH7yUvlHQDGqNLxdaPjzVelCIJF6UKoq/31b9kvkkp0=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=U4VldoX9zZ07XcuQZuDVZx3QTTpm0nb/vpwDBkQGofGKfCVUwvhl6Pff3s1/OQ7r0
	 IeiSv3slnvnJhvxW5U9jCsWpJ94d1jMPAl97+JHmNWdnaoifO8ImWO3XzGKt46+VQc
	 gHUA5423KeM8Ef/zFwSLZHQAMaCoa864VHcvGrAUkSOAn75fCWJ99dRuyDDASJE1Ht
	 XI3kWlJZ2B/76AfieD9O3ma9wFYKC6g3LhfpsXMv7g4CQl8BnaWPmZZG4KJCfqyoAb
	 OubqxbiQho9NS6J8VUVSocLEKKgIwitPFJC4SGHXyeYKxvcao1/7o8OFS6/X956iQ/
	 ed74yR33T1plQ==
Date: Wed, 24 Dec 2025 07:08:13 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: linux-pwm@vger.kernel.org
Subject: Re: [PATCH] pwm: Emit native configuration in /sys/kernel/debug/pwm
Message-ID: <qk5bfhqiqioyzfxdppjp2747homa3x2f3zg62c5454glkby67d@jzziufh7irfq>
References: <20251121104947.2652013-2-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fxsyzcwiu3yl3tsn"
Content-Disposition: inline
In-Reply-To: <20251121104947.2652013-2-u.kleine-koenig@baylibre.com>


--fxsyzcwiu3yl3tsn
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] pwm: Emit native configuration in /sys/kernel/debug/pwm
MIME-Version: 1.0

Hello,

On Fri, Nov 21, 2025 at 11:49:48AM +0100, Uwe Kleine-K=F6nig wrote:
> Currently there are two abstractions for PWM drivers. Use the waveform
> representation for the drivers that support it as this is more
> expressive and so tells more about the actual hardware state.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>

Applied to
https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for-=
next
=2E

Best regards
Uwe

--fxsyzcwiu3yl3tsn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmlLg0oACgkQj4D7WH0S
/k6UXwf9HzyulatHrS2AXhYi0ABufw8m5p61/CqkClMJikYq+7keHWOIMRdllIiW
VHK4VN00QMW88MhRwErWzmIzC5VneN7aKeDXb9cJZ8gcH7cAGgsyWHDpN36R0fwS
vWTZPH8dFB8LnZawvNeroK7gq4ZQc2Mbv5QNrGKNFvbT/PmtI5HFoEas80CpOLWO
CeC8K8morMcAiY98JPod/kcyJ3S/fx4uG7uoenT/3SiMgkqUgq8r4LOrOjxnsm7z
QIZtut+pbmFwrpYunagRAo2fDQonMFo2bXKqwugAw4Z32n7h4r+Ut5fGz2uhgh9g
TLS9PaXJ1RVGpOkQ1Bf4Q4wLxHLfwg==
=7FHx
-----END PGP SIGNATURE-----

--fxsyzcwiu3yl3tsn--

