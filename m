Return-Path: <linux-pwm+bounces-5138-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B325FA5DFA0
	for <lists+linux-pwm@lfdr.de>; Wed, 12 Mar 2025 16:00:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A62211894EE9
	for <lists+linux-pwm@lfdr.de>; Wed, 12 Mar 2025 15:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C4A324FC0D;
	Wed, 12 Mar 2025 15:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="OmXS0mYB"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFDEA236A73
	for <linux-pwm@vger.kernel.org>; Wed, 12 Mar 2025 15:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=121.127.44.59
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741791615; cv=none; b=AkRPe7LG5jriTWDT1v7SsbOofLlxagcDLekuLYR4NKkOAZVN/hv1wEyyd+bBNuGXhftgIN6He56iQCQVuAlJ+BgAxT8DAKcZldEAg3QI77X8hEzDTx73GbjTppQccaFvl2VcqlygFIZuOGqAPBi06FotjEWZqBdJsmOeRaknSRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741791615; c=relaxed/simple;
	bh=0TDjfpWLM0KOf/+ikJ3p43z3rnLgL6wjBL/u1rSaBcs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R2QvrYkRroBzflbv1pm93AR5UuxhQRQik9ViUnoyydvE4pkFIbQbxbgGvIFIYqitIDDb2Y3VOGcjGo86OWLUaHjGoKFKP1bFxyDNdkmRhcIvl0FkgYED9ErWGjnK09tEDgN9ggy/KAFC/Ca+S1YAPcjME/Eck6A1RzF1LhX44PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=OmXS0mYB; arc=none smtp.client-ip=121.127.44.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1741791606;
 bh=wS+iW3PEgK6vQzywICkq9SarBtHISre1FPGbp4FqxEg=;
 b=OmXS0mYBt14pXFm2+nFXpFk14Gn5nyHGZFdN9gpWdSf1VtVx6G+wwfQ5qAzRfZ+xSQyE1KlAl
 fYhED4lakq0Cxin1TjwS/gf42Jx98ZqbV7HTODkLl+SD7y7jhPUHQPcSaDTP9Md4hylmhG05w0/
 Z9ROJDk7dE1V068X975Ce1uWMl9hg/ha+8Cw1+6RieQThpkgud2JCqKJrxNxi35eG1a6KDFB1LC
 NGccoHTPsoREHlRrCahfYVGbH7zV6M7zwey7nelzRicYzEo9tOxhSLzkeMsWf3oa23ggE39/Jk2
 ZqjqmpCZGR29+WRAUtjCJ4ubwz8seQIO3BcKYwzssHSw==
X-Forward-Email-ID: 67d1a174a3842b4a6f18d3d1
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.59
X-Forward-Email-Version: 0.4.40
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <b7d8d385-81ee-4947-ab8f-1da43843464b@kwiboo.se>
Date: Wed, 12 Mar 2025 16:00:00 +0100
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
References: <a5ec9062-ca57-4748-8c0f-fb5b9c75fa28@kwiboo.se>
 <20250312143515.1225171-1-amadeus@jmu.edu.cn>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20250312143515.1225171-1-amadeus@jmu.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Chukun,

On 2025-03-12 15:35, Chukun Pan wrote:
> Hi,
> 
>> The pinctrl-names should be changed to "default" and not "active",
>> something you can fixup or do you want a patch?
> 
> Sorry I've been a bit busy this week and forgot to send the v2 patch.
> In rk3528.dtsi, the uart and upcoming i2c nodes do not have pinctrl,
> so I prefer to remove them.
> 
>>> Unlike other SoCs, pinctrl-names need to be in "active" state,
>>> I'm not sure about this, but otherwise the pwm-regulator will
>>> not work properly.
> 
> BTW, setting the pinctrl of pwm corresponding to pwm-regulator
> to "default" will cause kernel boot suspended.
> Sorry but do you know why?

Not an issue I have seen, do you have any more logs or details? E.g.
what board you use, full regulator node, do you have operating points
defined etc.

I have runtime tested a branch at [1], that use pinctrl-names = default,
have vdd_arm and vdd_logic defined, also an opp table for cpu and gpu.

For E20C there is a commit to enable the vdd_logic, however without gpu
enabled and a mali-supply the pwm-regulator is initialized to
max-microvolt by Linux. Have instead updated U-Boot to initialize the
pwm-regulator's:

```
&vdd_arm {
	regulator-init-microvolt = <953000>;
};

&vdd_logic {
	regulator-init-microvolt = <900000>;
};
```

[1] https://github.com/Kwiboo/linux-rockchip/commits/next-20250311-rk3528/

Regards,
Jonas

> 
> e.g.
> ```
> vdd_arm: regulator-vdd-arm {
> 	compatible = "pwm-regulator";
> 	pwms = <&pwm1 0 5000 1>;
> 	...
> };
> 
> &pwm1 {
> 	pinctrl-0 = <&pwm1m0_pins>;
> 	pinctrl-names = "default";
> 	status = "okay";
> };
> ```
> 
> Thanks,
> Chukun
> 
> --
> 2.25.1
> 


