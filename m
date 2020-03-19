Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C11418AD24
	for <lists+linux-pwm@lfdr.de>; Thu, 19 Mar 2020 08:05:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727142AbgCSHFS (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 19 Mar 2020 03:05:18 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:53431 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbgCSHFR (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 19 Mar 2020 03:05:17 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1jEpEt-0006xW-F2; Thu, 19 Mar 2020 08:05:11 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1jEpEs-0003lY-Ej; Thu, 19 Mar 2020 08:05:10 +0100
Date:   Thu, 19 Mar 2020 08:05:10 +0100
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
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/7] dt-bindings: pwm: document the PWM polarity flag
Message-ID: <20200319070510.gc6hr53gn7n2osvb@pengutronix.de>
References: <20200317123231.2843297-1-oleksandr.suvorov@toradex.com>
 <20200317123231.2843297-3-oleksandr.suvorov@toradex.com>
 <20200317174344.GB1464607@ulmo>
 <20200317213056.futfiwn4qgr2njye@pengutronix.de>
 <20200318230539.GB2874972@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200318230539.GB2874972@ulmo>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, Mar 19, 2020 at 12:05:39AM +0100, Thierry Reding wrote:
> On Tue, Mar 17, 2020 at 10:30:56PM +0100, Uwe Kleine-König wrote:
> > Hello Thierry,
> > 
> > On Tue, Mar 17, 2020 at 06:43:44PM +0100, Thierry Reding wrote:
> > > On Tue, Mar 17, 2020 at 02:32:26PM +0200, Oleksandr Suvorov wrote:
> > > > Add the description of PWM_POLARITY_NORMAL flag.
> > > > 
> > > > Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
> > > > ---
> > > > 
> > > >  Documentation/devicetree/bindings/pwm/pwm.txt | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/pwm/pwm.txt b/Documentation/devicetree/bindings/pwm/pwm.txt
> > > > index 084886bd721e..440c6b9a6a4e 100644
> > > > --- a/Documentation/devicetree/bindings/pwm/pwm.txt
> > > > +++ b/Documentation/devicetree/bindings/pwm/pwm.txt
> > > > @@ -46,6 +46,7 @@ period in nanoseconds.
> > > >  Optionally, the pwm-specifier can encode a number of flags (defined in
> > > >  <dt-bindings/pwm/pwm.h>) in a third cell:
> > > >  - PWM_POLARITY_INVERTED: invert the PWM signal polarity
> > > > +- PWM_POLARITY_NORMAL: don't invert the PWM signal polarity
> > > 
> > > This doesn't make sense. PWM_POLARITY_NORMAL is not part of the DT ABI.
> > 
> > "is not part of the DT ABI" is hardly a good reason. If it's sensible to
> > be used, it is sensible to define it.
> 
> That's exactly it. It's not sensible at all to use it.

If you think the argument is "It is not sensible to be used." then please
say so and don't add "PWM_POLARITY_NORMAL is not part of the DT ABI."
which seems to be irrelevant now.

> If you define it here it means people are allowed to do stuff like
> this:
> 
> 	pwms = <&pwm 1234 PWM_POLARITY_INVERTED | PWM_POLARITY_NORMAL>;
> 
> which doesn't make sense.

I would hope that a human reader would catch this.

> What's more, it impossible for the code to even notice that you're
> being silly because | PWM_POLARITY_NORMAL is just | 0 and that's just
> a nop.

I think this argument is a bad one. Whenever you introduce a
function or symbol you can use it in a wrong way. With this argument you
can also say GPIO_ACTIVE_LOW doesn't make sense because

	pwms = <&pwm 1234 GPIO_ACTIVE_LOW>;

is silly.

Keep well and fit,
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
