Return-Path: <linux-pwm+bounces-4258-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A483A9E5E19
	for <lists+linux-pwm@lfdr.de>; Thu,  5 Dec 2024 19:15:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61EA7287B55
	for <lists+linux-pwm@lfdr.de>; Thu,  5 Dec 2024 18:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6184227BBB;
	Thu,  5 Dec 2024 18:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mo0B6B0p"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE7A227BAB;
	Thu,  5 Dec 2024 18:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733422503; cv=none; b=bq8vl78637oqpxqT2x/l6UqKf5QCeYO16y+ldp+PksqDIRdwSE7QkK6x68iaaBN8j5/YNnvWQrkuqxofcy4RW5mAs9RYoIPMB1PlSTkGoUrkmz9tWkDwOObbcb7ulNfBwKPE6v3YBFs+oxpyqXfzyGxqe9FwW+aP6bwA2PYGwRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733422503; c=relaxed/simple;
	bh=xxzkZHV8bU8zs+Js+tnRGqLeNA9OX9QiQEWbAm9heVA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VyQQQWxdPzQLH0sm4FAZhyi+pCk7Ztv8BnljrRuwqSA4mPZQeogm1gmf5zdzPg3fU4+xUESyrEALBUxiUD/6ixXNvZaNZGegthSUUJaB+LuDl6xMktTvLW8A78Z6FbrcT3vzYpmvwEL0ZZHhht4Ngfn/t01dX6UC5oND1shhE/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mo0B6B0p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A206AC4CEDC;
	Thu,  5 Dec 2024 18:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733422503;
	bh=xxzkZHV8bU8zs+Js+tnRGqLeNA9OX9QiQEWbAm9heVA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Mo0B6B0p5goBaxZc60eCkjV/pG80zcP21okgeAi69WhLmLwsFwi1ZdS6bZjWPCRos
	 w85hukDb78kVY9f9J74R1a+EgKnBSwLWpeowwIZUjpu1ljyRuRYsUck3jK5CTkU28d
	 RdPFsUT3b+a20lEPkfejy+PUj1jfwnI6hhVkukOygjM3GSz7dd2RDoUS3TcDuC3oip
	 WgQXiwBKWonpHIK+UJyXTomxDm4tAvN1PkbQpBPBIWSRakxCXjtx4LWWjeh7rLE/hP
	 Q7C99+SP3shP19HizyEZkBniAAfeRzhfz3x83zm08FJl6NdxFHa5DuHNVjjIW7e+X8
	 liKe/5wSFyUaQ==
Date: Thu, 5 Dec 2024 18:14:59 +0000
From: Conor Dooley <conor@kernel.org>
To: "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: adf4371: add rdiv2 and doubler
Message-ID: <20241205-tummy-snorkel-2765ce63dc3f@spud>
References: <20241129153356.63547-1-antoniu.miclaus@analog.com>
 <20241129153356.63547-2-antoniu.miclaus@analog.com>
 <20241130163948.269289dc@jic23-huawei>
 <CY4PR03MB3399CB671D685BA8164E0F3B9B352@CY4PR03MB3399.namprd03.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zhbonRGPyfEtWeAZ"
Content-Disposition: inline
In-Reply-To: <CY4PR03MB3399CB671D685BA8164E0F3B9B352@CY4PR03MB3399.namprd03.prod.outlook.com>


--zhbonRGPyfEtWeAZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 02, 2024 at 09:47:21AM +0000, Miclaus, Antoniu wrote:

> > -----Original Message-----
> > From: Jonathan Cameron <jic23@kernel.org>
> > Sent: Saturday, November 30, 2024 6:40 PM
> > To: Miclaus, Antoniu <Antoniu.Miclaus@analog.com>
> > Cc: robh@kernel.org; conor+dt@kernel.org; linux-iio@vger.kernel.org;
> > devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
> > pwm@vger.kernel.org
> > Subject: Re: [PATCH v3 1/2] dt-bindings: iio: adf4371: add rdiv2 and do=
ubler
> >=20
> > [External]
> >=20
> > On Fri, 29 Nov 2024 17:33:52 +0200
> > Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:
> >=20
> > > Add support for reference doubler enable and reference divide by 2
> > > clock.
> > >
> > > Both of these blocks are optional on the frequency path within the
> > > chip and can be adjusted depending on the custom needs of the
> > > applications.
> > Thanks for the additional info!
> > >
> > > The doubler is useful for increasing the PFD comparison frequency
> > > which will result in a noise performance of the system.
> >=20
> > So I'll play devil's advocate. Improved noise performance sounds
> > good. If it doesn't take me out of range of allowed frequencies, why
> > would I not turn it on?  What is it about the surrounding circuitry
> > etc that would make this a bad idea for some uses of this chip
> > but not others?

Did I miss a response to this?

> > > The reference divide by 2 divides the reference signal by 2,
> > > resulting in a 50% duty cycle PFD frequency.
> >=20
> > why would I want one of those? My 'guess' is this makes sense
> > if the reference frequency is too high after the application of
> > the scaling done by the 5 bit counter.  In effect it means the
> > division circuitry does divide by 1-31, 2-64 in steps of 2.
> >=20
> > That could all be wrapped up in the existing control of the
> > frequency, and so far I'm still not seeing a strong reason why
> > it belongs in DT.
> >=20
> > The 50% cycle thing is a bit of a red herring as assuming it
> > is triggered on say the rising edge of the high frequency signal
> > to toggle the divided signal, that will always be a 50% duty cycle.
> >=20
> As mentioned in the cover letter this was mostly a request from
> customers that are using adf4371 on a large scale and they need
> these features to be controllable somehow by the user.
>=20
> Since these attributes were already validated as devicetree properties
> for adf4350 on mainline, I found this as the best approach to satisfy
> both ends.

Probably shouldn't have allowed it then, but things were different a
decade ago.

--zhbonRGPyfEtWeAZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ1HtowAKCRB4tDGHoIJi
0shwAP4iirJ0ArRmeKHavHbxz14PFZAFnod9h9613bjP1F8svQD/cWqXXRG/KZnF
DML/oiTyMIdibfcqyg9ac+JD/etqfgQ=
=rYRh
-----END PGP SIGNATURE-----

--zhbonRGPyfEtWeAZ--

