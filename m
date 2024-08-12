Return-Path: <linux-pwm+bounces-3012-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8D6C94F027
	for <lists+linux-pwm@lfdr.de>; Mon, 12 Aug 2024 16:48:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 842BE1F26097
	for <lists+linux-pwm@lfdr.de>; Mon, 12 Aug 2024 14:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D6F186E51;
	Mon, 12 Aug 2024 14:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jq15jcMh"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3F7186E52;
	Mon, 12 Aug 2024 14:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723473981; cv=none; b=NK3TXp395RD5PcZflWK0GBEW1V4a6oYLU6q4GY4AoD0YycJ47jsji6o266rXpE4tEUJkDw0161A19rCExMFyYt4eBVY/yZYmsmoykg1a/UAqeiuIAopiXvyqZ+AIYRWIktWcn14tbeyTiTfZOwGPTPB7lRDe4xD+te7Jo+eD8gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723473981; c=relaxed/simple;
	bh=6EwWjIRQk/sSk2O6sQQi8d9c67kMukQLlwq8Iu0PHQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aULwDG0XOiPc41iw9H8gEQZNoall8jA5XOz1/eIU8BDxVeXx6cIgUnpo8DRSJxQVvPj2nMHmQtOFKcutIrraTzyVjflkyXwVgkUm7W7OACU7XSsxcwbpDr4e1RWdCySbqXpBF49311ZzSrZPiGQjJX5YySyXWvkJTgDn1afJLyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jq15jcMh; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723473979; x=1755009979;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6EwWjIRQk/sSk2O6sQQi8d9c67kMukQLlwq8Iu0PHQY=;
  b=Jq15jcMhlNd4durg5pYmv9qcKsMEeGHUXuDW9V3C3M6KXlxPfRRlQf56
   yFw6Qe/21iE8iKdqZ6bodJuSbjqWTRZP+eVPfHxlr4WluqYQs9Bx+sS8G
   CjHAOTZSjmgRA5mv8PIeJLOCDUsqU4g9q5qIkPcNKGcE8duJvL1xjCsQy
   Voo9LwIINZKDuAns+UglF1IgmbhLR3Zx+QUXO2EX3Tf3sO3d21F0n2z6F
   7s7bLKgjNkOKZ2TC00QKD0qZlUqbFU+bySXvM2y5hXOg2vDiwoZZGL+Zd
   M3Suqs3FyY505WzoFmCj4KepNT/UDbsDCcN4JYg5sgab5aiMUmEj6lgEz
   Q==;
X-CSE-ConnectionGUID: oEWFnBYnSc+sKwYLQ/dTGA==
X-CSE-MsgGUID: bt60szcgReaSJCja1hzXYQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11162"; a="39103394"
X-IronPort-AV: E=Sophos;i="6.09,283,1716274800"; 
   d="scan'208";a="39103394"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 07:46:18 -0700
X-CSE-ConnectionGUID: 7Jr7aG7xRJyvRxjhOVjlRA==
X-CSE-MsgGUID: bnTwUiRVQgek9F6l6ITQWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,283,1716274800"; 
   d="scan'208";a="58997793"
Received: from unknown (HELO b6bf6c95bbab) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 12 Aug 2024 07:46:15 -0700
Received: from kbuild by b6bf6c95bbab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sdWJI-000Bu4-1R;
	Mon, 12 Aug 2024 14:46:12 +0000
Date: Mon, 12 Aug 2024 22:45:33 +0800
From: kernel test robot <lkp@intel.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>, linux-pwm@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, ukleinek@kernel.org,
	lorenzo.bianconi83@gmail.com, krzk+dt@kernel.org, robh@kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	upstream@airoha.com, angelogioacchino.delregno@collabora.com,
	benjamin.larsson@genexis.eu, conor+dt@kernel.org,
	ansuelsmth@gmail.com
Subject: Re: [PATCH v2 2/2] pwm: airoha: Add support for EN7581 SoC
Message-ID: <202408122207.joypBYZD-lkp@intel.com>
References: <d5abef7ee63f2c5df8bf3400c4d8a5ff72c706a9.1723393857.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d5abef7ee63f2c5df8bf3400c4d8a5ff72c706a9.1723393857.git.lorenzo@kernel.org>

Hi Lorenzo,

kernel test robot noticed the following build errors:

[auto build test ERROR on robh/for-next]
[also build test ERROR on linus/master v6.11-rc3 next-20240812]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Lorenzo-Bianconi/dt-bindings-pwm-Document-Airoha-EN7581-PWM/20240812-003542
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/d5abef7ee63f2c5df8bf3400c4d8a5ff72c706a9.1723393857.git.lorenzo%40kernel.org
patch subject: [PATCH v2 2/2] pwm: airoha: Add support for EN7581 SoC
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20240812/202408122207.joypBYZD-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240812/202408122207.joypBYZD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408122207.joypBYZD-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: drivers/pwm/pwm-airoha.o: in function `airoha_pwm_config_flash_map':
>> pwm-airoha.c:(.text+0x127): undefined reference to `__ffsdi2'
   ld: drivers/pwm/pwm-airoha.o: in function `airoha_pwm_config_waveform':
   pwm-airoha.c:(.text+0x1ed): undefined reference to `__ffsdi2'
>> ld: pwm-airoha.c:(.text+0x26f): undefined reference to `__ffsdi2'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

