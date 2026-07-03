Return-Path: <linux-pwm+bounces-9550-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qpGLIa4rSGpFnQAAu9opvQ
	(envelope-from <linux-pwm+bounces-9550-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 03 Jul 2026 23:37:50 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EEF8D705EBB
	for <lists+linux-pwm@lfdr.de>; Fri, 03 Jul 2026 23:37:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=j28NUzn8;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9550-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9550-lists+linux-pwm=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4BD9831785A5
	for <lists+linux-pwm@lfdr.de>; Fri,  3 Jul 2026 21:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE17C36998C;
	Fri,  3 Jul 2026 21:28:34 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90547367B6F;
	Fri,  3 Jul 2026 21:28:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783114114; cv=none; b=reLQbIt4/eH6ISLMJVljZfVyxNfSYqvx7myQom0jDsCigUiiMkQwP7ga0LAvPFER9MLak0QbNJkIF/Q7KAdaiF1WfGPag7518DL0I/9zHj+0UWfLubNuKa0G0m/IpCgxbqAMBN4uMNKfN3SHHIBDCg5tpncP1F420TvGCm+R16A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783114114; c=relaxed/simple;
	bh=RuTC3mNSYKGmnhJjG2Zp2sDRf6wakXblt2A6yEH4/TA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LPA4u99IRFI6ijjK87FvfKVdAyfCbWo5BjWxgs20CJcYhgBNYUfLGkCCJfbgdDTXoG3BdC+LwnqdnQ6SIlCshZUHm1C0qRsvz+Jz9jfJVNEbbZ0MbEanf4nq8mo/PTRGiWhA1ICFRiZrSDHWeUxZJM9ImBK35oiEBqnhzBWQ62w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j28NUzn8; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 9F16D1F000E9;
	Fri,  3 Jul 2026 21:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783114113;
	bh=RuTC3mNSYKGmnhJjG2Zp2sDRf6wakXblt2A6yEH4/TA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=j28NUzn80G9T70umEMpoP2e/A6AakmpQN0QB0ImFbgMCHLCkhbmzDhQgbLX8r2lTW
	 8M3uItjP/yRK9IV1dfJdQBMUl7gAXY3G74JoINSW/FJ2K0YeU9jdFOoZrrYfEjXJX9
	 SS2LzprSdbFe588SIM2tVJbHXGNL5v/4RQc1SYkJWL5jyrfANx5C8xLCA0w3erKPoy
	 tusDTanrFn7PUPXeA+rHS/5gy9HVmfjvIdOKDG1m2ZM/E2nDynqHlQeejpoksp5ipS
	 mFxr00M5S5unFI0BkhKLwy2lHtuH8HP8L3EXhwf/ySQ+JSjZZM1RG4xYvHgAI+ewKU
	 yLltTcx7wlQ0w==
Date: Fri, 3 Jul 2026 23:28:29 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: linux-pwm@vger.kernel.org
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] pwm: Use named initializers for platform_device_id
 arrays
Message-ID: <akgpIQp7QJQQ1yUv@monoceros>
References: <b515eb1644e793d019163fd2a717d3fccef857f5.1781689255.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pzxgbsidxo7x6grs"
Content-Disposition: inline
In-Reply-To: <b515eb1644e793d019163fd2a717d3fccef857f5.1781689255.git.u.kleine-koenig@baylibre.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.76 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:linux-pwm@vger.kernel.org,m:laurent.pinchart@ideasonboard.com,m:linux-gpio@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[ukleinek@kernel.org,linux-pwm@vger.kernel.org];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9550-lists,linux-pwm=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ukleinek@kernel.org,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[monoceros:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,baylibre.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EEF8D705EBB


--pzxgbsidxo7x6grs
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1] pwm: Use named initializers for platform_device_id
 arrays
MIME-Version: 1.0

Hello,

On Wed, Jun 17, 2026 at 11:41:50AM +0200, Uwe Kleine-K=F6nig (The Capable H=
ub) wrote:
> Named initializers are better readable and more robust to changes of the
> struct definition. This robustness is relevant for a planned change to
> struct platform_device_id replacing .driver_data by an anonymous union.
>=20
> While touching these arrays drop a comma after a list terminator.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig (The Capable Hub) <u.kleine-koenig@bayl=
ibre.com>

Applied to

https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for-=
next

Best regards
Uwe

--pzxgbsidxo7x6grs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmpIKXsACgkQj4D7WH0S
/k649Qf/ZMspAQd8n9bWTBQtzrOhW3oJlDoo2L6GDITnCVEzsztTPRhV//AZUkbc
r0BkxW/TnsJD0DhOA40sOzfCLPnFssF7FWxkNzA58FVnkFkTnMxq7LE/7Lj9hi6c
jTZ8QGFhKao68ygZCb1z3Iwsuc0erT8PVu8oCotKR7Q71DMfJTtlxWAP1f6twWEI
ehzXe0zVnX5ZAIbHYKghNHBxhYYPv/1xZQFhcRrbpKZXkQbOqbCJZly6U+TINv0Q
gENRe1EBRvS1+kejI313LuuGvnJBQ1ipoU5BtWfNZdSwfkUVHIx4r5wzXX2pYZJ5
FvMFmIShgZbEoa3JqE5UV0Iv0Hxz2A==
=0lBf
-----END PGP SIGNATURE-----

--pzxgbsidxo7x6grs--

