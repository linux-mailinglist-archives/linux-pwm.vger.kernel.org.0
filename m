Return-Path: <linux-pwm+bounces-2405-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BED349025CB
	for <lists+linux-pwm@lfdr.de>; Mon, 10 Jun 2024 17:40:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB946B2C987
	for <lists+linux-pwm@lfdr.de>; Mon, 10 Jun 2024 15:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4A82142E7F;
	Mon, 10 Jun 2024 15:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="guGRf5sY"
X-Original-To: linux-pwm@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142991422CA;
	Mon, 10 Jun 2024 15:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718033178; cv=none; b=ZYeT2n1EuDOFLLOO9wLx1oR/mNZQpJs8Um+EKCX4m6vBJMhcnVEtlK8AsP9RbAo8EgeAFDuUmhs7tOO5nVYalyxDgThOgTeSFCGZVmkUTucxVQJhY6VIEgjztqirCwP/lwhbhnvki4c7xZyspcTpnLGzPWZnBR5vMjwg3+DvC+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718033178; c=relaxed/simple;
	bh=1vFvZ2zJd0CuPcM/ebA1+wFn+pbF96AW6hJNpLAk5Ww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lLkqNN9S1tlZtaGWwm4UuJ4i47jWlkOF9rPKHTtylO8GXNqlh/yIJyjpIGxpByWbhf6RbpDd+HsglXANZb1BEeIxXom7eRX+v0xgtXrbKuGYSPi6IeyTJaaqDsv+m97nt4HowJBtGUGPvO2425CjKpoq1/A1ZtgO9loDB1y8e3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=guGRf5sY; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 3FB6266F;
	Mon, 10 Jun 2024 17:26:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1718033163;
	bh=1vFvZ2zJd0CuPcM/ebA1+wFn+pbF96AW6hJNpLAk5Ww=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=guGRf5sYrgq1r6A4VgY7eAsmcM1uh5KGYdHpDcvYJ3srl/fSySgs//5bLsL2Kz1oP
	 6m8fKsRK0qyGVPhfKMozSFcDadniOuWZUnSiEukS2oNT6z6KLDTy4RDRR5jqKuph7Q
	 YhlIhcdXRs/ADnH4sJeqxfGKVVG+UUCHWM2KAz0g=
Date: Mon, 10 Jun 2024 18:25:55 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Haibo Chen <haibo.chen@nxp.com>
Subject: Re: [PATCH v4 3/4] gpio: adp5585: Add Analog Devices ADP5585 support
Message-ID: <20240610152555.GV18479@pendragon.ideasonboard.com>
References: <20240608141633.2562-1-laurent.pinchart@ideasonboard.com>
 <20240608141633.2562-4-laurent.pinchart@ideasonboard.com>
 <ZmcYnDf0YIWA9A85@surfacebook.localdomain>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZmcYnDf0YIWA9A85@surfacebook.localdomain>

On Mon, Jun 10, 2024 at 06:15:40PM +0300, Andy Shevchenko wrote:
> Sat, Jun 08, 2024 at 05:16:32PM +0300, Laurent Pinchart kirjoitti:
> > From: Haibo Chen <haibo.chen@nxp.com>
> > 
> > The ADP5585 is a 10/11 input/output port expander with a built in keypad
> > matrix decoder, programmable logic, reset generator, and PWM generator.
> > This driver supports the GPIO function using the platform device
> > registered by the core MFD driver.
> > 
> > The driver is derived from an initial implementation from NXP, available
> > in commit 451f61b46b76 ("MLK-25917-2 gpio: adp5585-gpio: add
> > adp5585-gpio support") in their BSP kernel tree. It has been extensively
> > rewritten.
> 
> ...
> 
> > +static const struct platform_device_id adp5585_gpio_id_table[] = {
> > +	{ "adp5585-gpio" },
> 
> > +	{ /* Sentinel */ },
> 
> Drop the comma.

I prefer keeping it.

> > +};

-- 
Regards,

Laurent Pinchart

