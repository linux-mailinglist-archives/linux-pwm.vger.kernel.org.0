Return-Path: <linux-pwm+bounces-2992-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0156894DABC
	for <lists+linux-pwm@lfdr.de>; Sat, 10 Aug 2024 06:49:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9997B1F222A5
	for <lists+linux-pwm@lfdr.de>; Sat, 10 Aug 2024 04:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06E3412D760;
	Sat, 10 Aug 2024 04:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GYe6lDCv"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C713A241E7;
	Sat, 10 Aug 2024 04:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723265363; cv=none; b=dJOcF8tQfgHq8S90Cml+hJnUkdnn5VA2fIfPFEMkLKM/VUsMZG8OzUGYNFyfR4y2hstGIbkchRPHfCp73adHQt9A7TgBsmC8eMsjzFnalVJqmbgc0eWypAHGaCILk2iZlITi3L2d+3MqXj/zoT29OP7DQIaeI2Y1EYB9L/ypKDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723265363; c=relaxed/simple;
	bh=/TbkSKTWzsAmYq9/B1RSPVECpYzuRzgwQQKFiytxSog=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=POKTXlO5FEqVwntAE0n+lynsol30D1BVws0nUcIWjPSiRPj38dnir1zUlNCKcyTqJGg+79gM/PIMn0umTUqGaorU0JYuuMBHTV36NGqiilPOHmoNrnyKfMHXbEMziNx7ZJTOkwPaDaXD8Dd9mrJVkvU/h0rYLuG9qzqfFXum6ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GYe6lDCv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEE7DC32781;
	Sat, 10 Aug 2024 04:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723265363;
	bh=/TbkSKTWzsAmYq9/B1RSPVECpYzuRzgwQQKFiytxSog=;
	h=From:To:Cc:Subject:Date:From;
	b=GYe6lDCvduH5xXFzr76NycB37XG/7ehF399HdLOhmztAETNkOgZoqIgqzvmFqYVkO
	 2T9QdCRJ3fivleytnVpKMYEcVpRT+kINMrvf+14H0POqQoie2MLA1E1oNhAWiWyrpI
	 GvGTkhT2UPpjK2jycULSxaPk5JZriZOaUmJCuKZlYqNHt9oQEeJn2nmOy7jWrwoMO4
	 4GLaTvokqhPTpYNFwRyc4Afy9zR/rlRDbyxPo2A7WiMG7npXuCSe16UTGMEdiRdq7h
	 QjDUYdCFYG7FxrKSFAFtDi8nc4noKfZP0yGQIJolowHCMK25y+51WDqF9qv82mTDMh
	 J7SWs9WGwYB4w==
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: linux-pwm@vger.kernel.org
Cc: ukleinek@kernel.org,
	lorenzo.bianconi83@gmail.com,
	krzk+dt@kernel.org,
	robh@kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	upstream@airoha.com,
	angelogioacchino.delregno@collabora.com,
	benjamin.larsson@genexis.eu,
	conor+dt@kernel.org,
	ansuelsmth@gmail.com
Subject: [PATCH 0/2] Add PWM support to EN7581
Date: Sat, 10 Aug 2024 06:48:41 +0200
Message-ID: <cover.1723264979.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce driver for PWM module available on EN7581 SoC.

Benjamin Larsson (1):
  pwm: airoha: Add support for EN7581 SoC

Christian Marangi (1):
  dt-bindings: pwm: Document Airoha EN7581 PWM

 .../bindings/pwm/airoha,en7581-pwm.yaml       |  42 ++
 drivers/pwm/Kconfig                           |  10 +
 drivers/pwm/Makefile                          |   1 +
 drivers/pwm/pwm-airoha.c                      | 403 ++++++++++++++++++
 4 files changed, 456 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/airoha,en7581-pwm.yaml
 create mode 100644 drivers/pwm/pwm-airoha.c

-- 
2.46.0


