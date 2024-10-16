Return-Path: <linux-pwm+bounces-3682-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3232D9A0761
	for <lists+linux-pwm@lfdr.de>; Wed, 16 Oct 2024 12:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63E271C25414
	for <lists+linux-pwm@lfdr.de>; Wed, 16 Oct 2024 10:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EAA62071E9;
	Wed, 16 Oct 2024 10:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="JsWfXgOW"
X-Original-To: linux-pwm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D6020695C;
	Wed, 16 Oct 2024 10:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729074461; cv=none; b=thSTrPAoUs1r9iI7hNZJyGCn5v9aTPNlamr3IoYEOpkxQpuSukdNFnxlfdL05iptZRtEqI3KOiQJ+K165sLr7oRruOIg0z9ySIf0CcZjgV4ALqI4ShoIHuQDbAgOc/Ks6KiuvtQa0ZlnC7SR/i07tS0eqTMnJwUeZheEvpFL3uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729074461; c=relaxed/simple;
	bh=md6N/XQGzlUgrB8oUbFlx4cVulC8rjoqYcCGd7LBoRQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Aat7ZwSbYXuUaz9PlcVtkAaXDRHW0jrlLsFjQJ7eyQvjcaahHx9Cc5D+YgnNzi+YOTj3PLLS7Lvc8jZNu40Cw1MD8yaVux5aG2Je0vKKD7JgxOVlBGDOCe9JFUIhcZGgkRxHEu9MYtQYZBJKOXUmRYrSyq75yvMy3h5O9fjqqgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=JsWfXgOW; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1729074457;
	bh=md6N/XQGzlUgrB8oUbFlx4cVulC8rjoqYcCGd7LBoRQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JsWfXgOWmZ0+VTUeT9qZFbbnRMZv3r/mQcpNmMgwaKcb7xmhFovuvwtz+hl2psPNm
	 tAbwaDwCxEwkGNqS6zc8/xPA8oZd7frUmiebwXJBD+N2YDznuE0zW1yeSjot0JF5AH
	 x5m4UA5ui8ttORQAdhM2zKU2q7R9AWDVR4UoMcQ0e14e3+HacsvL8M+w4I5lB03GFa
	 Y6C7yr5ILsAx0CRk4QE+WOOLGAg58rtWBMX1zqrv03CsTamvRuS3WPIUpyw1KRCIne
	 BstHvKZoHDWww7mKJSR8/LEHQE0GZlZ2Vb9yT6gTg+1Nw117mNGS9IXc4rCMxxZs3O
	 x8OPNyKQZdAkg==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 0878F17E1003;
	Wed, 16 Oct 2024 12:27:36 +0200 (CEST)
Message-ID: <3a70c755-3a33-48ff-842b-c24a6a37bbd0@collabora.com>
Date: Wed, 16 Oct 2024 12:27:36 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 5/6] pinctrl: airoha: Add support for EN7581 SoC
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
 <20241016-en7581-pinctrl-v7-5-4ff611f263a7@kernel.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241016-en7581-pinctrl-v7-5-4ff611f263a7@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 16/10/24 12:07, Lorenzo Bianconi ha scritto:
> Introduce pinctrl driver for EN7581 SoC. Current EN7581 pinctrl driver
> supports the following functionalities:
> - pin multiplexing
> - pin pull-up, pull-down, open-drain, current strength,
>    {input,output}_enable, output_{low,high}
> - gpio controller
> - irq controller
> 
> Tested-by: Benjamin Larsson <benjamin.larsson@genexis.eu>
> Co-developed-by: Benjamin Larsson <benjamin.larsson@genexis.eu>
> Signed-off-by: Benjamin Larsson <benjamin.larsson@genexis.eu>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


