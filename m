Return-Path: <linux-pwm+bounces-3003-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E522F94E246
	for <lists+linux-pwm@lfdr.de>; Sun, 11 Aug 2024 18:35:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BD6B281AF3
	for <lists+linux-pwm@lfdr.de>; Sun, 11 Aug 2024 16:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8BF61537A2;
	Sun, 11 Aug 2024 16:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NVqMH7zW"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC52014B950;
	Sun, 11 Aug 2024 16:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723394097; cv=none; b=POsftqftTqySV1y+FeTn2YgGtgRWv09msl1W+DX1iJhtzLR5M1/WLw7AolljqhJktKY240p17OYYVUjAKn4g4uJJrlc+ty/BmL2281c9uJqSx5gvvSEHdEHk57PxdBTURWCBJ1DwmlWAZiQXT70CH5qju6ixM2WP8AAxK6n/wjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723394097; c=relaxed/simple;
	bh=xUlyE54aBvjUDMvOX8g31Yb3a70VHjGE8lQXt8Jsn1o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Dy/c0eVGgUj/3+nj4k8Uho4gfgC+QFpCRnSzvEc3oS72PVPTSP8Cr7/4yJzmNlkryzbgRhckXk006VgerA1RedRiU+pXhv5NM3T4MUmho7zUbkFREBqljGI0mcFM4LfwrO+Dmf6q/Ux07bd4VN96y04jR5dPt6ZLFdnVfB4zsfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NVqMH7zW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98299C32786;
	Sun, 11 Aug 2024 16:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723394097;
	bh=xUlyE54aBvjUDMvOX8g31Yb3a70VHjGE8lQXt8Jsn1o=;
	h=From:To:Cc:Subject:Date:From;
	b=NVqMH7zWw/I4JdIkjjKHogHp2EXcnyVOBfXJs+ktJ7mOIgbXTgYPHRltkTfNyaenZ
	 /Zc5H6M7R3sp0aKjhIs28qp2d0AQLFQ53KFzpyiN+HwkCic9MnOMhCox5XDjJSO8rH
	 8Jhpw66LeocNRDHZZbi7LkZJt6Xo0HZY75sq9FrHCD1+c6fDK6XdVZHwRCmPJt2Gyx
	 pLKJbmLl4OvBuLhrQZf3TFhA30JyQt5NP3qqajSHo27Aku/8pfzon0XLoxsg2HhaEh
	 pmNx4XPNfZuQfdt5EkO3OLhwA+CCc6t8Z0RtNjYceuh2C7v910B5H5EIZTYuYTkiCj
	 TeunD+sb/DgwA==
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
Subject: [PATCH v2 0/2] Add PWM support to EN7581
Date: Sun, 11 Aug 2024 18:34:30 +0200
Message-ID: <cover.1723393857.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce driver for PWM module available on EN7581 SoC.

Changes since v1:
- fix compilation errors
- fix comment style
- get rid of MODULE_ALIAS()

Benjamin Larsson (1):
  pwm: airoha: Add support for EN7581 SoC

Christian Marangi (1):
  dt-bindings: pwm: Document Airoha EN7581 PWM

 .../bindings/pwm/airoha,en7581-pwm.yaml       |  42 ++
 drivers/pwm/Kconfig                           |  10 +
 drivers/pwm/Makefile                          |   1 +
 drivers/pwm/pwm-airoha.c                      | 408 ++++++++++++++++++
 4 files changed, 461 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/airoha,en7581-pwm.yaml
 create mode 100644 drivers/pwm/pwm-airoha.c

-- 
2.46.0


