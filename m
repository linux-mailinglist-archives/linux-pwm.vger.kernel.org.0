Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6988B18BE07
	for <lists+linux-pwm@lfdr.de>; Thu, 19 Mar 2020 18:31:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbgCSRbQ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 19 Mar 2020 13:31:16 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:60521 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727434AbgCSRbQ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 19 Mar 2020 13:31:16 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1jEz0K-0003KX-8i; Thu, 19 Mar 2020 18:30:48 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1jEz0H-0003li-AB; Thu, 19 Mar 2020 18:30:45 +0100
Date:   Thu, 19 Mar 2020 18:30:45 +0100
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
Message-ID: <20200319173045.ystpijvwtyvil2vq@pengutronix.de>
References: <20200317123231.2843297-1-oleksandr.suvorov@toradex.com>
 <20200317123231.2843297-2-oleksandr.suvorov@toradex.com>
 <20200317174043.GA1464607@ulmo>
 <20200317210042.ryrof3amr7fxp4w5@pengutronix.de>
 <20200318225953.GA2874972@ulmo>
 <20200319065039.szhh5dm6v3ejwijd@pengutronix.de>
 <20200319163700.GA3354541@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200319163700.GA3354541@ulmo>
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

On Thu, Mar 19, 2020 at 05:37:00PM +0100, Thierry Reding wrote:
> On Thu, Mar 19, 2020 at 07:50:39AM +0100, Uwe Kleine-König wrote:
> > On Wed, Mar 18, 2020 at 11:59:53PM +0100, Thierry Reding wrote:
> > > On Tue, Mar 17, 2020 at 10:00:42PM +0100, Uwe Kleine-König wrote:
> > > > Having said this I think (independent of the question if "inversed"
> > > > exists) using two similar terms for the same thing just results in
> > > > confusion. I hit that in the past already and I like it being addressed.
> > > 
> > > I don't know. It's pretty common to use different words for the same
> > > thing. They're called synonyms.
> > 
> > In literature yes, I agree. In a novel it is annoying to repeat the same
> > words over and over again and some variation is good. In programming
> > however the goal is a different one. There the goal should be to be
> > precise and consistent.
> 
> We also need to make sure that things don't break.

And I'm entirely on your side here.

> It's a very bad idea to have a macro with the same name as an enum
> value for reasons I stated before. I think that's the most important
> thing here.

You might have missed it, but that's OK for me, too. And note that after
applying the whole series the enum is gone and so the problem. (First
hunk of include/linux/pwm.h in patch 5.)

> Also, if inversed is a synonym of inverted, we don't loose any precision
> at all.

grep doesn't know about synonyms, so if I grep for stuff about inverted
PWMs in the kernel I completely miss one half as it's called inversed
there. (Yeah sure, I can also grep for "inversed|inverted", but therefor
I have to know first that both are used interchangable here.)

That's a bit like a schematic that has "RESET#" in one place and
"nRESET" in an other. If you stumble about that you wonder if they are
two different names for the same signal or if they are actually two
different ones.

Have you ever read a specification that described some property, gave it
a name and then later used a synonym to describe it? In my eyes that's a
bad idea.

> All you have to remember is that you're dealing with a device
> tree constant in one case and an API enumeration in the other.

Everything you need to remember (or learn) about a subsystem makes it
harder work with it.
 
> So I think the current form is actually more precise, though I guess it
> could be confusing if you don't care about the difference.

If there is a technical need to have different names that's one thing.
But using synonyms to differentiate them is not optimal. Then please
let's have names where looking at the identifier makes it obvious which
is for the device trees and which for the API enum.

> > > > > And as you noted in the cover letter, there's a conflict between the
> > > > > macro defined in dt-bindings/pwm/pwm.txt. If they end up being included
> > > > > in the wrong order you'll get a compile error.
> > > > 
> > > > There are also other symbols that exist twice (GPIO_ACTIVE_HIGH was the
> > > > first to come to my mind). I'm not aware of any problems related to
> > > > these. What am I missing?
> > > 
> > > There's currently no problem, obviously. But if for some reason the
> > > include files end up being included in a different order (i.e. the
> > > dt-bindings header is included before linux/pwm.h) then the macro will
> > > be evaluated and result in something like:
> > > 
> > > 	enum pwm_polarity {
> > > 		PWM_POLARITY_NORMAL,
> > > 		1,
> > > 	};
> > > 
> > > and that's not valid C, so will cause a build error.
> > 
> > I admit I didn't look closely here and I assume you are right. If I
> > understand Oleksandr right this is only an intermediate step and when
> > the series is applied completely this issue is gone. Still it might be
> > worth to improve the series here.
> 
> 	$ gcc -o /dev/null -x c - <<- EOF
> 	>     #define PWM_POLARITY_INVERTED (1 << 0)
> 	>
> 	>     enum pwm_polarity {
> 	>         PWM_POLARITY_NORMAL,
> 	>         PWM_POLARITY_INVERTED,
> 	>     };
> 	> EOF
> 	<stdin>:1:35: error: expected identifier before ‘(’ token
> 	<stdin>:5:9: note: in expansion of macro ‘PWM_POLARITY_INVERTED’
> 
> Q.E.D.

I don't understand why you proved something here. I didn't doubt this.

> > My original question was about similar problems with GPIO_ACTIVE_HIGH.
> > Are you aware of problems there?
> 
> The problem exists there equally. We're probably not running into it
> because drivers don't end up including dt-bindings/gpio/gpio.h and
> include/linux/gpio/machine.h at the same time. Or they end up always
> including them in the right order.

Oh, that's worse than I expected. There are two .c files that include
dt-bindings/gpio/gpio.h:

	drivers/rtc/rtc-omap.c
	drivers/tty/serial/omap-serial.c

So the definition isn't even used in the gpio core to parse dt-stuff.
(And both files don't use any definition of that file :-|)

> For PWM the situation is slightly more complicated because we only have
> one header for the kernel API, so the likelihood of including it along
> with the dt-bindings header is increased compared to GPIO.

If a consumer or provider includes the dt-bindings file there is
something fishy. (Still catching this with a compiler message better
than "expected identifier before ‘(’ token" would be good.)
 
> > > > > Note that DT bindings are an ABI and can
> > > > > never change, whereas the enum pwm_polarity is part of a Linux internal
> > > > > API and doesn't have the same restrictions as an ABI.
> > > > 
> > > > I thought only binary device trees (dtb) are supposed to be ABI.
> > > 
> > > Yes, the DTB is the ABI. dt-bindings/pwm/pwm.h is used to generate DTBs,
> > > which basically makes it ABI as well.
> > 
> > We disagree here. With this argument you could fix quite some things as
> > ABI.
> 
> I don't understand what you're trying to say.

I don't want to follow your argument that dt-bindings/pwm/pwm.h is ABI
as well. device tree binaries follow an ABI (similar to machine code),
but the compiler and the source code (including headers) are not.

> > > Yes, the symbol name may not be part of the ABI, but changing the
> > > symbol becomes very inconvenient because everyone that depends on it
> > > would have to change.
> > 
> > Oleksandr adapted all in-tree users, so it only affects out-of-tree
> > users. In my book this is fine.
> 
> There used to be a time when it was assumed that eventually device tree
> sources would live outside of the kernel tree. Given that they are a HW
> description, they really ought not to be relying on the Linux kernel
> tree as a way of keeping them consistent. That's really only out of
> convenience.

The other way round however is fine, isn't it? So use the dt definition
in the kernel should be ok.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
