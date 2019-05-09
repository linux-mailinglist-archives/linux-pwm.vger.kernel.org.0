Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27396191F1
	for <lists+linux-pwm@lfdr.de>; Thu,  9 May 2019 21:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728193AbfEITCS (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 9 May 2019 15:02:18 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:49391 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727694AbfEITCR (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 9 May 2019 15:02:17 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1hOoJ6-0000bo-Dh; Thu, 09 May 2019 21:02:16 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1hOoJ5-0007OZ-U8; Thu, 09 May 2019 21:02:15 +0200
Date:   Thu, 9 May 2019 21:02:15 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH 2/2] pwm: samsung: don't uses devm-functions in .request
Message-ID: <20190509190215.74oj4orkntnpqfws@pengutronix.de>
References: <20190325094934.10221-1-u.kleine-koenig@pengutronix.de>
 <20190325094934.10221-2-u.kleine-koenig@pengutronix.de>
 <20190509152214.GF8907@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190509152214.GF8907@ulmo>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, May 09, 2019 at 05:22:14PM +0200, Thierry Reding wrote:
> On Mon, Mar 25, 2019 at 10:49:34AM +0100, Uwe Kleine-König wrote:
> > A call to .request() is always paired by a call to .free() before a given
> > device is disposed. So the simplification that usually is possible when
> > using devm-functions cannot be used here. So use plain kzalloc() and
> > kfree() for improved runtime behaviour and reduced memory footprint.
> > 
> > Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> > ---
> >  drivers/pwm/pwm-samsung.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> Applied, and dropped the chip->dev parameter while at it to make this
> actually build.

Huh, thanks for that. I'm surprised I didn't notice that myself.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
