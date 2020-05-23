Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A9D61DFB17
	for <lists+linux-pwm@lfdr.de>; Sat, 23 May 2020 23:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387976AbgEWVFa (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 23 May 2020 17:05:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387965AbgEWVFa (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 23 May 2020 17:05:30 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BC1AC061A0E
        for <linux-pwm@vger.kernel.org>; Sat, 23 May 2020 14:05:30 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1jcbKh-0003p6-EQ; Sat, 23 May 2020 23:05:27 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1jcbKf-0004RG-G1; Sat, 23 May 2020 23:05:25 +0200
Date:   Sat, 23 May 2020 23:05:25 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     vineetha.g.jaya.kumaran@intel.com
Cc:     thierry.reding@gmail.com, robh+dt@kernel.org,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        wan.ahmad.zainie.wan.mohamad@intel.com, andriy.shevchenko@intel.com
Subject: Re: [PATCH 1/3] pwm: Add count attribute in sysfs for Intel Keem Bay
Message-ID: <20200523210525.5ciw3lyafbwr26qn@pengutronix.de>
References: <1589723560-5734-1-git-send-email-vineetha.g.jaya.kumaran@intel.com>
 <1589723560-5734-2-git-send-email-vineetha.g.jaya.kumaran@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1589723560-5734-2-git-send-email-vineetha.g.jaya.kumaran@intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Sun, May 17, 2020 at 09:52:38PM +0800, vineetha.g.jaya.kumaran@intel.com wrote:
> From: "Lai, Poey Seng" <poey.seng.lai@intel.com>
> 
> In Keem Bay, the number of repetitions for the period/waveform
> can be configured from userspace. This requires addition of a sysfs
> attribute to get/set the repetition count. Setting this value to 0
> will result in continuous repetition of the waveform until the
> channel is disabled or reconfigured.

There is nothing specific for Keem Bay in this patch, the only special
thing here is that this driver is the first implementor.

IMHO all drivers that don't support count should be changed to fail if
a count > 0 is passed and introducing support in the sysfs interface
should be a separate change.

Having said that I'm not convinced this is a good idea given that only
very few driver can support this interface. Also this needs
documentation, e.g. what is expected from .get_state().

You should also motivate what this functionality is used for in the
commit log and I'd prefer to see an in-tree user (apart from sysfs which
I don't count as such).

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
