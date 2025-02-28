Return-Path: <linux-pwm+bounces-5024-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEE3CA4A63C
	for <lists+linux-pwm@lfdr.de>; Fri, 28 Feb 2025 23:54:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4BF6E7A4BCC
	for <lists+linux-pwm@lfdr.de>; Fri, 28 Feb 2025 22:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68F9C1DF25C;
	Fri, 28 Feb 2025 22:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nX/j+gbK"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2111C5F36;
	Fri, 28 Feb 2025 22:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740783281; cv=none; b=hE73OSqkNDdHaKBTcYTy3lyDFdf8A36r85sPDevH3v/XzUCbOHoIOnZ2jJcAQIAImLeDgAjaA0LdBSsdQQw3gaqu+eNhINJ9v8pknbloLbFJhEjnPGa4yxJDTZE3o2EYcYGmUTq/JPVCDeKESVF05SQPhF8h7aoveil7+cxbg5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740783281; c=relaxed/simple;
	bh=9/BEXh6bZ8n930l+zITwwGD3TVUqcE/AjCK/PLv0gB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X9u/2Wqi5zdWwWVh4y+pblw4K0dZs6Z+qqOp/DXdLlKfRsYPfX2h8Q+pltLdhUcO/28Ga4Lx9iN5KuoHqmVCOlJlURy4SlBTbLxkq+L07blx3ZSyLwyjdydvI1799ILDrat5mvtz7wBHH6K2A86t/8SaSqWbksDAHQQq1pOoMgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nX/j+gbK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 365D4C4CEE5;
	Fri, 28 Feb 2025 22:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740783280;
	bh=9/BEXh6bZ8n930l+zITwwGD3TVUqcE/AjCK/PLv0gB0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nX/j+gbKMT3qpqycuWs1FLkNZM513VJA/ubbB3ELLAIas2x/UEUSHjmElCnSZJM+3
	 /foNfRWpibRmmI3jmjSJc/yiXsDYGs9ECi4XlrIOly7Pbrfoahe/tpjpPy6tJafgbB
	 CtwoIvOOl4cpjJrRGp/q/nmvxdj85NIeDRMwGEZvU64I3sgYW7+O4tihMU4aVJ5Y3O
	 UU0VxqFdtTGot5sUZKk0BX/4EQx59SwSTYP3i74aIEHCT6RSeoa6kxI2leO3AGhSKY
	 74+5nSVfV6Rh7RsE+AI5kEI1cFEQ2gOGKz6Ors36uE92f9osGZlLU/utjaXgBx5/Bw
	 tGDKtrPA5UAxg==
Date: Fri, 28 Feb 2025 23:54:37 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Kever Yang <kever.yang@rock-chips.com>
Cc: heiko@sntech.de, linux-rockchip@lists.infradead.org, 
	linux-pwm@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, 
	Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 10/15] dt-bindings: pwm: rockchip: Add
 rockchip,rk3562-pwm
Message-ID: <hmqehlztyrudpdkc46afqvgwg2jpanaprru25qxacnmna7tkha@ifz73s2oiqiq>
References: <20250227111913.2344207-1-kever.yang@rock-chips.com>
 <20250227111913.2344207-11-kever.yang@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7eve6skvx3pjfnjm"
Content-Disposition: inline
In-Reply-To: <20250227111913.2344207-11-kever.yang@rock-chips.com>


--7eve6skvx3pjfnjm
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 10/15] dt-bindings: pwm: rockchip: Add
 rockchip,rk3562-pwm
MIME-Version: 1.0

Hello,

On Thu, Feb 27, 2025 at 07:19:08PM +0800, Kever Yang wrote:
> The PWM core on Rockchip's RK3562 is the same as the one already
> included in RK3328. Extend the binding accordingly to allow
>=20
> 	compatible =3D "rockchip,rk3562-pwm", "rockchip,rk3328-pwm";
>=20
> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
> Acked-by: Uwe Kleine-K=F6nig <ukleinek@kernel.org>
> ---
>=20
> Changes in v3:
> - Update the commit message and collect the Acked-by tag.
>=20
> Changes in v2: None
>=20
>  Documentation/devicetree/bindings/pwm/pwm-rockchip.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/pwm/pwm-rockchip.yaml b/Do=
cumentation/devicetree/bindings/pwm/pwm-rockchip.yaml
> index 65bfb492b3a4..e4e1976c542d 100644
> --- a/Documentation/devicetree/bindings/pwm/pwm-rockchip.yaml
> +++ b/Documentation/devicetree/bindings/pwm/pwm-rockchip.yaml
> @@ -30,6 +30,7 @@ properties:
>            - enum:
>                - rockchip,px30-pwm
>                - rockchip,rk3308-pwm
> +              - rockchip,rk3562-pwm
>                - rockchip,rk3568-pwm
>                - rockchip,rk3588-pwm
>                - rockchip,rv1126-pwm

Applied with Rob's Ack to
https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for-=
next
=2E

Best regards
Uwe

--7eve6skvx3pjfnjm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmfCPqsACgkQj4D7WH0S
/k5fwQf/bAS8biZKL+kTke5xko1/gSdfFCKIQh8hFMMkR1nephPx57Secam01izM
4hWWBXkLtnA/4WZXDXftApK2+vParfljyN43aL1aX7ZVEYJAofAHo/VgnA5B36dR
SJgT3Pj4I10+iF3mtX0miBBxT6GpSY+wbYnscXeU/V1iAt9SuF21MsSXBHYaKd12
RS1XdmCD9FskxIx67EqE4Uee7nlRAxlmYHRLrLc0RTHABK/hWPJstx3yPDqh57TS
xFMXo643/mz0yJzWSmEJ6wGtDv6YkK59WUbzZSUBXfODP6qMJmYu0MzOodI02qsQ
WnrZme04x/XgtigQkvtigVEy8JNqyw==
=8SAG
-----END PGP SIGNATURE-----

--7eve6skvx3pjfnjm--

