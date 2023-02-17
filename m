Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91D1F69B522
	for <lists+linux-pwm@lfdr.de>; Fri, 17 Feb 2023 22:53:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbjBQVxr (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 17 Feb 2023 16:53:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjBQVxr (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 17 Feb 2023 16:53:47 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 163DA4FCAE
        for <linux-pwm@vger.kernel.org>; Fri, 17 Feb 2023 13:53:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676670826; x=1708206826;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=d/ouMf+/n6H9YOcrk81UbPaxHszdsDffyZ2+lUPOVyU=;
  b=f8h6nTVgcTtkQl65pbOTwOuAzRySSvaEJVuQb7erDwpHfUgjJsnUvFdM
   efNQRuEPu3CbVCwUY4giHFomzHPysymln2mtH1PAA7NsBdx7zoxvPPwUO
   pc31S/1oLtO5JuAPSs/asdH9Wu0kOPeEqVnUA9aQm6HLtDU2ZDQpts2Qy
   YKjYZOV/Bsf80ezd1OIlXinBOwbktcAO0RkbMso8SYQ/XTyt+KUoA0VvY
   PDpN/+5OvCDH/+5MGfMBWnrr+SZ/vlf5/gvtaLhpUzZQ+p5QYj4Ju0Ytq
   4Au1H/4gZYFblTR0PCLIrtOr1kHGqqLGl82x2L8OjCX1nB+KRvunDftUg
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10624"; a="418320155"
X-IronPort-AV: E=Sophos;i="5.97,306,1669104000"; 
   d="scan'208";a="418320155"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2023 13:53:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10624"; a="664008588"
X-IronPort-AV: E=Sophos;i="5.97,306,1669104000"; 
   d="scan'208";a="664008588"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 17 Feb 2023 13:53:35 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pT8fe-000BqT-2g;
        Fri, 17 Feb 2023 21:53:34 +0000
Date:   Sat, 18 Feb 2023 05:53:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ben Dooks <ben.dooks@sifive.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>
Subject: [thierry-reding-pwm:for-next 10/13] drivers/pwm/pwm-dwc.c:314:1:
 warning: data definition has no type or storage class
Message-ID: <202302180504.FZilVS8T-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Ben,

FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git for-next
head:   7a77daf8223e772a225d6aa6202a5b1ae2392caf
commit: c901a57e39db555ad7950fd61e1470cdecc8e654 [10/13] pwm: dwc: allow driver to be built with COMPILE_TEST
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20230218/202302180504.FZilVS8T-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git/commit/?id=c901a57e39db555ad7950fd61e1470cdecc8e654
        git remote add thierry-reding-pwm https://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git
        git fetch --no-tags thierry-reding-pwm for-next
        git checkout c901a57e39db555ad7950fd61e1470cdecc8e654
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash drivers/pwm/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302180504.FZilVS8T-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/pwm/pwm-dwc.c:314:1: warning: data definition has no type or storage class
     314 | module_pci_driver(dwc_pwm_driver);
         | ^~~~~~~~~~~~~~~~~
   drivers/pwm/pwm-dwc.c:314:1: error: type defaults to 'int' in declaration of 'module_pci_driver' [-Werror=implicit-int]
>> drivers/pwm/pwm-dwc.c:314:1: warning: parameter names (without types) in function declaration
   drivers/pwm/pwm-dwc.c:304:26: warning: 'dwc_pwm_driver' defined but not used [-Wunused-variable]
     304 | static struct pci_driver dwc_pwm_driver = {
         |                          ^~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +314 drivers/pwm/pwm-dwc.c

1ed2b3fca64516 Jarkko Nikula 2020-10-02  313  
1ed2b3fca64516 Jarkko Nikula 2020-10-02 @314  module_pci_driver(dwc_pwm_driver);
1ed2b3fca64516 Jarkko Nikula 2020-10-02  315  

:::::: The code at line 314 was first introduced by commit
:::::: 1ed2b3fca64516d1b3503ef21929f3b5f4f41cc6 pwm: Add DesignWare PWM Controller Driver

:::::: TO: Jarkko Nikula <jarkko.nikula@linux.intel.com>
:::::: CC: Thierry Reding <thierry.reding@gmail.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
