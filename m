Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2D7D3C7BE4
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Jul 2021 04:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237513AbhGNCnJ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 13 Jul 2021 22:43:09 -0400
Received: from mail-il1-f174.google.com ([209.85.166.174]:46789 "EHLO
        mail-il1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237478AbhGNCnJ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 13 Jul 2021 22:43:09 -0400
Received: by mail-il1-f174.google.com with SMTP id y6so67825ilj.13;
        Tue, 13 Jul 2021 19:40:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=riDFU7JLN9rdxbZ0yha84VJqHGAQItObLh3l+N0JqmE=;
        b=mEa55NW0kVDXs6XLun0o0XtAT6bE6CqA0JcmzkjjNy119u9HD7wv9q7QWFOaRikTMC
         tvMbBwgWiJLH0b2vWG8jWQCB3byQwsCEdnJvdROUkZ43D1NdqGny+eBUaXLgP8YL6iaU
         9Y1y5UmxCBhwIPkkDUTXty59rlNrtnkjVfXzo2SCvsVBr6SXGdUX0/xGNsymPDn3TCcu
         r8nZ6+qgG7gEvJrNG9hSaLVEYC29Phwbfzp6SGufV/dUK+vdN5bSLEmmx+1yI7E1uMoH
         XJkWIyt75V8Hm0zfHOJOAKfBpdBC13sNVXNWNJCW5hO1eOxnity/XDjI7QBgJbgDQv9C
         sgfw==
X-Gm-Message-State: AOAM53156VsSNZlohNCXTT8N5FAVGm12i+DcFAyG0UDrYcZWidlxNeSC
        bghuL230FxRIxKLZWCZJew==
X-Google-Smtp-Source: ABdhPJyYpTVJnJWr7IspJv6gkKDKsVeyNcozRDAHV5BN+pzvPlKtikW62UPo9J9JYyBz7AeGniakEg==
X-Received: by 2002:a92:b003:: with SMTP id x3mr5176007ilh.93.1626230418602;
        Tue, 13 Jul 2021 19:40:18 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id d8sm407613iom.49.2021.07.13.19.40.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 19:40:17 -0700 (PDT)
Received: (nullmailer pid 1350780 invoked by uid 1000);
        Wed, 14 Jul 2021 02:40:14 -0000
Date:   Tue, 13 Jul 2021 20:40:14 -0600
From:   Rob Herring <robh@kernel.org>
To:     Baruch Siach <baruch@tkos.co.il>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Balaji Prakash J <bjagadee@codeaurora.org>,
        Robert Marko <robert.marko@sartura.hr>,
        Kathiravan T <kathirav@codeaurora.org>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 3/4] dt-bindings: pwm: add IPQ6018 binding
Message-ID: <20210714024014.GA1334332@robh.at.kernel.org>
References: <f79128fa287e37ee59cb03ae04b319ecb3d68c29.1626176145.git.baruch@tkos.co.il>
 <6d3a4483d22753ba8114304db07756620c66da41.1626176145.git.baruch@tkos.co.il>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d3a4483d22753ba8114304db07756620c66da41.1626176145.git.baruch@tkos.co.il>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, Jul 13, 2021 at 02:35:44PM +0300, Baruch Siach wrote:
> DT binding for the PWM block in Qualcomm IPQ6018 SoC.
> 
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> ---
> v5: Use qcom,pwm-regs for phandle instead of direct regs (Bjorn
>     Andersson, Kathiravan T)
> 
> v4: Update the binding example node as well (Rob Herring's bot)
> 
> v3: s/qcom,pwm-ipq6018/qcom,ipq6018-pwm/ (Rob Herring)
> 
> v2: Make #pwm-cells const (Rob Herring)
> ---
>  .../devicetree/bindings/pwm/ipq-pwm.yaml      | 55 +++++++++++++++++++
>  1 file changed, 55 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/ipq-pwm.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pwm/ipq-pwm.yaml b/Documentation/devicetree/bindings/pwm/ipq-pwm.yaml
> new file mode 100644
> index 000000000000..a07bfe63dc1a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/ipq-pwm.yaml
> @@ -0,0 +1,55 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pwm/ipq-pwm.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm IPQ6018 PWM controller
> +
> +maintainers:
> +  - Baruch Siach <baruch@tkos.co.il>
> +
> +properties:
> +  "#pwm-cells":
> +    const: 2
> +
> +  compatible:
> +    const: qcom,ipq6018-pwm
> +
> +  qcom,pwm-regs:
> +    $ref: '/schemas/types.yaml#/definitions/phandle-array'
> +    maxItems: 1
> +    description: |
> +      phandle link and offset to TCSR block

This binding should be a child of the TCSR I think as Bjorn asked.

> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    const: core
> +
> +required:
> +  - "#pwm-cells"
> +  - compatible
> +  - qcom,pwm-regs
> +  - clocks
> +  - clock-names
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/qcom,gcc-ipq6018.h>
> +
> +    soc {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        pwm {
> +            #pwm-cells = <2>;
> +            compatible = "qcom,ipq6018-pwm";
> +            qcom,pwm-regs = <&tcsr_q6 0xa010>;
> +            clocks = <&gcc GCC_ADSS_PWM_CLK>;
> +            clock-names = "core";
> +        };
> +    };
> -- 
> 2.30.2
> 
> 
