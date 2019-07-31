Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61BD07BAD0
	for <lists+linux-pwm@lfdr.de>; Wed, 31 Jul 2019 09:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbfGaHjP (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 31 Jul 2019 03:39:15 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:35285 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726888AbfGaHjP (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 31 Jul 2019 03:39:15 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1hsjCb-0001qz-9h; Wed, 31 Jul 2019 09:39:13 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1hsjCa-00075J-GH; Wed, 31 Jul 2019 09:39:12 +0200
Date:   Wed, 31 Jul 2019 09:39:12 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Stephen Boyd <swboyd@chromium.org>, linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH v6 36/57] pwm: Remove dev_err() usage after
 platform_get_irq()
Message-ID: <20190731073912.7wb4tb42572g35c6@pengutronix.de>
References: <20190730181557.90391-1-swboyd@chromium.org>
 <20190730181557.90391-37-swboyd@chromium.org>
 <20190731065853.3ohrhqtjtuhxfq5r@pengutronix.de>
 <20190731071301.GA23317@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190731071301.GA23317@kroah.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, Jul 31, 2019 at 09:13:01AM +0200, Greg Kroah-Hartman wrote:
> On Wed, Jul 31, 2019 at 08:58:53AM +0200, Uwe Kleine-König wrote:
> > On Tue, Jul 30, 2019 at 11:15:36AM -0700, Stephen Boyd wrote:
> > > We don't need dev_err() messages when platform_get_irq() fails now that
> > > platform_get_irq() prints an error message itself when something goes
> > > wrong. Let's remove these prints with a simple semantic patch.
> > 
> > Looking at v5.3-rc2 it's not obvious to me that all error paths of
> > platform_get_irq issue an error message. Do I miss something?
> 
> The commit is in my driver-core tree at the moment, so this should wait
> until 5.4-rc1.  I woudn't recommend merging it in 5.3-rc as it's not a
> bugfix.

As this is a new change pointing out its id in the commit log of the
follow up changes might be beneficial.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
