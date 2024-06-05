Return-Path: <linux-pwm+bounces-2346-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C7F8FC32B
	for <lists+linux-pwm@lfdr.de>; Wed,  5 Jun 2024 07:53:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E7CCB250D9
	for <lists+linux-pwm@lfdr.de>; Wed,  5 Jun 2024 05:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95D9821C186;
	Wed,  5 Jun 2024 05:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="MOnMbvNB"
X-Original-To: linux-pwm@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584DA21C17F;
	Wed,  5 Jun 2024 05:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717566767; cv=none; b=Un48SHJ0Un7YZZTkbjyhFgzbcmCqwNGgZwf9neJWSA+QspY0+i6qmO6WszHy9UzW8iA2PkONru+VzBQnimFr0Exd9u6ThqfeG4NstlDTRV4NShTuJ3zs18q9hD6tlE668lB41STltJLnLopkavsWcFZ/w8uptq0saooYyRLBqPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717566767; c=relaxed/simple;
	bh=p+PzInLP+pe7SlKCHsWsS/k6Dd0Bl0VM0YIUxVBTgOA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OjBmL+k3Q7WygGOHl1udxPmL9+LsaMjA8VzK0wjN+7NBb3Ch7WY3gc2pSVHosiADorkECPzpukIeLgPRjQSy78jMr9pmqvR4TkjFNbchAYlKaUdq21t7fW02Z4qeIMySUeoeabO4iQdN3Q1LWT7sjlvYFopOaHnUvl+a6Woxl9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=MOnMbvNB; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4555qOTW001666;
	Wed, 5 Jun 2024 00:52:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1717566744;
	bh=RXwxKDglUHGw8iXienbiFGxa+YrigrmBMjwrRPtrhr4=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=MOnMbvNBu7AEJjvROJ/JNyT2MdWHOy6ZsvYVvSkyvQlPgPvhQjmp54jbYfmlPmJqm
	 My4k+2obV2qoxZCiq7/xwSUlCiBZ2NHEQwFHgpZOUdjd/pgfaMr9AOFqbplRoSGEtz
	 l7QA8mbFLO5mDmpKrUM+5A1Qk4kHtFMlXGlKZh8k=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4555qO9G059288
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 5 Jun 2024 00:52:24 -0500
Received: from lewvowa01.ent.ti.com (10.180.75.79) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 5
 Jun 2024 00:52:23 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by lewvowa01.ent.ti.com
 (10.180.75.79) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2507.34; Wed, 5 Jun
 2024 00:52:23 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 5 Jun 2024 00:52:23 -0500
Received: from localhost (dhruva.dhcp.ti.com [172.24.227.68])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4555qM71044039;
	Wed, 5 Jun 2024 00:52:23 -0500
Date: Wed, 5 Jun 2024 11:22:22 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Linus Walleij <linus.walleij@linaro.org>
CC: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>, <andy.shevchenko@gmail.com>,
        Philip Howard
	<phil@gadgetoid.com>, Sean Young <sean@mess.org>,
        Chris Morgan
	<macromorgan@hotmail.com>,
        Stefan Wahren <wahrenst@gmx.net>, <linux-gpio@vger.kernel.org>,
        <linux-pwm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Vincent Whitchurch
	<vincent.whitchurch@axis.com>,
        Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v7 2/2] pwm: Add GPIO PWM driver
Message-ID: <20240605055222.vi2mu6atmz7vezns@dhruva>
References: <20240604-pwm-gpio-v7-0-6b67cf60db92@linaro.org>
 <20240604-pwm-gpio-v7-2-6b67cf60db92@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240604-pwm-gpio-v7-2-6b67cf60db92@linaro.org>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On Jun 04, 2024 at 23:00:41 +0200, Linus Walleij wrote:
> From: Vincent Whitchurch <vincent.whitchurch@axis.com>
> 
> Add a software PWM which toggles a GPIO from a high-resolution timer.
> 
> This will naturally not be as accurate or as efficient as a hardware
> PWM, but it is useful in some cases.  I have for example used it for
> evaluating LED brightness handling (via leds-pwm) on a board where the
> LED was just hooked up to a GPIO, and for a simple verification of the
> timer frequency on another platform.
> 
> Since high-resolution timers are used, sleeping GPIO chips are not
> supported and are rejected in the probe function.
> 
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
> Co-developed-by: Stefan Wahren <wahrenst@gmx.net>
> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
> Co-developed-by: Linus Walleij <linus.walleij@linaro.org>
> Reviewed-by: Andy Shevchenko <andy@kernel.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  Documentation/driver-api/gpio/drivers-on-gpio.rst |   7 +-
>  drivers/pwm/Kconfig                               |  11 +
>  drivers/pwm/Makefile                              |   1 +
>  drivers/pwm/pwm-gpio.c                            | 241 ++++++++++++++++++++++
>  4 files changed, 259 insertions(+), 1 deletion(-)
> 

Reviewed-by: Dhruva Gole <d-gole@ti.com>

-- 
Best regards,
Dhruva Gole <d-gole@ti.com>

