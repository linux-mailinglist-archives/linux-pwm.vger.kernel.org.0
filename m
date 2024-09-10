Return-Path: <linux-pwm+bounces-3178-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A4D69726F8
	for <lists+linux-pwm@lfdr.de>; Tue, 10 Sep 2024 04:07:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D6D728553E
	for <lists+linux-pwm@lfdr.de>; Tue, 10 Sep 2024 02:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54238136643;
	Tue, 10 Sep 2024 02:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i56zvMZM"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4FD381E;
	Tue, 10 Sep 2024 02:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725934066; cv=none; b=tTK6/tG4louCkW9SWaTS9GaR+yZEVOpykGOi8b1M3jJr2x0pQtta1JGwmcvdACZCGiAEGFo1c2B2X9S3yMopNqnCThap73LQMQufan+ooNPxgpyvdqBYF1ZiVH5BEkPOOO4GO2CxQhRdfCDC88RnQvq0HHygEDhHIKanHrltC9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725934066; c=relaxed/simple;
	bh=ZqCdPnM4kd95KmoFDSwEgJCQuflyiQ5m5CNQCRu0eWY=;
	h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type; b=m9J16L/ptnF2WHnM6SCGmksdSXCr/lvqERa2sukXQ8ZOeCRU9krdmCH7ncIqSfyn/JQwweBwM+q4gqAtQ7UdZBigN8VUpF0YnVWGq8QE0+GlQUn8vpfvDK3dXaszIYt2FtvVyiy8MOQbr4spABzFNY1JPQZmlx/KwAe9Yohx+Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i56zvMZM; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5d5f24d9df8so2782083eaf.2;
        Mon, 09 Sep 2024 19:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725934064; x=1726538864; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=BK//ItzSH8AcHd/oLP+1w438mQf5hwWC4xyQCHjgSbY=;
        b=i56zvMZMq+8mvRBnXOizeQjacUT+Gn5GmAk+0o3Vv7GZsweVnP1DimTa21hK3fJ0ZQ
         K+gX3rLTFbpvMX47ITjE+FVYd0afF2wafNGi1Fa0ULxUGnNFpIcdyUaY6OLDipUCvOrX
         CMD/rTJewNEREqqKJzggUCdopT4ijQYMTipWYOD+7kH+sXpVTXgKUUoM15TIPu2Plbq6
         P3ZFuWAB4GzDvb23IJfo9HfwL7xYoJycS3wE+xPK+YmD3SwrS6yDslaQq9vAkLogTSmG
         3PovzAm50EtRfgfUxEW1dOyVi0HR3aKaxE01udGkIWavwEtjPZUbktlVxeIBjFRmA6UB
         f9tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725934064; x=1726538864;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BK//ItzSH8AcHd/oLP+1w438mQf5hwWC4xyQCHjgSbY=;
        b=Ytx7I8TL93pYBOYZXnZHvxlpWiOjylbgV67Rg7KG0pHP6wyUeeSMzx3OaTK0rEFPVv
         djgHkg8OnBT5tQiWQX7/SfciKEWNOdthgZ3ZRnAh5nrOm696lIbk714smNOYZU8mDu3j
         vGEw2GeJU34PvOfvWAGstu+c7sUEELT7k+6R5Q+EqSnOaDmJOzz4EAOf4Wkk8Af0i3UQ
         +6fe0w2a4eOCDekEXoLXUcs3vET7PsvzpgJSpdHMqYQ7kj8ZEYqXnzYE7ZYJTyZ56o4R
         xji2mik9HJ0B08YdoXXDBXzWMVQ47JVALS1kCOAGFwWhzs6M32m9AP1feakSyjzw83wk
         8vGg==
X-Forwarded-Encrypted: i=1; AJvYcCUGKrafjh1E84N4YbuktMB0iCuzkApBifr1oBf2kmqvz0f1z8AZsOakq6EvVutV56LvH+a8DegQfOrtn+9U@vger.kernel.org, AJvYcCWg1GojwfLe2uYZ6S5rg/qGvV15WFNMNxlyvwzCnv4AcSfZTOGJQ3tJlOf603VGifjWeuCwkjxE/pyD@vger.kernel.org, AJvYcCWqXVd+y2roalARJHIa8mvdZjtTvjsMulI8ERTwa+11hBqeXqkdQAb7xvVb0J8V0OiHaqjRSF5wfACR@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6crPiWJoSrYfgt7gukHWPHsfzanSrCsWwnawZLD37qMwf2Lo6
	AT5vOqYoexlVx5CIj1Q40kjiGcS+Lc6u30ADnt0oZY1N/xPFUR/G
X-Google-Smtp-Source: AGHT+IHbDe1RTbmQaRrH9IC68BLUsRm5Jpdk9RC2ILmiElVq7KrDXwbTKlr5i/tuUEVKyBym2vIzdA==
X-Received: by 2002:a05:6830:f88:b0:710:dae5:df1d with SMTP id 46e09a7af769-710dae5e366mr6575558a34.31.1725934063659;
        Mon, 09 Sep 2024 19:07:43 -0700 (PDT)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-710e0e89358sm1386448a34.14.2024.09.09.19.07.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 19:07:43 -0700 (PDT)
From: Chen Wang <unicornxw@gmail.com>
To: ukleinek@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	unicorn_wang@outlook.com,
	inochiama@outlook.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	chao.wei@sophgo.com,
	haijiao.liu@sophgo.com,
	xiaoguang.xing@sophgo.com,
	chunzhi.lin@sophgo.com
Subject: [PATCH v2 0/2] pwm: Add pwm driver for Sophgo SG2042
Date: Tue, 10 Sep 2024 10:07:34 +0800
Message-Id: <cover.1725931796.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Chen Wang <unicorn_wang@outlook.com>

Add driver for pwm controller of Sophgo SG2042 SoC.

Thanks,
Chen

---

Changes in v2:

  The patch series is based on v6.11-rc6.

  Fixed following issues as per comments from Yixun Lan, Krzysztof Kozlowski
  and Uwe Kleine-König, thanks.

  - Some minor issues in dt-bindings.
  - driver issues, use macros with name prefix for registers access; add
    limitations comments; fixed potential calculation overflow problem;
    add .get_state() callback and other miscellaneous code improvements.

Changes in v1:
  The patch series is based on v6.11-rc6. You can simply review or test the
  patches at the link [1].

Link: https://lore.kernel.org/linux-riscv/cover.1725536870.git.unicorn_wang@outlook.com/ [1]

---

Chen Wang (2):
  dt-bindings: pwm: sophgo: add PWM controller for SG2042
  pwm: sophgo: add driver for Sophgo SG2042 PWM

 .../bindings/pwm/sophgo,sg2042-pwm.yaml       |  51 +++++
 drivers/pwm/Kconfig                           |  10 +
 drivers/pwm/Makefile                          |   1 +
 drivers/pwm/pwm-sophgo-sg2042.c               | 180 ++++++++++++++++++
 4 files changed, 242 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/sophgo,sg2042-pwm.yaml
 create mode 100644 drivers/pwm/pwm-sophgo-sg2042.c


base-commit: 431c1646e1f86b949fa3685efc50b660a364c2b6
-- 
2.34.1


