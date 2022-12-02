Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18411641193
	for <lists+linux-pwm@lfdr.de>; Sat,  3 Dec 2022 00:39:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234557AbiLBXjY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pwm@lfdr.de>); Fri, 2 Dec 2022 18:39:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233745AbiLBXjX (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 2 Dec 2022 18:39:23 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E1BFA8DBE7
        for <linux-pwm@vger.kernel.org>; Fri,  2 Dec 2022 15:39:22 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0958523A;
        Fri,  2 Dec 2022 15:39:29 -0800 (PST)
Received: from slackpad.lan (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 36A143F73B;
        Fri,  2 Dec 2022 15:39:21 -0800 (PST)
Date:   Fri, 2 Dec 2022 23:37:38 +0000
From:   Andre Przywara <andre.przywara@arm.com>
To:     Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev
Subject: Re: [PATCH] pwm: sun4i: Propagate errors in .get_state() to the
 caller
Message-ID: <20221202233738.281329b1@slackpad.lan>
In-Reply-To: <20221201154822.mx7jafj3tyxes5ab@pengutronix.de>
References: <20221201152223.3133-1-andre.przywara@arm.com>
        <20221201154822.mx7jafj3tyxes5ab@pengutronix.de>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.31; x86_64-slackware-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, 1 Dec 2022 16:48:22 +0100
Uwe Kleine-König <u.kleine-koenig@pengutronix.de> wrote:

> On Thu, Dec 01, 2022 at 03:22:23PM +0000, Andre Przywara wrote:
> > .get_state() can return an error indication now. Make use of it to
> > propagate an impossible prescaler encoding, should that have sneaked in
> > somehow.
> > Also check the return value of clk_get_rate(). That's unlikely to fail,
> > but we use that in two divide operations down in the code, so let's
> > avoid a divide-by-zero condition on the way.
> > 
> > Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> > ---
> > Hi,
> > 
> > this goes on top of Uwe's series to introduce and observe .get_state
> > failures: https://lore.kernel.org/linux-pwm/20221130152148.2769768-12-u.kleine-koenig@pengutronix.de/T/#m9af39aa03bbd9bb7b31b3600f110c65ee0e8e70b
> > Actually it only relies on patch 01/11 from that.  
> 
> I recommend to put this info in machine-readable form into your patch.
> If you applied my patch #1 on v6.1-rc1 and this on top, you'd do
> 
> 	git format-patch -1 --base v6.1-rc1
> 
> This results in two additional lines that the build bots can evaluate,
> to find the right setup to test your patch.

Ah, nice one, didn't know about that. And just went I wanted to
complain that this relies on public branches and committed patches, I
learned that it doesn't.

So I got:
base-commit: eb7081409f94a9a8608593d0fb63a1aa3d6f95d8
prerequisite-patch-id: 3022328f2919301d79d852ef148c3f9dc4d723d6

Do you want me to resend the patch with this information?

> Apart from that:
> 
> Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Thanks for that!

Cheers,
Andre

> 
> and thanks to pick up on this topic,
> Uwe
> 

