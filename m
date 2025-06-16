Return-Path: <linux-pwm+bounces-6384-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB1B2ADB5B9
	for <lists+linux-pwm@lfdr.de>; Mon, 16 Jun 2025 17:44:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 192983B0155
	for <lists+linux-pwm@lfdr.de>; Mon, 16 Jun 2025 15:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29FE42701D0;
	Mon, 16 Jun 2025 15:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pNxQ978V"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAFBB269CF0;
	Mon, 16 Jun 2025 15:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750088664; cv=none; b=qwIByfyWx5j7qix6Jj2V8eF+rwmNeVuaw1HL4k07hae82+FN8xcZcbjpff3PgtDWwj20NaMYie9wgnFBHZ1TzxU7Ari3+HOUgAbpWyQ0+Kq5C9/kqwA38n6zO4N1YsdkPiUfSNnsT/FP7P5vPnyP1gp6g7qbYSwdrlq+D0CtDpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750088664; c=relaxed/simple;
	bh=zMy+y5c/8mfi8FAA89LQATnBS6oZZIjVu32K5ipEiDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c0LxtxADlvLQWD4jpYpYVjHILSAD5zCqd6myAzozoSXduSJCHEwbv+iGyIFcbllGaIzd9LZ2eUsdCWOP6PHTbtOEZqfLoLq/z/uHKHZonH7/oQgyc0AlSNbXXU9s/kG/R7Yq0L260IT8Ka3KiuJu0XYA6v61dDZmTIXT15viQ/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pNxQ978V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1237C4CEEA;
	Mon, 16 Jun 2025 15:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750088663;
	bh=zMy+y5c/8mfi8FAA89LQATnBS6oZZIjVu32K5ipEiDQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pNxQ978VmTyHAQQ9sM1UZUhVQbkOiaADT141E3DfFXEwOcwu4qEMxMTh1IVstEQGt
	 3PAOJqTKVY8HfvN8cTN+fK2oxDoJ5AkhIlaCRGObXvujSzMrFcaJcYwLfG+Trvg6w4
	 j921Hfcu+9Nad7s08+IUQFyT3vv1PWMl9FhwEnuqJUBBkMYATf9ppHtqBITbPsM6GW
	 GeYE5rVpfhm4iainanvkEnHIJwvNF5wE41xpDPrJNfogRb8E6LNirFmNMK9YjpYFnn
	 p4RkLzn4dxmNQis5Lpyt2r5WaU8IX0y2FEu0CFHx0mShhxY9FLCXOesN5eMnYGP5KQ
	 EpOZ60DvuS6BQ==
Date: Mon, 16 Jun 2025 17:44:20 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc: lee@kernel.org, alexandre.torgue@foss.st.com, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, wbg@kernel.org, jic23@kernel.org, 
	catalin.marinas@arm.com, will@kernel.org, devicetree@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, linux-pwm@vger.kernel.org, 
	olivier.moysan@foss.st.com
Subject: Re: [PATCH v3 4/8] pwm: stm32: add support for stm32mp25
Message-ID: <hsmkc6ydsyjgyq7dkhvcytqrn6uu7ezngknetshkf4kj4mjt3i@3hgg42aq3sd5>
References: <20250110091922.980627-1-fabrice.gasnier@foss.st.com>
 <20250110091922.980627-5-fabrice.gasnier@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ezyzxvlev7k4prvr"
Content-Disposition: inline
In-Reply-To: <20250110091922.980627-5-fabrice.gasnier@foss.st.com>


--ezyzxvlev7k4prvr
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 4/8] pwm: stm32: add support for stm32mp25
MIME-Version: 1.0

Hello Fabrice,

On Fri, Jan 10, 2025 at 10:19:18AM +0100, Fabrice Gasnier wrote:
> Add support for STM32MP25 SoC. Use newly introduced compatible to handle
> new features along with registers and bits diversity.
> The MFD part of the driver fills in ipidr, so it is used to check the
> hardware configuration register, when available to gather the number
> of PWM channels and complementary outputs.
>=20
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>

Applied to
https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for-=
next
=2E

Thanks for your patience
Uwe

--ezyzxvlev7k4prvr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmhQO9IACgkQj4D7WH0S
/k5Gygf9Gy+dDmATpLY1NSgEaVsqseEX8U1OK8Qr0hXVS6DWdx1yiKu/usPB/Ns8
KlFNa+c0Yd/lDEYjkvaLr0FmmGazj3yReZB7iuTBjo42rR4ZMg70Ch92UmhZL4JQ
jWYv+ZLzvdDvyEN1mtPizoYrwazqtK+9ajkbSgIWORogLWD2ieG12tfwpE0FjPjB
IkdnMX9NbFB777pXHx8JZTux0YzwmZ9Y6grswoV2Rdlor2xxm/atUWqAE0g8qRzM
QFCOVen4t50xS6ptchwAsDwMRIrDfmVaiMg3T8tC55Fpix5GOkkzFfunE33BqDhi
kt5RKeBIclzLIGFvx72daCwUDZqidg==
=4Cak
-----END PGP SIGNATURE-----

--ezyzxvlev7k4prvr--

