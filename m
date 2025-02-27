Return-Path: <linux-pwm+bounces-5011-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DEECA47BED
	for <lists+linux-pwm@lfdr.de>; Thu, 27 Feb 2025 12:22:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD7963AF2F7
	for <lists+linux-pwm@lfdr.de>; Thu, 27 Feb 2025 11:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BE6F22F384;
	Thu, 27 Feb 2025 11:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="GcN2ERCc"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-m3277.qiye.163.com (mail-m3277.qiye.163.com [220.197.32.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1E722CBC0;
	Thu, 27 Feb 2025 11:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740655187; cv=none; b=gcC4GzUyvUfuy+KI4d0RKCxYJbCpCq8xlE6MYT+y02QTm8hJuwJyWKTfTRrVAd1YZxiyR8NzWqh3AWAJLfuIetWpzfYuXpe+P6L8uCfJ8UqmNCXjtaiQk0N8gDSC4ICICFMUDiL0zs4Qidx7jTqsPEqMyrMGcyc8dZX9/AsRd78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740655187; c=relaxed/simple;
	bh=EY4+Z1I0kt1KrJE4+1Ei9AvotFHKyYCjeFn4OAX8t3c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AERK4MxeKGrEeVLsFnsMAuTkwc1C+cXD8ZpFrkX8eyxA9AgF+BYZ9WRnpr0XRpM3rmc2W16+QvfCU+SEFQUjPNtL6MIcjaAeqBtzG595oj8xN1PKdWY3+cX5simUD8r1MQaCaeB2zXuSq+GoT7u4JgsRZUmlDyboKdZDmyrPZ/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=GcN2ERCc; arc=none smtp.client-ip=220.197.32.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id c65f97ec;
	Thu, 27 Feb 2025 19:19:35 +0800 (GMT+08:00)
From: Kever Yang <kever.yang@rock-chips.com>
To: heiko@sntech.de
Cc: linux-rockchip@lists.infradead.org,
	Kever Yang <kever.yang@rock-chips.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	linux-pwm@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 10/15] dt-bindings: pwm: rockchip: Add rockchip,rk3562-pwm
Date: Thu, 27 Feb 2025 19:19:08 +0800
Message-Id: <20250227111913.2344207-11-kever.yang@rock-chips.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250227111913.2344207-1-kever.yang@rock-chips.com>
References: <20250227111913.2344207-1-kever.yang@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0lIT1ZIH0JIGR9IGE1IGRpWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
X-HM-Tid: 0a95472227a603afkunmc65f97ec
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PQw6Ajo6PDIWMw0ZEkMSHgMK
	NjJPCxFVSlVKTE9LTU5OSkxNQ0JLVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
	EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFKS0JKNwY+
DKIM-Signature:a=rsa-sha256;
	b=GcN2ERCc1IPbG8jdSQtA8+gejnae2Ic80W8H0f/M/9NoS9RfXof+K3bYWjyMhKuOedDw/XI6BQEYsQufopuwN507GTjp7A1azj/7+xjM6iQKEkxbVMc8XAkrXttbNAKs6X1Cle31sEbkhBko7R/8JulWU3/OED3FqwSUk1M8N00=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=FneYXAuOME8Df99lzvc4w6XCpUDG98t55L9UJ4vYqBQ=;
	h=date:mime-version:subject:message-id:from;

The PWM core on Rockchip's RK3562 is the same as the one already
included in RK3328. Extend the binding accordingly to allow

	compatible = "rockchip,rk3562-pwm", "rockchip,rk3328-pwm";

Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
Acked-by: Uwe Kleine-König <ukleinek@kernel.org>
---

Changes in v3:
- Update the commit message and collect the Acked-by tag.

Changes in v2: None

 Documentation/devicetree/bindings/pwm/pwm-rockchip.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pwm/pwm-rockchip.yaml b/Documentation/devicetree/bindings/pwm/pwm-rockchip.yaml
index 65bfb492b3a4..e4e1976c542d 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-rockchip.yaml
+++ b/Documentation/devicetree/bindings/pwm/pwm-rockchip.yaml
@@ -30,6 +30,7 @@ properties:
           - enum:
               - rockchip,px30-pwm
               - rockchip,rk3308-pwm
+              - rockchip,rk3562-pwm
               - rockchip,rk3568-pwm
               - rockchip,rk3588-pwm
               - rockchip,rv1126-pwm
-- 
2.25.1


