Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D3CD794113
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Sep 2023 18:05:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233554AbjIFQFY (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 6 Sep 2023 12:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232827AbjIFQFX (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 6 Sep 2023 12:05:23 -0400
Received: from gofer.mess.org (gofer.mess.org [88.97.38.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EE3B1BC3;
        Wed,  6 Sep 2023 09:04:30 -0700 (PDT)
Received: by gofer.mess.org (Postfix, from userid 1000)
        id 46F9F100091; Wed,  6 Sep 2023 17:03:25 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
        t=1694016205; bh=bQDhwwRwRNyVyuFF6ONIXSNKa0FRRRpdsnlp1UnTAOI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=juKUekLXafKpQaM+qlITrCGjmcx9xv/Zk4irrGFn5XDBVGwAl7+b8CfPgk2Z6ofH0
         T0yDjNDkFW15mlUmvh5Q7yrx+EQb/9OQjN/2T1666I+7MuBhzCIbf5ECpm0IYvNHva
         5p44EZx9eWvF8dgTA4EJLv4tcZR9z13SVR7tokRMa7j5lhFDRZ1nmVZtCySraXQHv8
         hGC/jKj65tx57HuRQTx0a0gVEs8iPnKNvnFEKEnm7LiFGUCZeucme7vORs990CWJjo
         XtcgrT8js6tH6cJfweOA+pUtHyWJOHqbulhnsoARkOcAj4KQNtd8FoYr1lVnKrzfUJ
         xIuNf+rAG8jzQ==
Date:   Wed, 6 Sep 2023 17:03:25 +0100
From:   Sean Young <sean@mess.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-media@vger.kernel.org,
        "Sicelo A . Mhlongo" <absicsz@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pwm@vger.kernel.org,
        Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>,
        Pavel Machek <pavel@ucw.cz>,
        Timo Kokkonen <timo.t.kokkonen@iki.fi>
Subject: Re: [PATCH v3 1/2] media: rc: remove ir-rx51 in favour of generic
 pwm-ir-tx
Message-ID: <ZPiizUW2ywv57Wo8@gofer.mess.org>
References: <20230822145644.213589-1-sean@mess.org>
 <20230822145644.213589-2-sean@mess.org>
 <20230906155803.vkyvifbazkleb3vr@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230906155803.vkyvifbazkleb3vr@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, Sep 06, 2023 at 05:58:03PM +0200, Uwe Kleine-König wrote:
> On Tue, Aug 22, 2023 at 03:56:43PM +0100, Sean Young wrote:
> > The ir-rx51 is a pwm-based TX driver specific to the N900. This can be
> > handled entirely by the generic pwm-ir-tx driver, and in fact the
> > pwm-ir-tx driver has been compatible with ir-rx51 from the start.
> > 
> > Note that the suspend code in the ir-rx51 driver is unnecessary, since
> > during transmit, the process is not in interruptable sleep. The process
> > is not put to sleep until the transmit completes.
> > 
> > Tested-by: Sicelo A. Mhlongo <absicsz@gmail.com>
> > Signed-off-by: Sean Young <sean@mess.org>
> > Cc: Tony Lindgren <tony@atomide.com>
> > Cc: Russell King <linux@armlinux.org.uk>
> > Cc: Thierry Reding <thierry.reding@gmail.com>
> > Cc: "Uwe Kleine-König" <u.kleine-koenig@pengutronix.de>
> > Cc: linux-omap@vger.kernel.org
> > Cc: linux-arm-kernel@lists.infradead.org
> > Cc: linux-pwm@vger.kernel.org
> > Cc: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
> > Cc: Pali Rohár <pali.rohar@gmail.com>
> > Cc: Pavel Machek <pavel@ucw.cz>
> > Cc: Timo Kokkonen <timo.t.kokkonen@iki.fi>
> 
> Looks ok for me. I assume this will go in via the media tree and the pwm
> list was only Cc:d because drivers/media/rc/pwm-ir-tx.c uses pwm
> functions?

That is exactly right.

> I'll mark this patch as "handled-elsewhere" in the pwm
> patchwork. Please tell me if you object.
> 
> Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

That's perfect.

Thanks,

Sean
