Return-Path: <linux-pwm+bounces-1305-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C84853DF1
	for <lists+linux-pwm@lfdr.de>; Tue, 13 Feb 2024 23:03:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9078DB2F070
	for <lists+linux-pwm@lfdr.de>; Tue, 13 Feb 2024 22:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C6F7664C4;
	Tue, 13 Feb 2024 21:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bQU8V6E6"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FFD165BAA;
	Tue, 13 Feb 2024 21:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707861504; cv=none; b=Yz2KV8+5xhfy/F67ZksMf2Fqs38pDlbQIilQFLgULB+p2SlefVUJ7stNPr/6nSgtA3y3S80w7dIbVaV8+Riy3VBX7cyOo6V19y53WR0wjsX7I79vTiUMuiceFv2iQ6nUybVHxG1lAFCAXA4QvAWNherw4+WfS+5GRmJvTpKOynY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707861504; c=relaxed/simple;
	bh=QZtp6zFSJB9KAqD6mHzlmSSAFRT2TanT7mhlKfjwml4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uSCSxzcGDlK0O03jlqnSpkx/RvPZRQEmuWcQI+PZrXB1swbse2BgBUbETw/97Ns4sSlo8wmaIXdeDgb0T4UrI0VN73cuvkS55H12ESYzaQzA/WhUwkIgPKnCLwxbSG+rPUF4LO0813ZAsEISwSaWka2UTunNnYsb9kTpe7OVzYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bQU8V6E6; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707861502; x=1739397502;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QZtp6zFSJB9KAqD6mHzlmSSAFRT2TanT7mhlKfjwml4=;
  b=bQU8V6E6qhV+r/nkG0+zeTp+0uyc/JQNQbasnPMXJLvm7VKBzMANMCQi
   ywMEGQSdlEx7zGgy7ISwOT5NqpcZQCz3tx/MeWNdg8LaKv68jiaTpA8fp
   08vqHaS1k+HPKe2Vz879R3XR+ryyvK6clsOFDFHMhf1AmYNDsm/6b+RBB
   9IVAnOzOnUssNp9vUZmFZ5JkauFXtBMdq6z7DYDVOPeS8gJWnfMSLygZ+
   cqG4KZg7SfWsPI+yU3B1pJOAYZXzP+7PFpVeERJxWJxWpy8Vn0JboknSV
   5te1X/yXB8wZPcidBXryqesKewDr0+KZ7octVeZh2xNcQVs3zpxPnMC3W
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="12611759"
X-IronPort-AV: E=Sophos;i="6.06,158,1705392000"; 
   d="scan'208";a="12611759"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2024 13:58:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="911908559"
X-IronPort-AV: E=Sophos;i="6.06,158,1705392000"; 
   d="scan'208";a="911908559"
Received: from lkp-server01.sh.intel.com (HELO 01f0647817ea) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 13 Feb 2024 13:58:17 -0800
Received: from kbuild by 01f0647817ea with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ra0nA-00086a-0K;
	Tue, 13 Feb 2024 21:58:16 +0000
Date: Wed, 14 Feb 2024 05:57:42 +0800
From: kernel test robot <lkp@intel.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, lee@kernel.org,
	daniel.thompson@linaro.org, jingoohan1@gmail.com, deller@gmx.de,
	javierm@redhat.com
Cc: oe-kbuild-all@lists.linux.dev, dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org, linux-input@vger.kernel.org,
	linux-pwm@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>,
	Bruno =?iso-8859-1?Q?Pr=E9mont?= <bonbons@linux-vserver.org>
Subject: Re: [PATCH 04/10] hid/hid-picolcd: Remove struct
 backlight_ops.check_fb
Message-ID: <202402140514.sb1rerJx-lkp@intel.com>
References: <20240212162645.5661-5-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240212162645.5661-5-tzimmermann@suse.de>

Hi Thomas,

kernel test robot noticed the following build errors:

