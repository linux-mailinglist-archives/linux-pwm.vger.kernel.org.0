Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A91951DEE4E
	for <lists+linux-pwm@lfdr.de>; Fri, 22 May 2020 19:33:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730700AbgEVRde (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 22 May 2020 13:33:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730636AbgEVRde (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 22 May 2020 13:33:34 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F3F8C061A0E
        for <linux-pwm@vger.kernel.org>; Fri, 22 May 2020 10:33:34 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1jcBY5-0005Vz-3d; Fri, 22 May 2020 19:33:33 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1jcBY4-0000Xm-PX; Fri, 22 May 2020 19:33:32 +0200
Date:   Fri, 22 May 2020 19:33:32 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: Re: Missing feedback
Message-ID: <20200522173332.isq7vl4knmcmw7rq@pengutronix.de>
References: <20200522101355.x4td3ehkfhp636ft@pengutronix.de>
 <20200522114635.GB2163848@ulmo>
 <20200522131512.44pzss7ujsp2wbgw@pengutronix.de>
 <20200522152133.GA2377357@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200522152133.GA2377357@ulmo>
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

On Fri, May 22, 2020 at 05:21:33PM +0200, Thierry Reding wrote:
> On Fri, May 22, 2020 at 03:15:12PM +0200, Uwe Kleine-König wrote:
> > I agree that working with patchwork is tedious, but as soon as there is
> > not only a single person who can keep everything in main memory some
> > form of such a coordination is useful and important.
> 
> Okay, let's start there then. Do you have an account on
> patchwork.ozlabs.org? If so, let me know and I can get the admins to add
> you as maintainer to the project.

I'm ukleinek there.

> I do also have half-finished scripts somewhere to help with patchwork
> maintenance. It might be worth resurrecting them and see if they can be
> made more useful. One thing I've been meaning to add is some semi-
> automated way of marking patches as superseeded/changes-requested. Or
> automatically sending "Applied" replies and marking the patches
> "accepted".

I think for "accepted" mails it would be helpful to add the Message-Id
to the commit logs as it usual already for some subsystems. I have
"looking into b4 + public-inbox" somewhere on my todo list for that.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
