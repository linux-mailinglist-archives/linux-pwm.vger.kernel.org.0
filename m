Return-Path: <linux-pwm+bounces-9308-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JZ2QL2/LMmpR5gUAu9opvQ
	(envelope-from <linux-pwm+bounces-9308-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 17 Jun 2026 18:29:35 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F5769B620
	for <lists+linux-pwm@lfdr.de>; Wed, 17 Jun 2026 18:29:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Rew1IxI6;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9308-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9308-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5C521308D42E
	for <lists+linux-pwm@lfdr.de>; Wed, 17 Jun 2026 16:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E98C8495529;
	Wed, 17 Jun 2026 16:11:25 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD69942050;
	Wed, 17 Jun 2026 16:11:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781712685; cv=none; b=iphvNBg1sPRt+PCWrOMSJkaWpu9GrPL+EeJ2tRslOPMRBLn3KbkqxjxUA3uwnSPnrwhRfQCNhyvjLGWjptBiqg3apA07vTzyp9PNq0MwVPpfa1Ep1vY36+yRf4oAfD628MB0Yu8Ii9qRoc08GJcspMgWZHFpIadQ9OKAv3Cip6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781712685; c=relaxed/simple;
	bh=b4bet+WzXHeWHI5YMWUNFNdpIrqfDuFYca3TeOTmh0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YmzW5KY9eRW6KiXRzcavSM7saYXt9laM1/6EPU5XBXAoEWNrKPxiYRPfNl3axLaWJGos4Tgokjpm4cFZS3CHXQGkAF4NhamnWC5PJEDkAVyYrxIuDHgvYBOUHMwWL/qV+pWhYuJ6FJ1Pgd0m1L3JySd1IMr4zYA0aKvihiAgqHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rew1IxI6; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 6465E1F000E9;
	Wed, 17 Jun 2026 16:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781712677;
	bh=b4bet+WzXHeWHI5YMWUNFNdpIrqfDuFYca3TeOTmh0I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Rew1IxI6/tQGVLFP/hzcDQ6v2QfSaqCQiFIQkeHepW0SUdwCAT+mMF4oGkd8Ji/Ix
	 Z3IVAbaoCVcTIcqmLq8nWzXOqMsfoTcLPg6eROU0+Iq4Bpgm40EnXirvpTSfuvCuhk
	 H9oSZ2oYPt5MP/m9OkE0n2k4c5ba37jP8O5ea7l3SaABXDBywVeghbbvCEKhE8wwAk
	 6DD3gZqUyTIndZhauRXcsIkqA/3e/LKU7ikuVG0lY6/ChA2Z76JIgmORwhWSIr7GF2
	 2/r0ySw8uLCXWYwgnr9Oco6xJjv+jzksgCLD8Tvn78HQHABdFMLv0rugAaceDC6VvQ
	 WV70/pLFZOG6g==
Date: Wed, 17 Jun 2026 18:11:15 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: keguang.zhang@gmail.com
Cc: Binbin Zhou <zhoubinbin@loongson.cn>, linux-pwm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] pwm: loongson: Reload PWM configuration through
 counter reset
Message-ID: <ajLFi7NpYQVcR_4I@monoceros>
References: <20260616-pwm-loongson-fix-v1-0-491dbf260a7f@gmail.com>
 <20260616-pwm-loongson-fix-v1-2-491dbf260a7f@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7bkyubkedq66emcn"
Content-Disposition: inline
In-Reply-To: <20260616-pwm-loongson-fix-v1-2-491dbf260a7f@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.76 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:keguang.zhang@gmail.com,m:zhoubinbin@loongson.cn,m:linux-pwm@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:keguangzhang@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FREEMAIL_TO(0.00)[gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[ukleinek@kernel.org,linux-pwm@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9308-lists,linux-pwm=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ukleinek@kernel.org,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	RCPT_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[monoceros:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 22F5769B620


--7bkyubkedq66emcn
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 2/2] pwm: loongson: Reload PWM configuration through
 counter reset
MIME-Version: 1.0

Hello,

On Tue, Jun 16, 2026 at 07:13:18PM +0800, Keguang Zhang via B4 Relay wrote:
> From: Keguang Zhang <keguang.zhang@gmail.com>
>=20
> By default, the Loongson PWM controller latches the LOW and PERIOD
> registers only at the start of each PWM period, causing configuration
> updates to be delayed until the next period.
>
> Reset the PWM counter when disabling the PWM and release it when enabling
> the PWM to force the controller to re-latch the updated LOW and PERIOD
> values, allowing configuration changes to take effect immediately.

To get this right, so if the hardware runs with PERIOD =3D 17 and then is
disabled with say the counter at 4, and later restarted with PERIOD =3D
12, the counter first goes up to 17 before the 12 becomes active, right?=20

I think the commit log is a bit irritating, because (IIUC) you only
change the behaviour when the PWM is disabled and then reenabled. If the
configuration is changed while the PWM is running, the effect is still
delayed until the current period ends (which is complete fine and even
preferred).

Best regards
Uwe

--7bkyubkedq66emcn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmoyxyAACgkQj4D7WH0S
/k6cogf/Z85s176uz5NVwNJkgxrz8iz9YuiVCadsdDzq64+O6T/i5e+3Nt/WKCeD
R55lKQYG4sLnoLeuCIvOOkzkB7LxXR2TvuVinzODHYrDGCj7QQbCorEyFrI8nL9w
oymNV+/X5m6GqoRlbrF+zYcibus9tdnFXUGvrZ9Yv/ewsI/h4mWWd1Mnu5Cch7i7
Gaatn3RHGiCWlKqg2Vw6YHPi9JEOtV0xy2oSgC9naPRQSZO4SR08meCy1fJ7cpE1
sZ0bIfSbSF68sr2z0/o1Kwspk+i1+7ZFNfYZICfNZ/kvKPEPqaAQnFIMHXUQei2x
SR8eCjmkQUeby//8SFL28QWa0fq+XA==
=K14W
-----END PGP SIGNATURE-----

--7bkyubkedq66emcn--

