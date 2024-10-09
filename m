Return-Path: <linux-pwm+bounces-3547-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 83978995D7E
	for <lists+linux-pwm@lfdr.de>; Wed,  9 Oct 2024 03:56:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2112FB238D9
	for <lists+linux-pwm@lfdr.de>; Wed,  9 Oct 2024 01:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78A243FBB3;
	Wed,  9 Oct 2024 01:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="ZgQdKmFr"
X-Original-To: linux-pwm@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63AD383;
	Wed,  9 Oct 2024 01:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728438972; cv=none; b=M3L77nC+PyotTxYUzm/A5xH6h9CUKbtcnBD5xSSx9AWcLCnVagOPsrmx90Yj0F8JZsiseWXDNVa//enG5H57RUX5SAwpsMSci5cWSY3kJGbdEJyq9l7zAKPP0xujMR8qG47WJ1bf56NqP9zidAxxWtXK7Ir2U8W/seVGZTbLHBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728438972; c=relaxed/simple;
	bh=+skyX18Cw/Mk9hJ3nJ7IAFqG3N0Qrlo3+F072XVLLOI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gOqkCglT/uKkFUlRAvt0ovh02I9fomweo7r+3T1YGAZleFBf1jUWAn0BpYKm2XhK2+1xv4krWWETZuD9Vm2u96dEbOj9U8BphPY1Qm+V6yxGDdyZ3OUtkXL7SzcHfHJTp1HxFaESoHC7OC+10lAlnnI7KqwW7zQbwKUFnuLK3+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=ZgQdKmFr; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id C7544890A9;
	Wed,  9 Oct 2024 03:56:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1728438969;
	bh=foI8pHzGkBAVELbTQPq3v4rUIZ60X3ygQWrpfbKRFmg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZgQdKmFrPp2tX1f0mxzJuZO9GmAdxGd24n4bGthoBke6g2sZdA0CPa/jrRowX5WCf
	 +8rav+Q20u/DNPaPcHa80Ulyr+UAZ/MwZWP6z26n2KzlG+amnbpvvyQXgOBpIIUGj7
	 uPPVNNCFNbhuWFwx0Uc/4Rc62Y6xuLlLAmHeVApPO0b+jiZ6RqXBMQskeY5BA8cDQT
	 KDCVhEgLD8ML+vu8XzYh32W/zIRRfGFnEUj/Z3LIu8eMl2zRNMpoF6LBn4p8WZwgax
	 VCV851hpn6Ji4DMVyBjsbCsRoNtI4Es5vsIV8AivzmysP9WcC/aItdWKIBG74V6S/q
	 borbxpd3+lEjw==
Message-ID: <41cc47bd-f18f-463b-a0dc-843088ecf91e@denx.de>
Date: Wed, 9 Oct 2024 03:55:35 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 1/1] pwm: imx27: workaround of the pwm output bug when
 decrease the duty cycle
To: Frank Li <Frank.Li@nxp.com>, u.kleine-koenig@baylibre.com
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, festevam@gmail.com,
 francesco@dolcini.it, imx@lists.linux.dev, jun.li@nxp.com,
 kernel@pengutronix.de, krzk+dt@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-pwm@vger.kernel.org, p.zabel@pengutronix.de, pratikmanvar09@gmail.com,
 robh@kernel.org, s.hauer@pengutronix.de, shawnguo@kernel.org,
 xiaoning.wang@nxp.com
References: <20241008194123.1943141-1-Frank.Li@nxp.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20241008194123.1943141-1-Frank.Li@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 10/8/24 9:41 PM, Frank Li wrote:

[...]

> +	c = clkrate * 1500;
> +	do_div(c, NSEC_PER_SEC);
> +
> +	local_irq_save(flags);
> +	val = FIELD_GET(MX3_PWMSR_FIFOAV, readl_relaxed(imx->mmio_base + MX3_PWMSR));
> +
> +	if (duty_cycles < imx->duty_cycle && (cr & MX3_PWMCR_EN)) {

I think you can use state->enabled instead of (cr & MX3_PWMCR_EN).

