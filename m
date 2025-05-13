Return-Path: <linux-pwm+bounces-5940-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6294AB4FD1
	for <lists+linux-pwm@lfdr.de>; Tue, 13 May 2025 11:31:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 104863A3D78
	for <lists+linux-pwm@lfdr.de>; Tue, 13 May 2025 09:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CEBE23814A;
	Tue, 13 May 2025 09:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mHI0+0jx"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D69A634EC;
	Tue, 13 May 2025 09:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747128675; cv=none; b=q5jZSqo56AnWecP4Di2JDhtOXEBuxdJN2c6kq+KcttRNMtGaZAzc2C4ECAn3dO3MXiTprzU8937LNmzK8qk9zILgEBGBeTiX8uSF7alG9CJg+OCxiaOrInr2Thc1FBsyA5ibbKs5sSeCJlVfl6mXJo2EQ8sIgnZQlBnme/69BXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747128675; c=relaxed/simple;
	bh=jsqqrcfYq+bnJqM7TR/bt4mLPJ69Cu+o4leVutMS2Rc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ah762fjjGMSS43/Y2Mp2yWwGLrQWdhJk/zKOTmqXBLxxtUYl0XwnyqVOrPDT2xXu16GtouQ3Kl3A0HIUpME6JRQO9jxOj5Iuzx8HNb2xgv1cAsuyOdH3SiNHLRHDV27aJ5rd6/hfGqbsobqlP2uq9J3wPYKs8YQu6VkCgGklJ30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mHI0+0jx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8118BC4CEE4;
	Tue, 13 May 2025 09:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747128674;
	bh=jsqqrcfYq+bnJqM7TR/bt4mLPJ69Cu+o4leVutMS2Rc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mHI0+0jxgvDq2H+naSqE+eBaNqvmqwpNyecqNTZZ4VHserpQaOPhA9RvDuTyTjF5s
	 /zsm9sMwCSOd8gTOQzxtYKbmsqsnUt09M0K6fEEHlph919MDI2nyVU9+Cs3ULBXsVO
	 FK6w1HJEsWuBhuiUhPTV831bzeFCQERsTj353uaDRyhQs9sz6sL5k/BaIl8Hu7D36v
	 unFPlEg+BZ2Y2uKdvwGcpeqaKJhe/NV6l95bwuZ9Bb8dhUaUOS1Ob2ABNPBKQAR8wQ
	 4wXNSLla4/E1/Dwq0zWf4UNeb7+616VqCYaKTbj9IZypnncAlk2RzLISBn80P7IRiI
	 74JIJz09QyCXQ==
Date: Tue, 13 May 2025 10:31:07 +0100
From: Lee Jones <lee@kernel.org>
To: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
	Rob Herring <robh@kernel.org>,
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
Subject: Re: [PATCH v8 02/11] mfd: Add max7360 support
Message-ID: <20250513093107.GC2936510@google.com>
References: <20250509-mdb-max7360-support-v8-0-bbe486f6bcb7@bootlin.com>
 <20250509-mdb-max7360-support-v8-2-bbe486f6bcb7@bootlin.com>
 <aCG9lyaCGchBsqLE@smile.fi.intel.com>
 <D9UW14SJQ9HV.3BA1FYKMG9DE0@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D9UW14SJQ9HV.3BA1FYKMG9DE0@bootlin.com>

On Tue, 13 May 2025, Mathieu Dubois-Briand wrote:

> On Mon May 12, 2025 at 11:21 AM CEST, Andy Shevchenko wrote:
> > On Fri, May 09, 2025 at 11:14:36AM +0200, mathieu.dubois-briand@bootlin.com wrote:
> >
> >> +#define MAX7360_REG_GPIO_LAST		0x5F
> >
> >> +#define MAX7360_FIFO_EMPTY		0x3f
> >> +#define MAX7360_FIFO_OVERFLOW		0x7f
> >
> > Please, be consistent in style of the values.
> 
> Is your point about the alignment of the values? Most of these are
> aligned on column 41, including the ones above. I just have an exception
> with MAX7360_PORT_CFG_*, as they are a bit too long. But as we are using
> tabs here, indentation appears a bit broken in the patch.

I believe the point was in reference to capitalisation.

-- 
Lee Jones [李琼斯]

