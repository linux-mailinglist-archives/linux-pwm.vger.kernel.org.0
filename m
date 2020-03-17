Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0950A188FF2
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Mar 2020 22:01:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbgCQVBZ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 17 Mar 2020 17:01:25 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:46209 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726549AbgCQVBZ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 17 Mar 2020 17:01:25 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1jEJKW-00039f-Bg; Tue, 17 Mar 2020 22:00:52 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1jEJKM-0003eU-V8; Tue, 17 Mar 2020 22:00:42 +0100
Date:   Tue, 17 Mar 2020 22:00:42 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Oleksandr Suvorov <oleksandr.suvorov@toradex.com>,
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
        Tony Prisk <linux@prisktech.co.nz>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-rockchip@lists.infradead.org
Subject: Re: [RFC PATCH 1/7] pwm: rename the PWM_POLARITY_INVERSED enum
Message-ID: <20200317210042.ryrof3amr7fxp4w5@pengutronix.de>
References: <20200317123231.2843297-1-oleksandr.suvorov@toradex.com>
 <20200317123231.2843297-2-oleksandr.suvorov@toradex.com>
 <20200317174043.GA1464607@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200317174043.GA1464607@ulmo>
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

On Tue, Mar 17, 2020 at 06:40:43PM +0100, Thierry Reding wrote:
> On Tue, Mar 17, 2020 at 02:32:25PM +0200, Oleksandr Suvorov wrote:
> > The polarity enum definition PWM_POLARITY_INVERSED is misspelled.
> > Rename it to PWM_POLARITY_INVERTED.
> 
> It isn't misspelled. "inversed" is a synonym for "inverted". Both
> spellings are correct.

Some time ago I stumbled about "inversed", too. My spell checker doesn't
know it and I checked some dictionaries and none of them knew that word:

https://www.lexico.com/search?utf8=%E2%9C%93&filter=dictionary&dictionary=en&query=inversed
https://de.pons.com/%C3%BCbersetzung/englisch-deutsch/inversed
https://dictionary.cambridge.org/spellcheck/english-german/?q=inversed

https://en.wiktionary.org/wiki/inverse#Verb mentions "inverse" as a verb
having "inversed" as past participle.

Having said this I think (independent of the question if "inversed"
exists) using two similar terms for the same thing just results in
confusion. I hit that in the past already and I like it being addressed.

> And as you noted in the cover letter, there's a conflict between the
> macro defined in dt-bindings/pwm/pwm.txt. If they end up being included
> in the wrong order you'll get a compile error.

There are also other symbols that exist twice (GPIO_ACTIVE_HIGH was the
first to come to my mind). I'm not aware of any problems related to
these. What am I missing?
 
> The enum was named this way on purpose to make it separate from the
> definition for the DT bindings.

Then please let's make it different by picking a different prefix or
something like that.

> Note that DT bindings are an ABI and can
> never change, whereas the enum pwm_polarity is part of a Linux internal
> API and doesn't have the same restrictions as an ABI.

I thought only binary device trees (dtb) are supposed to be ABI.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
