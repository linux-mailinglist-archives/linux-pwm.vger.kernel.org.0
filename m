Return-Path: <linux-pwm+bounces-2914-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C8ED993C8CD
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jul 2024 21:38:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 557BCB219CC
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jul 2024 19:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9D005589C;
	Thu, 25 Jul 2024 19:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="SX9p6/ru"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1907455884
	for <linux-pwm@vger.kernel.org>; Thu, 25 Jul 2024 19:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721936312; cv=none; b=dEuhTPErkfnGqNXoD2GAFshk1YJ589qbX3TKAKRAthKkMhO2eRc7rZpQLSBtvIEIl3+kWfWekTYlNbAl9aJJn52pxo5c3MnxYrwUHQFB/TDXkfn/mtX3Gk9HnXPLipQPnOqI342QpBZ71rOcsCuGUKFx+ff0QWhxrvUkKp0gFlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721936312; c=relaxed/simple;
	bh=OJ6dL3Tb55sqLB2qXtO+nrcNiUTuai5OfQ7n4rAEV/k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VZrGvq+1juPnKfDJVYIQMTpPa1n+LgSYAa+ihBFR11CTYyofx/IfL1ZqEb/fcG+yEytCF5bbwUby/M5PQl83FXFdMTl6JdP3KtN7K+LVU42qG3QN3oMc+bHYvdK6a7iL36EgGSrQbp0Gjlf0xdI4V1JbALQdJ0uHDTC8Qd3Afxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=SX9p6/ru; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:mime-version:content-transfer-encoding; s=k1; bh=/j/emlq9Wcwhx/
	OO5NxgFzHCdkszYejrWhvvaOBz9tE=; b=SX9p6/ruqMFj1iCehsX3slXDEdmLzA
	Cxx0unhmHnub60eGzYNKX+i8cUES2CvR83WuEiEYOAGbnDqSO0Qj5SDG/RaWIrxq
	ed6qMNXxu2LMdQbbEgpqOQ/gqYXlOMzeppnt8kN+M9GQHxwdK/UEVoeCTGymA1N4
	Wx0vMu1sSURgokYWA0hbUA6lDJxzD6rde+r81z0FlpWWu9xu+9Po5GU9jBrsFRYf
	NSkdfeoHmTJPsQk8YrobwhNFgqie1LJiHyFC0xlJBuGv1OO9owSxFhSGwnCbFT4C
	f0Zs9cz6aGVZGyh5UeO0nUkwTDXNvYSf+42OmuDAivcQxqAUOG/JhkZg==
Received: (qmail 3086194 invoked from network); 25 Jul 2024 21:38:26 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 25 Jul 2024 21:38:26 +0200
X-UD-Smtp-Session: l3s3148p1@GvTRiRceXtUujnsv
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-renesas-soc@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
	linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	Magnus Damm <magnus.damm@gmail.com>,
	Rob Herring <robh@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH 0/2] dt-bindings: pwm: Add r8a779h0 support
Date: Thu, 25 Jul 2024 21:38:03 +0200
Message-ID: <20240725193803.14130-4-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the bindings for both PWM controllers in this SoC.

Wolfram Sang (2):
  dt-bindings: pwm: renesas,pwm-rcar: Add r8a779h0 support
  dt-bindings: pwm: renesas,tpu: Add r8a779h0 support

 Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.yaml | 1 +
 Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.yaml  | 1 +
 2 files changed, 2 insertions(+)

-- 
2.43.0


