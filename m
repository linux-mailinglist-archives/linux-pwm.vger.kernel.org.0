Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6FB6333BD6
	for <lists+linux-pwm@lfdr.de>; Wed, 10 Mar 2021 12:54:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbhCJLyS (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 10 Mar 2021 06:54:18 -0500
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:43943 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbhCJLyN (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 10 Mar 2021 06:54:13 -0500
X-Originating-IP: 90.65.108.55
Received: from localhost (lfbn-lyo-1-1676-55.w90-65.abo.wanadoo.fr [90.65.108.55])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 4A89660009;
        Wed, 10 Mar 2021 11:54:08 +0000 (UTC)
Date:   Wed, 10 Mar 2021 12:54:08 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>,
        Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>, linux-rtc@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Daniel Palmer <daniel@0x0f.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Andreas Kemnade <andreas@kemnade.info>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-pwm@vger.kernel.org, Stephan Gerhold <stephan@gerhold.net>,
        allen <allen.chen@ite.com.tw>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Josua Mayer <josua.mayer@jm0.eu>,
        Shawn Guo <shawnguo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [GIT PULL] Immutable branch between MFD, PWM and RTC due for the
 v5.13 merge window
Message-ID: <YEizYHPnzyLad6Yi@piout.net>
References: <20210124214127.3631530-1-j.neuschaefer@gmx.net>
 <20210301102826.GK641347@dell>
 <20210309200520.GA4931@dell>
 <20210310113959.dnokjrt7dos43fx6@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210310113959.dnokjrt7dos43fx6@pengutronix.de>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 10/03/2021 12:39:59+0100, Uwe Kleine-König wrote:
> Hello Lee,
> 
> On Tue, Mar 09, 2021 at 08:05:20PM +0000, Lee Jones wrote:
> > On Mon, 01 Mar 2021, Lee Jones wrote:
> > 
> > > The following changes since commit fe07bfda2fb9cdef8a4d4008a409bb02f35f1bd8:
> > > 
> > >   Linux 5.12-rc1 (2021-02-28 16:05:19 -0800)
> > > 
> > > are available in the Git repository at:
> > > 
> > >   git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd-pwm-rtc-v5.13
> > > 
> > > for you to fetch changes up to 80629611215d1c5d52ed3cf723fd6d24a5872504:
> > > 
> > >   MAINTAINERS: Add entry for Netronix embedded controller (2021-03-01 10:26:17 +0000)
> > > 
> > > ----------------------------------------------------------------
> > > Immutable branch between MFD, PWM and RTC due for the v5.13 merge window
> > > 
> > > ----------------------------------------------------------------
> > > [...]
> > 
> > FYI, if anyone has pulled this, they should probably rebase it onto
> > v5.12-rc2 and delete the v5.12-rc1 tag from their tree:
> > 
> >   https://lwn.net/Articles/848431/
> 
> I'm not directly affected, but I wonder: The idea of an immutable branch
> is that the same history gets included in different trees. If now each
> maintainer rebases individually the result isn't the same
> history any more in each tree which somewhat defeats the idea of using
> immutable branches.
> 
> IMHO there are two ways forward: Either someone (Lee again?) creates a
> new pull request for this series rebased on -rc2; or we accept that
> these few patches are based on -rc1. For the latter it would be
> beneficial to merge the tag into a tree that is already based on -rc2.
> 

The solution is simply for the maintainers merging the immutable branch
to do that in a branch based on -rc2. Eg. I've rebased rtc-next on -rc2
(fast forward, I didn't have any patch). I can now merge this branch if
necessary, problem solved. If you can't rebased, nothing prevents you
from merging -rc2 in any branch.


-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