[auto build test ERROR on lee-backlight/for-backlight-next]
[also build test ERROR on lee-backlight/for-backlight-fixes hid/for-next lee-leds/for-leds-next linus/master v6.8-rc4 next-20240213]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Thomas-Zimmermann/backlight-Match-backlight-device-against-struct-fb_info-bl_dev/20240213-002853
base:   https://git.kernel.org/pub/scm/linux/kernel/git/lee/backlight.git for-backlight-next
patch link:    https://lore.kernel.org/r/20240212162645.5661-5-tzimmermann%40suse.de
patch subject: [PATCH 04/10] hid/hid-picolcd: Remove struct backlight_ops.check_fb
config: x86_64-rhel-8.3 (https://download.01.org/0day-ci/archive/20240214/202402140514.sb1rerJx-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240214/202402140514.sb1rerJx-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402140514.sb1rerJx-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/hid/hid-picolcd_fb.c: In function 'picolcd_init_framebuffer':
>> drivers/hid/hid-picolcd_fb.c:497:13: error: 'struct fb_info' has no member named 'bl_dev'
     497 |         info->bl_dev = data->backlight;
         |             ^~


vim +497 drivers/hid/hid-picolcd_fb.c

   459	
   460	static DEVICE_ATTR(fb_update_rate, 0664, picolcd_fb_update_rate_show,
   461			picolcd_fb_update_rate_store);
   462	
   463	/* initialize Framebuffer device */
   464	int picolcd_init_framebuffer(struct picolcd_data *data)
   465	{
   466		struct device *dev = &data->hdev->dev;
   467		struct fb_info *info = NULL;
   468		struct picolcd_fb_data *fbdata = NULL;
   469		int i, error = -ENOMEM;
   470		u32 *palette;
   471	
   472		/* The extra memory is:
   473		 * - 256*u32 for pseudo_palette
   474		 * - struct fb_deferred_io
   475		 */
   476		info = framebuffer_alloc(256 * sizeof(u32) +
   477				sizeof(struct fb_deferred_io) +
   478				sizeof(struct picolcd_fb_data) +
   479				PICOLCDFB_SIZE, dev);
   480		if (!info)
   481			goto err_nomem;
   482	
   483		info->fbdefio = info->par;
   484		*info->fbdefio = picolcd_fb_defio;
   485		info->par += sizeof(struct fb_deferred_io);
   486		palette = info->par;
   487		info->par += 256 * sizeof(u32);
   488		for (i = 0; i < 256; i++)
   489			palette[i] = i > 0 && i < 16 ? 0xff : 0;
   490		info->pseudo_palette = palette;
   491		info->fbops = &picolcdfb_ops;
   492		info->var = picolcdfb_var;
   493		info->fix = picolcdfb_fix;
   494		info->fix.smem_len   = PICOLCDFB_SIZE*8;
   495	
   496	#ifdef CONFIG_HID_PICOLCD_BACKLIGHT
 > 497		info->bl_dev = data->backlight;
   498	#endif
   499	
   500		fbdata = info->par;
   501		spin_lock_init(&fbdata->lock);
   502		fbdata->picolcd = data;
   503		fbdata->update_rate = PICOLCDFB_UPDATE_RATE_DEFAULT;
   504		fbdata->bpp     = picolcdfb_var.bits_per_pixel;
   505		fbdata->force   = 1;
   506		fbdata->vbitmap = info->par + sizeof(struct picolcd_fb_data);
   507		fbdata->bitmap  = vmalloc(PICOLCDFB_SIZE*8);
   508		if (fbdata->bitmap == NULL) {
   509			dev_err(dev, "can't get a free page for framebuffer\n");
   510			goto err_nomem;
   511		}
   512		info->flags |= FBINFO_VIRTFB;
   513		info->screen_buffer = fbdata->bitmap;
   514		info->fix.smem_start = (unsigned long)fbdata->bitmap;
   515		memset(fbdata->vbitmap, 0xff, PICOLCDFB_SIZE);
   516		data->fb_info = info;
   517	
   518		error = picolcd_fb_reset(data, 1);
   519		if (error) {
   520			dev_err(dev, "failed to configure display\n");
   521			goto err_cleanup;
   522		}
   523	
   524		error = device_create_file(dev, &dev_attr_fb_update_rate);
   525		if (error) {
   526			dev_err(dev, "failed to create sysfs attributes\n");
   527			goto err_cleanup;
   528		}
   529	
   530		fb_deferred_io_init(info);
   531		error = register_framebuffer(info);
   532		if (error) {
   533			dev_err(dev, "failed to register framebuffer\n");
   534			goto err_sysfs;
   535		}
   536		return 0;
   537	
   538	err_sysfs:
   539		device_remove_file(dev, &dev_attr_fb_update_rate);
   540		fb_deferred_io_cleanup(info);
   541	err_cleanup:
   542		data->fb_info    = NULL;
   543	
   544	err_nomem:
   545		if (fbdata)
   546			vfree(fbdata->bitmap);
   547		framebuffer_release(info);
   548		return error;
   549	}
   550	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

