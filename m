Return-Path: <linux-pwm+bounces-6477-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FDAFAE3F2B
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Jun 2025 14:08:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B7491790B0
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Jun 2025 12:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45819248F5A;
	Mon, 23 Jun 2025 12:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="eNMZ7Lqn"
X-Original-To: linux-pwm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91AD5248F46;
	Mon, 23 Jun 2025 12:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750680086; cv=none; b=ZxqOhyvEuNSmUAVX4NqIqT834ErwmyGbXRKUC2Z4X9jMxFfOXK9nUiFXGR8hHW6EHaBY6e60vfTwTvw2j6RnNhV2DAueTDpQZZfI2F7tX5B8eMIgDsj+Hdvkt9zTbJNfeDBVcYXTTeL4a46LSLkx4VmjwiGVR2Xk/qQNURycp+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750680086; c=relaxed/simple;
	bh=YMJ1LS+KoR0M9I0Sxf/wRosogdBiBEWRZnfRRB9Zjw8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AZJfx58MhOw8+1bI470X22PydDag1w/WWNavSfejNEKXMnKONe23rnx6iayC49RvzktAHA+DEpoTgUR+zJLsJ79fYNGftdooB2WrKSl0CItS8cAD6zzjYj7RVLBOtGSbh589RiB//X13TzzpjRSjC+Pj7hRsy8ZljdSmalXnxNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=eNMZ7Lqn; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1750680083;
	bh=YMJ1LS+KoR0M9I0Sxf/wRosogdBiBEWRZnfRRB9Zjw8=;
	h=From:To:Cc:Subject:Date:From;
	b=eNMZ7LqnqvnP39GaVTEhiQlRuMnKYwlHyzY38hOHZKoLBeZK9aMwYAcf5fcIsmJGP
	 7U1UIEGty2G7qpEZwwS/cwnMe62eIaRPbKLRyBZiYsmjbbF7IvdSVSJRhJgzMZtjRe
	 9c5rOLlEjFd5NxKTFg8a3yogSfUlvJAgn/4Ze7shDUp3fThXSSI8/2LkJso2BmmruE
	 y9Kwb1uDXBKzaTg4GTY6odYw5PqBaHQLlDh/LZWTNOWqqpYX/rnDYTiGJbzx67vxKv
	 SRk65wYFI958m3ByiUETTYyRQ+T6vgRjaQ1r/V0wyMcvd7wJAVGGvnZqu8DQabcIkf
	 blaf4EoYLAgFw==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 4F33117E0EC0;
	Mon, 23 Jun 2025 14:01:22 +0200 (CEST)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: ukleinek@kernel.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	john@phrozen.org,
	linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	kernel@collabora.com
Subject: [PATCH v1 0/3] pwm-mediatek: Add support for MT6991/MT8196 SoCs
Date: Mon, 23 Jun 2025 14:01:15 +0200
Message-ID: <20250623120118.109170-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds support for the PWM IP, version 3.002, found in the
MT6991 Dimensity 9400 Smartphone SoC and in the MT8196 Chromebook SoC.

AngeloGioacchino Del Regno (3):
  dt-bindings: pwm: mediatek,mt2712-pwm: Add support for MT6991/MT8196
  pwm: pwm-mediatek: Pass PWM_CK_26M_SEL from platform data
  pwm: pwm-mediatek: Add support for PWM IP V3.0.2 in MT6991/MT8196

 .../bindings/pwm/mediatek,mt2712-pwm.yaml     |  5 +++
 drivers/pwm/pwm-mediatek.c                    | 38 +++++++++++--------
 2 files changed, 28 insertions(+), 15 deletions(-)

-- 
2.49.0


