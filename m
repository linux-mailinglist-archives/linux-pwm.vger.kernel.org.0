Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01E5827E62D
	for <lists+linux-pwm@lfdr.de>; Wed, 30 Sep 2020 12:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728819AbgI3KEV (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 30 Sep 2020 06:04:21 -0400
Received: from mslow2.mail.gandi.net ([217.70.178.242]:58050 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728169AbgI3KEV (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 30 Sep 2020 06:04:21 -0400
Received: from relay12.mail.gandi.net (unknown [217.70.178.232])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id 07CF23B1805
        for <linux-pwm@vger.kernel.org>; Wed, 30 Sep 2020 10:01:19 +0000 (UTC)
Received: from localhost (lfbn-lyo-1-1908-165.w90-65.abo.wanadoo.fr [90.65.88.165])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 09FF3200011;
        Wed, 30 Sep 2020 10:00:55 +0000 (UTC)
Date:   Wed, 30 Sep 2020 12:00:55 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: microchip: atmel,at91rm9200-tcb: add
 atmel,tcb-pwm
Message-ID: <20200930100055.GF2804081@piout.net>
References: <20200820225546.2246517-1-alexandre.belloni@bootlin.com>
 <20200820225546.2246517-2-alexandre.belloni@bootlin.com>
 <20200908204834.GA886652@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200908204834.GA886652@bogus>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 08/09/2020 14:48:34-0600, Rob Herring wrote:
> On Fri, Aug 21, 2020 at 12:55:43AM +0200, Alexandre Belloni wrote:
> > Move the TCB pwm nodes under their parent and move its documentation to the
> > main file.
> > 
> > Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> > ---
> > Cc: Rob Herring <robh+dt@kernel.org>
> > 
> >  .../devicetree/bindings/pwm/atmel-tcb-pwm.txt | 16 ----------
> >  .../soc/microchip/atmel,at91rm9200-tcb.yaml   | 31 ++++++++++++++++++-
> >  2 files changed, 30 insertions(+), 17 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/pwm/atmel-tcb-pwm.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/pwm/atmel-tcb-pwm.txt b/Documentation/devicetree/bindings/pwm/atmel-tcb-pwm.txt
> > deleted file mode 100644
> > index 985fcc65f8c4..000000000000
> > --- a/Documentation/devicetree/bindings/pwm/atmel-tcb-pwm.txt
> > +++ /dev/null
> > @@ -1,16 +0,0 @@
> > -Atmel TCB PWM controller
> > -
> > -Required properties:
> > -- compatible: should be "atmel,tcb-pwm"
> > -- #pwm-cells: should be 3. See pwm.yaml in this directory for a description of
> > -  the cells format. The only third cell flag supported by this binding is
> > -  PWM_POLARITY_INVERTED.
> > -- tc-block: The Timer Counter block to use as a PWM chip.
> 
> What happened to 'tc-block'? Commit message should mention why it is 
> gone.
> 
> > -
> > -Example:
> > -
> > -pwm {
> > -	compatible = "atmel,tcb-pwm";
> > -	#pwm-cells = <3>;
> > -	tc-block = <1>;
> > -};
> > diff --git a/Documentation/devicetree/bindings/soc/microchip/atmel,at91rm9200-tcb.yaml b/Documentation/devicetree/bindings/soc/microchip/atmel,at91rm9200-tcb.yaml
> > index 55fffae05dcf..a51adfdb58f6 100644
> > --- a/Documentation/devicetree/bindings/soc/microchip/atmel,at91rm9200-tcb.yaml
> > +++ b/Documentation/devicetree/bindings/soc/microchip/atmel,at91rm9200-tcb.yaml
> > @@ -59,6 +59,7 @@ patternProperties:
> >          items:
> >            - enum:
> >                - atmel,tcb-timer
> > +              - atmel,tcb-pwm
> >                - microchip,tcb-capture
> >        reg:
> >          description:
> > @@ -68,11 +69,33 @@ patternProperties:
> >  
> >          minItems: 1
> >          maxItems: 3
> > +    required:
> > +      - compatible
> > +      - reg
> > +
> > +  "^pwm@[0-2]$":
> > +    description: The timer block channels that are used as PWMs.
> > +    $ref: ../../pwm/pwm.yaml#
> > +    type: object
> > +    properties:
> > +      compatible:
> > +        const: atmel,tcb-pwm
> > +      reg:
> > +        description:
> > +          TCB channel to use for this PWM.
> 
> enum: [ 0, 1, 2 ]
> 

This does not work:
Documentation/devicetree/bindings/soc/microchip/atmel,at91rm9200-tcb.yaml: patternProperties:^pwm@[0-2]$:properties:reg:enum: False schema does not allow [0, 1, 2]

I guess it is because reg is of type uint32-matrix.

I'm not sure there is a point in adding it in the first place since the
unit-address is already limited to [0-2] and so reg will also be [0-2]

> > +
> > +        maxItems: 1
> > +      "#pwm-cells":
> > +        description:
> > +          The only third cell flag supported by this binding is
> > +          PWM_POLARITY_INVERTED.
> > +        const: 3
> >  
> >      required:
> >        - compatible
> >        - reg
> 
>        additionalProperties: false
> 
> >  
> > +
> >  allOf:
> >    - if:
> >        properties:
> > @@ -158,7 +181,13 @@ examples:
> >                          compatible = "atmel,tcb-timer";
> >                          reg = <1>;
> >                  };
> > -        };
> > +
> > +                pwm@2 {
> > +                        compatible = "atmel,tcb-pwm";
> > +                        reg = <2>;
> > +                        #pwm-cells = <3>;
> > +                };
> > +         };
> >      /* TCB0 Capture with QDEC: */
> >          timer@f800c000 {
> >                  compatible = "atmel,at91rm9200-tcb", "simple-mfd", "syscon";
> > -- 
> > 2.26.2
> > 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
