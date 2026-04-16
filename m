Return-Path: <linux-pwm+bounces-8622-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wHLsISUA4Wk7oQAAu9opvQ
	(envelope-from <linux-pwm+bounces-8622-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 16 Apr 2026 17:28:37 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB5F410C47
	for <lists+linux-pwm@lfdr.de>; Thu, 16 Apr 2026 17:28:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 23E42301BA6D
	for <lists+linux-pwm@lfdr.de>; Thu, 16 Apr 2026 15:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F05D3DFC86;
	Thu, 16 Apr 2026 15:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HmgbCebd"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B14782866;
	Thu, 16 Apr 2026 15:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776353295; cv=none; b=t1jmp1U0J8ByG60/cnsJ2alVFO2bF0L63UllZtzVppvhKnrzkJf08apfK7jNRRG8I29M0x/mTRB+qOGsy0RKsNi0ZG5WNo/GaQp7eugOYfK/imtgE/qzWVsbX/qxGVaGz1n0v0rLmofuMdjCADedSzRv75UqH37oMS+PEGB2tyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776353295; c=relaxed/simple;
	bh=4WZaxG1fEkAWFHy6pQUBEmVvWmVwiU42yXOGl7cFeSk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gsm65mixF/+JNAMMtBXNTBGjgmx5cL0WSd7ujVt5EFYkp3wnrfnngIUBLaIPOa9Y6SGxMR0581IvpBSfgKt1m0BLhiEr5/6kSQt0g6nGe3lBwrNfVWa6nxaIb7FHju4Ka0d6O3pI7Yw522aJQ314Y5BGfhnQMGPZddudXF3TiXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HmgbCebd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B4E4C2BCAF;
	Thu, 16 Apr 2026 15:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776353294;
	bh=4WZaxG1fEkAWFHy6pQUBEmVvWmVwiU42yXOGl7cFeSk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HmgbCebd2RitIoCeB7ERlNcoigI2gcNXIffpcWBwxmLR/49fdBOVNJt43biViZruQ
	 SUxGBh7k0G0+wUXdh9iAWP2GMgN6StMoLwDDS5LGh5Br1Cnwm33Q/GStVLVjEZOIlQ
	 w4hkE+GR/0jbKoJ4US5vFm4g4MEeg+Xs6V5PrgCcI/qnLLqTpeTaFSF5XPdoBUlHQ2
	 OjpamUayO88WsFM/TR5a+osY+4ti1WMJ2OCRkJZrcPFP9f4h0m23q9sY1PQ1TMJ4kC
	 cgEcCgwOlRGZnDk/Yrr1KZlHj28bd1M2LC6/jqPfz6Y+HbJ6veLochyGSMDRZYe4RG
	 lXhGLPSAhcYRw==
Date: Thu, 16 Apr 2026 17:28:12 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
	Richard Genoud <richard.genoud@bootlin.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Paul Kocialkowski <paulk@sys-base.io>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	John Stultz <jstultz@google.com>, Joao Schim <joao@schimsalabim.eu>, bigunclemax@gmail.com, 
	linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 4/4] MAINTAINERS: Add entry on Allwinner sun8i/H616
 PWM driver
Message-ID: <aeD-BA95CGZ9lWLv@monoceros>
References: <20260416131419.3152419-1-richard.genoud@bootlin.com>
 <20260416131419.3152419-5-richard.genoud@bootlin.com>
 <e9904440-b08d-4f9d-8d66-121633289695@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fqfb3daydof4iavs"
Content-Disposition: inline
In-Reply-To: <e9904440-b08d-4f9d-8d66-121633289695@kernel.org>
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8622-lists,linux-pwm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,sholland.org,pengutronix.de,sys-base.io,bootlin.com,google.com,schimsalabim.eu,vger.kernel.org,lists.infradead.org,lists.linux.dev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ukleinek@kernel.org,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4CB5F410C47
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--fqfb3daydof4iavs
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v5 4/4] MAINTAINERS: Add entry on Allwinner sun8i/H616
 PWM driver
MIME-Version: 1.0

Hello,

On Thu, Apr 16, 2026 at 03:23:49PM +0200, Krzysztof Kozlowski wrote:
> On 16/04/2026 15:14, Richard Genoud wrote:
> > Add myself as maintainer of Allwinner SUN8I PWM driver.
> >=20
> > Tested-by: John Stultz <jstultz@google.com>
>=20
> Please drop or help me understand how one can test maintainers change?
> Build process tools are not testing.

For me that is fine. This is the only way we have to record that John
tested the series. Also if I applied the original series I would have
let b4 add it to all patches in reply to a "tested-by" send in reply to
the cover letter.

My feedback here would be more: Don't send a new revision for such
comments within 30 min, also not for

> And you have commit msg trailing junk.

=2E Maintainers differ, but if this is the only concern and the series is
fine otherwise, I'd just fix that when applying. (But I think the "don't
send a new iteration on the same day" is more universal, also for more
fundamental feedback.) There is no need to bother all subscribers of 5
mailing lists with a new thread in such quick sequence.

Best regards
Uwe

--fqfb3daydof4iavs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmnhAAIACgkQj4D7WH0S
/k6omQf/fppjti0PwQfUvki6ep25HnMUxzrIDQixXrcONd4YKG2bL+/sxUnYrLwY
ukm9qWvvJw9leMaHqxnuRqIHxgTB0tKN0R364W6nr9xyBHfbXER9NK25QzUB4USM
W8+vyaRHiUXAiahSIN59lgCVGsJW54KtAIrLsNFS0Z1ce6pF6ArOsMPEhE4kPGHd
GADqRwF1yFAZrshePxLacCVXaGLm31vyApgbxlfPAWdKJkedr4QkSehLup7d0Bwz
AvW4lFK0BziW4LQv3p7l9ad/5BnaXSEdAIxbnqLzt0HRJmKBwBNBgY9+BlEMsTOP
S8f8Grt1iBVpX1llaBvN2D7db1Ipng==
=55Kz
-----END PGP SIGNATURE-----

--fqfb3daydof4iavs--

