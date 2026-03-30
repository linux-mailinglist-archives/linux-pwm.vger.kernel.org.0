Return-Path: <linux-pwm+bounces-8422-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sNFgBEyNymn09gUAu9opvQ
	(envelope-from <linux-pwm+bounces-8422-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Mar 2026 16:48:44 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F2C735D250
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Mar 2026 16:48:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3E081319A2F8
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Mar 2026 14:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E190B2EC0A6;
	Mon, 30 Mar 2026 14:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f1XNAf7L"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C7F2E091B;
	Mon, 30 Mar 2026 14:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774881441; cv=none; b=jMwp/XCoZSucb9xNjs3XvRIppPOEPmdyC2VXpTpEm8d9CEB7cX2YOAYDT6G2u2unJbzfp06wwLQDXljJMotmN/mOtCPqwoWu1x96RG8xUoNO5l/haa3KKhMWt9GoBPo4k+V7nAlCglnNzfcH0QcTR0jXMjgdWBT7b96PNkBYiKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774881441; c=relaxed/simple;
	bh=FfsIVUKLPFqUD2jO1eTH3CMDTjs2wmEjz9bthk26meA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rMEAD3G43tffOhQo1xsGd6fzThT95/7ST7k7BpLpvb5e8WGCN4KTozqrQlq8UD/UQm3wPmb2OY4Vvo+vqcpS5MZWWRkxF0CaDOZ8pLTaJkoAVzms3O4uG4wvRqOJt6F8dlmxEuaak7DeTx8npNGsJypuiVHhK9VAHSCItsgc/nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f1XNAf7L; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774881440; x=1806417440;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FfsIVUKLPFqUD2jO1eTH3CMDTjs2wmEjz9bthk26meA=;
  b=f1XNAf7LVdSvhsGh7TuDRaG50/d5WRAAHRfC6SbiUCQd5cBaTIR5RHYT
   X0WQ5lA2Av3Fj2/rRjKCZuj8p1HqmmYXti4NBCS8pJDooQtXgM0+dPwPR
   Wb40NHVY3PNkQo3FQti9267CQQEj0VhJqHt2eunDZbxzBvfJkQUWfckdV
   XR18HpnY12M3ewH/B6vPqt0gqF954h+38A1wH9kFrQYiD6TpdU+KP7JV7
   ja4ypbwAQ7NK6UtutBw7foQCKquol9PzryHpb2jjoNIa0ezJqlQbD0r2Y
   aISAv2pEG2gj/dBCCp/lMA49sMeQBa59XEqedTYqxcuoKT+A7fG0dfEjS
   g==;
X-CSE-ConnectionGUID: tqPNu9e/Tf+77S/YXn3Wug==
X-CSE-MsgGUID: eorGjQYHTkiD+SAc2Vnn2Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11743"; a="75770636"
X-IronPort-AV: E=Sophos;i="6.23,150,1770624000"; 
   d="scan'208";a="75770636"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 07:37:20 -0700
X-CSE-ConnectionGUID: GQSdPSfWSXiYPERlw7dyaw==
X-CSE-MsgGUID: T37eBBTtRSqbMyEgnSZ/aw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,150,1770624000"; 
   d="scan'208";a="225245200"
Received: from lkp-server01.sh.intel.com (HELO 283bf2e1b94a) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 30 Mar 2026 07:37:16 -0700
Received: from kbuild by 283bf2e1b94a with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w7Dju-000000001DN-01E6;
	Mon, 30 Mar 2026 14:37:14 +0000
Date: Mon, 30 Mar 2026 22:36:53 +0800
From: kernel test robot <lkp@intel.com>
To: Mikko Perttunen <mperttunen@nvidia.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-pwm@vger.kernel.org,
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, Yi-Wei Wang <yiweiw@nvidia.com>,
	Mikko Perttunen <mperttunen@nvidia.com>
Subject: Re: [PATCH v2 2/7] pwm: tegra: Avoid hard-coded max clock frequency
Message-ID: <202603302259.NdAkuCVx-lkp@intel.com>
References: <20260325-t264-pwm-v2-2-998d885984b3@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325-t264-pwm-v2-2-998d885984b3@nvidia.com>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8422-lists,linux-pwm=lfdr.de];
	FREEMAIL_TO(0.00)[nvidia.com,gmail.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,01.org:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9F2C735D250
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Mikko,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 11439c4635edd669ae435eec308f4ab8a0804808]

