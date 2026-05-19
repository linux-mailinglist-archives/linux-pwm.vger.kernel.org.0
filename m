Return-Path: <linux-pwm+bounces-8994-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UKl7COA7DGp8aQUAu9opvQ
	(envelope-from <linux-pwm+bounces-8994-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 19 May 2026 12:30:56 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 276A557C421
	for <lists+linux-pwm@lfdr.de>; Tue, 19 May 2026 12:30:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1F48B30118FB
	for <lists+linux-pwm@lfdr.de>; Tue, 19 May 2026 10:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34940480DD5;
	Tue, 19 May 2026 10:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FmxNproE"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A1B477E31;
	Tue, 19 May 2026 10:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779185034; cv=none; b=dzEEddU7RZke63lsjkmGVgnhNZF2wDoWTRP7HLYPpDvQxpf5k1WjGqp6m+5r0q3GGggwcMG6bqGZmRnXxSDDv8llFg8eUadk0xIWQrNhHTYJw5GR82LwzuKxe1JsKmOma/fVV+VmZEjlTbMmU9ClptyvUzK9wT4ZhusxENKi7b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779185034; c=relaxed/simple;
	bh=5QWinO9Xjw92NFX2pfVE5o/B55ZoWiLgM/PylmeqNxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AZTFAEgSAHgJ5bGsi/AZUq3GijtGlKGQ7Cw4JRs38wQNfsyfGBHNRq5nfVJUD7p3Nkrg0+GgBrHBL+Rd4nRBm60QRwnhTByj+u24iqklg2BUcWmibeYczqc4kH5h0JtpmkLjrL0oX/HnxUKkkg6GY0jp4ss17/MaBCdH1qNBEOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FmxNproE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F1A0C2BCB3;
	Tue, 19 May 2026 10:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779185033;
	bh=5QWinO9Xjw92NFX2pfVE5o/B55ZoWiLgM/PylmeqNxE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FmxNproEEopPjAbb2zBeyvfCuA7MgGuISv+HsareXD0X3JS0PpGL2WmKBE32KnWHi
	 o9neWelgGRGO0B3F0yUsYCqi9XOAEXYQfgUpMa39plQJIJ9fL19VIdcl5z7Secnxzk
	 FULpwYAOWtLMQD1hfpTTbQz6LRgKqsLKbCqxFwW7kCBQJW0N8Y5dkBF6R6kxldP7ny
	 K7FJTq3KCH89mA1eEPW/hqAiMZCDSIN4XrGm3jACgprQXUEaI80nXssDtXh60ujfms
	 E/Uy+4+U50EN2PwEDq00noVpQzLGsB/qTyBagMMjW/RD0zz5Gx3gnpzaSgJaH19T/K
	 690+ib8PUBBLw==
Date: Tue, 19 May 2026 12:03:51 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: linux-pwm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] pwm: pca9685: Use named initializers for struct
 i2c_device_id
Message-ID: <agw1WE4xLKY_Uv_Z@monoceros>
References: <20260518172323.932774-2-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="brsjvhmpj6rzdtgf"
Content-Disposition: inline
In-Reply-To: <20260518172323.932774-2-u.kleine-koenig@baylibre.com>
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8994-lists,linux-pwm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ukleinek@kernel.org,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DBL_BLOCKED_OPENRESOLVER(0.00)[baylibre.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 276A557C421
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--brsjvhmpj6rzdtgf
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1] pwm: pca9685: Use named initializers for struct
 i2c_device_id
MIME-Version: 1.0

On Mon, May 18, 2026 at 07:23:22PM +0200, Uwe Kleine-K=F6nig (The Capable H=
ub) wrote:
> While being less compact, using named initializers allows to more easily
> see which members of the structs are assigned which value without having
> to lookup the declaration of the struct. And it's also more robust
> against changes to the struct definition.
>=20
> This patch doesn't modify the compiled arrays, only their representation
> in source form benefits. The former was confirmed with x86 and arm64
> builds.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig (The Capable Hub) <u.kleine-koenig@bayl=
ibre.com>

Applied to

	https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for=
-next

as merge window material.

Best regards
Uwe

--brsjvhmpj6rzdtgf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmoMNYQACgkQj4D7WH0S
/k42AAf+IBLsqxDF4Bsmhlaxpthxnf8UO96IRW06T0G2cdm1cJHkh4RzcRziCPHn
XZytjZYY+J50BWgn1Y4q4r1v3y4eI6gjL+0HbOCLd9DbCkmaprBsyaI30FMb0Wk+
JxU8ggQhgI3VTuqdf1eHbSNyjCfgdmWFw+COI2/YiwSR/9tX7dcsIt1HnMn390il
f3AAJ5YgVMqJLEkZWo5vKxeHYpyAa0VJZgC61xWmZOXxPzn2xYBX3S5mG57uCqAq
yB+YJrtnYMY1Cd/vnLXYse3VAAn3NsPXc3kPBNsrH/ZNp7pJ3v9dHTD2MMmRaHU1
CYlbRWraIxRBIc9lLq5e5hziPQJyNg==
=EnNZ
-----END PGP SIGNATURE-----

--brsjvhmpj6rzdtgf--

