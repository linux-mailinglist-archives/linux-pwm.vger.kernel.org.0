Return-Path: <linux-pwm+bounces-7380-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98D62BB1B9C
	for <lists+linux-pwm@lfdr.de>; Wed, 01 Oct 2025 22:59:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33EAC19C386F
	for <lists+linux-pwm@lfdr.de>; Wed,  1 Oct 2025 20:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2F933019BD;
	Wed,  1 Oct 2025 20:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=weathered-steel.dev header.i=@weathered-steel.dev header.b="VLHTImUa"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx-out2.startmail.com (mx-out2.startmail.com [145.131.90.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081F52D640E;
	Wed,  1 Oct 2025 20:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=145.131.90.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759352374; cv=none; b=O43wHHhALY6r+jqESHqXfUV4KjeyaT1eF8WOvtpuuHl3gqMnayfq7zJ8WM4TwrKm8K+WnB4CQNVWrBq+FBPL461IEdkQqQVVRGyEOD2e1sq9Dbo5gYq+ojNOVtaGvnTQPQFNnLc83WwQQKhujfsvCcbi61tWiY4AZ9tzKu7aBO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759352374; c=relaxed/simple;
	bh=rKWwFvpGkQcQFbnTJ7qLkEj7CYELicnQdbLhOSbXlsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Mime-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JarU02t8dwv9wwY46CQ0OaugtOgdOyZQS98GtQsxLlrKCnZ7BavSXqtc9Yeyx3hMoJGFnAAEjdeWSAk/X9b3iHpVPXUbdpEK+TKVpIaDW5GpQtqL4pS75PKguJ8NwXW7sOmulmYubM3XGIeB5mQMg9J7+HydyuPZCl/LtGo49p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weathered-steel.dev; spf=pass smtp.mailfrom=weathered-steel.dev; dkim=pass (2048-bit key) header.d=weathered-steel.dev header.i=@weathered-steel.dev header.b=VLHTImUa; arc=none smtp.client-ip=145.131.90.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weathered-steel.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weathered-steel.dev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weathered-steel.dev;
	s=startmail1; t=1759352369;
	bh=8dfCwcgkSDoAftKvUS9KyrBMUlCrd2D7DWmwBmaRRbU=;
	h=Date:From:To:Subject:Message-ID:References:Mime-Version:
	 Content-Type:Content-Disposition:In-Reply-To:From:Subject:To:Date:
	 Sender:Content-Type:Content-Transfer-Encoding:Content-Disposition:
	 Mime-Version:Reply-To:In-Reply-To:References:Message-Id:
	 List-Unsubscribe:List-Unsubscribe-Post:Autocrypt;
	b=VLHTImUaYmGsqK6+nUVqXxljt6D0gCXGdthsOzZkJf1d1FZ6lAdejKxrGy//fMxnp
	 AUa1isgj6G05rsLrRfxvBF0AAHdg1MYBTQrxgeMTsNEHqglmdkMYLnhoH64WLXAGN8
	 fJ3zQG+fRc78/Xs8WAfNAeggjnUkFhSMsjsCjvvB80WAh07+fBpi1Bq/RZCLDdSz0B
	 Bcr7g56tFMcIgz496CPwxw/f3WbPGPotmGh5BHZpxKurH83JaJ3EYb75TklzkQd61u
	 WHpuaJH7NywGWRqRjT0DbKyNrNuo9DCg90CDe9FzHo1l1fXVpCa4J1ghNXDD4to+lm
	 NaLONDU3z4n3A==
Date: Wed, 1 Oct 2025 20:59:26 +0000
From: Elle Rhumsaa <elle@weathered-steel.dev>
To: Michal Wilczynski <m.wilczynski@samsung.com>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>, Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Benno Lossin <lossin@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Drew Fustini <fustini@kernel.org>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v15 5/7] dt-bindings: pwm: thead: Add T-HEAD TH1520 PWM
 controller
Message-ID: <aN2WLimu68NyqxJG@archiso>
References: <20250930-rust-next-pwm-working-fan-for-sending-v15-0-5661c3090877@samsung.com>
 <CGME20250930122735eucas1p1c49ed11a4a48155c123ead6aec4b64a2@eucas1p1.samsung.com>
 <20250930-rust-next-pwm-working-fan-for-sending-v15-5-5661c3090877@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250930-rust-next-pwm-working-fan-for-sending-v15-5-5661c3090877@samsung.com>

On Tue, Sep 30, 2025 at 02:20:36PM +0200, Michal Wilczynski wrote:
> Add the Device Tree binding documentation for the T-HEAD
> TH1520 SoC PWM controller.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Tested-by: Drew Fustini <fustini@kernel.org>
> Reviewed-by: Elle Rhumsaa <elle@weathered-steel.dev>
> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
> ---
>  .../devicetree/bindings/pwm/thead,th1520-pwm.yaml  | 48 ++++++++++++++++++++++
>  MAINTAINERS                                        |  1 +
>  2 files changed, 49 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pwm/thead,th1520-pwm.yaml b/Documentation/devicetree/bindings/pwm/thead,th1520-pwm.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..855aec59ac53c430adc849271235686e87b10e6c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/thead,th1520-pwm.yaml
> @@ -0,0 +1,48 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pwm/thead,th1520-pwm.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: T-HEAD TH1520 PWM controller
> +
> +maintainers:
> +  - Michal Wilczynski <m.wilczynski@samsung.com>
> +
> +allOf:
> +  - $ref: pwm.yaml#
> +
> +properties:
> +  compatible:
> +    const: thead,th1520-pwm
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: SoC PWM clock
> +
> +  "#pwm-cells":
> +    const: 3
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/thead,th1520-clk-ap.h>
> +    soc {
> +      #address-cells = <2>;
> +      #size-cells = <2>;
> +      pwm@ffec01c000 {
> +          compatible = "thead,th1520-pwm";
> +          reg = <0xff 0xec01c000 0x0 0x4000>;
> +          clocks = <&clk CLK_PWM>;
> +          #pwm-cells = <3>;
> +      };
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d79dc21f22d143ca8cde6a06194545fbc640e695..a64027f441e8e23c579b469b2451b514e5d2802c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -21732,6 +21732,7 @@ F:	Documentation/devicetree/bindings/firmware/thead,th1520-aon.yaml
>  F:	Documentation/devicetree/bindings/mailbox/thead,th1520-mbox.yaml
>  F:	Documentation/devicetree/bindings/net/thead,th1520-gmac.yaml
>  F:	Documentation/devicetree/bindings/pinctrl/thead,th1520-pinctrl.yaml
> +F:	Documentation/devicetree/bindings/pwm/thead,th1520-pwm.yaml
>  F:	Documentation/devicetree/bindings/reset/thead,th1520-reset.yaml
>  F:	arch/riscv/boot/dts/thead/
>  F:	drivers/clk/thead/clk-th1520-ap.c
> 
> -- 
> 2.34.1
> 
Reviewed-by: Elle Rhumsaa <elle@weathered-steel.dev>

