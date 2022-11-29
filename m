Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E41363BF68
	for <lists+linux-pwm@lfdr.de>; Tue, 29 Nov 2022 12:53:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbiK2Lxb (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 29 Nov 2022 06:53:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232052AbiK2Lxa (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 29 Nov 2022 06:53:30 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 248A855A8F;
        Tue, 29 Nov 2022 03:53:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669722809; x=1701258809;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HFscW1vRVjDuP/maev1P0KzZMtKtQZ3cNE4ZEQ6OaFs=;
  b=kdPoHOTjRmSN945EQdzkslfvJqogBxbk1lHPFNI/6ZQo9wLLjRkP7RzO
   wS1I2gr5+yO82/zDR6rQuJNcVAy8ngYvShvmM1ncz8HK7nNhcX1tsWPKa
   MPYF/XgndPYytmqTCuxDt5//mqClNIKdNRxYqsPwHkUYlTIsGYFs4IUMP
   W8NrNh2MV7PLtG3mNNWQLji2Qzj0smYD3sV/n8wP0LO8JJZLTA00BbdQv
   uLn4XmIys1OMLiGhW1p/Cw1Gf9QhGakxXrOOOK3M4OwQFN12A2LjhGfLN
   xzsTEe7o6I+xzCiEo4FtXcx2KvJLQ898sq8XHh5zsqfLGOwUqipBde3Dk
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="294784518"
X-IronPort-AV: E=Sophos;i="5.96,203,1665471600"; 
   d="scan'208";a="294784518"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2022 03:53:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="972644627"
X-IronPort-AV: E=Sophos;i="5.96,203,1665471600"; 
   d="scan'208";a="972644627"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP; 29 Nov 2022 03:53:27 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ozzAz-001goI-2E;
        Tue, 29 Nov 2022 13:53:25 +0200
Date:   Tue, 29 Nov 2022 13:53:25 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Linux pin control <linux-gpio@vger.kernel.org>,
        linux-pwm@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [GIT PULL] intel-pinctrl for 6.2-2
Message-ID: <Y4XytaKH9QH+wDSG@smile.fi.intel.com>
References: <Y30YOvHpqvte9otX@black.fi.intel.com>
 <CACRpkdZa7hOuU5e-i+_=TqM_Ttec6tvzgXXPm8giy=NiFO2tEA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdZa7hOuU5e-i+_=TqM_Ttec6tvzgXXPm8giy=NiFO2tEA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, Nov 28, 2022 at 09:25:02PM +0100, Linus Walleij wrote:
> On Tue, Nov 22, 2022 at 7:42 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> 
> > This is an immutable tag with PWM feature enablement for Intel pin control IPs.
> > It's targeting v6.2 and have been reviewed by all stakeholders.
> >
> > The idea is that PWM and pin control subsystem soak up it independently.
> 
> I wanted to give Thierry the option to say if he's pulling this in,
> but it needs rotation in linux-next so I've pulled it into the pin
> control tree now.

Thank you!

Note, that Thierry and Uwe gave their respective tags to the patches.

-- 
With Best Regards,
Andy Shevchenko


