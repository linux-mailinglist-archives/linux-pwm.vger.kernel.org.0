Return-Path: <linux-pwm+bounces-3357-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D97E984942
	for <lists+linux-pwm@lfdr.de>; Tue, 24 Sep 2024 18:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A11BAB23A83
	for <lists+linux-pwm@lfdr.de>; Tue, 24 Sep 2024 16:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39B431AC88F;
	Tue, 24 Sep 2024 16:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GzSMNVBP"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738331AC441;
	Tue, 24 Sep 2024 16:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727194174; cv=none; b=Powk/VHSPNfUi1Okyc5GGzEmFrXhnKGrDjYBob7WUXLGDYCEsgHEmpgTFHbHFznp+HcS8eh72R7oOjZurB7Cp8LrG4nZHiTv2LucT7LIrNrmKT5DXf+5uthS/8z+JvNr1ktawH57orh1eDoD1Ns3L2oIbZmqKvuWWr7OhZPGqFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727194174; c=relaxed/simple;
	bh=WDJIymi6jhbzorfvBp3dPP8K22eFx3XqEjkbhxGF0xE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aZ8q+DW9DDZf3BMy238Ftxu3uND1gv5R3hpglo8YdJMTECJv5RElewl/KKNRI+3NBrVt7P4K0MB7/SSH5xX3Fd8kSH+8MN+66079y9JZnDEwrBX4lS+6Jx/sejr5gQcdgWwGkT2LRa+7tMsuqc4RLT8b4JSLE0/dI/JyhXV4RYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GzSMNVBP; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727194173; x=1758730173;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WDJIymi6jhbzorfvBp3dPP8K22eFx3XqEjkbhxGF0xE=;
  b=GzSMNVBPkPkz4UNUr+HYPD1ug3wSEvDHoB0lToCfHHjIRkcKJNrcflD/
   gmUAEPlcF8piVmwd8mz92YrFOmkzp5969kbls3CXOYvDkJOZfNk6X0vPm
   hf/FJ3dqz6S+jiHGKbptuOyx1Je79FsakWxMC4rzrNqjH1STIKfCRsWuF
   ML1l1tSSjoRyXb7cpcCkTydMPGsr1N+OfuO5mPH1ulTsv1JxbVVVgccNH
   2mwUwHOvJwxuS7u16ljknMNBv7BVPSyWRJZA442PQt+SH7ifpV32cMrI5
   kEsj/1YApJKkMCcOYbpaD0rEmxYOxInS1FTkJTAiL5EkDB/++/7fD9utC
   w==;
X-CSE-ConnectionGUID: dZGt7d54R3yyZf3PoGceNQ==
X-CSE-MsgGUID: V2lAm4AwRSaL/X1e3CAU8Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11205"; a="51615038"
X-IronPort-AV: E=Sophos;i="6.10,255,1719903600"; 
   d="scan'208";a="51615038"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2024 09:09:32 -0700
X-CSE-ConnectionGUID: +92+O1hhS3SAon2BTcyrVw==
X-CSE-MsgGUID: RxAyyAicQ2iDrsFlZ4YDwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,255,1719903600"; 
   d="scan'208";a="71457803"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 24 Sep 2024 09:09:26 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1st86O-000IXp-09;
	Tue, 24 Sep 2024 16:09:24 +0000
Date: Wed, 25 Sep 2024 00:08:29 +0800
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
	=?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <joao.goncalves@toradex.com>,
	Mike Looijmans <mike.looijmans@topic.nl>,
	Dumitru Ceclan <mitrutzceclan@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Alisa-Dariana Roman <alisadariana@gmail.com>,
	Sergiu Cuciurean <sergiu.cuciurean@analog.com>,
	Dragos Bogdan <dragos.bogdan@analog.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-pwm@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 6/7] iio: adc: ad485x: add ad485x driver
Message-ID: <202409242353.rDAcuGYR-lkp@intel.com>
References: <20240923101206.3753-7-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240923101206.3753-7-antoniu.miclaus@analog.com>

Hi Antoniu,

kernel test robot noticed the following build errors:

[auto build test ERROR on robh/for-next]
[also build test ERROR on linus/master v6.11]
[cannot apply to jic23-iio/togreg next-20240924]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Antoniu-Miclaus/iio-backend-add-API-for-interface-get/20240923-182050
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20240923101206.3753-7-antoniu.miclaus%40analog.com
patch subject: [PATCH 6/7] iio: adc: ad485x: add ad485x driver
config: openrisc-allyesconfig (https://download.01.org/0day-ci/archive/20240924/202409242353.rDAcuGYR-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240924/202409242353.rDAcuGYR-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409242353.rDAcuGYR-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/iio/adc/ad485x.c: In function 'ad485x_get_packet_format':
>> drivers/iio/adc/ad485x.c:396:18: error: implicit declaration of function 'FIELD_GET' [-Wimplicit-function-declaration]
     396 |         format = FIELD_GET(AD485X_PACKET_FORMAT_MASK, format);
         |                  ^~~~~~~~~
   drivers/iio/adc/ad485x.c: At top level:
   drivers/iio/adc/ad485x.c:854:23: warning: initialized field overwritten [-Woverride-init]
     854 |         .resolution = 16,
         |                       ^~
   drivers/iio/adc/ad485x.c:854:23: note: (near initialization for 'ad4856_info.resolution')


vim +/FIELD_GET +396 drivers/iio/adc/ad485x.c

   384	
   385	static int ad485x_get_packet_format(struct iio_dev *indio_dev,
   386					    const struct iio_chan_spec *chan)
   387	{
   388		struct ad485x_state *st = iio_priv(indio_dev);
   389		unsigned int format;
   390		int ret;
   391	
   392		ret = regmap_read(st->regmap, AD485X_REG_PACKET, &format);
   393		if (ret)
   394			return ret;
   395	
 > 396		format = FIELD_GET(AD485X_PACKET_FORMAT_MASK, format);
   397	
   398		return format;
   399	}
   400	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

