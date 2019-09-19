Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50DE2B783D
	for <lists+linux-pwm@lfdr.de>; Thu, 19 Sep 2019 13:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387693AbfISLLX (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 19 Sep 2019 07:11:23 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:38291 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387690AbfISLLX (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 19 Sep 2019 07:11:23 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1iAuLF-0001IP-5b; Thu, 19 Sep 2019 13:11:17 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1iAuLD-0002qQ-8O; Thu, 19 Sep 2019 13:11:15 +0200
Date:   Thu, 19 Sep 2019 13:11:15 +0200
From:   oUwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        David Wu <david.wu@rock-chips.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pwm: rockchip: simplify rockchip_pwm_get_state()
Message-ID: <20190919111115.5oraof2bdl4627xv@pengutronix.de>
References: <20190919091728.24756-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190919091728.24756-1-linux@rasmusvillemoes.dk>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, Sep 19, 2019 at 11:17:27AM +0200, Rasmus Villemoes wrote:
> The way state->enabled is computed is rather convoluted and hard to
> read - both branches of the if() actually do the exact same thing. So
> remove the if(), and further simplify "<boolean condition> ? true :
> false" to "<boolean condition>".
> 
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---
> I stumbled on this while trying to understand how the pwm subsystem
> works. This patch is a semantic no-op, but it's also possible that,
> say, the first branch simply contains a "double negative" so either
> the != should be == or the "false : true" should be "true : false".

The change looks obviously right, it's a noop.

I share your doubts however. The construct was introduced in commit 
831b2790507b ("pwm: rockchip: Use same PWM ops for each IP") by David
Wu.

Before there were rockchip_pwm_get_state_v1 for the supports_polarity =
false case and rockchip_pwm_get_state_v2 for supports_polarity = true.

In both state->enabled was assigned true if ((val & enable_conf) ==
enable_conf). So I assume everything is fine.

A confirmation by David would be great though.

As a side note: Is there publicly available documentation for this IP?
If a link were added to the driver's header we could check easily
ourselves.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
