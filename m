Return-Path: <linux-pwm+bounces-3738-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 545969A6AC6
	for <lists+linux-pwm@lfdr.de>; Mon, 21 Oct 2024 15:44:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11FF72872C6
	for <lists+linux-pwm@lfdr.de>; Mon, 21 Oct 2024 13:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 740CA1FA276;
	Mon, 21 Oct 2024 13:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="FBeIW3Qr"
X-Original-To: linux-pwm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404531F8F02;
	Mon, 21 Oct 2024 13:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729518174; cv=none; b=Sn3yZK2zZwEhEIgIaxjfoenyFYKSkNcmshsVepD2In4oETqB3qdTtRkeH+eAhel6K2jxUeRVjk/FHqf5u6HYvDmNCkOxoisV7qTPe0xJqZpx8fioGwBvW/Os9slUAMvoPg93Qg197Bna75EPUpXVoO5I2YICsnDHuYDSEjziMdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729518174; c=relaxed/simple;
	bh=zASdF1eo7QN55lG2Cxck3mYfIlw6fWVKv5h50/EaGTo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Px2M80HgDqqF2tVNStrG+KLmT44496oJFVlZ8WtkTJqWkxNW5rFfd1okxEHjx4+VAzTxMY2oG6ZfA/zHL3D2DuxVmQTuPgQ5h+EvjVFyuCEA/i8x3ie/V629LOf/wP+gOPnv0QrLjRqZMiouLiNpHnSQ1Kp5iAb9RWNqgemv/iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=FBeIW3Qr; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1729518170;
	bh=zASdF1eo7QN55lG2Cxck3mYfIlw6fWVKv5h50/EaGTo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FBeIW3QrPRYxqJrcqj1hPP3B0erKcfIT7he6Y0+IyoGbIE8FM5fKPWNFHM7GVuqFt
	 GHaT4Nd6kiri/hWK+E5Znb4GrCbEN2j0aH4Df5jL2yFwsYThaTa10ZSYbr5MUx4bsi
	 fuip6tvtU3Ng+C6tBLNgJcnLFkb135VuVH/P9xFQBBjfSdepYNNY7CU4Lb/0QBQ0/o
	 aQqyrdZMbz5IstH+uTYPhJDUp2054U1F39V2lHi81HuQtCfLKXlTokj0Kqm63vHUtH
	 rPnkB2nmRaR+rX5HPSq9p1HwBbmnJRFUhn8Wr4mThd4ie6NaPvdfSEEXeQnifuxZDa
	 1iOH3Xf0FtwtA==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id E193017E361B;
	Mon, 21 Oct 2024 15:42:49 +0200 (CEST)
Message-ID: <8dc6f6b1-54db-443f-a2ef-bcce43b49846@collabora.com>
Date: Mon, 21 Oct 2024 15:42:49 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 1/6] dt-bindings: arm: airoha: Add the chip-scu node
 for EN7581 SoC
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
 <20241018-en7581-pinctrl-v8-1-b676b966a1d1@kernel.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241018-en7581-pinctrl-v8-1-b676b966a1d1@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 18/10/24 15:19, Lorenzo Bianconi ha scritto:
> This patch adds the chip-scu document bindings for EN7581 SoC.
> The airoha chip-scu block provides a configuration interface for clock,
> io-muxing and other functionalities used by multiple controllers (e.g.
> clock, pinctrl, ecc.) on EN7581 SoC.
> 
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


