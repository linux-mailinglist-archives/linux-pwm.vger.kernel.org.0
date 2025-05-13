Return-Path: <linux-pwm+bounces-5942-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B76C1AB4FF0
	for <lists+linux-pwm@lfdr.de>; Tue, 13 May 2025 11:36:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A4DF7AFA9E
	for <lists+linux-pwm@lfdr.de>; Tue, 13 May 2025 09:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 360EB2222A7;
	Tue, 13 May 2025 09:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X4nEB0on"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD0321C9F6;
	Tue, 13 May 2025 09:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747128975; cv=none; b=fpuws/rzJceCYkaW0lbC/ScZhXHmU5QD89+TU1BM2I417xFLhp0RPnR2u1to2pL1kPFe1WGhnfi7a4Zs35HQvBiv2APQKhxCCjaUUfYJGRCZRjpKUMqXMCnAi9plQMnFikI1u7w+biBAweOISNZcZm9D+BCh7R3+KGIQLq5UjL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747128975; c=relaxed/simple;
	bh=6PsxRyDCIJjPf8qjO8S6UU6kMJG3dxwRF0RPzaORjOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dyAjlOiHjzZGSYFgliGaHwKghmvqTXeKInRIdsdeBiLR3IRIHm2Al6RR6slf+v3glfH0c8iLOIoalW/x+Ui0+aI2p3Tb+rp/re5NN20QvrzIgvlBl6VXqUFTh56sNj5LA0iePBzxIFrYI+3s39yY3oByUitJ4YqyzBS5pIKSak8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X4nEB0on; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F18AC4CEE4;
	Tue, 13 May 2025 09:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747128974;
	bh=6PsxRyDCIJjPf8qjO8S6UU6kMJG3dxwRF0RPzaORjOQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X4nEB0onpk7H3th0ti9CTHKeYFf4tpYTpoGX4ga/dIHxrfGRfIDU8scpeSXhuoT7u
	 1A1wpyuRZyXZF09mg7JQIcVETEy5Ox+9W+fU6Bbe7QHGG9wn05h+UCTY1+1zsxPkEs
	 gC5txgnlLTJrLAv/JaxOHe8ne3MRHWAhxPAQOvkfuXJALE85BN+S0vXJPbraEoTaIU
	 sw3ylovGRZ2fOR/36zetODrNtKZ4KDabqK59cI+YKVEFcy4qTVlITzIxNJW9WxlZEn
	 ntfwQ8PQixwT44EbhkanAMmSrdRWcUVkUFQ2uQ2JehK41LEeRZGrYIUJVhBI/OEghw
	 8sHwbEFyK1xcw==
Date: Tue, 13 May 2025 11:36:11 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: "Rafael V. Volkmer" <rafael.v.volkmer@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v4 4/4] pwm: tiehrpwm: drop unnecessary parentheses and
 fix spacing
Message-ID: <54m3xdlxjw5ge2euadab5xf6am7uqrz6fgtg7tk55zxvvyoa64@23mrrsgskgsn>
References: <20250419195830.79053-1-rafael.v.volkmer@gmail.com>
 <20250419200100.79140-1-rafael.v.volkmer@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ajevienc2r2mxiyq"
Content-Disposition: inline
In-Reply-To: <20250419200100.79140-1-rafael.v.volkmer@gmail.com>


--ajevienc2r2mxiyq
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 4/4] pwm: tiehrpwm: drop unnecessary parentheses and
 fix spacing
MIME-Version: 1.0

On Sat, Apr 19, 2025 at 05:01:00PM -0300, Rafael V. Volkmer wrote:
> The comparison in pwm-tiehrpwm.c triggered =E2=80=9CUNNECESSARY_PARENTHES=
ES=E2=80=9D and
> =E2=80=9CPARENTHESIS_ALIGNMENT=E2=80=9D when wrapping the second clause i=
n extra parens.

What is the source of "UNNECESSARY_PARENTHESES" and
"PARENTHESIS_ALIGNMENT"?

> This removes superfluous parentheses, aligns continued lines under the =
=E2=80=98if=E2=80=99,

The "aligns continued lines under the =E2=80=98if=E2=80=99" part is wrong?

> and ensures operators are properly spaced.
>=20
> Signed-off-by: Rafael V. Volkmer <rafael.v.volkmer@gmail.com>

Best regards
Uwe

--ajevienc2r2mxiyq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmgjEokACgkQj4D7WH0S
/k6Glgf/eAyATqFjwy7/K50ggd8jMdvi770oQ2TCWnyK7pSy6gfY4BdrFwm4lT1Q
MQslkj4H2qCbnJnS64sj2XI0DpBrY3VEw48l5C+qW8+9c0PdZye0YVT2M8yutgnM
/dZBf3k2cxajyuNEu5D4iX8rirv5fJ7ZiSUW87QpuFDmmgvtlI8f3rJGRZjBmvxJ
fth1SMllFnnRMhkPLg1n3agZ32MFF7fcHs+vFsy+nSARNQhyTmwnI0yqCmK4XEL6
mjQRDSBDgN3J0ztfPbWiCvABuefrNhZpCIP1HZAjoy+VuCF1YZ7krl8DA7lWdz0k
VYzTCpF9i6690NnY/vXkeDGjhwu3hA==
=KRH0
-----END PGP SIGNATURE-----

--ajevienc2r2mxiyq--

