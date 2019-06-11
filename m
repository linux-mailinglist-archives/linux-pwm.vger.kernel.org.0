Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58FB83D10C
	for <lists+linux-pwm@lfdr.de>; Tue, 11 Jun 2019 17:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405165AbfFKPha (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 11 Jun 2019 11:37:30 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:47757 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405160AbfFKPha (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 11 Jun 2019 11:37:30 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1haipw-000382-M3; Tue, 11 Jun 2019 17:37:24 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1haipw-0004sA-4S; Tue, 11 Jun 2019 17:37:24 +0200
Date:   Tue, 11 Jun 2019 17:37:24 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-amlogic@lists.infradead.org, linux-pwm@vger.kernel.org,
        thierry.reding@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>, kernel@pengutronix.de
Subject: Re: [PATCH v2 02/14] pwm: meson: use devm_clk_get_optional() to get
 the input clock
Message-ID: <20190611153724.fg34zp6vof7lpcgl@pengutronix.de>
References: <20190608180626.30589-1-martin.blumenstingl@googlemail.com>
 <20190608180626.30589-3-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190608180626.30589-3-martin.blumenstingl@googlemail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Sat, Jun 08, 2019 at 08:06:14PM +0200, Martin Blumenstingl wrote:
> Simplify the code which fetches the input clock for a PWM channel by
> using devm_clk_get_optional().
> This comes with a small functional change: previously all errors except
> EPROBE_DEFER were ignored. Now all other errors are also treated as
> errors. If no input clock is present devm_clk_get_optional() will return
> NULL instead of an error which matches the behavior of the old code.
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>

Nitpick: Put your S-o-b last. Otherwise this ends as

	Sgned-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
	Rviewed-by: Neil Armstrong <narmstrong@baylibre.com>
	Sgned-off-by: Thierry Reding <thierry.reding@gmail.com>

and this implies that Thierry added Neil's tag.  (Typos are done on
purpose to not confuse patchwork.)

Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
