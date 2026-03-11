Return-Path: <linux-pwm+bounces-8229-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4A+oEsJTsWn8tgIAu9opvQ
	(envelope-from <linux-pwm+bounces-8229-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Mar 2026 12:36:34 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AFF6F262F73
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Mar 2026 12:36:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4CBAE301300B
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Mar 2026 11:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC68A3CF668;
	Wed, 11 Mar 2026 11:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QP6zZAFV"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786F73112C1;
	Wed, 11 Mar 2026 11:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773228990; cv=none; b=AainrEaqL16XvpBOLMVSgmhjyORluxl/lxzq/akeAgJjtdComK41gg82noHH+qNhVSQvz1zwwh6Vc1zqQCm1LZ+xwkM+g/NS8T4TSC3MrZRm6d4tfdZ/MotgwmOTw0EMmNckqLrmT+n4Y3rhjY9zKZ22Eu9qqVmoWNbc7Kg/DBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773228990; c=relaxed/simple;
	bh=o4mzS9ptvgAjnLz4N9oF/qMwT6YeKSX5GUVjpuFvOGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cRcb8BwchN48M9dwyGeZxi0q36CsRFCXmAzoRjbmMGaFjVdR8QwZrMLI1r9rxH4cK02XGAl+bF02fA7nvLg0R+u6kGrVveqQQgSy4W3OJYsMSH9lQMOt0lRI+BwK2cipPUEGrfCjfmK8DVJ50/5vW/Vc9ZhYQ/Q3DrpA2aej1SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QP6zZAFV; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773228990; x=1804764990;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=o4mzS9ptvgAjnLz4N9oF/qMwT6YeKSX5GUVjpuFvOGY=;
  b=QP6zZAFVwJHjKLMsmGR2HhaP9qG9jZA5YDLVRUXCKnXpYbr9gBeGcW6H
   rFQ7f7iMNa8G1D7XTGLVFAaZXuqRexzlqoK9TtfyQencqEJ1ok7YfF9ou
   U/PD/NvBRCbNxZ1NrKcaJyYKbaZRzjh3OmBHmAQ9CfWls2YtFk2XGohCt
   /0SC8LCnCXOlEgRQSbWVElS5Rjo/eax5xNuJWHD7g6aZjqoy6duCwuXoV
   OsKwGeaUzgmA2Zf8ek/yO882ptb5lDUtGRq2MDXWh0+nlYguEdOfx9/h/
   OsuM1AxKKa2BUl8E1/hJj+R+1RnyQAYkgCt+z3rX7sQIwiCpsjJECdv3m
   A==;
X-CSE-ConnectionGUID: 9SD48vhaRVq6oQ5PfpLLlg==
X-CSE-MsgGUID: XW1Fkbo2T3a+VF7/A44Xtw==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="84616923"
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="84616923"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 04:36:29 -0700
X-CSE-ConnectionGUID: DPLbcihwRaWPV808gIz/SA==
X-CSE-MsgGUID: FWx/UiGuTHmUc8ihLMg6vg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="250936304"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.178])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 04:36:24 -0700
Date: Wed, 11 Mar 2026 13:36:22 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Alexis Czezar Torreno <alexisczezar.torreno@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v2 3/3] MAINTAINERS: Add entry for AD5706R DAC driver
Message-ID: <abFTtlfBZaGEjdCK@ashevche-desk.local>
References: <20260311-dev_ad5706r-v2-0-f367063dbd1b@analog.com>
 <20260311-dev_ad5706r-v2-3-f367063dbd1b@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260311-dev_ad5706r-v2-3-f367063dbd1b@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Queue-Id: AFF6F262F73
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8229-lists,linux-pwm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@intel.com,linux-pwm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ashevche-desk.local:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,intel.com:dkim]
X-Rspamd-Action: no action

On Wed, Mar 11, 2026 at 08:23:19AM +0800, Alexis Czezar Torreno wrote:
> Add maintainer entry for the Analog Devices AD5706R DAC driver
> and device tree binding.

This should be added when the respective files are being added.

-- 
With Best Regards,
Andy Shevchenko



