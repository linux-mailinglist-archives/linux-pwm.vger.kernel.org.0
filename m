Return-Path: <linux-pwm+bounces-7529-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA68C1BAAB
	for <lists+linux-pwm@lfdr.de>; Wed, 29 Oct 2025 16:31:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F2FA6253DA
	for <lists+linux-pwm@lfdr.de>; Wed, 29 Oct 2025 15:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE1342FF161;
	Wed, 29 Oct 2025 15:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TxSnS6CL"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7D72F12A0;
	Wed, 29 Oct 2025 15:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761751178; cv=none; b=WKC5LkXnfiju9jUi2axMs6aMC4bV8FwOhfZGkwyRhgbBYwSoRWfy+XiQ+xuBYxuCQKw5/Dx3GPHPK4IMTJTIVlU2IX156RnDIIMQK+Hv2nou32Qt7Nz2U8eEmJGanMzK0nG1RlTz0IFWAcC+XWpMwSRsEHuDW8i0WcWljM5P6pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761751178; c=relaxed/simple;
	bh=3JfNQo+M21Fj37FKvWiKjtWeQMPxwV5uRtgj06oRTOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c/q0dYkgroUAVRKliR6t2d0cgUPk8Na1G6oTqEIt2l++hcJW2FplscfzLQY9CV/pqBEuiMyZLajXAkH3A6rw4orjBnWW5B0VKnQZwNeueINsP5eMoE8f0zFkr7uye7vhL4dRJAy+fjZ0D1RngM705+hNL9Xsv7C2yy9NNLx8qD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TxSnS6CL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02710C4CEF8;
	Wed, 29 Oct 2025 15:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761751178;
	bh=3JfNQo+M21Fj37FKvWiKjtWeQMPxwV5uRtgj06oRTOY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TxSnS6CLDVT3HGmhCi2XCkNvUYVYsXFLCfPyA5iC3ve1K2ILlAI9zXpbobFdPM70V
	 eDa6kXgPAd8yRd6YeaLV2lQSqVtC794EwQ76A9dowTcCEyj+0UfDx9owtblAeoUGdf
	 xqTWuE7Tqfs3tt8tcV/PGTJYIWfJeXwNXpziA6AyMspEVQm1f+FraChVQ4WK1yL7ey
	 jqChgdvXpj/zdeYEbO+c1n9zTYtG3P4k0kmpreLqoEJTo9jUdbC9+Ckuo1ap86eN+2
	 9Udd0z0aIoGKQ9bWHjTRvwVUsHD3vZGKtGBZeE+rQKQEJnzsQkm2vAZGWExm4+NKhb
	 Lv8pEVDnQNJOw==
Date: Wed, 29 Oct 2025 10:22:41 -0500
From: Bjorn Andersson <andersson@kernel.org>
To: george.moussalem@outlook.com
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Baruch Siach <baruch@tkos.co.il>, 
	Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Devi Priya <quic_devipriy@quicinc.com>, Baruch Siach <baruch.siach@siklu.com>, 
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v18 1/6] dt-bindings: pwm: add IPQ6018 binding
Message-ID: <gkvbziqeae53bunqd556r4swaye4s4lcnwthryouynwfwqrnsi@6o4cjgxiwxco>
References: <20251029-ipq-pwm-v18-0-edbef8efbb8e@outlook.com>
 <20251029-ipq-pwm-v18-1-edbef8efbb8e@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029-ipq-pwm-v18-1-edbef8efbb8e@outlook.com>

On Wed, Oct 29, 2025 at 12:36:57PM +0400, George Moussalem via B4 Relay wrote:
> From: Devi Priya <quic_devipriy@quicinc.com>
> 
> DT binding for the PWM block in Qualcomm IPQ6018 SoC.
> [George: added compatibles for IPQ5018, IPQ5332, and IPQ9574]
> 
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Co-developed-by: Baruch Siach <baruch.siach@siklu.com>
> Signed-off-by: Baruch Siach <baruch.siach@siklu.com>
> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>

This is where we expect the [George: ...] comment.

I'll leave it up to Uwe to determine if he'd like you to resubmit this
or not though...

> Signed-off-by: George Moussalem <george.moussalem@outlook.com>

I think this patch looks good now.

Thank you,
Bjorn

> ---
>  .../devicetree/bindings/pwm/qcom,ipq6018-pwm.yaml  | 51 ++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pwm/qcom,ipq6018-pwm.yaml b/Documentation/devicetree/bindings/pwm/qcom,ipq6018-pwm.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..ca8e916f03276e93d755d574e2567b0e4b86a8ce
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/qcom,ipq6018-pwm.yaml
> @@ -0,0 +1,51 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pwm/qcom,ipq6018-pwm.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm IPQ6018 PWM controller
> +
> +maintainers:
> +  - George Moussalem <george.moussalem@outlook.com>
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - enum:
> +              - qcom,ipq5018-pwm
> +              - qcom,ipq5332-pwm
> +              - qcom,ipq9574-pwm
> +          - const: qcom,ipq6018-pwm
> +      - const: qcom,ipq6018-pwm
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  "#pwm-cells":
> +    const: 2
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - "#pwm-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/qcom,gcc-ipq6018.h>
> +
> +    pwm: pwm@1941010 {
> +        compatible = "qcom,ipq6018-pwm";
> +        reg = <0x01941010 0x20>;
> +        clocks = <&gcc GCC_ADSS_PWM_CLK>;
> +        assigned-clocks = <&gcc GCC_ADSS_PWM_CLK>;
> +        assigned-clock-rates = <100000000>;
> +        #pwm-cells = <2>;
> +    };
> 
> -- 
> 2.51.1
> 
> 

