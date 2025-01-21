Return-Path: <linux-pwm+bounces-4693-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1303DA17CD5
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Jan 2025 12:16:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11881165237
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Jan 2025 11:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFBAA1F1502;
	Tue, 21 Jan 2025 11:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tj1QAG+L"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48C81F12FD;
	Tue, 21 Jan 2025 11:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737458186; cv=none; b=k/xnqTl2IqQDMICwr8vN+VfjZNQIU4sNg38jrKtTMEFB9yjGRTyXGTOD8qZmDut7yARfPmdTMfGe6uOgKBvy/e4loQeUufdczqxaTKfMpSCQS6/99y4WCRS02mvX/Vy+Ti9ZexK/lkns3BaZbNuK+6TXtNeJeWzlVqURrrb/Wds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737458186; c=relaxed/simple;
	bh=Yul0dY1W7TJ0im0cLifhL477CvUbR0lwcyOhbO9oTRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=roUnzGAxdxgS2oESZqWn3g1kokaaqkQf8ahsqjx3obLW3NvrIIGRULu7E8IKF4PY4uCtQxTNPIbVgK2tkdAxSQb49Cgm/hP2z57npAM9U8JoTJwYBv2ISdnPxp5XCrpGgP5sNyva176Kg+4NkryTrMpNhHS2GJBAxnQ9QV2HpqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tj1QAG+L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CCCBC4CEE2;
	Tue, 21 Jan 2025 11:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737458186;
	bh=Yul0dY1W7TJ0im0cLifhL477CvUbR0lwcyOhbO9oTRQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tj1QAG+Lp9mTno6/VicWbthUXpIn9zxXN0HpvL8Bqy7RsEZFnRpoWcev8XTvvLzje
	 ji9jtmkhzI2w0eF0Z2nKnKEzlz7/L0TsYEUYGWgPQshOuFa+YmziZm1ZeB4/mqzeEp
	 6RFvH4CiX3IyNF33DrOwl9Q6N7NL3L7DqRyTNks7zjyuDN1vuXCEJjE1K2tLzYfng6
	 Ts24kPif9FUADKJSojOOGL4IjapslzRIti2v5kvOWf8q9g7GdAoj+zaApyduasGhb+
	 SWBucR1vfzROWjWL73QnJnpQf7IHZX9uMVgKaQL1OihLzRgIjls+nqL8C89xflGAEY
	 5k3Q4TEFuFiyA==
Date: Tue, 21 Jan 2025 12:16:23 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Chen Wang <unicornxw@gmail.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	unicorn_wang@outlook.com, inochiama@outlook.com, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, linux-riscv@lists.infradead.org, 
	chao.wei@sophgo.com, haijiao.liu@sophgo.com, xiaoguang.xing@sophgo.com, 
	chunzhi.lin@sophgo.com, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v6 1/3] dt-bindings: pwm: sophgo: add PWM controller for
 SG2042
Message-ID: <dvjnhptep4fa3iqxzsau5fdp7qrno4nhnpdecvvyb55h6sxjpl@ohnvvbldwtpj>
References: <cover.1733281657.git.unicorn_wang@outlook.com>
 <673f314d78ab467399afc02b96ac730149f19587.1733281657.git.unicorn_wang@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="huec3nvjneppu6k6"
Content-Disposition: inline
In-Reply-To: <673f314d78ab467399afc02b96ac730149f19587.1733281657.git.unicorn_wang@outlook.com>


--huec3nvjneppu6k6
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v6 1/3] dt-bindings: pwm: sophgo: add PWM controller for
 SG2042
MIME-Version: 1.0

Hello,

On Wed, Dec 04, 2024 at 11:16:22AM +0800, Chen Wang wrote:
> From: Chen Wang <unicorn_wang@outlook.com>
>=20
> Sophgo SG2042 contains a PWM controller, which has 4 channels and
> can generate PWM waveforms output.
>=20
> Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Nitpick: Put your S-o-b last.

> ---
>  .../bindings/pwm/sophgo,sg2042-pwm.yaml       | 58 +++++++++++++++++++
>  1 file changed, 58 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/sophgo,sg2042-p=
wm.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/pwm/sophgo,sg2042-pwm.yaml=
 b/Documentation/devicetree/bindings/pwm/sophgo,sg2042-pwm.yaml
> new file mode 100644
> index 000000000000..5dea41fa4c44
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/sophgo,sg2042-pwm.yaml
> @@ -0,0 +1,58 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pwm/sophgo,sg2042-pwm.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Sophgo SG2042 PWM controller
> +
> +maintainers:
> +  - Chen Wang <unicorn_wang@outlook.com>
> +
> +description:
> +  This controller contains 4 channels which can generate PWM waveforms.
> +
> +allOf:
> +  - $ref: pwm.yaml#
> +
> +properties:
> +  compatible:
> +    const: sophgo,sg2042-pwm
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    items:
> +      - const: apb
> +
> +  resets:
> +    maxItems: 1
> +
> +  "#pwm-cells":
> +    const: 2

Please use 3 here.

> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - resets
> +
> +unevaluatedProperties: false

Best regards
Uwe

--huec3nvjneppu6k6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmePggUACgkQj4D7WH0S
/k5JIQgAlxVeCOpps3Aki/zCI/ccjfWrmWRKg7iuCZ0woJgM7spcEL3XFnczHG9i
Zc9+LCG42ERSL5mlJ2HAw5jHde3JqrVgkJZFbGWQIDNMR1ni0MH2vsHAykE/Nprc
cZIMIbqh9AQ+BUythNR026bYYBBA0OrleoljbDDsStC2JBOKDsCsmq51qgKlqWxy
zaYPLxtCwIbgUkQmXWMC2VOlGakZFB/lNlngQq1nYRyTawCaLLyzGYg5uPTWfkSX
oQtPBjlcDi1qfkObHzFZGc+rdi/aW/3xwjcRNWxWJ/Cmz+ylGlDErrZ5QglwHl/9
+qNNVMMZULpWG9c2KZao+uyJOAAIhQ==
=0J6r
-----END PGP SIGNATURE-----

--huec3nvjneppu6k6--

