Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9398170200
	for <lists+linux-pwm@lfdr.de>; Wed, 26 Feb 2020 16:10:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbgBZPKg (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 26 Feb 2020 10:10:36 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:60929 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727108AbgBZPKg (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 26 Feb 2020 10:10:36 -0500
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1j6yKY-0004aS-Th; Wed, 26 Feb 2020 16:10:34 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1j6yKY-0007AG-J5; Wed, 26 Feb 2020 16:10:34 +0100
Date:   Wed, 26 Feb 2020 16:10:34 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc:     thierry.reding@gmail.com, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] pwm: pca9685: remove unused duty_cycle struct element
Message-ID: <20200226151034.7i3h5blmrwre2yzg@pengutronix.de>
References: <20200226135229.24929-1-matthias.schiffer@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200226135229.24929-1-matthias.schiffer@ew.tq-group.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello Matthias,

as you seem to have this hardware on your desk, it would be great if you
could answer the following questions:

 - Does the hardware complete the currently running period before
   applying a new setting?
 - Is this racy somehow (i.e. can it happen that when going from
   duty_cycle/period = 1000/5000 to duty_cycle/period = 4000/10000 the
   output is 1000/10000 (or 4000/5000) for one cycle)?
 - Does the hardware complete the currently running period before
   .enabled = false is configured?
 - How does the output pin behave on a disabled PWM. (Usual candidates
   are: freeze where is just happens to be, constant inactive and
   High-Z).

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
