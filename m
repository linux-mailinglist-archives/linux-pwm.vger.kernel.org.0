Return-Path: <linux-pwm+bounces-4146-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 218329D8C24
	for <lists+linux-pwm@lfdr.de>; Mon, 25 Nov 2024 19:24:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6D45166A33
	for <lists+linux-pwm@lfdr.de>; Mon, 25 Nov 2024 18:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFC351B87DD;
	Mon, 25 Nov 2024 18:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e4x+JV+4"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA3A1B3943;
	Mon, 25 Nov 2024 18:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732559037; cv=none; b=hOO9f2nEO8Mu/3Y5BZwu6WE+PNEFkPeSlgOwwcl+CJB/+u2dc0SmwVs8Hbsq6Yxp25VdtBxsJrzAPzgkbK0ggDzPxUBfsGux5I5LHRnfAKXk21B/CROw/mP1952u4EXoEsv7TbeTQp0sXT7UdsM2jjgsdrpYfQRDzNTLWdIlLr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732559037; c=relaxed/simple;
	bh=FEnfJKu8BFsY79SSwoKzJxBfw021YIRRMqklGnoZg7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hj+hxgJqTRtGjbcv6tCdk0FjODjtJzPUwq/tG2nkXEF0d0D2ECNPqzueXUlncUX//+NGcbSZzj8neagGWsofQHdsJ0sniXw/mURoCOl8aMX+jxZzMLeeO/kt9i4YL2psvVEhy4NrwEJWc0UsHswbzbgCFAK/WQTr18kRJEa56ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e4x+JV+4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9533EC4CECE;
	Mon, 25 Nov 2024 18:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732559037;
	bh=FEnfJKu8BFsY79SSwoKzJxBfw021YIRRMqklGnoZg7c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e4x+JV+4TLj/641DvnEomE+s05vAVx2khLlIX+WVTOL5mMmJtzdK1df2SXXf18ttq
	 rU9Lc+wXSWSGHHvpIbR5my06OvGj9v6wakQoQCQwANXxnS3QKRooly4tluFGZxTT3d
	 bVJvn9QAc9I9Awj/PaDHVhue+ngtzgK57kk5zcAat+Y9YUF4hH7INKuprMfW+Yhv6W
	 LtbJGt/Dz4JcAWnVn+ewMbpQZ9YQUNIIwKnuw+9ZGiuLKH0JW2/gwCg2pmFape3vUT
	 nxWXbv2mwZnAeiVeQ4f95CnA+Je5+0GtSc56sZzQ2aroKTl78cazl4pNJYJcGSN4K8
	 6fHObgWuI6vaw==
Date: Mon, 25 Nov 2024 18:23:53 +0000
From: Conor Dooley <conor@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: jic23@kernel.org, robh@kernel.org, conor+dt@kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: adf4371: add rdiv2 and doubler
Message-ID: <20241125-rotting-brim-162582b5ad42@spud>
References: <20241125112643.10459-1-antoniu.miclaus@analog.com>
 <20241125112643.10459-2-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="AR3vOxY7YAd4jTmS"
Content-Disposition: inline
In-Reply-To: <20241125112643.10459-2-antoniu.miclaus@analog.com>


--AR3vOxY7YAd4jTmS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 25, 2024 at 01:26:40PM +0200, Antoniu Miclaus wrote:
> Add support for reference doubler enable and reference divide by 2
> clock.

You're still missing an explanation here for why these cannot be derived
=66rom the required output frequency vs the input frequency.

>=20
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
> no changes in v2. (added cover letter as requested)
>  .../devicetree/bindings/iio/frequency/adf4371.yaml    | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml=
 b/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml
> index 1cb2adaf66f9..ef241c38520c 100644
> --- a/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml
> +++ b/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml
> @@ -40,6 +40,17 @@ properties:
>        output stage will shut down until the ADF4371/ADF4372 achieves loc=
k as
>        measured by the digital lock detect circuitry.
> =20
> +  adi,reference-doubler-enable:
> +    type: boolean
> +    description:
> +      If this property is present, the reference doubler block is enable=
d.
> +
> +  adi,adi,reference-div2-enable:
> +    type: boolean
> +    description:
> +      If this property is present, the reference divide by 2 clock is en=
abled.
> +      This feature can be used to provide a 50% duty cycle signal to the=
 PFD.
> +
>  required:
>    - compatible
>    - reg
> --=20
> 2.47.0
>=20

--AR3vOxY7YAd4jTmS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ0TAuQAKCRB4tDGHoIJi
0gGdAP0ZgwYPH6bIZifcDRAHpGwlSAIXXCWJNn0APgzsBZpCuQEAp1G65MyvRK9v
Rv+tnTXqNsUE76LG5QDkQZr/jd9muQg=
=d7g1
-----END PGP SIGNATURE-----

--AR3vOxY7YAd4jTmS--

