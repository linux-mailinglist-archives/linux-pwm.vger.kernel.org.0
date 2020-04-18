Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2F401AEAD5
	for <lists+linux-pwm@lfdr.de>; Sat, 18 Apr 2020 10:23:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725887AbgDRIXS (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 18 Apr 2020 04:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbgDRIXR (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 18 Apr 2020 04:23:17 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8543CC061A0C
        for <linux-pwm@vger.kernel.org>; Sat, 18 Apr 2020 01:23:17 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1jPikf-0005Wz-ET; Sat, 18 Apr 2020 10:23:01 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1jPike-0006bn-RM; Sat, 18 Apr 2020 10:23:00 +0200
Date:   Sat, 18 Apr 2020 10:23:00 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Sandipan Patra <spatra@nvidia.com>
Cc:     Thierry Reding <treding@nvidia.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Bibek Basu <bbasu@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pwm: tegra: dynamic clk freq configuration by PWM driver
Message-ID: <20200418082300.mucrg2srysvvjbfn@pengutronix.de>
References: <1585917303-10573-1-git-send-email-spatra@nvidia.com>
 <20200403151050.nh2mrffkqdqtkozq@pengutronix.de>
 <BYAPR12MB3014C0178A7360662C6FA8B7ADDB0@BYAPR12MB3014.namprd12.prod.outlook.com>
 <20200415141856.ck3w3gtae4bsxyfl@pengutronix.de>
 <BYAPR12MB30149D2715DC575A030A7F59ADD90@BYAPR12MB3014.namprd12.prod.outlook.com>
 <20200417135027.wkj6bxiplnehsa5s@pengutronix.de>
 <BYAPR12MB3014041BFFC43AF5EB3BC27CADD90@BYAPR12MB3014.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BYAPR12MB3014041BFFC43AF5EB3BC27CADD90@BYAPR12MB3014.namprd12.prod.outlook.com>
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

On Fri, Apr 17, 2020 at 02:53:22PM +0000, Sandipan Patra wrote:
> > To put my expression in words: pick the maximum of the possible periods that
> > are less or equal to the requested value.  Maybe this is better
> > understandable:
> > 
> >         max { x ∊ implementablePeriods | x <= requestedPeriod }
> > 
> > ?
> 
> I think I got your question.
> Should tegra_pwm_config() not return error (EINVAL) when the requested period is
> invalid but it should configure to a nearest possible value?

If you cannot configure according to the above rule, yes, return an
error code. EINVAL is the usual one I think (some also return ERANGE).

> > > Yes, the output stops as soon as the PWM_ENABLE bit is cleared in
> > > hardware. Then The output is set to 0 (which is inactive).
> > > Once .disable() => tegra_pwm_disable() gets invoked, enable bit is
> > > cleared and hence PWM will possess no output signal.
> > > tegra_pwm_config() will be invoked for any new configuration request.
> > 
> > Some drivers already have a "Limitations" section in their header.
> > Please take a look at the existing examples and provide something similar. (Note
> > you still didn't answer "How does a running PWM behave when the register is
> > updated? Does it complete the currently running period?". I assume the answer
> > to the second question is "No" (and the first is only there for rhetoric reasons).)
> >
>  
> 1. I will add the below comments as Limitations:
> -	When PWM is disabled, the output is driven to 0 and

In fact, this is a good property. So the only problem is, that for both
stop and reconfiguration the currently running period isn't completed.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
