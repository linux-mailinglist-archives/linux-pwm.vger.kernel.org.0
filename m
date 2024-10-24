Return-Path: <linux-pwm+bounces-3816-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF239AE2E5
	for <lists+linux-pwm@lfdr.de>; Thu, 24 Oct 2024 12:43:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C87F2284133
	for <lists+linux-pwm@lfdr.de>; Thu, 24 Oct 2024 10:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E639A1C4A17;
	Thu, 24 Oct 2024 10:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G7+ho9kz"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BDDC1B85C4;
	Thu, 24 Oct 2024 10:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729766598; cv=none; b=F8i6Dgr1vU6JgCSOJSUbvJBrQcZpMtOOCxtcd/9PrmT/+Y3OJayP79sa7gt8/e41ZzBQMDKufQ4Aks4S4KklS1oZEC7BeTSp4RnSRd4R76PHCZEsS7A+RRd+thCmuWKAa+tRlRSKUL8PtmkigTHzqg4aUTLj0xbcvsicqWdmiYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729766598; c=relaxed/simple;
	bh=fO61moAmptosg/u0egEsTyMjVhOR7hk3clxajJJwZ5c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oVNoIW4IoGEo6mWUmuzDIl1uh/8Um9ZKZyK/gtq9y9PtOMQ3EHyWu6HtK9jFQWmFDZQM3jxGbLmD8mIss4kMvKWRPOnaF1cjDg7YqBR9keouXvS7lSvLyTQ94jAybjfqvJkDT+mdTqVFMody/NGoIKZRUZrXlSvwvZaXVoTmfes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G7+ho9kz; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20ceb8bd22fso5188875ad.3;
        Thu, 24 Oct 2024 03:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729766596; x=1730371396; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h7HjZCPn22R/d/6vCRTZ9B7oHF5tk/EK1K6/sj2ocw8=;
        b=G7+ho9kzMBVTmaOmDnPkli2l/bFHMLZOnJnc9/Vrfg5zC6pI4qqLy9m+JjxOTkmu4Y
         cvBFScZ8Mt37UAs0jmwvcwuN+lVVcrbpPAyvfATpQ/VDGM6+M+c+SdKNxNbetIyDSlYd
         QkOGbYBAF092O+sj02g60BtB0SgX+AYtCg4Gx2gvAo4NjTkve63gj8Qkt7wD5uTyWf/Z
         ubbNUovZOfFHvBmNbiXb8J3HFFtMzNwRByLR+pUWUA2j9pOy5zOWKXJRvPlu9daF16qc
         h4AOmtvwjUFFRh+NulawrQWy0KEmVP0nWy7zgpKUSDLRMhFeokyp2iT3+vISE67KLpcm
         J0zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729766596; x=1730371396;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h7HjZCPn22R/d/6vCRTZ9B7oHF5tk/EK1K6/sj2ocw8=;
        b=byebC6lYJU3YrzmS5SWvYFsbP7ZDfjYUWbqWPvqB51/aW5YTEpKGTtbBMEbQeQa75M
         SHenOv9SzTetgNd7jHlfQAxEy8rgc++rBOi5GmqUMKZZ1Tw4xbzlv3zeS9gip/EvBBx1
         7n9iNXMOlO9pFVTbQbUu2wWzwtUIyEQaeH4cOAfQ7eHurtL6+NLlHqpSnUKkzUBm1OHN
         04NmllFZmSMOghQ/Zeh3juF8LUWmWfWM1YTISUqHE9Lycz02O04H/ExwSK9VJ0X8utyG
         JiKDuCBOCxJ7mse6GTLkSz8LJ8MC5S9grHrupH5ByW9dLNsexmPhlFRRtYFnLnA75en2
         xJBw==
X-Forwarded-Encrypted: i=1; AJvYcCV5fwcjM/1YSKL0C0wTxYWWxU0qlS1J1yRTrA1oN+D0o85uL4nLDtadBTkuE1AbouM+Q7tZFO4/o5H/@vger.kernel.org, AJvYcCWsyjEyqqSKSXhioIYbNdoF+z+hhdOxJd2Yci77Xac7FZK6a/eaZWt2ayQRwcM4PCRCBpu9CbeVAUT9@vger.kernel.org
X-Gm-Message-State: AOJu0YwmnJX8C6yk7C1Jec6drsZUlkUDP3oC1PublRc4f/h00y9L4/8b
	vgRDjTZ1Z+rZVvKrDQKAGFHe1z9NOhBfatX1nlE+h4LXGdTD6DcW
X-Google-Smtp-Source: AGHT+IERBF7N68rMaekUR1OZVbMc0yUseUnfhYs1PSJUJ7bL/4xEUyW/oQnjzLjfkeUypihI4zwOZQ==
X-Received: by 2002:a17:902:e845:b0:20c:853a:52a7 with SMTP id d9443c01a7336-20fa9e9bb64mr68534735ad.36.1729766596164;
        Thu, 24 Oct 2024 03:43:16 -0700 (PDT)
Received: from localhost.localdomain (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e77e48ed34sm1252785a91.9.2024.10.24.03.43.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 03:43:15 -0700 (PDT)
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
Subject: [PATCH RESEND v2 0/2] Add support for nuvoton ma35d1 pwm controller
Date: Thu, 24 Oct 2024 18:43:07 +0800
Message-Id: <20241024104309.169510-1-cwweng.linux@gmail.com>
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

v2 resend:
  - Remove wrong 'Reviewed-by' tags.

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


