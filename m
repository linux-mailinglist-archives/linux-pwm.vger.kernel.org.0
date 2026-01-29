Return-Path: <linux-pwm+bounces-8011-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UDQgEOoJe2k6AwIAu9opvQ
	(envelope-from <linux-pwm+bounces-8011-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 29 Jan 2026 08:19:06 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AA271AC8A6
	for <lists+linux-pwm@lfdr.de>; Thu, 29 Jan 2026 08:19:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 300F9301AAB3
	for <lists+linux-pwm@lfdr.de>; Thu, 29 Jan 2026 07:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 868A8322DB7;
	Thu, 29 Jan 2026 07:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vd+pTJfd"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6441B2770A;
	Thu, 29 Jan 2026 07:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769671143; cv=none; b=Bsbds3FQzIAaQ3VtwOyjF3dknn/DdIsoQqum0O34A+n97B1+W94GDroFKdTq9GOrDzxjG4Zs/EJvH7Lt0r/YD2loLjTG1u+1how8CMuQfpndbKz9Wh1vbd7wb2wJ59P/2wKS64DMswqQKR6HPtn7Jm/dkKPTdPhyi4hh5iTALD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769671143; c=relaxed/simple;
	bh=W+5VMByxti97mFzLCkBd9tZNvqOVZpQ5XRuraLsQAbo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XsQiJSs0AR8FIrT36PJxVG7COGUmTETMEXn51zAie4lBkx53tv96gK7H4X9jccMkScijN03FrlzKl083xfJJdLVVsocQz7rU4QW1jkFbXz6enCI812St/XRrGPcDSC6dRMrYYUAPNkRXtOr2xezLbix+/F3KKYSnzAs3sJ1OH3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vd+pTJfd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8538FC4CEF7;
	Thu, 29 Jan 2026 07:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769671143;
	bh=W+5VMByxti97mFzLCkBd9tZNvqOVZpQ5XRuraLsQAbo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Vd+pTJfdGE42Mznoc8ob7bnwcvGBLvgYy8tyaFyr6lyX3znq9wbOIDgTUUj/8kyr+
	 WBd2Z36z8G+WI6pEdL+DIZeFQVwrMnxLPZoBzNQLjgC9Ha6vU0a9PC23bZUGcMZEvg
	 0tCPnvGGLFgVjpBTDUElUvuAUBrQIKFbdQ9z3jiKvmpNiIcNGPmjhmNbUHmwhcgfiN
	 /LhmlaSNlr2uKdSArtXXzJXZ5/hT1miVPSLn03B1mJAbFdRuB/vc0OvmVRbPdH9l3p
	 j+pY1k58Fg8ZWLgakPRnSm6bVoc6kx11AoAeYNtSfp+RhAg0KyGc4msj2gtb6HyonE
	 PYwalqfdNUWkg==
Date: Thu, 29 Jan 2026 08:19:00 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: ben717@andestech.com
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: pwm: remove redundant check in pwm_ops_check()
Message-ID: <jxzeyujbaj6s2j3woj7lyuilwi7tzlhenamlih2q23khxw4d3f@dpbnhlxzsjmr>
References: <20260129-fix-pwm-ops-check-v1-1-6f0b7952c875@andestech.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xdwruuzlpbgythtd"
Content-Disposition: inline
In-Reply-To: <20260129-fix-pwm-ops-check-v1-1-6f0b7952c875@andestech.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8011-lists,linux-pwm=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ukleinek@kernel.org,linux-pwm@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AA271AC8A6
X-Rspamd-Action: no action


--xdwruuzlpbgythtd
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] drivers: pwm: remove redundant check in pwm_ops_check()
MIME-Version: 1.0

Hello Ben,

thanks for your patch.

On Thu, Jan 29, 2026 at 02:43:34PM +0800, Ben Zong-You Xie via B4 Relay wro=
te:
> From: Ben Zong-You Xie <ben717@andestech.com>
>=20
> Drop the redundant check for the existence of 'ops->write_waveform'.
>=20
> Fixes: 17e40c25158f ("pwm: New abstraction for PWM waveforms")
> Signed-off-by: Ben Zong-You Xie <ben717@andestech.com>

I would rewrite the commit log to:

	pwm: Remove redundant check in pwm_ops_check()

	ops->write_waveform is already known to be non-NULL so there is
	no need to check it a second time.

	The superflous check was introduced in commit 17e40c25158f
	("pwm: New abstraction for PWM waveforms").

	Signed-off-by: Ben Zong-You Xie <ben717@andestech.com>

to make the change more clear and also to not bother the stable team
with backporting the commit to stable.

Please confirm if you're ok with this change, then I cope for the update
while applying your change.

Best regards
Uwe

--xdwruuzlpbgythtd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAml7CeEACgkQj4D7WH0S
/k4adAf/YwsqbtE74Hq+AeF4rBJBneM/+47IWBwZWKWGSqb+SGIsOLEBKwqslMv9
siuPLHXX8wJE2zTyIvWanMjo63HphTY8I5bjFuM5FBk4qbhDMBxouu01cAoSewQn
3MXHENtsyXNiqWUWp5Vy6b33zLTlq/If/jtUtkDqxRTzPpaonz/MXAaKZZpsTJIh
sDSKzDecKAx7eg8/OwTg5H8afegYPUJX5rskh026Y6Lg4KkgxwTC4dMXPHPSdGnc
aFlqNbS8SjCPGbNtX7cgOZ11HFMjoRpLx0VNWwpf2V0W3aUxkCmuIHJ22/v8l46S
KkgS75O0zZVZGWlxqT0lJ4TlcJSpJQ==
=3N+n
-----END PGP SIGNATURE-----

--xdwruuzlpbgythtd--

