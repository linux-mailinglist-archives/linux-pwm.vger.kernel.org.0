Return-Path: <linux-pwm+bounces-3645-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 529BD99E54A
	for <lists+linux-pwm@lfdr.de>; Tue, 15 Oct 2024 13:14:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E39511F22FEF
	for <lists+linux-pwm@lfdr.de>; Tue, 15 Oct 2024 11:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84BF61E3764;
	Tue, 15 Oct 2024 11:13:59 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D211D89F3;
	Tue, 15 Oct 2024 11:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728990839; cv=none; b=tBt25FFcAb3kpKGeNl85M2UuKhtJ7f3qXdOysO4Y/mzcIgst45Pdf2PVl77mGftlm40XklhGPRsCLp23sYA3NrXwwz/DEkmHi0o3fmiSOyOWBOe2S9zuFwNSA2p9End126zwdX5+g4wfQnJ0TIkzg4+wAhHh6oJYeLRhXvBIuHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728990839; c=relaxed/simple;
	bh=WvOBu/y7FFpCn+M/r8vBiywVPF77IlJRf6ph7rkqysU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GrwwpctpXy+pIDkm4M/GRhBcqm1MH69/zplV7HE1eIGMEUEC6xD66xQ60DMDr2kUpDbddAdEw+rh0jc0GAT6CetRUD/6Guov4tqdHPBtMthh9zTinJA9bicFKDqeB/ISVuNnVwqai7rPL7wFf7VFjH08yo1VbDqlUfkjZVYWa94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: BKQ7Vu59SkmeIazDZCyYlA==
X-CSE-MsgGUID: aOjOjgHgQCW52kdzqla80A==
X-IronPort-AV: E=McAfee;i="6700,10204,11225"; a="28257774"
X-IronPort-AV: E=Sophos;i="6.11,204,1725346800"; 
   d="scan'208";a="28257774"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2024 04:13:51 -0700
X-CSE-ConnectionGUID: 0MXsz2toRPKXWw+85noTVQ==
X-CSE-MsgGUID: HvfYLc6DTHCUipDyy5GClw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,204,1725346800"; 
   d="scan'208";a="108654600"
Received: from smile.fi.intel.com ([10.237.72.154])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2024 04:13:45 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andy@kernel.org>)
	id 1t0fUj-00000003FHF-0i05;
	Tue, 15 Oct 2024 14:13:41 +0300
Date: Tue, 15 Oct 2024 14:13:40 +0300
From: Andy Shevchenko <andy@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Nuno Sa <nuno.sa@analog.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Ivan Mikhaylov <fr0st61te@gmail.com>,
	Marius Cristea <marius.cristea@microchip.com>,
	Dumitru Ceclan <mitrutzceclan@gmail.com>,
	=?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <joao.goncalves@toradex.com>,
	Alisa-Dariana Roman <alisadariana@gmail.com>,
	Mike Looijmans <mike.looijmans@topic.nl>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Sergiu Cuciurean <sergiu.cuciurean@analog.com>,
	Dragos Bogdan <dragos.bogdan@analog.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org
Subject: Re: [PATCH v3 6/6] iio: adc: ad4851: add ad485x driver
Message-ID: <Zw5OZAhzyhNUTPae@smile.fi.intel.com>
References: <20241014094154.9439-1-antoniu.miclaus@analog.com>
 <20241014094154.9439-6-antoniu.miclaus@analog.com>
 <Zw0ZM0vQXJep3dFJ@smile.fi.intel.com>
 <c70139f8-c0ba-4e28-9477-964db3fbfbba@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c70139f8-c0ba-4e28-9477-964db3fbfbba@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Oct 14, 2024 at 05:08:47PM -0500, David Lechner wrote:
> On 10/14/24 8:14 AM, Andy Shevchenko wrote:
> > On Mon, Oct 14, 2024 at 12:40:40PM +0300, Antoniu Miclaus wrote:

...

> >> +	return regmap_update_bits(st->regmap, AD4851_REG_PACKET,
> >> +				  AD4851_PACKET_FORMAT_MASK, (osr == 1) ? 0 : 1);
> > 
> > I would do it with a conditional
> > 
> > 	if (osr ...)
> > 		return regmap_update_bits(st->regmap, AD4851_REG_PACKET,
> > 					  AD4851_PACKET_FORMAT_MASK, 0);
> > 
> > 	return regmap_update_bits(st->regmap, AD4851_REG_PACKET,
> > 				  AD4851_PACKET_FORMAT_MASK, 1);
> > 
> If we do this, regmap_set_bits() and regmap_clear_bits() would
> be even better.

Sure, but I want also to have the only one conditional, so the respective
helper functions can be easily read and followed.

-- 
With Best Regards,
Andy Shevchenko



