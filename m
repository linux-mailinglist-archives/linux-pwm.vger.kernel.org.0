Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F154127D1D8
	for <lists+linux-pwm@lfdr.de>; Tue, 29 Sep 2020 16:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731067AbgI2Ovs (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 29 Sep 2020 10:51:48 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:44152 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729721AbgI2Ovo (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 29 Sep 2020 10:51:44 -0400
Received: by mail-oi1-f193.google.com with SMTP id 185so5719870oie.11;
        Tue, 29 Sep 2020 07:51:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SNaAcKAAWIf+we0pnVV8QsaJ9JxOBJ024VqpUeXbwmU=;
        b=q+BXhS8JpIrN3Slq6J0Wiu0XCQmzDtwagpGlsO12WFO//I/DLzc8WDvvHfm5tAUNGh
         iPW0xXsoDtNYwXJ81D2asf6PsU3A1M/KO22SuB6sH/k5f1UFOz0Y8X6BxZuvPkZQqdiE
         8JdVtLjoQFs/kpEQZFmJQV/HlX3Vfkl9HCeljcq/gheQXikOpFGyMF8/pJZcKSWBbq0r
         JopSRSxah+W0CFNFqKgsKo9fHLtIdtN6yejsmT3XujGsxOnWCmem7wJCtHPodUlK4RyV
         XiJ+CvaTX070SiWV3KyBCjszC4UhfXUMf/3IFFGROeTvWdFDwSuLv8PZCqKAj9VtAgmW
         wiYw==
X-Gm-Message-State: AOAM531NzqGf+z3maEUKsjmXj6CHbQXHOkiRxz3RmdlU75lGdTvCzk2U
        Bw2+/cXCBj5GFEvYUUQK9g==
X-Google-Smtp-Source: ABdhPJwQszdShg3UdLp+0KNVzAl5PfxP3q5d9+5FAltd1165TyykwgcIxNH0Yg1449Mm13ClAYrYlw==
X-Received: by 2002:aca:f40a:: with SMTP id s10mr2913929oih.126.1601391101244;
        Tue, 29 Sep 2020 07:51:41 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id g7sm1026686otl.59.2020.09.29.07.51.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 07:51:40 -0700 (PDT)
Received: (nullmailer pid 572612 invoked by uid 1000);
        Tue, 29 Sep 2020 14:51:39 -0000
Date:   Tue, 29 Sep 2020 09:51:39 -0500
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
Subject: Re: [PATCH v4 1/4] dt-bindings: leds: Add Qualcomm Light Pulse
 Generator binding
Message-ID: <20200929145139.GB566563@bogus>
References: <20200929031544.1000204-1-bjorn.andersson@linaro.org>
 <20200929031544.1000204-2-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200929031544.1000204-2-bjorn.andersson@linaro.org>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, Sep 28, 2020 at 08:15:41PM -0700, Bjorn Andersson wrote:
> This adds the binding document describing the three hardware blocks
> related to the Light Pulse Generator found in a wide range of Qualcomm
> PMICs.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
> 
> Changes since v3:
> - Rewritten as YAML
> - Adopt multicolor model
> 
>  .../bindings/leds/leds-qcom-lpg.yaml          | 170 ++++++++++++++++++
>  1 file changed, 170 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml
> 
> diff --git a/Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml b/Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml
> new file mode 100644
> index 000000000000..5c6e98fc3b9a
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
> +  "qcom,power-source":

Don't need quotes.

> +    $ref: /schemas/types.yaml#definitions/uint32
> +    description: >
> +      power-source used to drive the output, as defined in the datasheet.
> +      Should be specified if the TRILED block is present
> +    enum:
> +      - 0
> +      - 1
> +      - 3
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
> +  "^multi-led$":

Not a pattern, so move to 'properties'

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
> +            $ref: /schemas/types.yaml#definitions/uint32-array
> +            description: >
> +              configures the output into an internal test line of the pmic. Specified
> +              by a list of u32 pairs, one pair per channel, where each pair denotes the
> +              test line to drive and the second configures how the value should be
> +              outputed, as defined in the datasheet
> +            minItems: 2
> +            maxItems: 2
> +
> +        required:
> +          - reg
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
> +	label = "rgb:notification";
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
