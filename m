Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E63A16689F
	for <lists+linux-pwm@lfdr.de>; Thu, 20 Feb 2020 21:42:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728688AbgBTUme (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 20 Feb 2020 15:42:34 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:52129 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728582AbgBTUme (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 20 Feb 2020 15:42:34 -0500
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1j4se0-000106-Uk; Thu, 20 Feb 2020 21:42:00 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1j4sds-0001Ks-T6; Thu, 20 Feb 2020 21:41:52 +0100
Date:   Thu, 20 Feb 2020 21:41:52 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Yangtao Li <tiny.windzz@gmail.com>, thierry.reding@gmail.com
Cc:     claudiu.beznea@microchip.com, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, ludovic.desroches@microchip.com,
        rjui@broadcom.com, sbranden@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com, f.fainelli@gmail.com,
        nsaenzjulienne@suse.de, shc_work@mail.ru, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, vz@mleia.com, slemieux.tyco@gmail.com,
        khilman@baylibre.com, matthias.bgg@gmail.com, heiko@sntech.de,
        palmer@dabbelt.com, paul.walmsley@sifive.com, mripard@kernel.org,
        wens@csie.org, jonathanh@nvidia.com, linux@prisktech.co.nz,
        linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH 30/32] pwm: hibvt: do some cleanup
Message-ID: <20200220204152.p6rublsssifvvnvk@pengutronix.de>
References: <20191229080610.7597-1-tiny.windzz@gmail.com>
 <20191229080610.7597-30-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191229080610.7597-30-tiny.windzz@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Sun, Dec 29, 2019 at 08:06:08AM +0000, Yangtao Li wrote:
> Use devm_platform_ioremap_resource() to simplify code.
> 'i' and 'ret' are variables of the same type and there is no
> need to use two lines.

I think I wouldn't have merged these two lines, but I don't feel strong
here. The other 31 patches are clean replacements.

But I also don't think respining just for this minor thing is worth the
effort, so:

Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

for the whole series. (Not sure it is sensible to ack each patch
individually, @Thierry, tell me if this simplifies things for you.)

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
