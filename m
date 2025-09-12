Return-Path: <linux-pwm+bounces-7303-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9876DB54D13
	for <lists+linux-pwm@lfdr.de>; Fri, 12 Sep 2025 14:18:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15A381D62678
	for <lists+linux-pwm@lfdr.de>; Fri, 12 Sep 2025 12:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A7BB3090EB;
	Fri, 12 Sep 2025 12:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="HqXaT7jo"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F22302CB2;
	Fri, 12 Sep 2025 12:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757678873; cv=none; b=uT1/LbqUlgLsMfIlcfQznTlwCrJYhc1z3ZCCrUTQebYKHzUFyV+xqBE4QMJDLeHorlR5fQxiMVWxuue4LjgLNiAHAEROtTzYGaJsMZyyWnxe07Buvd62cAP0kSAY+R+7mei7Dx5MdVEM88UKb/1XjFErhfiGrLboXJxXTcbDLwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757678873; c=relaxed/simple;
	bh=V5L2Cqd1TLvPKhROh6gN8nsEJByTgaGs5MeM2XqfYTY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=HvXXRMg3DxQRg2n8yLbN6SgZTK8+5GZOsYXJn10GQYjCALI1t7Mo1vCBILx1BAO1ApIhU1j7lWJpFgknsWVgOvgcanlFtI38fzj4dyWtCpm9wBxdK5LSzyrH45C0sL30tLal9Z3ZvbFD8sIAOIoTDaJ+uO8VAUFwuWVlTJlraRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=HqXaT7jo; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id B85751A0DCF;
	Fri, 12 Sep 2025 12:07:49 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 84F4860638;
	Fri, 12 Sep 2025 12:07:49 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D49D3102F2956;
	Fri, 12 Sep 2025 14:07:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1757678868; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=V5L2Cqd1TLvPKhROh6gN8nsEJByTgaGs5MeM2XqfYTY=;
	b=HqXaT7joeZNpMcZaGgBB/2RbMv3VGyfWofHaIFcKukWp3jwIoYLWM8+390IbocOjZDLFH9
	SJ3g3uk3Zsf/rwPx2g1dYG8oTcV3InBrOJ7rWO+248cVpFd0oWZYe3IKuJ1Rv2g8rtIrcu
	25LYnUNhRp8yqeysD3ZUzC/pBnZBgVigifFN2PiMcF68qUwbbmhnTWyRwJeajJgy7Aszqu
	sUUsS0Lijb/fEVcj/Wgh9LyC4fKBHgyqH2s/vWGXX43JMntN9dSMvYMr29yo28pvvAJlSH
	mG5B7O1mxpXzmW22QkJ22oSVACTbUE8pKuyy0fW5tAW/JPZuQlmrYdsZ4DC6bw==
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 12 Sep 2025 14:07:39 +0200
Message-Id: <DCQT5KSSRURJ.1OMQGZG4XHMNP@bootlin.com>
Subject: Re: [PATCH v14 00/10] Add support for MAX7360
Cc: "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski"
 <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, "Kamel Bouhara"
 <kamel.bouhara@bootlin.com>, "Linus Walleij" <linus.walleij@linaro.org>,
 "Bartosz Golaszewski" <brgl@bgdev.pl>, "Dmitry Torokhov"
 <dmitry.torokhov@gmail.com>, =?utf-8?q?Uwe_Kleine-K=C3=B6nig?=
 <ukleinek@kernel.org>, "Michael Walle" <mwalle@kernel.org>, "Mark Brown"
 <broonie@kernel.org>, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, "Danilo Krummrich"
 <dakr@kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
 <linux-input@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
 <andriy.shevchenko@intel.com>, =?utf-8?q?Gr=C3=A9gory_Clement?=
 <gregory.clement@bootlin.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, "Krzysztof Kozlowski"
 <krzysztof.kozlowski@linaro.org>, "Andy Shevchenko"
 <andriy.shevchenko@linux.intel.com>, "Bartosz Golaszewski"
 <bartosz.golaszewski@linaro.org>
From: "Mathieu Dubois-Briand" <mathieu.dubois-briand@bootlin.com>
To: "Lee Jones" <lee@kernel.org>
X-Mailer: aerc 0.19.0-0-gadd9e15e475d
References: <20250824-mdb-max7360-support-v14-0-435cfda2b1ea@bootlin.com>
 <20250902152306.GV2163762@google.com>
In-Reply-To: <20250902152306.GV2163762@google.com>
X-Last-TLS-Session-Version: TLSv1.3

On Tue Sep 2, 2025 at 5:23 PM CEST, Lee Jones wrote:
> On Sun, 24 Aug 2025, Mathieu Dubois-Briand wrote:
>
>> This series implements a set of drivers allowing to support the Maxim
>> Integrated MAX7360 device.
>>=20
>> The MAX7360 is an I2C key-switch and led controller, with following
>> functionalities:
>> - Keypad controller for a key matrix of up to 8 rows and 8 columns.
>> - Rotary encoder support, for a single rotary encoder.
>> - Up to 8 PWM outputs.
>> - Up to 8 GPIOs with support for interrupts and 6 GPOs.
>
> MFD looks okay now, let me know when you have all Acks and I'll merge the=
 set.

Hi Lee,

The PWM driver just got Acked, so I believe we are good to go.

Please tell me if there is anything else I need to do.

Thanks,
Mathieu

--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


