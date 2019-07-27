Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABFFE77943
	for <lists+linux-pwm@lfdr.de>; Sat, 27 Jul 2019 16:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387700AbfG0O2p (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 27 Jul 2019 10:28:45 -0400
Received: from mailoutvs2.siol.net ([185.57.226.193]:46289 "EHLO mail.siol.net"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387692AbfG0O2o (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sat, 27 Jul 2019 10:28:44 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTP id D8E7A5217B1;
        Sat, 27 Jul 2019 16:28:39 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta12.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta12.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 4KP6mDNuYTc3; Sat, 27 Jul 2019 16:28:39 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTPS id 878815217B3;
        Sat, 27 Jul 2019 16:28:39 +0200 (CEST)
Received: from jernej-laptop.localnet (89-212-178-211.dynamic.t-2.net [89.212.178.211])
        (Authenticated sender: jernej.skrabec@siol.net)
        by mail.siol.net (Zimbra) with ESMTPA id 048075217B1;
        Sat, 27 Jul 2019 16:28:39 +0200 (CEST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@siol.net>
To:     Maxime Ripard <mripard@kernel.org>
Cc:     thierry.reding@gmail.com, wens@csie.org, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH 5/6] pwm: sun4i: Add support to output source clock directly
Date:   Sat, 27 Jul 2019 16:28:38 +0200
Message-ID: <4063694.66Ui2fGJfo@jernej-laptop>
In-Reply-To: <20190727105008.he35sixfvoyl2lm7@flea.home>
References: <20190726184045.14669-1-jernej.skrabec@siol.net> <20190726184045.14669-6-jernej.skrabec@siol.net> <20190727105008.he35sixfvoyl2lm7@flea.home>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Dne sobota, 27. julij 2019 ob 12:50:08 CEST je Maxime Ripard napisal(a):
> On Fri, Jul 26, 2019 at 08:40:44PM +0200, Jernej Skrabec wrote:
> > PWM core has an option to bypass whole logic and output unchanged source
> > clock as PWM output. This is achieved by enabling bypass bit.
> > 
> > Note that when bypass is enabled, no other setting has any meaning, not
> > even enable bit.
> > 
> > This mode of operation is needed to achieve high enough frequency to
> > serve as clock source for AC200 chip, which is integrated into same
> > package as H6 SoC.
> > 
> > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> 
> It doesn't seem to be available on the A10 (at least) though. The A13
> seem to have it, so you should probably check that, and make that
> conditional to the compatible if not available on all of them.

Ok, can you suggest the name for the quirk? "has_bypass" is suspiciously 
similar to "has_prescaler_bypass".

Also, how to name these sun4i_pwm_data structures? Now that there are (will 
be) three new quirks, name of the structure would be just too long, like 
"sun50i_pwm_dual_prescaler_bypass_clk_rst_bypass". 

Best regards,
Jernej

> 
> Maxime
> 
> --
> Maxime Ripard, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com




