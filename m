Return-Path: <linux-pwm+bounces-9718-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7Kt/FPAnVmoP0QAAu9opvQ
	(envelope-from <linux-pwm+bounces-9718-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 14 Jul 2026 14:13:36 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BA2667545C5
	for <lists+linux-pwm@lfdr.de>; Tue, 14 Jul 2026 14:13:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=cOL2UimI;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9718-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9718-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 58FBB30C603E
	for <lists+linux-pwm@lfdr.de>; Tue, 14 Jul 2026 12:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 789B0394462;
	Tue, 14 Jul 2026 12:08:37 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58655233927;
	Tue, 14 Jul 2026 12:08:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784030917; cv=none; b=uQBOE4fVBOPahVTT/dBBOUHhDFhAN6cjl9VpApdFNn85H+0wYkH2BWqOt7KfKsk3S7MGnVLTarly/ECFlVFEgfELJ+cBJ/MDOLAf87qMxQoZ6jR7oF7uJTIjvcHyCRQKHiWYb0mdbqfko2A4CT0l4kVMlZNFQ86ekMXtpOVTv74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784030917; c=relaxed/simple;
	bh=dXY0GC+RtMRuoUAl+Q3RuJBFmYA4ldj/VgShDcX0rQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lq2/XYbZcop8ZoKM1/FQpNAkNotMviq+NiNw8UG5kEiXGyAzgKTQDZWW9EHkTuZbUsa9eK72fNOvKpjeYsykrdZ8XPDtfIZwxDFtVqubd1km4iBGcUm7NNiB1WLycWyj9H35bkydmIImzhTtLfO9ar9PIZC3AKbNJ9X82QjKerk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cOL2UimI; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id A67EE1F00A3E;
	Tue, 14 Jul 2026 12:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784030916;
	bh=dXY0GC+RtMRuoUAl+Q3RuJBFmYA4ldj/VgShDcX0rQc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cOL2UimIR1Nt072NbjV9FBhG/jQxuoldBxeRMjsVpngK9wVzl3wvI5DfV5TyAo3OF
	 UXGstIAdfS1kAHhlz9wT8HS+XxGHqcz9OJYy2Unk20mLlfqjoMpU/2uq0ZpLv+OuYt
	 p9+AqMs4aqLR1qG4oQgM550FI8/zdhRbCHxSStrLY6OAdWdrUza1Jn/H+2seDapBom
	 JuTiv2jVE2Dn3WOa67fpLFW4qssdLmLgzOY9WlFsmd46cT0bCoCAstg2Q9i7E3kakI
	 zswPMEbGp2TolahAWDnIGhXNOE/jjjDM52r9jhCKc4mWDhfa4KTMjO+J4mRFAMHYhb
	 56vun/HilhxlQ==
Date: Tue, 14 Jul 2026 14:08:33 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: "Ola Chr. Vaage" <o.c.vage@gmail.com>
Cc: Thierry Reding <thierry.reding@kernel.org>, 
	Jonathan Hunter <jonathanh@nvidia.com>, linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org, 
	linux-kernel@vger.kernel.org, "Ola Chr. Vaage" <ola.christoffer.vage@scoutdi.com>
Subject: Re: [PATCH] pwm: tegra: fix doubled output frequency due to divider
 truncation
Message-ID: <alYmY0535HVPRNz2@monoceros>
References: <20260713111541.473547-1-o.c.vage@gmail.com>
 <alX5fmfHs1CW_bps@monoceros>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bbyk6v3ybvtkrwjw"
Content-Disposition: inline
In-Reply-To: <alX5fmfHs1CW_bps@monoceros>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.26 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[ukleinek@kernel.org,linux-pwm@vger.kernel.org];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_RECIPIENTS(0.00)[m:o.c.vage@gmail.com,m:thierry.reding@kernel.org,m:jonathanh@nvidia.com,m:linux-pwm@vger.kernel.org,m:linux-tegra@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:ola.christoffer.vage@scoutdi.com,m:ocvage@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9718-lists,linux-pwm=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ukleinek@kernel.org,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[linux-pwm];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,monoceros:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BA2667545C5


--bbyk6v3ybvtkrwjw
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] pwm: tegra: fix doubled output frequency due to divider
 truncation
MIME-Version: 1.0

Hello again,

On Tue, Jul 14, 2026 at 11:14:58AM +0200, Uwe Kleine-K=F6nig wrote:
> The usual behaviour for .apply() is to pick the largest possible period
> not larger than the requested period (and similar for duty_cycle). The
> tegra PWM driver doesn't do that and instead trys to pick a nearest
> match. If you change how the configuration happens, the only acceptable
> way is to migrate to the usual behaviour, still better, convert to the
> waveform callbacks.
>=20
> The driver also lacks a .get_state() callback and should not use
> pwm_is_enabled(). Also calling tegra_pwm_config() discards bits from
> state->duty_cycle and state->period if they are bigger than INT_MAX.
>=20
> So there are some things to work on in that driver, but don't make the
> clock selection not more complicated as it already is and as is
> necessary.

I started on that, but failed to Cc: you. Please see
https://lore.kernel.org/linux-pwm/cover.1784030076.git.ukleinek@kernel.org

Best regards
Uwe

--bbyk6v3ybvtkrwjw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmpWJr4ACgkQj4D7WH0S
/k7FhQf/asLvaUiHOopjiDbi9CHLkv3NquzJwY4hRuPuXYi97Fs2iz/b+6F3UjwB
dPtkhMrrcEqdOJLq3uMeboDwO8Pl8YxfXvDzkKcawlGnHVEU3okDqTObSRDsnws/
52OMgQDOk+NyuZIt8NoptSSm8H8fxI01BYcAtKLHZB7RayEG8ln/rioGme3+zEXu
fZrFzECYtEZV3aaiNU9eKahXpOEfJXnQtMKK9MsZ1H78S2pQfiC5kEEsbQbhIiXx
mNQWtJxFgkzw7a1wBSOBSW9Lmi9M4dixG1Spie13A2hMHlJsVS2bXbsNbBxC41Zp
y22N2oiJ7O2OotQDa5vXmYxtZgyLgg==
=jVt5
-----END PGP SIGNATURE-----

--bbyk6v3ybvtkrwjw--

