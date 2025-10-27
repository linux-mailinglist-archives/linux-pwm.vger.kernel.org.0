Return-Path: <linux-pwm+bounces-7493-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D5BDC0F6C5
	for <lists+linux-pwm@lfdr.de>; Mon, 27 Oct 2025 17:46:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B356E484E43
	for <lists+linux-pwm@lfdr.de>; Mon, 27 Oct 2025 16:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38003313283;
	Mon, 27 Oct 2025 16:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V0WnMzga"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C662D46D0;
	Mon, 27 Oct 2025 16:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761582985; cv=none; b=c/c5bzKoTxxLCIeIAKhMRx9MkrkCRwxPduH/de0e203sEiXuOoAgKTTkJOMGIkqlOqE/LaXc8x0Oud8tQt0DTObNcDfI/I1044+5BK14xPu5IrOzulS5wHf6GKKNMQzbtUpZxePdCnw7M8UclfKVrxjeILWi30D0f0IGiXOPonY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761582985; c=relaxed/simple;
	bh=5bkUbFX9gMJW4tdihtLae66ry9QAZ8utSkoN+9IssC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jV+YRD8jzU1H+xJ4WdrDZbE3O3xNbOk7RVnU1Cr/GZvSDWPU124mwFFC1TE03WK39fzyykCVob4LcYeJL6RPlSWheg72+8WOiubgq/nK6vl0fBMx48wd5Hv+NTHoT9sY+Xq10188VohVS+QUrPuGhHgCa2PLi2USKGxUNIhhGvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V0WnMzga; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BB38C4CEF1;
	Mon, 27 Oct 2025 16:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761582984;
	bh=5bkUbFX9gMJW4tdihtLae66ry9QAZ8utSkoN+9IssC0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V0WnMzga6sKwHdBCgsLdugWHbaVkz2FuL79z6EUUqQfj3H+58lpV1b9CED7L6YQyt
	 zsuLAQQyQKzb/TqOh29bSZuQ1JMWE5FcUr5lnbOVTB+DKwa5KY2kDMkXlmDIzKJHKw
	 BLtylgkl74+I8oq/9DLZfjcd6okZ32Ct4UjX8+fKTdlZuMYq0PosUF2KhfR8HhkU+P
	 vsZWnp0fhPLgzb5qWBbhA6fSy9DEytBgLQTpvTUUUevhhdDiRz7Yq2TS+tPIHclZAI
	 kown3/Vsp7Qma0N8P4PhDEZMC8w9KOftikgIIhyBbMNsckHIShExFIEUxhcrkauoVj
	 wtwF4+buAurhA==
Date: Mon, 27 Oct 2025 11:39:17 -0500
From: Bjorn Andersson <andersson@kernel.org>
To: george.moussalem@outlook.com
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Baruch Siach <baruch@tkos.co.il>, 
	Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Devi Priya <quic_devipriy@quicinc.com>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	Baruch Siach <baruch.siach@siklu.com>
Subject: Re: [PATCH v17 1/9] dt-bindings: pwm: add IPQ6018 binding
Message-ID: <r7revm7tle6nh6kggf2kjwdz2pnpfdrn7web4ckqcbkorjodkq@ujl5mfh5eous>
References: <20251008-ipq-pwm-v17-0-9bd43edfc7f7@outlook.com>
 <20251008-ipq-pwm-v17-1-9bd43edfc7f7@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251008-ipq-pwm-v17-1-9bd43edfc7f7@outlook.com>

On Wed, Oct 08, 2025 at 07:32:53PM +0400, George Moussalem via B4 Relay wrote:
> From: Devi Priya <quic_devipriy@quicinc.com>
> 
> DT binding for the PWM block in Qualcomm IPQ6018 SoC.
> 
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Co-developed-by: Baruch Siach <baruch.siach@siklu.com>
> Signed-off-by: Baruch Siach <baruch.siach@siklu.com>
> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>

Thanks for your work on this, George.

We need your Signed-off-by here as well though.

How about squashing the later additions to this same file, to avoid
repeatedly changing the file you introduce here, in this same series?
You can document your contribution by adding a line [george: Added
compatibles for X, Y, Z] before your signed-off-by.

Regards,
Bjorn

> ---
>  .../devicetree/bindings/pwm/qcom,ipq6018-pwm.yaml  | 44 ++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pwm/qcom,ipq6018-pwm.yaml b/Documentation/devicetree/bindings/pwm/qcom,ipq6018-pwm.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..1172f0b53fadc140482f9384a36020260df372b7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/qcom,ipq6018-pwm.yaml
> @@ -0,0 +1,44 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pwm/qcom,ipq6018-pwm.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm IPQ6018 PWM controller
> +
> +maintainers:
> +  - Baruch Siach <baruch@tkos.co.il>
> +
> +properties:
> +  compatible:
> +    const: qcom,ipq6018-pwm
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
> 2.51.0
> 
> 

