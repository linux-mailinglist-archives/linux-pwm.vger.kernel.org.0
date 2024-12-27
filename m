Return-Path: <linux-pwm+bounces-4518-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8535C9FD107
	for <lists+linux-pwm@lfdr.de>; Fri, 27 Dec 2024 08:24:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21BF97A03E9
	for <lists+linux-pwm@lfdr.de>; Fri, 27 Dec 2024 07:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B69EE143C63;
	Fri, 27 Dec 2024 07:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DnpHTGvz"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858351DA4E;
	Fri, 27 Dec 2024 07:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735284258; cv=none; b=sNyky9iiYzxuxx4enwiYLidrMstdRBwOkrJWjMvmXLVXDxL6hmFQjoAo3TEu79yuGpgxLWzus8X1KrCGDMBeRHs49TOGbz3U6kFDox2llC0knx+lK9GcNWa8Ou7ZgpLdJtB5nzVtHGWO4VGhjUqS9RmQPNrwtg0Edn9Cx/DMzoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735284258; c=relaxed/simple;
	bh=FKfiqhxldTWxKz+iVQbR99XJepNfxu1G8YzV3vCaeV4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hMnhM/bH5GVUnZ+t1A9PQIFPXtdJiXdV99WXfX0MpoyVETAGcHQfozfbrMBrQFKLg2NIy5PBlDe9PukRYcycsEQ3Tyyfuz0oqUIrQtBeIPx6j6ncbgZc0XR2WmGnn+pTNwENccWVmnIv3zLkfVO99S7zGEG9ow8ndH+6ipOj0Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DnpHTGvz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83933C4CED0;
	Fri, 27 Dec 2024 07:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735284258;
	bh=FKfiqhxldTWxKz+iVQbR99XJepNfxu1G8YzV3vCaeV4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DnpHTGvzELQi4ilXrQrOGqMOk0PmfRmso0RHTS899n4t9073pdfPmKmjoYcD93IeQ
	 L0GgACvFkw3PcknP4FOPlIjh6JSlBEnLCQitUnp4FYTSj42vzbYD9EnYafrvzC32C2
	 3oHUb6q4SlpXVj9fbFGEAK95HdEFynqbQGe7qAqeBuRQw9T9ei5RmLoe9fpn161lHK
	 FroMxYBdTXsWdfRFVerSFjHkQeKZd+/RuuL9c4QZEYHfWw52yItpY+9GHsWabw57I8
	 aITjsCCfsd7hUGL490tjgokZZ3Nw5Y9ltpAgFiNE819w2uMFdH4Nr4cM5YeGoUdbcq
	 6DbKuoam6ni/A==
Date: Fri, 27 Dec 2024 08:24:15 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Kever Yang <kever.yang@rock-chips.com>
Cc: heiko@sntech.de, linux-rockchip@lists.infradead.org, 
	linux-pwm@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, 
	Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 11/17] dt-bindings: pwm: rockchip: Add
 rockchip,rk3562-pwm
Message-ID: <qvr7x4anlxxtpxjywrqjihxyxejw4i73wrh2ibl3hasayew4s2@obyuxce4ez4g>
References: <20241224094920.3821861-1-kever.yang@rock-chips.com>
 <20241224094920.3821861-12-kever.yang@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="54zezqdhae62ynag"
Content-Disposition: inline
In-Reply-To: <20241224094920.3821861-12-kever.yang@rock-chips.com>


--54zezqdhae62ynag
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 11/17] dt-bindings: pwm: rockchip: Add
 rockchip,rk3562-pwm
MIME-Version: 1.0

On Tue, Dec 24, 2024 at 05:49:14PM +0800, Kever Yang wrote:
> Add rockchip,rk3562-pwm compatible string.
>=20
> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>

What is your merge plan here? From my POV merging the pwm update via my
pwm tree would be the easiest. But if you want to let it go via (say)
arm-soc to have it all in a single tree soon and then base new
development on top of that, that would be fine for me, too.

In the former case, please tell me. In the latter case:

Acked-by: Uwe Kleine-K=F6nig <ukleinek@kernel.org>

Best regards
Uwe

--54zezqdhae62ynag
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmduVhwACgkQj4D7WH0S
/k4g1gf/euWj+DTnb2zE4V27eM419OFeA5x4S86KZ0uCp85R1Py/Yp+UYsm9Se4g
Bf12EMuLDedAJ+ye72jM8cCD92w8nyOPAxgZRYhJMPy7eMd4R9KLYMwXrMZsqZ9w
e0W4ufYVFQVtZGyW0dTUVnN2LIJKOCgtmhyQdOjoEGIcPGWdX2UYjqaXE3VzBLik
yKtxvFZhvkc+GjnNcjtr9At/YlKcoSCweCN0vle1JcOi/qPrXy+WGQJ4xLdEDj5d
OMNODhIYAuzd2DwxzzlzkKhLlrccEUMyFY15ZkINt8D3ScaKJimmzFYHkCfqjUzD
Z6UW8hRjMmQNkmOS2bY9/MfQ9INGhQ==
=wm9h
-----END PGP SIGNATURE-----

--54zezqdhae62ynag--

