Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18A4A25F304
	for <lists+linux-pwm@lfdr.de>; Mon,  7 Sep 2020 08:10:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbgIGGKG (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 7 Sep 2020 02:10:06 -0400
Received: from mail-ej1-f67.google.com ([209.85.218.67]:44350 "EHLO
        mail-ej1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725803AbgIGGKG (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 7 Sep 2020 02:10:06 -0400
Received: by mail-ej1-f67.google.com with SMTP id r7so3266499ejs.11;
        Sun, 06 Sep 2020 23:10:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GVokwuwCaSVBc9Gyn7b0LOXpcqkbxNYOMN+1IZzWnZQ=;
        b=a/E5fKmAyHWIix6L1IW31pNLvcxTdToWINidap+0KcmBjq68Hhx6EC+MLnZ3Iv0nKu
         LGT8SDT65dzLFvq4lmEcpnivS8uEhkZXehNbUtQiG7j3h3KSNg3ZVxQQiSH/HCaOqkds
         I9ZE9KoHf2eWgIKSIB7JOtDHXgNK6W7eHiZRwEOWJaV01frOvckMeRnQDEAnWyP9SW+K
         LxxPcBKdjx30SLeFCTyEigg9UYzHjpep0iKNQU0cqjiXUsEO8xApx73G5BhFZNI61yXm
         /p6sYNeJcjBWHmrdiM92DID6TLHNTug2TChQadaD5FkhxOEvqwpzJiZW923LRtAA+4ph
         I4wA==
X-Gm-Message-State: AOAM531ZCzY/DJ6nK2AKirtVlNY4PbDLfXAq4PnodCCT8SHTY+h20F8w
        MmbRxd2w5uB1/i0LC/BzvoWX17+N00s=
X-Google-Smtp-Source: ABdhPJzM/GiqDDPUglZaYg3VUWUe0/dDHCWpXQ1+YwL2JZxA9p9bR+MKuStVCwG/XpSPy00N+WM4qQ==
X-Received: by 2002:a17:906:a00d:: with SMTP id p13mr20408792ejy.535.1599459001754;
        Sun, 06 Sep 2020 23:10:01 -0700 (PDT)
Received: from kozik-lap ([194.230.155.174])
        by smtp.googlemail.com with ESMTPSA id r16sm14473271ejb.110.2020.09.06.23.09.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 06 Sep 2020 23:10:00 -0700 (PDT)
Date:   Mon, 7 Sep 2020 08:09:58 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>
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
Subject: Re: [PATCH v3 12/14] dt-bindings: mtd: gpmi-nand: Fix matching of
 clocks on different SoCs
Message-ID: <20200907060958.GA4525@kozik-lap>
References: <20200904152404.20636-1-krzk@kernel.org>
 <20200904152404.20636-13-krzk@kernel.org>
 <CAL_Jsq+tGQhkqtQszOx7nvr1PR=YFz2p1=OnWQ8JxmSg4qNkHA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAL_Jsq+tGQhkqtQszOx7nvr1PR=YFz2p1=OnWQ8JxmSg4qNkHA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, Sep 04, 2020 at 04:36:39PM -0600, Rob Herring wrote:
> On Fri, Sep 4, 2020 at 9:25 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> >
> > Driver requires different amount of clocks for different SoCs.  Describe
> > these requirements properly to fix dtbs_check warnings like:
> >
> >     arch/arm64/boot/dts/freescale/imx8mm-beacon-kit.dt.yaml: nand-controller@33002000: clock-names:1: 'gpmi_apb' was expected
> >
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> >
> > ---
> >
> > Changes since v1:
> > 1. Do not require order of clocks (use pattern).
> 
> To the extent that you can, you should fix the order in dts files
> first. If we just adjust the schemas to match the dts files, then
> what's the point?

The DTSes do not have mixed order of clocks between each other, as fair
as I remember. It was fix after Sasha Hauer comment that order is not
necessarily good.

We have the clock-names property, why enforcing the order?

> 
> > ---
> >  .../devicetree/bindings/mtd/gpmi-nand.yaml    | 76 +++++++++++++++----
> >  1 file changed, 61 insertions(+), 15 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/mtd/gpmi-nand.yaml b/Documentation/devicetree/bindings/mtd/gpmi-nand.yaml
> > index 28ff8c581837..e08e0a50929e 100644
> > --- a/Documentation/devicetree/bindings/mtd/gpmi-nand.yaml
> > +++ b/Documentation/devicetree/bindings/mtd/gpmi-nand.yaml
> > @@ -9,9 +9,6 @@ title: Freescale General-Purpose Media Interface (GPMI) binding
> >  maintainers:
> >    - Han Xu <han.xu@nxp.com>
> >
> > -allOf:
> > -  - $ref: "nand-controller.yaml"
> > -
> >  description: |
> >    The GPMI nand controller provides an interface to control the NAND
> >    flash chips. The device tree may optionally contain sub-nodes
> > @@ -58,22 +55,10 @@ properties:
> >    clocks:
> >      minItems: 1
> >      maxItems: 5
> > -    items:
> > -      - description: SoC gpmi io clock
> > -      - description: SoC gpmi apb clock
> > -      - description: SoC gpmi bch clock
> > -      - description: SoC gpmi bch apb clock
> > -      - description: SoC per1 bch clock
> >
> >    clock-names:
> >      minItems: 1
> >      maxItems: 5
> > -    items:
> > -      - const: gpmi_io
> > -      - const: gpmi_apb
> > -      - const: gpmi_bch
> > -      - const: gpmi_bch_apb
> > -      - const: per1_bch
> >
> >    fsl,use-minimum-ecc:
> >      type: boolean
> > @@ -107,6 +92,67 @@ required:
> >
> >  unevaluatedProperties: false
> >
> > +allOf:
> > +  - $ref: "nand-controller.yaml"
> > +
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - fsl,imx23-gpmi-nand
> > +              - fsl,imx28-gpmi-nand
> > +    then:
> > +      properties:
> > +        clocks:
> > +          items:
> > +            - description: SoC gpmi io clock
> > +        clock-names:
> > +          items:
> > +            - const: gpmi_io
> > +
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - fsl,imx6q-gpmi-nand
> > +              - fsl,imx6sx-gpmi-nand
> > +    then:
> > +      properties:
> > +        clocks:
> > +          items:
> > +            - description: SoC gpmi io clock
> > +            - description: SoC gpmi apb clock
> > +            - description: SoC gpmi bch clock
> > +            - description: SoC gpmi bch apb clock
> > +            - description: SoC per1 bch clock
> > +        clock-names:
> > +          items:
> > +            - pattern: "^(gpmi_(io|apb|bch|bch_apb)|per1_bch)$"
> > +            - pattern: "^(gpmi_(io|apb|bch|bch_apb)|per1_bch)$"
> > +            - pattern: "^(gpmi_(io|apb|bch|bch_apb)|per1_bch)$"
> > +            - pattern: "^(gpmi_(io|apb|bch|bch_apb)|per1_bch)$"
> > +            - pattern: "^(gpmi_(io|apb|bch|bch_apb)|per1_bch)$"
> 
> BTW, you can make 'items' a schema rather than a list to apply a
> constraint to all entries:
> 
> maxItems: 5
> items:
>   pattern: "^(gpmi_(io|apb|bch|bch_apb)|per1_bch)$"

Right, I forgot about such syntax.

> 
> > +
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            const: fsl,imx7d-gpmi-nand
> > +    then:
> > +      properties:
> > +        clocks:
> > +          items:
> > +            - description: SoC gpmi io clock
> > +            - description: SoC gpmi bch apb clock
> > +        clock-names:
> > +          minItems: 2
> > +          maxItems: 2
> 
> You can drop these. It's the default based on the size of 'items'.

Sure.

> 
> > +          items:
> > +            - pattern: "^gpmi_(io|bch_apb)$"
> > +            - pattern: "^gpmi_(io|bch_apb)$"
> 
> Surely here we can define the order.

Yes, but still the same question as before - do we want the order? Why
enforcing it?

Best regards,
Krzysztof
