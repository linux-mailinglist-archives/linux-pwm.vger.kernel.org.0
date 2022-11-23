Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FF1D6350BC
	for <lists+linux-pwm@lfdr.de>; Wed, 23 Nov 2022 07:59:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236160AbiKWG7B (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 23 Nov 2022 01:59:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236165AbiKWG7A (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 23 Nov 2022 01:59:00 -0500
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9F7928B138;
        Tue, 22 Nov 2022 22:58:56 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 6116780F1;
        Wed, 23 Nov 2022 06:58:55 +0000 (UTC)
Date:   Wed, 23 Nov 2022 08:58:54 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-omap@vger.kernel.org, linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: pwm: Allow decimal format in
 addition to hex format
Message-ID: <Y33ErrigR4II6EYH@atomide.com>
References: <20221122123225.59106-1-tony@atomide.com>
 <20221123024153.GB1026269-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221123024153.GB1026269-robh@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

* Rob Herring <robh@kernel.org> [221123 02:31]:
> On Tue, Nov 22, 2022 at 02:32:24PM +0200, Tony Lindgren wrote:
> > Let's allow node numbering in decimal format too.
> > 
> > Simple human-readable increments/IDs are usually decimal, hex is only for
> > addresses as noted by Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>.
> > 
> > Let's use an improved match suggested by Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> and improved a bit by Uwe Kleine-König
> > <u.kleine-koenig@pengutronix.de>.
> > 
> > Cc: linux-pwm@vger.kernel.org
> > Cc: Thierry Reding <thierry.reding@gmail.com>
> > Suggested-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > Suggested-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > ---
> > 
> > Changes since v2:
> > 
> > - Use pattern suggested by Krzysztof and Uwe
> > 
> > Changes since v1:
> > 
> > - New patch added to deal with pwm-omap-dmtimer binding
> > 
> > ---
> >  Documentation/devicetree/bindings/pwm/pwm.yaml | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/pwm/pwm.yaml b/Documentation/devicetree/bindings/pwm/pwm.yaml
> > --- a/Documentation/devicetree/bindings/pwm/pwm.yaml
> > +++ b/Documentation/devicetree/bindings/pwm/pwm.yaml
> > @@ -13,7 +13,7 @@ select: false
> >  
> >  properties:
> >    $nodename:
> > -    pattern: "^pwm(@.*|-[0-9a-f])*$"
> > +    pattern: "^pwm(@.+|-[0-9a-f]+)?$"
> 
> So now pwm-10 could be either?

Yes.

> I'm fine with decimal, but can we do that everywhere we do this -N 
> naming?

Do you mean the '[0-9a-f]' users that don't use '[0-9af]+'?

These can be found with:

$ find Documentation/devicetree/bindings/ -name \*.yaml | \
	xargs grep pattern: | grep '\[0-9a-f\]' | grep -v '\[0-9a-f\]+'

Not sure if some of these need to intentionally limit the node numbering
to 15.

If you have some other criteria in mind, let me know :)

That sounds like a separate patch though.

Regards,

Tony
