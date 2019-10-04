Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C963CC3EC
	for <lists+linux-pwm@lfdr.de>; Fri,  4 Oct 2019 22:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730981AbfJDUIL (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 4 Oct 2019 16:08:11 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:39487 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729079AbfJDUIL (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 4 Oct 2019 16:08:11 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1iGTs1-0001TG-Br; Fri, 04 Oct 2019 22:08:09 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1iGTrw-0008EY-Kb; Fri, 04 Oct 2019 22:08:04 +0200
Date:   Fri, 4 Oct 2019 22:08:04 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Benjamin GAIGNARD <benjamin.gaignard@st.com>
Cc:     Yizhuo <yzhai003@ucr.edu>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Fabrice GASNIER <fabrice.gasnier@st.com>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Mark Brown <broonie@kernel.org>
Subject: Re: [Linux-stm32] [PATCH] pwm: stm32: Fix the usage of uninitialized
 variable in stm32_pwm_config()
Message-ID: <20191004200804.ee6kedadchxoznnd@pengutronix.de>
References: <20191004044649.2405-1-yzhai003@ucr.edu>
 <20191004062336.jidzrytx4z5talro@pengutronix.de>
 <e6824330-d331-798d-0f0a-1952db028900@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e6824330-d331-798d-0f0a-1952db028900@st.com>
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

Cc += Mark Brown who maintains regmap

On Fri, Oct 04, 2019 at 09:09:51AM +0000, Benjamin GAIGNARD wrote:
> 
> On 10/4/19 8:23 AM, Uwe Kleine-König wrote:
> > Hello,
> >
> > On Thu, Oct 03, 2019 at 09:46:49PM -0700, Yizhuo wrote:
> >> Inside function stm32_pwm_config(), variable "psc" and " arr"
> >> could be uninitialized if regmap_read() returns -EINVALs.
> >> However, they are used later in the if statement to decide
> >> the return value which is potentially unsafe.
> 
> Hi Yizhuo,
> 
> like for the your patch in IIO trigger regmap_read could only failed
> if the hardware block is no more clocked and in this case we won't 
> return of regmap_read.

I'm not sure this is aligned with how regmap is supposed to be used. I
think the driver making use of regmap is not supposed to make any
assumptions about how and when a read or write access can or cannot fail
and instead is supposed to check all return values. So IMHO the patch
goes in the right direction.

> Testing regmap_read() return value just add code but doesn't provide a 
> valid information.
> If you really want to log all the possible errors cases please do it in 
> regmap code itself and
> not in *all* the drivers.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
