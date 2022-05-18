Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BE5152C215
	for <lists+linux-pwm@lfdr.de>; Wed, 18 May 2022 20:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241330AbiERSRe (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 18 May 2022 14:17:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240092AbiERSRe (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 18 May 2022 14:17:34 -0400
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4279F17DDF1;
        Wed, 18 May 2022 11:17:33 -0700 (PDT)
Received: by mail-oi1-f171.google.com with SMTP id w127so237608oie.1;
        Wed, 18 May 2022 11:17:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JHB4mxwuxXLtxgR0b4MAdhznA0CHuJezj+quJiq9BUc=;
        b=HxGlrN1QejU/psK562dsmR6sLYQ3HSnuVjsT5I4OgPv4kYoDMFDHy+Q+mEGpr3Tg3N
         Lx8VpEKcQmQlvy0kVII5nwrW9oa8Zj5bHFGPqTjJ15LdAXkXdPHf2OYjYhQLaSUZvvwL
         tBA2iqVPNPq/JAAkOj9jruVHAbpA2ZLn8tl7aa//EwxPicxqEKyHaS0p1rxE39nPRBin
         ejCB058xgCr4jVLQ14r6XB3W8EUVekZ4hA+iekuM7R16RTk46zAoBamn7jYtkb6RPymn
         JyFvPrfnoubRvNYIGlV8UBHd5Y9M3Warsln9XsShcNKwFDroCPacnAcQqHXg18afrqjr
         j72w==
X-Gm-Message-State: AOAM532shSVrVa4JeK2Lpd124YHPnE7vjbr2W6WRU90TyDNR1D64+i0D
        LmoemR5D3GJPGueZ4F/PTQ==
X-Google-Smtp-Source: ABdhPJwvC1l1x1uCUV1cpREPMBP26niSwJLo+XNIq7PloD4/cp1Dj6DMnFz6u4WHLF8c3hlHNwUWQw==
X-Received: by 2002:a05:6808:3091:b0:326:cd17:fed4 with SMTP id bl17-20020a056808309100b00326cd17fed4mr726863oib.51.1652897852071;
        Wed, 18 May 2022 11:17:32 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id p4-20020a4a8144000000b0035eb4e5a6d0sm1240542oog.38.2022.05.18.11.17.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 11:17:31 -0700 (PDT)
Received: (nullmailer pid 3626486 invoked by uid 1000);
        Wed, 18 May 2022 18:17:30 -0000
Date:   Wed, 18 May 2022 13:17:30 -0500
From:   Rob Herring <robh@kernel.org>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [RFC 1/8] dt-bindings: soc: renesas: Add RZ/G2L POEG binding
Message-ID: <20220518181730.GH3302100-robh@kernel.org>
References: <20220510151112.16249-1-biju.das.jz@bp.renesas.com>
 <20220510151112.16249-2-biju.das.jz@bp.renesas.com>
 <20220517210407.GA1635524-robh@kernel.org>
 <OS0PR01MB5922FC66FD4EF05F31B17D3386D19@OS0PR01MB5922.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OS0PR01MB5922FC66FD4EF05F31B17D3386D19@OS0PR01MB5922.jpnprd01.prod.outlook.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, May 18, 2022 at 05:58:00AM +0000, Biju Das wrote:
> Hi Rob,
> 
> Thanks for the feedback.
> 
> > Subject: Re: [RFC 1/8] dt-bindings: soc: renesas: Add RZ/G2L POEG binding
> > 
> > On Tue, May 10, 2022 at 04:11:05PM +0100, Biju Das wrote:
> > > Add device tree bindings for the RZ/G2L Port Output Enable for GPT
> > (POEG).
> > >
> > > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > > ---
> > >  .../soc/renesas/renesas,rzg2l-poeg.yaml       | 65 +++++++++++++++++++
> > >  1 file changed, 65 insertions(+)
> > >  create mode 100644
> > > Documentation/devicetree/bindings/soc/renesas/renesas,rzg2l-poeg.yaml
> > >
> > > diff --git
> > > a/Documentation/devicetree/bindings/soc/renesas/renesas,rzg2l-poeg.yam
> > > l
> > > b/Documentation/devicetree/bindings/soc/renesas/renesas,rzg2l-poeg.yam
> > > l
> > > new file mode 100644
> > > index 000000000000..5737dbf3fa45
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/soc/renesas/renesas,rzg2l-poeg
> > > +++ .yaml
> > > @@ -0,0 +1,65 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) %YAML 1.2
> > > +---
> > > +$id:
> "
> > > +
> > > +title: Renesas RZ/G2L Port Output Enable for GPT (POEG)
> > > +
> > > +maintainers:
> > > +  - Biju Das <biju.das.jz@bp.renesas.com>
> > > +
> > > +description:
> > 
> > '|' needed.
> 
> OK.
> 
> > 
> > > +  The output pins of the general PWM timer (GPT) can be disabled by
> > > + using  the port output enabling function for the GPT (POEG).
> > > + Specifically,  either of the following ways can be used.
> > > +  * Input level detection of the GTETRGA to GTETRGD pins.
> > > +  * Output-disable request from the GPT.
> > > +  * Register settings.
> > > +
> > > +properties:
> > > +  compatible:
> > > +    items:
> > > +      - enum:
> > > +          - renesas,r9a07g044-poeg  # RZ/G2{L,LC}
> > > +          - renesas,r9a07g054-poeg  # RZ/V2L
> > > +      - const: renesas,rzg2l-poeg
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +  interrupts:
> > > +    maxItems: 1
> > > +
> > > +  clocks:
> > > +    maxItems: 1
> > > +
> > > +  power-domains:
> > > +    maxItems: 1
> > > +
> > > +  resets:
> > > +    maxItems: 1
> > > +
> > > +required:
> > > +  - compatible
> > > +  - reg
> > > +  - interrupts
> > > +  - clocks
> > > +  - power-domains
> > > +  - resets
> > > +
> > > +additionalProperties: false
> > > +
> > > +examples:
> > > +  - |
> > > +    #include <dt-bindings/clock/r9a07g044-cpg.h>
> > > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > > +
> > > +    poeggd: poeg@10049400 {
> > > +        compatible = "renesas,r9a07g044-poeg", "renesas,rzg2l-poeg";
> > > +        reg = <0x10049400 0x4>;
> > 
> > This looks like it is part of some larger block?
> 
> There are 2 IP blocks GPT(PWM) and POEG with its own resources like (register map, clk, reset and interrupts)
> 
> Larger block is GPT, which has lot of functionalities. The output from GPT block can be disabled
> by this IP either by external trigger, request from GPT(Deadtime error, both output low/high)
> or explicit software control). This IP has only a single register. Currently I am not sure which framework
> to be used for this IP?? Or should it be merged with larger block GPT by combining the resources?

Usually, IP blocks would have some minimum address alignment (typ 4K or 
64K to be page aligned), but if there's no other IP in this address 
range as-is is fine. The question is what's before or after the above 
address?

Rob
