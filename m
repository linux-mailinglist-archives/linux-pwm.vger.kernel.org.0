Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2A0725E3BF
	for <lists+linux-pwm@lfdr.de>; Sat,  5 Sep 2020 00:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728098AbgIDWgw (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 4 Sep 2020 18:36:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:43856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728076AbgIDWgv (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 4 Sep 2020 18:36:51 -0400
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B9F9721481;
        Fri,  4 Sep 2020 22:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599259010;
        bh=Z77smMqMlJ9InjnfOSLkOfrCVv21ZVMsWg97rhByuYA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=d42dH4d2dmIZHNUOIPn2Xx9MDOlVwMecjUeWrrvxfpq6DK2RfQvJ6xLEXu/dqhvzS
         Z/ISTc0EKYUenUlG+YNk2cGRIJ9vj92JritbM+b60QJN529orldpgXxshMN/mRXRsl
         H5JpjCsVsztY+LzY2r0RUl6cSIkr06PafRhcGs0Y=
Received: by mail-ot1-f44.google.com with SMTP id i4so7324119ota.2;
        Fri, 04 Sep 2020 15:36:50 -0700 (PDT)
X-Gm-Message-State: AOAM533W+cEA4mxsG6seLg1qDD4q3g53SJaMW0hz9TF/mmhVyvEhpNdl
        46dzckZl0PaLaTpBvf5PIaMC+NkpWAKkgVk+EQ==
X-Google-Smtp-Source: ABdhPJzgDGB2PMZG85xp4jfP9Au8Rn5zzR1d3vIUH17hhCmIoFGECB1Z1dXYQV5cZkVxUXSJH9qoAFDMcWerjSrzYOA=
X-Received: by 2002:a05:6830:1008:: with SMTP id a8mr6724740otp.107.1599259010019;
 Fri, 04 Sep 2020 15:36:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200904152404.20636-1-krzk@kernel.org> <20200904152404.20636-13-krzk@kernel.org>
In-Reply-To: <20200904152404.20636-13-krzk@kernel.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 4 Sep 2020 16:36:39 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+tGQhkqtQszOx7nvr1PR=YFz2p1=OnWQ8JxmSg4qNkHA@mail.gmail.com>
Message-ID: <CAL_Jsq+tGQhkqtQszOx7nvr1PR=YFz2p1=OnWQ8JxmSg4qNkHA@mail.gmail.com>
Subject: Re: [PATCH v3 12/14] dt-bindings: mtd: gpmi-nand: Fix matching of
 clocks on different SoCs
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-clk <linux-clk@vger.kernel.org>, devicetree@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        MTD Maling List <linux-mtd@lists.infradead.org>,
        Linux PWM List <linux-pwm@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        LINUX-WATCHDOG <linux-watchdog@vger.kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, Sep 4, 2020 at 9:25 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> Driver requires different amount of clocks for different SoCs.  Describe
> these requirements properly to fix dtbs_check warnings like:
>
>     arch/arm64/boot/dts/freescale/imx8mm-beacon-kit.dt.yaml: nand-controller@33002000: clock-names:1: 'gpmi_apb' was expected
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>
> ---
>
> Changes since v1:
> 1. Do not require order of clocks (use pattern).

To the extent that you can, you should fix the order in dts files
first. If we just adjust the schemas to match the dts files, then
what's the point?

> ---
>  .../devicetree/bindings/mtd/gpmi-nand.yaml    | 76 +++++++++++++++----
>  1 file changed, 61 insertions(+), 15 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/mtd/gpmi-nand.yaml b/Documentation/devicetree/bindings/mtd/gpmi-nand.yaml
> index 28ff8c581837..e08e0a50929e 100644
> --- a/Documentation/devicetree/bindings/mtd/gpmi-nand.yaml
> +++ b/Documentation/devicetree/bindings/mtd/gpmi-nand.yaml
> @@ -9,9 +9,6 @@ title: Freescale General-Purpose Media Interface (GPMI) binding
>  maintainers:
>    - Han Xu <han.xu@nxp.com>
>
> -allOf:
> -  - $ref: "nand-controller.yaml"
> -
>  description: |
>    The GPMI nand controller provides an interface to control the NAND
>    flash chips. The device tree may optionally contain sub-nodes
> @@ -58,22 +55,10 @@ properties:
>    clocks:
>      minItems: 1
>      maxItems: 5
> -    items:
> -      - description: SoC gpmi io clock
> -      - description: SoC gpmi apb clock
> -      - description: SoC gpmi bch clock
> -      - description: SoC gpmi bch apb clock
> -      - description: SoC per1 bch clock
>
>    clock-names:
>      minItems: 1
>      maxItems: 5
> -    items:
> -      - const: gpmi_io
> -      - const: gpmi_apb
> -      - const: gpmi_bch
> -      - const: gpmi_bch_apb
> -      - const: per1_bch
>
>    fsl,use-minimum-ecc:
>      type: boolean
> @@ -107,6 +92,67 @@ required:
>
>  unevaluatedProperties: false
>
> +allOf:
> +  - $ref: "nand-controller.yaml"
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - fsl,imx23-gpmi-nand
> +              - fsl,imx28-gpmi-nand
> +    then:
> +      properties:
> +        clocks:
> +          items:
> +            - description: SoC gpmi io clock
> +        clock-names:
> +          items:
> +            - const: gpmi_io
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - fsl,imx6q-gpmi-nand
> +              - fsl,imx6sx-gpmi-nand
> +    then:
> +      properties:
> +        clocks:
> +          items:
> +            - description: SoC gpmi io clock
> +            - description: SoC gpmi apb clock
> +            - description: SoC gpmi bch clock
> +            - description: SoC gpmi bch apb clock
> +            - description: SoC per1 bch clock
> +        clock-names:
> +          items:
> +            - pattern: "^(gpmi_(io|apb|bch|bch_apb)|per1_bch)$"
> +            - pattern: "^(gpmi_(io|apb|bch|bch_apb)|per1_bch)$"
> +            - pattern: "^(gpmi_(io|apb|bch|bch_apb)|per1_bch)$"
> +            - pattern: "^(gpmi_(io|apb|bch|bch_apb)|per1_bch)$"
> +            - pattern: "^(gpmi_(io|apb|bch|bch_apb)|per1_bch)$"

BTW, you can make 'items' a schema rather than a list to apply a
constraint to all entries:

maxItems: 5
items:
  pattern: "^(gpmi_(io|apb|bch|bch_apb)|per1_bch)$"

> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: fsl,imx7d-gpmi-nand
> +    then:
> +      properties:
> +        clocks:
> +          items:
> +            - description: SoC gpmi io clock
> +            - description: SoC gpmi bch apb clock
> +        clock-names:
> +          minItems: 2
> +          maxItems: 2

You can drop these. It's the default based on the size of 'items'.

> +          items:
> +            - pattern: "^gpmi_(io|bch_apb)$"
> +            - pattern: "^gpmi_(io|bch_apb)$"

Surely here we can define the order.

> +
>  examples:
>    - |
>      nand-controller@8000c000 {
> --
> 2.17.1
>
