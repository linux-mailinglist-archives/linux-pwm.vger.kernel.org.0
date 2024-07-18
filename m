Return-Path: <linux-pwm+bounces-2850-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2386D934DD0
	for <lists+linux-pwm@lfdr.de>; Thu, 18 Jul 2024 15:09:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3173282304
	for <lists+linux-pwm@lfdr.de>; Thu, 18 Jul 2024 13:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F2AB13C806;
	Thu, 18 Jul 2024 13:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="mPWZxvdB"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87CCD13C3F6;
	Thu, 18 Jul 2024 13:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721308153; cv=none; b=cdtQI/tI2IsLhaJXxEBUTAU5eXrBZ6oZn/N426sNH6Idu5K/xS1MGJASmz1nQYcJ1IB+LrsbqWhvePL2OjlmYx/4DOYDiQk2x7TFu9eeZw8UJVHV6qwv+ydlz1G5dkn/nJIMi3IL2rvmGHnJbAxlDekM68VenUtBNZBS3sWUH00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721308153; c=relaxed/simple;
	bh=WX7ukJI8n3jjzffY/JPZ9oaOhlROEeN4zgp0zjWA1Gw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=eviHdXF5CAZZOS8nzU+oCwvTfq3b6ju15BuVYip9lojDjRmtWrVWQeQPPFpKBE3sPggdwF0Lk+WBTuQTpt5AmqC4PGJr4QBpMOamCOXSpJ1SKUpDhUuR7r/VVKqoGSra5w+8XNY4tlatDN4fhYdy2qugLzD0sGQPxZo10njYHC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=mPWZxvdB; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk02.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id AC9D5120010;
	Thu, 18 Jul 2024 16:09:05 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru AC9D5120010
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1721308145;
	bh=Rs10WoBRGbxVA1tpxhegD8xnv3KUn3Y5nh+zd+3yfX4=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
	b=mPWZxvdBkbvEFNl+vpCubAemBLzMi854k4tuKT+wtnijRwNNVDI2bcUA2E99Tw9qA
	 Tp2U+oSqZgn9qewJg5NmYD0DHC3xyUC53V0cxO5YNYzNvLRreJ66GXyYekraMVmJMJ
	 sM7XHAs3TQ5ZnzFjopWxJw6JXN4XBGmr6rQ5fUR4qxqVwcubdG+jGdfMbO2nxlnODy
	 /57f97dKMW9T68Gb0AFUxRIrvyjmz9TNcikU0+sz3b/DzdPsMTuDkb28DP6uasJk3b
	 odCaxC/YWGyHDFmnbgFJUoUJZ8doNrcikgpUu6AV09A50Uih34uc5F9joe93ol4YuP
	 v4TEPm+nfrMZA==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Thu, 18 Jul 2024 16:09:05 +0300 (MSK)
Received: from [172.28.129.66] (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 18 Jul 2024 16:09:05 +0300
Message-ID: <52e2e211-a0b7-47b1-a451-34c304028097@salutedevices.com>
Date: Thu, 18 Jul 2024 16:09:04 +0300
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/3] pwm: meson: add pwm support for A1
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<neil.armstrong@linaro.org>
CC: <ukleinek@kernel.org>, <linux-pwm@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <martin.blumenstingl@googlemail.com>,
	<jbrunet@baylibre.com>, <khilman@baylibre.com>,
	<linux-amlogic@lists.infradead.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <kernel@salutedevices.com>,
	<hkallweit1@gmail.com>
References: <20240710234116.2370655-1-gnstark@salutedevices.com>
Content-Language: en-US
From: George Stark <gnstark@salutedevices.com>
In-Reply-To: <20240710234116.2370655-1-gnstark@salutedevices.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 186588 [Jul 18 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: gnstark@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 24 0.3.24 186c4d603b899ccfd4883d230c53f273b80e467f, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/07/18 08:50:00
X-KSMG-LinksScanning: Clean, bases: 2024/07/18 08:50:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/07/18 08:29:00 #26061289
X-KSMG-AntiVirus-Status: Clean, skipped

Hello

Excuse me, should I fix/improve anything on this series?

On 7/11/24 02:41, George Stark wrote:
> Add support for Amlogic meson A1 SoC family PWM
> 
> Changes in v2:
>    add patch with optional power-domains to pwm bindings;
>    fix syntax in a1 bindigns patch:
>    - use enum over const for amlogic,meson-a1-pwm beacuse adding more devices here
>      are expected
>    - leave only base compatible amlogic,meson-s4-pwm in check section
>    dt_binding_check and dtbs_check run ok now;
>    previous version: [1]
> 
> Changes in v3:
>    squash power-domains patch into main bindigns patch
>    add conditional to bindings that power-domains property is required only for a1
>    previous version: [2]
> 
> Changes in v4:
>    split bindings patch into power-domains patch and new compatible patch
>    previous version: [3]
> 
> [1] https://lore.kernel.org/lkml/20240701130113.433169-3-gnstark@salutedevices.com/T/
> [2] https://lore.kernel.org/lkml/20240701172016.523402-1-gnstark@salutedevices.com/T/
> [3] https://lore.kernel.org/lkml/20240702123425.584610-1-gnstark@salutedevices.com/T/
> 
> George Stark (3):
>    dt-bindings: pwm: amlogic: Add optional power-domains
>    dt-bindings: pwm: amlogic: Add new bindings for meson A1 PWM
>    arm64: dts: meson: a1: add definitions for meson PWM
> 
>   .../devicetree/bindings/pwm/pwm-amlogic.yaml  |  17 ++
>   arch/arm64/boot/dts/amlogic/meson-a1.dtsi     | 215 ++++++++++++++++++
>   2 files changed, 232 insertions(+)
> 
> --
> 2.25.1
> 

-- 
Best regards
George

