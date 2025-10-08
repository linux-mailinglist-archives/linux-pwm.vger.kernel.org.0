Return-Path: <linux-pwm+bounces-7419-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 88328BC5FE8
	for <lists+linux-pwm@lfdr.de>; Wed, 08 Oct 2025 18:18:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 11A4534E813
	for <lists+linux-pwm@lfdr.de>; Wed,  8 Oct 2025 16:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F030225486D;
	Wed,  8 Oct 2025 16:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tkos.co.il header.i=@tkos.co.il header.b="OERXjzjC"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail.tkos.co.il (wiki.tkos.co.il [84.110.109.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6082417E6;
	Wed,  8 Oct 2025 16:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.110.109.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759940312; cv=none; b=RWsTnFURQplvypwA3gnXmyhmWMsWtoP7OkQpAHAoZhA39CpzV2/MsrhiV6M4uan5USpwXmw3uOqWeEXwHpP9uZ8AL1OzHhVmv0MVnKVT0H7zLrRXKJuNA8fin1NN0r5BX7NP9PuxSJI5ubAzzIxfl942NnuinWVvnD0WRhZDxVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759940312; c=relaxed/simple;
	bh=PbMDtEvTjUpuOYUXU318hJZ2SLk5Jfj316HRQAhtXVQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lULdwtLx5NmFxgHjGWag5yFEC1UaREwT7x6cpE1sMW1F5XFJjX8BLZon9Q/+PL8nEO6+zFCIYIf86Vad8sPSf4e7FR/TAtCWwgHX0GzEYZIOI2V6t34S/TLcFneKt83pvZzXtE4w9z7anLtLatvcpJPUT1EXrcRgjKG1N6qbyss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tkos.co.il; spf=pass smtp.mailfrom=tkos.co.il; dkim=pass (2048-bit key) header.d=tkos.co.il header.i=@tkos.co.il header.b=OERXjzjC; arc=none smtp.client-ip=84.110.109.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tkos.co.il
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tkos.co.il
Received: from localhost (unknown [10.0.8.2])
	by mail.tkos.co.il (Postfix) with ESMTP id 08B074400C6;
	Wed,  8 Oct 2025 19:07:31 +0300 (IDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tkos.co.il;
	s=default; t=1759939651;
	bh=PbMDtEvTjUpuOYUXU318hJZ2SLk5Jfj316HRQAhtXVQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=OERXjzjC7qIH/cjKSmeX8G0qmWI2QVC+WFWpFq5Q2+R+QWUWlSilRGMFzAN9YswGW
	 KmLYDvxeDPlcWphNSSufvurGdwuy//ToQzN7+GFK3XJuhR8JfJH1nxkPn8eEevIa8Y
	 9lppD0gUPFW2uGIKBMx/kGIyxmUjt76/44mEtUlq1nlqBBibfDOeUhOWvvQxmcC/ox
	 7reHJr7ayDgoEw9cdiA3/zZdYpm5yatYq5ethj/dEMjmBjxepmVYEGfYAnI865x0uz
	 Gcotn5fR4BKsSyWk6lVxDWwWVuGH3xh5AsaB9mfl1c+A1z6ZE5jeGpJRmtwqMbNUgN
	 V35+eeYy1sKNw==
From: Baruch Siach <baruch@tkos.co.il>
To: George Moussalem via B4 Relay
 <devnull+george.moussalem.outlook.com@kernel.org>
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,  Rob Herring
 <robh@kernel.org>,
  Krzysztof Kozlowski <krzk+dt@kernel.org>,  Conor Dooley
 <conor+dt@kernel.org>,  Bjorn Andersson <andersson@kernel.org>,  Konrad
 Dybcio <konradybcio@kernel.org>,  george.moussalem@outlook.com,
  linux-arm-msm@vger.kernel.org,  linux-pwm@vger.kernel.org,
  devicetree@vger.kernel.org,  linux-kernel@vger.kernel.org,  Devi Priya
 <quic_devipriy@quicinc.com>,  Krzysztof Kozlowski
 <krzysztof.kozlowski@linaro.org>,  Baruch Siach <baruch.siach@siklu.com>
Subject: Re: [PATCH v17 1/9] dt-bindings: pwm: add IPQ6018 binding
In-Reply-To: <20251008-ipq-pwm-v17-1-9bd43edfc7f7@outlook.com> (George
	Moussalem via's message of "Wed, 08 Oct 2025 19:32:53 +0400")
References: <20251008-ipq-pwm-v17-0-9bd43edfc7f7@outlook.com>
	<20251008-ipq-pwm-v17-1-9bd43edfc7f7@outlook.com>
User-Agent: mu4e 1.12.12; emacs 30.1
Date: Wed, 08 Oct 2025 19:08:28 +0300
Message-ID: <87347tl6kj.fsf@tarshish>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi George,

On Wed, Oct 08 2025, George Moussalem via B4 Relay wrote:
> From: Devi Priya <quic_devipriy@quicinc.com>
>
> DT binding for the PWM block in Qualcomm IPQ6018 SoC.
>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Co-developed-by: Baruch Siach <baruch.siach@siklu.com>
> Signed-off-by: Baruch Siach <baruch.siach@siklu.com>
> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
> ---
>  .../devicetree/bindings/pwm/qcom,ipq6018-pwm.yaml  | 44 ++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/pwm/qcom,ipq6018-pwm.yaml
> b/Documentation/devicetree/bindings/pwm/qcom,ipq6018-pwm.yaml
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

Unfortunately I have no access to this PWM hardware anymore. I don't
think I can maintain hardware DT binding.

baruch

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

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -

