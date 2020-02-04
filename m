Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 765C615161B
	for <lists+linux-pwm@lfdr.de>; Tue,  4 Feb 2020 07:47:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbgBDGrB (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 4 Feb 2020 01:47:01 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:53841 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbgBDGrA (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 4 Feb 2020 01:47:00 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1iyrz3-00065e-8W; Tue, 04 Feb 2020 07:46:53 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1iyrz1-000841-JM; Tue, 04 Feb 2020 07:46:51 +0100
Date:   Tue, 4 Feb 2020 07:46:51 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        "maintainer:BROADCOM BCM281XX/BCM11XXX/BCM216XX ARM ARCHITE..." 
        <bcm-kernel-feedback-list@broadcom.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Bart Tanghe <bart.tanghe@thomasmore.be>,
        Stephen Warren <swarren@wwwdotorg.org>,
        "open list:PWM SUBSYSTEM" <linux-pwm@vger.kernel.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] pwm: bcm2835: Dynamically allocate base
Message-ID: <20200204064651.jaxyftjj346xrdml@pengutronix.de>
References: <20200203213536.32226-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200203213536.32226-1-f.fainelli@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hallo Florian,

On Mon, Feb 03, 2020 at 01:35:35PM -0800, Florian Fainelli wrote:
> The newer 2711 and 7211 chips have two PWM controllers and failure to
> dynamically allocate the PWM base would prevent the second PWM
> controller instance being probed for succeeding with an -EEXIST error
> from alloc_pwms().
> 
> Fixes: e5a06dc5ac1f ("pwm: Add BCM2835 PWM driver")
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
