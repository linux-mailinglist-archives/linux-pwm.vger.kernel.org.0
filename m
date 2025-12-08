Return-Path: <linux-pwm+bounces-7777-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 27201CAD8EC
	for <lists+linux-pwm@lfdr.de>; Mon, 08 Dec 2025 16:21:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BC1B53017666
	for <lists+linux-pwm@lfdr.de>; Mon,  8 Dec 2025 15:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A3D827C162;
	Mon,  8 Dec 2025 15:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jWvmYVxO"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665BE2797BE
	for <linux-pwm@vger.kernel.org>; Mon,  8 Dec 2025 15:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765207300; cv=none; b=ohgwXyt9shGnXme7NFzKPjb7RzBp7/ONL+yoPyMI3I9bEib2FLIfqv+GBrcYawrDJb/v3OQmG9N+8mQtYaLnnHVu6rTt3urKee7wcY1SZKd8uCTKnIHBxeEfJzPNBoh9Bi5yytZ0t7Wa0E8AEg4RWjttUhrY/Nl5GVboaHAfdAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765207300; c=relaxed/simple;
	bh=JP2fz9Dv4DJWLvkYoNe7H1Oid5YvFT7CctbsVz7dpSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qgnwVC/BisQeWwxGz2Hop3PGWPhxSEOtiAdChfzhAXsek5k0s5HFusdZgBeXTyWXL8y8LJxvBB03y6C+SuWJZhblFrW2bp9L9e0zXEgwNgxTGhYk17hMdg06icyHYNi89qfVA5KwLkLoOhvBn0eDgj9TbcMnhQl2ZpFcK3PxJXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jWvmYVxO; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-640a0812658so7929375a12.0
        for <linux-pwm@vger.kernel.org>; Mon, 08 Dec 2025 07:21:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765207297; x=1765812097; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B4/wvP35/1XunlBudfWVzFMdIF32aFpqLyJzIThUjSU=;
        b=jWvmYVxOcwGMAruzdYSPMnTY0VSgS6VlcC7Y/ppUuJhwDez++ykh7TEPIPJCNn94h0
         DyjxUh5/7GzhQuQYCHYhPmgnrhaK4CIYD5wrngRymhkeZYkaW5kJS6m0q7BNTNw6ziUs
         5nDDeYf7yiEo+v3HjzTF/yp+xx+ms+83Odmrm0VNDQcYQAb9C2yvZPuPhvqeyDl3Exhz
         EAox1p4Za2ta40H5+z1p5dw3s5KaluCLre9f1RxSUlIU1b3f2idNxbPmOUwQcksDq+JG
         nfI2VylMsFS+bpe8AoQfVt0rqBgxZ0rR83qV229Oee8I+ssZfdcOwt9CnWphSmMhNXOO
         OXfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765207297; x=1765812097;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B4/wvP35/1XunlBudfWVzFMdIF32aFpqLyJzIThUjSU=;
        b=BRPXXBV3jTH5R9hf5DyGuU9e8E+XJG11o6s2BOQb+I+GyVK/f9F5M5iaye0JklnRno
         EVjjTLtWx0h/r4WGu3hgxbQrsDjcFr65yOJ4juCNth8ut7v0HfJBciYW1fjcHbeLx1hC
         L/6b6ReRSuynpg+kAKfINou3W8WrGI5dvyD4vQgEGD2ppODu59A6uHJUQD+gVUUOpwlJ
         5QnNI/FOSKH6XQVeBKAs8jonwD2NvhUlcy0FjCC6eXhEPBhsphsQGWDZSZRXshtZSvc1
         LBc7i+rmTrPQ+rQwvHvvFolbj0S7ACbEfeodkWtBP2ovflpM5KlwtKkc9pVkDhto9+gR
         ntuw==
X-Forwarded-Encrypted: i=1; AJvYcCXVrgf1NczWgOju3R7dPFhmPl6nIrVPObVXIchuT88+NIxvQ2qlQUnk+Z7GZHaAk2SP2U9pDnfRn1c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzim82uVm4P9y3zO5mxcTZbuchCrXyTjfwWHTXckFjN6QW1BjqV
	HGlt9v/Ah0Q3TFtAiPYwGseDCIb05RID/G8FwhB4FbAlSU6c+GbPP4j+
