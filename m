Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D9FB3D4338
	for <lists+linux-pwm@lfdr.de>; Sat, 24 Jul 2021 01:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232904AbhGWWXG (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 23 Jul 2021 18:23:06 -0400
Received: from mail-io1-f48.google.com ([209.85.166.48]:37877 "EHLO
        mail-io1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231954AbhGWWXG (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 23 Jul 2021 18:23:06 -0400
Received: by mail-io1-f48.google.com with SMTP id r18so4416411iot.4;
        Fri, 23 Jul 2021 16:03:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=DW4bQw9bBu1BhDL+EWMhBLTiwn6MVnii4A/u2r0uOO4=;
        b=ihIKncyVTDq4wTE8FoYN9zK3HA34IhaxvttAOwvSf4dlt/dfr8OoqDgWVyRduLDRAZ
         uSz/c63/3fcK5gaGBMgFTaf8/eD0KrhapTJcn6D6dq51sA9pK/0bHPXie7JzzDQIrXP7
         /uYGXaE9J5GoytxRo92FuvFBtkMen7rDgIMuFv7l+XNp2/WWosHCBDaIm8IdHSwGW5j8
         cf7h/8dDDrgbOj3JONe+8tMj5UwE//HFIh1f9obD9kKOHnLYmE5RSPzphqNIgBkaZu8W
         Xcx9bdrPE0PlXIRQRoW4/c5exb2Xxzam2S2pZiARHA2axmus93FQzuO6pqavC8GVzWH9
         Yoiw==
X-Gm-Message-State: AOAM530Fa2lZxduIwuxZwY+2VNQIolTHvn+AzrAPMx2oeUBDKHd029bq
        k51KOrUE28UqlIJfGguk3Q==
X-Google-Smtp-Source: ABdhPJzkKRM3SdTpwR7KsVQI2xc7VD6bxG1O9jkUH3Cu4HixVa3X3vQH5/ZVGWU5h977KexrakHw8w==
X-Received: by 2002:a05:6638:25c7:: with SMTP id u7mr6034251jat.26.1627081418604;
        Fri, 23 Jul 2021 16:03:38 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id v18sm17161933iln.49.2021.07.23.16.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jul 2021 16:03:38 -0700 (PDT)
Received: (nullmailer pid 2770149 invoked by uid 1000);
        Fri, 23 Jul 2021 23:03:36 -0000
Date:   Fri, 23 Jul 2021 17:03:36 -0600
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
Subject: Re: [PATCH v6 3/4] dt-bindings: pwm: add IPQ6018 binding
Message-ID: <20210723230336.GA2764383@robh.at.kernel.org>
References: <889aae1b88f120cb6281919d27164a959fbe69d0.1626948070.git.baruch@tkos.co.il>
 <70f0522a9394e9da2f31871442d47f6ad0ff41aa.1626948070.git.baruch@tkos.co.il>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <70f0522a9394e9da2f31871442d47f6ad0ff41aa.1626948070.git.baruch@tkos.co.il>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, Jul 22, 2021 at 01:01:09PM +0300, Baruch Siach wrote:
> DT binding for the PWM block in Qualcomm IPQ6018 SoC.
> 
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> ---
> v6:
> 
>   Device node is child of TCSR; remove phandle (Rob Herring)
> 
>   Add assigned-clocks/assigned-clock-rates (Uwe Kleine-König)
> 
> v5: Use qcom,pwm-regs for phandle instead of direct regs (Bjorn
>     Andersson, Kathiravan T)
> 
> v4: Update the binding example node as well (Rob Herring's bot)
> 
> v3: s/qcom,pwm-ipq6018/qcom,ipq6018-pwm/ (Rob Herring)
> 
> v2: Make #pwm-cells const (Rob Herring)
> ---
>  .../devicetree/bindings/pwm/ipq-pwm.yaml      | 69 +++++++++++++++++++
>  1 file changed, 69 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/ipq-pwm.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pwm/ipq-pwm.yaml b/Documentation/devicetree/bindings/pwm/ipq-pwm.yaml
> new file mode 100644
> index 000000000000..ee2bb03a1223
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/ipq-pwm.yaml
> @@ -0,0 +1,69 @@
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
> +  offset:
> +    description: |
> +      Offset of PWM register in the TCSR block.
> +    maxItems: 1

Use 'reg' here instead.

> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    const: core
> +
> +  assigned-clocks:
> +    maxItems: 1
> +
> +  assigned-clock-rates:
> +    maxItems: 1
> +
> +required:
> +  - "#pwm-cells"
> +  - compatible
> +  - clocks
> +  - clock-names
> +  - assigned-clocks
> +  - assigned-clock-rates
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
> +        tcsr: syscon@1937000 {
> +            compatible = "syscon", "simple-mfd";

This should really have a specific compatible string, but we don't warn 
for that (yet).

> +            reg = <0x0 0x01937000 0x0 0x21000>;
> +
> +            pwm: pwm {
> +                #pwm-cells = <2>;
> +                compatible = "qcom,ipq6018-pwm";
> +                offset = <0xa010>;
> +                clocks = <&gcc GCC_ADSS_PWM_CLK>;
> +                clock-names = "core";
> +                assigned-clocks = <&gcc GCC_ADSS_PWM_CLK>;
> +                assigned-clock-rates = <100000000>;
> +                status = "disabled";

Drop 'status'

> +            };
> +        };
> +    };
> -- 
> 2.30.2
> 
> 
