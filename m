Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B3B085CDB
	for <lists+linux-pwm@lfdr.de>; Thu,  8 Aug 2019 10:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732119AbfHHI2g (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 8 Aug 2019 04:28:36 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:38571 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731844AbfHHI2f (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 8 Aug 2019 04:28:35 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1hvdmh-0001lV-Co; Thu, 08 Aug 2019 10:28:31 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1hvdmf-00027y-3C; Thu, 08 Aug 2019 10:28:29 +0200
Date:   Thu, 8 Aug 2019 10:28:29 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Rob Herring <robh@kernel.org>
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>, od@zcrc.me,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/6] dt-bindings: Remove unused compatible strings
Message-ID: <20190808082829.i6enaout5ozvdnwj@pengutronix.de>
References: <20190607154410.10633-1-paul@crapouillou.net>
 <20190607154410.10633-2-paul@crapouillou.net>
 <20190709020425.GA7984@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190709020425.GA7984@bogus>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, Jul 08, 2019 at 08:04:25PM -0600, Rob Herring wrote:
> On Fri, Jun 07, 2019 at 05:44:05PM +0200, Paul Cercueil wrote:
> > Right now none of the Ingenic-based boards probe this driver from
> > devicetree. This driver defined three compatible strings for the exact
> > same behaviour. Before these strings are used, we can remove two of
> > them.
> > 
> > Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> > ---
> > 
> > Notes:
> >     v2: Rebase on v5.2-rc3
> > 
> >  Documentation/devicetree/bindings/pwm/ingenic,jz47xx-pwm.txt | 5 +----
> >  1 file changed, 1 insertion(+), 4 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/pwm/ingenic,jz47xx-pwm.txt b/Documentation/devicetree/bindings/pwm/ingenic,jz47xx-pwm.txt
> > index 7d9d3f90641b..493bec80d59b 100644
> > --- a/Documentation/devicetree/bindings/pwm/ingenic,jz47xx-pwm.txt
> > +++ b/Documentation/devicetree/bindings/pwm/ingenic,jz47xx-pwm.txt
> > @@ -2,10 +2,7 @@ Ingenic JZ47xx PWM Controller
> >  =============================
> >  
> >  Required properties:
> > -- compatible: One of:
> > -  * "ingenic,jz4740-pwm"
> > -  * "ingenic,jz4770-pwm"
> > -  * "ingenic,jz4780-pwm"
> > +- compatible: Should be "ingenic,jz4740-pwm"
> 
> Are you sure all 3 chips are exactly the same features and bugs?
> 
> The correct thing to do here generally is the 4770 and 4780 would also 
> have ingenic,jz4740-pwm as a fallback compatible. Then the driver can 
> match on that until you find some difference and can use the more 
> specific compatible.

Note that Thierry already applied this patch before your concern reached
the mailing list. Is this bad enough to revert
925488e8df4f396ad96ff008a84f5b14d8b73347?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
