Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6F507BB928
	for <lists+linux-pwm@lfdr.de>; Fri,  6 Oct 2023 15:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232420AbjJFNfL (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 6 Oct 2023 09:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232422AbjJFNfI (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 6 Oct 2023 09:35:08 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E60D895
        for <linux-pwm@vger.kernel.org>; Fri,  6 Oct 2023 06:35:07 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="5306141"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="5306141"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 06:35:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="925963408"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="925963408"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 06:35:05 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC1)
        (envelope-from <andy@kernel.org>)
        id 1qokys-00000003JA7-3436;
        Fri, 06 Oct 2023 16:35:02 +0300
Date:   Fri, 6 Oct 2023 16:35:02 +0300
From:   Andy Shevchenko <andy@kernel.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org,
        kernel@pengutronix.de, Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH v1 100/101] pwm: Ensure the memory backing a PWM chip
 isn't freed while used
Message-ID: <ZSANBvD8wVk43xaF@smile.fi.intel.com>
References: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
 <20230808171931.944154-101-u.kleine-koenig@pengutronix.de>
 <ZR__enSpj7_TBcrj@orome.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZR__enSpj7_TBcrj@orome.fritz.box>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, Oct 06, 2023 at 02:37:14PM +0200, Thierry Reding wrote:
> On Tue, Aug 08, 2023 at 07:19:30PM +0200, Uwe Kleine-König wrote:

[...]

> For cases where pwmchip_release() needs to do more than just free the
> memory, we could add a new pwm_ops.release callback that drivers can
> implement if needed.

Definitely not the best idea. Many drivers want to have PM runtime to
be called, or clocks to be handled (and w/o devm it makes it a lot
more verbose and prone to ordering issues with subtle bugs that may
appear 1 per 10 years.

So, I'm definitely on the Uwe's side in this discussion.

-- 
With Best Regards,
Andy Shevchenko


