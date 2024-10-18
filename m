Return-Path: <linux-pwm+bounces-3695-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA1CA9A337D
	for <lists+linux-pwm@lfdr.de>; Fri, 18 Oct 2024 05:49:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D9421F2446C
	for <lists+linux-pwm@lfdr.de>; Fri, 18 Oct 2024 03:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93F9314885E;
	Fri, 18 Oct 2024 03:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jTq7PyNp"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C8320E31D;
	Fri, 18 Oct 2024 03:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729223346; cv=none; b=R/gLoB1iHDpIIlhHN7ZSGPrTFjE5dQ8XA7a6wJKrruQGa0hJQDmYnLH7elF6a8AePGdHFrVqHemX74cs01jRf1mDBC0CN1xFgUIuvi0RUonpD8YK3YHcu6rAyfdtker/bX+fuLWdUMYXC6XPKx5PbAwHlkp66aBl0jpHA9L1wCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729223346; c=relaxed/simple;
	bh=JIHI9gt8swxrHXqxbbqQQY1AU7yWxlIJqAcxkBR0HrE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mgyIpw3X/HwBdWtXjgWiG96IbJj0cII1ZjJNCutqsnpGJGDxhc8iCQHA1uAUWMX06LYvPef4ZeIBwo+xIc5uaRmL7a1hehHFh4FIysfmrzdrWJM673p7ax7+e+6CgahRlpB52P+8c65ISLJZD6DT2SqdRB6HLfKdBCSEQ9kM/Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jTq7PyNp; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-71e79f73aaeso1186438b3a.3;
        Thu, 17 Oct 2024 20:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729223344; x=1729828144; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SDMWPTZLTSceSfSI7tlS46UKbSdC7kfiGzUwE2DAU/w=;
        b=jTq7PyNpQ2Qve6CvoTPuPYReFte6hwvGpvGQARsUD4Oyyg+abR7HLZE+Q7LNtVfAer
         YwulMFTmViITwbJkRc1wdHVKmDZMkwRaTy5fWbMcqQQzViCnGAfQ/xM7cm7A8uDsIvKf
         Moqz6uDG3+6kH2cry+mw/oNSNtx4z8hMkhEvKpO+LhbQv2NalUL5oyzPPfNYbFkS2UJ4
         sk59VZZwtY5eXyMdIvMPXjXHDndAL+Y+i8R3WBhDgZiDRXeB3Bf6djT9PvNQK1PYQxCN
         quOncBtC4ZUXqxPh+0e6dm5R5ToLr30vm9G8ZQXSL5BN9I43C1B/wTfWNcrWLzIKGOqs
         V4YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729223344; x=1729828144;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SDMWPTZLTSceSfSI7tlS46UKbSdC7kfiGzUwE2DAU/w=;
        b=m1hOa1iaIYBtHU3rfeiGgo7hOnCX+uWvtG9bYG3vlRFNb8G1zFBevYyG9JEzbN8cg7
         unDXDnusXZKbR0qD0cK91+wwLFTzXtO2P2AdrrKdiEUliaxW5iYe622wRQ9FVAzJV/VB
         j8/CtSM91gIdqYPo+Zx7g2R4Hf0BOG/p6HwLydYprgYvC/JwC2g0xZgXQ5/sxernOCaC
         CaNq3YIjjqjujREabIZ3FCM2zyhW5EYr8anPzeuAfjkqCwyd6CyVg5RVXRcY3LQZ95aj
         4rMTMY3Hiq8DGsyTIYthvsLmPpNHRANzNjHc6Q+Vf8eVAj19mDOuP7vp5uGDgUgWp/Dt
         3cew==
X-Forwarded-Encrypted: i=1; AJvYcCVVNYb7RlE1BaHZhai1Nu+ZSWxRYnEZy11yL5uf5GRVNyxdroXfwY0mLDfcr3IDuHGtq0k/JINLtVsN@vger.kernel.org, AJvYcCXbKH2nTKqNhrHA3R3CNtGAzW48hSG+ZXZmZPqrMJ8gJ25+NUjeYSn/XRzPyU98bA8SIO1ItwuwMtB6@vger.kernel.org
X-Gm-Message-State: AOJu0YwS8jcVBq3VTLYv406mexj64hCFF5R9m43qpZTGNRZZpphpbHFK
	rEi8HblecMNcl64ybsPFbpRZk+YnSMLoN28vi+3SO2e0lH8IEwol
X-Google-Smtp-Source: AGHT+IGqGNFGFh04PA1HczFsT4xsywTPwJ8IkIkw+augztSfLxDrKyN0WuJARigS0ey1NnO+gF9Klg==
X-Received: by 2002:a05:6a00:140c:b0:71e:6122:5919 with SMTP id d2e1a72fcca58-71ea332adfemr1406062b3a.20.1729223344455;
        Thu, 17 Oct 2024 20:49:04 -0700 (PDT)
Received: from localhost.localdomain (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ea333d6e2sm459066b3a.66.2024.10.17.20.49.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 20:49:04 -0700 (PDT)
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
	Chi-Wen Weng <cwweng.linux@gmail.com>
Subject: [PATCH 0/2] Add support for nuvoton ma35d1 pwm controller
Date: Fri, 18 Oct 2024 03:48:55 +0000
Message-Id: <20241018034857.568-1-cwweng.linux@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series adds pwm driver for the nuvoton ma35 ARMv8 SoC.
It includes DT binding documentation and the ma35d1 pwm driver.

Chi-Wen Weng (2):
  dt-bindings: pwm: Add dt-bindings for Nuvoton MA35D1 SoC PWM
    Controller
  pwm: Add Nuvoton PWM controller support

 .../bindings/pwm/nuvoton,ma35d1-pwm.yaml      |  45 +++++
 drivers/pwm/Kconfig                           |   9 +
 drivers/pwm/Makefile                          |   1 +
 drivers/pwm/pwm-ma35d1.c                      | 169 ++++++++++++++++++
 4 files changed, 224 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/nuvoton,ma35d1-pwm.yaml
 create mode 100644 drivers/pwm/pwm-ma35d1.c

-- 
2.25.1


