Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D3281F9E5A
	for <lists+linux-pwm@lfdr.de>; Mon, 15 Jun 2020 19:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731167AbgFOR0L (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 15 Jun 2020 13:26:11 -0400
Received: from mga07.intel.com ([134.134.136.100]:59328 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729682AbgFOR0K (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 15 Jun 2020 13:26:10 -0400
IronPort-SDR: lWtIzt5AOH2pa44vhutIXzHUmSbF4N++1LfN3moRgltZ5KrtAATtXz0T+tQCAlXhpxNq7u5S32
 Vi1OkooECZ2Q==
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2020 10:26:07 -0700
IronPort-SDR: qRGgKHp4MjpK5tGyU6xaMRnbjPtkhyD/zw7ZB2OHcldiSO1aDvLHXlFx1tHpHgDof7RHiZe5eb
 c/4rKtmUOsjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,515,1583222400"; 
   d="gz'50?scan'50,208,50";a="351434743"
Received: from lkp-server02.sh.intel.com (HELO ec7aa6149bd9) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 15 Jun 2020 10:26:04 -0700
Received: from kbuild by ec7aa6149bd9 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jksrz-00007f-IF; Mon, 15 Jun 2020 17:26:03 +0000
Date:   Tue, 16 Jun 2020 01:25:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     kbuild-all@lists.01.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Guru Das Srinagesh <gurus@codeaurora.org>,
        linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] video: ssd1307fb: Print PWM period using 64-bit
 format specifier
Message-ID: <202006160158.b6D0fvrq%lkp@intel.com>
References: <20200615141606.2814208-2-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="KsGdsel6WgEHnImy"
Content-Disposition: inline
In-Reply-To: <20200615141606.2814208-2-thierry.reding@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--KsGdsel6WgEHnImy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Thierry,

I love your patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v5.8-rc1 next-20200615]
[cannot apply to pwm/for-next]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Thierry-Reding/pwm-Miscellaneous-fixes-for-64-bit-support/20200615-221856
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git b3a9e3b9622ae10064826dccb4f7a52bd88c7407
config: h8300-randconfig-r004-20200615 (attached as .config)
compiler: h8300-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=h8300 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>, old ones prefixed by <<):

