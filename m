Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86E431DE3CE
	for <lists+linux-pwm@lfdr.de>; Fri, 22 May 2020 12:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728809AbgEVKN7 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 22 May 2020 06:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728396AbgEVKN5 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 22 May 2020 06:13:57 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1B4FC061A0E
        for <linux-pwm@vger.kernel.org>; Fri, 22 May 2020 03:13:57 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1jc4ge-0000Jr-8U; Fri, 22 May 2020 12:13:56 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1jc4gd-0002DO-Kj; Fri, 22 May 2020 12:13:55 +0200
Date:   Fri, 22 May 2020 12:13:55 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: Missing feedback
Message-ID: <20200522101355.x4td3ehkfhp636ft@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello Thierry,

there is again quite a backlog of missing pwm feedback and missing care
for patchwork.

Patchwork has several iterations of a few patch series where the old
series should be marked as superseeded. If you want you can give me
write access there, then I can go through the list and mark patches
accordingly. (I'm user "ukleinek" on patchwork.ozlabs.org.)

Patches/mails where I'd like to see feedback (or just application) from
you include:

 - "Convert PWM period and duty cycle to u64" series (v14, feedback)
 - pwm: sun4i: direct clock output support for Allwinner A64 (v2, 
   application)
 - pwm: imx27: Fix rounding behavior
 - docs: pwm: rework documentation for the framework
 - adding linux-pwm archives to lore.kernel.org?

but I feel the backlog on the list is much bigger.

In the past I did less review on the list myself, partly because I
consider it frustrating to invest time and then still have patches lying
around without application/feedback.

I think getting patchwork more up to date would already help
considerably, but in the long run I can also imagine taking care for
patch application and sending pull requests if this helps.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
