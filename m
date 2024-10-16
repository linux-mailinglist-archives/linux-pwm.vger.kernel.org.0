Return-Path: <linux-pwm+bounces-3681-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F36E9A0759
	for <lists+linux-pwm@lfdr.de>; Wed, 16 Oct 2024 12:30:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1755E1F261D6
	for <lists+linux-pwm@lfdr.de>; Wed, 16 Oct 2024 10:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ACEC20969A;
	Wed, 16 Oct 2024 10:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="DCiZLUuq"
X-Original-To: linux-pwm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75BFD209677;
	Wed, 16 Oct 2024 10:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729074373; cv=none; b=oHoY3ZCLiC0l4PRZwSVjnLz6wqHS4btphJeUxsldqvRaFCRY++CUlGt/cIA5MOgY3oOKgshwep414iFqIUJHfGStMt3gHdhsGB8oS61KX5UuSwDeisTn5+fwc7ih8lgrjto7gWX35tkqWA7ijFJd9r47Dv1L7BoQIcVm4rflJIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729074373; c=relaxed/simple;
	bh=UH6An7zktsxQ7GL3P6sIPgkfAT+XZCHpUixfpH1byNE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kjE/4wWLkqOnADrDP6kHYu5blVyVSs0y80ivErdP2/jFMD8Ksk4DCbKWsaBQIPEBVDA4xqWif4vZC9n9EbDDKXQrkLd+VvUQOzvNnbEJ4z5cKZrXULnZDsVKgftHePNA7snogsXj9m95o4sR33HiRANWMpJ9lrqnCztUC6Flqzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=DCiZLUuq; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1729074369;
	bh=UH6An7zktsxQ7GL3P6sIPgkfAT+XZCHpUixfpH1byNE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DCiZLUuqPZZCn21ZLZ3BXmll/WogG9s/QHGn1ZD0+5xiBeF/rCTvsBSAX86VW97+Y
	 +KkpVd2Etfmx8PxYt7IHMNzOOmg4pL16vLAVP2N6FRQKHBGavQzNG+MZWkhGGEA2at
	 BXENq2qegMMaD2ALl+rUxpD7cTqosJHXOev+L4YwMnPrtIZUgHbGJOEUC0JMl4WHsA
	 3n/3cEewZ9BSotSyKClL1Ol6PViVLIr9MSQIhmkCmL5AkVYUiSruKme59U++CYJRTe
	 eP4uKovDnM1wwqQOtk+a4ybnvtXFe+YhLO06NtLgUylg/N2V7JK360ZtWECPMGiZ3h
	 zszXmAWSxxtqQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id C734417E1003;
	Wed, 16 Oct 2024 12:26:08 +0200 (CEST)
Message-ID: <3dfc6d8c-a816-4ae1-b3e7-d948734960be@collabora.com>
Date: Wed, 16 Oct 2024 12:26:08 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 4/6] dt-bindings: mfd: Add support for Airoha EN7581
 GPIO System Controller
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
References: <20241016-en7581-pinctrl-v7-0-4ff611f263a7@kernel.org>
 <20241016-en7581-pinctrl-v7-4-4ff611f263a7@kernel.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241016-en7581-pinctrl-v7-4-4ff611f263a7@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 16/10/24 12:07, Lorenzo Bianconi ha scritto:
> From: Christian Marangi <ansuelsmth@gmail.com>
> 
> Add support for Airoha EN7581 GPIO System Controller which provide a
> register map for controlling the GPIO, pinctrl and PWM of the SoC via
> dedicated pinctrl and pwm child nodes.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