In file included from include/linux/printk.h:404,
from include/linux/kernel.h:15,
from include/asm-generic/bug.h:19,
from arch/h8300/include/asm/bug.h:8,
from include/linux/bug.h:5,
from include/linux/thread_info.h:12,
from include/asm-generic/current.h:5,
from ./arch/h8300/include/generated/asm/current.h:1,
from include/linux/sched.h:12,
from include/linux/ratelimit.h:6,
from include/linux/dev_printk.h:16,
from include/linux/device.h:15,
from include/linux/backlight.h:12,
from drivers/video/fbdev/ssd1307fb.c:8:
drivers/video/fbdev/ssd1307fb.c: In function 'ssd1307fb_init':
>> drivers/video/fbdev/ssd1307fb.c:315:30: warning: format '%llu' expects argument of type 'long long unsigned int', but argument 5 has type 'unsigned int' [-Wformat=]
315 |   dev_dbg(&par->client->dev, "Using PWM%d with a %lluns period.n",
|                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
include/linux/dynamic_debug.h:125:15: note: in definition of macro '__dynamic_func_call'
125 |   func(&id, ##__VA_ARGS__);           |               ^~~~~~~~~~~
include/linux/dynamic_debug.h:157:2: note: in expansion of macro '_dynamic_func_call'
157 |  _dynamic_func_call(fmt,__dynamic_dev_dbg,            |  ^~~~~~~~~~~~~~~~~~
include/linux/dev_printk.h:115:2: note: in expansion of macro 'dynamic_dev_dbg'
115 |  dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
|  ^~~~~~~~~~~~~~~
include/linux/dev_printk.h:115:23: note: in expansion of macro 'dev_fmt'
115 |  dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
|                       ^~~~~~~
drivers/video/fbdev/ssd1307fb.c:315:3: note: in expansion of macro 'dev_dbg'
315 |   dev_dbg(&par->client->dev, "Using PWM%d with a %lluns period.n",
|   ^~~~~~~
drivers/video/fbdev/ssd1307fb.c:315:53: note: format string is defined here
315 |   dev_dbg(&par->client->dev, "Using PWM%d with a %lluns period.n",
|                                                  ~~~^
|                                                     |
|                                                     long long unsigned int
|                                                  %u

vim +315 drivers/video/fbdev/ssd1307fb.c

   294	
   295	static int ssd1307fb_init(struct ssd1307fb_par *par)
   296	{
   297		struct pwm_state pwmstate;
   298		int ret;
   299		u32 precharge, dclk, com_invdir, compins;
   300	
   301		if (par->device_info->need_pwm) {
   302			par->pwm = pwm_get(&par->client->dev, NULL);
   303			if (IS_ERR(par->pwm)) {
   304				dev_err(&par->client->dev, "Could not get PWM from device tree!\n");
   305				return PTR_ERR(par->pwm);
   306			}
   307	
   308			pwm_init_state(par->pwm, &pwmstate);
   309			pwm_set_relative_duty_cycle(&pwmstate, 50, 100);
   310			pwm_apply_state(par->pwm, &pwmstate);
   311	
   312			/* Enable the PWM */
   313			pwm_enable(par->pwm);
   314	
 > 315			dev_dbg(&par->client->dev, "Using PWM%d with a %lluns period.\n",
   316				par->pwm->pwm, pwm_get_period(par->pwm));
   317		}
   318	
   319		/* Set initial contrast */
   320		ret = ssd1307fb_write_cmd(par->client, SSD1307FB_CONTRAST);
   321		if (ret < 0)
   322			return ret;
   323	
   324		ret = ssd1307fb_write_cmd(par->client, par->contrast);
   325		if (ret < 0)
   326			return ret;
   327	
   328		/* Set segment re-map */
   329		if (par->seg_remap) {
   330			ret = ssd1307fb_write_cmd(par->client, SSD1307FB_SEG_REMAP_ON);
   331			if (ret < 0)
   332				return ret;
   333		}
   334	
   335		/* Set COM direction */
   336		com_invdir = 0xc0 | par->com_invdir << 3;
   337		ret = ssd1307fb_write_cmd(par->client,  com_invdir);
   338		if (ret < 0)
   339			return ret;
   340	
   341		/* Set multiplex ratio value */
   342		ret = ssd1307fb_write_cmd(par->client, SSD1307FB_SET_MULTIPLEX_RATIO);
   343		if (ret < 0)
   344			return ret;
   345	
   346		ret = ssd1307fb_write_cmd(par->client, par->height - 1);
   347		if (ret < 0)
   348			return ret;
   349	
   350		/* set display offset value */
   351		ret = ssd1307fb_write_cmd(par->client, SSD1307FB_SET_DISPLAY_OFFSET);
   352		if (ret < 0)
   353			return ret;
   354	
   355		ret = ssd1307fb_write_cmd(par->client, par->com_offset);
   356		if (ret < 0)
   357			return ret;
   358	
   359		/* Set clock frequency */
   360		ret = ssd1307fb_write_cmd(par->client, SSD1307FB_SET_CLOCK_FREQ);
   361		if (ret < 0)
   362			return ret;
   363	
   364		dclk = ((par->dclk_div - 1) & 0xf) | (par->dclk_frq & 0xf) << 4;
   365		ret = ssd1307fb_write_cmd(par->client, dclk);
   366		if (ret < 0)
   367			return ret;
   368	
   369		/* Set Set Area Color Mode ON/OFF & Low Power Display Mode */
   370		if (par->area_color_enable || par->low_power) {
   371			u32 mode;
   372	
   373			ret = ssd1307fb_write_cmd(par->client,
   374						  SSD1307FB_SET_AREA_COLOR_MODE);
   375			if (ret < 0)
   376				return ret;
   377	
   378			mode = (par->area_color_enable ? 0x30 : 0) |
   379				(par->low_power ? 5 : 0);
   380			ret = ssd1307fb_write_cmd(par->client, mode);
   381			if (ret < 0)
   382				return ret;
   383		}
   384	
   385		/* Set precharge period in number of ticks from the internal clock */
   386		ret = ssd1307fb_write_cmd(par->client, SSD1307FB_SET_PRECHARGE_PERIOD);
   387		if (ret < 0)
   388			return ret;
   389	
   390		precharge = (par->prechargep1 & 0xf) | (par->prechargep2 & 0xf) << 4;
   391		ret = ssd1307fb_write_cmd(par->client, precharge);
   392		if (ret < 0)
   393			return ret;
   394	
   395		/* Set COM pins configuration */
   396		ret = ssd1307fb_write_cmd(par->client, SSD1307FB_SET_COM_PINS_CONFIG);
   397		if (ret < 0)
   398			return ret;
   399	
   400		compins = 0x02 | !par->com_seq << 4 | par->com_lrremap << 5;
   401		ret = ssd1307fb_write_cmd(par->client, compins);
   402		if (ret < 0)
   403			return ret;
   404	
   405		/* Set VCOMH */
   406		ret = ssd1307fb_write_cmd(par->client, SSD1307FB_SET_VCOMH);
   407		if (ret < 0)
   408			return ret;
   409	
   410		ret = ssd1307fb_write_cmd(par->client, par->vcomh);
   411		if (ret < 0)
   412			return ret;
   413	
   414		/* Turn on the DC-DC Charge Pump */
   415		ret = ssd1307fb_write_cmd(par->client, SSD1307FB_CHARGE_PUMP);
   416		if (ret < 0)
   417			return ret;
   418	
   419		ret = ssd1307fb_write_cmd(par->client,
   420			BIT(4) | (par->device_info->need_chargepump ? BIT(2) : 0));
   421		if (ret < 0)
   422			return ret;
   423	
   424		/* Set lookup table */
   425		if (par->lookup_table_set) {
   426			int i;
   427	
   428			ret = ssd1307fb_write_cmd(par->client,
   429						  SSD1307FB_SET_LOOKUP_TABLE);
   430			if (ret < 0)
   431				return ret;
   432	
   433			for (i = 0; i < ARRAY_SIZE(par->lookup_table); ++i) {
   434				u8 val = par->lookup_table[i];
   435	
   436				if (val < 31 || val > 63)
   437					dev_warn(&par->client->dev,
   438						 "lookup table index %d value out of range 31 <= %d <= 63\n",
   439						 i, val);
   440				ret = ssd1307fb_write_cmd(par->client, val);
   441				if (ret < 0)
   442					return ret;
   443			}
   444		}
   445	
   446		/* Switch to horizontal addressing mode */
   447		ret = ssd1307fb_write_cmd(par->client, SSD1307FB_SET_ADDRESS_MODE);
   448		if (ret < 0)
   449			return ret;
   450	
   451		ret = ssd1307fb_write_cmd(par->client,
   452					  SSD1307FB_SET_ADDRESS_MODE_HORIZONTAL);
   453		if (ret < 0)
   454			return ret;
   455	
   456		/* Set column range */
   457		ret = ssd1307fb_write_cmd(par->client, SSD1307FB_SET_COL_RANGE);
   458		if (ret < 0)
   459			return ret;
   460	
   461		ret = ssd1307fb_write_cmd(par->client, 0x0);
   462		if (ret < 0)
   463			return ret;
   464	
   465		ret = ssd1307fb_write_cmd(par->client, par->width - 1);
   466		if (ret < 0)
   467			return ret;
   468	
   469		/* Set page range */
   470		ret = ssd1307fb_write_cmd(par->client, SSD1307FB_SET_PAGE_RANGE);
   471		if (ret < 0)
   472			return ret;
   473	
   474		ret = ssd1307fb_write_cmd(par->client, par->page_offset);
   475		if (ret < 0)
   476			return ret;
   477	
   478		ret = ssd1307fb_write_cmd(par->client,
   479					  par->page_offset +
   480					  DIV_ROUND_UP(par->height, 8) - 1);
   481		if (ret < 0)
   482			return ret;
   483	
   484		/* Clear the screen */
   485		ssd1307fb_update_display(par);
   486	
   487		/* Turn on the display */
   488		ret = ssd1307fb_write_cmd(par->client, SSD1307FB_DISPLAY_ON);
   489		if (ret < 0)
   490			return ret;
   491	
   492		return 0;
   493	}
   494	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--KsGdsel6WgEHnImy
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
KGKvRfmxZ+pl9eRNZDfsJpK3WKb/rkmTOTazKp3D3mLOdHqcRFEpDaaE9ThvJ4JMIySdOojd
5krTcylwylrFFRVYNhM603T6GGaPKVC+wDw75qST9JPk5fXwcRK+bH+8vSptvNjsHrT0BClm
IkbHkyRJ2dAUisdkBiWoVx2J4zMpiwGMniRl2laco3Y6Fj8aRTpJUmDZ6oiSyTe8h6YVbUq7
Rxa8W2Bl+0Lk3BRZXcNyCIulp99ySYWpmLMa83TnKldBWAHv32ThCKL3hrkgx/TofkJidVNK
wuTsoYsu9xpzgODnWfp+ypWeRemJxv/X4bXZ4Z09NOz57Vj/rOGf+rj99OnTv6n4inFWgKFU
+Gv/xIQe8j7q80M9Z4KzVa6Fpyio2gGB/oBG2BOyDZhX1w1cFmEyKDGPEga0G5vd1UoJxO8v
/o8u6hmi7QULFFYj8X0PPmZf6dmQfqnU6QmDtqUAlRP6Qi+NR2b6D7V432+Omwmu2ls8yLOs
czwUtJZZDpjPTYiM3Q80Y1Gp+MoTBZbHzLKyy0xgTJQR2XT+LmwQlFcgvkHdrLklZzUY33Aw
smGFw5x9lqeQRkGfHifK+AwDiPOvaWBKl/JSE1VvGSgZZTlnVgJ8RaCSRYAdhJcDvFC5wISF
dgKCR8y8pnUS3f0W9eGIYxZ1k4sZETcPNZ3GyzLmfbDbb43bxiQDRfRNbS7IocEMxuMpatpK
lcWep+OOElTsPHnpcPoggjAPBe+og0hlqUnTkOUMFJFY+p1ztskbncDb1Wzs8RkqCrJh0oVl
NgvqpZFL3qnbA7Dsu8mNGnNVqlm7GZhieISNgxV1HF4Rs20He8Me0LpfKD8YLOdRdV7yPzGd
u7EMRgEA

--KsGdsel6WgEHnImy--
