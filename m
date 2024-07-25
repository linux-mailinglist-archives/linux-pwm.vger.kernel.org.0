Return-Path: <linux-pwm+bounces-2916-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AF9993C8D5
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jul 2024 21:39:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 265D0B222C8
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jul 2024 19:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACCB21369B6;
	Thu, 25 Jul 2024 19:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="XhkQSnDo"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E6776036
	for <linux-pwm@vger.kernel.org>; Thu, 25 Jul 2024 19:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721936316; cv=none; b=V5prcHmsUO1W8/VYFSGhjFpBJaN7mlUPGD34fgaOQsmbfFokc5lsE7VzISpLakIOFS2Qod03D6i7H5lsBHPC5CXsHh/T/9MnylT9to4xdXGJDLWIOpadZGX7rzc6lp3kx7XZBOgfJ4unosxiqu01UH2MpWTvI5pIUmArs8lEfLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721936316; c=relaxed/simple;
	bh=iZDrPg+CXyY9fqxcW/wsDBsQ9YoVYk5jMoM543C5ips=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gMaE8RQhK7Bpa8I3FDMwpVcZ0IALPyATRug0ldy/N8DNN3iHyGhTvdCZY8SfkqxpOLubDM81xFDbTOpamrzf2J5OiW/YHNClkQ1OOEvQya84JP/s4xzmPFLa+W9KAhVOBGunupJw32EEBhDRbGPKyg1yu9e94p+/mIO+ZRj8Mdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=XhkQSnDo; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=DT5h3oFizEgEe8a32cS3JZd9hwSm/bnmsT6MyoxeeTk=; b=XhkQSn
	Dos8gcuFqk9Zo5K4Km5YXImNnq0mAlQU+/nLm4XxEe5UQy28YLd+g1COgqUR7z+T
	irl7+E5CipyhKQd9VTe5TMYS9Bi/4VB3GD4L1y4R2MFkk9Ur99hGmE/wrHFYKcDK
	F326+jum5y7sftSD4XIsaFZuBzgOWWGqjx8DZLMH3EYldgdKahWj2gbz9xHXiIJE
	rJBKtuBaXy1z58KoDUfN+ZRC/eEex4OasssFpGD2MUSxaW4oKCZlSNrj80+hy/Au
	ZZpKRNsgaHVSi/3fMz8sxa+l7oGw6XSzp86F1E0j1n24+YoxSOfnY/H8GxLgIT1s
	S0L/WXgvgHdjADbQ==
Received: (qmail 3086315 invoked from network); 25 Jul 2024 21:38:28 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 25 Jul 2024 21:38:28 +0200
X-UD-Smtp-Session: l3s3148p1@dKLyiRceetUujnsv
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-renesas-soc@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
	linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] dt-bindings: pwm: renesas,tpu: Add r8a779h0 support
Date: Thu, 25 Jul 2024 21:38:05 +0200
Message-ID: <20240725193803.14130-6-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240725193803.14130-4-wsa+renesas@sang-engineering.com>
References: <20240725193803.14130-4-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document support for the 16-Bit Timer Pulse Unit (TPU) in the Renesas
R-Car V4M (R8A779H0) SoC.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.yaml b/Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.yaml
index a3e52b22dd18..a4dfa09344dd 100644
--- a/Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.yaml
+++ b/Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.yaml
@@ -41,6 +41,7 @@ properties:
           - renesas,tpu-r8a77980  # R-Car V3H
           - renesas,tpu-r8a779a0  # R-Car V3U
           - renesas,tpu-r8a779g0  # R-Car V4H
+          - renesas,tpu-r8a779h0  # R-Car V4M
       - const: renesas,tpu
 
   reg:
-- 
2.43.0


