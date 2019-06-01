Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE95C31FDC
	for <lists+linux-pwm@lfdr.de>; Sat,  1 Jun 2019 18:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbfFAQFN (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 1 Jun 2019 12:05:13 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:52021 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726246AbfFAQFN (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 1 Jun 2019 12:05:13 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1hX6VB-0005BR-FK; Sat, 01 Jun 2019 18:05:01 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1hX6V9-0002xN-7I; Sat, 01 Jun 2019 18:04:59 +0200
Date:   Sat, 1 Jun 2019 18:04:59 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     YueHaibing <yuehaibing@huawei.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-pwm@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] pwm: pca9685: Remove set but not used variable
 'pwm'
Message-ID: <20190601160459.baedo5pp5hsrltzs@pengutronix.de>
References: <20190601035709.85379-1-yuehaibing@huawei.com>
 <CAGngYiXZM0QUdKE_zDK763J9iDuiKSbmFeTVA1PJ_4WvjntjQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGngYiXZM0QUdKE_zDK763J9iDuiKSbmFeTVA1PJ_4WvjntjQQ@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello Sven,

On Sat, Jun 01, 2019 at 09:03:09AM -0400, Sven Van Asbroeck wrote:
> Hi YueHaibing,
> 
> On Fri, May 31, 2019 at 11:49 PM YueHaibing <yuehaibing@huawei.com> wrote:
> >
> >         mutex_lock(&pca->lock);
> > -       pwm = &pca->chip.pwms[offset];
> >         mutex_unlock(&pca->lock);
> 
> Thanks for noticing this issue. However it should be fixed differently.
> 
> This was introduced by Uwe's clean-up patch:
> commit e926b12c611c2095c79 ("pwm: Clear chip_data in pwm_put()")
> 
> But Uwe did not realize that in this case, the pwm chip_data is used as a
> synchronization mechanism between pwm and gpio. Moving the chip_data
> clear out of the mutex breaks this mechanism.

> 
> I think the following would restore the mechanism:
> 
> >         mutex_lock(&pca->lock);
> >        pwm = &pca->chip.pwms[offset];
> > +     pwm_set_chip_data(pwm, NULL);
> >         mutex_unlock(&pca->lock);

I didn't look into the driver to try to understand that, but the
definitely needs a comment to explain for the next person to think they
can do a cleanup here.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
