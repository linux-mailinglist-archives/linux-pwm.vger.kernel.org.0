Return-Path: <linux-pwm+bounces-172-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E25337F60B7
	for <lists+linux-pwm@lfdr.de>; Thu, 23 Nov 2023 14:47:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FBE81C20F8E
	for <lists+linux-pwm@lfdr.de>; Thu, 23 Nov 2023 13:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB0212574B;
	Thu, 23 Nov 2023 13:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u0bpNOGX"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9822C22F1D;
	Thu, 23 Nov 2023 13:47:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38256C433C7;
	Thu, 23 Nov 2023 13:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700747246;
	bh=Tksu6lTu40j+EZN0tFMOSHhEBbN9nqr7FRPKCBhoTj0=;
	h=From:To:Cc:Subject:Date:From;
	b=u0bpNOGXh6wXoJmvu24UNoROEX9mo2lQ36OS/28yua3mXZAToDDRW8BhBouOCoj22
	 UMf/7Vxo660dRPGFXxXoJgOi7I8c6JAObRyyvcHTOAXlsKPScykxdVUHTPR2XNYxmc
	 vWWSjHrVho+3H1Dx88FGv62CG8v58BSJPgSwIrEYtQerczlHW1DZFdzZyBSWgYLz1V
	 nqaqo25N3JbrdJGTV8mZCNdl0CtfN40RCcJYZYPJrSUs+M6P9pEnRLFU+mFHs1ZFOp
	 ch0Y6FHDldK0+6mehsABWKFoVUpnN8mEEc3QMOT8XEFR4OXHua61aOK0RNYQRl4ESV
	 k0PZfbakWzw0A==
From: Michael Walle <mwalle@kernel.org>
To: Thierry Reding <thierry.reding@gmail.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Jitao Shi <jitao.shi@mediatek.com>
Cc: linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Michael Walle <mwalle@kernel.org>
Subject: [PATCH] dt-bindings: pwm: remove Xinlei's mail
Date: Thu, 23 Nov 2023 14:47:16 +0100
Message-Id: <20231123134716.2033769-1-mwalle@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Xinlei Lee's mail is bouncing:

<xinlei.lee@mediatek.com>: host mailgw02.mediatek.com[216.200.240.185] said:
    550 Relaying mail to xinlei.lee@mediatek.com is not allowed (in reply to
    RCPT TO command)

Remove it.

Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml b/Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml
index 153e146df7d4..afcdeed4e88a 100644
--- a/Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml
+++ b/Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml
@@ -8,7 +8,6 @@ title: MediaTek DISP_PWM Controller
 
 maintainers:
   - Jitao Shi <jitao.shi@mediatek.com>
-  - Xinlei Lee <xinlei.lee@mediatek.com>
 
 allOf:
   - $ref: pwm.yaml#
-- 
2.39.2


