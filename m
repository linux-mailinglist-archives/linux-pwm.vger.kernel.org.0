Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A668F5F2BFB
	for <lists+linux-pwm@lfdr.de>; Mon,  3 Oct 2022 10:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbiJCIhp (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 3 Oct 2022 04:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231661AbiJCIhQ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 3 Oct 2022 04:37:16 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CBEF10061;
        Mon,  3 Oct 2022 01:10:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id E4848CE0B19;
        Mon,  3 Oct 2022 07:32:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F170C433C1;
        Mon,  3 Oct 2022 07:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664782354;
        bh=kndw7sVSotadKbIopJSfkVKeF16JHesTWp6Ta3tvvCk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=atdrJtnQAazUMSIEajmfjBhH39dKEwQuvzGBE1Gs6ZzU1wQyeD/AUHrg57nZSMOT5
         NZGXJFlQkjo7uVP0wsuDI2PQHFQRZrqJlzMwLdx7qjDZV/fQD5A+X2AZ4qG3LLJz8U
         GPxVjFGhwvhnLXe3zrWe3UZ1w46mhXw5uvG1ngN/M80hj/dZc9KtgsuJOhoNQTyvRe
         MWCIv3yjVl03Dv/GJq/pveBEPoF4R3BRSgKW4HikLqHSf88WI2DFK2bCudTeOag1Gz
         gcFTOxaLUHv3827Du0/zIPNyR9VPRPAubH/e7xGZF/vqD0TahMjzLk4p2HQMQ2x6M+
         6gz0zjAbJi/DQ==
Date:   Mon, 3 Oct 2022 08:32:27 +0100
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
Message-ID: <YzqQC3gEzGksqYzk@google.com>
References: <20220929103043.1228235-1-biju.das.jz@bp.renesas.com>
 <20220929103043.1228235-4-biju.das.jz@bp.renesas.com>
 <YzXbU69imBM5aKwn@google.com>
 <OS0PR01MB5922134DC72EE29D5404867B86579@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <YzbcyxY839GlR71V@google.com>
 <OS0PR01MB592241115B5D0F17B8CAE9D086599@OS0PR01MB5922.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <OS0PR01MB592241115B5D0F17B8CAE9D086599@OS0PR01MB5922.jpnprd01.prod.outlook.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Sat, 01 Oct 2022, Biju Das wrote:

> Hi Lee Jones,
> 
> > Subject: Re: [PATCH RFC 3/7] dt-bindings: mfd: rz-mtu3: Document
> > RZ/G2L MTU3 PWM
> > 
> > On Thu, 29 Sep 2022, Biju Das wrote:
> > 
> > > Hi Lee Jones,
> > >
> > > Thanks for the feedback.
> > >
> > > > Subject: Re: [PATCH RFC 3/7] dt-bindings: mfd: rz-mtu3: Document
> > > > RZ/G2L MTU3 PWM
> > > >
> > > > On Thu, 29 Sep 2022, Biju Das wrote:
> > > >
> > > > > Document RZ/G2L MTU3 PWM support. It supports following pwm
> > modes.
> > > > > 	1) PWM mode 1
> > > > > 	2) PWM mode 2
> > > > > 	3) Reset-synchronized PWM mode
> > > > > 	4) Complementary PWM mode 1 (transfer at crest)
> > > > > 	5) Complementary PWM mode 2 (transfer at trough)
> > > > > 	6) Complementary PWM mode 3 (transfer at crest and trough)
> > > >
> > > > Shouldn't all this go in the PWM driver binding?
> > >
> > > Looks like at top level MTU3 IP provides similar HW functionality
> > like
> > > below binding [1], where there is a core MFD driver and pwm, counter
> > > and timer as child devices.
> > 
> > Previous mistakes are not good references for what should happen in
> > the present and the future. =;)
> 
> Why do you think that reference is not a good one? I believe there
> should be some reason for it.

I didn't even look at it.

What I "believe" is that documentation for each functionality
belonging to a particular subsystem should live in subsystem's
associated documentation directory and be reviewed/maintained by that
subsystem's associated maintainer.

-- 
Lee Jones [李琼斯]
