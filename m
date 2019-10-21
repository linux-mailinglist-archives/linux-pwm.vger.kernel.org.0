Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37EC7DEAAA
	for <lists+linux-pwm@lfdr.de>; Mon, 21 Oct 2019 13:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727620AbfJULSt (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 21 Oct 2019 07:18:49 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:60701 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727433AbfJULSt (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 21 Oct 2019 07:18:49 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1iMVi4-0006Xk-73; Mon, 21 Oct 2019 13:18:48 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1iMVi3-0007OG-Ti; Mon, 21 Oct 2019 13:18:47 +0200
Date:   Mon, 21 Oct 2019 13:18:47 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH] Revert "pwm: Let pwm_get_state() return the last
 implemented state"
Message-ID: <20191021111847.c5j4qycyqy5wmynh@pengutronix.de>
References: <20191021105830.1357795-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191021105830.1357795-1-thierry.reding@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, Oct 21, 2019 at 12:58:30PM +0200, Thierry Reding wrote:
> It turns out that commit 01ccf903edd6 ("pwm: Let pwm_get_state() return
> the last implemented state") causes backlight failures on a number of
> boards. The reason is that some of the drivers do not write the full
> state through to the hardware registers, which means that ->get_state()
> subsequently does not return the correct state. Consumers which rely on
> pwm_get_state() returning the current state will therefore get confused
> and subsequently try to program a bad state.
> 
> Before this change can be made, existing drivers need to be more
> carefully audited and fixed to behave as the framework expects. Until
> then, keep the original behaviour of returning the software state that
> was applied rather than reading the state back from hardware.

I would really prefer to fix that in the framework instead. This is
something that affects several drivers (cros-ec, imx27, atmel, imx-tpm,
lpss, meson, sifive, sprd and stm32-lp). This is im my eyes really
sufficient to justify a framework wide solution instead of adapting
several drivers in a way that doesn't affect the values programmed to
hardware.

> Signed-off-by: Thierry Reding <thierry.reding@gmail.com>

Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Thanks
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