X-Gm-Gg: ASbGncv9cnCVW+niEj/yQuZGp37RlBTVcZLWvfgHL/IrI2Cvb4KM4UHaWQ3zk7T5T6U
	lum0N9/snDE9VazZ/pyIwfyT3zPbKFNrKAWMDHMhkwk5+6vy+RtF03a2azwHm5tWvwBHhumdUse
	YvG+vDLVwSO5+TTAytFqvV1TYXsx9BBcWZ/aXl7vACNm8o9nzUZNwSO4CR13XwRl1UbHg7vO1Zg
	//t99/oZ3ODHs539cSYecLIRSY/glzvWtbK08pPrDEcfmkxSCom9pnigkxzt8dGtkQSl+36hpVO
	OeNrEdx37SgHc3ONcobXWMTaODs3Qyp6RF9o4L/KGu6l9qF4Zg4mKVCZrfqzofFlyyodEOGPSDh
	ORf1m3ecMnaVyOkZpM6BJA9QBciXcCVcwuDRO2bnJ7HCDUnlTQKoD+X2mMSxmtOYoXNVLLxrb+q
	2ibGwdb6wKbwgFUfh0NakWYMzD/HyDtAckkmFaqFOj8I2qIzZllaXgjpfcuoUF7wQ921M0fV6Bi
	X8E31QjxO1dRPPz
X-Google-Smtp-Source: AGHT+IHxdWJsw1kNb8reJw7JSoI2S/TXuOuDjwZ2NsDuaPdfwtLRf7UY3wFExCIiplYPXHFP+4litQ==
X-Received: by 2002:a05:6402:3485:b0:63b:ef0e:dfa7 with SMTP id 4fb4d7f45d1cf-64919c043dbmr6304762a12.6.1765207296481;
        Mon, 08 Dec 2025 07:21:36 -0800 (PST)
Received: from localhost.localdomain (host86-162-200-138.range86-162.btcentralplus.com. [86.162.200.138])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-647b412deddsm11547484a12.31.2025.12.08.07.21.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Dec 2025 07:21:36 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>
Subject: [PATCH v4 0/9] Add RZ/G3E GPT support
Date: Mon,  8 Dec 2025 15:21:17 +0000
Message-ID: <20251208152133.269316-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

Add RZ/G3E GPT support. It has multiple clocks and resets compared to
RZ/G2L. Also prescale field width and factor for calculating prescale
are different.

v3->v4:
 * Added wave form callback conversion back to this patch series.
 * Updated rzg2l_gpt_is_ch_enabled() fit into 80-character limit for
   consistency with other functions.
 * Dropped field_{get,prep} as mainline now support it.
 * Updated commit description for patch#3
 * Retained RZG2L_GTCR_TPCS bit definitons
 * Replaced gtcr_tpcs_mask->gtcr_tpcs
 * Updated commit header and description for patch#4
 * Renamed prescale_pow_of_two_mult_factor->prescale_mult
 * Added RZG3E_GTCR_TPCS bit definition for RZ/G3E and added to
   rzg3e_data.
 * Added error checks on suspend() and device set to operational state
   on failure().
 * Added Rb tag from Geert for SoC dtsi.
 * Added SW_GPIO9_CAN1_STB check to gpt0 node.
v2->v3:
 * Added Rb tag from Rob for bindings patch
 * Dropped wave form callback conversion from this patch series as
   it is covered in another series[1]
 * Added suspend/resume support.
v1->v2:
 * Created separate document for RZ/G3E GPT.
 * Updated commit header and description for binding patch.
 * Added waveform callback conversion to this series.
 * Collected tag.
 * Added link to hardware manual
 * Updated limitation section in driver patch.

Biju Das (9):
  dt-bindings: pwm: Document RZ/G3E GPT support
  pwm: rzg2l-gpt: Implementation of the waveform callbacks
  pwm: rzg2l-gpt: Add info variable to struct rzg2l_gpt_chip
  pwm: rzg2l-gpt: Add prescale_mult variable to struct rzg2l_gpt_info
  pwm: rzg2l-gpt: Add calculate_prescale() callback to struct
    rzg2l_gpt_info
  pwm: rzg2l-gpt: Add RZ/G3E support
  pwm: rzg2l-gpt: Add suspend/resume support
  arm64: dts: renesas: r9a09g047: Add GPT nodes
  arm64: dts: renesas: r9a09g047e57-smarc: Enable GPT on carrier board

 .../bindings/pwm/renesas,rzg3e-gpt.yaml       | 323 +++++++++++++++
 arch/arm64/boot/dts/renesas/r9a09g047.dtsi    | 184 ++++++++
 .../boot/dts/renesas/r9a09g047e57-smarc.dts   |  13 +
 drivers/pwm/pwm-rzg2l-gpt.c                   | 392 +++++++++++++-----
 4 files changed, 819 insertions(+), 93 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pwm/renesas,rzg3e-gpt.yaml


base-commit: 82bcd04d124a4d84580ea4a8ba6b120db5f512e7
-- 
2.43.0


