Return-Path: <linux-pwm+bounces-151-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB0CF7F4E7D
	for <lists+linux-pwm@lfdr.de>; Wed, 22 Nov 2023 18:36:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F70E1F219C4
	for <lists+linux-pwm@lfdr.de>; Wed, 22 Nov 2023 17:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EBD94CDFA;
	Wed, 22 Nov 2023 17:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eu8lf+UQ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2995B5BC;
	Wed, 22 Nov 2023 17:36:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4854DC433C8;
	Wed, 22 Nov 2023 17:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700674598;
	bh=Vza99+xtq+1wLQeh3rk7M9wfNhph6mzwpTZ+i29+N5k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eu8lf+UQ8lxS78Mxw93tY9qK+MnxSy1BtNRiLd8+eS9R31GqQxBBks3Gzx0pFkbcy
	 doqzjlz/x1XXXLbJmai3iZKJbx29szV2aJidObn4mHv49HHst47H0JReAaH6mCB3/r
	 JpLXyIbeatYpCd1+ek6uZhbMXrvRsthb8ZkzRs/M1yte6Hutyh31Y6P7yoRPFYOzcL
	 cM+/FVpaTqjjN3KLj3qqKS9JVO6MYw8fYDkXu3wJ2OBnXh2bg6nkmF8N4inruHZZvP
	 BQQBaC+DUmDBc1t8nQ+inJZWemDM64XSFPhpM/klRR5Sq1o/wvzVEHJsepeXc6UJia
	 aVkW3mkMMwNew==
Date: Wed, 22 Nov 2023 17:36:32 +0000
From: Conor Dooley <conor@kernel.org>
To: William Qiu <william.qiu@starfivetech.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-pwm@vger.kernel.org,
	Emil Renner Berthing <kernel@esmil.dk>,
	Rob Herring <robh+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Hal Feng <hal.feng@starfivetech.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Subject: Re: [PATCH v7 1/4] dt-bindings: pwm: Add OpenCores PWM module
Message-ID: <20231122-jokester-reapply-eb000d976d56@spud>
References: <20231110062039.103339-1-william.qiu@starfivetech.com>
 <20231110062039.103339-2-william.qiu@starfivetech.com>
 <afce202d-6234-4c5f-9018-facd9a56b5eb@linaro.org>
 <f4551a7a-61e6-4d97-94c2-da2e4e9e8cb3@starfivetech.com>
 <824cee7b-e4d3-461a-8bfb-4ad095c240fd@linaro.org>
 <20231113-sprung-tantrum-94659009b9d4@squawk>
 <1ba3e8d1-ed89-4aab-ae27-d8d31ee2f150@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="9e0gDyQKikb1dEdb"
Content-Disposition: inline
In-Reply-To: <1ba3e8d1-ed89-4aab-ae27-d8d31ee2f150@starfivetech.com>


--9e0gDyQKikb1dEdb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 22, 2023 at 03:03:36PM +0800, William Qiu wrote:
>=20
>=20
> On 2023/11/14 4:17, Conor Dooley wrote:
> > On Mon, Nov 13, 2023 at 09:07:15PM +0100, Krzysztof Kozlowski wrote:
> >> On 13/11/2023 10:42, William Qiu wrote:
> >> > Will update.
> >> >>> +
> >> >>> +allOf:
> >> >>> +  - $ref: pwm.yaml#
> >> >>> +
> >> >>> +properties:
> >> >>> +  compatible:
> >> >>> +    oneOf:
> >> >>> +      - items:
> >> >>> +          - enum:
> >> >>> +              - starfive,jh7100-pwm
> >> >>> +              - starfive,jh7110-pwm
> >> >>> +          - const: opencores,pwm
> >> >>
> >> >> That's a very, very generic compatible. Are you sure, 100% sure, th=
at
> >> >> all designs from OpenCores from now till next 100 years will be 100%
> >> >> compatible?
> >> >>
> >> > My description is not accurate enough, this is OpenCores PTC IP, and=
 PWM
> >> > is one of those modes, so it might be better to replace compatible w=
ith
> >> > "opencores, ptc-pwm"
> >> >=20
> >> > What do you think?
> >>=20
> >> Sorry, maybe this answers maybe doesn't. What is "PTC"?
> >=20
> > "pwm timer counter". AFAIU, the IP can be configured to provide all 3.
> > I think that William pointed out on an earlier revision that they have
> > only implemented the pwm on their hardware.
> > I don't think putting in "ptc" is a sufficient differentiator though, as
> > clearly there could be several different versions of "ptc-pwm" that have
> > the same concern about "all designs from OpenCores for now till the next
> > 100 years" being compatible.

Perhaps noting what "ptc" stands for in the description field would be a
good idea.

> After discussion and review of materials, we plan to use "opencores,ptc-p=
wm-v1"
> as this version of compatible, so that it can also be compatible in the f=
uture.
>=20
> What do you think?

Do we know that it is actually "v1" of the IP? I would suggest using the
version that actually matches the version of the IP that you are using
in your SoC.

Thanks,
Conor.

--9e0gDyQKikb1dEdb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZV48IAAKCRB4tDGHoIJi
0nnhAP0dO+HuU6VJxyhYQTYCOgtFy1M7siCtU/9xX8hHaon4MgEA3d9vorRE+CH8
uSLzgEykIwm2UD5v+hkW0uBeHJrQ8wk=
=AWCX
-----END PGP SIGNATURE-----

--9e0gDyQKikb1dEdb--

