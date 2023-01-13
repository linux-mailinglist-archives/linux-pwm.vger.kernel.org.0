Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEC82668EFD
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Jan 2023 08:21:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240905AbjAMHVO (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 13 Jan 2023 02:21:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240906AbjAMHUm (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 13 Jan 2023 02:20:42 -0500
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 45914755D6;
        Thu, 12 Jan 2023 23:06:08 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 5E21E80FA;
        Fri, 13 Jan 2023 07:06:07 +0000 (UTC)
Date:   Fri, 13 Jan 2023 09:06:06 +0200
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
Message-ID: <Y8EC3jB2317ohUIB@atomide.com>
References: <20221122123225.59106-1-tony@atomide.com>
 <20221123024153.GB1026269-robh@kernel.org>
 <Y33ErrigR4II6EYH@atomide.com>
 <20221127182232.GA128974-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221127182232.GA128974-robh@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Rob,

* Rob Herring <robh@kernel.org> [221127 18:22]:
> On Wed, Nov 23, 2022 at 08:58:54AM +0200, Tony Lindgren wrote:
> > * Rob Herring <robh@kernel.org> [221123 02:31]:
> > > On Tue, Nov 22, 2022 at 02:32:24PM +0200, Tony Lindgren wrote:
> > > > --- a/Documentation/devicetree/bindings/pwm/pwm.yaml
> > > > +++ b/Documentation/devicetree/bindings/pwm/pwm.yaml
> > > > @@ -13,7 +13,7 @@ select: false
> > > >  
> > > >  properties:
> > > >    $nodename:
> > > > -    pattern: "^pwm(@.*|-[0-9a-f])*$"
> > > > +    pattern: "^pwm(@.+|-[0-9a-f]+)?$"
> > > 
> > > So now pwm-10 could be either?
> > 
> > Yes.
> > 
> > > I'm fine with decimal, but can we do that everywhere we do this -N 
> > > naming?
> > 
> > Do you mean the '[0-9a-f]' users that don't use '[0-9af]+'?
> 
> No, I mean for all cases of <nodename>-N, can be we consistent. Either 
> we use hex or we use decimal.
>  
> > 
> > These can be found with:
> > 
> > $ find Documentation/devicetree/bindings/ -name \*.yaml | \
> > 	xargs grep pattern: | grep '\[0-9a-f\]' | grep -v '\[0-9a-f\]+'
> 
> Not quite. It's just cases of '-N':
> 
> $ find Documentation/devicetree/bindings/ -name \*.yaml |         xargs grep pattern: | grep '\-\[0-9a-f\]' | grep -v '\[0-9a-f\]+'
> Documentation/devicetree/bindings/phy/intel,combo-phy.yaml:    pattern: "combophy(@.*|-[0-9a-f])*$"
> Documentation/devicetree/bindings/pwm/pwm.yaml:    pattern: "^pwm(@.*|-[0-9a-f])*$"
> Documentation/devicetree/bindings/timestamp/hardware-timestamps-common.yaml:    pattern: "^timestamp(@.*|-[0-9a-f])?$"
> Documentation/devicetree/bindings/watchdog/watchdog.yaml:    pattern: "^watchdog(@.*|-[0-9a-f])?$"
> Documentation/devicetree/bindings/spi/spi-controller.yaml:    pattern: "^spi(@.*|-[0-9a-f])*$"
> Documentation/devicetree/bindings/rtc/rtc.yaml:    pattern: "^rtc(@.*|-[0-9a-f])*$"
> 
> 
> And there's probably some more in dtschema.

Looking at this again, not exactly sure still what you want..

Can you please post some initial patch maybe, verbal patches are
a bit tricky :)

Regards,

Tony
