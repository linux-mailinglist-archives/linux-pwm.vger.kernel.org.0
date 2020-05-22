Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 126071DE7D2
	for <lists+linux-pwm@lfdr.de>; Fri, 22 May 2020 15:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729623AbgEVNPP (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 22 May 2020 09:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729334AbgEVNPO (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 22 May 2020 09:15:14 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 800BCC061A0E
        for <linux-pwm@vger.kernel.org>; Fri, 22 May 2020 06:15:14 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1jc7W5-0003kK-2k; Fri, 22 May 2020 15:15:13 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1jc7W4-0008Vd-Hf; Fri, 22 May 2020 15:15:12 +0200
Date:   Fri, 22 May 2020 15:15:12 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: Re: Missing feedback
Message-ID: <20200522131512.44pzss7ujsp2wbgw@pengutronix.de>
References: <20200522101355.x4td3ehkfhp636ft@pengutronix.de>
 <20200522114635.GB2163848@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200522114635.GB2163848@ulmo>
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

On Fri, May 22, 2020 at 01:46:35PM +0200, Thierry Reding wrote:
> Like I said, I'm open to let you take on a more central role eventually,
> but I'm going to need a bit more time to convince myself that you will
> be doing a better job than I.

I'm also unsure that I can do better than you (and additionally that I
can be better in your subjective view given that we don't agree on every
aspect). Also note I don't want to replace you, for some questions I
don't feel competent to judge. My goal is just to widen the bottle neck.

As a sensible step I think getting my hands on patchwork and cleanup up
there would be a good thing. This would help me seeing what is actually
still open and also help other interested parties to see the current
situation.

I agree that working with patchwork is tedious, but as soon as there is
not only a single person who can keep everything in main memory some
form of such a coordination is useful and important.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
