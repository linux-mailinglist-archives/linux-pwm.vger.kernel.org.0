Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84AD31DFAEE
	for <lists+linux-pwm@lfdr.de>; Sat, 23 May 2020 22:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387924AbgEWURk (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 23 May 2020 16:17:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387834AbgEWURk (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 23 May 2020 16:17:40 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DCABC061A0E
        for <linux-pwm@vger.kernel.org>; Sat, 23 May 2020 13:17:40 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1jcaaL-0000Jz-7t; Sat, 23 May 2020 22:17:33 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1jcaaI-0002gY-TY; Sat, 23 May 2020 22:17:30 +0200
Date:   Sat, 23 May 2020 22:17:30 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] pwm: pca9685: Remove set but not used variable
 'pwm'
Message-ID: <20200523201730.o7y7pent4hjtgia3@pengutronix.de>
References: <CAGngYiVDCCjo6VKt660Uz5mbEGOBOZpcUWeRHWx_L=TapZgv_w@mail.gmail.com>
 <20190606151111.14237-1-TheSven73@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190606151111.14237-1-TheSven73@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, Jun 06, 2019 at 11:11:11AM -0400, Sven Van Asbroeck wrote:
> I was able to test the patch [1] exclusion mechanism without access to actual
> hardware - by giving it a dummy regmap. See patch below.
> 
> Test cases (all via sysfs):
> 1. verify requested pwm cannot be requested as gpio
> 2. verify requested gpio cannot be requested as pwm
> 3. verify pwm "all LEDs" cannot be used if pwms/gpios in use
> 4. verify pwms/gpios cannot be requested if pwm "all LEDs" in use
> 
> All test cases ok.
>  Obviously, I could not test multi-threaded correctness.
> 
> [1] https://lkml.org/lkml/2019/6/4/1039

Is this patch still relevant? A patch similar to YueHaibing's one was
merged in the meantime but I guess the underlying problem is still
relevant. Sven, do you care enough to recheck and create a patch on top
of a more recent tree?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
