Return-Path: <linux-pwm+bounces-5303-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8667DA74DEF
	for <lists+linux-pwm@lfdr.de>; Fri, 28 Mar 2025 16:37:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78EA3188B211
	for <lists+linux-pwm@lfdr.de>; Fri, 28 Mar 2025 15:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B53A31531E3;
	Fri, 28 Mar 2025 15:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VH7hJnjp"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86295DF58;
	Fri, 28 Mar 2025 15:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743176247; cv=none; b=Nz/pGEDWfGh/tYMiwGco0W8MUwEqqWFBs3YYaq2+xA9HPVIwz2ANka/BlfKyYif/8ySeJ6Q7tMosL6enuAK0TElwqNHoBG5v1KfEOKSjSOOmZwqGqY+t5qbRaxkLg2jMZT5GWkDbPlKuNM5UIGP2UFSDQNoIHrSI+/3Dbplvc/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743176247; c=relaxed/simple;
	bh=o4MexGeb/LCpfw+0KdNpOfw/qNqhCqQrnnNXSCVaV98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TVgA1tjosK05j9oMq2M3uRQSeMYNsr8lkuubVRgjDySWBmstk2BiDOO4rvuIJAE0BHuPCdJQDSupzlcXOFLk7CnRwdtxyYKEVvyzMPhTS06oAprnwaMRKWyCmisvCBR4NB/gX5GktReI6igibgvc55LXA9xzVoE0I47c03QwfcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VH7hJnjp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 405D7C4CEE4;
	Fri, 28 Mar 2025 15:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743176246;
	bh=o4MexGeb/LCpfw+0KdNpOfw/qNqhCqQrnnNXSCVaV98=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VH7hJnjpc3CNEE9iiPG3U/eaOHN+lNXoNYntt6CUo1/7mPU0rqaGMOvBRmGMYS8oj
	 QKMV22W0DsOjScMWSADUY/8ZEJynt0XR/2g2DHWzPyNc3OUwuWv45rDyFwYBPHWFDv
	 Rq1Q9mRAY/2Uzh50OsbCwOs9sCAPyjZdnZ+3+oGd+LDf2t/Nrp+1Oh42G4GP5SqFIH
	 0HbgEAvtMjiMOO6jLhh3sJCpOFICL/aw+pC9C/D2TBsin/ucRGMSF0t+q0CbNIiBQG
	 5G+iqdgboI8btzYV8dTFrVCQZDTeLnbWUQYTh4Ymrqx7xdcn9sqwUeCKBApi8Q5OZ6
	 rXz9EdLtagH6Q==
Date: Fri, 28 Mar 2025 16:37:23 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Binbin Zhou <zhoubinbin@loongson.cn>
Cc: Binbin Zhou <zhoubb.aaron@gmail.com>, 
	Huacai Chen <chenhuacai@loongson.cn>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Juxin Gao <gaojuxin@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, 
	Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev, devicetree@vger.kernel.org, 
	linux-pwm@vger.kernel.org, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v9 1/2] dt-bindings: pwm: Add Loongson PWM controller
Message-ID: <bfbni6q322ag7r3pzgcflec4dhx4luvrdqerzkoslfuczhdnb3@xxwdodl25v64>
References: <cover.1739784071.git.zhoubinbin@loongson.cn>
 <d6be5236ab4ff5b5fde78004c38d8bced42f2ba2.1739784071.git.zhoubinbin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="j57y2bovoac6vyqv"
Content-Disposition: inline
In-Reply-To: <d6be5236ab4ff5b5fde78004c38d8bced42f2ba2.1739784071.git.zhoubinbin@loongson.cn>


--j57y2bovoac6vyqv
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v9 1/2] dt-bindings: pwm: Add Loongson PWM controller
MIME-Version: 1.0

On Mon, Feb 17, 2025 at 05:30:24PM +0800, Binbin Zhou wrote:
> Add Loongson PWM controller binding with DT schema format using
> json-schema.
>=20
> Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Acked-by: Huacai Chen <chenhuacai@loongson.cn>

nitpick: Please put your S-o-b last.

> ---
>  .../bindings/pwm/loongson,ls7a-pwm.yaml       | 66 +++++++++++++++++++
>  MAINTAINERS                                   |  6 ++
>  2 files changed, 72 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/loongson,ls7a-p=
wm.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/pwm/loongson,ls7a-pwm.yaml=
 b/Documentation/devicetree/bindings/pwm/loongson,ls7a-pwm.yaml
> new file mode 100644
> index 000000000000..46814773e0cc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/loongson,ls7a-pwm.yaml
> @@ -0,0 +1,66 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pwm/loongson,ls7a-pwm.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Loongson PWM Controller
> +
> +maintainers:
> +  - Binbin Zhou <zhoubinbin@loongson.cn>
> +
> +description:
> +  The Loongson PWM has one pulse width output signal and one pulse input
> +  signal to be measured.
> +  It can be found on Loongson-2K series cpus and Loongson LS7A bridge ch=
ips.
> +
> +allOf:
> +  - $ref: pwm.yaml#
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - const: loongson,ls7a-pwm
> +      - items:
> +          - enum:
> +              - loongson,ls2k0500-pwm
> +              - loongson,ls2k1000-pwm
> +              - loongson,ls2k2000-pwm
> +          - const: loongson,ls7a-pwm
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  '#pwm-cells':
> +    description:
> +      The first cell must have a value of 0, which specifies the PWM out=
put signal;
> +      The second cell is the period in nanoseconds;
> +      The third cell flag supported by this binding is PWM_POLARITY_INVE=
RTED.
> +    const: 3
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/clock/loongson,ls2k-clk.h>
> +    pwm@1fe22000 {

Another nitpick: I would have added another \n between the includes and
the dt node.

Looking at the output of `git grep -A1 \#include
Documentation/devicetree/bindings/pwm/` this isn't consistent, but the
empty line is the more usual approach.

I'll look into the 2nd patch and if these two nitpicks are the only
concerns left, I'll fixup accordingly unless you object.

Best regards
Uwe

--j57y2bovoac6vyqv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmfmwjEACgkQj4D7WH0S
/k63cggAnyX1KlC2wwh7YaLfvZN82jX3GLsU6rw3NXPWLBhPEy5OMxSn2Mx6jHLB
onFUx2IVzLonJcxH+Bb6egH6nqZAThnvVXt4lthGTr4Fitco+GPK/EkX5Srvy/k7
WE7JfIITs+crTgIpu0Hs2syIAjzRvLQspiHXxVj8wOFvGUs2BIx+nC2XiDcREa1b
8dm6i20kxfeDVlPNpUknPxJVX/lWjD3koXecNhYShzvYeOgGc7lJ2JtklT3jnCFt
sCnHvLyqgFRthLbbe4IkOHinnYuIvM+THqSAxptWzEaKQDjpl5+7iW3nO0cG3gb/
8QqAXpoxqMNseH2se8PY+hUyZ5UJlg==
=Lp1W
-----END PGP SIGNATURE-----

--j57y2bovoac6vyqv--

