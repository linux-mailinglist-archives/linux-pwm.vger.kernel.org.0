Return-Path: <linux-pwm+bounces-8160-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WLxLMR06n2m5ZQQAu9opvQ
	(envelope-from <linux-pwm+bounces-8160-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 25 Feb 2026 19:06:21 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E8519BFFC
	for <lists+linux-pwm@lfdr.de>; Wed, 25 Feb 2026 19:06:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D5B7030ABF7D
	for <lists+linux-pwm@lfdr.de>; Wed, 25 Feb 2026 18:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91FED2D6401;
	Wed, 25 Feb 2026 18:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ji+qU+Ba"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6472C15BA
	for <linux-pwm@vger.kernel.org>; Wed, 25 Feb 2026 18:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772042621; cv=none; b=R9e4rVplKOJ2hjKxh4vMyHpSAq//txDqofEp/B5Gnbj7TRUUSDnhqvtcxF2AXJ/Gu6R3rMoD7O+1O/pdm61qXSD4vmGwgLGG2TYCOiyl3S3HKBkFAvEC3MC0WNUR5VtO+Z4y4xAWglVOzLG2AYi4VAj0aMgaCv/YIuIcLl8Xhy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772042621; c=relaxed/simple;
	bh=tjI/17jbAsUhi8wOGSErCgeg5cVy/WV9eTUDfdv7nVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pT4ByHowbUSWS3oaQ41JONyYJKtTdzzRMnPl3KqSXhVyjpHUOH+RIbcwgKdf9lo7kl4SB59XFPCB6Q9Y3mbsqxQHYuKhzIyMQwAaeObN6xJV+CqcUKEcluPQnjBCBwYmcBy2PZiJDCREpqLMcS/RVoN/ecfLpllydSjLM2f0Vtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ji+qU+Ba; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB0CCC116D0;
	Wed, 25 Feb 2026 18:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772042621;
	bh=tjI/17jbAsUhi8wOGSErCgeg5cVy/WV9eTUDfdv7nVI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ji+qU+BaY/fHEuLmjqYGJbK4up2UjTL+Yf58Yavl3/T00cqKn0wz77dbrasKE32Ox
	 XnDnG1q/niN1fX/aP6pSllzSOl9ZAt20CcgofJBUrYshq2rZPU8yR9UStCzRP1LX4S
	 oXghvhKtA54j1ReOQmfXsAsJkUGGG5jpAGxKU4HSmXUwZWYyY6aQdTOJgT2V3hcX9x
	 N06w4+MmQj5R+fL9zf0yMbmCIWOHh61QsgW4FFJDt2Fx5sg9wxg8JrleTA4AoSbyv5
	 ABFP0MZhgNBpql3TEL/YOqN2aRzQl8Miom44ad7i1meF3Bb4opA/0xLm7GQSIEVgYe
	 ZCfXdAGqQLtCw==
Date: Wed, 25 Feb 2026 18:03:36 +0000
From: Conor Dooley <conor@kernel.org>
To: Linus Walleij <linusw@kernel.org>
Cc: Yu-Chun Lin <eleanor.lin@realtek.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	linux-pwm@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, brgl@kernel.org, james.tai@realtek.com,
	cy.huang@realtek.com, stanley_chang@realtek.com,
	tychang@realtek.com
Subject: Re: [PATCH 5/8] dt-bindings: pinctrl: realtek: add RTD1625 pinctrl
 binding
Message-ID: <20260225-reconvene-troubling-947eb972cef8@spud>
References: <20260128033936.27642-1-eleanor.lin@realtek.com>
 <20260128033936.27642-6-eleanor.lin@realtek.com>
 <CAD++jL=445wx467ZKE3-qm_BaVzKYXE-7zmReTFZA0KUAaSNyw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/cVZ3ZprakcW3CWN"
Content-Disposition: inline
In-Reply-To: <CAD++jL=445wx467ZKE3-qm_BaVzKYXE-7zmReTFZA0KUAaSNyw@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8160-lists,linux-pwm=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[conor@kernel.org,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 39E8519BFFC
X-Rspamd-Action: no action


--/cVZ3ZprakcW3CWN
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 28, 2026 at 01:33:00PM +0100, Linus Walleij wrote:
> Hi Yu-Chun,
>=20
> thanks for your patch!
>=20
> [Uwe, can you check this a bit down!]
>=20
> On Wed, Jan 28, 2026 at 4:39=E2=80=AFAM Yu-Chun Lin <eleanor.lin@realtek.=
com> wrote:
>=20
> > From: Tzuyi Chang <tychang@realtek.com>
> >
> > Add device tree bindings for RTD1625.
> >
> > Signed-off-by: Tzuyi Chang <tychang@realtek.com>
> > Co-developed-by: Yu-Chun Lin <eleanor.lin@realtek.com>
> > Signed-off-by: Yu-Chun Lin <eleanor.lin@realtek.com>
>=20
> Overall this looks good!

Where can I find the binding patch? What this is in-reply-to does not
exist:
https://lore.kernel.org/all/CAD++jL=3D445wx467ZKE3-qm_BaVzKYXE-7zmReTFZA0KU=
AaSNyw@mail.gmail.com/
Nor can I find anything else from Eleanor that would appear to be what
this is:
https://lore.kernel.org/all/?q=3Df%3Aeleanor.lin%40realtek.com

>=20
> > +      power-source:
> > +        description: |
> > +          Valid arguments are described as below:
> > +          0: power supply of 1.8V
> > +          1: power supply of 3.3V
> > +        enum: [0, 1]
>=20
> OK...
>=20
> > +      slew-rate:
> > +        description: |
> > +          Valid arguments are described as below:
> > +            0: ~1ns falling time
> > +            1: ~10ns falling time
> > +            2: ~20ns falling time
> > +            3: ~30ns falling time
> > +        enum: [0, 1, 2, 3]
>=20
> Slew rate is usually something like volts/second in SI units, I would
> expect that this differs depending on which power-source is selected?
> I.e. are these values for 1.8V or 3.3V?
>=20
> > +      realtek,drive-strength-p:
> > +        description: |
> > +          Some of pins can be driven using the P-MOS and N-MOS transis=
tor to
> > +          achieve finer adjustments.
>=20
> Finer compared to what? Compared to the overall setting for slew-rate or
> drive-strength, or both?
>=20
> > The block-diagram representation is as
> > +          follows:
> > +                         VDD
> > +                          |
> > +                      ||--+
> > +               +-----o||     P-MOS-FET
> > +               |      ||--+
> > +          IN --+          +----- out
> > +               |      ||--+
> > +               +------||     N-MOS-FET
> > +                      ||--+
> > +                          |
> > +                         GND
>=20
> Nice picture!
>=20
> > +          The driving strength of the P-MOS/N-MOS transistors impacts =
the
> > +          waveform's rise/fall times. Greater driving strength results=
 in
> > +          shorter rise/fall times. Each P-MOS and N-MOS transistor off=
ers
> > +          8 configurable levels (0 to 7), with higher values indicating
> > +          greater driving strength, contributing to achieving the desi=
red
> > +          speed.
> > +
> > +          The realtek,drive-strength-p is used to control the driving =
strength
> > +          of the P-MOS output.
> > +        $ref: /schemas/types.yaml#/definitions/uint32
> > +        minimum: 0
> > +        maximum: 7
> > +
> > +      realtek,drive-strength-n:
> > +        description: |
> > +          Similar to the realtek,drive-strength-p, the realtek,drive-s=
trength-n
> > +          is used to control the driving strength of the N-MOS output.
> > +        $ref: /schemas/types.yaml#/definitions/uint32
> > +        minimum: 0
> > +        maximum: 7
>=20
> These two are really interesting. But what do these settings represent?
>=20
> I would *guess* it represents the number of transistors used, simply,
> so 0 means just one P/N transistor is driving and 7 means 8 transistors
> are driving.
>=20
> Can you provide details here?
>=20
> In this case, maybe we want a generalized property such as
> drive-stages-p =3D <n>;
> drive-stages-n =3D <n>;
>=20
> in the generic bindings, if this will appear from more vendors?
>=20
> > +      realtek,duty-cycle:
> > +        description: |
> > +          An integer describing the level to adjust output duty cycle,
> > +          controlling the proportion of positive and negative waveform=
s in
> > +          nanoseconds.
> > +          Valid arguments are described as below:
> > +          0: 0ns
> > +          2: + 0.25ns
> > +          3: + 0.5ns
> > +          4: -0.25ns
> > +          5: -0.5ns
> > +        $ref: /schemas/types.yaml#/definitions/uint32
> > +        enum: [0, 2, 3, 4, 5]
>=20
> This is a bit dubious.
>=20
> Isn't this one of those cases where you should be using the PWM
> bindings, directly in this node? Just slam in #pwm-cells =3D <...> etc,
> I think this is what you really want.
>=20
> Please consult/reference:
> Documentation/devicetree/bindings/pwm/pwm.yaml
> consumers would not use pinctrl phandles but something like
> pwms =3D <&pwm ....>;
>=20
> It's maybe a bit trixy to use two generic bindings in the
> node but it should be just fine.
>=20
> I don't feel confident mergeing this without Uwe Kleine-K=C3=B6nig's revi=
ew.

This does sound like a pwm to me too, but I can't see the rest of the
series to comment.


> > +      realtek,input-voltage:
> > +        description: |
> > +          Select the input receiver voltage domain for the pin (1.8V o=
r 3.3V).
> > +          This defines the reference for VIH/VIL and must match the ex=
ternal
> > +          signal level.
> > +
> > +          This does not control the output drive voltage, which is han=
dled by
> > +          the standard generic 'power-source' property.
> > +
> > +          Valid arguments are described as below:
> > +          0: 1.8V input logic level
> > +          1: 3.3V input logic level
> > +        $ref: /schemas/types.yaml#/definitions/uint32
> > +        enum: [0, 1]
>=20
> This looks very generic. Can you please just add input-voltage to
> pincfg-node.yaml with a custom format and reference that?

Why a custom format, rather than input-voltage-microvolt or w/e?

Cheers,
Conor.

>=20
> > +      realtek,high-vil:
> > +        type: boolean
> > +        description: |
> > +          Select the input receiver with a higher LOW recognition thre=
shold
> > +          (VIL) to improve detection for sources with weak pull-down o=
r slow
> > +          falling edges.
>=20
> Isn't this supposed to be input-schmitt-microvolt?
>=20
> Or is this something else than a schmitt trigger?
>=20
> In either case, try to figure out the typical recognition threshold in mi=
crovolt
> and use that, please.
>=20
> Yours,
> Linus Walleij

--/cVZ3ZprakcW3CWN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaZ85eAAKCRB4tDGHoIJi
0pCJAQCOgynGYTPPfulsHK5QnaiaeM/j3cYU0OluS0Hk1UYTwwEAw8d2OoCS4PS2
Ttva4ReaeiOzhVvejjR4ftjomjh5CQg=
=OsoX
-----END PGP SIGNATURE-----

--/cVZ3ZprakcW3CWN--

