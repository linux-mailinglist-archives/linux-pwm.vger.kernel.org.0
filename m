Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C588A5F0B6B
	for <lists+linux-pwm@lfdr.de>; Fri, 30 Sep 2022 14:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231575AbiI3MLl (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 30 Sep 2022 08:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231538AbiI3MLQ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 30 Sep 2022 08:11:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13BBB58148;
        Fri, 30 Sep 2022 05:11:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F3B4FB82897;
        Fri, 30 Sep 2022 12:10:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBF49C433C1;
        Fri, 30 Sep 2022 12:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664539857;
        bh=8PoWIrPFu1RotwVvo7U9/sShxzjz4XuF8NY3hrKT2KQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TsgY9cnuchcdBv35/LSHrDb678BNpjAyC4p+SWyLL/n+x/CeH0Eu18LQRQoW50JEQ
         SgQ/0wwhpDqggKwUtlfYlVkQ/5iO3UvmmsgJbOLK1eMf1WMqWuRal3lgcwQcNBW15f
         WUZPm4bZi7Qk86BgGkpmsbu7cL5bJolTqNRbF+9I/UzvWmMz4Tnc5/Dmw4NT4ataLB
         QS3PP5JT41DdKBYW1bBTXEDwBlsJnA38W9ueBqic3r39FyEhfyW2BbP2Em8bYTed0j
         ZxOaVauLd0aFVOCgZ+PyP/vNhqcy2/etxTO0Ji1SO3b5nR+vYUEmMTqOiYKsLJdRdP
         0vxmhSVMHTsWQ==
Date:   Fri, 30 Sep 2022 13:10:51 +0100
From:   Lee Jones <lee@kernel.org>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH RFC 3/7] dt-bindings: mfd: rz-mtu3: Document RZ/G2L MTU3
 PWM
Message-ID: <YzbcyxY839GlR71V@google.com>
References: <20220929103043.1228235-1-biju.das.jz@bp.renesas.com>
 <20220929103043.1228235-4-biju.das.jz@bp.renesas.com>
 <YzXbU69imBM5aKwn@google.com>
 <OS0PR01MB5922134DC72EE29D5404867B86579@OS0PR01MB5922.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <OS0PR01MB5922134DC72EE29D5404867B86579@OS0PR01MB5922.jpnprd01.prod.outlook.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, 29 Sep 2022, Biju Das wrote:

> Hi Lee Jones,
> 
> Thanks for the feedback.
> 
> > Subject: Re: [PATCH RFC 3/7] dt-bindings: mfd: rz-mtu3: Document
> > RZ/G2L MTU3 PWM
> > 
> > On Thu, 29 Sep 2022, Biju Das wrote:
> > 
> > > Document RZ/G2L MTU3 PWM support. It supports following pwm modes.
> > > 	1) PWM mode 1
> > > 	2) PWM mode 2
> > > 	3) Reset-synchronized PWM mode
> > > 	4) Complementary PWM mode 1 (transfer at crest)
> > > 	5) Complementary PWM mode 2 (transfer at trough)
> > > 	6) Complementary PWM mode 3 (transfer at crest and trough)
> > 
> > Shouldn't all this go in the PWM driver binding?
> 
> Looks like at top level MTU3 IP provides similar HW functionality like below
> binding [1], where there is a core MFD driver and pwm, counter and timer
> as child devices.

Previous mistakes are not good references for what should happen in
the present and the future. =;)

> [1] https://elixir.bootlin.com/linux/v6.0-rc7/source/Documentation/devicetree/bindings/mfd/st,stm32-timers.yaml
> 
> Cheers,
> Biju
> > 
> > > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > > ---
> > >  .../bindings/mfd/renesas,rzg2l-mtu3.yaml      | 50
> > +++++++++++++++++++
> > >  1 file changed, 50 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/mfd/renesas,rzg2l-
> > mtu3.yaml b/Documentation/devicetree/bindings/mfd/renesas,rzg2l-
> > mtu3.yaml
> > > index c4bcf28623d6..362fedf5bedb 100644
> > > --- a/Documentation/devicetree/bindings/mfd/renesas,rzg2l-mtu3.yaml
> > > +++ b/Documentation/devicetree/bindings/mfd/renesas,rzg2l-mtu3.yaml
> > > @@ -223,6 +223,50 @@ patternProperties:
> > >        - compatible
> > >        - reg
> > >
> > > +  "^pwm@([0-4]|[6-7])+$":
> > > +    type: object
> > > +
> > > +    properties:
> > > +      compatible:
> > > +        const: renesas,rz-mtu3-pwm
> > > +
> > > +      reg:
> > > +        description: Identify pwm channels.
> > > +        items:
> > > +          enum: [ 0, 1, 2, 3, 4, 6, 7 ]
> > > +
> > > +      "#pwm-cells":
> > > +        const: 2
> > > +
> > > +      renesas,pwm-mode1:
> > > +        type: boolean
> > > +        description: Enable PWM mode 1.
> > > +
> > > +      renesas,pwm-mode2:
> > > +        type: boolean
> > > +        description: Enable PWM mode 2.
> > > +
> > > +      renesas,reset-synchronized-pwm-mode:
> > > +        type: boolean
> > > +        description: Enable Reset-synchronized PWM mode.
> > > +
> > > +      renesas,complementary-pwm-mode1:
> > > +        type: boolean
> > > +        description: Complementary PWM mode 1 (transfer at crest).
> > > +
> > > +      renesas,complementary-pwm-mode2:
> > > +        type: boolean
> > > +        description: Complementary PWM mode 2 (transfer at trough).
> > > +
> > > +      renesas,complementary-pwm-mode3:
> > > +        type: boolean
> > > +        description: Complementary PWM mode 3 (transfer at crest
> > and trough).
> > > +
> > > +    required:
> > > +      - compatible
> > > +      - reg
> > > +      - "#pwm-cells"
> > > +
> > >  required:
> > >    - compatible
> > >    - reg
> > > @@ -305,6 +349,12 @@ examples:
> > >          compatible = "renesas,rzg2l-mtu3-counter";
> > >          reg = <1>;
> > >        };
> > > +      pwm@3 {
> > > +        compatible = "renesas,rz-mtu3-pwm";
> > > +        reg = <3>;
> > > +        #pwm-cells = <2>;
> > > +        renesas,pwm-mode1;
> > > +      };
> > >      };
> > >
> > >  ...
> > 

-- 
Lee Jones [李琼斯]
