Return-Path: <linux-pwm+bounces-2754-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 980D092D606
	for <lists+linux-pwm@lfdr.de>; Wed, 10 Jul 2024 18:15:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51E89287181
	for <lists+linux-pwm@lfdr.de>; Wed, 10 Jul 2024 16:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DF27194A66;
	Wed, 10 Jul 2024 16:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="vfZHKAcO"
X-Original-To: linux-pwm@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1C61803D
	for <linux-pwm@vger.kernel.org>; Wed, 10 Jul 2024 16:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720628020; cv=none; b=H2yq+R/9FjckhRnA9VeRyVdkcJ4oMqxCXrI4IwugPSXmrJz8UNbP28IHpoW5IQH6hC9ujCQ/QHaPZsjkA5qXIsOfQDH74BI1uHAoYRVR5NGRCRP0HkN+xroIRduT91jVBRcu2srz8aIvZG+Z+uI8HVHyxO4LezzZEpcrnWp7TxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720628020; c=relaxed/simple;
	bh=c/8ZAiW0OOTwxWfWF2d4DDY31u2gF8DX8pOih4vVzD4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=fzxoXTdgVXL6zBfOZW0pg1NBVNnV5NzSCb8sfEn8icC0ksASfsA2Mgw71JhZ9D54XKvSAEM2UY4wOz23LPXVSznjax4u/VH2F9SxHWR2psD0SS0Bm7nawrSsyidtmBv5nu6sHAT4cBDsCn1UK5v7l2rcnNtySaZKwzCTqPaQsZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=vfZHKAcO; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1720628018; x=1752164018;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=c/8ZAiW0OOTwxWfWF2d4DDY31u2gF8DX8pOih4vVzD4=;
  b=vfZHKAcO4OjfBNbn6NjspA+D8Mpix2E0WO4bviYDQJpj5iS91aiTuGE1
   3E0l5ZFpXLNN1WKInazet4zbr+QfE4/u1yPOFLlhXGNHUigxEU7nNJOTQ
   V3QQeWQODce9qLKcdj00txh2U7gHLDz9IqFPMIpu/NJ7GWcAYU7YXp26Z
   zFJzDBhq07eR7jtg82LjiaQanRW9PSnmsqAO4Ilc2FFjd7B24MH8opZ4C
   tCDcYFiU/cwk7VWgqy/kfFSkDZO4uBbIwVIast6hpaIFY2/u3gMCPLQXc
   PePsUtYLNKJKJZp88NazNKnqmVrn2xgqceAcMdmz8st0ubIKoVKrQSqXV
   A==;
X-CSE-ConnectionGUID: vHkbMBcqTzKf5CHrXDkVjQ==
X-CSE-MsgGUID: GxneP7LWRI+Pe7Uoj89F6Q==
X-IronPort-AV: E=Sophos;i="6.09,198,1716274800"; 
   d="scan'208";a="259958743"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Jul 2024 09:13:37 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 10 Jul 2024 09:13:18 -0700
Received: from [10.180.117.33] (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 10 Jul 2024 09:13:16 -0700
Message-ID: <f03471e7-a4e5-483a-b6b1-71a7d9b54b82@microchip.com>
Date: Wed, 10 Jul 2024 18:13:40 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] pwm: atmel-tcb: Fix race condition and convert to
 guards
Content-Language: en-US, fr-FR
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
CC: Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea
	<claudiu.beznea@tuxon.dev>, Boris Brezillon <boris.brezillon@collabora.com>,
	<linux-pwm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
References: <20240709101806.52394-3-u.kleine-koenig@baylibre.com>
 <bbb984a8-8815-45fb-8ddf-a5180f6e41c4@microchip.com>
 <i3d3x7rzqphcjhagmdfenqxrzq72k5qdmdv2dh3tjvwmbrcub2@nfkck2zyjbzf>
From: Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <i3d3x7rzqphcjhagmdfenqxrzq72k5qdmdv2dh3tjvwmbrcub2@nfkck2zyjbzf>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit

On 10/07/2024 at 17:31, Uwe Kleine-König wrote:
> Hello Nicolas,
> 
> On Wed, Jul 10, 2024 at 04:17:09PM +0200, Nicolas Ferre wrote:
>> On 09/07/2024 at 12:18, Uwe Kleine-König wrote:
>>> The hardware only supports a single period length for both PWM outputs. So
>>> atmel_tcb_pwm_config() checks the configuration of the other output if it's
>>> compatible with the currently requested setting. The register values are
>>> then actually updated in atmel_tcb_pwm_enable(). To make this race free
>>> the lock must be held during the whole process, so grab the lock in
>>> .apply() instead of individually in atmel_tcb_pwm_disable() and
>>> atmel_tcb_pwm_enable() which then also covers atmel_tcb_pwm_config().
>>>
>>> To simplify handling, use the guard helper to let the compiler care for
>>> unlocking. Otherwise unlocking would be more difficult as there is more
>>> than one exit path in atmel_tcb_pwm_apply().
>>>
>>> Fixes: 9421bade0765 ("pwm: atmel: add Timer Counter Block PWM driver")
>>> Signed-off-by: Uwe Kleine-König<u.kleine-koenig@baylibre.com>
>> Acked-by: Nicolas Ferre<nicolas.ferre@microchip.com>
>>
>> And I like the conversion to the "guard" lock helper.
> I hesitated a bit to add it because it will make backporting to stable
> harder. But I guess we will just not backport it, the problem doesn't
> seem to matter in practise given that it was found by looking at code
> and not hit in real life more more than 11 years after its introduction.

Fair indeed: +1.

> Best regards and thanks for your Acks,
> Uwe


