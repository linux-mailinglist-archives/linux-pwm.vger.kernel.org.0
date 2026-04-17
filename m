Return-Path: <linux-pwm+bounces-8629-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SMH2NoVO4mnx4QAAu9opvQ
	(envelope-from <linux-pwm+bounces-8629-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 17 Apr 2026 17:15:17 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F6CA41C78C
	for <lists+linux-pwm@lfdr.de>; Fri, 17 Apr 2026 17:15:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AF68530471DC
	for <lists+linux-pwm@lfdr.de>; Fri, 17 Apr 2026 15:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 068333C6611;
	Fri, 17 Apr 2026 15:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GMGuJw7Z"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F1638F64A;
	Fri, 17 Apr 2026 15:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776438798; cv=none; b=ogzbiBjZujpn0PBRr+myNaerchJZFNIzhh0O2ic5MhHfPyiKIfwU12nphuZg4DRZwSFb/0xoUcjScKWLKkUYnbwRMj0AWLfQvmxW8rsmQBaVWW6+8PnBuqHpbbhPZO8k2coU4apVYv5OTl76+ivhKo0p3lj5UVfubaOXdM2IpLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776438798; c=relaxed/simple;
	bh=40NUwObhEJDkoBmlb65mQofhUit6TQTAn5h8PfjU1Zk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UxGbVYGrr0L8TQbv6Ijsq9e5nPdIluEPjenoeg1kstU5QMw0G/3SuTXpRIFiHlnHi+/rh21SJ5gLRbX+XwOrBfQtTtzwDfEQ+5SHyt+vJUAhxNhY/xeS7CMPvz9SZ/nGfwi7gEXkVaKBrVMrXBrQ3/g0szFJILx7czKRI5iiPno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GMGuJw7Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EB38C2BCB7;
	Fri, 17 Apr 2026 15:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776438798;
	bh=40NUwObhEJDkoBmlb65mQofhUit6TQTAn5h8PfjU1Zk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GMGuJw7ZIMa9HgWj0CHkK0jw2NY6dO+0d7LEd9HAi5Cdbz+MQZ+mXH4NnnOA9O2QT
	 z64OcUBv0oLDYz6cieBkXHZcB+jLlTG/XKOVdmi1sEM2vXdXvQ/rJS4e2gb8Rohaf6
	 ZzcZb0J7z0LJD4zJ5cAUCE8ux3y7VAnWHiPWWvgFyf7hVdyodfpEUcElzZExwnTZQL
	 YX/suUsTrYeOgUYB0Mk58v6t3DZbskHPGMnGSwJiGe4VI07w0dOaUoRFbVTAJYnH3D
	 9IWRxmMuRPYvAGxbysqkTTfYPVkPiffkZgwvLaGHhmjpwGw3NqBIzPU40vdVHiZyjf
	 jSk+ke/7VZghA==
Date: Fri, 17 Apr 2026 16:13:13 +0100
From: Conor Dooley <conor@kernel.org>
To: Xuyang Dong <dongxuyang@eswincomputing.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, ukleinek@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	ben-linux@fluff.org, ben.dooks@codethink.co.uk,
	p.zabel@pengutronix.de, linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	ningyu@eswincomputing.com, linmin@eswincomputing.com,
	xuxiang@eswincomputing.com, wangguosheng@eswincomputing.com,
	pinkesh.vaghela@einfochips.com
Subject: Re: Re: Re: [PATCH v4 1/2] dt-bindings: pwm: dwc: add reset optional
Message-ID: <20260417-slobbery-epidural-41b03c5ee6d4@spud>
References: <20260415094908.1539-1-dongxuyang@eswincomputing.com>
 <20260415095020.1597-1-dongxuyang@eswincomputing.com>
 <20260415-reacquire-handstand-d1923af82c9d@spud>
 <20260416-wandering-solemn-uakari-083ae7@quoll>
 <281f7aa3.5575.19d95a879f8.Coremail.dongxuyang@eswincomputing.com>
 <20260416-flashcard-shadily-a0ddd2f12ff8@spud>
 <3b2e80d5.55a5.19d996c6821.Coremail.dongxuyang@eswincomputing.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sg3S+psXLlkMCLn2"
Content-Disposition: inline
In-Reply-To: <3b2e80d5.55a5.19d996c6821.Coremail.dongxuyang@eswincomputing.com>
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8629-lists,linux-pwm=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[conor@kernel.org,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,eswincomputing.com:email]
X-Rspamd-Queue-Id: 7F6CA41C78C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--sg3S+psXLlkMCLn2
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 17, 2026 at 11:11:51AM +0800, Xuyang Dong wrote:
> > > > > >=20
> > > > > > The DesignWare PWM includes separate reset signals dedicated to=
 each clock
> > > > > > domain:
> > > > > > The presetn signal resets logic in pclk domain.
> > > > > > The timer_N_resetn signal resets logic in the timer_N_clk domai=
n.
> > > > > > The resets are active-low.
> > > > > >=20
> > > > > > Signed-off-by: Xuyang Dong <dongxuyang@eswincomputing.com>
> > > > >=20
> > > > > This commit implies that your hardware differs from existing devi=
ces,
> > > > > I think you should add a device-specific compatible.
> > > > >=20
> > >=20
> > > Hi Conor and Krzysztof,
> > >=20
> > > The DesignWare PWM Databook for 2.13a says: "The DW_apb_timers includ=
es=A0
> > > separate reset signals dedicated to each clock domain". They are:
> > > The presetn signal resets logic in pclk domain (i.e., the bus clock i=
n DT).
> > > The timer_N_resetn signal resets logic in the timer_N_clk domain (i.e=
=2E,
> > > the timer clock in DT).
> > >=20
> > > These reset signals are optional; it is up to the designer's=20
> > > implementation.
> >=20
> > Right, and it's that "designer's implementation" that warrants a
> > device-specific compatible.
> >=20
>=20
> Hi Conor,
>=20
> The YAML update for the new device-specific compatible is as follows:
>=20
> properties:
>   compatible:
>     oneOf:
>       - const: snps,dw-apb-timers-pwm2
>       - items:
>           - enum:
>               - snps,dw-apb-timers-pwm-2.13a

This is not a device-specific compatible.
Hint: device-specific means it needs to start with "eswin,eic7700" (and
probably end with "-pwm".

>           - const: snps,dw-apb-timers-pwm2

--sg3S+psXLlkMCLn2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaeJOCAAKCRB4tDGHoIJi
0qI8APoCc1Xb+oei3edhggc6lHYj7iYhd4Ta7TK+mKKesrcSpAD+LA9jI5ASoAI8
HLMbaHvce11uUBIwZu2CrYp8sS7nZwk=
=WojP
-----END PGP SIGNATURE-----

--sg3S+psXLlkMCLn2--

