Return-Path: <linux-pwm+bounces-5378-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 220A7A8084E
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Apr 2025 14:44:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C4C34E1116
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Apr 2025 12:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A8C926E166;
	Tue,  8 Apr 2025 12:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="alue8/mP"
X-Original-To: linux-pwm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DAB726A0FA;
	Tue,  8 Apr 2025 12:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744115654; cv=pass; b=svqRdnNj8LonHbDJ5VH93H/dlmXBK/Sb7VnyEFs38ul7n5wPd5NspS5WNUVPn1YRLCFN6XQae+5D1AHJReLOUSMURDxUMGJHDq9BecvzxnlC+BnNOnsz6eN9NVJocPd9/h0VhJn8evgzMyid3RnH02a5fGbSiABSM0fndQlTfCU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744115654; c=relaxed/simple;
	bh=c4twEWwmsa1TQM5rZNybMMxxoJRngP/HN7of1HzCRj0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Fz5w2LtSjkf7GlknNuOMP/S2JRK2gmkyxymSdD9cJ1R8phNxRNQTUUlTtYLSWc5oZE4n5FaQm60nlbFwvNPMUzxpK4jtJ1nlrC0BK6afNRkFt0QSCoJdfvbhCAAv7+54XzvPpvz6EHm7EVtyo4YglEGVEdy5RK9hZmAcH8rWNiU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=alue8/mP; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1744115623; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=HzP064aaOCF6y6hOj7dRK5sI3bN/dS5Ihvs9eNBiFgnKC8sjICTZhSUPSTjXKDloFic5z0N5t8p9fCvvanhNPTkEVsiKTvlFqiJOtTJ/QLUNdyMrZGOlrwi5xsXsahPeCB7eyOGpWEpZ9wVcU4QOTG39BKnsnNPqXfqVbt8pMFU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1744115623; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=dxPWRUM+Lmlc7lbL7SefS+1aIcIp06X3EqAUwi7F43g=; 
	b=DT7W5IHpEByyCYaiOVIG7DaCHy+Ml/e6/MGp++rnCdZJ5IWqdFpOv+Fb9e/Ykg9le6HWnd7td2iow3oAgFULBpof1XL2RCTedjSkhngWjefX4az6YfoUFd0XnQhqyhW25WowpbgCadDfBBW4z6lnu3ULscN6ICxs1V7TuulExbQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1744115623;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=dxPWRUM+Lmlc7lbL7SefS+1aIcIp06X3EqAUwi7F43g=;
	b=alue8/mPvPyWvAXKI/G7dJ1Na5tsAAzwmYg/1zXv6sUCiIYciYGR+Al/RmcnDvuO
	cAH3D8gDuzjLJVCE/4V05SXR9xB9owHg7LgjhgcFDL9vXCbv+wC+Xz2GIBRQSTxFgRX
	NdF4r0JexJJRZkk6GCB4wffEN6TOTJd+Iv1WUQCI=
Received: by mx.zohomail.com with SMTPS id 1744115621608488.26624651220584;
	Tue, 8 Apr 2025 05:33:41 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Tue, 08 Apr 2025 14:32:13 +0200
Subject: [PATCH 1/7] dt-bindings: pinctrl: rockchip: increase max amount of
 device functions
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250408-rk3576-pwm-v1-1-a49286c2ca8e@collabora.com>
References: <20250408-rk3576-pwm-v1-0-a49286c2ca8e@collabora.com>
In-Reply-To: <20250408-rk3576-pwm-v1-0-a49286c2ca8e@collabora.com>
To: Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 William Breathitt Gray <wbg@kernel.org>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 Kever Yang <kever.yang@rock-chips.com>
Cc: linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, 
 linux-iio@vger.kernel.org, kernel@collabora.com, 
 Jonas Karlman <jonas@kwiboo.se>, 
 Detlev Casanova <detlev.casanova@collabora.com>, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
X-Mailer: b4 0.14.2

With the introduction of the RK3576, the maximum device function ID used
increased to 14, as anyone can easily verify for themselves with:

  rg -g '*-pinctrl.dtsi' '<\d+\s+RK_P..\s+(?<func>\d+)\s.*>;$' --trim \
  -NI -r '$func' arch/arm64/boot/dts/rockchip/ | sort -g | uniq

Unfortunately, this wasn't caught by dt-validate as those pins are
omit-if-no-ref and we had no reference to them in any tree so far.

Once again kick the can down the road by increasing the limit to 14.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 Documentation/devicetree/bindings/pinctrl/rockchip,pinctrl.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/rockchip,pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/rockchip,pinctrl.yaml
index 960758dc417f7405010fab067bfbf6f5c4704179..125af766b99297dc229db158846daea974dda28e 100644
--- a/Documentation/devicetree/bindings/pinctrl/rockchip,pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/rockchip,pinctrl.yaml
@@ -135,7 +135,7 @@ additionalProperties:
               description:
                 Pin bank index.
             - minimum: 0
-              maximum: 13
+              maximum: 14
               description:
                 Mux 0 means GPIO and mux 1 to N means
                 the specific device function.

-- 
2.49.0


