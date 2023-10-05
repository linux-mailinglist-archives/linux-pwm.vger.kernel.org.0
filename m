Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C59A97BA91A
	for <lists+linux-pwm@lfdr.de>; Thu,  5 Oct 2023 20:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231332AbjJESaI (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 5 Oct 2023 14:30:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbjJESaF (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 5 Oct 2023 14:30:05 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9601AD;
        Thu,  5 Oct 2023 11:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696530602; x=1728066602;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mgH9mjU70d488SDsVbeAEChvBEQGjntDusGMNaqHH8g=;
  b=M88KnO5WUurS4ZIgtHVvhVOVLInkEH9k86+an0xZTt9dBdMy414DWgfd
   PUjGgeL9JYzPy2TVP7Jr8rALNp3A7W0DpmkET22EbvTSiCWdamytDXYKk
   SlPFvl10rPjyqZIryDm/H3ogkSwCtbUhIqVzX6/Xzj0kDKLKsozHdWZi7
   9H1B205wPtenjKJtPnPPDMCyxs4jVRv7fJaf/YWGQhpPFLkaeAdmfVK9M
   hoxNoSoXB38VLI8lwmPRyqndr4/M7GUIGxJRXVID0l27TT4pfbpJsQc0Q
   R6HiQ3taA2NdMMi7GwL2NdfhBJXXPBPNRhD8MINm9qJADJct3j63cbJWz
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="382451966"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="382451966"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 11:30:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="999042597"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="999042597"
Received: from lkp-server02.sh.intel.com (HELO c3b01524d57c) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 05 Oct 2023 11:29:59 -0700
Received: from kbuild by c3b01524d57c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qoT6j-000LmG-0M;
        Thu, 05 Oct 2023 18:29:57 +0000
Date:   Fri, 6 Oct 2023 02:29:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Biju Das <biju.das.jz@bp.renesas.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     oe-kbuild-all@lists.linux.dev,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>, linux-pwm@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v16 3/4] pwm: Add support for RZ/G2L GPT
Message-ID: <202310060218.5lQtUezc-lkp@intel.com>
References: <20231004111451.126195-4-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231004111451.126195-4-biju.das.jz@bp.renesas.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Biju,

kernel test robot noticed the following build errors:

[auto build test ERROR on 4aae44f65827f0213a7361cf9c32cfe06114473f]

url:    https://github.com/intel-lab-lkp/linux/commits/Biju-Das/dt-bindings-pwm-Add-RZ-G2L-GPT-binding/20231004-231907
base:   4aae44f65827f0213a7361cf9c32cfe06114473f
patch link:    https://lore.kernel.org/r/20231004111451.126195-4-biju.das.jz%40bp.renesas.com
patch subject: [PATCH v16 3/4] pwm: Add support for RZ/G2L GPT
config: mips-allyesconfig (https://download.01.org/0day-ci/archive/20231006/202310060218.5lQtUezc-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231006/202310060218.5lQtUezc-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310060218.5lQtUezc-lkp@intel.com/

All errors (new ones prefixed by >>):

   arch/mips/kernel/head.o: in function `kernel_entry':
   (.ref.text+0xac): relocation truncated to fit: R_MIPS_26 against `start_kernel'
   init/main.o: in function `set_reset_devices':
   main.c:(.init.text+0x10): relocation truncated to fit: R_MIPS_26 against `_mcount'
   main.c:(.init.text+0x18): relocation truncated to fit: R_MIPS_26 against `__sanitizer_cov_trace_pc'
   init/main.o: in function `debug_kernel':
   main.c:(.init.text+0x50): relocation truncated to fit: R_MIPS_26 against `_mcount'
   main.c:(.init.text+0x58): relocation truncated to fit: R_MIPS_26 against `__sanitizer_cov_trace_pc'
   init/main.o: in function `quiet_kernel':
   main.c:(.init.text+0x90): relocation truncated to fit: R_MIPS_26 against `_mcount'
   main.c:(.init.text+0x98): relocation truncated to fit: R_MIPS_26 against `__sanitizer_cov_trace_pc'
   init/main.o: in function `warn_bootconfig':
   main.c:(.init.text+0xd0): relocation truncated to fit: R_MIPS_26 against `_mcount'
   main.c:(.init.text+0xd8): relocation truncated to fit: R_MIPS_26 against `__sanitizer_cov_trace_pc'
   init/main.o: in function `init_setup':
   main.c:(.init.text+0x108): relocation truncated to fit: R_MIPS_26 against `_mcount'
   main.c:(.init.text+0x114): additional relocation overflows omitted from the output
   mips-linux-ld: drivers/pwm/pwm-rzg2l-gpt.o: in function `rzg2l_gpt_calculate_pv_or_dc':
>> pwm-rzg2l-gpt.c:(.text.rzg2l_gpt_calculate_pv_or_dc+0x138): undefined reference to `__udivdi3'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
