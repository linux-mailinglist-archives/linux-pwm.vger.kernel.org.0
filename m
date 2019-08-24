Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 273259BE6A
	for <lists+linux-pwm@lfdr.de>; Sat, 24 Aug 2019 17:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbfHXPOE (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 24 Aug 2019 11:14:04 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:35905 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727146AbfHXPOE (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 24 Aug 2019 11:14:04 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1i1Xjs-0006v0-Ki; Sat, 24 Aug 2019 17:14:00 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1i1Xjr-0003Vv-LF; Sat, 24 Aug 2019 17:13:59 +0200
Date:   Sat, 24 Aug 2019 17:13:59 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Stefan Wahren <wahrenst@gmx.net>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Eric Anholt <eric@anholt.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH V2 3/3] pwm: bcm2835: suppress error message during
 deferred probe
Message-ID: <20190824151359.p43543prfadjmudf@pengutronix.de>
References: <1566655788-24949-1-git-send-email-wahrenst@gmx.net>
 <1566655788-24949-4-git-send-email-wahrenst@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1566655788-24949-4-git-send-email-wahrenst@gmx.net>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Sat, Aug 24, 2019 at 04:09:48PM +0200, Stefan Wahren wrote:
> This suppresses error messages in case the PWM clock isn't ready yet.
> 
> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Thanks
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
