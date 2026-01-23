Return-Path: <linux-pwm+bounces-8000-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yFmVL5y3c2ncyAAAu9opvQ
	(envelope-from <linux-pwm+bounces-8000-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 23 Jan 2026 19:02:04 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C3B7951F
	for <lists+linux-pwm@lfdr.de>; Fri, 23 Jan 2026 19:02:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BB38930011A2
	for <lists+linux-pwm@lfdr.de>; Fri, 23 Jan 2026 18:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0527B199FAB;
	Fri, 23 Jan 2026 18:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SKAUSqfW"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6387A55;
	Fri, 23 Jan 2026 18:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769191301; cv=none; b=RrcaiAwmv2HRXOV546SvLw8pfsByRSlY8U7S9anB1SyqdGeiS9RnuiVITYdZIJ9SkS6OqF8lW+l1bwfP8l+vgc+Rd/Cv/4cv4KUUgRkOHZVRQrwABqEEq8fRvHxaIgXmu+XDgOO7umqQafpAk7yATPDsrobN/F79InlPDKD0RRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769191301; c=relaxed/simple;
	bh=xqZ5eXWpHP1ZMEiJ8jRzqZ6mXJXc07TRqPQhe+P1DkE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yqpv/tu5n0ZQx3GEk6JdnHCWbtMOrW5bA8e/ZJkimNINfHRhPZF1tKTZAJjvL9xg8tu5px2eBkgMidAQrqvVWmicfAQcJ39m/NA1yKZLAz2ng8v9QNnVMJqU37Pd+3agc1rkKscKBV6jJvFQt4Ts/RI2NLE/juGDcYIG7YPht2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SKAUSqfW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 275E7C4CEF1;
	Fri, 23 Jan 2026 18:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769191301;
	bh=xqZ5eXWpHP1ZMEiJ8jRzqZ6mXJXc07TRqPQhe+P1DkE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SKAUSqfWdnuHNVsTmpRRoYJ3liJwd2otYOcWOELpMWP9JQl52t4K8GOHYvf3bOlTz
	 Qwi2oDe7DxpY6XMs6WxHuNv456ohZOT4pqiVsnOM1wLUsVeQwAJYrVmYXJOk/B+8N3
	 xC2/WZf06hkNFNNti+dPxesqpR0WRjRwHOwKP9aKF/p7DpOCM4Kwoi7DaPKJnaPr9z
	 iX70qLfmPOaEi8kg9zyVSACgol14m5AUWma/7zzGAsZo3U1hpKZd9uYn0GofuwbviL
	 J5aaaxyQy3jbZPzY74Rxvfaxa5dxLyONhnUtfwHkimz16gSY2PoCD9C1oLNOPayT6H
	 T4gkOOIi3jNvw==
Date: Fri, 23 Jan 2026 19:01:38 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: "Kumar, Udit" <u-kumar1@ti.com>
Cc: Gokul Praveen <g-praveen@ti.com>, j-keerthy@ti.com, 
	linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, n-francis@ti.com
Subject: Re: [PATCH v4] pwm: tiehrpwm: Enable pwmchip's parent device before
 setting configuration
Message-ID: <d773qlfhifbtn6xtkuowdu3l3h6em7hrk2etsg3n5umuiuhfu7@yuetzfci7pni>
References: <20260121061134.15466-1-g-praveen@ti.com>
 <3ck3abtfdqzmatsvfqcbp7bxu7ydy7u37hfkke4xvpatpcg5uk@wfnya5hxrplo>
 <7081d6d7-d2d9-4364-9df2-48961d465474@ti.com>
 <2b13ec3e-767f-454a-b344-87b7f1bfafb3@ti.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ysvkxvhq6nes3p42"
Content-Disposition: inline
In-Reply-To: <2b13ec3e-767f-454a-b344-87b7f1bfafb3@ti.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8000-lists,linux-pwm=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ukleinek@kernel.org,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-pwm];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,ti.com:email]
X-Rspamd-Queue-Id: F1C3B7951F
X-Rspamd-Action: no action


--ysvkxvhq6nes3p42
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4] pwm: tiehrpwm: Enable pwmchip's parent device before
 setting configuration
MIME-Version: 1.0

Hello,

On Fri, Jan 23, 2026 at 08:28:48PM +0530, Kumar, Udit wrote:
> On 1/21/2026 4:19 PM, Gokul Praveen wrote:
> > Hello Uwe,
> >=20
> > On 21/01/26 15:48, Uwe Kleine-K=F6nig wrote:
> > > Hello Gokul,
> > >=20
> > > On Wed, Jan 21, 2026 at 11:41:34AM +0530, Gokul Praveen wrote:
> > > > The period and duty cycle configurations on J7200 and J784S4 SoCs
> > > > does not get reflected after setting them using sysfs nodes.
> > > > This is because at the end of ehrpwm_pwm_config function,
> > > > the put_sync function is called which resets the hardware.
> > > >=20
> > > > Hold the PWM controller out of low-power mode during .apply() to
> > > > make sure it accepts the writes to its registers.
> > > >=20
> > > > This renders the calls to pm_runtime_get_sync() and
> > > > pm_runtime_put_sync() in ehrpwm_pwm_config() into no-ops, so
> > > > these can be dropped.
> > > >=20
> > > > Fixes: 5f027d9b83db("pwm: tiehrpwm: Implement .apply() callback")
> > > > Signed-off-by: Gokul Praveen <g-praveen@ti.com>
> > >=20
> > > I applied this patch to
> > >=20
> > > =A0=A0=A0=A0https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/=
linux.git
> > > pwm/for-next
> > >=20
> > > and will send it during the next merge window. The problem is old
> > > (v5.18-rc1~54^2~29 from 2021) and it's late in the development cycle,=
 so
> > > I won't bother Linus with it for 6.19.
> > >=20
> >=20
> fyi,
>=20
> We are hitting compilation error with this patch
>=20
> https://gist.github.com/uditkumarti/d23bc9ee1886bfce70cc76e4b19fbb59

I assume you tried to compile this patch on top of a tree that doesn't
also has commit 9a0abc39450a3123fd52533a662fbd37e0d1508c?

Best regards
Uwe

--ysvkxvhq6nes3p42
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmlzt4AACgkQj4D7WH0S
/k42iAgAjBMxwzGpvcvyIbNNbwYRQs6xhbBZ1hAVred5CyRzwe/4aBcc+rxvX3p7
Pihgce0cJlZBncrsoJRrhM34wkpbUsjaoUzBebb1S8dWJPFmrV7xGtE1sG/h9pOV
gck+gUnbIIlV6Xk2KTLxx9/sSHqS0iKEhUtvlfkQlRc2407penlDVWx1lUEK6R0A
2xngFNJlSB27GbzGDKZrjSxcKC8j/EJRMXKwsyvsFGojZxvPvB9aXpcjlbEPvUN4
5uFlF/n/MTHNbgf0EWZpL+4Z9D/Rjfp2f7mOG8sr6YS3I3/6tfv1QeB43dUJZr3C
2dbjT26aj0mvhUr4h6c/TSeNyrSO0Q==
=s3F5
-----END PGP SIGNATURE-----

--ysvkxvhq6nes3p42--

