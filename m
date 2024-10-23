Return-Path: <linux-pwm+bounces-3767-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 279219AC8BC
	for <lists+linux-pwm@lfdr.de>; Wed, 23 Oct 2024 13:19:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC8F62813F9
	for <lists+linux-pwm@lfdr.de>; Wed, 23 Oct 2024 11:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7899119E960;
	Wed, 23 Oct 2024 11:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iLriqqKG"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC791B813;
	Wed, 23 Oct 2024 11:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729682365; cv=none; b=NL1eU/nfBCn7Eutz5jaOv4L2iaHmg7WlD67BclWoJykvMyR1QFQzdXsywRcJdPFUM6u5/zQuplDezk1X+Xsbmdugma47m+83o2rsLlt7ZjJuv7lVfVeRjCsP5WkihU0keCzWBs0lNA1D3hUH28WX5NI0G3MuiaiYfFLYvbMWJC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729682365; c=relaxed/simple;
	bh=zh+dX67lar1d2U2hALKOPSbuvmdfg66Z5qWFNtie79s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=a9+28agSn/WfP+3ORTiIv5BSMwLteYAAi0id28kyRTixvjrzr+TbDbg1Uf57DoRhsQI/0rOerKG5h/EjVPgSwxdd9RVKfFGUStw9H+j9kpQY5o/FugmHEW9QfHWmy+G81fC7tUbx57Qv8O1lsLTHEKeE1qT8YuY8cN0U6g88SKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iLriqqKG; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2e2a999b287so5121585a91.0;
        Wed, 23 Oct 2024 04:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729682363; x=1730287163; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JgV2bop4E+Lefe1b02SOkU11Tjy474hcAgvkx+xv0NY=;
        b=iLriqqKGpX2PLPqoyHdOLEpkJk4ouX0frO8UWZEGuuXRnXCbt2VM/XMU9kjUSUiPPM
         VWdG2RTRYslJhBlNhTV/ox2K6+af37m3HiRJfdr7ZUCs3VJtvX+6SJrmyV7g3646j0A3
         zv6dhOFnDzQ0a9Mx+Rk6kiQ2yRhqQ26GnUh8o7ToQ3Ac1s2Guc65H+Ud7pgMC7lVwNz6
         WVZ4dw3GwMfoIlcrKtU/IU5wUl5IJqb2gxsLnUR+NuITIVKnabBFvkd4nTLN9dYN9YR7
         JTkb1oCprHNKq+7WB6GuInEaLMgFSRn8tRXU6u0PJO0/v/1s4Qv5uAtPKFBtSMPy2tSa
         dHBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729682363; x=1730287163;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JgV2bop4E+Lefe1b02SOkU11Tjy474hcAgvkx+xv0NY=;
        b=nX7Rd554wjq8Ab4+IBTlDC7Mbq3hQRhN6dTgbhHw1jxqHDKavQ/QhTH9zQXUgkLfjG
         jApaPyBBcXNvRylsZxb5M5WFX+za2gCiM4FyD+xtfFE39TMEaACNo4KzEwh0wABQJ2Xi
         0mFw0cygkVZkKsQruIyd6W6E+5JN7a50ACXzHuwWMNk6ViaIUPlPSgp5hjEbay4J5ex7
         Ctvx2Axk2osLUYYXHjKLQS478llCi60RrQ2woRphXA1jRQksPshAyMuiuY0PuFZWrh6b
         BvZ/4yetu7GIBDjFbD2j6S2T7C6q3ZM9MzJbdmqIgDQ+bWIIUKM9aypuTnpgmuBd/SAP
         U6Ng==
X-Forwarded-Encrypted: i=1; AJvYcCWG/myeKhQOqpbq2WobgIejKpxiDA8XCWL+hFwaMrCYNwOnOPOEbl9bxtsDGRVvm2ku/ygcGv1sTdOs@vger.kernel.org, AJvYcCXFAJ+d6aQGTTVTDXiYhmxilcahHpOXwykrxYLXd118xPaF683eAuaCAiXKGws2x3jF9+m+nqQoCCDU@vger.kernel.org
X-Gm-Message-State: AOJu0Yz89ctuvis5TlsbxWsu2B4JwV5AhcmedF6W5fogSiuna8PfrDtI
	u3BPoRq4AykIvI3qotNg6esiaFNNG7TlNUkxfhYVKy8oXBdOFqgtJ3YV/Jaq
X-Google-Smtp-Source: AGHT+IFhAZ88Ov+m4B72gMAynIVK0mE7UZ0VxI7wuNoZF7LTUb4m149scJ3ktLFsatlgiKyvvGr2vA==
X-Received: by 2002:a17:90a:6f83:b0:2e2:e8a9:a1d with SMTP id 98e67ed59e1d1-2e76b5b67b5mr2016364a91.6.1729682363178;
        Wed, 23 Oct 2024 04:19:23 -0700 (PDT)
Received: from localhost.localdomain (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e76dfbeca4sm1123022a91.32.2024.10.23.04.19.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 04:19:22 -0700 (PDT)
From: Chi-Wen Weng <cwweng.linux@gmail.com>
To: ukleinek@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	ychuang3@nuvoton.com,
	schung@nuvoton.com,
	cwweng@nuvoton.com,
	Chi-Wen Weng <cwweng.linux@gmail.com>
Subject: [PATCH v2 0/2] Add support for nuvoton ma35d1 pwm controller
Date: Wed, 23 Oct 2024 19:18:39 +0800
Message-Id: <20241023111841.158049-1-cwweng.linux@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series adds pwm driver for the nuvoton ma35d1 ARMv8 SoC.
It includes DT binding documentation and the ma35d1 pwm driver.

v2:
  - Update nuvoton,ma35d1-pwm.yaml
    - Fix 'maxItems' of 'reg' to 1.
    - Remove unused label
  - Update ma35d1 pwm driver
    - Remove MODULE_ALIAS()
    - Add chip->atomic = true



Chi-Wen Weng (2):
  dt-bindings: pwm: nuvoton: Add MA35D1 pwm
  pwm: Add Nuvoton MA35D1 PWM controller support

 .../bindings/pwm/nuvoton,ma35d1-pwm.yaml      |  45 +++++
 drivers/pwm/Kconfig                           |   9 +
 drivers/pwm/Makefile                          |   1 +
 drivers/pwm/pwm-ma35d1.c                      | 169 ++++++++++++++++++
 4 files changed, 224 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/nuvoton,ma35d1-pwm.yaml
 create mode 100644 drivers/pwm/pwm-ma35d1.c

-- 
2.25.1


