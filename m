Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28406E2B39
	for <lists+linux-pwm@lfdr.de>; Thu, 24 Oct 2019 09:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408654AbfJXHgQ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 24 Oct 2019 03:36:16 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:35095 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727635AbfJXHgQ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 24 Oct 2019 03:36:16 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1iNXfJ-0004NC-Nm; Thu, 24 Oct 2019 09:36:13 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1iNXfD-0006fS-TZ; Thu, 24 Oct 2019 09:36:07 +0200
Date:   Thu, 24 Oct 2019 09:36:07 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Yendapally Reddy Dhananjaya Reddy 
        <yendapally.reddy@broadcom.com>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
Subject: Re: [PATCH] pwm: bcm-iproc: prevent unloading the driver module
 while in use
Message-ID: <20191024073607.fs33i2rztfjqmvfj@pengutronix.de>
References: <20191017192218.9042-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191017192218.9042-1-u.kleine-koenig@pengutronix.de>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello,

On Thu, Oct 17, 2019 at 09:22:18PM +0200, Uwe Kleine-König wrote:
> The owner member of struct pwm_ops must be set to THIS_MODULE to
> increase the reference count of the module such that the module cannot
> be removed while its code is in use.
> 
> Fixes: daa5abc41c80 ("pwm: Add support for Broadcom iProc PWM controller")
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Assuming you will send another PR to Linus for 5.4 with the revert of
01ccf903edd65f6421612321648fa5a7f4b7cb10 I suggest to add this patch,
too.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
