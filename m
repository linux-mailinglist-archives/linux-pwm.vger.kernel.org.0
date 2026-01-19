Return-Path: <linux-pwm+bounces-7943-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B18C1D3B343
	for <lists+linux-pwm@lfdr.de>; Mon, 19 Jan 2026 18:07:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 375D7315D0EB
	for <lists+linux-pwm@lfdr.de>; Mon, 19 Jan 2026 16:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FEB4326922;
	Mon, 19 Jan 2026 16:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U0P+KRsV"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1DD318EE3;
	Mon, 19 Jan 2026 16:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768840503; cv=none; b=uMH5nFLm8/Rat9NFb2r8wk/bQyoR7+oXywt4YB270P3qMAfeA23UA73Jm9ND4wSxc9yJJW73xGvvsC3prw7u9eB3GjFMArQl7w1gXl76g011H7djl5OYqAgRBGifqIarL9z8R3c5J98hldye9vYj570P0k3qNfkpJQfI8q7VjQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768840503; c=relaxed/simple;
	bh=/gbd7uauHMhX1AhH4FUvMRgJbzZjxB7Krt+HDac4cSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m57RSAxZItKf+G7BwY9gtuEut87MOMda58+CZtLqLc2nFuQUnz+J22EIFn0d8BFDHIpFJ+hgMWJ/b2fyyRYOzEf0Tpvwpb78eOz83FzJWV4WKiyVOI7ySuNLfB5Bua9y7BD0vqnw5IIxyiz3IiXkxhYS30R72Acvcc0P8SVq7Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U0P+KRsV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B622C116C6;
	Mon, 19 Jan 2026 16:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768840502;
	bh=/gbd7uauHMhX1AhH4FUvMRgJbzZjxB7Krt+HDac4cSI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U0P+KRsVlkBSU7e43cnEgF7c1XMNQ8R0RMyslp374matQVHrEkRcPj6zc3iI5ny+R
	 x6QzKhLuo19SUlesdUq75K9wbpmzwXGs9Xd3dFyD+nTl1w1JJ+VbCqqrVJuR3aClOA
	 ltUEdtikRac49pW1mQ+9olu7sZl9bZrOA9yT4NeEvmMo8SUDSO6PF/Z7Y57YnJLRcq
	 hD7UcSlEatDLHJctyDO0DjI94j255BrTXpdX1u9dSnDuzs1dSjTCKkOy+VfMKAQk3D
	 UooD8hG/l52jMk1uNcXwvrjcShgsztEkw4nJEgq0R4RgTtrhWKJgI7/eyJNAAwylmG
	 5v1mzDY9VL+qw==
Date: Mon, 19 Jan 2026 17:35:00 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: George Moussalem <george.moussalem@outlook.com>, 
	Konrad Dybcio <konradybcio@kernel.org>, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-pwm@vger.kernel.org, Devi Priya <quic_devipriy@quicinc.com>, 
	Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Baruch Siach <baruch.siach@siklu.com>, 
	Krzysztof Kozlowski <krzk@kernel.org>, devicetree@vger.kernel.org, Baruch Siach <baruch@tkos.co.il>
Subject: Re: [PATCH v19 1/6] dt-bindings: pwm: add IPQ6018 binding
Message-ID: <ysbuuhn7cdndv5ieae4uaeylxe7d3iuqqehkdtcvhr7xs5wxsi@rcfqzbxn3lqf>
References: <20251128-ipq-pwm-v19-0-13bc704cc6a5@outlook.com>
 <20251128-ipq-pwm-v19-1-13bc704cc6a5@outlook.com>
 <176432871822.1774259.10260811586771769913.robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bi43ollq7h2qpl5p"
Content-Disposition: inline
In-Reply-To: <176432871822.1774259.10260811586771769913.robh@kernel.org>


--bi43ollq7h2qpl5p
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v19 1/6] dt-bindings: pwm: add IPQ6018 binding
MIME-Version: 1.0

Hello,

On Fri, Nov 28, 2025 at 05:18:38AM -0600, Rob Herring (Arm) wrote:
> On Fri, 28 Nov 2025 14:29:13 +0400, George Moussalem wrote:
> > From: Devi Priya <quic_devipriy@quicinc.com>
> >=20
> > DT binding for the PWM block in Qualcomm IPQ6018 SoC.
> >=20
> > Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > Co-developed-by: Baruch Siach <baruch.siach@siklu.com>
> > Signed-off-by: Baruch Siach <baruch.siach@siklu.com>
> > Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
> > Signed-off-by: George Moussalem <george.moussalem@outlook.com>
> > ---
> >  .../devicetree/bindings/pwm/qcom,ipq6018-pwm.yaml  | 51 ++++++++++++++=
++++++++
> >  1 file changed, 51 insertions(+)
> >=20
>=20
> My bot found errors running 'make dt_binding_check' on your patch:
>=20
> yamllint warnings/errors:
>=20
> dtschema/dtc warnings/errors:
> Documentation/devicetree/bindings/thermal/thermal-sensor.example.dtb: /ex=
ample-0/soc/thermal-sensor@c263000: failed to match any schema with compati=
ble: ['qcom,sdm845-tsens', 'qcom,tsens-v2']
> Documentation/devicetree/bindings/thermal/thermal-sensor.example.dtb: /ex=
ample-0/soc/thermal-sensor@c263000: failed to match any schema with compati=
ble: ['qcom,sdm845-tsens', 'qcom,tsens-v2']
> Documentation/devicetree/bindings/thermal/thermal-sensor.example.dtb: /ex=
ample-0/soc/thermal-sensor@c265000: failed to match any schema with compati=
ble: ['qcom,sdm845-tsens', 'qcom,tsens-v2']
> Documentation/devicetree/bindings/thermal/thermal-sensor.example.dtb: /ex=
ample-0/soc/thermal-sensor@c265000: failed to match any schema with compati=
ble: ['qcom,sdm845-tsens', 'qcom,tsens-v2']

I admit I didn't try to reproduce that, but the patch in question
creates Documentation/devicetree/bindings/pwm/qcom,ipq6018-pwm.yaml and
isn't about temperature stuff at all. So I don't understand where
thermal-sensor and tsens comes into play here. Bot bug?

Best regards
Uwe

--bi43ollq7h2qpl5p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmluXTEACgkQj4D7WH0S
/k5d2QgAk5j8xOD8QtaBY9LPywQb80D30raDaSdFKdb3wTr7OZ867esYpSqMx5sB
Os7iy1eTCRZwAbP/52fsn+b5olc6JSZWxGlZPkZ5xMtPJ/ybC2xwFLC+w0jWMCk8
SnaIB06++1UQ+jAiZ4aiqSdB2LzQRioVdPK2e/+7rfsjNTiS8dfsN+VefmCGwYNF
WNT4eyD/lrgM9d8ETzrMIqPgktSHNoBxaXhIwzaguI8eIdU7H+XNDvwjtLPxtqVn
QnjTJFcEh/RnWkildmb6UwteFClkvVN25pIMjwx4z1glRv2kyumnfdMYHDrV5+ph
5f2hb2nD053Z2lF55+x5WjYs9cPFnQ==
=wTWK
-----END PGP SIGNATURE-----

--bi43ollq7h2qpl5p--

