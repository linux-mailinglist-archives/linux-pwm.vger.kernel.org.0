Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 312E9A5B0F
	for <lists+linux-pwm@lfdr.de>; Mon,  2 Sep 2019 18:04:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726027AbfIBQEz (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 2 Sep 2019 12:04:55 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:55807 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbfIBQEz (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 2 Sep 2019 12:04:55 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1i4oow-0001oT-VY; Mon, 02 Sep 2019 18:04:46 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1i4oov-0002kp-AO; Mon, 02 Sep 2019 18:04:45 +0200
Date:   Mon, 2 Sep 2019 18:04:45 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Rob Herring <robh@kernel.org>
Cc:     Sam Shih <sam.shih@mediatek.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        John Crispin <john@phrozen.org>, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v5 07/13] dt-bindings: pwm: add a property "num-pwms"
Message-ID: <20190902160445.fitoa65t4ndzjq6v@pengutronix.de>
References: <1566457123-20791-1-git-send-email-sam.shih@mediatek.com>
 <1566457123-20791-8-git-send-email-sam.shih@mediatek.com>
 <20190827183924.GA24178@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190827183924.GA24178@bogus>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, Aug 27, 2019 at 01:39:24PM -0500, Rob Herring wrote:
> On Thu, Aug 22, 2019 at 02:58:37PM +0800, Sam Shih wrote:
> > From: Ryder Lee <ryder.lee@mediatek.com>
> 
> The subject should indicate this is for Mediatek.
> 
> > 
> > This adds a property "num-pwms" in example so that we could
> > specify the number of PWM channels via device tree.
> > 
> > Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> > Signed-off-by: Sam Shih <sam.shih@mediatek.com>
> > Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
> > Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> > ---
> > Changes since v5:
> > - Add an Acked-by tag
> > - This file is original v4 patch 5/10
> > (https://patchwork.kernel.org/patch/11102577/)
> > 
> > Change-Id: I429048afeffa96f3f14533910efe242f88776043
> > ---
> >  Documentation/devicetree/bindings/pwm/pwm-mediatek.txt | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt b/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
> > index 991728cb46cb..ea95b490a913 100644
> > --- a/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
> > +++ b/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
> > @@ -14,12 +14,12 @@ Required properties:
> >                  has no clocks
> >     - "top": the top clock generator
> >     - "main": clock used by the PWM core
> > -   - "pwm1-8": the eight per PWM clocks for mt2712
> > -   - "pwm1-6": the six per PWM clocks for mt7622
> > -   - "pwm1-5": the five per PWM clocks for mt7623
> > +   - "pwm1-N": the PWM clocks for each channel
> > +   where N starting from 1 to the maximum number of PWM channels
> 
> Once converted to schema, you are going to be back to listing them out.
> 
> >   - pinctrl-names: Must contain a "default" entry.
> >   - pinctrl-0: One property must exist for each entry in pinctrl-names.
> >     See pinctrl/pinctrl-bindings.txt for details of the property values.
> > + - num-pwms: the number of PWM channels.
> 
> You can't add new required properties without breaking compatibility. 
> 
> You already have to imply the number of channels from the compatible (or 
> number of clocks) and you have to keep doing so to maintain 
> compatibility, so why not just keep doing that for new chips?

This was a suggestion by me. The driver still handles compatibility
(i.e. falls back to the number of PWMs that was implied by the
compatible before). Given that there are various drivers that all solve
the same problem (i.e. different variants with different number of PWMs)
I thought it would be a good idea to introduce a property in the device
tree that specifies this number.

Only for newly introduced compatibles the num-pwms property is really
required. Differentiating the ones that need it and the ones that don't
seems over-engineered to me.

(BTW, using the number of clks doesn't really work because there are
also some variants without clocks. It is still under discussion if in
this case dummy-clocks should be provided IIRC.)

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
