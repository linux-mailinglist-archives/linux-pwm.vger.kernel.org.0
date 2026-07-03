Return-Path: <linux-pwm+bounces-9549-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id AcwXB/UnSGr0mwAAu9opvQ
	(envelope-from <linux-pwm+bounces-9549-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 03 Jul 2026 23:21:57 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 593B2705B83
	for <lists+linux-pwm@lfdr.de>; Fri, 03 Jul 2026 23:21:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=dgB949gc;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9549-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9549-lists+linux-pwm=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4872C303799F
	for <lists+linux-pwm@lfdr.de>; Fri,  3 Jul 2026 21:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AC3634751E;
	Fri,  3 Jul 2026 21:21:15 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D3A349B0A;
	Fri,  3 Jul 2026 21:21:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783113675; cv=none; b=PdAP5v1kJDgatEMqoVQsjqGdxzIWEu4rj82nadEwjes8pYdHryebhcAob7/FqboiFeGtZTunlndjONHZCW7ZWrz6NO8a7/bvXGzsQotiWAbWIkQ5LlZSeFhKHddi+BeGFJs67aflw2dH0gSF//GGev34T5oVK46fiFtkGQxq6VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783113675; c=relaxed/simple;
	bh=LPhuVwz6mITfxSfO4u0zB50yB7mhelUpTEmHeN4Z6TU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bLZy/hqfGCnEYvNoA9uvPZ028Hv7Cnr4fxPt7kqAyBvzGcbdzA6H2POCXhSZtMgCsLhlNad+ib8YImHCJ/elnIt2Dz7R/Q7BWwF9dLsTJo4eou4OpEQ91ZzPMsBrhnLgIHy4Whrh4jEilbACdmwfmBYV/yQdydtLKZbE8xEx9xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dgB949gc; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 0D5F01F000E9;
	Fri,  3 Jul 2026 21:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783113673;
	bh=LPhuVwz6mITfxSfO4u0zB50yB7mhelUpTEmHeN4Z6TU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dgB949gcS8uPvxiZO0FNv2oIa/6xscvHAHzUVo7FE+7W57AYHQn/u0xMEbqOg0APv
	 PjF7oL97Tc3Px5TwBJflQIAebY2GAg91dnRR3TuGxOSprLGcQessxSktUb5RDyrruC
	 nbEz6CLABNaEX5tBAViPPCiZdLpjeafmDYsPYMBEIKfRNW1W+Yw1T4zExHhVSGAkW7
	 AvUpvU5Qj6GA9eszz/X5Lj1p1O9qCUAU4ILeofLwFrl2JeQiOX2k3WeFxfC4BTbdo4
	 prqLV9FgJS/a+OGmKrUgbG0XVSxejbzxoVVdWIqQOAuWp9BSYHZrrVBshWKqXJVxNn
	 +xtfBu3ErbfEg==
Date: Fri, 3 Jul 2026 23:21:10 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: linux-pwm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pwm: mc33xs2410: Initialize spi_device_id arrays using
 member names
Message-ID: <akgndtvHVIBJ1549@monoceros>
References: <3fc7783506cc6429b8942cb7294926a6d4cb353e.1781885606.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yuek2e5cck6qqu2b"
Content-Disposition: inline
In-Reply-To: <3fc7783506cc6429b8942cb7294926a6d4cb353e.1781885606.git.u.kleine-koenig@baylibre.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.76 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9549-lists,linux-pwm=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[ukleinek@kernel.org,linux-pwm@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_RECIPIENTS(0.00)[m:linux-pwm@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ukleinek@kernel.org,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,monoceros:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,baylibre.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 593B2705B83


--yuek2e5cck6qqu2b
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] pwm: mc33xs2410: Initialize spi_device_id arrays using
 member names
MIME-Version: 1.0

On Fri, Jun 19, 2026 at 06:14:10PM +0200, Uwe Kleine-K=F6nig (The Capable H=
ub) wrote:
> While being less compact, using named initializers allows to more easily
> see which members of the structs are assigned which value without having
> to lookup the declaration of the struct. And it's also more robust
> against changes to the struct definition.
>=20
> The mentioned robustness is relevant for a planned change to struct
> spi_device_id that replaces .driver_data by an anonymous union.
>=20
> This patch doesn't modify the compiled array, only its representation
> in source form benefits.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig (The Capable Hub) <u.kleine-koenig@bayl=
ibre.com>

Applied to

https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for-=
next

Best regards
Uwe

--yuek2e5cck6qqu2b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmpIJ8IACgkQj4D7WH0S
/k6c6Qf8CiX7Jd7IWInoHGLm8GD2JOerntfYVyoc3HGMd5J8Qrm3+1i8BVuN/0iL
9AxPxQcHODrr3EZDlG1w8qqD7n8tAeqNU6CT5ig2Xn6Xzt4KOMD0gePFLg0KQ4l8
n6xIbFddIb72iqtx5dX2EdlY/S0us59azVDDUd5bY8xvAsGwNuE4jtgWLLkNjv/R
hWwWiI5ARluQDMarsye8agxlfpFdVXlRBYzmr4XQKVa5ZoZOZFUdUn3rjJFSQyTq
+QxXfY+dEmkQ+kewYckPLS9jr+MXO7irOVnjETmotq3mcA2GpGxlcGRw5vCTA/Jn
LJRIn/MpWFppRdwEM2rR9CpQPFwTLw==
=O/DY
-----END PGP SIGNATURE-----

--yuek2e5cck6qqu2b--

