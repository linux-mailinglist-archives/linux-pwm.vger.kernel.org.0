Return-Path: <linux-pwm+bounces-5658-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8EB9A971A8
	for <lists+linux-pwm@lfdr.de>; Tue, 22 Apr 2025 17:52:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91AB3441475
	for <lists+linux-pwm@lfdr.de>; Tue, 22 Apr 2025 15:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC262918F1;
	Tue, 22 Apr 2025 15:51:14 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6817528FFCC;
	Tue, 22 Apr 2025 15:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745337074; cv=none; b=RGEtF2qNaVmW/CU+E+cyVCs8nH2RiImb+efrlGfuWN9tf780lIVJj/SAXNBtfSMPqzwkxGqHwEMVmnq9mNLPoMj9sdn9WUcw8lrZtTIpbzAD2wqhib7fozcO+B3m1HYr9NTDfzS+9m39vNIhN/jDBUsX4greRr/FvQ4biFkH/sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745337074; c=relaxed/simple;
	bh=Ns10knqhmzesZnxFjhk5h8WG/v33Hhl7wryAQIM50MU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SY0AiWn6hmeKac0c1KesB53XSfU+etUv6eSnY7osvsKBkC+1zU9VC174CvKKHUUw8ltZa8WKwtQJF26w+nC/IxPjIRPdxSsBs4iJNLR2ehTSgdc/Gd4YkB6elRVv8L5wH5WQ6FLPD0qhHsI9rz58g/E16k5y9WCsefpVhJC/5pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: xcJ3DBGcR1OGSV3V4ECr0Q==
X-CSE-MsgGUID: pENXFs2ARM+T0GzcQAiZzA==
X-IronPort-AV: E=McAfee;i="6700,10204,11411"; a="34521121"
X-IronPort-AV: E=Sophos;i="6.15,231,1739865600"; 
   d="scan'208";a="34521121"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 08:51:11 -0700
X-CSE-ConnectionGUID: cb9jPsGCR82zVJrgWHJDKg==
X-CSE-MsgGUID: 34mREltDRC6TyMainAXIBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,231,1739865600"; 
   d="scan'208";a="132046001"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 08:51:08 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andy@kernel.org>)
	id 1u7Ftp-0000000Elp2-1yRp;
	Tue, 22 Apr 2025 18:51:05 +0300
Date: Tue, 22 Apr 2025 18:51:05 +0300
From: Andy Shevchenko <andy@kernel.org>
To: Jorge Marques <jorge.marques@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-pwm@vger.kernel.org
Subject: Re: [PATCH v2 2/5] iio: code: mark iio_dev as const in
 iio_buffer_enabled
Message-ID: <aAe66Y3Gim7mzeoQ@smile.fi.intel.com>
References: <20250422-iio-driver-ad4052-v2-0-638af47e9eb3@analog.com>
 <20250422-iio-driver-ad4052-v2-2-638af47e9eb3@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250422-iio-driver-ad4052-v2-2-638af47e9eb3@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Apr 22, 2025 at 01:34:47PM +0200, Jorge Marques wrote:
> The iio_dev struct is never modified inside the method, mark it as
> const.
> This allows to be called from get_current_scan_type, and is useful
> when the scan_type depends on the buffer state.

Assuming it compiles and works,
Reviewed-by: Andy Shevchenko <andy@kernel.org>


-- 
With Best Regards,
Andy Shevchenko



