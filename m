Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40BFF183164
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Mar 2020 14:29:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbgCLN3x (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 12 Mar 2020 09:29:53 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:41497 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbgCLN3x (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 12 Mar 2020 09:29:53 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1jCNuC-0007Km-DG; Thu, 12 Mar 2020 14:29:44 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1jCNuA-0001ji-U0; Thu, 12 Mar 2020 14:29:42 +0100
Date:   Thu, 12 Mar 2020 14:29:42 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Pascal Roeleven <dev@pascalroeleven.nl>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: pwm: sun4i: pwm-backlight not working since 5.6-rc1
Message-ID: <20200312132942.2kfspvmoc3mxkdx4@pengutronix.de>
References: <6185b5540ca082d887d7d13330c9d938@pascalroeleven.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6185b5540ca082d887d7d13330c9d938@pascalroeleven.nl>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, Mar 12, 2020 at 01:22:13PM +0100, Pascal Roeleven wrote:
> Hi all,
> 
> I am working on adding an old A10 device to mainline and noticed an issue
> when testing on 5.5.8 vs master.
> 
> Since 5.6-rc1, I can't control the brightness of my LCD backlight anymore.
> The backlight stays on full brightness instead. I am controlling the
> brightness value via sysfs for testing.
> 
> I am not sure if this is a general pwm-sun4i issue or if it is related to
> the backlight. However I narrowed it down to one commit for pwm-sun4i:
> 
> fa4d81784681a26bcf7d2a43c6ac5cf991ef28f5
> 
> If I use pwm-sun4i.c from 5b090b430d750961305030232314b6acdb0102aa on
> master, the backlight works fine. Unfortunately, due to my lack of kernel
> experience, I can't see how the commit above broke it.

Hmm, I cannot see how fa4d81784681a26bcf7d2a43c6ac5cf991ef28f5 breaks
this. Looking at the output of

	git show -b fa4d81784681a26bcf7d2a43c6ac5cf991ef28f5

(i.e. ignoring whitespace changes) I don't see how the behaviour you're
reporting can be explained.

Are you sure that fa4d81784681a26bcf7d2a43c6ac5cf991ef28f5 is the bad
commit?

Can you install a tool to inspect register values and check how the
affected registers change if you switch kernel versions and/or pwm
settings?

(e.g.
	memtool md 0x1c20e00+0xc
)

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
