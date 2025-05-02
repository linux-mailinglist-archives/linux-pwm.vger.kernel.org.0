Return-Path: <linux-pwm+bounces-5813-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1FB6AA73C5
	for <lists+linux-pwm@lfdr.de>; Fri,  2 May 2025 15:33:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88FFF3B3B0A
	for <lists+linux-pwm@lfdr.de>; Fri,  2 May 2025 13:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F022254AF4;
	Fri,  2 May 2025 13:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cVLlAguG"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3812F11713;
	Fri,  2 May 2025 13:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746192766; cv=none; b=JvCOokK0wvSLikwWbqGU0An0Hfa7XNK7JN0OUDI1fMgZ5kPT8gIW/MmBV2ybFs1gm6h1R5Cx9YioMNPjpo+pAmj539GQ9ZGPKFDI40tBNJuG867190xTbfLNdbwMU/E+bBKTYGDxx2syF8SqomhgkBFcN1X+Qmy9E6Hur+WVo5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746192766; c=relaxed/simple;
	bh=NR622j4dRvHmLsUKScG/FmmKzF09lXOVZ2C1KIRIqaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TUSal7K5MM/N8zV4z1ql3ckMRCOC7q9lvleH+o9JJgmFP/yn4MtIImhl4qKC7mSnC+yWvGXHInzpY+PkRiY1JXq72H7SDRC54Snv3q6VqWHKi1rGWm2KVkElR7r7oejncOEeUhUBWaBJtXNMq9g7M9TwurmJsF8ybkchvqNKHYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cVLlAguG; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746192764; x=1777728764;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NR622j4dRvHmLsUKScG/FmmKzF09lXOVZ2C1KIRIqaE=;
  b=cVLlAguGtQsUNEEJhFw7Efj0GHh5k/UnDNouoltPNt6MJO7mc8dyFd4J
   V5anDrCM2vj5w5BSRvLfxlDOFrNUFQACsQShf+RZOXGfEYBMyF3NCF37t
   we0pvg9SCZinbkwvMxjDV4xJ/3+rqtXlBxhA/dMc7MdLL+k1/9AX5VNeT
   3zgrEFJlg+nieqtiNFOj/2KgLWgqYxP3vlnSDjHVB0z8XVefXdjes++o5
   yjY1qQPqDKsP4dRoQtruSMENE38MF37Q2FoBqtkViKuB8wrA6EjP0gM+X
   LOMGcE19xPqp2EfdNEcTxcmVjir28AmnQZW0q3o6cOuKPvqFYuxXztq4b
   g==;
X-CSE-ConnectionGUID: 0+z02viiRKu6dLr+z/a5WA==
X-CSE-MsgGUID: Xub0/RqGR66u7JQSOdYUmQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11421"; a="46982257"
X-IronPort-AV: E=Sophos;i="6.15,256,1739865600"; 
   d="scan'208";a="46982257"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2025 06:32:41 -0700
X-CSE-ConnectionGUID: omR7LMr4SgyH/xVbGou2Jw==
X-CSE-MsgGUID: wzXs2UDSTvGXwHj2DEbhbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,256,1739865600"; 
   d="scan'208";a="138661327"
Received: from smile.fi.intel.com ([10.237.72.55])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2025 06:32:37 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uAqVG-00000002D7w-0P7L;
	Fri, 02 May 2025 16:32:34 +0300
Date: Fri, 2 May 2025 16:32:33 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
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
Subject: Re: [PATCH v7 09/11] input: keyboard: Add support for MAX7360 keypad
Message-ID: <aBTJcQp-wBLJTh-6@smile.fi.intel.com>
References: <20250428-mdb-max7360-support-v7-0-4e0608d0a7ff@bootlin.com>
 <20250428-mdb-max7360-support-v7-9-4e0608d0a7ff@bootlin.com>
 <aBSii0rHox72GM5Y@smile.fi.intel.com>
 <D9LPB49CQJDW.3VMFI0TFGV7K2@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D9LPB49CQJDW.3VMFI0TFGV7K2@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, May 02, 2025 at 03:15:34PM +0200, Mathieu Dubois-Briand wrote:
> On Fri May 2, 2025 at 12:46 PM CEST, Andy Shevchenko wrote:
> > On Mon, Apr 28, 2025 at 01:57:27PM +0200, Mathieu Dubois-Briand wrote:

...

