Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D0574B2F7
	for <lists+linux-pwm@lfdr.de>; Wed, 19 Jun 2019 09:22:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725980AbfFSHW6 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 19 Jun 2019 03:22:58 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:59063 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbfFSHW6 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 19 Jun 2019 03:22:58 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1hdUvl-0005rp-Bq; Wed, 19 Jun 2019 09:22:53 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1hdUvj-00069o-GI; Wed, 19 Jun 2019 09:22:51 +0200
Date:   Wed, 19 Jun 2019 09:22:51 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Stefan Wahren <wahrenst@gmx.net>
Cc:     Sean Young <sean@mess.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Eric Anholt <eric@anholt.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-pwm@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Andreas Christ <andreas@christ-faesch.ch>
Subject: Re: [PATCH v2] pwm: bcm2835: improve precision of pwm
Message-ID: <20190619072251.vhncrs2cnmtudrsj@pengutronix.de>
References: <20190603090058.qd3tbiffmdgqm34d@gofer.mess.org>
 <1c7dc4ba-eb6e-b6da-3bfd-4b872f9c6498@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1c7dc4ba-eb6e-b6da-3bfd-4b872f9c6498@gmx.net>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hallo Stefan,

On Wed, Jun 19, 2019 at 07:21:43AM +0200, Stefan Wahren wrote:
> Am 03.06.19 um 11:00 schrieb Sean Young:
> > If sending IR with carrier of 455kHz using the pwm-ir-tx driver, the
> > carrier ends up being 476kHz. The clock is set to bcm2835-pwm with a
> > rate of 10MHz.
> >
> > A carrier of 455kHz has a period of 2198ns, but the arithmetic truncates
> > this to 2100ns rather than 2200ns. So, use DIV_ROUND_CLOSEST() to reduce
> > rounding errors, and we have a much more accurate carrier of 454.5kHz.
> >
> > Reported-by: Andreas Christ <andreas@christ-faesch.ch>
> > Signed-off-by: Sean Young <sean@mess.org>
> Acked-by: Stefan Wahren <wahrenst@gmx.de>

you already acked that with a slightly different mail address a week
ago. Was this intended?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
