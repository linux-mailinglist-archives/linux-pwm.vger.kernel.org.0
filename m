Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 890573B0B5F
	for <lists+linux-pwm@lfdr.de>; Tue, 22 Jun 2021 19:26:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231133AbhFVR2U (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 22 Jun 2021 13:28:20 -0400
Received: from guitar.tcltek.co.il ([192.115.133.116]:57678 "EHLO
        mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230338AbhFVR2T (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 22 Jun 2021 13:28:19 -0400
Received: from tarshish (unknown [10.0.8.3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx.tkos.co.il (Postfix) with ESMTPS id 2D5CA4402B1;
        Tue, 22 Jun 2021 20:25:49 +0300 (IDT)
References: <f97c32aa98c9cdd977fac22cd504ad97448949e9.1624348502.git.baruch@tkos.co.il>
 <202106222154.DXCnEs3v-lkp@intel.com>
User-agent: mu4e 1.4.15; emacs 27.1
From:   Baruch Siach <baruch@tkos.co.il>
To:     kernel test robot <lkp@intel.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?utf-8?Q?Kleine-K?= =?utf-8?Q?=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        kbuild-all@lists.01.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Balaji Prakash J <bjagadee@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        Robert Marko <robert.marko@sartura.hr>,
        linux-pwm@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v3 1/3] pwm: driver for qualcomm ipq6018 pwm block
In-reply-to: <202106222154.DXCnEs3v-lkp@intel.com>
Date:   Tue, 22 Jun 2021 20:25:58 +0300
Message-ID: <87zgvh95g9.fsf@tarshish>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi lkp,

Thanks for the report.

Adding m68k maintainer to Cc.

On Tue, Jun 22 2021, kernel test robot wrote:
> I love your patch! Yet something to improve:
>
> [auto build test ERROR on pwm/for-next]
> [also build test ERROR on robh/for-next v5.13-rc7 next-20210621]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
>
> url:    https://github.com/0day-ci/linux/commits/Baruch-Siach/pwm-driver-for-qualcomm-ipq6018-pwm-block/20210622-155719
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git for-next
> config: m68k-allmodconfig (attached as .config)
> compiler: m68k-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/0day-ci/linux/commit/9fe01901cd004c6d48de541eb67dd006243c9220
>         git remote add linux-review https://github.com/0day-ci/linux
>         git fetch --no-tags linux-review Baruch-Siach/pwm-driver-for-qualcomm-ipq6018-pwm-block/20210622-155719
>         git checkout 9fe01901cd004c6d48de541eb67dd006243c9220
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=m68k 
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>, old ones prefixed by <<):
>
>>> ERROR: modpost: "__divdi3" [drivers/pwm/pwm-ipq.ko] undefined!
>>> ERROR: modpost: "__udivdi3" [drivers/pwm/pwm-ipq.ko] undefined!

That is most likely related to the div64_u64() call. The sh arch also
showed a similar issue on v2:

  https://lore.kernel.org/linux-pwm/202105250028.jIIxG5w6-lkp@intel.com/

What is the right fix here? Isn't div64_u64() universally available? I
see quite a few calls under driver/pwm/. Should the driver depend on
some per-arch Kconfig symbol?

Thanks,
baruch

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
