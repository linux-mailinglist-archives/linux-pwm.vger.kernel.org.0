Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B551299067
	for <lists+linux-pwm@lfdr.de>; Mon, 26 Oct 2020 16:02:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1782919AbgJZPCl (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 26 Oct 2020 11:02:41 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:44772 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1782749AbgJZPCl (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 26 Oct 2020 11:02:41 -0400
Received: by mail-ot1-f65.google.com with SMTP id e20so8222409otj.11;
        Mon, 26 Oct 2020 08:02:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2aiLRf1lQzD4dmA+9Qc8/8CVqPN/upZ+zNSr1+Xbbnk=;
        b=jEihGHWA9JCNgqDH4vbBRr1h5JIKXLEiu0zTH/LPUrsH493KGpRFgTUekR91JUl4ZF
         LmMvWhdthlQRVFTHnJFHgmCk8HRbysnfqFWnjNkLGrgvBQXgMai8eFVi2an95ACkwh3u
         3s4o62T91kwrlCLiGMJhgAS5pjLap8JSmA3Se2EB93z1Kqdvq9vjh4z5lEbj+MGN8EeJ
         5mcpBzTJ9HHBdD5K1r1AT72zT4+uLIdcb7v2nt4gMNOq2S8uoRDoaFSEL5R/NCFln3fk
         h2cld9zAhzp9XH0r/3R671yoy8ik1kdqB4+uTUtXvucRoAiOiKsETSVMYUIZ9pX6bJwE
         j6ug==
X-Gm-Message-State: AOAM532Se/Tcq8S7/EHpkYwsfnEzitfwUs/w7VWaHilKMmZpxX3SDpVJ
        rQmUW7aBAeiCU2uOD7WKHw==
X-Google-Smtp-Source: ABdhPJwZIO7eFvyYC6iIW/01eosuWEdyWYpFD9Md2hkD3Kl2sB29RW5rARlUyAQvIWydhS7rQT12Jg==
X-Received: by 2002:a9d:172f:: with SMTP id i47mr10180077ota.74.1603724557602;
        Mon, 26 Oct 2020 08:02:37 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id h6sm4126286oia.51.2020.10.26.08.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 08:02:36 -0700 (PDT)
Received: (nullmailer pid 156045 invoked by uid 1000);
        Mon, 26 Oct 2020 15:02:35 -0000
Date:   Mon, 26 Oct 2020 10:02:35 -0500
From:   Rob Herring <robh@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        Andy Gross <agross@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Martin Botka <martin.botka1@gmail.com>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH v6 1/4] dt-bindings: leds: Add Qualcomm Light Pulse
 Generator binding
Message-ID: <20201026150235.GA140013@bogus>
References: <20201021201224.3430546-1-bjorn.andersson@linaro.org>
 <20201021201224.3430546-2-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201021201224.3430546-2-bjorn.andersson@linaro.org>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, Oct 21, 2020 at 01:12:21PM -0700, Bjorn Andersson wrote:
> This adds the binding document describing the three hardware blocks
> related to the Light Pulse Generator found in a wide range of Qualcomm
> PMICs.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
> 
> Changes since v5:
> - None
> 
>  .../bindings/leds/leds-qcom-lpg.yaml          | 170 ++++++++++++++++++
>  1 file changed, 170 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml
> 
> diff --git a/Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml b/Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml
> new file mode 100644
> index 000000000000..5ccf0f3d8f1b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml
> @@ -0,0 +1,170 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/leds/leds-qcom-lpg.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Light Pulse Generator
> +
> +maintainers:
> +  - Bjorn Andersson <bjorn.andersson@linaro.org>
> +
> +description: >
> +  The Qualcomm Light Pulse Generator consists of three different hardware blocks;
> +  a ramp generator with lookup table, the light pulse generator and a three
> +  channel current sink. These blocks are found in a wide range of Qualcomm PMICs.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - qcom,pm8916-pwm

Are the LED properties valid when PWM is used/enabled? The schema 
suggests yes, the example suggests no. If not, I think this should be 2 
schema docs.

> +      - qcom,pm8941-lpg
> +      - qcom,pm8994-lpg
> +      - qcom,pmi8994-lpg
> +      - qcom,pmi8998-lpg
> +
> +  "#pwm-cells":
> +    const: 2
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0
> +
> +  qcom,power-source:
> +    $ref: /schemas/types.yaml#definitions/uint32

led-sources can't be made to work for this?

> +    description: >
> +      power-source used to drive the output, as defined in the datasheet.
> +      Should be specified if the TRILED block is present
> +    enum:
> +      - 0
> +      - 1
> +      - 3
> +
> +  multi-led:
> +    type: object
> +    $ref: leds-class-multicolor.yaml#
> +    properties:
> +      "#address-cells":
> +        const: 1
> +
> +      "#size-cells":
> +        const: 0
> +
> +      "^led@[0-9a-f]$":
> +        type: object
> +        $ref: common.yaml#
> +
> +        properties:
> +          "qcom,dtest":

Don't need quotes.

> +            $ref: /schemas/types.yaml#definitions/uint32-array

The description sounds like a matrix rather than an array.

> +            description: >
> +              configures the output into an internal test line of the pmic. Specified
> +              by a list of u32 pairs, one pair per channel, where each pair denotes the
> +              test line to drive and the second configures how the value should be
> +              outputed, as defined in the datasheet
> +            minItems: 2
> +            maxItems: 2

If so, then you'd want:

items:
  minItems: 2
  maxItems: 2

> +
> +        required:
> +          - reg
> +
> +patternProperties:
> +  "^led@[0-9a-f]$":
> +    type: object
> +    $ref: common.yaml#
> +    properties:
> +      "qcom,dtest":
> +        $ref: /schemas/types.yaml#definitions/uint32-array
> +        description: >
> +          configures the output into an internal test line of the pmic. Specified
> +          by a list of u32 pairs, one pair per channel, where each pair denotes the
> +          test line to drive and the second configures how the value should be
> +          outputed, as defined in the datasheet
> +        minItems: 2
> +        maxItems: 2
> +
> +    required:
> +      - reg
> +
> +required:
> +  - compatible
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/leds/common.h>
> +
> +    lpg {
> +      compatible = "qcom,pmi8994-lpg";
> +
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      qcom,power-source = <1>;
> +
> +      led@1 {
> +        reg = <1>;
> +        label = "green:user1";
> +      };
> +
> +      led@2 {
> +        reg = <2>;
> +        label = "green:user0";
> +        default-state = "on";
> +      };
> +
> +      led@3 {
> +        reg = <3>;
> +        label = "green:user2";
> +      };
> +
> +      led@4 {
> +        reg = <4>;
> +        label = "green:user3";
> +
> +        qcom,dtest = <4 1>;
> +      };
> +    };
> +  - |
> +    #include <dt-bindings/leds/common.h>
> +
> +    lpg {
> +      compatible = "qcom,pmi8994-lpg";
> +
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      qcom,power-source = <1>;
> +
> +      multi-led {
> +        color = <LED_COLOR_ID_MULTI>;
> +        label = "rgb:notification";
> +
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        led@1 {
> +          reg = <1>;
> +          color = <LED_COLOR_ID_RED>;
> +        };
> +
> +        led@2 {
> +          reg = <2>;
> +          color = <LED_COLOR_ID_GREEN>;
> +        };
> +
> +        led@3 {
> +          reg = <3>;
> +          color = <LED_COLOR_ID_BLUE>;
> +        };
> +      };
> +    };
> +  - |
> +    lpg {
> +      compatible = "qcom,pm8916-pwm";
> +      #pwm-cells = <2>;
> +    };
> +...
> -- 
> 2.28.0
> 
