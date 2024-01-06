Return-Path: <linux-pwm+bounces-686-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA7958261B6
	for <lists+linux-pwm@lfdr.de>; Sat,  6 Jan 2024 22:29:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71D872830B8
	for <lists+linux-pwm@lfdr.de>; Sat,  6 Jan 2024 21:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E5BAF51E;
	Sat,  6 Jan 2024 21:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.com header.i=@yandex.com header.b="U5FCXBzs"
X-Original-To: linux-pwm@vger.kernel.org
Received: from forward502c.mail.yandex.net (forward502c.mail.yandex.net [178.154.239.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51900F9C7;
	Sat,  6 Jan 2024 21:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.com
Received: from mail-nwsmtp-smtp-production-main-59.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-59.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:1580:0:640:de7b:0])
	by forward502c.mail.yandex.net (Yandex) with ESMTP id F07F660C8A;
	Sun,  7 Jan 2024 00:25:13 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-59.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id BPmPnMOr9iE0-yopHyjDh;
	Sun, 07 Jan 2024 00:25:13 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.com; s=mail;
	t=1704576313; bh=aOO8K1kRwYNcAd+V6oNlanooC+SLRLZcpv5ZyxlV6v4=;
	h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
	b=U5FCXBzs+6/1MnWeYpNMk1BZUW7fx9e5L7a+PS9D9vlrOqHIk6oXEIC2jpEqdmXn7
	 KBdh4vkHaB+y38iNU6ONbTqf6Y0bisN+9Ik9t2wuoWH6eeBKMljE1alvDE+Nwqs0xq
	 0BMcYg8yRF6wU3dqaIRX6/KLqy9rfgmfUHqyWzQU=
Authentication-Results: mail-nwsmtp-smtp-production-main-59.iva.yp-c.yandex.net; dkim=pass header.i=@yandex.com
Message-ID: <94ad0f59-4095-40ee-963d-4ac379fc8852@yandex.com>
Date: Sat, 6 Jan 2024 22:25:10 +0100
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: pwm: rockchip: Allow "interrupts" prooperty
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-rockchip@lists.infradead.org, kernel@pengutronix.de
References: <20240106142654.1262758-2-u.kleine-koenig@pengutronix.de>
 <7dea73a6-d733-4cd2-b2d5-02f09e2a6dd9@linaro.org>
Content-Language: en-US
From: Johan Jonker <jbx6244@yandex.com>
In-Reply-To: <7dea73a6-d733-4cd2-b2d5-02f09e2a6dd9@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 1/6/24 18:10, Krzysztof Kozlowski wrote:
> On 06/01/2024 15:26, Uwe Kleine-König wrote:
>> This fixes the dtbs_check error
>>
>> 	arch/arm/boot/dts/rockchip/rv1108-elgin-r1.dtb: pwm@10280030: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
>> 	from schema $id: http://devicetree.org/schemas/pwm/pwm-rockchip.yaml#
>>
>> in several device trees.
>>
>> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

NAK

There's a reason why this isn't implemented before:

[RFC PATCH v1 1/2] dt-bindings: pwm: rockchip: add interrupts property <https://lore.kernel.org/linux-rockchip/ed3df2c8-ffb5-1723-0ed7-3a2721972852@gmail.com/#r>

https://lore.kernel.org/linux-rockchip/ed3df2c8-ffb5-1723-0ed7-3a2721972852@gmail.com/

[PATCH 1/1] dt-bindings: pwm: rockchip: Add description for rk3588 <https://lore.kernel.org/linux-rockchip/20220901135523.52151-1-sebastian.reichel@collabora.com/#r>

https://lore.kernel.org/linux-rockchip/66b5b616-ae9f-a1aa-e2b5-450f570cfcdd@gmail.com/

[PATCH v1 03/11] dt-bindings: pwm: rockchip: add rockchip,rk3128-pwm <https://lore.kernel.org/linux-rockchip/f5dd0ee4-d97e-d878-ffde-c06e9b233e38@gmail.com/>

https://lore.kernel.org/linux-rockchip/946d8ac2-6ff2-093a-ad3c-aa755e00d1dd@arm.com/


On how to correctly model the DT with common interrupts , PWM and one shot as a sort of MFD etc there's no consensus yet.

Leaf it as it is till someone made a working driver demo, so that the coder is free to model a DT solution that fits to him/her.


Johan

> Best regards,
> Krzysztof
>
>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip

