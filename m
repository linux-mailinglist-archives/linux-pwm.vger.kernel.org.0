Return-Path: <linux-pwm+bounces-5817-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 493DAAA83CF
	for <lists+linux-pwm@lfdr.de>; Sun,  4 May 2025 06:11:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0ECDA189A352
	for <lists+linux-pwm@lfdr.de>; Sun,  4 May 2025 04:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC99823CB;
	Sun,  4 May 2025 04:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XONysR+v"
X-Original-To: linux-pwm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1C314A0A8
	for <linux-pwm@vger.kernel.org>; Sun,  4 May 2025 04:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746331854; cv=none; b=esGQOl/ZH9tqvBe+FNuMJCszvQJopvJ7MPzA0wJYHhHnmoDFKID5WmG5kcsIaSamvlpyAXB2A1EGaQrbGcVmrreAfnOuBYRvP5DQLlyRjaBvW8MuInRtT5iXHjZlPsEkBELqCSXG1ldmEPt/B9u+QwWXjlVBPel+gdgw0oBBVHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746331854; c=relaxed/simple;
	bh=58y1wlPA8jRdV6kOneRQ3qISahx75Mn9ln9rC7q2WlU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=He0VI8Cyj7c5QvAZdG2FW/F2klFJvZGSfdyQ4WP6AGpehaoqZoHckglnfvDXg+n8+TA7ZEUBWsN2AnCcHjuyugxoj0rUzx6UWqXvaLsEQtlXyz+tEg2hvDiW/kxF+7HnEr4Eu2TatBiyqk2npKB25xuPbkf5r+QB4kjDzAk02HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XONysR+v; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746331850;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pXg0ERkF8XHkKLcRr4bURjizOpgCnyyQy1hmk10qVvs=;
	b=XONysR+v3TIAgxCzCjDvAMatNCK1MhpEZdPEZqiQWGfReSZaUSwO/24nzRQjuWbvqZCdyp
	N3Q6xwQ3IIgNuaswyK13LqZUWJkrQ0uw6o5lQHMmawxhc/6Om6VyM5ppV+11RPIFtlvHIS
	5bxETxriOB3fbcILdAol0Km9lbIi6WE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-454-RayrN0pxNWGwKFAAmp0iYQ-1; Sun, 04 May 2025 00:10:49 -0400
X-MC-Unique: RayrN0pxNWGwKFAAmp0iYQ-1
X-Mimecast-MFC-AGG-ID: RayrN0pxNWGwKFAAmp0iYQ_1746331848
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43cf5196c25so17151595e9.0
        for <linux-pwm@vger.kernel.org>; Sat, 03 May 2025 21:10:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746331848; x=1746936648;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pXg0ERkF8XHkKLcRr4bURjizOpgCnyyQy1hmk10qVvs=;
        b=HVpD/uaWBlmzC4IjSXulwq+oiAh1YnL2eZolXJUhoBJcX1mdDeBJJ0iTZV3DzhaqC0
         VSiACkt5n5uRhjrQOSzOWkBxiYNzCxXNoeoBFoe4GDbEMjbfttpdkTb0L7lkTfEKBBVp
         8yyMz2hwGo/zVLYufKsIubaaaNhV7CQ5fiQhgwlffA0TCUT56VNZ+R+xlOHMdhR7VNGn
         FCuK+iJMq1hvW3PqM9K7k8HL09YlMYAsfPsXrgXsCOhcNDgEK3iuCL2ox0sI/xfawhCw
         Zbj54r3V6ee7C2j4A6u805ZWnaWhDrP39uKBmSrC4HyP9i46tqp4+UBnPKAA6GHS9lJY
         cxaA==
X-Forwarded-Encrypted: i=1; AJvYcCUguDkDhyBCqUpSMVCxTQs3LhkrRi252+TnGtppStoGe3ZeLhO0aHXBKbEZmIx1lKvIS3lulwYWOmg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9qit0A40tfIQiITfp0JAV3HE9WjmGeJnwsepSILywCSEKyRhn
	f1X3gp7Opdir6KTR2cR2ybsi76n+pqX2NbZFU4vs3LcqlyIHuwdE2vxyVqORARCFs1lf1lxvzKB
	LOoNsJPyuOAbUIZ0LiC1/c4l28klnh8ZiZ7eTkSDKJDpplNofU3GZIPuBlQ==
X-Gm-Gg: ASbGnctqoykAw54/wqxZqqoUYK2Y2ghgVIM+5pqRzLy9auKdi89FxXpnguHwy5jVVD3
	+4vRl8tAWCOuoQPbtPXU1k6QDUZPaqfjnlsxs9x1+2b0GO1lxYu7Q8vb0kmWt750PAF3Ygj+bdX
	ITuS1qCy9oiSfjiItHoxPSBtdhhDvzOChhx7h2CQSs0AZuchCSAHTR1S2D6UHy9aVXA3fHLBjks
	/dP4JceSOxs6+WeA6eWpFP7C5jScA1twYrPRoNgjNYXdGimyzxhNIWr8IzdbiJC8t9r8Z6gpTCd
	rykEMqLIjRb1RpHuRjQO/IWQV/A/o1sFmyQkqiWvppGaepAdD/5uPlxwvw==
X-Received: by 2002:a05:600c:8283:b0:43d:8ea:8d7a with SMTP id 5b1f17b1804b1-441c4948691mr19622045e9.28.1746331848172;
        Sat, 03 May 2025 21:10:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+L9gMdreyvyzyLlq3oHQYPX/FO9Npa9JrKoYnNFTKf5gqLqTcPTA+0B3G8oMkDtOUnSc9ZQ==
X-Received: by 2002:a05:600c:8283:b0:43d:8ea:8d7a with SMTP id 5b1f17b1804b1-441c4948691mr19621955e9.28.1746331847872;
        Sat, 03 May 2025 21:10:47 -0700 (PDT)
Received: from lbulwahn-thinkpadx1carbongen9.rmtde.csb ([2a02:810d:7e01:ef00:b52:2ad9:f357:f709])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441b2af306bsm138229675e9.21.2025.05.03.21.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 May 2025 21:10:46 -0700 (PDT)
From: Lukas Bulwahn <lbulwahn@redhat.com>
X-Google-Original-From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
To: =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Lee Jones <lee@kernel.org>,
	linux-gpio@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	linux-input@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: [PATCH] MAINTAINERS: rectify file entry in ADP5585 driver section
Date: Sun,  4 May 2025 06:10:40 +0200
Message-ID: <20250504041040.40421-1-lukas.bulwahn@redhat.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lukas Bulwahn <lukas.bulwahn@redhat.com>

Commit a53fc67a1e21 ("Input: adp5585: Add Analog Devices ADP5585/89
support") adds the file drivers/input/keyboard/adp5585-keys.c, but then
refers with a file entry to the non-existing file
drivers/input/adp5585-keys.c in the MAINTAINERS section ADP5585 GPIO
EXPANDER, PWM AND KEYPAD CONTROLLER DRIVER.

Make this file entry refer to the intended file.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index b21363fdbf4d..1401209d06df 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -550,7 +550,7 @@ L:	linux-pwm@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/*/adi,adp5585*.yaml
 F:	drivers/gpio/gpio-adp5585.c
-F:	drivers/input/adp5585-keys.c
+F:	drivers/input/keyboard/adp5585-keys.c
 F:	drivers/mfd/adp5585.c
 F:	drivers/pwm/pwm-adp5585.c
 F:	include/linux/mfd/adp5585.h
-- 
2.49.0


