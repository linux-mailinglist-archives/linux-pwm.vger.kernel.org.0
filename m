Return-Path: <linux-pwm+bounces-8665-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wBvyGIKQ52n69wEAu9opvQ
	(envelope-from <linux-pwm+bounces-8665-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Apr 2026 16:58:10 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0478F43C6CB
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Apr 2026 16:58:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3A1C6307C890
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Apr 2026 14:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E7723D9057;
	Tue, 21 Apr 2026 14:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="REONwhrE"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD203D904C;
	Tue, 21 Apr 2026 14:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776783057; cv=none; b=m7foDq4nLMlo0qLRUIbm2nB4rzsMKOI+3mgtvsrM21pu0KMuIp+MCFcXRw/q3qi2uPwlgYXHrhRDIjBqQ7ym8ZdPgzEQTs5TeupDdW5o/tFU65fL8j5eHWWSBlYp6kJtfbG6omeG2EMK1tNxf09ogerTJLW/ao3D7aOPssiorRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776783057; c=relaxed/simple;
	bh=BMGi9M1H3wYbS7OQ26wY0topQ2jajr8jKH7yXASM19Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MA7dM0LVmcrBD5bspDEc/dFy+YAzJBmISPKSOA8PN93pJa3FFsgfz2aECiXzXYgiK7Uu76vjLhS6EdW9Ub1QMuqETTc3xEN5tTBDaKOxgmuSKacuTptnONSRgCBPzwceyP6b03Lq0W3qlo0tGJLg0iRyHhzV6uAMPZXd6Cv42EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=REONwhrE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D6F4C2BCB0;
	Tue, 21 Apr 2026 14:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776783056;
	bh=BMGi9M1H3wYbS7OQ26wY0topQ2jajr8jKH7yXASM19Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=REONwhrEVyLesl8w0b0qOeoimehD0dZcP0Xpfs9qeznq6IEvnxVUVuLm578geZK+o
	 b6OhnXPRBNPheVrCO+nhWXNxqfBOamFtVYGLWexK1F33PJk605gAKVHJ+mbykUfbTN
	 hFx8RV2rGRDutNDgogFmAQ6irrpinpK+sC9hi9yUsvhrijOBNJzXcTFGLn8E+ddtKi
	 qcF3Tuqvm5OdvdA302x/9VA8fvYxEyu+TcPFNXKBBuS01ec8vm2USaK3zwfr2MCBY1
	 TBZbCHZOxixXWsVoqt2ECWEdk06mLsKM+l8CD5ETcbohxBTo3BThyBL9QqzUmSAdOC
	 Kl1GtW1BRFN7w==
Date: Tue, 21 Apr 2026 16:50:54 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Andrea della Porta <andrea.porta@suse.com>
Cc: linux-pwm@vger.kernel.org, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Naushir Patuck <naush@raspberrypi.com>, Stanimir Varbanov <svarbanov@suse.de>, mbrugger@suse.com
Subject: Re: [PATCH v2 2/3] pwm: rp1: Add RP1 PWM controller driver
Message-ID: <aeeMp1XBDxSZ1qrl@monoceros>
References: <cover.1775829499.git.andrea.porta@suse.com>
 <0d99317b9150310dfbd98de1cb2a890f0bffe7cd.1775829499.git.andrea.porta@suse.com>
 <adkrHkANCzxO8KUP@monoceros>
 <aeC6U7D6TfWm8JPx@apocalypse>
 <aeDmk-t5Lc1zpkg9@monoceros>
 <aeH373a_xmr6fnAy@apocalypse>
 <aeIGxfQ7AoIVR5n6@monoceros>
 <aeZUAaQkHGqBL8st@apocalypse>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="opxzx26y76daqdvu"
Content-Disposition: inline
In-Reply-To: <aeZUAaQkHGqBL8st@apocalypse>
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8665-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ukleinek@kernel.org,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 0478F43C6CB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--opxzx26y76daqdvu
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 2/3] pwm: rp1: Add RP1 PWM controller driver
MIME-Version: 1.0

Hello Andrea,

On Mon, Apr 20, 2026 at 06:27:45PM +0200, Andrea della Porta wrote:
> On 12:50 Fri 17 Apr     , Uwe Kleine-K=F6nig wrote:
> > What happens if sync is asserted while a disabled channel didn't
> > complete the last period yet?
>=20
> The output stops immediately without waiting for the current period to fi=
nish.

