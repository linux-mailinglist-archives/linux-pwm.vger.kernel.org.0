Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7AA3832394
	for <lists+linux-pwm@lfdr.de>; Sun,  2 Jun 2019 16:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbfFBOfT (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 2 Jun 2019 10:35:19 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:57995 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbfFBOfT (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 2 Jun 2019 10:35:19 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1hXRZq-0003S4-Bv; Sun, 02 Jun 2019 16:35:14 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1hXRZn-0005ZF-GW; Sun, 02 Jun 2019 16:35:11 +0200
Date:   Sun, 2 Jun 2019 16:35:11 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Sean Young <sean@mess.org>, Eric Anholt <eric@anholt.net>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-pwm@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Andreas Christ <andreas@christ-faesch.ch>,
        kernel@pengutronix.de
Subject: Re: [PATCH] pwm: bcm2835: increase precision of pwm
Message-ID: <20190602143511.o777ozvxuh5xey7o@pengutronix.de>
References: <20190602102350.zzwmfvlky3mnlqln@gofer.mess.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190602102350.zzwmfvlky3mnlqln@gofer.mess.org>
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

On Sun, Jun 02, 2019 at 11:23:50AM +0100, Sean Young wrote:
> If sending IR with carrier of 455kHz using the pwm-ir-tx driver, the
> carrier ends up being 476kHz.
> 
> A carrier of 455kHz has a period of 2198ns, but the arithmetic truncates
> this to 2.1ns rather than 2.2ns. So, use DIV_ROUND_CLOSEST() to reduce
> rounding errors, and we have a much more accurate carrier of 454.5kHz.

can we please fix the rules how to round such that not every driver
invents its own measurement of what is best?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
