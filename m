Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BAE7278368
	for <lists+linux-pwm@lfdr.de>; Fri, 25 Sep 2020 10:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727679AbgIYI72 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 25 Sep 2020 04:59:28 -0400
Received: from mga17.intel.com ([192.55.52.151]:24563 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727044AbgIYI72 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 25 Sep 2020 04:59:28 -0400
IronPort-SDR: T+NPBjClqOVJKeJI8IfG3rf38lPNB8rUzg2/j12wvVcgZtuFGvU/+81s5/jlYMgBs6QfX1Rugk
 RHnYXDi4B21A==
X-IronPort-AV: E=McAfee;i="6000,8403,9754"; a="141503838"
X-IronPort-AV: E=Sophos;i="5.77,301,1596524400"; 
   d="scan'208";a="141503838"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2020 01:59:27 -0700
IronPort-SDR: eJGqry7RCkHfSNAQd5teD3D9rGoqQNy00gZxxnehLb1Fmq5cnE1dUIoJVd5FKYFeuF2/D9aBo8
 qiqPRtfGG8aw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,301,1596524400"; 
   d="scan'208";a="339420109"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008.jf.intel.com with ESMTP; 25 Sep 2020 01:59:24 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1kLjGY-001sH3-2H; Fri, 25 Sep 2020 11:39:42 +0300
Date:   Fri, 25 Sep 2020 11:39:42 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Rahul Tanwar <rahul.tanwar@linux.intel.com>,
        linux-pwm@vger.kernel.org, lee.jones@linaro.org,
        thierry.reding@gmail.com, p.zabel@pengutronix.de,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, songjun.Wu@intel.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com,
        rahul.tanwar.linux@gmail.com, rtanwar@maxlinear.com
Subject: Re: [PATCH v13 2/2] Add PWM fan controller driver for LGM SoC
Message-ID: <20200925083942.GW3956970@smile.fi.intel.com>
References: <cover.1600158087.git.rahul.tanwar@linux.intel.com>
 <befa655d8beb326fc8aa405a25a8b3e62b7e6a4a.1600158087.git.rahul.tanwar@linux.intel.com>
 <20200924065534.e2anwghhtysv63e7@pengutronix.de>
 <20200924132334.GT3956970@smile.fi.intel.com>
 <20200924141659.4wov7w2l2bllpre4@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200924141659.4wov7w2l2bllpre4@pengutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, Sep 24, 2020 at 04:16:59PM +0200, Uwe Kleine-König wrote:
> On Thu, Sep 24, 2020 at 04:23:34PM +0300, Andy Shevchenko wrote:
> > On Thu, Sep 24, 2020 at 08:55:34AM +0200, Uwe Kleine-König wrote:

...

> > True. And above dev_err_probe() is not needed.
> 
> You argue that dev_err_probe() gives no benefit as
> lgm_reset_control_deassert won't return -EPROBE_DEFER, right?
> 
> Still I consider it a useful function because
> 
>  a) I (as an author or as a reviewer) don't need to think if the
>     failing function might return -EPROBE_DEFER now or in the future.
>     dev_err_probe does the right thing even for functions that don't
>     return -EPROBE_DEFER.
> 
>  b) With dev_err_probe() I can accomplish things in a single line that
>     need two lines when open coding it.
> 
>  c) dev_err_probe() emits the symbolic error name without having to
>     resort to %pe + ERR_PTR.
> 
>  d) Using dev_err_probe() for all error paths gives a consistency that I
>     like with a maintainer's hat on.
> 
> So I still want to request using dev_err_probe() in all error paths.

As a maintainer it is your choice. I really would like to see more consensus
among maintainers, some are insisting of what I said, some, like you, on the
opposite, some hate that API and some simply don't care.

And on top of that I saw already use of API without taking returned value into
account.

-- 
With Best Regards,
Andy Shevchenko


