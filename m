Return-Path: <linux-pwm+bounces-7127-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E19B2E756
	for <lists+linux-pwm@lfdr.de>; Wed, 20 Aug 2025 23:17:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 348A4AA458D
	for <lists+linux-pwm@lfdr.de>; Wed, 20 Aug 2025 21:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D1EF286D66;
	Wed, 20 Aug 2025 21:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=weathered-steel.dev header.i=@weathered-steel.dev header.b="kQMm3rIG"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-106113.protonmail.ch (mail-106113.protonmail.ch [79.135.106.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0EF2550D0;
	Wed, 20 Aug 2025 21:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755724593; cv=none; b=Ny8QoOkMVUsfbh9NfnQ2NKOD7hGyrwMSBWmrdX9y1GZJ8Qis6N3LGIBtEPFfxJ/fUE88ClGkJlewzITRbNI0/KVeQ9rlZJuiJLIpt0XVeHq3KyeN6pZwuqd+8Lg/w9tUAXa83AfYT9sj3gDdi2tan4M1ODPXSQKdCfPwqRWo0l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755724593; c=relaxed/simple;
	bh=Rtbsy9mYZrYwav5fUL6Fsm0mVjEoIZY/OnkgLKr27Yc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h1qXUEbdtlAgrxsI/4+Du31rfSYgWO8Y6Jz4hC93jK9jDKxqhB87Wgie5OpNwu4McT9R21vjMO7pr6cHFbOyTBK1oVxVXVl7BSTJ+0kWqaWbOgEwEGpvH5C4X00yMZod+LTX3zGybHI2/QXBnwTdIiYuYcWHJMqPesyoh9wG/5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weathered-steel.dev; spf=pass smtp.mailfrom=weathered-steel.dev; dkim=pass (2048-bit key) header.d=weathered-steel.dev header.i=@weathered-steel.dev header.b=kQMm3rIG; arc=none smtp.client-ip=79.135.106.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weathered-steel.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weathered-steel.dev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weathered-steel.dev;
	s=protonmail3; t=1755724588; x=1755983788;
	bh=GrowVB5MF8RNBNwUOvZofvnxbDvD4JbTvirhxl7xE1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:In-Reply-To:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=kQMm3rIGRtZ2UZDa8nH+6paX7zsLGP4rBuWwjsRup9hpRLmC7MdxUGJiLuKiHXNyg
	 381gxbXrkDWdURQuBRW2Rtdz25GeipS++Qku5zR8LXB3NnWP92XxfjukSHyG94mvbP
	 7/1kzFc5I0YKW134r5YJmxF8tgRWHUZQyxjAFVgY1Y04h3bsAHC35w2aFBaXEWtSU2
	 L5P5BsmFAOjYg8ZE5hBfX21ZlDsjBJep2fJF1suNlJsEWoScDzTLVuyKk1/iAVMMDO
	 XG3BtLXtq19i/BBpah2h1URvK0wKAC1jq9LLSR22IqSuaDOAGo7HyD6DIg6QObofRO
	 ZRNnOsICam4fg==
X-Pm-Submission-Id: 4c6fQJ4sXMz2ScCq
Date: Wed, 20 Aug 2025 21:16:19 +0000
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
Subject: Re: [PATCH v14 5/7] dt-bindings: pwm: thead: Add T-HEAD TH1520 PWM
 controller
Message-ID: <aKY7IzAg0IX4UfWW@archiso>
References: <20250820-rust-next-pwm-working-fan-for-sending-v14-0-df2191621429@samsung.com>
 <CGME20250820083546eucas1p2cc370ae89e7a87e3f3b9266967501b44@eucas1p2.samsung.com>
 <20250820-rust-next-pwm-working-fan-for-sending-v14-5-df2191621429@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250820-rust-next-pwm-working-fan-for-sending-v14-5-df2191621429@samsung.com>

On Wed, Aug 20, 2025 at 10:35:40AM +0200, Michal Wilczynski wrote:
> Add the Device Tree binding documentation for the T-HEAD
> TH1520 SoC PWM controller.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Tested-by: Drew Fustini <fustini@kernel.org>
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

Reviewed-by: Elle Rhumsaa <elle@weathered-steel.dev>

