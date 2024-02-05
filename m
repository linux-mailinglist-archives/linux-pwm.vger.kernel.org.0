Return-Path: <linux-pwm+bounces-1202-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51D9C84939A
	for <lists+linux-pwm@lfdr.de>; Mon,  5 Feb 2024 06:55:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E41651F23860
	for <lists+linux-pwm@lfdr.de>; Mon,  5 Feb 2024 05:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA6D3BA28;
	Mon,  5 Feb 2024 05:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="SwhvQZio"
X-Original-To: linux-pwm@vger.kernel.org
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC48FB670;
	Mon,  5 Feb 2024 05:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707112534; cv=none; b=IX0IH7P7egq2N3AARu9dX0qU10fNB+E7hMERmmQ/5lQE1hQ68JS7fEhjg2NQZYwyCOffAq7S+KnkVpXBu0cf387mwCpvEV5c3/P7dPqvto2WSTYX5NTbEGeyEkTtsVDr4nG+M3AhWaFxiCxlorXtHbgiSVFdMJDqtIpaaFE8iaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707112534; c=relaxed/simple;
	bh=ju6YE0oBHIeK9zcvvq+qvKrPJsFzxoBtpAAHRsRvN80=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tPF1QQMREAJU/MBwMyX6mhlfC1uKFsqWjxHn8yL0FnDIB5HcpUr9xJG9C+j3V5LT+an/xWUg+XREEmPTx9MskBAqVzHB1lkG2Z/29CLmMfGzg4FYsWIXtLbXUv9+rJgaK6HgZXlmnWz/XPWc2TfmADJ8UlU9QVTI1iZ3cysKvo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=SwhvQZio; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4155tGiV120696;
	Sun, 4 Feb 2024 23:55:16 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707112516;
	bh=LvEJrWyHyN0lxHNcqKJjNjH0q34jTFfI5LghukRsGIg=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=SwhvQZiozpvh0Xe3ph2T/TA7tWW85Ay4lv2lMBijRRUUeGz2GVCltUJPv6YbVC7+9
	 ccNiLx/2CARmJrSag5T2EUrsnR8DvZJviK0DxT3le9KHe+4LUtFgtgACamJ+OGhtAg
	 +cb0AK2uz+SMMumbJRX5WGq4BL6HcQ1261lUvHp4=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4155tGBF001855
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 4 Feb 2024 23:55:16 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 4
 Feb 2024 23:55:15 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 4 Feb 2024 23:55:15 -0600
Received: from localhost (dhruva.dhcp.ti.com [172.24.227.68])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4155tFDn117159;
	Sun, 4 Feb 2024 23:55:15 -0600
Date: Mon, 5 Feb 2024 11:25:14 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Stefan Wahren <wahrenst@gmx.net>
CC: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Rob
 Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, <andy.shevchenko@gmail.com>,
        Angelo Compagnucci
	<angelo.compagnucci@gmail.com>,
        Philip Howard <phil@gadgetoid.com>, Sean
 Young <sean@mess.org>,
        Linus Walleij <linus.walleij@linaro.org>, <linux-pwm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-doc@vger.kernel.org>
Subject: Re: [PATCH V4 0/2] pwm: Add GPIO PWM driver
Message-ID: <20240205055514.rox6yd2eenhsngva@dhruva>
References: <20240204220851.4783-1-wahrenst@gmx.net>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240204220851.4783-1-wahrenst@gmx.net>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi,

On Feb 04, 2024 at 23:08:49 +0100, Stefan Wahren wrote:
> Add a software PWM which toggles a GPIO from a high-resolution timer.
> 
> Recent discussions in the Raspberry Pi community revealt that a lot
> of users still use MMIO userspace tools for GPIO access. One argument
> for this approach is the lack of a GPIO PWM kernel driver. So this
> series tries to fill this gap.
> 
> This continues the work of Vincent Whitchurch [1], which is easier
> to read and more consequent by rejecting sleeping GPIOs than Nicola's
> approach [2].
> 
> The work has been tested on a Raspberry Pi 3 B+ and a cheap logic
> analyzer.

I recently came across this series and I have to say that it will sure be
a nice to have feature to be able to use any GPIO as a PWM.

However, just a minor suggestion is that we should make sure it's well
documented how to actually use this. It would be much appreciated if you
could include some basic documentation of a few sysfs commands or any
userspace library that you used to test what you've mentioned above.

Maybe add another patch for this page?
https://docs.kernel.org/driver-api/pwm.html#using-pwms-with-the-sysfs-interface

This will ensure people know about this feature and will actually be
able to use it.

-- 
Best regards,
Dhruva Gole <d-gole@ti.com>

