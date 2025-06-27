Return-Path: <linux-pwm+bounces-6544-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0013AEB4A2
	for <lists+linux-pwm@lfdr.de>; Fri, 27 Jun 2025 12:29:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45B1D16BF9E
	for <lists+linux-pwm@lfdr.de>; Fri, 27 Jun 2025 10:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8C85298CD7;
	Fri, 27 Jun 2025 10:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="leb5l7OW"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69289266EE7;
	Fri, 27 Jun 2025 10:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751019955; cv=none; b=BC5PXA0rokfABKT4JvMe7CKY+RJZXcMRtp+4tp8eVrwNY+bmRZAhOiG6KhfEkhz7CrjV/l7uE33tkz8e8E8H5MInSbFRFCsIawsHN6M8bHZgvUR4aKVaqTqEPemS4rpGxeLJWmWfpEyRgHNmQTIZfdtrGEcHBiC2im5jyaQdwy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751019955; c=relaxed/simple;
	bh=pleE2a99A3MjFvbNJRK8AZZQWTV88MHknWRXe5Y2Z7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e8lW5e6AF4D6vbKzTFK5XivMMMm8pss77BJQIK4J5QjUsWNzZBu69qVbKE1GGOOJ6t+s1KtOcTSs1I7F1NwkHVyG7uDdqRRSLj6aoonjSIKQYNuZBhScFXuGWVxbyBbY+TsZ63YeSNgUbf6aKcwZ5Ql/PAEsnLTsfZV6q75J75o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=leb5l7OW; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751019955; x=1782555955;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pleE2a99A3MjFvbNJRK8AZZQWTV88MHknWRXe5Y2Z7M=;
  b=leb5l7OWmBBwOK8De1sBg+M8W2m7d15tyKUSdVssqPWyRAVDeQDh0hT1
   ljpM8GDlgWQ/oAJ+493hO/DFcTtsa9YI1AA19WRWIvNGolDn5QSoNLUdv
   VuZwTh9tblPhpoUXWosHA+nPTfDnOLW274ZJR22cKESS3PN0Nq/WM+NOI
   m4bcmiHoIFijZirUp2t/h7NuMQfgLasxMZ66baDqSli/JJTbvSnV+KdiS
   SKN6SWc+ycTdgEQJw+7+bI+B3QnY12DbfyMwGJpl4ZeM6txH9uU1J3Ya/
   dvsOlS6Cxw/pqFlUvNVonliDS2qBI0CBCjt5tvMH5Q5hj4QwXCjdfZH11
   g==;
X-CSE-ConnectionGUID: gEi4cP/KQvG7r9VdfNf+Bg==
X-CSE-MsgGUID: ENWprTcqRWOSA5xBDux7Cw==
X-IronPort-AV: E=McAfee;i="6800,10657,11476"; a="57009870"
X-IronPort-AV: E=Sophos;i="6.16,270,1744095600"; 
   d="scan'208";a="57009870"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2025 03:25:54 -0700
X-CSE-ConnectionGUID: hQINK6DNSEaj1f3dq7r5KA==
X-CSE-MsgGUID: qfRwwSYxTG2HlmKWAt6p+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,270,1744095600"; 
   d="scan'208";a="152163043"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2025 03:25:52 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uV6HF-0000000ARzc-0CRM;
	Fri, 27 Jun 2025 13:25:49 +0300
Date: Fri, 27 Jun 2025 13:25:48 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
	Benjamin Larsson <benjamin.larsson@genexis.eu>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>
Subject: Re: [PATCH v18] pwm: airoha: Add support for EN7581 SoC
Message-ID: <aF5xrHkTr8Tb71ZH@smile.fi.intel.com>
References: <20250626224805.9034-1-ansuelsmth@gmail.com>
 <aF5dHDr8yDSKlp5j@smile.fi.intel.com>
 <685e6544.5d0a0220.20cf55.9440@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <685e6544.5d0a0220.20cf55.9440@mx.google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jun 27, 2025 at 11:32:46AM +0200, Christian Marangi wrote:
> On Fri, Jun 27, 2025 at 11:58:04AM +0300, Andy Shevchenko wrote:
> > On Fri, Jun 27, 2025 at 12:47:53AM +0200, Christian Marangi wrote:

...

> > > +	/* Global mutex to protect bucket used refcount_t */
> > > +	struct mutex mutex;
> > 
> > This makes a little sense. Either you use refcount_t (which is atomic) or
> > use mutex + regular variable.
> 
> Using a regular variable I lose all the benefits of refcount_t with
> underflow and other checks.

Then drop the mutex, atomic operations do not need an additional
synchronisation. Btw, have you looked at kref APIs? Maybe that
would make the intention clearer?

-- 
With Best Regards,
Andy Shevchenko



