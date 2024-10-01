Return-Path: <linux-pwm+bounces-3413-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C99FC98BCD9
	for <lists+linux-pwm@lfdr.de>; Tue,  1 Oct 2024 14:54:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79C581F2646F
	for <lists+linux-pwm@lfdr.de>; Tue,  1 Oct 2024 12:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C49731C32E6;
	Tue,  1 Oct 2024 12:54:15 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239C81A0733;
	Tue,  1 Oct 2024 12:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727787255; cv=none; b=bKylHrmJBxwn7VNcAsffLPzxG09a1TdVLMzZvWail7weYJQdPKACEAek7XKDNw+lyfiN6sl9rTmIha8t1L9TaCRmRVtC/LkKyvdMWUd1iDlxE39FDzNgQ1PRY6xq+8TL/f8z4tCv+sTg650oH8fmDgIuVRUrkIf1UIWKGgNhogs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727787255; c=relaxed/simple;
	bh=ZXXbUqt1MI3dgRFUEtXUCu3+/KWfXxEGNPo9YGuAnkg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IP0V7vtINaEm6ubsAFd2/NwBhDLhSN5lK/PNYh/OeRVYp6//2e6ps5kZ4UwxWdF95qkFNvNfBA2RoO6/xcb+2RuSNqf4Jz8Roh4AcXDAtG6r9G6fmfmD/x2j7k9NfMJy86onqNHOUVC5bH2GTqVyJNj8Gj0WMTQyUl58rlm9FYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: 2I/ocrZrQIK7HrCml6Ve/g==
X-CSE-MsgGUID: rNXRqZxwTrCP2K/c2jzIsA==
X-IronPort-AV: E=McAfee;i="6700,10204,11212"; a="27058876"
X-IronPort-AV: E=Sophos;i="6.11,167,1725346800"; 
   d="scan'208";a="27058876"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2024 05:54:14 -0700
X-CSE-ConnectionGUID: 4R8C4JUETC+XwIOofpirMw==
X-CSE-MsgGUID: f5DcL2aTTcS+80fNN6H4xA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,167,1725346800"; 
   d="scan'208";a="73905649"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2024 05:54:08 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andy@kernel.org>)
	id 1svcOD-0000000FCEh-1PCQ;
	Tue, 01 Oct 2024 15:54:05 +0300
Date: Tue, 1 Oct 2024 15:54:05 +0300
From: Andy Shevchenko <andy@kernel.org>
To: "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	"Hennerich, Michael" <Michael.Hennerich@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, "Sa, Nuno" <Nuno.Sa@analog.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	"Schmitt, Marcelo" <Marcelo.Schmitt@analog.com>,
	=?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <joao.goncalves@toradex.com>,
	Mike Looijmans <mike.looijmans@topic.nl>,
	Dumitru Ceclan <mitrutzceclan@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Alisa-Dariana Roman <alisadariana@gmail.com>,
	"Cuciurean, Sergiu" <Sergiu.Cuciurean@analog.com>,
	"Bogdan, Dragos" <Dragos.Bogdan@analog.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>
Subject: Re: [PATCH 6/7] iio: adc: ad485x: add ad485x driver
Message-ID: <Zvvw7ah4wGsl2vjw@smile.fi.intel.com>
References: <20240923101206.3753-1-antoniu.miclaus@analog.com>
 <20240923101206.3753-7-antoniu.miclaus@analog.com>
 <20240928184722.314b329b@jic23-huawei>
 <CY4PR03MB33991208029C4877760B528D9B772@CY4PR03MB3399.namprd03.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY4PR03MB33991208029C4877760B528D9B772@CY4PR03MB3399.namprd03.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Oct 01, 2024 at 11:53:18AM +0000, Miclaus, Antoniu wrote:

> Regarding the bulk writes/reads, the msb/mid/lsb registers need to be
> read/write in a specific order and the addresses are not incremental,

We have _noinc() variants of regmap accessors.

> so I am not sure how the bulk functions fit. On this matter, we will need
> unsigned int (not u8) to store the values read via regmap_read, and in this
> case we will need extra casts and assignments to use get_unaligned.

-- 
With Best Regards,
Andy Shevchenko



