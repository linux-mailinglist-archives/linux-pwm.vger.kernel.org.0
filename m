Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C6422901C7
	for <lists+linux-pwm@lfdr.de>; Fri, 16 Oct 2020 11:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404838AbgJPJYM (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 16 Oct 2020 05:24:12 -0400
Received: from mga18.intel.com ([134.134.136.126]:24207 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404499AbgJPJYL (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 16 Oct 2020 05:24:11 -0400
IronPort-SDR: 7EIB8gktI96mPbPKEtv6Akhj7L2HsDChz+OWV1q2SrRnKqKvQlcz95aPR3qFxCiNhNNwC4Px5s
 O9Z6lh1s98Lw==
X-IronPort-AV: E=McAfee;i="6000,8403,9775"; a="154371998"
X-IronPort-AV: E=Sophos;i="5.77,382,1596524400"; 
   d="scan'208";a="154371998"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2020 02:24:10 -0700
IronPort-SDR: mlXEtulFxgODm6K5CtmsjFXusLEtPGooPn/6pPMOe9ZLe1pRJb4lSq2zVvUblVKC3+O5VdmcYG
 yO0pJTjewzxQ==
X-IronPort-AV: E=Sophos;i="5.77,382,1596524400"; 
   d="scan'208";a="331110121"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2020 02:24:08 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kTLz4-0088CE-NC; Fri, 16 Oct 2020 12:25:10 +0300
Date:   Fri, 16 Oct 2020 12:25:10 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Ayyathurai, Vijayakannan" <vijayakannan.ayyathurai@intel.com>
Cc:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "Wan Mohamad, Wan Ahmad Zainie" 
        <wan.ahmad.zainie.wan.mohamad@intel.com>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "Raja Subramanian, Lakshmi Bai" 
        <lakshmi.bai.raja.subramanian@intel.com>
Subject: Re: [PATCH v12 1/2] pwm: Add PWM driver for Intel Keem Bay
Message-ID: <20201016092510.GH4077@smile.fi.intel.com>
References: <cover.1602703463.git.vijayakannan.ayyathurai@intel.com>
 <5fc6189f9c4cf382d54ae00e663f296baeb2c06e.1602703463.git.vijayakannan.ayyathurai@intel.com>
 <20201015104217.GR4077@smile.fi.intel.com>
 <DM6PR11MB425089996A0CC9A43CBC50C5FB030@DM6PR11MB4250.namprd11.prod.outlook.com>
 <20201016073426.vyjehbkyn3sxn7d5@pengutronix.de>
 <DM6PR11MB4250C00BB0FFB3CD97D5207CFB030@DM6PR11MB4250.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DM6PR11MB4250C00BB0FFB3CD97D5207CFB030@DM6PR11MB4250.namprd11.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, Oct 16, 2020 at 08:32:05AM +0000, Ayyathurai, Vijayakannan wrote:
> From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de> 
> Sent: Friday, 16 October, 2020 1:04 PM
> Hello Ayyathurai,
> 
> Can you please fix your MUA to properly quote when replying, this is really annoying.
> 
> Sorry for that MUA (Made Up Acronym). 

MUA = Mail User Agent. And your quoting is a mess. Please, fix this for any
replies in OSS mailing lists.

-- 
With Best Regards,
Andy Shevchenko


