Return-Path: <linux-pwm+bounces-8024-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qMbTHJw2fWkuQwIAu9opvQ
	(envelope-from <linux-pwm+bounces-8024-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 30 Jan 2026 23:54:20 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D8AE7BF3DC
	for <lists+linux-pwm@lfdr.de>; Fri, 30 Jan 2026 23:54:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 48B623004F73
	for <lists+linux-pwm@lfdr.de>; Fri, 30 Jan 2026 22:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8430335A95A;
	Fri, 30 Jan 2026 22:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tQuQ/Wcu"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E629358D38;
	Fri, 30 Jan 2026 22:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769813643; cv=none; b=r8CMJFSF03RUI+gvqbA9i4vDRPRkpynhlbRwMW6ndqwzA1e7xGiD4MwYO53t0whHrgi50sCcYHfISZzUM60U8ANRjCwUE/QTzWKPbgJJJIyth0ryDzLHpcXiRKupD9d4ETNdo/IY+fN6QjYNrE4CCBAW/ehL4Lf8iI5Jr+qrevw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769813643; c=relaxed/simple;
	bh=BC9YUeb9WKTkaJYQAKVMGEgmblMkguJiuXzL58qwZdo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qLPdgmerT49qM0zm+0bByVg9AN1UBMcVzQQlHVaK0SbgYJOS0x/DWDStVSFcjHE1c9IZNnJJ98NnRMDceNe9dvpsPupynElRh+0UOy5iI0xKv09Icvy2Ax9fGUft+dBC5cWzdHWz8t4Lan8x3pnQ7s+OceHXVHLuJl5Bh1B2imo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tQuQ/Wcu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95264C4CEF7;
	Fri, 30 Jan 2026 22:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769813643;
	bh=BC9YUeb9WKTkaJYQAKVMGEgmblMkguJiuXzL58qwZdo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tQuQ/WcumE1JiQ//1BD6xkMbC7920ppd98IUaxn07imyq6dlfHJoBd6f7/urcHey/
	 hINeibsZzFMxfIhdTUmecKzDRv/4rrVMjIj+aEhIu7eqObigZ6K9oXzGOhBSvIaTeZ
	 GC+nN9ylQumoJi6pqJCwsB0h8E9T3OWnWUG4fOy7WGTvWJatWL1UFuatOrQNGbIYsf
	 Ja+2WDWHqaIzVv89lrJnH36fTI4dUNQH65b7WWtr5UG/N9QqQsYarLXz7xRfjhsjux
	 IwjEa0erbNQKHWkM5xQVuZfH873ncLYwBhGLLz89JPaQ2d7z82gnP0FSc8b4Y9mNUt
	 owqXJzO7UbZBw==
Date: Fri, 30 Jan 2026 23:54:00 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Frank Li <Frank.li@nxp.com>
Cc: "Viorel Suman (OSS)" <viorel.suman@oss.nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, linux-pwm@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pwm: imx-tpm: keep channel state instead of counting
Message-ID: <hgq3sqxuav3z3fgxyighfgqan6hliu2bev7bthgrmzlwsjecmv@7bxor6zucgct>
References: <20260130143720.778514-1-viorel.suman@oss.nxp.com>
 <aXztQkefafsgFJvN@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ywia3zssrqv4e5f3"
Content-Disposition: inline
In-Reply-To: <aXztQkefafsgFJvN@lizhi-Precision-Tower-5810>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[oss.nxp.com,pengutronix.de,gmail.com,vger.kernel.org,lists.linux.dev,lists.infradead.org];
	TAGGED_FROM(0.00)[bounces-8024-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ukleinek@kernel.org,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D8AE7BF3DC
X-Rspamd-Action: no action


--ywia3zssrqv4e5f3
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] pwm: imx-tpm: keep channel state instead of counting
MIME-Version: 1.0

On Fri, Jan 30, 2026 at 12:41:22PM -0500, Frank Li wrote:
> On Fri, Jan 30, 2026 at 04:37:20PM +0200, Viorel Suman (OSS) wrote:
> > @@ -166,6 +166,10 @@ static int pwm_imx_tpm_get_state(struct pwm_chip *=
chip,
> >
> >  	/* get channel status */
> >  	state->enabled =3D FIELD_GET(PWM_IMX_TPM_CnSC_ELS, val) ? true : fals=
e;
> > +	if (state->enabled)
> > +		tpm->enabled_channels |=3D BIT(pwm->hwpwm);
> > +	else
> > +		tpm->enabled_channels &=3D ~BIT(pwm->hwpwm);
>=20
> Do you have lock for RMW? or you should atomic_or() and atomic_and()

=2Eget_state() is called under the chip lock, so the locking should be
fine.

Best regards
Uwe

--ywia3zssrqv4e5f3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAml9NnAACgkQj4D7WH0S
/k4HZAgAgpYz3BG+3flQ7e8bEdfouy6v7sOSUJ7IDh3f9w/p8HjkSIFaQbbRCsKf
vMlD3WQf2bD87YysBuN/oSDlUI/L3qUWRS4PerGgeBAR1kWwMuY/g7E5mVz/OdxV
kSGVkvBhTVsjE3M3R1XHX0AlKzFR1hGPkZxw18ggECdtwj81QhxS8ZUWmUJaZxle
w9mFBvYt75QBvXG/am97eJ9hyVv9Br0R1yUYbJazN53Pw0dvWR2ZpL6SFPCscVKX
EUz+UK6Bj2grSG4/T6jJHJ2B0I/bqhBrn/7jEuY5/x9vLCLm8uLBSihQgDwMg16D
Ex8i2jdJutn4q67nVavlxs5sjCEerw==
=coeH
-----END PGP SIGNATURE-----

--ywia3zssrqv4e5f3--

