Return-Path: <linux-pwm+bounces-9090-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2FeUGErfEWohrgYAu9opvQ
	(envelope-from <linux-pwm+bounces-9090-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Sat, 23 May 2026 19:09:30 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D31D95BFFCF
	for <lists+linux-pwm@lfdr.de>; Sat, 23 May 2026 19:09:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 55620301024B
	for <lists+linux-pwm@lfdr.de>; Sat, 23 May 2026 17:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E1A130BF4F;
	Sat, 23 May 2026 17:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DwqKXVQ7"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9192F7AD2
	for <linux-pwm@vger.kernel.org>; Sat, 23 May 2026 17:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779556166; cv=none; b=GepIe6pHBtN2waU/14EWkiqoZjOXfw9pUpzS4TMt+LqhE1X86iZeFIHh6S8uCnjOhxs0725hzN2JV19Eggta2U9SkqmdZ6VrNvmZWxIVqd1Q7YW8eYJbHagQwM9EOIlRhgKxlSDTYvQFdVkD8w+u4PWn8ziIZT9tOg0ncibrtqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779556166; c=relaxed/simple;
	bh=WzPJtmg1sb3V/Q425vBHRnfy8XIzzc4T92lqzE70k4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bjMtcZhg72YWv+f/3I34Q5NNn0n57l8l0t/ZcDyKrSsmF4tLbqc9wNC4J9XclSHz3r482WjrGpxWLbLl5X4yBlsvSSyrkhXCVCThoLLk2oga032LKsEuYqIi8ZRe1wrinPPfmGgA7VYc+V/01eCvIsPlQuaqygn63fKzGLL8Owg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DwqKXVQ7; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 2B1461F000E9;
	Sat, 23 May 2026 17:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779556164;
	bh=fh3b7XSHHpyAk/EqJXtvp0N/MDMReridJC1c4TuGq2E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DwqKXVQ7rGMQ8mXt3fOSY1b/2+w4qpGo539ceF62Q3VvmZRtAnJfrZb/WZSMs2CZZ
	 4SpjhdwYrZzSQ6aj1bkche2il0KOnnpVPm/TC9WC0ChY1SMEdlrWz2jqM1G5Cd1rlz
	 5m3G08Zr/8hB70zF9qbWQjGqDZg8aO5YRTZVza9OG6KiXhPT1F78A64q5k3jGaXTlw
	 gfYRyUJLywUhs/nBsU8bYAUkY1qhkn3hbc02IYY54R7qmgJ3AX3fVmeDONsCb73yA4
	 tt/dsJsi8PuiYsl7A6KmyyKLouAFYTKbz+LugjdnBVlLY2TmRy1wZ55atzE6WNj5Ki
	 idCroHzSv34Mw==
Date: Sat, 23 May 2026 19:09:21 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Chen Ni <nichen@iscas.ac.cn>
Cc: nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, 
	claudiu.beznea@tuxon.dev, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] pwm: atmel-tcb: Remove unneeded semicolon
Message-ID: <ahHep1cKDjuvMuiS@monoceros>
References: <agnyKRxQk5WXSTHe@monoceros>
 <20260518022251.1625520-1-nichen@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vvack7oqb3jt2kp6"
Content-Disposition: inline
In-Reply-To: <20260518022251.1625520-1-nichen@iscas.ac.cn>
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9090-lists,linux-pwm=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ukleinek@kernel.org,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: D31D95BFFCF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--vvack7oqb3jt2kp6
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] pwm: atmel-tcb: Remove unneeded semicolon
MIME-Version: 1.0

On Mon, May 18, 2026 at 10:21:25AM +0800, Chen Ni wrote:
> On Sun, May 17, 2026 at 06:52:48PM +0200, Uwe Kleine-K=F6nig wrote:
>=20
> > I'd like to pick up this commit, but don't want to modify the commit log
>=20
> > without your consent. For now this is blocked because of that.
>=20
> Hi Uwe,
>=20
> That is fine with me. Please go ahead and add the note to the commit log.

I did that and the patch is now part of

	https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/fix=
es

=2E Thanks for cleaning up after me :-)

(Actually I applied it already a while ago and failed to announce that.)

There are four patches now in pwm/fixes. I don't know yet if I send them
to Linus before v7.1. I'll wait for sure a few days to have them exposed
in next for a while at least.

Best regards
Uwe

--vvack7oqb3jt2kp6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmoR3z8ACgkQj4D7WH0S
/k7W8Qf/UjiR839YUlUZoigYf5A2VZmwX8taPg1nLyJyT6tunnF0icBajYNYXAvA
Rz3D/sCeYsq1XHyZ/ReP5YNs5ZylXBgpjQ1qBeJ2CrPw2lTgCWeNTiN2WWuPsIli
vTglVmB2Caig+782l1jHJ+FkgDkUoTGjTwO4P+o/MqHzreDD70EH88sS5aG9ubHI
t7OfndJQfCQKLCaYb9KyohNdcf55Obe3iQyI2R3GU1hDtZC2enqTmpVDQiuQyRYZ
yujllq0oFXo6w+mxor3j6h7rGm3oFk0qstdAU0rSgknW4N8qF6Pjd2GWCQ4e4lnk
QHN/rDYfqJe/oJOFB4P3JbAXUpSK0A==
=knMV
-----END PGP SIGNATURE-----

--vvack7oqb3jt2kp6--

