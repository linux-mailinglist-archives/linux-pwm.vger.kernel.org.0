Return-Path: <linux-pwm+bounces-6482-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46F77AE4BEC
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Jun 2025 19:31:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB04F17BF99
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Jun 2025 17:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 369F32BD01B;
	Mon, 23 Jun 2025 17:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="ok/sPASM"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ECD629CB31;
	Mon, 23 Jun 2025 17:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750699841; cv=none; b=KxMzT61tj37CcCQq7nTycBDNiJWQ5exWpTwmjkmpTYexdvvmn2zWJaUOkhTlxRbFtANQAmRV+lXH4IvYFLc1YIYr6WmWuZdd8FnXHBGGelqozRINlCPBck+iN/Jwzdzu5LycKYG41721uPfdE019FPpvip+MhAmR9O84HUEJXrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750699841; c=relaxed/simple;
	bh=DUz9DkDPksM68vM8VjoJ4Fn0qWoFH3j+eIq7pEER7yI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JLCWUdfLZQJDMEi0G7Q3AeEOC3ec417SyEeI2TW4rbohhhn/E3AQyA/JF/TwVnWp0tNUodsuZWLyE+mDJ0cUctOGyK6lR1dTy9iU1KKP4Y71YRDwHNy2RTKu2AsvfiiAXJDFCFXt7TF67I+OCa8btezy8oBQAw34YihlFb4DTTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=ok/sPASM; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4bQw8W3jYlz9sJ2;
	Mon, 23 Jun 2025 19:30:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1750699835;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gVQBJE3O5hWd22dP+NHNYkocneGEZLxBMOp7ka97pNI=;
	b=ok/sPASM/De2bzzXdhUGxASAOQkrXL6NJwkltadXdV+kcvA2LATzfFPLii+Rck2oSKCzum
	sXLpIYTLE6WY2W9ldfHtSYdux02F3fMiv4D9OQnFdDd6Js3RtDT7qomk2IMCypx4gOTL/x
	ICXY9pKwNEUHfXeTiLjwofSpmDxRoA4WOXa5WzyIUdjGYVO1j42AsJ18GMBeKa8GObWoVZ
	d4DrBq3w056IQyO2Q6UvhRCnglhDp1EiRoZjQURp6JQMfTD2qaAZVD5ArZ9K5gV4VK9+7z
	+zfdtR+paAFgVuVNmE/WgSRGusxwBnemp/9mSeTMkvLIfHwgmHrZGQC7DdXCPQ==
Message-ID: <dbec18f0-5df4-4eb8-93ab-da6ccfedf8ab@mailbox.org>
Date: Mon, 23 Jun 2025 19:30:33 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4 3/3] pwm: argon-fan-hat: Add Argon40 Fan HAT support
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: linux-pwm@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>,
 devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
References: <20250621172056.160855-1-marek.vasut+renesas@mailbox.org>
 <20250621172056.160855-3-marek.vasut+renesas@mailbox.org>
 <purpjdp72jw2rok5ihyua635izyih54ufom2knsbaiwdd3jzgk@6wjf364fao2g>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <purpjdp72jw2rok5ihyua635izyih54ufom2knsbaiwdd3jzgk@6wjf364fao2g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: atwcd4idrktq9teeb15on37ayenhxamx
X-MBO-RS-ID: 0e8d127bce028be0e92

On 6/23/25 11:11 AM, Uwe Kleine-König wrote:
> Hello,

Hello Uwe,

> when I replied to v3 this v4 was already on the list which I missed. My
> concern applies here, too, though.
> 
> On Sat, Jun 21, 2025 at 07:19:56PM +0200, Marek Vasut wrote:
>> +static void argon_fan_hat_i2c_shutdown(struct i2c_client *i2c)
>> +{
>> +	argon_fan_hat_write(i2c, 100);
>> +}
> 
> If you drop this, I'm willing to apply.

Dropping this would make the hardware which uses this device more 
susceptible to thermal damage, e.g. in case it gets stuck during reboot 
and does not boot Linux afterward. I don't want to risk such thermal damage.

-- 
Best regards,
Marek Vasut

