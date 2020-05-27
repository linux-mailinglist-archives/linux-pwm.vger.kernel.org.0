Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D06C21E3D5B
	for <lists+linux-pwm@lfdr.de>; Wed, 27 May 2020 11:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbgE0JPY (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 27 May 2020 05:15:24 -0400
Received: from mga14.intel.com ([192.55.52.115]:2801 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726600AbgE0JPX (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 27 May 2020 05:15:23 -0400
IronPort-SDR: cnGDxl3jRMnYfdI4wlawiljsnVz3dHyTTFSnu/srEniJteMbPZfeLdEQpBBE45Hod0Uxx/oz8R
 6utRS9l7QH1Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2020 02:15:23 -0700
IronPort-SDR: SF4e9Ud+NzqoSgOtLCWW0thQSwuv/BECHfAnvtDAcpsDAhHpFny/uY/6luXlxGJNppq1NgL8h+
 UvXH7gzK4b+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,440,1583222400"; 
   d="scan'208";a="284741187"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga002.jf.intel.com with ESMTP; 27 May 2020 02:15:18 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1jds9h-009BXB-AC; Wed, 27 May 2020 12:15:21 +0300
Date:   Wed, 27 May 2020 12:15:21 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     "Tanwar, Rahul" <rahul.tanwar@linux.intel.com>
Cc:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, thierry.reding@gmail.com,
        p.zabel@pengutronix.de, linux-pwm@vger.kernel.org,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, songjun.Wu@intel.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com
Subject: Re: [PATCH v1 2/2] Add PWM driver for LGM
Message-ID: <20200527091521.GH1634618@smile.fi.intel.com>
References: <cover.1590132733.git.rahul.tanwar@linux.intel.com>
 <3c1d2343b034325dbc185ccd23a35b40a62a4e7b.1590132733.git.rahul.tanwar@linux.intel.com>
 <20200522085613.ktb2ruw2virj337v@pengutronix.de>
 <3a1f1e83-2d9d-ddbf-e2e6-9c8bab87372b@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3a1f1e83-2d9d-ddbf-e2e6-9c8bab87372b@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, May 27, 2020 at 02:28:53PM +0800, Tanwar, Rahul wrote:
> On 22/5/2020 4:56 pm, Uwe Kleine-König wrote:
> > On Fri, May 22, 2020 at 03:41:59PM +0800, Rahul Tanwar wrote:

...

> > I'm a unhappy to have this in the PWM driver. The PWM driver is supposed
> > to be generic and I think this belongs into a dedicated driver.
> 
> Well noted about all other review concerns. I will rework the driver in v2.
> However, i am not very sure about the above point - of having a separate
> dedicated driver for tach_work because its logic is tightly coupled with
> this driver.

Actually I agree with Uwe.
Here is layering violation, i.e. provider and consumer in the same pot. It's
not good from design perspective.

-- 
With Best Regards,
Andy Shevchenko


