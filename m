Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C23D8CFF6
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Aug 2019 11:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726047AbfHNJqP (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 14 Aug 2019 05:46:15 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:59755 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725265AbfHNJqP (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 14 Aug 2019 05:46:15 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1hxpr8-0004OO-DB; Wed, 14 Aug 2019 11:46:10 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1hxpr7-0005BZ-BS; Wed, 14 Aug 2019 11:46:09 +0200
Date:   Wed, 14 Aug 2019 11:46:09 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-pwm@vger.kernel.org, DTML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, kernel@pengutronix.de
Subject: Re: [PATCH v2 1/2] dt-bindings: pwm: sprd: Add Spreadtrum PWM
 documentation
Message-ID: <20190814094609.pm7ulg57e37pphrs@pengutronix.de>
References: <f9d2c7cb01cbf31bf75c4160611fa1d37d99f355.1565703607.git.baolin.wang@linaro.org>
 <20190813141256.jnbrfld42rtigek3@pengutronix.de>
 <CAMz4kuJA+a=nzFRja4wRkfJu3Gzb0wnvaM8H4Ek9X5u8CNegPg@mail.gmail.com>
 <20190814070121.o53tj2mtky4hcy3n@pengutronix.de>
 <CAMz4ku+55O6ORVM9xDv4R954QG4PXV8EkcGypSTB5wKni+Dq+Q@mail.gmail.com>
 <20190814073939.ubgzysmkmmel5h4y@pengutronix.de>
 <CAMz4ku+Q7CV+0dP1P0hAPJR7KiG0HOkZbT_LPXY4Q03hMuvS8A@mail.gmail.com>
 <20190814084929.q3uy7cpf4ullpevo@pengutronix.de>
 <CAMz4kuLFeg2OyzgxZLp4Ks5ucTptOBTrxod5yVFXQ+q8ttKjcw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMz4kuLFeg2OyzgxZLp4Ks5ucTptOBTrxod5yVFXQ+q8ttKjcw@mail.gmail.com>
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

On Wed, Aug 14, 2019 at 05:33:25PM +0800, Baolin Wang wrote:
> On Wed, 14 Aug 2019 at 16:49, Uwe Kleine-K�nig
> <u.kleine-koenig@pengutronix.de> wrote:
> > On Wed, Aug 14, 2019 at 03:52:08PM +0800, Baolin Wang wrote:
> > > On 14/08/2019, Uwe Kleine-K�nig <u.kleine-koenig@pengutronix.de> wrote:
> > > > On Wed, Aug 14, 2019 at 03:25:53PM +0800, Baolin Wang wrote:
> > > >> On Wed, 14 Aug 2019 at 15:01, Uwe Kleine-K�nig
> > > >> <u.kleine-koenig@pengutronix.de> wrote:
> > > >> > On Wed, Aug 14, 2019 at 09:51:34AM +0800, Baolin Wang wrote:
> > > >> > > On Tue, 13 Aug 2019 at 22:13, Uwe Kleine-K�nig
> > > >> > > <u.kleine-koenig@pengutronix.de> wrote:
> > > >> > > > On Tue, Aug 13, 2019 at 09:46:40PM +0800, Baolin Wang wrote:
> > > >> > > > > +- assigned-clock-parents: The phandle of the parent clock of PWM
> > > >> > > > > clock.
> > > >> > > >
> > > >> > > > I'm not sure you need to point out assigned-clocks and
> > > >> > > > assigned-clock-parents as this is general clk stuff. Also I wonder if
> > > >> > > > these should be "required properties".
> > > >> > >
> > > >> > > I think I should describe any properties used by PWM node, like
> > > >> > > 'clocks' and 'clock-names' properties, though they are common clock
> > > >> > > properties.
> > > >> >
> > > >> > Then you might want to describe also "status", "assigned-clock-rates",
> > > >> > "pinctrl-$n", "pinctrl-names", "power-domains", "power-domain-names"
> > > >> > and
> > > >> > probably another dozen I'm not aware of.
> > > >>
> > > >> We usually do not describe 'status', but if your device node used
> > > >> "pinctrl-$n", "pinctrl-names" ... common properties, yes, you should
> > > >> describe them to let users know what is the purpose of these
> > > >> properties. That's also asked by DT maintainer Rob.
> > > >
> > > > Does this convince you that you should also describe "pinctrl-$n" and
> > > > the others? If not, why not? We also usually don't describe
> > >
> > > Our PWM device node did not use "pinctrl-$n" things, why I should
> > > describe "pinctrl-$n"?
> >
> > The binding you implemented supports "pinctrl-$n". And this is described
> > somewhere in the generic pinctrl binding docs. The same applies to
> > "assigned-clock-parents".
> >
> > That you happen to use assigned-clock-parents but not pinctrl-$n on the
> > board you used to develop your driver is a detail that IMHO shouldn't
> > decide about being listed in the binding doc for your PWM type.
> >
> > > If some devices use pinctrl, yes, they should describe what is the
> > > purpose of pinctrl, see:
> > > https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/Documentation/devicetree/bindings/mmc/sdhci-sprd.txt
> >
> > I agree that if the driver assumes special pinctrl names this is worth
> > mentioning. If however there is nothing special and just some generic
> > stuff is used that is described in some other location then I'd chose to
> > not add this redundant information to the binding document. So if I
> > reviewed the patch that created
> > Documentation/devicetree/bindings/mmc/sdhci-sprd.txt I would have
> > suggested to drop "assigned-clocks" and "assigned-clock-parents" there,
> > too.
> >
> > > > assigned-clock-parents. For me these are all in the same catagory:
> > >
> > > Lots of dt bindings describe 'assigned-clock-parents',:
> > > ./Documentation/devicetree/bindings/display/msm/dsi.txt
> > > ./Documentation/devicetree/bindings/display/msm/dsi.txt
> > > ./Documentation/devicetree/bindings/display/mediatek/mediatek,hdmi.txt
> > > ./Documentation/devicetree/bindings/rtc/st,stm32-rtc.txt
> > > ./Documentation/devicetree/bindings/rtc/st,stm32-rtc.txt
> > > ./Documentation/devicetree/bindings/rtc/st,stm32-rtc.txt
> > > ./Documentation/devicetree/bindings/pci/rockchip-pcie-host.txt
> > > ./Documentation/devicetree/bindings/sound/mt2701-afe-pcm.txt
> > > ./Documentation/devicetree/bindings/sound/brcm,cygnus-audio.txt
> > > ./Documentation/devicetree/bindings/sound/brcm,cygnus-audio.txt
> > > ......
> >
> > I didn't check each of them, but I assume the same applies here, too.
> > Please don't copy blindly but think before using other people's stuff as
> 
> I did not  copy blindly.

OK, there was no offence intended.

> > reference. Even in the Linux kernel where reviews seem and are told to
> > catch non-optimal stuff, there are places where this doesn't work. IMHO
> > the key question is: Does it add value to describe "assigned-clocks" in
> > the binding for your PWM device given that you're only using this
> > generic and well documented construct?
> 
> I just want to remind users that they should set the parent clock for
> PWMs, otherwise the PWM source clock can be not available.

Probably it is just subjective where to draw the line here. There are a
thousand and one things that can go wrong when the PWM should be used.
To me it seems artificial to pick one of these and mention it in a
document that is supposed to describe how to formalize such a device.

But given that we're going in cycles, I will stop trying to convince you
now.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K�nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
