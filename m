Return-Path: <linux-pwm+bounces-6629-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 833C0AEF358
	for <lists+linux-pwm@lfdr.de>; Tue,  1 Jul 2025 11:30:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E275F7ACB78
	for <lists+linux-pwm@lfdr.de>; Tue,  1 Jul 2025 09:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3CDD26E70A;
	Tue,  1 Jul 2025 09:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IebRQs2S"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7131F26E6E4;
	Tue,  1 Jul 2025 09:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751362203; cv=none; b=Q8v7rkaesQ96qTu/KbD7MfnCzgtVDgY2pKc95kugpucGO3Fdlvj7nAhn/dR5U/dD/P6gDKnCL7zCi0h+pfVWlZ8g8Cr/EffprNcxM1X6ygA76uJmgUtbUfkuVMK3Q1v0fctwlRd5WJKsqssMz0rgvzzE+A+0TUTg92UzDhJQZlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751362203; c=relaxed/simple;
	bh=kZOKyNs4Db2MnERH7f8zaFtDju4I4ipaWRZu+43uIXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=spA3dJXJ7BPjon1F+IHB2G6F6lqjIzFseAn69U5GnTfmNwofRYJ9wdOX0TDCnQgU/be7OEt9BJcplJ+HWYZIg4WHEJCuuGVVaeS2p24NlKjtX9tpf0ANcQqth65ZS0Wm1CfwUi+oWtwaMqWvWZsgfVq9qb3QUfEm2ONbI5uYtOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IebRQs2S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CAB3C4CEEF;
	Tue,  1 Jul 2025 09:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751362203;
	bh=kZOKyNs4Db2MnERH7f8zaFtDju4I4ipaWRZu+43uIXo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IebRQs2S4Zck295c+TBqK/iU11rhK4zM9iH6It/WDDjTnkzRJDFRMga9rMofy3OYK
	 W41pvCTEWF+AzUxh9eofQQnHdlHTwJg4iJA8ZKA0nN9/4jeP4TnRJIoMisw1r+ibuV
	 p/RqM8cqTIwciKsQL54FaElEidEarmMz4MI9EmDr/qqOnhPZldCjGCO6AZrImtIAng
	 e0tMkAozmrb6xpFrg9PHBXr+69xBZtAdSzlNLAWZD/41I9O+pEr0bO5e/LJ8QVkQmJ
	 QBizlS8OEB4eVW6CgnbR1yjIk1x2mjXNtuE+18MWZoBMFlPOOaJhPX3QwfqTDNgjIw
	 252/ta9q3QqvA==
Date: Tue, 1 Jul 2025 11:30:00 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Vladimir Zapolskiy <vz@mleia.com>, Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>, 
	"open list:PWM SUBSYSTEM" <linux-pwm@vger.kernel.org>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, 
	"moderated list:ARM/LPC32XX SOC SUPPORT" <linux-arm-kernel@lists.infradead.org>, open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH v2 1/1] dt-bindings: pwm: convert lpc32xx-pwm.txt to yaml
 format
Message-ID: <3jtfwyrga5p6wucp6phzcizolnbgqexskelcolrapoepearqpd@3hws66swq2ya>
References: <20250625161909.2541315-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ffz725mp2gxeplek"
Content-Disposition: inline
In-Reply-To: <20250625161909.2541315-1-Frank.Li@nxp.com>


--ffz725mp2gxeplek
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 1/1] dt-bindings: pwm: convert lpc32xx-pwm.txt to yaml
 format
MIME-Version: 1.0

Hello Frank,

On Wed, Jun 25, 2025 at 12:19:08PM -0400, Frank Li wrote:
> Convert pc32xx-pwm.txt to yaml format.
>=20
> Additional changes:
> - add ref to pwm.yaml
> - add clocks
> - restrict #pwm-cells to 3
>=20
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> change in v2
> - allow clocks, there are not clocks for nxp,lpc3220-motor-pwm, so not put
> into required.

Applied to
https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for-=
next
with the R-b tags for Rob and Vladimir.

Thanks
Uwe

--ffz725mp2gxeplek
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmhjqpUACgkQj4D7WH0S
/k7cZwgAjSlcgslaZQCd4n6XMk369t4QHQX44Dpo46C4+913tMXa3IOAm2bpUVVW
CXwEF8h0/i0Yyv6icPkv9SCdERBN/dz7xTHB7dhJvtUj2aWSUlS5lEcACWSuq8P1
DO9U3tDD33LGOVYYV+crDYqpfbUi+6Z3jhLPhYNWY+Zfq2Q+i/XuRtGhx0f7708g
loG8RYpKnT7Ux2rNhfD73lgNkzyFEbTT9E8HA7HEdXez4ENrVOxnPnAuvRxEnaRH
ZEhA8RLY4N+lfL5eE+7TPrgg2qNbRR/iSR11AqoFyWy2WbiXk2eopw23IAcAJtKb
rzZ8jbkiyf/7BqQ2G9DIUxT7pgkcmQ==
=/nBM
-----END PGP SIGNATURE-----

--ffz725mp2gxeplek--

