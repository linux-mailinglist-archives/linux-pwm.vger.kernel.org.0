Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D33518ACFF
	for <lists+linux-pwm@lfdr.de>; Thu, 19 Mar 2020 07:51:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbgCSGvM (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 19 Mar 2020 02:51:12 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:50645 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726982AbgCSGvM (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 19 Mar 2020 02:51:12 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1jEp0w-0005WC-FG; Thu, 19 Mar 2020 07:50:46 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1jEp0p-0002ri-RB; Thu, 19 Mar 2020 07:50:39 +0100
Date:   Thu, 19 Mar 2020 07:50:39 +0100
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
        bcm-kernel-feedback-list@broadcom.com,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-rockchip@lists.infradead.org
Subject: Re: [RFC PATCH 1/7] pwm: rename the PWM_POLARITY_INVERSED enum
Message-ID: <20200319065039.szhh5dm6v3ejwijd@pengutronix.de>
References: <20200317123231.2843297-1-oleksandr.suvorov@toradex.com>
 <20200317123231.2843297-2-oleksandr.suvorov@toradex.com>
 <20200317174043.GA1464607@ulmo>
 <20200317210042.ryrof3amr7fxp4w5@pengutronix.de>
 <20200318225953.GA2874972@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200318225953.GA2874972@ulmo>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


[Dropped Tony Prisk from recipients as the address bounces]

Hello,

On Wed, Mar 18, 2020 at 11:59:53PM +0100, Thierry Reding wrote:
> On Tue, Mar 17, 2020 at 10:00:42PM +0100, Uwe Kleine-König wrote:
> > Hello,
> > 
> > On Tue, Mar 17, 2020 at 06:40:43PM +0100, Thierry Reding wrote:
> > > On Tue, Mar 17, 2020 at 02:32:25PM +0200, Oleksandr Suvorov wrote:
> > > > The polarity enum definition PWM_POLARITY_INVERSED is misspelled.
> > > > Rename it to PWM_POLARITY_INVERTED.
> > > 
> > > It isn't misspelled. "inversed" is a synonym for "inverted". Both
> > > spellings are correct.
> > 
> > Some time ago I stumbled about "inversed", too. My spell checker doesn't
> > know it and I checked some dictionaries and none of them knew that word:
> > 
> > https://www.lexico.com/search?utf8=%E2%9C%93&filter=dictionary&dictionary=en&query=inversed
> > https://de.pons.com/%C3%BCbersetzung/englisch-deutsch/inversed
> > https://dictionary.cambridge.org/spellcheck/english-german/?q=inversed
> > 
> > https://en.wiktionary.org/wiki/inverse#Verb mentions "inverse" as a verb
> > having "inversed" as past participle.
> 
> Here are the first three results from a Google query:
> 
> 	https://www.yourdictionary.com/inversed

There is something fishy. In the Verb section it says indeed, that it is
the past participle and simple past of inverse. The entry for inverse
however only has sections that identify this word as adjective or noun;
not a verb.

> 	https://www.dictionary.com/browse/inversed

Not sure I'd count this as hint that inversed exists. The entry shown to
me under this URL is about "inverse" and it has

	verb (used with object), in·versed, in·vers·ing.
		? to invert.

Does this mean: "Did you mean invert instead?"

> 	https://en.wiktionary.org/wiki/inversed

Yeah, that's the one I found, too.

I still have the impression that "inversed" is in use because people
don't know better and understand the intended meaning. And this results
in leaking of this word into the references.

> > Having said this I think (independent of the question if "inversed"
> > exists) using two similar terms for the same thing just results in
> > confusion. I hit that in the past already and I like it being addressed.
> 
> I don't know. It's pretty common to use different words for the same
> thing. They're called synonyms.

In literature yes, I agree. In a novel it is annoying to repeat the same
words over and over again and some variation is good. In programming
however the goal is a different one. There the goal should be to be
precise and consistent.

> > > And as you noted in the cover letter, there's a conflict between the
> > > macro defined in dt-bindings/pwm/pwm.txt. If they end up being included
> > > in the wrong order you'll get a compile error.
> > 
> > There are also other symbols that exist twice (GPIO_ACTIVE_HIGH was the
> > first to come to my mind). I'm not aware of any problems related to
> > these. What am I missing?
> 
> There's currently no problem, obviously. But if for some reason the
> include files end up being included in a different order (i.e. the
> dt-bindings header is included before linux/pwm.h) then the macro will
> be evaluated and result in something like:
> 
> 	enum pwm_polarity {
> 		PWM_POLARITY_NORMAL,
> 		1,
> 	};
> 
> and that's not valid C, so will cause a build error.

I admit I didn't look closely here and I assume you are right. If I
understand Oleksandr right this is only an intermediate step and when
the series is applied completely this issue is gone. Still it might be
worth to improve the series here.

My original question was about similar problems with GPIO_ACTIVE_HIGH.
Are you aware of problems there?

> > > Note that DT bindings are an ABI and can
> > > never change, whereas the enum pwm_polarity is part of a Linux internal
> > > API and doesn't have the same restrictions as an ABI.
> > 
> > I thought only binary device trees (dtb) are supposed to be ABI.
> 
> Yes, the DTB is the ABI. dt-bindings/pwm/pwm.h is used to generate DTBs,
> which basically makes it ABI as well.

We disagree here. With this argument you could fix quite some things as
ABI.

> Yes, the symbol name may not be part of the ABI, but changing the
> symbol becomes very inconvenient because everyone that depends on it
> would have to change.

Oleksandr adapted all in-tree users, so it only affects out-of-tree
users. In my book this is fine.

> Why bother?

To make the API more precise and consistent. That's a good goal in my
eyes.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
