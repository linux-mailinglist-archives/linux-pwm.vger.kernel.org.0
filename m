Return-Path: <linux-pwm+bounces-6034-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B07A4ABE5A4
	for <lists+linux-pwm@lfdr.de>; Tue, 20 May 2025 23:03:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72F151894ED6
	for <lists+linux-pwm@lfdr.de>; Tue, 20 May 2025 21:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62BF25E458;
	Tue, 20 May 2025 21:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ZfjPm/J5"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36AF02528F3
	for <linux-pwm@vger.kernel.org>; Tue, 20 May 2025 21:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747774882; cv=none; b=gLsKAnw1MK46ic9BceK+CHRSi5bkTc/M2KVCp4I69JP8yBNGSyTB7GiMscsQ2Vr6AZNXc/Z5aTgTdhDPiLFc2BqLkS1aTFDmaJof5PPQqNuONZ/6Cqz6PxoffxpGGv3/G195DY5ASEGXz6XwbtsEtFVhwqbUtgUHEJl61jBsQxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747774882; c=relaxed/simple;
	bh=hFJhOZb2KYc99TdUu5lHL7z+CYiP5EKAGEds0BI0i+g=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=tjTplLPzO1GQarz2racSDc753ceune6UaIiLDQCV2RmAoYh4T3Qz4PAMkhQ70zRtjXXOaHaXyjUl/fQi8xSSVrkMWTCuhgyXnlS3dCV3akDnl3thhi0Gsy0OeANC3RzAUDuLN7GNizRiP0RxILOXXlHutzlJ+aMWhogHAn7UsUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ZfjPm/J5; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-2cca475546fso3419718fac.1
        for <linux-pwm@vger.kernel.org>; Tue, 20 May 2025 14:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1747774877; x=1748379677; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kQLjZcAnXXaS5ho2DdOLPHVtQHkOQ3Gsnqmc9n9fclM=;
        b=ZfjPm/J5jnFRDs6BM27vzshhg/37uLsj9lGq9SA0QS/e0PfudXpVN1Jk/89S4fEKU7
         AtUBxyIPcXUV/zZsD5PxXYAyRGH5vVZfVJN6ncr7LomZtAw6zsrmavlEDoug5mUQcOVX
         9N2anUp10F539+T32cC5TQ5dZGSr/NHOTUgseY72MAOcG8UaCbjwObFx6ayvNWk+aGUA
         42AbaAzZuzeKmEyfpCG9dh3FmlbLl8K+sxs9Yn0261VtUgZ4+4TrluiAQqQ56vAQl+UK
         d4MN7LACdWEEL8chhtR9AHbtHc8WydoJMgLnT7dqE7JdmsVcQNqk5MgbuDuwslKddkDS
         hS2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747774877; x=1748379677;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kQLjZcAnXXaS5ho2DdOLPHVtQHkOQ3Gsnqmc9n9fclM=;
        b=tNi2esraZn9QBK9xQm1kQNBHrfi9pmr+J6PyBM//o/o4DoGnAKoHCAQ8lVj5JN+SYi
         lB6X4K4ZV90BFqJU+MEGTm4FASrKh8e4q29XdOKxalXtXex9HyS9czGqO2tlE6LpO7CW
         /dAYh497CoWJA1E49BP4KEKW3LxCVXYIUwzTu7wPOdWKymSBYz5L/9euvlOqAc/IAOCp
         9/AU8jo4IIqTzOYzTQOgg0m8pcRkpBXITtl2AeHdPOGdsJHXjYkjN1J0gngiWeyr4VBj
         1sVEx+8cj10ye1XuppAsqrXvNSEFAA8/2QqG5TXFZUo5DhBVEmwMeoRpeFXCuOZTnhao
         AEPg==
X-Gm-Message-State: AOJu0Yw1mQeiS0ua9pcDv0hGyInlm183P4Hp2ldL4vN+rNToX0KreehL
	FsE8gfSoIWTsBr/M1Dq+dOKbg1IVeYlw1UrST3iX4dWD0yQ4tORwzSctIajiVIoR/24=
