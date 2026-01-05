Return-Path: <linux-pwm+bounces-7848-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C781CCF4D51
	for <lists+linux-pwm@lfdr.de>; Mon, 05 Jan 2026 17:55:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6F87331679CF
	for <lists+linux-pwm@lfdr.de>; Mon,  5 Jan 2026 16:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76E122BDC04;
	Mon,  5 Jan 2026 16:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EzKZLI2W"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A928301717;
	Mon,  5 Jan 2026 16:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767631319; cv=none; b=MmC3Lud6g6ja6UHBY7hlr4/YFnVoP8c+YxCLQWUjg9zrHAxAZVh9N7iPUbuu4vVdFCtIWKFlFRsX+JhAP676qtdC6v0UdHVZ3Xw+8iejg/YnvI1EHYkCKh88GdmGQr/q0g5ZcPj/+8Z16AWz7nB9JrctMUdjde9M18CXhtYEESQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767631319; c=relaxed/simple;
	bh=uV4yhkucw42ARRhWUkmCcRhSx6lKMVyX5IOZgXhGepc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s3eQbCgRO9uK2q1kW5k135Gc/T4KTKtu3DjrGKN2PnrnXLKoFfXTYVWtZJI4nF6nf3U0GqQzoBMS5TLQQYKu62VGVBBrMiLt1HjsAMFbfUuNEboIjoLE+aj645H7vTHjpKG0AqHYytfpDLLdWWJxYcbTC9Bd3KAkvBoOXbyQHiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EzKZLI2W; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767631316; x=1799167316;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uV4yhkucw42ARRhWUkmCcRhSx6lKMVyX5IOZgXhGepc=;
  b=EzKZLI2Wi7MIdOnbW3Q26+3yWqNG3b2S+moIWZNEjdpfhwgLn+s2QLB4
   CEMKp+qbccKKd8j+GcjIwYdPXzvIy/Ap5VGW/X8ErQ1TP4M9rEVxW7U5o
   928bBo45X6UTgSpBBnAbCVw9xHtdiF+VNslg5pH03uoMmBkq4f1AoBvRC
   tkN0F9jAjT+C/xpBpwBaznXwO1l8FhLWnlxsvKtNQfwz6CkNEBkJWASgA
   d2DZ/GxMMdEku6HPyRNa3HguTSn/GUSKktvJdOv8eJg4cRlgXHokIu4tW
   CxLb6OUs7csAHcnBjX1PE8bHOwgYkOHavAxjkvOE54jPcD9kHSG/UbBwr
   A==;
X-CSE-ConnectionGUID: yOi/uMlSSjCLclmcuunUwA==
X-CSE-MsgGUID: YFsRRLYtQpaMMe6f+KPxLQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11662"; a="79633115"
X-IronPort-AV: E=Sophos;i="6.21,203,1763452800"; 
   d="scan'208";a="79633115"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2026 08:41:53 -0800
X-CSE-ConnectionGUID: R6swGXYSSsi7f4hQYeFcgQ==
X-CSE-MsgGUID: GEiDt1iiSXS5nB9vkSQwUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,203,1763452800"; 
   d="scan'208";a="202477824"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.215])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2026 08:41:51 -0800
Date: Mon, 5 Jan 2026 18:41:48 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Raag Jadav <raag.jadav@intel.com>
Cc: ukleinek@kernel.org, heikki.krogerus@linux.intel.com,
	linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] pwm: dwc: Use size macro
Message-ID: <aVvpzK1fXqwms6Ct@smile.fi.intel.com>
References: <20260105091737.17280-1-raag.jadav@intel.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260105091737.17280-1-raag.jadav@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jan 05, 2026 at 02:47:37PM +0530, Raag Jadav wrote:
> Use SZ_4K from size.h instead of hardcoding constant.

Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

OTOH, not sure if it's just an unneeded churn. What was the motivation to
create this patch?

-- 
With Best Regards,
Andy Shevchenko



