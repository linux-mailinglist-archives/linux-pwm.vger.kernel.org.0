Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 380B25F2CC3
	for <lists+linux-pwm@lfdr.de>; Mon,  3 Oct 2022 11:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbiJCJEw (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 3 Oct 2022 05:04:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbiJCJEZ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 3 Oct 2022 05:04:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B12B1B9D4;
        Mon,  3 Oct 2022 01:57:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 30A5560FDC;
        Mon,  3 Oct 2022 08:57:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5C5FC433D6;
        Mon,  3 Oct 2022 08:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664787453;
        bh=Q0+10uGkL4axbW9qxQGcxfGVVKx4pZGFzgy/AdKF73U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uYu775RSi0HNcBsbUBsldRx0yfp5zZhNk9iw2RF6zjr8RsiwQmNKL38pJt6GyQpue
         oVTr3dzXpHysEBSagVi/PH/J8B3G0m2R118es6dRaCnqVUbj2zOJ0wiJhD9NH2nq1D
         Ey544VUEVKMN6uSyZkS0QAyiAXqZSbktx/4XGZ+Gx4YDTimA5ZswpFAbl31VNft/Ap
         xPocBUZI6AMCTLLrWmFTQ7xGgN9QAyCcTIboz+ocvQOdSZG6s07i1zs/+PSbJwd5tu
         GaqwUnqK9tRdVwWSv2zCNXWzcxYkVWq0zi1V+arWCjPsVWmRqoyM6W6umIX7jv5Hfn
         boy2PCKTheFSA==
Date:   Mon, 3 Oct 2022 09:57:27 +0100
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
Message-ID: <Yzqj9/1TVEB1BZcL@google.com>
References: <20220929103043.1228235-1-biju.das.jz@bp.renesas.com>
 <20220929103043.1228235-4-biju.das.jz@bp.renesas.com>
 <YzXbU69imBM5aKwn@google.com>
 <OS0PR01MB5922134DC72EE29D5404867B86579@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <YzbcyxY839GlR71V@google.com>
 <OS0PR01MB592241115B5D0F17B8CAE9D086599@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <YzqQC3gEzGksqYzk@google.com>
 <OS0PR01MB5922630991BABA41FAE06BBE865B9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <OS0PR01MB5922630991BABA41FAE06BBE865B9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, 03 Oct 2022, Biju Das wrote:

> Hi Lee,
> 
> > Subject: Re: [PATCH RFC 3/7] dt-bindings: mfd: rz-mtu3: Document
> > RZ/G2L MTU3 PWM
> > 
> > On Sat, 01 Oct 2022, Biju Das wrote:
> > 
> > > Hi Lee Jones,
> > >
> > > > Subject: Re: [PATCH RFC 3/7] dt-bindings: mfd: rz-mtu3: Document
> > > > RZ/G2L MTU3 PWM
> > > >
> > > > On Thu, 29 Sep 2022, Biju Das wrote:
> > > >
> > > > > Hi Lee Jones,
> > > > >
> > > > > Thanks for the feedback.
> > > > >
> > > > > > Subject: Re: [PATCH RFC 3/7] dt-bindings: mfd: rz-mtu3:
> > Document
> > > > > > RZ/G2L MTU3 PWM
> > > > > >
> > > > > > On Thu, 29 Sep 2022, Biju Das wrote:
> > > > > >
> > > > > > > Document RZ/G2L MTU3 PWM support. It supports following pwm
> > > > modes.
> > > > > > > 	1) PWM mode 1
> > > > > > > 	2) PWM mode 2
> > > > > > > 	3) Reset-synchronized PWM mode
> > > > > > > 	4) Complementary PWM mode 1 (transfer at crest)
> > > > > > > 	5) Complementary PWM mode 2 (transfer at trough)
> > > > > > > 	6) Complementary PWM mode 3 (transfer at crest and trough)
> > > > > >
> > > > > > Shouldn't all this go in the PWM driver binding?
> > > > >
> > > > > Looks like at top level MTU3 IP provides similar HW
> > functionality
> > > > like
> > > > > below binding [1], where there is a core MFD driver and pwm,
> > > > > counter and timer as child devices.
> > > >
> > > > Previous mistakes are not good references for what should happen
> > in
> > > > the present and the future. =;)
> > >
> > > Why do you think that reference is not a good one? I believe there
> > > should be some reason for it.
> > 
> > I didn't even look at it.
> > 
> > What I "believe" is that documentation for each functionality
> > belonging to a particular subsystem should live in subsystem's
> > associated documentation directory and be reviewed/maintained by that
> > subsystem's associated maintainer.
> 
> If I am correct, MFD is subsystem for calling shared resources
> across subsystems.
> 
> Here shared resources are channels which is shared by timer, counter and pwm

Which API do the consumers use to obtain these shared resources?

> They are child objects of MFD subsystems. That is the reason it is in MFDndings.

If the properties belong to the child, they should be documented in
the child's bindings.  Shoving all functionality and by extension all
documentation into the MFD driver and/or binding is incorrect
behaviour.

Looking at it from another perspective, I cannot/should not review
PWM, Reset, Counter or Timer bindings, since I do not have the level
of subject area knowledge as the assigned maintainers do.

Please place all sub-system specific bindings in their correct (leaf)
bindings and link to them from this one (run this):

  git grep \$ref -- Documentation/devicetree/bindings/mfd/

-- 
Lee Jones [李琼斯]
