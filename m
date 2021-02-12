Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13455319A0A
	for <lists+linux-pwm@lfdr.de>; Fri, 12 Feb 2021 07:53:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbhBLGxU (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 12 Feb 2021 01:53:20 -0500
Received: from mo-csw-fb1115.securemx.jp ([210.130.202.174]:48792 "EHLO
        mo-csw-fb.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbhBLGxT (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 12 Feb 2021 01:53:19 -0500
X-Greylist: delayed 376 seconds by postgrey-1.27 at vger.kernel.org; Fri, 12 Feb 2021 01:53:18 EST
Received: by mo-csw-fb.securemx.jp (mx-mo-csw-fb1115) id 11C6l4KO030844; Fri, 12 Feb 2021 15:47:05 +0900
Received: by mo-csw.securemx.jp (mx-mo-csw1114) id 11C6ijka021042; Fri, 12 Feb 2021 15:44:46 +0900
X-Iguazu-Qid: 2wGqhgW4xdcYh6o0w8
X-Iguazu-QSIG: v=2; s=0; t=1613112285; q=2wGqhgW4xdcYh6o0w8; m=xuBx/1YAhJIgG+Ao+2XQamK3cXyfCAXjCXBDLa2TDbA=
Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
        by relay.securemx.jp (mx-mr1112) id 11C6ii5P016481;
        Fri, 12 Feb 2021 15:44:44 +0900
Received: from enc02.toshiba.co.jp ([61.202.160.51])
        by imx12.toshiba.co.jp  with ESMTP id 11C6iiNi014961;
        Fri, 12 Feb 2021 15:44:44 +0900 (JST)
Received: from hop101.toshiba.co.jp ([133.199.85.107])
        by enc02.toshiba.co.jp  with ESMTP id 11C6ihk4018829;
        Fri, 12 Feb 2021 15:44:44 +0900
Date:   Fri, 12 Feb 2021 15:44:43 +0900
From:   Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
To:     Rob Herring <robh@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        punit1.agrawal@toshiba.co.jp, yuji2.ishikawa@toshiba.co.jp,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: pwm: Add bindings for Toshiba Visconti
 PWM Controller
X-TSB-HOP: ON
Message-ID: <20210212064443.ahjoby4w3pdi65uu@toshiba.co.jp>
References: <20200917223140.227542-1-nobuhiro1.iwamatsu@toshiba.co.jp>
 <20200917223140.227542-2-nobuhiro1.iwamatsu@toshiba.co.jp>
 <20200923203735.GA1257022@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200923203735.GA1257022@bogus>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi,

Thank for your review.

On Wed, Sep 23, 2020 at 02:37:35PM -0600, Rob Herring wrote:
> On Fri, Sep 18, 2020 at 07:31:39AM +0900, Nobuhiro Iwamatsu wrote:
> > Add bindings for the Toshiba Visconti PWM Controller.
> > 
> > Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> > ---
> >  .../bindings/pwm/toshiba,pwm-visconti.yaml    | 48 +++++++++++++++++++
> >  1 file changed, 48 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/pwm/toshiba,pwm-visconti.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/pwm/toshiba,pwm-visconti.yaml b/Documentation/devicetree/bindings/pwm/toshiba,pwm-visconti.yaml
> > new file mode 100644
> > index 000000000000..9145e9478b41
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pwm/toshiba,pwm-visconti.yaml
> > @@ -0,0 +1,48 @@
> > +# SPDX-License-Identifier: GPL-2.0
> 
> Dual license new bindings please.
> 
> (GPL-2.0-only OR BSD-2-Clause)
> 

OK, I will chnage to dual license.

> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/pwm/toshiba,pwm-visconti.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Toshiba Visconti PWM Controller
> > +
> > +maintainers:
> > +  - Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> > +
> > +properties:
> > +  compatible:
> > +    items:
> > +      - enum:
> > +          - toshiba,pwm-tmpv7708
> 
> The normal order is: vendor,soc-block
> 
> > +      - const: toshiba,pwm-visconti
> 
> Do you expect a lot of chips with the exact same version of the IP? If 
> not drop. Future chips can always use toshiba,pwm-tmpv7708 as a 
> fallback.


Currently it still supports only one IP. Therefore, "toshiba, pwm-visconti"
is enough for now. I will drop enum line..

> 
> > +
> > +  reg:
> > +    # base address and length of the registers block for the PWM.
> 
> Drop. No need to describe common properties.
> 

OK, I will drop this properties.

> > +    maxItems: 1
> > +
> > +  '#pwm-cells':
> > +    # should be 2. See pwm.yaml in this directory for a description of
> > +    # the cells format.
> 
> Drop.

OK, I will this comment lines.

> 
> > +    const: 2
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - '#pwm-cells'
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    soc {
> > +        #address-cells = <2>;
> > +        #size-cells = <2>;
> > +
> > +        pwm: pwm@241c0000 {
> > +            compatible = "toshiba,pwm-tmpv7708", "toshiba,pwm-visconti";
> > +            reg = <0 0x241c0000 0 0x1000>;
> > +            pinctrl-names = "default";
> > +            pinctrl-0 = <&pwm_mux>;
> > +            #pwm-cells = <2>;
> > +        };
> > +    };
> > -- 
> > 2.27.0
> > 
> 

Best regards,
  Nobuhiro

