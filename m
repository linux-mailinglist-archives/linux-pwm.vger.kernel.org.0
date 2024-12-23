Return-Path: <linux-pwm+bounces-4470-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6461D9FB37F
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Dec 2024 18:12:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B95A1884213
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Dec 2024 17:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2459B1B4126;
	Mon, 23 Dec 2024 17:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wbgmi2zp"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF326482ED;
	Mon, 23 Dec 2024 17:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734973929; cv=none; b=BVVjmhqJ5Fyo1xhs0H0QH+a+6S36UTWDRdqHvTQd3WqGva3ldx9uUIzbhaaNM3UB55LX5XPmzLvUKi/Kli7fqOcCFSF3zwEtk+g59PJdZhmnhpM2DTZ18B+1t5HqZZfG8PA78DpEkED239JDT/IcrXujn7AUxM2+/pMQ/iFK8N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734973929; c=relaxed/simple;
	bh=wwRttVYzYFx4SEqahRXroiq61I9r7WSdOCujIaurdms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P9/ZhFEPY8qnAg3vAX0udWVKdGnFngz5NdJa/Cgdl2RPh8xx1BDkLSWajc9GDkxlt0sNMKz+nT4qNyQ8tph5561N7EF+K2KJVRai36QvmBLg9mMhPtun5+ZfSx7Kdfvr/WFHKGt2zVIviG/RIGHGLjP/yc6k8jglLA9ILBxzeqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wbgmi2zp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 137A5C4CED3;
	Mon, 23 Dec 2024 17:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734973928;
	bh=wwRttVYzYFx4SEqahRXroiq61I9r7WSdOCujIaurdms=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Wbgmi2zpw801GNJt1pkzIPqYry3B2v1GR1jLuOARMC+BwZXLMYKYZGXtBS1zGpQij
	 V6GuUjDzJmN6fRfHIxY6AWXsirje0l8KQD3VplGlSRGnkIm03zbztltkPTpxwBfpJA
	 Q1bKZphFrzgjAh6uG1CKotmQGdo56FLIXAv/FAy3Px8wq3oJjoEMq8rQUs71A5/2+y
	 +dlm/RFCq5+Nnp2WV+RgV291qa7IW2GpDAXCQ9fsUhKVvBlxIEK5ixhuF/LlY8kxkn
	 RaIn0F6C6Xmodart0DVC/lVOZnDFzZFU3LkoyOCSVQ77UbFXttyH9Z8gRq/nZps+nf
	 zAJLfWtkFpyWw==
Date: Mon, 23 Dec 2024 18:12:05 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: William Qiu <william.qiu@starfivetech.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, Hal Feng <hal.feng@starfivetech.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH v16] pwm: opencores: Add PWM driver support
Message-ID: <52j6gtyzf4uwfkxxlfschygnvuwl2l4iaf7mzbi2nbzxtmlemf@dktywu73nldg>
References: <20241028014609.153997-1-william.qiu@starfivetech.com>
 <bfwpcffdrxqjes4atio6deltu5tgmd4ing7j4yewwp6jprqmmc@rv2x3qudlzo3>
 <ZQ0PR01MB1253A5B870FF90900A2643009F02A@ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dafvxmpsmlmm6kt4"
Content-Disposition: inline
In-Reply-To: <ZQ0PR01MB1253A5B870FF90900A2643009F02A@ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn>


--dafvxmpsmlmm6kt4
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v16] pwm: opencores: Add PWM driver support
MIME-Version: 1.0

Hello William,

On Mon, Dec 23, 2024 at 02:47:59AM +0000, William Qiu wrote:
> > > +	duty_data =3D mul_u64_u32_div(state->duty_cycle, ddata->clk_rate,
> > NSEC_PER_SEC);
> > > +	if (!duty_data)
> > > +		return -EINVAL;
> >=20
> > I can understand that period_data =3D=3D 0 is an error, but duty_data =
=3D=3D 0
> > could/should just work?!
>
> It means no need to check whether the duty is valid?=20

No, it means that I expect that duty_data =3D=3D 0 is a valid setting and
most controllers support it.

Best regards
Uwe

--dafvxmpsmlmm6kt4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmdpmeMACgkQj4D7WH0S
/k4XIggAhsvY4QRMqJbvVPJrAcWHSljqDjtFCkLc3kpRiaeEAeAOUGqsbcDZukSA
w/Ma+hfWiJc9DtP7D2g9vxf5SHh1qPqsSGn6ADjLMch/lcgdRg2gntXop3lMSKZm
ajii77yOeiN7Bcou5dkK0LEwx/Rd7jFELlZ6VIbZ4KUklIR0QJDq348+nnHmC849
dznvoIX/DzB7xtx+XEqGsR7EMX+H4sKSoUVWjqhsFkqw1NNgP+DplZG2uxYA3xgr
eEnqDzlURzO7WDQCQHNupNqvAmRvkBj3UCgfQxrB7Dtn0kLW6w9d0YZ4QeVX5FqC
XbDXDISRNnLX3DjBBBJ+JFkgmGdWRw==
=ch0j
-----END PGP SIGNATURE-----

--dafvxmpsmlmm6kt4--

