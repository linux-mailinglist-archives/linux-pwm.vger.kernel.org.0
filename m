Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB07371ACE
	for <lists+linux-pwm@lfdr.de>; Tue, 23 Jul 2019 16:51:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390759AbfGWOvG (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 23 Jul 2019 10:51:06 -0400
Received: from muru.com ([72.249.23.125]:55730 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388251AbfGWOvE (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 23 Jul 2019 10:51:04 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 82FC2808C;
        Tue, 23 Jul 2019 14:51:28 +0000 (UTC)
Date:   Tue, 23 Jul 2019 07:51:00 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     David Lechner <david@lechnology.com>
Cc:     linux-iio@vger.kernel.org, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH 3/4] ARM: dts: am33xx: Add nodes for eQEP
Message-ID: <20190723145100.GS5447@atomide.com>
References: <20190722154538.5314-1-david@lechnology.com>
 <20190722154538.5314-4-david@lechnology.com>
 <20190723084213.GR5447@atomide.com>
 <af21fd76-7123-b317-896b-bfe18d293325@lechnology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af21fd76-7123-b317-896b-bfe18d293325@lechnology.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

* David Lechner <david@lechnology.com> [190723 14:46]:
> On 7/23/19 3:42 AM, Tony Lindgren wrote:
> > * David Lechner <david@lechnology.com> [190722 15:46]:
> > > This adds new nodes for the Texas Instruments Enhanced Quadrature
> > > Encoder Pulse (eQEP) module in the PWM subsystem on AM33XX.
> > > 
> > > Signed-off-by: David Lechner <david@lechnology.com>
> > > ---
> > >   arch/arm/boot/dts/am33xx-l4.dtsi | 27 +++++++++++++++++++++++++++
> > >   1 file changed, 27 insertions(+)
> > > 
> > > diff --git a/arch/arm/boot/dts/am33xx-l4.dtsi b/arch/arm/boot/dts/am33xx-l4.dtsi
> > > index 3b1fb2ba4dff..7fdc2f61c553 100644
> > > --- a/arch/arm/boot/dts/am33xx-l4.dtsi
> > > +++ b/arch/arm/boot/dts/am33xx-l4.dtsi
> > > @@ -1908,6 +1908,15 @@
> > >   					status = "disabled";
> > >   				};
> > > +				eqep0: eqep@180 {
> > > +					compatible = "ti,am3352-eqep";
> > > +					reg = <0x180 0x80>;
> > > +					clocks = <&l4ls_gclk>;
> > > +					clock-names = "fck";
> > > +					interrupts = <79>;
> > > +					status = "disabled";
> > > +				};
> > > +
> > 
> > You probably no longer need to map any clocks here as this> is now a child of the interconnect target module managed
> > by ti-sysc driver. I have not checked but probably l4ls_gclk
> > is same as clocks = <&l4ls_clkctrl AM3_L4LS_EPWMSS0_CLKCTRL 0>
> > already managed by ti-sysc. If so, then just using runtime PM
> > calls in any of the child device drivers will keep it enabled.
> > 
> > If l4ls_gclk is a separate functional clock, then it still
> > needs to be managed by the child device driver directly.
> 
> The clock is included so that we can get the clock rate for
> the timing aspects of the eQEP, not for power management.
> 
> I chose to use the "fck" name to be consistent with the
> sibling EHRPWM and ECAP nodes that already have the same
> bindings for the same clock.

OK makes sense to me thanks.

Tony
