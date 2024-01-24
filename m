Return-Path: <linux-pwm+bounces-915-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 241FF83A5E0
	for <lists+linux-pwm@lfdr.de>; Wed, 24 Jan 2024 10:48:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 582D51C285C6
	for <lists+linux-pwm@lfdr.de>; Wed, 24 Jan 2024 09:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D83618042;
	Wed, 24 Jan 2024 09:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.com header.i=@yandex.com header.b="ke/H2ct2"
X-Original-To: linux-pwm@vger.kernel.org
Received: from forward501b.mail.yandex.net (forward501b.mail.yandex.net [178.154.239.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6B818035;
	Wed, 24 Jan 2024 09:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706089709; cv=none; b=mx/Re3/0WLN7EPoypd3TgXStcVCeBb7dj4iyMDXm5o2zCDFoMFYWBCd8QB+7xodM0qbXSbdX+jqki7wXEB7Jp/+JM8NtIn/70YttXhz7A4nvpdi6hB5u3wF4PKIvNK6z0fz1+y1ScqmoEKshQ9oixhB/h8b11xe+SqLtayK2Quk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706089709; c=relaxed/simple;
	bh=IHE+8qzpbTdog9EETVfiN/fpJqzJXicsqlvDrjk5K34=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PvrawPj92dH0tI+uPudQybMuSWre8bqDX/osFO4Fs7tmeRJqGlWzHJLy2OF7jkmsqwtI+otoj8dOsf3rZ7X2fRpgx9GKUcrnstvY7c9F7xv/7CsmWdZi+o1MgM15a/w2KEet9Pe9+mkQ4Siw08DfXVJ+1LYVzJ/ea06DfgQkw0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.com; spf=pass smtp.mailfrom=yandex.com; dkim=pass (1024-bit key) header.d=yandex.com header.i=@yandex.com header.b=ke/H2ct2; arc=none smtp.client-ip=178.154.239.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.com
Received: from mail-nwsmtp-smtp-production-main-81.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-81.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:5da3:0:640:8139:0])
	by forward501b.mail.yandex.net (Yandex) with ESMTP id 78C0861427;
	Wed, 24 Jan 2024 12:40:18 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-81.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id FeP8xM9oCSw0-tAQ2TBMr;
	Wed, 24 Jan 2024 12:40:17 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.com; s=mail;
	t=1706089217; bh=TdjvEzF9jVygdn01MqhB1dSKqKyYHG7CGfPsh6+QX2M=;
	h=In-Reply-To:Cc:References:To:From:Subject:Date:Message-ID;
	b=ke/H2ct2DrdVKkEyDm3aAFiHVVDIK/feQYkkT/8SVgxQg1moKmlyUvcuNmhXuJI+t
	 Fe16e9E98XOkpUr95bjahG9wBBir26dK38iIAI8tSnM+tDzf4zoA2/PfRq9wO8F0kK
	 +Mns/UIHdXHSiNKFjYaK4Eh67fbXchjAVxD30CYE=
Authentication-Results: mail-nwsmtp-smtp-production-main-81.myt.yp-c.yandex.net; dkim=pass header.i=@yandex.com
Message-ID: <b03fc42e-653a-49b2-8835-6cfb7a7bb39e@yandex.com>
Date: Wed, 24 Jan 2024 10:40:15 +0100
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: pwm: rockchip: Allow "interrupts" prooperty
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: linux-pwm@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
 Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, linux-rockchip@lists.infradead.org,
 Thierry Reding <thierry.reding@gmail.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 kernel@pengutronix.de
References: <20240106142654.1262758-2-u.kleine-koenig@pengutronix.de>
 <7dea73a6-d733-4cd2-b2d5-02f09e2a6dd9@linaro.org>
 <94ad0f59-4095-40ee-963d-4ac379fc8852@yandex.com>
 <cvvifoctmgdsgqfadqbhgywfw2ff57fz33w26hghf5kyo5j5sw@mj75xtvczr2h>
 <210132de-a46b-4f9f-8546-0c36d8a34665@linaro.org>
 <5swqcqpc5zwa3bfhuoyjnymozyzy3lgurnbsurebybj2c7fck3@ycwk2ugo2ouf>
