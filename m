Return-Path: <linux-pwm+bounces-5136-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB216A5DE87
	for <lists+linux-pwm@lfdr.de>; Wed, 12 Mar 2025 15:01:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B9D93AEE80
	for <lists+linux-pwm@lfdr.de>; Wed, 12 Mar 2025 14:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EEB824A051;
	Wed, 12 Mar 2025 14:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="apy/J+F5"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C9E23E323
	for <linux-pwm@vger.kernel.org>; Wed, 12 Mar 2025 14:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=121.127.44.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741788075; cv=none; b=V1+yjcEfmfZb7L5TwVLaDwjzZguHfVD6lpKvNE+8p4IGKW9hRwkYRSXD/ZyqbEMGxNu+9r/D2k+RirEiVhTRB8a5H6+iiWPCRn3ONqeO4kVWIwFDPU41j7pjxIVgebmIT17O5hg/6whhFQkmBRlVHsCrJ2iBcjQLWBHBlcKq46Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741788075; c=relaxed/simple;
	bh=4sgumaYPXZCwRHncJELoOrDevUSg6yqopo5ifhPZcBI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fAH/ipHrvSgieHwOxqK6xnfhaJ+vQJmJsddmmaXmN8v3ifBcxLkYWw7obBU7ATklSm77qnVGQF8tkL+1SevgHb/s1yZUIH3zrOt/1sjzSO5RVGa+ZwzMcIwI+uhbo49p1kK9opjxfY7DYGvywoq7WS1n5x511wjrHYATGjN4PqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=apy/J+F5; arc=none smtp.client-ip=121.127.44.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1741788066;
 bh=FK77bkIxkuIQ2RaZVUX+w+kEVUOJvqyQlYfCNDo4oio=;
 b=apy/J+F53lEE6ZXXi5L1hKUb/Udt8pKv5i8UuLcH/PMdmUhnOM6LARCufHgSXLgkzbm7X3pFi
 wIvu7uKIwB3fi8Q+Zae2QMFP+f+mxxm1g/LdjI/fGf+P11lT/7ASIoBLJoTbH1uDyXugegVDhmG
 S3nT+lzQnRhS0zetkuh5bEgTjj3NjPggK+XlGihDpCqcOmKkzVr69+mqYtwn/77Hwq31o/ftsfX
 W8oFh+K58PeuwIxL3bJT2dIAiFBCZ7qCZNwDxVmsc596rGzPKKmOnjOSO+gvS3fznoZApRdd64r
 t7UIxO/wQzBCUJ4MnzY6efxI8ZVl/yRSN2R8a/AFIPFg==
X-Forward-Email-ID: 67d1939ea3842b4a6f18c3e1
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 0.4.40
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <a5ec9062-ca57-4748-8c0f-fb5b9c75fa28@kwiboo.se>
Date: Wed, 12 Mar 2025 15:00:57 +0100
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: (subset) [PATCH 0/2] arm64: dts: rockchip: Add pwm nodes for
 RK3528
To: Heiko Stuebner <heiko@sntech.de>, Chukun Pan <amadeus@jmu.edu.cn>
Cc: Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Yao Zi <ziyao@disroot.org>, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-pwm@vger.kernel.org
References: <20250307120004.959980-1-amadeus@jmu.edu.cn>
 <174176555637.249409.2785731072183565436.b4-ty@sntech.de>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <174176555637.249409.2785731072183565436.b4-ty@sntech.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Heiko,

On 2025-03-12 08:45, Heiko Stuebner wrote:
> 
> On Fri, 07 Mar 2025 20:00:02 +0800, Chukun Pan wrote:
>> Add pwm nodes for RK3528. Most rk3528 boards use pwm-regulator to
>> supply to CPU, add node to enable them. The PWM core on RK3528 is
>> the same as RK3328, but the driver doesn't support interrupts yet.
>>
>> Unlike other SoCs, pinctrl-names need to be in "active" state,
>> I'm not sure about this, but otherwise the pwm-regulator will
>> not work properly.
>>
>> [...]
> 
> Applied, thanks!

The pinctrl-names should be changed to "default" and not "active",
something you can fixup or do you want a patch?

In commit 96d8d3253246 ("arm64: dts: rockchip: Fix PWM pinctrl names")
similar issue was corrected for current rockchip boards.

Regards,
Jonas

> 
> [2/2] arm64: dts: rockchip: Add pwm nodes for RK3528
>       commit: 2973d077aedfc114affab96c3b2c7286163cc8c9
> 
> Best regards,


