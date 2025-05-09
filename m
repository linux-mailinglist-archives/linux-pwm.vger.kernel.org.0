Return-Path: <linux-pwm+bounces-5869-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EACDAB0F66
	for <lists+linux-pwm@lfdr.de>; Fri,  9 May 2025 11:42:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7666B7B6D7A
	for <lists+linux-pwm@lfdr.de>; Fri,  9 May 2025 09:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92D8128DB6E;
	Fri,  9 May 2025 09:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="aqia2S7P"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189AB28DB64
	for <linux-pwm@vger.kernel.org>; Fri,  9 May 2025 09:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746783710; cv=none; b=T1gEnDF/9VoQVWCrexZF0yNdGPUokHeID9+q3VXD57zjoB6cCuVXEkL7kqEI1FgJ3wCGCJypyVR7CzBjiYQko785/dDenoorL5y5n6V2UXdjeJm2NrXfGVgjUYRITyTuupi5w6bEkZ8G28qXcEIRJmP0RLg0JpcPLfd1wXQeEho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746783710; c=relaxed/simple;
	bh=glrL9frKUynd0eooWslKXIli7Wwl1Of8mWNqeP69AkU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ckZrWS+tEVEqgIPxm7FLByu93gXqIzA+qTiBtwyqtKWUtVjPZkSSjw22TAgeSJsINY2PFywJjsJbMyVbiqDz0qYgWKxZcwy9wxpcyG+VIvXO7+jZ9R9tGkqpkP45Y/IEeoMYdHbux8IYHrywsMf/GF8Qwn7g2dCX0vJrNnkvC64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=aqia2S7P; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-22c3407a87aso25263945ad.3
        for <linux-pwm@vger.kernel.org>; Fri, 09 May 2025 02:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1746783707; x=1747388507; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Cqj4QIom4PNiBzVEbYX0WUBXZ7DUraiDzK4MrzGYzY=;
        b=aqia2S7Pqari63bQ2xUwRnkInMjdARyyb6Iz1BVyc9mcTkLYDMWaPbNPsl8xACTHNA
         DQnDPos1vxPyxYcFDYbjCoIspR7xH09sW8IL/ow/7OBV1znqYRDELPd/nZSrzKDlP1HR
         y94b5fDkt5I/WMqlvCdjI8VER2osa5FsZkXI/KgNhMJfPvk2dJcGkMYUO+9D28ngwAhe
         MAbj7dUozNK4OIxfBW/spV3rTyh2wYYGP0pov3ZOOLb6LIhWaDlh0sMiwgvAuHeXwznr
         +s3AEyXj/r7lviD7wIUubxwpsRT3zFvP90ioOBYZEXP9/rakaRP8NVGKDFbLnOvL+x5c
         MwTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746783707; x=1747388507;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Cqj4QIom4PNiBzVEbYX0WUBXZ7DUraiDzK4MrzGYzY=;
        b=XItmPDU494HXhW3eukHfsiQpY/rJUwAybSG9Qt0t2h9Zvl5cwp++hoytlZmlN2y2TV
         4C43ppHT3e/hiDfQZYgOBhYQOiau3rqoZ/QhBrg65HWcoT4cgiN5DaOtJgTZBy8wRP6B
         CNEDkfuVScJgNlTT3yYbF4BJidwd0k8FgSrjZRe8JutpwiO2PvMJXvZIZIIfIR3j9r+A
         wj0YrTBM/MU9T90aPtT/8feoiWSDlgi3H7Gh6SYunyJdr0gFYSfmJbGSEeyNTndbVNMq
         LcxLoZHD7D9vu0JQ2flkhpHQ2mTu0w8yzmWrCMETR6Huy4Acts78rNkdrV6LFp1DwPvQ
         2Zlw==
