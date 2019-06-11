Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8836C3D0CF
	for <lists+linux-pwm@lfdr.de>; Tue, 11 Jun 2019 17:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404826AbfFKPaC (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 11 Jun 2019 11:30:02 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:46419 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387864AbfFKPaB (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 11 Jun 2019 11:30:01 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1haiii-0001yg-GW; Tue, 11 Jun 2019 17:29:56 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1haiif-0004aA-9m; Tue, 11 Jun 2019 17:29:53 +0200
Date:   Tue, 11 Jun 2019 17:29:53 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-amlogic@lists.infradead.org, linux-pwm@vger.kernel.org,
        thierry.reding@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH v2 01/14] pwm: meson: unify the parameter list of
 meson_pwm_{enable,disable}
Message-ID: <20190611152953.5pitafag62dhk6vu@pengutronix.de>
References: <20190608180626.30589-1-martin.blumenstingl@googlemail.com>
 <20190608180626.30589-2-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190608180626.30589-2-martin.blumenstingl@googlemail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello Martin,

On Sat, Jun 08, 2019 at 08:06:13PM +0200, Martin Blumenstingl wrote:
> This is a preparation for a future cleanup. Pass struct pwm_device
> instead of passing the individual values required by each function as
> these can be obtained for each struct pwm_device instance.
> 
> As a nice side-effect the driver now uses "switch (pwm->hwpwm)"
> everywhere. Before some functions used "switch (id)" while others used
> "switch (pwm->hwpwm)".
> 
> No functional changes.
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
