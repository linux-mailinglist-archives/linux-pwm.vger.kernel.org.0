Return-Path: <linux-pwm+bounces-927-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F79283B25A
	for <lists+linux-pwm@lfdr.de>; Wed, 24 Jan 2024 20:37:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 630431C222CA
	for <lists+linux-pwm@lfdr.de>; Wed, 24 Jan 2024 19:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95B0A132C28;
	Wed, 24 Jan 2024 19:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="tTfqsQKo"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534D6131E39;
	Wed, 24 Jan 2024 19:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706125056; cv=none; b=ua9SdKF8b85MofSdbkzB3mBW4NJKgqKn/yXiqnOTjKZJecW4K4wl3KiCpsel26e5LYNvFXg1jyp5oeEQq9gQPOv+D9LA1/8EzjZTrYhg/gXp/Id2CTl7o8vUMJLJfOBg+hjNnA+oWmldmuImcswuer3jER6DkRpYhX73DTTw/50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706125056; c=relaxed/simple;
	bh=8gF2zYmT73BaR2b42YgHV15OigRTq91dnWWthEZAAyk=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:In-Reply-To:
	 Content-Type; b=S4pbAZ7m2BW0NNT67ISZOxTKBJVl5ZT6GhM7qW3UksvvMvDp+E1p9hcgjPWJuZmYgYW874QIFANBt6QunVRpx/wswoMSGZeCp+rkTP2ZnorzVShZGe+b6cru0sMxnD2R2KqVSMWavAcjQkxBQNRKfyIwLme+HzjPAUCivVXC3Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=tTfqsQKo; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=s31663417; t=1706125037; x=1706729837; i=wahrenst@gmx.net;
	bh=8gF2zYmT73BaR2b42YgHV15OigRTq91dnWWthEZAAyk=;
	h=X-UI-Sender-Class:Date:To:Cc:From:Subject:In-Reply-To;
	b=tTfqsQKoQuvcwoOJzbylW9+fFgqXFCdRPbco9s2Jl6fJg6SsHlR0RmJYAaQqgKTL
	 NHZLTptfMYS5lJP6hBXCmPSBoNwcekV4SsJA99ZOske3i1iDJBL+3AJh5VMd+LhT9
	 CcgCmk6fIJzRUWUk02lujtliZzSNDPQrLhr6iDIPF7fq6/YPtSTXYt+vncrtNpLve
	 C1Ub6nkrubs8qo6hJjx5Lmd0HJhH8SmoCyfGbZ7kWWl2caB5gO+s+xa9wg7vyO/kV
	 II1nwYO8gUoCSiiDPoW59ry74Q0vRe9HXk1W9nLTFsrZpdX7WZDBbUGFcbSBy+U4v
	 Fi4wkNxHLx+uRLTqlg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.167] ([37.4.248.43]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MvK4f-1rAv9w2kGv-00rGJX; Wed, 24
 Jan 2024 20:37:17 +0100
Message-ID: <bd2771f5-3452-4089-aa00-34663a64513d@gmx.net>
Date: Wed, 24 Jan 2024 20:37:12 +0100
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Philip Howard <phil@gadgetoid.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: andy.shevchenko@gmail.com,
 Angelo Compagnucci <angelo.compagnucci@gmail.com>,
 Linus Walleij <linus.walleij@linaro.org>, linux-pwm@vger.kernel.org,
 Lee Jones <lee.jones@linaro.org>, Rob Herring <robh@kernel.org>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>, linux-gpio@vger.kernel.org,
 Nicola Di Lieto <nicola.dilieto@gmail.com>,
 Vincent Whitchurch <vincent.whitchurch@axis.com>, oliver@schinagl.nl
From: Stefan Wahren <wahrenst@gmx.net>
Subject: Re: [PATCH v2 1/2] pwm: pwm-gpio: New driver
In-Reply-To: <5521796b-d51e-42a3-831a-7fbf75247726@gadgetoid.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sat+73QjtVWKrNElalBKI+uwWSRX3sTXFWqMUUJaH7LsHE2uFJn
 5NUVPRkaVHNiZc9jfe60+t68T4CS+eHmcwDIZN9y31SXPauj1EEeXm9OiTpoViTpZ5NxGzK
 SSy5EVDxa3UVYLcPTJl3+XN7c29far6yVisHCMcrWNzcWOpKae+6lEE5TVDDj+M0+gAxeUX
 NaucH7zlRtj6whVahRXsw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:FFHi9V95lKQ=;fTIIxpVVnxbLInl7g1Zs5gY/q3w
 tNIRNSCL2VR6I+HZ1T7rpiq6owI7tM11eAuFFFLBpR7wlEkPIToh2J1+rzFlcDGdQIxXZNXnJ
 JRlvWzE7/4xSPqatLVvkwtWgnf5aEv7RrDSiwq2eo0vO30w4PffYhL/Bon4hqzxEI3M4ENdjy
 /nf288ETOdbBhi+fI1b+PpUfOK9pk1LlKr+HOwh7auoCzkjZIAh2rNoX9xOwowcXHrgAJb6ZQ
 Npf/f79aYsselH6diLODJDQjb6ZWq17MWNG8pHIeW6eLDl39ZGavxI69G5C5hXUTme0RrwcZs
 0h97VIPiljxXzjTsCGHEfFibdNWHgcqTCKshDE7nXukdi/5xEdqJNP6lsGRqIAHzejM/y/oAj
 S85a/Js5elz5Upp7ZJXtPRCqVG8XgZf4m9uBGAe7pO/ZqbMKp5HuiST5BSmanxGkPl6fu1u1y
 3i9AibeCwm3/96aidbE7UyQV4azdTdQDRB58vWZlws/Pn0Z6Z/G2hS7G1iYN/ZhvvI6e5oBPV
 T8tdR+n+TjXq/RwF58moQh5ai5DaVUtZO0cLdwP9I49+rkXy3GxiIR4LYPTlazyT6cFAVdD41
 sPiajWLiyPGXP/mRJ7BuplLTJ4pdDWvp++1HuFyTIZ5GvbxjTfx3doQiloXKNvfkjZxrp000O
 8JXgJamNocnI1tjf53ckREpbp3Oo5wVmtYXr1lrLJgw8+rnJD7GIYTXTdKzNBKGbw8oNHXyx7
 U2DSpRvj1rMLZR9E76PwEaX38rhxmVZcFdQOGCTcA3ZrnORX5RGS8g9VMqQwMT4BPKY7/ExwA
 5WpQYlAycKQWcfTVXbhCNBOABgb/f1az2FmYic4jV6c8IQ7nR4tq8DviGFpJkMxNp4SJKmfWa
 Ws8liRCgP7TvjVjdaIZnV8CtBA1oJ3FZi6kJS+pWGL26rLGNw7HVOzh1xJm8dy33QR27QF2tA
 VzH//A==

Hi,

i was working on this a little bit during the holiday. Personally i
prefer Vincent's approach [1], which is easier to read and more
consequent by rejecting sleeping GPIOs. So i prepared a WIP branch [2],
which was tested on a Raspberry Pi 3 B Plus + a cheap Logic analyzer. So
maybe you want to give it a try. I will try to send a proper series soon.

Changes:
- rebased Vincent's last patch series on top of Linux 6.7
- cherry picked some improvements from Nicola's series
- tried to address Uwe's, Linus' and Andy's comments
- tried to avoid glitches during probe

Best regards

[1] -
https://lore.kernel.org/all/20200915135445.al75xmjxudj2rgcp@axis.com/T/
[2] - https://github.com/lategoodbye/rpi-zero/commits/v6.7-pwm-gpio/


