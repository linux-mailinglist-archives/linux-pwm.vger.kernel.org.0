Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2158D232EBB
	for <lists+linux-pwm@lfdr.de>; Thu, 30 Jul 2020 10:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729058AbgG3IbF (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 30 Jul 2020 04:31:05 -0400
Received: from mga12.intel.com ([192.55.52.136]:59652 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728850AbgG3IbE (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 30 Jul 2020 04:31:04 -0400
IronPort-SDR: eDu5NXabJ6tzA7DATUEyiPXWtBOL2jhzIlUKbQafYpCU+PT/EscvChTL75BocMdK20vmibEpOF
 AAwjbqX3VaZg==
X-IronPort-AV: E=McAfee;i="6000,8403,9697"; a="131118949"
X-IronPort-AV: E=Sophos;i="5.75,413,1589266800"; 
   d="scan'208";a="131118949"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2020 01:31:04 -0700
IronPort-SDR: ffGzBVTSxb8GpJc5oh3CKyQ0enNV7diTBxOIIzSwAJmju32x4zKCZ4nucAIkxFyY399Tj+DSj3
 EuyzMacinsYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,413,1589266800"; 
   d="scan'208";a="272865479"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga007.fm.intel.com with ESMTP; 30 Jul 2020 01:31:00 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1k13xq-004sgj-T2; Thu, 30 Jul 2020 11:30:58 +0300
Date:   Thu, 30 Jul 2020 11:30:58 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Roy Im <roy.im.opensource@diasemi.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Brian Masney <masneyb@onstation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>, Luca Weiss <luca@z3ntu.xyz>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Pascal PAILLET-LME <p.paillet@st.com>,
        Rob Herring <robh@kernel.org>,
        Samuel Ortiz <sameo@linux.intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Support Opensource <support.opensource@diasemi.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v18 3/3] Input: new da7280 haptic driver
Message-ID: <20200730083058.GC3703480@smile.fi.intel.com>
References: <cover.1595991580.git.Roy.Im@diasemi.com>
 <23b3470401ec5cf525add8e1227cb67586b9f294.1595991580.git.Roy.Im@diasemi.com>
 <20200729063638.GY1665100@dtor-ws>
 <20200729072145.ifzoe656sjpxdior@pengutronix.de>
 <20200730050653.GA1665100@dtor-ws>
 <20200730061631.y4r4s6v3xepktj54@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200730061631.y4r4s6v3xepktj54@pengutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, Jul 30, 2020 at 08:16:31AM +0200, Uwe Kleine-König wrote:
> On Wed, Jul 29, 2020 at 10:06:53PM -0700, Dmitry Torokhov wrote:
> > On Wed, Jul 29, 2020 at 09:21:45AM +0200, Uwe Kleine-König wrote:
> > > On Tue, Jul 28, 2020 at 11:36:38PM -0700, Dmitry Torokhov wrote:

...

> > Maybe we should introduce something like '%de' for the integer error
> > case?
> 
> I suggested that some time ago with limited success, see
> https://lore.kernel.org/lkml/20200129115516.zsvxu56e6h7gheiw@pathway.suse.cz/

Oh, please, no need for that really. We have now dev_err_probe() on its way to
upstream (now in Greg's tree) which hides all this behind.

Just switch to dev_err_probe() and forget about what is under the hood.

-- 
With Best Regards,
Andy Shevchenko


