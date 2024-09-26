Return-Path: <linux-pwm+bounces-3379-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D0C798762C
	for <lists+linux-pwm@lfdr.de>; Thu, 26 Sep 2024 17:01:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EECAE1F2273E
	for <lists+linux-pwm@lfdr.de>; Thu, 26 Sep 2024 15:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD22714BF8B;
	Thu, 26 Sep 2024 15:01:14 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B8E1D5AAB;
	Thu, 26 Sep 2024 15:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727362874; cv=none; b=sakCdAPfJMzThogyVJLj/COcVaC4tepXldTGx5EPr0izbobv8g6RbZ89NyU0tvEvGEES5L2zFfSQ32Z25BBHHDRuX+IzJfzfxzN4toiYSFi5+m8ahAB9pTzUUXcHWulVNDsE+BnzI6w+84kJL2t/06NYZN9bZraobSLyDN6AjYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727362874; c=relaxed/simple;
	bh=ekicD0hMIKrGIHgqbzt/2p5OLpTYrMqW/2awOrbsZVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=udLkt/2wwONxFd5wW4Z04jwlUNoHn0tb07a53IwEK1hOQDdiIHDAypwfZMe1ptjKevsP9MhWBRbFZ7TWq9VkSASj9pTpFOhTdKIxwpQRh1DGir7xkrdw/TY28TodlaUa4CHTLDi2SY0oo2uXN88U+4r5KL02RrC+Gl5Nd86HOUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: KxdZcZScS+aU5K6ksf9spA==
X-CSE-MsgGUID: OIh4p77BThegUrhdGVai2Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11207"; a="25970351"
X-IronPort-AV: E=Sophos;i="6.11,155,1725346800"; 
   d="scan'208";a="25970351"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2024 08:00:32 -0700
X-CSE-ConnectionGUID: 4nydMnQqQaeHa6OB7GEjVg==
X-CSE-MsgGUID: +Y9PVB2cStqZshl1QyoxYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,155,1725346800"; 
   d="scan'208";a="71863255"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2024 08:00:27 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andy@kernel.org>)
	id 1stpyh-0000000DEQN-4AQy;
	Thu, 26 Sep 2024 18:00:23 +0300
Date: Thu, 26 Sep 2024 18:00:23 +0300
From: Andy Shevchenko <andy@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Nuno Sa <nuno.sa@analog.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	=?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <joao.goncalves@toradex.com>,
	Mike Looijmans <mike.looijmans@topic.nl>,
	Dumitru Ceclan <mitrutzceclan@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Alisa-Dariana Roman <alisadariana@gmail.com>,
	Sergiu Cuciurean <sergiu.cuciurean@analog.com>,
	Dragos Bogdan <dragos.bogdan@analog.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-pwm@vger.kernel.org
Subject: Re: [PATCH 6/7] iio: adc: ad485x: add ad485x driver
Message-ID: <ZvV3Bx2BdnZZS9bZ@smile.fi.intel.com>
References: <20240923101206.3753-1-antoniu.miclaus@analog.com>
 <20240923101206.3753-7-antoniu.miclaus@analog.com>
 <CAMknhBHRfj7d8Uea8vX=t+y+9dqoPABQSzsgNhBMTK-8-f6L7w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMknhBHRfj7d8Uea8vX=t+y+9dqoPABQSzsgNhBMTK-8-f6L7w@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Sep 26, 2024 at 04:39:18PM +0200, David Lechner wrote:
> On Mon, Sep 23, 2024 at 12:17 PM Antoniu Miclaus
> <antoniu.miclaus@analog.com> wrote:

...

> > +static int ad485x_find_opt(bool *field, u32 size, u32 *ret_start)
> > +{
> > +       int i, cnt = 0, max_cnt = 0, start, max_start = 0;
> > +
> > +       for (i = 0, start = -1; i < size; i++) {
> > +               if (field[i] == 0) {
> > +                       if (start == -1)
> > +                               start = i;
> > +                       cnt++;
> > +               } else {
> > +                       if (cnt > max_cnt) {
> > +                               max_cnt = cnt;
> > +                               max_start = start;
> > +                       }
> > +                       start = -1;
> > +                       cnt = 0;
> > +               }
> > +       }
> > +
> > +       if (cnt > max_cnt) {
> > +               max_cnt = cnt;
> > +               max_start = start;
> > +       }
> > +
> > +       if (!max_cnt)
> > +               return -EIO;
> 
> EIO seems an odd choice since this function doesn't actually do any
> I/O. Maybe EINVAL would be better?

I would even go with -ENOENT as function called 'find'.

> > +       *ret_start = max_start;
> > +
> > +       return max_cnt;
> > +}

-- 
With Best Regards,
Andy Shevchenko



