Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 703AF60252D
	for <lists+linux-pwm@lfdr.de>; Tue, 18 Oct 2022 09:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbiJRHKy (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 18 Oct 2022 03:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbiJRHKc (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 18 Oct 2022 03:10:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E7487CA8A;
        Tue, 18 Oct 2022 00:10:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EB4E4B81BFB;
        Tue, 18 Oct 2022 07:10:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D647C43142;
        Tue, 18 Oct 2022 07:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666077024;
        bh=1n3yKH+jHZcKm9JP7oiRX4+wyMPs14jcsoNBnG64pzM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IDK5B6RjsysNX0+AYImjKVmDqOo9rgjr03Ev75Ke4c+n5UXbMSBujGcEuMboMRcoK
         LZGArh2WZ6Lj8SlItOV3kr1Efjqh0clxkXQb6ARyT4k0DRqEGvfuLFI/ZjwAK33mFm
         fIDdicAYl8LMeT//MiJRVfeTy8tu6BPaeTwVARQz+Uos8D3bq5N2SUT7Ho2bNLM2iN
         ojU/PggckJplbF9McOLggnl+IavNo+5oTsBwfeeFYYAlH4oIRjr8xCAWN5tfS/ijAS
         8ZiSCdGRqOOhzzckZOuRxtHQGPs9zpLonZhh1c96Ac4sIxPX92G+k55djoXM5lNGTe
         /crPZgAjI+TCA==
Date:   Tue, 18 Oct 2022 08:10:17 +0100
From:   Lee Jones <lee@kernel.org>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        William Breathitt Gray <william.gray@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH v4 1/4] dt-bindings: mfd: Document RZ/G2L MTU3a bindings
Message-ID: <Y05RWbqA0ofEc/Zj@google.com>
References: <20221010145222.1047748-1-biju.das.jz@bp.renesas.com>
 <20221010145222.1047748-2-biju.das.jz@bp.renesas.com>
 <8d6b8f0e-d9d7-0d77-aa99-379de768fd5d@linaro.org>
 <OS0PR01MB592232C831CCA84FC302212F86239@OS0PR01MB5922.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <OS0PR01MB592232C831CCA84FC302212F86239@OS0PR01MB5922.jpnprd01.prod.outlook.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, 11 Oct 2022, Biju Das wrote:

> 
> Hi Krzysztof Kozlowski,
> 
> > Subject: Re: [PATCH v4 1/4] dt-bindings: mfd: Document RZ/G2L MTU3a
> > bindings
> > 
> > On 10/10/2022 10:52, Biju Das wrote:
> > > The RZ/G2L multi-function timer pulse unit 3 (MTU3a) is embedded in
> > > the Renesas RZ/G2L family SoC's. It consists of eight 16-bit timer
> > > channels and one 32-bit timer channel. It supports the following
> > > functions
> > >  - Counter
> > >  - Timer
> > >  - PWM
> > >
> > > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > > ---
> > > v3->v4:
> > >  * Dropped counter and pwm compatibeles as they don't have any
> > resources.
> > >  * Made rz-mtu3 as pwm provider.
> > >  * Updated the example and description.
> > > v2->v3:
> > >  * Dropped counter bindings and integrated with mfd as it has only
> > one property.
> > >  * Removed "#address-cells" and "#size-cells" as it do not have
> > children with
> > >    unit addresses.
> > >  * Removed quotes from counter and pwm.
> > >  * Provided full path for pwm bindings.
> > >  * Updated the example.
> > > v1->v2:
> > >  * Modelled counter and pwm as a single device that handles
> > >    multiple channels.
> > >  * Moved counter and pwm bindings to respective subsystems
> > >  * Dropped 'bindings' from MFD binding title.
> > >  * Updated the example
> > >  * Changed the compatible names.
> > > ---
> > >  .../bindings/mfd/renesas,rz-mtu3.yaml         | 305
> > ++++++++++++++++++
> > >  1 file changed, 305 insertions(+)
> > >  create mode 100644
> > > Documentation/devicetree/bindings/mfd/renesas,rz-mtu3.yaml
> > 
> > This should not be in MFD. Just because some device has few features,
> > does not mean it should go to MFD... Choose either timer or pwm.
> 
> MFD is for multifunction device. This IP supports multiple functions
> like timer, pwm, clock source/events. That is the reason I have added 
> here. MFD is core which provides register access for client devices.
> 
> For me moving it to pwm or counter is not a big problem.
> Why do you think it cannot be MFD?

Sorry for jumping in late here.  I see this has been resolved.

The TL;DR is: if you're not using the MFD Core (and including
mfd/core.h), it's not an MFD.  You *could* split this up into its
component parts, place them into their own subsystems and use an MFD
core driver to register them all, but as Thierry says, this is not a
hard requirement either.

-- 
Lee Jones [李琼斯]
