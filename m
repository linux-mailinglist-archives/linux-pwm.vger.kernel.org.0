Return-Path: <linux-pwm+bounces-7974-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YDnLLEjUb2mgMQAAu9opvQ
	(envelope-from <linux-pwm+bounces-7974-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 20 Jan 2026 20:15:20 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 452D34A1DF
	for <lists+linux-pwm@lfdr.de>; Tue, 20 Jan 2026 20:15:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D674CA6260F
	for <lists+linux-pwm@lfdr.de>; Tue, 20 Jan 2026 18:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A3644BCBC;
	Tue, 20 Jan 2026 18:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mb9RRNfJ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA124314A9D;
	Tue, 20 Jan 2026 18:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768932633; cv=none; b=ElbZCt+bBI7vtWLjJeM4vgVrRj8zvXXFJbV1+EZjfQCwEugVebe7Bf3vVO7WYeGf2ej0th4uT/0dA5mxhdSG+N3/GZkhkTnP4EFToD8BgFoaYXMKjqKyY+BioCjmUjrr11XoGA3xfSfxYkWWdrHNa9EYoD1d3zCbpKQUhQW+A0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768932633; c=relaxed/simple;
	bh=z4qhv19x14mJR2BlyaLHoajY1A4AII07YFtQh1gYJc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tixF7bf4/v/TUNkaa0ZXFrscZkG2XTU5y/78VCSdSk3e+sC2MsKUdFFmvfvN5QcYl3FyedgMXOySDHEN8ATWc7CUXuqClnwUw9dRn4Am148pZIw67eFE/KCHpMO2niiIuKAoI/T/TBkOxDoZc1KJxM2i/hRNs4Atd52SNtmzqtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mb9RRNfJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED289C16AAE;
	Tue, 20 Jan 2026 18:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768932632;
	bh=z4qhv19x14mJR2BlyaLHoajY1A4AII07YFtQh1gYJc4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Mb9RRNfJjyLzKjUI+XE6tHgNWbzbonmZ5QYGFcUdZzQnvC/RY/e19MfQaUgxhk4g7
	 sBGlUtufESyYxhFpuyB1h1IydMzrTULYsg/rZKSjW/rHKBn0iij8MRHFKUfq3dIyoZ
	 kpH2KgoUTipvxYCZOYT3oYO1/b0jK6RHFhyhsMGD6gVPHFYH0Xo91ilJQpnboEdjB2
	 hjd+FaeFC62PL1duTxbwjH0dRzRmrRG0r33w4fyETblshDJVpdAkF7jeuoIWJDkRiq
	 q2WcmTvUiPpdaH0epXI16mQPlwYLlXjqvjT8epRDh3bquK3RFunEeT6mi02nLm6wob
	 6fOdEybrMVxRA==
Date: Tue, 20 Jan 2026 19:10:30 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Vladimir Zapolskiy <vz@mleia.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
	Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] dt-bindings: pwm: nxp,lpc32xx-pwm: Add optional
 Motor Control PWM interrupt
Message-ID: <b3r6azklrc2p5v7eb22hjh6uivxfm3uevrfvalmgz5ijrzeqgp@c2rfbscdhaij>
References: <20260110014524.3379187-1-vz@mleia.com>
 <20260110014524.3379187-2-vz@mleia.com>
 <20260112-garnet-axolotl-of-acceptance-3978fd@quoll>
 <20bd5723-212b-474d-84ea-52dec73a5333@mleia.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="amfavhcheyxo4tm4"
Content-Disposition: inline
In-Reply-To: <20bd5723-212b-474d-84ea-52dec73a5333@mleia.com>
X-Spamd-Result: default: False [-2.06 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7974-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ukleinek@kernel.org,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 452D34A1DF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--amfavhcheyxo4tm4
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/2] dt-bindings: pwm: nxp,lpc32xx-pwm: Add optional
 Motor Control PWM interrupt
MIME-Version: 1.0

Hello,

On Mon, Jan 12, 2026 at 12:14:39PM +0200, Vladimir Zapolskiy wrote:
> On 1/12/26 11:10, Krzysztof Kozlowski wrote:
> > On Sat, Jan 10, 2026 at 03:45:23AM +0200, Vladimir Zapolskiy wrote:
> > > NXP LPC32xx Motor Control PWM has an interrupt line shared with TIMER=
4,
> > > and the interrupt may be used to report events from programmable coun=
ters
> > > e.g. timer counter limit (period), match counter (pulse-width), or fr=
om
> > > counters on input lines of PWM channels.
> > >=20
> > > As a reference and for more details see NXP LPC32xx User Manual, tabl=
e 595.
> > >=20
> > > Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
> > > ---
> > >   .../devicetree/bindings/pwm/nxp,lpc3220-pwm.yaml       | 10 +++++++=
+++
> > >   1 file changed, 10 insertions(+)
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/pwm/nxp,lpc3220-pwm.ya=
ml b/Documentation/devicetree/bindings/pwm/nxp,lpc3220-pwm.yaml
> > > index cdd83ac29caf..53520f005acb 100644
> > > --- a/Documentation/devicetree/bindings/pwm/nxp,lpc3220-pwm.yaml
> > > +++ b/Documentation/devicetree/bindings/pwm/nxp,lpc3220-pwm.yaml
> > > @@ -32,6 +32,16 @@ required:
> > >   allOf:
> > >     - $ref: pwm.yaml#
> > > +  - if:
> > > +      properties:
> > > +        compatible:
> > > +          contains:
> > > +            enum:
> > > +              - nxp,lpc3220-motor-pwm
> > > +    then:
> > > +      properties:
> > > +        interrupts:
> > > +          maxItems: 1
> >=20
> > Properties must be defined in top-level. You only narrow constraints or
> > disallow them :false per variant in if:then: blocks.
>=20
> It makes sense. In this case would it be better to split the schema file
> into two, one for each PWM type? Two described PWM types are too unsimila=
r,
> apparently it was wrong to merge them under a single .yaml file in the co=
mmit
> 4cd2f417a0ac ("dt-bindings: pwm: Convert lpc32xx-pwm.txt to yaml format").

No strong feeling either way from my side. I marked this patch as
"changes requested" in patchwork and drop if from my mailbox.

Best regards
Uwe

--amfavhcheyxo4tm4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmlvxRMACgkQj4D7WH0S
/k7LjQgArQ9OG0El4KPIYCalTIisTIEIwv4joOjv55eqJE0bjoWhg6KaFm9l59Sw
WNLOOAT5qSrdCtehO6+D3We5OEFUvS85BSvpB1Kgd9Ka4Uk4/M98zxrJILTEw6/s
5ZrgxvBb/5fPg2XWueaZ43KWCxPPe5QQa3k4/0AJluJd8azKAVKI0BROw8dzHEt6
+BdT12rgpYzVPpzmqPPlYJMcCscXrkMtAq+8zMUACcw4Ufgv57+nU4aMzqRJwvgP
CK6Iv7bxhMOpMyngWfg8EKFduZeGd6MuJBgPY+UQl7HXcvb1/GfKKSORhMk8qznC
Mn+DpQ607KeYZH7phzglWRKALeMucw==
=Znar
-----END PGP SIGNATURE-----

--amfavhcheyxo4tm4--

