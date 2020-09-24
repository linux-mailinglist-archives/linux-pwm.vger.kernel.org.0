Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 396AC27729D
	for <lists+linux-pwm@lfdr.de>; Thu, 24 Sep 2020 15:39:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728044AbgIXNjC (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 24 Sep 2020 09:39:02 -0400
Received: from mga04.intel.com ([192.55.52.120]:17190 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727888AbgIXNjB (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 24 Sep 2020 09:39:01 -0400
IronPort-SDR: hUQp4x/SJplnpc8Mi6XCZU/c0UXYRueMezf0dHQ42xp1f9d6l1l2c4DtcwRIgXGPILmWLrG5J6
 zJ0mc8gJsxgw==
X-IronPort-AV: E=McAfee;i="6000,8403,9753"; a="158582189"
X-IronPort-AV: E=Sophos;i="5.77,297,1596524400"; 
   d="scan'208";a="158582189"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2020 06:38:58 -0700
IronPort-SDR: jWOEcGzq6troy1NP13CLTFfaqvuZUeJBoVkPvBeW4r3vbRUuadDgQPeiLaL7c3iQMg08GSayWH
 UKC1wj2Ts6RA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,297,1596524400"; 
   d="scan'208";a="339049158"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008.jf.intel.com with ESMTP; 24 Sep 2020 06:38:54 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1kLRDi-001fqv-2C; Thu, 24 Sep 2020 16:23:34 +0300
Date:   Thu, 24 Sep 2020 16:23:34 +0300
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
Message-ID: <20200924132334.GT3956970@smile.fi.intel.com>
References: <cover.1600158087.git.rahul.tanwar@linux.intel.com>
 <befa655d8beb326fc8aa405a25a8b3e62b7e6a4a.1600158087.git.rahul.tanwar@linux.intel.com>
 <20200924065534.e2anwghhtysv63e7@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200924065534.e2anwghhtysv63e7@pengutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, Sep 24, 2020 at 08:55:34AM +0200, Uwe Kleine-König wrote:
> On Tue, Sep 15, 2020 at 04:23:37PM +0800, Rahul Tanwar wrote:

...

> > +	ret = lgm_clk_enable(dev, pc);
> > +	if (ret) {
> > +		dev_err(dev, "failed to enable clock\n");
> 
> You used dev_err_probe four times for six error paths. I wonder why you
> didn't use it here (and below for a failing pwmchip_add()).

dev_err_probe() makes sense when we might experience deferred probe. In neither
of mentioned function this can be the case.

> > +		return ret;
> > +	}

...

> > +	ret = lgm_reset_control_deassert(dev, pc);
> > +	if (ret)
> > +		return dev_err_probe(dev, ret, "cannot deassert reset control\n");
> 
> After lgm_reset_control_deassert is called pc->rst is unused. So there
> is no need to have this member in struct lgm_pwm_chip. The same applies
> to ->clk. (You have to pass rst (or clk) to devm_add_action_or_reset for
> that to work. Looks like a nice idea anyhow.)

True. And above dev_err_probe() is not needed.

-- 
With Best Regards,
Andy Shevchenko


