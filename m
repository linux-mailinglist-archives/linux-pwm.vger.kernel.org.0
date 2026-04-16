Return-Path: <linux-pwm+bounces-8623-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gClXO+EA4Wk7oQAAu9opvQ
	(envelope-from <linux-pwm+bounces-8623-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 16 Apr 2026 17:31:45 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 50663410D99
	for <lists+linux-pwm@lfdr.de>; Thu, 16 Apr 2026 17:31:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E8FCD300A3A1
	for <lists+linux-pwm@lfdr.de>; Thu, 16 Apr 2026 15:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C1FD3B27D8;
	Thu, 16 Apr 2026 15:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wxe8kejo"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D8623C4FA;
	Thu, 16 Apr 2026 15:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776353375; cv=none; b=kVdAL8PYO3otktyg0UFp5dQfqxQ8tTuEN2tsOI7zvn1iaMTBfntUR1FUVpmB+SpY4mL+piy7GKhr0PCszL3QN1DpZBGvCE2aKoGMSRVJDpIp6FeDz07ZFGDsL2K5mIgTgs1tThupyeQbvxTyji9TaOZsxxCcGEFDJ7eTi+GDEW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776353375; c=relaxed/simple;
	bh=KY4Bx/l3iKmDgcH/fhZjq79tdaDCI3sKsHPqUEI+wy4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aRF/lywwjfj907vzEsdQWpJxZaqyXMFaBRwAxI/nfFho+T6AQYe+rQAN7P4rD4QBRZRgf+FIsZPjmyB7O3SYMlwzUvz/HFgxOBSe4UXbJ+IDoEqrfKCdEfCaqW2XFDvycB8n6N8GLd6xkyguXjXt3QAae/WNtajowtbWjIZN62U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wxe8kejo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34593C2BCAF;
	Thu, 16 Apr 2026 15:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776353375;
	bh=KY4Bx/l3iKmDgcH/fhZjq79tdaDCI3sKsHPqUEI+wy4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Wxe8kejoTyo7nHF1BFDTIzznaeW2QSyjLWCA4tPleInUMD2qm/anG92Ifbo5tHBWV
	 S9TphCxYYJldyQjGPhTO6KdZORTIHzJt0vG2+o1nXU4KkyDPMWU8k7fr8g4wJ2q4N+
	 F9vctPAlsMgrMTaKOhSlqbD0KKsmODnO3+N0Ra0IzhCS0Fbi7/cgoe5zgYas5NX7m5
	 uoMzTx7ZujLJxeQETk34HXonjrT3tNfCYrbpm7j401lY8P+JXyc06ogwqibuNiLFfq
	 n2q1hBkdtK2WFIr60LCRIcvpYkvFyfKsW+scLevQhFKkxD71uBr4nw+1JAg4+Drq2S
	 R5zmfLwYSPcmA==
Date: Thu, 16 Apr 2026 16:29:29 +0100
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
Subject: Re: Re: [PATCH v4 1/2] dt-bindings: pwm: dwc: add reset optional
Message-ID: <20260416-flashcard-shadily-a0ddd2f12ff8@spud>
References: <20260415094908.1539-1-dongxuyang@eswincomputing.com>
 <20260415095020.1597-1-dongxuyang@eswincomputing.com>
 <20260415-reacquire-handstand-d1923af82c9d@spud>
 <20260416-wandering-solemn-uakari-083ae7@quoll>
 <281f7aa3.5575.19d95a879f8.Coremail.dongxuyang@eswincomputing.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="RT0aWT33ZuoPw3Hs"
Content-Disposition: inline
In-Reply-To: <281f7aa3.5575.19d95a879f8.Coremail.dongxuyang@eswincomputing.com>
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8623-lists,linux-pwm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,eswincomputing.com:email]
X-Rspamd-Queue-Id: 50663410D99
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--RT0aWT33ZuoPw3Hs
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 16, 2026 at 05:38:59PM +0800, Xuyang Dong wrote:
> > > >=20
> > > > The DesignWare PWM includes separate reset signals dedicated to eac=
h clock
> > > > domain:
> > > > The presetn signal resets logic in pclk domain.
> > > > The timer_N_resetn signal resets logic in the timer_N_clk domain.
> > > > The resets are active-low.
> > > >=20
> > > > Signed-off-by: Xuyang Dong <dongxuyang@eswincomputing.com>
> > >=20
> > > This commit implies that your hardware differs from existing devices,
> > > I think you should add a device-specific compatible.
> > >=20
>=20
> Hi Conor and Krzysztof,
>=20
> The DesignWare PWM Databook for 2.13a says: "The DW_apb_timers includes=A0
> separate reset signals dedicated to each clock domain". They are:
> The presetn signal resets logic in pclk domain (i.e., the bus clock in DT=
).
> The timer_N_resetn signal resets logic in the timer_N_clk domain (i.e.,
> the timer clock in DT).
>=20
> These reset signals are optional; it is up to the designer's=20
> implementation.

Right, and it's that "designer's implementation" that warrants a
device-specific compatible.

>=20
> According to [1], the applied YAML is also based on 2.13a, so our=A0
> hardware is the same as the existing devices. It's just that these two=A0
> reset signals were missing from the original YAML binding.
>=20
> [1] https://lore.kernel.org/linux-pwm/8bb5103d-803e-90d2-fd93-132bb2aac2d=
6@sifive.com/
>=20
> > > > ---
> > > >  .../devicetree/bindings/pwm/snps,dw-apb-timers-pwm2.yaml       | 3=
 +++
> > > >  1 file changed, 3 insertions(+)
> > > >=20
> > > > diff --git a/Documentation/devicetree/bindings/pwm/snps,dw-apb-time=
rs-pwm2.yaml b/Documentation/devicetree/bindings/pwm/snps,dw-apb-timers-pwm=
2.yaml
> > > > index 7523a89a1773..a8bbad0360f8 100644
> > > > --- a/Documentation/devicetree/bindings/pwm/snps,dw-apb-timers-pwm2=
=2Eyaml
> > > > +++ b/Documentation/devicetree/bindings/pwm/snps,dw-apb-timers-pwm2=
=2Eyaml
> > > > @@ -43,6 +43,9 @@ properties:
> > > >        - const: bus
> > > >        - const: timer
> > > > =20
> > > > +  resets:
> > > > +    maxItems: 2
> >=20
> > And this should really be listed with description, because order is
> > fixed.
> >=20
>=20
> The description of resets will be listed in next version.
>=20
> Best regards,
> Xuyang Dong

--RT0aWT33ZuoPw3Hs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaeEAWQAKCRB4tDGHoIJi
0rw3AP9akyjTmY4lqX4/Yw1P7IOAQM7a1gqMZnuej5yU4rpErgEAi+a5lvyMrln8
VKS6iiyYnqGVNeljt+KYUh/L4qd/IwY=
=/wmG
-----END PGP SIGNATURE-----

--RT0aWT33ZuoPw3Hs--

