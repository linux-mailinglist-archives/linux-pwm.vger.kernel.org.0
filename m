Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2232274A31
	for <lists+linux-pwm@lfdr.de>; Tue, 22 Sep 2020 22:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbgIVUhS (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 22 Sep 2020 16:37:18 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:33396 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbgIVUhS (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 22 Sep 2020 16:37:18 -0400
Received: by mail-il1-f193.google.com with SMTP id y2so7955719ila.0;
        Tue, 22 Sep 2020 13:37:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=b6PLDdi8fxcl5wdYEMizGD4y37EzcneWERt48cXIEcA=;
        b=kjMHJFuvt/NlRCAY7o7+W1sZhc0iS7/vCKM63sAy+TJTQ5m7Tpy+HqiMVC8+2qQgPJ
         m2Hk0YpHWmLg74lxHIZ6H5hWsKhdvnfgmvQn55KeDse9RBUeY2o6qJqDfe/qCjdM5WM4
         CRDOnessCFzzFNu3PXBdNZPKEgizSX439bktacTlUP8lDLZCGcgrjKMSOqH8jorUNWou
         khoYwtPeFwuFT5nqJAiG4xedsDgShMLjSOmVa8RueKdqUJf2V7hNBIV/jLQbbGPxBx+F
         m2ZAY5S/ksPO+W3Nwn2n1fL/Dj3eTN5ZUmvwnUlGQMi+S0AQ32ls5vG9mVKn4jmt/Az8
         Eg9g==
X-Gm-Message-State: AOAM531TYBob4OkUqJdwIQ0L8qhXOOSq/JpHEgWD6wg2fYoJdk6ibsVQ
        PRWw9JThhGrPbLF86Qs72w==
X-Google-Smtp-Source: ABdhPJxILOHU26JjUwj1e2C2a7BUhOjbr/XE/OtmvaSBy6NijsR8Rg+QvKohpCO4W6NfvHoCKokbPw==
X-Received: by 2002:a92:bf0e:: with SMTP id z14mr5944896ilh.288.1600807036582;
        Tue, 22 Sep 2020 13:37:16 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id i10sm7935475ioi.39.2020.09.22.13.37.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 13:37:15 -0700 (PDT)
Received: (nullmailer pid 3199568 invoked by uid 1000);
        Tue, 22 Sep 2020 20:37:14 -0000
Date:   Tue, 22 Sep 2020 14:37:14 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sagar Kadam <sagar.kadam@sifive.com>
Cc:     linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
        tglx@linutronix.de, jason@lakedaemon.net, maz@kernel.org,
        thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        lee.jones@linaro.org, aou@eecs.berkeley.edu, yash.shah@sifive.com
Subject: Re: [PATCH v1 3/3] dt-bindings: riscv: convert pwm bindings to
 json-schema
Message-ID: <20200922203714.GA3195489@bogus>
References: <1599734644-4791-1-git-send-email-sagar.kadam@sifive.com>
 <1599734644-4791-4-git-send-email-sagar.kadam@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1599734644-4791-4-git-send-email-sagar.kadam@sifive.com>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, Sep 10, 2020 at 04:14:04PM +0530, Sagar Kadam wrote:
> Convert device tree bindings for SiFive's PWM controller to YAML
> format.
> 
> Signed-off-by: Sagar Kadam <sagar.kadam@sifive.com>
> ---
>  .../devicetree/bindings/pwm/pwm-sifive.txt         | 33 ----------
>  .../devicetree/bindings/pwm/pwm-sifive.yaml        | 72 ++++++++++++++++++++++
>  2 files changed, 72 insertions(+), 33 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/pwm/pwm-sifive.txt
>  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-sifive.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pwm/pwm-sifive.txt b/Documentation/devicetree/bindings/pwm/pwm-sifive.txt
> deleted file mode 100644
> index 3d1dd7b0..0000000
> --- a/Documentation/devicetree/bindings/pwm/pwm-sifive.txt
> +++ /dev/null
> @@ -1,33 +0,0 @@
> -SiFive PWM controller
> -
> -Unlike most other PWM controllers, the SiFive PWM controller currently only
> -supports one period for all channels in the PWM. All PWMs need to run at
> -the same period. The period also has significant restrictions on the values
> -it can achieve, which the driver rounds to the nearest achievable period.
> -PWM RTL that corresponds to the IP block version numbers can be found
> -here:
> -
> -https://github.com/sifive/sifive-blocks/tree/master/src/main/scala/devices/pwm
> -
> -Required properties:
> -- compatible: Should be "sifive,<chip>-pwm" and "sifive,pwm<version>".
> -  Supported compatible strings are: "sifive,fu540-c000-pwm" for the SiFive
> -  PWM v0 as integrated onto the SiFive FU540 chip, and "sifive,pwm0" for the
> -  SiFive PWM v0 IP block with no chip integration tweaks.
> -  Please refer to sifive-blocks-ip-versioning.txt for details.
> -- reg: physical base address and length of the controller's registers
> -- clocks: Should contain a clock identifier for the PWM's parent clock.
> -- #pwm-cells: Should be 3. See pwm.yaml in this directory
> -  for a description of the cell format.
> -- interrupts: one interrupt per PWM channel
> -
> -Examples:
> -
> -pwm:  pwm@10020000 {
> -	compatible = "sifive,fu540-c000-pwm", "sifive,pwm0";
> -	reg = <0x0 0x10020000 0x0 0x1000>;
> -	clocks = <&tlclk>;
> -	interrupt-parent = <&plic>;
> -	interrupts = <42 43 44 45>;
> -	#pwm-cells = <3>;
> -};
> diff --git a/Documentation/devicetree/bindings/pwm/pwm-sifive.yaml b/Documentation/devicetree/bindings/pwm/pwm-sifive.yaml
> new file mode 100644
> index 0000000..415d053
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/pwm-sifive.yaml
> @@ -0,0 +1,72 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (C) 2020 SiFive, Inc.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pwm/pwm-sifive.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: SiFive PWM controller
> +
> +maintainers:
> +  - Yash Shah <yash.shah@sifive.com>
> +  - Sagar Kadam <sagar.kadam@sifive.com>
> +  - Paul Walmsley <paul.walmsley@sifive.com>
> +
> +description:
> +  Unlike most other PWM controllers, the SiFive PWM controller currently
> +  only supports one period for all channels in the PWM. All PWMs need to
> +  run at the same period. The period also has significant restrictions on
> +  the values it can achieve, which the driver rounds to the nearest
> +  achievable period. PWM RTL that corresponds to the IP block version
> +  numbers can be found here -
> +
> +  https://github.com/sifive/sifive-blocks/tree/master/src/main/scala/devices/pwm
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: sifive,fu540-c000-pwm
> +      - const: sifive,pwm0
> +    description:
> +      Should be "sifive,<chip>-pwm" and "sifive,pwm<version>". Supported
> +      compatible strings are "sifive,fu540-c000-pwm" for the SiFive PWM v0
> +      as integrated onto the SiFive FU540 chip, and "sifive,pwm0" for the
> +      SiFive PWM v0 IP block with no chip integration tweaks.
> +      Please refer to sifive-blocks-ip-versioning.txt for details.
> +
> +  reg:
> +    maxItems: 1
> +    description: Physical base address and length of the controller's registers

Drop description.

> +
> +  clocks:
> +    description: Should contain a clock identifier for the PWM's parent clock.

How many clocks?

> +
> +  "#pwm-cells":
> +    const: 3
> +    description:
> +      Should be 3. See pwm.yaml in this directory for a description of the
> +      cell format.

Drop.

> +
> +  interrupts:
> +    maxItems: 1

Is it 1 or...

> +    description: One interrupt per PWM channel.

one per channel?

> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - "#pwm-cells"
> +  - interrupts
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    pwm:  pwm@10020000 {
> +      compatible = "sifive,fu540-c000-pwm", "sifive,pwm0";
> +      reg = <0x10020000 0x1000>;
> +      clocks = <&tlclk>;
> +      interrupt-parent = <&plic>;
> +      interrupts = <42 43 44 45>;

Split entries:

interrupts = <42>, <43>, <44>, <45>;

> +      #pwm-cells = <3>;
> +    };
> -- 
> 2.7.4
> 
