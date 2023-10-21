Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D206E7D207C
	for <lists+linux-pwm@lfdr.de>; Sun, 22 Oct 2023 01:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbjJUXzr (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 21 Oct 2023 19:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231624AbjJUXzq (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 21 Oct 2023 19:55:46 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E59AD68;
        Sat, 21 Oct 2023 16:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697932540; x=1729468540;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=14/ngXnade/NJsLUk5wX9HBENWxj2wB/+XO3Lt6T00k=;
  b=nm5MU4Lxga+K3C+RWgBmkbcer6p/wPe0apOu26M1XmolVurLXGonWsgN
   xBB0UnINcvwFVDtr0uJ6bMtqS7A7ZEFN+EMfQe6CAhpKFf/Y03QNTtfL0
   Y25alho8kwc4K+k1O9+3c7zWpGOsRj/C9VrFtj8GpzjDlHbztBhOXFDhU
   EU/k798V65/aWbp8unqCyiW5cNp1mO52U9NplDgbo7VlmopeDn1KIOrx0
   SQ6N4jWoUsPMbs1H+vASPBkDWXNXY7pOZExSVy3L3s0wmhIqncOLqYjTy
   Wy/L0o1fgVjsXC+lGECyqQ/YpG8i5l0S9dlsm2tGL5OAoAo3XXaZuiXFU
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10870"; a="472887238"
X-IronPort-AV: E=Sophos;i="6.03,242,1694761200"; 
   d="scan'208";a="472887238"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2023 16:55:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10870"; a="751278907"
X-IronPort-AV: E=Sophos;i="6.03,242,1694761200"; 
   d="scan'208";a="751278907"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 21 Oct 2023 16:55:32 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1quLoX-0005Oc-30;
        Sat, 21 Oct 2023 23:55:29 +0000
Date:   Sun, 22 Oct 2023 07:55:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sean Young <sean@mess.org>, linux-media@vger.kernel.org,
        linux-pwm@vger.kernel.org,
        Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Support Opensource <support.opensource@diasemi.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Mark Gross <markgross@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>
Cc:     oe-kbuild-all@lists.linux.dev, linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 1/3] pwm: make it possible to apply pwm changes in
 atomic context
Message-ID: <202310220706.HH9RMDHJ-lkp@intel.com>
References: <a7fcd19938d5422abc59c968ff7b3d5c275577ed.1697534024.git.sean@mess.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a7fcd19938d5422abc59c968ff7b3d5c275577ed.1697534024.git.sean@mess.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Sean,

kernel test robot noticed the following build errors:

[auto build test ERROR on media-tree/master]
[also build test ERROR on linus/master v6.6-rc6]
[cannot apply to thierry-reding-pwm/for-next dtor-input/next dtor-input/for-linus next-20231020]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Sean-Young/pwm-make-it-possible-to-apply-pwm-changes-in-atomic-context/20231017-173221
base:   git://linuxtv.org/media_tree.git master
patch link:    https://lore.kernel.org/r/a7fcd19938d5422abc59c968ff7b3d5c275577ed.1697534024.git.sean%40mess.org
patch subject: [PATCH v3 1/3] pwm: make it possible to apply pwm changes in atomic context
config: openrisc-allmodconfig (https://download.01.org/0day-ci/archive/20231022/202310220706.HH9RMDHJ-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231022/202310220706.HH9RMDHJ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310220706.HH9RMDHJ-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/media/rc/ir-rx51.c: In function 'ir_rx51_on':
>> drivers/media/rc/ir-rx51.c:37:9: error: implicit declaration of function 'pwm_apply_state'; did you mean 'pwm_apply_args'? [-Werror=implicit-function-declaration]
      37 |         pwm_apply_state(ir_rx51->pwm, &ir_rx51->state);
         |         ^~~~~~~~~~~~~~~
         |         pwm_apply_args
   cc1: some warnings being treated as errors


vim +37 drivers/media/rc/ir-rx51.c

c332e8472d7db6 Timo Kokkonen 2012-08-10  33  
a92def1becf33e Sean Young    2016-12-19  34  static inline void ir_rx51_on(struct ir_rx51 *ir_rx51)
c332e8472d7db6 Timo Kokkonen 2012-08-10  35  {
99076cd117c4cb Maíra Canal   2021-11-04  36  	ir_rx51->state.enabled = true;
99076cd117c4cb Maíra Canal   2021-11-04 @37  	pwm_apply_state(ir_rx51->pwm, &ir_rx51->state);
c332e8472d7db6 Timo Kokkonen 2012-08-10  38  }
c332e8472d7db6 Timo Kokkonen 2012-08-10  39  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
