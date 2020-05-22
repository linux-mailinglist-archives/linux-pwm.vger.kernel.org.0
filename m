Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E2A51DE316
	for <lists+linux-pwm@lfdr.de>; Fri, 22 May 2020 11:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728424AbgEVJcj (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 22 May 2020 05:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728068AbgEVJcj (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 22 May 2020 05:32:39 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E539FC061A0E
        for <linux-pwm@vger.kernel.org>; Fri, 22 May 2020 02:32:38 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1jc42d-0004xj-09; Fri, 22 May 2020 11:32:35 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1jc42c-0000dW-0u; Fri, 22 May 2020 11:32:34 +0200
Date:   Fri, 22 May 2020 11:32:33 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     Rahul Tanwar <rahul.tanwar@linux.intel.com>,
        thierry.reding@gmail.com, p.zabel@pengutronix.de,
        linux-pwm@vger.kernel.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        songjun.Wu@intel.com, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com
Subject: Re: [PATCH v1 2/2] Add PWM driver for LGM
Message-ID: <20200522093233.yy3tcalveoutxcsj@pengutronix.de>
References: <cover.1590132733.git.rahul.tanwar@linux.intel.com>
 <3c1d2343b034325dbc185ccd23a35b40a62a4e7b.1590132733.git.rahul.tanwar@linux.intel.com>
 <20200522085613.ktb2ruw2virj337v@pengutronix.de>
 <20200522091824.GR1634618@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200522091824.GR1634618@smile.fi.intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello Andy,

On Fri, May 22, 2020 at 12:18:24PM +0300, Andy Shevchenko wrote:
> On Fri, May 22, 2020 at 10:56:13AM +0200, Uwe Kleine-König wrote:
> > On Fri, May 22, 2020 at 03:41:59PM +0800, Rahul Tanwar wrote:
> 
> > > +	io_base = devm_platform_ioremap_resource(pdev, 0);
> > > +	if (IS_ERR(io_base))
> > 
> > error message here?
> 
> platform core provides it. No need to duplicate (esp. taking into consideration
> that it can issue IIRC three different error messages depending on actual error).

Ah, missed that. Indeed that's fine as is in the patch.

Thanks
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
