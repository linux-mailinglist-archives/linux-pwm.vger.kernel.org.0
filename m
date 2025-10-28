Return-Path: <linux-pwm+bounces-7506-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4530BC14419
	for <lists+linux-pwm@lfdr.de>; Tue, 28 Oct 2025 12:05:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 321CF1B2105C
	for <lists+linux-pwm@lfdr.de>; Tue, 28 Oct 2025 11:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE61230BBBF;
	Tue, 28 Oct 2025 10:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="S1mtYRFF"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-m32116.qiye.163.com (mail-m32116.qiye.163.com [220.197.32.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A82306B0D;
	Tue, 28 Oct 2025 10:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761649098; cv=none; b=dJmHvP82T1qWLD7uGomCTz4Z/iSPGAKuBoPVysx5nPYHvQ+SADiGajzU5PFIx/9IcQKorGZW5Uy1NTKIHupmRPIulRC0b3zlfbG12I8CpMZkaKlm6n6MDR7p4JStadOy5wiJ0rROnP7Dp6HxvklxC9KTihDg92JPb1+MEIVrrbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761649098; c=relaxed/simple;
	bh=26olVJnTBzVdqfMxmqduKc3AaTMDecoatS6OLyYX9xo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ksDa6jrnXQK+v9WO1vHApBtOm219qH90kzlP2MTNnzFPyvTfITmewprwfGQCrGoP1jxhvTMtkWXOMrPWT0FnUQW5XXpXewd0GLiGI79iFZ6pBJ9PP3Wfh/UlsY+LceLar3I7fJZvTowcLsQ+2iSKCf42/tZrqfb1Zm9gxJ2pIQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=S1mtYRFF; arc=none smtp.client-ip=220.197.32.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.26] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 277b7c941;
	Tue, 28 Oct 2025 18:42:52 +0800 (GMT+08:00)
Message-ID: <dbb5f7b4-7dac-413e-8c0a-4f962b79eae0@rock-chips.com>
Date: Tue, 28 Oct 2025 18:42:51 +0800
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] dt-bindings: pwm: Add a new binding for
 rockchip,rk3576-pwm
To: Conor Dooley <conor@kernel.org>
Cc: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Lee Jones <lee@kernel.org>, William Breathitt Gray <wbg@kernel.org>,
 kernel@collabora.com, Jonas Karlman <jonas@kwiboo.se>,
 Alexey Charkov <alchark@gmail.com>, linux-rockchip@lists.infradead.org,
 linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>
References: <20251027-rk3576-pwm-v3-0-654a5cb1e3f8@collabora.com>
 <20251027-rk3576-pwm-v3-1-654a5cb1e3f8@collabora.com>
 <ff9631f5-8fff-4be8-8b6f-807c29943ef6@rock-chips.com>
 <20251028-favored-dynamite-fa626b96ecba@spud>
Content-Language: en-US
From: Damon Ding <damon.ding@rock-chips.com>
In-Reply-To: <20251028-favored-dynamite-fa626b96ecba@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a9a2a69de4503a3kunm3a0251b715b88b
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQxlMHVZKGkkeHR5DSUMZH0NWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=S1mtYRFF6hi+IK7RpvYsFRyQjzX9G+C1YGR+qZrW7CHGySfkhkjEJ6cltXdZZ5ZnbzFXXAyotA4NNbci43z7eiXayHbWdngregdEBj7/lEfAf2r4yQn0YVx5aR/TJErMMP3zqlDTE2SMXXNZJ7JDijcgo9+npF4OSioc323AKx4=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=gWFZ7wFU0oJn0xlF0a8hdwI8bFTvAeFwgQl1T8susj4=;
	h=date:mime-version:subject:message-id:from;

Hi Conor,

On 10/28/2025 4:50 PM, Conor Dooley wrote:
> On Tue, Oct 28, 2025 at 11:06:15AM +0800, Damon Ding wrote:
>> On 10/28/2025 1:11 AM, Nicolas Frattaroli wrote:
>   
>> The RK3506 and RV1126B platforms that are about to be upstream also use this
>> PWM IP. Would it be better to name the yaml file "pwm-rockchip-v4.yaml"?
> 
> No. Files should be named to match a compatibles.
> 
>> Then subsequent platforms only need to expand the compatible property.
> 
> That's all subsequent platforms need to do anyway!

Got it.

Best regards,
Damon


