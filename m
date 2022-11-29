Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72BED63BFDF
	for <lists+linux-pwm@lfdr.de>; Tue, 29 Nov 2022 13:16:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233643AbiK2MQc (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 29 Nov 2022 07:16:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233711AbiK2MQ1 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 29 Nov 2022 07:16:27 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43C2D5D686;
        Tue, 29 Nov 2022 04:16:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669724187; x=1701260187;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vkHb10UWl0EmeYONEXD8X8afsmS+52X0M20NY2od828=;
  b=LkcPxuTj9frfK45N0mDHBSCBdmcbmpAKP8UA7Tk9mOSI+Ty037h2KMzD
   e2f1My8I7RGDE1X0QYQFSpJFBwOJkGwGLXEKZYEdlkSzxn5sagcCwl6Bl
   RMIHKVMpPEDHU5sp15FzDEygHxS36UhRTxpdppP1NCsPSXQBFGZCeeYQz
   +ZTXcdrATUreJy3wzLTiw6YMvxIpoH967NeyQ09UvjNiEsIi4IltiATOm
   45MiyF9kTHLN0akUIBI3plG07mbqRcN2uU+j+brcA+z0v1UX3JsE7hKxU
   Y26hIVvZ5g39Gubg7CzTYVpmJIDsXBQUo12zfedSSl4yX/aqgmnGYaoWz
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="377239413"
X-IronPort-AV: E=Sophos;i="5.96,203,1665471600"; 
   d="scan'208";a="377239413"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2022 04:16:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="786019470"
X-IronPort-AV: E=Sophos;i="5.96,203,1665471600"; 
   d="scan'208";a="786019470"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP; 29 Nov 2022 04:16:11 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ozzWz-001hFK-1X;
        Tue, 29 Nov 2022 14:16:09 +0200
Date:   Tue, 29 Nov 2022 14:16:09 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Linux pin control <linux-gpio@vger.kernel.org>,
        linux-pwm@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [GIT PULL] intel-pinctrl for 6.2-2
Message-ID: <Y4X4CQqafmtct26C@smile.fi.intel.com>
References: <Y30YOvHpqvte9otX@black.fi.intel.com>
 <CACRpkdZa7hOuU5e-i+_=TqM_Ttec6tvzgXXPm8giy=NiFO2tEA@mail.gmail.com>
 <Y4X0QUVIIddOK2+I@orome>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y4X0QUVIIddOK2+I@orome>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, Nov 29, 2022 at 01:00:01PM +0100, Thierry Reding wrote:
> On Mon, Nov 28, 2022 at 09:25:02PM +0100, Linus Walleij wrote:
> > On Tue, Nov 22, 2022 at 7:42 PM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > 
> > > This is an immutable tag with PWM feature enablement for Intel pin control IPs.
> > > It's targeting v6.2 and have been reviewed by all stakeholders.
> > >
> > > The idea is that PWM and pin control subsystem soak up it independently.
> > 
> > I wanted to give Thierry the option to say if he's pulling this in,
> > but it needs rotation in linux-next so I've pulled it into the pin
> > control tree now.
> 
> My recollection is that Andy wanted to take this through the Intel pin
> control tree, so there's no need for me to pick this up as well unless
> perhaps for conflict resolution (which I'm not seeing right now).

The idea was to have an immutable tag that all parties, who are involved,
can pull. It means if you don't need it, it's fine, since the main route
is Intel pin control as you said.

Thank you!

-- 
With Best Regards,
Andy Shevchenko


