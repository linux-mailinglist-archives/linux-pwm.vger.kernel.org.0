Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE7225FA8D
	for <lists+linux-pwm@lfdr.de>; Mon,  7 Sep 2020 14:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729198AbgIGMeo (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 7 Sep 2020 08:34:44 -0400
Received: from mga18.intel.com ([134.134.136.126]:34181 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729186AbgIGMdk (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 7 Sep 2020 08:33:40 -0400
IronPort-SDR: /m9ZbdO4zbC53238hSJlIbGsz/q+eC/KXPVA8frrw175BFAUej+ok/19OidiYERI7Ayziqt43c
 oUFTgEMvmIXA==
X-IronPort-AV: E=McAfee;i="6000,8403,9736"; a="145705343"
X-IronPort-AV: E=Sophos;i="5.76,401,1592895600"; 
   d="scan'208";a="145705343"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2020 05:33:39 -0700
IronPort-SDR: BWi0P5a0/LbMmyJhLsF+GjyZTREr1uVm+6uKHSy7XSrV0pYYr2TRXvXCOZuQ5zirT2FT5r2KQB
 EOnd7na1fHag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,401,1592895600"; 
   d="scan'208";a="333150609"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008.jf.intel.com with ESMTP; 07 Sep 2020 05:33:36 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kFGL0-00EwvE-0k; Mon, 07 Sep 2020 15:33:34 +0300
Date:   Mon, 7 Sep 2020 15:33:34 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     vineetha.g.jaya.kumaran@intel.com
Cc:     thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        robh+dt@kernel.org, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, wan.ahmad.zainie.wan.mohamad@intel.com,
        vijayakannan.ayyathurai@intel.com, mgross@linux.intel.com,
        lakshmi.bai.raja.subramanian@intel.com
Subject: Re: [PATCH v6 1/2] pwm: Add PWM driver for Intel Keem Bay
Message-ID: <20200907123334.GF1891694@smile.fi.intel.com>
References: <1599480470-5932-1-git-send-email-vineetha.g.jaya.kumaran@intel.com>
 <1599480470-5932-2-git-send-email-vineetha.g.jaya.kumaran@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1599480470-5932-2-git-send-email-vineetha.g.jaya.kumaran@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, Sep 07, 2020 at 08:07:49PM +0800, vineetha.g.jaya.kumaran@intel.com wrote:
> From: "Lai, Poey Seng" <poey.seng.lai@intel.com>
> 
> The Intel Keem Bay SoC requires PWM support.
> Add the pwm-keembay driver to enable this.

Hadn't I given a tag already? If so, where is it?

> Co-developed-by: Vineetha G. Jaya Kumaran <vineetha.g.jaya.kumaran@intel.com>
> Signed-off-by: Lai, Poey Seng <poey.seng.lai@intel.com>
> Signed-off-by: Vineetha G. Jaya Kumaran <vineetha.g.jaya.kumaran@intel.com>

-- 
With Best Regards,
Andy Shevchenko


