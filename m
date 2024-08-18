Return-Path: <linux-pwm+bounces-3035-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A262D955C5E
	for <lists+linux-pwm@lfdr.de>; Sun, 18 Aug 2024 14:03:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE0171F21527
	for <lists+linux-pwm@lfdr.de>; Sun, 18 Aug 2024 12:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B904F17BA9;
	Sun, 18 Aug 2024 12:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YTZqrU4W"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E20E182A0;
	Sun, 18 Aug 2024 12:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723982615; cv=none; b=k2c0PA7qSHzjYFxgAZdzlyhpldCl+niAGOBQYNs3E9OKa+M+/1oLNtNydAeQUiRmV1piiL5kFYCT2Bw/+l7CTP1P7mq35LXWkRvU783HlhYTRfYEPcqQgNw991Xz0bYne+Kzxq218SpSkQs25wbg8hwBdgVXcpgPdM5+/qhLTqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723982615; c=relaxed/simple;
	bh=NneFI/aKI44Oa8B72759jQUaUXhE5CPvAL0PjlomLac=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=fHl36cKwB6nns1y2kezamox2k+8C7pqRrqEfJCRC9Q0wOlAnGHN5JxHLXiw3O+tI+CjJvmCRqQD4NxST4xvXucW5t/BNEPDMy+zhTOqzp41WuVU11EkUf7oT33ujXbPld4UEeSslditM7zW77zjJXrNP/J+U2NXNXqWSKvZBiV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YTZqrU4W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C2E6C32786;
	Sun, 18 Aug 2024 12:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723982615;
	bh=NneFI/aKI44Oa8B72759jQUaUXhE5CPvAL0PjlomLac=;
	h=From:Subject:Date:To:Cc:From;
	b=YTZqrU4WyHshKuPjLSFqQVAGstdjgv3hKebWWgitR04SG2yV3O5PvwKK9b0JWTOdm
	 CZ8pQ1w9v9hI1BBMTC8H/fDRXif+a6wuoRhDpZO2aKbZAdZ/lb2/8hizfstN5w6mAV
	 JonoqznldIbj/uCi4aKTEz0bVbpLcGj0IlRtIF3Ia7ZjvJSa9IiodT4CixXdpeYsdR
	 qPeow77c0WPuEJ6CY9XDue0qqCNplvgMRF9huFr1W9Vrjxk45RmqOOuFMwQXeAhqom
	 ix2JwAiRT1mNTpSYDhTldSP4PsFCSvv5ShIFVv+mDW15Ah0xkvdDaN3790gh8RD0AD
	 UCEMP3bQbd4dA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH v3 0/2] Add PWM support to EN7581
Date: Sun, 18 Aug 2024 14:03:25 +0200
Message-Id: <20240818-airoha-pwm-drv-v3-0-e398f3e41916@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAA7jwWYC/0WOQQ6CMBAAv0J6dklpQQon/2E4FLqFRqC4IBoJf
 7dBE49zmMlsbEZyOLMy2hjh6mbnxwDyFLGm02OL4ExgJrhIuUoUaEe+0zA9BzC0gsHMWIEN5zV
 nQZoIrXsdwWsV2JIfYOkI9ZFp/IoUJ7mQspAqy+PWLXHvCce3v9yQRuxjT+2vRHh/hKPlm/sPl
 dGxk/MMrCc4Q5JAPVnQMi3QNlwZq8pVsGrfP8NUZs7hAAAA
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

Changes since v2:
- fix compilation errors on arm32

Changes since v1:
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


