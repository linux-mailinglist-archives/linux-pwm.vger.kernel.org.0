Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D24F3701C7
	for <lists+linux-pwm@lfdr.de>; Fri, 30 Apr 2021 22:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233420AbhD3UGe (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 30 Apr 2021 16:06:34 -0400
Received: from mail-ot1-f49.google.com ([209.85.210.49]:36491 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232957AbhD3UGe (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 30 Apr 2021 16:06:34 -0400
Received: by mail-ot1-f49.google.com with SMTP id n32-20020a9d1ea30000b02902a53d6ad4bdso10485975otn.3;
        Fri, 30 Apr 2021 13:05:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=T7ePI4bIX8CcnC5j3hUDE0qviNPb4HDFmqxhfLcKhzs=;
        b=JYHPIFUIi4U/3CpgUtBQ7Rhnnyvk6THwNXM8+f97Y2NYapWSNgmEh+H63XzKdU6LI0
         4ioATsTz4wZAxwb+dWpr83QvTcYE6iPvxWocro7exzBr2Grcn3p32XpFq1bSKNoAk2Om
         zgy9gfL2BXDnUygWqBY40kJ+Ip2jzntedgak9by5c+rhdGOrkD339nrX5xw5mlgZ8ADx
         kKabwfDeol4NC6ucynQvOX6/zxSISnxC4Rpp/c7N+TFhZ5qdvDUsf4egYmLGpgtf+h4X
         1YBFHhAZAYRv8ubutJ1hoI5gWgcGuqdobsAVaXAbdhAuR+B72dwnBWH2E7fIIk0ehjDq
         yNvA==
X-Gm-Message-State: AOAM530bD32PuAi/SZyxZAHmOxndWRy+rrd+zFUciCyzOIM547r/moWJ
        4BkFgi3ZP4NsQAy+fGsJVA==
X-Google-Smtp-Source: ABdhPJzxQDEmXhTIvUDst9IPtWg/QKelSOh5zpecKai2g4sf9uXP5LZNFw8DZ3Kd7bh//H6TZ3gvQA==
X-Received: by 2002:a05:6830:30ad:: with SMTP id g13mr4929721ots.272.1619813144488;
        Fri, 30 Apr 2021 13:05:44 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id w3sm899112otg.78.2021.04.30.13.05.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 13:05:43 -0700 (PDT)
Received: (nullmailer pid 3796857 invoked by uid 1000);
        Fri, 30 Apr 2021 20:05:42 -0000
Date:   Fri, 30 Apr 2021 15:05:42 -0500
From:   Rob Herring <robh@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Pavel Machek <pavel@ucw.cz>, Andy Gross <agross@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pwm@vger.kernel.org,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        Luca Weiss <luca@z3ntu.xyz>,
        Subbaraman Narayanamurthy <subbaram@codeaurora.org>
Subject: Re: [PATCH v7 1/6] dt-bindings: leds: Add Qualcomm Light Pulse
 Generator binding
Message-ID: <20210430200542.GA3779966@robh.at.kernel.org>
References: <20210429211517.312792-1-bjorn.andersson@linaro.org>
 <20210429211517.312792-2-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210429211517.312792-2-bjorn.andersson@linaro.org>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, Apr 29, 2021 at 02:15:12PM -0700, Bjorn Andersson wrote:
> This adds the binding document describing the three hardware blocks
> related to the Light Pulse Generator found in a wide range of Qualcomm
> PMICs.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
> 
> Changes since v6:
> - Backed qcom,dtest out of the child nodes again, as it's useful to be able to
>   route pwm signals through dtest lines as well (and pwm channels aren't
>   described as children).
> - Added pm8150[bl] compatibles
> - Dropped quotes around qcom,dtest
> - Fixed indentation errors in subnode definition
> 
>  .../bindings/leds/leds-qcom-lpg.yaml          | 158 ++++++++++++++++++
>  1 file changed, 158 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml
> 
> diff --git a/Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml b/Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml
> new file mode 100644
> index 000000000000..2998598e8785
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml
> @@ -0,0 +1,158 @@
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
> +      - qcom,pm8150b-lpg
> +      - qcom,pm8150l-lpg
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
> +  qcom,power-source:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      power-source used to drive the output, as defined in the datasheet.
> +      Should be specified if the TRILED block is present

constraints?

> +
> +  qcom,dtest:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    description: >
> +      A list of integer pairs, where each pair represent the dtest line the
> +      particular channel should be connected to and the flags denoting how the
> +      value should be outputed, as defined in the datasheet. The number of
> +      pairs should be the same as the number of channels.

Sounds like a matrix rather than array. Constraints on the values?

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
> +patternProperties:
> +  "^led@[0-9a-f]$":
> +    type: object
> +    $ref: common.yaml#
> +
> +    properties:
> +      reg: true
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
> +      qcom,dtest = <0 0
> +                    0 0
> +                    0 0
> +                    4 1>;
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
> 2.29.2
> 
