Return-Path: <linux-pwm+bounces-7583-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CE9A9C2CED0
	for <lists+linux-pwm@lfdr.de>; Mon, 03 Nov 2025 16:56:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 792DE3468A1
	for <lists+linux-pwm@lfdr.de>; Mon,  3 Nov 2025 15:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0A4E313E1E;
	Mon,  3 Nov 2025 15:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="kKUupT4R";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="ZPv989lv"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C07E236435
	for <linux-pwm@vger.kernel.org>; Mon,  3 Nov 2025 15:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762185366; cv=none; b=VL2R7PbKBFn3qJmqVIN8w5Tx4rqDMT1UeGwlFrPblEHk6AL4t2oj8emybkhgc2bDjk0UFd6j11/Bi7ymH1VRtOXUeThUUKnrtGltLvZLKdDnX1b73vIjUi6UyoKz70XsqKVh1NISkG7SsnnEwsFhmbrnb/uLE4R5yLPPxgZNmBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762185366; c=relaxed/simple;
	bh=/ipuyYTIQ1/WRsCnWLbCbdWxgJzZFpx1PyhsFClLJZs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jrUs6I2ssl6FucA5m0tg6jqITTQYLUSsmCxzhMM8K82pY+203yNwLs8HNY2CoYh7DZf3jtbZm2CvtqpSL2Z8GVclstA4un6eZykW11x798cjZTKmvUHNfelbGZ5srlOlHPBN6g3aY61syCiaSQlj3JKZrYCi90Pxic4iKDbJYJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=kKUupT4R; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=ZPv989lv; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4d0blz1HCRz9tRJ;
	Mon,  3 Nov 2025 16:55:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1762185359;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HebIZo7LSq7Q6JaAZyeO4HuT48a3PPZYoSqINPPEdik=;
	b=kKUupT4R+JeN9ZsONgvH+3oRoBcCtP1IPDixdWJ9jqkwD/RUQjt23ZPa8Px72KV5K0ZUWJ
	BndfcWWERuNWM+6txkzReHEBt8ei20SxBJkD+NL9vwhaOkntuAeMATuEGyHFwiAmERGqRk
	u03YHQTJwymm/YMoI2uafryzCtBIUGnIkA9aGTRcDzJXYdixpwyMIOTE3uwxLYjHfLtjYB
	n9NPxkXaykOfNklUPjSSQQRmnFZmFQuMyIvpzla+tXD0oD/UnUNQ+kjzr1kQEM1nSMPtoQ
	zl2WZKXio4YslBaEd6/DvxlTAO91wbTFa4zw4YpKMPyNfN7UxUkUr+tzfUb1Cw==
Message-ID: <05b5b096-33cd-45c4-9d9c-286d743c6916@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1762185357;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HebIZo7LSq7Q6JaAZyeO4HuT48a3PPZYoSqINPPEdik=;
	b=ZPv989lv4HQgzwAh8M8cJltm563aZsdyQSky2yIQBRQo3cfF7YKAeaJw6wmU/hGsY4UAVB
	dKPKGJ7pAxe09thnebHc1G+qNJzHomTRmLsP7lM7yCFVqL9Gze/1jk7D9rBAPmr6xktszc
	FTOPM2EvorscCUpdoQDV2hzZ7QksJHzYsDuvJErdjbmljWSpUkvnQBUyObVljjBniOwo/+
	nBsIgKR2TMksoZ8h1g/4U/tnmzJRZeEO2lj/2hubDafFPNi0ChBPax8aR344tHkCKenecK
	qh63H0bmtUpqe8SWsL2p7iLG9pQhOwTGA5a38i+UneU861H8h3idKVjkIay57g==
Date: Mon, 3 Nov 2025 16:55:55 +0100
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] pwm: argon-fan-hat: Add hardware dependency
To: Jean Delvare <jdelvare@suse.de>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
 <ukleinek@kernel.org>, Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-pwm@vger.kernel.org
References: <20251103164752.533aee39@endymion>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20251103164752.533aee39@endymion>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: dqptdpnwz7hq9835zi9hb1s99asxmnxe
X-MBO-RS-ID: afef346ccd5ecb077a7

On 11/3/25 4:47 PM, Jean Delvare wrote:
> The Argon fan hat is designed to be connected to Raspberry Pi 3+
> systems, so only offer this option when building a kernel which
> supports this architecture (unless build-testing). Also extend the
> description to reflect that.
> 
> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> ---
>   drivers/pwm/Kconfig |    4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> --- linux-6.17.orig/drivers/pwm/Kconfig
> +++ linux-6.17/drivers/pwm/Kconfig
> @@ -68,9 +68,11 @@ config PWM_APPLE
>   
>   config PWM_ARGON_FAN_HAT
>   	tristate "Argon40 Fan HAT support"
> +	depends on ARCH_BCM2835 || COMPILE_TEST

NAK, this is wrong.

This fan plugs into any arbitrary board with compatible 2x20 connector, 
not only RPi. That connector is present on all kinds of fruitboards with 
different non-BCM2835 SoCs.

