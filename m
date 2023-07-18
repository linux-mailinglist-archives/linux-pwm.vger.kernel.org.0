Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94C727585EA
	for <lists+linux-pwm@lfdr.de>; Tue, 18 Jul 2023 22:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbjGRUFg (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 18 Jul 2023 16:05:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjGRUFg (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 18 Jul 2023 16:05:36 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A689B9D;
        Tue, 18 Jul 2023 13:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689710734; x=1721246734;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=mnxKohf2xPQKgrCKJyNvtxb6h6YDhp8sG/+vF3Y5qeA=;
  b=KQKLvePxb48ZxmD4lnOHF0gj7KUy9rvtDjlgNxJcbNm2BWNqQPTNyVPN
   tvqtaKquouDsypCEykRPWDpr5fjVXQhoUGa08anka3Td4UdIQburnkbEy
   NHLsvCgZi+Tn4duquCgXVT+sezyj4+VJVYH5F/hM7rjrJHUrGzmwfZAWX
   +LMZVV4VlG5cqeWaU6nh7GaB6lNyfJBU60dsjlb+BKDQuxBWIngkfwdlR
   HphWlGgVPkzt3iYhwKy9vmUTwZAQKuuip07uj5kVnKSDNAiZH8nL54jYb
   C0ZvqlIpVKUdWrfSpQojIA6zfdVCgeijVvGf1QgvFADiveS3mxUX8JzzW
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="346601842"
X-IronPort-AV: E=Sophos;i="6.01,214,1684825200"; 
   d="scan'208";a="346601842"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 13:05:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="793749516"
X-IronPort-AV: E=Sophos;i="6.01,214,1684825200"; 
   d="scan'208";a="793749516"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP; 18 Jul 2023 13:05:31 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qLqwr-00BDgm-1E;
        Tue, 18 Jul 2023 23:05:29 +0300
Date:   Tue, 18 Jul 2023 23:05:29 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        James Clark <james.clark@arm.com>, linux-doc@vger.kernel.org,
        kernel@pengutronix.de, linux-pwm@vger.kernel.org
Subject: Re: [PATCH 01/18] pwm: Provide devm_pwmchip_alloc() function
Message-ID: <ZLbwib753V6wSHKB@smile.fi.intel.com>
References: <20230718181849.3947851-1-u.kleine-koenig@pengutronix.de>
 <20230718181849.3947851-2-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230718181849.3947851-2-u.kleine-koenig@pengutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, Jul 18, 2023 at 08:18:32PM +0200, Uwe Kleine-König wrote:
> This function allocates a struct pwm_chip and driver data. Compared to
> the status quo the split into pwm_chip and driver data is new, otherwise
> it doesn't change anything relevant (yet).
> 
> The intention is that after all drivers are switched to use this
> allocation function, its possible to add a struct device to struct
> pwm_chip to properly track the latter's lifetime without touching all
> drivers again. Proper lifetime tracking is a necessary precondition to
> introduce character device support for PWMs (that implements atomic
> setting and doesn't suffer from the sysfs overhead of the /sys/class/pwm
> userspace support).
> 
> The new function pwmchip_priv() (obviously?) only works for chips
> allocated with devm_pwmchip_alloc().

...

> +void *pwmchip_priv(struct pwm_chip *chip)
> +{
> +	return (char *)chip + ALIGN(sizeof(*chip), 32);

Why 32? I haven't found any explanation on the choice. I can understand arch
minimum align, but hard coded value is a bit hard to get.

> +}

...

> +struct pwm_chip *devm_pwmchip_alloc(struct device *parent, size_t sizeof_priv)
> +{
> +	struct pwm_chip *chip;
> +	size_t alloc_size;

> +	alloc_size = ALIGN(sizeof(*chip), 32) + sizeof_priv;

Ditto.

Shouldn't it use a macro from overflow.h?

> +	chip = devm_kzalloc(parent, alloc_size, GFP_KERNEL);
> +	if (!chip)
> +		return NULL;
> +
> +	chip->dev = parent;
> +
> +	return chip;
> +}

-- 
With Best Regards,
Andy Shevchenko


