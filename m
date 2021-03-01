Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91E00327E7F
	for <lists+linux-pwm@lfdr.de>; Mon,  1 Mar 2021 13:43:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235069AbhCAMnM (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 1 Mar 2021 07:43:12 -0500
Received: from mga01.intel.com ([192.55.52.88]:31729 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235015AbhCAMnJ (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 1 Mar 2021 07:43:09 -0500
IronPort-SDR: QbW7RI6i0jPWZwFL81+Wj6Jq5LB1Ub328plWg1rQXyRwPEf4lcF911j43lbc3UcGfRzMkrQ+X7
 C1nF+xML3i9A==
X-IronPort-AV: E=McAfee;i="6000,8403,9909"; a="206056180"
X-IronPort-AV: E=Sophos;i="5.81,215,1610438400"; 
   d="gz'50?scan'50,208,50";a="206056180"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2021 04:42:27 -0800
IronPort-SDR: DYVEJTBdvBYIuKOLTfb5adC3AV5Sy6VxPzNsg3jNeKlO0tAQIOvy2IIZg2rLrbbkBSyAjgncFj
 XKSdHWYzMNdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,215,1610438400"; 
   d="gz'50?scan'50,208,50";a="444205674"
Received: from lkp-server01.sh.intel.com (HELO 16660e54978b) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 01 Mar 2021 04:42:24 -0800
Received: from kbuild by 16660e54978b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lGhsW-0004Zy-0t; Mon, 01 Mar 2021 12:42:24 +0000
Date:   Mon, 1 Mar 2021 20:41:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-pwm@vger.kernel.org,
        linux-clk@vger.kernel.org, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v2 1/3] clk: generalize devm_clk_get() a bit
Message-ID: <202103012036.kyOD6Lc7-lkp@intel.com>
References: <20210301110821.1445756-2-uwe@kleine-koenig.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="UugvWAfsgieZRqgk"
Content-Disposition: inline
In-Reply-To: <20210301110821.1445756-2-uwe@kleine-koenig.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi "Uwe,

I love your patch! Perhaps something to improve:

[auto build test WARNING on fe07bfda2fb9cdef8a4d4008a409bb02f35f1bd8]

url:    https://github.com/0day-ci/linux/commits/Uwe-Kleine-K-nig/clk-provide-new-devm-helpers-for-prepared-and-enabled-clocks/20210301-191522
base:   fe07bfda2fb9cdef8a4d4008a409bb02f35f1bd8
config: nds32-defconfig (attached as .config)
compiler: nds32le-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/bf2779180284ed39480360900c07ce553f75e06a
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Uwe-Kleine-K-nig/clk-provide-new-devm-helpers-for-prepared-and-enabled-clocks/20210301-191522
        git checkout bf2779180284ed39480360900c07ce553f75e06a
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=nds32 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/clk/clk-devres.c:22:13: warning: no previous prototype for '__devm_clk_get' [-Wmissing-prototypes]
      22 | struct clk *__devm_clk_get(struct device *dev, const char *id,
         |             ^~~~~~~~~~~~~~


vim +/__devm_clk_get +22 drivers/clk/clk-devres.c

    21	
  > 22	struct clk *__devm_clk_get(struct device *dev, const char *id,
    23				   struct clk *(*get)(struct device *dev, const char *id),
    24				   int (*init)(struct clk *clk),
    25				   void (*exit)(struct clk *clk))
    26	{
    27		struct devm_clk_state *state;
    28		struct clk *clk;
    29		int ret;
    30	
    31		state = devres_alloc(devm_clk_release, sizeof(*state), GFP_KERNEL);
    32		if (!state)
    33			return ERR_PTR(-ENOMEM);
    34	
    35		clk = get(dev, id);
    36		if (IS_ERR(clk)) {
    37			ret = PTR_ERR(clk);
    38			goto err_clk_get;
    39		}
    40	
    41		if (init) {
    42			ret = init(clk);
    43			if (ret)
    44				goto err_clk_init;
    45		}
    46	
    47		state->clk = clk;
    48		state->exit = exit;
    49	
    50		devres_add(dev, state);
    51	
    52		return clk;
    53	
    54	err_clk_init:
    55	
    56		clk_put(clk);
    57	err_clk_get:
    58	
    59		devres_free(state);
    60		return ERR_PTR(ret);
    61	}
    62	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--UugvWAfsgieZRqgk
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--UugvWAfsgieZRqgk--
