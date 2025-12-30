Return-Path: <linux-pwm+bounces-7835-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 92DCCCEAE44
	for <lists+linux-pwm@lfdr.de>; Wed, 31 Dec 2025 00:38:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 94F5B30581E4
	for <lists+linux-pwm@lfdr.de>; Tue, 30 Dec 2025 23:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E69592FDC28;
	Tue, 30 Dec 2025 23:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b="sMi7S4cK";
	dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b="sMi7S4cK"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail.mleia.com (mleia.com [178.79.152.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9948E2E5D32;
	Tue, 30 Dec 2025 23:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.79.152.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767137780; cv=none; b=b44p63QbAy/qGlVRG24j2nGrHJiHxAzy9H701Rp2AagjWU0CGZJXDAiDXSCny1DgsLE8wj/Gz3E8wKv6p2e56gkHO72JtkCn4eGLiILDlyzJcDs6SsiujumxFSegORSGh2ZmQfug4BScd3aSRGnzntmKSeWInM3WD2paZRg5jas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767137780; c=relaxed/simple;
	bh=fRbNyr2cuRipwrLi8FVp7melLLkMjoIZA13ghnT0lS8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JP8tntQaog8oe0NI3eHldcPLso5weEFDeAlQq55aXiJw5LwyXdqYJ+BqrhMGLwwNv+OLEn2+cD+9SWNgHq97YUMK9Xxzt0P4Oo8y9r/EcFP/yh/XJ3cO5ZymoLcjCu24QTLLpOGnD3fPc85G14jT1MJu/RA9SjOkIUGvj5F0oV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mleia.com; spf=none smtp.mailfrom=mleia.com; dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b=sMi7S4cK; dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b=sMi7S4cK; arc=none smtp.client-ip=178.79.152.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mleia.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mleia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mleia.com; s=mail;
	t=1767137768; bh=fRbNyr2cuRipwrLi8FVp7melLLkMjoIZA13ghnT0lS8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=sMi7S4cKutKVX/HnKgs8r+o63CntnvognGZ5p1Um4zhoI7xXB6za5k1FWWfO2aD5o
	 HT7Z9Gip4Qd9f8KPmAcD8xHjvnTvImNtISAUsjqhdOH+xOyYS9TJ/Jqc+l96R63RtN
	 PxWBbyBot3UXTxrLZLYitjTo3DJaBdJ0XKKBNlH4kMCc6bWYO/K7zQfx06Ieak4ut0
	 0k90B4qlINbi2FxAPyn34tR9gbAGx/LMVFdWKQuxGg3WB9bOAtWK5GtivPP2FlbWUG
	 2DN7mpEm5fXaMIzkhWD7pwOx0NVm0lDV/AD0mvUc7H/xDfqYxZiAiPkr5S/uwDEz1s
	 Y86kuLCx27FtQ==
Received: from mail.mleia.com (localhost [127.0.0.1])
	by mail.mleia.com (Postfix) with ESMTP id BD7103E956D;
	Tue, 30 Dec 2025 23:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mleia.com; s=mail;
	t=1767137768; bh=fRbNyr2cuRipwrLi8FVp7melLLkMjoIZA13ghnT0lS8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=sMi7S4cKutKVX/HnKgs8r+o63CntnvognGZ5p1Um4zhoI7xXB6za5k1FWWfO2aD5o
	 HT7Z9Gip4Qd9f8KPmAcD8xHjvnTvImNtISAUsjqhdOH+xOyYS9TJ/Jqc+l96R63RtN
	 PxWBbyBot3UXTxrLZLYitjTo3DJaBdJ0XKKBNlH4kMCc6bWYO/K7zQfx06Ieak4ut0
	 0k90B4qlINbi2FxAPyn34tR9gbAGx/LMVFdWKQuxGg3WB9bOAtWK5GtivPP2FlbWUG
	 2DN7mpEm5fXaMIzkhWD7pwOx0NVm0lDV/AD0mvUc7H/xDfqYxZiAiPkr5S/uwDEz1s
	 Y86kuLCx27FtQ==
Received: from [192.168.1.100] (91-159-24-186.elisa-laajakaista.fi [91.159.24.186])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.mleia.com (Postfix) with ESMTPSA id 369463E9491;
	Tue, 30 Dec 2025 23:36:08 +0000 (UTC)
Message-ID: <9bb897bd-a7b1-442b-8931-dac9826de2c9@mleia.com>
Date: Wed, 31 Dec 2025 01:36:02 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm: dts: lpc32xx: add clocks property to Motor
 Control PWM device tree node
To: Rob Herring <robh@kernel.org>
Cc: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>,
 Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
 linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20251228224907.1729627-1-vz@mleia.com>
 <20251228224907.1729627-3-vz@mleia.com>
 <20251230175933.GA864856-robh@kernel.org>
From: Vladimir Zapolskiy <vz@mleia.com>
In-Reply-To: <20251230175933.GA864856-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-49551924 
X-CRM114-CacheID: sfid-20251230_233608_792516_4FCC31B4 
X-CRM114-Status: GOOD (  16.24  )

On 12/30/25 19:59, Rob Herring wrote:
> On Mon, Dec 29, 2025 at 12:49:07AM +0200, Vladimir Zapolskiy wrote:
>> Motor Control PWM depends on its own supply clock, the clock gate control
>> is present in TIMCLK_CTRL1 register.
> 
> You say it is required, so does that mean this hasn't ever worked? Or it
> happened to work because something else turned on the clock?

There is no upstream driver for this particular PWM controller, I'm about to
submit one though, and so far I've completed my review of its dt properties.

>>
> 
> Fixes tag?

It'd make sense, however as I've said above formally there is no fixed
runtime bug, if the scope is limited to the upstream only.

Fixes: b7d41c937ed7 ("ARM: LPC32xx: Add the motor PWM to base dts file")

>> Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
>> ---
>>   arch/arm/boot/dts/nxp/lpc/lpc32xx.dtsi | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm/boot/dts/nxp/lpc/lpc32xx.dtsi b/arch/arm/boot/dts/nxp/lpc/lpc32xx.dtsi
>> index 39af48470ed5..abd401fda94e 100644
>> --- a/arch/arm/boot/dts/nxp/lpc/lpc32xx.dtsi
>> +++ b/arch/arm/boot/dts/nxp/lpc/lpc32xx.dtsi
>> @@ -304,6 +304,7 @@ i2c2: i2c@400a8000 {
>>   			mpwm: pwm@400e8000 {
>>   				compatible = "nxp,lpc3220-motor-pwm";
>>   				reg = <0x400e8000 0x78>;
>> +				clocks = <&clk LPC32XX_CLK_MCPWM>;
>>   				#pwm-cells = <3>;
>>   				status = "disabled";
>>   			};
>> -- 
>> 2.43.0
>>

-- 
Best wishes,
Vladimir

