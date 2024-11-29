Return-Path: <linux-pwm+bounces-4171-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96D779DEB2E
	for <lists+linux-pwm@lfdr.de>; Fri, 29 Nov 2024 17:40:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B50B2807DE
	for <lists+linux-pwm@lfdr.de>; Fri, 29 Nov 2024 16:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E36C1474A7;
	Fri, 29 Nov 2024 16:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T+hITyal"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F1A44C77;
	Fri, 29 Nov 2024 16:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732898398; cv=none; b=DVb+iA1Op/37SZkLcdfQ666PSKEP5dAf+Pwavj2x5fBpTLwFYTSRGD2L2Ha4sL4LK5alj6UfILsler/mMjpvNaHIUwl/cK66CgtPfnSgbop1+5iNVpr+m63Va4n2WWEJp7CS3M9ZI14Qwm43A25KzRfqiIEYW8lC63CQgkvikto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732898398; c=relaxed/simple;
	bh=o/XHuQjqUCNdCnp0GPnthWhFOFHb1KDgppZGdAgrSfY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jA/D9ZvqsUY1RVChqfe2kAPkIvkBl38YHSpjGvgwQIwK95t6CdQs5KYM1gymvTDVnKM74L8sekg5l8sRjPoUGx6CdWPtEIWa0VMvDEnLY+WdFXiQg5XnVmG6Ws1EXvEaw/0wfW41r8K16UEDRWtjNUvFlpC+q1kQovaumjMjNiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T+hITyal; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6EFFC4CECF;
	Fri, 29 Nov 2024 16:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732898396;
	bh=o/XHuQjqUCNdCnp0GPnthWhFOFHb1KDgppZGdAgrSfY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T+hITyalUhRVwvksgWjIiXjVT9QMUfhYekEFMFKiWHT4ko4UpNOEzC+pXIFBWvusq
	 AgjhxsmsDZ+bKH0MEBoKxyx8JUrGrhwCcplCgKVIPi/J/2QhosFG6p5bBUCjWRu/80
	 KDK+uLU+gBLUGG5hmIdvGMvOhNLAvYdqptdodsP/oJodCZe/HtHX+jTigMS2REW9Yu
	 OUNiekS1po0aU2md+sQVC3xLN8+a7ArWymqPWBhfwxkeMJGaJbwUoTnYUE8U6se7IG
	 LWyZs1SY65VXeqtAMLrSYFNvWCQzxW47BamfNeeJTNPuynCygWrMxG6sE+xpSa4wcF
	 e8fJbFwYAbxPA==
Date: Fri, 29 Nov 2024 17:39:52 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	"linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	"biju.das.au" <biju.das.au@gmail.com>
Subject: Re: [PATCH v22 1/4] dt-bindings: pwm: Add RZ/G2L GPT binding
Message-ID: <oyfqxmjce2edq6jgyzrjzubfwf6m5dt5s5ojhmuycquktrcutf@n7uqufaxmyrz>
References: <20241018130049.138775-1-biju.das.jz@bp.renesas.com>
 <20241018130049.138775-2-biju.das.jz@bp.renesas.com>
 <7r7euw7h5fln3y5hy3zkrm4n4fafh5ww3ydxnwcpcjhbpb5vza@fleninlwsaqb>
 <TY3PR01MB113469F250419F13DCBB9A95D862A2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6gwoa7j7cfo44lzf"
Content-Disposition: inline
In-Reply-To: <TY3PR01MB113469F250419F13DCBB9A95D862A2@TY3PR01MB11346.jpnprd01.prod.outlook.com>


--6gwoa7j7cfo44lzf
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v22 1/4] dt-bindings: pwm: Add RZ/G2L GPT binding
MIME-Version: 1.0

Hello Biju,

On Fri, Nov 29, 2024 at 09:10:02AM +0000, Biju Das wrote:
> > -----Original Message-----
> > From: Uwe Kleine-K=F6nig <ukleinek@kernel.org>
> > Sent: 29 November 2024 08:51
> > To: Biju Das <biju.das.jz@bp.renesas.com>
> > Subject: Re: [PATCH v22 1/4] dt-bindings: pwm: Add RZ/G2L GPT binding
> >=20
> > On Fri, Oct 18, 2024 at 02:00:42PM +0100, Biju Das wrote:
> > >  .../bindings/pwm/renesas,rzg2l-gpt.yaml       | 378 ++++++++++++++++=
++
> > >  1 file changed, 378 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/pwm/renesas,rzg=
2l-gpt.yaml
> >=20
> > Wow, quite a big binding. An astonishing amount of irqs.
> >=20
> > > [...]
> > > +  '#pwm-cells':
> > > +    const: 2
> >=20
> > Please make this 3. Otherwise no objections.
>=20
> The hardware supports both polarities. Currently I have added support for=
 normal polarity.
> Subsequent patch will enable inverse polarity.=20
>=20
> Am I missing something here? Please let me know.
>=20
> Or
>=20
> since it is optional, there is no harm in making it to 3 to take care
> of any future additions in pwm.h flags.

3 is the value to use for new drivers. Then you don't need a binding
update when you later add support for inversed polarity. For now it's
only possible to pass 0 as flags, but this is fine for the sake of
consistence among the pwm bindings.

Best regards
Uwe

--6gwoa7j7cfo44lzf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmdJ7lYACgkQj4D7WH0S
/k7vbggAivZAdIVyZFC1byIC4sdT8h2gEk4ldIZQrgxAsmETgAotUCWM+HRVd2jy
/ZBFacDbpBf/hsL0sFzaASKNvnPwRFlHzQCQU9dAX1o1OZEBugwsH2DPjQm1Pvf/
AjdjkJ04qhQRwP2QmK2xL9VHvM/zT10tJ74Gi14/ei3+iKyuS4VdLb8oVunY3LXa
Wqy7j2gE4ORlXpO4k1TAr5jRVBoAFus4xkvUIdNa5e18cihjL43ZHmLxkwY8HO8W
ZK48uHa43jcX+s3gE4PcvZm81Qe5q1YlwVNqP9UpkHdO9Be3LXOooXO+ysgMJA3A
+Znigdi8epacsfifdf77JwV+1OIz7Q==
=FLvT
-----END PGP SIGNATURE-----

--6gwoa7j7cfo44lzf--

