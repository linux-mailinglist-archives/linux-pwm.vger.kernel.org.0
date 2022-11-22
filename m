Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81E086343C8
	for <lists+linux-pwm@lfdr.de>; Tue, 22 Nov 2022 19:42:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232544AbiKVSmo (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 22 Nov 2022 13:42:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232800AbiKVSmn (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 22 Nov 2022 13:42:43 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B48F860E7;
        Tue, 22 Nov 2022 10:42:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669142562; x=1700678562;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=spb72GnJAfANMzKzjWtwRkItkEppMQiOyrflr5IPPG0=;
  b=UJQuZT7Bk17/5h6Q5ke4aUWN0Qz6XyaJfA1UHjI+XRG8uo/cikeNoLxq
   NOkj64Y8HnzEkyS40Mur8Qoc6oOyhYVDo3rsANt+w9Wat3Lu672jwsPaa
   Rlf66ApSXfzuwdRAkayOTwx0NPD8QDFedFDdqBgIopb3n2G1Z5Hip0Muk
   +HKR0V0CgQsS5OYvL5s0CNYIdb/AGR2D7IpW6VsQKtMFOotDQ5fktj5WT
   LK7ZYY9fWjXpdWFwvIinLZDneEHRvDjzDfKFdEf1UV7DsWRQX1qdF9WoY
   d4uAcKN1C1Wq69pUlq0BNetDp+rWFRCzrhzkeVAbGd0CjcUAPuCiBCQkO
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="400178580"
X-IronPort-AV: E=Sophos;i="5.96,184,1665471600"; 
   d="scan'208";a="400178580"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2022 10:42:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="970568858"
X-IronPort-AV: E=Sophos;i="5.96,184,1665471600"; 
   d="scan'208";a="970568858"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 22 Nov 2022 10:42:40 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 48F4E128; Tue, 22 Nov 2022 20:43:06 +0200 (EET)
Date:   Tue, 22 Nov 2022 20:43:06 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linux pin control <linux-gpio@vger.kernel.org>,
        linux-pwm@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: [GIT PULL] intel-pinctrl for 6.2-2
Message-ID: <Y30YOvHpqvte9otX@black.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Linux pin control and PWM maintainers,

This is an immutable tag with PWM feature enablement for Intel pin control IPs.
It's targeting v6.2 and have been reviewed by all stakeholders.

The idea is that PWM and pin control subsystem soak up it independently.

Thanks,

With Best Regards,
Andy Shevchenko

The following changes since commit 9abf2313adc1ca1b6180c508c25f22f9395cc780:

  Linux 6.1-rc1 (2022-10-16 15:36:24 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pinctrl/intel.git tags/intel-pinctrl-v6.2-2

for you to fetch changes up to eb78d3604d6bcbe9743e036114c33a5a17090a0a:

  pinctrl: intel: Enumerate PWM device when community has a capability (2022-11-22 20:34:02 +0200)

----------------------------------------------------------------
intel-pinctrl for v6.2-2

* Enable PWM feature on Intel pin control IPs

The following is an automated git shortlog grouped by driver:

intel:
 -  Enumerate PWM device when community has a capability

pwm:
 -  lpss: Rename pwm_lpss_probe() --> devm_pwm_lpss_probe()
 -  lpss: Allow other drivers to enable PWM LPSS
 -  lpss: Include headers we are the direct user of
 -  lpss: Rename MAX_PWMS --> LPSS_MAX_PWMS
 -  Add a stub for devm_pwmchip_add()

----------------------------------------------------------------
Andy Shevchenko (6):
      pwm: Add a stub for devm_pwmchip_add()
      pwm: lpss: Rename MAX_PWMS --> LPSS_MAX_PWMS
      pwm: lpss: Include headers we are the direct user of
      pwm: lpss: Allow other drivers to enable PWM LPSS
      pwm: lpss: Rename pwm_lpss_probe() --> devm_pwm_lpss_probe()
      pinctrl: intel: Enumerate PWM device when community has a capability

 drivers/pinctrl/intel/pinctrl-intel.c      | 29 ++++++++++++++++++++++++++
 drivers/pwm/pwm-lpss-pci.c                 |  2 +-
 drivers/pwm/pwm-lpss-platform.c            |  2 +-
 drivers/pwm/pwm-lpss.c                     |  8 ++++----
 drivers/pwm/pwm-lpss.h                     | 26 ++++-------------------
 include/linux/platform_data/x86/pwm-lpss.h | 33 ++++++++++++++++++++++++++++++
 include/linux/pwm.h                        |  5 +++++
 7 files changed, 77 insertions(+), 28 deletions(-)
 create mode 100644 include/linux/platform_data/x86/pwm-lpss.h

-- 
With Best Regards,
Andy Shevchenko


