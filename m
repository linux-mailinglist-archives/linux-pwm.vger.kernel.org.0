Return-Path: <linux-pwm+bounces-6200-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E6AAC9B19
	for <lists+linux-pwm@lfdr.de>; Sat, 31 May 2025 14:59:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9047E189BE68
	for <lists+linux-pwm@lfdr.de>; Sat, 31 May 2025 13:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFF3A23C4FB;
	Sat, 31 May 2025 12:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="qhj/8mZE"
X-Original-To: linux-pwm@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF2842AA6;
	Sat, 31 May 2025 12:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748696382; cv=none; b=dTvSnEUf37cxnu4+uu/Pu5Z8D3ILwMkJGLhE0P/wZn9Kxt4dneqYcMzKr042xP7ZY9E26gK4ksYWuDWg8ofbI8tpK3hzGyyGxKDGogBKpekjxzEP/62UptcfOBB66FVrwZ9R2Op0QTd8+iG+5lELW1rqtogslmORL3J+U9vLrNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748696382; c=relaxed/simple;
	bh=3oX8Ytt7icyUJ0L4uW63iWAERBXG8/haXvAsNX7fWMw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hj2k7oCiQb9wm5sUuIPp1ArGlyyyWgkG9ByiGw4CRcp8+GIDBnCOV8698NXyx9mkyV3CbTl0WrO0xjDbTUsDxmsleK9SQvrGCOcnnpYWT9SCXTciHcbKuZU54Xeg+YI+r//CoboTKf+XKC9kSCpP+aVUH4MU/xmgCPP0EfK2uHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=qhj/8mZE; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=/QvtLNBteUL/eoLfwenUJUkU6N99pIrssBMZcazvFXE=; b=qhj/8mZElYbDGGnYnH5ZkSah2m
	r+HVjvfjaV4NJVyvl05yBCjwXMsUNBkYXAC3g6ou8vEpMRh1a03Dw1kNzLw9/5CFnSCMEX2ETxzuR
	xFKMKrhOpPeydmV2oe0ocsYfUVcw/obPOpOzCU8V8mm/eXfhWRCUDW85qieblAwRtv1Cit1jy9Fz2
	Pu6U6b5oOZOKsQrGVV9jfra5Vdvqu2CkyjqEA1kPCPsZCZ0g9I/Xz7pvNho9FjRo5k8psmadmS/wO
	260bSocfh4be5JXcffZpDDoS/Y984BBAN64KBxnfDYemIwh5yW3Q/OlYme6CxFPVBuusLoh9uvGXh
	dnihS9qg==;
Received: from i53875a3e.versanet.de ([83.135.90.62] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1uLLo0-0002Xd-EM; Sat, 31 May 2025 14:59:20 +0200
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <ukleinek@kernel.org>,
 William Breathitt Gray <wbg@kernel.org>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
 linux-iio@vger.kernel.org, kernel@collabora.com,
 Jonas Karlman <jonas@kwiboo.se>,
 Detlev Casanova <detlev.casanova@collabora.com>,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Subject:
 Re: [PATCH 1/7] dt-bindings: pinctrl: rockchip: increase max amount of device
 functions
Date: Sat, 31 May 2025 14:59:17 +0200
Message-ID: <23957563.6Emhk5qWAg@diego>
In-Reply-To: <20250408-rk3576-pwm-v1-1-a49286c2ca8e@collabora.com>
References:
 <20250408-rk3576-pwm-v1-0-a49286c2ca8e@collabora.com>
 <20250408-rk3576-pwm-v1-1-a49286c2ca8e@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Am Dienstag, 8. April 2025, 14:32:13 Mitteleurop=C3=A4ische Sommerzeit schr=
ieb Nicolas Frattaroli:
> With the introduction of the RK3576, the maximum device function ID used
> increased to 14, as anyone can easily verify for themselves with:
>=20
>   rg -g '*-pinctrl.dtsi' '<\d+\s+RK_P..\s+(?<func>\d+)\s.*>;$' --trim \
>   -NI -r '$func' arch/arm64/boot/dts/rockchip/ | sort -g | uniq
>=20
> Unfortunately, this wasn't caught by dt-validate as those pins are
> omit-if-no-ref and we had no reference to them in any tree so far.
>=20
> Once again kick the can down the road by increasing the limit to 14.
>=20
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>



