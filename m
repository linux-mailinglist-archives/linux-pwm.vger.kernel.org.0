Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC6487749BD
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Aug 2023 22:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbjHHUCp (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 8 Aug 2023 16:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbjHHUCc (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 8 Aug 2023 16:02:32 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1001C81291
        for <linux-pwm@vger.kernel.org>; Tue,  8 Aug 2023 11:19:33 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="437269769"
X-IronPort-AV: E=Sophos;i="6.01,156,1684825200"; 
   d="scan'208";a="437269769"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2023 10:49:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="801408349"
X-IronPort-AV: E=Sophos;i="6.01,156,1684825200"; 
   d="scan'208";a="801408349"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP; 08 Aug 2023 10:49:54 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andy@kernel.org>)
        id 1qTQq9-0015wc-1N;
        Tue, 08 Aug 2023 20:49:53 +0300
Date:   Tue, 8 Aug 2023 20:49:53 +0300
From:   Andy Shevchenko <andy@kernel.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org, kernel@pengutronix.de,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH v1 080/101] pwm: lpss: Store parent device in driver data
Message-ID: <ZNKAQV4VXVwkyYBV@smile.fi.intel.com>
References: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
 <20230808171931.944154-81-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230808171931.944154-81-u.kleine-koenig@pengutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, Aug 08, 2023 at 07:19:10PM +0200, Uwe Kleine-König wrote:
> struct pwm_chip::dev is about to change. To not have to touch this
> driver in the same commit as struct pwm_chip::dev, store a pointer to
> the parent device in driver data.

I'm not against this change, so
Acked-by: Andy Shevchenko <andy@kernel.org>
bu see some comments below.

I think ideally pwm_chip should be an opaque to the driver
(or something near to it). OTOH it may be I understood that
wrong.

...

>  	if (state->enabled) {
>  		if (!pwm_is_enabled(pwm)) {
> -			pm_runtime_get_sync(chip->dev);
> +			pm_runtime_get_sync(lpwm->parent);
>  			ret = pwm_lpss_prepare_enable(lpwm, pwm, state);
>  			if (ret)
> -				pm_runtime_put(chip->dev);
> +				pm_runtime_put(lpwm->parent);
>  		} else {
>  			ret = pwm_lpss_prepare_enable(lpwm, pwm, state);
>  		}
>  	} else if (pwm_is_enabled(pwm)) {
>  		pwm_lpss_write(pwm, pwm_lpss_read(pwm) & ~PWM_ENABLE);
> -		pm_runtime_put(chip->dev);
> +		pm_runtime_put(lpwm->parent);
>  	}

I'm wondering why PM runtime calls can't be part of PWM core?
We may cleanup a lot of code with it, no?

...

> -	pm_runtime_get_sync(chip->dev);
> +	pm_runtime_get_sync(lpwm->parent);


> -	pm_runtime_put(chip->dev);
> +	pm_runtime_put(lpwm->parent);

Ditto.

...

>  struct pwm_lpss_chip {
> +	struct device *parent;

Have you checked IIO approach with the public and private members
(under private the opaque pointer is meant)? Maybe something of that
can be applied to PWM code as well, dunno.

>  	void __iomem *regs;
>  	const struct pwm_lpss_boardinfo *info;
>  };

-- 
With Best Regards,
Andy Shevchenko