X-Forwarded-Encrypted: i=1; AJvYcCUKMQKHv0uTF8f0uZfyhDa68A7U3i+yTryBt9Tw1VDg+vgq3jdKLXza46YgZfoI6fgCStL+clbz6c8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5oN0c+X2LzhrYe37YSPMnxvzWclc8dpJiusLxTv0TrLut+hzp
	tv7J+UncD0yDpZpol1O9e8lPVloWenCxMYEuUqAT2IOVe/1AwP2FCGLxYBs8Abk=
X-Gm-Gg: ASbGncuJYm+p1wYwgbAtiOLgRFfdm0Uffzpc3xfeJqEZqO6U9kxpXvikxNQ+ob/JnR+
	gG9pokbJAKKLVS3H57mrJIdbR1iaocY7zwZSnp/xWEkMm62ax6qNzC6xzZSLDxEHOr3whunbsTa
	6LyVaaxLxOxsjN+PStTx9sJ1C8gMwgff/reCJToLicjStDc9YmDLCUvsyInhezLSuhGTpSkCd4e
	YM1u12813BgmzsIZtd/bJGmHM6pmcv2MgnRan/XhucUgvqbLqALYD0a+snBhj3ffHdesjI6jS8a
	O3l7X6JAKK6cBWqLtHMS4sshAW3Arc7/0Y2AnrLBrbQsGQ62A3DiCrFAFDroZ5+6DcIqYuABma2
	FLw==
X-Google-Smtp-Source: AGHT+IFkTuXt01agQ1105zn1T3rz6uGwTacZ4V6TXQQSitMoy+sXg1uhaf6FBpjek3MEYU8Zsgr4Hw==
X-Received: by 2002:a17:903:1a2c:b0:22e:50f6:b95b with SMTP id d9443c01a7336-22fc8b3d8a7mr40565465ad.11.1746783707291;
        Fri, 09 May 2025 02:41:47 -0700 (PDT)
Received: from hsinchu36-syssw02.internal.sifive.com ([210.176.154.34])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22fc8271c38sm13271035ad.119.2025.05.09.02.41.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 02:41:47 -0700 (PDT)
From: Nylon Chen <nylon.chen@sifive.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	devicetree@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: conor@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	samuel.holland@sifive.com,
	Nylon Chen <nylon.chen@sifive.com>,
	Zong Li <zong.li@sifive.com>
Subject: [PATCH v14 3/5] pwm: sifive: Fix the error in the idempotent test within the pwm_apply_state_debug function
Date: Fri,  9 May 2025 17:52:32 +0800
Message-Id: <20250509095234.643890-4-nylon.chen@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250509095234.643890-1-nylon.chen@sifive.com>
References: <20250509095234.643890-1-nylon.chen@sifive.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Round the result to the nearest whole number. This ensures that real_period
is always a reasonable integer that is not lower than the actual value.

e.g.
$ echo 110 > /sys/devices/platform/led-controller-1/leds/d12/brightness
$ .apply is not idempotent (ena=1 pol=0 1739692/4032985) -> (ena=1 pol=0
1739630/4032985)

Co-developed-by: Zong Li <zong.li@sifive.com>
Signed-off-by: Zong Li <zong.li@sifive.com>
Signed-off-by: Nylon Chen <nylon.chen@sifive.com>
---
 drivers/pwm/pwm-sifive.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-sifive.c b/drivers/pwm/pwm-sifive.c
index bb9146267bc5..6259f8500f71 100644
--- a/drivers/pwm/pwm-sifive.c
+++ b/drivers/pwm/pwm-sifive.c
@@ -101,7 +101,7 @@ static void pwm_sifive_update_clock(struct pwm_sifive_ddata *ddata,
 
 	/* As scale <= 15 the shift operation cannot overflow. */
 	num = (unsigned long long)NSEC_PER_SEC << (PWM_SIFIVE_CMPWIDTH + scale);
-	ddata->real_period = div64_ul(num, rate);
+	ddata->real_period = DIV_ROUND_UP_ULL(num, rate);
 	dev_dbg(ddata->parent,
 		"New real_period = %u ns\n", ddata->real_period);
 }
-- 
2.34.1


