Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B1494036BE
	for <lists+linux-pwm@lfdr.de>; Wed,  8 Sep 2021 11:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351356AbhIHJSq (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 8 Sep 2021 05:18:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351327AbhIHJSq (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 8 Sep 2021 05:18:46 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C97D4C061575
        for <linux-pwm@vger.kernel.org>; Wed,  8 Sep 2021 02:17:38 -0700 (PDT)
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mNti4-0002ko-Kl; Wed, 08 Sep 2021 11:17:36 +0200
Received: from ukl by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mNti3-00020W-RH; Wed, 08 Sep 2021 11:17:35 +0200
Date:   Wed, 8 Sep 2021 11:17:35 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     zhaoxiao <long870912@gmail.com>
Cc:     thierry.reding@gmail.com, lee.jones@linaro.org,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pwm: ab8500: Don't check the return code of
 pwmchip_remove()
Message-ID: <20210908091735.yxyr7wqpbyirkw73@pengutronix.de>
References: <20210908060200.7876-1-long870912@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210908060200.7876-1-long870912@gmail.com>
User-Agent: NeoMutt/20180716
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello zhaoxiao,

On Wed, Sep 08, 2021 at 02:02:00PM +0800, zhaoxiao wrote:
> pwmchip_remove() returns always 0. Don't use the value to make it
> possible to eventually change the function to return void. Also the
> driver core ignores the return value of ab8500_pwm_remove()
> and considers the device removed anyhow. So returning early results
> in a resource leak.
> 
> Signed-off-by: zhaoxiao <long870912@gmail.com>

Can you please base your patches on top of linux-next? This patch is
invalid in the presence of 
https://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git/commit/?h=for-next&id=14ac9e17f9bd4bd0dfe18e384a3c2ca8dfbffcc8

So this is waste of your (and my) time :-\

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
