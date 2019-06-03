Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9690A33461
	for <lists+linux-pwm@lfdr.de>; Mon,  3 Jun 2019 17:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbfFCP7C (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 3 Jun 2019 11:59:02 -0400
Received: from mga18.intel.com ([134.134.136.126]:3129 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726646AbfFCP7C (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 3 Jun 2019 11:59:02 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jun 2019 08:59:02 -0700
X-ExtLoop1: 1
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 03 Jun 2019 08:58:59 -0700
Received: by lahna (sSMTP sendmail emulation); Mon, 03 Jun 2019 18:58:58 +0300
Date:   Mon, 3 Jun 2019 18:58:58 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        YueHaibing <yuehaibing@huawei.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-pwm@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] pwm: pca9685: Remove set but not used variable
 'pwm'
Message-ID: <20190603155858.GF2781@lahna.fi.intel.com>
References: <20190601035709.85379-1-yuehaibing@huawei.com>
 <CAGngYiXZM0QUdKE_zDK763J9iDuiKSbmFeTVA1PJ_4WvjntjQQ@mail.gmail.com>
 <20190601160459.baedo5pp5hsrltzs@pengutronix.de>
 <CAGngYiUfGGF+PwaT4SE2ZJkrCidc7-QWeuRsPTDwrLL1onm88w@mail.gmail.com>
 <20190603114029.GC2781@lahna.fi.intel.com>
 <CAGngYiVDCCjo6VKt660Uz5mbEGOBOZpcUWeRHWx_L=TapZgv_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGngYiVDCCjo6VKt660Uz5mbEGOBOZpcUWeRHWx_L=TapZgv_w@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, Jun 03, 2019 at 11:08:06AM -0400, Sven Van Asbroeck wrote:
> On Mon, Jun 3, 2019 at 7:40 AM Mika Westerberg
> <mika.westerberg@linux.intel.com> wrote:
> >
> > I think you are right. pca9685_pwm_request() should take the mutex as
> > long as it is requesting PWM.
> 
> Yes, but things get hairy because pca9685_pwm_request() will have to
> give up the mutex when it returns. I cannot see a way to keep holding
> this mutex while the in-use flag is set by the pwm core ?

Right, I did not notice it's the PWM core that sets the flag.

> Alternatively, we could set (void *)1 pwm_data inside the pwm_request,
> wrapped inside the mutex.
> But then things get 'messy'.
> 
> > A flag would probably be easier to understand than the magic we have
> > now.
> 
> I have the feeling that a flag (plus a mutex) would be the clearest and
> safest way forward. I'll post a patch soon, you guys tell me what you
> think.

Sounds good thanks!
