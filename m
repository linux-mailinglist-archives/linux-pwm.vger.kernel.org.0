Return-Path: <linux-pwm+bounces-8373-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mCLOCDXVxGnk4AQAu9opvQ
	(envelope-from <linux-pwm+bounces-8373-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 26 Mar 2026 07:41:57 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ADEAD32FFAD
	for <lists+linux-pwm@lfdr.de>; Thu, 26 Mar 2026 07:41:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 24DBF3074F2D
	for <lists+linux-pwm@lfdr.de>; Thu, 26 Mar 2026 06:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1D6C346FA5;
	Thu, 26 Mar 2026 06:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tlvjf7Jd"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D3C33CEB5;
	Thu, 26 Mar 2026 06:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774506947; cv=none; b=tmsO9wIoVu+25Xzy0iJ81ZhZnmDipB276U1+iR+ZXvx6b2V9IU9Bsqw3ooHp1KAatqrmUIufdOcpEhMZ4g53cccfjqO3zmgEXzdeRZo+JIVRbAV0YEK89Jxy6b+XF7MNjXsmCiOqpHIrlfRbuYgDUGPefjPxs6S5VzIfsT2LvOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774506947; c=relaxed/simple;
	bh=mXw+OnzMTg/llL26Q+CuSnTiRZOcs0RZPrPP1Kk4svA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=PJ9Xf+m6F/bot2FcbofafGmk8bnTi8VZ2S3odAfcyhvUx7qHClsC3GOJKwIuvwQSu+F2FSfi4YnAgwGLwS+rLKtcQXsn7w9YqKKuhux+5nhByorO7dLI9A7+UN5qf9XA8VUJumCnQTIM6Df9GpHXN+rLfWcjh5AqxteRVOKTdGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tlvjf7Jd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 14574C19423;
	Thu, 26 Mar 2026 06:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774506947;
	bh=mXw+OnzMTg/llL26Q+CuSnTiRZOcs0RZPrPP1Kk4svA=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=Tlvjf7JdSHXxQLDgiwkI+gx3cEMeCILMoLYre+Qn8k9YrVAmMNzlSxpI2vdxFUP4I
	 EeywSuAodFlNYpFHiPHz1SDY54LoH5NNISksD+p6nIdCFWiP7ReMBzmps894gCYjW4
	 2vL0l0Ih1fvtyEe7umkH8xc9tvXXk4PZJqbuBNWFhrJvWtDxBs9pjhfwQPM1Xq/4ek
	 3mcK0pn3i/QXUCc6moj0KTwmUPg8P887nDAmSajZKcx19G94emUHhHcL/DLy9sX7vw
	 jPBPjdQLQw8d00wX3m+4hRtuDMGzFlMXhbLflMlLWZ8dzsPikGu0VX+zQQLFbjEoDm
	 7SZgdtB7YxxyQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08122109E556;
	Thu, 26 Mar 2026 06:35:47 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Subject: [PATCH 0/2] Add PWM support Amlogic S7 S7D S6
Date: Thu, 26 Mar 2026 06:35:37 +0000
Message-Id: <20260326-s6-s7-pwm-v1-0-67e2f72b98bc@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALnTxGkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDYyNT3WIz3WJz3YLyXF0jC0MzU4skCwtzYzMloPqCotS0zAqwWdGxtbU
 A5IPHXVsAAAA=
X-Change-ID: 20260325-s6-s7-pwm-281658b88736
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, Xianwei Zhao <xianwei.zhao@amlogic.com>, 
 Junyi Zhao <junyi.zhao@amlogic.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774506945; l=648;
 i=xianwei.zhao@amlogic.com; s=20251216; h=from:subject:message-id;
 bh=mXw+OnzMTg/llL26Q+CuSnTiRZOcs0RZPrPP1Kk4svA=;
 b=OKuOvNZb4cwcyMGkRCZPv7Lo3XaP6ugCt+rAwxMUC/RBELX+R+vk05Ud6A/aa/KMmrd7brkrb
 15QAhUmz6DYDQdl0VlL1R4Ir0jw8UGCNuyqUtL27raJ6dhJ2p/+1wE0
X-Developer-Key: i=xianwei.zhao@amlogic.com; a=ed25519;
 pk=dWwxtWCxC6FHRurOmxEtr34SuBYU+WJowV/ZmRJ7H+k=
X-Endpoint-Received: by B4 Relay for xianwei.zhao@amlogic.com/20251216 with
 auth_id=578
X-Original-From: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reply-To: xianwei.zhao@amlogic.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8373-lists,linux-pwm=lfdr.de,xianwei.zhao.amlogic.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,linaro.org,baylibre.com,googlemail.com];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,linux-pwm@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	HAS_REPLYTO(0.00)[xianwei.zhao@amlogic.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amlogic.com:email,amlogic.com:replyto,amlogic.com:mid]
X-Rspamd-Queue-Id: ADEAD32FFAD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add bindings and driver support Amlogic S7/S7D/S6 SoCs.

Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
Junyi Zhao (1):
      dt-bindings: pwm: amlogic: Add new bindings for S6 S7 S7D

Xianwei Zhao (1):
      pwm: meson: Add support for Amlogic S7

 .../devicetree/bindings/pwm/pwm-amlogic.yaml       | 27 ++++++++++++++++++
 drivers/pwm/pwm-meson.c                            | 32 ++++++++++++++++++++--
 2 files changed, 57 insertions(+), 2 deletions(-)
---
base-commit: 8ab1fc9104158045f68fde2d0ae16f5fbcf8bfbd
change-id: 20260325-s6-s7-pwm-281658b88736

Best regards,
-- 
Xianwei Zhao <xianwei.zhao@amlogic.com>



