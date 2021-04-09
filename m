Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DCEA3596AB
	for <lists+linux-pwm@lfdr.de>; Fri,  9 Apr 2021 09:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231811AbhDIHpT (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 9 Apr 2021 03:45:19 -0400
Received: from mo-csw1516.securemx.jp ([210.130.202.155]:47362 "EHLO
        mo-csw.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbhDIHpS (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 9 Apr 2021 03:45:18 -0400
Received: by mo-csw.securemx.jp (mx-mo-csw1516) id 1397iWUC032283; Fri, 9 Apr 2021 16:44:32 +0900
X-Iguazu-Qid: 34ts1PSq8uy9NsjtWP
X-Iguazu-QSIG: v=2; s=0; t=1617954271; q=34ts1PSq8uy9NsjtWP; m=HQ4LwDPZhM5Lp0dULteRO76Vt1mbmgpcJ69yjzbLcY0=
Received: from imx12-a.toshiba.co.jp (imx12-a.toshiba.co.jp [61.202.160.135])
        by relay.securemx.jp (mx-mr1510) id 1397iUh5015378
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 9 Apr 2021 16:44:30 +0900
Received: from enc02.toshiba.co.jp (enc02.toshiba.co.jp [61.202.160.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by imx12-a.toshiba.co.jp (Postfix) with ESMTPS id A6AEC1000B1;
        Fri,  9 Apr 2021 16:44:30 +0900 (JST)
Received: from hop101.toshiba.co.jp ([133.199.85.107])
        by enc02.toshiba.co.jp  with ESMTP id 1397iU8N007893;
        Fri, 9 Apr 2021 16:44:30 +0900
Date:   Fri, 9 Apr 2021 16:44:28 +0900
From:   Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
To:     Rob Herring <robh@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
        punit1.agrawal@toshiba.co.jp, yuji2.ishikawa@toshiba.co.jp,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: pwm: Add bindings for Toshiba
 Visconti PWM Controller
X-TSB-HOP: ON
Message-ID: <20210409074428.hg7ys5he6iuqzhm6@toshiba.co.jp>
References: <20210212131910.557581-1-nobuhiro1.iwamatsu@toshiba.co.jp>
 <20210212131910.557581-2-nobuhiro1.iwamatsu@toshiba.co.jp>
 <20210305202224.GA583007@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210305202224.GA583007@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi,

On Fri, Mar 05, 2021 at 02:22:24PM -0600, Rob Herring wrote:
> On Fri, Feb 12, 2021 at 10:19:09PM +0900, Nobuhiro Iwamatsu wrote:
> > Add bindings for the Toshiba Visconti PWM Controller.
> > 
> > Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> > ---
> >  .../bindings/pwm/toshiba,pwm-visconti.yaml    | 43 +++++++++++++++++++
> >  1 file changed, 43 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/pwm/toshiba,pwm-visconti.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/pwm/toshiba,pwm-visconti.yaml b/Documentation/devicetree/bindings/pwm/toshiba,pwm-visconti.yaml
> > new file mode 100644
> > index 000000000000..f11558cdc32f
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pwm/toshiba,pwm-visconti.yaml
> > @@ -0,0 +1,43 @@
> > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
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
> > +      - const: toshiba,pwm-visconti
> 
> The 'normal' order is: toshiba,visconti-pwm

I see, I will change to it.

> 
> Otherwise,
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> 

Thanks!

Best regards,
  Nobuhiro
