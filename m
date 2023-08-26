Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CCD5789913
	for <lists+linux-pwm@lfdr.de>; Sat, 26 Aug 2023 22:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbjHZUjP (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 26 Aug 2023 16:39:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjHZUjI (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 26 Aug 2023 16:39:08 -0400
Received: from gofer.mess.org (gofer.mess.org [88.97.38.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 215F2196
        for <linux-pwm@vger.kernel.org>; Sat, 26 Aug 2023 13:39:06 -0700 (PDT)
Received: by gofer.mess.org (Postfix, from userid 1000)
        id EF4461000CD; Sat, 26 Aug 2023 21:39:01 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
        t=1693082341; bh=tSTb58k9ibwjjJTD3dAsPR7pVUr0526V70hvEa5OHXg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bDv47V2u/K46HK1DzT5oH5mzJXJ1MmCVcZfHxdJ74sovTB41uGHjtNJ+NLkY4dvMQ
         IwhkJ5o57NuR/q52eDthROQV54n/ZUwUUIOJHllNlWVN1ohWj0vtrHQgbMqSJX30Rn
         abK40uqtEklDv6rjUQQTNrdVkLMbL4dge+jpxSyI8VfVNHwqqLXsUjePVSLy+WmHm0
         mimkUAWt1ANrLwZJJZZEN8zPRMbnQR0VxWA+C1d8BAIWBc2wtT8QoUN/BInvzTl81F
         t6T9kq9cP6b2FZSVQKO+eXpY6R3JW0plQMOnVK7fbPvfE6JPB4oJ2iJDWvohDti8Cu
         XRuLrpZTUsRIw==
Date:   Sat, 26 Aug 2023 21:39:01 +0100
From:   Sean Young <sean@mess.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-media@vger.kernel.org, Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org,
        Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>,
        Pavel Machek <pavel@ucw.cz>,
        Timo Kokkonen <timo.t.kokkonen@iki.fi>
Subject: Re: [PATCH v4 2/2] dt-bindings: media: remove nokia,n900-ir as
 pwm-ir-tx is compatible
Message-ID: <ZOpi5fpDIoJOLnN9@gofer.mess.org>
References: <20230826171711.366710-1-sean@mess.org>
 <2b81baae-cd50-e46f-f560-33b3d186cb24@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b81baae-cd50-e46f-f560-33b3d186cb24@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Sat, Aug 26, 2023 at 09:54:04PM +0200, Krzysztof Kozlowski wrote:
> On 26/08/2023 19:17, Sean Young wrote:
> > The generic pwm-ir-tx driver works for the Nokia n900, so nokia,n900-ir
> > can be removed.
> > 
> > Signed-off-by: Sean Young <sean@mess.org>
> 
> Please use scripts/get_maintainers.pl to get a list of necessary people
> and lists to CC. It might happen, that command when run on an older
> kernel, gives you outdated entries. Therefore please be sure you base
> your patches on recent Linux kernel.
> 
> You missed at least devicetree list (maybe more), so this won't be
> tested by automated tooling. Performing review on untested code might be
> a waste of time.

You are right, I -- again -- messed up. The Cc: list for 1/2 and 2/2 got
mixed up.

I am sorry about this, it's getting embarrassing now.

Is there any tooling which does this automagically? I'm copying and
pasting the output of scripts/get_maintainers.pl into shell scripts,
which is very error-prone (as evidenced by today's mistake).

Sean
