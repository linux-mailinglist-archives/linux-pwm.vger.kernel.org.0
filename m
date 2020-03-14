Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0E8D1857AC
	for <lists+linux-pwm@lfdr.de>; Sun, 15 Mar 2020 02:45:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbgCOBpe (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 14 Mar 2020 21:45:34 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:46827 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726628AbgCOBpe (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 14 Mar 2020 21:45:34 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1jDEZQ-0002vd-NZ; Sat, 14 Mar 2020 22:43:48 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1jDEZP-0005Xp-Oz; Sat, 14 Mar 2020 22:43:47 +0100
Date:   Sat, 14 Mar 2020 22:43:47 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>, kernel@pengutronix.de
Subject: Re: [PATCH] pwm: meson: Fix confusing indentation
Message-ID: <20200314214347.dun6ith5zamaa3m6@pengutronix.de>
References: <20200314113524.23031-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200314113524.23031-1-krzk@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Sat, Mar 14, 2020 at 12:35:24PM +0100, Krzysztof Kozlowski wrote:
> Fix indentation of return block.  Smatch warning:
>     drivers/pwm/pwm-meson.c:139 meson_pwm_request() warn: inconsistent indenting
> 
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

This exists since commit 211ed630753d ("pwm: Add support for Meson PWM
Controller") in 2016. Added Neil to Cc:.

Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Thanks
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
