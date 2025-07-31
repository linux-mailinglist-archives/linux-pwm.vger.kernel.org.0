Return-Path: <linux-pwm+bounces-6920-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA6E4B16F1B
	for <lists+linux-pwm@lfdr.de>; Thu, 31 Jul 2025 12:02:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85A173B5D4A
	for <lists+linux-pwm@lfdr.de>; Thu, 31 Jul 2025 10:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 046E9221561;
	Thu, 31 Jul 2025 10:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mL1VMlDD"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12E62A8C1;
	Thu, 31 Jul 2025 10:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753956130; cv=none; b=DjOWzJrqQQ8nWepRlo1Rh+KSzCtVuuxRXDDQ6HFUO+xkNMOPIc10hZWzZWEJCHyfACToiujDIqmdgZPAvt7BGuEacq/QMmM7yu/Z6WL/j8VBbGmQEo7vngx2XgZvnMUkEUd76DcuidF4vlnJZKKTULnqHEIiOijbmgAuzJO7No8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753956130; c=relaxed/simple;
	bh=B/lWDLuFzb4pOBkoCFR5w3l5ZJ+vboDdpy+Z+WH8fek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TZ8clcCxeGJH/g+PbdyqRghxJD/Ez7cSlQk8GD6rx2jIPdSCvPHtDwEMvxp26yst+7UXbHJwojthccEeWuw2VLM1bqsYZDSLQOarSlbgwKRcA5j9DZNWo55bALYYb6R2Q1vTwlaPJAWwuUlYTITw/N2AomoAH+bzfMzXbMiQSao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mL1VMlDD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7C70C4CEEF;
	Thu, 31 Jul 2025 10:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753956130;
	bh=B/lWDLuFzb4pOBkoCFR5w3l5ZJ+vboDdpy+Z+WH8fek=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mL1VMlDDH/oVTIVTnEG3D7rrmjfs7K5dbdnHeg+hN7wnsyuYgviEwfqQXd+RkNe/o
	 zdbJBI5OF7VoOz4kmHFIlqbh2LizzJi5jp/ntL180nWQJZv2y+lHmclEQWi78kB0ZX
	 InhuLL4DkASKFQcjtLVI+LRoVMNgbULrWKhc4YwpHMwz9g0DHtd18CWeVKKi8Faq+K
	 PKyUyZAIqydRawc+Rv56aWqRMWAomzcuAYBqj3O/soEHAL4+olpdmjUGM1mJq0KH8d
	 NeTuYWMRojDQf48/hny4yov93RmQgu9KKYIfMl8nZeT859tAbIe1zf2Q2o2e+xBYPT
	 Aleo8b3o3UROQ==
Date: Thu, 31 Jul 2025 11:02:02 +0100
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
Subject: Re: [PATCH v12 00/10] Add support for MAX7360
Message-ID: <20250731100202.GB1049189@google.com>
References: <20250722-mdb-max7360-support-v12-0-3747721a8d02@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250722-mdb-max7360-support-v12-0-3747721a8d02@bootlin.com>

On Tue, 22 Jul 2025, Mathieu Dubois-Briand wrote:

> This series implements a set of drivers allowing to support the Maxim
> Integrated MAX7360 device.
> 
> The MAX7360 is an I2C key-switch and led controller, with following
> functionalities:
> - Keypad controller for a key matrix of up to 8 rows and 8 columns.
> - Rotary encoder support, for a single rotary encoder.
> - Up to 8 PWM outputs.
> - Up to 8 GPIOs with support for interrupts and 6 GPOs.
> 
> Chipset pins are shared between all functionalities, so all cannot be
> used at the same time.
> 
> Lee Jones suggested the whole series goes through MFD subsystem, once
> all patches got the needed Acks.

MFD looks good.

Let me know when you get all (PWM?) the Acks and I'll merge the set.

-- 
Lee Jones [李琼斯]

