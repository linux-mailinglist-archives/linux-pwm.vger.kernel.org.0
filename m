Return-Path: <linux-pwm+bounces-2701-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C152F928102
	for <lists+linux-pwm@lfdr.de>; Fri,  5 Jul 2024 05:45:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 094ED1C22C7D
	for <lists+linux-pwm@lfdr.de>; Fri,  5 Jul 2024 03:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AEC41E497;
	Fri,  5 Jul 2024 03:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nW7JymBB"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7472A2F52;
	Fri,  5 Jul 2024 03:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720151129; cv=none; b=I5j39TKxc+BBURPVWadpW1kGpAiUxbMGVvIIItLnXzMy7bd9eYxNBNN9TS9gG/+dUrr5TmKFYY1Qw8D+JEyvwuYTM6kVx54LuJm7jlL5L8T+AJ9pDEEcMsPU7mAio1HZFx+/aBBkY6ZzuQkpfQlatnK+Lfwvwjvu6hmWWATrFrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720151129; c=relaxed/simple;
	bh=zu13MZPjKn2VMGYqrCkGWyyUa3RUGK2FjD+KHP+z52g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=er3YBVU/TJ2yrssDjzEpwej5lxepxXVYnLcJsAX9crJGfEeiWGp0dCYnjcTomqIS4FrarfIBLWxp8X8y7V73Ny22ku6oz5TWUXnCIMRpWuq3ZQ644tgLRNO661q1TCoesDdSmftOi4zyXJ3Vg17+XWbiELfhvn6TRbMW7fHv9zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nW7JymBB; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720151127; x=1751687127;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zu13MZPjKn2VMGYqrCkGWyyUa3RUGK2FjD+KHP+z52g=;
  b=nW7JymBBLcmUl239FIL82kLRd0B4avQz3QLZe/6zlEW/Q/i55pUpUt7M
   FenL4aUW1nfdd/lQKtLsl2RN8StCP4dkxjebZhnS2K++A/lf7WBpQEUeL
   B+G0TAceoU6xD6p4nnyWRQE7XXP2SDqj8bS2r4O5cq1xfGgv0Qd8q1La5
   QWxV7oluWVbZX3hNT0EuEhXzTC2/3ytrw0yngH9hbjnLXby4fk/JpivEo
   4YXWderVrQIirC6jQYACN1gIx/ucRxcCF+kmLwTcjhnHkU8xWQd3/DMT1
   X8EqTcKRiRTr2XiZMgTTBcDaqT8ELew+ZrN5Ue06qTyFtyDbqLvqttiYF
   A==;
X-CSE-ConnectionGUID: 1sA2CHIkQhO3ZbXzITVcbQ==
X-CSE-MsgGUID: /POC54o/R0q0KGZgsCAfRg==
X-IronPort-AV: E=McAfee;i="6700,10204,11123"; a="17080894"
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="17080894"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2024 20:45:27 -0700
X-CSE-ConnectionGUID: JbpyQsOeSJ6uFh9r4+ZN5w==
X-CSE-MsgGUID: UGhnHYvPRX2PfgV5Y5CBqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="77502794"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2024 20:45:25 -0700
Date: Fri, 5 Jul 2024 06:45:22 +0300
From: Raag Jadav <raag.jadav@intel.com>
To: ukleinek@kernel.org, jarkko.nikula@linux.intel.com,
	mika.westerberg@linux.intel.com, andriy.shevchenko@linux.intel.com
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] LPSS PWM cleanups
Message-ID: <ZodsUkFQ4BJDU1JY@black.fi.intel.com>
References: <20240605131533.20037-1-raag.jadav@intel.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240605131533.20037-1-raag.jadav@intel.com>

On Wed, Jun 05, 2024 at 06:45:31PM +0530, Raag Jadav wrote:
> This series implements minor cleanups for LPSS PWM driver.
> 
> Changes since v1:
> - Update commit message

Bump.

Anything I can do to move this forward?

Raag

