Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB7C307768
	for <lists+linux-pwm@lfdr.de>; Thu, 28 Jan 2021 14:49:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232004AbhA1Nq7 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 28 Jan 2021 08:46:59 -0500
Received: from mga09.intel.com ([134.134.136.24]:56365 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231667AbhA1Nq4 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 28 Jan 2021 08:46:56 -0500
IronPort-SDR: S/jExUFEUPWGafhTvwBVB2zW3p0rlZl9MzhnmNSY+L17LcBczu4mc4nJSmCig54KigkSHNOXeK
 tBylchYuqb3A==
X-IronPort-AV: E=McAfee;i="6000,8403,9877"; a="180376739"
X-IronPort-AV: E=Sophos;i="5.79,382,1602572400"; 
   d="scan'208";a="180376739"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2021 05:46:14 -0800
IronPort-SDR: Zr1is76ZWVd6QiItDcAXKLWQeDtkUueBohPTXQs3t29xgXIA/knxciUulYW6G8yEYbROc6SBJO
 OqxUA7hDnVYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,382,1602572400"; 
   d="scan'208";a="409067063"
Received: from lkp-server02.sh.intel.com (HELO 625d3a354f04) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 28 Jan 2021 05:46:10 -0800
Received: from kbuild by 625d3a354f04 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1l57cf-0002wW-7w; Thu, 28 Jan 2021 13:46:09 +0000
Date:   Thu, 28 Jan 2021 21:45:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Vladimir Zapolskiy <vz@mleia.com>, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] pwm: fix semicolon.cocci warnings
Message-ID: <20210128134537.GA54687@068c7b848bbb>
References: <202101282111.dfwxyPwI-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202101282111.dfwxyPwI-lkp@intel.com>
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

From: kernel test robot <lkp@intel.com>

drivers/pwm/pwm-lpc18xx-sct.c:292:2-3: Unneeded semicolon


 Remove unneeded semicolon.

Generated by: scripts/coccinelle/misc/semicolon.cocci

Fixes: e96c0ff4b1e0 ("pwm: Enable compile testing for some of drivers")
CC: Krzysztof Kozlowski <krzk@kernel.org>
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: kernel test robot <lkp@intel.com>
---

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   76c057c84d286140c6c416c3b4ba832cd1d8984e
commit: e96c0ff4b1e013a4e9174344b0fcda0d566d3689 pwm: Enable compile testing for some of drivers

 pwm-lpc18xx-sct.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/pwm/pwm-lpc18xx-sct.c
+++ b/drivers/pwm/pwm-lpc18xx-sct.c
@@ -289,7 +289,7 @@ static int lpc18xx_pwm_request(struct pw
 		dev_err(lpc18xx_pwm->dev,
 			"maximum number of simultaneous channels reached\n");
 		return -EBUSY;
-	};
+	}
 
 	set_bit(event, &lpc18xx_pwm->event_map);
 	lpc18xx_data->duty_event = event;
