Return-Path: <linux-pwm+bounces-4719-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F26EA1A6DA
	for <lists+linux-pwm@lfdr.de>; Thu, 23 Jan 2025 16:16:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67F613A276D
	for <lists+linux-pwm@lfdr.de>; Thu, 23 Jan 2025 15:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75136211293;
	Thu, 23 Jan 2025 15:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U4IYR7U/"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A9920FA9D;
	Thu, 23 Jan 2025 15:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737645361; cv=none; b=eUDT+bGdkrZQNgKzZERga6Ld5ZCY1xcN6UycghrPI9+xM2efZVAd7wkZHIKiRWK97IO3XJnLDdMXyxDnj8iEbzPXzo9r2gp6c9pcZoKlj0zm60Ji4VybSsDZQm7kOEY5O6d2QG7pNf/Qs3H/l8D9mMPKs5Ojmtpmq4pfBbOECDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737645361; c=relaxed/simple;
	bh=hO/M+SZqqgKYIoTGLg+jgxAyd+xAFmjSZk4ZQKtWISQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LKSTwu/LxWMR6J4E+l0r4/CjThC1u+UqaR9gpPdevo0EhEn43wvfLglMtKXcuC96ftOlJY++bQr21dDG+zuU8j4yfVA/9rO5a7GQcsabsbiKHPuOya4r8te9hfWnlBUs1Lm8wq7MCpv3op8f3JY2P3ERHpFEQ0gyguZ5xmlCzN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U4IYR7U/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39CC1C4CED3;
	Thu, 23 Jan 2025 15:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737645360;
	bh=hO/M+SZqqgKYIoTGLg+jgxAyd+xAFmjSZk4ZQKtWISQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U4IYR7U/zgYenZLCTxVYUZ3IMKNHciTZEPhw4L/gNt+aTAUX04QIojTIda7KH1+hY
	 Sp+56BCI5LQ8bi6nBG1hveC3p5Jl5DvuOneHLPIgcsfE/ql3NzBYapPNnU/44uJNdC
	 FOCkijyLN2WihEL62h5H+3aX3C3EUZhEe9vIePY7MGVW1Uc2jid3faEOiGioGHvP8V
	 Bn1oj6iI/v+Telmp7f5Ib0jPR82NQDDwmw9WIpq5IFNCWKGd/URhKSiMhmEKkoKTLP
	 DKB0KsxrRiHreHUhz+fsF/p1T6EGJc3TYbondNiqH6PSho4Gg5jShjIBbR8RYZWil1
	 22msgHVBZXyOw==
Date: Thu, 23 Jan 2025 16:15:57 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: linux-pwm@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>, 
	stable@vger.kernel.org, Daire McNamara <daire.mcnamara@microchip.com>, 
	Thierry Reding <thierry.reding@gmail.com>, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] pwm: microchip-core: fix incorrect comparison with
 max period
Message-ID: <r3dybh3ef4lbneruiae4s5co6mkgsowwucba6niqv23tfycyza@qnklz4w5rnnr>
References: <20250122-pastor-fancied-0b993da2d2d2@spud>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="a56xps3gn2qlgwig"
Content-Disposition: inline
In-Reply-To: <20250122-pastor-fancied-0b993da2d2d2@spud>


--a56xps3gn2qlgwig
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1] pwm: microchip-core: fix incorrect comparison with
 max period
MIME-Version: 1.0

Hello Conor,

On Wed, Jan 22, 2025 at 02:42:56PM +0000, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
>=20
> In mchp_core_pwm_apply_locked(), if hw_period_steps is equal to its max,
> an error is reported and .apply fails. The max value is actually a
> permitted value however, and so this check can fail where multiple
> channels are enabled.
>=20
> For example, the first channel to be configured requests a period that
> sets hw_period_steps to the maximum value, and when a second channel
> is enabled the driver reads hw_period_steps back from the hardware and
> finds it to be the maximum possible value, triggering the warning on a
> permitted value. The value to be avoided is 255 (PERIOD_STEPS_MAX + 1),
> as that will produce undesired behaviour, so test for greater than,
> rather than equal to.
>=20
> Fixes: 2bf7ecf7b4ff ("pwm: add microchip soft ip corePWM driver")
> CC: stable@vger.kernel.org
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>

Applied to

	https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/fix=
es

which I intend to send to Linus next week.

Best regards
Uwe

--a56xps3gn2qlgwig
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmeSXSsACgkQj4D7WH0S
/k7MxAf9H63osdnsvlMLvftXzklq8mHrUZ0AzQydxMcDuwrFSkDpOV0V4fgOM2Op
tQHZ7fLR74Hj2XUZpFgMTeZ8ZgsEI6ri9EcDzMQFGZTDV2qbkic2+6B9EOIwaWaX
E5Vyri0ZoI89mm1hfPIO3Qwe+ApftvMnsAJtgsImP0JX/r0ZxAmFk+5wuBqcakR4
bJ/kzTmuBdAdypT+yNzf8KpMtmRzdSQKKJd2qM0yE05/HMlgsjqzSmWJkwPI6H5V
CmxmkAs1y82xZ8jaOSBwFxDNiHj5glGOb0xY/gKf3CWAEr3s6YiA3kdlDV0q6o2P
Iv0/ROtuw/PVnWvoyweffxJYh22Cdw==
=fEw6
-----END PGP SIGNATURE-----

--a56xps3gn2qlgwig--

