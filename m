Return-Path: <linux-pwm+bounces-4283-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F11269E7F15
	for <lists+linux-pwm@lfdr.de>; Sat,  7 Dec 2024 09:46:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEEDE166F76
	for <lists+linux-pwm@lfdr.de>; Sat,  7 Dec 2024 08:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7F96126C08;
	Sat,  7 Dec 2024 08:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rtLrQ+Rd"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA322E3EB;
	Sat,  7 Dec 2024 08:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733561168; cv=none; b=ZAHp9VL8frTuzzYLLewgf8QqrtyBb9O9Le4Z1r4lWKozQOaM9/kMRNwAdi0zetDMVJDMRUXOLOyxMDTP9IEx6AdoIMtaA3fW85F2UOKjJxAPO7IBqSwxLGG4cYW2oknMmjO0hOFkb8Wa5lcbFJYypFFoFkNCQyfVtSi3Lw+CtII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733561168; c=relaxed/simple;
	bh=Wb2cgo90VM0BZt3RlHOwC/RhEANvPqgEySvUWJGLHNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ubxy14UxWw7cuvfJfTCh3fSOAq574cX/AUH45QujPHlfhEcm1CmHhvwzkBMIQBUePrlIXgC0tBVeBv/sSidzGDuPTvl5g/YphfOlYSovRMy2kPfeUrRdv7J4kVGicVk2lxVVLdCoANoJ/x4QbQx5uPKInWbb35JKZs2Pnm3t42E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rtLrQ+Rd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEDEEC4CECD;
	Sat,  7 Dec 2024 08:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733561168;
	bh=Wb2cgo90VM0BZt3RlHOwC/RhEANvPqgEySvUWJGLHNk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rtLrQ+Rd+OhhRS4PtLyFkT1tEKWKZi1Q9Sx3ugJpZjnt1T+VqisNUYf5+KlvWwYdw
	 XXvWQuFrevcUihZySaOXd3jF6YjssUqhHbtJIynYz8PtGI5k/vpyZMizToFTEM3t01
	 nYMlEclv0vuS9WJtSFINB7e4dWb5JnkUQ+a+LyHH/wbYuoDeGoZhzSzA9H6s6pnHOq
	 iGw9IEqC5GY45RlBJsVrtXsgiQ8sUSYO/hrgK7/Vd9v0edhF9gD0kVjbVMSbfRW7vj
	 Iq/ykxKp4ZcEW2eldtsR5TpKxkI2PhKE1/jFN0GGtrEzauIK4l6mB7o2FbHAuW2ekh
	 gTEZr7fBefx3g==
Date: Sat, 7 Dec 2024 09:46:05 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Mingwei Zheng <zmw12306@gmail.com>
Cc: fabrice.gasnier@foss.st.com, mcoquelin.stm32@gmail.com, 
	alexandre.torgue@foss.st.com, hierry.reding@gmail.com, lee@kernel.org, 
	linux-pwm@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Jiasheng Jiang <jiashengjiangcool@gmail.com>
Subject: Re: [PATCH v3] pwm: stm32-lp: Add check for clk_enable()
Message-ID: <4wcwxgo5irzfvyec537ucm4e276fqq36hhw3l64qmoj43hjnmv@byi5mvb2wc2b>
References: <20241206215318.3402860-1-zmw12306@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="oj4rdulsaiobcffa"
Content-Disposition: inline
In-Reply-To: <20241206215318.3402860-1-zmw12306@gmail.com>


--oj4rdulsaiobcffa
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3] pwm: stm32-lp: Add check for clk_enable()
MIME-Version: 1.0

Hello,

On Fri, Dec 06, 2024 at 04:53:18PM -0500, Mingwei Zheng wrote:
> Changelog:
>=20
> v2 -> v3:
>=20
> 1. Add tool name in the commit log.

Thanks.

Applied to

https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for-=
next

=2E

Best regards
Uwe

--oj4rdulsaiobcffa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmdUC0oACgkQj4D7WH0S
/k6mqQf+JDo1gcCBjg9efkJzxZYhmArKsOw3oPJMdypsvvMVg3jtShekC41O0nIT
HRSguGN0MitOyEYsGAV/ZMKr/NiKM8oxOrSa+PNzhikAhjPHpqrfvYAcVqcjtDla
JSnwYVFDfNiI0BUs5ZEHLmB6KAwdiFJS80GumePqh8zQUfIrn55DIZWzpvg0ScAL
Nv8FLKz7o+tO+OiZXSuKwqhl7JCaVh9zQXV5KZoMidQV9WTrmAEiC2HllMDQy+79
Voekd71JC+DB3nE5NSlNEZTEAr5M6/GCgnd5KV+Sme4gK3tT+DFMF+AZuFSYCRlt
g8UEcIcpkdOcrnXnfZ/7jepGVxRwhQ==
=fMTD
-----END PGP SIGNATURE-----

--oj4rdulsaiobcffa--