This is a good info for the Limitations block.

> > Maybe it's worth to test the following procedure for updating duty and
> > period:
> >=20
> > 	disable channel
> > 	configure duty
> > 	configure period
> > 	enable
> > 	set update flag
> >=20
> > Assumint disable is delayed until the end of the currently running
> > period, the effect of this procedure might be that no glitch happens if
> > the update flag is asserted before the currently running period ends and
> > the anormality is reduced to a longer inactive state if the updates are
> > not that lucky (in contrast to more severe glitches).
>=20
> The disable isn't delayed as explained above. Setting just the new period=
/duty
> (which do not depend on the sync bit) correctly waits for the end of the =
current
> period without noticeable glitches (tested with a scope).

So if you happen to change both and one is done before the end of the
current period and the other shortly afterwards (which might happen as
those are configured in two different registers and the update trigger
isn't used), you get a mixed output for one cycle, right? If yes, please
also mention that in the Limitations paragraph.

> > > Let's say that teh user want 10 tick period, we have to use
> > > 9 instead to account for the extra tick at the end, so that the compl=
ete period
> > > contains that extra tick?
> >=20
> > I would describe that a bit differently, but in general: yes.
> >=20
> > The more straight forward description is that setting
> >=20
> > 	RP1_PWM_RANGE(pwm->hwpwm) :=3D x
> >=20
> > results in a period of x + 1 ticks.
>=20
> Exactly. So whatever the user request I have to subtract one from the val=
ue
> to be written to the RANGE register.

Unless the calculation is already rounded to 0, in that case don't
subtract 1 and let the tohw callback return 1.

> > > This also means that if we ask for 100% duty cycle, the output wavefo=
rm will
> > > have the high part of the signal lasting one tick less than expected.=
a I guess
> > > this is the accepted compromise.
> >=20
> > I assume you considered something like:
> >=20
> > 	RP1_PWM_RANGE(pwm->hwpwm) :=3D 17
> > 	RP1_PWM_DUTY(pwm->hwpwm) :=3D 18
> >=20
> > to get a 100% relative duty?
>=20
> Ah right! It's working fine and I've got 100% duty. So at hw register lev=
el
> the duty can be greater that the period.

In that case please make sure to not use the maximal value for
RP1_PWM_RANGE(pwm->hwpwm) to ensure that for each (possible) period
length a 100% relative duty cycle can be configured.

> > My (not so well articulated) point is: Please be stringent about clock
> > handling to not bank up technical dept more than necessary and such that
> > the driver can be made unbindable if and when syscons grow
> > that feature. Optionally wail at the syscon guys :-)
>=20
> Hmmm not sure I've understood your point: is it a requirement that the dr=
iver
> must be unbindable? In this case I should avoid registering the syscon. Or
> should I just provide a .remove callback in case there will be a way to
> unregister the syscon (even if this callback will not be called as of now=
)?

It's a requirement to properly manage the resources you allocate. If a
driver isn't unbindable due to restrictions of other subsystems that's
unfortunate and I don't like it, but I wouldn't block a patch because of
that.

Best regards
Uwe

--opxzx26y76daqdvu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmnnjssACgkQj4D7WH0S
/k6P2gf/WFdiNIbWu5z/n7i8vDSyytpmEL3VfoLW459jfMZEdsbKNezPkFGWf2HU
3GHi9Xvt48ND7zprcfUfpIMVYgllVxxoCLPk8tpIKssRaBqlWpij/+b6IX+MtiOC
m/S9JF9BfJLZlrXv3Dn1XXOCEBzBj71O0wUCZoLBIWSQKr3Yr49F1NbbXN0eo92o
G5FjXk6VVnSNO/qHh2m0RgQHfUae6iUxFa1y5jMv+c0M1e5LZnH55thCxWVjBGAh
ReYTrGU4npCzRKmgJq3TfJtX8x1vcQQhb/iQa0fRNwLFoQlFwfo7hmfnmGkPSoWf
7tUT4CPniRXmLRrA/0MxX5Un8dtfVQ==
=YncQ
-----END PGP SIGNATURE-----

--opxzx26y76daqdvu--

