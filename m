Return-Path: <linux-pwm+bounces-3737-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D55579A6ABE
	for <lists+linux-pwm@lfdr.de>; Mon, 21 Oct 2024 15:44:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E78F41C22C17
	for <lists+linux-pwm@lfdr.de>; Mon, 21 Oct 2024 13:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B70A81F8927;
	Mon, 21 Oct 2024 13:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="XiRQxA/9"
X-Original-To: linux-pwm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC991F8F02;
	Mon, 21 Oct 2024 13:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729518171; cv=none; b=NF8ZM2wLwNmfbudVMk1hjOQ0KlZY4Ty2r7yI5gDHn9P+Kv9QqD5QxGnYJWcFOUANFvrmIfqZz5Cww3CsUYGd7vNJ2fO9ivL96SH2M4DtH1U0eBtQ075VXTvrBFyFfdZPW/oS1hUaD1ywU4Ve6Wq9TmGWobRxli+WXcYdG81KSPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729518171; c=relaxed/simple;
	bh=Za6fLfK25amxq3Nz44P1bfUEcNWw7mIDffdQ9UHQBmo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xoyh4YbOpom/rNlb9GJP3MKnfR/trKdkoM7pvq50FKJeOV2aNRa/Pb+kYbVjn1oSAlNxBY6ObPigjMLSh9IODmm4KvRVrhzPBgbjXVJYtbNqdndRtrLEqmVxAjQlBtm+303+XMWJXQH52steqIoxp+8lv0VsyiUrX5uidFg1Ue0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=XiRQxA/9; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1729518167;
	bh=Za6fLfK25amxq3Nz44P1bfUEcNWw7mIDffdQ9UHQBmo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XiRQxA/98stToIctCScBhq4wjm1jI8k11l2JY5BcQloRhNwHw/PKkvDPSSwPe5rMZ
	 ryi5L39HLCzhDokJ8Cjmv4+Fi0HLD0+XF91yTSgLHQEeOGNM9zX36TY2GccEehPSNP
	 k9gaBjQxeHsWR0roFq/iAxhQGUb6u+AeK0V4u4O4gVy2JTeyONiVyh9IBFfzG01GkK
	 NDWi3A7X9IdkJ+xsbh86GcoYaYtFR1V4gsbici27U7ta/DxkyEzkIthbDis+6GUCqW
	 pahIcyVIW4wKKcLrn/9RpWKRyB2IXQ/6uG33dmvR93o7pkuNLQHnhbvMEWmMwCQqXY
	 fKHBfy1qQ9W6g==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id C2DBF17E3619;
	Mon, 21 Oct 2024 15:42:46 +0200 (CEST)
Message-ID: <88d41ba5-e6a8-44c9-bbdb-4ed43fd8ea32@collabora.com>
Date: Mon, 21 Oct 2024 15:42:46 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/6] dt-bindings: pinctrl: airoha: Add EN7581 pinctrl
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
 <20241018-en7581-pinctrl-v8-2-b676b966a1d1@kernel.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241018-en7581-pinctrl-v8-2-b676b966a1d1@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 18/10/24 15:19, Lorenzo Bianconi ha scritto:
> Introduce device-tree binding documentation for Airoha EN7581 pinctrl
> controller.
> 
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


