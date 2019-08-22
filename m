Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14FAA98F12
	for <lists+linux-pwm@lfdr.de>; Thu, 22 Aug 2019 11:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733109AbfHVJSO (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 22 Aug 2019 05:18:14 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:58717 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731601AbfHVJSO (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 22 Aug 2019 05:18:14 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1i0jER-0006yr-IT; Thu, 22 Aug 2019 11:18:11 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1i0jEQ-0006Qz-IE; Thu, 22 Aug 2019 11:18:10 +0200
Date:   Thu, 22 Aug 2019 11:18:10 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Fabien Parent <fparent@baylibre.com>
Cc:     thierry.reding@gmail.com, robh+dt@kernel.org,
        matthias.bgg@gmail.com, mark.rutland@arm.com,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 2/2] pwm: pwm-mediatek: Add MT8516 SoC support
Message-ID: <20190822091810.5t3inn56npdvwnfy@pengutronix.de>
References: <20190805125848.15751-1-fparent@baylibre.com>
 <20190805125848.15751-2-fparent@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190805125848.15751-2-fparent@baylibre.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, Aug 05, 2019 at 02:58:48PM +0200, Fabien Parent wrote:
> Add the compatible and the platform data to support PWM on the MT8516
> SoC.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>

Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

The change looks fine, there is however another series currently waiting
for application for this driver that conflicts with this one (I think).

Maybe it would be sensible to join your forces and produce a single
series without conflicts?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
