Return-Path: <linux-pwm+bounces-3166-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA79D971553
	for <lists+linux-pwm@lfdr.de>; Mon,  9 Sep 2024 12:29:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 476FEB2365F
	for <lists+linux-pwm@lfdr.de>; Mon,  9 Sep 2024 10:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B838F1B3F2D;
	Mon,  9 Sep 2024 10:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LfIcKxUW"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93381B3B2A;
	Mon,  9 Sep 2024 10:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725877741; cv=none; b=Gfy9eNGWXvYo3aBQ0SqurndABM/WVKG9Q+2C1x6Ajj/YQUCLp9FKjtPlMwmD5mwv8VgYlHlTQOwyGmU9vAkJg7Dxxfvf1cF+HuZodaLtnX4rC3sDDcFJwaliIlQYd4Fn3viCt0qsLq2vh14QBbw7QSWXTQCmtkbWKqCjjUYW6Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725877741; c=relaxed/simple;
	bh=j/5zo3J+1syvwV8Fyx6cdd+5FuNkHVAOK/IKOmDoCwU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d0+5U9BoeDuMc3R84u59+P5k7+jzxRbY2+fFIUXPd+F2DLmt+2Ecu8TkpKCi10htnuruMi9fYIubcgh3C4mU93o4X3kONtcaPytDeOp+gIkOeLcr0NzbdfvtlMPfw2Jc4xvOZQppWpgHD9kWQZgou3ro4Jh7IIe40Rg06qHPqdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LfIcKxUW; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725877740; x=1757413740;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=j/5zo3J+1syvwV8Fyx6cdd+5FuNkHVAOK/IKOmDoCwU=;
  b=LfIcKxUWDgnuyPda+ZpnCKxjm6Ck5omu7PC66hZhNi9qmyLDhSzv9WlC
   xcITsl2I3eBsbIez32ydw0vlYuTZaOS6z55EYudEcI8eNjJBJVHgzYweu
   yzNPPZjbHkb4+MiqhekPqYChGQt85qgkdSKUuazHSshawdizp2Mphtjwp
   1d9bafKpx3MtWDSgdwiwxSpFBOvkq8fU3/kSfbPdgQzz/85Yxu7/riyea
   Zko31/ysxJEqrGO/wDAi2j48LADSc4M4n7CFcIkj7SYvVI6KW6ZfRFzKt
   OUMYPrmgLR1zi6qNjJJSLFqhFhTUCUY6w2rkwzJdahciVMOqFp7GZugiF
   g==;
X-CSE-ConnectionGUID: MZ4pSAWkT9KQVFtOhqRiWQ==
X-CSE-MsgGUID: vcsToSzCRvqsU/8mbClD1Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11189"; a="28449493"
X-IronPort-AV: E=Sophos;i="6.10,214,1719903600"; 
   d="scan'208";a="28449493"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 03:28:59 -0700
X-CSE-ConnectionGUID: wD7fQusdT4GjBsM4MF1GLw==
X-CSE-MsgGUID: Wb7IZAzdRxW96w+Zv+Hnjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,214,1719903600"; 
   d="scan'208";a="66868180"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 03:28:58 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1snbdf-00000006kik-3K5V;
	Mon, 09 Sep 2024 13:28:55 +0300
Date: Mon, 9 Sep 2024 13:28:55 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: nikita.shubin@maquefel.me
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v12 13/38] pwm: ep93xx: add DT support for Cirrus EP93xx
Message-ID: <Zt7N56YRS9u_8zwm@smile.fi.intel.com>
References: <20240909-ep93xx-v12-0-e86ab2423d4b@maquefel.me>
 <20240909-ep93xx-v12-13-e86ab2423d4b@maquefel.me>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240909-ep93xx-v12-13-e86ab2423d4b@maquefel.me>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Sep 09, 2024 at 11:10:38AM +0300, Nikita Shubin via B4 Relay wrote:
> From: Nikita Shubin <nikita.shubin@maquefel.me>
> 
> Add OF ID match table.
> 
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

If you need to send a v13, drop one of the above.

-- 
With Best Regards,
Andy Shevchenko



