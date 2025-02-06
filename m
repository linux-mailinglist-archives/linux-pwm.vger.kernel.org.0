Return-Path: <linux-pwm+bounces-4801-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D25C1A2A7DB
	for <lists+linux-pwm@lfdr.de>; Thu,  6 Feb 2025 12:46:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F9707A3766
	for <lists+linux-pwm@lfdr.de>; Thu,  6 Feb 2025 11:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E0BB227596;
	Thu,  6 Feb 2025 11:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cwvBZ9eX"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA46214209;
	Thu,  6 Feb 2025 11:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738842338; cv=none; b=Gn3388UbOu9/kFxSbtkHMxgu31wyRq538qrfOWFMITFabTUnd0G9W5lQUPfEj7dUkFTyQl/hVrRr6z+bMYXqXf+DT0zBnbv5YLKQGKDptvfPe051otmKFuMHaujHkAsi5sE91VGOCZpLUFpn5aafdldS7IfF2sGhVhiqWb67csI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738842338; c=relaxed/simple;
	bh=4WMwn/PouydQAcfdYq9D0Bi/1e6v3nBuTp8T6kN0Uu4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bDWsRkKCvidr0F/wQR9haESztq6Ol54TpSUZ3obBXa6VSjEqQpdQe+UJn1scB2oM21zkeFgqXlIH+66N/hGOSDaAZQnyw1y6clVz5R3SEiWYRCzKe0wzZOtt4whBfg49nSDjEXDkjmtjzwr7bWLLINxY6ozrywdN6eQ6qRiAYVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cwvBZ9eX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F16AC4CEDD;
	Thu,  6 Feb 2025 11:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738842337;
	bh=4WMwn/PouydQAcfdYq9D0Bi/1e6v3nBuTp8T6kN0Uu4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cwvBZ9eX0/ic+Nq0scUr4+6X6SJ7CrmDohJF2qj4EzPjAC+f9g55SJWQU9DJcAO8N
	 /pQmWPklWXtSshhzo3VtFXvurX+l0sRlsYcd+vhU4FwasVJtIDu374GLrlOS5TwyKo
	 SNUsGX3vSckA0a48CbvDoC99bq7vIVvDfczVy+GwfofpdTwAjxxTmzDxSgU44d4cyg
	 eeF4Dzi3bZQMYQUOPizexOYBDDk+s5hYG+Wrw3hkW7AoODIA5Zt1OVjpN2gP7aZBDN
	 knmgwLvqmbsLITWu9nGxMpqKpqIklXWwg5iDesNlPSHTP/uGyrPh84lLr0XNWYPiny
	 taJUbz74MXeUw==
Date: Thu, 6 Feb 2025 12:45:34 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Ben Zong-You Xie <ben717@andestech.com>
Cc: krzk@kernel.org, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
Subject: Re: [v3 2/2] pwm: atcpit100: add Andes PWM driver support
Message-ID: <pfqsycjocrlfsxmty7lm44niuv4723n74hyofpmvuvpandat5v@tvnahmf6zg7m>
References: <20250123193534.874256-1-ben717@andestech.com>
 <20250123193534.874256-3-ben717@andestech.com>
 <5514fa03-139e-456e-b522-6a774b52eac1@kernel.org>
 <Z6RuGrszOiPFWHyU@atctrx.andestech.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="n7l7m4k6emmmi2kp"
Content-Disposition: inline
In-Reply-To: <Z6RuGrszOiPFWHyU@atctrx.andestech.com>


--n7l7m4k6emmmi2kp
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [v3 2/2] pwm: atcpit100: add Andes PWM driver support
MIME-Version: 1.0

Hello Ben,

On Thu, Feb 06, 2025 at 04:08:58PM +0800, Ben Zong-You Xie wrote:
> Also, I will remove "depends on RISCV" [...]

Krzysztof didn't say so explicitly, but I think he wanted the dependency
to be more restrictive, not less. At least that would be my concern
here.

The rational is: Don't annoy people who work on ARM or x86 with
questions about this driver that they don't need anyhow. If there is no
stricter dependency possible, I'm happy with

	depends on RISCV || COMPILE_TEST

. If however your driver is implemented in an FPGA, adding a dependency
on a set of SoCs that have the known FPGA that provides that device
would be a good idea.

Best regards
Uwe

--n7l7m4k6emmmi2kp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmekoNwACgkQj4D7WH0S
/k7/6gf9GqpAf+X8w6dCTLYj95mwQmBNhDGgBmjC9LHusgBKYdlIxNYMJglMJlMa
SJCHwBx9G5T20HNhMZHifnQRBjvwBNLPV0cb9ZKM9ycFX5/ZPrJWj/DhI/XkOJwR
J7rnvJIQ5Y8FGMArf0FTdvrxYJvXdHEwC9GlIkvIxTxPsnQrxCkssxwS4SZFVZlO
sjP3AD2QsvrcTJZlCWzsf+sNLccHBbzszhk+XdOVpZg6l8SpFeff6no691nDhyl7
XlW1F17XE3tJBQq0glwDO7YRNtoIGvALvNph8GtwMd7osugBdQa9U97RFbGOkkpm
DydBvmPjP36Xr0og409Bl+UuuJMB9Q==
=OOxv
-----END PGP SIGNATURE-----

--n7l7m4k6emmmi2kp--

