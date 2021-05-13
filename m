Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A21EB37F136
	for <lists+linux-pwm@lfdr.de>; Thu, 13 May 2021 04:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbhEMCRm (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 12 May 2021 22:17:42 -0400
Received: from mail-oi1-f173.google.com ([209.85.167.173]:45814 "EHLO
        mail-oi1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbhEMCRm (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 12 May 2021 22:17:42 -0400
Received: by mail-oi1-f173.google.com with SMTP id n184so24013135oia.12;
        Wed, 12 May 2021 19:16:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=y+KDXvkWHnI8UVO24nn71Hmzcx37ZiyhRtRBKlTwS4M=;
        b=L1NLilfG4Nx0NSC5VVrBl4rfvN1dFpA13QC5HriHkVH47/iKF+cdGufXEDo/X7CLkL
         +GH2K4muukXuYIfIgzZM357TqJcYRvY5gOdOqCafP07CHouX90JACWf4tY5PbFsgUhtS
         uBIrZVpnPz8dhLlwIPpkszsEDG2j1sDIlIRDCscLSzoXIW2KgMXsQvFaU27coFBrdgXc
         35m2RmFTHjrwNT9LkImlvEzb5KMeLZhJXOsRaFoyM0wxJXKdhHRFn7fX8M9wBSlSMRGb
         jw/GGzfQCDanteOZ7Cs0ZcJpdowGmErCtTYKOet/3p+FKCVNfZStT1Y3bzF9hs+H1ocw
         XYUQ==
X-Gm-Message-State: AOAM531c+e3LcRCNwKecCnYZfrcz3rjbdZfS0tv/+Yxea0xVvgaA0pc6
        KLxpyF3RGQ32wCDLFkMLOA==
X-Google-Smtp-Source: ABdhPJxzpIFas0IKjjxV+sM+i8b4NDKme3/5qxaIdjZJBkoesT6CClkTqqRnvaAF6roIe0DTbIHU8w==
X-Received: by 2002:aca:dd89:: with SMTP id u131mr1186065oig.145.1620872193113;
        Wed, 12 May 2021 19:16:33 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id e21sm352733oie.32.2021.05.12.19.16.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 19:16:32 -0700 (PDT)
Received: (nullmailer pid 890278 invoked by uid 1000);
        Thu, 13 May 2021 02:16:31 -0000
Date:   Wed, 12 May 2021 21:16:31 -0500
From:   Rob Herring <robh@kernel.org>
To:     Sean Anderson <sean.anderson@seco.com>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        michal.simek@xilinx.com, Alvaro Gamez <alvaro.gamez@hazent.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 1/2] dt-bindings: pwm: Add Xilinx AXI Timer
Message-ID: <20210513021631.GA878860@robh.at.kernel.org>
References: <20210511191239.774570-1-sean.anderson@seco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210511191239.774570-1-sean.anderson@seco.com>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, May 11, 2021 at 03:12:37PM -0400, Sean Anderson wrote:
> This adds a binding for the Xilinx LogiCORE IP AXI Timer. This device is
> a "soft" block, so it has many parameters which would not be
> configurable in most hardware. This binding is usually automatically
> generated by Xilinx's tools, so the names and values of some properties
> must be kept as they are. Replacement properties have been provided for
> new device trees.

Because you have some tool generating properties is not a reason we have 
to accept them upstream. 'deprecated' is for what *we* have deprecated.

In this case, I don't really see the point in defining new properties 
just to have bool.

> 
> Because we need to init timer devices so early in boot, the easiest way
> to configure things is to use a device tree property. For the moment
> this is 'xlnx,pwm', but this could be extended/renamed/etc. in the
> future if these is a need for a generic property.

No...

> Signed-off-by: Sean Anderson <sean.anderson@seco.com>
> ---
> How should the clocking situation be documented? For the moment I have
> just left clock as optional, but should clock-frequency be documented?
> 
> Changes in v3:
> - Mark all boolean-as-int properties as deprecated
> - Add xlnx,pwm and xlnx,gen?-active-low properties.
> - Make newer replacement properties mutually-exclusive with what they
>   replace
> - Add an example with non-deprecated properties only.
> 
> Changes in v2:
> - Use 32-bit addresses for example binding
> 
>  .../bindings/pwm/xlnx,axi-timer.yaml          | 142 ++++++++++++++++++
>  1 file changed, 142 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/xlnx,axi-timer.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pwm/xlnx,axi-timer.yaml b/Documentation/devicetree/bindings/pwm/xlnx,axi-timer.yaml
> new file mode 100644
> index 000000000000..a5e90658e31a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/xlnx,axi-timer.yaml
> @@ -0,0 +1,142 @@
> +# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pwm/xlnx,axi-timer.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Xilinx LogiCORE IP AXI Timer Device Tree Binding
> +
> +maintainers:
> +  - Sean Anderson <sean.anderson@seco.com>
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +        - const: xlnx,axi-timer-2.0
> +        - const: xlnx,xps-timer-1.00.a
> +      - const: xlnx,xps-timer-1.00.a
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    const: s_axi_aclk
> +
> +  reg:
> +    maxItems: 1
> +
> +  xlnx,count-width:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 8
> +    maximum: 32
> +    description:
> +      The width of the counter(s), in bits.
> +
> +  xlnx,gen0-assert:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [ 0, 1 ]
> +    default: 1
> +    deprecated: true
> +    description:
> +      The polarity of the generateout0 signal. 0 for active-low, 1 for active-high.
> +
> +  xlnx,gen0-active-low:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description:
> +      The generate0 signal is active-low.
> +
> +  xlnx,gen1-assert:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [ 0, 1 ]
> +    default: 1
> +    deprecated: true
> +    description:
> +      The polarity of the generateout1 signal. 0 for active-low, 1 for active-high.
> +
> +  xlnx,gen1-active-low:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description:
> +      The generate1 signal is active-low.
> +
> +  xlnx,one-timer-only:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [ 0, 1 ]
> +    deprecated: true
> +    description:
> +      Whether only one timer is present in this block.
> +
> +  xlnx,single-timer:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description:
> +      Only one timer is present in this block.
> +
> +  xlnx,pwm:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description:
> +      This timer should be configured as a PWM.

If a PWM, perhaps you want a '#pwm-cells' property which can serve as 
the hint to configure as a PWM.

> +
> +required:
> +  - compatible
> +  - reg
> +  - xlnx,count-width
> +
> +allOf:
> +  - if:
> +      required:
> +        - clocks
> +    then:
> +      required:
> +        - clock-names
> +
> +  - if:
> +      required:
> +        - xlnx,gen0-active-low
> +    then:
> +      not:
> +        required:
> +          - xlnx,gen0-assert
> +
> +  - if:
> +      required:
> +        - xlnx,gen0-active-low
> +    then:
> +      not:
> +        required:
> +          - xlnx,gen0-assert
> +
> +  - if:
> +      required:
> +        - xlnx,one-timer-only
> +    then:
> +      not:
> +        required:
> +          - xlnx,single-timer
> +
> +additionalProperties: true
> +
> +examples:
> +  - |
> +    axi_timer_0: timer@800e0000 {
> +        clock-names = "s_axi_aclk";
> +        clocks = <&zynqmp_clk 71>;
> +        compatible = "xlnx,axi-timer-2.0", "xlnx,xps-timer-1.00.a";
> +        reg = <0x800e0000 0x10000>;
> +        xlnx,count-width = <0x20>;
> +        xlnx,gen0-assert = <0x1>;
> +        xlnx,gen1-assert = <0x1>;
> +        xlnx,one-timer-only = <0x0>;
> +        xlnx,trig0-assert = <0x1>;
> +        xlnx,trig1-assert = <0x1>;
> +    };
> +
> +  - |
> +    axi_timer_0: timer@800e0000 {
> +        clock-names = "s_axi_aclk";
> +        clocks = <&zynqmp_clk 71>;
> +        compatible = "xlnx,axi-timer-2.0", "xlnx,xps-timer-1.00.a";
> +        reg = <0x800e0000 0x10000>;
> +        xlnx,count-width = <0x20>;
> +        xlnx,gen0-active-low;
> +        xlnx,single-timer;
> +    };
> -- 
> 2.25.1
> 
