Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A82C418B306
	for <lists+linux-pwm@lfdr.de>; Thu, 19 Mar 2020 13:10:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbgCSMK6 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 19 Mar 2020 08:10:58 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:43695 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726793AbgCSMK6 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 19 Mar 2020 08:10:58 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1jEu0L-0007Yc-KU; Thu, 19 Mar 2020 13:10:29 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1jEu0I-0006oX-6J; Thu, 19 Mar 2020 13:10:26 +0100
Date:   Thu, 19 Mar 2020 13:10:26 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
        Paul Barker <pbarker@konsulko.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Igor Opaniuk <igor.opaniuk@toradex.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Fabio Estevam <festevam@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Kevin Hilman <khilman@baylibre.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Maxime Ripard <mripard@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Ray Jui <rjui@broadcom.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Scott Branden <sbranden@broadcom.com>,
        Shawn Guo <shawnguo@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-rockchip@lists.infradead.org
Subject: Re: [RFC PATCH 1/7] pwm: rename the PWM_POLARITY_INVERSED enum
Message-ID: <20200319121026.3rzcxdknfyhtkryi@pengutronix.de>
References: <20200317123231.2843297-1-oleksandr.suvorov@toradex.com>
 <20200317123231.2843297-2-oleksandr.suvorov@toradex.com>
 <20200317174043.GA1464607@ulmo>
 <20200317210042.ryrof3amr7fxp4w5@pengutronix.de>
 <20200318225953.GA2874972@ulmo>
 <CAGgjyvGd4y8M0L1sFMvQ1=gPcKfUPoR13dVS7F5WZx=333KG6g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGgjyvGd4y8M0L1sFMvQ1=gPcKfUPoR13dVS7F5WZx=333KG6g@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello,

[dropping Tony Prisk <linux@prisktech.co.nz> from recipients]

On Thu, Mar 19, 2020 at 01:40:28PM +0200, Oleksandr Suvorov wrote:
> Thierry, I see the PWM core converts the bit field "third cell" into
> the polarity variable.
> Now I probably understand your sight and agree that we shouldn't give
> the same names to bits in bitfield (dts) and values of a variable.
> 
> But there are lots of useless "0" values of third cell of "pwms"
> option in dts files.
> 
> I see 2 ways now:
> - just remove all "0" "third cell" from "pwms" options in dts files. I
> see this "0" confuses some people.

Then you have to overwrite pwm-cells of the provider. If there are two
PWMs used from the same provider and only one is inverted this won't
work. (Not entirely sure I understood your suggestion.) So I don't like
this suggestion.

And also in my eyes this isn't clearer, just more complicated to use.

> - convert pwm_state.polarity into pwm_state.flags and use bitfield
>   directly from dtb.
>   It simplifies the parsing logic and makes adding new flags easier.

*shrug*, I don't care much.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