Content-Language: en-US
From: Johan Jonker <jbx6244@yandex.com>
In-Reply-To: <5swqcqpc5zwa3bfhuoyjnymozyzy3lgurnbsurebybj2c7fck3@ycwk2ugo2ouf>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 1/24/24 09:26, Uwe Kleine-König wrote:
> Hello Johan,
>
> On Sun, Jan 07, 2024 at 11:30:14AM +0100, Krzysztof Kozlowski wrote:
>> On 07/01/2024 00:25, Uwe Kleine-König wrote:
>>> On Sat, Jan 06, 2024 at 10:25:10PM +0100, Johan Jonker wrote:
>>>> On 1/6/24 18:10, Krzysztof Kozlowski wrote:
>>>>> On 06/01/2024 15:26, Uwe Kleine-König wrote:
>>>>>> This fixes the dtbs_check error
>>>>>>
>>>>>> 	arch/arm/boot/dts/rockchip/rv1108-elgin-r1.dtb: pwm@10280030: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
>>>>>> 	from schema $id: http://devicetree.org/schemas/pwm/pwm-rockchip.yaml#
>>>>>>
>>>>>> in several device trees.
>>>>>>
>>>>>> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
>>>>> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>> NAK
>>>>
>>>> There's a reason why this isn't implemented before:
>>>>
>>>> [RFC PATCH v1 1/2] dt-bindings: pwm: rockchip: add interrupts property <https://lore.kernel.org/linux-rockchip/ed3df2c8-ffb5-1723-0ed7-3a2721972852@gmail.com/#r>
>>>>
>>>> https://lore.kernel.org/linux-rockchip/ed3df2c8-ffb5-1723-0ed7-3a2721972852@gmail.com/
>>>>
>>>> [PATCH 1/1] dt-bindings: pwm: rockchip: Add description for rk3588 <https://lore.kernel.org/linux-rockchip/20220901135523.52151-1-sebastian.reichel@collabora.com/#r>
>>>>
>>>> https://lore.kernel.org/linux-rockchip/66b5b616-ae9f-a1aa-e2b5-450f570cfcdd@gmail.com/
>>>>
>>>> [PATCH v1 03/11] dt-bindings: pwm: rockchip: add rockchip,rk3128-pwm <https://lore.kernel.org/linux-rockchip/f5dd0ee4-d97e-d878-ffde-c06e9b233e38@gmail.com/>
>>>>
>>>> https://lore.kernel.org/linux-rockchip/946d8ac2-6ff2-093a-ad3c-aa755e00d1dd@arm.com/
>>>>
>>>>
>>>> On how to correctly model the DT with common interrupts , PWM and one shot as a sort of MFD etc there's no consensus yet.
>>>>
>>>> Leaf it as it is till someone made a working driver demo, so that the coder is free to model a DT solution that fits to him/her.
>>> Having the warnings until this happens is bad though. If describing the
>>> irqs in the schema is considered wrong, we should remove the interrupts
>>> properties from the device tree sources.
>> I think the previous thread mixes bindings with driver. Does the
>> hardware have interrupt? Yes? Add it to the bindings. No? Don't add it.
>>
>> However Johan's reply is saying something about driver, so how is it
>> related?
> Following Krzysztof's argumentation I'm inclined to apply the patch
> despite Johan's objection as the irqs are already described in the
> device trees and not having them in the binding only adds warnings to
> the dt checks.
The interrupts are common interrupts for a group of 4 PWM channels!

The name PWM channels is somewhat confusing.

It has various modes not related to PWM


From Rockchip RK3368 TRM V2.0.pdf:


Continuous Mode:
No interrupts.


One-shot Mode:
an interrupt is asserted to inform that the operation has been finished

Reference mode:

asserts an interrupt when the polarity of the input waveform changes.

Also IR

===

PWM_INTSTS0x00040 W0x00000000 Interrupt Status Register
PWM_INT_EN0x00044 W0x00000000 Interrupt Enable Register
PWM_FIFO_CTRL0x00050 W0x00000000
PWM Channel 3 FIFO Mode Control Register
PWM_FIFO_INTSTS0x00054 W0x00000000 FIFO Interrupts Status Register


===
    pwm0: pwm@ff680000 {
        compatible = "rockchip,rk3368-pwm", "rockchip,rk3288-pwm";
        reg = <0x0 0xff680000 0x0 0x10>;
    };

    pwm1: pwm@ff680010 {
        compatible = "rockchip,rk3368-pwm", "rockchip,rk3288-pwm";
        reg = <0x0 0xff680010 0x0 0x10>;
    };

    pwm2: pwm@ff680020 {
        compatible = "rockchip,rk3368-pwm", "rockchip,rk3288-pwm";
        reg = <0x0 0xff680020 0x0 0x10>;
    };

    pwm3: pwm@ff680030 {
        compatible = "rockchip,rk3368-pwm", "rockchip,rk3288-pwm";
        reg = <0x0 0xff680030 0x0 0x10>;
    };

===

The interrupt registers are located outside the PWM range and have nothing to do with the PWM driver.
Adding them to a PWM binding is just bogus.
They are a left over from the manufacturer tree that use them in a IR detection driver.
Heiko keeps them because someone outside mainline kernel might use them?
They should be removed and remodeled in a new sort of MFD node that handles all operating 3 modes.


Johan
>
> Best regards
> Uwe
>

