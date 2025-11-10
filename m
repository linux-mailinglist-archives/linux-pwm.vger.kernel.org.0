Return-Path: <linux-pwm+bounces-7604-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8037C4649D
	for <lists+linux-pwm@lfdr.de>; Mon, 10 Nov 2025 12:33:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3982F3BBA06
	for <lists+linux-pwm@lfdr.de>; Mon, 10 Nov 2025 11:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BCAF309EF6;
	Mon, 10 Nov 2025 11:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UNmq8akE"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD82255E43;
	Mon, 10 Nov 2025 11:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762774346; cv=none; b=Vglf3+v9vvT27IUNEMnJiMFOLwDX0M4IBfoM0YI8QafKuXRTEg+THh67qsWIStOfK8CFHIVxGq8/rw2MVqVuRYphxIBRpP94KvaehSAmwIe5RUxn9vnxPe0wZAShJbCnFqyjlaJ+ppjR9tlmnxNwQjSZkpeP9ocfq7w+WNeyjnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762774346; c=relaxed/simple;
	bh=bMeE+5B5dtl5t9xya726sZPElWX+pnp2Rz6tIuzftiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kBDVpezyD8/il7gUdkUkSplufWmYLGVWOJoN16I7uzpyU2ou3d+zutY+JYUw9wapg0IFql6Dv/SDwiIE57/tJmUjLID1MGCuIses4888DQ+Kis4SLjmw7OqPY2G+g+UowBUS7EO/FNmxz8w0OSo0nHPtCKIRqIRWJ/bwqpXPVSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UNmq8akE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48E39C4CEFB;
	Mon, 10 Nov 2025 11:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762774345;
	bh=bMeE+5B5dtl5t9xya726sZPElWX+pnp2Rz6tIuzftiM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UNmq8akE3N8+6v6VBYH3+k0pevABP3qNlLemgnv1970X+/xMcEvz8QA4zgBSH8nst
	 K5N8q/gYbJphoV1j2n2/Q0C3M48x1hD8ytNZ1i2kekooxnZFo3IuwUjiOzQAnnnotS
	 LTq4riMmRydNWUyNLNHhmE5Pg4vNK054U+lc2du8zHGR9OL9Ry8LGI7dZft5nkif8q
	 OUXK+NQVN85eDi8anfR2F4zc1l23t7aetctxD4k66D28wVJCvRPdJF5V7hwnfka00f
	 GhHyDVYcuAjUBngz0k9pPiybOlDJIswTDrGhOnf3ZkEPqJ48m2EN3yGHXiDiDH8pkL
	 +xQywMrEXy3aw==
Date: Mon, 10 Nov 2025 12:32:23 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: george.moussalem@outlook.com, Bjorn Andersson <andersson@kernel.org>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Baruch Siach <baruch@tkos.co.il>, Konrad Dybcio <konradybcio@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Devi Priya <quic_devipriy@quicinc.com>, 
	Baruch Siach <baruch.siach@siklu.com>, Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v18 1/6] dt-bindings: pwm: add IPQ6018 binding
Message-ID: <lkbwgakmqknqptsjrb7hvxv3bxi3fo62vml7tmf4avo7nr7cue@dwsovmchu2pp>
References: <20251029-ipq-pwm-v18-0-edbef8efbb8e@outlook.com>
 <20251029-ipq-pwm-v18-1-edbef8efbb8e@outlook.com>
 <gkvbziqeae53bunqd556r4swaye4s4lcnwthryouynwfwqrnsi@6o4cjgxiwxco>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mwtelqqfu255nqhk"
Content-Disposition: inline
In-Reply-To: <gkvbziqeae53bunqd556r4swaye4s4lcnwthryouynwfwqrnsi@6o4cjgxiwxco>


--mwtelqqfu255nqhk
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v18 1/6] dt-bindings: pwm: add IPQ6018 binding
MIME-Version: 1.0

Hello,

On Wed, Oct 29, 2025 at 10:22:41AM -0500, Bjorn Andersson wrote:
> On Wed, Oct 29, 2025 at 12:36:57PM +0400, George Moussalem via B4 Relay w=
rote:
> > From: Devi Priya <quic_devipriy@quicinc.com>
> >=20
> > DT binding for the PWM block in Qualcomm IPQ6018 SoC.
> > [George: added compatibles for IPQ5018, IPQ5332, and IPQ9574]
> >=20
> > Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > Co-developed-by: Baruch Siach <baruch.siach@siklu.com>
> > Signed-off-by: Baruch Siach <baruch.siach@siklu.com>
> > Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
>=20
> This is where we expect the [George: ...] comment.
>=20
> I'll leave it up to Uwe to determine if he'd like you to resubmit this
> or not though...

Don't resubmit because of that. BTW I only think this type of comment is
important for changes that happen without involving the mailing list. A
typical scenario is when a maintainer does some changes while applying
the patch. In this case I'd say not mentioning the changes you did since
you picked up the series is completely fine.

> > ---
> >  .../devicetree/bindings/pwm/qcom,ipq6018-pwm.yaml  | 51 ++++++++++++++=
++++++++
> >  1 file changed, 51 insertions(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/pwm/qcom,ipq6018-pwm.yam=
l b/Documentation/devicetree/bindings/pwm/qcom,ipq6018-pwm.yaml
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..ca8e916f03276e93d755d57=
4e2567b0e4b86a8ce
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pwm/qcom,ipq6018-pwm.yaml
> > @@ -0,0 +1,51 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/pwm/qcom,ipq6018-pwm.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Qualcomm IPQ6018 PWM controller
> > +
> > +maintainers:
> > +  - George Moussalem <george.moussalem@outlook.com>
> > +
> > +properties:
> > +  compatible:
> > +    oneOf:
> > +      - items:
> > +          - enum:
> > +              - qcom,ipq5018-pwm
> > +              - qcom,ipq5332-pwm
> > +              - qcom,ipq9574-pwm
> > +          - const: qcom,ipq6018-pwm
> > +      - const: qcom,ipq6018-pwm
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    maxItems: 1
> > +
> > +  "#pwm-cells":
> > +    const: 2

Please use 3 here.

Best regards
Uwe

--mwtelqqfu255nqhk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmkRzUEACgkQj4D7WH0S
/k681wf+KedyXgpShz7il9/w8yt94Dux1ecSUur+tzXHYf6YZ1FfkxM8fcwX2yBf
3I2Nhfxx1s1Ga1Rm8sR89Jpy1P8mNkq5w4yaRViZvsXFxj8LIAvxveOEMe+K/pnK
MYVtk1GXyWAl1dkQqC4R+NwohRH7eFWnFoEKzhx7VNvEH+ILuz2jGL2xrIDt3xyf
DT1TE0op7ZitOrhXFGVqo3UQWGPeEtM/ScArBtCa74DNhLSYQR9Teu9qbzbLpxvf
j6JjV6NFPIQ82N/YLOLDSHcOETVsIxXDHvnp08VyLJRDL11LEEipCmWkpgz6SG2u
6rdlUm6trjmC0eEhTJ361cQt3e5QvA==
=xn2Y
-----END PGP SIGNATURE-----

--mwtelqqfu255nqhk--

