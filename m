Return-Path: <linux-pwm+bounces-3047-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 533DB95869F
	for <lists+linux-pwm@lfdr.de>; Tue, 20 Aug 2024 14:13:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD106B22EBC
	for <lists+linux-pwm@lfdr.de>; Tue, 20 Aug 2024 12:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3812918F2C1;
	Tue, 20 Aug 2024 12:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gzuryPV6"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F68018EFDE;
	Tue, 20 Aug 2024 12:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724155973; cv=none; b=RO9S6rBXPsPUqQhmHCteGXdXVyPpzNjCZxK24GgIS02+R6UkvA7QtnBPnbC96jz8mfZMwhNWQkCVU5NOUjbtaq1kXWweQylQhTgF4Sjgoq4AT+2bl0wE7rB8kcwNBi3FKANPZPw7LB8wRptDoGaGeuHvVboSIiD6QZzainG0x3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724155973; c=relaxed/simple;
	bh=wAFYBWvy2aohpaOsZuTOOMzrh2vQd2xgJrn5HVeKbBA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=p6CUaJ98vajG0KfJ+0pzo7fWJy3WSlTCTQ/aGYx9julJAFIOEjTgqVHzXk6Kck9k3wTtlNkG9V3K+Rl+o5NWcvQiU/ibvo9FlIzG2xeGE3NdgXssWGja96WavFtao4fQ1NSH3BbgcKz2uPZ7v7PJrpC/qBK6fIgPWW8v6dsMLRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gzuryPV6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECAEDC4AF09;
	Tue, 20 Aug 2024 12:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724155972;
	bh=wAFYBWvy2aohpaOsZuTOOMzrh2vQd2xgJrn5HVeKbBA=;
	h=From:Subject:Date:To:Cc:From;
	b=gzuryPV6ZRSA4NOtDIoEPUBEXUkwvR8RB+06b7TFwf/sp4nuTz37EpijzD2swElwJ
	 gBuqqgOfaa8oezPQKYPNhiu5uBQB62goReYbzNkNlCeyxPphpAfx/sV0wmLr58sCIK
	 wyyefVPs9LFePS20ukz3jHu9Ze5j8OuHz6hUN3s2wteJm6kaHH4VSS2m7pujGDGX3u
	 MoOXu2nOquL5qAGNAyRm/mLUpKaIS2FBnFjbZkD4tSK/vy/UhbExsLyZjCuTH+SdDs
	 cgCJ8qHaDcqjExxrP2I5iLOV4Ds5jJIHJiKClC13p70q0KgteT5S33BJfszSaPIKIN
	 M/xw2XwGB7apQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH v4 0/2] Add PWM support to EN7581
Date: Tue, 20 Aug 2024 14:12:14 +0200
Message-Id: <20240820-airoha-pwm-drv-v4-0-2b1c2b760744@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAB6IxGYC/3WPy26DMBBFfwV53UF+QDCs8h9RFg4eg9UEk4E4b
 SL+Pa5bqd10eRb36NwnW5A8Lqwrnoww+sWHKUH1VrB+NNOA4G1iJrmsuBYajKcwGpjvF7AUwWJ
 tncSe8xNnaTQTOv+RhYdjYkfhAutIaLKmDxGpFI1UqlW6bsrBr+U5EE6PsH9HmvBcBhp+TITXW
 ypav3W/QV2RcxpegwsEOxACTrMDo6oWXc+1dbqLkn0FjH5ZA33mg1Flz39fogIOqFrtFFaiFbu
 /Rcdt2162fVvTLgEAAA==
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Christian Marangi <ansuelsmth@gmail.com>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
 lorenzo.bianconi83@gmail.com, linux-arm-kernel@lists.infradead.org, 
 upstream@airoha.com, angelogioacchino.delregno@collabora.com, 
 ansuelsmth@gmail.com, benjamin.larsson@genexis.eu, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.0

Introduce driver for PWM module available on EN7581 SoC.

---
Changes in v4:
- fix compilation error on sh
- Link to v3: https://lore.kernel.org/r/20240818-airoha-pwm-drv-v3-0-e398f3e41916@kernel.org

Changes in v3:
- fix compilation errors on arm32

Changes in v2:
- fix compilation errors
- fix comment style
- get rid of MODULE_ALIAS()

---
Benjamin Larsson (1):
      pwm: airoha: Add support for EN7581 SoC

Christian Marangi (1):
      dt-bindings: pwm: Document Airoha EN7581 PWM

 .../devicetree/bindings/pwm/airoha,en7581-pwm.yaml |  42 +++
 drivers/pwm/Kconfig                                |  10 +
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/pwm-airoha.c                           | 408 +++++++++++++++++++++
 4 files changed, 461 insertions(+)
---
base-commit: 8400291e289ee6b2bf9779ff1c83a291501f017b
change-id: 20240818-airoha-pwm-drv-de5df2ec00b0
prerequisite-change-id: 20240705-for-6-11-bpf-a349efc08df8:v2

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


