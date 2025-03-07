Return-Path: <linux-pwm+bounces-5123-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79841A56CD8
	for <lists+linux-pwm@lfdr.de>; Fri,  7 Mar 2025 16:59:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C38B1889265
	for <lists+linux-pwm@lfdr.de>; Fri,  7 Mar 2025 15:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3546B221709;
	Fri,  7 Mar 2025 15:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lfm1QjW0"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042FF194C78;
	Fri,  7 Mar 2025 15:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741363098; cv=none; b=FNXYCoPO92ahn4XSZetM8LTxH6zGTWHAXJS5DXh+2mVKPThHPOfwH7izspHl4VR2ym6oTeVko68cqUjTW2FmYba2es95Vl50BvnE0Dga8OUkUuBR5GTYSKsq8O3PnY2GUhT7R3WZMrXy2tYo2YYNWi+Td+lYtfdpSmjw/40vsJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741363098; c=relaxed/simple;
	bh=DbOJCP64/Zf1wfRed5mRMA7gHSuE9mWdYEEM8LkNjNc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tTlTVxN3k+32FwNqaQZIoXKrUnYlLiR+7JHTnJ0EX3FQnP97qqd5eMNAzCkt4B1dC20nwr7eUkGumlb4x2iKT/2/+fadvlt2yeo2kgFe/R7C96KHzTh41La/rHA1UaE1MRitCUt9MXoUCYKZZaPSvgSGfB3EpXusLUUm3TAWTSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lfm1QjW0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F5BDC4CED1;
	Fri,  7 Mar 2025 15:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741363097;
	bh=DbOJCP64/Zf1wfRed5mRMA7gHSuE9mWdYEEM8LkNjNc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lfm1QjW0+Yj40viKDxMa/eaI1kIybtAHMSB9BuuhaavCDsQS+lTcgvkY6LsfGIaM8
	 ycoYHNpzCe4tQgpyS93zEEpX2Ujp4Xc9G/udOdZmUMhBcqGYTdWuQ70Q33xRghPYIt
	 oB6U/ZoAW3oRVKmCSsey8mMo9Jy0ZEBBt560tzIIqLoQaQ4wPBQ8hSOKxp/FovR89E
	 1TAdPTWiB8WL5uXYfeO8EU26V5IdurFTlb/TQb5Cx7VcAMN/wAxD8xDeWowH4kUsIE
	 fa119vcwUufZu7wvBPeShILRoz29j2dhEDA+HId+rG/RzP1/wKVrgwYcq+Lzb4mHOd
	 Tzvje4zwr6hmw==
Date: Fri, 7 Mar 2025 15:58:12 +0000
From: Conor Dooley <conor@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	"open list:PWM SUBSYSTEM" <linux-pwm@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	"open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <imx@lists.linux.dev>,
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: pwm: imx: Add i.MX93, i.MX94 and i.MX95
 support
Message-ID: <20250307-scion-comprised-03e8ea95abed@spud>
References: <20250306170845.240555-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="lEFFTIemAybPsts5"
Content-Disposition: inline
In-Reply-To: <20250306170845.240555-1-Frank.Li@nxp.com>


--lEFFTIemAybPsts5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 06, 2025 at 12:08:45PM -0500, Frank Li wrote:
> Add compatible string "fsl,imx93-pwm", "fsl,imx94-pwm" and "fsl,imx95-pwm=
",
> which is backward compatible with i.MX7ULP. Set it to fall back to
> "fsl,imx7ulp-pwm".

Acked-by: Conor Dooley <conor.dooley@microchip.com>

>=20
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  .../devicetree/bindings/pwm/imx-tpm-pwm.yaml          | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/pwm/imx-tpm-pwm.yaml b/Doc=
umentation/devicetree/bindings/pwm/imx-tpm-pwm.yaml
> index ac0a35bf8648c..d5a9340ff9209 100644
> --- a/Documentation/devicetree/bindings/pwm/imx-tpm-pwm.yaml
> +++ b/Documentation/devicetree/bindings/pwm/imx-tpm-pwm.yaml
> @@ -23,8 +23,15 @@ properties:
>      const: 3
> =20
>    compatible:
> -    enum:
> -      - fsl,imx7ulp-pwm
> +    oneOf:
> +      - enum:
> +          - fsl,imx7ulp-pwm
> +      - items:
> +          - enum:
> +              - fsl,imx93-pwm
> +              - fsl,imx94-pwm
> +              - fsl,imx95-pwm
> +          - const: fsl,imx7ulp-pwm
> =20
>    reg:
>      maxItems: 1
> --=20
> 2.34.1
>=20

--lEFFTIemAybPsts5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ8sXlAAKCRB4tDGHoIJi
0vOkAQDWqdqeelxxD0R357bSU/Q1uJv1tmCMs6Lf/ewtxmAb2AD9HplVxYRL9SjA
/DlA2PnHJvXCFTiqK98yaz/Qb8OR3wo=
=lBWI
-----END PGP SIGNATURE-----

--lEFFTIemAybPsts5--

