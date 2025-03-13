Return-Path: <linux-pwm+bounces-5166-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F10B4A5F7B8
	for <lists+linux-pwm@lfdr.de>; Thu, 13 Mar 2025 15:20:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B9B61609AF
	for <lists+linux-pwm@lfdr.de>; Thu, 13 Mar 2025 14:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85DE72690CB;
	Thu, 13 Mar 2025 14:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FaOr28aX"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54604268FE2;
	Thu, 13 Mar 2025 14:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741875559; cv=none; b=gEuXL8XzReq5B3LyWkCPYKnAKTTv+u8XpTnk6S6GT2qN6ET/D7wJrX0MdMo5dgEvJraAMftXD7H4goYtqGs77qwxCMK/gKpe6OCaHglgMPvAyFZo2laez0cAsFzVGjrRpkE1qN/m7xsAp8bXzLrEr/+fZSfds5aMsM88A7Qt3bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741875559; c=relaxed/simple;
	bh=HTZtKcPE/KmLhTONUSP12PIgECGY/rxdeux1UJD5SzM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m6XLA03yu/X5CFlUfUMn4YH9Ma0UdUT7C+8kLr3wNmaizgFwV6sVXKtQKN75wFu1PIx6xUP/9aU8oHWBETwNV8YQZsP/sLGjswRc1J7aF6GlUJS9eHzvzNkSYA7YCLlCz0ZQMN2jkVwir18PAHyRGrW/6tRYbnNrSm5/SekiAEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FaOr28aX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7A897C4AF11;
	Thu, 13 Mar 2025 14:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741875558;
	bh=HTZtKcPE/KmLhTONUSP12PIgECGY/rxdeux1UJD5SzM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=FaOr28aXXq5n6fADEcWaXBezw78Plia0WjMpZA6VHl6iLj3jDoIeKqw4Q6NlKhDl1
	 naPYP85YKgHDFPef4jew7S3ApB8lzGCwgFRgJFblVSpPvhOCrGkvUTAuL214l+HA9y
	 V7gXJlJYhDUae5rPoEexMMRNWc0+OX+H3RPkrt06+mx8Es3GKnkOPqOfzeRo3aTqWP
	 ggjFGmbNHmmjDMNKoQrKJS8pXjo7Dc5D+y/DBdUiiwB/qV/pqQMEWO0Hk8Txu+SEmr
	 wg9sJ2bheCRPHHqD+HK0ltDXMo4/CaJ3hmm0gtQULvLbSJnoLLnydwW6GNqkxctovn
	 5qbs8qGzDF7Gw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67157C28B2E;
	Thu, 13 Mar 2025 14:19:18 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Thu, 13 Mar 2025 14:19:32 +0000
Subject: [PATCH 15/18] dt-bindings: mfd: adp5585: document reset gpio
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250313-dev-adp5589-fw-v1-15-20e80d4bd4ea@analog.com>
References: <20250313-dev-adp5589-fw-v1-0-20e80d4bd4ea@analog.com>
In-Reply-To: <20250313-dev-adp5589-fw-v1-0-20e80d4bd4ea@analog.com>
To: linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-input@vger.kernel.org
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Liu Ying <victor.liu@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741875561; l=1046;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=RZgpAeQ47IAlMhn5Pqw+gcN/6fM2CbPkY3yNF9wFGcw=;
 b=R4mB0yuWY/DXUTGIo92U4KKoBaqk/uH940J7JYXdGbEPw5qWOV92ru6vk3WbsvN85iaSXDRpg
 rs/ZeUXAqMVDUwfodlMCWWiZKwze3xZ3n0xgRr4ouDVWr1NAjbsoweT
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sá <nuno.sa@analog.com>

Add a reset gpio property. Note that for the adp5585-01 models, the
reset pin is used as the additional ROW5 which means there's no reset.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 Documentation/devicetree/bindings/mfd/adi,adp5585.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/adi,adp5585.yaml b/Documentation/devicetree/bindings/mfd/adi,adp5585.yaml
index e976c9240df79afae1d0949e6ac91d477bfaceef..20488af1563369b0ef60e8b55ad660a35623039c 100644
--- a/Documentation/devicetree/bindings/mfd/adi,adp5585.yaml
+++ b/Documentation/devicetree/bindings/mfd/adi,adp5585.yaml
@@ -39,6 +39,9 @@ properties:
 
   vdd-supply: true
 
+  reset-gpios:
+    maxItems: 1
+
   gpio-controller: true
 
   '#gpio-cells':
@@ -167,6 +170,7 @@ allOf:
         adi,unlock-keys: false
         adi,unlock-trigger-sec: false
         gpio-reserved-ranges: false
+        reset-gpios: false
         adi,keypad-pins:
           minItems: 2
           maxItems: 11

-- 
2.48.1



