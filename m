Return-Path: <linux-pwm+bounces-4579-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B48BFA08D8F
	for <lists+linux-pwm@lfdr.de>; Fri, 10 Jan 2025 11:12:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6735160E91
	for <lists+linux-pwm@lfdr.de>; Fri, 10 Jan 2025 10:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02E9120B1E1;
	Fri, 10 Jan 2025 10:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="CgI98iJr"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-m49221.qiye.163.com (mail-m49221.qiye.163.com [45.254.49.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759D620E004;
	Fri, 10 Jan 2025 10:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736503780; cv=none; b=eVRp++WMyyqHi9olRTZ1lPN98J9PlcnHMaNOPPcDHpW6Q8vF2gbffHo9NTwsfCTjZt6Vj433oX7+nDSOXA9WAlNm4nI9lmQ0D7m15t/Jwdi9f7pKsBfcxKSvjcB0vQxs8jbuwIaOPq/gW4HpAxFRo0T0BYRpCU+LNrizHlOJ0rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736503780; c=relaxed/simple;
	bh=SnFH98ibQzsvQhtTYNyPTVrfsL5nJpMT8T+fexoCZ8A=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=njDTNkw6eAilb78zFWT2mxsYeKNiwwkys9y2msNiYAdOtLLT23JgQR/QyEuApQNi0IQaP28OL4BONzsztHGelN/deoHMjIvuT/qs6HRtrxWRiq+SM46Vpymt9wcXvJymgwa4EG7Du/w5RrRymczpVzXXx7/bcwqSBIo9E5Wg3J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=CgI98iJr; arc=none smtp.client-ip=45.254.49.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [192.168.60.65] (unknown [103.29.142.67])
	by smtp.qiye.163.com (Hmail) with ESMTP id 85663352;
	Fri, 10 Jan 2025 18:09:25 +0800 (GMT+08:00)
Message-ID: <46372c17-d317-4477-9635-36564c73cc6a@rock-chips.com>
Date: Fri, 10 Jan 2025 18:09:24 +0800
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Kever Yang <kever.yang@rock-chips.com>
Subject: Re: [PATCH v2 11/17] dt-bindings: pwm: rockchip: Add
 rockchip,rk3562-pwm
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: heiko@sntech.de, linux-rockchip@lists.infradead.org,
 linux-pwm@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
 Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20241224094920.3821861-1-kever.yang@rock-chips.com>
 <20241224094920.3821861-12-kever.yang@rock-chips.com>
 <qvr7x4anlxxtpxjywrqjihxyxejw4i73wrh2ibl3hasayew4s2@obyuxce4ez4g>
Content-Language: en-US
In-Reply-To: <qvr7x4anlxxtpxjywrqjihxyxejw4i73wrh2ibl3hasayew4s2@obyuxce4ez4g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDQxpDVh1CQkIfSRhJThpLSlYVFAkWGhdVEwETFh
	oSFyQUDg9ZV1kYEgtZQVlKS0hVSUJVSk9JVU1MWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
	VKQktLWQY+
X-HM-Tid: 0a944fb0ac4c03afkunm85663352
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PRw6NRw*EjIJOQ4wEUpNIjw#
	M0gaCwFVSlVKTEhNTktITE1DSUtKVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
	EgtZQVlKS0hVSUJVSk9JVU1MWVdZCAFZQUpLQkM3Bg++
DKIM-Signature:a=rsa-sha256;
	b=CgI98iJrbeouOxI5b3pc4yw7d68VlP0GdydTJiwcX10/5mN0FWV7zhLTXRanZv0ZTZD/hnL1SHzCg3YBgWbnO/UGPiuoYcbjTq2OeVjvfuU6Ow+ExujrV0lg1V6Sd5ZCOgZAQPX/6enhwZ/j/Ecn/1WeiNZWAdMyXOh5dKijOPw=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=SnFH98ibQzsvQhtTYNyPTVrfsL5nJpMT8T+fexoCZ8A=;
	h=date:mime-version:subject:message-id:from;

Hi Uwe,

     Thanks very much for your review.

On 2024/12/27 15:24, Uwe Kleine-König wrote:
> On Tue, Dec 24, 2024 at 05:49:14PM +0800, Kever Yang wrote:
>> Add rockchip,rk3562-pwm compatible string.
>>
>> Signed-off-by: Kever Yang<kever.yang@rock-chips.com>
> What is your merge plan here? From my POV merging the pwm update via my
> pwm tree would be the easiest. But if you want to let it go via (say)
> arm-soc to have it all in a single tree soon and then base new
> development on top of that, that would be fine for me, too.
I send this in a patch set for a new soc and board because there is
no driver change needed, and I think it would be more clear for the new soc
support. It will be great if maintainers like you can pick the patches
for the module which I guess is preferred way in the kernel maintain rule?
Or else I have to follow the comments fromKrzysztof to send patches one
by one separately.

Thanks,
- Kever
> In the former case, please tell me. In the latter case:
>
> Acked-by: Uwe Kleine-König<ukleinek@kernel.org>
>
> Best regards
> Uwe

