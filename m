Return-Path: <linux-pwm+bounces-5146-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF971A5EDE0
	for <lists+linux-pwm@lfdr.de>; Thu, 13 Mar 2025 09:22:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA736189F9B3
	for <lists+linux-pwm@lfdr.de>; Thu, 13 Mar 2025 08:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3D9678F34;
	Thu, 13 Mar 2025 08:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="UA4p/fAI"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4711DF26F
	for <linux-pwm@vger.kernel.org>; Thu, 13 Mar 2025 08:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=121.127.44.59
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741854141; cv=none; b=YMuXCupzq0jMSFfHzTetOJTCQ4+c41444v6ZDxOSNRI/nJJIy7jMgcORm8MldRtJheHitExn1SpaqxOLrzg1ItI5BEq5mYJPpgTc3fqKo0C4UHpz88b0wPQFQqDE53CrixLCtm2+Dkww/gXCXzN5qa41IQUZbY0EfRLK6a1LyLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741854141; c=relaxed/simple;
	bh=lpexoIwlDAaOjLTBnIEGgWkXlf+ZNRKe4g36xBvm0TA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UF/NH5wkCDteMCHPG6K8fruYs4yNpAxBAmXosx5GdCbbFsU/ryVM8cQpXWloQaHb9TdXAndZ0cvWse2Gs2/HE8FaSjj5q6elvUIqE4qEzLSDEvgjyhFRwlw1mQqo3CN5hc5GENGihnsU7tsEa6V5Grsz55ZhiJdJ7gN44wwtYlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=UA4p/fAI; arc=none smtp.client-ip=121.127.44.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1741854137;
 bh=+6TtqnWRHap1+zGPihePGn3UrV1PoskvkH+xAMooAk4=;
 b=UA4p/fAIAIjf15CT406GFI7+0LhZOyfCtKnvZ5sQsV8fc4J33Swa6ZTMYWY7BfKEY4DrG6ghn
 8dhWqDYg07jhbAbSsvyxB+u8Ktv4Cf39QxorkrVEfkLdzBWJAfQd1ON+m39fV9jgaj1TlFzd8av
 DlExNS4kUhPYi5Mut3O34bj7nPQ1kWyPBZFS0z6Zx9wn2kpVuFGXakQfn4sPBAUy//asCCGLYE7
 SkgUl+MsfXH+zKiUAL2Z7mGoCLe9H/DusF9GhVJOFo4dBqNYMlfvZEZZNEwkvOd34OEYOsBpBhL
 X757X8SI3Z4QRyrgyTS9ucxBu9z+O5YVetmmN7rAEQyQ==
X-Forward-Email-ID: 67d295b469c9ba463efbea93
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.59
X-Forward-Email-Version: 0.4.40
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <60065c0b-4597-4976-b74b-172556c4e156@kwiboo.se>
Date: Thu, 13 Mar 2025 09:22:08 +0100
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] arm64: dts: rockchip: Add pwm nodes for RK3528
To: heiko@sntech.de, Chukun Pan <amadeus@jmu.edu.cn>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, krzk+dt@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-pwm@vger.kernel.org, linux-rockchip@lists.infradead.org
References: <7779050.EvYhyI6sBW@phil>
 <20250313071031.1840032-1-amadeus@jmu.edu.cn>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20250313071031.1840032-1-amadeus@jmu.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 2025-03-13 08:10, Chukun Pan wrote:
> Hi,
> 
>> so yes of course the pinctrl needs to be default - simply because
>> that's the only pinctrl state mainline supports.
> 
>> But judging by the fact that you're discussing working vs. non-working
>> below, can you please check if we should drop the patch for 6.15 till
>> that is solved?
> 
> I suggest dropping this patch first, I will send v2
> when this issue is solved.

I noticed that the pwm nodes and saradc node ended up in wrong mmio
address order, so yes please drop the patch (or reorder nodes) ;-)

Chukun, please get back with more details about the issue you are having.
E.g. a stack trace, what board, DT and U-Boot you are using etc.

I have not seen any issue with PWM using the merged patch having
pinctrl-names=default.

Please see my Linux tree [1] and U-Boot tree [2], those are little ahead
of what has been posted on ML, e.g. it has working USB2.0 host, CPU opp,
Hantro VPU, GPU + opp, arm and logic pwm regulators for E20C, ROCK 2A/2F
and Sige1.

Will try to post USB2.0 host and Hantro VPU patches later today.
CPU opp and GPU + opp depend on PWM and I was planning to post that
together with initial thermal support.

[1] https://github.com/Kwiboo/linux-rockchip/commits/next-20250311-rk3528/
[2] https://source.denx.de/u-boot/contributors/kwiboo/u-boot/-/commits/rk3528

Regards,
Jonas

> 
> Thanks,
> Chukun
> 
> --
> 2.25.1
> 


