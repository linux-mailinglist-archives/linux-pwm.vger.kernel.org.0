Return-Path: <linux-pwm+bounces-8012-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SAahOJo6e2mNCgIAu9opvQ
	(envelope-from <linux-pwm+bounces-8012-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 29 Jan 2026 11:46:50 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 70CE5AF0C0
	for <lists+linux-pwm@lfdr.de>; Thu, 29 Jan 2026 11:46:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 74115306CF6E
	for <lists+linux-pwm@lfdr.de>; Thu, 29 Jan 2026 10:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6811A2D12F3;
	Thu, 29 Jan 2026 10:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mfjD8gAY"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4595933FE36
	for <linux-pwm@vger.kernel.org>; Thu, 29 Jan 2026 10:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769683128; cv=none; b=G7Z0Ng1MlCA0MbYN28CEEqiCuCwCm3APslGeFjPwfAhNtwrWg6jlai3utDtxk3vgAAYQ7m+DUxZie88mFkpFDHO/vy5kakA5wV2+OBlutFJle+Vp5fpcfvcfYEPGo+pW/0sAWaaOC7QOrRYR64KI2sZN5ZruZfh80P1FXKoGOzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769683128; c=relaxed/simple;
	bh=o3seb3z1j3AkJd6g2aD+Oy3VLDwvDm95kkayOif+w7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lF6gCB5t1pA0rBbv6hLEBltDOtodAW11HNbF/LOgSwKKaRuGTEMxJVnHoZYBAWgNfbB9sln1+BMQKGDSVkcI2b12c9gE9X5ADYY2Qd4sNfs5C3UWuOeaxCuIGxJn9QTQ46k8bdy8gCV92fNgMEpaT5JzBWLgTSzgzAVS+EQrqIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mfjD8gAY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52841C4CEF7;
	Thu, 29 Jan 2026 10:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769683127;
	bh=o3seb3z1j3AkJd6g2aD+Oy3VLDwvDm95kkayOif+w7s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mfjD8gAYvAs71y5Z19DaUK8x+jhK8qd7CPqmUxlZpI1y/jfJLr0lqhrKAJG4opySi
	 KUKQpld1QYmKvBafvGofh4cRzBEgsV3YXs2pblUSgNqSLDB9XwaBeYjiAw415ZOxb9
	 HYB9gfd0/qpVqZCSKOLknXoaCqCYrjjJ9/VNqTh5sNnmLlvMZUQKs9gQMchYZqKMMx
	 NNgUE7yzYvTX/nfeJUiTfHiW+yEYA3fMmjviP3/M19cWB6TDiNsBUMLSb3q0SDOAZZ
	 l8viN8IL9s3rewVyxA6dHNFIOR/ZFkDmvsDQU2/JZVIGqD025ZhVQKrh2pWaKP7S5q
	 JFKkUXRRuetCg==
Date: Thu, 29 Jan 2026 11:38:45 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Linus Walleij <linusw@kernel.org>
Cc: Yu-Chun Lin <eleanor.lin@realtek.com>, linux-pwm@vger.kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, brgl@kernel.org, 
	james.tai@realtek.com, cy.huang@realtek.com, stanley_chang@realtek.com, 
	tychang@realtek.com
Subject: Re: [PATCH 5/8] dt-bindings: pinctrl: realtek: add RTD1625 pinctrl
 binding
Message-ID: <hqxvkj5iog5g6bdnwykctkc74zcynnf43zssu76xp5d5lyiz4o@tf4izpf3wapk>
References: <20260128033936.27642-1-eleanor.lin@realtek.com>
 <20260128033936.27642-6-eleanor.lin@realtek.com>
 <CAD++jL=445wx467ZKE3-qm_BaVzKYXE-7zmReTFZA0KUAaSNyw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ocmdifhjmbvi2wnl"
Content-Disposition: inline
In-Reply-To: <CAD++jL=445wx467ZKE3-qm_BaVzKYXE-7zmReTFZA0KUAaSNyw@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-8012-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ukleinek@kernel.org,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 70CE5AF0C0
X-Rspamd-Action: no action


--ocmdifhjmbvi2wnl
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH 5/8] dt-bindings: pinctrl: realtek: add RTD1625 pinctrl
 binding
MIME-Version: 1.0

Hello Linus,

On Wed, Jan 28, 2026 at 01:33:00PM +0100, Linus Walleij wrote:
> [Uwe, can you check this a bit down!]

Hmm, I'd like to see the whole patch for that, but I don't find it on
lore.kernel.org
(https://lore.kernel.org/all/CAD++jL=445wx467ZKE3-qm_BaVzKYXE-7zmReTFZA0KUAaSNyw@mail.gmail.com/#related).
Maybe the original patch is still in moderation or was killed by a spam
filter?

Best regards
Uwe

--ocmdifhjmbvi2wnl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAml7OKkACgkQj4D7WH0S
/k5rKwf/VAgLlJfGQ1Hiv0xST6vgMjY12pnbeIPJsC9+qRzzZeXt6Eq9hlMIy5r1
aG2u6FhN3oplRE2u11wZj2zpS44PNrH7JAM5Wfmc7rinRIokemEiHfQXgkOuCAho
Xxihb5yEwr/huFJQJHEmHDwR8WuZskQ9bcfOZ0kdML7i3At6OknPS/zXimYRmLJH
MsC9ZdrNpn4oesMIIgVifIZ9Xgq0y7tSkVZipEX1ESbvzMi0ELeIGR94BQLmAe/A
SaXmtY6pZlHfWEUoYvA7TmF9KoaUqhPvIfa5e677gjXh6LWqnIF9BaFmr/p6FNGf
2F55iuPgmB1ohrxMYR0b8EU9DxWYbA==
=0VDy
-----END PGP SIGNATURE-----

--ocmdifhjmbvi2wnl--

