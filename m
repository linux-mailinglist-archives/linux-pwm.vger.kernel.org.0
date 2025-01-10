Return-Path: <linux-pwm+bounces-4580-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 872B1A08DBE
	for <lists+linux-pwm@lfdr.de>; Fri, 10 Jan 2025 11:22:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EB633A60B9
	for <lists+linux-pwm@lfdr.de>; Fri, 10 Jan 2025 10:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0957B20A5FC;
	Fri, 10 Jan 2025 10:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PPTcRcZd"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEFB61C3C04;
	Fri, 10 Jan 2025 10:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736504520; cv=none; b=f6860S6pGT23EdSqJ19FJKymea1ewEK+mCcq47q+/ozoh7nr+jkVwOikxLdeACqTI+UKSnyQEf/1mtP0vxPtMUUxon/0b/ui+aC9miY18Q5tqy9L+jqHda0gJ8hfjDGszfX59eEK+UvHPRFUFsXtLEkU96XzzAGcLijOAzcEcY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736504520; c=relaxed/simple;
	bh=KZFaGRzO42N3iOtxZMGsNXlcKOn51BtlCOw1JMLOfhM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G6U9KxfWimdAxM+KS1n1xGjjlOFfETyihMml8p5nPO1kbW1SW+Aed+x40IlOqcfurfTVEwTVZR1MAlCVoqY3u2ZrqtljxpeaZGchBMpKt8U5k/o/VJ0vMRA9YHkfffoB7FaySRHFMmyhhPJ+t9OmQfl3OQbjurdlV59Y7SNVqaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PPTcRcZd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E14C4C4CED6;
	Fri, 10 Jan 2025 10:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736504520;
	bh=KZFaGRzO42N3iOtxZMGsNXlcKOn51BtlCOw1JMLOfhM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PPTcRcZdS96583Dr6442J01etvfZD9Xg4Bt4ehvfEsqcBE7vSMZtvh1uX6yQToUD6
	 nCOhSaXTJUu9gwLxvxmm+sPGrCJrRMEi9Sys6x7jO8IxNUSPZ/llnMtLkTKrA8sxND
	 ygfDKMoMztaMpX2KLQ1V37yBiXFNhpxEQc8hhkujKcnUki2TGp+ItFR+IeokIWZN+F
	 tYOs4wKQZbl9y6bcoo5/BlSWT0Yj1S2xKNZSQrS3uZ+oojnH2EcZrUyTryJlzHSdKk
	 ijGQ2CPBWuC4XZ4OBLlJLOHKezxnXwlymf+qZ64EgTkLIXL4qXd/LUqLBtT+hVdk1H
	 3FGRefYZa6+GA==
Date: Fri, 10 Jan 2025 11:21:57 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Kever Yang <kever.yang@rock-chips.com>
Cc: heiko@sntech.de, linux-rockchip@lists.infradead.org, 
	linux-pwm@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, 
	Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 11/17] dt-bindings: pwm: rockchip: Add
 rockchip,rk3562-pwm
Message-ID: <qtcyfcdgrtyjtwaexxkspbvncdckpzentq4nmxthr4hgtfzqvx@x44hdqzkisqv>
References: <20241224094920.3821861-1-kever.yang@rock-chips.com>
 <20241224094920.3821861-12-kever.yang@rock-chips.com>
 <qvr7x4anlxxtpxjywrqjihxyxejw4i73wrh2ibl3hasayew4s2@obyuxce4ez4g>
 <46372c17-d317-4477-9635-36564c73cc6a@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gt6eakxipv7gzido"
Content-Disposition: inline
In-Reply-To: <46372c17-d317-4477-9635-36564c73cc6a@rock-chips.com>


--gt6eakxipv7gzido
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 11/17] dt-bindings: pwm: rockchip: Add
 rockchip,rk3562-pwm
MIME-Version: 1.0

On Fri, Jan 10, 2025 at 06:09:24PM +0800, Kever Yang wrote:
> Hi Uwe,
>=20
> =A0=A0=A0 Thanks very much for your review.
>=20
> On 2024/12/27 15:24, Uwe Kleine-K=F6nig wrote:
> > On Tue, Dec 24, 2024 at 05:49:14PM +0800, Kever Yang wrote:
> > > Add rockchip,rk3562-pwm compatible string.
> > >=20
> > > Signed-off-by: Kever Yang<kever.yang@rock-chips.com>
> > What is your merge plan here? From my POV merging the pwm update via my
> > pwm tree would be the easiest. But if you want to let it go via (say)
> > arm-soc to have it all in a single tree soon and then base new
> > development on top of that, that would be fine for me, too.
> I send this in a patch set for a new soc and board because there is
> no driver change needed, and I think it would be more clear for the new s=
oc
> support. It will be great if maintainers like you can pick the patches
> for the module which I guess is preferred way in the kernel maintain rule?
> Or else I have to follow the comments fromKrzysztof to send patches one
> by one separately.

Sometimes it's sensible to let a complete machine/SoC support go in
together via a single tree, but if there are no such necessities, that's
fine for me.

In that case it's a good idea to explicitly mention dependencies between
the patches in the cover letter and ask for individual application.

Best regards
Uwe

--gt6eakxipv7gzido
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmeA9MMACgkQj4D7WH0S
/k5D1wf9HrQkx97o93w9Uwklb5T1csbudprqqwZx1eOhIrwaVPLb2LUqjKdW/ZKC
jKJYsEIuw908eaNx9TpTt4eFqyataXJzcEvi0s2PnqjRygAfQR4zML5yA9U4C4jU
KlsNtfCei41fD8u7G1CW+OwYI2cUUC7NtYrrZ3VndVaHpJlo8NXdRYpcI/U3pHIG
hUi4SNniHkpyWgFlxu0pLUcjjhHe9ur6kX1TMjUXQcSShWa7Iv2j7ZZzErRuJCPM
ZAP3v3z0YPM9rXl/TofONk4W53rmvyiATSVmJwieHYPq8o63oGdau10dmkfIHy2t
+jciLqLZ+v2JB1lJfD7hvzqPbL3BIw==
=v+BO
-----END PGP SIGNATURE-----

--gt6eakxipv7gzido--

