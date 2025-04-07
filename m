Return-Path: <linux-pwm+bounces-5358-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12A2AA7DDAD
	for <lists+linux-pwm@lfdr.de>; Mon,  7 Apr 2025 14:31:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0B1D3AF103
	for <lists+linux-pwm@lfdr.de>; Mon,  7 Apr 2025 12:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1492248865;
	Mon,  7 Apr 2025 12:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A/PTyzE6"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E55242930;
	Mon,  7 Apr 2025 12:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744029089; cv=none; b=VXWFKB5J2SUjFDwf2KSBNTVdIbun/owVKzDJAye6/+TC/fTUr2iKoMoue59PACe+VLy3wikMm76fq1HQjPzcHw+ogUiKuoEs9sSVIcVwYcTSUzP2x/Xx7XebuzcSRidqVJar6MwX2vjAiD+ZrPv1nt4g18ceIRbUvuJWoYRMmcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744029089; c=relaxed/simple;
	bh=mWLxrmUWg2QbduQqGeynDbNIO+EvNnvSdkJRvmJ0LSU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P6jaoiD9ETCtHs23/scy/B2M+ppd3j2FDOxZ17aV8Hq5FmZD1blstnD3qFIStSB/nvkCoF+BHv+7ZgjFx1EJDTPfNLaQe+e8ukRL/TfgvqZJ2/TYZSqcQK1GWW1g5hzfee1jKGbVJWk6ronSXXHUySA+rBtjLRM9PAZRB4iNpJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A/PTyzE6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34C4DC4CEDD;
	Mon,  7 Apr 2025 12:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744029088;
	bh=mWLxrmUWg2QbduQqGeynDbNIO+EvNnvSdkJRvmJ0LSU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A/PTyzE6r+rflOEinzc+cMW6/l5y6kQp7OPqVae68mCaiQ7GTyDb4zFGqxCCtqRZO
	 fw/C8hh2QgUFKSMOQ8ohXgqw80kg60aFnnFLFZE+m8+ky7HhqMeVKSRzRWWQCifsyU
	 Jxpc4nhL7K6QJmT3Lf5Hvcv3xbQREuJ9DtXwf0fLhUdPtuHqQaHZxbirTjHu0/yqht
	 P5UzN7Ow+wjCcHsVirpm0CpaLg49nUKa5S33ljVugn50Rpkc/HB9fru2GPZPDr1lwt
	 Lh/xjP0WKNTBqjf8TOIGCHz6ff+MztzPzfvrc0UR/DdLyfQuekYirLw0xobYwDtkAf
	 hGK2L5T4ojH1A==
Date: Mon, 7 Apr 2025 14:31:24 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Longbin Li <looong.bin@gmail.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen Wang <unicorn_wang@outlook.com>, Inochi Amaoto <inochiama@gmail.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, ghost <2990955050@qq.com>, 
	linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, sophgo@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH 1/2] dt-bindings: pwm: sophgo: add pwm controller for
 SG2044
Message-ID: <jq55x7uhftvejninh56tzk32jtmmwa5wxzna5uxbkk5woi7zi5@6wrg2ctmyg7b>
References: <20250407072056.8629-1-looong.bin@gmail.com>
 <20250407072056.8629-2-looong.bin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7u4pfjk7u4y7yhpc"
Content-Disposition: inline
In-Reply-To: <20250407072056.8629-2-looong.bin@gmail.com>


--7u4pfjk7u4y7yhpc
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/2] dt-bindings: pwm: sophgo: add pwm controller for
 SG2044
MIME-Version: 1.0

Hello,

On Mon, Apr 07, 2025 at 03:20:38PM +0800, Longbin Li wrote:
> diff --git a/Documentation/devicetree/bindings/pwm/sophgo,sg2042-pwm.yaml=
 b/Documentation/devicetree/bindings/pwm/sophgo,sg2042-pwm.yaml
> index bbb6326d47d7..e0e91aa237ec 100644
> --- a/Documentation/devicetree/bindings/pwm/sophgo,sg2042-pwm.yaml
> +++ b/Documentation/devicetree/bindings/pwm/sophgo,sg2042-pwm.yaml
> @@ -17,7 +17,9 @@ allOf:
>=20
>  properties:
>    compatible:
> -    const: sophgo,sg2042-pwm
> +    enum:
> +      - sophgo,sg2042-pwm
> +      - sophgo,sg2044-pwm

Given that the sg2044 has more registers (to e.g. implement different
polarity), but the sg2042 registers are identical, I wonder if the 2044
device should use:

	compatible =3D "sophgo,sg2044-pwm", "sophgo,sg2042-pwm";

Note, I'm unsure here, only providing input to people who are more
knowledgeable in DT that I am.

Best regards
Uwe

--7u4pfjk7u4y7yhpc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmfzxZoACgkQj4D7WH0S
/k73JAf/YF3lOc8ZTYHAVl5pC0RWr/ZB8pp9gKCGzYHdGYbogEGAgSewARKopzQ+
ZEPmNeXoVEglTRPxfWXl0aDImSXG/NbOeA449I7kmpecXGHEX/iqwexGYR1kvNxh
Yg8jl+bl2dxh/m+jw/KoCi2rpyq9jverosDJ0r3y/aum7lqd6LB8IPx1zsxcaQN9
xXAuXOE4UnKaUSTZfRBqiwUvY0N62kg4/o/wFERPSdyKS3Tjfb7m8sTVy0rBoGEY
s8SvRNjcapE/sSWqPsREl2XdULCQHlJ6CCMXk10oMisXB65FouAzb80ghiZ8WU+6
0h9ascRYWtiItrTm/D854ODd/FgwmA==
=GmB3
-----END PGP SIGNATURE-----

--7u4pfjk7u4y7yhpc--

