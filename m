Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 950C81DE2CB
	for <lists+linux-pwm@lfdr.de>; Fri, 22 May 2020 11:18:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728368AbgEVJSZ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 22 May 2020 05:18:25 -0400
Received: from mga09.intel.com ([134.134.136.24]:37261 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728068AbgEVJSZ (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 22 May 2020 05:18:25 -0400
IronPort-SDR: 4sfRajtSiPTK5pXRhPShMXltCYWnibqHfE/XIczG6OSsOjl3ZWLjI88hgBNJRVt7MXxb1RlKuW
 TvGQ/VIT7nYA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2020 02:18:23 -0700
IronPort-SDR: fliFQp2k0Jegvpud9LRgFiCDLKayCWiBstcC5LyqtT4DFnnULjgmrihisTWEaD49Mtgm9ipdgB
 guqmZqAI7Low==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,421,1583222400"; 
   d="scan'208";a="309326287"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by FMSMGA003.fm.intel.com with ESMTP; 22 May 2020 02:18:21 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1jc3ou-008Cho-Ao; Fri, 22 May 2020 12:18:24 +0300
Date:   Fri, 22 May 2020 12:18:24 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Rahul Tanwar <rahul.tanwar@linux.intel.com>,
        thierry.reding@gmail.com, p.zabel@pengutronix.de,
        linux-pwm@vger.kernel.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        songjun.Wu@intel.com, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com
Subject: Re: [PATCH v1 2/2] Add PWM driver for LGM
Message-ID: <20200522091824.GR1634618@smile.fi.intel.com>
References: <cover.1590132733.git.rahul.tanwar@linux.intel.com>
 <3c1d2343b034325dbc185ccd23a35b40a62a4e7b.1590132733.git.rahul.tanwar@linux.intel.com>
 <20200522085613.ktb2ruw2virj337v@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200522085613.ktb2ruw2virj337v@pengutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, May 22, 2020 at 10:56:13AM +0200, Uwe Kleine-König wrote:
> On Fri, May 22, 2020 at 03:41:59PM +0800, Rahul Tanwar wrote:

> > +	io_base = devm_platform_ioremap_resource(pdev, 0);
> > +	if (IS_ERR(io_base))
> 
> error message here?

platform core provides it. No need to duplicate (esp. taking into consideration
that it can issue IIRC three different error messages depending on actual error).

> 
> > +		return PTR_ERR(io_base);

-- 
With Best Regards,
Andy Shevchenko


