Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1313274A2B
	for <lists+linux-pwm@lfdr.de>; Tue, 22 Sep 2020 22:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbgIVUed (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 22 Sep 2020 16:34:33 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:37784 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbgIVUed (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 22 Sep 2020 16:34:33 -0400
Received: by mail-il1-f195.google.com with SMTP id q4so18628374ils.4;
        Tue, 22 Sep 2020 13:34:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GVXRqEHXrZ3iuCE86AKACwgjvepk2Jk8PvwnmbjbrKk=;
        b=DtCPEvbCNm0ql6258L4naFpjaqy9PYG5W8EmWqnSylC2Ee3xZmKpTL4hBbDBXcDnSQ
         eNZm2z7vryTNMT2Tadx0uP6zkW6brx2P+909IVf+yXcq6GbLC+XyQ3KJmrysJhR/RAYx
         HafmK2VaYC/9mkfIOnQ6jBSCRnp/30ZM7gWWR3aIke7U6BF4ULmkeOei15VUYBCLh3Rg
         Lr6OYp1WzOKDF3y8nwHzvErT4Zq7npdK+Ax1NVGyLc3N5WmugMyzepABPYXfGGxfCigD
         2nSrsxDCccAkhbFZN0b+xhO1QquNc5RK5NUFEO4/AmQcjM1VeyRETedz7bLaLTtryhNv
         LcyA==
X-Gm-Message-State: AOAM53232ntgjnO/drbNVTHMFVKi7xF9UE3f1nkeDtjkbtDdvSyjBfvI
        70vBnoygzCPS7tF+/rbApw==
X-Google-Smtp-Source: ABdhPJztkpG3s/gqZ3SqL0LUOYMffJ8BBUk3C1/1qIyhG4fiknVIIXEF6njrh2KnCmWxFJA9J7gVQA==
X-Received: by 2002:a92:6b0d:: with SMTP id g13mr6189676ilc.242.1600806871421;
        Tue, 22 Sep 2020 13:34:31 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id c5sm1008173ill.1.2020.09.22.13.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 13:34:30 -0700 (PDT)
Received: (nullmailer pid 3195166 invoked by uid 1000);
        Tue, 22 Sep 2020 20:34:29 -0000
Date:   Tue, 22 Sep 2020 14:34:29 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sagar Kadam <sagar.kadam@sifive.com>
Cc:     linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
        tglx@linutronix.de, jason@lakedaemon.net, maz@kernel.org,
        thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        lee.jones@linaro.org, aou@eecs.berkeley.edu, yash.shah@sifive.com
Subject: Re: [PATCH v1 2/3] dt-bindings: riscv: convert plic bindings to
 json-schema
Message-ID: <20200922203429.GA3188204@bogus>
References: <1599734644-4791-1-git-send-email-sagar.kadam@sifive.com>
 <1599734644-4791-3-git-send-email-sagar.kadam@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1599734644-4791-3-git-send-email-sagar.kadam@sifive.com>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, Sep 10, 2020 at 04:14:03PM +0530, Sagar Kadam wrote:
> Convert device tree bindings for SiFive's PLIC to YAML format
> 
> Signed-off-by: Sagar Kadam <sagar.kadam@sifive.com>
> ---
>  .../interrupt-controller/sifive,plic-1.0.0.txt     |  58 -----------
>  .../interrupt-controller/sifive,plic-1.0.0.yaml    | 107 +++++++++++++++++++++
>  2 files changed, 107 insertions(+), 58 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.txt
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.txt b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.txt
> deleted file mode 100644
> index 6adf7a6..0000000
> --- a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.txt
> +++ /dev/null
> @@ -1,58 +0,0 @@
> -SiFive Platform-Level Interrupt Controller (PLIC)
> --------------------------------------------------
> -
> -SiFive SOCs include an implementation of the Platform-Level Interrupt Controller
> -(PLIC) high-level specification in the RISC-V Privileged Architecture
> -specification.  The PLIC connects all external interrupts in the system to all
> -hart contexts in the system, via the external interrupt source in each hart.
> -
> -A hart context is a privilege mode in a hardware execution thread.  For example,
> -in an 4 core system with 2-way SMT, you have 8 harts and probably at least two
> -privilege modes per hart; machine mode and supervisor mode.
> -
> -Each interrupt can be enabled on per-context basis.  Any context can claim
> -a pending enabled interrupt and then release it once it has been handled.
> -
> -Each interrupt has a configurable priority.  Higher priority interrupts are
> -serviced first.  Each context can specify a priority threshold. Interrupts
> -with priority below this threshold will not cause the PLIC to raise its
> -interrupt line leading to the context.
> -
> -While the PLIC supports both edge-triggered and level-triggered interrupts,
> -interrupt handlers are oblivious to this distinction and therefore it is not
> -specified in the PLIC device-tree binding.
> -
> -While the RISC-V ISA doesn't specify a memory layout for the PLIC, the
> -"sifive,plic-1.0.0" device is a concrete implementation of the PLIC that
> -contains a specific memory layout, which is documented in chapter 8 of the
> -SiFive U5 Coreplex Series Manual <https://static.dev.sifive.com/U54-MC-RVCoreIP.pdf>.
> -
> -Required properties:
> -- compatible : "sifive,plic-1.0.0" and a string identifying the actual
> -  detailed implementation in case that specific bugs need to be worked around.
> -- #address-cells : should be <0> or more.
> -- #interrupt-cells : should be <1> or more.
> -- interrupt-controller : Identifies the node as an interrupt controller.
> -- reg : Should contain 1 register range (address and length).
> -- interrupts-extended : Specifies which contexts are connected to the PLIC,
> -  with "-1" specifying that a context is not present.  Each node pointed
> -  to should be a riscv,cpu-intc node, which has a riscv node as parent.
> -- riscv,ndev: Specifies how many external interrupts are supported by
> -  this controller.
> -
> -Example:
> -
> -	plic: interrupt-controller@c000000 {
> -		#address-cells = <0>;
> -		#interrupt-cells = <1>;
> -		compatible = "sifive,plic-1.0.0", "sifive,fu540-c000-plic";
> -		interrupt-controller;
> -		interrupts-extended = <
> -			&cpu0-intc 11
> -			&cpu1-intc 11 &cpu1-intc 9
> -			&cpu2-intc 11 &cpu2-intc 9
> -			&cpu3-intc 11 &cpu3-intc 9
> -			&cpu4-intc 11 &cpu4-intc 9>;
> -		reg = <0xc000000 0x4000000>;
> -		riscv,ndev = <10>;
> -	};
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
> new file mode 100644
> index 0000000..95c8c85
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
> @@ -0,0 +1,107 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +# Copyright (C) 2020 SiFive, Inc.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/interrupt-controller/sifive,plic-1.0.0.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: SiFive Platform-Level Interrupt Controller (PLIC)
> +
> +description:
> +  SiFive SOCs include an implementation of the Platform-Level Interrupt Controller
> +  (PLIC) high-level specification in the RISC-V Privileged Architecture
> +  specification. The PLIC connects all external interrupts in the system to all
> +  hart contexts in the system, via the external interrupt source in each hart.
> +
> +  A hart context is a privilege mode in a hardware execution thread. For example,
> +  in an 4 core system with 2-way SMT, you have 8 harts and probably at least two
> +  privilege modes per hart; machine mode and supervisor mode.
> +
> +  Each interrupt can be enabled on per-context basis. Any context can claim
> +  a pending enabled interrupt and then release it once it has been handled.
> +
> +  Each interrupt has a configurable priority. Higher priority interrupts are
> +  serviced first.  Each context can specify a priority threshold. Interrupts
> +  with priority below this threshold will not cause the PLIC to raise its
> +  interrupt line leading to the context.
> +
> +  While the PLIC supports both edge-triggered and level-triggered interrupts,
> +  interrupt handlers are oblivious to this distinction and therefore it is not
> +  specified in the PLIC device-tree binding.
> +
> +  While the RISC-V ISA doesn't specify a memory layout for the PLIC, the
> +  "sifive,plic-1.0.0" device is a concrete implementation of the PLIC that
> +  contains a specific memory layout, which is documented in chapter 8 of the
> +  SiFive U5 Coreplex Series Manual <https://static.dev.sifive.com/U54-MC-RVCoreIP.pdf>.
> +
> +maintainers:
> +  - Sagar Kadam <sagar.kadam@sifive.com>
> +  - Paul Walmsley  <paul.walmsley@sifive.com>
> +  - Palmer Dabbelt <palmer@dabbelt.com>
> +
> +allOf:
> +  - $ref: /schemas/interrupt-controller.yaml#

Don't need this. It gets selected matching on node name.

> +
> +properties:
> +  compatible:
> +    items:
> +      - const: sifive,plic-1.0.0
> +      - const: sifive,fu540-c000-plic

Somehow these ended up in the wrong order. Should be most specific to 
least specific.

> +
> +    description:
> +      Should be "sifive,plic-1.0.0" and a string identifying the actual
> +      detailed implementation in case that specific bugs need to be worked around.

Drop this.

> +
> +  reg:
> +    maxItems: 1
> +    description:  Should contain 1 register range (address and length).

Drop this. The schema says this...

> +
> +  '#address-cells':
> +    const: 0
> +    description: Should be <0> or more.

Drop. 'or more' is wrong. If there's a case with more, it will need to 
be documented.

> +
> +  '#interrupt-cells':
> +    const: 1
> +    description: Should be <1> or more.

Same here.

> +
> +  interrupt-controller: true
> +
> +  interrupts-extended:
> +    minItems: 1
> +    description:
> +      Specifies which contexts are connected to the PLIC, with "-1" specifying
> +      that a context is not present. Each node pointed to should be a
> +      riscv,cpu-intc node, which has a riscv node as parent.
> +
> +  riscv,ndev:
> +    $ref: "/schemas/types.yaml#/definitions/uint32"
> +    description:
> +      Specifies how many external interrupts are supported by this controller.
> +
> +required:
> +  - compatible
> +  - '#address-cells'
> +  - '#interrupt-cells'
> +  - interrupt-controller
> +  - reg
> +  - interrupts-extended
> +  - riscv,ndev
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    plic: interrupt-controller@c000000 {
> +      #address-cells = <0>;
> +      #interrupt-cells = <1>;
> +      compatible = "sifive,plic-1.0.0", "sifive,fu540-c000-plic";
> +      interrupt-controller;
> +      interrupts-extended = <
> +        &cpu0_intc 11
> +        &cpu1_intc 11 &cpu1_intc 9
> +        &cpu2_intc 11 &cpu2_intc 9
> +        &cpu3_intc 11 &cpu3_intc 9
> +        &cpu4_intc 11 &cpu4_intc 9>;
> +      reg = <0xc000000 0x4000000>;
> +      riscv,ndev = <10>;
> +    };
> -- 
> 2.7.4
> 