> >> +static irqreturn_t max7360_keypad_irq(int irq, void *data)
> >> +{
> >> +	struct max7360_keypad *max7360_keypad = data;
> >> +	struct device *dev = max7360_keypad->input->dev.parent;
> >> +	unsigned int val;
> >> +	unsigned int row, col;
> >> +	unsigned int release;
> >> +	unsigned int code;
> >> +	int error;
> >> +
> >> +	do {
> >> +		error = regmap_read(max7360_keypad->regmap, MAX7360_REG_KEYFIFO, &val);
> >> +		if (error) {
> >> +			dev_err(dev, "Failed to read max7360 FIFO");
> >> +			return IRQ_NONE;
> >> +		}
> >> +
> >> +		/* FIFO overflow: ignore it and get next event. */
> >> +		if (val == MAX7360_FIFO_OVERFLOW)
> >> +			dev_warn(dev, "max7360 FIFO overflow");
> >
> > If many events are missing this will flood the logs, perhaps _ratelimited() ?
> >
> >> +	} while (val == MAX7360_FIFO_OVERFLOW);
> >
> > regmap_read_poll_timeout() ?
> 
> OK, I can try something like:
> 
> +       error = regmap_read(max7360_keypad->regmap, MAX7360_REG_KEYFIFO, &val);
> +
> +       /* FIFO overflow: ignore it and get next event. */
> +       if (!error && (val == MAX7360_FIFO_OVERFLOW)) {
> +               dev_warn(dev, "max7360 FIFO overflow");
> +               error = regmap_read_poll_timeout(max7360_keypad->regmap, MAX7360_REG_KEYFIFO,
> +                                                val, val != MAX7360_FIFO_OVERFLOW, 0, 0);
> +       }
> +
> +       if (error) {
> +               dev_err(dev, "Failed to read max7360 FIFO");
> +               return IRQ_NONE;
> +       }

Maybe something like this (see also below about timeouts)?

       error = regmap_read(max7360_keypad->regmap, MAX7360_REG_KEYFIFO, &val);
       if (error) {
               dev_err(dev, "Failed to read MAX7360 FIFO");
               return IRQ_NONE;
       }

       /* FIFO overflow: ignore it and get next event. */
       if (val == MAX7360_FIFO_OVERFLOW) {
               dev_warn(dev, "max7360 FIFO overflow");
               error = regmap_read_poll_timeout(max7360_keypad->regmap, MAX7360_REG_KEYFIFO,
                                                val, val != MAX7360_FIFO_OVERFLOW, 0, 1000);
               if (error) {
                       dev_err(dev, "Failed to empty MAX7360 FIFO");
                       return IRQ_NONE;
               }
       }

> Sleep_us is 0 as we are in the IRQ handler,

Isn't it under the mutex, so we are fine to have small delays? But in general
it seems not okay to sleep here. In any case 0 for sleep_us gives an atomic read.

> but I'm not sure about
> timeout_us. We could set one to make sure we are not stuck in the IRQ
> handler, but the IRQ would fire again right after we return. I will stay
> with 0 for now.

I would still choose sane limit. The backend uses ktime for this, so it might
be corner cases (tickless systems) but in general should be fine.

> Also, the "max7360 FIFO overflow" message would be shown at most once
> per IRQ, so probably no need for dev_warn_ratelimited().
> 
> >> +	if (val == MAX7360_FIFO_EMPTY) {
> >> +		dev_dbg(dev, "Got a spurious interrupt");
> >> +
> >> +		return IRQ_NONE;
> >> +	}
> >> +
> >> +	row = FIELD_GET(MAX7360_FIFO_ROW, val);
> >> +	col = FIELD_GET(MAX7360_FIFO_COL, val);
> >> +	release = val & MAX7360_FIFO_RELEASE;
> >> +
> >> +	code = MATRIX_SCAN_CODE(row, col, MAX7360_ROW_SHIFT);
> >> +
> >> +	dev_dbg(dev, "key[%d:%d] %s\n", row, col, release ? "release" : "press");
> >> +
> >> +	input_event(max7360_keypad->input, EV_MSC, MSC_SCAN, code);
> >> +	input_report_key(max7360_keypad->input, max7360_keypad->keycodes[code], !release);
> >> +	input_sync(max7360_keypad->input);
> >> +
> >> +	return IRQ_HANDLED;
> >> +}

-- 
With Best Regards,
Andy Shevchenko



