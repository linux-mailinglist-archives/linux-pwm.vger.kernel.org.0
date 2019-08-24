Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3E3B9B9C8
	for <lists+linux-pwm@lfdr.de>; Sat, 24 Aug 2019 02:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725917AbfHXAhH (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 23 Aug 2019 20:37:07 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:42367 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbfHXAhH (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 23 Aug 2019 20:37:07 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1i1K38-00066C-KH; Sat, 24 Aug 2019 02:36:58 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1i1K38-0000SH-4s; Sat, 24 Aug 2019 02:36:58 +0200
Date:   Sat, 24 Aug 2019 02:36:58 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Yingjoe Chen <yingjoe.chen@mediatek.com>
Cc:     Sam Shih <sam.shih@mediatek.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org, Ryder Lee <ryder.lee@mediatek.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, John Crispin <john@phrozen.org>
Subject: Re: [PATCH v5 08/13] dt-bindings: pwm: update bindings for MT7628 SoC
Message-ID: <20190824003658.66hisfvhkbkc3pub@pengutronix.de>
References: <1566457123-20791-1-git-send-email-sam.shih@mediatek.com>
 <1566457123-20791-9-git-send-email-sam.shih@mediatek.com>
 <1566461540.16302.4.camel@mtksdaap41>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1566461540.16302.4.camel@mtksdaap41>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, Aug 22, 2019 at 04:12:20PM +0800, Yingjoe Chen wrote:
> On Thu, 2019-08-22 at 14:58 +0800, Sam Shih wrote:
> > This updates bindings for MT7628 pwm controller.
> > 
> > Signed-off-by: Sam Shih <sam.shih@mediatek.com>
> > ---
> >  Documentation/devicetree/bindings/pwm/pwm-mediatek.txt | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt b/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
> > index ea95b490a913..93980e3da261 100644
> > --- a/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
> > +++ b/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
> > @@ -21,6 +21,10 @@ Required properties:
> >     See pinctrl/pinctrl-bindings.txt for details of the property values.
> >   - num-pwms: the number of PWM channels.
> > +
> > + Optional properties:
> > + - clock-frequency: fix clock frequency, this is only used in MT7628 SoC
> > +                    for period calculation. This SoC has no complex clock tree.
> 
> I'm sorry if this has been discussed before. 
> 
> Would it be simpler if you just provide a fixed-clock as clock in device
> tree? This way you don't need this optional properties and don't need to
> special handle it in driver code. 
> 
> After all, the hw is still connected to a simple clock tree.

This is what I just wrote in reply to patch 3 (which implements handling
the clock-frequency property) even before reading your feedback. So I
fully agree.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
