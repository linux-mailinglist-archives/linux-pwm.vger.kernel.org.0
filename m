Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A10317EB1E
	for <lists+linux-pwm@lfdr.de>; Mon,  9 Mar 2020 22:23:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbgCIVXc (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 9 Mar 2020 17:23:32 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:42921 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbgCIVXc (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 9 Mar 2020 17:23:32 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1jBPs2-0003GI-H4; Mon, 09 Mar 2020 22:23:30 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1jBPs1-0008L4-4q; Mon, 09 Mar 2020 22:23:29 +0100
Date:   Mon, 9 Mar 2020 22:23:29 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Philippe Schenker <philippe.schenker@toradex.com>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "pbarker@konsulko.com" <pbarker@konsulko.com>,
        "pantelis.antoniou@konsulko.com" <pantelis.antoniou@konsulko.com>,
        "laurent.pinchart+renesas@ideasonboard.com" 
        <laurent.pinchart+renesas@ideasonboard.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "matt.ranostay@konsulko.com" <matt.ranostay@konsulko.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>
Subject: Re: [PATCH] dts: imx6: Allow flags argument in pwms reference
Message-ID: <20200309212329.j5y7j7s46fjjscv3@pengutronix.de>
References: <20200309145558.16098-1-pbarker@konsulko.com>
 <d1c950a83d3aa0520df696033bb0a038e2de1f66.camel@toradex.com>
 <20200309170751.vzffq5gmsaw3tsbp@pengutronix.de>
 <20200309173506.GA4916@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200309173506.GA4916@pendragon.ideasonboard.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, Mar 09, 2020 at 07:35:06PM +0200, Laurent Pinchart wrote:
> On Mon, Mar 09, 2020 at 06:07:51PM +0100, Uwe Kleine-König wrote:
> > On Mon, Mar 09, 2020 at 04:45:05PM +0000, Philippe Schenker wrote:
> > > On Mon, 2020-03-09 at 14:55 +0000, Paul Barker wrote:
> > >> diff --git a/arch/arm/boot/dts/imx6dl-aristainetos_4.dts
> > >> b/arch/arm/boot/dts/imx6dl-aristainetos_4.dts
> > >> index 37f80ab8ccd0..f87ac95b70bc 100644
> > >> --- a/arch/arm/boot/dts/imx6dl-aristainetos_4.dts
> > >> +++ b/arch/arm/boot/dts/imx6dl-aristainetos_4.dts
> > >> @@ -14,7 +14,7 @@
> > >>  
> > >>  	backlight {
> > >>  		compatible = "pwm-backlight";
> > >> -		pwms = <&pwm1 0 5000000>;
> > >> +		pwms = <&pwm1 0 5000000 0>;
> > > 
> > > There is a header file existing that has PWM_POLARITY_INVERTED defined
> > > in include/dt-bindings/pwm/pwm.h. I feel we should add there a
> > > PWM_POLARITY_NORMAL instead of just using 0.
> > 
> > ack.
> > 
> > > But then I'm asking myself if we can't get rid of the file include/dt-
> > > bindings/pwm/pwm.h and instead use include/linux/pwm.h everywhere.
> > > 
> > > Or shouldn't we use defines in devicetrees from there?
> > 
> > devicetrees are supposed to be stand-alone. So yes indeed, no linux
> > includes in device tree files.
> 
> Correct. I don't mind adding PWM_POLARITY_NORMAL to
> include/dt-bindings/pwm/pwm.h, I think it would increase readability.

+1 from me. Who cares enough to come up with a patch?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
