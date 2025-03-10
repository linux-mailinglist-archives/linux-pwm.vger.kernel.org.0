Return-Path: <linux-pwm+bounces-5129-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51E19A59ABA
	for <lists+linux-pwm@lfdr.de>; Mon, 10 Mar 2025 17:15:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90B5C165F63
	for <lists+linux-pwm@lfdr.de>; Mon, 10 Mar 2025 16:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7651322F3A3;
	Mon, 10 Mar 2025 16:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tZtVwSzT"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345F61BCA1B;
	Mon, 10 Mar 2025 16:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741623309; cv=none; b=lmd9SAXfRKo4MT3VCx1suHsUjfjAD4OCYCArPkU+Vj9canB/oz8qRLbIhJcudInJXxcbspLWI9eyqHeND6Bh8cmkW1D4NcfmorxeVSP/+APfAxQjYxjyXSOKw2pC23gbr47yAiDy8ypqJ40HDRnXhqyLuSwtqggVa4SJeC3a6SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741623309; c=relaxed/simple;
	bh=GfKQEI3/w/jPPIgwJ2M+qaN1oQ83UFtd+Kj8kr4X1wc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q8HBcylXxilJApjMzg+mdQsRRb7b/qHZJRzZ5JICjsbsFWjtpkYQ6WBUnFeu+JtMMuJlyygIxafmMV1eJF91eJGIDmNaDHEghSQeCLkhUmM9iIc+nNsLcVrGTSeFsh6kzyTiZNXuwnlcsAtmhajzHUUYkYE0z+/GGfEID8eDPc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tZtVwSzT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16AADC4CEE5;
	Mon, 10 Mar 2025 16:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741623308;
	bh=GfKQEI3/w/jPPIgwJ2M+qaN1oQ83UFtd+Kj8kr4X1wc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tZtVwSzTRBzyJCQJsgC/9YF3adZtv1HOhVsNHISyy+2qM3dqTvytdY5OEnYOnf5jN
	 jhBVs1x1D5sdE1QGLM2BCl3h8wYf8az/tSrUdM9MNja+1tICm4lhwXVIMo9mhOon6o
	 Vc7D4JvNnc3Zh3+Yi70hmimYOw4wXfHoPWWpaNeXaAbpB/8tHCuc+sUa3tYelrvH82
	 ieA1G7LtJkk/MjAvBmb0BjWHuG0bvMYofLWBqk/z0Erp/ALAJRIo+hf9TSmoXlIw+R
	 OmvUeMdCo918OHYOIEdpdODmHvwzK44oUR+pT0rYfoE4bbDi4IIpUC6X+l0NTAHvSY
	 cLDTmSgqbpRoQ==
Date: Mon, 10 Mar 2025 17:15:05 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	"open list:PWM SUBSYSTEM" <linux-pwm@vger.kernel.org>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, 
	"open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <imx@lists.linux.dev>, 
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: pwm: imx: Add i.MX93, i.MX94 and i.MX95
 support
Message-ID: <jwge3lqlx7t6j4gmag4ghu6vtzatg54i3x3tl75k5upvedakdy@entc6jjcqh47>
References: <20250306170845.240555-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lm2fsqm2yujhiixb"
Content-Disposition: inline
In-Reply-To: <20250306170845.240555-1-Frank.Li@nxp.com>


--lm2fsqm2yujhiixb
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] dt-bindings: pwm: imx: Add i.MX93, i.MX94 and i.MX95
 support
MIME-Version: 1.0

Hello Frank,

On Thu, Mar 06, 2025 at 12:08:45PM -0500, Frank Li wrote:
> Add compatible string "fsl,imx93-pwm", "fsl,imx94-pwm" and "fsl,imx95-pwm=
",
> which is backward compatible with i.MX7ULP. Set it to fall back to
> "fsl,imx7ulp-pwm".
>=20
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Applied to
https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for-=
next
with Conor's ack.

Thanks
Uwe

--lm2fsqm2yujhiixb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmfPEAEACgkQj4D7WH0S
/k5/Qgf9EmSnszwO5HAMyp/zt++qVoJo500Z8MtKSb4CtHeppS12p6xcfklZDMBN
+mgSdfHdaV6D0CvILircndu4GLxRLWuEk08FgqYoSsqeUoNLoIDaWtDFakdWPTX6
thzWQhg4TSGbDVXDzuHSMw4Eg8SeXmIm8ffQ46mfcuGtSUpB2P30WKq9WwOg1Wa7
VO4BLXv0JvpPFSBH2TBt12qmedffPELK7Hd11LPmbsHSARUGmYsemF2ejtWrG05O
hWs5WsPq08UmeKb/LDyDagFpFo+a41Ih62G4PRn3Vooqx+zEGSKo7/YcNCOhmqSp
vEGzTENSpDyBnW1egQuY7k7GIPsdTA==
=xC4L
-----END PGP SIGNATURE-----

--lm2fsqm2yujhiixb--