url:    https://github.com/intel-lab-lkp/linux/commits/Mikko-Perttunen/dt-bindings-pwm-Document-Tegra194-and-Tegra264-controllers/20260329-233356
base:   11439c4635edd669ae435eec308f4ab8a0804808
patch link:    https://lore.kernel.org/r/20260325-t264-pwm-v2-2-998d885984b3%40nvidia.com
patch subject: [PATCH v2 2/7] pwm: tegra: Avoid hard-coded max clock frequency
config: nios2-allmodconfig (https://download.01.org/0day-ci/archive/20260330/202603302259.NdAkuCVx-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260330/202603302259.NdAkuCVx-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603302259.NdAkuCVx-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/kernel.h:17,
                    from include/linux/clk.h:13,
                    from drivers/pwm/pwm-tegra.c:39:
   drivers/pwm/pwm-tegra.c: In function 'tegra_pwm_probe':
>> include/linux/limits.h:26:25: warning: unsigned conversion from 'long long int' to 'long unsigned int' changes value from '9223372036854775807' to '4294967295' [-Woverflow]
      26 | #define S64_MAX         ((s64)(U64_MAX >> 1))
         |                         ^~~~~~~~~~~~~~~~~~~~~
   drivers/pwm/pwm-tegra.c:303:47: note: in expansion of macro 'S64_MAX'
     303 |         ret = dev_pm_opp_set_rate(&pdev->dev, S64_MAX);
         |                                               ^~~~~~~


vim +26 include/linux/limits.h

3c9d017cc283df Andy Shevchenko 2023-08-04  14  
54d50897d544c8 Masahiro Yamada 2019-03-07  15  #define U8_MAX		((u8)~0U)
54d50897d544c8 Masahiro Yamada 2019-03-07  16  #define S8_MAX		((s8)(U8_MAX >> 1))
54d50897d544c8 Masahiro Yamada 2019-03-07  17  #define S8_MIN		((s8)(-S8_MAX - 1))
54d50897d544c8 Masahiro Yamada 2019-03-07  18  #define U16_MAX		((u16)~0U)
54d50897d544c8 Masahiro Yamada 2019-03-07  19  #define S16_MAX		((s16)(U16_MAX >> 1))
54d50897d544c8 Masahiro Yamada 2019-03-07  20  #define S16_MIN		((s16)(-S16_MAX - 1))
54d50897d544c8 Masahiro Yamada 2019-03-07  21  #define U32_MAX		((u32)~0U)
3f50f132d8400e John Fastabend  2020-03-30  22  #define U32_MIN		((u32)0)
54d50897d544c8 Masahiro Yamada 2019-03-07  23  #define S32_MAX		((s32)(U32_MAX >> 1))
54d50897d544c8 Masahiro Yamada 2019-03-07  24  #define S32_MIN		((s32)(-S32_MAX - 1))
54d50897d544c8 Masahiro Yamada 2019-03-07  25  #define U64_MAX		((u64)~0ULL)
54d50897d544c8 Masahiro Yamada 2019-03-07 @26  #define S64_MAX		((s64)(U64_MAX >> 1))
54d50897d544c8 Masahiro Yamada 2019-03-07  27  #define S64_MIN		((s64)(-S64_MAX - 1))
54d50897d544c8 Masahiro Yamada 2019-03-07  28  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

