Return-Path: <linux-pwm+bounces-3513-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7BA29935ED
	for <lists+linux-pwm@lfdr.de>; Mon,  7 Oct 2024 20:19:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99BD52867CE
	for <lists+linux-pwm@lfdr.de>; Mon,  7 Oct 2024 18:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 465491DE2AD;
	Mon,  7 Oct 2024 18:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BDiTCBmT"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684401DDC18;
	Mon,  7 Oct 2024 18:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728325157; cv=none; b=YFdeRKjXuP6KUbI6uECLexfo8GkTIGXjCgN6/gI7hZrlBh81xCfB0FHkWdQf/vpL1FDio9PcLMi9WxfYiCAuiUsQEIyYot7utkkEY+EOj89V4saL80zyOvD6jvn2C7docMRnaKgFFjxDiAOgyGpmtiWpqpaSSBd32tVvLViHTh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728325157; c=relaxed/simple;
	bh=+fqlVs8atMU9JNdpn1K4HbRS8JdgD3pcPFhRP5DgDK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UYb7Y+DHxQaNuCl+IOH3O0pzy6AiaKLFmCjtLKSSzfcX8Lt1Ey5xYkPlgoprsf6jyT4TPH6Y1id0HdxbhYF0ztf9sirDqJyBHOg3N93M+i7MM0QTmX1tgUKGtwM7dqsii070Y9hPVyYdPlbMVStZjMFOwJ61ohsthswsTVmQeEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BDiTCBmT; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728325156; x=1759861156;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+fqlVs8atMU9JNdpn1K4HbRS8JdgD3pcPFhRP5DgDK8=;
  b=BDiTCBmT60NDF8pHBIURy9ZMvqHX+TmByK7Oj8l8v3a5Eridv3pquect
   V5BMGH7e1V8LZvIWFOqL3R8yTZLLIiaWiHhKFrlQ+guLyGJw7LXhaJLCB
   ZLfl21C8ZyWYdnKpY+epIIUUaT5JoHOFjai/z/ke4wtI6lENYNO6oOoQY
   IYI4GAk76ImY+05eK4G7xrB9zuFrsVRqq1OTryo6eLo4VX53f9iPWkYbA
   bAfZlG7gN0o/Ggb3IAWkdUu85ZrTChFWqk3XQOLtSOhC29YqDecGUueJ9
   VhHebtjYCsm8VbxSxVYBDm+KfGAet2kav7jT5n0AKvYoFHfR+LFf+cTLo
   w==;
X-CSE-ConnectionGUID: r5KkQIHgQwmc3tqXDp0aSA==
X-CSE-MsgGUID: YQT/+OYrRV2ItfkPQdBakw==
X-IronPort-AV: E=McAfee;i="6700,10204,11218"; a="26949054"
X-IronPort-AV: E=Sophos;i="6.11,184,1725346800"; 
   d="scan'208";a="26949054"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 11:19:15 -0700
X-CSE-ConnectionGUID: OERP3/j8SFuuGDqa6h8Yaw==
X-CSE-MsgGUID: x/MZW99BQQGt4JlOnuv+3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,184,1725346800"; 
   d="scan'208";a="75396018"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 07 Oct 2024 11:19:09 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sxsK2-0005Ns-1T;
	Mon, 07 Oct 2024 18:19:06 +0000
Date: Tue, 8 Oct 2024 02:18:37 +0800
From: kernel test robot <lkp@intel.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Nuno Sa <nuno.sa@analog.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Mike Looijmans <mike.looijmans@topic.nl>,
	Marius Cristea <marius.cristea@microchip.com>,
	Dumitru Ceclan <mitrutzceclan@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Alisa-Dariana Roman <alisadariana@gmail.com>,
	Ivan Mikhaylov <fr0st61te@gmail.com>,
	Sergiu Cuciurean <sergiu.cuciurean@analog.com>,
	Dragos Bogdan <dragos.bogdan@analog.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-pwm@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v2 6/7] iio: adc: ad485x: add ad485x driver
Message-ID: <202410080232.6SxmYFFA-lkp@intel.com>
References: <20241004140922.233939-6-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241004140922.233939-6-antoniu.miclaus@analog.com>

Hi Antoniu,

kernel test robot noticed the following build errors:

[auto build test ERROR on v6.11]
[cannot apply to jic23-iio/togreg robh/for-next v6.12-rc1 linus/master next-20241004]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Antoniu-Miclaus/iio-backend-add-support-for-data-size-set/20241004-221608
base:   v6.11
patch link:    https://lore.kernel.org/r/20241004140922.233939-6-antoniu.miclaus%40analog.com
patch subject: [PATCH v2 6/7] iio: adc: ad485x: add ad485x driver
config: hexagon-allmodconfig (https://download.01.org/0day-ci/archive/20241008/202410080232.6SxmYFFA-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project fef3566a25ff0e34fb87339ba5e13eca17cec00f)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241008/202410080232.6SxmYFFA-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410080232.6SxmYFFA-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/iio/adc/ad485x.c:18:
   In file included from include/linux/regmap.h:20:
   In file included from include/linux/iopoll.h:14:
   In file included from include/linux/io.h:14:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:548:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     548 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:561:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     561 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
         |                                                   ^
   In file included from drivers/iio/adc/ad485x.c:18:
   In file included from include/linux/regmap.h:20:
   In file included from include/linux/iopoll.h:14:
   In file included from include/linux/io.h:14:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:574:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     574 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   In file included from drivers/iio/adc/ad485x.c:18:
   In file included from include/linux/regmap.h:20:
   In file included from include/linux/iopoll.h:14:
   In file included from include/linux/io.h:14:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:585:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     585 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:595:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     595 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:605:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     605 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   In file included from drivers/iio/adc/ad485x.c:19:
   In file included from include/linux/regulator/consumer.h:35:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:21:
   In file included from include/linux/mm.h:2232:
   include/linux/vmstat.h:517:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     517 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> drivers/iio/adc/ad485x.c:408:9: error: call to undeclared function 'FIELD_GET'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     408 |         return FIELD_GET(AD485X_PACKET_FORMAT_MASK, format);
         |                ^
   7 warnings and 1 error generated.


vim +/FIELD_GET +408 drivers/iio/adc/ad485x.c

   396	
   397	static int ad485x_get_packet_format(struct iio_dev *indio_dev,
   398					    const struct iio_chan_spec *chan)
   399	{
   400		struct ad485x_state *st = iio_priv(indio_dev);
   401		unsigned int format;
   402		int ret;
   403	
   404		ret = regmap_read(st->regmap, AD485X_REG_PACKET, &format);
   405		if (ret)
   406			return ret;
   407	
 > 408		return FIELD_GET(AD485X_PACKET_FORMAT_MASK, format);
   409	}
   410	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

