Return-Path: <linux-pwm+bounces-5149-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A81EA5F3B3
	for <lists+linux-pwm@lfdr.de>; Thu, 13 Mar 2025 13:04:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B311918913E1
	for <lists+linux-pwm@lfdr.de>; Thu, 13 Mar 2025 12:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 672861FAC51;
	Thu, 13 Mar 2025 12:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="vpCyCZ4k"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D52266B5C
	for <linux-pwm@vger.kernel.org>; Thu, 13 Mar 2025 12:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=121.127.44.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741867396; cv=none; b=IzrkSPo49xNWRvKJY8l66jpCnDzOq5p/WG7S5hAjxjFGpGpMJeBUmg/MCHY24lwWVLNQJrTZ3K8IPXfPGPdpSpq4IIaYBo1UM/dSbrxVvO+VO6fHt3iuBAJhJu6P99a/AUwGZhq3C26jtsCNCEjpMKW1i9BHyeFh9JwOQNStN/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741867396; c=relaxed/simple;
	bh=bZNNGOED+1l8XZ/zYpoer0VQ2XGh/RdyKEnP1jUgGFc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VkdB8dNOpXLCgrIsyJJqIPRytcU6dsi/mpPIr8RW8AMx4qso76gWMrehr5bes4kqqTi4c05zuLzAJWR0TMmZvgeFj5uoVmLPx1xBIBHXdEV8IZqazTX8gTLhvokY1s535fAcZSk2IKDeA/44fye1PaL/IHTKAWij8sHX9BhHcd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=vpCyCZ4k; arc=none smtp.client-ip=121.127.44.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1741867393;
 bh=bZAbj6+NmXSfWd9Y3ZYRj3CY/kM/CunfChIIkSXsoRg=;
 b=vpCyCZ4khpNqoDvqJU9TMENoRt+h8k/WjOOPJFrgrXSasDIKUaHDmGYBDQz3IYnBHpd9100Km
 /f0Cn43B4d1zOPMk9v+lghttUOgFaqw2kUbq1+ZmxuJppsEu/EXPS5uv3XZCtIbuj/VSLJfORDQ
 nZiUP8FRRx52Z3zr6lQ1wasdy5qkxnt+QKKzKCgmw9NjgK1JRJ/S5Q2m5oWlE5Uqxemn3PP4elt
 5Ni/iCWmnoCH60jg4rDkfAWEg1sHKodzQ+suYuJjlP2MvR/hnhSd9rCZnGwZusDzmVIfpTzZZ9y
 5ZqHbYgjO4xtw5anN2b79xgQZb7mDePo2Qw3tJ5uctzA==
X-Forward-Email-ID: 67d2c97dc524b8270342b1d9
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 0.4.40
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <22d849c3-8a0d-4704-b69c-8019c7f70ca7@kwiboo.se>
Date: Thu, 13 Mar 2025 13:03:04 +0100
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] arm64: dts: rockchip: Add pwm nodes for RK3528
To: Chukun Pan <amadeus@jmu.edu.cn>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, heiko@sntech.de,
 krzk+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
 linux-rockchip@lists.infradead.org
References: <60065c0b-4597-4976-b74b-172556c4e156@kwiboo.se>
 <20250313090109.1910997-1-amadeus@jmu.edu.cn>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20250313090109.1910997-1-amadeus@jmu.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 2025-03-13 10:01, Chukun Pan wrote:
> Hi,
> 
>> I have not seen any issue with PWM using the merged patch having
>> pinctrl-names=default.
>>
>> Please see my Linux tree [1] and U-Boot tree [2], those are little ahead
>> of what has been posted on ML, e.g. it has working USB2.0 host, CPU opp,
>> Hantro VPU, GPU + opp, arm and logic pwm regulators for E20C, ROCK 2A/2F
>> and Sige1.
>>
>> Please see my Linux tree [1] and U-Boot tree [2], those are little ahead
>> of what has been posted on ML, e.g. it has working USB2.0 host, CPU opp,
>> Hantro VPU, GPU + opp, arm and logic pwm regulators for E20C, ROCK 2A/2F
>> and Sige1.
>> ...
>> [1] https://github.com/Kwiboo/linux-rockchip/commits/next-20250311-rk3528/
>> [2] https://source.denx.de/u-boot/contributors/kwiboo/u-boot/-/commits/rk3528
> 
> I tested your kernel device tree on E20C earlier today and still have
> the same issue. But if I replace u-boot with the link [2] you provided,
> it will work fine. For reference, I was using v2025.01 plus this series
> of patches [3]. So it looks like u-boot does something and kernel doesn't?

Interesting, good that it works with the updated U-Boot. Main change
compared to v1 is that it now use clock/reset id and DT closer to what
has been merged in mainline Linux. It also has DT params to help
initialize the two pwm regulators used by these boards.

I will try with the old v1 U-Boot series and see if I can replicated
your issue.

Regards,
Jonas

> 
> [3] https://lore.kernel.org/u-boot/20250123224844.3104592-1-jonas@kwiboo.se/
> 
> Thanks,
> Chukun
> 
> --
> 2.25.1
> 


