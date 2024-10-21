Return-Path: <linux-pwm+bounces-3736-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C43C9A6AC2
	for <lists+linux-pwm@lfdr.de>; Mon, 21 Oct 2024 15:44:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85B85B27B2D
	for <lists+linux-pwm@lfdr.de>; Mon, 21 Oct 2024 13:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5206F1F9EAD;
	Mon, 21 Oct 2024 13:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="qVYjBjMa"
X-Original-To: linux-pwm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0600C1F9432;
	Mon, 21 Oct 2024 13:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729518161; cv=none; b=fX9U0ZAAFNd+kiIXl3WaVX0evLnqHX9vnHetd6WFcIyIxAyyK4vpTMvhNm/8g1wrYBiEu+Rfd6SPawQOc23hmLU0NCF3mk6T9dTUA+UjEJ6La/bpiKVtEyfGYqcpqUnHaJco0+A6wmKPK7MzGrBj+SSy7vlBTaA2eGR0yDpkY1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729518161; c=relaxed/simple;
	bh=oviwJ80cczN0pYVEPAgAh5XYy0VrED3BDuautf43roQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JZM9yuDbE6iuXLs7uWx8Hk4pTMFnvI64M2UV4iynHtCxj4NOQeHMnd/hyLykh0wFLXYBp+5V02hiHtpBMUhFa8leJuQn7kH14o8cafwdw1Tf0z4majAd6sO38DbhEgvG3HfpMqApPMajvwtFCJeQsm/9Kyp4UdKaVqPAM4fpI38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=qVYjBjMa; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1729518157;
	bh=oviwJ80cczN0pYVEPAgAh5XYy0VrED3BDuautf43roQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qVYjBjMascFiv0kUZLFjGRXEKOfiXXfTYeQV72wncmk91HLekVJWdOFaeWxIOwDL5
	 +2aDOMVrOHdzBmYa6h2dR37EyaQHtpttVk86yacLWLocUJ4wj6sXn+a4taKVJYG8+C
	 VFDRwbp0iUFhZ5omUWmgq4VuGFb1qofos5J3cjn1ny2lus55PZysyQ4OQai8iMpEKD
	 NmzoPtJtw3Q2vE/P3Ti/6ROx+jPdB494rpVoO04GSnkb6VeslmYFf66TNN92YnqkCw
	 E5srjufWuvTyYfXujudfAg4AkNGRGJNRtbFq97/hB3Q8lfMQmuv/6bg6KCBF25z9+5
	 l1gFkKDhcqbMQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 894ED17E361B;
	Mon, 21 Oct 2024 15:42:36 +0200 (CEST)
Message-ID: <b1d528f8-9af5-4a42-be4c-47c70af52540@collabora.com>
Date: Mon, 21 Oct 2024 15:42:36 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 6/6] pwm: airoha: Add support for EN7581 SoC
To: Lorenzo Bianconi <lorenzo@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Sean Wang <sean.wang@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, Lee Jones <lee@kernel.org>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 upstream@airoha.com, benjamin.larsson@genexis.eu, ansuelsmth@gmail.com,
 linux-pwm@vger.kernel.org
References: <20241018-en7581-pinctrl-v8-0-b676b966a1d1@kernel.org>
 <20241018-en7581-pinctrl-v8-6-b676b966a1d1@kernel.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241018-en7581-pinctrl-v8-6-b676b966a1d1@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 18/10/24 15:19, Lorenzo Bianconi ha scritto:
> From: Benjamin Larsson <benjamin.larsson@genexis.eu>
> 
> Introduce driver for PWM module available on EN7581 SoC.
> 
> Signed-off-by: Benjamin Larsson <benjamin.larsson@genexis.eu>
> Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



