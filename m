Return-Path: <linux-pwm+bounces-8244-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mPuVCG7as2mzbgAAu9opvQ
	(envelope-from <linux-pwm+bounces-8244-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Mar 2026 10:35:42 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B98280963
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Mar 2026 10:35:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AFE52314571B
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Mar 2026 09:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3219F331230;
	Fri, 13 Mar 2026 09:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YsZ/zOSC"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DFA122A4E9;
	Fri, 13 Mar 2026 09:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773394352; cv=none; b=E+FJv5/myRejAfBE13wK/v62AO+irW413CX1aaTASYN0KHFi/wAW7gGxL3ucyxb4dXjkoa557uUoIgnRqWLfGpfc8T1XtJSlhgk3Uvb064G8ZnPXGox5JLaar41vtvt4YLP2OBopJ+9Ym4ryf9JQ6xTSTQVUUC4B1QGN5GqdGlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773394352; c=relaxed/simple;
	bh=+MT2bK5lK4b/U+CKVnI5iPZjRVFFSU1WWNQo7BSEpGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CTt9F/NAYlYzbvPPX7ZFNFIcRhrfEpd/7uGV8bCEzeRXF2QDSxRRUI9FwjboAuSPnaaDPxNgm20fscR57fmyCMUs2miidnoCpFVE0DV6hOiI/KMZAAPzaY83dOExj2tC96U0bbFpX2IyLEiagKccWue9qQoe63pmwmJFF+JU+FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YsZ/zOSC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F4DFC19421;
	Fri, 13 Mar 2026 09:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773394351;
	bh=+MT2bK5lK4b/U+CKVnI5iPZjRVFFSU1WWNQo7BSEpGs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YsZ/zOSCWdZPU3Jciw6dOovFXjZi7JCTqvB4ZleCf9pN1Lc36FvPXKrL4tdL922dN
	 sRqJU99AhErIhg7m6B/SOxyT3V90rEgg9leEwg9eVgkRWQWYBMhlRiadFecyNDk0+4
	 AUJwEboXm7Wa2KN1udBilplTwMPfG6nsTEv1EHe2EEhw1yeB9n/3kZHI4Mkrfnf834
	 oq8qjvyBxiy0fyiepery/b1A8UkjvGUOKnEN7yQzlC0wV9qQSVxcuGDqBgDgi/a+E2
	 Fsr0D0hTrr3p3XwCCVY6JT8/Y6+eloYdDsCY8I6NyMzoqmSJMbCWwY6TsBLJXyg1Z5
	 gXshwXUd1oPCA==
Date: Fri, 13 Mar 2026 10:32:28 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: "Viorel Suman (OSS)" <viorel.suman@oss.nxp.com>
Cc: Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, linux-pwm@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] pwm: imx-tpm: count the number of enabled channels in
 probe
Message-ID: <abPZBUvzHi_yqkkU@monoceros>
References: <20260311123309.348904-1-viorel.suman@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3x3zrpgo2kxgdoay"
Content-Disposition: inline
In-Reply-To: <20260311123309.348904-1-viorel.suman@oss.nxp.com>
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[nxp.com,pengutronix.de,gmail.com,vger.kernel.org,lists.linux.dev,lists.infradead.org];
	TAGGED_FROM(0.00)[bounces-8244-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ukleinek@kernel.org,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:email]
X-Rspamd-Queue-Id: 72B98280963
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--3x3zrpgo2kxgdoay
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3] pwm: imx-tpm: count the number of enabled channels in
 probe
MIME-Version: 1.0

Hello,

On Wed, Mar 11, 2026 at 02:33:09PM +0200, Viorel Suman (OSS) wrote:
> On a soft reset TPM PWM IP may preserve its internal state from
> previous runtime, therefore on a subsequent OS boot and driver
> probe "enable_count" value and TPM PWM IP internal channels
> "enabled" states may get unaligned. In consequence on a suspend/resume
> cycle the call "if (--tpm->enable_count =3D=3D 0)" may lead to
> "enable_count" overflow the system being blocked from entering
> suspend due to:
>=20
>    if (tpm->enable_count > 0)
>        return -EBUSY;
>=20
> Fix the problem by counting the enabled channels in probe function.
>=20
> Signed-off-by: Viorel Suman (OSS) <viorel.suman@oss.nxp.com>

Applied to
https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for-=
next

with Cc: stable. Given that the issue is already old (May 2019 in
5.2-rc1) I tend to not send it for inclusion into v7.0, but if something
more urgent pops up I'll probably send it along.

Best regards
Uwe

--3x3zrpgo2kxgdoay
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmmz2akACgkQj4D7WH0S
/k5F4wgAr+r7n0wf0qQGC7PzYyABJ2R++TrHH11Mj3ayf4RwH12e/AZdB4BexERN
YXRiq7MFz/NjHQyvSaEBOSe0bzSLRCz+IEgq+5YtrJzA9niDlBWAKQtZus93TBWV
J75sVS/gh5rTf5ykCqm7GgZQ/3QWd6DfZ7GvNRnnTgtby4ePVgtax7xwjISMYh5O
5aOrRuHTacEBbC/7PFdwJ4hngibB4/mJBMVZSQcV5199q0zUzecUYPag4xCYpGM4
xe1Hj/waykSIvY8QMKjJSUYZXqBo+fFEpsoTvw08ZMiA+tp162x+walf8VAzGWuT
/oj2t6W5PtRfjVq7dwPFvD0+cMIKBg==
=vRAD
-----END PGP SIGNATURE-----

--3x3zrpgo2kxgdoay--

