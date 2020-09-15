Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1235326A6C6
	for <lists+linux-pwm@lfdr.de>; Tue, 15 Sep 2020 16:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbgIOOGI (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 15 Sep 2020 10:06:08 -0400
Received: from smtp2.axis.com ([195.60.68.18]:65046 "EHLO smtp2.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726339AbgIOOFu (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 15 Sep 2020 10:05:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; l=1548; q=dns/txt; s=axis-central1;
  t=1600178749; x=1631714749;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CIoW8RV31m/+63QYI41vckbTL6oVbVgAaZMjvOnFW6w=;
  b=ZioeXPVUTl/h9PC+14pTGSLYxI1o+Ful7eUUs388WWF+Z0/Cw6MLasBg
   VajtoX89YBL48hn5MOjvXIWTGqRCzYGwSSILX82cHQ3bIPrNWXZ7PO2AX
   59th3qRdaEwtlZyfrvOUkVtFfkFupNud0nZp70/1oZYlQ96S33PJX0uzw
   09+rtwGsJulYp3ltB4LZtrUfjXk/msTAQRKeCbhVmkw+xGbK1GCsoBWje
   53oBoFmbDIWtMD8SZssBTCRjpyRLCeLsW8h3W9LG+emtiv8I372nYAbOk
   GWVa/KKEqlwaFdtmq5SMh1eXrijg/9ocq6dBhUjcC1zT7Fiyd6c2Pyqad
   A==;
IronPort-SDR: WD9wdm5am+yBY+LYYXBIo78iPXaZ3KlNq7sKmlkuHBBxotj1Ex78IpCJku15f/RJwU86GIqdog
 8NKxOxela/8KPV1tXwrFmKOSKyI0o37IaeKgjZPPr+qn5vqOuOqtU/k6/uC/yzfpJ5enhYBzAJ
 AXpj4uGPYmYYnTOZAM8ZqRSqONiI6p59NZN3bpalaCV8MrrjVB833jlKvbJGExnEbNHRRzg1+S
 v5gt1Bc5DbwrtznvmFrLjdStLtoyziPkHwivoWhKXP7vlpnsFjaT+KkC9kB4/e/Dc+/15243kW
 ZPQ=
X-IronPort-AV: E=Sophos;i="5.76,430,1592863200"; 
   d="scan'208";a="12508311"
Date:   Tue, 15 Sep 2020 16:02:08 +0200
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     Olliver Schinagl <oliver@schinagl.nl>
CC:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        kernel <kernel@axis.com>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Subject: Re: [PATCH 2/2] pwm: Add GPIO PWM driver
Message-ID: <20200915140208.bzserxn2bgw4xiwk@axis.com>
References: <20200814155513.31936-1-vincent.whitchurch@axis.com>
 <20200814155513.31936-2-vincent.whitchurch@axis.com>
 <703362fe-1454-c16e-180a-76bfc4e3ab3f@schinagl.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <703362fe-1454-c16e-180a-76bfc4e3ab3f@schinagl.nl>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, Sep 03, 2020 at 11:15:31AM +0200, Olliver Schinagl wrote:
> On 14-08-2020 17:55, Vincent Whitchurch wrote:
> > Add a software PWM which toggles a GPIO from a high-resolution timer.
> > 
> > This will naturally not be as accurate or as efficient as a hardware
> > PWM, but it is useful in some cases.  I have for example used it for
> > evaluating LED brightness handling (via leds-pwm) on a board where the
> > LED was just hooked up to a GPIO, and for a simple verification of the
> > timer frequency on another platform.
> > 
> > Since high-resolution timers are used, sleeping gpio chips are not
> > supported and are rejected in the probe function.
> > 
> > Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
> > ---
> > While preparing this driver for posting, I found a pwm-gpio driver posted to
> > the lists way back in 2015 by Olliver Schinagl:
> > 
> >   https://lore.kernel.org/linux-pwm/1445895161-2317-8-git-send-email-o.schinagl@ultimaker.com/
> > 
> Thanks for reminding me there :) As I think I still use this driver, I 
> don't mind migrating to this one (if merged) but how do you suggests to 
> proceed with regards to multiple PWM's, as this is how I am using it 
> currently. E.g. how do we merge them? I'm fine with 'taking the simpler 
> code method' for a start point, but i guess I solved that part 
> (somewhat) in 2015 :p

Since this is just a software construct, the simplest way would just be
to create multiple instances in the device tree if you want multiple
PWMs, wouldn't it?
