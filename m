Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B37317E5D6
	for <lists+linux-pwm@lfdr.de>; Mon,  9 Mar 2020 18:35:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727416AbgCIRfL (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 9 Mar 2020 13:35:11 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:58492 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727257AbgCIRfL (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 9 Mar 2020 13:35:11 -0400
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 742452D2;
        Mon,  9 Mar 2020 18:35:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1583775309;
        bh=cNUG21AIQuWguIWMaWR0YrR815lsN6eSpuJ61vHjccE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pwDX0z9my3G+PmEboLgi8ZHMgeZx+YHPn6ToJ92tqo7GblbmTlxQ5XwkaC4slZY7Q
         fdhVuJQ5X0ep91xIiGUiws73S9kb7cr/9O4Coxx9KbyvygVJBJul2oUekh/DIeuW+4
         1CzqNckNv3cg2jPv0X+BTwG0fBfsteONmWXYhysw=
Date:   Mon, 9 Mar 2020 19:35:06 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
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
Message-ID: <20200309173506.GA4916@pendragon.ideasonboard.com>
References: <20200309145558.16098-1-pbarker@konsulko.com>
 <d1c950a83d3aa0520df696033bb0a038e2de1f66.camel@toradex.com>
 <20200309170751.vzffq5gmsaw3tsbp@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200309170751.vzffq5gmsaw3tsbp@pengutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, Mar 09, 2020 at 06:07:51PM +0100, Uwe Kleine-König wrote:
> On Mon, Mar 09, 2020 at 04:45:05PM +0000, Philippe Schenker wrote:
> > On Mon, 2020-03-09 at 14:55 +0000, Paul Barker wrote:
> >> The pwm-imx27 driver supports a third argument in a pwms reference to
> >> provide flags. However #pwm-cells needs to be set to <3> in the pwm
> >> node
> >> so that these flags can be passed through to the driver. Once #pwm-
> >> cells
> >> is <3>, all pwms references need to use the 3-cell form.
> >> 
> >> Signed-off-by: Paul Barker <pbarker@konsulko.com>
> >> 
> >> Cc: Matt Ranostay <matt.ranostay@konsulko.com>
> >> Cc: Pantelis Antoniou <pantelis.antoniou@konsulko.com>
> >> Cc: Rob Herring robh+dt@kernel.org
> >> Cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> >> Cc: Thierry Reding <thierry.reding@gmail.com>
> >> Cc: Shawn Guo <shawnguo@kernel.org>
> >> ---
> >>  arch/arm/boot/dts/imx6dl-aristainetos_4.dts      |  2 +-
> >>  arch/arm/boot/dts/imx6dl-aristainetos_7.dts      |  2 +-
> >>  arch/arm/boot/dts/imx6dl-mamoj.dts               |  2 +-
> >>  arch/arm/boot/dts/imx6dl-yapp4-common.dtsi       |  1 -
> >>  arch/arm/boot/dts/imx6q-ba16.dtsi                |  2 +-
> >>  arch/arm/boot/dts/imx6q-display5.dtsi            |  1 -
> >>  arch/arm/boot/dts/imx6q-kp.dtsi                  |  4 ++--
> >>  arch/arm/boot/dts/imx6q-logicpd.dts              |  2 +-
> >>  arch/arm/boot/dts/imx6q-mccmon6.dts              |  1 -
> >>  arch/arm/boot/dts/imx6q-novena.dts               |  2 +-
> >>  arch/arm/boot/dts/imx6q-pistachio.dts            |  2 +-
> >>  arch/arm/boot/dts/imx6q-var-dt6customboard.dts   |  2 +-
> >>  arch/arm/boot/dts/imx6qdl-apalis.dtsi            |  2 +-
> >>  arch/arm/boot/dts/imx6qdl-apf6dev.dtsi           |  2 +-
> >>  arch/arm/boot/dts/imx6qdl-aristainetos2.dtsi     |  2 +-
> >>  arch/arm/boot/dts/imx6qdl-colibri.dtsi           |  2 +-
> >>  arch/arm/boot/dts/imx6qdl-cubox-i.dtsi           |  2 +-
> >>  arch/arm/boot/dts/imx6qdl-emcon.dtsi             |  6 +++---
> >>  arch/arm/boot/dts/imx6qdl-gw52xx.dtsi            |  2 +-
> >>  arch/arm/boot/dts/imx6qdl-gw53xx.dtsi            |  2 +-
> >>  arch/arm/boot/dts/imx6qdl-gw54xx.dtsi            |  2 +-
> >>  arch/arm/boot/dts/imx6qdl-gw560x.dtsi            |  2 +-
> >>  arch/arm/boot/dts/imx6qdl-gw5903.dtsi            |  2 +-
> >>  arch/arm/boot/dts/imx6qdl-gw5904.dtsi            |  2 +-
> >>  arch/arm/boot/dts/imx6qdl-icore.dtsi             |  2 +-
> >>  arch/arm/boot/dts/imx6qdl-kontron-samx6i.dtsi    |  2 +-
> >>  arch/arm/boot/dts/imx6qdl-nit6xlite.dtsi         |  4 ++--
> >>  arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi     |  6 +++---
> >>  arch/arm/boot/dts/imx6qdl-nitrogen6_som2.dtsi    |  4 ++--
> >>  arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi        |  4 ++--
> >>  arch/arm/boot/dts/imx6qdl-phytec-mira.dtsi       |  2 +-
> >>  arch/arm/boot/dts/imx6qdl-sabreauto.dtsi         |  2 +-
> >>  arch/arm/boot/dts/imx6qdl-sabrelite.dtsi         |  6 +++---
> >>  arch/arm/boot/dts/imx6qdl-sabresd.dtsi           |  2 +-
> >>  arch/arm/boot/dts/imx6qdl-savageboard.dtsi       |  2 +-
> >>  arch/arm/boot/dts/imx6qdl-tx6.dtsi               |  2 --
> >>  arch/arm/boot/dts/imx6qdl.dtsi                   |  8 ++++----
> >>  arch/arm/boot/dts/imx6sl-evk.dts                 |  2 +-
> >>  arch/arm/boot/dts/imx6sl.dtsi                    |  8 ++++----
> >>  arch/arm/boot/dts/imx6sll-evk.dts                |  2 +-
> >>  arch/arm/boot/dts/imx6sll.dtsi                   |  8 ++++----
> >>  arch/arm/boot/dts/imx6sx-nitrogen6sx.dts         |  2 +-
> >>  arch/arm/boot/dts/imx6sx-sdb.dtsi                |  2 +-
> >>  arch/arm/boot/dts/imx6sx-softing-vining-2000.dts |  6 +++---
> >>  arch/arm/boot/dts/imx6sx.dtsi                    | 16 ++++++++-------
> >> -
> >>  arch/arm/boot/dts/imx6ul-14x14-evk.dtsi          |  2 +-
> >>  arch/arm/boot/dts/imx6ul-ccimx6ulsbcpro.dts      |  2 +-
> >>  arch/arm/boot/dts/imx6ul-geam.dts                |  2 +-
> >>  arch/arm/boot/dts/imx6ul-imx6ull-opos6uldev.dtsi |  2 +-
> >>  arch/arm/boot/dts/imx6ul-isiot.dtsi              |  2 +-
> >>  arch/arm/boot/dts/imx6ul-kontron-n6310-s-43.dts  |  2 +-
> >>  arch/arm/boot/dts/imx6ul-kontron-n6x1x-s.dtsi    |  2 +-
> >>  arch/arm/boot/dts/imx6ul-pico.dtsi               |  2 +-
> >>  arch/arm/boot/dts/imx6ul-tx6ul.dtsi              |  1 -
> >>  arch/arm/boot/dts/imx6ul.dtsi                    | 16 ++++++++-------
> >> -
> >>  arch/arm/boot/dts/imx6ull-colibri.dtsi           |  4 ----
> >>  56 files changed, 85 insertions(+), 95 deletions(-)
> >> 
> >> diff --git a/arch/arm/boot/dts/imx6dl-aristainetos_4.dts
> >> b/arch/arm/boot/dts/imx6dl-aristainetos_4.dts
> >> index 37f80ab8ccd0..f87ac95b70bc 100644
> >> --- a/arch/arm/boot/dts/imx6dl-aristainetos_4.dts
> >> +++ b/arch/arm/boot/dts/imx6dl-aristainetos_4.dts
> >> @@ -14,7 +14,7 @@
> >>  
> >>  	backlight {
> >>  		compatible = "pwm-backlight";
> >> -		pwms = <&pwm1 0 5000000>;
> >> +		pwms = <&pwm1 0 5000000 0>;
> > 
> > There is a header file existing that has PWM_POLARITY_INVERTED defined
> > in include/dt-bindings/pwm/pwm.h. I feel we should add there a
> > PWM_POLARITY_NORMAL instead of just using 0.
> 
> ack.
> 
> > But then I'm asking myself if we can't get rid of the file include/dt-
> > bindings/pwm/pwm.h and instead use include/linux/pwm.h everywhere.
> > 
> > Or shouldn't we use defines in devicetrees from there?
> 
> devicetrees are supposed to be stand-alone. So yes indeed, no linux
> includes in device tree files.

Correct. I don't mind adding PWM_POLARITY_NORMAL to
include/dt-bindings/pwm/pwm.h, I think it would increase readability.

-- 
Regards,

Laurent Pinchart
