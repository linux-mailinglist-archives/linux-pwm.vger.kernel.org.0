Return-Path: <linux-pwm+bounces-1648-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1BA1869CFE
	for <lists+linux-pwm@lfdr.de>; Tue, 27 Feb 2024 18:00:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A673C1F22EE2
	for <lists+linux-pwm@lfdr.de>; Tue, 27 Feb 2024 17:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C296B249F5;
	Tue, 27 Feb 2024 16:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="lTuy1O/O"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5DC1E871;
	Tue, 27 Feb 2024 16:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709053199; cv=none; b=mJ6RVRwyz0gzThzo1+O7bvFIJGaa/uP3gosKgdco29zhNupWDdKGTvy6TZnXGAKZPHkmcYnQFkHOstsKt0RdKbwRxjJnuFe0brwWgFNYx1M1mmmKbggk/EsHnpPA00XXAiT/v1oIYDDFCnW2+Kw8havgURreRrqatowjDKfHY2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709053199; c=relaxed/simple;
	bh=/B7LelH4C9+7KN5snCerIQZt9DJfVqzKB8tK+DeSzIU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q502uOHho2CWnRNCxi/+SE/WdQUfjczvTfgZu2Uj4t8NaauttT/y+1JQ29wr8n0av73PgH7f46D535cZ1QZi08CCujPZHMI1aC/65s9sKhWGgEKsPgFyggy5p1UuZ2ohyeKT3QN3eSb58YU+BY4566TPU4LjhUvB2Ip0TpUlLes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=lTuy1O/O; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=s31663417; t=1709053183; x=1709657983; i=wahrenst@gmx.net;
	bh=/B7LelH4C9+7KN5snCerIQZt9DJfVqzKB8tK+DeSzIU=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=lTuy1O/O9F96ZLgrvw3CbNNnT7wlFbteL9hKwcLY9KFiocmxXqnMrTtSdD6+K/Rl
	 xb0WZHsqWb2r3HdJzfNFMK5CAqcKR5XMf1n+6/pl+uaaa7qNaB5Lyet/74Mzk4PxD
	 G3ve9tShKZ9EyrpgEgnofulTLUyNqG1/lht2qJ8Akoz4CdQH2Y76A/AZ/H5kwcFiR
	 dwe5bdXivLC9iB2z3FNClQw6gokZMbKIEO47h7uaMt3UDjPmIT0womX0e+pceQ7a5
	 rvUEAk912pbDX5yy2b1V51LrIEqBwVsFxXo8zSYlQOLTLfH2NlxkcxzniliJP3nAh
	 6/40CYGYrMMAt68M5A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.167] ([37.4.248.43]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N0X8u-1qitpr2cQ0-00wRse; Tue, 27
 Feb 2024 17:59:43 +0100
Message-ID: <3e65fd65-ccfc-4a77-8934-52791662bdce@gmx.net>
Date: Tue, 27 Feb 2024 17:59:40 +0100
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 2/2] pwm: Add GPIO PWM driver
Content-Language: en-US
To: Chris Morgan <macroalpha82@gmail.com>
Cc: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, andy.shevchenko@gmail.com,
 Angelo Compagnucci <angelo.compagnucci@gmail.com>,
 Philip Howard <phil@gadgetoid.com>, Sean Young <sean@mess.org>,
 Linus Walleij <linus.walleij@linaro.org>, linux-pwm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
 Vincent Whitchurch <vincent.whitchurch@axis.com>
References: <20240204220851.4783-1-wahrenst@gmx.net>
 <20240204220851.4783-3-wahrenst@gmx.net>
 <65de00aa.540a0220.f1081.6933@mx.google.com>
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <65de00aa.540a0220.f1081.6933@mx.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4iuxu59Rwv26h5ynZ7P87p2WwtTz/IbU6nbihWne8+8BnV6ieQu
 XRj9F9Nd5PLHtS87JAk2JnHKRMbmn1Gf4BEKgAhLHK0/ycdwY7wqP/ejND3fTIuj+xLbUOe
 1uSvzMndZzdtwpKZ1G0kmgxo3tPGX1ekb/KtsLoc4VuR4USymZsYxqmGZ9Rp/mOCQ0zl6S4
 1iX8WmTDzTZi5vuwDCU7A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:EbUIyjHgN24=;zGsFF/y1JP3Oy+HkmHN9SSxfqP9
 W+AENJfWf+TxN9Ht4xUfeXpZ1bd2F1rstI15qaIWy4kndULOAHb4A2eU8JbVDLX2zcockTHHF
 kjC4ZecSlQIUJtHP2WY7ZPEWpewBqNM7t5iOv5Dxjt6uI+r5UUXtcYqylyov9X7WzbuDnqCl0
 LnopYxXaqLrcqEwFfZRl5O4pDp+4KQ0ggOKefeVVTFhRi7S3IKY/WI4m3ev3YYp90PGhSMcsQ
 8i0PriNS/bwN6N70fodrejlmLaLPnvUez3b9YOllLfrfcIAk07V59CoLjpBAnUXFlQUNuPT3h
 ATd5EhFYdbSQarcSqgNv6Z8RWFGvULniZgpkB0FItDgAudJ7RyPCmTF1DTs4297omg0RUTrdC
 eARZcc10d4HJxc7c5DRZdJ3NTon7XpuNp6ceXGuQiK35IFwD45z3WL4JZIbpgOWWMZLiDPEu9
 0HysrC/VvCAmwOfuFzxiNFNlQ7QCg4n2G/bqWVFnBY+XAzYYtmpq9ADeU1TXyf8CqASPnD8CF
 GkI3+wDNXC9p1ylX7oxnBy77VZXpB1EmL8BixHEAX8/1V+N25xinmzk6NRT3FRyNRaCCn5Ybi
 RolUFJ3USov/a9n+j2NSfUSM7fvAEHH92FnVdh+A7nLnd7g8XlsWgLeNjn4AYRb4vOiXItUno
 Qu5GAj+ZxJpA1Ba75Y29BsAKMqIH96BWUNx+woBxgEHZqUxkCI4SWkUCKwZdGLCu0WG2Yxntq
 KEQIzlnjBRtBmZGGondbbHrr9vHtWN6QxBXBmUWAKALca+MdJ9eyyoYAkIMdkGOa83macJBJy
 RfefVNyhzZ6tdCgKep4M27S9IAWBRJoZAoTYpeYpFsyAI=

Hi Chris,

Am 27.02.24 um 16:32 schrieb Chris Morgan:
> I have a series of devices with GPIO controlled force feedback that
> this driver helps us control better. So I'm looking forward to this,
> thank you.
Thanks for testing. I didn't had much time recently and i was fighting
with hr timer resolution stuff. But will try to send the next version in
March.
> Note that when I set the resolution too low (I got confused and set
> the period to 255) my device locked up hard and only a forced
> power cycle could bring it back.
Unfortunately this is a general design issue by driving the GPIO by a
kernel driver and "expected" behavior. I didn't have a good solution for
it yet.

What period is too low without limiting other users?

The only idea which comes to my mind is to introduce a kernel parameter
for this driver to set a lower period limit. This can be provided by
some administrator or system designer with enough experience. So a
general user doesn't need to care about it.

Best regards

> Tested-by: Chris Morgan <macromorgan@hotmail.com>


