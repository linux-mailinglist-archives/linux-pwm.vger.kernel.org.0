Return-Path: <linux-pwm+bounces-5419-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 662EBA82B20
	for <lists+linux-pwm@lfdr.de>; Wed,  9 Apr 2025 17:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F6143B9914
	for <lists+linux-pwm@lfdr.de>; Wed,  9 Apr 2025 15:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DB5B26772C;
	Wed,  9 Apr 2025 15:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q8/utymb"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B97265CC6;
	Wed,  9 Apr 2025 15:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744213212; cv=none; b=MNJ5vQpoTASGHT+hFrieEZtrwtcnQo9HG7NBUgc8KRsjK9Q3J9tXBuQSABJ4pD0nSvJeUXlTDWwgjpTgHnFNk/ZvlLUIRKA84bKZ2u1xRxRvP9qRn4b1ixCijJSve5MU5j9FwaEoAE53FxgT89hltBh35WxhcLcoD+4gGYDiadE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744213212; c=relaxed/simple;
	bh=z3ECtH9nXMU27fndDBs3IrRNaeghTsCm4s6Kg7+bUX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s1YhbwFQ+rkqYRrU3OnLppfi/As+3azOQ6hlMZeVFls0QNd+CEVbCi410XbYp4JEKaGozWhYLWnJDWx6K7U/fYTqHRtVxGQdkjtwLHfycwP1HtutZcMN3s/bIP7Teip8XUa5Lg2Iq6p3uYLOCfG1VSOEdKzye3v/UbtelRLfmfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q8/utymb; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744213210; x=1775749210;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=z3ECtH9nXMU27fndDBs3IrRNaeghTsCm4s6Kg7+bUX4=;
  b=Q8/utymbiZA7+C73+eJUjtrCWacsvx8Qb5H2T1E8IV7WPm0nJ4bwaG5f
   62aVwHCuT3+J4tQQrPWmqjwkSdQkfNiGsGqwc75UV6Evm9ekXMfHQEk7S
   cjQCSKh6NnY2Ow39n/udriwGspmCxN19OOdP20JCngvsSVfi/aHfhChdr
   eRIlQuFhoZU5BQD5bc3aEhldl+c4ednwO/8Ww8LliCTkz4toECOKRab1Q
   A39t2WrZXgx5WySCzSNm/HEdiUWrwwT45bUA9O46gDOSVCxfdpE/3+TSR
   VUqbSJydQN6KPD3r7IpzqPZuOVvBuUVSJQz5pRCE7JGivD770SeNtIwXH
   Q==;
X-CSE-ConnectionGUID: 6HQDCHt/RrKQyASpvRc0vg==
X-CSE-MsgGUID: xab30qb4QEiYMMDJaiKy8g==
X-IronPort-AV: E=McAfee;i="6700,10204,11399"; a="71073106"
X-IronPort-AV: E=Sophos;i="6.15,200,1739865600"; 
   d="scan'208";a="71073106"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 08:40:09 -0700
X-CSE-ConnectionGUID: 0DcUfIIVTr+p/lHA4Mexsw==
X-CSE-MsgGUID: f1H6QlzIQA2UddKHS9KjPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,200,1739865600"; 
   d="scan'208";a="151798272"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 08:40:04 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1u2XWz-0000000AmV4-2IGG;
	Wed, 09 Apr 2025 18:40:01 +0300
Date: Wed, 9 Apr 2025 18:40:01 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kamel Bouhara <kamel.bouhara@bootlin.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Michael Walle <mwalle@kernel.org>, Mark Brown <broonie@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-input@vger.kernel.org, linux-pwm@vger.kernel.org,
	=?iso-8859-1?Q?Gr=E9gory?= Clement <gregory.clement@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v6 05/12] regmap: irq: Remove unreachable goto
Message-ID: <Z_aU0dRS3I4cN2aX@smile.fi.intel.com>
References: <20250409-mdb-max7360-support-v6-0-7a2535876e39@bootlin.com>
 <20250409-mdb-max7360-support-v6-5-7a2535876e39@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250409-mdb-max7360-support-v6-5-7a2535876e39@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Apr 09, 2025 at 04:55:52PM +0200, Mathieu Dubois-Briand wrote:
> BUG() never returns, so code after it is unreachable: remove it.

Thank you, this is the right change to do.
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



