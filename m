Return-Path: <linux-pwm+bounces-7241-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C22B408D7
	for <lists+linux-pwm@lfdr.de>; Tue,  2 Sep 2025 17:23:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44F86202E86
	for <lists+linux-pwm@lfdr.de>; Tue,  2 Sep 2025 15:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29E7031DDAF;
	Tue,  2 Sep 2025 15:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l7e+2r+t"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4422DA751;
	Tue,  2 Sep 2025 15:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756826594; cv=none; b=eq+i3J4g6zY9/YX2oG9IXdCEEDl3QtYarrRztrgS+Q9lXgJuqbhmS4Rz8EQMYjHOiQm0lCdTPi7vthEOLe9Tz6RLuqLdn2EkgPPj3Y4ymFrdSZWm9e3jQGqJYmxhw7MF98Dmv5hGBZkLE0DdsyYlcLJ6fXR1E7X8jrhb225tPOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756826594; c=relaxed/simple;
	bh=0k7XOc/MAWxBHAWe2nQltg0rfeGbxKlH0oH7p5vvKxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nEyEzc8Xvg29gqL78pu+EpT1EjLKz1weTVxXIFKS2yBawvYUo1GOEYDyve/6WfZoieVV0ye4lKRVVJw+GNGaz/Onus6QxkiyNejrWLzeF8UFlIF++RDBTNplf5Xu/Gb/cG1X/OT8g8U80IZF0U6nenWhGnowoYsJub0tpq6lESc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l7e+2r+t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27BC6C4CEED;
	Tue,  2 Sep 2025 15:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756826593;
	bh=0k7XOc/MAWxBHAWe2nQltg0rfeGbxKlH0oH7p5vvKxE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l7e+2r+tgkWmKO2zrTo30FsU8aZv8IrCXZz60X5iMyD7MZTujB5nhhXxv3GC+LJJd
	 s458S2UQCg3YMsgA+5NT1oFTuVwgMsjzXKmaxraBWieRLFU8outKdNAN8JkXbvH522
	 X9vl0T+IVoQb0VxTsDq1MEYpk91XZvxhTJ6Zq5Y5SnpxDPOtHW+BN3guPA+053QlFB
	 i+zrTN3RwHAU8qeoqMekA53Ae/tH9oXeVDmKq87v0COvVtwwOGrqs3GDckklnWUKlM
	 BPv8PMGX9mGSVnkH5e6aNDYO0yST84eVSm4/y8qhyh/4yxhVWhPqdlGw7MifJvzfhT
	 9tjfcIEwf0bKw==
Date: Tue, 2 Sep 2025 16:23:06 +0100
From: Lee Jones <lee@kernel.org>
To: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
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
	andriy.shevchenko@intel.com,
	=?iso-8859-1?Q?Gr=E9gory?= Clement <gregory.clement@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v14 00/10] Add support for MAX7360
Message-ID: <20250902152306.GV2163762@google.com>
References: <20250824-mdb-max7360-support-v14-0-435cfda2b1ea@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250824-mdb-max7360-support-v14-0-435cfda2b1ea@bootlin.com>

On Sun, 24 Aug 2025, Mathieu Dubois-Briand wrote:

> This series implements a set of drivers allowing to support the Maxim
> Integrated MAX7360 device.
> 
> The MAX7360 is an I2C key-switch and led controller, with following
> functionalities:
> - Keypad controller for a key matrix of up to 8 rows and 8 columns.
> - Rotary encoder support, for a single rotary encoder.
> - Up to 8 PWM outputs.
> - Up to 8 GPIOs with support for interrupts and 6 GPOs.

MFD looks okay now, let me know when you have all Acks and I'll merge the set.

-- 
Lee Jones [李琼斯]

