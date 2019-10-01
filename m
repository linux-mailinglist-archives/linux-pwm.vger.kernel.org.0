Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85E22C3687
	for <lists+linux-pwm@lfdr.de>; Tue,  1 Oct 2019 16:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388673AbfJAOAH (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 1 Oct 2019 10:00:07 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:40773 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726710AbfJAOAH (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 1 Oct 2019 10:00:07 -0400
Received: by mail-ot1-f68.google.com with SMTP id y39so11610424ota.7;
        Tue, 01 Oct 2019 07:00:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JZBM1FPFDAl5uESgEP9tPsFTn7qdNx8IBtQzRJpA2CU=;
        b=JJ6Ba9U260hPNMjV33RcZ4y4AOaBtHnjOByo9zSyjfHN3eAatyKNOkOgmyd1ru0Sm9
         Sh0ucXuvXH5gHibOXGHWFPbLnOMTyrqAVMT+4gthL0YteSJyxpstoaO4V9iyLtOIV4mk
         vqs8y3GDEj61emJcbuf5VrBAYuRm+ZTKiyod7zaSjSik06RgNP9A3j8T17P47IoGyOd6
         hg7mtUlOXdAodyFCsBiBvJ1HgXnwIQ45nshjfu+Bodd+rOJRidpOPndCoCGsjgyVobpd
         bwR8ycm8zR0dF61jo6a2FP57u6Jg3T6gS22+G+vOhySqKsyDZ1gbdxnZ8PwUalSEfshh
         KkmA==
X-Gm-Message-State: APjAAAVr+PRHwQCvMAYY+PNPx5D0/RCQsKzdEgbERn2PSzCOE2hbsup5
        HznEYzRjx+2O9BlmLHiUOw==
X-Google-Smtp-Source: APXvYqyny3jSQCJcTq07B8NFgeh+CqrPZ/jllExOJcitfcVJnCPPhlC7KQB0zTngJlFTUtwdcVIBqg==
X-Received: by 2002:a9d:4041:: with SMTP id o1mr4924805oti.61.1569938405253;
        Tue, 01 Oct 2019 07:00:05 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m25sm5045457oie.39.2019.10.01.07.00.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2019 07:00:04 -0700 (PDT)
Date:   Tue, 1 Oct 2019 09:00:03 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-tegra@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        linux-riscv@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-crypto@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v2 2/8] dt-bindings: sram: Convert SRAM bindings to
 json-schema
Message-ID: <20191001140003.GA31344@bogus>
References: <20190918173141.4314-1-krzk@kernel.org>
 <20190918173141.4314-2-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190918173141.4314-2-krzk@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, Sep 18, 2019 at 07:31:35PM +0200, Krzysztof Kozlowski wrote:
> Convert generic mmio-sram bindings to DT schema format using
> json-schema.

I've been slow getting to this because I started on the same thing...

> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> ---
> 
> Changes since v1:
> 1. Indent example with four spaces (more readable).
> ---
>  .../devicetree/bindings/sram/sram.txt         |  80 ----------
>  .../devicetree/bindings/sram/sram.yaml        | 138 ++++++++++++++++++
>  2 files changed, 138 insertions(+), 80 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sram/sram.txt
>  create mode 100644 Documentation/devicetree/bindings/sram/sram.yaml

> diff --git a/Documentation/devicetree/bindings/sram/sram.yaml b/Documentation/devicetree/bindings/sram/sram.yaml
> new file mode 100644
> index 000000000000..8d9d6ce494b2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sram/sram.yaml
> @@ -0,0 +1,138 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sram/sram.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Generic on-chip SRAM
> +
> +maintainers:
> +  - FIXME <who@should.it.be>

You can put me.

> +
> +description: |+
> +  Simple IO memory regions to be managed by the genalloc API.
> +
> +  Each child of the sram node specifies a region of reserved memory. Each
> +  child node should use a 'reg' property to specify a specific range of
> +  reserved memory.
> +
> +  Following the generic-names recommended practice, node names should
> +  reflect the purpose of the node. Unit address (@<address>) should be
> +  appended to the name.
> +
> +properties:
> +  $nodename:
> +    pattern: "^sram(@.*)?"
> +
> +  compatible:
> +    items:
> +      - enum:
> +          - mmio-sram
> +          - atmel,sama5d2-securam

I was trying to go down the path of putting all the compatibles for 
various SRAM bindings here, but I ran into some issues. I need to 
revisit as I've forgotten the exact issue.

This would need to be a 'contains' if this is going to work for others.

> +
> +  reg:
> +    maxItems: 1
> +
> +  "#address-cells":
> +    description: Should use the same values as the root node.
> +
> +  "#size-cells":
> +    description: Should use the same values as the root node.

I defined both of these to be 1 as 4GB of SRAM should be enough for a 
while. We can debate 1 or 2 cells vs. 1, but there's no reason it has to 
be the same as the root (unless we're failing to do address 
translation).

> +
> +  ranges:
> +    description:
> +      Should translate from local addresses within the sram to bus addresses.
> +
> +  no-memory-wc:
> +    description:
> +      The flag indicating, that SRAM memory region has not to be remapped
> +      as write combining. WC is used by default.
> +    type: boolean
> +
> +  # TODO: additionalProperties: false
> +
> +patternProperties:
> +  "^([a-z]*-)?sram@[a-f0-9]$":
> +    type: object
> +    description:
> +      Each child of the sram node specifies a region of reserved memory.
> +    properties:
> +      reg:
> +        description:
> +          IO mem address range, relative to the SRAM range.

maxItems: 1

> +
> +      compatible:
> +        $ref: /schemas/types.yaml#/definitions/string
> +        description:
> +          Should contain a vendor specific string in the form
> +          <vendor>,[<device>-]<usage>
> +
> +      pool:
> +        description:
> +          Indicates that the particular reserved SRAM area is addressable
> +          and in use by another device or devices.
> +        type: boolean
> +
> +      export:
> +        description:
> +          Indicates that the reserved SRAM area may be accessed outside
> +          of the kernel, e.g. by bootloader or userspace.
> +        type: boolean
> +
> +      protect-exec:
> +        description: |
> +          Same as 'pool' above but with the additional constraint that code
> +          will be run from the region and that the memory is maintained as
> +          read-only, executable during code execution. NOTE: This region must
> +          be page aligned on start and end in order to properly allow
> +          manipulation of the page attributes.
> +        type: boolean
> +
> +      label:
> +        $ref: /schemas/types.yaml#/definitions/string

Already has a type definition.

> +        description:
> +          The name for the reserved partition, if omitted, the label is taken
> +          from the node name excluding the unit address.
> +
> +      clocks:
> +        description:
> +          A list of phandle and clock specifier pair that controls the
> +          single SRAM clock.
> +
> +      # TODO: additionalProperties: false
> +
> +    required:
> +      - reg
> +
> +required:
> +  - compatible
> +  - reg
> +  - "#address-cells"
> +  - "#size-cells"
> +  - ranges
> +
> +examples:
> +  - |
> +    sram: sram@5c000000 {
> +        compatible = "mmio-sram";
> +        reg = <0x5c000000 0x40000>; /* 256 KiB SRAM at address 0x5c000000 */
> +
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +        ranges = <0 0x5c000000 0x40000>;
> +
> +        smp-sram@100 {
> +            compatible = "socvendor,smp-sram";
> +            reg = <0x100 0x50>;
> +        };
> +
> +        device-sram@1000 {
> +            reg = <0x1000 0x1000>;
> +            pool;
> +        };
> +
> +        exported@20000 {
> +            reg = <0x20000 0x20000>;
> +            export;
> +        };
> +    };
> -- 
> 2.17.1
> 