X-Gm-Gg: ASbGncvbL7eVcJiinFd+YMJL0OdJNqnhpED2hyJzz87bXowmHK1bC5cJeVumbo5yRo0
	ohj3G/bOq+AMxBDFX8RAB56jeM1XvtcEYdsOYE/zpQQkMcLaOD6pp14Njb1zRgHcQoE1gm+5zUQ
	Nu+nFVgaBgtr7jDW3c0XijV89lExrXJkwqw64/R1psZHb32DamkFGbcyv7b2vCNR569QVnuv+W2
	AQhvo94jGyxwMXPSGx5JJDrabYn4hYAbsxtKQhxSB07Hr7930kh4SmgZ6Keshnd8cczN3dKwJp4
	XBJGPp+6GEUSuUMm1ggrXeennhCGkpnFidj3ZETxL6EW9MXLCAAmIThR
X-Google-Smtp-Source: AGHT+IHCaNRz8jgNzTe7X02HLlceq96ofFY+QEcp3cSOZO+Ea2N9Ngvuwc4vEBlOvjNHpM35FTfYgQ==
X-Received: by 2002:a05:6871:8081:b0:2db:f81e:db98 with SMTP id 586e51a60fabf-2e3c1e9281fmr11839606fac.30.1747774877028;
        Tue, 20 May 2025 14:01:17 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:d77b:6acc:2ad1:8ff])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2e3c0b2e1a7sm2348470fac.48.2025.05.20.14.01.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 14:01:16 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH 0/3] pwm: axi-pwmgen: add external clock
Date: Tue, 20 May 2025 16:00:43 -0500
Message-Id: <20250520-pwm-axi-pwmgen-add-external-clock-v1-0-6cd63cc001c8@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHztLGgC/x2NQQ6DIBAAv2L23E3AilG/0vSAsOhGRANNJTH+v
 dTTZC4zJySKTAmG6oRIX068hSLyUYGZdZgI2RaHWtRKKKlwP1bUmf+cKKC2Fil/KAbt0fjNLCi
 ebeNG6zrRj1A6eyTH+X683tf1AyQkdZRzAAAA
X-Change-ID: 20250515-pwm-axi-pwmgen-add-external-clock-0364fbdf809b
To: Michael Hennerich <michael.hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Trevor Gamblin <tgamblin@baylibre.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1285; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=hFJhOZb2KYc99TdUu5lHL7z+CYiP5EKAGEds0BI0i+g=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoLO1+HR1LfRmxZyAO7NhveFiE4LPjQiKuNkNUd
 vRwQOVK+WKJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaCztfgAKCRDCzCAB/wGP
 wNTLB/4qE9N1BaGQSqUtXIzXos9hC8s+6tTa8iABPktn3wJygFb8c/spuZCi5MqJl8OwsbNjpcL
 f1NBd9v3FZ7ic40Bhj5Ys39/lW4jZEwzB8L9Dou9qKkgFcGq8kVui2c4v3olTZjjc5MnArHsOLe
 LigOu1fw5Z6Le2EzSqsCrm3mnsgrAUMMNfgSYWNcZlwOhzfFt310MjPPFNJTiNGa7D6ME+XkHbF
 pwK3ZEdMHuUjo18SbRFBtO14U2EfOnuFBgSgx4cDN8HgMzNK7nZ5lPJofQb3mSiuc3sNFpu9I7x
 Fd9ttx+7gIH0CuE3eSJz6Bb+hxx66EV63IFceqS9vnmSqH2X
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

When we created the driver for the AXI PWMGEN IP block, we overlooked
the fact that it can optionally be configured to use an external clock
in addition to the AXI bus clock. This is easy to miss in testing
because the bus clock is always on because it is driving other
peripherals as well.

Up to now, users were specifying the external clock if there was one and
the AXI bus clock otherwise. But the proper way to do this is to would
be to always specify the bus clock and only specify the external clock
if the IP block has been configured to use it.

To support this, we extend the bindings to allow 1 or 2 clocks and
modify the driver to handle both cases.

---
David Lechner (3):
      dt-bindings: pwm: adi,axi-pwmgen: update documentation link
      dt-bindings: pwm: adi,axi-pwmgen: add external clock
      pwm: axi-pwmgen: add support for external clock

 .../devicetree/bindings/pwm/adi,axi-pwmgen.yaml    | 28 ++++++++++++++++++----
 drivers/pwm/pwm-axi-pwmgen.c                       | 23 +++++++++++++++---
 2 files changed, 43 insertions(+), 8 deletions(-)
---
base-commit: 484803582c77061b470ac64a634f25f89715be3f
change-id: 20250515-pwm-axi-pwmgen-add-external-clock-0364fbdf809b

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


