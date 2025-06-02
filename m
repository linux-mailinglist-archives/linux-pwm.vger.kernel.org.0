Return-Path: <linux-pwm+bounces-6220-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F950ACB974
	for <lists+linux-pwm@lfdr.de>; Mon,  2 Jun 2025 18:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C17C7A472F
	for <lists+linux-pwm@lfdr.de>; Mon,  2 Jun 2025 16:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B34C322541B;
	Mon,  2 Jun 2025 16:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="fbcyVaJS"
X-Original-To: linux-pwm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D512253A7;
	Mon,  2 Jun 2025 16:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748881217; cv=pass; b=JzwI7j+NePuv7+EPw/PQ+xhj93oHpp6gk24Lu8pfU+ktY4/8JRH+aoL6IbRWbjR/2+EyP61s7KULVSrRGv+IedSk7gKTZkLzjmhIETj7lttiAddl9OVkExI1wCIWRTds+aDGCxK7RZfXiw35jGtR16PqJrgeTyJ+XzkVuKWcWWU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748881217; c=relaxed/simple;
	bh=BxX2lY1ojTJ2Olmal1Wm1LAOHRRAEkEzQvJqCHF6wsk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FLaPv5cKkEqIchRNyGBxhjHeD2xnaq9uGVg84e3JdvqVWbpI+k3w25IinHv00Ond6gKyKiz1vyVhjQbbrWbAUbmEX87Bc6Sccwg55q0JTv28GwGnBcvyRmsieNUU7FvNPJk1AXoaGLuCa7pQ5xRJT90Ae+ZB4v75ZYrEKKUqqBk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=fbcyVaJS; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1748881184; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=VMZ55qsQsQBzmLOFgLk6MfuXnL9mRZQxGWseKvh+XxASlmU1BeKNLMljTlmlC+TtJ3XDfZsYuyJODIKI8uk6auU4W2O/BzLk56STXgbMRLnODhiZYH9sXTUrp8wVhNZ9OJJfA5IUN2AFrypH9RBw9YaG/RZPItuxpQUNLyMN9Zg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1748881184; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Oqhb0zTAPAAI3BV03PHDJVXV8qr8Hq9NvZb0bcbTck0=; 
	b=HgzBJ94HMpYkMyImJ9+AHMnFhxEqrEQdswPomW6tTo8TSD/bbESMGWKdyssrsYHH7goKnaEqvESAyKmaXi4vWk3O1ZVfaSjYY4eQhAneW5BwGsgV4JN5lYCqWXYmGYG+DJqqmbTTZWvF1taj29PGf4Sh0mucoA7WbtHNPZOtW+s=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1748881184;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=Oqhb0zTAPAAI3BV03PHDJVXV8qr8Hq9NvZb0bcbTck0=;
	b=fbcyVaJSMsDX2AAZ2HspovdYhpUv4Pn4rGAqTOGvRZgK+lX54OK51HtB3MNzQK27
	MBRfqehWJ/B3hjgYdfC+m6d41ivIC0GHNp31irI7afkbTTK3aMUxF1i+AapJduYnu7E
	KjkyYsTtQAFUbEtfqvz0ENqW2O2qITMq1RbBMncI=
Received: by mx.zohomail.com with SMTPS id 1748881183139995.513413165423;
	Mon, 2 Jun 2025 09:19:43 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Mon, 02 Jun 2025 18:19:12 +0200
Subject: [PATCH v2 1/7] dt-bindings: pinctrl: rockchip: increase max amount
 of device functions
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250602-rk3576-pwm-v2-1-a6434b0ce60c@collabora.com>
References: <20250602-rk3576-pwm-v2-0-a6434b0ce60c@collabora.com>
In-Reply-To: <20250602-rk3576-pwm-v2-0-a6434b0ce60c@collabora.com>
To: Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 William Breathitt Gray <wbg@kernel.org>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 Kever Yang <kever.yang@rock-chips.com>, Yury Norov <yury.norov@gmail.com>, 
 Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
 Leon Romanovsky <leon@kernel.org>, Lee Jones <lee@kernel.org>, 
 linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, 
 linux-iio@vger.kernel.org, kernel@collabora.com, 
 Jonas Karlman <jonas@kwiboo.se>, 
 Detlev Casanova <detlev.casanova@collabora.com>, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.2

With the introduction of the RK3576, the maximum device function ID used
increased to 14, as anyone can easily verify for themselves with:

  rg -g '*-pinctrl.dtsi' '<\d+\s+RK_P..\s+(?<func>\d+)\s.*>;$' --trim \
  -NI -r '$func' arch/arm64/boot/dts/rockchip/ | sort -g | uniq

Unfortunately, this wasn't caught by dt-validate as those pins are
omit-if-no-ref and we had no reference to them in any tree so far.

Once again kick the can down the road by increasing the limit to 14.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
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


